Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3764858A3DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbiHDXUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiHDXUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:20:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C88848E85;
        Thu,  4 Aug 2022 16:20:22 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8887A6601B8B;
        Fri,  5 Aug 2022 00:20:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659655220;
        bh=T0qa+MBJicKTTAZecGrlpW67BsO3JhfQBcWJNXRa4zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hH1TgnyvKoh2vVAqSo9D86sEPyQp9coth65EX7I5eUQx1zM2/dicl2FTfdJNQkBvz
         KspkfArJl68MM4tj//R3mx7eW/CtBz4mI4gHGSGG5+uG5cRKXeglv9/eh05xzedmgr
         JaWDG3SAxSgKH+1d0PsF2WmRgKqPce6H535Wx2LfoWCQjSMwwLcPvkCOO2FvoBvT2/
         bipN9umw3NmBsHaIQVOugavHQ+tnhuE05FMe5rX60Y8VSfX7HE37VyasHD9nGbhh+A
         Fil0Mc38682UP0nno7MpyiPESI3P3ShO669oOE7bSswoeY3tTVh4+Yv1ZKS4gGsi+I
         2NnqbtkScB3ng==
Date:   Thu, 4 Aug 2022 19:20:15 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: Re: [PATCH v8.1, 3/7] arm64: dts: mt8192: Add thermal zone
Message-ID: <20220804232015.wz23cjuh73zceoa5@notapiano>
References: <20220804130912.676043-1-bchihi@baylibre.com>
 <20220804130912.676043-4-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804130912.676043-4-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 03:09:08PM +0200, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> This adds the thermal zone for the mt8192.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 113 ++++++++++++++++++++++-
>  1 file changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index cbae5a5ee4a0..3320b5c14ee3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
[..]
> +		vdec-thermal {

		infra-thermal

> +			polling-delay = <0>;
> +			polling-delay-passive = <0>;
> +			thermal-sensors = <&lvts_ap 4>;
> +		};
> +		img-thermal {

		cam-thermal

> +			polling-delay = <0>;
> +			polling-delay-passive = <0>;
> +			thermal-sensors = <&lvts_ap 5>;
> +		};
> +		infra-thermal {

		md1-thermal

> +			polling-delay = <0>;
> +			polling-delay-passive = <0>;
> +			thermal-sensors = <&lvts_ap 6>;
> +		};
> +		cam1-thermal {

		md2-thermal

> +			polling-delay = <0>;
> +			polling-delay-passive = <0>;
> +			thermal-sensors = <&lvts_ap 7>;
> +		};
> +		cam2-thermal {

		md3-thermal

Thanks,
Nícolas

> +			polling-delay = <0>;
> +			polling-delay-passive = <0>;
> +			thermal-sensors = <&lvts_ap 8>;
> +		};
> +	};
>  };
> -- 
> 2.34.1
> 
> 
