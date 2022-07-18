Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F955780FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiGRLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiGRLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:38:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22A2220E6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658144314; x=1689680314;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n2Q3FcltGHz6CGZ/4h4aB90IlF1pQJ49RqYDZmZ2zhU=;
  b=gLoaVOK2phV1nW6wWvKxWYfNFCUD9rBfqEEaQRG9WvKU1ZPkR1KNeH3J
   Gk/XEuiT5GE+BBmLoR9VUlgWvWII4OGoSKMC97eliNBC5iKLWfO26dGY0
   mMQkufx75eokccp2EOqlmGwqYYeimMoWmp8VLIdPuvFshJvG4XvKtBlTP
   xmPjxrlZD+LrURuhZyKWA7RZGFtpHfirympT9B5GdmhoK403gjC1fAHMA
   AYoUrUbg+7kjKxMqii/5xODoN5hvoQ/AA0Sr3ca95azUR+BRYGgAueRG0
   tJG+8vO1N9KzW+sU6X28BIX9yhEYLeeo3lgZMN+eGQd2pPeph6ckL821/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="350159727"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="350159727"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 04:38:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="624692261"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO maurocar-mobl2) ([10.249.35.85])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 04:38:31 -0700
Date:   Mon, 18 Jul 2022 13:38:28 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v2 24/39] drm/i915: dvo_sil164.c: use SPDX
 header
Message-ID: <20220718133817.058b8b43@maurocar-mobl2>
In-Reply-To: <f6ab40860cd4f8079e6e169c7d6465f211b8dbd3.camel@perches.com>
References: <cover.1657699522.git.mchehab@kernel.org>
        <002a8d51244a70572744de86cacbdae293e7d503.1657699522.git.mchehab@kernel.org>
        <YtHdp6ju3IfjF8Bq@intel.com>
        <f6ab40860cd4f8079e6e169c7d6465f211b8dbd3.camel@perches.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 15:16:05 -0700
Joe Perches <joe@perches.com> wrote:

> On Fri, 2022-07-15 at 17:35 -0400, Rodrigo Vivi wrote:
> > On Wed, Jul 13, 2022 at 09:12:12AM +0100, Mauro Carvalho Chehab wrote: =
=20
> > > This file is licensed with MIT license.	Change its license text
> > > to use SPDX.
> > >=20
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org> =20
> >=20
> > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com> =20
>=20
> Not exactly the MIT license as it's missing "or copyright holders"

Text is not identical, but the license is... see below:

> >  =20
> > > ---
> > >=20
> > > To avoid mailbombing on a large number of people, only mailing lists =
were C/C on the cover.
> > > See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522=
.git.mchehab@kernel.org/
> > >=20
> > >  drivers/gpu/drm/i915/display/dvo_sil164.c | 32 +++++----------------=
--
> > >  1 file changed, 6 insertions(+), 26 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/i915/display/dvo_sil164.c b/drivers/gpu/=
drm/i915/display/dvo_sil164.c
> > > index 0dfa0a0209ff..12974f7c9dc1 100644
> > > --- a/drivers/gpu/drm/i915/display/dvo_sil164.c
> > > +++ b/drivers/gpu/drm/i915/display/dvo_sil164.c
> > > @@ -1,30 +1,10 @@
> > > -/*******************************************************************=
*******
> > > +// SPDX-License-Identifier: MIT
> > > =20
> > > -Copyright =C2=A9 2006 Dave Airlie
> > > -
> > > -All Rights Reserved.
> > > -
> > > -Permission is hereby granted, free of charge, to any person obtainin=
g a
> > > -copy of this software and associated documentation files (the
> > > -"Software"), to deal in the Software without restriction, including
> > > -without limitation the rights to use, copy, modify, merge, publish,
> > > -distribute, sub license, and/or sell copies of the Software, and to
> > > -permit persons to whom the Software is furnished to do so, subject to
> > > -the following conditions:
> > > -
> > > -The above copyright notice and this permission notice (including the
> > > -next paragraph) shall be included in all copies or substantial porti=
ons
> > > -of the Software.

The license itself is here. It is standard MIT license. The original
text for the above paragraph is clearer about that:

	"The above copyright notice and this permission notice shall be included in
	 all copies or substantial portions of the Software."

The "next paragraph", mentioned on this variant:

> > > -
> > > -THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPR=
ESS
> > > -OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > > -MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEME=
NT.
> > > -IN NO EVENT SHALL THE AUTHOR =20
>=20
> Missing "Authors or copyright holders"

Is actually a disclaimer's note, and not the license itself, informing that
there's no warranties provide by author(s).=20

With SPDX, this will point to LICENSES/preferred/MIT with has a paragraph
that fits to the same purpose: it excludes any express or implied
warranties.

Btw, the Kernel itself had this at COPYING by the time this was added
and before SPDX, which was there when this code was added. This is
part of the GPL text:

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

So, I can't see any changes here: with or without this patch, there's
no warranties from the ones that wrote the code - nor for any
copyright holders - as the Kernel as a hole is released under GPL.

Also, LICENSES/preferred/MIT define that MIT license text is:

	MIT License
=09
	Copyright (c) <year> <copyright holders>

In this specific case, "Copyright =C2=A9 2006 Dave Airlie", which is both
the author and the copyright holder that is part of MIT, so the text=20
meaning is identical with either "AUTHOR" or "AUTHORS OR COPYRIGHT=20
HOLDERS" is used.

So, I can't see any difference from legal standpoint.

Regards,
Mauro
