Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24594F0688
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 00:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349144AbiDBWD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 18:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbiDBWDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 18:03:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDFCC49;
        Sat,  2 Apr 2022 15:02:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c7so9129493wrd.0;
        Sat, 02 Apr 2022 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2OQnYVvLaW9bpTUFsIzEdFq8P66ZYalyZFA5fImrQ1E=;
        b=aoIxuoEO2EhbGmTWv6RB+MxlG91kTNCBMtSzXP8hLXlk93Ot1NVeRtokLGpoC16HwI
         j/N6lxJoZPFUvM6+kqsGO7ko9/DvrU/K2S+WWaZZ8ILc6L6Abe1sWiYnj5CiiniCzSOT
         3nWhb/kkby6UuL4M42vxoVgzlYz1dRd0XHm6T4TI4Xvq2L5u0FKEfXlbcAU0fGYKz+Fc
         XvmwQuaBnOK4ZmpSU9Lo1JUUK2YkKipe+TPG0q/mxS4zQSQXDMpiQcFQG2JeQLXtz98d
         CkEx6i/XyXy3g3Eg33G8sF+NJvTM/N45c+A8hrPnkAXYnk+dJlaHYqN2xQ4dIK+UU4lS
         FeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2OQnYVvLaW9bpTUFsIzEdFq8P66ZYalyZFA5fImrQ1E=;
        b=cuOyQS2b24a+G9XUuLlUR11ISIZ9JaG9KuCzPB8wNDvLBDb5mDMsqkCkumRnk+uT9O
         1coCmcUIgxLP5S7iawvSQHO/qBidObJDRvBVVbap47Kw9q/dpHkbCvGE9DaYbfH8Pkde
         FxxhhNdvbQj1JkhFqLuwOr8/sLaupdeFf7enFkjI4+zPj/Vv8JkdPEy+K8RcYCkBhH8V
         B6adb1oT4ESvLNI0ScriU6Uqrw5bDBQLFZrVXLMah7/1aSu0qBSpjByBHhhJBab/Y2gW
         3htImksxNcAPFFEzb+HrE5yJI1Lby64jlsDcHwlPsG3z6QBemsJ6DfcWh/9bw4K4VWGC
         Q7Vg==
X-Gm-Message-State: AOAM531VxPoYKP2A3uiS4aTz9gOu5/Xw0P8FDrhCMrPMI+fmKWB50WWS
        zn/g97ylLtvaeHYo7FewCnc=
X-Google-Smtp-Source: ABdhPJw3EcGH9cK9fmCnPv80XHvktAOF1EfUjxBpV4gQT8voyFEZOHEqy5v4XtO0UG/+0fbhm7N3og==
X-Received: by 2002:a05:6000:2a8:b0:205:8817:8296 with SMTP id l8-20020a05600002a800b0020588178296mr12090836wry.309.1648936920207;
        Sat, 02 Apr 2022 15:02:00 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm14756280wmq.41.2022.04.02.15.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 15:01:59 -0700 (PDT)
Message-ID: <6f3aef3d-62ba-b068-bc65-604eba315946@gmail.com>
Date:   Sun, 3 Apr 2022 00:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] ioctl_userfaultfd.2, userfaultfd.2: add minor fault
 mode
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Ian Abbott <abbotti@mev.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20220322163944.631042-1-axelrasmussen@google.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <20220322163944.631042-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On 3/22/22 17:39, Axel Rasmussen wrote:
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
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Sorry, but this patch doesn't apply after one from Ian that I applied to
my tree.  I can fix the conflicts myself (they seem easy from a
lines-in-lines-out point of view), but I'd prefer you to do it since I
may introduce some incorrections in the page, and you'll know better.

Please check
<http://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/>

Thanks,

Alex

> ---
>  man2/ioctl_userfaultfd.2 | 135 ++++++++++++++++++++++++++++++++++++---
>  man2/userfaultfd.2       |  79 +++++++++++++++++++----
>  2 files changed, 192 insertions(+), 22 deletions(-)
> 
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 504f61d4b..d213a0a43 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -214,6 +214,11 @@ memory accesses to the regions registered with userfaultfd.
>  If this feature bit is set,
>  .I uffd_msg.pagefault.feat.ptid
>  will be set to the faulted thread ID for each page-fault message.
> +.TP
> +.BR UFFD_FEATURE_MINOR_HUGETLBFS " (since Linux 5.13)"
> +If this feature bit is set,
> +the kernel supports registering userfaultfd ranges
> +in minor mode on hugetlbfs-backed memory areas.
>  .PP
>  The returned
>  .I ioctls
> @@ -240,6 +245,11 @@ operation is supported.
>  The
>  .B UFFDIO_WRITEPROTECT
>  operation is supported.
> +.TP
> +.B 1 << _UFFDIO_CONTINUE
> +The
> +.B UFFDIO_CONTINUE
> +operation is supported.
>  .PP
>  This
>  .BR ioctl (2)
> @@ -278,14 +288,8 @@ by the current kernel version.
>  (Since Linux 4.3.)
>  Register a memory address range with the userfaultfd object.
>  The pages in the range must be "compatible".
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
>  .PP
>  The
>  .I argp
> @@ -324,9 +328,20 @@ the specified range:
>  .TP
>  .B UFFDIO_REGISTER_MODE_MISSING
>  Track page faults on missing pages.
> +Since Linux 4.3,
> +only private anonymous ranges are compatible.
> +Since Linux 4.11,
> +hugetlbfs and shared memory ranges are also compatible.
>  .TP
>  .B UFFDIO_REGISTER_MODE_WP
>  Track page faults on write-protected pages.
> +Since Linux 5.7,
> +only private anonymous ranges are compatible.
> +.TP
> +.B UFFDIO_REGISTER_MODE_MINOR
> +Track minor page faults.
> +Since Linux 5.13,
> +only hugetlbfs ranges are compatible.
>  .PP
>  If the operation is successful, the kernel modifies the
>  .I ioctls
> @@ -735,6 +750,110 @@ or not registered with userfaultfd write-protect mode.
>  .TP
>  .B EFAULT
>  Encountered a generic fault during processing.
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
>  .SH RETURN VALUE
>  See descriptions of the individual operations, above.
>  .SH ERRORS
> diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> index cee7c01d2..458e05faa 100644
> --- a/man2/userfaultfd.2
> +++ b/man2/userfaultfd.2
> @@ -82,7 +82,7 @@ all memory ranges that were registered with the object are unregistered
>  and unread events are flushed.
>  .\"
>  .PP
> -Userfaultfd supports two modes of registration:
> +Userfaultfd supports three modes of registration:
>  .TP
>  .BR UFFDIO_REGISTER_MODE_MISSING " (since 4.10)"
>  When registered with
> @@ -96,6 +96,18 @@ or an
>  .B UFFDIO_ZEROPAGE
>  ioctl.
>  .TP
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
>  .BR UFFDIO_REGISTER_MODE_WP " (since 5.7)"
>  When registered with
>  .B UFFDIO_REGISTER_MODE_WP
> @@ -216,9 +228,10 @@ a page fault occurring in the requested memory range, and satisfying
>  the mode defined at the registration time, will be forwarded by the kernel to
>  the user-space application.
>  The application can then use the
> -.B UFFDIO_COPY
> +.B UFFDIO_COPY ,
> +.B UFFDIO_ZEROPAGE ,
>  or
> -.B UFFDIO_ZEROPAGE
> +.B UFFDIO_CONTINUE
>  .BR ioctl (2)
>  operations to resolve the page fault.
>  .PP
> @@ -322,6 +335,43 @@ should have the flag
>  cleared upon the faulted page or range.
>  .PP
>  Write-protect mode supports only private anonymous memory.
> +.\"
> +.SS Userfaultfd minor fault mode (since 5.13)
> +Since Linux 5.13, userfaultfd supports minor fault mode.
> +In this mode, fault messages are produced not for major faults (where the
> +page was missing), but rather for minor faults, where a page exists in the page
> +cache, but the page table entries are not yet present.
> +The user needs to first check availability of this feature using
> +.B UFFDIO_API
> +ioctl against the feature bit
> +.B UFFD_FEATURE_MINOR_HUGETLBFS
> +before using this feature.
> +.PP
> +To register with userfaultfd minor fault mode, the user needs to initiate the
> +.B UFFDIO_REGISTER
> +ioctl with mode
> +.B UFFD_REGISTER_MODE_MINOR
> +set.
> +.PP
> +When a minor fault occurs, user-space will receive a page-fault notification
> +whose
> +.I uffd_msg.pagefault.flags
> +will have the
> +.B UFFD_PAGEFAULT_FLAG_MINOR
> +flag set.
> +.PP
> +To resolve a minor page fault, the handler should decide whether or not the
> +existing page contents need to be modified first.
> +If so, this should be done in-place via a second, non-userfaultfd-registered
> +mapping to the same backing page (e.g., by mapping the hugetlbfs file twice).
> +Once the page is considered "up to date", the fault can be resolved by
> +initiating an
> +.B UFFDIO_CONTINUE
> +ioctl, which installs the page table entries and (by default) wakes up the
> +faulting thread(s).
> +.PP
> +Minor fault mode supports only hugetlbfs-backed memory.
> +.\"
>  .SS Reading from the userfaultfd structure
>  Each
>  .BR read (2)
> @@ -460,19 +510,20 @@ For
>  the following flag may appear:
>  .RS
>  .TP
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
>  .TP
> +.B UFFD_PAGEFAULT_FLAG_WRITE
> +If this flag is set, then the fault was a write fault.
> +.PP
> +If neither
>  .B UFFD_PAGEFAULT_FLAG_WP
> -If the address is in a range that was registered with the
> -.B UFFDIO_REGISTER_MODE_WP
> -flag, when this bit is set, it means it is a write-protect fault.
> -Otherwise it is a page-missing fault.
> +nor
> +.B UFFD_PAGEFAULT_FLAG_MINOR
> +are set, then the fault was a missing fault.
>  .RE
>  .TP
>  .I pagefault.feat.pid

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
