Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8562058CFDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbiHHVoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiHHVn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:43:56 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05836369;
        Mon,  8 Aug 2022 14:43:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E74B5C012B;
        Mon,  8 Aug 2022 17:43:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Aug 2022 17:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659995031; x=1660081431; bh=Noq7c0Nawz
        gYCdsg9ZW5dIqk4AKYo1HmGlvkyEbTt+c=; b=NzBoaOMR564b9o7V+HRo3/nIkd
        FFrKyQHi2J4r/hOcCnBif/E5rH35hfZdzTrDHzOiWNTndrciYHPflbX3rxT4otuq
        n+HfFq4qXXh5noZhRaYFley+ZtcEaH2oT9pkUl6Nx7IIC206rZoc48LxnRLM+JTH
        0irsuf6BNMaVn7Cnx5MhRMwsIwjL+vqwKIAlWApIQVY8NTipKdpZKChVfEc4baYS
        atGXCzX2xNuQjx0yHqGZlaXpx92cp8i9xq0jY9dg/ZpVBlHU/EGVJ8JRyQ4WFgoo
        E44AaDSb5A3HMspYOlWQ1s3RhvzQvvZaGWjv77ALZSOhv8XruqTSVRh07TJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659995031; x=1660081431; bh=Noq7c0NawzgYCdsg9ZW5dIqk4AKY
        o1HmGlvkyEbTt+c=; b=hWJITFklnaX55cOl0D/padFTW6Q44xFfQcivdn+cnBVQ
        LzqDXvc91jS0IcXdppGr7dgDdClEYagzZ//Ep+cyNhGYG/j5XTPmApcEsMDC1WQz
        hQxso2BA3fnYBeXPo9lxn4nelFL0ioi2YCKDqEZAAlb50Xczwk2WXe9Nd43BFX5Q
        Ip4jgt5ROy+R2Zmrhu/UmkbBumKN+Mnf4YbrBrcEzbuVsnicEt3vN5BGn1TuXVth
        fMGvSC6s8Fm0b0MiFut+Va7oK1w91OzesVTOBeles1YmDva/hTxcFZjN+kYvioGi
        1Vj6EYPmtpMcMkCTVEXa1nGL9ak66D0zNOxiDuGXIg==
X-ME-Sender: <xms:l4PxYodSMV1sp8ab-ng7IxluAGDZLHKp1bMVDoHc6378JessSTGlIw>
    <xme:l4PxYqOJj2xRxvksmuFMfYdn6yGGL3JQT26SiUXlt85TYimMc0jyAwYP_6Ya1yFqa
    ubo7r8v1Uxo7_pZ2Cw>
X-ME-Received: <xmr:l4PxYphkamKw9GeFClYKpVi1H2X4b7JQ-T4710USchlZlTVpv6hck6ykxJ-eqQ48OCEUFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:l4PxYt_QsE4XqtkyFV_TFEjVn3Xdne4PvHrfItZUN6uEZbUJhdpyCQ>
    <xmx:l4PxYksNyYjiwRoZzvMMTLO5u5gN2ej8OG3swxS1_S0VYbnfllhcMg>
    <xmx:l4PxYkGnlqtrJxgpblxR3krWqciZ3FE_JKAZHOMVC2a6Umk1b0tMsg>
    <xmx:l4PxYt5Yzr6sGrwayr3doGMMzazkEgOd2NGfr4I2EPwA5RTb58kwlQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 17:43:46 -0400 (EDT)
Date:   Tue, 09 Aug 2022 09:43:32 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 2/6] asus-wmi: Implement TUF laptop keyboard LED modes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <KCGBGR.P2V4UO7HLOX11@ljones.dev>
In-Reply-To: <CAHp75VcR-strGDhaGE78NjToamK98e8UO-rQhU-Ow81AavU5YA@mail.gmail.com>
References: <20220808030420.8633-1-luke@ljones.dev>
        <20220808030420.8633-3-luke@ljones.dev>
        <CAHp75VcR-strGDhaGE78NjToamK98e8UO-rQhU-Ow81AavU5YA@mail.gmail.com>
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

Hi Andy,

> 
>>  +       if (sscanf(buf, "%hhd %hhd %hhd", &save, &mode, &speed) != 
>> 3)
>>  +               return -EINVAL;
> 
> Same comment as per v1.
> 

You wrote:

 > Usually we have three separate nodes for that, but they are kinda
 > hidden in one driver, so I don't care much.

I think that is the wrong direction to take. Doing so would mean that 
every write to one of these values has to write-out to device. I don't 
know how long writes on an i2c device take, but on the USB connected 
versions they are 1ms, which means that to individually set colour, 
save, mode, speed (also direction and sometimes a 2nd colour on USB) 
adds up to 4-6ms - and I don't know what sort of impact that has in the 
kernel itself, but I do know that users expect there to be fancy 
effects available on par with Windows (like audio equalizer visuals on 
the RGB, something that is in progress in asusctl).

Using multicolor LED class already breaks away from having a single 
packet write, but the gain in API scope was worth the compromise. 
Hopefully we can keep the single set of parameters here?

Pavel suggested using triggers, I've yet to look at that, but will do 
so after finalising this.

I suppose one alternative would be to store speed and mode as 
attributes, but not write out until the "save" node is written to? So 
this raises the question of: we can't read from device, and speed+mode 
must be saved in module for use with "save" now, should I then allow 
showing these values in a _show? On fresh boot they will be incorrect..

I'm going to go ahead and split those parameters in to individual nodes 
now anyway - it may help with later work using triggers.


> ...
> 
>>  +       asus->keyboard_rgb_mode.mode = mode < 12 && mode != 9 ? 
>> mode : 0x0a;
> 
> Same comment as per v1.
> 

I missed it sorry. Done now.

> ...
> 
>>  +       switch (speed) {
>>  +       case 0:
>>  +               asus->keyboard_rgb_mode.speed = 0xe1;
>>  +               break;
>>  +       case 1:
>>  +               asus->keyboard_rgb_mode.speed = 0xeb;
>>  +               break;
>>  +       case 2:
>>  +               asus->keyboard_rgb_mode.speed = 0xf5;
>>  +               break;
>>  +       default:
>>  +               asus->keyboard_rgb_mode.speed = 0xeb;
> 
> break;

Done

> 
>>  +       }
> 
> ...
> 
>>  +
> 
> A blank line is not needed here.

Okay thanks, I'll go through previous patches and check this.

Kind regards,
Luke.
> 


