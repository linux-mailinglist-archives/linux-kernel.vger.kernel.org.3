Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C64BE9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358384AbiBUM4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:56:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiBUM4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:56:02 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3531C10F;
        Mon, 21 Feb 2022 04:55:39 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21LCtNQl071574;
        Mon, 21 Feb 2022 06:55:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645448123;
        bh=Ldesc9E9S6OV1ULQBDllRREpqpso1MX11dz5s4qIfkE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bN3yr06kwogpyXgikL5UHPTiPSSyPuoFfAMjZFdF0kxOpZU1h3oeDpIezYGXghR75
         HP5cueo8zogJ5n4Sptor4c0ktOsbf6t2FR5kReY4TjpineJZfnf0golZj90l0HbGze
         EZgzEQGZohwP8/Z3J/yWSFDWrbYL3BDLK/DDVRd4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21LCtMlw059858
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Feb 2022 06:55:22 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 21
 Feb 2022 06:55:22 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 21 Feb 2022 06:55:22 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21LCtM5f038962;
        Mon, 21 Feb 2022 06:55:22 -0600
Date:   Mon, 21 Feb 2022 06:55:22 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Drew Fustini <dfustini@baylibre.com>
CC:     =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, <devicetree@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, <s-anna@ti.com>,
        <khilman@baylibre.com>
Subject: Re: [PATCH 02/11] dt-bindings: wkup_m3_ipc: Add vtt toggling bindings
Message-ID: <20220221125522.l3tntb6i7yjxp6vb@flattered>
References: <20220219215328.485660-1-dfustini@baylibre.com>
 <20220219215328.485660-3-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220219215328.485660-3-dfustini@baylibre.com>
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

On 13:53-20220219, Drew Fustini wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Add description of the wkup_m3_ipc DT properties that can be used to
> toggle VTT regulator during low power mode transitions.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  .../bindings/soc/ti/wkup_m3_ipc.txt           | 34 +++++++++++++++++++


NAK. no more txt files please. convert to yaml prior to adding features.

>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
> index 401550487ed6..4cdbb60fd0d0 100644
> --- a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
> +++ b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
> @@ -55,3 +55,37 @@ Example:
>  			...
>  		};
>  	};
> +
> +Support for VTT Toggle
> +==================================
> +In order to enable the support for VTT toggle during Suspend/Resume
> +sequence needed by some boards (like AM335x EVM-SK & AM437x GP EVM),
> +the below DT properties are required. It is possible to toggle VTT
> +using one of two methods depending on the SoC being used, either
> +GPIO0 toggle (AM335x and AM437x), or any GPIO with DS_PAD_CONFIG
> +bits in the control module (AM437x only).
> +
> +VTT Toggle using GPIO0
> +----------------------------------
> +Supported by: AM335x and AM437x
> +Used on: AM335x EVM-SK
> +
> +Optional properties:
> +- ti,needs-vtt-toggle:	Indicates that the boards requires VTT toggling
> +			during suspend/resume.
> +- ti,vtt-gpio-pin:	Specifies the GPIO0 pin used for VTT toggle.
> +
> +Important Note:
> +- Here it is assumed that VTT Toggle will be done using a pin on GPIO-0 Instance.
> +  It will not work on any other GPIO using the above properties, regardless of
> +  which part is being used.
> +
> +Example:
> +	wkup_m3_ipc: wkup_m3_ipc@1324 {
> +		compatible = "ti,am3352-wkup-m3-ipc";
> +		...
> +		...
> +		ti,needs-vtt-toggle;
> +		ti,vtt-gpio-pin = <7>;
> +		...
> +	};
> -- 
> 2.32.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
