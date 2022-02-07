Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06E84AB2E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 01:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243041AbiBGALs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 19:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBGALp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 19:11:45 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7335C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 16:11:44 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id v67so15303419oie.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 16:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LOpru0mRYDPzEf1e5PXFsNinQx/DOMgkRXU9rqOn+UU=;
        b=gnYLlDs+q1FKVtQXDdmQLYX+vHgl4/IO0Cp4J3yynJYg0dCJgvoaQBmXhNIPVZu/fE
         cC1jd3msKXZ6Ny7zluaULuhBMd9ypB1q2C7pHqPJDnOHNVn1LIhX4XrPemdhWbbqhAyD
         ASUjtJtcrqINxHBjX152uykYm58im/VDBudYeo5m/vRYAKlo4kL9tVITuDIRyllVWSwr
         mkp2n4p096LNeCfXaqPfIkvFnkoL5Jxhe1TOeThZtwB6bN5UKjbHytqubzcb78OzbhuM
         tLDFKCYvEwnBa5v5ftJZR9bxX1MsrVghkBiFFHuQgEBaVdzy5IXOdjVkkQfhhkBeaod5
         jKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LOpru0mRYDPzEf1e5PXFsNinQx/DOMgkRXU9rqOn+UU=;
        b=ga5NGoTc3VveMDwl5MLI/m9FGhps1mDqel6wd9aXOvpMIQfHAv3ZfxNCTWz3tiS6r9
         7VmeYOCp+0YU1RPXceBnAa2cdvUS3iLMm+OsVypMkdCGby4xCrlX8Kd8KnzqtvKtYbmu
         YZBD1RZPbpdIKvkWcdtqR+IfUrv+D4Y/gZXi/jKWEr0SWpHi5x07Uzw/lnVBg71twniu
         5fMdLudkGpL96DUWIoQEpclGAYZ6/pW5ndxuiIZA4kAW4rvSuI7RZWNgrFH5MtgXuudj
         oGoMD9nFZzX0AAiWK7YzuiQIoJ7D+Yt21WYmH3xj0blNKzvl1XE4orFSM54vhFPDLi4Z
         f29g==
X-Gm-Message-State: AOAM5313fkMKLD6kF0Kbjg6ZWYJVt3jELMvG6GSmeoCV4WP4z01X4cQe
        oKdB9kgzK/qjWfg/VRH1Qc4Y0+9fFmnZ8Q==
X-Google-Smtp-Source: ABdhPJxea03SPrfINfOlQDc7HNPmpxfzb5uf1ZU/POR0Gs/4RxcRcU6r8s3/aNCr38iuKPQKDilnpQ==
X-Received: by 2002:aca:3106:: with SMTP id x6mr4230348oix.174.1644192703927;
        Sun, 06 Feb 2022 16:11:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i1sm326473ood.32.2022.02.06.16.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 16:11:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Feb 2022 16:11:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.17-rc3
Message-ID: <20220207001141.GA1833089@roeck-us.net>
References: <CAHk-=wiKr3q0ABWL0me+ugjN87zBOFXnBi43=-rBu7+WDKwQVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKr3q0ABWL0me+ugjN87zBOFXnBi43=-rBu7+WDKwQVA@mail.gmail.com>
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

On Sun, Feb 06, 2022 at 12:40:28PM -0800, Linus Torvalds wrote:
> Things look fairly normal so far, with a pretty average number of
> commits for an rc3 release.
> 
> The diffstat shows that we've had more filesystem activity than is
> perhaps usual, The filesystem activity is all over, ranging from cifs
> re-introducing fscache support after the rewrite, to vfs-level error
> handling fixes, to just regular filesystem-specific fixes (btrfs,
> ext4, xfs), to some unicode Kconfig cleanups. So it's not one single
> thing, it just happened that we had more filesystem stuff than is
> perhaps common at this point.
> 
> That said, driver fixes (networking, gpu, sound, pin control, platform
> drivers,scsi etc) still dominate. On the driver side, some reverts to
> re-enable hw-accelerated scrolling for legacy fbdev devices perhaps
> stand out.
> 
> Outside of that, it's a mixed bag of random stuff - the usual arch
> updates (kvm noise stands out), generic networking and core kernel,
> and tooling (selftests and perf). And some documentation fixes.
> 
> Shortlog appended for more details, but I don't see anything that
> makes me worried for the 5.17 release. Knock wood.
> 
> Please go test,
> 

Build results:
	total: 155 pass: 154 fail: 1
Failed builds:
	powerpc:skiroot_defconfig
Qemu test results:
	total: 488 pass: 487 fail: 1
Failed tests:
	arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs

---

Building powerpc:skiroot_defconfig ... failed
--------------
arch/powerpc/kernel/stacktrace.c: In function 'handle_backtrace_ipi':
arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of function 'nmi_cpu_backtrace'

Introduced with commit 1614b2b11fab29 ("arch: Make ARCH_STACKWALK
independent of STACKTRACE"). Discussed at
https://lore.kernel.org/lkml/YeE2VWwHO50gFw9M@hirez.programming.kicks-ass.net/T/
No fix posted as far as I know, and no recent progress.

---
Building arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs ... running ........R.... failed (no root file system)

Introduced with 8df89a7cbc63 ("pinctrl-sunxi: don't call
pinctrl_gpio_direction()"). Fix posted at
https://patchwork.kernel.org/project/linux-media/patch/0f536cd8-01db-5d16-2cec-ec6d19409a49@xs4all.nl/

---

Unrelated to testing with my testbed, the following problem was found
while merging stable releases into Chrome OS.

Upstream commit 9de2b9286a6d ("ASoC: mediatek: Check for error clk pointer")
introduces a regression affecting all (or at least many many) Mediatek
systems using the mtk-scpsys driver. Revert and explanation posted at
https://lore.kernel.org/lkml/20220205014755.699603-1-linux@roeck-us.net/.

Guenter
