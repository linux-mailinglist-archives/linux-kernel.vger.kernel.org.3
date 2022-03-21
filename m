Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D94E3321
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiCUWuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiCUWtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:49:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CBC31FF34
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 025ED611FC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE92C36AE3;
        Mon, 21 Mar 2022 22:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647901798;
        bh=wutwcYfPuDKvje0wl8k99lEbUIaJw/Jfjn0jdgrmcf0=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=UCHgU0/nfTYpt+7mFjjE2sCGl8P1YZQ7v+ZoVmJIz4jeHfYP0HSEvcgglKWTKNOFy
         FbA4J5y11c+46eMMWpMUkFbMrY4qR0xbaDTad9jg0NmwQ9L16t1+JXj5ZXaNxZGx4k
         sj73XP18hGfw9cIC/ZToL4kq81omNVw51E0hRRWWtaPErzIspDf/mW/gG5su4JtKXZ
         fGp7gVGxyFywtyJ3XbTANJdosljK8GzawYRRm5yKAdO7RdoizeQFvGgc1zLNRX73Wz
         DW7ERqGQ3fQXgIcvJDoTT3k6ylFS9imY18yd0pbnoG9FjEd/TYEd5zRSfWi6TI7B0y
         /48F8Rxdov7Zw==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9B28827C0054;
        Mon, 21 Mar 2022 18:29:56 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Mon, 21 Mar 2022 18:29:56 -0400
X-ME-Sender: <xms:Y_w4YvCCeUVgUydeHawN0zyU-tDs4wjhYGNYLoYHQeXrzeSVTtnmdQ>
    <xme:Y_w4Ylh8lt2ZvAEVm0Ypg7bzIXziEB0qi9drVr8Q9aFZ9I4Of7Txs2K1oHxxRwqaV
    QtxVGZ4EFsj2cFgz4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhephfelhfdugeetvdfhfeeuveevtdegueekhfffheetffdtleevtdeh
    tdeivdeuvedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:Y_w4YqlZSnVfv0k7OnZ4e1g0eF5mYs4kLX_4gU70_EXhM9X3uswt5g>
    <xmx:Y_w4Yhxv5TeVGvFik2vqO-pIt2y_B8sKhEYQZJu9ogyqKTXHQXnOyw>
    <xmx:Y_w4YkQ7l-A3VAvAjL5Kr8KsaaN4rUx0iWWzCDW__uhfBcuYrNv_Xw>
    <xmx:ZPw4YrJA4wCcJfpzvSYpRLne0w4BPlILIDxy7fuqhbjim8ssiPlHZw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4342821E006E; Mon, 21 Mar 2022 18:29:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4907-g25ce6f34a9-fm-20220311.001-g25ce6f34
Mime-Version: 1.0
Message-Id: <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
In-Reply-To: <20220310111545.10852-1-bharata@amd.com>
References: <20220310111545.10852-1-bharata@amd.com>
Date:   Mon, 21 Mar 2022 15:29:34 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Bharata B Rao" <bharata@amd.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org, "the arch/x86 maintainers" <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, shuah@kernel.org,
        "Oleg Nesterov" <oleg@redhat.com>, ananth.narayan@amd.com
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022, at 3:15 AM, Bharata B Rao wrote:
> Hi,
>
> This patchset makes use of Upper Address Ignore (UAI) feature available
> on upcoming AMD processors to provide user address tagging support for x86/AMD.
>
> UAI allows software to store a tag in the upper 7 bits of a logical
> address [63:57]. When enabled, the processor will suppress the
> traditional canonical address checks on the addresses. More information
> about UAI can be found in section 5.10 of 'AMD64 Architecture
> Programmer's Manual, Vol 2: System Programming' which is available from
>
> https://bugzilla.kernel.org/attachment.cgi?id=300549

I hate to be a pain, but I'm really not convinced that this feature is suitable for Linux.  There are a few reasons:

Right now, the concept that the high bit of an address determines whether it's a user or a kernel address is fairly fundamental to the x86_64 (and x86_32!) code.  It may not be strictly necessary to preserve this, but violating it would require substantial thought.  With UAI enabled, kernel and user addresses are, functionally, interleaved.  This makes things like access_ok checks, and more generally anything that operates on a range of addresses, behave potentially quite differently.  A lot of auditing of existing code would be needed to make it safe.

UAI looks like it wasn't intended to be context switched and, indeed, your series doesn't context switch it.  As far as I'm concerned, this is an error, and if we support UAI at all, we should context switch it.  Yes, this will be slow, perhaps painfully slow.  AMD knows how to fix it by, for example, reading the Intel SDM.  By *not* context switching UAI, we force it on for all user code, including unsuspecting user code, as well as for kernel code.  Do we actually want it on for kernel code?  With LAM, in contrast, the semantics for kernel pointers vs user pointers actually make sense and can be set per mm, which will make things like io_uring (in theory) do the right thing.

UAI and LAM are incompatible from a userspace perspective.  Since LAM is pretty clearly superior [0], it seems like a better long term outcome would be for programs that want tag bits to target LAM and for AMD to support LAM if there is demand.  For that matter, do we actually expect any userspace to want to support UAI?  (Are there existing too-clever sandboxes that would be broken by enabling UAI?)

Given that UAI is not efficiently context switched, the implementation of uaccess is rather bizarre.  With the implementation in this series in particular, if the access_ok checks ever get out of sync with actual user access, a user access could be emitted with the high bits not masked despite the range check succeeding due to masking, which would, unless great care is taken, result in a "user" access hitting the kernel range.  That's no good.

I believe it's possible for a high-quality kernel UAI implementation to exist, but, as above, I think it would be slow, and it might be quite complex and fragile.  Are we sure that it's worth supporting it?

[0] I hope I don't have to argue this point.



>
> Currently ARM64 provides a way for processes to opt-in for
> relaxed tagged ABI via prctl() options PR_SET/GET_TAGGED_ADDR_CTRL.
> The prctl() API was found to be a bit restrictive for x86 use and
> Kirill had posted an extension to it as part of Intel LAM patchset.
> (https://lore.kernel.org/linux-mm/20210205151631.43511-1-kirill.shutemov@linux.intel.com/)
>
> This patchset builds on that prctl() extension and adds support
> for AMD UAI. AMD implementation is kept separate as equivalent
> Intel LAM implementation is likely to be different due to different
> bit positions and tag width.
>
> This is an early implementation which has been only lightly tested.
> I have used the tags_test.c from selftests/vm/tags/ to test this.
> For ARM64 changes, I have only ensured that the changes compile.
>
> Regards,
> Bharata.
>
> Bharata B Rao (5):
>   x86/cpufeatures: Add Upper Address Ignore(UAI) as CPU feature
>   x86: Enable Upper Address Ignore(UAI) feature
>   x86: Provide an implementation of untagged_addr()
>   x86: Untag user pointers in access_ok()
>   x86: Add prctl() options to control tagged user addresses ABI
>
> Kirill A. Shutemov (1):
>   mm, arm64: Update PR_SET/GET_TAGGED_ADDR_CTRL interface
>
>  arch/arm64/include/asm/processor.h            |  12 +-
>  arch/arm64/kernel/process.c                   |  45 +++++-
>  arch/arm64/kernel/ptrace.c                    |   4 +-
>  arch/x86/Kconfig                              |   9 ++
>  arch/x86/include/asm/cpufeatures.h            |   2 +-
>  arch/x86/include/asm/msr-index.h              |   2 +
>  arch/x86/include/asm/page_32.h                |   3 +
>  arch/x86/include/asm/page_64.h                |  26 ++++
>  arch/x86/include/asm/processor.h              |  12 ++
>  arch/x86/include/asm/thread_info.h            |   2 +
>  arch/x86/include/asm/uaccess.h                |  29 +++-
>  arch/x86/kernel/cpu/scattered.c               |   1 +
>  arch/x86/kernel/process.c                     | 134 ++++++++++++++++++
>  arch/x86/kernel/setup.c                       |   8 ++
>  kernel/sys.c                                  |  14 +-
>  .../testing/selftests/arm64/tags/tags_test.c  |  31 ----
>  .../selftests/{arm64 => vm}/tags/.gitignore   |   0
>  .../selftests/{arm64 => vm}/tags/Makefile     |   0
>  .../{arm64 => vm}/tags/run_tags_test.sh       |   0
>  tools/testing/selftests/vm/tags/tags_test.c   |  59 ++++++++
>  20 files changed, 335 insertions(+), 58 deletions(-)
>  delete mode 100644 tools/testing/selftests/arm64/tags/tags_test.c
>  rename tools/testing/selftests/{arm64 => vm}/tags/.gitignore (100%)
>  rename tools/testing/selftests/{arm64 => vm}/tags/Makefile (100%)
>  rename tools/testing/selftests/{arm64 => vm}/tags/run_tags_test.sh (100%)
>  create mode 100644 tools/testing/selftests/vm/tags/tags_test.c
>
> -- 
> 2.25.1
