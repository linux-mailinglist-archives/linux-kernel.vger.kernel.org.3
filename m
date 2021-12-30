Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7C481B70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbhL3Kkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbhL3Kkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:40:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA60C061574;
        Thu, 30 Dec 2021 02:40:42 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF5641EC04FB;
        Thu, 30 Dec 2021 11:40:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640860836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hMCPTeDnIJ9H9jmkzRtiX1XZPABKFjQELYVZLBGOkB4=;
        b=aIY2V3d9y9BrUI1nNsTxU5QvqX4XueKqqpzBbQwO68S1IeZtvRneqZXH0DlSQI5B2vI4Ex
        hdYb7fth4mOeb4TfAX13SLZ0cnW9oAWs3VYRVOmhdXjzVQKFRgBoV3yjAbEemDB+6rOTUs
        92CdA3L1MP0CVaH82oAiJ1ypb8xz9OM=
Date:   Thu, 30 Dec 2021 11:40:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>
Subject: Re: [PATCH v19 01/13] kdump: add helper parse_crashkernel_high_low()
Message-ID: <Yc2MprJJsm7LagGc@zn.tnic>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-2-thunder.leizhen@huawei.com>
 <4878dda9-871d-228d-21ac-3ac7c8a84322@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4878dda9-871d-228d-21ac-3ac7c8a84322@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 06:14:59PM +0800, Leizhen (ThunderTown) wrote:
> 
> Hi, Dave, Baoquan, Borislav:
>   What do you think about the introduction of parse_crashkernel_high_low()? If everyone
> doesn't object, I'll bring it to the next version. But I'll make some adjustments to the
> patches, see below. If there's any objection, I still strongly recommend removing the
> parameters "system_ram" and "crash_base" of parse_crashkernel_{high,low}().
> 
> How about splitting __parse_crashkernel() into two parts? One for parsing
> "crashkernel=X[@offset]", another one for parsing "crashkernel=X,{high,low}" and other
> suffixes in the future. So the parameter requirements are clear at the lowest level.

First of all, please do not top post!

Now, I already explained to you what I'd like to see:

https://lore.kernel.org/r/Ycs3kpZD/vpoo1AX@zn.tnic

yet you still don't get it.

So let me make myself clear: in its current form, this is not really an
improvement so for all x86 changes:

NAKed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
