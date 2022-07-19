Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25CF57A486
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiGSRES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiGSREQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:04:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FC858849
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FF58B81B10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DDBC341CA;
        Tue, 19 Jul 2022 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658250253;
        bh=PZHPDa5XtVXQXEAePGLLEMeuPDPYqXznACxOWUvT01g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uo9WUzf5Ibr3tX6tGTqALrfBCcUETGSZClliGw1IxrabjfHjqyVS383UE+6wuMydp
         R/mAJJ4CKQ7JPCEjW4FxZmJ29LWNcetzUjSAwhWzRbF8+fGtyEvYUyclYH6rKjcifU
         /sDhN29hhx2KNW9fLNmzXgsH750idd/teXNjmmL6weaVVSBWjX+xQMMvjuhetjk5/a
         rjduDv3a/IInXcITNVheg6g/3VNEJkjhQZmqxewb8RBklgpT7Dpb2mgAXWQYDaRnP8
         HcCDDgcrVjbnvqOV4KJgzv2Ce6dAlQKHX+9hMKmIUvyyz0yH3U5qSdzvvPLDNv+0N7
         qSiftihRZqJyA==
Date:   Tue, 19 Jul 2022 18:04:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: Re: [PATCH 3/5] regulator: max597x: Add support for max597x regulator
Message-ID: <YtbkCJQCXEiB7wlM@sirena.org.uk>
References: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
 <20220705122244.472894-4-Naresh.Solanki@9elements.com>
 <c03fd83f-97b3-1837-b7fd-5f3f28c4b557@gmail.com>
 <CABqG17gL=7TJHNowpM8OJD4Pmezp5iVmAKx4csmakrTpp5bUkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q1JkEfkimDiBsz4p"
Content-Disposition: inline
In-Reply-To: <CABqG17gL=7TJHNowpM8OJD4Pmezp5iVmAKx4csmakrTpp5bUkA@mail.gmail.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q1JkEfkimDiBsz4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2022 at 09:29:15PM +0530, Naresh Solanki wrote:
> > I like the way the IRQ helpers have been used here. It'd be cool to hear
> > how the rest of the system you're dealing with utilize the WARN level
> > events :)

> Userspace applications would receive sysfs notify for these events in realtime
> (there is another patch that enables sysfs notify on regulator events)
> This will enable taking necessary action if the regulator is not in good state.

Right, the question is more what the action that might be taken is.

--q1JkEfkimDiBsz4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLW5AcACgkQJNaLcl1U
h9Ah3AgAg69/IVIOOF8vVWEoRVJYKFDH5m3bC+Ae46QkX5haS3UOcXMEN0hXr0Of
snKR5NOW6owHGOfyFAny70ju0b+F6fwixEFf13fnd8ZhqMvcnuM/cRoMZtLCXn3P
rsFt7Dl8D/F9km0MENsjZy8ITf1vXwNDp7qX6ZNL5hTx7Dy63H4GKLvc7w4t9ptB
+vSOaZVLb27rlVXvXVmdgGCx2mX9pdkvmnApZKP++TL2wQML+3e3AcE/hTQdcPf9
fAdgq0C93uONpYY70b5jIK3RfpcYxjRJsAtRxBZpWLguG3cdoyRWTHGWMJmWpgVP
VhucvRgjQ63+OhXTFl4wC60CHm4X6Q==
=tYLa
-----END PGP SIGNATURE-----

--q1JkEfkimDiBsz4p--
