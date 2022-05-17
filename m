Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B67529FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbiEQLHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiEQLHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30CA60FB;
        Tue, 17 May 2022 04:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B5E560AE0;
        Tue, 17 May 2022 11:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AB9C385B8;
        Tue, 17 May 2022 11:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652785661;
        bh=5tBsPYW0JHeXxvdkgiNd1jJmfnPjditVESh5dkxWeFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAw5YJsIfHwu8sfxpkMfWCIKj9sv+lv3f9AseTWanqKK8fuyWV/H4HRERRLDlhPEP
         46gRtUfGOMQsC3l1fCQOVunxMr9/6+UbKQXUpqQENSd2w9rjp6DynvKkrgalWSjTiG
         +lIGJjNfEbmTsWwM5x35LJWjkh01C59MGJZyfDUhwKfyrQY0yCBTS7rYSxIyrHTcf9
         ji6kX4MZN4PKEtlNJZGmRWs0N2fAkgcY+uOYnur0ODRxnrmif9jXri2sf8DqqAmhhB
         uBnu5Rlv3+Z6gnuTyPZUd6EONJ17l/5GzrFhNXb6WWm9ZZXF50k2CI09JVH6akXoJT
         AUx+re60NY5bg==
Date:   Tue, 17 May 2022 12:07:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64/sve: Add Perf extensions documentation
Message-ID: <YoOB9y9WR901CyTp@sirena.org.uk>
References: <20220517100743.3020667-1-james.clark@arm.com>
 <20220517100743.3020667-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iuQTJ7qbN0XNIs6b"
Content-Disposition: inline
In-Reply-To: <20220517100743.3020667-3-james.clark@arm.com>
X-Cookie: Fats Loves Madelyn.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iuQTJ7qbN0XNIs6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2022 at 11:07:43AM +0100, James Clark wrote:
> Document that the VG register is available in Perf samples
>=20
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Mark Brown <broonie@kernel.org>

--iuQTJ7qbN0XNIs6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKDgfYACgkQJNaLcl1U
h9BhmQf6An4DDFzlaW5rZWv/57ry7Yu0oiLAUrQ7m5XIlZszVEkFKP27yfGhGYTz
5mcAcBKnMkQgBCN7Cj7MLkgwpEfO8EWhKvCd5JsU/BpFeXoj1bZQxmUMGbbwl36c
oqJkE5sFYM0+cNaxK1YdKn2esA7q1WRqWsxf20FSc3RAbutamcwrUtU1oVfQzz6C
FtAF05pUcUj3ViC9mLhf4wLvE2wwqOnQ8Hv8dRRDHZm0pzn61/ow+7f3zLEEdpXh
dQxTEB1/l/1dISvPFvPcApYJYc+3qMqpn+7x07GhiqCSGN+/bZL5AODRP7j3IQDF
v23ZAxfxi8uaU8WHLjZY3/8kZ/IxPA==
=1IeJ
-----END PGP SIGNATURE-----

--iuQTJ7qbN0XNIs6b--
