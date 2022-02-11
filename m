Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAC94B2A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351608AbiBKQjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:39:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349644AbiBKQjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:39:14 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F50FD;
        Fri, 11 Feb 2022 08:39:13 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id s1so9496079qtw.9;
        Fri, 11 Feb 2022 08:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91wBUM1U5Fgu+1y7VkG8fjzKeiOG8ccSLVnmdenYAgc=;
        b=qzv4nq9b4iUxpSKzq/8grp+xNhr7NdiJTXM23eHS1GzMO/rxqPZo0DmvRlg4bN7j1y
         vz+g0kwMlIdPBrFT7+NTsFkddB0ni7cNiMTxMeynhyoh8OUimYYOQ0EPqGBXpCJaHpe6
         q3BwhOoJZgB0SDVWPyDFNl4KzUpE2WG8E4aAqZi3tLzdal4MoP22YlU9JFpQdGjdaDh1
         P6H2HfOnBYoZ7cR/LSEv3yBqhTzh7xMdq0X7ltPcT175WnBUtVo/aBoJT3VvY3HUxy4H
         MJGh9y6nrPVVZjpi4vrkmRJIFGZ9ilcQmGwGwa1RDkoNuhTPwiVHmp6823uWD0YpDXk3
         IQ7w==
X-Gm-Message-State: AOAM530wJMFQV+Sn71I9zUtjj0Vua5XGO4/bn2NPevHyVMmOPrHiBKgb
        IRC86MhAKwREf9jjpLouGA==
X-Google-Smtp-Source: ABdhPJwSVEFpGB453dlo9FfCGEHx6G37GlTlLco94HSNEFo/4ttgi4d9rr4+dNlSqK0nBUsP+D9CBA==
X-Received: by 2002:a05:622a:88:: with SMTP id o8mr1719393qtw.116.1644597552393;
        Fri, 11 Feb 2022 08:39:12 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id j11sm12731354qtx.67.2022.02.11.08.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:39:11 -0800 (PST)
Received: (nullmailer pid 487918 invoked by uid 1000);
        Fri, 11 Feb 2022 16:39:08 -0000
Date:   Fri, 11 Feb 2022 10:39:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: arm: ti: Add bindings for AM625 SoC
Message-ID: <YgaRLOjB0Y0uCY4m@robh.at.kernel.org>
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208131827.1430086-3-vigneshr@ti.com>
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

On Tue, 08 Feb 2022 18:48:24 +0530, Vignesh Raghavendra wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> The AM62 SoC family is the follow on AM335x built on K3 Multicore SoC
> architecture platform, providing ultra-low-power modes, dual display,
> multi-sensor edge compute, security and other BOM-saving integration.
> The AM62 SoC targets broad market to enable applications such as
> Industrial HMI, PLC/CNC/Robot control, Medical Equipment, Building
> Automation, Appliances and more.
> 
> Some highlights of this SoC are:
> 
> * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>   Pin-to-pin compatible options for single and quad core are available.
> * Cortex-M4F for general-purpose or safety usage.
> * Dual display support, providing 24-bit RBG parallel interface and
>   OLDI/LVDS-4 Lane x2, up to 200MHz pixel clock support for 2K display
>   resolution.
> * Selectable GPUsupport, up to 8GFLOPS, providing better user experience
>   in 3D graphic display case and Android.
> * PRU(Programmable Realtime Unit) support for customized programmable
>   interfaces/IOs.
> * Integrated Giga-bit Ethernet switch supporting up to a total of two
>   external ports (TSN capable).
> * 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, GPMC for
>   NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
>   1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
> * Dedicated Centralized System Controller for Security, Power, and
>   Resource Management.
> * Multiple low power modes support, ex: Deep sleep,Standby, MCU-only,
>   enabling battery powered system design.
> 
> AM625 is the first device of the family. Add DT bindings for the same.
> 
> More details can be found in the Technical Reference Manual:
> https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
