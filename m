Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3CF55DA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiF0OKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbiF0OJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:09:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52D813D6A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:09:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so5721232wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jojb+I5vu8ulvAjghx10j+BHDVxqMYhhkEXWAGtGjuo=;
        b=oaGrp3Aasb4Tk57Hdw3ZkCT4SGSU+I7em1VUBat0zS8wWNmLcdN81wQYUNjGh2Tymu
         7UJKdfUB5lIOKI2lwoLM63cluMiFwlCAeUzY51xTxI88M6RXmHHz4bxZrjerfcr18fy+
         iCWDh3DWNYDg5w4+s1pvmRe6o5Ds2xkbpa8h7nZdZ5nzniQQVzqkQbBqQzkOSOHiaQEl
         vAVnhHTT3e6SOZ8JZE5dGzbSSFo6hiq6HvS5K0ONiwOVX2CQ8t4vGmcnaL3uNoX54PSB
         zsx/TzKZpYOZUSFsqhRqe0qFL4+QR5+RAfr3LuXY4W4oqvEWbaBOzVo/CEWGcRZmAW6B
         LYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jojb+I5vu8ulvAjghx10j+BHDVxqMYhhkEXWAGtGjuo=;
        b=LXoDdwsKAfcPXQkQttrDGVj9chqRDfXkBN9q2t/kjLWecRvl1l08tFfH5EaEGIIXFa
         +GDK37RspPzhsgpnfFfLSJzjat0MquqQtTFa6UWR9KhKwOMDd847f9YQlWc0m6a8pkJq
         L8c+zS3I1vlHUz/RG4DTB6pNv45fjk2J0PNxcO4e4rOXlUxbDAlRYJgrkWX/BrRYHTox
         lcsKQAs2puLhNPdDe13LzVk8K+OVqtr0bKX8vuIwPutEQoAZg4uiZ4sfxacdAihPO7cQ
         Q/8g5hwCI+F3VxxaFB9h685HtjtnAy8+F6+EdeZNzhjE4StiZ+JAix0QE3IugtloGnm5
         bmQA==
X-Gm-Message-State: AJIora/yQV0ivKgeHNWiM7TPmoiRu4WsFfxR1I1B+IZQeP7P6LpZw5mX
        HPmMf/tZw3owqYEkjSyCINLq0q5CairpxQ==
X-Google-Smtp-Source: AGRyM1sdpafrWVgHTSwkK+bILrDrqAMbAUdc1pNGCOmCSCWJoM43hTwX83em6aCvjIGs0ihU6KDIDg==
X-Received: by 2002:a1c:7913:0:b0:39e:72d1:b9b3 with SMTP id l19-20020a1c7913000000b0039e72d1b9b3mr14994122wme.53.1656338989417;
        Mon, 27 Jun 2022 07:09:49 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c3ac900b003a03be22f9fsm14098623wms.18.2022.06.27.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:09:49 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:09:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: db8500-prcmu: drop unexpected word "the" in the
 comments
Message-ID: <Yrm6KzycESat3zI2@google.com>
References: <20220621103839.96847-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220621103839.96847-1-jiangjian@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022, Jiang Jian wrote:

> there is an unexpected word "the" in the comments that need to be dropped
> 
> Line 801: * This function sets the the operating point of the ARM.
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/mfd/db8500-prcmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
