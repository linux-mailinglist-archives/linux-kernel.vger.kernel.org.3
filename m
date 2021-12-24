Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E647EF1C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbhLXNTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:19:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40826 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhLXNTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:19:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B242862043;
        Fri, 24 Dec 2021 13:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF53C36AE5;
        Fri, 24 Dec 2021 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640351985;
        bh=RRC0/259fcqHbTn1tWwd3RXhY57VSROcl0lc6qKKWdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEJ8KMwBUMwKQVwvE8D34Otw7cDN5W5yRIX4/F/mJXKzKsHAlFf2b/ujW+9dkkq9m
         nvwlgHv29Gs1iv1gzJHkweZW3DN3N6qgfMmviBXMCEDKw0Dq52WZHYiyAKffwqoBb8
         qG0kyPcnBpujUGB+4SC5+LJvN+/+bNqtuV16aaWYfkZzf/b/i0VVr51Dpi5ZGQt9Jy
         oIshsV73npxECqQXUFaT1DRB46FwXtTWvK6Sn4e1yKxWcEn4imNsszFopXtZFNJrm2
         pkjABeo5XycsVYISnnjbIQZK+DajbUAnL+DPZUJ7/YOTykmQJW+MQNSMFJfVlRRg46
         wwoSQXY6bt+ng==
Date:   Fri, 24 Dec 2021 13:19:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v6 5/9] regmap: Introduces regmap lock helpers
Message-ID: <YcXI73GKNdx/gvUb@sirena.org.uk>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-6-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mlX9XU0JAkRu6gCR"
Content-Disposition: inline
In-Reply-To: <20211224041352.29405-6-quan@os.amperecomputing.com>
X-Cookie: I brake for chezlogs!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mlX9XU0JAkRu6gCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 24, 2021 at 11:13:48AM +0700, Quan Nguyen wrote:
> This commit introduces regmap_acquire/release_lock() functions and makes
> them available for drivers that need atomic access of regmap registers

You've not explained what something would need this for and how
it's expected to work - we don't provide unlocked access to the
regmap to client drivers so I don't see how one could safely use
this.  It's unclear to me what this would mean or why it's not
better implemented in the client driver.

--mlX9XU0JAkRu6gCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHFyO4ACgkQJNaLcl1U
h9DaeAf+LrT+e8nVJuT7C0PxLOgU/FymUBhAX0UdyOknH3zdIG0c7DcvOXau1O1x
Kld90ZKSql9M73A3NpWy7ZnamQwLSd+7ik25B9lSL6lY7yRK7Or2N5YL0yWWg9Tl
fJq5v7gTLRLHk5DYQaO7OGXpW5GHKuE4VB7u2aoiWGH1/ovF1odyGVRhbFz6Yn2c
8PaAz4+ja4FDk77vird8NbSpHWOTFVPJg1hq9Kl1ru/ylihcqcNQOlYdubCxLudc
LZSmGUv3WYRRq6ruyjGgQblUkYdlakLVTk8lNi5LaJamD2gKBqPOi1Q1NvPGrhZi
JIMOd8EICA6jR9Hj+s1SIxK4RJNPDQ==
=Dgc1
-----END PGP SIGNATURE-----

--mlX9XU0JAkRu6gCR--
