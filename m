Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52FA49E913
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiA0Rcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbiA0Rcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:32:39 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C7C061714;
        Thu, 27 Jan 2022 09:32:38 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ka4so7324335ejc.11;
        Thu, 27 Jan 2022 09:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2lCGLXs6YGQp3h15Eb0z7/QVdPNp8XuhGNbjNFCQzRA=;
        b=FlQ1YC1txpdVN6jJbO/LQ//5Yf7GCMlDVlyOB2eJMDDTB1xyE8Vod5TaHr2SB9pAZQ
         FeTyzJPEXEAtPVsE3hrAX+aFZFLndEUyxVHy/unSaGN6QXX/TDAXAGWoaQGdk9LU57r1
         GjlS0R5tQtCqMhZ9bhHkGlbiI7f/AcL6uU0emMoXofbyAR2/Y8jHss5FWvN8oL/lIome
         XmSRWJDmqm2qbR22vIXwtfHG9o1iuo3ox0g+ONEMlsAQSmM4mNFa2AiGxXnpUeh31XHs
         hG9o/OuT70v4xSCa9Klx9VjcgP5chKi3FdRjedh/I/ZcPWB17562/OGi3vC/SJcFMkJC
         nBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lCGLXs6YGQp3h15Eb0z7/QVdPNp8XuhGNbjNFCQzRA=;
        b=5nWmyFRYuEa9ldFPHKT1GffSbQUs/ai+c1NOgtg+9ayseOQuOPCIG/7aIN3Apk0GGE
         Xgg5ieT+5MdXkYs/dopuGwxxCsqiEpKV34zMZUXoe0Vt/Bn1dNsrB6nNyywKzOlLm9AL
         GNNdySgMlVKI/rMo03vsliXWJlOEt+HbZaSJgkkJnIoNRTI7gqAAnzhH8DxfpYF9UcUY
         b2Id6nrvljfhlgzW0T2/a4duptWfiLI4D0FtMmQoPDSgVM3LfwTc02EZwHBx55JWTvIO
         MPcWiAQepSb4w85g7CEK2veSl7y64XktExoGorE+j3F/mubJTwsci3ySkSxnrILf8vpn
         LOSg==
X-Gm-Message-State: AOAM5328/hyDFELNrlc3hqcagzRbtnXXFfA2BAf7AkwbAyJWTmbrDHmJ
        HDZNWssQqnOPJV1gPYE7FtsJSE55QNCGZw==
X-Google-Smtp-Source: ABdhPJwUN/Bq7wyaQglPGxU5Ss4bf2Iqr3zY+U9Rq85JCgnpexPqBxOMZIgtVqPrhdDTmDnc25rBrg==
X-Received: by 2002:a17:907:1614:: with SMTP id hb20mr3662222ejc.255.1643304757253;
        Thu, 27 Jan 2022 09:32:37 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id kw5sm1472188ejc.140.2022.01.27.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:32:35 -0800 (PST)
Date:   Thu, 27 Jan 2022 18:32:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sameer Pujar <spujar@nvidia.com>, jonathanh@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: tegra-bpmp: Restore Handle errors in BPMP response
Message-ID: <YfLXMVXTgN9lZAA6@orome>
References: <1641995806-15245-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lFSd7VNl4nEuksga"
Content-Disposition: inline
In-Reply-To: <1641995806-15245-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lFSd7VNl4nEuksga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2022 at 07:26:46PM +0530, Sameer Pujar wrote:
> This reverts following commit 69125b4b9440 ("reset: tegra-bpmp: Revert
> Handle errors in BPMP response").
>=20
> The Tegra194 HDA reset failure is fixed by commit d278dc9151a0 ("ALSA:
> hda/tegra: Fix Tegra194 HDA reset failure"). The temporary revert of
> original commit c045ceb5a145 ("reset: tegra-bpmp: Handle errors in BPMP
> response") can be removed now.
>=20
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  drivers/reset/tegra/reset-bpmp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Hi Philipp,

the commit that fixed the HDA reset failure was merged into v5.17-rc1,
so this can safely be applied as a fix for v5.17. At the same time the
existing bug is fairly harmless, so deferring this to v5.18 would also
be fine.

Acked-by: Thierry Reding <treding@nvidia.com>

--lFSd7VNl4nEuksga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmHy1y8ACgkQ3SOs138+
s6HU+g/8DQ4NAOdFDNmf1ft03thYqebvUH/l5hm+2YyzCHU2p0NCxlf4cfe6/jyV
7ssvooV4zsyt8Pq3vj1tcelNRTHrHVYrURWaRveqyw/Hz2VbCqO+daStarv5Wafg
E05P0XEgPs1L1YyvT6BQRcSt+z1XTwMZYAoPRO1iL4bMD27rRwpEfmnSIyga1T46
y4kuNiGFZN7XkBjlZcoSiefW51/anKAWI/elh99eNDQquW7J4h37CSDI2wbGQYbf
S2lUhN0nSwmbOYiW9Q7A4vcKwfVgeWeVKpWRgzH9rKBMu9G/Zymla06yasZ/MYDk
CFKTlqNGnXYfsPeJjfu/2K+3eHhw7sGvVXOkZuQNrrd4s5vEWh4jxIcD2JrpceCQ
EuhZIRz4mgjPUuGALyLHtgDpNaCtuGLFCtbLTCcGnjgjLH1p9z20/NoO6iXtBmRj
kHn2sUM08BnneBqtj63vYUXtPKhaQApwkHEjNUgfh/mMzBfODnXS0lmEYYpND8sT
EG2gSdbqo4CcT9aro+/nn/uAvP/w/ZYVkLR7G/Z/UpzM46D9bNMVcsBdYR5/QA+G
0mS1FhX/BHgogbtlCkGXJtQN60DlKXZy2sh06WPBSTGD9Vd2HvGiNhMn/0bwltHN
/8rL9DPFfvRElTTY8DShRNSvXf0JT8Mbu/1RH3JYGvylwsx0aj4=
=FmYd
-----END PGP SIGNATURE-----

--lFSd7VNl4nEuksga--
