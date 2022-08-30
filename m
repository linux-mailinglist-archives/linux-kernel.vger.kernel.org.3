Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913745A65B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiH3N4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiH3NzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:55:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBAD5D12F;
        Tue, 30 Aug 2022 06:55:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UDssoS015439;
        Tue, 30 Aug 2022 08:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661867694;
        bh=Ibq5djXv+iTal2Io0T+5lRTHqikjmYj4LLSTJV1j26g=;
        h=From:To:CC:Subject:In-Reply-To:References:Date;
        b=rbbO7IEB5gnrOpY5NtxKtoeYusVKfTKtjTNTWgG9v4O7ffdZtsioX5WhG8iXNtDb1
         79SENaqrMaXvs5+3Rj0QWOceX3L16eLfmaZdgSnrPOXxVR7kMzZHSZH+KZNQ4yBaPE
         dXawoeuSiGvemwmxqAYgNSbPjemEX+H17kpP4qME=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UDssgZ101014
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 08:54:54 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 08:54:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 08:54:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UDsrA9082524;
        Tue, 30 Aug 2022 08:54:53 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am64: Add SA2UL address space
 to Main CBASS ranges
In-Reply-To: <20220711085743.10128-2-j-choudhary@ti.com>
References: <20220711085743.10128-1-j-choudhary@ti.com>
 <20220711085743.10128-2-j-choudhary@ti.com>
Date:   Tue, 30 Aug 2022 19:24:53 +0530
Message-ID: <8735ddu98y.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jayesh Choudhary <j-choudhary@ti.com> writes:

> From: Suman Anna <s-anna@ti.com>
>
> Add the address space for the SA2UL in MAIN domain to the ranges property
> of the cbass_main interconnect node so that the addresses within the
> corresponding sram nodes and its children can be translated properly by
> the relevant OF address API.
>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> index 016dd8511ca6..c858725133af 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> @@ -82,6 +82,7 @@
>  			 <0x00 0x3b000000 0x00 0x3b000000 0x00 0x00000400>, /* GPMC0_CFG */
>  			 <0x00 0x3cd00000 0x00 0x3cd00000 0x00 0x00000200>, /* TIMERMGR0_CONFIG */
>  			 <0x00 0x3f004000 0x00 0x3f004000 0x00 0x00000400>, /* GICSS0_REGS */
> +			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA2_UL0 */
>  			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>, /* CTRL_MMR0 */
>  			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
>  			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMASS */

Reviewed-by: Kamlesh Gurudasani <kamlesh@ti.com>
