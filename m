Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF34C6D76
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiB1NKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiB1NKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:10:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA97804F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:10:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s1so15338524wrg.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+tfmzsAwXlzwGA/68yHJ/dxS4HEgSBaoMff0gqNFjw=;
        b=XLm9GW/kvlSiLN8LraAP1WxOyk/8vHRHY+CejJ+XDoLmis0woM7v0Txmy7NBB5WddD
         UeU3mP2QK6Ahu1W/QcU02gdUZhZor8BeG6DUULAKiVpgdstxhIrjZKZ5jLk8P66gudcP
         KNYGyvvPcbELGHGcx8beJtj8UfDT12pNqeIJ2eBaH7+aQM/PkolEoEhaXu5Q5huCFcyS
         u3n+aJIu90mB0gHTsqTdgoEuWN0Sw8zPAeV8uFoz9tpQZr6J9ipAOFjrShB5rCzaFzDE
         r8ha7JiYIRd6fPWb5LCKWb7N1if9SnODnwGIA4/QV5AWLSFFTc8Cfhl3jwWnTSZ6RhTd
         LzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+tfmzsAwXlzwGA/68yHJ/dxS4HEgSBaoMff0gqNFjw=;
        b=GROqCx6ccAyQ9UVSxNRTO5y82PZdFVnyU1ybyXokkNWfFhkAoAVNsI8y+lntmSYSND
         zqMRPQ+C3EKj8KCcsDvyltKg8FM++k/a3W+FsFWWliZ+zBSQT4wLCTl6WDjrm4rQlOLh
         6Z9C29MwVEYZldyIiT7EbtECcpdL6NFaHM5dyb3jcRLHNBpJ6AmRvaggf2UmwGXtMwjc
         +XymQaIJjgC+5VhZu4O/PVSV8y1yDKk0QRVbz9C444KK9IgDy5jtp6oK5C8jwcPAL1P2
         kpbxpPgz4uhWFm4JeJwc1Lb+Zdi0Cx32EiOgfbrU+X5AEusx4W2HzMQaQRojuKeM7G7P
         a9KA==
X-Gm-Message-State: AOAM531gf4F/Qtp0hSLqIpHL5GwIWnKZftP50l+8hXyBIpSxavug9rvx
        Ak8IAGhPh/Y1vNzhaK7abylDj75y0jvVrCaTD1kl4A==
X-Google-Smtp-Source: ABdhPJwpYbHtsKqzvUh856LHTzTP6NBw6Ufzhzl1fuggS7R7Iuv7uS137uKXoomI1n9T2jbuozxHNd7ywAOKOGSkBt8=
X-Received: by 2002:a5d:64a8:0:b0:1ef:f99c:8c12 with SMTP id
 m8-20020a5d64a8000000b001eff99c8c12mr780480wrp.214.1646053813809; Mon, 28 Feb
 2022 05:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20220216052110.1053665-1-mchitale@ventanamicro.com> <20220216052110.1053665-2-mchitale@ventanamicro.com>
In-Reply-To: <20220216052110.1053665-2-mchitale@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 28 Feb 2022 18:39:44 +0530
Message-ID: <CAAhSdy2imgdYY8nv30Z_Am1PmR83uBy041H07N2+YivnRJN1kg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] riscv: enum for svinval extension
To:     Mayuresh Chitale <mchitale@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:51 AM Mayuresh Chitale
<mchitale@ventanamicro.com> wrote:
>
> Similar to the other ISA extensions, this patch enables
> callers to check for the presence for the svinval extension.
>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>

Please update riscv_fill_hwcap() in arch/riscv/kernel/cpufeature.c
to probe Svinval extension.

Regards,
Anup

> ---
>  arch/riscv/include/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpu.c        | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 691fc9c8099b..bbff7cb279ea 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -51,6 +51,7 @@ extern unsigned long elf_hwcap;
>   * available logical extension id.
>   */
>  enum riscv_isa_ext_id {
> +       RISCV_ISA_EXT_SVINVAL = RISCV_ISA_EXT_BASE,
>         RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ced7e5be8641..ff0613f8cc39 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -71,6 +71,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>         }
>
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
> +       __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>         __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>
> --
> 2.25.1
>
