Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA64509C55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387643AbiDUJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387641AbiDUJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:31:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09D27FEB;
        Thu, 21 Apr 2022 02:28:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 66BAD1F452EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650533289;
        bh=ptoZj0zFpkieEBVYbfFm80mk/GACzh8P4FCP7u5kt4I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fa955ng5ILBujIu9QV+HvXfpVRPDu1cS/wFEB1NxzivoDE4BnbdHuV7SkHwQDJ1Uu
         a7IgttMNFlHVWXZ4qKCPNi2ux5Ib0L71DkrkBZvV2I4hQXc/NofCZjGP8UNkW9Alpa
         d2G11zp5LiU5Gb8S5k6MqUDGqQTVeN/q+3ijkbHnSKyTEdvp6T2dM790UIRIBT5X5i
         OcsYbvK4EAAgEOli0MGB2Td9o/R0gCMt+WbutSscykrcjSbcdemQKMqvI0Qev765rq
         TrBrqcL9Zw61lH6ybvft+/VBQTuxqPANg76Qyb7u/wmZHHpvNj5KowdDCPp1KrkMLr
         rtKWppH6lf42Q==
Message-ID: <e7ce1509-4680-6f3a-8e60-76b361e0ed33@collabora.com>
Date:   Thu, 21 Apr 2022 11:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v13 1/3] dt-binding: mt8183: add Mediatek MDP3 dt-bindings
Content-Language: en-US
To:     "moudy.ho" <moudy.ho@mediatek.com>, Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        allen-kh.cheng@mediatek.com, xiandong.wang@mediatek.com,
        randy.wu@mediatek.com, jason-jh.lin@mediatek.com,
        roy-cw.yeh@mediatek.com, river.cheng@mediatek.com,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220418022213.23826-1-moudy.ho@mediatek.com>
 <20220418022213.23826-2-moudy.ho@mediatek.com>
 <YmAyrzjtWGrk5pNn@robh.at.kernel.org>
 <b78fd7595fe66e774e3a707884ed9828964cbde8.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b78fd7595fe66e774e3a707884ed9828964cbde8.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/04/22 04:46, moudy.ho ha scritto:
> On Wed, 2022-04-20 at 11:19 -0500, Rob Herring wrote:
>> On Mon, Apr 18, 2022 at 10:22:11AM +0800, Moudy Ho wrote:
>>> This patch adds DT binding documents for Media Data Path 3 (MDP3)
>>> a unit in multimedia system combined with several components and
>>> used for scaling and color format convert.
>>>
>>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>>> ---
>>>   .../bindings/media/mediatek,mdp3-rdma.yaml    | 166
>>> ++++++++++++++++++
>>>   .../bindings/media/mediatek,mdp3-rsz.yaml     |  54 ++++++
>>>   .../bindings/media/mediatek,mdp3-wrot.yaml    |  57 ++++++
>>>   .../bindings/soc/mediatek/mediatek,ccorr.yaml |  47 +++++
>>>   .../bindings/soc/mediatek/mediatek,wdma.yaml  |  58 ++++++
>>>   5 files changed, 382 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>>>   create mode 100644
>>> Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>>>   create mode 100644
>>> Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
>>>   create mode 100644
>>> Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
>>>   create mode 100644
>>> Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-
>>> rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-
>>> rdma.yaml
>>> new file mode 100644
>>> index 000000000000..45b7c075ebf5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-
>>> rdma.yaml
>>> @@ -0,0 +1,166 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id:
>>> https://urldefense.com/v3/__http://devicetree.org/schemas/media/mediatek,mdp3-rdma.yaml*__;Iw!!CTRNKA9wMg0ARbw!3LSlozK4Ddsy4vjMI70PtpvvS39MTVvDGVME_eBDGj7hhW-DSZsoGdwR90ItVI6F$
>>>   
>>> +$schema:
>>> https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!3LSlozK4Ddsy4vjMI70PtpvvS39MTVvDGVME_eBDGj7hhW-DSZsoGdwR96lcJIFE$
>>>   
>>> +
>>> +title: Mediatek Read Direct Memory Access
>>> +
>>> +maintainers:
>>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>>> +
>>> +description: |
>>> +  Mediatek Read Direct Memory Access(RDMA) component used to do
>>> read DMA.
>>> +  It contains one line buffer to store the sufficient pixel data,
>>> and
>>> +  must be siblings to the central MMSYS_CONFIG node.
>>> +  For a description of the MMSYS_CONFIG binding, see
>>> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.ya
>>> ml
>>> +  for details.
>>> +  The 1st RDMA is also used to be a controller node in Media Data
>>> Path 3(MDP3)
>>> +  that containing MMSYS, MUTEX, GCE and SCP settings.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      # MDP3 controller node
>>> +      - const: mediatek,mt8183-mdp3
>>> +      - const: mediatek,mt8183-mdp3-rdma
>>
>> This *still* makes no sense. I'm not looking at this further.
>>
>> Rob
> 
> Hi Rob,
> 
> Apologize for the misunderstanding with your comments in version 12, I
> will recheck and delete the SW related information.
> 
> Thanks,
> Moudy
> 

Hello Moudy,
As an afterthought, I think that a commit title like

dt-bindings: mediatek: Add bindings for MediaTek MDP3 components

would be explaining what you're doing in a more concise manner.

Regards,
Angelo
