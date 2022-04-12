Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18BF4FEAED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiDLX3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiDLX0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:26:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD045E5E2A;
        Tue, 12 Apr 2022 15:37:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bh17so392487ejb.8;
        Tue, 12 Apr 2022 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fi7MSAw9JJfEvAstthfKaej5RCtbNw/RZ/uRsivb1lk=;
        b=P0UAHya9e7CASxMUbhq+/+mZprtCmglz9V4rIrQxtp/2QWoEr6dcyh2A77/WSJ9ZQ9
         MzS3J/xT0o1MaHzzIWjNkb+O3ATx8QEftezuDBugYJJKvaR2wK5xHunebttC/0nHQTd6
         xQVcX/ye+UobRN4t/8PjkZd9H18AYH7RXVDTD2tUlOPiTO6mXikOzUUB/Kid2+axYFjd
         xTR5Fku5CdDPgoL7balX19T3uzgItp0GQe1Ij2eWWZKiyWoiIGI6SnMvOu+Iq7Y0+d5G
         fP9FxGITJMK2Zx/cg7mfn9RhZ4ifYp2D3g08reHUUW6CjUnLn+iz0nJVfEz8ABt0QNej
         MIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fi7MSAw9JJfEvAstthfKaej5RCtbNw/RZ/uRsivb1lk=;
        b=ATOEVXBWRxPWWCAWzOUABYPf9OAfxa/gtez7QfIPn6jvxJJkFbOGk7qL1VHY2X3Bcv
         C3lpJCQTq7F7sSkXdYy4SUo0ctdJau45mnpjBRalUQ+tYM7UoKbhQgvXhxhqQzYw5Yw0
         JgzpEDcYAcBusp6uGB/F4g5O3xNc8FcV5ZXQb5nZ7IAxfFbL9NmzZrfBuiWg9p1+tp2Y
         aR8peEIrrTe9/ees3mKMVu6IwDtMNsfNSM8+vxYJoVwtMYKqtKR7OfXRVJp/hjq7E2Tg
         006MXx4alk5dZiR0n+s8q15JldenHzoGI7byUmrdGDlLZ8j24tBc8dlRawCro6QrzBg8
         xC5A==
X-Gm-Message-State: AOAM531OBFQk1J4dfJj1RcD0Z9YienAj9qkycfIk78quoKiWfEEjyyt3
        c1sdxR6Jq3m17rUVPuUveXg=
X-Google-Smtp-Source: ABdhPJyYVVu7QfZdAoEiOX9n+x0N4MK17YbtHf77uSWQez4CJOaLjbCP0v6dWK2uaL8ANUwRNSw+gQ==
X-Received: by 2002:a17:906:3082:b0:6e0:111f:8986 with SMTP id 2-20020a170906308200b006e0111f8986mr35114749ejv.677.1649803035186;
        Tue, 12 Apr 2022 15:37:15 -0700 (PDT)
Received: from Ansuel-xps. (host-80-182-176-248.pool80182.interbusiness.it. [80.182.176.248])
        by smtp.gmail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm336339edj.49.2022.04.12.15.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:37:14 -0700 (PDT)
Message-ID: <6255ff1a.1c69fb81.bae17.1e86@mx.google.com>
X-Google-Original-Message-ID: <YlXcpPCmMBPPzuXM@Ansuel-xps.>
Date:   Tue, 12 Apr 2022 22:10:12 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH v3 13/18] ARM: dts: qcom: add opp table for cpu and l2
 for ipq8064
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
 <20220309190152.7998-14-ansuelsmth@gmail.com>
 <YlXcHJminisFjobl@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlXcHJminisFjobl@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 03:07:56PM -0500, Bjorn Andersson wrote:
> On Wed 09 Mar 13:01 CST 2022, Ansuel Smith wrote:
> 
> > Add opp table for cpu and l2 cache. While the current cpufreq is
> > the generic one that doesn't scale the L2 cache, we add the l2
> > cache opp anyway for the sake of completeness. This will be handy in the
> > future when a dedicated cpufreq driver is introduced for krait cores
> > that will correctly scale l2 cache with the core freq.
> > 
> > Opp-level is set based on the logic of
> > 0: idle level
> > 1: normal level
> > 2: turbo level
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 99 +++++++++++++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index 7dd0b901cd30..a1079583def9 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -48,6 +48,105 @@ L2: l2-cache {
> >  		};
> >  	};
> >  
> > +	opp_table_l2: opp_table_l2 {
> 
> Please don't use '_' in the node names.
> 
> > +		compatible = "operating-points-v2";
> > +
> > +		opp-384000000 {
> > +			opp-hz = /bits/ 64 <384000000>;
> > +			opp-microvolt = <1100000>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <0>;
> > +		};
> > +
> > +		opp-1000000000 {
> > +			opp-hz = /bits/ 64 <1000000000>;
> > +			opp-microvolt = <1100000>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <1>;
> > +		};
> > +
> > +		opp-1200000000 {
> > +			opp-hz = /bits/ 64 <1200000000>;
> > +			opp-microvolt = <1150000>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <2>;
> > +		};
> > +	};
> > +
> > +	opp_table0: opp_table0 {
> 
> Perhaps you can name this opp-table-kryo, to make it consistent with
> opp-table-l2 above?
> 
> Regards,
> Bjorn
>

Considering this is krait, I think I should use krait. Also about this
we have from ages the wrong compatible but we had too keep kryo to not
break compatibility with old dt. Can I fix this for once and just add
this additional compatible?

> > +		compatible = "operating-points-v2-kryo-cpu";
> > +		nvmem-cells = <&speedbin_efuse>;
> > +
> > +		/*
> > +		 * Voltage thresholds are <target min max>
> > +		 */
> > +		opp-384000000 {
> > +			opp-hz = /bits/ 64 <384000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1000000 950000 1050000>;
> > +			opp-microvolt-speed0-pvs1-v0 = <925000 878750 971250>;
> > +			opp-microvolt-speed0-pvs2-v0 = <875000 831250 918750>;
> > +			opp-microvolt-speed0-pvs3-v0 = <800000 760000 840000>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <0>;
> > +		};
> > +
> > +		opp-600000000 {
> > +			opp-hz = /bits/ 64 <600000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
> > +			opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
> > +			opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
> > +			opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <1>;
> > +		};
> > +
> > +		opp-800000000 {
> > +			opp-hz = /bits/ 64 <800000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1100000 1045000 1155000>;
> > +			opp-microvolt-speed0-pvs1-v0 = <1025000 973750 1076250>;
> > +			opp-microvolt-speed0-pvs2-v0 = <995000 945250 1044750>;
> > +			opp-microvolt-speed0-pvs3-v0 = <900000 855000 945000>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <1>;
> > +		};
> > +
> > +		opp-1000000000 {
> > +			opp-hz = /bits/ 64 <1000000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1150000 1092500 1207500>;
> > +			opp-microvolt-speed0-pvs1-v0 = <1075000 1021250 1128750>;
> > +			opp-microvolt-speed0-pvs2-v0 = <1025000 973750 1076250>;
> > +			opp-microvolt-speed0-pvs3-v0 = <950000 902500 997500>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <1>;
> > +		};
> > +
> > +		opp-1200000000 {
> > +			opp-hz = /bits/ 64 <1200000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1200000 1140000 1260000>;
> > +			opp-microvolt-speed0-pvs1-v0 = <1125000 1068750 1181250>;
> > +			opp-microvolt-speed0-pvs2-v0 = <1075000 1021250 1128750>;
> > +			opp-microvolt-speed0-pvs3-v0 = <1000000 950000 1050000>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <2>;
> > +		};
> > +
> > +		opp-1400000000 {
> > +			opp-hz = /bits/ 64 <1400000000>;
> > +			opp-microvolt-speed0-pvs0-v0 = <1250000 1187500 1312500>;
> > +			opp-microvolt-speed0-pvs1-v0 = <1175000 1116250 1233750>;
> > +			opp-microvolt-speed0-pvs2-v0 = <1125000 1068750 1181250>;
> > +			opp-microvolt-speed0-pvs3-v0 = <1050000 997500 1102500>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <100000>;
> > +			opp-level = <2>;
> > +		};
> > +	};
> > +
> >  	thermal-zones {
> >  		sensor0-thermal {
> >  			polling-delay-passive = <0>;
> > -- 
> > 2.34.1
> > 

-- 
	Ansuel
