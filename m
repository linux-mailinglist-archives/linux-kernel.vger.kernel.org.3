Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811F24C0AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiBWDrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiBWDrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:47:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADB5B60CCD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645588014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IyrPqz1BsumJA1M6xQYUZkQ2C6LgRTDoH7fHGR94hxE=;
        b=cxpZWq685acJl3ZaPoZ3Fz9ND3AkPwcjC+7wzAXMBuI91meT0i/cxruyqh5mC/78C+dKbG
        G/sGCSG3aQnTDxTtPnt5KTC6QZvbByK+cd8Bhr61tHIsCPk7fGJ0W3cN/n4YI53mSE7FBz
        kB4xAptlb+DNvXbfbcoROf2hy7ICDWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-rFsA4Yg1Op6pT1x-pzdmWA-1; Tue, 22 Feb 2022 22:46:51 -0500
X-MC-Unique: rFsA4Yg1Op6pT1x-pzdmWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AD2480DE09;
        Wed, 23 Feb 2022 03:46:49 +0000 (UTC)
Received: from localhost (ovpn-14-1.pek2.redhat.com [10.72.14.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A87624ABA9;
        Wed, 23 Feb 2022 03:46:28 +0000 (UTC)
Date:   Wed, 23 Feb 2022 11:46:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 04/10] crash hp: prototype change for
 crash_prepare_elf64_headers
Message-ID: <YhWuElhbF4GslSfq@MiWiFi-R3L-srv>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-5-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209195706.51522-5-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/22 at 02:57pm, Eric DeVolder wrote:
> From within crash_prepare_elf64_headers() there is a need to
> reference the struct kimage hotplug members. As such, this
> change passes the struct kimage as a parameter to the
> crash_prepare_elf64_headers().

One more sentence can be added"

"This is preparation for later patch, no functionality change."

Otherwise, this patch looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 6 +++---
>  arch/powerpc/kexec/file_load_64.c      | 2 +-
>  arch/x86/kernel/crash.c                | 3 ++-
>  include/linux/kexec.h                  | 5 +++--
>  kernel/kexec_file.c                    | 4 ++--
>  5 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 59c648d51848..7dbafb42ecf2 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  	return kexec_image_post_load_cleanup_default(image);
>  }
>  
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
> +static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
>  {
>  	struct crash_mem *cmem;
>  	unsigned int nr_ranges;
> @@ -67,7 +67,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
>  
>  	if (!ret)
> -		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> +		ret =  crash_prepare_elf64_headers(image, cmem, true, addr, sz);
>  
>  	kfree(cmem);
>  	return ret;
> @@ -96,7 +96,7 @@ int load_other_segments(struct kimage *image,
>  
>  	/* load elf core header */
>  	if (image->type == KEXEC_TYPE_CRASH) {
> -		ret = prepare_elf_headers(&headers, &headers_sz);
> +		ret = prepare_elf_headers(image, &headers, &headers_sz);
>  		if (ret) {
>  			pr_err("Preparing elf core header failed\n");
>  			goto out_err;
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index b4981b651d9a..07da6bf1cf24 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -797,7 +797,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
>  		goto out;
>  
>  	/* Setup elfcorehdr segment */
> -	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
> +	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
>  	if (ret) {
>  		pr_err("Failed to prepare elf headers for the core\n");
>  		goto out;
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9730c88530fc..9db41cce8d97 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -265,7 +265,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>  		goto out;
>  
>  	/* By default prepare 64bit headers */
> -	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
> +	ret =  crash_prepare_elf64_headers(image, cmem,
> +				IS_ENABLED(CONFIG_X86_64), addr, sz);
>  
>  out:
>  	vfree(cmem);
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 13c238c2da48..b11d75a6b2bc 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -221,8 +221,9 @@ struct crash_mem {
>  extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mstart,
>  				   unsigned long long mend);
> -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> -				       void **addr, unsigned long *sz);
> +extern int crash_prepare_elf64_headers(struct kimage *image,
> +	struct crash_mem *mem, int kernel_map,
> +	void **addr, unsigned long *sz);
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  #ifdef CONFIG_KEXEC_ELF
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b..801d0d0a5012 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -1260,8 +1260,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  	return 0;
>  }
>  
> -int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> -			  void **addr, unsigned long *sz)
> +int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
> +	int kernel_map, void **addr, unsigned long *sz)
>  {
>  	Elf64_Ehdr *ehdr;
>  	Elf64_Phdr *phdr;
> -- 
> 2.27.0
> 

