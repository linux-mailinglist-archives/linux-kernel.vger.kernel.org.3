Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94334D2ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiCIMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiCIMN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:13:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6ED2FFCA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:12:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EEB6B81FE8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5137BC340E8;
        Wed,  9 Mar 2022 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646827971;
        bh=HQtUh5F+3Pud/JJ6YLhmkIUGJhE7yFbx4GD9vgSBFwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4a4XqtuwDJM076l2/hG2lboDE9MUfk9TC1l5WgleXDqzjvNYxsSt2MCWCpESIaK8
         Odlfv39dSnu5Hh/yJdYeoEkjAgV29phD20ZhFexkUXDX+lLwzBBxHF6PZImQpvMS9z
         Dj8vhiQ0K19J7kmclLZENZsVj3xelyXwx1ZuBgz25paW2E5WL0oFdM+QZ+mRWJuzOG
         vubUujc5vfI7cRSJtDWNgM9x6RFaj0B2Zncpiywf1Vx155uYdiPscpTej6XhwQc03u
         zbQP7UukPveegzZi/fANjonV+vZ88Nt0WyQZL6ACORGkNy44V/d4IMRjOzwsKlhhNr
         lLOEPEXN+FijA==
Date:   Wed, 9 Mar 2022 12:12:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas5805m: fix pdn polarity
Message-ID: <YiiZv7Fc8a4O1nYR@sirena.org.uk>
References: <20220309104104.3605112-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ba1YCjGxAge/4h5/"
Content-Disposition: inline
In-Reply-To: <20220309104104.3605112-1-john@metanate.com>
X-Cookie: You will inherit millions of dollars.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ba1YCjGxAge/4h5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 09, 2022 at 10:41:04AM +0000, John Keeping wrote:

> Fixes: ec45268467f4 ("ASoC: add support for TAS5805M digital amplifier")

Please don't insert fixes tags unless you're actually fixing a bug,
stylistic improvements like this - people try to use the tag for
backporting bug fixes and so on so extra tags create noise for them.

--Ba1YCjGxAge/4h5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIomb4ACgkQJNaLcl1U
h9A0sgf7BAc7mpPh6cd6TuUWK6w07kKjeD9dDKEN7YQPDl8/DoGFHQa187x3NEzx
7isd/LtzDtFbxqxCJZ9fInOYWk30hNQa9PwjO91UhWbHLUTdUABh1cRzH72vHw3t
sIkVA0MoX7kuA0gRooWOTWYDH5sVN3c2KaO8tGDVtqoXZBnNm55aCmyGu9ESyaOL
cOqCsfdGUWMVuuR5n6c1oQpX4U2GXfZ2711hoWxAzt6aPeVCYY5HZs4kKUAHUEAH
6kxn8ZdLQoi8zu4b4FXd8TA5KZVcWB7hsptsvxeOZR/25uU+tnmdS4hEpcSspZyq
piirNBAh25ogtsX9Urp4S42XgrHSrQ==
=cmOh
-----END PGP SIGNATURE-----

--Ba1YCjGxAge/4h5/--
