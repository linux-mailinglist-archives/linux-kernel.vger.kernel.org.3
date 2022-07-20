Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5802057AFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiGTEFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiGTEFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:05:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780346254
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E406140D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6449AC341CB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658289912;
        bh=CzFHa1T2nBUH30PXVGgIPY9OIkGOqT8aynKW1aD7qLc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HI87q3/M4gCZ9jBIvGGhF1Cc19IjYDyq2bfCREVi51oKn1oN7vub71W6kyRIn8jS7
         xg+tQODt+cRX12s+n9iPyLZW9RcSQTRzWVAay9Ub8FacYMElthv4PZTT0n7nldy00i
         ARi/NMnHONmHPBqa9fWH8pAIh+5cZNmVETSrk+OYtR0J3+IeLI34kFkyTlpW2arb5s
         D+/8dzJ8D9s2OISmaUBgrGVoksdsZ0SdJ1Z9L+u53/euGdCyZf2GuSlQosIK5V607r
         83PO5h4XN0zTcVsFu7Q/TSexSWPzApMRwFsSg3eEJsOwAOBsj+W7ErviLWI/YTGaQP
         HSaNglD7b2RBQ==
Received: by mail-lf1-f53.google.com with SMTP id d12so28196687lfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:05:12 -0700 (PDT)
X-Gm-Message-State: AJIora+V8jghUMLQTgpcN3+iSgYFS1uKEIPD5b+HKdSrWwC0VHMV2i1F
        NOFua3RbAMCj5xZsVLpOqruJWlR3XaBTH+2r2+c=
X-Google-Smtp-Source: AGRyM1uLXnx3xaLP+f7GMaqugMVNJKZubvmvNn+ehrZ8uHGY/mZSRSbOBGmfq7suVUtc1uF41pvQvBjUHj6+nKWIsdc=
X-Received: by 2002:a05:6512:1394:b0:489:6a91:272a with SMTP id
 p20-20020a056512139400b004896a91272amr18121223lfa.424.1658289910426; Tue, 19
 Jul 2022 21:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220709014929.14221-1-rdunlap@infradead.org>
In-Reply-To: <20220709014929.14221-1-rdunlap@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Jul 2022 12:04:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR27PLRoZGdy_D1YvgCdWdKFo_QVNymML5794mzZ7Ub9Q@mail.gmail.com>
Message-ID: <CAJF2gTR27PLRoZGdy_D1YvgCdWdKFo_QVNymML5794mzZ7Ub9Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix RISCV_ISA_SVPBMT kconfig dependency warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>,
        Liu Shaohua <liush@allwinnertech.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Sat, Jul 9, 2022 at 9:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> RISCV_ISA_SVPBMT selects RISCV_ALTERNATIVE which depends on !XIP_KERNEL.
> Therefore RISCV_ISA_SVPBMT should also depend on !XIP_KERNEL so
> quieten this kconfig warning:
>
> WARNING: unmet direct dependencies detected for RISCV_ALTERNATIVE
>   Depends on [n]: !XIP_KERNEL [=y]
>   Selected by [y]:
>   - RISCV_ISA_SVPBMT [=y] && 64BIT [=y] && MMU [=y]
>
> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Wei Fu <wefu@redhat.com>
> Cc: Liu Shaohua <liush@allwinnertech.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -362,6 +362,7 @@ config RISCV_ISA_C
>  config RISCV_ISA_SVPBMT
>         bool "SVPBMT extension support"
>         depends on 64BIT && MMU
> +       depends on !XIP_KERNEL
>         select RISCV_ALTERNATIVE
>         default y
>         help



-- 
Best Regards
 Guo Ren
