Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3EC4AE576
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiBHXdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiBHXdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:33:20 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA57C061576;
        Tue,  8 Feb 2022 15:33:20 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p63so1032558iod.11;
        Tue, 08 Feb 2022 15:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXvAMfTXEgJYMeJO/Tzvz+YQNaqSUZ+oxlMGctoDxCU=;
        b=d7lWWs4xju1UA+H0DYJ4BECcJarJwtvs3ajF8h4fEcMbCfCozaJ3t1gGWpz4N81cX7
         9uHFkAewCLPXW+7BBCw/ItQ3xARjfq71TrFkRb/Uh/+Kp8qPJVvqUlFExtkUWXCl24Ks
         0dkH7M4VDFah4LWKhM/ktMIGNGfUR0SOK0Z7CxMXxQOAZN16OCKfaiBNYHkPNsm6wUBC
         vQocxuJ9AutjMimyR/UHlMk27a0hqIHIIjrlATZnbwiM6DQ+Mliu7TpFsvgDqAxosrQD
         ew/Y69D8/AH3nQcp0Lb4/RwMVdZpZd6EsH2p3fCh0oF1RJTIQQtCL+D03yfQIxvOCQsW
         Ltrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXvAMfTXEgJYMeJO/Tzvz+YQNaqSUZ+oxlMGctoDxCU=;
        b=oIO1kd5HOhEoJCh0T0djfxRQZYKCoxcXEUqTlbPKCUQjoOiFfU5FrvW3GdkUJhPU5q
         ZXqtOhqD2wbaCCt/+nNlaof/bNJTA13HkhTa2aylN9qPnEGD0AKweMOmmQP899kV6G7m
         9ivxZ0bfb93cD0WuAFX4R/TQb1KOve+gQ6jWfSc7B/dyrluNf6eloplD1qk3NnTkATi1
         tCB11Vl0P+Rjg6Fxyzq8BcgmZZQQZAu2UzF/wvrZMD1NT5PGDTyQRfnIeRv+dGCFt+t8
         E+4/DiTrkXoRUH6+6Vko+MiYP3gEwyC9lFSmJxccJgH+vedA1ZIofelmZcO3mou3QohB
         2rVQ==
X-Gm-Message-State: AOAM531ORbUqGOVDPvYOik5xSTiO64vtVBIREkIg4WAKwB1C39QHNmDO
        dOIpVtQNlwyn3SGToOkfQIT/2tqXnn9hEuArVZs=
X-Google-Smtp-Source: ABdhPJxCyWbgZyjiypFhW2jm1bsfm/W+HCdtvL2kNPU4/iSckqCEimjnpHM4fEJ36t1gQgneCo7Op3wWNwtwaZj2ROc=
X-Received: by 2002:a02:b0d8:: with SMTP id w24mr3296125jah.241.1644363199474;
 Tue, 08 Feb 2022 15:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20220208094244.1106312-1-eugene.shalygin@gmail.com> <20220208233048.GA2970774@roeck-us.net>
In-Reply-To: <20220208233048.GA2970774@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 9 Feb 2022 00:33:08 +0100
Message-ID: <CAB95QASONk_s-xO0bz7P+tq_9-KOfA2y41+mnQg9suN4LFd4CA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add CPU core voltage
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
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

On Wed, 9 Feb 2022 at 00:30, Guenter Roeck <linux@roeck-us.net> wrote:
> > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Tested-by: Denis Pauk <pauk.denis@gmail.com>
> Applied to hwmon-next.

I thank you all!

Best regards,
Eugene
