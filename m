Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDCD4DD38C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiCRD13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiCRD11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:27:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BB14F121
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:26:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h16so3630668wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDuSjmRhr8MOV1rhbEGNhveI41ON6vxVElre6la9kK4=;
        b=gQPTka+LUuoi8LUTzV1fKgYIUHP3QdXLh7Rb+5kWyfTZdWiB6/SAIHDcj0/kSCEZgJ
         2gw+Z40Fyf5lKxwBcUFYZEjUrDgrbX879AxVss/Xj0uqEMfm90GbdI4SRvh2YkhQ1YNY
         P+9uCZE6nF6x4E/j3zI0lur7fFO058AYty+26RtTAelygMkaKxgtO5N41P/Tnz7hGsxA
         V3FBMhHMqKk8cWn93Da5qzFkwIyv0sG7VjFHpKYZ0Pv5PIMziBkMSQZJCYhEvwm5JFeZ
         BLkcSTw7m0760UWmBbWK4aj0MoYoXVKU4DqnDqeDRY0wKOkH0bAvhtb7pVWFU6LP9/Ha
         MNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDuSjmRhr8MOV1rhbEGNhveI41ON6vxVElre6la9kK4=;
        b=ECrwRl4aVu6RoRn0hNyNPeZ2lAyIeMaDodQ8i6t4ZM5knMYcexqtzAyXZuTAUlvrym
         rRJXR2DJKeK1eOifU3R4coXCDJ7Vadcza7xIdHaiD2f7zkZM/DkmtYcDOZFkCt1Ay6XI
         5fwUzs1xtOvi/T9aVZBj9YCENrwUc/dqUsc8LPElSu/5EH2BNZsnoFcRVDZiZo9jcnJo
         z32VvhQATKZYfZm18HmUdwRjqEA4HxCa9lJ9q1qPFQKNEoURd3XEb6drXZAduDkPrZx6
         9mDaYiYXGcTa4PIn72a8HLvWEvBdyinc+wv8uKQb8CyAUuUrjgT9PSL92HO1RSWjaNus
         /+og==
X-Gm-Message-State: AOAM530Jj4Xg742DGqhwd+CEkiuL5NGUGJ/8uM1NCuM/IGEb+7fGmPCK
        qf9+kLmnWRjnPGx9KRK4iOSivQKv5XRH53d0xBO7yP1AKM0=
X-Google-Smtp-Source: ABdhPJyTHL26FWcH9VnnHBMM+mTieR7VP1cfwTA4HSK/6ggJqBpHpzhFEL9yEYep6RtE18lyOJhN+b6nTxldom/V5Y0=
X-Received: by 2002:a05:600c:3516:b0:389:f9aa:f821 with SMTP id
 h22-20020a05600c351600b00389f9aaf821mr14115817wmq.73.1647573967585; Thu, 17
 Mar 2022 20:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220304201020.810380-1-atishp@rivosinc.com> <20220304201020.810380-5-atishp@rivosinc.com>
In-Reply-To: <20220304201020.810380-5-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Mar 2022 08:55:56 +0530
Message-ID: <CAAhSdy3bPuhqcZWpZpDP_DGiMEc97aMEjspum4K9k0D=24fYsg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/7] RISC-V: KVM: Remove 's' & 'u' as valid ISA extension
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 5, 2022 at 1:40 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> There are no ISA extension defined as 's' & 'u' in RISC-V specifications.
> The misa register defines 's' & 'u' bit as Supervisor/User privilege mode
> enabled. But it should not appear in the ISA extension in the device tree.
>
> Remove those from the allowed ISA extension for kvm.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Both PATCH4 and PATCH5, fix the "isa" config register of one_reg interface.

Can you send PATCH4 (i.e. this patch) and PATCH5 separately with the
"Fixes:" tag so that we can have these patches as RC fixes ?

Regards,
Anup


> ---
>  arch/riscv/kvm/vcpu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 624166004e36..3ae545e7b398 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -43,9 +43,7 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
>                                  riscv_isa_extension_mask(d) | \
>                                  riscv_isa_extension_mask(f) | \
>                                  riscv_isa_extension_mask(i) | \
> -                                riscv_isa_extension_mask(m) | \
> -                                riscv_isa_extension_mask(s) | \
> -                                riscv_isa_extension_mask(u))
> +                                riscv_isa_extension_mask(m))
>
>  static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
>  {
> --
> 2.30.2
>
