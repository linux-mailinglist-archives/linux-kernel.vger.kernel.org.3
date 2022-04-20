Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD6508D28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380523AbiDTQ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376497AbiDTQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:26:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902E83DA46
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32EEC619E4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2886CC385A1;
        Wed, 20 Apr 2022 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650471811;
        bh=SBnyZwALtyPYeKnG3vPDUEjUDcPRsFRW6H4/3UQsehI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjtEy44tAZJMG/MPWmRPct3HexSkYWqmoasVTFPZ0uDJo4SfOND2yhrgLZrbiom4E
         mAGZAKGNCF60K4HILY+oQR1dyXxr4n/3mH3rfA7VOBsYl1mujCzegSxvutbkcuH0dU
         zGS9YqNNGBQkE9j9glelr4mQpowsUk1hD//UDzaPtn3AFPs7VNGhbJGgT2gudlmy+7
         hxEq/KBeXcuts/XtmA3+D1MCzJXMMxaAxoC1ClyIv2nlOfmZ8V4JP1HJJR51dvjDl/
         vmkVJsVvyG5oY7wufmwSGblpizL0tpauqJBzYmyq5iNkjO4pWNOYYSZZoZunBmFrF2
         UOFmw635NmDog==
Date:   Wed, 20 Apr 2022 17:23:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        cgel.zte@gmail.com, Zeal Robot <zealci@zte.com.cn>,
        lgirdwood@gmail.com, Minghao Chi <chi.minghao@zte.com.cn>,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH] ASoC: SOF: using pm_runtime_resume_and_get to simplify
 the code
Message-ID: <YmAzfTlr9VauoyLu@sirena.org.uk>
References: <20220420030315.2575691-1-chi.minghao@zte.com.cn>
 <78c7edc3-f431-9735-238d-9aa2b45ec45e@linux.intel.com>
 <YmAljQjpLCoBv+nj@sirena.org.uk>
 <2572220e-57d0-4f10-1695-bfeab54de38d@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pPSA/PyGUaMRPFlK"
Content-Disposition: inline
In-Reply-To: <2572220e-57d0-4f10-1695-bfeab54de38d@linux.intel.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pPSA/PyGUaMRPFlK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2022 at 11:11:03AM -0500, Pierre-Louis Bossart wrote:

> ok, I'll send follow-up patches for the remaining code.

Thanks, like you say there's a lot to get through here!

--pPSA/PyGUaMRPFlK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJgM3wACgkQJNaLcl1U
h9CQJgf/fmHmEvmSkw+o5cwa89eqRnsRjl0W9UEoY268KcH7oP1YF3/DZCS5KkLi
fkv2zMjTMNU96KRgcX7T0LQ1nqatX4hkWZXfYmTfPTT03sVzJ1q9FXT4IEERV587
Y+R0wsTgHWV2e4/n3GNsYcq3dgfeDt1c2LrcLnhpClO8SMTl0Qjdv2ci0NCBdmqe
ISS9aCBtP2e2zAu8MOqwFBR0BVwaPu8euKJiVtpu7y6cXuh3awKaqOQYnGCUm/dD
cqYtMnQwLh3WzAoyKUrK5Pohu/AtQBkssGiS/n3c9JMjU7utg/K5x2+t2tZrBh88
fvVmR2Mo8H18gUzxmZ6rybDj0TM1BA==
=XETb
-----END PGP SIGNATURE-----

--pPSA/PyGUaMRPFlK--
