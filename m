Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B261B4696EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244388AbhLFN15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:27:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41062 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242221AbhLFN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:27:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04345B810AC;
        Mon,  6 Dec 2021 13:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE5DC341C2;
        Mon,  6 Dec 2021 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638797065;
        bh=INWxeJPzZWwdQTIDT2IG0S33Gqu4JoJxLJTG54b+hf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPYv5BwzVD2mTs8JHPg9LiOB0oKq3DkAzLhTeg6SHkW0nIkcbsPKTaMx0dicrBzwk
         C+sxtkjZcwjEHnTdjfjxNSeciOTryhsqpwPe7KrmhgAAN7KZ5S/+4dJZow5AoOCg2s
         cGTPeyH65nf9srgwBI7D16Osxpp84tfzzVL2qJFNB1wOGdmYrKJ9Kd7t5IzQ3Bou8z
         i5fM60P8XJV1MHboLkz/SccnO3bzO5UTl4XO9MUOwk0XGC9uxRh6mwPV4NmXPVLFWr
         YNiQxgTGdtNMApBz95e5SXqIwiGlKzOlCKD1OUKJxUNQ16EMnAN28mcNM/XxTJ689K
         TCtAtxirfP2aQ==
Date:   Mon, 6 Dec 2021 13:24:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yanteng Si <siyanteng01@gmail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org, corbet@lwn.net,
        chenhuacai@kernel.org, linux-doc@vger.kernel.org,
        Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH] regulato: remove unnecessary indentation from driver.h's
 comments
Message-ID: <Ya4PBDWwnZ89/xqO@sirena.org.uk>
References: <20211205131503.4122955-1-siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lill0gYgTsNPZBWf"
Content-Disposition: inline
In-Reply-To: <20211205131503.4122955-1-siyanteng@loongson.cn>
X-Cookie: You will soon forget this.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Lill0gYgTsNPZBWf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 05, 2021 at 09:15:03PM +0800, Yanteng Si wrote:

>   *	REGULATOR_SEVERITY_PROT should automatically shut down the regulator(s).
>   *	REGULATOR_SEVERITY_ERR should indicate that over-current situation is
> - *		caused by an unrecoverable error but HW does not perform
> - *		automatic shut down.
> - *	REGULATOR_SEVERITY_WARN should indicate situation where hardware is
> - *		still believed to not be damaged but that a board sepcific
> - *		recovery action is needed. If lim_uA is 0 the limit should not
> - *		be changed but the detection should just be enabled/disabled as
> - *		is requested.
> + *	caused by an unrecoverable error but HW does not perform automatic shut
> + *	down.
> + *	REGULATOR_SEVERITY_WARN should indicate situation where hardware is still

This is obviously making things worse - it's creating inconsistent
indentation within the list.

--Lill0gYgTsNPZBWf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuDwMACgkQJNaLcl1U
h9Dyswf/cRx93KrtSfajokT5jGSu0oBZYQyi1Ji7WQsYd7z+8Whaepi/Im5tDIHE
AePT6gmNo29tXekEcxSOjWHKxrvv+NffkhO739QKQM7Hztq1+8UeI9s1ZHs5wowp
/8L/ubqZi5i6CsFFgjr5w8s77lDIoYFbkQ9W58EE27xADmLs/8RLL1UlKVFwX35M
CvY6fDlwu9Zw/Hsp9lDFQdT2OnM0V419YvAi81+pHNt0JEVhKPzWaBFtz51nK9YA
wsVE7A/ORU0PPqxDkbE0xSWGVQ33aZnscedjKjzSj9RzfPxROAFd9vsQcm0HsVaw
GuUdtHr4oYPab8WNQbPb5lGiKp7Ifw==
=4sYw
-----END PGP SIGNATURE-----

--Lill0gYgTsNPZBWf--
