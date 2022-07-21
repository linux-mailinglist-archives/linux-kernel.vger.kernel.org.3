Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EEA57C6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiGUIzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiGUIzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:55:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CD7357C2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:55:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so1305914edc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y52+vmlkRnvgFyCTIdVjgi2XLyCNtChwCyrrSaF4xEs=;
        b=JfScOhfOqzqLqsMNguyPz0pmtqPx00EBej7n3tTNiTELdECIuqhQFfdgfxv0NZANL6
         fJHBfkEJAKFk4rovHbV7mrijRm9H5aWF9cBLWsIHOitso5dVjWiy2XozKo4+hV0MqAmt
         mNgaTsrlEcSahSI8zRaZEJpDBfjjMGPO7jIgBdUnSZex7WTQlFX9K3n7+zQmNajKEMRu
         F9FPjIDBrMF3Crz4neWe7RT80XgUh+SRBz5BD23hs5/YjGMXJLiMh7wXt+F0TY4YlsEp
         V3Yz7uwhK2GsLAG8wMmN0xZf0N11NN/fTBzc64C6eiDBhDhoV6Zqxkt1JYliOh/vlYiV
         pV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y52+vmlkRnvgFyCTIdVjgi2XLyCNtChwCyrrSaF4xEs=;
        b=fUsZuDxzGarY0l21okSL4Mt2OKbLYvV5lL426QQHdjwisjdjvOtaMKkuWnJNhhSj+o
         sQd4m8An3TT7tzXNmOzYgFrMschNGO3Byiq1KS1BAROyVkXzzGgxPmWcZmrIWjCdf33T
         y+ESPL47Q4eVQYC4AUwU3APpBeALCP5mPNDyO+d9AAaex/3XYC3Bf/RJ97A6ZkfiNVKh
         g4qJr0xiJAXUzI9uP4zlx6nnvQ7oWwzaSxFRBHx013nrI8+RHPGLN2uzv6C5ZLmEQ5Db
         LeWGlDdEPUhf/KbSQPqUBIG9HigblKXR4PKL8D877/FFPhBokDf/RYpjoZZf4Dhz0Cin
         cyKQ==
X-Gm-Message-State: AJIora/Jf7vUigXzh52Sjhnoj9RduLFgYbjRegwUekKjumQN729iqozZ
        t2z8BjRuvX34fKdjM7j17xj39w==
X-Google-Smtp-Source: AGRyM1utn9lhUWfU5jFiySqjwbTTFY/S53Ue3qZ3Nt/lL522fet/Tr/Y0KsbrgjwndvTNOGyKyH5BQ==
X-Received: by 2002:a05:6402:22c9:b0:43b:c529:7ee1 with SMTP id dm9-20020a05640222c900b0043bc5297ee1mr2760657edb.251.1658393748544;
        Thu, 21 Jul 2022 01:55:48 -0700 (PDT)
Received: from blmsp ([2001:4090:a243:806e:25e7:daa:8208:ceb])
        by smtp.gmail.com with ESMTPSA id wj22-20020a170907051600b0072af2460cd6sm611924ejb.30.2022.07.21.01.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:55:48 -0700 (PDT)
Date:   Thu, 21 Jul 2022 10:55:47 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] soc: mediatek: add support of MTK_SCPD_STRICT_BUSP
 cap
Message-ID: <20220721085547.unr5cu4kywpugxmx@blmsp>
References: <20220530204214.913251-1-fparent@baylibre.com>
 <20220530204214.913251-3-fparent@baylibre.com>
 <c385ab55-bffc-8185-5d8b-f2fed1dd54a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c385ab55-bffc-8185-5d8b-f2fed1dd54a4@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

sorry, took a long time to respond.

On Fri, Jun 17, 2022 at 04:20:10PM +0200, Matthias Brugger wrote:
> 
> 
> On 30/05/2022 22:42, Fabien Parent wrote:
> > From: Alexandre Bailon <abailon@baylibre.com>
> > 
> > This adds support of MTK_SCPD_STRICT_BUSP cap.
> > This is required by the mt8365, for the MM power domain.
> > 
> 
> Please explain better waht this flag is doing.

I will update the commit message as well.

The flag basically tells the code that there is a strict bus protection
policy in place which means that bus protect release must be before bus
access. This is not on all platforms the case.

> 
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >   drivers/soc/mediatek/mtk-pm-domains.c | 37 ++++++++++++++++++++-------
> >   drivers/soc/mediatek/mtk-pm-domains.h |  1 +
> >   2 files changed, 29 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> > index 90b91b3b19a8..beaa5785fda2 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.c
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > @@ -263,17 +263,36 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
> >   	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
> > -	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> > -	if (ret)
> > -		goto err_pwr_ack;
> 
> I think it would help readability if we would enable the clocks only in the
> case that MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUSP) is false. Then we would
> only need to add the same if to the error path of err_disable_subsys_clks,
> correct?

I already rearranged the code to have a cleaner flow for v2.

Thanks,
Markus

> 
> Regards,
> Matthias
> 
> > +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUSP)) {
> > +		/*
> > +		 * In few Mediatek platforms(e.g. MT6779), the bus protect
> > +		 * policy is stricter, which leads to bus protect release must
> > +		 * be prior to bus access.
> > +		 */
> > +		ret = scpsys_sram_enable(pd);
> > +		if (ret < 0)
> > +			goto err_pwr_ack;
> > -	ret = scpsys_sram_enable(pd);
> > -	if (ret < 0)
> > -		goto err_disable_subsys_clks;
> > +		ret = scpsys_bus_protect_disable(pd);
> > +		if (ret < 0)
> > +			goto err_pwr_ack;
> > -	ret = scpsys_bus_protect_disable(pd);
> > -	if (ret < 0)
> > -		goto err_disable_sram;
> > +		ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> > +		if (ret < 0)
> > +			goto err_pwr_ack;
> > +	} else {
> > +		ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> > +		if (ret)
> > +			goto err_pwr_ack;
> > +
> > +		ret = scpsys_sram_enable(pd);
> > +		if (ret < 0)
> > +			goto err_disable_subsys_clks;
> > +
> > +		ret = scpsys_bus_protect_disable(pd);
> > +		if (ret < 0)
> > +			goto err_disable_sram;
> > +	}
> >   	return 0;
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> > index a3955d960233..5347471bc3c4 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.h
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> > @@ -8,6 +8,7 @@
> >   #define MTK_SCPD_SRAM_ISO		BIT(2)
> >   #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
> >   #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
> > +#define MTK_SCPD_STRICT_BUSP		BIT(5)
> >   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
> >   #define SPM_VDE_PWR_CON			0x0210
> 
