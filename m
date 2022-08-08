Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD458CB35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbiHHPVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243386AbiHHPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:21:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B13DF80
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:21:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso4647671wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=/aQl8wvm9E3J7UGIPft/EHOkSFTFjH1CdmXqIGFuzOE=;
        b=YrkcKl2PRFVM1xpJke1tGgm1EiIxcBgMNzbhwDjs5rYWIG4bP9Q9vp+RK4goTrgT/k
         xt/XBtqpuu0GedUq0P0DZSbuA6/w+0yXAUQ/5NC+eCUNbxJYEYV9Po+2rw+ozBYMdjjz
         Kad2zDj4/DhUjNwX69bT820kPiRVW/MF9SMz8i+odwpJ0NJk/K4DBW8WTqUXXIW5pOd9
         vt/q/NgK5v2rFXm8f1RqUFVJAEEIb0UKvL8asxtfXeSEP19qcrFicadh2odcbrBkj+AM
         F/qZHVO8XQtKnSEsga1C/x4Uiu72tQwzx3Enj91wqzkFciL9LQSC+TgSc//7ABNyQj0n
         NpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/aQl8wvm9E3J7UGIPft/EHOkSFTFjH1CdmXqIGFuzOE=;
        b=pR3NMeWodypMslX2VBKwUsVZeHcXyLY+9LsUCxO8/mSqGfUbsedeJ/j8OidlP85MpG
         jDjObPQ6b7jxQ7KLY4kqORqKJ6d/qFv/5Src4UkW1nG46UP+eF6ASmp5efJWz1468ZQP
         nVJRJYEIGo2vjrTa17unGjhyk4fARwnsXPd4bC8uZc34AF+MW85cNnftLePcKPIDUD/A
         TDLz5DG5uQR5rca8mUn+PKMd5R1El+vdMh2s78RlslUSJa5yaI16aKIze99hMAU1y+nb
         h+wOc3CFEq6H/RMLWcMuCnn+ltCUpHPMo+FpI75aQka3iXme3kBH5kwb6oSrH6vJf8zJ
         zfww==
X-Gm-Message-State: ACgBeo37Us6mo3MhRzJhRVrHEhf5tEwzKmUrXme5EzDIgwDAybf2moyc
        GqrYMMCuJxJK0RjuFJx7MDENwuiQWApibQ==
X-Google-Smtp-Source: AA6agR5jg2GJfsoDifmainWD45oN1RguIrC5gKnyIl29Pen1bJuApY/L87JfRSx9b6eJ6f47I5wT0w==
X-Received: by 2002:a05:600c:4f49:b0:3a3:1d16:18e8 with SMTP id m9-20020a05600c4f4900b003a31d1618e8mr13293775wmq.109.1659972081366;
        Mon, 08 Aug 2022 08:21:21 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4803000000b0021e42e7c7dbsm11518853wrq.83.2022.08.08.08.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:21:20 -0700 (PDT)
Date:   Mon, 8 Aug 2022 16:21:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [RESEND][PATCH v1 9/9] Revert "mfd: intel_soc_pmic_bxtwc:
 Support IRQ chip hierarchy"
Message-ID: <YvEp76xF265c3/yL@google.com>
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
 <20220718122328.8287-9-andriy.shevchenko@linux.intel.com>
 <YvEpy/I2F9pk19Ar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvEpy/I2F9pk19Ar@google.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Aug 2022, Lee Jones wrote:

> On Mon, 18 Jul 2022, Andy Shevchenko wrote:
> 
> > This reverts commit 4a34dfdfcc185efea44da958b2e4a6005a70e7d4.
> 
> Sign-off?
> 
> Commit message?

My guess is that you didn't mean to send 8 and 9, right?

> > ---
> >  drivers/mfd/intel_soc_pmic_bxtwc.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> > index f9842ff44b3f..8dac0d41f64f 100644
> > --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> > +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> > @@ -422,10 +422,8 @@ static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
> >  		return dev_err_probe(pmic->dev, irq, "Failed to get parent vIRQ(%d) for chip %s\n",
> >  				     pirq, chip->name);
> >  
> > -	return __devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq,
> > -					  irq_flags, 0,
> > -					  regmap_irq_get_domain(pdata),
> > -					  chip, data);
> > +	return devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq, irq_flags,
> > +					0, chip, data);
> >  }
> >  
> >  static int bxtwc_probe(struct platform_device *pdev)
> 

-- 
DEPRECATED: Please use lee@kernel.org
