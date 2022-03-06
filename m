Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06D14CEDAA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 21:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiCFU1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 15:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiCFU1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 15:27:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C9B53E37;
        Sun,  6 Mar 2022 12:26:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBY684s0Rz4xvS;
        Mon,  7 Mar 2022 07:26:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646598416;
        bh=ZJanfrGMIKTAVyDL0JNDavep9Y3pzUUtr4+PKqba4Ok=;
        h=Date:From:To:Cc:Subject:From;
        b=qgl9fqxlpwCzGvQ3Jyq5Yl0VyRt3S037uo7sBpzRkdbVT/P5a/H5kL64X+WxDPR9h
         P6Xd/jNdU0PL7U0DVOjt9tTD/DRCd9ZUP3BMCeEpZrUidkZXx5gHQKOx0jwvhR7a89
         uQe6xzfGEVfXfmDpp/Bzbk8TQ3ZkZo+16sIB88iZFP/5156t7ZJ4TVOeBHKiP6A3mQ
         yQ57uP6zepGtRG4xYiUYEiTd5EU4d2PZHx0uvDz0iHIQ3mSgcNQZ/H9gUfIr/EGyWs
         JzxCC4bxBqDcakJjoWJAmJT5t4AtiUvfKBRy83Ps+vlyY0sF7X287cKdv357ed4faF
         f3YIpuLGXsjOQ==
Date:   Mon, 7 Mar 2022 07:26:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Philip Yang <Philip.Yang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20220307072655.42b15147@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i4eA7j1sB_FBkYM_nfgmDls";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i4eA7j1sB_FBkYM_nfgmDls
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d9de22f1e392 ("drm/amdkfd: Add format attribute to kfd_smi_event_add")

Fixes tag

  Fixes: 486975669106c3 ("drm/amdkfd: Add SMI add event helper")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: d58b8a99cbb8 ("drm/amdkfd: Add SMI add event helper")

--=20
Cheers,
Stephen Rothwell

--Sig_/i4eA7j1sB_FBkYM_nfgmDls
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIlGQ8ACgkQAVBC80lX
0Gxt3Qf/VpVmNKxZ+QB1WVHjxG7RqNd3W8ELjECJjE9D3O3bStODiLOi0dfSjZwQ
HdRvPo67DMiJu+CrwUl50K+WSGCU7ZN5a2GTpo8hvNTeFSkFLw0NlsubgwP5FVhK
L3gAY/sndMp4up1cRtxXCPqEj7d4vwwiXe4pg6moqnwpz6HhYUMtC4ZhnXe/WUdJ
X38UJxltE7FlWwEJNnFHTAATKz1eKsVu+KtHpvBcRZXeFRA99DWUPcPqswwYM6Be
a7VPyxtvcsddNwsk5jZbKAVRaozA+bEh4LNwpEAOpvrXpblSKV5ointOIR/5Di1Y
QwUCg+wboaBs8qvolmlAI6s1clubPw==
=hsh2
-----END PGP SIGNATURE-----

--Sig_/i4eA7j1sB_FBkYM_nfgmDls--
