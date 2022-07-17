Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2325577587
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 11:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiGQJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGQJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 05:23:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49075BF4;
        Sun, 17 Jul 2022 02:23:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r83-20020a1c4456000000b003a2fa488efdso763302wma.4;
        Sun, 17 Jul 2022 02:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=8YTr2X8svIbJnTpbF7x5tnLHp9hIZERbO+Kgz/ZPYT8=;
        b=FvwqRGpcS2qa45206mLsjOytt4/TCoTHHYYX7Gl0v1hZGLv6KF70gCpGLNgGBbEoAn
         xXQYv8a3PpneoWUWIotTMhlbzvVAf9jfOa2XGR3qWBLSjclpO2Ihd624PVu5VVtd/1NX
         plLFzJX0xOMnJjNp4SXy3PJ4mVwzvm4ODVoHcgF9KB3f0v+um9xQuN/JPARm5S2mVjka
         7CndBoPAwI3Z6D8aKqva/BPQzD318kuyN7rLI24cCosg5Z+ZGrELBxp2fJYwhJoumBFL
         QX5rwH39PgZ/JpERJzHwhyQYSNGCUTJIaYT/xnM0plahZNeo2tbnj7dwWNGxXdnNt6m4
         reug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YTr2X8svIbJnTpbF7x5tnLHp9hIZERbO+Kgz/ZPYT8=;
        b=iUe84LH1tGdRkXGlSixhbTyizwhOv+HyobXYivulinSfLF6YaLUrWPF9sI17n93Msg
         qznSH3ehu+ZYMNvEmgooegFbKJBeyObxqW1heSbi+eprmwGMWRJzn+tPWqTDiThHqkeU
         uCTs5nNO7NjDDuT5guHAPa3oAREM3dIuf19N4gxuMGBjSC4agZc8mT1U8fwSLpFit9j0
         zqP4YB4JhFejL7T6zyFXh9CH3ZeVvxa7zNrx7383sIelyHA1Lnhh/CnkuLnjqKwxvC5y
         dL+952EeB1U+ZgullA6Kq6lNmJXjVTQcQ7ZALy8DDJ3SCBbjz8au7LtuFgfO2HmRuWmE
         C0Yg==
X-Gm-Message-State: AJIora9LuHbNLNZLylWMuQgboXnQ629oqVDB8VWAiukRWsR8lOUr4Tfp
        V1Lx3/QFjpcuJpCyyzhRoQA=
X-Google-Smtp-Source: AGRyM1taStmAGCfMxAnd9fr1zaGcAoYHIrE8NCunwSoSJCBhDGvLLtg8QmNcNokv28dSJbEOE+2KjQ==
X-Received: by 2002:a7b:c84a:0:b0:3a2:cf6b:290d with SMTP id c10-20020a7bc84a000000b003a2cf6b290dmr28857462wml.137.1658049810732;
        Sun, 17 Jul 2022 02:23:30 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003976fbfbf00sm13374295wms.30.2022.07.17.02.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 02:23:30 -0700 (PDT)
Message-ID: <62d3d512.1c69fb81.6e086.d251@mx.google.com>
X-Google-Original-Message-ID: <YtPVEAbMFiYFMcJp@Ansuel-xps.>
Date:   Sun, 17 Jul 2022 11:23:28 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/3] ARM: dts: qcom: add missing hwlock for ipq8064
 dtsi
References: <20220707102040.1859-1-ansuelsmth@gmail.com>
 <20220707102040.1859-2-ansuelsmth@gmail.com>
 <YtN8R1eRTccJ+dUn@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtN8R1eRTccJ+dUn@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 10:04:39PM -0500, Bjorn Andersson wrote:
> On Thu 07 Jul 05:20 CDT 2022, Christian Marangi wrote:
> 
> > Add missing hwlock for ipq8064 dtsi provided by qcom,sfpb-mutex.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index 4b475d98343c..cd1b43e2cab4 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -1224,4 +1224,11 @@ sdcc3: mmc@12180000 {
> >  			};
> >  		};
> >  	};
> > +
> > +	sfpb_mutex: hwlock@1200600 {
> 
> This is an mmio device, so it should live under /soc, so I moved it
> there while applying the patch.
> 
> 
> But it would be nice if this file followed others and kept all nodes
> sorted by address (or name if they don't have an address). Also if
> addresses were padded to 8 digits, to make sorting easier.
> 
> I would much appreciate if you could find the time to prepare such a
> patch.

That will take tons of changes, but yes will make a patch to reorder all
the nodes.

> 
> > +		compatible = "qcom,sfpb-mutex";
> > +		reg = <0x01200600 0x100>;
> > +
> > +		#hwlock-cells = <1>;
> > +	};
> >  };
> > -- 
> > 2.36.1
> > 

-- 
	Ansuel
