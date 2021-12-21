Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8235A47C3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbhLUQl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbhLUQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:41:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A73C061574;
        Tue, 21 Dec 2021 08:41:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 318EFB817B6;
        Tue, 21 Dec 2021 16:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0594C36AE8;
        Tue, 21 Dec 2021 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640104883;
        bh=JA2XthLwZ7lLTOnJ+u7LAbaKjOnIJFmoqSmlZzwHHlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjeCYWWYUNUV56UhX22pxyu2UjhqvrVBGsj8Lv7/lFRD8kvXCkCkzaQC0IsagL+l9
         JNhqDVeFQwmi4AA2l80xBU8PX9Mp2kk756E4QSAW1NvQvrQsHxYWvTKAtbnfWWRkp1
         ZwJow86sZOvuYF5K9tuigA8iveFUZ6yewjFlUKrTict5pY4uUlX00FzhhhwTMwwclf
         ufKQuXlhk7tJwkJwgX9SgHeM/0VsI2OZlyzZauTJ5WZiuVAUvVXWyvKJdotlvDau6f
         UVjeRf70evnnxtGOFK84WVfbb5rXEEd48R72JBxFHx4CzGUf8v8CWzL++/LMqq9SIq
         HgPZAMbtm1hkw==
Date:   Tue, 21 Dec 2021 16:41:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: sound: tegra-audio-rt5677: Correct
 example
Message-ID: <YcIDrlhopQXFomzU@sirena.org.uk>
References: <20211216160229.17049-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uyGpmtvI5umEZmqU"
Content-Disposition: inline
In-Reply-To: <20211216160229.17049-1-digetx@gmail.com>
X-Cookie: knowledge, n.:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uyGpmtvI5umEZmqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 16, 2021 at 07:02:29PM +0300, Dmitry Osipenko wrote:
> Remove non-existent properties from the example of the binding. These
> properties were borrower from the old txt binding, but they were never

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--uyGpmtvI5umEZmqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHCA64ACgkQJNaLcl1U
h9CskQf9H4IdMGrIuSb7/r9gEvwcPTaKSI9wGbd6jzbFPU/4byXuCujCjWN+VY/8
giajs0QgQLeo8IcBryD9h7EeIre7nA5IDQhVKwGLb2tJV88HgXUzsel9lJcJnPOQ
q8apMEzFQxM1VE9kba+yYAWOR3XBFJMrRrHNq/G/ObN2X/dajoK8M9IZkdQHtbmc
pkyo4xPwi7iaUzkGhArqtrVH8wDb0LH950HtoOkK26rI78aKtyTJ1XqBru44Hpf9
lYKzRRY8ijsadMcsKmSkjlU9KvDqJLEF0dx7DaafGh6Dx7VHw96QvEbyxTedIvoH
5jysj9q0P+uvc7XmPppYHUUhJ2ZJrg==
=67kT
-----END PGP SIGNATURE-----

--uyGpmtvI5umEZmqU--
