Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACE497E25
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbiAXLk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiAXLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:40:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B11C06173B;
        Mon, 24 Jan 2022 03:40:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A7EF71F43214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643024453;
        bh=LEHg3DZ84C8Gry6J9n4ClFKXAKM6i9ht5dmGB41/N7o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WXeSeQLU5W3nLwzELPyDMf7K8FWSMovo3BSirPCptuRsj4ufrFEOfsAEp52mLHt+o
         RWuUuh7ZQ2B1XFug/IUvWMpbXMTkeif3XZV+EmLswi2ETPxTHFype9fuxaj29RQcm3
         7qAwuwifM4jV3oxZlAtNm7yn2g9wCH1ua8c5QjI74sPgHiX2Vw3o/4EGWBB7Kqa4DS
         VueIZ+BHTE8Lss9JyKlW0bkyNPTYN6QhF0e/aGIpxHQtwrbNQmQITjBG6kduyRtmsW
         KqUkxDvxQH+hBztoXrOfSWy3xukesC5r0mJUNsKxjDXueCna6sgpw8UOcFgVm4uRhp
         d0pw3OJ6YlmYw==
Subject: Re: [PATCH v11 1/3] dt-binding: mt8183: add Mediatek MDP3 dt-bindings
To:     Rob Herring <robh@kernel.org>, Moudy Ho <moudy.ho@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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
 <20220105093758.6850-2-moudy.ho@mediatek.com>
 <YesiwTSxa9HJ1lxG@robh.at.kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <815a363d-749e-d7a5-3786-c11dfd4d22d4@collabora.com>
Date:   Mon, 24 Jan 2022 12:40:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YesiwTSxa9HJ1lxG@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/01/22 22:16, Rob Herring ha scritto:
> On Wed, Jan 05, 2022 at 05:37:56PM +0800, Moudy Ho wrote:

Hello Rob,

since I'm not the best at reviewing dt-bindings, I always try to leave that to

other reviewers; in which case, thank you for your awesome review activity on

all of these (and helping me a lot on some of my attempts to write yaml..!!)


In this case, though, since I do have knowledge about the platform, it's probably
worth for me to try to address some of your questions, on at least this one.


>> This patch adds DT binding document for Media Data Path 3 (MDP3)
>> a unit in multimedia system used for scaling and color format convert.
>>
>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>> ---
>>   .../bindings/media/mediatek,mdp3-rdma.yaml    | 193 ++++++++++++++++++
>>   .../bindings/media/mediatek,mdp3-rsz.yaml     |  55 +++++
>>   .../bindings/media/mediatek,mdp3-wrot.yaml    |  57 ++++++
>>   .../bindings/soc/mediatek/mediatek,ccorr.yaml |  47 +++++
>>   .../bindings/soc/mediatek/mediatek,wdma.yaml  |  58 ++++++
>>   5 files changed, 410 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
>>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
>>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>> new file mode 100644
>> index 000000000000..002503383934
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>> @@ -0,0 +1,193 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-rdma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Mediatek Read Direct Memory Access
>> +
>> +maintainers:
>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>> +
>> +description: |
>> +  Mediatek Read Direct Memory Access(RDMA) component used to do read DMA.
>> +  It contains one line buffer to store the sufficient pixel data, and
>> +  must be siblings to the central MMSYS_CONFIG node.
>> +  For a description of the MMSYS_CONFIG binding, see
>> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> +  for details.
>> +  The 1st RDMA is also used to be a controller node in Media Data Path 3(MDP3)
>> +  that containing MMSYS, MUTEX, GCE and SCP settings.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          # MDP3 controller node
>> +          - const: mediatek,mt8183-mdp3
> 
> How is this more specific than this:
> 
>> +          - const: mediatek,mt8183-mdp3-rdma0
> 

Probably, oneOf is not the right choice here... "mediatek,mt8183-mdp3" is needed
to probe the "main" mdp3 core pdev, while RDMA0 is a necessary component (as in
this driver uses the component framework, and rdma0 is required for functionality,
as far as I understand).

This shouldn't be a choice, meaning that defining mdp3-rdma0 without mdp3 is
completely useless, as there wouldn't be anything else initializing that component,
nor sub-components of that.

>> +      - items:
>> +          # normal RDMA conponent
>> +          - const: mediatek,mt8183-mdp3-rdma0
>> +
>> +  mediatek,scp:
>> +    description: The node of system control processor (SCP), using
>> +      the remoteproc & rpmsg framework.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    maxItems: 1
>> +
>> +  mediatek,mdp3-comps:
>> +    description: MTK sub-system of direct-link or DIP
> 
> This needs a better description. What is DIP? What is direct-link?

I agree, this needs a better description.

> 
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    items:
>> +      - enum:
>> +          # MDP direct-link input path selection, create a
>> +          # component for path connectedness of HW pipe control
>> +          - mediatek,mt8183-mdp3-dl1
>> +      - enum:
>> +          - mediatek,mt8183-mdp3-dl2
>> +      - enum:
>> +          # MDP direct-link output path selection, create a
>> +          # component for path connectedness of HW pipe control
>> +          - mediatek,mt8183-mdp3-path1
>> +      - enum:
>> +          - mediatek,mt8183-mdp3-path2
>> +      - enum:
>> +          # Input DMA of ISP PASS2 (DIP) module for raw image input
>> +          - mediatek,mt8183-mdp3-imgi
>> +      - enum:
>> +          # Output DMA of ISP PASS2 (DIP) module for YUV image output
>> +          - mediatek,mt8183-mdp3-exto
> 
> There's only 1 possible value for mediatek,mdp3-comps, so why does it
> need to be in DT?
> 

The wanted logic here (I believe) is that, depending on firmware capabilities
and/or platform/board capabilities, you may miss some subcomponents like IMGI
and/or EXTO.
As for DL1/2 and PATH1/2... DL1+PATH1 is surely critically necessary for the
functionality of the MDP3 RDMA... I don't know whether it's possible that we
get any fw/platform/device that's not using DL2/PATH2 at all.

Moudy, can you please explain?

>> +
>> +  reg:
>> +    items:
>> +      - description: basic RDMA HW address
>> +      - description: MDP direct-link 1st and 2nd input
>> +      - description: MDP direct-link 1st output
>> +      - description: MDP direct-link 2nd output
>> +      - description: ISP input and output
>> +
>> +  mediatek,gce-client-reg:
>> +    description: The register of client driver can be configured by gce with
>> +      4 arguments defined in this property, such as phandle of gce, subsys id,
>> +      register offset and size. Each GCE subsys id is mapping to a client
>> +      defined in the header include/dt-bindings/gce/<chip>-gce.h.
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - description: GCE client for RDMA
>> +      - description: GCR client for MDP direct-link 1st and 2nd input
>> +      - description: GCR client for MDP direct-link 1st output
>> +      - description: GCR client for MDP direct-link 2nd output
>> +      - description: GCR client for ISP input and output
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: RDMA clock
>> +      - description: RSZ clock
>> +      - description: direck-link TX clock in MDP side
>> +      - description: direck-link RX clock in MDP side
>> +      - description: direck-link TX clock in ISP side
>> +      - description: direck-link RX clock in ISP side
>> +
>> +  iommus:
>> +    maxItems: 1
>> +
>> +  mediatek,mmsys:
>> +    description: The node of mux(multiplexer) controller for HW connections.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  mediatek,mm-mutex:
> 
> Is this some sort of h/w lock? We have a standard binding for that.
> 

There's a story behind that one: this was part of mtk (display) DRM drivers, then
it was moved to soc/mediatek/mtk-mutex.c as it started being shared.

I wonder if the mm-mutex can be rewritten and moved to hwspinlock... this driver
is growing and now, with the introduction of MDP3, we're seeing some more.

Though, it's definitely worth mentioning that the usage of MediaTek's mm-mutex is
varying a bit between the drm case and the mdp3 case as, here, we have a "command
queue" mechanism that is used for commands ordering in HW.
This is a very complex architecture that has very specific requirements.
For how I see it, migrating that to hwspinlock would require an almost complete
reimplementation of soc/mediatek/*, which would take a considerable amount of
time and efforts.
I'm mostly sure that I can help with that, but for how things are looking right

now, between refactoring, getting code solid, going through sane reviews and a
final merge, I'd say that this will take 8-12 months from now.

For this reason, I would propose to perform a slow and steady migration of the
MediaTek mmsys, scpsys, mutex over time, but only after getting in the support
for the new SoCs and functionality for the older ones, provided in this series
and some others that were already sent by MTK, half (or more) of which have
already been merged.

>> +    description: The node of sof(start of frame) signal controller.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    maxItems: 1
>> +
>> +  mediatek,mailbox-gce:
>> +    description: The node of global command engine (GCE), used to read/write
>> +      registers with critical time limitation.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  mboxes:
>> +    items:
>> +      - description: used for 1st data pipe from RDMA
>> +      - description: used for 2nd data pipe from RDMA
>> +      - description: used for 3rd data pipe from Direct-Link
>> +      - description: used for 4th data pipe from Direct-Link
>> +
>> +  gce-subsys:
>> +    description: sub-system id corresponding to the global command engine (GCE)
>> +      register address.
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +
>> +if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: mediatek,mt8183-mdp3
>> +
>> +then:
>> +  required:
>> +    - mediatek,scp
>> +    - mediatek,mmsys
>> +    - mediatek,mm-mutex
>> +    - mediatek,mailbox-gce
>> +    - mboxes
>> +    - gce-subsys
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - mediatek,gce-client-reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/mt8183-clk.h>
>> +    #include <dt-bindings/gce/mt8183-gce.h>
>> +    #include <dt-bindings/power/mt8183-power.h>
>> +    #include <dt-bindings/memory/mt8183-larb-port.h>
>> +
>> +    mdp3_rdma0: mdp3_rdma0@14001000 {
>> +      compatible = "mediatek,mt8183-mdp3",
>> +                   "mediatek,mt8183-mdp3-rdma0";
>> +      mediatek,scp = <&scp>;
>> +      mediatek,mdp3-comps = "mediatek,mt8183-mdp3-dl1",
>> +                            "mediatek,mt8183-mdp3-dl2",
>> +                            "mediatek,mt8183-mdp3-path1",
>> +                            "mediatek,mt8183-mdp3-path2",
>> +                            "mediatek,mt8183-mdp3-imgi",
>> +                            "mediatek,mt8183-mdp3-exto";
>> +      reg = <0x14001000 0x1000>,
>> +            <0x14000000 0x1000>,
>> +            <0x14005000 0x1000>,
>> +            <0x14006000 0x1000>,
>> +            <0x15020000 0x1000>;
>> +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>,
>> +                                <&gce SUBSYS_1400XXXX 0 0x1000>,
>> +                                <&gce SUBSYS_1400XXXX 0x5000 0x1000>,
>> +                                <&gce SUBSYS_1400XXXX 0x6000 0x1000>,
>> +                                <&gce SUBSYS_1502XXXX 0 0x1000>;
>> +      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>> +      clocks = <&mmsys CLK_MM_MDP_RDMA0>,
>> +               <&mmsys CLK_MM_MDP_RSZ1>,
>> +               <&mmsys CLK_MM_MDP_DL_TXCK>,
>> +               <&mmsys CLK_MM_MDP_DL_RX>,
>> +               <&mmsys CLK_MM_IPU_DL_TXCK>,
>> +               <&mmsys CLK_MM_IPU_DL_RX>;
>> +      iommus = <&iommu>;
>> +      mediatek,mmsys = <&mmsys>;
>> +      mediatek,mm-mutex = <&mutex>;
>> +      mediatek,mailbox-gce = <&gce>;
>> +      mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST>,
>> +               <&gce 21 CMDQ_THR_PRIO_LOWEST>,
>> +               <&gce 22 CMDQ_THR_PRIO_LOWEST>,
>> +               <&gce 23 CMDQ_THR_PRIO_LOWEST>;
>> +      gce-subsys = <&gce 0x14000000 SUBSYS_1400XXXX>,
>> +                   <&gce 0x14010000 SUBSYS_1401XXXX>,
>> +                   <&gce 0x14020000 SUBSYS_1402XXXX>,
>> +                   <&gce 0x15020000 SUBSYS_1502XXXX>;
>> +    };
>> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>> new file mode 100644
>> index 000000000000..cd4cf1531535
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>> @@ -0,0 +1,55 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-rsz.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Mediatek Resizer
>> +
>> +maintainers:
>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>> +
>> +description: |
>> +  One of Media Data Path 3 (MDP3) components used to do frame resizing.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - mediatek,mt8183-mdp3-rsz0
>> +          - mediatek,mt8183-mdp3-rsz1
> 
> Again, what's the difference between 0 and 1?
> 
> I've probably asked that before, but without a sufficient reasoning
> here in the schema I'm just going to keep asking the same question.

This can probably be, instead, something like

compatible = "mediatek,mt8183-mdp3-rsz";
reg = < .... >;
mediatek,instance-id = <0>;
gce reg, clocks, blah...

or

compatible = "mediatek,mt8183-mdp3-rsz";
reg = < ...rsz0... >, < ...rsz1... >;
reg-names = "rsz0", "rsz1";
gce reg, clocks, blah...


...In any case, if MediaTek chose to separate these like that, I guess that
there will be differences in newer SoCs that would make that kind of binding
much necessary.

Please Moudy, can you explain why you didn't write that like the examples
that I provided there?

> 
> Rob
> 


