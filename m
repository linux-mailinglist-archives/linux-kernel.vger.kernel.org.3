Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABE5560327
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiF2OgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiF2OgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:36:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EFC31358
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:36:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n185so9477214wmn.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mDRUQBQgMmxkE+9DyP5icmrJT5k4xDypDVHgVIqYkM4=;
        b=vZWGORosd+wVCIZ3Sy9zfDYUlv1YSU0qxZGKxaU9sqPTSeFyLWTPs/tkPOSkF62BeL
         l0D5fvCsmqX9cn/rogOhIfUuuabILnxn2DZCMRB6c5UTCIlIVu0K4NqFgwCOqtJan2bW
         SGHHH3M8MZFSHV9gc76ltfo3QQOE1kmkHmXb5sn4Bp38CvZ+gkrpTqEYQ4D/6q8vo7Uc
         kGkb3qopZrU6Ci375oZRQkmmU8tiFcj/Oboy7FJhTOxwABUMFtUz1cDt6a/zYHbUsDp8
         5Nx/r/UMsct2N7EN6SipHeIsQeivWpCqXiFNgUIZSiDHFzJcQC/By/ZZylCKX+rH9Nta
         pzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mDRUQBQgMmxkE+9DyP5icmrJT5k4xDypDVHgVIqYkM4=;
        b=UkI0W1lHd/nfPKyGWJV4aKNePgo54yxr4NTHJMtxH+aSRUi+aTNsGE3rVhBEBZL73b
         pP4FTZnZYyB0PyfRAB9QlvSzMhVrsHXZlXrUR7Hv0hILdHbymnKyoL2AbXqHMubPUCa+
         9fm40X7RXbtbJG56NdOcuX7ex95OkhTVJ9nKIOf46gwoU7/q7r/nvZzONlSgo5r4oiL5
         6iYPk/ZpHyqodpYmPoR+8ifaUrIxIuPGKNuUsp4xZBY1wv4AIzqgifIf2tIa2vNvV5iL
         gM3qfWwc3VCjR31z637FJt8F3zqA4DZBdlY63Xy/BZsLL1VVyjl9n3jygwhFXmV3m821
         KxDA==
X-Gm-Message-State: AJIora8ccKD7jKauzyLSauKkC4Ame/SI5m6Ie27CV01b0LS7kx0IsLSL
        J+FwcXTrqkoaLQtPFKoAVDO9+g==
X-Google-Smtp-Source: AGRyM1vmwWoPvUWDv2eMeJ6PjF4jijj2IgIs5Hw1vSc/VRDQ4sYpAUEs3RDeDKgvnIqu6etp5n1Ipw==
X-Received: by 2002:a7b:cc96:0:b0:3a0:4aa0:f053 with SMTP id p22-20020a7bcc96000000b003a04aa0f053mr6161893wma.89.1656513360221;
        Wed, 29 Jun 2022 07:36:00 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l4-20020a1c7904000000b003a047f64496sm3402631wme.7.2022.06.29.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:35:59 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:35:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YrxjTD0sJXh8cgVP@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <Yrmr175fsQi6ToEY@google.com>
 <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022, Andy Shevchenko wrote:

> On Mon, Jun 27, 2022 at 02:08:39PM +0100, Lee Jones wrote:
> > On Thu, 16 Jun 2022, Andy Shevchenko wrote:
> 
> ...
> 
> > >  drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
> > >  drivers/mfd/intel_soc_pmic_core.h |  25 -----
> > >  drivers/mfd/intel_soc_pmic_crc.c  | 162 ++++++++++++++++++++++++++++--
> > >  4 files changed, 157 insertions(+), 193 deletions(-)
> > >  delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
> > >  delete mode 100644 drivers/mfd/intel_soc_pmic_core.h
> > 
> > Can you submit this again with the -M flag please.
> 
> This is done with this flag. Basically for the last several years I do my
> submissions with that flag.

Odd.  I thought -M only showed diff for the changes.

> Anything else I can do?
> 
> > Trying to figure out what exactly changed is proving challenging.
> 

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
