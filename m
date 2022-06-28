Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8268955D223
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbiF1KfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbiF1KfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:35:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E1313BE;
        Tue, 28 Jun 2022 03:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8E9CB81DC6;
        Tue, 28 Jun 2022 10:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14493C3411D;
        Tue, 28 Jun 2022 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412505;
        bh=nmAD0wkHPJj75POEBn9llYxTmYYIW9jt0N+pB+TZRr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCuKjyAePOHhaAZuR1nGo64rN/yFJfZuXyujuEeQcmipVVCnq4LwDzmvO5gAov5Js
         ievamH+VFSXlKJuzRUeKZktjFPCwKxt/k/CDRKkmY8u5q3MAqQUp7CWuSXM1U4XHbX
         2zUxEVRTz3lNNXpP1FDgDR0B1KYo0TgixLRbyfiK0gh05hZcM/fx4czGqbIgQZDocW
         KwZVnYNjcr2PfNUT3YxH9aZpAj3e81t5PZsXOySBi/PzrSIPI20g1wxX9f0AaHXPvI
         1qGito6O0MAb+xw32lKEnd6PR4lSVZz5KaXv89Mg+Wgf8m9lmRPrQAdgmnMOoUoWwQ
         L8f75Gs3AOuGA==
Date:   Tue, 28 Jun 2022 11:35:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/22] regulator: fix a kernel-doc warning
Message-ID: <YrrZVDUXzHNtvLNi@sirena.org.uk>
References: <cover.1656409369.git.mchehab@kernel.org>
 <15efc16e878aa327aa2769023bcdf959a795f41d.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6l3VTahVwLIvYoL/"
Content-Disposition: inline
In-Reply-To: <15efc16e878aa327aa2769023bcdf959a795f41d.1656409369.git.mchehab@kernel.org>
X-Cookie: I like your SNOOPY POSTER!!
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6l3VTahVwLIvYoL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 28, 2022 at 10:46:22AM +0100, Mauro Carvalho Chehab wrote:
> document n_ramp_values field at struct regulator_desc, in order
> to solve this warning:

This is patch 18 of a series for which I don't have a cover letter or
anything.  What's the story with dependencies here?

--6l3VTahVwLIvYoL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK62VQACgkQJNaLcl1U
h9D7MAf/TDKw+iaQTVZC0yWj0l7aunVFuGoLANysHVQ0y72uxSOnR29paCHQmsGA
u5p2SUYFsJM0pik355wg9S3uE8S5tWQCsjeYu9UBHab6MR8wB2ePuJuVaHzIVFHc
3WR48A9NsuSpsKaj1OswKQ1xrXlrtebr8wi1sJ9YnfS9WsPV4ZA1f5YnQ2tBncrY
ZAOlULXRQSsnmOVAjxUIOymOs7/AVJVtr7//18YJ4kFOSIsM9tB1xWBY9oVCXMqQ
LqsR57hMckpIttFK54qtiVoHX/vyGyvGbglzdvA/xU84FO+30JkvajYLDTPGuNFE
zzxixyd5RmedfZLFM3I8ZPPLVPJt7g==
=lBOH
-----END PGP SIGNATURE-----

--6l3VTahVwLIvYoL/--
