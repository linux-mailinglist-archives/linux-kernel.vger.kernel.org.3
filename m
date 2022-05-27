Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091315366E2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353821AbiE0SWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiE0SWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:22:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298C213CA2F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 906BC61E6B
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 18:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E6BC385B8;
        Fri, 27 May 2022 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653675752;
        bh=UVSKD2w56mlgEfl0ZkR/dT7q4SzsY8P7MtcC6hyVt4I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=FBMFjtrTweZvKQFVAxphG1CDiAY+UMSzNV94KtF/E3dlHO1gF7YQRgC/pyOB/2MpA
         39zYOT5gwiktxPhHhhFV8TPnU5zVpdSvvGimJHs3Z2uYMQvsU02MqD53OCLr9U+5gc
         Iot2xVFpU4tjBiEJoirx8TITsWTS+PhdKKen+NDOu84BQvWK1w0kU1VgbJmO7vDte5
         Tev+i4n9scPLMjMyCDZ/9Q+My1Q6//r25InI3VHuSEgW/NvE44FKbhn+5ovtvvvIkj
         sHUx+twY46NE6DLb/vR1DnJaqf0b2ZkiUKylQbogUog1uxQE39kwMKgRuNqVzRIqg1
         xBci/c+3xeXFQ==
Date:   Fri, 27 May 2022 11:22:30 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [PATCH] MAINTAINERS: Update Xen maintainership
In-Reply-To: <1653674225-10447-1-git-send-email-boris.ostrovsky@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2205271122230.1905099@ubuntu-linux-20-04-desktop>
References: <1653674225-10447-1-git-send-email-boris.ostrovsky@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022, Boris Ostrovsky wrote:
> Due to time constraints I am stepping down as maintainter. I will stay
> as reviewer for x86 code (for which create a separate category).
> 
> Stefano is now maintainer for Xen hypervisor interface and Oleksandr has
> graciously agreed to become a reviewer.
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  MAINTAINERS | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6d879cb0afd..b879c4e6750e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21549,23 +21549,29 @@ F:	arch/arm64/include/asm/xen/
>  F:	arch/arm64/xen/
>  
>  XEN HYPERVISOR INTERFACE
> -M:	Boris Ostrovsky <boris.ostrovsky@oracle.com>
>  M:	Juergen Gross <jgross@suse.com>
> -R:	Stefano Stabellini <sstabellini@kernel.org>
> +M:	Stefano Stabellini <sstabellini@kernel.org>
> +R:	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>  L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
>  F:	Documentation/ABI/stable/sysfs-hypervisor-xen
>  F:	Documentation/ABI/testing/sysfs-hypervisor-xen
> -F:	arch/x86/include/asm/pvclock-abi.h
> -F:	arch/x86/include/asm/xen/
> -F:	arch/x86/platform/pvh/
> -F:	arch/x86/xen/
>  F:	drivers/*/xen-*front.c
>  F:	drivers/xen/
>  F:	include/uapi/xen/
>  F:	include/xen/
>  
> +XEN HYPERVISOR X86
> +M:	Juergen Gross <jgross@suse.com>
> +R:	Boris Ostrovsky <boris.ostrovsky@oracle.com>
> +L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
> +S:	Supported
> +F:	arch/x86/include/asm/pvclock-abi.h
> +F:	arch/x86/include/asm/xen/
> +F:	arch/x86/platform/pvh/
> +F:	arch/x86/xen/
> +
>  XEN NETWORK BACKEND DRIVER
>  M:	Wei Liu <wei.liu@kernel.org>
>  M:	Paul Durrant <paul@xen.org>
> -- 
> 1.8.3.1
> 
