Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B115357A743
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiGSTej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGSTeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:34:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E754AE9;
        Tue, 19 Jul 2022 12:34:36 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E733066019F4;
        Tue, 19 Jul 2022 20:34:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658259275;
        bh=0Nwi9OB6jwRh2GcUL4FWu+6SaUOl2YK0yUvaExLD0i0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Rt11ZwNOBG93A+wB1QRi7HLy0qKAXxY19sllg2t/PbPz2aACrvQnYwenAuHNaPu0M
         Vtqj9xWkAa7qWw0Ii4yYuR9hGhbfgD2jVOL+zyFIZhNPN3fsQEMuhpD6FNX44g+KyL
         mSCf1w5wPalhqCdXootgnhoZ86+veAB4ZByvelIq8zT4mfzzWtZeByG1Kpq5s05o5G
         s0F4/g4w7Hk5JnOC6G0IK10mUO0Q1mgsW3PIWEOkzKUDmr6ixv039KcsD2OY83wy+T
         Ohdf8qbTI03P3PYOMqiMG0x9UGJaRFpNoWLyV+KcPxTRJHIY9oPKNqIx8SurVx4K+C
         dyYnCQ2ujnCiQ==
Message-ID: <d9fa1648e63542dc4cc1ff6f56d8cd019a0d3e67.camel@collabora.com>
Subject: Re: [PATCH] hantro: Remove dedicated control documentation
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Chris Healy <cphealy@gmail.com>
Date:   Tue, 19 Jul 2022 15:34:24 -0400
In-Reply-To: <20220718214123.73275-2-ezequiel@vanguardiasur.com.ar>
References: <20220718214123.73275-1-ezequiel@vanguardiasur.com.ar>
         <20220718214123.73275-2-ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 18 juillet 2022 =C3=A0 18:41 -0300, Ezequiel Garcia a =C3=A9crit=
=C2=A0:
> The dedicated control required by the HEVC support
> was removed, and the driver now calculates the value
> internally. Remove the ad-hoc documentation as well.
>=20
> Fixes: 3360755ef89ab ("media: hantro: Stop using Hantro dedicated control=
")
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../userspace-api/media/drivers/hantro.rst    | 19 -------------------
>  1 file changed, 19 deletions(-)
>  delete mode 100644 Documentation/userspace-api/media/drivers/hantro.rst
>=20
> diff --git a/Documentation/userspace-api/media/drivers/hantro.rst b/Docum=
entation/userspace-api/media/drivers/hantro.rst
> deleted file mode 100644
> index cd9754b4e005..000000000000
> --- a/Documentation/userspace-api/media/drivers/hantro.rst
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -Hantro video decoder driver
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -
> -The Hantro video decoder driver implements the following driver-specific=
 controls:
> -
> -``V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP (integer)``
> -    Specifies to Hantro HEVC video decoder driver the number of data (in=
 bits) to
> -    skip in the slice segment header.
> -    If non-IDR, the bits to be skipped go from syntax element "pic_outpu=
t_flag"
> -    to before syntax element "slice_temporal_mvp_enabled_flag".
> -    If IDR, the skipped bits are just "pic_output_flag"
> -    (separate_colour_plane_flag is not supported).
> -
> -.. note::
> -
> -        This control is not yet part of the public kernel API and
> -        it is expected to change.

