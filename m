Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD9463DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbhK3Ss7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:48:59 -0500
Received: from gloria.sntech.de ([185.11.138.130]:50206 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239001AbhK3Ss5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:48:57 -0500
Received: from ip5f5b2004.dynamic.kabel-deutschland.de ([95.91.32.4] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ms881-0006bu-6m; Tue, 30 Nov 2021 19:45:21 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     anup.patel@wdc.com, atishp04@gmail.com, palmer@dabbelt.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org,
        linux-riscv@lists.infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, arnd@arndb.de, wens@csie.org,
        maxime@cerno.tech, dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh+dt@kernel.org>, wefu@redhat.com
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
Date:   Tue, 30 Nov 2021 19:45:19 +0100
Message-ID: <10924379.EydaIB8Zb3@diego>
In-Reply-To: <20211129014007.286478-2-wefu@redhat.com>
References: <20211129014007.286478-1-wefu@redhat.com> <20211129014007.286478-2-wefu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 29. November 2021, 02:40:06 CET schrieb wefu@redhat.com:
> From: Wei Fu <wefu@redhat.com> 
> 
> Previous patch has added svpbmt in arch/riscv and add "riscv,svpmbt"
> in the DT mmu node. Update dt-bindings related property here.
> 
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index aa5fb64d57eb..9ff9cbdd8a85 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -63,6 +63,16 @@ properties:
>        - riscv,sv48
>        - riscv,none
>  
> +  mmu:
> +    description:
> +      Describes the CPU's MMU Standard Extensions support.
> +      These values originate from the RISC-V Privileged
> +      Specification document, available from
> +      https://riscv.org/specifications/
> +    $ref: '/schemas/types.yaml#/definitions/string'
> +    enum:
> +      - riscv,svpmbt

shouldn't that be "riscv,svpbmt" ? [the m is at the wrong location it seems]

> +
>    riscv,isa:
>      description:
>        Identifies the specific RISC-V instruction set architecture
> 




