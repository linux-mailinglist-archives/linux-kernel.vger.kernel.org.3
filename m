Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3419B486337
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiAFKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:53:02 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:41562 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiAFKxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:53:02 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6DF301C0B79; Thu,  6 Jan 2022 11:53:00 +0100 (CET)
Date:   Thu, 6 Jan 2022 11:52:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, greg@kroah.com,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, satyap@codeaurora.org,
        pheragu@codeaurora.org, rnayak@codeaurora.org,
        sibis@codeaurora.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH V3 7/7] MAINTAINERS: Add maintainer entry for EUD
Message-ID: <20220106105256.GA12925@amd>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
 <e0d3661ea69a5706ea0fec3b4a38c5cd43a2e790.1641288286.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <e0d3661ea69a5706ea0fec3b4a38c5cd43a2e790.1641288286.git.quic_schowdhu@quicinc.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2022-01-04 17:28:20, Souradeep Chowdhury wrote:
> Add the entry for maintainer for EUD driver
> and other associated files.
>=20
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0227e15..54f616a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7018,6 +7018,14 @@ F:	include/trace/events/mdio.h
>  F:	include/uapi/linux/mdio.h
>  F:	include/uapi/linux/mii.h
> =20
> +EUD-QCOM

This should really explain the "EUD" and "QCOM". Something like
EMBEDDED USB DEBUGGER (EUD) ?

Is it Qualcomm specific?

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHWyggACgkQMOfwapXb+vJ8GwCfTnfwSgwHiyf/tWvkDFAcJMcO
7HkAnj+hqivNTTW6rhHz5HGfkRjybo+z
=2GVg
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
