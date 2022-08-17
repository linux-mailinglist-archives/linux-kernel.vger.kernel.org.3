Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37218596B91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiHQIr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiHQIr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:47:27 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5380775396;
        Wed, 17 Aug 2022 01:47:26 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B087D5C00DC;
        Wed, 17 Aug 2022 04:47:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 17 Aug 2022 04:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660726045; x=
        1660812445; bh=eJdjM2G4sB7ExeX/ghGvYLyWHzgtzAuKtAeAW6HccW4=; b=c
        MUUgBUAa/zHxVrKvDud3Ck2IzqvXgdstw7hfvouWNyxy/GYG0yGzu+BMETP/2bD1
        P6tU/wCtIlL61GI0VQPXG8whOFc8/ou2lamy/JBv5xToprtElouR5tji47MZa+Fb
        KxD88O7TBkff1dkLYy5f6GPglB4p10EO1OFCg49sJB78XGphO3I3cpYLiKFcW9To
        DKFqlNxshRS0rWFh0wHbwpQt6vQ0FqnZ/Vd1SgDr5e7Zc+5Mz7fvfzzovtwKE7st
        5Oy3/b8jF2184TZSrhwCsxxaD3DH3+lU+cWkIRDE2S3TO+nwV4YPsTkvmHbMzXu+
        pPnBMqXlQQWXyMOffcOOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660726045; x=
        1660812445; bh=eJdjM2G4sB7ExeX/ghGvYLyWHzgtzAuKtAeAW6HccW4=; b=S
        6aGhEAw2x9L2hMza6+9atDCM1BP1Wm4R5IRmfEkpqtVZkm28OPTk31jQxHbdzgTV
        4J/lGaQsxm5v8ETGjYeANBAt1BhAxeTwJQN7MpMgUo8fAsedaRefEAfi1AyphpYb
        bdSgrjI/CDu3CmN9C7iE0f3s0wnoUgA5AbLfzRNBlBiCo/xptuuS3EP90uEi8q1I
        Xielk3ESvwVJ3eIlnzvUhLYUTmo88svmcc3ho523YgOi4NNaDQBacNwp/hX17stO
        V3g2ecfPWDIoAcm8qxBvZIvgnXDQGjC0QBy7NxkNEQMvj1NWeURfuo88szh7rWmc
        3ZaQj1j0BjIZYzqwx+N9Q==
X-ME-Sender: <xms:Hav8YiH1_T322uwt7IM7JKvqnpVKRhYsCPtOjJyr_846_eIDmgW94g>
    <xme:Hav8YjUhv29bx9Su3SbZnjoLIuRhOx58eSEPWJgZCR7_LKNyibMbPSZx77TV82t-m
    3tv7onH4_P_ceoEeg>
X-ME-Received: <xmr:Hav8YsIZc9ZvLXLJjsDHIjFsA4BSFIOJSJDL73Hae0TNk9UOYLDCglqroYg8zRsjzq1SyMm1NVp_zmzzqqQMjL5DMgx6dHfQIF782YcoOuvaVTTQh3xUNT4c3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeitedvhfejhfdvjefggeeutdegteejfffgvedtjedukefgueek
    tddtvdegfedtgfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:Hav8YsGv4fcaMz_id0kMTTl2j31xfvRbtJdOSARd6IwjthR0fQs4gQ>
    <xmx:Hav8YoX_Lu_LjSH9JuXlIIlv4mE0K75-iEbGPPhdnGRFQ_JV9t09fw>
    <xmx:Hav8YvPlFnYvzerZQpahI1WSMXkHANtMk1IcBwQVsjH1uYiO5cI7ZQ>
    <xmx:Hav8YhN9mFG_IRsI3L61ECqRRHhIucucK2J6VwcsYzpl7gC09RJb0w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 04:47:25 -0400 (EDT)
Subject: Re: [PATCH v3 3/4] dt-bindings: sram: sunxi-sram: Add optional
 regulators child
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-4-samuel@sholland.org>
 <3e23c288-7065-a3fd-c326-8d66e168ba41@linaro.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <3c646774-3b1e-bb9a-cc7d-c4a010e8a28a@sholland.org>
Date:   Wed, 17 Aug 2022 03:47:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3e23c288-7065-a3fd-c326-8d66e168ba41@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 4:59 AM, Krzysztof Kozlowski wrote:
> On 15/08/2022 07:34, Samuel Holland wrote:
>> Some sunxi SoCs have in-package regulators controlled by a register in
>> the system control MMIO block. Allow a child node for these regulators
>> in addition to SRAM child nodes.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>> Changes in v3:
>>  - Require the regulators node to have a unit address
>>  - Reference the regulator schema from the SRAM controller schema
>>  - Move the system LDOs example to the SRAM controller schema
>>  - Reorder the patches so the example passes validation
>>
>> Changes in v2:
>>  - New patch for v2
>>
>>  .../allwinner,sun4i-a10-system-control.yaml   | 29 +++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
>> index d64c1b28fb61..915ca85c3f10 100644
>> --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
>> +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
>> @@ -56,6 +56,10 @@ properties:
>>    ranges: true
>>  
>>  patternProperties:
>> +  "^regulators@[0-9a-f]+$":
>> +    $ref: /schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
>> +    unevaluatedProperties: false
> 
> unevaluatedProperties is not needed. Your other schema does not allow
> anything else here.

I can remove it. I added it because it looks like the dt-schema tools use it as
an indicator that the matched properties are child nodes[1]. Maybe that is not
relevant here?

Regards,
Samuel

[1]: https://github.com/devicetree-org/dt-schema/commit/b12b3737cabc
