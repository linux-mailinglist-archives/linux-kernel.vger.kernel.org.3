Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF050E3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbiDYPHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiDYPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:07:04 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58082120A2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:03:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 12so17358176oix.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8G4/8iMnjJuOlBkbsr3GuWjcrP2t2EtWHZyD3A4fE/A=;
        b=DGXPvVKKadnRlgKp3HL9QCeWJhYXLKkKJrj1YJ1VdYfefgHPAuo8dK7s31xvyq2kwi
         vrkfbKvlfk9GLe7f5H4wChjJ+HQXl3PkysQR8nJSRCaUvsXonRGtOdebq9YKDj3UzOtk
         8hJ1nY1xtsqbCwXIYxcA5cPAiW3zY6DTsBpCfIf221YY25JDeZDh1DA2D1wp5sH9jTLO
         vzL5330zPkSpgxZFQ91tquYjKzCHoHygH3lomqJApW3ShehIDo/dHIR4Z4wT93EJC4hD
         +UWyAUUzTKz+hCZJBJa7oARaJXHnu3h9ACfVvIF55q6SWo3v6d7z5wOWNW7v/3nUtYos
         M9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8G4/8iMnjJuOlBkbsr3GuWjcrP2t2EtWHZyD3A4fE/A=;
        b=A6gnJVKPJji4SUWs0nzCmouyLBqA2bhCbg2qxcIYrI+Gb5ISovuoLMySn/LQoO7GjF
         l9L/IfNQ7qiNSmJfXr3JH35m7abRQ45vgxo36zpuTU1f6Wmxl74SLVDN0Lzlsz3k72IJ
         kT1V2p1GTyikF2cQ6llD1XbOKCaR7QchNaE3Hxr5+rp8Oi4JKEcj2kViQb+JxHWWzwOg
         +dmoWhcqVJNFJt48mCkZBd/ZSiP1c5esASiEv2n/8JGHdWpR30PYApXJCYyfD7aWLBlt
         JC3qOYzNL34Kn0w28dVlWGf8BMQcQXt2W/nliekePuc+7MyTKvFNV4AEPv4uSNtHAUMI
         ilHg==
X-Gm-Message-State: AOAM530pubyn5Uo027KwUbj76Vk9PVx2dozHgLz3AhHaGTxe1OUhyzMQ
        pc5Qq+rySEUPJ1DxqJyo8uPDJv7cidc=
X-Google-Smtp-Source: ABdhPJzQ/OlwCGCQgdnmYMHuXegiX/UWMe3zzPtpD4URIZDo0YGj+7azYcf6fM7pIDZSvZr2FLMxtQ==
X-Received: by 2002:a05:6808:1926:b0:323:3c4:947d with SMTP id bf38-20020a056808192600b0032303c4947dmr9969024oib.103.1650899038658;
        Mon, 25 Apr 2022 08:03:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000d277c48d18sm3529887oao.3.2022.04.25.08.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:03:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Apr 2022 08:03:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.18-rc4
Message-ID: <20220425150356.GA4138752@roeck-us.net>
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 03:22:59PM -0700, Linus Torvalds wrote:
> Fairly slow and calm week - which makes me just suspect that the other
> shoe will drop at some point.
> 
> But maybe things are just going really well this release. It's bound
> to happen _occasionally_, after all.
> 
> It's not only a fairly small set of commits, the diffstat is pretty
> small and flat too. The biggest single patch is literally killing off
> a zombie file that had already been deleted - well, renamed, really -
> once, but it didn't know to stay dead, and was resurrected by a merge
> mistake.
> 
> The changes are sprinkled all over, they just aren't all that big:
> arch updates (sound being the bulk of it, but "bulk" really is fairly
> misleading), some driver updates, a couple of filesystem fixes, memory
> management, networking, and some tooling (mainly a couple of
> selftests).
> 

Build results:
	total: 151 pass: 131 fail: 20
Failed builds:
	arm:allnoconfig
	arm:tinyconfig
	h8300:allnoconfig
	h8300:tinyconfig
	h8300:edosk2674_defconfig
	h8300:h8300h-sim_defconfig
	h8300:h8s-sim_defconfig
	m68k:allnoconfig
	m68k:tinyconfig
	m68k_nommu:m5272c3_defconfig
	m68k_nommu:m5307c3_defconfig
	m68k_nommu:m5249evb_defconfig
	m68k_nommu:m5407c3_defconfig
	riscv32:allnoconfig
	riscv32:tinyconfig
	riscv:allnoconfig
	riscv:tinyconfig
	s390:allmodconfig
	sh:allnoconfig
	sh:tinyconfig
Qemu test results:
	total: 489 pass: 486 fail: 3
Failed tests:
	arm:mps2-an385:mps2_defconfig:mps2-an385:initrd
	mcf5208evb:m5208:m5208evb_defconfig:initrd
	xtensa:de212:kc705-nommu:nommu_kc705_defconfig

As far as I can see this is all due to

error: page_alloc.c: undefined reference to `vmalloc_huge'

as already reported.

Guenter
