Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260924AEC76
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiBIIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:32:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241563AbiBIIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:32:29 -0500
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66833C050CF0;
        Wed,  9 Feb 2022 00:32:24 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id m131so729900vkm.7;
        Wed, 09 Feb 2022 00:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oWGIhr7j5T0wmli3m35is4QqbH67LJ+yM8vH/Tq854=;
        b=jLMKhf4nqdRGLisWIQaJHX9LnNkfluKHor9kp8/y5O+WT2xV/6XsPbOwNi0W+MCC4A
         bp0TRegbynItzyTqj+OqUHHAUslQtGmeWCFL97bsaZRarM3blTN2HtWay3JuxpJ3r6WU
         q7rSWLtGxHxExhvNRKk18+D61UQFl6Y+HwBY6MvyZnKvjRCmrFok373DBKbgE1iJDgj6
         JsIC5v7a5kykIWQdLcHNeSxAzQM4hwzYBhORS16rFIF0C0p1QJ8+oqXrzUN+DAF1nMmH
         ESL1PX4b8+EQNv0S3hUwxveT0cLFyuAb1nF/UsRBvHubmso+Dxjh5H+jopwU2P2LcvSh
         tVbg==
X-Gm-Message-State: AOAM5330yd7hRx95t3scXXump5VkRt2J4kCp3KdIW51MH1EjEyp2vdLE
        tBicM2905S+Tzrtwm9L3542dugYC4kFZ+Q==
X-Google-Smtp-Source: ABdhPJxI6ztoHaKCr6at9s7gMeLfVX7pVAf7ed0ssxLruqp7IAJauLk/Rflssgd3TsR5PQHaErKqIA==
X-Received: by 2002:a05:6122:20a0:: with SMTP id i32mr397487vkd.36.1644395537029;
        Wed, 09 Feb 2022 00:32:17 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id q22sm3048215vsj.23.2022.02.09.00.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 00:32:16 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id r20so1806643vsn.0;
        Wed, 09 Feb 2022 00:32:16 -0800 (PST)
X-Received: by 2002:a67:ec0c:: with SMTP id d12mr296321vso.77.1644395536427;
 Wed, 09 Feb 2022 00:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20220208183511.2925304-1-jjhiblot@traphandler.com> <20220208183511.2925304-3-jjhiblot@traphandler.com>
In-Reply-To: <20220208183511.2925304-3-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 09:32:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU80BbODE9CV2r2TuDTbpT9FGNg_ZXENoFsAHQDJ1OozQ@mail.gmail.com>
Message-ID: <CAMuHMdU80BbODE9CV2r2TuDTbpT9FGNg_ZXENoFsAHQDJ1OozQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: watchdog: renesas,wdt: Add support
 for RZ/N1
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Feb 8, 2022 at 7:35 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> Describe the WDT hardware in the RZ/N1 series.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
