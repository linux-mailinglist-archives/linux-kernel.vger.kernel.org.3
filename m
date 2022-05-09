Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC6D51F3AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 07:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiEIFBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiEIE7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:59:43 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AA0BBF;
        Sun,  8 May 2022 21:55:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AEF995C00F9;
        Mon,  9 May 2022 00:55:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 09 May 2022 00:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652072146; x=
        1652158546; bh=rqjpnOUJzRgcRrP/waTDuMu336TXRB4V1nDMgbHbydc=; b=a
        7f31izfTJ1lTX/4z7eDmjD2P0VUB6s6tYswG7DhZ60X3xb6Qy4UOTdlYLgRqaabY
        Zv6DjzlpJA/nEfRECtqdfRjY9uktz+TUqpTpxTSLCoIurwuJo2gCa/z0BJGKRsqx
        bbvYMpZqyNeCKTC0y+6xA/FpNMrbKuZyzcEtIGtbTEmkKVJ6JTjEHADwNTLaMyo8
        1W5fATtOxe6RvBak0ZWVNy43I5ayO9X2NqpUBlcC5OjLPC7eXqBwJ3IgNW7lsPwl
        lRY0H7525sbjJfGIzTkfJQXcQz5iNxb48SEs8V4ckA/bo4nOMrS26MJEmjmFjzps
        1yzdbxqfOZCw5+OqN7LrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652072146; x=1652158546; bh=rqjpnOUJzRgcR
        rP/waTDuMu336TXRB4V1nDMgbHbydc=; b=CQzJ7jh2Oy1GvhjybovNkgAjl9bQs
        pmHgxRYueLygNkQZp9BWsk5R3S8qBMktThk3udJjARdwTvwfW1LPls+a794Cb7fI
        RIJWKrEROsMejphBM8bEjpUPHHlmV3AP8/W8icLgB2lN6JbHc1nq5XfY20kRFGzW
        WRCzWsCaBqDVpxdMgamNLmgSPxiU8viCvLH2qKEkmRA6+0mcXNtT+9fcMilqBepm
        EGtvAgEMw/HiO/sbtrnYUHFs6oV/zJ3yu3HxKslGHBSrEcXK2aOxxh11yrFmDmK8
        PoOB3GAgjCBXjRqoGlNzGz/c404o4JkeY0oE+cu47KPYO8wtjRl5CfwNA==
X-ME-Sender: <xms:0J54YuSYKVcBpRkMEHBJLCJN_FQkolnHaEa6B4ng-05z6M6m4F4-UA>
    <xme:0J54YjwNOW610eWDfBM2nhHBM8OIJ4ROnLgxF-oAZpbIuQf1BQGEez0TA5vXkfOnu
    srlY6VVKMq_LK_9yw>
X-ME-Received: <xmr:0J54Yr3i3mIc8tIYJ0NimEkZSR1f47XNcJP3pdxsTPR9kw5QH4q63ecJwXbSJQuO3bfGN3sv-ZV2OwZJnZuLgaXhsFZPJTLWXbxoBeaf4YTmtuPbUo5_PXPkmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhephfffheejteegffefheetjedvleethedugefgheeifeekffegueeg
    ieeikeegjeeinecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgr
    mhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:0J54YqDEu4nx7CbO87WnQdOvi3EVFNEnhHve04UvRKUuRIKp6fx-NA>
    <xmx:0J54Yng8XpfovBEVT8ETtJ-M_mR-S7K302BuPtpMgu08klqlgfrHcg>
    <xmx:0J54Ymor-mzCHXt5ekYfXXkajWS1kziT-MXAM3HjBmOdrNN8aXvMDw>
    <xmx:0p54YmNNy6U-e8BJsKfxePJEJtwDrn4sDVJExauy2mpq4yI-Zk3mBQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 May 2022 00:55:44 -0400 (EDT)
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Enable CPU opp tables for
 OrangePi One Plus
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, x@xff.cz
References: <ANAAfQDrFEUw2aEo5XZZDqq2.1.1652016541476.Hmail.201821123082@jmu.edu.cn>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <63e88351-2242-b2bf-3e72-1db66cd9d9bf@sholland.org>
Date:   Sun, 8 May 2022 23:55:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ANAAfQDrFEUw2aEo5XZZDqq2.1.1652016541476.Hmail.201821123082@jmu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chukun,

On 5/8/22 8:29 AM, Chukun Pan wrote:
>> The AXP805 datasheet has this information in the description for REG 1A.
>> DVM is disabled by default, and when it is enabled, the default ramp rate
>> is 10mV/15.625 us == 640 uV/us.
>>
>> Did you notice any instability without this delay?
> 
> Actually I write this based on the commit https://github.com/torvalds/linux/commit/ebae33c
> ("arm64: dts: allwinner: h6: Enable CPU opp tables for Orange Pi 3") and https://github.com/
> torvalds/linux/commit/fe79ea5 ("arm64: dts: allwinner: h6: Enable CPU opp tables for Pine
> H64"), so I think it's necessary to add this delay.

Thanks for the context! I think the suggestion comes originally from here:
https://lore.kernel.org/lkml/20200405115138.vrrvv7spnv6ifm6x@core.my.home/

From my reading of that thread, there appear to have been no reliability issues
before adding this change. It was just based on the available information at the
time.

On the other hand, adding this property will cause the CPU to spin for up to
112us in _regulator_do_set_voltage() during each CPU frequency change. So this
adds a lot of latency, which I would like to avoid if possible.

Regards,
Samuel

>>> @@ -216,6 +222,7 @@ reg_dcdcc: dcdcc {
>>>  				regulator-enable-ramp-delay = <32000>;
>>>  				regulator-min-microvolt = <810000>;
>>>  				regulator-max-microvolt = <1080000>;
>>> +				regulator-ramp-delay = <2500>;
>>
>> This change is not related to CPU frequency scaling, so it belongs in a separate
>> patch (if it is needed).
> 
> The two commits mentioned above also add this delay to dcdcc regulator.
> If there is a need for a separate patch, I will send these separately.
> 
> Thanks,
> Chukun
> 
> 

