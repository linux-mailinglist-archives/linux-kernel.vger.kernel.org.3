Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88C64AA328
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350115AbiBDWdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:33:46 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:47066 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbiBDWdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:33:45 -0500
Received: by mail-oo1-f54.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so6247023ooo.13;
        Fri, 04 Feb 2022 14:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q4Gn8/JIPxPBAROIKOguet0/WP6sycYjFPMRswgQQ08=;
        b=QqLiev350pJ7HKYG0c6KQuJfdMSx+uoRyjc5K75IzCkRO03PIlTHtNLJkRRCoOq3+v
         bI/uWAaR6BbewDeavvdH4JlFCKMDOVLj+Tum1x5DKxt6UY0VdY94ONoVyfpaJkmyoXQW
         2p36jsLy0QW+H2SinZlyq+a9FKUYit/QuAC5SXG52wIo2mGJv2tutY/l0SeVe7HQNEjv
         5/wa7+5hDwo6m98qYuveFqAFYEjvGqhEJeK+gbpRVYtcgVfIkWGQlS5WxZBdfkTlBgEF
         4GySQf+28NlbCy22Ymq4HMJD7HZHvbmwwthIU1IcK2DMo0XKI9/y4eCV0+nFenIRS5VQ
         KlGg==
X-Gm-Message-State: AOAM532ucZvNPAcJDtN8ughIqRnvGp2ACoACRvo+YyJb6KFucAC4ROmt
        /1GaakOUSE3iaoP7TcM7pA==
X-Google-Smtp-Source: ABdhPJxxGFbL+dwr9YXVucvOXSlOKzQXJ55WMPaQbBqLsMQeJKRuakTQZ//ZngXJ3zGtnHxq3V5LEQ==
X-Received: by 2002:a05:6870:d88c:: with SMTP id dv12mr474170oab.113.1644014024814;
        Fri, 04 Feb 2022 14:33:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 127sm1309058oih.8.2022.02.04.14.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:33:44 -0800 (PST)
Received: (nullmailer pid 3305687 invoked by uid 1000);
        Fri, 04 Feb 2022 22:33:42 -0000
Date:   Fri, 4 Feb 2022 16:33:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        hch@lst.de, arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH v5 11/14] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
Message-ID: <Yf2pxvmG0t6eugOz@robh.at.kernel.org>
References: <20220121163618.351934-1-heiko@sntech.de>
 <20220121163618.351934-12-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121163618.351934-12-heiko@sntech.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 05:36:15PM +0100, Heiko Stuebner wrote:
> From: Wei Fu <wefu@redhat.com>
> 
> Previous patch has added svpbmt in arch/riscv and add "riscv,svpmbt"
> in the DT mmu node. Update dt-bindings related property here.
> 
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index aa5fb64d57eb..3ad2593f1400 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -63,6 +63,16 @@ properties:
>        - riscv,sv48
>        - riscv,none
>  
> +  mmu:

riscv,mmu

> +    description:
> +      Describes the CPU's MMU Standard Extensions support.
> +      These values originate from the RISC-V Privileged
> +      Specification document, available from
> +      https://riscv.org/specifications/
> +    $ref: '/schemas/types.yaml#/definitions/string'
> +    enum:
> +      - riscv,svpbmt

Are there per vendor MMU extensions? If not, drop the 'riscv,' part. 

> +
>    riscv,isa:
>      description:
>        Identifies the specific RISC-V instruction set architecture
> -- 
> 2.30.2
> 
> 
