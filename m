Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5CA4EBD22
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244550AbiC3JEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244541AbiC3JEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:04:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F12D2E0A3;
        Wed, 30 Mar 2022 02:02:25 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7BE285C0190;
        Wed, 30 Mar 2022 05:02:24 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute1.internal (MEProxy); Wed, 30 Mar 2022 05:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=tuz6s6EWNZ0Esh
        nRWti89Elty7LEZNweVZZiB9p+PU8=; b=Ays+hhe7LU/RWsUh7Jq3ipCyb6QZDv
        QWtwS5zW8ob/gZx0ANtxxJgT3yGE+7p/4wMOlfV5oDYGy6fKWMqkXum6YSK6NEax
        KQM+tT1CMsx36Hlqlqy39xX88YuRaQsOZsz2oDrNnJkoyqnggghgx4/bNYRwwsnD
        /pkRDJW9h8QTWJOTs+6WPifJqRaPlNkWPuqkt5jVa3vG7extFFeqk1DvltMiGCLt
        KUZuBf/Wo6ZNBqHlKqNUd+vnoNfUeO7TkNcmJ4FPFb2qkfPFD7BlJNS1Zw32jRM8
        /N5YVVq+YDkuVX4/V2NzCyYeX1s55+Uk7cLPMRoaYLX1F/+cJjkNUKFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=tuz6s6EWNZ0EshnRWti89Elty7LEZNweVZZiB9p+P
        U8=; b=jbKyovw/syyihbCeFXLJA6UtNM+SezgJS4+LoIdhD78+gktuUHoPYr95T
        0n3oYLLHHd/o4XGgP1kjXzVVMdC4jdnfotnfvwsuFFb1OT7irwtYXzOVhUv2wddO
        iVaqZ1SHT8AZTlLjyzDV1B42ydWnZCfHq8XDHyAkW8VtRjBLrBk4///X9mCZqq67
        hExfBIxPYF0cVtQhO2k4pNTk8neocVEk47i1J+OH8xMQh6hEfYYv4oPjfh5NQn7n
        V/MOtiJ4UBnKT4k8etOe94AHM9G11Q3PRq8dM1S/0op/Fh+yAtgIiq+wyZhfEoei
        THTS3VBboNWNW6LyQC0ck2LwcMV7A==
X-ME-Sender: <xms:nRxEYgh6LdPrCa7m3JG_HI0DR7bJP47S2GutXYOyXUtiQjmXGR37Pg>
    <xme:nRxEYpBBVn1Dy7CmwHGlWdyDunLV2_Hng8HR2qZlvtL8gVFwAT_eIixoesmOgNFpT
    8Zt_rMoNM_FYU7UusY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepgeehgfehgeffffehtefffeevjeeifefhheejledtfeel
    fffggedvfeekteekteevnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihu
    nhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:nRxEYoGiwSRhKaE89IDQ2q4BWTWceBGWRUg4oR0g6TdSqaIJAvR9bA>
    <xmx:nRxEYhSDQZAVg8gAVTHnhdq8aJ_v9EOZSwNyX4jDmkF11T9Twv1EbQ>
    <xmx:nRxEYtyLXLI7mk0pw6WpFjP9NcQss3I88XpJm3t1hcNzS7-SWsTavQ>
    <xmx:oBxEYjpxpULllUwb1F0o7W7TAv8jWaikJvTFNQ_z0Ehn9_iZWDgEdA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 41CDBFA0AA5; Wed, 30 Mar 2022 05:02:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4911-g925b585eab-fm-20220323.003-g925b585e
Mime-Version: 1.0
Message-Id: <a777b827-32a2-46f8-9074-3f43c0bd87ba@www.fastmail.com>
In-Reply-To: <0a3a29af-ad2f-9ccc-3a56-3e5b7e4c7c83@189.cn>
References: <20220328022835.2508587-1-15330273260@189.cn>
 <20220328022835.2508587-3-15330273260@189.cn>
 <CAL_Jsq+zO7RXzQLoPXR7Zm0mcsKCydK=8EFaNFGu-_THgJuh7Q@mail.gmail.com>
 <0a3a29af-ad2f-9ccc-3a56-3e5b7e4c7c83@189.cn>
Date:   Wed, 30 Mar 2022 10:01:51 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Sui Jingfeng" <15330273260@189.cn>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Roland Scheidegger" <sroland@vmware.com>,
        "Zack Rusin" <zackr@vmware.com>,
        "Christian Gmeiner" <christian.gmeiner@gmail.com>,
        "David Airlie" <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Andrey Zhizhikin" <andrey.zhizhikin@leica-geosystems.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Lucas Stach" <l.stach@pengutronix.de>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        "Qing Zhang" <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v13 3/6] dt-bindings: display: Add Loongson display controller
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82022=E5=B9=B43=E6=9C=8830=E6=97=A5=E4=B8=89=E6=9C=88 =E4=B8=8A=E5=
=8D=884:46=EF=BC=8CSui Jingfeng=E5=86=99=E9=81=93=EF=BC=9A
> On 2022/3/29 21:27, Rob Herring wrote:
>> On Sun, Mar 27, 2022 at 9:29 PM Sui Jingfeng <15330273260@189.cn> wro=
te:
>>> Add DT bindings and simple usages for Loongson display controller
>>> found in LS7A1000 bridge chip and LS2k1000 SoC.
>>>
>>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>>> ---
>>>   .../loongson/loongson,display-controller.yaml | 321 ++++++++++++++=
++++
>>>   1 file changed, 321 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/display/loong=
son/loongson,display-controller.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/loongson/loon=
gson,display-controller.yaml b/Documentation/devicetree/bindings/display=
/loongson/loongson,display-controller.yaml
>>> new file mode 100644
>>> index 000000000000..34060ed55a25
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/display/loongson/loongson,di=
splay-controller.yaml
>>> @@ -0,0 +1,321 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/display/loongson/loongson,displa=
y-controller.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Loongson LS7A1000/LS2K1000/LS2K0500 Display Controller Devic=
e Tree Bindings
>>> +
>>> +maintainers:
>>> +  - Sui Jingfeng <suijingfeng@loongson.cn>
>>> +
>>> +description: |+
>>> +
>>> +  Loongson display controllers are simple which require scanout buf=
fers
>>> +  to be physically contiguous. LS2K1000/LS2K0500 is a SOC, only sys=
tem
>>> +  memory is available. LS7A1000/LS7A2000 is bridge chip which is eq=
uipped
>>> +  with a dedicated video RAM which is 64MB or more, precise size ca=
n be
>>> +  read from the PCI BAR 2 of the GPU device(0x0014:0x7A15) in the b=
ridge
>>> +  chip.
>>> +
>>> +  LSDC has two display pipes, each way has a DVO interface which pr=
ovide
>>> +  RGB888 signals, vertical & horizontal synchronisations, data enab=
le and
>>> +  the pixel clock. LSDC has two CRTC, each CRTC is able to scanout =
from
>>> +  1920x1080 resolution at 60Hz. Each CRTC has two FB address regist=
ers.
>>> +
>>> +  For LS7A1000, there are 4 dedicated GPIOs whose control register =
is
>>> +  located at the DC register space. They are used to emulate two wa=
y i2c,
>>> +  One for DVO0, another for DVO1.
>>> +
>>> +  LS2K1000 and LS2K0500 SoC grab i2c adapter from other module, eit=
her
>>> +  general purpose GPIO emulated i2c or hardware i2c in the SoC.
>>> +
>>> +  LSDC's display pipeline have several components as below descript=
ion,
>>> +
>>> +  The display controller in LS7A1000:
>>> +     ___________________                                     ______=
___
>>> +    |            -------|                                   |      =
   |
>>> +    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monit=
or |
>>> +    |  _   _     -------|        ^             ^            |______=
___|
>>> +    | | | | |    -------|        |             |
>>> +    | |_| |_|    | i2c0 <--------+-------------+
>>> +    |            -------|
>>> +    |   DC IN LS7A1000  |
>>> +    |  _   _     -------|
>>> +    | | | | |    | i2c1 <--------+-------------+
>>> +    | |_| |_|    -------|        |             |             ______=
___
>>> +    |            -------|        |             |            |      =
   |
>>> +    |  CRTC1 --> | DVO1 ----> Encoder1 ---> Connector1 ---> |  Pane=
l  |
>>> +    |            -------|                                   |______=
___|
>>> +    |___________________|
>>> +
>>> +  Simple usage of LS7A1000 with LS3A4000 CPU:
>>> +
>>> +    +------+            +------------------------------------+
>>> +    | DDR4 |            |  +-------------------+             |
>>> +    +------+            |  | PCIe Root complex |   LS7A1000  |
>>> +       || MC0           |  +--++---------++----+             |
>>> +  +----------+  HT 3.0  |     ||         ||                  |
>>> +  | LS3A4000 |<-------->| +---++---+  +--++--+     +---------+   +-=
-----+
>>> +  |   CPU    |<-------->| | GC1000 |  | LSDC |<--->| DDR3 MC |<->| =
VRAM |
>>> +  +----------+          | +--------+  +-+--+-+     +---------+   +-=
-----+
>>> +       || MC1           +---------------|--|-----------------+
>>> +    +------+                            |  |
>>> +    | DDR4 |          +-------+   DVO0  |  |  DVO1   +------+
>>> +    +------+   VGA <--|ADV7125|<--------+  +-------->|TFP410|--> DV=
I/HDMI
>>> +                      +-------+                      +------+
>>> +
>>> +  The display controller in LS2K1000/LS2K0500:
>>> +     ___________________                                     ______=
___
>>> +    |            -------|                                   |      =
   |
>>> +    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monit=
or |
>>> +    |  _   _     -------|        ^              ^           |______=
___|
>>> +    | | | | |           |        |              |
>>> +    | |_| |_|           |     +------+          |
>>> +    |                   <---->| i2c0 |<---------+
>>> +    |   DC IN LS2K1000  |     +------+
>>> +    |  _   _            |     +------+
>>> +    | | | | |           <---->| i2c1 |----------+
>>> +    | |_| |_|           |     +------+          |            ______=
___
>>> +    |            -------|        |              |           |      =
   |
>>> +    |  CRTC1 --> | DVO1 ----> Encoder1 ---> Connector1 ---> |  Pane=
l  |
>>> +    |            -------|                                   |______=
___|
>>> +    |___________________|
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^display-controller@[0-9a-f],[0-9a-f]$"
>>> +
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - loongson,ls7a1000-dc
>>> +              - loongson,ls2k1000-dc
>>> +              - loongson,ls2k0500-dc
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>> +
>>> +  i2c@6:
>> NAK on made-up bus numbers. See v11 discussion for details.
>>
>> Rob
>
> I am worry about when this driver is loaded before the hardware i2c(on=20
> the ls7a1000 bridge) driver,

That=E2=80=99s the problem that EPROBE_DEFER addressed.

>
> and when there is no DT support. in such a case, if i2c bus number is=20
> dynamically assigned,
>
> it may incurring troubles.=C2=A0 Made the bus number fixed is benefit =
to the=20
> whole system.
>
> DT=C2=A0 serve as a purpose to passing parameters to the kernel.=C2=A0=
 bus numbers=20
> just a kind of parameters.
>
> this is my understanding toward DT. why you are so disagree about this=
?=C2=A0=20
> what's the benefits of
>
> disallow put bus numbers it DT? to the whole world of developers who i=
s=20
> using DT?

There is nothing more to discuss.
You lack understanding to the fundamentals of the DT because you didn=E2=
=80=99t work
on thousands of platforms and being trapped by previous design failures.

Just follow the instructions from Rob, he is the expert. Is it that hard?

Thanks
--=20
- Jiaxun
