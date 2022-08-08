Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7705458D07B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244554AbiHHX2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiHHX15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:27:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28776258;
        Mon,  8 Aug 2022 16:27:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AB2475C0185;
        Mon,  8 Aug 2022 19:27:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Aug 2022 19:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660001273; x=1660087673; bh=n9y09zFa9r
        VKe8pEdf/zPqfBD6xx47qhNH1z9hXdyk0=; b=Uvd30Go0WfPEhLsrd9Es5QHWgX
        03+WGc/bNS/2ZJRpNoinpbvClNImXzGoO1ZTEHN4UeKUUF/4WB/yNlMT4qhIHHZF
        kC6gsOCeFDRRW4UvDBrOuy/jhu12UFeIOkf3Df7gu+xBWy2Z9nL/KNwyF0XSHCF8
        LUcH6wG1jWXoqwxbtRiJoGHTK3HHo8lCjas6Z5hwD9CcjrN+F6h53agpvWnJKTLf
        ybF5D5QrEQLnOjbY0nDg0ZXgBkC5UKimqRBQEnTacG9j8t83trjLdhCf1t0UVvIt
        l/uDF6Tvi8tfT3DN9On7rItOnUCvB/fthtsXMQ+D1ZcimD1krj+Xeoz+AE/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660001273; x=1660087673; bh=n9y09zFa9rVKe8pEdf/zPqfBD6xx
        47qhNH1z9hXdyk0=; b=dm+gULD1lT703Hs5wTD3rKqzPlR6/oaV1eAceHm/UI7C
        QZUYAynUXOlhrnh+qrNfIYqKiPI4CLaZeEKohlxOxwmIWzaEbCo0lfQPPoTnBR70
        dibDob2CMWdmwfCHP86osmOuXs8Sc1OFHY+Zk4LJ3lgfcIu968MphB1e2BkW6/VX
        g78aGQWAQCaRxvVRuB4GcGIVBHgm16kNNUFHdNbVfB0EXw3vYN0Fm1odzf8vvwxL
        W30k7e7AEiocvgbqZL8TFkNXXLy6rO8eJWc1lQv1kO/CmYZhha+UDWiXTywNRmf4
        plTro/sQcmuTgc4dBZawCFknef2OsVW2GuKfrtRrZw==
X-ME-Sender: <xms:-ZvxYiMwfhANpNroHRaLdaWVasiSXsxeRPtrvcXY5KvnXuoJrz9TzQ>
    <xme:-ZvxYg8NNGdIb4x8ZKXAZzm8FUU_riyjGuyJ0KChY7PpbF4ttysmkpBJIwO3IO4fN
    rdpSbRL8zFvpnc6PkA>
X-ME-Received: <xmr:-ZvxYpRhGbhJQeHWN31sH58Z4rJYh4oAf8tVXILDQiV9h5eXN-oHr4YevKtWWNfvUi24CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:-ZvxYivwzMHBxrvOHutCRwgqvr9fQrB2UnDPSW6eiExryHolADuVBQ>
    <xmx:-ZvxYqeo8JFZs7H1J4mM0vrai8MWoTsfQfEOML4rXSzFhaKarO-V-A>
    <xmx:-ZvxYm112Ce5GfJBf_LF7Q-nyTXLrgk_yFcXbtWJyhtwyxHasWNo2Q>
    <xmx:-ZvxYrqDsx6c5lzoOJ58zLPOIm3Ut1t8VGj3qQw_Idl42dYQeJhzVw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 19:27:48 -0400 (EDT)
Date:   Tue, 09 Aug 2022 11:27:33 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 3/6] asus-wmi: Implement TUF laptop keyboard power
 states
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <X5LBGR.15DO7CCYH6ER@ljones.dev>
In-Reply-To: <CAHp75VdNa8csSF5Je87kOzC3EQ4yetZqpxXFZu1D7C4A6XCTNg@mail.gmail.com>
References: <20220808030420.8633-1-luke@ljones.dev>
        <20220808030420.8633-4-luke@ljones.dev>
        <CAHp75VdNa8csSF5Je87kOzC3EQ4yetZqpxXFZu1D7C4A6XCTNg@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

>>  +       flags = 0;
> 
> This can be done before 'if (boot)'

Okay done.

> 
>>  +       if (sscanf(buf, "%hhd %hhd %hhd %hhd %hhd", &save, &boot, 
>> &awake, &sleep, &keyboard) != 5)
>>  +               return -EINVAL;
> 
> Same Q here: wouldn't it be better to put each of the parameters to a
> separate sysfs node? Or look at the LED ABI (that what Pavel mentioned
> for multi-color patterns) and see if there are already some
> established ways of how to represent necessary information?

Same argument I make for the RGB mode nodes. But here I think it's 
probably even more pertinent. The reasons I would like to keep this as 
one node are:

- It's separate to the RGB part
- We can't read the device to set defaults on boot
- Because of the above, if we set a default and the user wants to 
change perhaps "sleep", then we're going to have to write some 
incorrect guess data since the write requires all the flags at once
- One way to improve the UX is to add _show, but then this has to 
display incorrect data on boot
- We end up with 5 more nodes

The same reasons above apply to the RGB nodes, which right now I'm of 
two minds about. We'll see which way the RGB mode patch goes after some 
daily use.

> 
>>  +       save = save == 0 ? 0x0100 : 0x0000;
> 
>   if (save)
>     flags = BIT(8);

I didn't know about BIT(). Will do.

> 
>>  +       if (boot)
>>  +               flags |= 0x02;
>>  +       if (awake)
>>  +               flags |= 0x08;
>>  +       if (sleep)
>>  +               flags |= 0x20;
>>  +       if (keyboard)
>>  +               flags |= 0x80;
> 
> Use BIT() for flags.
> 
> ...
> 
>>  +       err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
>>  +                       ASUS_WMI_DEVID_TUF_RGB_STATE, 0xBD | save | 
>> (flags << 16), 0, &ret);
> 
> Why not provide flags to be a full 32-bit value?
> 
> Also 0xBD can be lower-cased and explained somehow?

Done, as is the rest of comments

Kind regards,
Luke.
> 


