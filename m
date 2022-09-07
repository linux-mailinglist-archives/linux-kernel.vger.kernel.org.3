Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A575B0134
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiIGKDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIGKD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:03:28 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C517B23179;
        Wed,  7 Sep 2022 03:03:21 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6A3401C000B;
        Wed,  7 Sep 2022 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662545000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LU+zY2Jwd4kGJSZPj1OwZLuTVU96ZZVbSnnFj4Wo8zI=;
        b=nBsTT7pah7wiKx7rluTTL/vACsuRcN2Oy8lB7MWf/G+yJP4YtF2lB/JBufoan5TRslDugL
        qQG9/Xd9a1i/Y4EfQnoHSB2piI9J9n5SCaacI9yp4f6kgQNoHU5JXZC10jd3IDrl2gCQSM
        kTeRuLcUwFN/rFy8Dw6gnrYbGx3JfkX8rWNtNGWgIXZAdKUYQopp6m8b7vqtQK9MrBiSFm
        CfWrW2nWlsNDVQwKfIDmgnOe8QdZGodk0mCCvZjfY/xaj0bf7iUEr2mWcAsDq8JbKce0BD
        v+icHAowg2/qTusuSV/EIXvP/D4klSs/3EbnnBw7Moad127BDGkKLJKbjpY1kA==
Date:   Wed, 7 Sep 2022 12:03:14 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 00/43] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / CSI
 Rework
Message-ID: <YxhsYu293t7h3655@aptenodytes>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
 <9270d6c8-fc8d-3a15-5469-aca3faab098b@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o/kNkGguw6K7pQKQ"
Content-Disposition: inline
In-Reply-To: <9270d6c8-fc8d-3a15-5469-aca3faab098b@xs4all.nl>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o/kNkGguw6K7pQKQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Wed 07 Sep 22, 10:47, Hans Verkuil wrote:
> Hi Paul,
>=20
> On 26/08/2022 20:31, Paul Kocialkowski wrote:
> > This part only concerns the rework of the CSI driver to support the MIP=
I CSI-2
> > and ISP workflows.
> >=20
> > Very few patches have not received any review at this point and the who=
le
> > thing looks good to go. Since this multi-part series has been going on =
for a
> > while, it would be great to see it merged soon!
>=20
> Testing with just patches 1-15 gives me these kerneldoc results:
>=20
> kerneldoc: WARNINGS
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:79: warning: Function =
parameter or member 'csi_dev' not described in 'sun6i_csi_is_format_support=
ed'
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:79: warning: Excess fu=
nction parameter 'csi' description in 'sun6i_csi_is_format_supported'
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:86: warning: Function =
parameter or member 'csi_dev' not described in 'sun6i_csi_set_power'
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:86: warning: Excess fu=
nction parameter 'csi' description in 'sun6i_csi_set_power'
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:94: warning: Function =
parameter or member 'csi_dev' not described in 'sun6i_csi_update_config'
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:94: warning: Excess fu=
nction parameter 'csi' description in 'sun6i_csi_update_config'
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:102: warning: Function=
 parameter or member 'csi_dev' not described in 'sun6i_csi_update_buf_addr'
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:102: warning: Excess f=
unction parameter 'csi' description in 'sun6i_csi_update_buf_addr'
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:109: warning: Function=
 parameter or member 'csi_dev' not described in 'sun6i_csi_set_stream'
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h:109: warning: Excess f=
unction parameter 'csi' description in 'sun6i_csi_set_stream'
>=20
> If this is caused by just 1 or 2 patches, then please post a v6.1 version=
 of just
> those patches fixing this. Otherwise perhaps a v7 is needed.

Only a single patch was concerned by the change so I've sent it as v6.1.

It looks like some return code descriptions were also missing so I've added
them in as well and updated the commit log.

Cheers,

Paul

> Regards,
>=20
> 	Hans
>=20
> >=20
> > Changes since v5:
> > - Rebased on latest media tree;
> > - Switched to using media_pad_remote_pad_first;
> > - Switched to using media_pad_remote_pad_unique.
> >=20
> > Changes since v4:
> > - Removed the v4l2 controls handler from the driver;
> > - Removed the info message about video device registration;
> > - Fixed "literature" typos;
> > - Moved patches dependent on the ISP driver to its dedicated series;
> > - Rebased on the latest media tree;
> > - Added collected tags;
> >=20
> > Changes since v3:
> > - Updated Kconfig to follow the latest media-wide changes;
> > - Rebased on latest changes to the driver (JPEG/sRGB colorspaces);
> > - Added helper to get a single enabled link for an entity's pad, to rep=
lace
> >   source selection at link_validate time and select the remote source at
> >   stream on time instead;
> > - Kept clock-managed regmap mmio;
> > - Added collected review tags;
> > - Various cosmetic cleanups;
> >=20
> > Changes since all-in-one v2:
> > - Reworked capture video device registration, which stays in the main p=
ath.
> > - Reworked async subdev handling with a dedicated structure holding the
> >   corresponding source to avoid matching in the driver;
> > - Added mutex for mbus format serialization;
> > - Remove useless else in link_validate;
> > - Reworked commit logs to include missing information;
> > - Cleaned up Kconfig, added PM dependency;
> > - Moved platform-specific clock rate to of match data;
> > - Added collected Reviewed-by tags;
> > - Updated copyright years;
> >=20
> > Paul Kocialkowski (43):
> >   media: sun6i-csi: Define and use driver name and (reworked)
> >     description
> >   media: sun6i-csi: Refactor main driver data structures
> >   media: sun6i-csi: Tidy up platform code
> >   media: sun6i-csi: Always set exclusive module clock rate
> >   media: sun6i-csi: Define and use variant to get module clock rate
> >   media: sun6i-csi: Use runtime pm for clocks and reset
> >   media: sun6i-csi: Tidy up Kconfig
> >   media: sun6i-csi: Tidy up v4l2 code
> >   media: sun6i-csi: Tidy up video code
> >   media: sun6i-csi: Pass and store csi device directly in video code
> >   media: sun6i-csi: Register the media device after creation
> >   media: sun6i-csi: Remove controls handler from the driver
> >   media: sun6i-csi: Add media ops with link notify callback
> >   media: sun6i-csi: Introduce and use video helper functions
> >   media: sun6i-csi: Move csi buffer definition to main header file
> >   media: sun6i-csi: Add bridge v4l2 subdev with port management
> >   media: sun6i-csi: Rename sun6i_video to sun6i_csi_capture
> >   media: sun6i-csi: Add capture state using vsync for page flip
> >   media: sun6i-csi: Rework register definitions, invert misleading
> >     fields
> >   media: sun6i-csi: Add dimensions and format helpers to capture
> >   media: sun6i-csi: Implement address configuration without indirection
> >   media: sun6i-csi: Split stream sequences and irq code in capture
> >   media: sun6i-csi: Move power management to runtime pm in capture
> >   media: sun6i-csi: Move register configuration to capture
> >   media: sun6i-csi: Rework capture format management with helper
> >   media: sun6i-csi: Remove custom format helper and rework configure
> >   media: sun6i-csi: Add bridge dimensions and format helpers
> >   media: sun6i-csi: Get mbus code from bridge instead of storing it
> >   media: sun6i-csi: Tidy capture configure code
> >   media: sun6i-csi: Introduce bridge format structure, list and helper
> >   media: sun6i-csi: Introduce capture format structure, list and helper
> >   media: sun6i-csi: Configure registers from format tables
> >   media: sun6i-csi: Introduce format match structure, list and helper
> >   media: sun6i-csi: Implement capture link validation with logic
> >   media: sun6i-csi: Get bridge subdev directly in capture stream ops
> >   media: sun6i-csi: Move hardware control to the bridge
> >   media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
> >   media: sun6i-csi: Cleanup headers and includes, update copyright lines
> >   media: sun6i-csi: Add support for MIPI CSI-2 to the bridge code
> >   media: sun6i-csi: Only configure capture when streaming
> >   media: sun6i-csi: Add extra checks to the interrupt routine
> >   media: sun6i-csi: Request a shared interrupt
> >   MAINTAINERS: Add myself as sun6i-csi maintainer and rename/move entry
> >=20
> >  MAINTAINERS                                   |   17 +-
> >  .../media/platform/sunxi/sun6i-csi/Kconfig    |   12 +-
> >  .../media/platform/sunxi/sun6i-csi/Makefile   |    2 +-
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 1027 ++++------------
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  149 +--
> >  .../sunxi/sun6i-csi/sun6i_csi_bridge.c        |  844 +++++++++++++
> >  .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |   69 ++
> >  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 1089 +++++++++++++++++
> >  .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   88 ++
> >  .../platform/sunxi/sun6i-csi/sun6i_csi_reg.h  |  362 +++---
> >  .../platform/sunxi/sun6i-csi/sun6i_video.c    |  685 -----------
> >  .../platform/sunxi/sun6i-csi/sun6i_video.h    |   38 -
> >  12 files changed, 2551 insertions(+), 1831 deletions(-)
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_br=
idge.c
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_br=
idge.h
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_ca=
pture.c
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_ca=
pture.h
> >  delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> >  delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
> >=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--o/kNkGguw6K7pQKQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMYbGEACgkQ3cLmz3+f
v9FJtwgAnkpeX7G3aSjaRipBe9p9k2eYVDvvBqgOZTj12TGcUi9OaHnEXCsacepX
eLcRiFNtOGZ2mKaO9mkgGxEEvh6Uknxq0evBqAvKfFtIVe7sOk/nhTr0zZp2Vyht
debjUt5wfpyt7O69f0Ez8opyG9wuh/RDNVFrRA7NLbZVCLETglIGzf9dMDnSJJhu
D9RIOIQSmF+vglfbG/HqRmoPAQataJ8ShzRp+qOwE0m4cHF6xURd3PsK2+rGgrum
k69Wqiv7ze4lDlDmvbxZOMCPej0IunwB889BIQBCTLiWniO7PyGb9jrXVR7E0Vjx
HJK1sN78oZ2PKj8DQEcIiw/wCVjxvg==
=sHhU
-----END PGP SIGNATURE-----

--o/kNkGguw6K7pQKQ--
