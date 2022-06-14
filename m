Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69854B74F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbiFNRDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344298AbiFNRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:03:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66730101FB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:03:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so8258163plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Yix9ys5uzW2uR5pDvNILio6kCQq7ulTL6eO/1R4l4Y=;
        b=PF2ZLmKQIHN6bu5PTkzbBuPu/UDRH6AJFgYW0tIvw+xb8ljuR+1KtBHYWPGqhOi7VW
         TrmoU1mOayL9t1HzOKave2vZ7JmuUeoLqquOpF0YeobZYeaEsRaMHJoZlnLMVA288XgH
         kHWn16JgR/r2rLc8SGdjrfpxDASHM2JetNOLxVWnOl8auGtEK4iCGgNF6mLokqnFW4Xm
         wrzfdM4Ht1aYTBiRkqDXKrdU3oAuDbQXj/OkvF8JIeB8XAbjaBbTdf2avjjzriVmNc7J
         B43i4iKS2+q3GQOk6dAuT4/Y3chPaVwJNoy/2+LXWwmafmW0Cr66l3nSNujiTnTEhPG5
         2ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/Yix9ys5uzW2uR5pDvNILio6kCQq7ulTL6eO/1R4l4Y=;
        b=ciJ4G7W+Qumx0i4S/a+RsXwiZXaMhK+IV5BMDCVr1Bc+UHKsJm0oABdU6YqBaxRHJi
         WlY1Wj8me5Ys7KEDRYYWihYnAw6wcsLD4thpgcTjdW3CINuAqC4DIlmxlZ99vlyVliui
         Lc5WG4N5EEoxMDBcOplQl+B4ypCqU0ezqLigHl2X1g1QuPNeEaJ+6ygoaP9f7Qwe0oIU
         6i87cDv61jRnboKmvzSj+reZzebcde+0yrnxW+xJf0P9RmoTtCFqYYQvunSnms86eksL
         yWM5bP6XHJhx3/1s39WXu2+Muz/55FcXdPKj8LfCzVStLcT8as163mIQ1+u+mkiUigWP
         tong==
X-Gm-Message-State: AJIora+oOI+TGZxFbPP1G0m5Rq3MKoxa8HrpReexrT8jQqZFjxBmWYRR
        gKCREE28OTR3wEfQuxPZsAXl17I3kB4=
X-Google-Smtp-Source: AGRyM1vrW8M39cb14qCD837Ko+qAwkpOlvdTqZw4+ekDbA3MDhXjrQeAi28NrfO9QOLxLo00Kq9ujA==
X-Received: by 2002:a17:90b:4a12:b0:1e8:4a16:ae28 with SMTP id kk18-20020a17090b4a1200b001e84a16ae28mr5564999pjb.1.1655226198854;
        Tue, 14 Jun 2022 10:03:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e21200b0015e8d4eb2ddsm7456762plb.295.2022.06.14.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:03:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 14 Jun 2022 10:03:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jchao Sun <sunjunchao2870@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: Linux 5.19-rc2
Message-ID: <20220614170316.GA3690098@roeck-us.net>
References: <CAHk-=wiLDbZ9ch9vSLxrYBdr-bBujr5sehH_HszWzSah54UiQw@mail.gmail.com>
 <20220613154640.GA3881687@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613154640.GA3881687@roeck-us.net>
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

On Mon, Jun 13, 2022 at 08:46:42AM -0700, Guenter Roeck wrote:
> 
> There are also various UAF and "spinlock bad magic" BUG/WARNING logs in arm
> boot tests. I don't know if those are new or if I just see them now because
> I enabled KFENCE. Here is an (incomplete) sample.
> 
> [    0.430290] printk: console [ramoops-1] printing thread started
> [    0.436219] BUG: spinlock bad magic on CPU#0, kdevtmpfs/23
> [    0.436250]  lock: noop_backing_dev_info+0x6c/0x3b0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.436808] CPU: 0 PID: 23 Comm: kdevtmpfs Not tainted 5.19.0-rc2 #1
> 

This is caused by commit 10e14073107dd0 ("writeback: Fix inode->i_io_list
not be protected by inode->i_lock error"). Reverting this commit fixes
the problem. Here is a complete backtrace:

BUG: spinlock bad magic on CPU#0, kdevtmpfs/16
 lock: noop_backing_dev_info+0x6c/0x3b0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
CPU: 0 PID: 16 Comm: kdevtmpfs Not tainted 5.19.0-rc2-00001-g8bd0807eb95c #1
Hardware name: ARM RealView Machine (Device Tree Support)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x68/0x90
 dump_stack_lvl from do_raw_spin_lock+0xa8/0xf4
 do_raw_spin_lock from __mark_inode_dirty+0x1a4/0x664
 __mark_inode_dirty from simple_setattr+0x44/0x5c
 simple_setattr from notify_change+0x404/0x460
 notify_change from devtmpfsd+0x1ec/0x2b8
 devtmpfsd from kthread+0xe0/0x104
 kthread from ret_from_fork+0x14/0x24
Exception stack(0xe0851fb0 to 0xe0851ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000

Guenter
