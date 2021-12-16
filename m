Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C414F47799C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbhLPQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:49:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45534 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhLPQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:49:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70D9C61EBB;
        Thu, 16 Dec 2021 16:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084F6C36AE4;
        Thu, 16 Dec 2021 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639673347;
        bh=1Cn/YaBA1mXDfkWjv49bj322yFYnapcjg344B018UkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKBo/uDHNX4zOxMt+onveypXwa9GFl5ANDl+OHlA43ytPl4lDYMFAv3+/HAcR4zz4
         yePSYt+psIebVP7KeGQvupZL4sVL3/hTRa0zgkmYkhzegu1ICEO3SVVl/z+pjyi0uG
         BZhT0uLNHUG3OezGLCGGFw6Kh0PtcuvsAYNWkCf93RGKPXhnjiD/c3hOSjd8PKbjbG
         K4bpXnY4XhBeuDF2CmCM7DB1TnxtD364e/HlKXFSFHH6VhLDtWVWPQY/BSTFydHJDM
         ETKvk59O5w11yJAKYGQstCpdOWTIxZjWjbszhZx5PitFxpG/wUpVFaOj6MhYSnWlGW
         FdT6rFbUotVEg==
Date:   Thu, 16 Dec 2021 16:49:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: Migrate DA9063 text bindings to YAML
Message-ID: <Ybtt/DEpZfuLmbK4@sirena.org.uk>
References: <20211216164037.2888316-1-alexandre.ghiti@canonical.com>
 <20211216164037.2888316-2-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7UPpL9eSKpRqGuyR"
Content-Disposition: inline
In-Reply-To: <20211216164037.2888316-2-alexandre.ghiti@canonical.com>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7UPpL9eSKpRqGuyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 16, 2021 at 05:40:37PM +0100, Alexandre Ghiti wrote:
> DA9063 devices bindings used text format, so migrate those bindings to YAML
> format before adding any new bindings.

Acked-by: Mark Brown <broonie@kernel.org>

--7UPpL9eSKpRqGuyR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG7bfsACgkQJNaLcl1U
h9AU4wf+NQMl2BzpsI732uzQnsyi7tWtsifci5XFZQKXDbrG+O49GavA7WWKttTs
hfQAcN7IH/OkUlomNNzudjYA4fNXA7ssYYibtMMYl2XHp65Z5oaWUs7pn8HFbek1
iP6Ycb2NL8zGP9AHv0hvnjAOGB0LCPHl1AmjE8KjWtu6sAuHX4rkY5b60SOxfHQw
AKRQ0o10LcHHouIYYbZMfkuZNsKbn1DQCs2bS3ZrrZjoaZ11XirIzZmukL1upU8x
Kiuz4sReSR4XVd9I0RdkJ//XH73bgLKB2/ftU8JQjsGRIViccgNYtOb8Xe2lOGyj
jIlD/BGjBvv/SBwpTRVK9ByivuDYCA==
=ZZh+
-----END PGP SIGNATURE-----

--7UPpL9eSKpRqGuyR--
