Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6635B2CE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIID3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiIID3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:29:18 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EE611FCA7;
        Thu,  8 Sep 2022 20:29:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D19D85C009A;
        Thu,  8 Sep 2022 23:29:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 08 Sep 2022 23:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662694154; x=
        1662780554; bh=u2mfimWztm9KQP3elvYFu0j6jCYKTV0elyvFijpDNZE=; b=U
        cQXJWFplo5C80tlInQnC7VDI+iOufXSaNlaaYvNptR7kUx7Bg3jc3ULvMkZ+b+sa
        fGwAk/BAW6vvqpntekBUl0jV/KinZoPeHVBh98CxTPSgma4n9Wvdj2MP73ZImBw7
        bynA4VrdojWaiCc12pVjSseaE1X2gvhmL6D5L6nXfYMUm0vfqd39yOxhqfYef/DR
        bDhXAFW50pIgGi/hgi54YJPt32xS9Fh+4PWOJ8urPeVIGuY1MrRS9+Abwv6KGXfC
        VAom3Ru3t7nTHyqqhlvQw7u99kSFuE7P4HOcKUeTJ+Q8s5ZuH0GrsXjMldPYaW40
        rCeI5YRoJfN9wH9EJMR4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662694154; x=
        1662780554; bh=u2mfimWztm9KQP3elvYFu0j6jCYKTV0elyvFijpDNZE=; b=i
        t/wbNrxp0itN7StKmyyMHHugswmXmiV7t5lWxjizWH9CfpoxDb6mgmRKEy8+BFAp
        fOUaI7Z0l8UbZbSDhGvUbCoySdbKksYnci8MPzcgn5KAqlGHrG1juQOVirVWXg4p
        DM6i8+MX8RFW1oJcCHl4V95kuCUKd1A8GydfIiL1oa6HJWFeoxFDjhqGREMpMZmF
        bO74sRNhctbuerjCnB6laJYuoIv2xAJDblSqC/HgqgG9cQI2bmqgm2vFVJnyClAy
        J2TOzv9ysrGNMMz8LiloL2bsUU8ZODulZB2pqZiNyi6MNaGAEErguemyDIQnhO4u
        7YE+CIswm3MmFAXLMFUxA==
X-ME-Sender: <xms:CrMaY6smHBadu5yYDpW5j-zT8znrXqT2XcnWLtOJcLaSSL9z8tq0pA>
    <xme:CrMaY_c0VOwwzSIiQICsHl89-7meHYBkTr75cCagNYhmr292NbPSHqkVCzurKuPWz
    -kdt46tndBpXG6pCw>
X-ME-Received: <xmr:CrMaY1zPhER_XoX2JfqfYaNbw4csqJ0XGmr8SVvYpYnACYyGhdGEglzALdzeKjF1ADMxFbZpbYuqQZy5i2cGLo7Vm-6BFotudQzr7hKsZvAvX7CSvmuOnKlgFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtgedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:CrMaY1NejLR4p4P3Nh8NQc1Ok2HV9EkKTy0P9RC6NBwMdBpN8fFQXw>
    <xmx:CrMaY69_SieeYHAVsd8xoIFZG6CIwNqPe2QZXTl_HNPODm7KNgAMlg>
    <xmx:CrMaY9UzqqFGPhrrpEO2th7Q89ORTk4Zkwiq-xJVSjGNrjuOAyQIJA>
    <xmx:CrMaY-RGthwMylriTPBwcXBMxWfGiOdc4_-N3R8FjFpRZjmjzcTe4w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Sep 2022 23:29:13 -0400 (EDT)
Subject: Re: [PATCH 3/4] dt-bindings: nvmem: Allow bit offsets greater than a
 byte
To:     Rob Herring <robh@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220814173656.11856-1-samuel@sholland.org>
 <20220814173656.11856-4-samuel@sholland.org>
 <20220825210252.GA1671168-robh@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <68274f65-48f0-fe37-cefc-876d18e327e6@sholland.org>
Date:   Thu, 8 Sep 2022 22:29:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220825210252.GA1671168-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 4:02 PM, Rob Herring wrote:
> On Sun, Aug 14, 2022 at 12:36:54PM -0500, Samuel Holland wrote:
>> Some NVMEM devices contain cells which do not start at a multiple of the
>> device's stride. However, the "reg" property of a cell must be aligned
>> to its provider device's stride.
> 
> How is a DT author supposed to know this? 

To know the stride? They know the compatible string of the NVMEM provider
device, and the stride is a property of the hardware.

To know that alignment to the stride is required? That's not documented in the
binding. I can add that to the "reg" description in this file.

> I would lean toward it's the OS's problem to deal with (your option 1 I 
> guess). I worry that one client could expect it one way and another 
> client the other. Or folks making DT changes to 'fix' things.

After this binding change, the meaning of

	reg = <0x2a 1>;
	bits = <0 8>; // optional

and

	reg = <0x28 4>;
	bits = <16 8>;

would be identical.

With option 1, only the first representation would be valid in the DT.

With this series (option 2), either representation would validate in the DT, but
only the second representation would be accepted by Linux for the driver in
question (sunxi-sid).

With option 3, either representation would work in the DT and Linux.

Note that there is no restriction on the bit length, so the following are
already equivalent today:

	reg = <0x28 1>;
	bits = <0 8>; // optional

and

	reg = <0x28 2>;
	bits = <0 8>;

So there are already multiple possible representations. I don't really think
that is a problem, since the meaning is still unambiguous.

Regards,
Samuel

>> These cells can be represented in the DT using the "bits" property if
>> that property allows offsets up to the full stride. 63 is chosen
>> assuming that NVMEM devices will not have strides larger than 8 bytes.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> index 3bb349c634cb..4f440ab6a13c 100644
>> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> @@ -53,7 +53,7 @@ patternProperties:
>>          $ref: /schemas/types.yaml#/definitions/uint32-array
>>          items:
>>            - minimum: 0
>> -            maximum: 7
>> +            maximum: 63
>>              description:
>>                Offset in bit within the address range specified by reg.
>>            - minimum: 1
>> -- 
>> 2.35.1
>>
>>

