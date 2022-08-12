Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6954591769
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiHLWo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHLWoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:44:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E74D6DFBF;
        Fri, 12 Aug 2022 15:44:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D03EB32002F9;
        Fri, 12 Aug 2022 18:44:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 12 Aug 2022 18:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660344292; x=
        1660430692; bh=eHaYN+aY4bW7BBAcwDPtlT5DUdMR3lZc1lanNKf+X2E=; b=y
        xGydJ/BYVM5H/koF87d7C9Z6FJyYx7A96ssH3pivfZ9XoWPiQPjW8OYYrVaeVAkf
        wio5bxYolsXU2N+bsNOo/qzLv/tzSahaJ55+v82HG7KtzW7zkn+kIzuDvLqrKV/c
        fSZpdBaJ8VTY9mfu9h8KVEKnzwGT3YwwmN0kYtxlb598qs6J1XrX8Rxxko7Rbzl0
        XlwmpHew1oR1kZYGIwMh9W/v13rv7pAjlO3yHaFH3fY0HqNImaoFhP1Xt8xb5LUT
        5ZhLKD3RI0oNnrT+CygCvbSHziC3vkA0o4Ayj4W2JGXXne9ZO8UiunPd0HiLNBJu
        jrW2n5r0nPi4tIYUvvt3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660344292; x=
        1660430692; bh=eHaYN+aY4bW7BBAcwDPtlT5DUdMR3lZc1lanNKf+X2E=; b=k
        uGXKzjuDEhMYgepOUZhdL5FNXZuwtlu1HhKJOdN5HE9syykiE0jlOFAtRJTArANU
        gQPgO/syw6ZdIZmhOpZw5/QgxrqFghvviGquJIWN+EoNRY+ZODjiPN567wuz5hAM
        D2uEDOSmGV7GqmtPgdGeoo5Fe0VwSYJnOGgfwaxxDnSSdTiAMzBtDnpGjZFn8x7d
        wccuZao/2V1jE28uVVAZ6xxUzZR7u6MTuNC8/YoQLjlH4hK5PNBd+1H1vT4/qtEW
        zYQnnlJ9ojdO3Bmz1cNvFrG90Rib0byj7c7pXaqh728tw0vVCNT/RLfSggv2T0Tc
        tSl8M0g1oh/cS1Wdq/5IA==
X-ME-Sender: <xms:49f2YpnWEdv3ZEjXcq-Bpnhsp2EvYe3FFBEQ0PFjshCkS3qaZBeiIg>
    <xme:49f2Yk3xZxhXgS7oC4ok6QntKSqw0iVghgN29M6jMJ4w7Oxuo7CNh8ugoTOxP88tq
    ZqMPFWr6M_6STKzjQ>
X-ME-Received: <xmr:49f2YvpDafcehHBOc8CTDCvkFHNod3NGS3Ca3JpKbwlj6kLM2EWzZWhTbCn7-ifQj4_vcGBWZXasPkH6J0tW-KUYtK3iYp5iDg33-2vKaxB5FW2V3Lgi53AC1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:49f2Ypn5P6YVu3vrza3uIwgxZguiTRUzIZHhGOFzyElzqgFpDBIAKA>
    <xmx:49f2Yn2AzEaM8BxINzupB_cgjTfSRBbnrhJ-3wqf-b4mWJP6PMv_5g>
    <xmx:49f2YoufpTq23d5Ih7RSx6vJZCbpuW5o1H-2cIXJFoNA5tQfDRWm1A>
    <xmx:5Nf2Yu11M5SvZXi-4P_UBLTQFeyi-McoY8LOjgiND-1ZKHb_tRxcnw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:44:51 -0400 (EDT)
Subject: Re: [PATCH 1/8] dt-bindings: sun6i-a31-mipi-dphy: Add the interrupts
 property
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-2-samuel@sholland.org> <YvZGAEM4B8SdDjwJ@aptenodytes>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0c82fb9e-60cd-70d5-96d6-ee06c56eeb85@sholland.org>
Date:   Fri, 12 Aug 2022 17:44:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YvZGAEM4B8SdDjwJ@aptenodytes>
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

Hi Paul,

On 8/12/22 7:22 AM, Paul Kocialkowski wrote:
> On Fri 12 Aug 22, 02:55, Samuel Holland wrote:
>> The sun6i DPHY can generate several interrupts, mostly for reporting
>> error conditions, but also for detecting BTA and UPLS sequences.
>> Document this capability in order to accurately describe the hardware.
>>
>> The DPHY has no interrupt number provided in the vendor documentation
>> because its interrupt line is shared with the DSI controller.
> 
> Interesting! I do see DPHY_INT_EN*/PD* in the Allwinner BSP's
> drivers/media/video/sunxi-vfe/mipi_csi/dphy/dphy_reg_i.h

You can also find some bit of documentation in the T7 User Manual.

> Maybe it would be useful to import the fields in the driver so that the
> next person who'll try to debug DSI can use them directly?
> 
> You might also want to submit a patch as [PATCH NOT FOR MERGE] that
> adds an interrupt routine and some useful debugging.

I think this would be more interesting to someone who knew more about MIPI
CSI/DSI and understood what those errors meant. :)

I'm mostly concerned with bringing up the D1 SoC at the moment.

> Do you think this is also available without a DSI controller?
> I could just give it a try on V3/A83t here and find out :)

I would assume so. It could possibly be shared with the MIPI CSI interrupt (SPI
90) or keep its position at SPI 89.

Regards,
Samuel

>> Fixes: c25b84c00826 ("dt-bindings: display: Convert Allwinner DSI to a schema")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml           | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
>> index 22636c9fdab8..cf49bd99b3e2 100644
>> --- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
>> @@ -24,6 +24,9 @@ properties:
>>    reg:
>>      maxItems: 1
>>  
>> +  interrupts:
>> +    maxItems: 1
>> +
>>    clocks:
>>      items:
>>        - description: Bus Clock
>> @@ -53,6 +56,7 @@ required:
>>    - "#phy-cells"
>>    - compatible
>>    - reg
>> +  - interrupts
>>    - clocks
>>    - clock-names
>>    - resets
>> -- 
>> 2.35.1
>>
> 

