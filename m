Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDB746D958
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhLHRRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbhLHRRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:17:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAB0C061746;
        Wed,  8 Dec 2021 09:13:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64C7DB821DC;
        Wed,  8 Dec 2021 17:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ACAC00446;
        Wed,  8 Dec 2021 17:13:41 +0000 (UTC)
Date:   Wed, 8 Dec 2021 17:13:38 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: Re: [PATCH v16 00/11] support reserving crashkernel above 4G on
 arm64 kdump
Message-ID: <YbDnwol20HrRl4uL@arm.com>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123124646.1995-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 08:46:35PM +0800, Zhen Lei wrote:
> Chen Zhou (10):
>   x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
>   x86: kdump: make the lower bound of crash kernel reservation
>     consistent
>   x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
>     reserve_crashkernel()
>   x86: kdump: move xen_pv_domain() check and insert_resource() to
>     setup_arch()
>   x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
>   arm64: kdump: introduce some macros for crash kernel reservation
>   arm64: kdump: reimplement crashkernel=X
>   x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL config
>   of: fdt: Add memory for devices by DT property
>     "linux,usable-memory-range"
>   kdump: update Documentation about crashkernel
> 
> Zhen Lei (1):
>   of: fdt: Aggregate the processing of "linux,usable-memory-range"

Apart from a minor comment I made on patch 8 and some comments from Rob
that need addressing, the rest looks fine to me.

Ingo stated in the past that he's happy to ack the x86 changes as long
as there's no functional change (and that's the case AFAICT). Ingo, does
your conditional ack still stand?

In terms of merging, I'm happy to take it all through the arm64 tree
with acks from the x86 maintainers. Alternatively, with the change I
mentioned for patch 8, the first 5 patches could be queued via the tip
tree on a stable branch and I can base the rest of the arm64 on top.

Thomas, Ingo, Peter, any preference?

Thanks.

-- 
Catalin
