Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5338C53695B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 02:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355242AbiE1AWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 20:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiE1AWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 20:22:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72F537BCC;
        Fri, 27 May 2022 17:22:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L92Rl3c1Xz4xZ7;
        Sat, 28 May 2022 10:22:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653697331;
        bh=tBEjMskdtGbN/wETV4oNxP4osW6efJNOpCWtKAwaysk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MEoK/41zm5rMVNbRh8wU6pc3DcmLQo8+bdrjCHRe4OnK/0x5f7TOc3abZciG11boO
         C11rWvVRIjZZRCVt3OKluzPsgDOSs2PKQuxuXs548uxEIk4nNHIl1Vp0us246Roti8
         0uklcKdKlkbMQH+mrCcco+THJggCfYKOY/jfEJacZklXcMEg34ciIYKKmRwOOaCHNn
         XJwbhyoHzQA3kHrAu9osWiU/JGruXcfnRKT1qgizFX5+6AnIzcwKEDduh4yFyamLlJ
         TGDIdBuKMRjRLcd5xQeDQrHp/iUgO78zqt82Hs/9yyXZQ5H/GpafP5ezFzmwqTjQSu
         v7JGEATWfN2uw==
Date:   Sat, 28 May 2022 10:22:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for May 27
Message-ID: <20220528102210.7c3dac8d@canb.auug.org.au>
In-Reply-To: <20220527164940.6ef5b25e@canb.auug.org.au>
References: <20220527164940.6ef5b25e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WaPMWXtAeckL7pgjddtInxR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WaPMWXtAeckL7pgjddtInxR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 May 2022 16:49:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Note: please do not add any v5.20 material to your linux-next included
> branches until after v5.19-rc1 has been related.

I forgot to mention that there will be no linux-next release on Monday.

--=20
Cheers,
Stephen Rothwell

--Sig_/WaPMWXtAeckL7pgjddtInxR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKRazIACgkQAVBC80lX
0Gxa8Qf+IK42xpJtNRiQuasI46+giQu3/pLIVjweL7HHTkQWL45BJ5Y7xobLl7tW
oJ31Lf/V/n84ad4Q9MmjsXblRLhAGoafEIZ/0ISOt1ISLbXDEJ55c8Yx6L7Pi2GY
kL/XPwEosblRg0kBiyj61keU2reYOti0UIol4zM0M9TDPEB+mKx9h2YLgkrC1TDb
aHr//GdHg6M/emFdFvEb8b9vuImabL0fU/oWnKVdlfG5jgsnPSvO7ogYLaXs/MEI
ltukoQ8NJjLZvC8rudAANTsXRFVcraiyIsnZcwMNLvrhEFGEwRZycggdoBaYU5VR
AXyH4MoAIngcPcvyWJvLBfxqEB9sFg==
=iMNJ
-----END PGP SIGNATURE-----

--Sig_/WaPMWXtAeckL7pgjddtInxR--
