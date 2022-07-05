Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30330566EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiGENGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiGENFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:05:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75462DA97
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:32:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bk26so2272152wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3h8IwJb/X5yrsXPZtVPE+zLoArglTBKDiVaZV8Tb8Ys=;
        b=O8JZXQkQru+6Hqi3SMebkFGvcbgn25KO75WaDQGcmIQhQnOoP9pP6XBkIK5c9RcHZy
         HKOE9w5PNv+zPdK3ZE/RxVgWREZH69/ZdsSdJ/UsJp+CVkHUBpy4jLsrN7hTiOLYEcoY
         aB6Qo9tEsOPEUeB76j8rhTPK2qJ1Nbz3yQNl80BGgBrsGcFMW4+SRZ6kEPJ0XtmVWcij
         sFPEVPoPnfoKb5x3YR+iR2uApdKzZgt1d3JMvpKx4BSr9Ccf/F4TIpWOYPmkWH/Qp1Nt
         A/YWOovHCsjGWSq0jLdxSZJWKZ/g9cEW3TeWZwAfXjjde1HtPh5slnPR3LF9LJ76a6Qc
         88Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3h8IwJb/X5yrsXPZtVPE+zLoArglTBKDiVaZV8Tb8Ys=;
        b=Kxvq+8/1LIsy2Y+0TaETkVNYIkgCwF1B2RumTZsZ6hJVDpmhtjg1+WMc4uKzEhMwHU
         caTad29UngnA//sq8nSJQodh+UB5aVjuYwv8CkzQk77i5BzAW8U08yLmBRO7j5nZXY9m
         uecpzbO5JdRom0QO6hprTrLPKza6HMVuxe1r/2O61rNVz6SCb+dsTHZFjL+1mCVq8avD
         y2CMJSQRoSpxQh5QD4DNp0Jwyn85zhZXcxbHdV+X/BgiK8egCbDTVLn/dhG8HUEtcEAP
         u/JaFIM9iif5m1ker75VrdEhfYWuw1MtryyMA97woBEUJlHadqyGYCraFfYIUmcBqLLt
         Oivg==
X-Gm-Message-State: AJIora+zrh/ErZGsHuXGQ89VDOKUnuas+RzRUlfaEnV/GDuoBK5Nef9z
        4Se7j24BAkGmN2lkrI5FYRnFVw==
X-Google-Smtp-Source: AGRyM1sGW8Pl/DwqS8c+Bs0FDAR2JcJiL7UdVqHIgFGkVWx1F+zQl0fPY1XSaAPAFVPMN+NnfQIZdQ==
X-Received: by 2002:adf:f44e:0:b0:21d:6eed:bd0b with SMTP id f14-20020adff44e000000b0021d6eedbd0bmr5466121wrp.216.1657024369204;
        Tue, 05 Jul 2022 05:32:49 -0700 (PDT)
Received: from google.com ([2.26.241.96])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b0039c747a1e8fsm19728277wmp.7.2022.07.05.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 05:32:48 -0700 (PDT)
Date:   Tue, 5 Jul 2022 13:32:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mfd tree
Message-ID: <YsQvbia3TXHe/CYS@google.com>
References: <20220705115439.5a189cde@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220705115439.5a189cde@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jul 2022, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the mfd tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/mfd/axp20x.c:634:35: error: initialization of 'unsigned int (*)(struct regmap_irq_chip_data *, unsigned int,  int)' from incompatible pointer type 'int (*)(unsigned int,  int)' [-Werror=incompatible-pointer-types]
>   634 |         .get_irq_reg            = axp192_get_irq_reg,
>       |                                   ^~~~~~~~~~~~~~~~~~
> drivers/mfd/axp20x.c:634:35: note: (near initialization for 'axp192_regmap_irq_chip.get_irq_reg')
> 
> Caused by commit
> 
>   8c7d8aa029a3 ("mfd: axp20x: Add support for AXP192")
> 
> I have used the mfd tree from next-20220704 for today.

Aidan, what are your plans?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
