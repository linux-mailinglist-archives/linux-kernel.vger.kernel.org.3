Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B14246DD39
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhLHUlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLHUlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:41:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25581C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:38:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A9AC5CE2340
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CBDC341C8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638995879;
        bh=iyEvj82ekm6Lj4oQv96NJaUNAiBGU+wAJ4ZSvFlFM4o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GDYIdfvsSLPIX5G8WVtPHO3ivOnGjvO/ma/bDNwdvyg+9ttitaYvIvfCX4vPVU50h
         phAVVp/Zh4sAjoydnspBrwp0JY01eW0pJAYSYi3xuQiNzDbHYCfVcSBM4Cr1IR1gnK
         ZSN40rZabVzc2NsaBiqHip2bgqMT798K6NSvwW2GcYnFjls/vq2Loue7M88omJJ6a0
         Q+O87T6FRqu9WefQ9USptc7t6btlxvmL6s4jxO4u8D+98NRXrV5+qxMJlfCers5m6t
         BWDTxiTpUkFHx7qmPymdmLwTCd+VgjjMU9uTmEx3hJevLnW0lfSBq+zsElwIV1xQqQ
         wNY781lgzVatA==
Received: by mail-ed1-f43.google.com with SMTP id v1so12602414edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:37:59 -0800 (PST)
X-Gm-Message-State: AOAM532BbJU8BWOEChZZ2VVbpwDPrymrnBoO6Q4T5SrhXQspZiNZCMp7
        Fl1CLIUIuBwAF2kfAxwNUaq9QQl3+txZ19ZwHQ==
X-Google-Smtp-Source: ABdhPJyQs0WEmQzobaw4oYyA/edXbXZ6z9JCOT40fhRezA8RTDJYel8VEI/dH0NrI1rjDpUb12oypK+g9mFMsbR3LeI=
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr9923722ejb.128.1638995878114;
 Wed, 08 Dec 2021 12:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20211208170910.85364-1-nramas@linux.microsoft.com>
In-Reply-To: <20211208170910.85364-1-nramas@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Dec 2021 14:37:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLgKrS_ReuVvyZv+kfGOpvMfQVCo9PAcXVnoLoVZmmdYw@mail.gmail.com>
Message-ID: <CAL_JsqLgKrS_ReuVvyZv+kfGOpvMfQVCo9PAcXVnoLoVZmmdYw@mail.gmail.com>
Subject: Re: [PATCH] [kexec]: arch/arm64/kernel/machine_kexec_file.c:152
 load_other_segments() warn: missing error code 'ret'
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 11:09 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>

Please use get_maintainers.pl so the right people are Cc'ed. In this
case being in arch/arm64, it needs to go to Will and Catalin and
lakml. They will need to apply this.

The subject and commit message needs some work. Something like:

arm64: kexec: Fix smatch 'ret' warning in load_other_segments()

Since commit ac10be5cdbfa ("arm64: Use common
of_kexec_alloc_and_setup_fdt()"), smatch has a warning:

arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments() warn:
missing error code 'ret'

...and then the rest:

> Return code is not set to an error code in load_other_segments() when
> of_kexec_alloc_and_setup_fdt() call returns a NULL dtb. This results
> in status success (return code set to 0) being returned from
> load_other_segments().
>
> Set return code to -ENOMEM if of_kexec_alloc_and_setup_fdt() returns
> NULL dtb.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")

> ---
> Patch created in dt/next branch in git repo
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>
>  arch/arm64/kernel/machine_kexec_file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 63634b4d72c1..04d072885e64 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -149,6 +149,7 @@ int load_other_segments(struct kimage *image,
>                                            initrd_len, cmdline, 0);
>         if (!dtb) {
>                 pr_err("Preparing for new dtb failed\n");
> +               ret = -ENOMEM;
>                 goto out_err;
>         }
>
> --
> 2.25.1
>
