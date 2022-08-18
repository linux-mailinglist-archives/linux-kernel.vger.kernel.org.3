Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21B598900
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344832AbiHRQg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343580AbiHRQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:36:57 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE3ABD28E;
        Thu, 18 Aug 2022 09:36:55 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id z72so1480198iof.12;
        Thu, 18 Aug 2022 09:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EsZP3ELRo6TTGsFBmByT42JNw5wBc7RlaMRIBETg5Gc=;
        b=Zp2w9mVrisi8zlrYNsIIKp9yEvxq/4/fQRSqXMDGCG+MXBk6OqDys0DJoeVMgvIO4X
         De1eJmQGlA4ZR8f+0LaXP0eLLF7A2TZO9/rwwNxejv7lG1EXOOS+90RNFvxSKw3qzmE4
         K8uL0SQ19ui8oCwNAYi2QnO1ruTYBGDxVBkH/a53XyMK0dIMn0lkl6QXAUUxftF7Mwes
         FD2jFtuxTP4nXs1uJ4xOaVSlbnCTLH9Kp1UCo9KJz8ire6Kfx8qC9TvyqvlkwJK5ha/V
         +lsgftTnXKTnOA5uJE9DbBR2TSXMRsQUrdqsHUsPicNJYDjNu/XQuTI/xqwGFfxFQI/t
         1wFw==
X-Gm-Message-State: ACgBeo0VbclgPS7c71bpk+pHlqRiH/kDQVAjxJJ/LUNCouAmsDTtunHb
        UxV2FOKD1VilVpnDfM84rA==
X-Google-Smtp-Source: AA6agR7XYb4e6JSFTnrS/q7WlPl4E2gg4SEWAy++LgChjlcloI3dnrD9XsgcrfX8E4rSums27VI5/w==
X-Received: by 2002:a05:6602:330e:b0:67b:9fed:49db with SMTP id b14-20020a056602330e00b0067b9fed49dbmr1740842ioz.54.1660840614873;
        Thu, 18 Aug 2022 09:36:54 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:647:4ff2:3529:f8cd:d6cd:ac54])
        by smtp.gmail.com with ESMTPSA id b40-20020a0295ab000000b003427281824csm756542jai.128.2022.08.18.09.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:36:54 -0700 (PDT)
Received: (nullmailer pid 1996636 invoked by uid 1000);
        Thu, 18 Aug 2022 16:36:48 -0000
Date:   Thu, 18 Aug 2022 10:36:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 2/4] dt-bindings: interrupt-controller: sifive,plic:
 add legacy riscv compatible
Message-ID: <20220818163648.GD1978870-robh@kernel.org>
References: <20220817201212.990712-1-mail@conchuod.ie>
 <20220817201212.990712-3-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817201212.990712-3-mail@conchuod.ie>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 09:12:11PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> While "real" hardware might not use the compatible string "riscv,plic0"
> it is present in the driver & QEMU uses it for automatically generated
> virt machine dtbs. To avoid dt-validate problems with QEMU produced
> dtbs, such as the following, add it to the binding.
> 
> riscv-virt.dtb: plic@c000000: compatible: 'oneOf' conditional failed, one must be fixed:
>         'sifive,plic-1.0.0' is not one of ['sifive,fu540-c000-plic', 'starfive,jh7100-plic', 'canaan,k210-plic']
>         'sifive,plic-1.0.0' is not one of ['allwinner,sun20i-d1-plic']
>         'sifive,plic-1.0.0' was expected
>         'thead,c900-plic' was expected
> riscv-virt.dtb: plic@c000000: '#address-cells' is a required property
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml     | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
