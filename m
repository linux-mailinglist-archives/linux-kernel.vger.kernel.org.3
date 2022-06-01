Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1FC53AEED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiFAV5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiFAV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:57:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E521F263F;
        Wed,  1 Jun 2022 14:57:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LD3071zltz4xD8;
        Thu,  2 Jun 2022 07:57:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654120631;
        bh=yvSCr6+mFfHoPs0BMYIjNhhHwb+zbDE6id+dGN/jzt4=;
        h=Date:From:To:Cc:Subject:From;
        b=sagrtn97riSgqBd8d/TMOFq26SJnMxboIi/+YmCbItktfpN/rca5W0KQQUiT2EbVa
         hm3sVFG2xUYletebdKhcFyS3oX7OVpoXSTqF+JgEujse6VDRuBrcs4jg4kzhkD236T
         CeiWV+ie96LOddX2mfwGmdrKLvpG5QzpOP6j6BHpR57t+uAWOn657aTvfX0vkEcsNs
         5bRxmPZGmdxNuc/7C3sm3CvYxv5LMVrpZZ7cLZY5vfe/3x6Z6Tu+jL9pC6tlTq3rYO
         ZWxxECtYAL/u2eKwvoiJrPrS4goZkj7fkJ8oLfn/KToX0iH74owYTQ5MQUo1kW/8Lt
         A33UVQgnq2LXA==
Date:   Thu, 2 Jun 2022 07:57:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dillon Varone <dillon.varone@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amdgpu tree
Message-ID: <20220602075709.65484abe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qvRlcWE8f3OGIrdx6TsDbC6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qvRlcWE8f3OGIrdx6TsDbC6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  bd92bf3976c6 ("drm/amd/display: Ensure that DMCUB fw in use is loaded by =
DC and not VBIOS")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/qvRlcWE8f3OGIrdx6TsDbC6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKX4LUACgkQAVBC80lX
0GyY/ggApQQ36pUu41eM/9FnYE/DXVZeT8ZOvlEstvxPlPNfqN7Mjv0yHZ6k6roC
JLMjLcRCvFZCG7+X0UcZPBIRKNaZ7oC3mZVaEGMUZ8NbFUo/UiqnSxcPRab3P10r
LXug2O7u0/FVgtS8kF3vhoFJK00qF5bQgKrlTG9DuQS3QZ95yodhMgPbH+gRQns8
CAO78AsGLohJ0f8XY0b0RjPkSvgRvIiFKxC1cne/VxjkBHY7myiSMa5EbmOlYuzU
XalkYPbavMdxZOpnwANKxoFAtXxoRU/65soorCUZeb7iXrLSRq9b/Ac0IE+rkQg6
Xn/qRJN9YcUpNkWZYrDwbGTOqnJhSw==
=3ew8
-----END PGP SIGNATURE-----

--Sig_/qvRlcWE8f3OGIrdx6TsDbC6--
