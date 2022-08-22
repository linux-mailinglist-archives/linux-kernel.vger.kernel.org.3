Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA159C866
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiHVTPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiHVTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:14:53 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ACD2F381;
        Mon, 22 Aug 2022 12:14:46 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-11c896b879bso14076782fac.3;
        Mon, 22 Aug 2022 12:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+9mYtYRdtFYJ0G4uhdbdFfotHF7Sh4Tm00IctJc4L4s=;
        b=PDvyOTd4ewNzUM1BUZaKm/vj5dItr+56cU6UuzIE5XGvD7WOAgNbwz67E8qlXhHbuM
         fSXg3p/+lBXmhyX8P91qdrx4+glo0TBcl2M6WV+M0BkNLt6L+Fj87z1tthju+WHVBK1L
         utKaIHZf4lPeRyvZNLPmKESVnwwIUq8RM2t2BZ8y/hLxYBSEveUrqEyD6BGwxvr3peoG
         bJTdMxJUjnePlzlVx86amAbdLgVk5lyffMqRrfqZGS7U+k569uqpd/b28lAjofic59S0
         8mxznaKb3dJrDGrKnW2CfXJNRQHyoovSGa9WjyDWRLEDfgIuwUPAr6UzWSSHdpZsweFe
         mUgA==
X-Gm-Message-State: ACgBeo032mSJaADijtwIUhNcr5Hqnr3s6I9sHtKEM0AGOT1mI7NuNwSw
        +Y/0REdVgndj1//aKA4Jaw==
X-Google-Smtp-Source: AA6agR5oYMphkHrwtR9ftlAb0utmEIuJpCmM4Twje7fpd6P2+GKlfXYkStDRhzqW/KE83WCop63FmA==
X-Received: by 2002:a05:6870:6193:b0:11d:3674:69e3 with SMTP id a19-20020a056870619300b0011d367469e3mr3957587oah.83.1661195686011;
        Mon, 22 Aug 2022 12:14:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g203-20020aca39d4000000b00342d18cc2fdsm2731970oia.53.2022.08.22.12.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:14:45 -0700 (PDT)
Received: (nullmailer pid 248067 invoked by uid 1000);
        Mon, 22 Aug 2022 19:14:43 -0000
Date:   Mon, 22 Aug 2022 14:14:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: irqchip: ti,sci-inta: Fix warning
 '#interrupt-cells' was unexpected
Message-ID: <20220822191443.GA247988-robh@kernel.org>
References: <20220819190729.32358-1-a-nandan@ti.com>
 <20220819190729.32358-2-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190729.32358-2-a-nandan@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022 00:37:27 +0530, Apurva Nandan wrote:
> #interrupt-cells = <0> property is required in device tree for
> ti,sci-inta nodes, or else we will have following warning when building
> device tree files with W=2 warning level.
> 
> arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:147.51-156.5: Warning (interrupt_provider): /bus@100000/main-navss/interrupt-controller@33d00000: Missing #interrupt-cells in interrupt provider
> 
> And further, #interrupt-cells is required to be in yaml bindings as well
> to prevent following schema warnings:
> 
> k3-j721e-common-proc-board.dtb: interrupt-controller@33d00000: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
> From schema: linux/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
> 
> Add #interrupt-cells property in ti,sci-inta.yaml
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  .../devicetree/bindings/interrupt-controller/ti,sci-inta.yaml  | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
