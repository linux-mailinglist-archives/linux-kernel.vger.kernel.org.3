Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2771C4C6DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiB1NTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiB1NTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:19:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CBB1EAD7;
        Mon, 28 Feb 2022 05:18:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB45612FE;
        Mon, 28 Feb 2022 13:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72281C340E7;
        Mon, 28 Feb 2022 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646054300;
        bh=yxGEHfot5dt7JWoIs1jlTjlg4Y11zVRZt6EPyBbEl+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RhsXvtENJPZEqGrFPUieFhkthDNujpkEbe5vgtl4aCdXK+Fcd1D0+LCao8hE7kCSA
         i/UQJ2W12lgvtZzuyoysssoTd7mhyYT7TCEAgOV/FgEbNcDudmuCIBJtCGcuFI3T4K
         xkv17TuhzrjxrI3gZJ6S4v9u3gsZzkWbXONRLQcaNieLS5rYiJvQ9Oc+B9Z1YLfLNR
         fB7U2YR6wU0iIDnmSxfZj8g+JOP5vBVtEcJA0ik2RNdoL786y2kXJFo+ROZyHC43x8
         +709m2jae+idTJ2Xsc1ysapz75NXrMNKQzJlbN6wF9bGMkoXP3x8x9z0QG0whTG7Ko
         UYYJd4pMcr8Hg==
Date:   Mon, 28 Feb 2022 13:18:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] spi: Add new mode to generate additional clock
 cycles
Message-ID: <YhzLmNcJH2KsXsMC@sirena.org.uk>
References: <cover.1645950971.git.christophe.leroy@csgroup.eu>
 <2bbe791f1c2b3c809c8863020184cdcfdadd1510.1645950971.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cdm2/dmGKlfIytbZ"
Content-Disposition: inline
In-Reply-To: <2bbe791f1c2b3c809c8863020184cdcfdadd1510.1645950971.git.christophe.leroy@csgroup.eu>
X-Cookie: Killing turkeys causes winter.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cdm2/dmGKlfIytbZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 27, 2022 at 11:00:34AM +0100, Christophe Leroy wrote:

> +  spi-trailing-clock:
> +    description:
> +      Add a few clock cycles (minimum 2) with chipselect OFF after transfers.
> +

We should make this a specification of the actual requirement, not just
a boolean with a vague "a few" requirement - with the above we'd have to
add a new property if some device turns up which requires three clocks
instead of two.

--cdm2/dmGKlfIytbZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIcy5cACgkQJNaLcl1U
h9AllQf/YJaP/qR2wottG+/EKGYXx52lG4My6wzT7+VgVtlthD3xmiNezRygrAyR
1mKrrog3yCg1M8eUJMM3jv2S+7yg+JlHaegBIAwnWd7AEGBLxMxNiBHGbwrI9WJd
laduiHNd8C6lDHd37Pj2sNwNti3jv66IZTdLSBKOKD9Bi1Y1Iv3PyDT/Z2Kw+bQd
7imbWEW8AtRq68ljQYdlJXC2/HVfW/D0OVLWwd24x+chQNwfwocuMH0NUxtcQsyh
NS3nLV7HYmIQKUvrysfohca+TI5myQ9JZJuhyj5hadUNG4+hEd3gKHgprK7tyxXC
RlgLEc5COkAYTRouycz7rzKtAe2byQ==
=y5b3
-----END PGP SIGNATURE-----

--cdm2/dmGKlfIytbZ--
