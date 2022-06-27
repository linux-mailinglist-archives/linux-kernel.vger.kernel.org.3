Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8EA55C3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiF0Guo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiF0Gum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5021126C0;
        Sun, 26 Jun 2022 23:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0FA6612EE;
        Mon, 27 Jun 2022 06:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52984C341CA;
        Mon, 27 Jun 2022 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656312641;
        bh=kD7SZF1jNAVPc0INxaOHFTvsDEVbYxB3CbbfNIpTB1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BWRvRLt/oqeA2/Hmle5OVB6hEoiC86UQg676mPsNHKWzzof6dtBDZ0wk6/pFfHycH
         m41UbhTCR8N8VMDQCRFHrtds/D1a0KtPApRKpJOVB00hfAbuyhYpMmKuCZI8cWi/9p
         z0jJmIZ6CJF8XhVqSV+rv2kyzQUUh3I7AxBzgMEsSwlT06PdgD/AUtdeAmLu6s6FNE
         YUUCpO/+M8U3se+4QjdTes5aZSkvcgvdfmTVJuY90L01DeSz6aRQ3TrlDPh64GyO08
         DmkUCiSMCkJW0n+5r4gtnltfcVknBOGjheNWw+Dh3gblXROBSf+Gj1VB2ljGbdxgbJ
         FlFWe8yMTzCoQ==
Received: by mail-vs1-f49.google.com with SMTP id k25so8058589vso.6;
        Sun, 26 Jun 2022 23:50:41 -0700 (PDT)
X-Gm-Message-State: AJIora/J0tlk6qkur92YzNAivdPN0n75oOLNhu1X6xF4f85Nvymgm4qm
        Z31wgGjAafrH68RfY6wBpkH/hOVQ4N+LIpQ+PeI=
X-Google-Smtp-Source: AGRyM1sMPTXuLWt0JOCsNU6oMtoWPerFopULnWcC0H4jByn+qpMAeG/bE/AP0NKukPYSLKCka+W+5Qa2MkXg1Lte8Jk=
X-Received: by 2002:a05:6102:366f:b0:356:352f:9de2 with SMTP id
 bg15-20020a056102366f00b00356352f9de2mr2292856vsb.2.1656312640226; Sun, 26
 Jun 2022 23:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220627051257.38543-1-samuel@sholland.org> <20220627051257.38543-3-samuel@sholland.org>
In-Reply-To: <20220627051257.38543-3-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 27 Jun 2022 14:50:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjcP44+HHsNz8RHHEA_XqL2OjKqVHNK-e3sakFP2oW6w@mail.gmail.com>
Message-ID: <CAJF2gTTjcP44+HHsNz8RHHEA_XqL2OjKqVHNK-e3sakFP2oW6w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] irqchip/sifive-plic: Name the chip more generically
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Mon, Jun 27, 2022 at 1:13 PM Samuel Holland <samuel@sholland.org> wrote:
>
> The interface for SiFive's PLIC was adopted and clarified by RISC-V as
> the standard PLIC interface. Now that several PLIC implementations by
> different vendors share this same interface, it is somewhat misleading
> to report "SiFive PLIC" to userspace, when no SiFive hardware may be
> present. This is especially the case when some implementations are
> subtly incompatible with the binding and behavior of the SiFive PLIC,
> yet are similar enough to share a driver.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  drivers/irqchip/irq-sifive-plic.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bb87e4c3b88e..90515865af08 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -28,6 +28,11 @@
>   * The largest number supported by devices marked as 'sifive,plic-1.0.0', is
>   * 1024, of which device 0 is defined as non-existent by the RISC-V Privileged
>   * Spec.
> + *
> + * The PLIC behavior and memory map is futher formalized as an official RISC-V
> + * specification:
> + *
> + *     https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc
>   */
>
>  #define MAX_DEVICES                    1024
> @@ -177,12 +182,12 @@ static void plic_irq_eoi(struct irq_data *d)
>  }
>
>  static struct irq_chip plic_chip = {
> -       .name           = "SiFive PLIC",
> -       .irq_mask       = plic_irq_mask,
> -       .irq_unmask     = plic_irq_unmask,
> -       .irq_eoi        = plic_irq_eoi,
> +       .name                   = "PLIC",
> +       .irq_mask               = plic_irq_mask,
> +       .irq_unmask             = plic_irq_unmask,
> +       .irq_eoi                = plic_irq_eoi,
>  #ifdef CONFIG_SMP
> -       .irq_set_affinity = plic_set_affinity,
> +       .irq_set_affinity       = plic_set_affinity,
>  #endif
>  };
>
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
