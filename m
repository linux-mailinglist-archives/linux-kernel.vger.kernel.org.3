Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B105807F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbiGYXGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGYXGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:06:40 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5AF13F6B;
        Mon, 25 Jul 2022 16:06:39 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id n16-20020a4a9550000000b0043568f1343bso2435424ooi.3;
        Mon, 25 Jul 2022 16:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhEaSHQR4f/8hLraGFE+9LlVTZgeLV3rteyyTTidIjk=;
        b=sZF1NbBKhVGlS/L1XsAhhCk4oetb2jYZJRYJaK5APb5US2Px7oZ3jTg9Kg183Hv+oc
         ohtqXnY67S0nQ0KVoYFY55qE9MLPRq1iFDh+oUvo76tKGDmyQypL1+K2qPWaOwa2SAV/
         L8ls4Kbhf2GkwMyfu5/3wNvdKpw+LcYjQd3smTeQaXFQkxPZ+QsRHSC+eKim0sGCb6H1
         yLR4tkw9t3/iuINThRUU579EvhrA98r73osiaCasL/Zzkt8C6BPoe+8Boo9Ds0rD1SQH
         FeZ0B0XFnAxEzgTAd10Bok0eAHYGOSGnUFqHAYBwW9VVsSeCWN/X05BT5xQdnupmz0KK
         Chig==
X-Gm-Message-State: AJIora9W/hXzoJ3/wMdNlw2dkze6zAUmtQhwoZojDt69S2vowLNjgb2o
        hzakts8+v0WJ/8rb2eA8Ng==
X-Google-Smtp-Source: AGRyM1uWXbzqvCB09wbBdY4RhmV9MqfiKdcKzlsfS4eiVYuIla5/jtCEi4xIghtxm6uXUVPDYWj8NQ==
X-Received: by 2002:a4a:d54a:0:b0:435:c4e7:77ce with SMTP id q10-20020a4ad54a000000b00435c4e777cemr4960249oos.67.1658790398832;
        Mon, 25 Jul 2022 16:06:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x24-20020a056870a79800b0010830c24aaasm6963744oao.56.2022.07.25.16.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:06:38 -0700 (PDT)
Received: (nullmailer pid 2920430 invoked by uid 1000);
        Mon, 25 Jul 2022 23:06:36 -0000
Date:   Mon, 25 Jul 2022 17:06:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: interrupt-controller: Add macros for
 NMI and IRQ0-7 interrupts present on RZ/G2L SoC
Message-ID: <20220725230636.GA2920367-robh@kernel.org>
References: <20220722151155.21100-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220722151155.21100-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722151155.21100-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 16:11:53 +0100, Lad Prabhakar wrote:
> Add macros for NMI and IRQ0-7 interrupts which map to SPI0-8 present on
> RZ/G2L (and alike) SoC's so that these can be used in the first cell of
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3:
> * New patch as suggested by Biju and Geert.
> ---
>  .../interrupt-controller/irqc-rzg2l.h         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/interrupt-controller/irqc-rzg2l.h
> 

Acked-by: Rob Herring <robh@kernel.org>
