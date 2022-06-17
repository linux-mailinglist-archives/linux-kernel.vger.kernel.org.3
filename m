Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB34454F182
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380441AbiFQHJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380531AbiFQHJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:09:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8620D6621E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:09:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LPVWq4mX0z4xYX;
        Fri, 17 Jun 2022 17:08:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1655449738;
        bh=Ld8odACPKrJ92UdQKdxcty3uFHAGtCNlTBxeSo4iImI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hWOPSyYz1EhXPnB5ea5qGqyjtlfgMWoIuOWSEioYdQmDdVbueqFu+8c9DlYwtl3Ne
         c/fojj2dABMv7Hg6+PQa4oSUzoHU1jm41I2YvnxfvNlDq0mFXEteHAjr4ac5Ma2oXc
         PaLEJOHRXjhUX6FUiKgJy2rHWuFedcDAxjWXW2E7bJOvwl/YW/GIXVXti48bMxDPTz
         vMRKMPVk6/1d+A+tECv52ihr/SYALEImvzxFlmsZNwUQHx0HUI57454/gp9T/wmgcv
         BPFMjJoPj/FJSgnhbB5XeOan0xEY9ZlZ3pHE1hJ6JgfoAqVq819ZSK2ucQXnyrMwfi
         6mNDbakIlYAVA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Lyude Paul <lyude@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/nouveau/bios: Rename prom_init() and friends
 functions
In-Reply-To: <f548e6d03daf6c56cd011bd1a9ce46001e93590c.camel@redhat.com>
References: <7e0612b61511ec8030e3b2dcbfaa7751781c8b91.1647684507.git.christophe.leroy@csgroup.eu>
 <f6e72c6e6d9ae9019ad675081493372f745cbbf5.camel@redhat.com>
 <8735ggeih2.fsf@mpe.ellerman.id.au>
 <8c6e570f5e65e4f5abebc136d40d567e9af4f940.camel@redhat.com>
 <f548e6d03daf6c56cd011bd1a9ce46001e93590c.camel@redhat.com>
Date:   Fri, 17 Jun 2022 17:08:51 +1000
Message-ID: <87fsk3bwcc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lyude Paul <lyude@redhat.com> writes:
> Alright, dim's pushing it now. sorry about that!

Thanks, I see it in linux-next now.

cheers

> On Wed, 2022-06-08 at 16:48 -0400, Lyude Paul wrote:
>> Whoops, it totally may have. Thank you for the reminder, I will double c=
heck
>> and make sure this gets pushed today
>>=20
>> On Tue, 2022-06-07 at 23:00 +1000, Michael Ellerman wrote:
>> > Lyude Paul <lyude@redhat.com> writes:
>> > > Reviewed-by: Lyude Paul <lyude@redhat.com>
>> > >=20
>> > > Will push to drm-misc-next
>> >=20
>> > I don't see this patch in mainline or drm-misc-next, did it get lost?
>> >=20
>> > cheers
>> >=20
>> > > On Sat, 2022-03-19 at 11:27 +0100, Christophe Leroy wrote:
>> > > > While working at fixing powerpc headers, I ended up with the
>> > > > following error.
>> > > >=20
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/no=
uveau/nvkm/subdev/bios/shadowrom.c:48:1:
>> > > > error:
>> > > > conflicting types for 'prom_init'; have 'void *(struct nvkm_bios *,
>> > > > const
>> > > > char *)'
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0make[5]: *** [scri=
pts/Makefile.build:288:
>> > > > drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.o] Error 1
>> > > >=20
>> > > > powerpc and a few other architectures have a prom_init() global
>> > > > function.
>> > > > One day or another it will conflict with the one in shadowrom.c
>> > > >=20
>> > > > Those being static, they can easily be renamed. Do it.
>> > > >=20
>> > > > While at it, also rename the ops structure as 'nvbios_prom' instea=
d of
>> > > > 'nvbios_rom' in order to make it clear that it refers to the
>> > > > NV_PROM device.
>> > > >=20
>> > > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> > > > ---
>> > > > v2: using nvbios_prom prefix instead of nvbios_rom. Changed struct=
ure
>> > > > name
>> > > > to keep things consistant.
>> > > >=20
>> > > > =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 +-
>> > > > =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c=C2=A0 |=C2=
=A0 2 +-
>> > > > =C2=A0.../gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c=C2=A0=C2=A0=
 | 14 +++++++------
>> > > > -
>> > > > =C2=A03 files changed, 9 insertions(+), 9 deletions(-)
>> > > >=20
>> > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
>> > > > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
>> > > > index fac1bff1311b..cfa8a0c356dd 100644
>> > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
>> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h
>> > > > @@ -19,7 +19,7 @@ struct nvbios_source {
>> > > > =C2=A0int nvbios_extend(struct nvkm_bios *, u32 length);
>> > > > =C2=A0int nvbios_shadow(struct nvkm_bios *);
>> > > > =C2=A0
>> > > > -extern const struct nvbios_source nvbios_rom;
>> > > > +extern const struct nvbios_source nvbios_prom;
>> > > > =C2=A0extern const struct nvbios_source nvbios_ramin;
>> > > > =C2=A0extern const struct nvbios_source nvbios_acpi_fast;
>> > > > =C2=A0extern const struct nvbios_source nvbios_acpi_slow;
>> > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
>> > > > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
>> > > > index 4b571cc6bc70..19188683c8fc 100644
>> > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
>> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c
>> > > > @@ -171,7 +171,7 @@ nvbios_shadow(struct nvkm_bios *bios)
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct shadow mthd=
s[] =3D {
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ 0, &nvbios_of },
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ 0, &nvbios_ramin },
>> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0{ 0, &nvbios_rom },
>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0{ 0, &nvbios_prom },
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ 0, &nvbios_acpi_fast },
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ 4, &nvbios_acpi_slow },
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ 1, &nvbios_pcirom },
>> > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
>> > > > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
>> > > > index ffa4b395220a..39144ceb117b 100644
>> > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
>> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
>> > > > @@ -25,7 +25,7 @@
>> > > > =C2=A0#include <subdev/pci.h>
>> > > > =C2=A0
>> > > > =C2=A0static u32
>> > > > -prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *b=
ios)
>> > > > +nvbios_prom_read(void *data, u32 offset, u32 length, struct nvkm_=
bios
>> > > > *bios)
>> > > > =C2=A0{
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nvkm_device=
 *device =3D data;
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 i;
>> > > > @@ -38,14 +38,14 @@ prom_read(void *data, u32 offset, u32 length,
>> > > > struct
>> > > > nvkm_bios *bios)
>> > > > =C2=A0}
>> > > > =C2=A0
>> > > > =C2=A0static void
>> > > > -prom_fini(void *data)
>> > > > +nvbios_prom_fini(void *data)
>> > > > =C2=A0{
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nvkm_device=
 *device =3D data;
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nvkm_pci_rom_shado=
w(device->pci, true);
>> > > > =C2=A0}
>> > > > =C2=A0
>> > > > =C2=A0static void *
>> > > > -prom_init(struct nvkm_bios *bios, const char *name)
>> > > > +nvbios_prom_init(struct nvkm_bios *bios, const char *name)
>> > > > =C2=A0{
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nvkm_device=
 *device =3D bios->subdev.device;
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (device->card_t=
ype =3D=3D NV_40 && device->chipset >=3D 0x4c)
>> > > > @@ -55,10 +55,10 @@ prom_init(struct nvkm_bios *bios, const char
>> > > > *name)
>> > > > =C2=A0}
>> > > > =C2=A0
>> > > > =C2=A0const struct nvbios_source
>> > > > -nvbios_rom =3D {
>> > > > +nvbios_prom =3D {
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "PROM",
>> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.init =3D prom_init,
>> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.fini =3D prom_fini,
>> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.read =3D prom_read,
>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.init =3D nvbios_prom_i=
nit,
>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.fini =3D nvbios_prom_f=
ini,
>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.read =3D nvbios_prom_r=
ead,
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.rw =3D false,
>> > > > =C2=A0};
>> > >=20
>> > > --=20
>> > > Cheers,
>> > > =C2=A0Lyude Paul (she/her)
>> > > =C2=A0Software Engineer at Red Hat
>> >=20
>>=20
>
> --=20
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
