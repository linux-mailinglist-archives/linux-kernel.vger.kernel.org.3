Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893DB5AF768
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIFVx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIFVxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:53:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC2C985B9;
        Tue,  6 Sep 2022 14:53:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMfKS3l9sz4xGG;
        Wed,  7 Sep 2022 07:53:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662501228;
        bh=P1UZW97JpfiJjJNwh5Z/whP3vo9XvHY8OmNfyz0LgNs=;
        h=Date:From:To:Cc:Subject:From;
        b=Oz25eLLPtUcfrKiZPZ4zDIBgAHP8fAJHdSZVrCKyTnUrvyK+EV6fVQWxZ2wIdnqlV
         wLcvrP+FdLpupJ/5Z9Tdu2g1TLu77tJ1cgSXgc/snpD+QyvUN/zYyB+0KVbm4X/r3r
         sFck5g8IXzn/GHCiyVMkas3Nkyv/maGs70m3UNiX58+MqCeoDb4xvNenqaV3z6ZHTf
         2JT1shxbPyZsCX3Dfjnbr+F/XIAC6p3U2PMOLhZl2XedyKfu89ZDRWw19yhLoZ98YF
         KvlZicyDOcpkmsKcqu0VKSg5smlfIJjTu8BxyB/yGxtsXEkai1vmtR6qZ6bfNg7a3V
         1E1k69kmh4/2w==
Date:   Wed, 7 Sep 2022 03:31:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm64 tree
Message-ID: <20220907033142.1fe410e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6l6AviH5J5QVXm+_yHv5Bmg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6l6AviH5J5QVXm+_yHv5Bmg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  000aef672bf2 ("kselftest/arm64: Install signal handlers before output in =
FP stress tests")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/6l6AviH5J5QVXm+_yHv5Bmg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMXg/8ACgkQAVBC80lX
0GwjQAf/dappteMw8xgyyIJ265ILHV+qYAdKHBX2FgdfRSxfrC4TH3bFEvl1Y3Q5
Vayh/D6oCvGGQIzh/BoG1FV83ajYuVAq6aVOgsXdfdu0c6eY4qNit4PX6jhtNAKi
Jgs5JmBL5Ao+/RpwcNip57798466ekorXRU7f5vOiSDaav+XNbSZEhaaITWrpRsF
s3ruxO6fCoGxoKccDGL5OCOArsHmM/t+jWL6MLVUEM+iWZuZBilNsjNHqOGpifkQ
yRP8t5l+wOpIQoZsO/QKVYtVAZGE4IwGYTMgt/vnHGaquccqnK6ApLi7RqHX/BUL
Xl4Sjklm0u5mc/MyljZBm85sFyNfeA==
=6GX7
-----END PGP SIGNATURE-----

--Sig_/6l6AviH5J5QVXm+_yHv5Bmg--
