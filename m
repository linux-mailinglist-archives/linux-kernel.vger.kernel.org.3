Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8F54E8CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiFPRsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiFPRsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:48:06 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F203ED23;
        Thu, 16 Jun 2022 10:48:05 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id s1so1445013ilj.0;
        Thu, 16 Jun 2022 10:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ET/2NyU63r4lb7KKeDjvDBp7nDdG96w+h335ssSiog=;
        b=OpZ+PDiBWS2IBsNanScudGFJ7SdUh9Ca17E8L0Q2fFf/FvLJuCaVwKX85INia8eRAu
         FsC77btVfWM1N19Ftt04ooUddJnD1E6YVdYGrcJzTCNoKjViyg+vuHJQ65xRbnMh2OuY
         ezCinJQx1o2oq5DfEMhirpzwJHFTTPTmnv+OQPiU6VPNHFjGf1s8S2874qvLXoeuN4iB
         pEjdwPR50aw80DSIhII7DGhEysKZCb/asE+PvhiTzVycmg4woZFxr/ATwL3pwkeKnkKC
         +uRwdVjmXoCP1MgnpDm1zdW6vftq94UKWFxX0eQImaYTbUyREzJNrj/oOlZ9Xynz7X2c
         KqrQ==
X-Gm-Message-State: AJIora/bpy+8di3FzeKJPSLdBpLYJtp1Nktnd1yrl+d3B0FmUqt1dCyd
        UdJTxQwtOHd4eBn4qLX3sg==
X-Google-Smtp-Source: AGRyM1tkquxOwngNmYLC1DvIBwV+F7+tmGMsgoqGqIgigytqdGOE5wBEfYNo7O2CDYJ430ksu1O67w==
X-Received: by 2002:a05:6e02:968:b0:2d3:983d:7e38 with SMTP id q8-20020a056e02096800b002d3983d7e38mr3535849ilt.305.1655401684872;
        Thu, 16 Jun 2022 10:48:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c31-20020a023b1f000000b0032e271a558csm1117289jaa.168.2022.06.16.10.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:48:04 -0700 (PDT)
Received: (nullmailer pid 3710209 invoked by uid 1000);
        Thu, 16 Jun 2022 17:48:03 -0000
Date:   Thu, 16 Jun 2022 11:48:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert
 rda,8810pl-intc to YAML
Message-ID: <20220616174803.GA3710131-robh@kernel.org>
References: <20220611180703.GA24988@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611180703.GA24988@standask-GA-A55M-S2HP>
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

On Sat, 11 Jun 2022 20:07:03 +0200, Stanislav Jakubek wrote:
> Convert RDA Micro interrupt controller bindings to DT schema format.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> 
> Changes in v2:
>   - drop the interrupt sources header file
> 
>  .../interrupt-controller/rda,8810pl-intc.txt  | 61 -------------------
>  .../interrupt-controller/rda,8810pl-intc.yaml | 43 +++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 44 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
> 

Applied, thanks!
