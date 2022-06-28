Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A655EF18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiF1UPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiF1UPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:15:21 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA924205C8;
        Tue, 28 Jun 2022 13:10:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r66so13235104pgr.2;
        Tue, 28 Jun 2022 13:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SxEAgGhXZUimjkuSK5lsXjj4eSChRh9RoZUK89SqAI0=;
        b=EJwkK7oN7ZsHUjDbE9Sy4XKbeASkq2tgVbuNIexkpfyliT504YDtYg8nceZAW83BAy
         aXLPO42ff6sytw5RFI7irXIjSZvTc61Qxmvdqlmd99soyxCnX0iqfwuG2VxeIw1Jy4lO
         Mds4CTSg76QfubjsoaforcA8Gd/lJw8atPoSjAjdal4CeYVJbcP2azRmnrYnM7R7TeB7
         owKcbdC++uTOw8pU9GgtxhLwwRsnU2JrTOVmIb2x/WN/S7m1rxY6N3J+403L+SsaVf2z
         UGrahueUHZlKH8FZ7F6YL+0PcKyqcAkDHViE5dVtFZXAC3aDmGVE1yyM4wZSHUqArmyI
         JmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SxEAgGhXZUimjkuSK5lsXjj4eSChRh9RoZUK89SqAI0=;
        b=NGZdUTcZMsomdrgQCymQucX9Z/jAzqYn28/cIT3s7VwrBpuidokyJrsCCGFZpSU5oR
         +ygb5+T+C08s5ZO9pYmyWu6vfyddyK6iv8J46bpnBxRHkEfntXIrShA2QkUtrVwWsK2o
         7OwBF0ixl5wucTfbd47ecgZDf6ehL13OzmDKZlSYcaJC4oiVh4I+2UHH6mNs/Mq0lyYA
         QTszDhzgcLaX3wUVw0VzDQBqWTqfZdEF+yMF/cMMHhQL/KewK5/VRos2M25CVgXMkW6s
         rDOCaZYF78Oi6H3aTvPmU5oX4xApHz6HzVJ8otVNsJ9vipgCmAcdTtmmUFiiu7POY12H
         kHxg==
X-Gm-Message-State: AJIora9DS8m5Mll5kWSsPLtyDOXUlIob4Ax//ntG9KDBYMyoj9jeAJ5A
        05TaqGSBg5GrnUMqOgUcunY=
X-Google-Smtp-Source: AGRyM1tDkQltTNLlYFGC05/KK1Vj/8PpOF4o6yyHoX8kGZuOe7XYFIVEWTQeqDu3imHZvjNmczMSIQ==
X-Received: by 2002:a05:6a00:13a5:b0:525:1da8:4af4 with SMTP id t37-20020a056a0013a500b005251da84af4mr6396324pfg.43.1656447000327;
        Tue, 28 Jun 2022 13:10:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j15-20020a056a00234f00b0052542cbff9dsm10310276pfj.99.2022.06.28.13.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 13:09:59 -0700 (PDT)
Message-ID: <7d561941-b6e2-6a30-b951-8ef9df9c7e79@gmail.com>
Date:   Tue, 28 Jun 2022 13:09:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/8] watchdog: bcm7038_wdt: Remove #ifdef guards for PM
 related functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-2-paul@crapouillou.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220628193449.160585-2-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 12:34, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to
> handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards. Not using #ifdef guards means that the code is
> always compiled independently of any Kconfig option, and thanks to that
> bugs and regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Confirmed that the exact same code is generated before/after, thanks Paul!
-- 
Florian
