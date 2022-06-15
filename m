Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CCD54D1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349578AbiFOThC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349258AbiFOTg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:36:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1554BC0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:36:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e66so12263827pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8al2XYMDvOe7tskCVg70KWMyMTD1/8d1biCJ6KACqlg=;
        b=aE2E6R2HUI6gKUuT0TDv/cWw1AV2lkpEju7eTORxSEkKfoCCeqN0b2alKeT96cm0gL
         Caqc9FMvddEzo4//6PcxvBawlQqC0xidvE97MMxPbeh+5BejQv3J/21Y7+qbaI8r0YyF
         VnQ4ei6q+p84xeWLg2rrMLFi5zT2JjyPz6a6f8hXnuKzmAF1G8Smc70320KYcg9wpxCX
         D32JeEKSMgwTsqb1RkSWCp5U9bHdwC98SrtjqwggpadpePqhrTqSSC83hIVKGox+C+Rv
         93rClelDdO7dOD4irR+XCYIjaOeUj3N9BuGC/BmwZNkTdZIkgpe/7/j+W5dLIxEbW6D4
         vFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8al2XYMDvOe7tskCVg70KWMyMTD1/8d1biCJ6KACqlg=;
        b=HyPJxbFHDsZrQHJ5UUZIJpSZfA77xeArD7bj5ILxNOlkWosjNL1tbG4m9fbU0WRjUr
         SsKX6K5NqXIJurriCaudX2ddGFFuUqHR3/p3NrRfB/6JNtYc4TF2T/w10VX4ej1igMYq
         XCy0tFtYM/lYMBwsTqMDLR4UcXWyhn9EY/Gqi3zj0tzODj3E3hcEZFbJGOzP34MI6Exg
         vXh8IHzCsNMYqyh/zKtlpsyMozHEgT7t/YWv0mr/FcGpzcMoChsufEP5Nj9x0G2xEcni
         x/iw7NzqnkD0er+LGmaOueTMsGGYJsrpH1R5pKTY52otnIAzeqqZNWjAN7tSsM/7cKyL
         ii+g==
X-Gm-Message-State: AJIora/vizYZ96E/INnPi6ZUYPGTUmah80hSYZYXFfgjJPtTYJoNuPSk
        ZR52RxRvsPinNzvkcG5ZQ7y/KDWNpviZgJKZ
X-Google-Smtp-Source: AGRyM1vawXOzGKVs8hMwFnr0hCamRPmiXm+V1oVB883gU2xvVIHll8w5N2I7ADuvrTk52dKNHgyWyg==
X-Received: by 2002:a63:5205:0:b0:401:7586:74f6 with SMTP id g5-20020a635205000000b00401758674f6mr1122057pgb.591.1655321815661;
        Wed, 15 Jun 2022 12:36:55 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090adac100b001e67e01158fsm2216549pjx.30.2022.06.15.12.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 12:36:55 -0700 (PDT)
Date:   Wed, 15 Jun 2022 20:36:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com
Subject: Re: [PATCH v1 1/1] MAINTAINERS: Update Intel PMIC (MFD part) to
 Supported
Message-ID: <Yqo01aws5MNwW9gq@google.com>
References: <20220530120015.70543-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530120015.70543-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022, Andy Shevchenko wrote:

> The actual status of the code is Supported.
> 
> Reported-by: dave.hansen@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
