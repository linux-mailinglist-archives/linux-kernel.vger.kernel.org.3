Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C777A4D4693
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbiCJMPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiCJMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:15:27 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3DE1480E0;
        Thu, 10 Mar 2022 04:14:26 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id bm39so4230008qkb.0;
        Thu, 10 Mar 2022 04:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pC4y1hPLgVophxmsxiWtzmdOsu96CQ5ZYdDypoK4kI=;
        b=1s8mLD7JGMHe7IkNgzNaXsFyMys9AMnG4GzIE11XksZjeVO4ZLI4gYYO34C2Vczarl
         yXHchterCiSgxmoHuUvTx63p3s38m8QQ/xxQCstfYBaV0+TmCzsfWWyCl5679j9fY95T
         ONovh9FwMqsSUvRj7QU5VMRKN1AFiczT3UJsF1qgbRfYmdu25907IbvFWvb+1j3YJHKI
         dt7Qa6V644x+CDoM+0HChFhtAI5f1JzmC6XXNTeValeW6ozosfT+Tpiw8sLMheV/RIBn
         DQs5UJ5UzSWWZxTWH8Rk/9CONQ5dA7lHI7z3pKYXV1vIvY8dn6g+b8yo+VygvLhERsri
         HzWA==
X-Gm-Message-State: AOAM530+XsaU5PAI//c/PRywS5XTTg2i53kPNPAM9y3uKvSjkjKWyYTF
        wsnmKr0sCg/7q+9Rh/ZRMHpYIrA89ZRvsQ==
X-Google-Smtp-Source: ABdhPJxI0nN88b9HdfF4S3g126Cuh8swfhM0l/NM/jk7Bxut01RAe/ypd4mhGaF/0Fbz2IDAi5YzIw==
X-Received: by 2002:ae9:e803:0:b0:67b:14c8:8481 with SMTP id a3-20020ae9e803000000b0067b14c88481mr2735951qkg.58.1646914465854;
        Thu, 10 Mar 2022 04:14:25 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id bm21-20020a05620a199500b0067d5e6c7bd8sm383784qkb.56.2022.03.10.04.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:14:25 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2dc585dbb02so54931727b3.13;
        Thu, 10 Mar 2022 04:14:25 -0800 (PST)
X-Received: by 2002:a0d:f1c7:0:b0:2db:d2bc:be11 with SMTP id
 a190-20020a0df1c7000000b002dbd2bcbe11mr3655602ywf.62.1646914464859; Thu, 10
 Mar 2022 04:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20220310090048.1933020-1-laurent@vivier.eu> <20220310090048.1933020-2-laurent@vivier.eu>
In-Reply-To: <20220310090048.1933020-2-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Mar 2022 13:14:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdxXuMrxeJ+RychgWgoq09PKOBdj0DC1LVj9qZ0ozHLw@mail.gmail.com>
Message-ID: <CAMuHMdVdxXuMrxeJ+RychgWgoq09PKOBdj0DC1LVj9qZ0ozHLw@mail.gmail.com>
Subject: Re: [PATCH v15 1/5] m68k: add asm/config.h
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:01 AM Laurent Vivier <laurent@vivier.eu> wrote:
> To avoid 'warning: no previous prototype for' error, declare all
> the parse_bootinfo and config functions prototypes into asm/config.h
> and include it in arch/m68k/kernel/setup_mm.c and arch/m68k/*/config.c
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Already queued in the m68k for-v5.18 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
