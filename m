Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3084F01F4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354992AbiDBNHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354987AbiDBNHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:07:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C2111744;
        Sat,  2 Apr 2022 06:05:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 30CEB5C0085;
        Sat,  2 Apr 2022 09:05:22 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 02 Apr 2022 09:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=MME4DPlmxw4OEbGoGjpt1lgxpmzoAt
        tfZ6Spqlp45/w=; b=COl6nk98BhshABHNc1WUszh9m+HY9o4XmLQVohYL1/1ilr
        2Jzzefgxko/sbE0Msf98nWKAh30apP4N7MkRt1PlfcFW2TPuxoWzpYTREW76tMXc
        1I4ROAti/RWess8tt3mC/flQPL8JkHmrAJmsVzCEAeoelixt3KQKxQX05N4q7CM9
        Kd3R2eDus00hh5vjGlq/Q5k+izInV8y47FwN4sHS4QgRriSGl8cOtOItHWW6zL6Q
        W9Ry8boi5wB/M9gyJ1scGZysEKu8T5lv0hcwrgwWAq0IkCjBqBvzcjmIDwGSxhYy
        ilENW8s1zGm94VOkdwOCiEJy1V+HoLJH0PNNcyhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MME4DPlmxw4OEbGoG
        jpt1lgxpmzoAttfZ6Spqlp45/w=; b=kx0oVWqT+qDl7pSJiVasIjmxK64erjfr2
        qvZUJ1WxWbQzJ9q1BREKNNLeOs167xbsCo06yhEsMfDanKSTQQ0esY2D3tXeceVm
        UXlOhbjbMUqNp0nSWyw2uPSeszq/wgzRHFa0kHRDydfBCYDpO4Ysos2oPm5bQnxF
        tVm20qn1MCTTy03OADgEYkESKd9L44l4FgPWh3TRd+pI7qpq6eOP+vWyb9vJsq51
        nHVx9lheK817nc0rST2/iN3mfu5iCxIW8y+itMHRCEcTF2V0r2vgdlGcsp2Gvx+/
        kNxsuMeoRZKiXvltAFgO1qj+qLJhl2ayNIo8N0u448Pzi8bxbcE0g==
X-ME-Sender: <xms:EUpIYmivtvL5byeuGPKR2GHhPdQvUUO42woW2kF2sAQeCCDvnTaq6w>
    <xme:EUpIYnA7NqXFwakTw04HIudXWHeBhKmn-fslAKswev-BHJZvX67husnmZpi1wLdve
    bVYtzIZbtgHzzqTiyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeehtdffledvffegveejgeegvdeujedtteefgfelffehtdetudekteethfet
    keeuudenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvght
    vghrrdguvghv
X-ME-Proxy: <xmx:EUpIYuFGHvTdg-PqyJkhOncT5Ql5Xd_JDm6d-tV0-ZgkDND44wBSVw>
    <xmx:EUpIYvS_4d5o8ts2x2saI5McSEjmrZPZ0orlEJ8RU37See8VPJgzIA>
    <xmx:EUpIYjy3x4GWf2IQJDGEYqSF85Ygs_oCfF4jkNiva6gvXIPQGbuIQg>
    <xmx:EkpIYh6PAZ_fDhl4-ost8aO57hNcZrM0LZOt_3nCEqYcTlVyF0T0Ag>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A37A027402C7; Sat,  2 Apr 2022 09:05:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <692ae417-f0c6-4932-95f3-2a0984df5ad0@www.fastmail.com>
In-Reply-To: <40f7c074-198a-5ce0-02b3-e6042975e228@kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-3-sven@svenpeter.dev>
 <40f7c074-198a-5ce0-02b3-e6042975e228@kernel.org>
Date:   Sat, 02 Apr 2022 15:05:00 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Arnd Bergmann" <arnd@arndb.de>, "Keith Busch" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] dt-bindings: soc: apple: Add ANS NVMe
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the review!

On Wed, Mar 23, 2022, at 12:14, Krzysztof Kozlowski wrote:
> On 21/03/2022 17:50, Sven Peter wrote:
>> Apple SoCs such as the M1 come with an embedded NVMe coprocessor called
>> ANS2.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  .../bindings/soc/apple/apple,nvme-ans.yaml    | 75 +++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
>> new file mode 100644
>> index 000000000000..e1f4c1c572aa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
>> @@ -0,0 +1,75 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/apple/apple,nvme-ans.yaml#
>
> Do not drop all code in soc/apple, but please use respective subsystems.
> Apple is not a subsystem, is not special.
>

Sure, the code is already inside drivers/nvme/host but I'll also create
Documentation/devicetree/bindings/nvme and put the bindings in there as
well.

>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple ANS NVM Express host controller
>> +
>> +maintainers:
>> +  - Sven Peter <sven@svenpeter.dev>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - apple,t8103-nvme-ans2
>> +          - apple,t6000-nvme-ans2
>> +      - const: apple,nvme-ans2
>> +
>> +  reg:
>> +    items:
>> +      - description: NVMe and NVMMU registers
>> +      - description: ANS2 co-processor control registers
>> +
>> +  reg-names:
>> +    items:
>> +      - const: nvme
>> +      - const: ans
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  power-domains: true
>
> maxItems

Ok, I guess I can just use the max number of domains in the HW
released so far and we can always increase it when Apple releases
a new SoC that requires more power domains then.


Thanks,

Sven
