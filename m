Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8931E4FA947
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbiDIPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiDIPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56C4232128;
        Sat,  9 Apr 2022 08:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F93660A78;
        Sat,  9 Apr 2022 15:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B932C385A5;
        Sat,  9 Apr 2022 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649518302;
        bh=8p1ouQSaJQfbz/s0yj1J24urm8BcKDHsOgym4W/acoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t0ESnNa4/kEcA0Ivh/FKNElIm6fbMn46X9xH0WLvCQK9BVG33JZc2M9OrcTDcLhO0
         y+jwA2ybp5y5bIB43u7C66wA1AG+0aI+aLcmdPXQOjYhEs/xT0jqFUN4y6SUey4iRE
         tzfzqi4gHhNq64Wp5zoajK8Ksr963B01CX9CorxBwtZgM7VQ3oHzyazTcYO0f+QNWK
         G6GLPpATA4pYkHD4KlZm61IL4J0XkllgsJon01EY7RESl3H3dwn2vNTQO/hzMNvyGm
         iOJFUS/W6Yz5/thZEwow6h0Wqe5es0gqjVR0Mnaq3PAy/4SCmr4ifLFJYEcCytH4Cv
         clpdxKcorJRow==
Date:   Sat, 9 Apr 2022 17:31:38 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Piotr Chmura <chmooreck@gmail.com>
Cc:     Robert Schlabbach <robert_s@gmx.net>,
        LMML <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antti Palosaari <crope@iki.fi>
Subject: Re: [PATCH v3] si2157: unknown chip version Si2147-A30 ROM 0x50
Message-ID: <20220409173138.2a9d8a6e@coco.lan>
In-Reply-To: <f2fc5822-56fb-26e8-00f3-71d2e359cf80@leemhuis.info>
References: <c4bcaff8-fbad-969e-ad47-e2c487ac02a1@gmail.com>
        <f2fc5822-56fb-26e8-00f3-71d2e359cf80@leemhuis.info>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 9 Apr 2022 14:53:52 +0200
Thorsten Leemhuis <regressions@leemhuis.info> escreveu:

> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> to make this easily accessible to everyone.
>=20
> Mauro, what's the hold-up here? Below patch is fixing a regression
> caused by one of your patches. Why haven't you applied this or provided
> feedback to Piotr what needs to be improved? Or am I missing something
> and progress was made?

We're currently without a sub-maintainer for dvb, so it takes a longer
time for patches like that to be noticed.

In the specific case of this patch, the problem is that it doesn't apply...
The emailer mangled the patch, replacing spaces by U+0xa0 characters.

Piotr,

Please re-submit them with git send-email (or use some other client
that won't damage whitespaces.

Regards,
Mauro

>=20
> This really is overdue, the first version of this patch was already
> posted two and a half weeks ago. Reminder, the newly added document on
> handling regressions (
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/handling-regressions.rst#n132
> ) for this case states this as rule of thumb: "Aim to fix regressions
> within one week ".
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>=20
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
>=20
>=20
> #regzbot poke
>=20
>=20
> On 31.03.22 17:55, Piotr Chmura wrote:
> > Fix firmware file names assignment in si2157 tuner, allow for running
> > devices without firmware files needed.
> >=20
> >=20
> > It's regression in kernel 5.17.0, worked fine in 5.16 series.
> >=20
> > device: 07ca:1871 AVerMedia Technologies, Inc. TD310 DVB-T/T2/C dongle
> > modprobe gives error: unknown chip version Si2147-A30 ROM 0x50
> > Device initialization is interrupted.
> >=20
> > caused by:
> > 1. table si2157_tuners has swapped fields rom_id and required vs struct
> > si2157_tuner_info.
> > 2. both firmware file names can be null for devices with required =3D=3D
> > false - device uses build-in firmware in this case
> >=20
> > Fix:
> > 1. Rearrange fields in table si2157_tuners
> > 2. Allow both firmware file names be NULL for devices defined with
> > required =3D=3D false
> >=20
> >=20
> > Fixes: 1c35ba3bf972 ("media: si2157: use a different namespace for
> > firmware")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215726
> > Link:
> > https://lore.kernel.org/lkml/5f660108-8812-383c-83e4-29ee0558d623@leemh=
uis.info/
> >=20
> > Cc: stable@vger.kernel.org # 5.17.x
> > Signed-off-by: Piotr Chmura <chmooreck@gmail.com>
> > Tested-by: Robert Schlabbach <robert_s@gmx.net>
> >=20
> > ---
> >=20
> > --- a/drivers/media/tuners/si2157.c=C2=A0=C2=A0=C2=A0 2022-03-20 21:14:=
17.000000000 +0100
> > +++ b/drivers/media/tuners/si2157.c=C2=A0=C2=A0=C2=A0 2022-03-22 23:48:=
05.604408331 +0100
> > @@ -77,16 +77,16 @@ err_mutex_unlock:
> > =C2=A0}
> >=20
> > =C2=A0static const struct si2157_tuner_info si2157_tuners[] =3D {
> > -=C2=A0=C2=A0=C2=A0 { SI2141, false, 0x60, SI2141_60_FIRMWARE, SI2141_A=
10_FIRMWARE },
> > -=C2=A0=C2=A0=C2=A0 { SI2141, false, 0x61, SI2141_61_FIRMWARE, SI2141_A=
10_FIRMWARE },
> > -=C2=A0=C2=A0=C2=A0 { SI2146, false, 0x11, SI2146_11_FIRMWARE, NULL },
> > -=C2=A0=C2=A0=C2=A0 { SI2147, false, 0x50, SI2147_50_FIRMWARE, NULL },
> > -=C2=A0=C2=A0=C2=A0 { SI2148, true,=C2=A0 0x32, SI2148_32_FIRMWARE, SI2=
158_A20_FIRMWARE },
> > -=C2=A0=C2=A0=C2=A0 { SI2148, true,=C2=A0 0x33, SI2148_33_FIRMWARE, SI2=
158_A20_FIRMWARE },
> > -=C2=A0=C2=A0=C2=A0 { SI2157, false, 0x50, SI2157_50_FIRMWARE, SI2157_A=
30_FIRMWARE },
> > -=C2=A0=C2=A0=C2=A0 { SI2158, false, 0x50, SI2158_50_FIRMWARE, SI2158_A=
20_FIRMWARE },
> > -=C2=A0=C2=A0=C2=A0 { SI2158, false, 0x51, SI2158_51_FIRMWARE, SI2158_A=
20_FIRMWARE },
> > -=C2=A0=C2=A0=C2=A0 { SI2177, false, 0x50, SI2177_50_FIRMWARE, SI2157_A=
30_FIRMWARE },
> > +=C2=A0=C2=A0=C2=A0 { SI2141, 0x60, false, SI2141_60_FIRMWARE, SI2141_A=
10_FIRMWARE },
> > +=C2=A0=C2=A0=C2=A0 { SI2141, 0x61, false, SI2141_61_FIRMWARE, SI2141_A=
10_FIRMWARE },
> > +=C2=A0=C2=A0=C2=A0 { SI2146, 0x11, false, SI2146_11_FIRMWARE, NULL },
> > +=C2=A0=C2=A0=C2=A0 { SI2147, 0x50, false, SI2147_50_FIRMWARE, NULL },
> > +=C2=A0=C2=A0=C2=A0 { SI2148, 0x32, true,=C2=A0 SI2148_32_FIRMWARE, SI2=
158_A20_FIRMWARE },
> > +=C2=A0=C2=A0=C2=A0 { SI2148, 0x33, true,=C2=A0 SI2148_33_FIRMWARE, SI2=
158_A20_FIRMWARE },
> > +=C2=A0=C2=A0=C2=A0 { SI2157, 0x50, false, SI2157_50_FIRMWARE, SI2157_A=
30_FIRMWARE },
> > +=C2=A0=C2=A0=C2=A0 { SI2158, 0x50, false, SI2158_50_FIRMWARE, SI2158_A=
20_FIRMWARE },
> > +=C2=A0=C2=A0=C2=A0 { SI2158, 0x51, false, SI2158_51_FIRMWARE, SI2158_A=
20_FIRMWARE },
> > +=C2=A0=C2=A0=C2=A0 { SI2177, 0x50, false, SI2177_50_FIRMWARE, SI2157_A=
30_FIRMWARE },
> > =C2=A0};
> >=20
> > =C2=A0static int si2157_load_firmware(struct dvb_frontend *fe,
> > @@ -178,7 +178,7 @@ static int si2157_find_and_load_firmware
> > =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0 if (!fw_name && !fw_alt_name) {
> > +=C2=A0=C2=A0=C2=A0 if (required && !fw_name && !fw_alt_name) {
> > =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err(&client->dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 "unknown=
 chip version Si21%d-%c%c%c ROM 0x%02x\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 part_id,=
 cmd.args[1], cmd.args[3], cmd.args[4], rom_id);
> >  =20
>=20



Thanks,
Mauro
