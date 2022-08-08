Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65BF58C20B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiHHD1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiHHD1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:27:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEDBDFE5;
        Sun,  7 Aug 2022 20:27:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D61E5C0050;
        Sun,  7 Aug 2022 23:27:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 07 Aug 2022 23:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1659929226; x=
        1660015626; bh=kz9uFpYclBPOg+dbDXT2G5x7qXu3V/ZJPvJd8gCdT9k=; b=W
        Yaro3MV8sPaRVxatCHapof6gNk7KJn4oWm19oMZxePStCyNvmqepFdwRjCUjues2
        YeKhXzoe/WpLc8w3e3Ct5K0a/dNJ7PmvXoqOO8yzOhEO3Iz0i7E4LZ3PrOFyaZLx
        /q7tuKJc4fRDyC0BGVUvr0nKHUE/Y3p5v66VTIkzE0SU2NqSKACyv5Tj73iA8chF
        6b5/+dEmXekcbuK3U/yCLYD8ua6SRc5SxeR+ujoXGa88d7dcRlVgF4Cy/Aw/tADk
        g3aiXvltq3iv7ICfjB5L4SaKzM5Hw9jI0ym6pkeB7eiXBUdIr1/67gYaTos5E9cb
        t0vdIOYhZKvpMxMVq0WKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1659929226; x=
        1660015626; bh=kz9uFpYclBPOg+dbDXT2G5x7qXu3V/ZJPvJd8gCdT9k=; b=R
        oEwLiEw/6PyZiOcHhR9lSikaDS7+6oYQ/0hUAcSHFJ647K7xDJmOmquAZIa97Dls
        ErycaFFwuyf1YYqW2sP9vEp2Jvk6wXKiHo0MExdTbUhyNR6CxjHoEke/vyWMtAmK
        PYXl67rfB+SG3GWD2aZswUjwqRRdv2xwXj1j5aV6Jwgds+UWKnbgDZKt0Jw5dw+h
        9uQODgkq2b4YGFjeupj+8mNpq+IBgsfak1O3USxmjJ7HSCRWDYhMkkGubdee+C2K
        RENRVwHGLd8La6OFjoPIWtA+6wTfUa5hY2zw69WTp5Dv3MxtrGkFaQYv5TjJ8E/2
        GELgkPiLBa3atzf87WjGw==
X-ME-Sender: <xms:ioLwYuHYgKNov7PxDIeQ6Xvh4L4Zx5Vi3wjwBx37M8-A1Pq1x7h2mg>
    <xme:ioLwYvWZGLbEnP4Q2oR4FaCyut2CBIv-AOpWQaVb2XTeM2eA1s3pVMAGvQSjfMeR4
    uhiygCg0YyA1IzaA14>
X-ME-Received: <xmr:ioLwYoIDCP4X_4BmKEFgds62Xyq8IHSoljn00YD_Wmtfsf5TS80K9xqEWPZYeV0jEaAwKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvfevkfgjfhfogggtgfesth
    hqredtredtudenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnhepheeujeejjeevkefhvdetiefggffgueetvd
    ehtdduueefteetffeuleetudegffetnecuffhomhgrihhnpehlkhhmlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslh
    hjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ioLwYoG2S5kQ0Qc3MYc48n_CRudcPwdQcCG9xGyXVEBXdWD6nc22Ww>
    <xmx:ioLwYkVfZKThHcARafiRhxXlvTntSp3VY1Oy5Pq2Y18LM_cD4fYjBw>
    <xmx:ioLwYrMq11ZKNavL4f0hjF6U-coqCrKO0AQjyxjbjoar76JRLaOH3g>
    <xmx:ioLwYiy71C4gUVRyO8vXAvNvOYLBZ33ZAlXdcp5l-XlxHakzv_cZKw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:27:00 -0400 (EDT)
Date:   Mon, 08 Aug 2022 15:26:42 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 0/6] asus-wmi: Add support for RGB keyboards
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, pobrn@protonmail.com,
        andy.shevchenko@gmail.com
Message-Id: <IK1AGR.65TRDBUQUK0T3@ljones.dev>
In-Reply-To: <20220808030420.8633-1-luke@ljones.dev>
References: <20220808030420.8633-1-luke@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies to: Pavel, Barnab=E1s, Andy, I should have CC'ed you all in=20
from the start. I have a wee bit going on and forgot to do so.

Kind regards,
Luke.

On Mon, Aug 8 2022 at 15:04:14 +1200, Luke D. Jones <luke@ljones.dev>=20
wrote:
> This is a patch series to add RGB support for ASUS laptops.
> The laptops with this RGB tend to be the TUF series of gamer laptops.
>=20
> The first step is initial bringup of support using the multicolor LED=20
> API.
>=20
> These types of keyboards implement a slightly more complex interface=20
> than
> just RGB control however - they also have modes with can be static=20
> LED,
> blinking, rainbow, color cycles, and more. They also have some custom
> animations that can play depending on device state, such as suspended
> playing a fancy colour cycle, or playing a "wave" animation.
>=20
> Two of the patches add support for these features.
>=20
> The last patch adds documentation in:
> Documentation/ABI/testing/sysfs-platform-asus-wmi
>=20
> Some notes:
>=20
> - this patch series obsoletes the previous RGB patches by myself
>=20
> - it is not possible to add attribute groups to multicolor LED as
>   they get overwritten by `led_multicolor_groups` in
>   `led_classdev_multicolor_register_ext`.
>=20
> - the methods for RGB control do not provide a way to fetch exisiting
>   state, so these methods are WO.
>=20
> - There is an existing `asus::kbd_backlight`, this provides a 4-step
>   brightness to the RGB (off,low,med,high) individually to multicolor.
>   I was unsure of the effect of adding a similar path so have used the
>   `asus::multicolour::kbd_backlight` name to be clear about purpose.
>   If the `asus::kbd_backlight` is off, then no RGB is shown at all.
>=20
> Changelog:
> - V2: patch 1: asus-wmi - RGB
> 	+ shorten a few lines
> 	+ move unused keyboard_rgb_mode_available to next patch
> 	+ remove tuf_rgb_brightness_get() is it was only returning current
> 	  led_classdev brightness, not reading it from device
> 	+ remove unnecessary setting of brightness on multicolor init
> 	+ set brightness_get to null for TUF RGB
> 	+ actually use the member subled_info in keyboard_rgb_led struct and
> 	  not the leftover dynamic allocation (now removed)
> - V2: patch 2: asus-wmi RGB mode control
> 	+ tuf_rgb_brightness_set() was still using hardcoded save/mode/speed
> 	  from testing. This is now using the pre-set default.
> 	+ asus_wmi_led_init(), set speed value to a correct value
> 	+ keyboard_rgb_mode_store() return count, not 0
> 	+ correctly unregister the mulicolor led on module exit
> 	+ use switch/case in keyboard_rgb_mode_store() for speed
> 	+ remove a single line bracket block
> - V2: patch 3: asus-wmi RGB power control
> 	+ Try to fix the indent warning from buildbot
> 	+ Use correct date on added API docs
> 	+ Add missing panel_od doc
> 	+ correctly label attribute for keyboard_rgb_state
> - V2: patch 4: documentation
> 	+ Add commit message
> - V2: patch 5: attributes using sysfs_emit:
> 	+ Add commit message
> - V2: patch 6: new patch, dgpu_only mode
> 	+ A previous patch I submitted=20
> "0006-asus-wmi-Add-support-for-dGPU-only-mode.patch"
> 	  is now part of this series due to merge conflicts caused by the
> 	  previous 5 patches
>=20
> Previous patches obsoleted:
> https://lkml.org/lkml/2022/8/3/885
> https://lkml.org/lkml/2022/8/3/886
> https://lkml.org/lkml/2022/8/3/44
> I may not have listed all.
>=20
> Luke D. Jones (6):
>   asus-wmi: Implement TUF laptop keyboard RGB control
>   asus-wmi: Implement TUF laptop keyboard LED modes
>   asus-wmi: Implement TUF laptop keyboard power states
>   asus-wmi: Document previously added attributes
>   asus-wmi: Convert all attr-show to use sysfs_emit
>   asus-wmi: Add support for dGPU-only mode
>=20
>  .../ABI/testing/sysfs-platform-asus-wmi       |  68 ++++
>  drivers/platform/x86/asus-wmi.c               | 343=20
> +++++++++++++++++-
>  include/linux/platform_data/x86/asus-wmi.h    |   8 +
>  3 files changed, 412 insertions(+), 7 deletions(-)
>=20
> --
> 2.37.1
>=20


