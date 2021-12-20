Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4321447AA10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhLTNBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:01:20 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52298 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhLTNBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:01:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 163F2CE102B;
        Mon, 20 Dec 2021 13:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C11C36AE7;
        Mon, 20 Dec 2021 13:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640005275;
        bh=REUKzYvTnWFtSseRl3TT7ssf0DMkQQjLPLGHo24Iw9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AasdkjnnNJsF6oJgAWJT46rCcWhebElwpln7Xpf1P6NArnvIcFfIbpOGhC7lMsx4W
         UsDtDACQOU78EolMCL/awrtb+O7ENvyEU7TnKFn3/UT94i7PufoeQCE/b18F3XyAHz
         Y7eNUT4qNIGc65ebCagifqHyLXBQcCSPmjLpsUIhSsn/4SvvPbbsGDCuHR5zR/nOEL
         /txjGN7JclFRQkedc7znxNTw9U0nsK3JyyfkNhYrKGvj/lUyuBW+Q7qKAF71bwQm8y
         624/nIfXaukjrN8wceJstgK54zySU15CPhXC7B3fKNOzkc9/UmpaSwjUTQFFXJT/5G
         5b8xH68R8hG6w==
Date:   Mon, 20 Dec 2021 13:01:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/10] ACPI / scan: Create platform device for
 CLSA0100 and CSC3551 ACPI nodes
Message-ID: <YcB+lUePGlo1S9tX@sirena.org.uk>
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
 <20211217115708.882525-9-tanureal@opensource.cirrus.com>
 <CAJZ5v0jTELqFeO6q6w_mYNo_yf1R9SX66RrEz0ZSe27w7E6kog@mail.gmail.com>
 <4b5506b1-20c6-3983-d541-86dc2388b2a7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9/Pqt07Ueb9aNBfT"
Content-Disposition: inline
In-Reply-To: <4b5506b1-20c6-3983-d541-86dc2388b2a7@redhat.com>
X-Cookie: Christ was born in 4 B.C.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9/Pqt07Ueb9aNBfT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 07:26:51PM +0100, Hans de Goede wrote:

> This is fine with me, but I wonder if it would not be better
> to keep it under drivers/platform/x86 ? Since the new SPI
> use-cases are also all on x86 laptops AFAICT.

Someone's going to end up using it for one of the Arm devices with ACPI,
*especially* if it's put in drivers/platform/x86.

--9/Pqt07Ueb9aNBfT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHAfpQACgkQJNaLcl1U
h9Ac8wf9FmAjh+2RRFMNCcPoRlzeJvaGXlVOENLgOET0tUOx6vtKf/bBmdZ04Jfn
/EnxgiVJOnHRjALACEva0AvgeooyLzMROopnthAcw6fbR0t4mWTruzNn8uawTUU7
Jdz52ctPsB3q0kLrYCvCMI3qvmUFUcN+0iyDhMlP5yxSBEJadzdlMYDtywlfoO3e
URO0st0GO/Vmhlp/EqEiwbEnp48KbSi/YvSbYMGeSemQ+PU6t43NikAV80DWAZgt
2kbHYXZEOV/HA2qPrtGRalL2CqpriYMbeF4lm1zml+DliGSVBYIVKOryZfz1cX0v
JP7EXWfEgcaclQFKDq4295OGuW0K/A==
=QTdH
-----END PGP SIGNATURE-----

--9/Pqt07Ueb9aNBfT--
