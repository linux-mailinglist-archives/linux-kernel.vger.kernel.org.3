Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5285F4CA4B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241742AbiCBMUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241744AbiCBMUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:20:05 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B610657168
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:19:20 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id x6-20020a4a4106000000b003193022319cso1668265ooa.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 04:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2AHBorZms8YAGoG9GhF+kfihvE43wMRpP4hUA+7xto=;
        b=r4fh2zx+7V9cjuHBtWdTH+AuC8ckxuv3eEjvJg2jgDKfSSAKj2ATaKGBVZMKjnkHqf
         HgcJoT9GYZUogc7cmeUiNUy28YO1+8JNBTdXoqYeqPqWWDbfr+XTQwEW8uRyTW4u4m0i
         p3yZH/6ARzIxhZ6KEnS00wlZFdLvd7EDxldDgKHDvbrux95w+RY1ZPlCWsrYS104b7P5
         7Fz8jTM9orYw2DZEaNRdeH12F4eysoZRdsbU7FCWGzPqa84E0Ca8a2uuDEsjFDO/hqvK
         FQlFtx6ntGzjq+KwsakdXWEQxMXIGbCfjIIK73MUVFBJ0WHSZGPe23km98T+SgmmmEP6
         smwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2AHBorZms8YAGoG9GhF+kfihvE43wMRpP4hUA+7xto=;
        b=SDTvdTvmVBv36VI8y8MKrbmSD/v7hFPBQ45u8zg8Lt46r/YSWk68db10KZ7Cdt4OKX
         h+HFBjlIFGlO6huKrhINgFqCh9f4Maf0PIeRHSuBwx3dHAkza008wPTomCoc/TNbt+2/
         VJnM53ztbbq0wbGIgynb3NMIWIEeOdnxKiqFzjn/3sv1ozq4wCvPSOycE0JA1NrUw1CT
         ZT+WLWEV/ccVT16gWaTtiXtjvWiZsnBozfYNmQxSMk2hWhEJssZydZzmczXHXP4+LFuc
         196cCrqQsSZqWQ//pBtTBycYKj3nhILZxGab2xDkvr+JzTvFTP4mH+7FO/bWaZwqfIFy
         o/aw==
X-Gm-Message-State: AOAM53015XPS4ch8RC92yj+U3vHgTlUamQq2Wz0rcs+JdlApUIppnqnV
        OuPhvtaWqjd82FVpvI1QwRuvypvDttaU+PpP3lsRFQ==
X-Google-Smtp-Source: ABdhPJzRsnGNx1fdPAqwBzv9n93Ob+rDaO5Q/Mm9UetP4uvFOGd1t9zNatKQ5mno6z4JPqg2SO/qtToGVI/930EUBFc=
X-Received: by 2002:a05:6870:434f:b0:bf:9f2a:26f0 with SMTP id
 x15-20020a056870434f00b000bf9f2a26f0mr7372412oah.40.1646223560034; Wed, 02
 Mar 2022 04:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
 <20220301072511.117818-6-bhupesh.sharma@linaro.org> <d51717a2-0a50-f2fb-0d2d-e233c6e75d4b@linaro.org>
In-Reply-To: <d51717a2-0a50-f2fb-0d2d-e233c6e75d4b@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 2 Mar 2022 17:49:09 +0530
Message-ID: <CAH=2NtwGzDCACt16YfMCys+qBF+peTCyJo+WTsEk5CfPUpE2sw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] PCI: qcom: Add SM8150 SoC support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, 1 Mar 2022 at 17:13, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 01/03/2022 10:25, Bhupesh Sharma wrote:
> > The PCIe IP (rev 1.5.0) on SM8150 SoC is similar to the one used on
> > SM8250. Hence the support is added reusing the members of ops_2_7_0.
> >
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-qcom.c | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index c19cd506ed3f..66fbc0234888 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1487,6 +1487,17 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
> >       .config_sid = qcom_pcie_config_sid_sm8250,
> >   };
> >
> > +/* Qcom IP rev.: 1.5.0 */
> > +static const struct qcom_pcie_ops ops_1_5_0 = {
> > +     .get_resources = qcom_pcie_get_resources_2_7_0,
> > +     .init = qcom_pcie_init_2_7_0,
> > +     .deinit = qcom_pcie_deinit_2_7_0,
> > +     .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> > +     .post_init = qcom_pcie_post_init_2_7_0,
> > +     .post_deinit = qcom_pcie_post_deinit_2_7_0,
> > +     .config_sid = qcom_pcie_config_sid_sm8250,
> > +};
> > +
>
> This duplicates the ops_1_9_0, doesn't it?
> I'd suggest to reuse 1.9.0 structure and add a comment that it's also
> used for 1.5.0.

Ack. I will fix this in v3.

Regards,
Bhupesh

> >   static const struct qcom_pcie_cfg apq8084_cfg = {
> >       .ops = &ops_1_0_0,
> >   };
> > @@ -1511,6 +1522,10 @@ static const struct qcom_pcie_cfg sdm845_cfg = {
> >       .ops = &ops_2_7_0,
> >   };
> >
> > +static const struct qcom_pcie_cfg sm8150_cfg = {
> > +     .ops = &ops_1_5_0,
> > +};
> > +
> >   static const struct qcom_pcie_cfg sm8250_cfg = {
> >       .ops = &ops_1_9_0,
> >   };
> > @@ -1626,6 +1641,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> >       { .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
> >       { .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
> >       { .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
> > +     { .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
> >       { .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
> >       { .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
> >       { .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
>
>
> --
> With best wishes
> Dmitry
