Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69424E7493
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357854AbiCYN6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354852AbiCYN6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:58:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731CD0A95;
        Fri, 25 Mar 2022 06:56:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 7BF251F462D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648216618;
        bh=Yok8IySePES7GFEb7QlYbVFKQbSvbM5xHMo/W3KrAq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cDEsB6HTdtC52vnOaCKRXIafRpo7nxqy/2Oa0yrR4JXs9qtk/T8396sW+rAyfBxaw
         mYwB3sGaJfCApzeUrgW+8vTivI92GxysMcYC2LPSzev7/rZ3phzhXe9lPSnx+gGMOu
         cbnpJa+lUFw+4qyK4J52LCBcv6MohniLreUx2pqmESFXAPALS/yWqhMMsllKYUD/js
         uECfcs9tGxleYYheriFqEFGDh9npoooDm1o4YPNZ2SSEOu5y/KCgzuhuxvdcqxeJvx
         zBFDoD77T8V4WLbIoCtGJLzwmMOihpzQTkpKe0EMfBJOuSLdTpzu1uepku7r6jRACp
         p/ZMZUIeXu6zw==
Message-ID: <d9f14221-b0ad-9853-e9c8-a35d9111549b@collabora.com>
Date:   Fri, 25 Mar 2022 10:56:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx
 audio card node
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
 <CAOMZO5D4_WboF4S0dgSLD1m15a13c2irK2yjDV4C77_Wb15=2w@mail.gmail.com>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <CAOMZO5D4_WboF4S0dgSLD1m15a13c2irK2yjDV4C77_Wb15=2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 3/25/22 10:49, Fabio Estevam wrote:
> On Wed, Mar 23, 2022 at 10:56 AM Ariel D'Alessandro
> <ariel.dalessandro@collabora.com> wrote:
>>
>> BSH SystemMaster (SMM) S2 PRO board comes with an audio card based on
>> tlv320aic31xx family codec.
>>
>> The audio card exposes two playback devices, one of them using the EASRC
>> (Enhanced Asynchronous Sample Rate Converter) module. Note that this
>> would require SDMA and EASRC firmware in order to work.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>> ---
> 
> What are the changes in v4?

* Fixed the sound-tlv320aic31xx audio-codec property to point to the
right codec node <&tlv320dac3101>

* Reordered properties in tlv320dac3101, and removed clock-names property.

> 
> I see you removed 'clock-names' so this looks good:

Indeed.

> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks!
