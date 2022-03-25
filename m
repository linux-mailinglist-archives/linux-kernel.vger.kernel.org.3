Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6814E79BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbiCYRQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiCYRQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:16:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E93E72AA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF4CB61A9D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9F3C2BBE4;
        Fri, 25 Mar 2022 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648228485;
        bh=sIUMKnGt0Oc3vXoWstY5PCIQUuyykpTlBcByYVqY0AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QX/CO/bxhuYiRf0fl5GFzY96i+4tmdy9ELfRPlNtGeuioJJnYYaHpvVOCSj15ma/6
         +00Lezzf18Obfb/b94opkB3XCYEvt92DGagWakVhus/jkXTBZ1FgpEOfXUZYDUVEmh
         9wPeFhuWQFxlld37jkMa3BYOEK1UCtQlPc1GRMGz4iLUyvRFduiROVet1dTjFJaUFo
         iIN7+fqPF0z++ZdBMrLflQ/QItrPtsEaWnqeIOAAeuBjjen20e4dB7XrV6RsxQVH6n
         qBbXfrmXUxoEHh985gVlIbmWEsxRFPYP1wGru29WSg6gq/ii57TET7BXmt27y6HIBC
         DMGU3zoINPTwA==
Date:   Fri, 25 Mar 2022 17:14:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm*: use simple i2c probe function
Message-ID: <Yj34gLRxhmXD1Y5B@sirena.org.uk>
References: <20220325162439.1203870-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mZXNND7REWmn/zfc"
Content-Disposition: inline
In-Reply-To: <20220325162439.1203870-1-steve@sk2.org>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mZXNND7REWmn/zfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2022 at 05:24:39PM +0100, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.

This is going to generate conflicts with other pending and more
substantial patches for wm8731 - please resubmit after those have been
applied, or split up into finer grained patches so the rest can go.

--mZXNND7REWmn/zfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI9+H8ACgkQJNaLcl1U
h9AGuAf/YJd1705c1FWe1k3HyTnSJjwxsssaICO4bhNG/E4puONzf7FX6B07XE0H
b1pVNpR8bvFQ4gOM+hKydkTIZTD/GMUfRY1rhxO8kt4+/ZzynWccPvdq1PMug0KG
FJcaiGGulHsVNxI60oZAMaIO+UNrfMOJ3yOu4Si7Ttj6+jU1ZtSn1t8R+apOMn8S
RnNYP8nLucSdSiDUe8KKKNAYIbZbF9YefFd6SwUef7ZP2V7o4LX1dr0NzovSUtd5
ZsxZmh3afUsz4Ifh2cmFuL54MZT09ozQ7KSKVwJvrfEHuN7DZjoC7z17PzQNfgzD
mlUvu4ADqtd8NzZvRJ7se3m2FhiRWA==
=Dxux
-----END PGP SIGNATURE-----

--mZXNND7REWmn/zfc--
