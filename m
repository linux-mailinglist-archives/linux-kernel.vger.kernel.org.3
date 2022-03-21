Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0694E25DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347057AbiCUMBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347058AbiCUMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97D5C35DFF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647863989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8SduSexr52RIvyqJ7K4vqt1DySM0qnqx8wYMGvEAVM=;
        b=Zur6uNfLrMIyPBs/RP3Kn69v9OmNHOLFuI4DnbxrYLUjbhxNRaPvICxtOVjStwV8B/+DzA
        RRqRoZRjm3xR5X5KVtqoG13i6ZP/qvjvI9jd9kN1nn/6uAYdHWgN/5pI5NBkU3ecd4Y7HT
        5zKmiylzyZysYV3fWK4Z6m8Tomy7RiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-JZO2FG2FObqXwYcXkrAyYA-1; Mon, 21 Mar 2022 07:59:46 -0400
X-MC-Unique: JZO2FG2FObqXwYcXkrAyYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73AA4811E7A;
        Mon, 21 Mar 2022 11:59:45 +0000 (UTC)
Received: from localhost (ovpn-13-106.pek2.redhat.com [10.72.13.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86B5840C1241;
        Mon, 21 Mar 2022 11:59:44 +0000 (UTC)
Date:   Mon, 21 Mar 2022 19:59:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v5 2/8] x86/crash hp: Introduce CRASH_HOTPLUG
 configuration options
Message-ID: <20220321115940.GA354864@MiWiFi-R3L-srv>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-3-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303162725.49640-3-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/22 at 11:27am, Eric DeVolder wrote:
> Support for CPU and memory hotplug for crash is controlled by the
> CRASH_HOTPLUG configuration option, introduced by this patch.
> 
> The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
> also introduced with this patch.

Maybe can rephrase it as:

x86/crash: Introduce new options to support cpu and memory hotplug of crash
 
CRASH_HOTPLUG is to enable cpu and memory hotplug of crash.

CRASH_HOTPLUG_ELFCOREHDR_SZ is used to Specify the maximum size of
the elfcorehdr buffer/segment.
 
This is a preparation for later usage.

Otherwise, this looks good to me.


> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9f5bd41bf660..37eb26563f07 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2061,6 +2061,32 @@ config CRASH_DUMP
>  	  (CONFIG_RELOCATABLE=y).
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
> +config CRASH_HOTPLUG
> +	bool "kernel updates of crash elfcorehdr"
> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
> +	help
> +	  Enable the kernel to update the crash elfcorehdr (which contains
> +	  the list of CPUs and memory regions) directly when hot plug/unplug
> +	  of CPUs or memory. Otherwise userspace must monitor these hot
> +	  plug/unplug change notifications via udev in order to
> +	  unload-then-reload the crash kernel so that the list of CPUs and
> +	  memory regions is kept up-to-date. Note that the udev CPU and
> +	  memory change notifications still occur (however, userspace is not
> +	  required to monitor for crash dump purposes).
> +
> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
> +	depends on CRASH_HOTPLUG
> +	int
> +	default 131072
> +	help
> +	  Specify the maximum size of the elfcorehdr buffer/segment.
> +	  The 128KiB default is sized so that it can accommodate 2048
> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
> +	  region of memory.
> +	  For example, this size can accommodate a machine with up to 1024
> +	  CPUs and up to 1024 memory regions, eg. as represented by the
> +	  'System RAM' entries in /proc/iomem.
> +
>  config KEXEC_JUMP
>  	bool "kexec jump"
>  	depends on KEXEC && HIBERNATION
> -- 
> 2.27.0
> 

