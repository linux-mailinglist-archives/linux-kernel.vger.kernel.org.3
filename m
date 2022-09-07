Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D570F5B0B03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIGRFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIGRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:05:12 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45079326C5;
        Wed,  7 Sep 2022 10:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=q5jJ8bZ2+jzwp/69l9bHYA3OjQkDPCINRBtB9c+L6fI=; b=SJQVDb1STNHhPzd7ze5mXrpwDO
        jgmJ4FDz+15+5vAerorXcslOssiqkjn6adHX0kPpnAqw2bQnql2UzMoMB91ZgB38+hlxSKDYdPoF9
        abjVRDq9xHKCgEmLIg2kGqsdgjVA+9x9/cZAzHmr0IuTRVivYIeJg4T9RRHNhWCcaWw34N+quKgXR
        sWGyPon2FrE9ThyFO4Lqq/bn8za86wnFndAbqoaobYI6oxCbJVDJEf20DmQ2PsrEgIEVekCO8reVi
        tUmtaunddjSHvn5cip3VNLZyyhkvm5wC6FOPcEgr0B1iWlhF+0BbkQHp0B24svb2lWxdWXt+X5+/l
        cqb87AVA==;
Received: from [38.44.74.92] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oVyU4-00CpzH-GN; Wed, 07 Sep 2022 19:05:04 +0200
Date:   Wed, 7 Sep 2022 16:04:51 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Igor Torrente <igormtorrente@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: build failure of next-20220906 due to 396369d67549 ("drm: vkms:
 Add support to the RGB565 format")
Message-ID: <20220907170451.efhz62nkxybqxtaa@mail.igalia.com>
References: <YxducgSzR6/zyHD7@debian>
 <CADVatmNfc1YT02v5-FaMoGN==MOx5ZJ=o8YMQAH19Gvf91betA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x6b2unxeedv2ifzg"
Content-Disposition: inline
In-Reply-To: <CADVatmNfc1YT02v5-FaMoGN==MOx5ZJ=o8YMQAH19Gvf91betA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x6b2unxeedv2ifzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09/06, Sudip Mukherjee wrote:
> On Tue, Sep 6, 2022 at 4:59 PM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi All,
> >
> > The builds of next-20220906 fails for mips, xtensa and arm allmodconfig.
> >
> > The errors in mips and xtensa are:
> >
> > ERROR: modpost: "__divdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > ERROR: modpost: "__udivdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> >
> > The error in arm is:
> >
> > ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/vkms/vkms.ko] undef=
ined!
> > ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefi=
ned!
> >
> >
> > Trying to do a git bisect to find out the offending commit.
>=20
> git bisect points to 396369d67549 ("drm: vkms: Add support to the
> RGB565 format")

Hi Sudip,

Thanks for pointing out this issue.

I think we can replace the macros that are triggering those compilation
error by functions in drm/drm_fixed.h that do the same calculation.

I checked those errors when building for arm and i386 and the issues are
fixed after applying the patch below. I appreciate if you can test.

I didn't check with mips and xtensa, but I guess it works in the same
way.

Igor,

it would be good if you double-check the calculation and compare to your
previous results.

Thanks,

Melissa

---

=46rom 0853d85c0b9d6108f916665ff55efa079f28bc53 Mon Sep 17 00:00:00 2001
=46rom: Melissa Wen <mwen@igalia.com>
Date: Wed, 7 Sep 2022 15:14:31 -0100
Subject: [PATCH] drm/vkms: fix 32 bits compilation error by replacing macros

Replace vkms_formats macro for fixed-point operations with functions
=66rom drm/drm_fixed.h to do the same job and fix 32-bits compilation
errors.

Fixes: a19c2ac9858 ("drm: vkms: Add support to the RGB565 format")
Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 54 +++++++++++------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkm=
s_formats.c
index 30bf8e6660ad..5c2612b822d4 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -1,27 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
=20
-#include <drm/drm_rect.h>
+#include <linux/kernel.h>
 #include <linux/minmax.h>
+#include <drm/drm_rect.h>
+#include <drm/drm_fixed.h>
=20
 #include "vkms_formats.h"
=20
-/* The following macros help doing fixed point arithmetic. */
-/*
- * With Fixed-Point scale 15 we have 17 and 15 bits of integer and fractio=
nal
- * parts respectively.
- *  | 0000 0000 0000 0000 0.000 0000 0000 0000 |
- * 31                                          0
- */
-#define SHIFT 15
-
-#define INT_TO_FIXED(a) ((a) << SHIFT)
-#define FIXED_MUL(a, b) ((s32)(((s64)(a) * (b)) >> SHIFT))
-#define FIXED_DIV(a, b) ((s32)(((s64)(a) << SHIFT) / (b)))
-/* This macro converts a fixed point number to int, and round half up it */
-#define FIXED_TO_INT_ROUND(a) (((a) + (1 << (SHIFT - 1))) >> SHIFT)
-#define INT_TO_FIXED_DIV(a, b) (FIXED_DIV(INT_TO_FIXED(a), INT_TO_FIXED(b)=
))
-#define INT_TO_FIXED_DIV(a, b) (FIXED_DIV(INT_TO_FIXED(a), INT_TO_FIXED(b)=
))
-
 static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x=
, int y)
 {
 	return frame_info->offset + (y * frame_info->pitch)
@@ -137,20 +122,21 @@ static void RGB565_to_argb_u16(struct line_buffer *st=
age_buffer,
 	int x_limit =3D min_t(size_t, drm_rect_width(&frame_info->dst),
 			       stage_buffer->n_pixels);
=20
-	s32 fp_rb_ratio =3D INT_TO_FIXED_DIV(65535, 31);
-	s32 fp_g_ratio =3D INT_TO_FIXED_DIV(65535, 63);
+	s32 fp_rb_ratio =3D drm_fixp_div(drm_int2fixp(65535), 31);
+	s32 fp_g_ratio =3D drm_fixp_div(drm_int2fixp(65535), 63);
=20
 	for (size_t x =3D 0; x < x_limit; x++, src_pixels++) {
 		u16 rgb_565 =3D le16_to_cpu(*src_pixels);
-		s32 fp_r =3D INT_TO_FIXED((rgb_565 >> 11) & 0x1f);
-		s32 fp_g =3D INT_TO_FIXED((rgb_565 >> 5) & 0x3f);
-		s32 fp_b =3D INT_TO_FIXED(rgb_565 & 0x1f);
+		s32 fp_r =3D drm_int2fixp((rgb_565 >> 11) & 0x1f);
+		s32 fp_g =3D drm_int2fixp((rgb_565 >> 5) & 0x3f);
+		s32 fp_b =3D drm_int2fixp(rgb_565 & 0x1f);
=20
 		out_pixels[x].a =3D (u16)0xffff;
-		out_pixels[x].r =3D FIXED_TO_INT_ROUND(FIXED_MUL(fp_r, fp_rb_ratio));
-		out_pixels[x].g =3D FIXED_TO_INT_ROUND(FIXED_MUL(fp_g, fp_g_ratio));
-		out_pixels[x].b =3D FIXED_TO_INT_ROUND(FIXED_MUL(fp_b, fp_rb_ratio));
+		out_pixels[x].r =3D drm_fixp2int(drm_fixp_mul(fp_r, fp_rb_ratio));
+		out_pixels[x].g =3D drm_fixp2int(drm_fixp_mul(fp_g, fp_g_ratio));
+		out_pixels[x].b =3D drm_fixp2int(drm_fixp_mul(fp_b, fp_rb_ratio));
 	}
+
 }
=20
=20
@@ -249,17 +235,17 @@ static void argb_u16_to_RGB565(struct vkms_frame_info=
 *frame_info,
 	int x_limit =3D min_t(size_t, drm_rect_width(&frame_info->dst),
 			    src_buffer->n_pixels);
=20
-	s32 fp_rb_ratio =3D INT_TO_FIXED_DIV(65535, 31);
-	s32 fp_g_ratio =3D INT_TO_FIXED_DIV(65535, 63);
+	s32 fp_rb_ratio =3D drm_fixp_div(drm_int2fixp(65535), 31);
+	s32 fp_g_ratio =3D drm_fixp_div(drm_int2fixp(65535), 63);
=20
 	for (size_t x =3D 0; x < x_limit; x++, dst_pixels++) {
-		s32 fp_r =3D INT_TO_FIXED(in_pixels[x].r);
-		s32 fp_g =3D INT_TO_FIXED(in_pixels[x].g);
-		s32 fp_b =3D INT_TO_FIXED(in_pixels[x].b);
+		s32 fp_r =3D drm_int2fixp(in_pixels[x].r);
+		s32 fp_g =3D drm_int2fixp(in_pixels[x].g);
+		s32 fp_b =3D drm_int2fixp(in_pixels[x].b);
=20
-		u16 r =3D FIXED_TO_INT_ROUND(FIXED_DIV(fp_r, fp_rb_ratio));
-		u16 g =3D FIXED_TO_INT_ROUND(FIXED_DIV(fp_g, fp_g_ratio));
-		u16 b =3D FIXED_TO_INT_ROUND(FIXED_DIV(fp_b, fp_rb_ratio));
+		u16 r =3D drm_fixp2int(drm_fixp_div(fp_r, fp_rb_ratio));
+		u16 g =3D drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
+		u16 b =3D drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
=20
 		*dst_pixels =3D cpu_to_le16(r << 11 | g << 5 | b);
 	}
--=20
2.35.1


--x6b2unxeedv2ifzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmMYzywACgkQwqF3j0dL
ehwDBA/8CeX62ZgAMRmGyARst+qDVWEraAZbURjE0KbgaRAIQMNmF8+5eV25vA4H
gm/q6KSIWH1+h0CNW7W8Zj8gps1Jmilzph5T88O8mLwgx6+Qt+CMAvNvIGwmzDtS
usCJYJPMxviA0CT+H3mTDgqoVkEqFmlfpoN0fg7E5GJLos6XK8zZArSa1gKLojS7
h4BGwlRpZRGrNOtAYhLhmX497gsV7VVYWuxHHiM30MiCILA5BBKgPD1TOO1YpbEJ
AzRVmpD5CVhCOANO7nxKiddPZYYsnMwSe8Wc6hG51SQBGuTS61KgWkrUvZ6bregt
y2VM4WQB+JYwpiF7CPhXpb5cpOiHUAYAyrpLGuUjenXMakA813JwPr6od2t/dfTK
pbIHS4m6CvVblDugdMC7ZMGxCctI22mHiuq5SOKxpGVyFNF/lm/tzksk0lSErrlE
ZpaXj03cSYmi1QxtVutbV2b0znq7vO+NzPrqjT4jhUrTO2kHu6y5Ezw71BnH2VnJ
X6WbsM4zO5xquAo+YEiyYNV+4mY5WVECJ1lGvxtl4ycDmCE9U27nQsB17p06H8mL
GKBWu//yR8vseZHfL5AANtoQDWVTNxfdo7LfFWfBlx+uLpgLpt01NXxLP8DtO5MP
nsmaz9SV6CoQRWmy1sMClLLjIbrFi5CGpLTTDE5au+77KLV7QMg=
=24Px
-----END PGP SIGNATURE-----

--x6b2unxeedv2ifzg--
