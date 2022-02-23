Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4BE4C1456
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiBWNj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiBWNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:39:55 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7584EAC047;
        Wed, 23 Feb 2022 05:39:27 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id e5so3145814vsg.12;
        Wed, 23 Feb 2022 05:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BG1GJjMEJebhLWZR3fn6x4GIgbQRNOTDQbzziFzPgro=;
        b=BZyPmjcyHfZtsJXTnZimqVTwz1zZaD7TDbweWKxVyg+9bUzTAP+GR4PVXCY0lDHcOF
         F4HilB3O0HRwIv/G6thuHFH9kVr/lLm2WpJlCfRnTfi1bT9hn7gKaSiCFqOI81PT1+wI
         Jc3xrHSIB6CvTSkAvM8g1De7pK0SnVZlnSdPB/7izvxZJ9EuXKeh74DHPds1TVSZZZGL
         9U7syxRp4GLk5h387m3R+STyIQqKp4PV6+07aGiYEytHBEDEQ5LVNrUdEQz1dwTG1G5b
         opz6PNAUbZiJoWet5OAXdlbExtn1aNXVaL1vFTvIuv3wOOqe7yIKiBOiupL2uA7vSGLG
         y/tA==
X-Gm-Message-State: AOAM530mABVHM8nwf7AafCiaBeqGyC/yhuZ+roP/DLdQ1qehBgpuipD+
        US5n/FWlGpQAQurrYKJKZrFzFjfP9FFiKg==
X-Google-Smtp-Source: ABdhPJz4JVYTFdlYSRIzMm2fjEX/5JuI8pzQGmzSdPHKR6Y7fJpTYfmJG6Vrtsp9fYgaZ912hpEPKg==
X-Received: by 2002:a05:6102:3ed4:b0:31b:3c20:c4f3 with SMTP id n20-20020a0561023ed400b0031b3c20c4f3mr11133743vsv.54.1645623566474;
        Wed, 23 Feb 2022 05:39:26 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id y22sm674226vsi.25.2022.02.23.05.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 05:39:26 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id q9so3206506vsg.2;
        Wed, 23 Feb 2022 05:39:26 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr12231813vsl.68.1645623565961; Wed, 23
 Feb 2022 05:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20220221095032.95054-1-jjhiblot@traphandler.com> <20220221095032.95054-4-jjhiblot@traphandler.com>
In-Reply-To: <20220221095032.95054-4-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 14:39:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUuwuJA4r8c7TC0p0Axr9ci-QC8HFieZrkEG+BGxPw8HQ@mail.gmail.com>
Message-ID: <CAMuHMdUuwuJA4r8c7TC0p0Axr9ci-QC8HFieZrkEG+BGxPw8HQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] ARM: dts: r9a06g032: Add the watchdog nodes
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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

On Mon, Feb 21, 2022 at 10:51 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> This SOC includes 2 watchdog controllers (one per A7 core).
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
