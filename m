Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F184C99FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 01:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbiCBAn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 19:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCBAn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 19:43:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A15E769;
        Tue,  1 Mar 2022 16:43:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7b28644dz4xRC;
        Wed,  2 Mar 2022 11:43:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646181793;
        bh=Zb0vd0yPoblAyV5qNpDm656rT0BpGkDb4bIzXPh9MDs=;
        h=Date:From:To:Cc:Subject:From;
        b=ZZrzZ3OIACHFW6ozBNLk77Of5QGYfhOCr88nsfSpabxpCeRRkj5ckxHn0b2Eo56Ox
         CjOWUK9vIw8d3Ri/ruIVJm4B0gPx4CHNGNf2R5P+Ibtetl+N3vXjFIvFug7TzDFwVb
         GZwZReiS3zQl05sWkzAVnS8dM95zreDkvsepvlExnO88HdzUl48xCVbDDL1A4yXqoE
         3z2SjBalJ6sa5gxJDVdoiF3HxuWcgPS2Qjq/L+BmwcDGnXoeJK6vaf7YqlmYH82p+s
         ItpOM+45BBkZ5HbgpsbszR9XOYsQWmhAViu3WNW8HiwjclCS33to6B+YemCdimqZBf
         mJUYpIdbz4JzQ==
Date:   Wed, 2 Mar 2022 11:43:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm-msm tree
Message-ID: <20220302114312.077aa81b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MS6smuMKV9MKdUoJbE66fzO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MS6smuMKV9MKdUoJbE66fzO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8661f450626f ("dt-bindings: display/msm: add missing brace in dpu-qcm2290=
.yaml")

Fixes tag

  Fixes: 164f69d9d45a ("dt-bindings: msm: disp: add yaml schemas for

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over moe than one line or truncate them.

--=20
Cheers,
Stephen Rothwell

--Sig_/MS6smuMKV9MKdUoJbE66fzO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIevaAACgkQAVBC80lX
0GxU0Af/e8RdvhgjudoWZgUYp9r31CsQJVdnZs/qiQc0K8npXo/rl78FD9neRzgc
W1+tHh0m5C9IHx99k4iOOSrcezyNUiTRFc4IEcrFKwq7APda41YoQWDZdbnipuRl
d48Su9wZHbP927Ic3ibit8w0qhiPtPfK86wEZU5FKpY7ukgpqoFH9lxnWAhBBd+z
htJpqJuHGetRmIH3N85RHbMPOrP/+fkS4x+DcEJ0p0CZanskfr10MhstQ265Ajpn
3oJAd9xrF5Y/ZRg1BmRja8Th8tgLjM7nypOHU4LXQvwhe/f+xvooG5phfenCfhju
S8gQi5OaJCSzUqX99HhAdElnyT5itA==
=tMRS
-----END PGP SIGNATURE-----

--Sig_/MS6smuMKV9MKdUoJbE66fzO--
