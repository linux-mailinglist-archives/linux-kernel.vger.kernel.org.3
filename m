Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9AE51143C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiD0JXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiD0JXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:23:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FB7289364
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:19:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso3032906wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8sqkicp7TCLsdDfMQvxUs9jKD62pCQQIDqpRab+zTPA=;
        b=Pb8JHvgys+tt8nxeISBxsgvfy+Y7Jy0cPdD9gyKPY6czvcdWKb2n091OCCQrtd+DPJ
         NP18QmY7iPaZbNbMUXTtQ2DCXXDlfY3qxlvb5Zw6E/FH0dJIMfLD/dXUDTIbbLH3awIZ
         V68Nt3Gd2omrhy6sdX2mS9dsOuWcb81/wJENsYRhThdfUXs5N+yUp+y/mZ3xkGOF1kvP
         cqmvzELke+1fQhJjyou3sg844RTMK5NV6m1VBpsdwSG0TMwNU7UwgEsGdB1O/xdZemN5
         XZAKb5LLWdWDMb7YdgqLJIZtqnoD3/7Y3Qe/NInjsiPq7R9DR42MgS+7f1OUaxFuVAvh
         PukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8sqkicp7TCLsdDfMQvxUs9jKD62pCQQIDqpRab+zTPA=;
        b=RFhlYfp+2GDX6zBizPjYjVueEyxgYERjKFy+WDKIz+qB3FadpA3m8DGM55L58NGzVb
         RBZWx02GFFZnITo0ACAIKyOQeLYsqJ15te85AUytihSz8O47gDu0WhkuY59JiFfbYNGV
         KkayraGwrkHxvxrz7i5bFm4pm9GEu0Kz2n9/a6LRVNGhevWbjWmfc09wRa7omFtbI24O
         dxdykmJw5xegpFQrjq7wsxeUlERuJegwVGC8VAqoZ5hmYW2XBa0Oy6nYRozNllspw/aR
         n3cHs95IbLTW30IaRoylAs7aRNo8R0F22OkCZY6BIZP02eMTRQ3bRFBG+WO6E7KR04HV
         O3lQ==
X-Gm-Message-State: AOAM533Yrc10nkdRAIXR052R3ORvjdsfvrAkfRBtuwPKDy9UmJB1BF0t
        2M0uvPsENJg8X7CGNX02nCmWog==
X-Google-Smtp-Source: ABdhPJwS3Lpq1bbdJ/fRRbVTbgFuQnhJ3BQPIShYP2o8we0b0VCYIytS6QLcOCV9H1BEpUESsEWMSQ==
X-Received: by 2002:a05:600c:3547:b0:393:eee3:39df with SMTP id i7-20020a05600c354700b00393eee339dfmr10656180wmq.181.1651051169012;
        Wed, 27 Apr 2022 02:19:29 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id v6-20020a056000144600b0020a9a1627e2sm13681977wrx.15.2022.04.27.02.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 02:19:28 -0700 (PDT)
Date:   Wed, 27 Apr 2022 10:19:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sprd: change the device_id data order
Message-ID: <YmkKnlL9XQOaulft@google.com>
References: <20220427075212.3409407-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427075212.3409407-1-gengcixi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022, Cixi Geng wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Ordered with the smallest number at the top.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
