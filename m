Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8977D4E4184
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiCVOkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbiCVOj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:39:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392FF3EBAD;
        Tue, 22 Mar 2022 07:38:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j15so22566135eje.9;
        Tue, 22 Mar 2022 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juTN+xCvJKs7At6G2rfDGQXc8roG+98Pu4NXfG0liEY=;
        b=UNPjtPPobqU+6kwoxl8Yr6UoIF2gmVVB/EVeSQcuSERawxU1hpx2Zn7dcIEStUoh9e
         xzoBfvKXonP2oC9+zqZXZRVyH8EW5pq9vnAjwINj+bJRh/sT7lbiWhs/9XPZ4+rTfFQg
         ftRk8riiOUOLtrSD3t7LtLLKhi+VLsK42FlMYo8V88DcMSLacR6TnhL7bLWP1YqTgcgE
         rmcWCRjmnhUYCT87m250SjPRY4IaaSed2OlZQnOTE2RbDpHZMk4iXiXiTKRQZmbb2clQ
         r/ZQjdqMBNMZ6abAe36nP6BSxSelsjUU424GxKTw0pzU76ptvAe5p+q+tV0JE0xBQn+Z
         uXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juTN+xCvJKs7At6G2rfDGQXc8roG+98Pu4NXfG0liEY=;
        b=Awp4IKngIMQDhnqfNulmrlM4WMjGbJUmQkYJ667FFDw14vtid/LV3nC0OeGZLlVBoP
         GN9db8fh1XfjG1zQv8/v/ucdisL+Ut+bX8Hla9j97v8F6fRZ+5p4nF039Z+ZlCPdz8HE
         WtRTnByvySLvCkvvmV0L2/vGvELifGmDvNlt/neq7QYFLevH04Mme6hr0mk09zbbFZnA
         rUzsOq83GHKbXhxcDfMfw/DC6ERZ+j6pwPn0ewKfn4wy+MJadbEjf4sVpYzhcDBnFFxu
         kXqPUVCBHvQQbhUVsaoM15TucHp6SsTKLY+dvdwH7jx+Grw/6/rmpY1RIiG0QCsUS+0F
         bAMg==
X-Gm-Message-State: AOAM533TNdjkBfzEfyu5g0SeNcFrphAvXxdCb2AMMf5P0R8D7eGen7Cx
        irLNhYc2BlvYBGN559zlaHAMmm685gVm9ZPavII=
X-Google-Smtp-Source: ABdhPJyog+twb2gWvEakKIAvibAUkfxZkO5NYS7lvcFmO3Mq9gyCT9G80cHFPYqfbA5HQu1nJb+z1pM0BTsCAvkgiQ8=
X-Received: by 2002:a17:907:162a:b0:6db:b0e8:9721 with SMTP id
 hb42-20020a170907162a00b006dbb0e89721mr25897711ejc.579.1647959903067; Tue, 22
 Mar 2022 07:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220310150905.1.Ie0a005d7a763d501e03b7abe8ee968ca99d23282@changeid>
In-Reply-To: <20220310150905.1.Ie0a005d7a763d501e03b7abe8ee968ca99d23282@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Mar 2022 16:37:13 +0200
Message-ID: <CAHp75Vfbs6sPsrjwxNWLZQu=pEoar2K5sY=fX9a7KkOe=mwsZw@mail.gmail.com>
Subject: Re: [PATCH] gpio: Drop CONFIG_DEBUG_GPIO
To:     Brian Norris <briannorris@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 4:55 AM Brian Norris <briannorris@chromium.org> wrote:

...

> Description: it says nothing about enabling extra printk()s. But -DDEBUG
> does just that; it turns on every dev_dbg()/pr_debug() that would
> otherwise be silent.

Which is what some and I are using a lot during development.

...

> -ccflags-$(CONFIG_DEBUG_GPIO)   += -DDEBUG
> -

NAK to this change.

I'm not against enabling might_sleep() unconditionally.

-- 
With Best Regards,
Andy Shevchenko
