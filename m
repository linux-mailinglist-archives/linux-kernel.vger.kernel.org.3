Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB7958E676
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiHJEoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiHJEof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:44:35 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F7382FA8;
        Tue,  9 Aug 2022 21:44:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 23D69320090A;
        Wed, 10 Aug 2022 00:44:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Aug 2022 00:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660106670; x=
        1660193070; bh=BIhDR8QyFaEyZZyv2NBJxwbm+qAB3aLtVX5s9TTqwoA=; b=c
        +Wj0w/pXdOLqD9+xv4x9My7M7ELw1rwDcYlA3uuzRGE8LTRYSix+MnKGOP9P6nM/
        YTyCgzuKbFvCd7AJ1Or52tddbrkti+ICgsR0yUNlK6JgE4c+uoSRFmEZqHyk5jE7
        rKTFxWsMLL7eNgT+Ny7GlojVmHpLqKmuKSlO/ICJ3MFNs32PzM/TVwBRyTABrO/Z
        vLH/2gGsjSU72hUALAFuNlAEfXCaQ0WREibrMBGyKiVCwT3VHMvW+AawZ9ovfD+C
        +IF8GEX0dYgMBqmbIWIWIK2R2cI7kEEakrxs+xZzgTcbr5osWn+jfxWOi/SRkVuu
        bdKpKys1wKZV1PFXL+Fgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660106670; x=
        1660193070; bh=BIhDR8QyFaEyZZyv2NBJxwbm+qAB3aLtVX5s9TTqwoA=; b=o
        sy2ksPtbF5E+r4gGopt81yCuclThFHt6gnoXKjTxMdoCyogCrJYVkkN5z21FV54I
        7FaX01G6fkxDVmXz+hVWcM6xEzB3lbJY/o+OCRIzWEphT3ZWGvIPnpOqg8bZ2GUc
        g56xwdv58P2+XMef7/RZuh7eCwAbkOmUOmrcPTHEOKPk6mCv/Xgza2lfFvQujXvf
        W1lD2X/phBuQNxxBCYcuMWJBFj/cUvtczfY1jaw7Ug+Zy5dHIQuSYwphGNmDjIZw
        s/Itl+jGo4HGIl0B1/WlqcSE0bBo8TrS99Rt/bDUcrAJsELhqxeNVyN3SNSDE+/M
        jQheviTWtmyntoOZ3MrRw==
X-ME-Sender: <xms:rjfzYg29sAORIkygg_mt-L_YVjgX1VpgFY55Oo8lTiHQSp82e-ZECQ>
    <xme:rjfzYrFIDDIYXRsUAoZciDIbWnpXd31t6K_azAJaucHWAG_AoKmsfLjllooISwodT
    MkaywFuKtjWBN851xA>
X-ME-Received: <xmr:rjfzYo5RFtEO4aDF9_nKeQwSFvG0xNmIyqQ0IMDbbWQyL8xb5E8nEkE6P2M95Zh3kAirGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeguddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:rjfzYp25kavF12M5vXGxr1O09_dDujz6u1eu3Na148sZnRqVqVUTxg>
    <xmx:rjfzYjHazngnQJKOTS8jlt76WPZm-u604zYG9OKMxxExnZ2vW79qvw>
    <xmx:rjfzYi-JLWwW1A8GDb0UBLczxTA7hi3441EFi1B1SeliuBcueoyLIA>
    <xmx:rjfzYrBFhiRVBru171uDUmkjsaesNwlcXRMf_LBh1gXEHlcCcnPw7Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Aug 2022 00:44:27 -0400 (EDT)
Message-ID: <fcc7b7eb29abc1ac9053bce02fd9f705e5f06b0b.camel@ljones.dev>
Subject: Re: [PATCH v3 1/6] asus-wmi: Implement TUF laptop keyboard RGB
 control
From:   Luke Jones <luke@ljones.dev>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     hdegoede@redhat.com, andy.shevchenko@gmail.com,
        pobrn@protonmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Aug 2022 16:44:20 +1200
In-Reply-To: <20220809105031.GA4971@duo.ucw.cz>
References: <20220809025054.1626339-1-luke@ljones.dev>
         <20220809025054.1626339-2-luke@ljones.dev>
         <20220809105031.GA4971@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel, Andy, Hans,

> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * asus::kbd_backlight still controls a
> > > > > > > > base > > > > > > 3-level backlight and when
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it is on 0, the RGB is not visible
> > > > > > > > at all. > > > > RGB > > should be treated as
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * an additional step.
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > >=20
> > > > Ouch. Lets not do that? If rgb interface is available, hide the
> > > > 3
> > > > level one, or something.
> > > >=20

I really don't think this is safe or sensible. There are some laptops
that default the 3-stage method to off, and this means that the LEDs
will not show regardless of multicolor brightness.



> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mc_cdev->led_cdev.name =3D=C2=A0=C2=A0 > >=
 > > > >
> > > > > > > > "asus::multicolour::kbd_backlight";
> > > >=20
> > > > Make this "rgb:kbd_backlight" or "inputX:rgb:kbd_backligh" and
> > > > document it in Documentation/leds/well-known-leds.txt.

Will do.

-- 4 hours later --

I've spent a lot of time working on this now. I don't think multicolor
LED is suitable for use with the way these keyboards work.

The biggest issue is related to the brightness setting.
1. If the ASUS_WMI_DEVID_KBD_BACKLIGHT method defaults to 0 on boot
then RGB is not visible

I worked around this by setting it to "3" by default in module if
ASUS_WMI_DEVID_TUF_RGB_MODE is found. And added a check in the button
events to adjust multicolor brightness (+/- 17). This works but now I
can't do led notify (led_classdev_notify_brightness_hw_changed).

2. Pattern trigger can't be used for these keyboard modes as the modes
are done entirely in hardware via a single switch in the complete
command packet.

I don't see any way forward with this, and looking at the complexity I
don't have time either.

3. Nodes everywhere..

To fully control control these keyboards there are two WMI methods, one
for mode/rgb, one for power-state. Splitting each of these parameters
out to individual nodes with sensible naming and expectations gives:

- keyboard_rgb_apply, new WO node to actually write out data
- keyboard_rgb_save, first parameter of packet, retain-on-boot
- keyboard_rgb_mode, the factory built-in modes,
- keyboard_rgb_speed, speed of certain modes

And then for power-state:

- keyboard_state_apply, new WO node to actually write out data
- keyboard_state_save, first parameter of packet, retain-on-boot
- keyboard_state_boot, play boot animation (on boot)
- keyboard_state_awake, LEDs visible while awake
- keyboard_state_sleep, play suspend animation (while suspended)
- keyboard_state_keyboard, unknown effect

Quite frankly I would rather use the method I had in the first patch I
submitted where mode and state had two nodes each,
- keyboard_rgb_mode, WO =3D "n n n n n n"
- keyboard_rgb_mode_index, output =3D "save/apply, mode, r, g, b, speed"
- keyboard_rgb_state, WO =3D "n n n n n"
- keyboard_rgb_state_index, output =3D "save/apply, boot, awake, sleep,
keyboard"

A big benefit of this structure is that not being able to read settings
back from the keyboard (not possible!) becomes a non-issue because
users have to write a full input, not partial, and it will apply right
away.

Multicolor class could still be used, but from everything I've tried
now it really isn't suitable when the proper method for brightness is a
separate WMI method (0-3), and when that is 0 it means LEDs are fully
off - there's potential for mistakes/issues. Losing led-notif is an
issue for users for sure.

In short, from dog-fooding the current state inlcuding the trial of
using multicolor brightness (and hiding the proper WMI method) I can
only conclude that multicolor is not suitable for how these keyboards
work.

Hans, Andy, can I please revert back to the node + _index pairs taking
an array input. Everything will be cleaner and simpler.

Cheers,
Luke.

