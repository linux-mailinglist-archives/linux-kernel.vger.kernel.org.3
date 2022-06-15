Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F12A54D34A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbiFOVGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiFOVGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:06:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27535850
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:06:15 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 184so12448255pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EUkqd6v0LN1gANy7CrcHX8pJTcOEcqatn5lL+ysvCwU=;
        b=v0VdZfUVd8lbYQvoe+AUT4cfAMa5jdk8tzVh1mqhWP7RbFcFqm956KAXBtIvyU47g1
         yB0uhNfPqfmtKyQEo3/EdF0YgftqRpjZYoI6DkRQ8hmL8Pu3TYoYK1pSsUlJbKDZckMV
         pXiSuwBQq9+GLPxvKxkSLk1pOD7847ByMQVhJSI8U6O1B8q0ROVJS86UhlvCLPf5qEAn
         IEw6SvjMTroy4oBy06HCKRCsiYkKpF9ie4DSlfjH1v4C2DbeQrBmiVKweTKyUT3YWf7P
         K3v6aBRHnLhr+1bgzabAX1sBewgKryHqPu0otqEmeQktjATQZ1P6qqL30NAlVbK0zZYW
         TGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EUkqd6v0LN1gANy7CrcHX8pJTcOEcqatn5lL+ysvCwU=;
        b=OmnZMnb+RRlQf+vzoQEY8DGN+BeI+fKoBqNNwYyUxbWb3rsQFH9e1lJI9zqJwrQoGx
         uOODD1gSxVqxcjTPPkw1Levd+jzTjcJhPVRzAzuC+1jc6d7CewUb+FJ4NiA5DQA3jQaM
         ruD6E/HlOeh6QOzRwxpTK6lyeyy4V76wNiynlVV6xJKSUHFb4CI6aoBDjw4oFvOth7vQ
         +1WVIw10WEqDlj5fqPZ5z55uNWtVATR8YPEqfypk4p/3CWZmHMmrsTYpj+YeX7iB4uGw
         q23zUYumRLKhZfBDuR7IHFXNaVurgg48e6mJNKishuomvWaHULLT8cxFzx1GfqK9HMod
         DX9g==
X-Gm-Message-State: AJIora/B84szvCYCFdCDvckeChcBXwsiTxvC2Aub/7ciQNkndcGIwkGD
        lV+Q+UAQZE47ElQIiAHQdK6zXjSarBZnvkKk
X-Google-Smtp-Source: AGRyM1u23bAIJTmn1Z8KywIe5wxumEvcHOq1w1HL3CJb9K9M34VXSZfDzISOM177YyTPrKupwuULzw==
X-Received: by 2002:a05:6a00:248b:b0:51c:4f53:a932 with SMTP id c11-20020a056a00248b00b0051c4f53a932mr1243256pfv.51.1655327175047;
        Wed, 15 Jun 2022 14:06:15 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p6-20020a62d006000000b00522c7bc96c7sm101797pfg.14.2022.06.15.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:06:14 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:06:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/4] mfd: asic3: Make asic3_gpio_remove() return void
Message-ID: <YqpJxMF+7Z/2a42A@google.com>
References: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
 <20220530192430.2108217-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530192430.2108217-2-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022, Uwe Kleine-König wrote:

> Up to now asic3_gpio_remove() returns zero unconditionally. This makes it
> easier to see in the caller that there is no error to handle.
> 
> This is a preparation for making platform remove callbacks return void.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Side note: asic3_mfd_probe() which is called by asic3_probe() could
> return an error, but this isn't handled.
> ---
>  drivers/mfd/asic3.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
