Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49FD5685C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiGFKii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiGFKif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:38:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42952167E5;
        Wed,  6 Jul 2022 03:38:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h23so26294472ejj.12;
        Wed, 06 Jul 2022 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=vUdjWGTHZmLYlGc/ZuMHohVJj+eoKfKT6JKGQ2BSBvM=;
        b=UDpjwxUP24o4du4brC7VOF838ENnIC5nCFcdYz0tnMfu3RI9u+0R0GxkwTIByxmX/u
         umt5Ckca4Rw+IovH0fAoPeWR3ddEL6ixo5zfdiN3bg68cJNOsY8kEd2RidCX4ZhQR1v0
         RlX5tmx3jsu1NMwypYd0Z7AvCLHGgcqlo11IDr7GWz4v1ObgPS1T5T/XLpz3aGP/N7wE
         XlI1+aOxqJz/JJvc1YgGpsM1u0mhdQz19k5pbbe1dAFyMpfl+BJPTxP5MiD5JNE3yzg2
         x5rEXvSTOX60wiHz3JzJDsupDfuNFWa3IFLMraYRRqBxWRgzI2EkB9gXkQOQ+4bwHv2I
         hLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=vUdjWGTHZmLYlGc/ZuMHohVJj+eoKfKT6JKGQ2BSBvM=;
        b=WALh0JhryMNLklhiTB59XM0WA0fC05HtCIeZQ56LL/mUz+m/K5tPqG8Au/J/bkpPBM
         p8NYm3+em16FAb5C1G+LYhV6TN+OPl8BXXXbrYUjdXbbNLkW/Jfa+19pIPnRlUmqlQpD
         eBU0LghJ1OKgAMCyCYaqIZ9zIn5f6Es4gzEQQXTP47d0TvXwHq55obx8Vc0ULOEsAmV+
         rxpuMsAyfCNtluzMsEJV8l0yCfXLe1xnLL97O5mXHlO2rpCrRS/gDvk79Chz2N/TnBem
         OMpbOXii7YTNMAWqWPz/qyM29omyBE7cS2YlgKSid0S1sw6P4gqfiE9U4k23AVFXc98J
         nJTw==
X-Gm-Message-State: AJIora9Zv49gKOZBVdW1b8B9CWNgo64U5BWHVOVDvA5fxMXR7j5txaIC
        Nf/vhChLYxooz2dCqCy1aKA=
X-Google-Smtp-Source: AGRyM1uJIm3IBu3JUOLVOZveOCHA6AFa86s/jejR2zWEUc0TFRUWLFhcJGuJd1QJBltIrqCSfKwuzg==
X-Received: by 2002:a17:907:3e11:b0:726:372b:6c32 with SMTP id hp17-20020a1709073e1100b00726372b6c32mr39456512ejc.157.1657103912696;
        Wed, 06 Jul 2022 03:38:32 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id m11-20020a50ef0b000000b0043a6c9e50f4sm6177406eds.29.2022.07.06.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:38:32 -0700 (PDT)
Message-ID: <62c56628.1c69fb81.aea0.a137@mx.google.com>
X-Google-Original-Message-ID: <YsViQy6l7TSB1AOI@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 12:21:55 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] clk: qcom: clk-rpm: convert to parent_data API
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-4-ansuelsmth@gmail.com>
 <CAA8EJpry3pJxEVOL7P7gFL4M9yDktCuDE=2KOGfc6DeAUasYGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpry3pJxEVOL7P7gFL4M9yDktCuDE=2KOGfc6DeAUasYGw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:27:34AM +0300, Dmitry Baryshkov wrote:
> On Tue, 5 Jul 2022 at 23:56, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Convert clk-rpm driver to parent_data API and change parent names to cxo
> > and pxo instead of the board variant as pxo_board is an ancient name and
> > pxo should be used instead.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/qcom/clk-rpm.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
> > index a18811c38018..d45a8b0fc97c 100644
> > --- a/drivers/clk/qcom/clk-rpm.c
> > +++ b/drivers/clk/qcom/clk-rpm.c
> > @@ -23,6 +23,14 @@
> >  #define QCOM_RPM_SCALING_ENABLE_ID                     0x2
> >  #define QCOM_RPM_XO_MODE_ON                            0x2
> >
> > +static const struct clk_parent_data gcc_pxo[] = {
> > +       { .fw_name = "pxo", .name = "pxo" },
> 
> This means that the core clock would look for the DT clock named 'pxo'
> with the fallback to the global clock named 'pxo'. Fallback is
> required to keep compatibility with older DT files, not having the
> clocks/clock-names properties.
> For all other platforms we were using as a fallback  the 'pxo_board'
> clock (defined in the DT) rather than the 'pxo' (hackily injected by
> the gcc driver).
> I'd suggest following this pattern and using .fw_name = "pxo', .name =
> "pxo_board".

We were discussing this to the lcc driver. Problematic topic, yes will
follow the pattern just to not change things.

> 
> Same applies to the CXO clock.
> 
> > +};
> > +
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
