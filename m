Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7148511F50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiD0Pep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiD0Pel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:34:41 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137A9D3AC3;
        Wed, 27 Apr 2022 08:31:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2ADC532008FD;
        Wed, 27 Apr 2022 11:31:28 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Wed, 27 Apr 2022 11:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1651073487; x=1651159887; bh=c0
        1znxB8PdUfA3BPO/q7MBKS/blJFAlfcryVXAK3B5E=; b=SwRwqf8PBqfNwsWAXl
        x/3rqJ7hgBLqIvkK2fTj1cqb3hUssNH05UsWdmVwo7my0m3J/l3EOsGP1hfikN9U
        SCYsEmpkTf/VROe8CvdHRGZqsqg8GlcXYfofmzgWe1OcCpJtQ3OR7BLXtvGKztbh
        0L+knZdHKhWDlr62o5KJoGxSUIiC7ioBuxhQlsYxgsNoCjq7Ealh0bgWqNski8H2
        0yH0jF7SdEASF+Wmc1f8xwVIzwfTCMjkIYXs/kknqVUcySsO9UmzyUerfbqVv2+A
        XW4ymTycsJxWGxpVBdGlHAeGapabUaoMpVMZ6Vr5enB/XvDcARbff38smwnpSx+6
        /CFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651073487; x=
        1651159887; bh=c01znxB8PdUfA3BPO/q7MBKS/blJFAlfcryVXAK3B5E=; b=m
        x/LwMkU27wcpM1kqEN74v5WbGct6EZRNGKfjGvxZZD04RjBxmhagHeel06jB7Y3n
        DEAqtaUoQS9LmmNZwaN5kJ/0RFT803aDX09rfQz8cQB6OElRHAqxAi7IRtEmHaLZ
        yWknuYb9WbH+OjkagvKN4fsmdTdVASRTlObnjiIzzgspVIvUxNV9CTwBVtROWdC+
        CTBmYoXO3FF/ATkGbPMLW63MvrPfx1qzQrcH9NQXzfaDRzY/NTlTA41yBF5FEKpO
        QrSqArfJDh9WzpbL/ywbQf29oth6OhqhIPNmbXJJLrbn1HlaxU454FCr3umRRjnA
        fKjzKVzipK3bMjhACSL0A==
X-ME-Sender: <xms:zmFpYqauyfsG3b7P4Yv_o0_phs7oqjcOuuCCtQw6J6XJIVWKGjzdfg>
    <xme:zmFpYtacxqTYbWFmL0HJIo1zScyYMgA068rdD_UKvzFjwdEkOFkx8pOxJpp_JzRev
    d2i1lHh8i6XYo1tFWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:zmFpYk9jIboH-rnrtNTnmc0DfCRZ6G2z1JYY1WSp_pp5oZXRWjpC5w>
    <xmx:zmFpYsquJ5Msf2bZxTS_q0RQEglFAeTxjhve5ZGH8eAdIq3jxv-GoQ>
    <xmx:zmFpYlqsatny_BJJfK97gPmq3FPckyZmAvh0OSt9iZk2sJIz7K5b9g>
    <xmx:z2FpYjgMi66AEV4kx_r_OjqbpN7G8E-0UKmVYSTWufb-9J4x5ZfixA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6704E2740386; Wed, 27 Apr 2022 11:31:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-569-g7622ad95cc-fm-20220421.002-g7622ad95
Mime-Version: 1.0
Message-Id: <c4a9d56e-571b-4ec4-8833-c1e438666264@www.fastmail.com>
In-Reply-To: <CAK8P3a2UEHfoDe-d=XEoTM=SS+7Lug7V1WQUa285LWdVLxjHYA@mail.gmail.com>
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <20220426201539.12829-6-sven@svenpeter.dev>
 <CAK8P3a2UEHfoDe-d=XEoTM=SS+7Lug7V1WQUa285LWdVLxjHYA@mail.gmail.com>
Date:   Wed, 27 Apr 2022 17:31:06 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "Marc Zyngier" <maz@kernel.org>, "Janne Grunau" <j@jannau.net>,
        DTML <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 5/6] soc: apple: Add RTKit IPC library
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Apr 26, 2022, at 23:01, Arnd Bergmann wrote:
> On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>>
>> Apple SoCs such as the M1 come with multiple embedded co-processors
>> running proprietary firmware. Communication with those is established
>> over a simple mailbox using the RTKit IPC protocol.
>>
>> This cannot be implement inside the mailbox subsystem since on top
>> of communication over channels we also need support for starting,
>> hibernating and resetting these co-processors. We also need to
>> handle shared memory allocations differently depending on the
>> co-processor and don't want to split that across multiple drivers.
>>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>

thanks!

>> +bool apple_rtkit_is_running(struct apple_rtkit *rtk)
>> +{
>> +       if (rtk->crashed)
>> +               return false;
>> +       if ((rtk->iop_power_state & 0xff) != APPLE_RTKIT_PWR_STATE_ON)
>> +               return false;
>> +       if ((rtk->ap_power_state & 0xff) != APPLE_RTKIT_PWR_STATE_ON)
>> +               return false;
>> +       return true;
>> +}
>> +EXPORT_SYMBOL_GPL(apple_rtkit_is_running);
>> +
>> +bool apple_rtkit_is_crashed(struct apple_rtkit *rtk)
>> +{
>> +       return rtk->crashed;
>> +}
>> +EXPORT_SYMBOL_GPL(apple_rtkit_is_crashed);
>
> I noticed that you use EXPORT_SYMBOL_GPL() here, but a more permissive
> EXPORT_SYMBOL() in the SART driver. Is that intentional?

No idea why I used both but it wasn't intentional. I'll change all exports
to EXPORT_SYMBOL_GPL.

>
>> +
>> +#if IS_ENABLED(CONFIG_APPLE_RTKIT)
>> +
>
> Same comment about the #if as for the SART driver: I'd prefer it without the
> conditional compilation.

Ok, will remove those #ifs as well.


Sven
