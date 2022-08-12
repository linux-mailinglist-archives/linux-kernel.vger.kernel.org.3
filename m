Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5906A591779
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiHLW6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHLW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:58:52 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0C95AFE;
        Fri, 12 Aug 2022 15:58:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 59D7432003AC;
        Fri, 12 Aug 2022 18:58:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 12 Aug 2022 18:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660345128; x=
        1660431528; bh=P9CWBxixdXhGy2tM+UZaqwS2e4jHPYt7yfX7kGMtD0I=; b=L
        eQs4JJYO3JrcuXT0TvnwZ1ceRnRuiE6C76Hxu0nlM7JPKtSpjEbIOP/LKVRG1EME
        EVkkHVRfN6N2QkG/7k6TOoHS6drktdzhIVvh37tAgJ+JUASHLASVNldFoMyirjoI
        caQWycKlJNJ2mPYFmUTx+wStJAn8ZTws0q5fGxha97GQk9bSIjtTQC5Su8PMymzs
        przJXY+iyDTRtTuc8XdG9M45q9a453BIFwD6eJkzoNFMlWg8ZRmvjxgvUgisJCus
        i6zoyZOFFcR/0KHqbJvzR54RqEttOGzmIvVmtX6bZVNhxpj955K0VJkdMOBpQOBx
        QqNE5dX9DC1xal4CvUyZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660345128; x=
        1660431528; bh=P9CWBxixdXhGy2tM+UZaqwS2e4jHPYt7yfX7kGMtD0I=; b=l
        jOdnRHi45bTlc9jV3b8KsXnbtCjhOtwVrQWn+mwl4gvX2GrbcZ/unxELvJ+0HTIk
        /SqkvHnx9t2aNEcKtpTbXiE8NeVQG/AbZNFMR6MqoINJvx3RzSgcpzrUq5YEwWFz
        w2qKRjBLOyA3NKS7xbFNEiOm0Gf2PZ2F/tvNszeYTYWPGehPQVwQXB2+2AlCgfQV
        VZjrn1+zkv9axFPbKphCqzeCTNNVD14UPdkjRtjKiMe5/FQBlFNis4WSVv0Ze9GT
        lFUu4/oJeJvdBVpkFjYNfBVDlZQKupxHV/Gx+fe9L5fOxg/TWbAh1ABgW0XnNIax
        jsE2jjRXOv8T0SqWO9tIg==
X-ME-Sender: <xms:KNv2Yv08IMinok4V4BCUFTHPg4Q8wvnv57K1E8A_SGjebqaPMh6ktA>
    <xme:KNv2YuFhtxO-GHz5ixibKKh5OLMbwEU9wHKY3ZwLJhk7F0FpfjKUI1XovvUl7rPCD
    PTeibWg4Iha9jvzbQ>
X-ME-Received: <xmr:KNv2Yv4q0Xd3P0L-stmhwbbq_XomYrasRn-IBPGlfkXV0z0LBS3y1ZSCrbYRZLBUMvJMZgiQ6MOiz-C0hwZxY255fpIykJkZvviUC4Wb8hujCeSJbnGxuativg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:KNv2Yk3uuhsqDXdg-nJc7ci4rh9xpYlIvqnm-344vG5s5LmS5d9TCA>
    <xmx:KNv2YiFp8HEobYBfyt6_ALiQLyvHEe3HihhhVnWlR0BwBfNcBmiOzw>
    <xmx:KNv2Yl8FI4vCnNRNTTNoAglbVS8KIeJOwDsQdSYWr9S5VcAa0Yqr5Q>
    <xmx:KNv2YpdlZZzZSMnTzKtmpC4Pp9lJCbP6bcsnlyvnsTPZmpGFO4gOZw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:58:47 -0400 (EDT)
Subject: Re: [PATCH 2/4] dt-bindings: display: sun6i-dsi: Add the A100 variant
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220812074257.58254-1-samuel@sholland.org>
 <20220812074257.58254-3-samuel@sholland.org>
 <13fcaa01-d2c0-e57f-bedc-b2e0536a55f9@linaro.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <379eabe8-3f55-d69f-dd2d-120b8d13f1b3@sholland.org>
Date:   Fri, 12 Aug 2022 17:58:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <13fcaa01-d2c0-e57f-bedc-b2e0536a55f9@linaro.org>
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

Hi Krzysztof,

On 8/12/22 5:49 AM, Krzysztof Kozlowski wrote:
> On 12/08/2022 10:42, Samuel Holland wrote:
>> The "40nm" MIPI DSI controller found in the A100 and D1 SoCs has the
>> same register layout as previous SoC integrations. However, its module
>> clock now comes from the TCON, which means it no longer runs at a fixed
>> rate, so this needs to be distinguished in the driver.
>>
>> The controller also now uses pins on Port D instead of dedicated pins,
>> so it drops the separate power domain.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>> Removal of the vcc-dsi-supply is maybe a bit questionable. Since there
>> is no "VCC-DSI" pin anymore, it's not obvious which pin actually does
>> power the DSI controller/PHY. Possibly power comes from VCC-PD or VCC-IO
>> or VCC-LVDS. So far, all boards have all of these as always-on supplies,
>> so it is hard to test.
>>
>>  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 28 +++++++++++++++----
>>  1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
>> index ae55ef3fb1fe..c53c25b87bd4 100644
>> --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
>> +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
>> @@ -12,9 +12,14 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    enum:
>> -      - allwinner,sun6i-a31-mipi-dsi
>> -      - allwinner,sun50i-a64-mipi-dsi
>> +    oneOf:
>> +      - enum:
>> +          - allwinner,sun6i-a31-mipi-dsi
>> +          - allwinner,sun50i-a64-mipi-dsi
>> +          - allwinner,sun50i-a100-mipi-dsi
> 
> While you are moving code, how about bringing alphabetical order?

I have put the sun*i prefix in numeric order, which matches (almost) all of our
other bindings. It roughly corresponds to chronological order as well. It
doesn't make much sense to me to sort sun50i (ARM64 SoCs) between sun5i and
sun6i (early ARMv7 SoCs).

Regards,
Samuel
