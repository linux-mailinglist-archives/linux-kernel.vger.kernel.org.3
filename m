Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABD44F68B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbiDFSTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbiDFSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40912112F;
        Wed,  6 Apr 2022 09:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C9F2617DC;
        Wed,  6 Apr 2022 16:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37344C385A5;
        Wed,  6 Apr 2022 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649264140;
        bh=EdN64zytqtRtf+0yxEZMWCmGr4dRXOvuVUDdm8D3KKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArvdI2qYUESktlzogGom7eVs8lJDuPaIvwDQVB2bIYTwsrbXtnXrTI4qrcyXDucsd
         wcbcgsIpzXHevHzmIirKjyAW4ZZ6/ibx4URSL3/H9Egrlvh4GAXzbt0qkKTB/I/r33
         TI4LPV1kVoAudV2AmT5vbAsipi5IDJswOyKlZ9pt9nHc9ScNiUJG9zu/YO1oXgia3O
         YOccywLHTggPGABUApUKX/Z1WuNYN6yj8GFGz204akWGZ1fXCujk2cNEzHQERPWRKF
         ZdtAnHillFYOtos6UJX4lK/h9j8oOBwp0lD1Jwe5KHKH9Eeoc7fn6qAenYQYDlYsbB
         gHEIZlcE4jg/Q==
Date:   Wed, 6 Apr 2022 09:55:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: Re: [tip: x86/build] x86/configs: Add x86 debugging Kconfig fragment
 plus docs
Message-ID: <Yk3GCnyA8rhy1Syj@thelio-3990X>
References: <20220331175728.299103A0@davehans-spike.ostc.intel.com>
 <164918891525.389.9920170532036101413.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164918891525.389.9920170532036101413.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 08:01:55PM -0000, tip-bot2 for Dave Hansen wrote:
> The following commit has been merged into the x86/build branch of tip:
> 
> Commit-ID:     9f61ccc85afb061f65dd8ede7b8d4845b2f2dfce
> Gitweb:        https://git.kernel.org/tip/9f61ccc85afb061f65dd8ede7b8d4845b2f2dfce
> Author:        Dave Hansen <dave.hansen@linux.intel.com>
> AuthorDate:    Thu, 31 Mar 2022 10:57:28 -07:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Tue, 05 Apr 2022 21:54:04 +02:00
> 
> x86/configs: Add x86 debugging Kconfig fragment plus docs
> 
> The kernel has a wide variety of debugging options to help catch
> and squash bugs.  However, new debugging is added all the time and
> the existing options can be hard to find.
> 
> Add a Kconfig fragment with the debugging options which tip
> maintainers expect to be used to test contributions.
> 
> This should make it easier for contributors to test their code and
> find issues before submission.
> 
>   [ bp: Add to "make help" output ]
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lore.kernel.org/r/20220331175728.299103A0@davehans-spike.ostc.intel.com
> ---
>  Documentation/process/maintainer-tip.rst | 14 ++++++++++++++
>  arch/x86/Makefile                        |  1 +
>  kernel/configs/x86_debug.config          | 18 ++++++++++++++++++
>  3 files changed, 33 insertions(+)
>  create mode 100644 kernel/configs/x86_debug.config
> 
> diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
> index c74f4a8..572a328 100644
> --- a/Documentation/process/maintainer-tip.rst
> +++ b/Documentation/process/maintainer-tip.rst
> @@ -437,6 +437,20 @@ in a private repository which allows interested people to easily pull the
>  series for testing. The usual way to offer this is a git URL in the cover
>  letter of the patch series.
>  
> +Testing
> +^^^^^^^
> +
> +Code should be tested before submitting to the tip maintainers.  Anything
> +other than minor changes should be built, booted and tested with
> +comprehensive (and heavyweight) kernel debugging options enabled.
> +
> +These debugging options can be found in kernel/configs/x86_debug.config
> +and can be added to an existing kernel config by running:
> +
> +	make x86_debug.config
> +
> +Some of these options are x86-specific and can be left out when testing
> +on other architectures.
>  
>  Coding style notes
>  ------------------
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 63d50f6..1abd7cc 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -313,5 +313,6 @@ define archhelp
>    echo  ''
>    echo  '  kvm_guest.config	- Enable Kconfig items for running this kernel as a KVM guest'
>    echo  '  xen.config		- Enable Kconfig items for running this kernel as a Xen guest'
> +  echo  '  x86_debug.config	- Enable tip tree debugging options for testing'
>  
>  endef
> diff --git a/kernel/configs/x86_debug.config b/kernel/configs/x86_debug.config
> new file mode 100644
> index 0000000..45498c0
> --- /dev/null
> +++ b/kernel/configs/x86_debug.config
> @@ -0,0 +1,18 @@
> +CONFIG_X86_DEBUG_FPU=y
> +CONFIG_LOCK_STAT=y
> +CONFIG_DEBUG_VM=y
> +CONFIG_DEBUG_VM_VMACACHE=y
> +CONFIG_DEBUG_VM_RB=y
> +CONFIG_DEBUG_SLAB=y
> +CONFIG_DEBUG_KMEMLEAK=y
> +CONFIG_DEBUG_PAGEALLOC=y
> +CONFIG_SLUB_DEBUG_ON=y
> +CONFIG_KMEMCHECK=y
> +CONFIG_DEBUG_OBJECTS=y
> +CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> +CONFIG_GCOV_KERNEL=y
> +CONFIG_LOCKDEP=y
> +CONFIG_PROVE_LOCKING=y
> +CONFIG_SCHEDSTATS=y
> +CONFIG_VMLINUX_VALIDATION=y
> +CONFIG_DEBUG_INFO=y

I am replying to this message versus the original patch because this
appears to be done during committing.

This "CONFIG_DEBUG_INFO=y" will not do anything, as the debug info
Kconfig was turned into a choice in commit f9b3cd245784 ("Kconfig.debug:
make DEBUG_INFO selectable from a choice").

CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y

will do what "CONFIG_DEBUG_INFO=y" used to do.

Cheers,
Nathan
