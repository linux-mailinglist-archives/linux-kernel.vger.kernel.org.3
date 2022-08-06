Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B619058B50D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiHFKeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiHFKeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:34:06 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1213DFD;
        Sat,  6 Aug 2022 03:34:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7D68C32004CE;
        Sat,  6 Aug 2022 06:34:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 06 Aug 2022 06:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659782043; x=1659868443; bh=kEtzJMglnI
        qvUaBgZ3UJjYvapZr8rHoZmRQolZV+jXQ=; b=d7ahdiuykpXE/LcwHN/JfJBqvY
        JV1SPdQV6BcTxcnFWQQcN1vXXnTuZT99lDipjTO4ZeCigjh7VWm4WJ3I1ubcyyyh
        HTRAijgCSitTFAmrW47m9dUKWMdB0xjeDmv9eywpFbPjNLFxU684H0cZZRRrSwH4
        840Gkcnj/zaAcdCTQZVM2ISipn1CkrrO0+2Rpzo3XAq2WR766VvqLrzc5X1OqFZI
        PSO5pnIO/94Zqz3OEM6BghLgUaOixVkivwzrNM1ksDni0eQAjcrFPig50O0Z9OAF
        Kuvd6+UL1k1X+MYo+3o/XCrQFSLPd8FZrxAYmkOlv27HbWtphNFf3EjsfBKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659782043; x=1659868443; bh=kEtzJMglnIqvUaBgZ3UJjYvapZr8
        rHoZmRQolZV+jXQ=; b=YXT5v0DE5Z87MZwGKinBNQleHlVqA7ScvwFe8QKuk8ti
        XTrFtRtC7azyXxgR8wGbEXjTKf1EdOYNJT7q+AJVAXNX1bK15vbOk4eRIl3uMAh+
        jEi4+Cgi6ZF1k4OhO/mXMuI8PhIy9JQRMK1+0XWN3xACNQLTyN+GtLNsHrVUOcXe
        AndT97250PxJ7WrMjigOLyfHRi6Q/K4p305MYzJVp1OR9eRPnjIBb6gAiC6QqZ0N
        4vqwTyLxQjMIv85btJxiQLiCpFIW2qsT0vAWAQqxudys4mdKlKoIFnm934r5XO9v
        6L2rV8P/ZcKXTekCjU3cPrUdkrmZX+ryYOjbd4n5dA==
X-ME-Sender: <xms:m0PuYmzEkHmGZtCIwAzWofrKwmqUoqby7h1MaqWxkDmhdRavDRtueg>
    <xme:m0PuYiTGotZT9bnVydl6PZX3b8eYBf7np1hzspOS_xAWHkh5Ns2NYwD4gh_XeKN0s
    lBVqkStH6xasajRhIo>
X-ME-Received: <xmr:m0PuYoUN43mVC6rhi9461qvp0-DnNPzJkHC-zTTxNcuzN4a3f94c4vzsYTXWt6rvomj5PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:m0PuYsirUfUUp8mB3kt2jXth5foWZ3WP_bh75jJGiUOWHET13Vq9Ew>
    <xmx:m0PuYoCYv9xOTm5x8IWTuRn4OABkTIRTNJBRmamkNkDd2uSd3ZBdvw>
    <xmx:m0PuYtKKfTfk_DZ4srOOkqpOCOHqZuAhG_3CMsxthRpwSjwMSBXhtQ>
    <xmx:m0PuYrM1tbut6VLhRySAKRlhrPsJ-isx8HRo-1wbBXjGlUTknVKyOA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 06:33:58 -0400 (EDT)
Date:   Sat, 06 Aug 2022 22:33:45 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 2/5] asus-wmi: Add support for TUF laptop keyboard RGB
 mode control
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <90W6GR.9Z5CYBT7NOHJ1@ljones.dev>
In-Reply-To: <CAHp75VcYba6wYwkMo_Q_QEZsr4wyfDB5czu13w-y6hfQ13CkvQ@mail.gmail.com>
References: <20220805081909.10962-1-luke@ljones.dev>
        <20220805081909.10962-3-luke@ljones.dev>
        <CAHp75VcYba6wYwkMo_Q_QEZsr4wyfDB5czu13w-y6hfQ13CkvQ@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sat, Aug 6 2022 at 11:56:58 +0200, Andy Shevchenko 
<andy.shevchenko@gmail.com> wrote:
> On Fri, Aug 5, 2022 at 10:20 AM Luke D. Jones <luke@ljones.dev> wrote:
>> 
>>  Adds support for TUF laptop RGB mode control.
>> 
>>  Two paths are added:
>>  - /sys/devices/platform/asus-nb-wmi/kernel_rgb_mode
>>  - /sys/devices/platform/asus-nb-wmi/kernel_rgb_mode_index
> 
> ...
> 
>>  +static int keyboard_rgb_mode_check_present(struct asus_wmi *asus)
>>  +{
>>  +       u32 result;
>>  +       int err;
>>  +
>>  +       asus->keyboard_rgb_mode_available = false;
>>  +
>>  +       err = asus_wmi_get_devstate(asus, 
>> ASUS_WMI_DEVID_TUF_RGB_MODE, &result);
>>  +       if (err) {
>>  +               if (err == -ENODEV)
>>  +                       return 0;
>>  +               return err;
>>  +       }
> 
>>  +       if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
>>  +               asus->keyboard_rgb_mode_available = true;
>>  +       }
> 
> {} are not needed (except if they will be utilized in the next patches
> in the series).

I've usually been pretty good at catching these. I must not have run 
the patch check script on this one.

Fixed.

> 
>>  +       return 0;
>>  +}
> 
> ...
> 
>>  +       if (sscanf(buf, "%hhd %hhd %hhd", &save, &mode, &speed) != 
>> 3)
>>  +               return -EINVAL;
> 
> Usually we have three separate nodes for that, but they are kinda
> hidden in one driver, so I don't care much.

I don't really understand what you mean sorry.

> 
> ...
> 
>>  +       asus->keyboard_rgb_mode.save = save > 0 ? 1 : 0;
> 
> So, it's actually boolean.
> 
> You may write it as
> 
>     ...save = !!save;

Err okay. Done.

> 
>>  +       /* These are the known usable modes across all TUF/ROG */
>>  +       asus->keyboard_rgb_mode.mode = mode < 12 && mode != 9 ? 
>> mode : 0x0a;
>>  +
>>  +       if (speed == 0)
>>  +               asus->keyboard_rgb_mode.speed = 0xe1;
>>  +       else if (speed == 1)
>>  +               asus->keyboard_rgb_mode.speed = 0xeb;
>>  +       else if (speed == 2)
>>  +               asus->keyboard_rgb_mode.speed = 0xf5;
> 
>>  +       else
>>  +               asus->keyboard_rgb_mode.speed = 0xeb;
> 
> So the 1 is default then, why not use switch-case to show this 
> explicitly?
> 
> switch (speed) {
>   case 0:
>     ...
>   break;
>   case 1:
>   default:
>     ...
>   break;
>   case 2:
>     ...
>   break;
> }
> 
> Yes, it's longer, but I think it's cleaner.

Agreed. Done.

> 
>>  +       err = tuf_rgb_brightness_set(cdev, cdev->brightness);
>>  +       if (err)
>>  +               return err;
>>  +       return 0;
> 
> return tuf_rgb_brightness_set(...);

This causes a hang (waiting for return somewhere?) if I don't return 
count. Especially true if the return is 0.

> 
>>  +}
> 
> --
> With Best Regards,
> Andy Shevchenko


