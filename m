Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0C57903C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbiGSB5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbiGSB5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:57:17 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B43A4A7;
        Mon, 18 Jul 2022 18:57:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so8328224wmb.5;
        Mon, 18 Jul 2022 18:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=cMdIIoXo0FxTmPtZAYMM+ebkWDuNNu4halIh9g0H150=;
        b=QEp68kdpNdHrPewjZ17Oqg9GlxRj3DcdLdteTarojRBSKXQM8FA9DGO5RuIwk0IIXE
         aMlkHP9fRnLlSLaVutro69FwqJ4AYy6FxgpzjBuacIBzxjbXlWEnDu1UYVNoaRWJfSao
         o8gOCNkyaXDfikW1l/wXL3otFgYKE52dP3xeXWcvdWhaaywZiQg+YrIgt67mZM8pk+st
         58ibWKjy9vqw1WXde0+SNC75AqVBYX2I5d7zesnQsOuh+J7ZDfou7UHQ0A46MoYjo++X
         yR/akz5RYGHCau4jwZrDqvz8Y1e/E+mDSmK/n0oA50UvMloDix3hjvhNDm7ATiKQYB6+
         PInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=cMdIIoXo0FxTmPtZAYMM+ebkWDuNNu4halIh9g0H150=;
        b=UEMGv0B52jI97bkG2IPDD7QA35DbixVmNROWod3bGN+DGl9HYzIuUTYNvvp6wXcu7h
         siYTVeeJzglZip06YvsN63FNmWIo9/vdL7FkgwKBx3BvuizxC4azufVQ+0QFXWoF3x54
         pioQlQ5qN5IqflJ4h/Yomli3IZxGUYXBFwzMro588MwN3dVQ6sRMvbu22hhvu5S8gfPz
         gsPHNwKjtJot5lMI7741qJj6ZKWETXkKuIdfRZJeFAH0Z8RxiM3ru6ueyD6+yazja4UR
         aj26yY5s+L0mFrTnisZhuPLRXQw1E4VB1UsM5+H7xDXbBQ+Q30quZkulDu28DhSW7bWn
         5LHw==
X-Gm-Message-State: AJIora9dtTJXU75dz8cTNZb5NMQSnT3o9EzCI5fdSAzp/gw53zE6nAc3
        7uAmTBeqCddM3YFgxrTKp0NhBlc2SB4=
X-Google-Smtp-Source: AGRyM1uIG7y0Cw3cup9C6XUdbEkziq17iApIgTsjUJfsrpyS2sx5wh/uBSkgRD+Z4/eq70fFM9PxEA==
X-Received: by 2002:a05:600c:1d17:b0:3a2:ff6b:9a2d with SMTP id l23-20020a05600c1d1700b003a2ff6b9a2dmr23755129wms.103.1658195827618;
        Mon, 18 Jul 2022 18:57:07 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id r129-20020a1c2b87000000b003a2eacc8179sm16981793wmr.27.2022.07.18.18.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 18:57:07 -0700 (PDT)
Message-ID: <62d60f73.1c69fb81.feea9.5487@mx.google.com>
X-Google-Original-Message-ID: <YtYLcONk3l90lJL8@Ansuel-xps.>
Date:   Tue, 19 Jul 2022 03:40:00 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] clk: qcom: gcc-ipq806x: remove cc_register_board
 for pxo and cxo
References: <20220706225321.26215-1-ansuelsmth@gmail.com>
 <20220706225321.26215-5-ansuelsmth@gmail.com>
 <YtX2///aNWyhKpJn@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtX2///aNWyhKpJn@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 07:12:47PM -0500, Bjorn Andersson wrote:
> On Wed 06 Jul 17:53 CDT 2022, Christian Marangi wrote:
> 
> > Now that these clock are defined as fixed clk in dts, we can drop the
> > register_board_clk for cxo_board and pxo_board in gcc_ipq806x_probe.
> > 
> 
> Are you trying to say, that now that we have .fw_name based lookup of
> these clocks we don't need the globally registered [cp]xo clocks to
> bridge towards the [cp]xo_board_clocks which was introduced in:
> 
> 30fc4212d541 ("arm: dts: qcom: Add more board clocks")
> 
> I think this change would work out if you also replace .name = "pxo"
> with .name = "pxo_board_clk" (and same for cxo)...
>

Mhhh why pxo_board_clk? Why _clk? It should be pxo_board.
Anyway about this, only the rpm clocks use pxo_board as parent,
everything else use pxo. Aside from rpm and gcc the other user of pxo is
the lcc driver and the krait-xcc clock. I sent patches to convert them.

> 
> But I don't think we can just drop these, as it would break
> compatibility with existing devicetree.

Wonder if we will be able to drop this ever? 

> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/qcom/gcc-ipq806x.c | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> > index 718de17a1e60..883629de2751 100644
> > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > @@ -3384,14 +3384,6 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
> >  	struct regmap *regmap;
> >  	int ret;
> >  
> > -	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
> > -	if (ret)
> > -		return ret;
> > -
> >  	if (of_machine_is_compatible("qcom,ipq8065")) {
> >  		ubi32_core1_src_clk.freq_tbl = clk_tbl_nss_ipq8065;
> >  		ubi32_core2_src_clk.freq_tbl = clk_tbl_nss_ipq8065;
> > -- 
> > 2.36.1
> > 

-- 
	Ansuel
