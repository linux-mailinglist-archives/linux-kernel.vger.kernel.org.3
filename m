Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8127C4B3953
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 05:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiBMEYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 23:24:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiBMEYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 23:24:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A885DE76;
        Sat, 12 Feb 2022 20:23:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B0560E65;
        Sun, 13 Feb 2022 04:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CC8C004E1;
        Sun, 13 Feb 2022 04:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644726234;
        bh=aHTWD3d99iGIWG+QZ4rAoUAw+ucVkDuzXZY9VQTriU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZH3bT0s4bI6Xjihho+Jvh5okFEQ8uRQRKAipRTl1C+HwdRpxwqrbR8dv5TTZc83K
         sK/4UA+wpJgME4X0qnx7XwcP9n0DFuRIO3rvLTZ2qaR52Exf+qFwnIeYr/EZsLY9OJ
         BT+y63zdLoYHoSnGZpeY2RARCNvTLNMq5X+BpHjie8UtFLr8JGRkEz9D94OavkYruv
         S0I4rMoS8zbFEpbTRTm5PyPMnUPwRwmPRuejVfCZyMv91EtzyFOZaLZBR2kBEsjUEe
         ce5/xVFR629YIBXof0lSbDqW7kwVdek0oN764sZdvq8t8BDDRZtro+MvOKIXpUwcja
         3nqkIgyiDwp1w==
Date:   Sun, 13 Feb 2022 12:23:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yunus Bas <y.bas@phytec.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] ARM: dts: imx6qdl: phycore-som: Add custom
 volt/freq table
Message-ID: <20220213042348.GM4909@dragon>
References: <20220209223258.1672425-1-y.bas@phytec.de>
 <20220209223258.1672425-2-y.bas@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209223258.1672425-2-y.bas@phytec.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 11:32:58PM +0100, Yunus Bas wrote:
> The PHYTEC phyCORE-i.MX6QDL SOM-modules are operating with a slightly
> different voltage and frequency values in contrast to the generic
> i.MX6Q/DL tables. The values have been adjusted to achieve the most
> stable condition for the PHYTEC-modules. Introduce imx6q- and
> imx6dl-phycore dtsi files with the modified power tables.
> 
> Signed-off-by: Yunus Bas <y.bas@phytec.de>
> ---
>  .../boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |  2 +-
>  .../boot/dts/imx6dl-phytec-phycore-som.dtsi   | 25 ++++++
>  .../boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |  2 +-
>  .../boot/dts/imx6q-phytec-mira-rdk-nand.dts   |  2 +-
>  .../boot/dts/imx6q-phytec-phycore-som.dtsi    | 83 +++++++++++++++++++
>  5 files changed, 111 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6dl-phytec-phycore-som.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6q-phytec-phycore-som.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> index d906a7f05aaa..8ec27080ca1e 100644
> --- a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
> @@ -6,7 +6,7 @@
>  
>  /dts-v1/;
>  #include "imx6dl.dtsi"
> -#include "imx6qdl-phytec-phycore-som.dtsi"
> +#include "imx6dl-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
> diff --git a/arch/arm/boot/dts/imx6dl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6dl-phytec-phycore-som.dtsi
> new file mode 100644
> index 000000000000..0985453b5ad6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-phytec-phycore-som.dtsi
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2021 PHYTEC Messtechnik GmbH
> + * Author: Yunus Bas <y.bas@phytec.de>
> + */
> +
> +#include "imx6qdl-phytec-phycore-som.dtsi"
> +
> +&cpu0 {
> +	operating-points = <
> +		/* kHz    uV */
> +		996000  1275000
> +		792000  1175000
> +		396000  1150000
> +	>;

Check Documentation/devicetree/bindings/opp/opp-v1.yaml to see how this
property should be coded properly.

Shawn

> +};
> +
> +&cpu1 {
> +	operating-points = <
> +		/* kHz    uV */
> +		996000  1275000
> +		792000  1175000
> +		396000  1150000
> +	>;
> +};
> diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> index 322f071d972f..7d947762f3b9 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
> @@ -6,7 +6,7 @@
>  
>  /dts-v1/;
>  #include "imx6q.dtsi"
> -#include "imx6qdl-phytec-phycore-som.dtsi"
> +#include "imx6q-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
> diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> index 3f13726c8058..afbb6681a6b5 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
> @@ -6,7 +6,7 @@
>  
>  /dts-v1/;
>  #include "imx6q.dtsi"
> -#include "imx6qdl-phytec-phycore-som.dtsi"
> +#include "imx6q-phytec-phycore-som.dtsi"
>  #include "imx6qdl-phytec-mira.dtsi"
>  #include "imx6qdl-phytec-mira-peb-eval-01.dtsi"
>  #include "imx6qdl-phytec-mira-peb-av-02.dtsi"
> diff --git a/arch/arm/boot/dts/imx6q-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6q-phytec-phycore-som.dtsi
> new file mode 100644
> index 000000000000..3ecb94379c8b
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-phytec-phycore-som.dtsi
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2021 PHYTEC Messtechnik GmbH
> + * Author: Yunus Bas <y.bas@phytec.de>
> + */
> +
> +#include "imx6qdl-phytec-phycore-som.dtsi"
> +
> +&cpu0 {
> +	operating-points = <
> +		/* KHz  uV */
> +		1200000 1300000
> +		996000  1250000
> +		852000  1250000
> +		792000  1175000
> +		396000  1075000
> +	>;
> +	fsl,soc-operating-points = <
> +		/* ARM kHz  SOC-PU uV */
> +		1200000 1275000
> +		996000	1250000
> +		852000	1250000
> +		792000	1250000
> +		396000	1250000
> +	>;
> +};
> +
> +&cpu1 {
> +	operating-points = <
> +		/* KHz  uV */
> +		1200000 1300000
> +		996000  1250000
> +		852000  1250000
> +		792000  1175000
> +		396000  1075000
> +	>;
> +	fsl,soc-operating-points = <
> +		/* ARM kHz  SOC-PU uV */
> +		1200000 1275000
> +		996000	1250000
> +		852000	1250000
> +		792000	1250000
> +		396000	1250000
> +	>;
> +};
> +
> +&cpu2 {
> +	operating-points = <
> +		/* KHz  uV */
> +		1200000 1300000
> +		996000  1250000
> +		852000  1250000
> +		792000  1175000
> +		396000  1075000
> +	>;
> +	fsl,soc-operating-points = <
> +		/* ARM kHz  SOC-PU uV */
> +		1200000 1275000
> +		996000	1250000
> +		852000	1250000
> +		792000	1250000
> +		396000	1250000
> +	>;
> +};
> +
> +&cpu3 {
> +	operating-points = <
> +		/* KHz  uV */
> +		1200000 1300000
> +		996000  1250000
> +		852000  1250000
> +		792000  1175000
> +		396000  1075000
> +	>;
> +	fsl,soc-operating-points = <
> +		/* ARM kHz  SOC-PU uV */
> +		1200000 1275000
> +		996000	1250000
> +		852000	1250000
> +		792000	1250000
> +		396000	1250000
> +	>;
> +};
> -- 
> 2.25.1
> 
