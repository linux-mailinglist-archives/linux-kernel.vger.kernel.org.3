Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137664C55D5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 13:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiBZMlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 07:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiBZMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 07:41:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA31DED4A;
        Sat, 26 Feb 2022 04:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645879223;
        bh=gRqleSNiS7RugUIP84HHge8cB+9Y8o8PNUyKmK6ru/c=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dESEbrUN2EaJunzZeSttQ78jBEfeBO8V4sQ1PXa8Qm92anje3UbAbvnP8/RhGKCcE
         fGkjkva7TgVyKuoqBtc4Uhfc+0utwJStnfjltQ30CRO5lvUD0LHVZlWmH2V2UTjeBk
         ZD8YL8uv7eeR0zaC6zHaYjLm9ovM1Y6y2b5eIbl0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([178.1.45.121]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1nTj7L3Jzx-00Eb3X; Sat, 26
 Feb 2022 13:40:22 +0100
Date:   Sat, 26 Feb 2022 13:40:19 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] clk: Declare mux tables as const u32[]
Message-ID: <Yhofs/PbIOmiyNIH@latitude>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
 <20220226010033.6C870C340E7@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GWbHRrphQV3Bh8j/"
Content-Disposition: inline
In-Reply-To: <20220226010033.6C870C340E7@smtp.kernel.org>
X-Provags-ID: V03:K1:dNF1UOYgr8RGoj8WNsbuQYYYEkvWI8nlA1KIHjJ7KlJdy43FvfR
 igs4EIDYIuvaVQPA7QLE6YSr3+Xvy8sG4J7INfMpqtRyQiAgbH83G5mXDQ2ww5x0OgrpkQ4
 oXvfj9pWf0IogCTAMdvMdiuukCBDzkEV4oJoB+HDGvAqqYFS4tVyS0y8iXadM0Xm4sb45Iy
 PB+89vkofSLzqL48yRKSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3b9kd8ojfAc=:lbrocjw8Chi3Lx0pl/vsn+
 x91n1BddLpd8OAP8zP9BiVBaUl+RmMFpfMwUpYfD1/H4Ews2U0OnurMdhOjm6lZYVmG1L9LUE
 DKW+qbE3eHMuc43AlkByXTbggrGWh9Ng8MpgyrrS9cbtL+65zzT6iM9DqVa+mLdLaXIISy2Xd
 /1nxd/YAFEbkenH3fo17bG/wTEyzl/qS3qjx0xXFa2Y8NM6ve1zNkOsrW11t0dDuD4PNjg9SG
 sANVRJD92wx7kPT55zY5V23ybx8jQC0hysEOa0IvzLiyvte+Wgv9vHQBv91vPpd/ugo2MTvAX
 1i6Fe5RDdQYjkfuHutYdiWvUJrwQmUhxbbS31FEEKvY8p6rhTZg6NHW05kBHsvW6cB3j6R9rP
 4GgZ/Ka0ekx5EY1KJ6rwDoWBbMY9xVFKHTZaH6K3p4XvuKXtdAvjKEdSg3DrEuUFmafQZEEvP
 Hc88vk4w6Io0CtYcbefPCoF6F/oDpzU50oudXcADusTpbrjKmtzjXxpQ4Q/1WgFrNzAklJQDj
 +SzGXEZVLzMDim9CRJAIcjXXyvNxkosWd4pXAvHouzK9GY3puCGwZynXDAELMTv6QoKc43h8j
 G92PiNNxev6+9r+n62fFh9eR2+HmdjNcmYW0Elo3x6Z/vknymSW4ylUlFv2KD5eyrBVpOIxhs
 7nd94q8TvNhEd+KGQlEBKOcQs6ysffvMmkoinXX2zGtQyKNDWKiEroFikRl2re0g+/vqJ77kQ
 0HQzsyUr9ocb8FuLSB2RrpH2pXpesuLBuFJchwUe4BArS52DxHiDF5ky+RHvaFYUXMBtpz/5W
 yUQOFT7ENPsJY4IiMPUxJTLlSv0DQQ2bviXqKg0Qydxh2QulN7zKNG2cJwJxVgSQ4BAo9hxtH
 10gogtHy7ZU/527iSuF4XtPYZCXK9EeX+cyYvVe/kmv4go3KMNYo0HO8ZpSjs0OiHI1YGMeL8
 ru3Kl/7Hh1jHYu8mTCfRq1lm0bS9zimhczifUvuv/tXqjrbvxr4KW/a/0DvZwIvylxRRcEiy0
 KL85/zx4TPMj0NbWTdvOiLxwhz/Xp9iOJBtZd5L4fe+Gn1xBLWpKXAwF5kjp1QhcGkqNRRUj+
 PrlNsqwZ9yyKBs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GWbHRrphQV3Bh8j/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 25, 2022 at 05:00:31PM -0800, Stephen Boyd wrote:
> Quoting Jonathan Neusch=C3=A4fer (2022-02-05 02:36:06)
> > I noticed that the 'table' parameter to clk_register_mux_table is never
> > used for modifying the table elements, and so it can be declared const.
> >=20
> > In version 2 I'm addressing two warnings in the clk-lpc18xx-cgu driver
> > that I previously missed.
>=20
> The format of these patches deeply confused my scripts that use git
> interpret-trailer. I fixed it now, hopefully it keeps working. In the
> future, please don't add more triple dash '---' sections to the patch.
> It looks like those extra sections for the changelog messed everything
> up. Or there's a new bug in interpret-trailers.  Either way,
> interpret-trailers was adding tags after the entire patch contents
> because I think it looks for the last triple dash instead of the first
> triple dash. Not sure why it's done that way. I resorted to
> reconstructing the patch after splitting it with mailinfo.

Hmm, sorry about that.

I've used this format for a while, because it conveniently lets me
keep my remarks in a git commit (rather than a patch file), until I use
git format-patch to generate the final patch file.

I'm not very familiar with git interpret-trailers, but git 2.34.1
doesn't seem to get confused on my patches (or I didn't pass the right
options to cause it to happen).


Jonathan

--GWbHRrphQV3Bh8j/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIaH3sACgkQCDBEmo7z
X9tEmxAAg6PisgpZidLLoo82mF12b0fO+MC4qfoTWHjrtx4lx8uEtEudcstu8uN4
u8CMwvh6ddSkLpAQ/Z6BakRswvdIyzS5/lENKd8qhmoP5nw+3eBMZI7HFMD7mZY5
6HywEIVzSOUXorZdWyRKTvqQt9pNfa8k1sDTpd1KDuFn6FE63lDhkbxtqiOV1m0W
JJC+dP9v2EVJsxpZVsXX0wEhT3WRScqH1JbVtzO0nkB5Zb3cx8hcDB4qyfdUlSMT
uZjn8WGOvk9RsHtlbnRsFRDMrv9ilYPaUnRXbdVuUvIAHmp+eQWEcS2E0EW6WO+M
9KJIafgjGTZZSesadNIkPafeXC2RcH/Ip54ZPTLuxKuNVCE6SjXjrdiRdfBCs5WG
f2a+mY+k65+ZLe67RvlbYQjx/w6sQIJQfdSVFn0NFQC1v6K1DPqwuzXCKnKM8P+m
QwOHDo2mveVLdMWql5+/eAL5dM/vAW5ywhGPspc3hYV2VN6X1NrgR9zHHPfTIfpZ
m8dMwI+8zJ4PrAwR/lfFTk1rqgPoSvH+w1/9TnMIfhUAeMzRRXvBBBVqLHpDaRv8
FKIwmgapLGG8+9WINeR8N0Py44L1I7/kSgFz6nvQ1eC7ghluekXao2V3GUZcyRCq
Vm35ObsxNs3bADTMlDnp/Si+gIgAr+uaLQJw4TkpMUgfsFsqM3c=
=4z9e
-----END PGP SIGNATURE-----

--GWbHRrphQV3Bh8j/--
