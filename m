Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A964EDAA0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiCaNhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiCaNhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:37:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7089B21592E;
        Thu, 31 Mar 2022 06:35:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id E5ECF1F4688D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648733729;
        bh=cyk9vNIO87cQrdRTFwmV9ctNt3fvnwlMz5JVZqWzBbI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=gI3e0WUcAQOpQKikV9eVbvPEmkrGJvFFlwoTtWxBI9zDa++2cwPCMl6l6WLC+KsJS
         lTQGIO1wo4MiBu7V9xPZ6dHwKMt7xHL6Olcd2RALErpCq41nHSa0gzv9wpXHhN92or
         naf3tEf0ovci+1cUJ2v9syX3fspRWNVuI8PiTGAIDeNznGdiA8SAmZDHONKc6l6kNS
         0M1QOP4j1mz8LGfZ8SCxIxeeqsglFGLjHPpjMYn52NyU6cZU1KpTSVavwPHQ2NM8h5
         gN1UNiOAq8DEVORF+qtelEGF6Rs82n2gr4yFNe2JvTllzJwmkYUv4wxtZfvXCNXAoo
         oUyf0oBxPxxqw==
Message-ID: <3e3b223f-7d05-f439-625a-a15afb44b95f@collabora.com>
Date:   Thu, 31 Mar 2022 10:35:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx
 audio card node
Content-Language: en-US
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
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
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
 <CAOMZO5D4_WboF4S0dgSLD1m15a13c2irK2yjDV4C77_Wb15=2w@mail.gmail.com>
 <d9f14221-b0ad-9853-e9c8-a35d9111549b@collabora.com>
In-Reply-To: <d9f14221-b0ad-9853-e9c8-a35d9111549b@collabora.com>
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

Hi Fabio, Shawn,

Can we merge this please?

Thanks,
Ariel

On 3/25/22 10:56, Ariel D'Alessandro wrote:
> Hi Fabio,
> 
> On 3/25/22 10:49, Fabio Estevam wrote:
>> On Wed, Mar 23, 2022 at 10:56 AM Ariel D'Alessandro
>> <ariel.dalessandro@collabora.com> wrote:
>>>
>>> BSH SystemMaster (SMM) S2 PRO board comes with an audio card based on
>>> tlv320aic31xx family codec.
>>>
>>> The audio card exposes two playback devices, one of them using the EASRC
>>> (Enhanced Asynchronous Sample Rate Converter) module. Note that this
>>> would require SDMA and EASRC firmware in order to work.
>>>
>>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>> ---
>>
>> What are the changes in v4?
> 
> * Fixed the sound-tlv320aic31xx audio-codec property to point to the
> right codec node <&tlv320dac3101>
> 
> * Reordered properties in tlv320dac3101, and removed clock-names property.
> 
>>
>> I see you removed 'clock-names' so this looks good:
> 
> Indeed.
> 
>>
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> Thanks!
