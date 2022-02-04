Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2C4A9C3B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359836AbiBDPtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBDPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:49:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE5C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:49:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so13471850pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8hAle5pK+OkXxUo/xp7Omgd0+lE9UICShlBEPUsqjw=;
        b=2WYS6VjWZVLZYjDTtp9oLw8pdbk8FQ7RxKuS0whK4rWg314ENG5QZVzS0wbGvsaGdk
         5Lzkb7kANAmI4pe/TEkRuQNRMoh2ghGKLWlTrVdZejHFY1khR0GCyjbtNlmiAVyNsy5N
         sdjkKcuHSJOT+aZGHkd9cSfyZbnc2gxaWw6NpvCQgDd2FUpGzCGr3n+/8QGZB5TLSJbS
         6Khn5PW5jNt2yUAniQJ+WsV6wYoDYvehQt6QlFdzteENOjpZ+vv7xh1gB1iPxZGvS6qx
         u69VXN5cv4N4FsqDuuvddNt3uHdDQ3W81tsVhLkA27ZmLghSpeHf28HWQnqH7BhLVltS
         VYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8hAle5pK+OkXxUo/xp7Omgd0+lE9UICShlBEPUsqjw=;
        b=Yfo59tiTdxQFqV9s1xGop18YpbOdm0YuGn3FmqmaIQQFwHjDXdZANUMbYzJtBMLyrt
         A3aqdh2O9BKxv0OQqlvFeXNGN6fZ/KQOqo4UzIIu2xnQSh/HU9IYwbaOJmdNv/KQ0022
         CotoTdh7P5ht9QNhabpeow98nG6ztDDj9Y7zroc7JgkM2VgrXmUcvDTf+fvfTsghF9v6
         xg2/03+uGvGZK4tkPHfr2UZCDmCftwIk7dd+JLvIgSRynd9tIUCYbia2uDio7GiZCPwj
         c3DtFrn/+5NtvW1nACtwojReteZesySwLw+ClMgaWb/RCLQLuyl+21yCLICJzRioOQ2N
         uYFA==
X-Gm-Message-State: AOAM5316pPMGIMylCKLjs6w/ob3LUmykzi5O1NVP7TMW2QWrjmwHz52e
        3zPBadl2qYhZMTTrdLPNyseL82X0xJyAbzqrp30JUw==
X-Google-Smtp-Source: ABdhPJwBmwL1AwQrptYo61NQpPYuFAyd1CBBkszJf222KUL0Av9R92Uzd5sPU1T0Y3c4H90URSUXdHmOHCE/llYvNTQ=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr3895928ply.34.1643989775485;
 Fri, 04 Feb 2022 07:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-33-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-33-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 07:49:24 -0800
Message-ID: <CAPcyv4iamy3CC=ryy5GhBfnCFo51dW2_kqA9Ur6KBD2VjEyJTw@mail.gmail.com>
Subject: Re: [PATCH V8 32/44] memremap_pages: Add Kconfig for DEVMAP_ACCESS_PROTECTION
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> The persistent memory (PMEM) driver uses the memremap_pages facility to
> provide 'struct page' metadata (vmemmap) for PMEM.  Given that PMEM
> capacity maybe orders of magnitude higher capacity than System RAM it

s/maybe/may be/

> presents a large vulnerability surface to stray writes.  Unlike stray
> writes to System RAM, which may result in a crash or other undesirable
> behavior, stray writes to PMEM additionally are more likely to result in
> permanent data loss. Reboot is not a remediation for PMEM corruption
> like it is for System RAM.
>
> Given that PMEM access from the kernel is limited to a constrained set
> of locations (PMEM driver, Filesystem-DAX, and direct-I/O to a DAX
> page), it is amenable to supervisor pkey protection.
>
> Not all systems with PMEM will want additional protections.  Therefore,
> add a Kconfig option for the user to configure the additional devmap
> protections.
>
> Only systems with supervisor protection keys (PKS) are able to support
> this new protection so depend on ARCH_HAS_SUPERVISOR_PKEYS.
> Furthermore, select ARCH_ENABLE_SUPERVISOR_PKEYS to ensure that the
> architecture support is enabled if PMEM is the only use case.
>
> Only PMEM which is advertised to the memory subsystem needs this
> protection.  Therefore, the feature depends on NVDIMM_PFN.
>
> A default of (NVDIMM_PFN && ARCH_HAS_SUPERVISOR_PKEYS) was suggested but
> logically that is the same as saying default 'yes' because both
> NVDIMM_PFN and ARCH_HAS_SUPERVISOR_PKEYS are required.  Therefore a
> default of 'yes' is used.

It still feels odd to default this to y just because the ARCH enables
it. I think it's fine for this to require explicit opt-in especially
because it has non-zero overhead and there are other PKEYS users on
the horizon.

>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes for V8
>         Split this out from
>                 [PATCH V7 13/18] memremap_pages: Add access protection via supervisor Protection Keys (PKS)
> ---
>  mm/Kconfig | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 46f2bb15aa4e..67e0264acf7d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -776,6 +776,24 @@ config ZONE_DEVICE
>
>           If FS_DAX is enabled, then say Y.
>
> +config DEVMAP_ACCESS_PROTECTION
> +       bool "Access protection for memremap_pages()"
> +       depends on NVDIMM_PFN
> +       depends on ARCH_HAS_SUPERVISOR_PKEYS
> +       select ARCH_ENABLE_SUPERVISOR_PKEYS
> +       default y
> +
> +       help
> +         Enable extra protections on device memory.  This protects against
> +         unintended access to devices such as a stray writes.  This feature is
> +         particularly useful to protect against corruption of persistent
> +         memory.
> +
> +         This depends on architecture support of supervisor PKeys and has no
> +         overhead if the architecture does not support them.
> +
> +         If you have persistent memory say 'Y'.
> +
>  config DEV_PAGEMAP_OPS
>         bool
>
> --
> 2.31.1
>
