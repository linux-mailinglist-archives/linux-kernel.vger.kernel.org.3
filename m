Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14405AC229
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 05:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiIDDcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 23:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDDci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 23:32:38 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF531900B;
        Sat,  3 Sep 2022 20:32:37 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B4465C008C;
        Sat,  3 Sep 2022 23:32:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 03 Sep 2022 23:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662262357; x=
        1662348757; bh=TeyTyQi/4NWG/VEID8iA849BFUgiaZmUHO9VJnS0F00=; b=z
        K9fO9/EGETZ+rM52VCnLG9+AIwT9QVDpkLo3BhDz8xBk0SZDpjWJv+UtIwGbLq3i
        VHIkeDDKcu/OkYeMZeqvORa3wN9aiXSZqcGVTkgPea2/+FEtku0Yfr5jzshE271J
        PMF0QkKTrKeVjWmytI06gpbh3e+0uTQ7H8ahXwOMwCiri0tHhswmwUF15j/QHpBl
        86YdoWr8W/zs7/BWzJsiIOutZdPAN+3W+iYpUGGxwLUsgd6yN2DvFerK9yjQAFP6
        Smi78oOrwYRBmoOpPOUb/59ZqowH6HcgDaSb4Zy90dGWjz7sdROraysFiscwnuaO
        lxOWy1ETloFnF+M1kmNqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1662262357; x=
        1662348757; bh=TeyTyQi/4NWG/VEID8iA849BFUgiaZmUHO9VJnS0F00=; b=Z
        vVKa2RrDlsfzt521ZxeAe13JsaCwjQvxizZ02heXNnqmZB8D7BSQK6xIXmQGDS92
        XNk/qR2XDpXE8QNBfBggMChTt9lErfa6kkoX7OfrXN8mWH93P33q215yLpkCN4+m
        +CHxxG2zbeYf4NlUyZoCqQtFjWS4zKs1RN+98diAwCZQqBC3nKgLNcaMkxvK+0DV
        7pDH7clbwFIZJgBxDJB51SyM2epMX7v8TqPwHGDyvc9z4Wycb6rfV3y34Sh/g7lP
        vO/XOyoy42DxYY8R24wKl6bTjT70dQ7PyvTHXrfeu5JTCHcL7AP6CGKTwtqP3BWk
        30I2TbHgQtIySlwLyAJvg==
X-ME-Sender: <xms:VBwUYzvVdjLoImfawq72Yk8jlj1_6s7M14ZjgZLnsO235I4_wKUbSQ>
    <xme:VBwUY0fohUQAPL4mklQyw2KB8Hl1B6D3BdJYDG2bVb5nSyqR9u66F20PzO1iCMM1h
    qYIgLjEqWXY0fWtEA>
X-ME-Received: <xmr:VBwUY2wIiCZl-PeXUls03AjAxdo0nus3W3nmQNCkMzCJJ4xfa09WZ43uXBAuys0B28W1PlkiqdL3KZ16IT6nq61_mmnsepk_Eac5p_Wj2mLVIOp_IuffVYuHTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelfedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejleefuddtgeegvedvkeehfeejfeevgfefiefffeegudeiuedt
    heekjeelgeeujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:VRwUYyMK8E-77mvvxWeQkNqxtZmfhDBmOWQD7qjQk1U1juoE2r3bxw>
    <xmx:VRwUYz-H16B3lqXVbfmCqLiHZaNtY6PBZoFFygjS2O-gU21x6UN8Rg>
    <xmx:VRwUYyXMQfARxFylCv-t_lvJLZyLM4F6kBgWCTNFbj7TrW0YqghMMQ>
    <xmx:VRwUY0MSZkSa9U4rsgB6Ro9VWw8r3qXWsisf70qI2XENz86inPrDhA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Sep 2022 23:32:36 -0400 (EDT)
Subject: Re: [PATCH v2 4/4] arm64: dts: allwinner: beelink-gs1: Enable GPU OPP
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220821173051.155038-1-peron.clem@gmail.com>
 <20220821173051.155038-5-peron.clem@gmail.com>
 <0c028109-bb50-fbaa-de18-9876706a7477@sholland.org>
 <CAJiuCcf7NuXFFLw6-RFcyZPNFPagfSB5aR7rY5528USzNB-iKg@mail.gmail.com>
 <CAJiuCcf0io5T=+Ap8io2uKn+CNqrCi2pbaCtyq2PVW=bEqKakg@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <26ebdc2d-caca-2d53-45bc-8c8b90c7c1fd@sholland.org>
Date:   Sat, 3 Sep 2022 22:32:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcf0io5T=+Ap8io2uKn+CNqrCi2pbaCtyq2PVW=bEqKakg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/22 2:06 PM, Clément Péron wrote:
> Hi Samuel,
> 
> On Sat, 3 Sept 2022 at 20:41, Clément Péron <peron.clem@gmail.com> wrote:
>>
>> Hi Samuel,
>>
>> On Tue, 23 Aug 2022 at 05:07, Samuel Holland <samuel@sholland.org> wrote:
>>>
>>> On 8/21/22 12:30 PM, Clément Péron wrote:
>>>> Enable GPU OPP table for Beelink GS1
>>>>
>>>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
>>>> ---
>>>>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
>>>> index 6249e9e02928..20fc0584d1c6 100644
>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
>>>> @@ -5,6 +5,7 @@
>>>>
>>>>  #include "sun50i-h6.dtsi"
>>>>  #include "sun50i-h6-cpu-opp.dtsi"
>>>> +#include "sun50i-h6-gpu-opp.dtsi"
>>>>
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>
>>>> @@ -261,6 +262,7 @@ reg_dcdca: dcdca {
>>>>                       };
>>>>
>>>>                       reg_dcdcc: dcdcc {
>>>> +                             regulator-always-on;
>>>
>>> Why is this necessary? This file already has:
>>
>> This is a relica from the first serie at this time the OPP doesn't
>> properly enable the regulator it's now fixed since:
>> https://patchwork.kernel.org/project/linux-pm/patch/81eb2efeeed1556d124065252f32777838a6d850.1589528491.git.viresh.kumar@linaro.org/

This should have nothing to do with the OPP driver; lima already has a "mali"
regulator consumer that should be enabled whenever the GPU is in use.

_Adding_ a regulator consumer from the OPP driver should not somehow decrease
the refcount.

>> I will drop it.
> 
> After retesting it, it seems to still no take the regulator and make
> my board hang... :(
> 
> [   17.698597] sun8i-dw-hdmi 6000000.hdmi: registered DesignWare HDMI
> I2C bus driver
> [   17.708475] sun4i-drm display-engine: bound 6000000.hdmi (ops
> sun8i_dw_hdmi_ops [sun8i_drm_hdmi])
> [   17.718350] [drm] Initialized sun4i-drm 1.0.0 20150629 for
> display-engine on minor 1
> [   17.877443] Console: switching to colour frame buffer device 320x90
> [   17.936050] sun4i-drm display-engine: [drm] fb0: sun4i-drmdrmfb
> frame buffer device
> [   17.961881] platform 5200000.usb: deferred probe pending
>>>>> [   31.710731] vdd-gpu: disabling <<<<<

Are there any messages from lima, especially about mali-supply? Can you provide
regulators_summary from debugfs?

Regards,
Samuel
