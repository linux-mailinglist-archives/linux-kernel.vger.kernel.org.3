Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777BB50299B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353287AbiDOM1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348932AbiDOM1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:27:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC01C12D3;
        Fri, 15 Apr 2022 05:24:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3B12D1F47DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650025445;
        bh=pP5XfXInasJ+Um4d51PqpWs2On4DNzbLzPuK/Aw3uio=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YIXSNX2Zfta1TwhcTA+ti7O8vcbpINLJGlIKvLeCXzq4Px8K3Bobjzok0S34BzcBQ
         iT3eysZ27LRanm+Z7lBL0UGOTCO29IsV/vsJMlqfgOGVc4+1p4gnWAwXs1Z7y1/UM8
         DTleqEJPeHGzHNMtJRqVXoieAzNKFatVy49xcpLDLt47BmLwWYDvMCUZbQ2w4jgoIH
         9op85MPGmQrQWhLfpQ5w+BQ1QXqkNDhPSeUDPULVbVQnaZxIwzO6ZhlF0sg6ASWESw
         GQi1codrRws+qJntMm82m/lxu0y8pyVIoOIgnitckUQXmHBzMe7BtrPmlltPl5q4B2
         Mzww8j3ukUbiQ==
Message-ID: <a1ae5616-48b8-054b-aad3-a9569eed20e1@collabora.com>
Date:   Fri, 15 Apr 2022 14:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 13/15] arm64: dts: mediatek: Add opp table and clock
 property for MT8183 cpufreq
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
 <20220415055916.28350-14-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415055916.28350-14-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/04/22 07:59, Rex-BC Chen ha scritto:
> - Add cpufreq opp table.
> - Add MediaTek cci opp table.
> - Add property of opp table and clock fro cpufreq.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  32 +++
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 270 ++++++++++++++++++++
>   2 files changed, 302 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index f3fd3cca23e9..8953dbf84f3e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 4b08691ed39e..4ae3305d16d2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -42,6 +42,244 @@
>   		rdma1 = &rdma1;
>   	};
>   
> +	cluster0_opp: cluster_opp_table0 {

Please don't use underscores in devicetree for anything that's not a phandle.

	cluster0_opp: cluster0-opp-table {

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		opp0_00 {

Apart from the underscore being invalid, across the kernel, you can find many
instances of opp tables, containing names related to the frequencies, so, for
consistency (this is not a rule!), perhaps it would be a good idea to do so.

		opp-793000000 {

> +			opp-hz = /bits/ 64 <793000000>;
> +			opp-microvolt = <650000>;
> +			required-opps = <&opp2_00>;
> +		};
> +		opp0_01 {

		opp-910000000 {

> +			opp-hz = /bits/ 64 <910000000>;
> +			opp-microvolt = <687500>;
> +			required-opps = <&opp2_01>;
> +		};
> +		opp0_02 {

..snip..

> +		opp0_15 {
> +			opp-hz = /bits/ 64 <1989000000>;
> +			opp-microvolt = <1050000>;
> +			required-opps = <&opp2_15>;

P.S.: Please fix the typo below!

> +		};	};
> +
> +

...also...

> +	cci_opp: opp_table2 {

	cci_opp: cci-opp-table {

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		opp2_00: opp-273000000 {

This one is fine instead :))

Cheers,
Angelo
