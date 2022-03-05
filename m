Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C14CE4AE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 13:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiCEMBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 07:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiCEMBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 07:01:32 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F837239689
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 04:00:40 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 950D35C0357;
        Sat,  5 Mar 2022 07:00:38 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 05 Mar 2022 07:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=vmjZL3xO/p2LUGnbNdIz4Ii8uyOFUT
        LeArwBNgVOTPk=; b=EDhHShSD1ynAYDI7gYOO/Vzgt1AoXy03Qwpac9rh5O7PiE
        PVTMbeZkBvqOLM2zu07K/ZY9zVNFotnTvAVsRAn5IUe2PWSri2IgY+b2WFvznDFX
        X2TBD6laY+rrNB0ex0zSnyfiKmG+rM6OxyWmeoVjfdutJkuPi9LUSGj8MZA8J8L6
        oZdJGaXI20agD8ywjcOrFm+c20q7ClAIqlnJyEZUwYnNisrqHm9uwqhc7QV1amKr
        qFQzCAWqc/hiC5TGLmIEljHonBYqSZs++4rlfx6Zte5S0BsNd6TB4SppqqRP+ytX
        K3mOSfBbNW3wg/CkqeTfFMc/7I6ZHP8MdzB4Ro9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vmjZL3xO/p2LUGnbN
        dIz4Ii8uyOFUTLeArwBNgVOTPk=; b=EqVp0xytoKstSTEJHmJyn+GWgn6uHxXhv
        2Idxs1MFIylBUiOBZZUEpsGbhQKVEp1kE0k0x5fiFBvBUvkqKr3ZrT8qSuDx8DCb
        VSzVKEaENtOJ4sYCiKQ4zL7ulHljFNl8scKUwysP9r6q3wk5Zjr6MwCImsyo4EjD
        rxpxX8maeLrClPw7KXnkMjD/V9Y+0uk3hW6kMX+6wtFlI8wf2RHXKjbP4oJCnRjq
        rj5mMP9Ey4wF5fxBs6YxzCNfwrg/rGAeE2Ajxg5KMtMunOsLAlF6QbpWP6TAT/yu
        9oqv7wmPS8qWnL1eFGW7jpe3HoIZOk3EQu+Sf02ODQKXftsKa1B7A==
X-ME-Sender: <xms:5VAjYlK4WSvFEs8vO3CCwflKYCyFr-qRho6PXv0qdw7Wwk6Ba52ztg>
    <xme:5VAjYhJDW2BtkCYCQOUhDP9AtoIpB3zgb6v2rlRNkvnqPWn76Yye5gf0NI8T-boCo
    HShDQHy6ekGMkTLG20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddutddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeehtdffledvffegveejgeegvdeujedtteefgfelffehtdetudekteethfet
    keeuudenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvght
    vghrrdguvghv
X-ME-Proxy: <xmx:5VAjYtsSFm3dtyfL074bbGL0yrwKnaQeHPgojbKzb2BK79al9uJwYQ>
    <xmx:5VAjYmY1HthJ8dAi1FaImcwN5bRSMtznF1o9xEXCN65kRCWV_w8BPw>
    <xmx:5VAjYsYkIhPFXhXARubbYScETCY5T-oDWkDVZZUWq8-_NvC2ishrOA>
    <xmx:5lAjYhPWzaVXcIIUMf7GXBgtu23K-Z-Kunepi0n88j6U34YhEw6umw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 484B12740692; Sat,  5 Mar 2022 07:00:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4778-g14fba9972e-fm-20220217.001-g14fba997
Mime-Version: 1.0
Message-Id: <2e36dae0-7eff-43fc-b1a5-2c530f56e877@www.fastmail.com>
In-Reply-To: <0d7b9a17-f5fc-69e5-173f-1c897522d3f3@canonical.com>
References: <20220227115743.69059-1-sven@svenpeter.dev>
 <0d7b9a17-f5fc-69e5-173f-1c897522d3f3@canonical.com>
Date:   Sat, 05 Mar 2022 13:00:17 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Add apple,efuses
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Mar 3, 2022, at 19:00, Krzysztof Kozlowski wrote:
> On 27/02/2022 12:57, Sven Peter wrote:
>> Apple SoCs come with eFuses used to store factory-programmed data
>> such as calibration settings for the PCIe and Type-C PHY.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  .../bindings/nvmem/apple,efuses.yaml          | 50 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
>> new file mode 100644
>> index 000000000000..a735d54856ae
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/nvmem/apple,efuses.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple SoC eFuse-based NVMEM
>> +
>> +description: |
>> +  Apple SoCs such as the M1 contain factory-programmed eFuses used to e.g. store
>> +  calibration data for the PCIe and the Type-C PHY or unique chip identifiers such
>> +  as the ECID.
>> +
>> +maintainers:
>> +  - Sven Peter <sven@svenpeter.dev>
>> +
>> +allOf:
>> +  - $ref: "nvmem.yaml#"
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - apple,t8103-efuses
>> +          - apple,t6000-efuses
>> +      - const: apple,efuses
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    efuse@3d2bc000 {
>> +        compatible = "apple,t8103-efuses", "apple,efuses";
>> +        reg = <0x3d2bc000 0x1000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        ecid: efuse@500 {
>> +              reg = <0x500 0x8>;
>
> Mismatched indentation. Rest looks good.

Good catch, thanks! Will fix it for v2.


Best,


Sven
