Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F28520167
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiEIPuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbiEIPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033291573E;
        Mon,  9 May 2022 08:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 750AA611CA;
        Mon,  9 May 2022 15:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134F6C385B1;
        Mon,  9 May 2022 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652111149;
        bh=5C2gAycAYfH3AorYV+ZVZig2Mkz2fhCTBkA4i45e2sM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yyq26cyETefivwltGGCi4Lgq3PfyAW4KN70HsE+JWAq2Rki2ctu27vtNCsto1jU9z
         oMNH/RFae2XQpOHJwM4Jybv/n4dtHzK5Y0iPQJPDL4VIY7qOHgI8pUJhD9ZOyYZoh8
         qNsfsXETPNMprtMjniIP9lPiVxAwgSitLMBwGArYOSuvCU+AXYIm/MgjrM3z6HdbOp
         x6qzpsSl8jgFxfpfzDMOXPv52qaetCkOl3ii7d9Kvv33CI79TU1Ks08vWTtZUqD2Z/
         LIyQx4MYBsG+6gW8HpRnFMFFRAffYZyVRpB41PzdfvFpSArIvbwB58ex+F6UIs0mKa
         w2iShoB5Lau2w==
Date:   Mon, 9 May 2022 16:45:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, german.gomez@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/6] arm64/sve: Add Perf extensions documentation
Message-ID: <Ynk3J2Gfnm4LkHn0@sirena.org.uk>
References: <20220509144257.1623063-1-james.clark@arm.com>
 <20220509144257.1623063-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mk/wbO/L6mmEEdnA"
Content-Disposition: inline
In-Reply-To: <20220509144257.1623063-3-james.clark@arm.com>
X-Cookie: Boycott meat -- suck your thumb.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mk/wbO/L6mmEEdnA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2022 at 03:42:50PM +0100, James Clark wrote:

> +* Its value is equivalent to the current vector length (VL) in bits divided by
> +  64.

Please explicitly say that this is the current *SVE* vector length,
given that with SME entering streaming mode means we have SVE registers
with the current streaming vector length which may be different to the
SVE vector length it is possible that someone may read the above as
referring to the vector length that applies to the current Z/P registers.

--mk/wbO/L6mmEEdnA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5NycACgkQJNaLcl1U
h9Dbdwf+PcSNippPQhwEFZ7lU/qxZTpSVBuoGp0Z1YUpzKhv2UgfZEbPz6WHtW89
W2jmtd52nfsNTc6old7JvHErzT3sdhrD5cdlNmZ8e5La/GS1NOwcLZKinXEarsqY
3nJPHYmKvSXCZCFuSMmnHB1xpTCZFou8dxgruNczu1DONbfXU0uil0bXHchEOYxa
Z3Bk5WdShpD67OwH9hgX4ub2ML5XEXpSmQnhKBZSGs4UIOETKvmraf7TYYZBWkZy
2RW6BJ4yE8/ZzWVx/HLPKzIlO9XPZN5Hl5gVsTQsk1uRK1fAPQNydQfITl3PPX7R
kmOKG0EK5Ov5rfaVdR8OQqXvIw/iMw==
=saF4
-----END PGP SIGNATURE-----

--mk/wbO/L6mmEEdnA--
