Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80481475600
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhLOKPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhLOKPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:15:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A6FC061574;
        Wed, 15 Dec 2021 02:15:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5F4481F45580
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639563305; bh=3gcQGNr2454bcL5Y6Emf4IAgqrpvitQtv6gVZdbNOPE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mp3IwHoye7upYbMjvc4/Qd7V0ucnZ7JsEyUyjLdKSdib6JHtWeMhnHroStMZEd7EC
         J2ImrfB79FYWHm65KwJpyfdt1JVO96L3cfBja4bUQfvCgN4lybE2/7Q7YTDeF1lmJW
         u3Usyt5m23uX8d8eJvNc3GRO1BNyfIjskDKB1r7v3KXDoihmW45q+CszlFS+8P3Vtq
         bvOO/ua+e0dadPSIcgJdaV7aVdVlrm0SpABiwrM+RJlKLxb1bEwtK6SeYIpD5AFqgv
         97PY9P3Dh8eOaIjL0Tkp8WLUDlspbKz9/c4khMXtvBXeK5x6DSaYV2dwVGFK+kWCKJ
         rK7xsqaAKzjNA==
Subject: Re: [PATCH v10 2/3] dts: arm64: mt8183: add Mediatek MDP3 nodes
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        menghui.lin@mediatek.com, sj.huang@mediatek.com,
        allen-kh.cheng@mediatek.com, randy.wu@mediatek.com,
        jason-jh.lin@mediatek.com, roy-cw.yeh@mediatek.com,
        river.cheng@mediatek.com, srv_heupstream@mediatek.com
References: <20211202062733.20338-1-moudy.ho@mediatek.com>
 <20211202062733.20338-3-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <0b893a2b-cec6-a88a-7218-52d1629d9469@collabora.com>
Date:   Wed, 15 Dec 2021 11:15:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211202062733.20338-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/12/21 07:27, Moudy Ho ha scritto:
> Add device nodes for Media Data Path 3 (MDP3) modules.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 115 ++++++++++++++++++++++-
>   1 file changed, 114 insertions(+), 1 deletion(-)
> 

Hello Moudy,
we have just detected an issue with this commit.


> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index ba4584faca5a..e4dc76b04438 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1325,6 +1325,85 @@
>   			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>   		};
>   
> +		mdp3_rdma0: mdp3_rdma0@14001000 {
> +			compatible = "mediatek,mt8183-mdp3",
> +				     "mediatek,mt8183-mdp3-rdma";
> +			mediatek,scp = <&scp>;
> +			mediatek,mdp3-id = <0>;
> +			mediatek,mdp3-comps = "mediatek,mt8183-mdp3-dl1",
> +					      "mediatek,mt8183-mdp3-dl2",
> +					      "mediatek,mt8183-mdp3-path1",
> +					      "mediatek,mt8183-mdp3-path2",
> +					      "mediatek,mt8183-mdp3-imgi",
> +					      "mediatek,mt8183-mdp3-exto";
> +			mediatek,mdp3-comp-ids = <0 1 0 1 0 1>;
> +			reg = <0 0x14001000 0 0x1000>,
> +			      <0 0x14000000 0 0x1000>,
> +			      <0 0x14005000 0 0x1000>,
> +			      <0 0x14006000 0 0x1000>,
> +			      <0 0x15020000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>,
> +						  <&gce SUBSYS_1400XXXX 0 0x1000>,
> +						  <&gce SUBSYS_1400XXXX 0x5000 0x1000>,
> +						  <&gce SUBSYS_1400XXXX 0x6000 0x1000>,
> +						  <&gce SUBSYS_1502XXXX 0 0x1000>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_MDP_RDMA0>,
> +				 <&mmsys CLK_MM_MDP_RSZ1>,
> +				 <&mmsys CLK_MM_MDP_DL_TXCK>,
> +				 <&mmsys CLK_MM_MDP_DL_RX>,
> +				 <&mmsys CLK_MM_IPU_DL_TXCK>,
> +				 <&mmsys CLK_MM_IPU_DL_RX>;
> +			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
> +			mediatek,mmsys = <&mmsys>;
> +			mediatek,mm-mutex = <&mutex>;
> +			mediatek,mailbox-gce = <&gce>;
> +			mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST 0>,
> +				 <&gce 21 CMDQ_THR_PRIO_LOWEST 0>,
> +				 <&gce 22 CMDQ_THR_PRIO_LOWEST 0>,
> +				 <&gce 23 CMDQ_THR_PRIO_LOWEST 0>;

The gce mailbox node declares #mbox-cells = <2> and you're trying to use three
cells instead. Like that, the driver won't even probe.

Please fix this by removing the last cell here (remove the 0).

Thanks,
- Angelo
