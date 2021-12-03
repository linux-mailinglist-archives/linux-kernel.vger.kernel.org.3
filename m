Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F85B467821
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352440AbhLCN07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhLCN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:26:58 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0885DC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:23:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso4879280wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 05:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lR8aeSNSNLSRJzVlwsyGcPcDwOiHsBURE+5SKLZfSus=;
        b=6qJDAtvDHsWsCS6gT+mxqgayP1XkZWPCGcSc4oQn7JcEH/9ttXWpQWHWlGuwMdmi4E
         43pIhjFbvu2fWtth1sComt1QTHASYfHZure9BVnwM7ACgwj7iayHGCV+j02eTu7KvdfC
         AuvuUOv0SFRCk6iel2jqGqVnzfqXPX3B2ZIEUWfxa63Grif5TDwUc2/xXikZIac46mrW
         kFWGsT/yphAFQ6N2hcl2Pq0TlQR4eCO3tFdK6xWhCid6Ge1Uo+GkE8+4saVIeRgFtwHP
         uIFNu7s4yhODqkB/SCWW/N/osvsqSgf3pJdw3mgG9gyUomdu0EtJf8TzRK8yBq/TChxX
         Q2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lR8aeSNSNLSRJzVlwsyGcPcDwOiHsBURE+5SKLZfSus=;
        b=KeLnGqkW5IZ5PSbAIItAOXEHRZNX2ARMgY8/mBz2GoKvxc4UWr8AZFZX++CXr+A3/A
         oldJn+3Ksdpp1sgOEjBq0bsRbzv2DcAZVi97CCmF+qQuh8YdTc/ffdRIF3ZFz+j1TByG
         wKPW1fwiulUdJvPI/HG6SvvvC521tJ25/307OJvPzLpZL9J9x9xvgNZu3/LqXr8iH2RE
         lneiwBdNmtxMdQriNpgwIdKQprONfipcwX2CdJfCBCBuD1qYk1BrzTyrASoXAcqpZVRd
         Wf00LS85qFWBlYE3eXBdeNGQhSomFsRvp429JBj/Tdq4HF1yKmCTSWv7DdYUfjbc099N
         LRIQ==
X-Gm-Message-State: AOAM532OIAtYROXiPlOh7bOn9bEi6iFckbFNjs0KqKA51KgbJXw6QRYQ
        sn/Xa1O96a0ROJdYhyL9NDCZaFLmlZOvfzX3EORoRQ==
X-Google-Smtp-Source: ABdhPJzAviTqyJhhuy+8EWcURnRhUhc+e5w/j54dpEC5njH38p4a8pfE/ForU6RfTu/bxPY67H+3bjNgiRiD4nbdK9M=
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr15086969wmq.59.1638537812348;
 Fri, 03 Dec 2021 05:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20211128160741.2122-1-jszhang@kernel.org> <20211128160741.2122-4-jszhang@kernel.org>
In-Reply-To: <20211128160741.2122-4-jszhang@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 3 Dec 2021 18:53:20 +0530
Message-ID: <CAAhSdy1ChQ6A0_zkOFFCO1dJypaK3-9RndRNLn-sNK1hNJKQEQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] riscv: kvm: make kvm_riscv_vcpu_fp_clean() static
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 9:45 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> There are no users outside vcpu_fp.c so make kvm_riscv_vcpu_fp_clean()
> static.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

I have queued this patch for 5.17

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_fp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
> index 1b070152578f..4449a976e5a6 100644
> --- a/arch/riscv/kvm/vcpu_fp.c
> +++ b/arch/riscv/kvm/vcpu_fp.c
> @@ -26,7 +26,7 @@ void kvm_riscv_vcpu_fp_reset(struct kvm_vcpu *vcpu)
>                 cntx->sstatus |= SR_FS_OFF;
>  }
>
> -void kvm_riscv_vcpu_fp_clean(struct kvm_cpu_context *cntx)
> +static void kvm_riscv_vcpu_fp_clean(struct kvm_cpu_context *cntx)
>  {
>         cntx->sstatus &= ~SR_FS;
>         cntx->sstatus |= SR_FS_CLEAN;
> --
> 2.34.0
>
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
