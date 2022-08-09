Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FD158D5F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbiHIJDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237465AbiHIJDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:03:49 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A622502;
        Tue,  9 Aug 2022 02:03:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9B1575C00E9;
        Tue,  9 Aug 2022 05:03:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Aug 2022 05:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660035827; x=1660122227; bh=nTV7sNCozL
        xKqxT4iQ3xI1kz6XFl6DJT30vVE2/aW94=; b=ZQztSYA+XSczmHY9i4rO0RU2u8
        HL8/5Mqjh/e0qbJohfy3yT4FVcAgDI3EGm8dcCgsBu/8dBmnW402lajy0iXTT66R
        VkqhffbGPzupu29UcI14hbBO5Ya0znrMy1BjsZLyW4mQK5FN2wuinV1kd2COFk7K
        rLIEnOc/Ta33zd5c019HrrWOQAAln2Od/gb3rlBJBEzsEVIZvGAVjpe4ADhE5fQB
        nxqQ9FXtXrEoiwUDcStSBSIhjzVxzxDEJMW/PgOuIXG1ac8yc9nqxuGrUQfeBpAM
        FUoNM+GDgAnYRYyLC74vcgKuAZOz7rjzRqRiE3NKr2vqnpT/XXWyFGM1IeFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660035827; x=1660122227; bh=nTV7sNCozLxKqxT4iQ3xI1kz6XFl
        6DJT30vVE2/aW94=; b=FvoYq8R2X+H9pk8BoFTydE1vUlhQ9BwyJJ6mUHDE+Ku5
        /jNC/APVHWs3CLkf7YSJcs9aSB9emiENP/qaOjB3wlhmhaHWrpvAY2nKoOphGxzS
        oOhU7q8JjOmywsdUd/lIbIrZYBvGQoISvXg0FDA0i0t9cfYFLLDLlUbmJrqo+qQd
        gyxO500gLs6qenTrr3E5omTuBMwLAkUQFjJbVPmopkvS6VsFqXJVhOBBle95lRvM
        SOMry2KylJrFUvTRa7zmOANWSLy2VVavKCEik0Sy2Fzt5x7i0FbTprJpxVYiTRFr
        GTZvNKqlhbscJySoetmZo7YwEgWDw8xsqS9WqPLRwQ==
X-ME-Sender: <xms:8yLyYvFOw__zApqLf05RfeBHqKKoU1oa7vwQj6vCsTVXxXlCl0xALA>
    <xme:8yLyYsU-N2sIlhc3ZHe5ubvRtROCDzdoPHsPnrsuZIZoE9FeROy057u5hZhLzQNZ2
    3qgLBX8Czwrso4121k>
X-ME-Received: <xmr:8yLyYhIQ5_PEYUg2-SFWy7GYWPUPama611kG_-QjAD-a4ZHQvhBFUdts4vxUP2hHCE3XLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    ephfeigedtveefjeeukeetfeektdeffeefteekfeffieeiteeigeehhfdutdeitdehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:8yLyYtFvTSNS1W7-IlL3xOfBsvgO3oS3Sdu_N8KTEUBrUcBRo5KCvA>
    <xmx:8yLyYlUmXileyPlweukr86uqOGbTSj8lyjtMqxKZfch2DRxRYVBtog>
    <xmx:8yLyYoNMycCy1dfZvpZ3vAysf8xYZHf5rLAG8fcKQHNBTlUsx7IDKw>
    <xmx:8yLyYkdE-rh6ZO1fHj8Xzu58k7EpkSiv74wCjIwtTKaGIJvL_jNgBA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 05:03:44 -0400 (EDT)
Date:   Tue, 09 Aug 2022 21:03:30 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v3 2/2] asus-wmi: Add support for ROG X13 tablet mode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <UTBCGR.Y86SR52O1CXJ@ljones.dev>
In-Reply-To: <e6370233-eae5-5668-3f07-d1a70eb92690@redhat.com>
References: <20220809033048.1634583-1-luke@ljones.dev>
        <20220809033048.1634583-3-luke@ljones.dev>
        <CAHp75VeAMBM+itfAn8hRDykV9rRLGXzck8L2kBgpGkVRsPUm5g@mail.gmail.com>
        <e6370233-eae5-5668-3f07-d1a70eb92690@redhat.com>
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

Hello,

On Tue, Aug 9 2022 at 10:46:11 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 8/9/22 10:40, Andy Shevchenko wrote:
>>  On Tue, Aug 9, 2022 at 5:31 AM Luke D. Jones <luke@ljones.dev> 
>> wrote:
>>> 
>>>  Add quirk for ASUS ROG X13 Flow 2-in-1 to enable tablet mode with
>>>  lid flip (all screen rotations).
>> 
>>  ...
>> 
>>>          { KE_IGNORE, 0xC6, },  /* Ambient Light Sensor 
>>> notification */
>>>          { KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip 
>>> action */
>>>  +       { KE_KEY, 0xBD, { KEY_PROG2 } }, /* Lid flip action on ROG 
>>> xflow laptops */
>> 
>>  Shouldn't you keep it sorted by value?
> 
> Actually as I mentioned in my review of v1, we don't want this
> addition at all, see:
> 
> https://lore.kernel.org/platform-driver-x86/d9d79f9b-f3ab-c07e-9e18-5760ff828487@redhat.com/
> 

My apologies, I will fix this.


> Regards,
> 
> Hans
> 
> 
>> 
>>  ...
>> 
>>>   #define NOTIFY_KBD_FBM                 0x99
>>>   #define NOTIFY_KBD_TTP                 0xae
>>>   #define NOTIFY_LID_FLIP                        0xfa
>>>  +#define NOTIFY_LID_FLIP_ROG            0xbd
>> 
>>  Ditto.
>> 
>>  ...
>> 
>>>  +static void lid_flip_rog_tablet_mode_get_state(struct asus_wmi 
>>> *asus)
>>>  +{
>>>  +       int result;
>>>  +
>>>  +       result = asus_wmi_get_devstate_simple(asus, 
>>> ASUS_WMI_DEVID_LID_FLIP_ROG);
>>>  +       if (result >= 0) {
>> 
>>  You missed the second part of my comment. Please, read carefully 
>> _all_
>>  reviewer's comments.
>> 
>>>  +               input_report_switch(asus->inputdev, 
>>> SW_TABLET_MODE, result);
>>>  +               input_sync(asus->inputdev);
>>>  +       }
>>>  +}
>> 
>>  ...
>> 
>>  Overall, it's getting better!
>> 
> 


