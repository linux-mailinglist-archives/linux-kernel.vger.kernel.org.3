Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F02B5988FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbiHRQgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343580AbiHRQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:36:34 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A95BD0A1;
        Thu, 18 Aug 2022 09:36:33 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id b15so1066943ilq.10;
        Thu, 18 Aug 2022 09:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=M8whQnh20c5DrO/g1DklkK8u4I+Jzv+7yqvteJMRnk4=;
        b=uc+3/DVjnKdEL37j8zBwTxKI9lnFcxv6WyWA5FbyIp/HFdu/P/ZryenVxDFWVsSI5Z
         LEuLILWOUgz9KvCt6f1AdNpLY15nSHelvTWMx00ucmAIvfnYcH3vtdPgkMXRhjonhnGV
         9sYvUCveSFsoJw41AMePKIEw6zNCHL15asLgOU0Ny2QxELXLp4zjX1QKt4CnwZh6i3BJ
         IExCivMCuAG3t5kskcT5igKvmcqCVTSOinMoXS3pEIv8gfr4F3IzjuhK2PoPeC75IUoJ
         otfz23ELEZLOgfJiWbJzh/6dKWed0tybsplJtSPnA3Sn9BylY//D9mp0cNbC9rLoTVFf
         s1Aw==
X-Gm-Message-State: ACgBeo3tqvZU9mEBLMXPN5mwV/GnWIbYH0WwPDQCdSX8/qrpmdoBG0oC
        qL+UD6ybsP+n2jt5zC1CFw==
X-Google-Smtp-Source: AA6agR6BO8dOlPsFEFWhj5EUY+W39h9E7U+aGdI6szZ6ee6PCPM3WFIUVT1ZpBVnS1ZlkaHZq6Da7g==
X-Received: by 2002:a05:6e02:de2:b0:2e6:691f:eda5 with SMTP id m2-20020a056e020de200b002e6691feda5mr1785399ilj.279.1660840592441;
        Thu, 18 Aug 2022 09:36:32 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:647:4ff2:3529:f8cd:d6cd:ac54])
        by smtp.gmail.com with ESMTPSA id x10-20020a056e021bca00b002e9256ab3f6sm177238ilv.31.2022.08.18.09.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:36:31 -0700 (PDT)
Received: (nullmailer pid 1996122 invoked by uid 1000);
        Thu, 18 Aug 2022 16:36:26 -0000
Date:   Thu, 18 Aug 2022 10:36:26 -0600
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
Subject: Re: [PATCH v3 1/4] dt-bindings: timer: sifive,clint: add legacy
 riscv compatible
Message-ID: <20220818163626.GC1978870-robh@kernel.org>
References: <20220817201212.990712-1-mail@conchuod.ie>
 <20220817201212.990712-2-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817201212.990712-2-mail@conchuod.ie>
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

On Wed, Aug 17, 2022 at 09:12:10PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> While "real" hardware might not use the compatible string "riscv,clint0"
> it is present in the driver & QEMU uses it for automatically generated
> virt machine dtbs. To avoid dt-validate problems with QEMU produced
> dtbs, such as the following, add it to the binding.
> 
> riscv-virt.dtb: clint@2000000: compatible:0: 'sifive,clint0' is not one of ['sifive,fu540-c000-clint', 'starfive,jh7100-clint', 'canaan,k210-clint']
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/timer/sifive,clint.yaml           | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
