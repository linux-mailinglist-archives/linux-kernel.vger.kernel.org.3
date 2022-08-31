Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128A5A75B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiHaFaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaFaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:30:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DB3237E8;
        Tue, 30 Aug 2022 22:30:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHXnM5KSKz4xGF;
        Wed, 31 Aug 2022 15:30:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661923816;
        bh=pGKp6b/WWQi5n8i/p3YE1DQRmmuy4PW/cQvMgnY/k90=;
        h=Date:From:To:Cc:Subject:From;
        b=eLKCvPc45jsCMcxUOMuc2JEvPR51pMRzEx8quvh7mvvvMadozBWrbXP0695ZjoyBB
         aBVaUebLAQRCnqv0KP5eFY2Rn8X9kbtGTXqFj2KGMYxsq6zF0OG5L5zyq2CakxA21+
         wXeojYI7YWIxqChnTdm48uqxz6d0uEZ1QBGsBlcfLVE4IhvYXoUC6poH3Pg8ZpUMch
         u+EhO/4oliHYZpZIdl8D3QaSwJ9RlJpFFcVXzUN8+njXfXpg1jCI8xaDEQAIDca6Ok
         spPZHN46mnqqDqD83vHvJ5NuifFmI9Bzi5OWnuPG+cfsKvQK2SqringmcTeYPWlHMP
         mjNMxQX8ZDD0w==
Date:   Wed, 31 Aug 2022 15:30:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Shych <michaelsh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20220831153014.4ac7c154@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.yS6cJY+O1to2tutcEAc5eU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.yS6cJY+O1to2tutcEAc5eU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/hwmon/emc2305.rst:16: WARNING: Title underline too short.

Introduced by commit

  47efd143900b ("docs: hwmon: add emc2305.rst to docs")

--=20
Cheers,
Stephen Rothwell

--Sig_/.yS6cJY+O1to2tutcEAc5eU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMO8eYACgkQAVBC80lX
0GwiVwf9HmyvqAnfKiC3wrB9S/9IbzAU1SjCVABCf8GfKgLjzKq8gy8RcwqvxE8U
t/nr1jE0/0CyKWxniD0pf+eg/PtIYR0B7QV86r637BVTq1Jl0XVyPm2mBFn6o5xi
G2oAw1UflqwpE7WdaRIZH6y/zA3Wa68bWWoWknwlLVztLjFS2yiyvfVASysnPXWb
rQMmXwAoo1xEGAOvXKmya8O4SIkPDW69O9PhM5MQI6gpH1WTUfb24+UM782LNmvy
dPknTzU+uhP5sJKWsoA3327qkRqo7vyeRA4EYB61R8/qXEMEtyrIJVJls2Tqjct1
Wfolan9BF+3Z8uJtrC7NkaXxTb8+wg==
=Dr9+
-----END PGP SIGNATURE-----

--Sig_/.yS6cJY+O1to2tutcEAc5eU--
