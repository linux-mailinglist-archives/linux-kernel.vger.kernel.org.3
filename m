Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8132F58B4C4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiHFJdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHFJdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:33:08 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB314022;
        Sat,  6 Aug 2022 02:33:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 49D7F32002E8;
        Sat,  6 Aug 2022 05:33:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 06 Aug 2022 05:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659778382; x=1659864782; bh=xYIPro+vyf
        IQ/HrH9MG/YzMR+LWcg1k8ChGwC4YRd68=; b=MYzo/PKXeFCiF2hD66dRw6n7ry
        MEgHD0DcA4D9NR+TSqORzvc8eyPI/+1YSeJG09uUyCDXe/nYHlRs1wiyNZ02+MyG
        eWcHosOGEKjLjzgdMC/nY9mR5aDTN+MRg7StT4EpP8PLcYO3RhC/cY453C0rEY0i
        ngsRxewuuqD/qpD7mcr7LZeFb4vWmyMMMcsMPIRJimOan3eevCBEomEAFAWdMHke
        ItZA/SyEt/pQXp+/DOthit8fVQ0rXuOryX9paJiGMnsiYGcwIahf/AoKGNRSl7Ca
        dCTITI9Ds1becIEsC1ohkYjKg/UuBejWSJ93PfzT1SpuaRJlzc9X4ZiDme2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659778382; x=1659864782; bh=xYIPro+vyfIQ/HrH9MG/YzMR+LWc
        g1k8ChGwC4YRd68=; b=IQb/IwMX0klWoiSxDK0vBgcet14N/yQPkbEbdYF3VAuu
        mGcuuS/OShOSCqPdLG8e76v7HB+G5MDh9waSfpxQDHKu2+g+6MiCV3vKL9D4DgS8
        c21JkTPPnT1BizbX89wWPyj+lVZjDsuwJXLQ7wD1sYv78NdzGFEG0Zs2N9xmBvwh
        M7uT62n3waI7K+qkbceCT0ngaXX3pJ18Fap+fBVNByr7XITLGZYEEHRtxCvI4JGD
        lz3tvpvyVi0KbTVok54muLrG37HMkehtq1crfrVmsKR6CEgI6UM4MfnW4CdqghXZ
        wHLH8mHTAxCzot1j+qfkXkB802ZP9BhVoHGK25qPGw==
X-ME-Sender: <xms:TjXuYhCC4rBIm5bEbN5O2edLmbct__lTFrbcN_tA-xpO1KhFIMVnmg>
    <xme:TjXuYvjcAeD4PH_iyMYMFWrLgt5ShD9zD88HMLFZ8BrnhHyKdoKVZtc2eVuD3ArO9
    9dXhtwUvM3Z3TZMzsE>
X-ME-Received: <xmr:TjXuYsk9UskSedoCQgnsMXGYQN2qW6wvSzDA0R56k61oHGHE3f9oKa7JeTpq1A9Obqx4jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:TjXuYrxQtiPjNabCwc_6P1AplbOUM8dvEVfYFwWN6wLDEhC18sb3jQ>
    <xmx:TjXuYmQMvbJV8iVg4cmTO4cv7zyBphw4sfQAb4aQs4FF6q-V3DvTHQ>
    <xmx:TjXuYua6tpjVp3ApZd2r4tyQhi4CDHWyER9Gg9XGJ4Mb52YdGKwp7Q>
    <xmx:TjXuYhfCTxj1Sfh5xdCylX-1D5dHihgcxHK3jkYs1ReQAl-JCKv25Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 05:32:57 -0400 (EDT)
Date:   Sat, 06 Aug 2022 21:32:43 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 0/5] asus-wmi: Add support for RGB keyboards
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <J6T6GR.SW0RXSJSYG9R1@ljones.dev>
In-Reply-To: <CAHp75Vd4iEGkAE1Ds_Zyqi0P+gQbOyqvGoJctpOHNmMD7cUG0g@mail.gmail.com>
References: <20220805081909.10962-1-luke@ljones.dev>
        <CAHp75Vd4iEGkAE1Ds_Zyqi0P+gQbOyqvGoJctpOHNmMD7cUG0g@mail.gmail.com>
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

Hi,

On Sat, Aug 6 2022 at 11:10:37 +0200, Andy Shevchenko 
<andy.shevchenko@gmail.com> wrote:
> On Fri, Aug 5, 2022 at 10:20 AM Luke D. Jones <luke@ljones.dev> wrote:
>> 
>>  This is a patch series to add RGB support for ASUS laptops.
>>  The laptops with this RGB tend to be the TUF series of gamer 
>> laptops.
>> 
>>  The first step is initial bringup of support using the multicolor 
>> LED API.
>> 
>>  These types of keyboards implement a slightly more complex 
>> interface than
>>  just RGB control however - they also have modes with can be static 
>> LED,
>>  blinking, rainbow, color cycles, and more. They also have some 
>> custom
>>  animations that can play depending on device state, such as 
>> suspended
>>  playing a fancy colour cycle, or playing a "wave" animation.
>> 
>>  Two of the patches add support for these features.
>> 
>>  The last patch adds documentation in:
>>  Documentation/ABI/testing/sysfs-platform-asus-wmi
>> 
>>  Some notes:
>> 
>>  - this patch series obsoletes the previous RGB patches by myself
>> 
>>  - it is not possible to add attribute groups to multicolor LED as
>>    they get overwritten by `led_multicolor_groups` in
>>    `led_classdev_multicolor_register_ext`.
>> 
>>  - the methods for RGB control do not provide a way to fetch 
>> exisiting
>>    state, so these methods are WO.
>> 
>>  - There is an existing `asus::kbd_backlight`, this provides a 4-step
>>    brightness to the RGB (off,low,med,high) individually to 
>> multicolor.
>>    I was unsure of the effect of adding a similar path so have used 
>> the
>>    `asus::multicolour::kbd_backlight` name to be clear about purpose.
>>    If the `asus::kbd_backlight` is off, then no RGB is shown at all.\
>> 
>>  I'm hopeful that this patch series addresses all previous feedback 
>> related
>>  to the obsoleted patches.
> 
> There are so many patches

This is what Hans requested that I do after the previous submissions,

>  and versioning of all of this is completely
> broken.

I was unsure how to handle this as the previous patches were 
individual, I thought perhaps this patch series is a good place to 
restart since the work done is a bit different.

I will try to better track what I do in future.

> You really have to clean up the mess and realize what version
> of this is. To me it looks like this series is v5 or so of the
> previously sent patch(es). Also you missed the changelog between
> versions so we can see what you have done from vX to vX+1 for the
> whole range (1 ... X+1).

As described before I thought this would hopefully be a good point at 
which to reset due to the changes requested by Hans which meant that 
the underlying structure is different.

I do have another version already prepped, so I will do my best to 
address the previous submissions and your concerns in the cover letter 
along with a changelog.

> 
> --
> With Best Regards,
> Andy Shevchenko


