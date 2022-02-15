Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6384B5F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiBOA1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:27:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiBOA1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:27:43 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F129118601;
        Mon, 14 Feb 2022 16:27:34 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so21252122ooq.10;
        Mon, 14 Feb 2022 16:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b5B+yrC0gIEdCLEK+c+3rXYNtE3GXLDu5+sXZ077SsU=;
        b=HkPyP2vLgaaQ9ig0Gr3XYjQoPl0M9HmZ3YpMS1h9M2XaOz1p2O75yyoH6vCLZAjhC9
         cNZCI2i+0NIdwQz/457Q9E0gujpBn7mjnK6Oty9pVWNhHHR3HZDWRVWk7kTgCTAjDwVQ
         UamSeJWPfcOZisdiNlu1Yk8y/S2hYYFJhyeoKGspUfmocH6NQEq9t4Ws9qI9WIB9pe6P
         RBWWV97fb5/XVyVMmZ/l+EKJwJMRXmOyTtHmrtuTdzDw2L33C0iP8DI4QbOhThawdXkK
         /QZ0FYur/W/uIPIMoBW6HHRth9o/twEZS2lILXgA0ndbMuVgdwBqRVJLh0fVBlIBngC+
         63LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b5B+yrC0gIEdCLEK+c+3rXYNtE3GXLDu5+sXZ077SsU=;
        b=a/5Os+d3dBb1uyz8ZH7VlOxujJvqHFzBYl+SBZ6pqygG+PrEHGWeOTsm3iEWwMvKa7
         e6JQ+pA4wNfXnW6/jzCExmg6Wjg7KnqpzgKLkOUjRqxdiYja+sYTXo4fjCpUR6fObc8s
         ciya+FqZxIObnl395bq60AMyiQDrNMRuArthqVhvxMSC5TIASr8T/1vip+ot4zY9pySA
         jSdaDg5nPz/7jgTgh2zdKDKUt9kvl0HnA//D7kzLJhT0d0qz3WCEUW5AsOvEzI3/MT3c
         FZKj7EOwEMtkipbj6lZgTmjGyDU+CLXfbk9E2p2PXo6/cJOy4dXyEHim5P65r5yuNdJz
         bL2A==
X-Gm-Message-State: AOAM5338dy/YYNzaEJj5HeP/h88549Cp4LfWiTFzVmePhX5rITXflND3
        7lmxpV5T4LzW14bYzQjkj6w=
X-Google-Smtp-Source: ABdhPJxEOf2WfIGCmAK2dc8BpfpvK0oIOCqxeRVtuIwP2iaCBUYc+bsRfQGdFLT8N+IwavzqziRUvQ==
X-Received: by 2002:a05:6870:4:: with SMTP id a4mr511568oaa.228.1644884853871;
        Mon, 14 Feb 2022 16:27:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p5sm13161323oou.39.2022.02.14.16.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 16:27:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Feb 2022 16:27:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Klein <michael@fossekall.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v2] ARM: dts: sun8i: Adjust power key nodes
Message-ID: <20220215002732.GA3215504@roeck-us.net>
References: <20211129165510.370717-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129165510.370717-1-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 29, 2021 at 05:55:10PM +0100, Jernej Skrabec wrote:
> Several H3 and one H2+ board have power key nodes, which are slightly
> off. Some are missing wakeup-source property and some have BTN_0 code
> assigned instead of KEY_POWER.
> 
> Adjust them, so they can function as intended by designer.
> 
> Co-developed-by: Michael Klein <michael@fossekall.de>
> Signed-off-by: Michael Klein <michael@fossekall.de>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

This patch results in the following traceback when rebooting an
orangepi-pc qemu emulation.

[   30.899594]
[   30.899685] ============================================
[   30.899757] WARNING: possible recursive locking detected
[   30.899938] 5.17.0-rc3-00394-gc849047c2473 #1 Not tainted
[   30.900055] --------------------------------------------
[   30.900124] init/307 is trying to acquire lock:
[   30.900246] c2dfe27c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0
[   30.900900]
[   30.900900] but task is already holding lock:
[   30.900974] c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0
[   30.901101]
[   30.901101] other info that might help us debug this:
[   30.901188]  Possible unsafe locking scenario:
[   30.901188]
[   30.901262]        CPU0
[   30.901301]        ----
[   30.901339]   lock(&irq_desc_lock_class);
[   30.901411]   lock(&irq_desc_lock_class);
[   30.901480]
[   30.901480]  *** DEADLOCK ***
[   30.901480]
[   30.901554]  May be due to missing lock nesting notation
[   30.901554]
[   30.901657] 4 locks held by init/307:
[   30.901724]  #0: c1f29f18 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x90/0x23c
[   30.901889]  #1: c20f7760 (&dev->mutex){....}-{3:3}, at: device_shutdown+0xf4/0x224
[   30.902016]  #2: c2e804d8 (&dev->mutex){....}-{3:3}, at: device_shutdown+0x104/0x224
[   30.902138]  #3: c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0
[   30.902281]
[   30.902281] stack backtrace:
[   30.902462] CPU: 0 PID: 307 Comm: init Not tainted 5.17.0-rc3-00394-gc849047c2473 #1
[   30.902572] Hardware name: Allwinner sun8i Family
[   30.902781]  unwind_backtrace from show_stack+0x10/0x14
[   30.902895]  show_stack from dump_stack_lvl+0x68/0x90
[   30.902970]  dump_stack_lvl from __lock_acquire+0x1680/0x31a0
[   30.903047]  __lock_acquire from lock_acquire+0x148/0x3dc
[   30.903118]  lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
[   30.903197]  _raw_spin_lock_irqsave from __irq_get_desc_lock+0x58/0xa0
[   30.903282]  __irq_get_desc_lock from irq_set_irq_wake+0x2c/0x19c
[   30.903366]  irq_set_irq_wake from irq_set_irq_wake+0x13c/0x19c
[   30.903442]  irq_set_irq_wake from gpio_keys_suspend+0x80/0x1a4
[   30.903523]  gpio_keys_suspend from gpio_keys_shutdown+0x10/0x2c
[   30.903603]  gpio_keys_shutdown from device_shutdown+0x180/0x224
[   30.903685]  device_shutdown from __do_sys_reboot+0x134/0x23c
[   30.903764]  __do_sys_reboot from ret_fast_syscall+0x0/0x1c
[   30.903894] Exception stack(0xc584ffa8 to 0xc584fff0)
[   30.904013] ffa0:                   01234567 000c623f fee1dead 28121969 01234567 00000000
[   30.904117] ffc0: 01234567 000c623f 00000001 00000058 000d85c0 00000000 00000000 00000000
[   30.904213] ffe0: 000d8298 be84ddf4 000918bc b6eb0edc
[   30.905189] reboot: Restarting system

The warning is no longer seen after reverting this patch.

The problem exists but is not seen in v5.17-rc4 because a bug in commit
8df89a7cbc63 ("pinctrl-sunxi: don't call pinctrl_gpio_direction()")
hides it. That problem is fixed with commit 3c5412cdec9f ("pinctrl-sunxi:
sunxi_pinctrl_gpio_direction_in/output: use correct offset") in linux-next,
and the traceback is seen there.

Guenter
