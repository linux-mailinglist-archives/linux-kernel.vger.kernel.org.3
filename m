Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024DC59B6FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 02:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiHVATI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 20:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiHVATF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 20:19:05 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8039B15727;
        Sun, 21 Aug 2022 17:19:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E149A5C00E4;
        Sun, 21 Aug 2022 20:19:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 21 Aug 2022 20:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661127542; x=1661213942; bh=L2nkszgY5W
        OfLgRzK4a0UTYpubHoRBwTEQkzg8BqgV8=; b=LygE7oGCZGQrEJbufqeGM76mIs
        M/PjtSxgA2DNSOl0S9uAEKPMLttVPpdcpeQtAYCtAER1eepiE08PzrOCipnx84CC
        7TeESltxOHCNzR00fyTlWpbr1IP/18FiyEldDA2Dfha/bS4nYa+XMzdrHwMixa1G
        DUJ5a8pBQn62QdhtEI6aOdQSTi95UgOuaiqEoA7H632q/VL4pHOsHBSNKuyQ3Znm
        iIQQ/N4OXJ/dPOFI0PIY8t9Z0mKX0Ju1STgytjFFtaitRQg0Eqk4p3gxb1Rga5yY
        QvsUR+9l/dxo0uOXGrqFvDznHSIaoxWpUe4KWY1wxO3Y/goCJJB5QM/RoTTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661127542; x=
        1661213942; bh=L2nkszgY5WOfLgRzK4a0UTYpubHoRBwTEQkzg8BqgV8=; b=o
        gfLdqt6wbPAR0sXCwaq4zcEkmMMKZCZ/ESqK/G/zVM/WjKnbtqZAzMCCEFrpakke
        42TvM0/0qykA39za++YftSeMEjruEGHwYgt5BPhnvURBXmiO0RdupD0oX1gEr1Ss
        yFGXqvT6RnaoPO8aQQ0f6s4GI/fsAq5p+aFDEZ3RjuWqeKYcdeyCmwudT18oI6Dz
        5ErkfTUsK2XLd2325kJi9K71OOvvWQuWMEwjNvhYPI8+IDDCm+GfCchb5qCBAVSg
        RnNX2Uxd2RMdr4Pure0tQqgmy/UO2iwOXjbTPWKM3nLSBtouHHftiVjyeD/TecnR
        W0X/RnjgwKr1r8kOqPYtg==
X-ME-Sender: <xms:dssCYxQx4TasUzZxR4pdf88CLkmagWVgum4J6A83ATl65KXfeCrgGQ>
    <xme:dssCY6z5X47wBkPU6Z6QuGRQr161ErGsdmg_e-10lnj8I_Gj6tEcK8uOgxB2ewUK6
    cCOKvh5893XKkr-dQ>
X-ME-Received: <xmr:dssCY20uHiNgRzO4861SmEehuRCZTffIVbqcGp4FOMYTFML7TtInpw5pGOfifWlUOobjYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiiedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ekredttdefjeenucfhrhhomhepvfhomhcuhfhithiihhgvnhhrhicuoehtohhmsehtohhm
    qdhfihhtiihhvghnrhihrdhmvgdruhhkqeenucggtffrrghtthgvrhhnpeelgfffheegtd
    fgudefhfdvveeviedttedthfevgeeugffgveeujeefteetteeigfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepthhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:dssCY5Ae76hQ1mLulG_Bfu6PZRHNyT5a5jYHGw9nrkpSxEx5zRTAgg>
    <xmx:dssCY6gnSQxOsWLxVPM2KoD7vMVBSJyFA2tvFRyuqOCn1kPaToURcw>
    <xmx:dssCY9pujbTvodKmvRtB_wWwNtBdLJ9UIejjG0q1AzxW2ZubDxye0w>
    <xmx:dssCY64g--RsODk7U39RdeC3t2zOnVd4MGOw7OzydtrHAo5YMg2jyw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Aug 2022 20:19:01 -0400 (EDT)
Message-ID: <460cd42b-4192-6761-7313-268a684e1e28@tom-fitzhenry.me.uk>
Date:   Mon, 22 Aug 2022 10:19:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <n@nfraprado.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
 <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
 <20220818030547.eblbmchutmnn6jih@notapiano>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <20220818030547.eblbmchutmnn6jih@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/8/22 13:05, Nícolas F. R. A. Prado wrote:

> thanks for getting the upstreaming of this DT going. Some comments below.

No worries, thank you for your review!

> You're also adding the SD controller here. Does it work as is? If so add it to
> the commit description as well.
I will note this in v4.
>> +/* PinePhone Pro datasheet:
> First comment line should be empty following the coding style [1]. Like you did
> for the copyrights above.
>
> [1] https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting

I will do this in v4.

> This signal is called vcc_sys in the datasheet, so I suggest we keep that name
> here. It's not everyday that we get a device with a publicly available datasheet
> :^).

Indeed! :) I will do this in v4.

> + rk818: pmic@1c {
>> +		compatible = "rockchip,rk818";
>> +		reg = <0x1c>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_LOW>;
>> +		#clock-cells = <1>;
>> +		clock-output-names = "xin32k", "rk808-clkout2";
> What about keeping the datasheet names here too? clk32kout1, clk32kout2
Per Megi's response, I'll stick with the current names.
>> +			vcc_1v8: vcc_wl: DCDC_REG4 {
>  From the datasheet, vcc_wl is actually wired to vcc3v3_sys. But looks like
> vcc_wl is only used for bluetooth and you're not enabling it yet anyway, so just
> drop this extra label, and it can be added when bluetooth is added (or not, and
> then the bluetooth supply just points directly to vcc3v3_sys).
Good catch, I will remove the vcc_wl label.
>> +			vcc_power_on: LDO_REG4 {
>> +				regulator-name = "vcc_power_on";
> The name on the datasheet for this one is rk818_pwr_on.
I will use the name rk818_pwr_on in v4.
>> +
>> +&cluster1_opp {
>> +	opp06 {
>> +		status = "disabled";
>> +	};
> There's actually an opp06 node in the OPP for RK3399-T, only that the frequency
> is slightly lower. Maybe you could keep it enabled but override the frequency?
>
> Or given the above point about the max voltages, maybe it would be best to have
> a separate OPP table after all?
Per Megi's response/rationale, I'll keep the existing table, but 
re-introduce cluster1_opp/opp06 with updated frequency/voltage, aligned 
with the RK3399-T datasheet.
>> +
>> +	opp07 {
>> +		status = "disabled";
>> +	};
>> +};
>> +
>> +&io_domains {
>> +	status = "okay";
> Let's keep the status at the end of the node for consistency with the rest.
I will do this in v4.
