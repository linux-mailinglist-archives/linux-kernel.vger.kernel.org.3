Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762295908A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbiHKWNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiHKWNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:13:32 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD22A032E;
        Thu, 11 Aug 2022 15:13:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A151A5C00BF;
        Thu, 11 Aug 2022 18:13:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Aug 2022 18:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660256010; x=
        1660342410; bh=ZIzxJ5MgFo4JJ3fo2egieILXrZU/1FfabyPb1B3koxY=; b=q
        GmZ0l1FwzD2KAfMEwNDY0/R1bYDvYtc+StDbWYv/pFCaErQ3yP6ZmckVMN4uBtJY
        /3r2PR7eWW41iJcn0bhBsVCpXQs4MkiYOFCrIJuS7QHDA/KWryLKRXwABUq/3Bn6
        E6JdIlnDpyjZgpdS44GjO//4jjtPReOTfbmCI6RZ5PMbZH5EXR/BV7ALcNJTOQ5x
        TrJhui+5O3fVQReYbobfle9uvYIRYozq+zL4PraaEL/9NUzs31hi/JWhno/y/Omn
        luWhYsaNOjv2LQ8Ek0AG4YQhjACw1QE+rk0qqxXfEoDb+yOURhyhnF0kAAhcVXUN
        eqD3TaTYMDUE0ttMyauhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660256010; x=
        1660342410; bh=ZIzxJ5MgFo4JJ3fo2egieILXrZU/1FfabyPb1B3koxY=; b=r
        bFqnp42vUqEU3sQopNBHvZqQSDpH8Fath4pbmljvrPb4+BdQsovbaVzlbOi8RUNt
        ALOd9/NvDbDXEGSoUCEJr6FNnQaVkQ20i+BfebU/inc1/ySLSg6gjHmmC0/dtELY
        pa2cUQtb3GCvHWXF1KYV7XnacpzKsI8H2O9EslVCmbz07U6Sd5yGdxUZsnksPuFE
        psUnbysfVqChzQaAJuKYBrAZzcijLkirZvcH4gsSVSngAKBeUA69gOxg3D0yFZiA
        1kVv3uXr8x5iBLKmQeIXXkY2Hcn25jpy37bW5h6rcKHl6+Bx+XM5+UTLDfNpR5l+
        W5BXbdvwJlxIcfIQ9Pshw==
X-ME-Sender: <xms:Cn_1YkYlkl3u5vn-CG4zkzPTvPYGFOLYlUHc7uH0-aot4iyO0_GBRg>
    <xme:Cn_1YvbeNH29Tua-j0NeXAsAeqtMzEOf9yjEGOP-vSBeQuAimbw1mfXOkhTwXqWrb
    vF9jG9-_V0QA7BDTfk>
X-ME-Received: <xmr:Cn_1Yu9K_KV1jVjUEuLNKMwtx2mIq8BStmoQkC8vC0fgGXFyVc6qj1pE5ZQnkxrKlpAXkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Cn_1YuoN9vKeim6sf-1iIQVbaQHfGIt-AEnZ4My7kijVzrib6bjt6w>
    <xmx:Cn_1YvrsP399rqv6TsoPrCtkCbteDQ41xlqMmA_c0pZ9HUMa9QSFxg>
    <xmx:Cn_1YsQef2DApPGWhwWer9Tp6hPHxzgGK2LmIvArphoDvBzfF8kRzg>
    <xmx:Cn_1YuUYe3jOAiQb0MGff2tq4c_CxV6PO2cVQanCaddeNdHo1-LJwg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 18:13:28 -0400 (EDT)
Message-ID: <4cefa82993c9a3560c0e0fd8969ac8e5e6d8ecc8.camel@ljones.dev>
Subject: Re: [PATCH v3 1/6] asus-wmi: Implement TUF laptop keyboard RGB
 control
From:   Luke Jones <luke@ljones.dev>
To:     Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Aug 2022 10:13:21 +1200
In-Reply-To: <af6b9480-5e33-ec1b-94cc-e51724db0716@redhat.com>
References: <20220809025054.1626339-1-luke@ljones.dev>
         <20220809025054.1626339-2-luke@ljones.dev>
         <20220809105031.GA4971@duo.ucw.cz>
         <fcc7b7eb29abc1ac9053bce02fd9f705e5f06b0b.camel@ljones.dev>
         <f1ad35f6-acdf-0fc8-1ee1-99bd8c7a5e77@redhat.com>
         <af6b9480-5e33-ec1b-94cc-e51724db0716@redhat.com>
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

On Thu, 2022-08-11 at 17:05 +0200, Hans de Goede wrote:
>=20
>=20
> On 8/11/22 17:01, Hans de Goede wrote:
> > Hi,
> >=20
> > On 8/10/22 06:44, Luke Jones wrote:
> > > Hi Pavel, Andy, Hans,
> > >=20
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * asus::kbd_backlight still
> > > > > > > > > > > controls a
> > > > > > > > > > > base > > > > > > 3-level backlight and when
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it is on 0, the RGB is not
> > > > > > > > > > > visible
> > > > > > > > > > > at all. > > > > RGB > > should be treated as
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * an additional step.
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > >=20
> > > > > > > Ouch. Lets not do that? If rgb interface is available,
> > > > > > > hide the
> > > > > > > 3
> > > > > > > level one, or something.
> > > > > > >=20
> > >=20
> > > I really don't think this is safe or sensible. There are some
> > > laptops
> > > that default the 3-stage method to off, and this means that the
> > > LEDs
> > > will not show regardless of multicolor brightness.
> > >=20
> > >=20
> > >=20
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mc_cdev->led_cdev.name =3D=C2=A0=C2=
=A0 > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > "asus::multicolour::kbd_backlight";
> > > > > > >=20
> > > > > > > Make this "rgb:kbd_backlight" or
> > > > > > > "inputX:rgb:kbd_backligh" and
> > > > > > > document it in Documentation/leds/well-known-leds.txt.
> > >=20
> > > Will do.
> > >=20
> > > -- 4 hours later --
> > >=20
> > > I've spent a lot of time working on this now. I don't think
> > > multicolor
> > > LED is suitable for use with the way these keyboards work.
> > >=20
> > > The biggest issue is related to the brightness setting.
> > > 1. If the ASUS_WMI_DEVID_KBD_BACKLIGHT method defaults to 0 on
> > > boot
> > > then RGB is not visible
> >=20
> > Note to others following this thread I asked Luke to clarify this
> > a bit in an unrelated 1:1 conversation we were having:
> >=20
> > On 8/10/22 23:45, Luke Jones wrote:
> > > On 8/10/22, Hans de Goede wrote:
> > > > I plan to go through all the asus-wmi stuff you've posted
> > > > tomorrow,
> > > > so I'll reply to this then. One thing which is not entirely
> > > > clear to me is that:
> > > >=20
> > > > 1. If I understand you correctly the laptops
> > > > with the RGB keyboards have both the old mono-color
> > > > "asus::kbd_backlight"
> > > > as well as a new RGB interface and these somehow interact with
> > > > each
> > > > other, do I understand that correctly?
> > >=20
> > > Yes, and that is the problem. The "mono" switch takes precedence.
> > >=20
> > > > 2. If yes, then can you explain the interaction in a bit more
> > > > detail,
> > > > I see you say someting along the lines of the RGB controls only
> > > > working when the old mono-color "asus::kbd_backlight"
> > > > brightness
> > > > is set to 3 (which is its max brightness) ?
> > >=20
> > > Adjusting this changes the overall keyboard brightness. So if
> > > this is
> > > at 1, and all RGB is at 255, then when you switch 2, 3, the
> > > overall
> > > brightness increases.
> > >=20
> > > > 3. So what happens e.g. if writing 2 to the old mono-color
> > > > "asus::kbd_backlight" brightness after setting some RGB values
> > > > ?
> > >=20
> > > If the brightness was 3, then the overall brightness decreases.
> > > If it was at 1, then it increases.
> >=20
> > I see, so the old (still present) mono-color "asus::kbd_backlight"
> > brightness works as a master brightness control and the rgb values
> > in the ASUS_WMI_DEVID_TUF_RGB_MODE WMI set commands are really
> > just to set the color.
> >=20
> > And I guess that the Fn + whatever kbd brightness hotkey also still
> > modifies the old mono-color "asus::kbd_backlight"? Which means that
> > the "asus::kbd_backlight" device is also the device on which the
> > led_classdev_notify_brightness_hw_changed is done as you mention
> > below.
> >=20
> > (continued below.
> >=20
> > > I worked around this by setting it to "3" by default in module if
> > > ASUS_WMI_DEVID_TUF_RGB_MODE is found. And added a check in the
> > > button
> > > events to adjust multicolor brightness (+/- 17). This works but
> > > now I
> > > can't do led notify (led_classdev_notify_brightness_hw_changed).
> > >=20
> > > 2. Pattern trigger can't be used for these keyboard modes as the
> > > modes
> > > are done entirely in hardware via a single switch in the complete
> > > command packet.
> > >=20
> > > I don't see any way forward with this, and looking at the
> > > complexity I
> > > don't have time either.
> > >=20
> > > 3. Nodes everywhere..
> > >=20
> > > To fully control control these keyboards there are two WMI
> > > methods, one
> > > for mode/rgb, one for power-state. Splitting each of these
> > > parameters
> > > out to individual nodes with sensible naming and expectations
> > > gives:
> >=20
> > <snip>
> >=20
> > > Quite frankly I would rather use the method I had in the first
> > > patch I
> > > submitted where mode and state had two nodes each,
> > > - keyboard_rgb_mode, WO =3D "n n n n n n"
> > > - keyboard_rgb_mode_index, output =3D "save/apply, mode, r, g, b,
> > > speed"
> > > - keyboard_rgb_state, WO =3D "n n n n n"
> > > - keyboard_rgb_state_index, output =3D "save/apply, boot, awake,
> > > sleep,
> > > keyboard"
> > >=20
> > > A big benefit of this structure is that not being able to read
> > > settings
> > > back from the keyboard (not possible!) becomes a non-issue
> > > because
> > > users have to write a full input, not partial, and it will apply
> > > right
> > > away.
> >=20
> > Right to me this not being able to read back the values shows that
> > the firmware API here really is not suitable for doing a more
> > fancy "nice" / standard sysfs API on top.
> >=20
> > Since we cannot read back any of the r, g, b, mode or speed values
> > we would need to pick defaults and then setting any of them would
> > override the actual values the hw is using for the others, which
> > is really not a good thing to do.
> >=20
> > So that only leaves something akin to keyboard_rgb_mode[_index] +
> > keyboard_rgb_state[_index] which sets all values at once, mirroring
> > the limited WMI API as a good option here, I agree with you on
> > this.
> >=20
> > Sorry Pavel, I know you don't like custom sysfs attributes
> > being added to LED class devices, but I have to agree with Luke
> > that there really is not a good way to deal with this here and
> > we did try!
> >=20
> > Only request I have for the next version wrt the decision to
> > circle all the way back to having:
> >=20
> > > - keyboard_rgb_mode, WO =3D "n n n n n n"
> > > - keyboard_rgb_mode_index, output =3D "save/apply, mode, r, g, b,
> > > speed"
> > > - keyboard_rgb_state, WO =3D "n n n n n"
> > > - keyboard_rgb_state_index, output =3D "save/apply, boot, awake,
> > > sleep,
> >=20
> > Is please put these new attributes under the:
> > /sys/class/leds/asus::kbd_backlight
> >=20
> > Using the led_class_device.groups member as discussed before, now
> > that we have decided to drop the multicolor LED stuff that should
> > work :)
> >=20
> > Although maybe Pavel prefers to have the new sysfs attributes
> > under /sys/bus/platform/devices/asus-nb-wmi/ instead since they
> > are non standard.
> >=20
> > Pavel, to me having these under /sys/class/leds/asus::kbd_backlight
> > seems more logical.
>=20
> p.s.
>=20
> Besides it being more logical to group these together with the
> main brightness control for the kbd_backlight, I believe this
> way the files will also be easier to discover for users
> (users not using the asusctl utility that is).

I agree with this. From what I've seen with folks trying to debug RGB
keyboard issues they aren't familiar with they tend to reach straight
for looking in /sys/class/leds/asus::kbd_backlight.

Doing it this way mean that the attributes will show up in udev under
this LED class also, making it a more logical way to discover an added
feature.

> > But since there are non-standard and since
> > there already is a bunch of asus-wmi sysfs API under
> > /sys/bus/platform/devices/asus-nb-wmi/ putting them there if you
> > prefer that is fine with me too. So what do you prefer ?
> >=20
> > > Hans, Andy, can I please revert back to the node + _index pairs
> > > taking
> > > an array input. Everything will be cleaner and simpler.
> >=20
> > Ack, see above. Thank you for at least trying to use the multi-
> > color
> > LED API.=20
> >=20
> > Regards,
> >=20
> > Hans
> >=20
>=20

Kind regards,
Luke.
