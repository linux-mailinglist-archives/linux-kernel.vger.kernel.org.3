Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794E44F5791
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiDFIPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbiDFIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:12:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D263917288B;
        Tue,  5 Apr 2022 22:51:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KYDCv2qclz4xNp;
        Wed,  6 Apr 2022 15:51:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649224299;
        bh=FI2yK1w4BoxDLceAwBGSkRpmSZfiLC52c+HFR+YTcCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tiaTpjp/qW7eHcK49V+/LajlejZwX3CwONOlMM6PuebxYbRAAEI868g8TzoBpowjd
         PJD3ad4dNW3WiPGRjh/+0stYdae4f/eJRpLI1FIExaLVqho461FsBaSlGqMCg9P8XO
         xKyG0bwXuoqlhm5HLpaExgaqfnSa5ukpJ4+v+Xa7F0jpu48bZ0CC5OLfuEpXRmLMRG
         qIsaVlKvlSJUfyWZXZven0N1LTLHWtpP/3d4VjoUJNwaurUwXqx0o9ifBSwTfYclJO
         niRGHo3ZP1GCINR4zjGIR6pgoWulrsBabtFNOu55xXFR7udAnH5awt3geuwrWm/NZ1
         0nPnsWPoIhx+w==
Date:   Wed, 6 Apr 2022 15:51:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the drm-misc tree
Message-ID: <20220406155138.61a8d85b@canb.auug.org.au>
In-Reply-To: <20220406154431.567414c3@canb.auug.org.au>
References: <20220406154431.567414c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ICUojPUEsse9a.hRFPw8grO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ICUojPUEsse9a.hRFPw8grO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 6 Apr 2022 15:44:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the drm-misc tree, today's linux-next build (KCONFIG_NAME)

This was an "htmldocs" build.

--=20
Cheers,
Stephen Rothwell

--Sig_/ICUojPUEsse9a.hRFPw8grO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJNKmoACgkQAVBC80lX
0GyYEwgAi2Imi3EmsiOg/zkGfnhxmHGLL2KeL8kX/wT/RCLY57XKvK2wt/Sc/PCu
ZANpi2cD7vQa0UT93sHz03g07mzqI7UEnO8cP7uOD+9oSCcy2FaUDKAzcXsIIBPq
nS3HLdn5UExItZxnkY685cAHWUY27rHgAT//lkqL0DXVO9kJGSkmtZGepvEZh4pa
P9f/rzodnxaaT7eAuzmfLb1q9OtQb7N38QOX2S0ZTd9o5mh5sDAVhEdRug4Y+9nU
tJ5Vj8qpTigEVk7HQtigjy6/17vv2Hjgv8aRTxWboTMfqXHgLDgHtyHKknA3ylX7
c4FHkGeX1YnJ/pA4x5N/g30ZuNpWqA==
=6WJm
-----END PGP SIGNATURE-----

--Sig_/ICUojPUEsse9a.hRFPw8grO--
