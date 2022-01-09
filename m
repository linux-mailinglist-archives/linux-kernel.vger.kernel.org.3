Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32E2488C22
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiAITsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiAITsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:48:07 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31868C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 11:48:07 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id v11so8952069pfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 11:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JyqLjQnkJpIxD8QTaBOhLwMadk8N68x8plAXpy9Hz0c=;
        b=wlXDxSwWI+cU/jDX6EPuCXko8qAEyfTr/XvemTHjVyrH8tQJ+erL/GO9C9svhL6FPT
         6Gc3OZs9vxDPI1BfDW/FAza1teZ8+10EHnk20ZcxHs/OO78y01q4KTkPAhcIbXPtxFK6
         KKfAkKQrZeOvgXCnCFSdeMNbPlRlD6WQWqwtlqHtXD2rT80XWhfnRMxFBRz7LtXS2R2/
         KIOlc22iKAeDZ5bYPGyXfhw+XbmBw8XPd5fhsGUjDVVDooZzZCrcCXezOM4kT7avIoPl
         n9ODPvqnocR8sb2leSniR9IJYU2ZEMEfv4Tl/XBFi3hTNz7rg5hLiCr04efMLWhp/mhc
         Ag9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JyqLjQnkJpIxD8QTaBOhLwMadk8N68x8plAXpy9Hz0c=;
        b=atB8i7ygcsXTRn2Jp7aawZk6MamO2vD2O1vFj/ym4xP5BaylhpRGp02Jb8RYZ3llKa
         rnYskifASiZ6aRL5JtRbCE1nDEflFFIWiU3FbBmf2Oum4pclCgHgAyarlnTNz57xQG66
         hEY1CNFOwbmukXkpydzB2kpIlRX6KYCydcQk4UIGTqgUsAbyCaymqNGiL1V3CJDT4HBc
         ZHVLTDHAx9Fq7hk0Wgfg36L/LilhlwCcu4LNXcB+lZHujhjdpjgSG8XE0ex+0VaEaE0c
         tyGFH+QPXVIn/o/6ss9r85MXaLJ8IB462vEgf1tG1CkpVD3wxAnwev5boyBJtzFYqjFk
         sw/Q==
X-Gm-Message-State: AOAM533jki2gRkOxziAz2C9BUrKfRV3Lv4U9XFVRl0ZPcxl+pghNZku/
        GdV5reqtA4WJYjyaagyjxuR7Aw==
X-Google-Smtp-Source: ABdhPJwu+d4+2ofEkpi1W3WNzWjp7vIYF0vd9QvzESYvxs7HnIN7MVX0KSrgkszCVogy/ZsxBkTSSg==
X-Received: by 2002:a63:9602:: with SMTP id c2mr48737508pge.538.1641757686425;
        Sun, 09 Jan 2022 11:48:06 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s14sm1213780pfw.33.2022.01.09.11.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 11:48:06 -0800 (PST)
Date:   Sun, 09 Jan 2022 11:48:06 -0800 (PST)
X-Google-Original-Date: Sun, 09 Jan 2022 11:47:30 PST (-0800)
Subject:     Re: [PATCH 0/5] riscv: misc clean up
In-Reply-To: <20211128160741.2122-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, atishp@atishpatra.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-4e157e52-f315-48ee-ac92-03628c35cbde@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Nov 2021 08:07:36 PST (-0800), jszhang@kernel.org wrote:
> This series is a misc clean up: clean up useless LoCs, or make some
> functions static, or mark function pointer as __initdata, or remove
> one function().
>
> Jisheng Zhang (5):
>   riscv: remove cpu_stop()
>   riscv: head: make secondary_start_common() static
>   riscv: kvm: make kvm_riscv_vcpu_fp_clean() static

Probably best to split out the KVM patches, as they go in via a 
different tree.

>   riscv: errata: alternative: mark vendor_patch_func __initdata
>   riscv: head: remove useless __PAGE_ALIGNED_BSS and .balign
>
>  arch/riscv/errata/alternative.c | 3 ++-
>  arch/riscv/include/asm/smp.h    | 2 --
>  arch/riscv/kernel/cpu-hotplug.c | 8 +-------
>  arch/riscv/kernel/head.S        | 9 ++-------
>  arch/riscv/kvm/vcpu_fp.c        | 2 +-
>  5 files changed, 6 insertions(+), 18 deletions(-)

These are on for-next (aside from the KVM one, which Anup has already 
picked up).

Thanks!


