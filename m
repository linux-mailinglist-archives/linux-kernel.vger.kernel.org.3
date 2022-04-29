Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F8A514A59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359739AbiD2NXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359731AbiD2NXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02F8C8485;
        Fri, 29 Apr 2022 06:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2093862287;
        Fri, 29 Apr 2022 13:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB19C385AC;
        Fri, 29 Apr 2022 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651238389;
        bh=19u80WrRYBrn0euhR5t2IahZXsXYVRXAnPVdCH6q/OA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzp9dNrw1fq7kaRwzsuipBWIEcIQrGCJXYGUQ+EJvcUn1wqUYdAMvlbx+LuUGhAKn
         8xd69n0H8JX0CPgb6WjcW1q7XAfUofjuWy9WQ+fQO4NnJ5mRBJAAknOmVRLDPzOHCS
         OS+7RFvMnFVE+xOeV77jBorf1wah47euXafGH6skPCZhCuZrgiFz/g+Lbv5N9ZTIMu
         b5T8hbIzNmL26tDus1GewZO5h9kWYbB+tHrfcBxxkKFQIM3IS7wJgdMb+XHDJ/Xvn2
         3jABx64hHlDYm6X8MbIoOTloGjf005gkwoSMRILhEkLYoCmCClXJdky2dowXC2lUUk
         AT0KiiAs5SSzg==
Date:   Fri, 29 Apr 2022 14:19:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     YC Hung <yc.hung@mediatek.com>, Rob Herring <robh@kernel.org>,
        robh+dt@kernel.org, daniel.baluta@nxp.com, trevor.wu@mediatek.com,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, cezary.rojewski@intel.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com
Subject: Re: [PATCH v4] dt-bindings: dsp: mediatek: add mt8195 dsp document
Message-ID: <Ymvl7x9NTJor/vfx@sirena.org.uk>
References: <20220106064847.15588-1-yc.hung@mediatek.com>
 <Yd4yNkeGlzdULNlv@robh.at.kernel.org>
 <68895a40-559b-13ce-d433-f9b32c648323@gmail.com>
 <9965188904de2e89bc5390fa6c71d9fb243f9d12.camel@mediatek.com>
 <cf9b425e-84ff-af12-72a7-4056b8cbf90d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qbtHrth/VF0HNcN8"
Content-Disposition: inline
In-Reply-To: <cf9b425e-84ff-af12-72a7-4056b8cbf90d@gmail.com>
X-Cookie: Are you still an ALCOHOLIC?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qbtHrth/VF0HNcN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 29, 2022 at 02:57:12PM +0200, Matthias Brugger wrote:
> On 29/04/2022 07:59, YC Hung wrote:

> > Sorry I miss this mail.
> > Could you please help to check this patch? Thanks.

> Rob gave his reviewed-by. I just saw that the driver maintainer is Mark, so
> I expect him to take the patch through his tree. Didn't realized this
> beforehand.

TBH I'd missed this since there was nothing in the subject line that
drew my attention to it.  Seen it now though.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--qbtHrth/VF0HNcN8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJr5e4ACgkQJNaLcl1U
h9B6jQf/dW9MqjjZQdTkinE+KFUJIRcK4SQ+e5QvdyqXMZ17f40lR3vhJ4Xo1NME
uNZx34lYDN8jy1PAvJa8HlyqyL0nVzOuxN7qjRuMr/uBlg/qhLEYFUcaxZXXc/wR
aGaaF3csCsN0+n/CMwkWP/my21AyyzhXfu8ygvhEVqhdJhetwOtYNfOB/aIHOId7
oszASoq1Jvbpvz7CRKq/Vqqk8O9ASXDpvSERh6iWSkWH4ShJMteoAipC4MndSgSI
rc0LLIZ2+wq+MAdE5KoqccPfGnx2UsJ9+6MzcYc7SbpRx/LirYjr5THGGkLWS/m3
kqvXdGrUS8RZNjj07qJ/cqGj8a/mOw==
=Hfdr
-----END PGP SIGNATURE-----

--qbtHrth/VF0HNcN8--
