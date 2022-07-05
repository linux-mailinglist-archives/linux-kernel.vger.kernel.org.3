Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA67566A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiGELnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiGELnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:43:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C0F1705A;
        Tue,  5 Jul 2022 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657021384; x=1688557384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WfImbQtfeMtGGz2Cw5g0Es7g3tuLxqK4vIhrQdT+d4M=;
  b=A85DDNCHazegrS6Dqt0itgJpV1tYrdxWLJLTB9F+tD2zL2sHodNJfAlj
   AiO+KmQzY0jwCRLhOLMXegkRoAI7oURgXpBkz/EGhB45Kds6OZRTihxur
   x+v3Uz/KtiRsLoN3iPy9+T/DyGoADozMYJb7cWNVGl8aq5dpe+H15Y/O1
   Cz0i85Df1ch5MdzINYhnqmGdCrkGRGO0uAdLdw/UeQZ/MFp/rFd+N10E9
   hH3VEw9IE+VopBd99Oe9vU4n0Ow7+s3uiWizlHAwxDxsuLNt5N6seoWAj
   xv4SttDS8FBOcOG8oqJ+UQNNE1cmz7g3zNTF80oi9M//VqWhx8ZVrLOiP
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="180778158"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 04:43:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 04:42:57 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 5 Jul 2022 04:42:53 -0700
From:   Daire McNamara <daire.mcnamara@microchip.com>
To:     <conor@kernel.org>, <conor.dooley@microchip.com>
CC:     <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <daire.mcnamara@microchip.com>, <devicetree@vger.kernel.org>,
        <ivan.griffin@microchip.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <palmer@rivosinc.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>,
        <sudeep.holla@arm.com>
Subject: Re: [PATCH] riscv: dts: microchip: hook up the mpfs's l2cache
Date:   Tue, 5 Jul 2022 12:42:30 +0100
Message-ID: <20220705114229.2734205-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629200732.4039258-1-conor@kernel.org>
References: <20220629200732.4039258-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Daire McNamara <daire.mcnamara@microchip.com>

> From: Conor Dooley <conor.dooley@microchip.com>
> Date: Monday, 4 July 2022 at 10:04
> To: FPGA ESS Linux patches <FPGA-ESS-Linux-Patches@microchip.com>
> Cc: Conor Dooley - M52691 <Conor.Dooley@microchip.com>
> Subject: [PATCH] riscv: dts: microchip: hook up the mpfs' l2cache
> 
> The initial PolarFire SoC devicetree must have been forked off from
> the fu540 one prior to the addition of l2cache controller support being
> added there. When the controller node was added to mpfs.dtsi, it was
> not hooked up to the CPUs & thus sysfs reports an incorrect cache
> configuration. Hook it up.
> 
> Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/mpfs.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> index ed8739350587..2df555a57003 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> @@ -50,6 +50,7 @@ cpu1: cpu@1 {
>                          riscv,isa = "rv64imafdc";
>                          clocks = <&clkcfg CLK_CPU>;
>                          tlb-split;
> +                       next-level-cache = <&cctrllr>;
>                          status = "okay";
>  
>                          cpu1_intc: interrupt-controller {
> @@ -77,6 +78,7 @@ cpu2: cpu@2 {
>                          riscv,isa = "rv64imafdc";
>                          clocks = <&clkcfg CLK_CPU>;
>                          tlb-split;
> +                       next-level-cache = <&cctrllr>;
>                          status = "okay";
>  
>                          cpu2_intc: interrupt-controller {
> @@ -104,6 +106,7 @@ cpu3: cpu@3 {
>                          riscv,isa = "rv64imafdc";
>                          clocks = <&clkcfg CLK_CPU>;
>                          tlb-split;
> +                       next-level-cache = <&cctrllr>;
>                          status = "okay";
>  
>                          cpu3_intc: interrupt-controller {
> @@ -131,6 +134,7 @@ cpu4: cpu@4 {
>                          riscv,isa = "rv64imafdc";
>                          clocks = <&clkcfg CLK_CPU>;
>                          tlb-split;
> +                       next-level-cache = <&cctrllr>;
>                          status = "okay";
>                          cpu4_intc: interrupt-controller {
>                                  #interrupt-cells = <1>;
> -- 
> 2.36.1
