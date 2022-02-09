Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004E74AE68F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbiBICj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241352AbiBIAxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:53:40 -0500
X-Greylist: delayed 1097 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 16:53:39 PST
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED9BC061576;
        Tue,  8 Feb 2022 16:53:39 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2190ZJv1007030;
        Tue, 8 Feb 2022 18:35:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644366919;
        bh=5EyyxMNHjefrxCy8IJH40Emcq2IkwFCHgOrxbd6LIHE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=FhUjrGWYeBwvuzWGaN1S41g+P6leu+LOxvWnb5NiRcblwhffNceyhWeijbHboZsaZ
         2EsiHpM5hhBXhSpYd/mejaCf+9jNwLQOu7GVs4ubndbrIYQ5kHMiEPcG5ByRXLHI7v
         vkqkropLC4NhQ0KEYtlPIdWXczUHcPX94QML7tY0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2190ZJVQ017346
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Feb 2022 18:35:19 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 8
 Feb 2022 18:35:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 8 Feb 2022 18:35:19 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2190ZJUm040029;
        Tue, 8 Feb 2022 18:35:19 -0600
Date:   Tue, 8 Feb 2022 18:35:19 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64: Add ESM0 to device memory map
Message-ID: <20220209003519.clokfvln7m2deewi@buddhism>
References: <20220208182119.24707-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220208182119.24707-1-hnagalla@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please loop in LAKML as stated in MAINTAINERS file.

On 12:21-20220208, Hari Nagalla wrote:
> AM64x SoCs have two ESM modules, with one in MAIN voltage domain and the
> other in MCU voltage domain. The error output from Main ESM module can
> be routed to the MCU ESM module. The error output of MCU ESM can be
> configured to reset the device.

So what happens to the window for MCU ESM - Is that already open?

> 
> For ESM details please refer technical reference manual at
> https://www.ti.com/lit/pdf/spruim2
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> index 120974726be8..0622a93ec136 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> @@ -66,6 +66,7 @@
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges = <0x00 0x000f4000 0x00 0x000f4000 0x00 0x000002d0>, /* PINCTRL */
> +			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
>  			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
>  			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
>  			 <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
