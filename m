Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FDA50E9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbiDYUGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiDYUF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:05:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84603112449;
        Mon, 25 Apr 2022 13:02:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u9-20020a05600c00c900b00393e729e655so253155wmm.0;
        Mon, 25 Apr 2022 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qfLwlqpmXcHD1Cl94kpG/ID89u7RYYYNcj9JpPafx8c=;
        b=ihZSJqR4jiiH5gL746ayafZELwL3VDM7WmLTwhbKmVSTzOGETf5rBNjlor6QQB95Vi
         mMtAdk8YsQaOF0plYW74WYSs95HsRMCBsLajf5xuM+cPfJRCy4B4GGphmZjGm0sHRgIw
         GpMAMc2oHsAeXHm2XQCybW3wXt35dep3Eby3mKDobBOehHgzfF5919eALWCGYOv9Po//
         BAUHLqZEId+r2v10DP3SAC6A4Alv0BkTMAVz6eiFi3fVLl07xl9ySr0ZzIF1TA+sluBE
         KvNHGHjKpwzDQlKA2D+8gdXLCcn2pYlKj6Vln6MCSSs6mcqM42nPre9/crPUxogcG/yD
         6Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qfLwlqpmXcHD1Cl94kpG/ID89u7RYYYNcj9JpPafx8c=;
        b=aUoApvb59eUEv5K6XrL5r045VPG5mqp9G/OfwEw7wUtA+mK1MbmEIHAZeGPYVPXW7q
         sSaxJQwjpVgOYyOUTeackp+Id6T3SPbWf2X0g+pf9yHH8Fiqfo0VepMKl/F4glsPAyZF
         0Eiz32va3lG2D08i1qIPcw3IYxApzK2NmOffWi8RMQYf9kdAf1ZCJ/TRD5ak3bci78qc
         cSQNvGRUnI04XIDCAFVpK3sHI/2TwiGgLsxNMK9AEoqCuhl5nC5HPfDe4vKRW/MfEUpf
         0q8dE2/pWqZnzGo0tSruO2hM4W4ndfz4L9AGzWUExQnuLXHwZV3d0Vz3N4CKOfJjRGuN
         EnlQ==
X-Gm-Message-State: AOAM530JTGlCGHUSZEu8J9kZrBa0EN20iPhF/DGFqaNY/Q2kfO9fTTow
        XngQo/28xA9rfAnnN1i1TyQ=
X-Google-Smtp-Source: ABdhPJxMZTwO2w5QCSNjzjUXQEK01fwd24g9Mfga0avoe6wgIVZDakKk5reNPVXHAUggiBVgMzuouw==
X-Received: by 2002:a7b:c7c3:0:b0:389:cbf1:fadf with SMTP id z3-20020a7bc7c3000000b00389cbf1fadfmr27930445wmk.147.1650916969946;
        Mon, 25 Apr 2022 13:02:49 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b00207b5d9f51fsm9705172wrf.41.2022.04.25.13.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 13:02:49 -0700 (PDT)
Message-ID: <8eb8754e-9481-6ada-b56e-ff26ddc223f6@gmail.com>
Date:   Mon, 25 Apr 2022 22:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4] ioctl_userfaultfd.2, userfaultfd.2: add minor fault
 mode
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org
References: <20220412195631.282237-1-axelrasmussen@google.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220412195631.282237-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On 4/12/22 21:56, Axel Rasmussen wrote:
> Userfaultfd minor fault mode is supported starting from Linux 5.13.
> 
> This commit adds a description of the new mode, as well as the new ioctl
> used to resolve such faults. The two go hand-in-hand: one can't resolve
> a minor fault without continue, and continue can't be used to resolve
> any other kind of fault.
> 
> This patch covers just the hugetlbfs implementation (in 5.13). Support
> for shmem is forthcoming, but as it has not yet made it into a kernel
> release candidate, it will be added in a future commit.
> 
> v1->v2:
> - Some spelling / phrasing improvements
> v2->v3:
> - Improved line wrapping in man2/ioctl_userfaultfd.2
> v3->v4:
> - Rebased onto http://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/ main
> - Mentioned minor fault shmem support
> - Improved line wrapping in man2/userfaultfd.2
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Patch applied.

On 4/12/22 22:05, Axel Rasmussen wrote:
 > Whoops, I ought to have removed this part of the commit message, since
 > I updated the commit to mention shmem as well:
 >
 > "This patch covers just the hugetlbfs implementation (in 5.13). Support
 > for shmem is forthcoming, but as it has not yet made it into a kernel
 > release candidate, it will be added in a future commit."

And message fixed.

Thanks,

Alex

> ---
>   man2/ioctl_userfaultfd.2 | 142 ++++++++++++++++++++++++++++++++++++---
>   man2/userfaultfd.2       |  95 ++++++++++++++++++++++----
>   2 files changed, 215 insertions(+), 22 deletions(-)
> 
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 15a681164c..d0cb0c9c8e 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -197,6 +197,16 @@ memory accesses to the regions registered with userfaultfd.
>   If this feature bit is set,
>   .I uffd_msg.pagefault.feat.ptid
>   will be set to the faulted thread ID for each page-fault message.
> +.TP
> +.BR UFFD_FEATURE_MINOR_HUGETLBFS " (since Linux 5.13)"
> +If this feature bit is set,
> +the kernel supports registering userfaultfd ranges
> +in minor mode on hugetlbfs-backed memory areas.
> +.TP
> +.BR UFFD_FEATURE_MINOR_SHMEM " (since Linux 5.14)"
> +If this feature bit is set,
> +the kernel supports registering userfaultfd ranges
> +in minor mode on shmem-backed memory areas.
>   .PP
>   The returned
>   .I ioctls
> @@ -256,14 +266,8 @@ by the current kernel version.
>   (Since Linux 4.3.)
>   Register a memory address range with the userfaultfd object.
>   The pages in the range must be "compatible".
> -.PP
> -Up to Linux kernel 4.11,
> -only private anonymous ranges are compatible for registering with
> -.BR UFFDIO_REGISTER .
> -.PP
> -Since Linux 4.11,
> -hugetlbfs and shared memory ranges are also compatible with
> -.BR UFFDIO_REGISTER .
> +Please refer to the list of register modes below
> +for the compatible memory backends for each mode.
>   .PP
>   The
>   .I argp
> @@ -302,9 +306,22 @@ the specified range:
>   .TP
>   .B UFFDIO_REGISTER_MODE_MISSING
>   Track page faults on missing pages.
> +Since Linux 4.3,
> +only private anonymous ranges are compatible.
> +Since Linux 4.11,
> +hugetlbfs and shared memory ranges are also compatible.
>   .TP
>   .B UFFDIO_REGISTER_MODE_WP
>   Track page faults on write-protected pages.
> +Since Linux 5.7,
> +only private anonymous ranges are compatible.
> +.TP
> +.B UFFDIO_REGISTER_MODE_MINOR
> +Track minor page faults.
> +Since Linux 5.13,
> +only hugetlbfs ranges are compatible.
> +Since Linux 5.14,
> +compatiblity with shmem ranges was added.
>   .PP
>   If the operation is successful, the kernel modifies the
>   .I ioctls
> @@ -331,6 +348,11 @@ The
>   The
>   .B UFFDIO_ZEROPAGE
>   operation is supported.
> +.TP
> +.B 1 << _UFFDIO_CONTINUE
> +The
> +.B UFFDIO_CONTINUE
> +operation is supported.
>   .PP
>   This
>   .BR ioctl (2)
> @@ -731,6 +753,110 @@ or not registered with userfaultfd write-protect mode.
>   .TP
>   .B EFAULT
>   Encountered a generic fault during processing.
> +.\"
> +.SS UFFDIO_CONTINUE
> +(Since Linux 5.13.)
> +Resolve a minor page fault
> +by installing page table entries
> +for existing pages in the page cache.
> +.PP
> +The
> +.I argp
> +argument is a pointer to a
> +.I uffdio_continue
> +structure as shown below:
> +.PP
> +.in +4n
> +.EX
> +struct uffdio_continue {
> +    struct uffdio_range range; /* Range to install PTEs for and continue */
> +    __u64 mode;                /* Flags controlling the behavior of continue */
> +    __s64 mapped;              /* Number of bytes mapped, or negated error */
> +};
> +.EE
> +.in
> +.PP
> +The following value may be bitwise ORed in
> +.IR mode
> +to change the behavior of the
> +.B UFFDIO_CONTINUE
> +operation:
> +.TP
> +.B UFFDIO_CONTINUE_MODE_DONTWAKE
> +Do not wake up the thread that waits for page-fault resolution.
> +.PP
> +The
> +.I mapped
> +field is used by the kernel
> +to return the number of bytes that were actually mapped,
> +or an error in the same manner as
> +.BR UFFDIO_COPY .
> +If the value returned in the
> +.I mapped
> +field doesn't match the value that was specified in
> +.IR range.len ,
> +the operation fails with the error
> +.BR EAGAIN .
> +The
> +.I mapped
> +field is output-only;
> +it is not read by the
> +.B UFFDIO_CONTINUE
> +operation.
> +.PP
> +This
> +.BR ioctl (2)
> +operation returns 0 on success.
> +In this case,
> +the entire area was mapped.
> +On error, \-1 is returned and
> +.I errno
> +is set to indicate the error.
> +Possible errors include:
> +.TP
> +.B EAGAIN
> +The number of bytes mapped
> +(i.e., the value returned in the
> +.I mapped
> +field)
> +does not equal the value that was specified in the
> +.I range.len
> +field.
> +.TP
> +.B EINVAL
> +Either
> +.I range.start
> +or
> +.I range.len
> +was not a multiple of the system page size; or
> +.I range.len
> +was zero; or the range specified was invalid.
> +.TP
> +.B EINVAL
> +An invalid bit was specified in the
> +.IR mode
> +field.
> +.TP
> +.B EEXIST
> +One or more pages were already mapped in the given range.
> +.TP
> +.B ENOENT
> +The faulting process has changed its virtual memory layout simultaneously with
> +an outstanding
> +.B UFFDIO_CONTINUE
> +operation.
> +.TP
> +.B ENOMEM
> +Allocating memory needed to setup the page table mappings failed.
> +.TP
> +.B EFAULT
> +No existing page could be found in the page cache for the given range.
> +.TP
> +.BR ESRCH
> +The faulting process has exited at the time of a
> +.B UFFDIO_CONTINUE
> +operation.
> +.\"
>   .SH RETURN VALUE
>   See descriptions of the individual operations, above.
>   .SH ERRORS
> diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> index 41741b4d88..f8dc4766b1 100644
> --- a/man2/userfaultfd.2
> +++ b/man2/userfaultfd.2
> @@ -65,7 +65,7 @@ all memory ranges that were registered with the object are unregistered
>   and unread events are flushed.
>   .\"
>   .PP
> -Userfaultfd supports two modes of registration:
> +Userfaultfd supports three modes of registration:
>   .TP
>   .BR UFFDIO_REGISTER_MODE_MISSING " (since 4.10)"
>   When registered with
> @@ -79,6 +79,18 @@ or an
>   .B UFFDIO_ZEROPAGE
>   ioctl.
>   .TP
> +.BR UFFDIO_REGISTER_MODE_MINOR " (since 5.13)"
> +When registered with
> +.B UFFDIO_REGISTER_MODE_MINOR
> +mode, user-space will receive a page-fault notification
> +when a minor page fault occurs.
> +That is, when a backing page is in the page cache, but
> +page table entries don't yet exist.
> +The faulted thread will be stopped from execution
> +until the page fault is resolved from user-space by an
> +.B UFFDIO_CONTINUE
> +ioctl.
> +.TP
>   .BR UFFDIO_REGISTER_MODE_WP " (since 5.7)"
>   When registered with
>   .B UFFDIO_REGISTER_MODE_WP
> @@ -199,9 +211,10 @@ a page fault occurring in the requested memory range, and satisfying
>   the mode defined at the registration time, will be forwarded by the kernel to
>   the user-space application.
>   The application can then use the
> -.B UFFDIO_COPY
> +.B UFFDIO_COPY ,
> +.B UFFDIO_ZEROPAGE ,
>   or
> -.B UFFDIO_ZEROPAGE
> +.B UFFDIO_CONTINUE
>   .BR ioctl (2)
>   operations to resolve the page fault.
>   .PP
> @@ -305,6 +318,59 @@ should have the flag
>   cleared upon the faulted page or range.
>   .PP
>   Write-protect mode supports only private anonymous memory.
> +.\"
> +.SS Userfaultfd minor fault mode (since 5.13)
> +Since Linux 5.13,
> +userfaultfd supports minor fault mode.
> +In this mode,
> +fault messages are produced not for major faults
> +(where the page was missing),
> +but rather for minor faults,
> +where a page exists in the page cache,
> +but the page table entries are not yet present.
> +The user needs to first check availability of this feature using the
> +.B UFFDIO_API
> +ioctl with the appropriate feature bits set before using this feature:
> +.B UFFD_FEATURE_MINOR_HUGETLBFS
> +since Linux 5.13,
> +or
> +.B UFFD_FEATURE_MINOR_SHMEM
> +since Linux 5.14.
> +.PP
> +To register with userfaultfd minor fault mode,
> +the user needs to initiate the
> +.B UFFDIO_REGISTER
> +ioctl with mode
> +.B UFFD_REGISTER_MODE_MINOR
> +set.
> +.PP
> +When a minor fault occurs,
> +user-space will receive a page-fault notification
> +whose
> +.I uffd_msg.pagefault.flags
> +will have the
> +.B UFFD_PAGEFAULT_FLAG_MINOR
> +flag set.
> +.PP
> +To resolve a minor page fault,
> +the handler should decide whether or not
> +the existing page contents need to be modified first.
> +If so,
> +this should be done in-place via a second,
> +non-userfaultfd-registered mapping
> +to the same backing page
> +(e.g., by mapping the shmem or hugetlbfs file twice).
> +Once the page is considered "up to date",
> +the fault can be resolved by initiating an
> +.B UFFDIO_CONTINUE
> +ioctl,
> +which installs the page table entries and
> +(by default)
> +wakes up the faulting thread(s).
> +.PP
> +Minor fault mode supports only hugetlbfs-backed (since Linux 5.13)
> +and shmem-backed (since Linux 5.14) memory.
> +.\"
>   .SS Reading from the userfaultfd structure
>   Each
>   .BR read (2)
> @@ -443,19 +509,20 @@ For
>   the following flag may appear:
>   .RS
>   .TP
> -.B UFFD_PAGEFAULT_FLAG_WRITE
> -If the address is in a range that was registered with the
> -.B UFFDIO_REGISTER_MODE_MISSING
> -flag (see
> -.BR ioctl_userfaultfd (2))
> -and this flag is set, this a write fault;
> -otherwise it is a read fault.
> +.B UFFD_PAGEFAULT_FLAG_WP
> +If this flag is set, then the fault was a write-protect fault.
> +.TP
> +.B UFFD_PAGEFAULT_FLAG_MINOR
> +If this flag is set, then the fault was a minor fault.
>   .TP
> +.B UFFD_PAGEFAULT_FLAG_WRITE
> +If this flag is set, then the fault was a write fault.
> +.PP
> +If neither
>   .B UFFD_PAGEFAULT_FLAG_WP
> -If the address is in a range that was registered with the
> -.B UFFDIO_REGISTER_MODE_WP
> -flag, when this bit is set, it means it is a write-protect fault.
> -Otherwise it is a page-missing fault.
> +nor
> +.B UFFD_PAGEFAULT_FLAG_MINOR
> +are set, then the fault was a missing fault.
>   .RE
>   .TP
>   .I pagefault.feat.pid
