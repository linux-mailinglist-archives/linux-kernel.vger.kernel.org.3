Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAA353B239
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiFBDoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiFBDoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:44:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8114084A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 20:44:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso3812258pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 20:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=gVoZS2vzK4dR4Y6/3npxg/APivJZF2gUX/to47n1YCM=;
        b=Q44pl4PZC8gOSRYB6J0wGoC2a9zoIQKt3GhYfvNGdyNqMi1D28LpJHDXUCib4gwEjc
         uHYPnsmGF4OQWkOriCKFRuh+wwpork/HmVYvSZFObqIVYFcNme6V2lbNnDyY1RV19Q9a
         XcEsWsXVq7t4LcaDTbJ4gFcJYA6BWSvcldHcjhYeUtGk+/ANknZ4Ah+EDgmfsttlBZ+w
         ewej66JKui+QNQ5xzzWescXdSGIy0d3NgUYmn6eAKA35WkWT4yYojaX6eNAl9XHV5FYQ
         1lNWlrC9Cz8NOlXMlCYO4/t581jvyztxvBvvS61gxRNNdkWeHPCckqsN66LLP4Rxj0fK
         9FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gVoZS2vzK4dR4Y6/3npxg/APivJZF2gUX/to47n1YCM=;
        b=WFDKGVT+3zLPESKSY1GU9B+nv2UwVZGk+6b15DLMDnGNzKPG63Tg6qM8aD4mbdOmfZ
         Vu3r0sddhxQleYkTaf97wqhU9zpbrksWDn2BVhGw1b+LGqZ93kVikDZKa9Gpqi/SY1V0
         CE+HhhkQWY4cs6EBeVVglZcd6uhVGudjBxSXjRYO74a44NIVTvwSTx/F/RbWZ1BW5C6K
         xR2qZWaXdNSGitPRd9Y3ADFpdLoaZ4NgmGKOXPcSF7dzyEgQ0MX8ctdgxJIfK2QHXnqc
         zf4TY/MXxl7bO4E7TGsPXLQhGPLYwYe5wryn9fUcGAuUNCKllvoRyVY16M26Yud74TQO
         qgNQ==
X-Gm-Message-State: AOAM5302UNcEcNsYK4JFltTOXQxX1k/JYIU75QSLBVOArNTfM7w+5wRz
        ChOm7L6W9VDdIxBbyEkjZuVQTdZdso0Gag==
X-Google-Smtp-Source: ABdhPJyEM2/VwvlC2CQzIqSXaE9/L6LNxoxkGMuwk5y4slDj7Ce2IqnUVMNuNFwIjbCt4hFIkjlXTw==
X-Received: by 2002:a17:902:8203:b0:15f:4423:6e9c with SMTP id x3-20020a170902820300b0015f44236e9cmr2747281pln.25.1654141441419;
        Wed, 01 Jun 2022 20:44:01 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902820100b001618383483fsm2268587pln.224.2022.06.01.20.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 20:44:00 -0700 (PDT)
Date:   Wed, 01 Jun 2022 20:44:00 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 20:43:21 PDT (-0700)
Subject:     Re: arch/riscv: SV48 patch series questions
In-Reply-To: <83813d991f96428c95c6d681c16ae852@EXMBX161.cuchost.com>
CC:     alexandre.ghiti@canonical.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     leyfoon.tan@starfivetech.com
Message-ID: <mhng-055df44c-3feb-41ae-b8c0-ae3a6489dee1@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 02:37:34 PDT (-0700), leyfoon.tan@starfivetech.com wrote:
> Hi Palmer
>
> Alex's "Introduce sv48 support without relocatable kernel" patch series in [1] was partially merged to Linux v5.17. But there are 4 patches are not merged (Patch-10 to 13).
>
> May I know what is the plan for these patches? Will them merged to next v5.19 merging window? Or do you expect any changes for these patches or Alex needs resend with rebase to latest kernel version?

I just saw this as I was digging up Alex's old email to reply to, all 
but #13 are now on for-next.

> Note, we would like to use the Patch-13 in this series.

Is your use case a CPU errata?  If so I think we should just go ahead 
and add that errata via the existing errata mechanism.  If you've got 
some other use case, do you mind elaborating?  From that other thread it 
sounds like a command-line argument is the way to go for folks who want 
to turn this off more dynamically, but happy to hear if you've got 
something different in mind.

> Patches not merged:
> [v3,10/13] riscv: Improve virtual kernel memory layout dump
> [v3,11/13] Documentation: riscv: Add sv48 description to VM layout
> [v3,12/13] riscv: Initialize thread pointer before calling C functions
> [v3,13/13] riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN
>
> [1]: https://patchwork.kernel.org/project/linux-riscv/cover/20211206104657.433304-1-alexandre.ghiti@canonical.com/
>
> Thanks.
>
> Regards
> Ley Foon
