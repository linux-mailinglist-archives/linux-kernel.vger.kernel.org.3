Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778A8572BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiGMDBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiGMDBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:01:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262E9D64E2;
        Tue, 12 Jul 2022 20:01:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 85DDB5C00BE;
        Tue, 12 Jul 2022 23:01:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Jul 2022 23:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657681277; x=
        1657767677; bh=IX/xuPhA1GhYJNalCXe7PUV3ahJKE0iqzjYmdUN5By4=; b=N
        GCyoWzlVHaJXrmPU9AnDWIoqY+jhJ8uau0h1esA/9qOQykTiMax3YLh84vfKuTJX
        4J6u58Q3BAO/CqNVDIinNyw/00jPP2FWVSK/56DQNpd2igEAxjrYcpI+HH13Xgck
        2RsxAG3ipaMc7letBqqLzY9rcCzt7zAYdLIY2iSRsdE+Iq0XgM330n6mG4ejoAbW
        O56QstjQjN8vZcBWHDBD+fAAVn7e0NbRZOnwaA+GHKZtrCpb9w9CVpH6EfXClh53
        m33Rd1H6xfnQS2DdVJ2eBoeF5hJRP3VdPM5cx0tGOK6CUPoiocXNcfJeuxNso4P6
        Yxtp/vAyDe26gTFWgRNmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657681277; x=
        1657767677; bh=IX/xuPhA1GhYJNalCXe7PUV3ahJKE0iqzjYmdUN5By4=; b=G
        rPmlsUXGYBy9hmyDoQ1f8oHg4igM/LsPLgVGqxHWrQ2szWCrzuV0Vken95P8Qa9j
        0JoqD1WBmTiUQyfhPRfzki1Kk4cXjazvdhRZvkMW0KYBRjkcJ5QyAKkgVo+WAYLY
        go672uzD1x8ZVBIgPwakUykwo/njOTbcVWCl4A/NUsBai7Nj3vXjFSAxZkpYtiTu
        HixmiLuIbXWadLyFWOzY4e78qaVdDWGFIuqlj5o3Mqvknfjjv2X31M/ytoLs0dOJ
        FrIsY0v9sVbAm1KpIGoc5zWvS9CfXwzVCwDvehd3V9u5UPEpSv/Xt9AYqxoLFgXl
        KENaLybUnl02JkgjGhLBQ==
X-ME-Sender: <xms:fDXOYkYXDRQD7C1LwnBN1AukH04EbTw-WKhshNQfgdqo05Pe6SvhJA>
    <xme:fDXOYvbo-byWPZOqLJjYpIuh6bX9l_jbKIdXqLuJFgIdB55BGP9J-MhT9CmQmKF26
    HaEQFbYW3K60ezIfg>
X-ME-Received: <xmr:fDXOYu-M3QtRomq3GSGGel6HLSBeSjh6GxsZmAknrR3HvLorfbl_DtpKwhk2WpEDUWoovh_jD8AJ2VPKg3AZXV8GlOiZ60aNRRobM7kmR3g6jGXC0I7Qi4-kQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejiedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:fDXOYuonK41IB2Ls64O4tJrBgH8ggEroI9wsHaKbnQkz-ZM11XXH9Q>
    <xmx:fDXOYvr-N9VQbL6UWkbTPiP4OXj6zTc7VrQj3ZvlBJilf2F1EZC1MA>
    <xmx:fDXOYsTISnM7Ildottj7UuSuatLupxiDbIzqrp0luin0YWDeNR7AaA>
    <xmx:fTXOYi0XYiEYa2S4-mOFb9DO57VlJRjYwF_o3QwcMvgMyah6r1sNjA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 23:01:16 -0400 (EDT)
Subject: Re: [PATCH 2/2] dt-bindings: arm: sunxi: Add several MBUS compatibles
To:     Chanwoo Choi <cwchoi00@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220702042447.26734-1-samuel@sholland.org>
 <20220702042447.26734-2-samuel@sholland.org>
 <59e565e3-8930-9010-7642-2b13607cba61@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <3a57d278-295a-313e-ed22-7cc482e9921f@sholland.org>
Date:   Tue, 12 Jul 2022 22:01:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <59e565e3-8930-9010-7642-2b13607cba61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 3:06 PM, Chanwoo Choi wrote:
> Hi Samuel,
> 
> On 22. 7. 2. 13:24, Samuel Holland wrote:
>> All of the sunxi SoCs since at least the A33 have a similar structure
>> for the MBUS and DRAM controller, but they all have minor differences in
>> MBUS port assignments and DRAM controller behavior. Give each SoC its
>> own compatible.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  .../bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
>> index 2b018feb56df..99566688d033 100644
>> --- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
>> +++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
>> @@ -29,10 +29,20 @@ properties:
>>    compatible:
>>      enum:
>>        - allwinner,sun5i-a13-mbus
>> +      - allwinner,sun8i-a33-mbus
>> +      - allwinner,sun8i-a50-mbus
>> +      - allwinner,sun8i-a83t-mbus
>>        - allwinner,sun8i-h3-mbus
>>        - allwinner,sun8i-r40-mbus
>> +      - allwinner,sun8i-v3s-mbus
>> +      - allwinner,sun8i-v536-mbus
>> +      - allwinner,sun20i-d1-mbus
>>        - allwinner,sun50i-a64-mbus
>> +      - allwinner,sun50i-a100-mbus
>>        - allwinner,sun50i-h5-mbus
>> +      - allwinner,sun50i-h6-mbus
>> +      - allwinner,sun50i-h616-mbus
>> +      - allwinner,sun50i-r329-mbus
>>  
>>    reg:
>>      minItems: 1
> 
> I have a question. 
> Are there the device drivers for the newly added compatible?

There are not DVFS drivers yet. However, the nodes are needed for their
dma-ranges property, which affects some other devices that do have drivers. And
at least for D1, the MBUS node is used for U-Boot's DRAM driver.

Regards,
Samuel
