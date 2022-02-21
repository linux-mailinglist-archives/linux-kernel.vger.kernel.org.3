Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A884BD477
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbiBUDt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:49:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiBUDt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:49:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C7C61EAC7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 19:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645415343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hb0dx0H8touNMHxGlfdIWo0CdWNEhRBt6iaUhiuotgs=;
        b=J9FUb60W9nybdBb+XuqVf8tia5a3Eq5UC8TClfE8oxkCnXSg8Lhw2Ku2ZsvD3i3BMi4Pga
        jofbcxXIuzpN9ZMxy5ANjX769WDCtM0rgpXjmyhZGZVBnb5Ibb5YmrQZ1fORf4RcGIVta8
        eR4nWuUBf0tsi+AMal9g02f5Zhcl7w4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-ulf2aE0VPKO2tiC1rn67Tw-1; Sun, 20 Feb 2022 22:49:00 -0500
X-MC-Unique: ulf2aE0VPKO2tiC1rn67Tw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F221814243;
        Mon, 21 Feb 2022 03:48:56 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09DF0E71E;
        Mon, 21 Feb 2022 03:48:51 +0000 (UTC)
Date:   Mon, 21 Feb 2022 11:48:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
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
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v20 5/5] kdump: update Documentation about crashkernel
Message-ID: <YhMLoUvxteZVVwqQ@MiWiFi-R3L-srv>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124084708.683-6-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/22 at 04:47pm, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> For arm64, the behavior of crashkernel=X has been changed, which
> tries low allocation in DMA zone and fall back to high allocation
> if it fails.
> 
> We can also use "crashkernel=X,high" to select a high region above
> DMA zone, which also tries to allocate at least 256M low memory in
> DMA zone automatically and "crashkernel=Y,low" can be used to allocate
> specified size low memory.
> 
> So update the Documentation.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst       | 11 +++++++++--
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index cb30ca3df27c9b2..d4c287044be0c70 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -361,8 +361,15 @@ Boot into System Kernel
>     kernel will automatically locate the crash kernel image within the
>     first 512MB of RAM if X is not given.
>  
> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> +   On arm64, use "crashkernel=X" to try low allocation in DMA zone and
> +   fall back to high allocation if it fails.
> +   We can also use "crashkernel=X,high" to select a high region above
> +   DMA zone, which also tries to allocate at least 256M low memory in
> +   DMA zone automatically.
> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
> +   Use "crashkernel=Y@X" if you really have to reserve memory from
> +   specified start address X. Note that the start address of the kernel,
> +   X if explicitly specified, must be aligned to 2MiB (0x200000).

Hmm, we may not need the details related to crashkernel,high|low in this
section. This just gives examples of basic configation for each ARCH.
The detailed configuration of all crashkernel setting can be found in
"crashkernel syntax" section, I don't think arm64 is so special to need
a specific one.

>  
>  Load the Dump-capture Kernel
>  ============================
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9ed9..65780c2ca830be0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -792,6 +792,9 @@
>  			[KNL, X86-64] Select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
> +			[KNL, ARM64] Try low allocation in DMA zone and fall back
> +			to high allocation if it fails when '@offset' hasn't been
> +			specified.
>  			See Documentation/admin-guide/kdump/kdump.rst for further details.

How about add ARM64 like below to avoid redundant words?
  			[KNL, X86-64, ARM64] Select a region under 4G first, and
  			fall back to reserve region above 4G when '@offset'
  			hasn't been specified.

>  
>  	crashkernel=range1:size1[,range2:size2,...][@offset]
> @@ -808,6 +811,8 @@
>  			Otherwise memory region will be allocated below 4G, if
>  			available.
>  			It will be ignored if crashkernel=X is specified.
> +			[KNL, ARM64] range in high memory.
> +			Allow kernel to allocate physical memory region from top.

Ditto, please don't add redundent words if it's similar to x86_64
handling.

>  	crashkernel=size[KMG],low
>  			[KNL, X86-64] range under 4G. When crashkernel=X,high
>  			is passed, kernel could allocate physical memory region
> @@ -816,13 +821,15 @@
>  			requires at least 64M+32K low memory, also enough extra
>  			low memory is needed to make sure DMA buffers for 32-bit
>  			devices won't run out. Kernel would try to allocate at
> -			at least 256M below 4G automatically.
> +			least 256M below 4G automatically.
>  			This one let user to specify own low range under 4G
>  			for second kernel instead.
>  			0: to disable low allocation.
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
> -
> +			[KNL, ARM64] range in low memory.
> +			This one let user to specify a low range in DMA zone for
> +			crash dump kernel.

Ditto.

>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
>  
> -- 
> 2.25.1
> 

