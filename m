Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2A249DFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiA0K5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiA0K52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:57:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230DC061714;
        Thu, 27 Jan 2022 02:57:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9FD541F40893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643281047;
        bh=nTKHCZzC6UeHy9OCKez9WNf/yCUacrzA2Hv/pSEJ8lw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=me780pf2wBR6g5L94Ao21BGx4lcKc0EO2mgsnNFeG6YuRrhQ55hU5PDNoxbTOES0S
         gMTtjKpWSidNHbtvCBR6cvxouUpIqfpyrQD9Utb0dHwzSsloPC51H/fUjObkoON+fw
         fOSWr/4eEkfKKVex0JQlF6+Slsj923sz0fuExqI5j3+vAZ5Wh2tX8Lgo0gqPXEfhGs
         e2jwKbs785o5n+UUiKzbuskru2JtFPsRaWWz0tQJ9GVQV5HfVukUaeGT4OTYrRIjZf
         gxZm19cDufkeMEh4nQR4NQzm5JONfocZVoKBfGidMLIDx9VBg+sFqDF7N32x4k794z
         VmYj9Gg4l4GBQ==
Subject: Re: [PATCH v11 2/3] dts: arm64: mt8183: add Mediatek MDP3 nodes
To:     moudy ho <moudy.ho@mediatek.com>,
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
References: <20220105093758.6850-1-moudy.ho@mediatek.com>
 <20220105093758.6850-3-moudy.ho@mediatek.com>
 <d61ec481-8059-a897-504a-0125f88fad61@collabora.com>
 <356f512b549f90b329775e249fd48eb2954ade02.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <08fc74c5-4f2f-8712-454d-8cf3aed4eb10@collabora.com>
Date:   Thu, 27 Jan 2022 11:57:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <356f512b549f90b329775e249fd48eb2954ade02.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/01/22 09:20, moudy ho ha scritto:
> On Fri, 2022-01-21 at 12:58 +0100, AngeloGioacchino Del Regno wrote:
>> Il 05/01/22 10:37, Moudy Ho ha scritto:
>>> Add device nodes for Media Data Path 3 (MDP3) modules.
>>>
>>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8183.dtsi | 108
>>> ++++++++++++++++++++++-
>>>    1 file changed, 107 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> index ba4584faca5a..b872ef1ff6b3 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> @@ -1325,6 +1325,79 @@
>>>    			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
>>> 0 0x1000>;
>>>    		};
>>>    
>>> +		mdp3_rdma0: mdp3_rdma0@14001000 {
>>> +			compatible = "mediatek,mt8183-mdp3",
>>> +				     "mediatek,mt8183-mdp3-rdma0";
>>> +			mediatek,scp = <&scp>;
>>> +			mediatek,mdp3-comps = "mediatek,mt8183-mdp3-
>>> dl1",
>>> +					      "mediatek,mt8183-mdp3-
>>> dl2",
>>> +					      "mediatek,mt8183-mdp3-
>>> path1",
>>> +					      "mediatek,mt8183-mdp3-
>>> path2",
>>> +					      "mediatek,mt8183-mdp3-
>>> imgi",
>>> +					      "mediatek,mt8183-mdp3-
>>> exto";
>>> +			reg = <0 0x14001000 0 0x1000>,
>>> +			      <0 0x14000000 0 0x1000>,
>>> +			      <0 0x14005000 0 0x1000>,
>>> +			      <0 0x14006000 0 0x1000>,
>>> +			      <0 0x15020000 0 0x1000>;
>>> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
>>> 0x1000 0x1000>,
>>> +						  <&gce SUBSYS_1400XXXX
>>> 0 0x1000>,
>>> +						  <&gce SUBSYS_1400XXXX
>>> 0x5000 0x1000>,
>>> +						  <&gce SUBSYS_1400XXXX
>>> 0x6000 0x1000>,
>>> +						  <&gce SUBSYS_1502XXXX
>>> 0 0x1000>;
>>> +			power-domains = <&spm
>>> MT8183_POWER_DOMAIN_DISP>;
>>> +			clocks = <&mmsys CLK_MM_MDP_RDMA0>,
>>> +				 <&mmsys CLK_MM_MDP_RSZ1>,
>>> +				 <&mmsys CLK_MM_MDP_DL_TXCK>,
>>> +				 <&mmsys CLK_MM_MDP_DL_RX>,
>>> +				 <&mmsys CLK_MM_IPU_DL_TXCK>,
>>> +				 <&mmsys CLK_MM_IPU_DL_RX>;
>>> +			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
>>> +			mediatek,mmsys = <&mmsys>;
>>> +			mediatek,mm-mutex = <&mutex>;
>>> +			mediatek,mailbox-gce = <&gce>;
>>> +			mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST 0>,
>>> +				 <&gce 21 CMDQ_THR_PRIO_LOWEST>,
>>> +				 <&gce 22 CMDQ_THR_PRIO_LOWEST>,
>>> +				 <&gce 23 CMDQ_THR_PRIO_LOWEST>;
>>
>> Hello Moudy,
>> the mboxes for gce 21, 22, 23 are missing the third cell. Please fix.
>>
>> Regards,
>> Angelo
> 
> Hi Angelo,
> Thanks for the reminder, but I'm a bit confused, the previous
> version(v10) mentioned that the current upstream mbox has only 2
> cells.
> So I should follow this rule to remove the extra 0 in the first item as
> follows:
>   +			mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST>,
>   +				 <&gce 21 CMDQ_THR_PRIO_LOWEST>,
>   +				 <&gce 22 CMDQ_THR_PRIO_LOWEST>,
>   +				 <&gce 23 CMDQ_THR_PRIO_LOWEST>;
> 
> Thanks,
> Moudy Ho

Hello Moudy,
I'm sorry for this confusion and you are totally right in the proposed solution,
which is the exact opposite of what I said.

Thanks for understanding,
Angelo

>>
>>> +			gce-subsys = <&gce 0x14000000 SUBSYS_1400XXXX>,
>>> +				     <&gce 0x14010000 SUBSYS_1401XXXX>,
>>> +				     <&gce 0x14020000 SUBSYS_1402XXXX>,
>>> +				     <&gce 0x15020000 SUBSYS_1502XXXX>;
>>> +		};
>>> +
>>
>>
> 

