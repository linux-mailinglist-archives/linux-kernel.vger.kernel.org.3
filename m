Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB27051E1D1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444935AbiEFXSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344728AbiEFXSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 198A6703E3
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651878903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fsjPSSDEheSxxSuL7Ltb8dQNk6VTQw2Y864IsSu4LBg=;
        b=cWJWSeWvzsH5BW5G6uyIL7+8eyqNdStUnmXtSSSNpums2kzhkled4GQRRPPUKZMh3Sm2P6
        DJTnBS1pOfa+21Afqz4xDfDqFItna2xZHCBnHPXmUYhkioeo1TfqY1bxA+VP7GXrn7Zm8i
        dZNIZ647dtXUfLfbF3DHjYd8coQ3yaM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-6e3mBSoQNiWUVALHVxPMfA-1; Fri, 06 May 2022 19:14:59 -0400
X-MC-Unique: 6e3mBSoQNiWUVALHVxPMfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BCC01C05199;
        Fri,  6 May 2022 23:14:58 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B7C97AD9;
        Fri,  6 May 2022 23:14:54 +0000 (UTC)
Date:   Sat, 7 May 2022 07:14:51 +0800
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
Subject: Re: [PATCH v24 6/6] docs: kdump: Update the crashkernel description
 for arm64
Message-ID: <20220506231451.GB122876@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-7-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506114402.365-7-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/22 at 07:44pm, Zhen Lei wrote:
> Now arm64 has added support for "crashkernel=X,high" and
> "crashkernel=Y,low". Unlike x86, crash low memory is not allocated if
> "crashkernel=Y,low" is not specified.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3f1cc5e317ed4a5..aa44c61114aa4b8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -808,7 +808,7 @@
>  			Documentation/admin-guide/kdump/kdump.rst for an example.
>  
>  	crashkernel=size[KMG],high
> -			[KNL, X86-64] range could be above 4G. Allow kernel
> +			[KNL, X86-64, ARM64] range could be above 4G. Allow kernel
>  			to allocate physical memory region from top, so could
>  			be above 4G if system have more than 4G ram installed.
>  			Otherwise memory region will be allocated below 4G, if
> @@ -821,7 +821,7 @@
>  			that require some amount of low memory, e.g. swiotlb
>  			requires at least 64M+32K low memory, also enough extra
>  			low memory is needed to make sure DMA buffers for 32-bit
> -			devices won't run out. Kernel would try to allocate at
> +			devices won't run out. Kernel would try to allocate
>  			at least 256M below 4G automatically.
>  			This one let user to specify own low range under 4G
>  			for second kernel instead.
> @@ -829,6 +829,11 @@
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
>  
> +			[KNL, ARM64] range in low memory.
> +			This one let user to specify a low range in DMA zone for
                                          ^ not needed,
                        Maybe Catalin can fix it when merging.

Other than this, LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> +			crash dump kernel.
> +			It will be ignored when crashkernel=X,high is not used.
> +
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
>  
> -- 
> 2.25.1
> 

