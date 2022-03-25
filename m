Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8D4E6F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353468AbiCYIJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiCYIJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:09:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF99CC517;
        Fri, 25 Mar 2022 01:08:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KPvpk5m2Qz4xL3;
        Fri, 25 Mar 2022 19:07:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648195679;
        bh=XVXPUoOn9TPR7w9Y6toVOvKmSorW+MvHYISWZcOHmso=;
        h=Date:From:To:Cc:Subject:From;
        b=C4ezPHH21A+tX4NxhTTrf+qeUNiO2dtxW8C4R+QsT7MlgSPKgl7NcKZpyIUFnu4ga
         na1s7m+f2UxQsTtvzh4FweUyQay2s0cRd/kdsQcoeWqHIvWUHyaWRxf56VCbqmqUZu
         1ay8Y0BwwnoTc0Nz4gIy95DbFlZE+VX1ipAzNqhs29vhzNaW4BKIboHCVlZQpk0vGs
         KO+O6L/YbhZVqFGB+HFiTvfK8RAiLJ4O+oFlqxUNgRPEFGFqZ5ZVAQnqqQX5vioutC
         582PzM21DyWk1dewJ/fn9KZBzs0tSBoq55dh54VizG1eVeXr0o8seiVZL7l6ZtPd1E
         a3nYxrvpf0q1Q==
Date:   Fri, 25 Mar 2022 19:07:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20220325190758.733238b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/clKL3emE+ugbXgBiGOtreqB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/clKL3emE+ugbXgBiGOtreqB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:94: warning: cannot understand funct=
ion prototype: 'struct amdgpu_vm_tlb_seq_cb '

Introduced by commit

  0de6faf15895 ("drm/amdgpu: rework TLB flushing")

Presumably caused by the kerneldoc like comment above the struct
definition.

--=20
Cheers,
Stephen Rothwell

--Sig_/clKL3emE+ugbXgBiGOtreqB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI9eF4ACgkQAVBC80lX
0Gz6/ggAmJTcKOy1Zi4CxtxGwSpm3UAhbA63DtDjEUVZo4756k5XcNVkpS0nugtE
hdk/b6L8nPx4MtjY2YGuhF73+kLgo4R7n5aVlB4cPdi0aGA6qQMULbgWENnZdMxB
7i/qiFhGHMSX62959dPdxecLk80ZUq8En+UYQ7npN+E+dJ0DRVSEWN5+EGX9DnOg
Z8na34BYAMrHiPUh5heohQGwcb4brkX4TvtS0lNQXyHh4e2QQqUgQ1pB8hsEeNYJ
06hr5ZvNhe9Kc+LQgj/sW33YVAkgX4u1MeITnt5g4vEt//fm2VWxqX3IxqXaFjc3
a8n3HDAW8+bH30ArxZT8hGdjFLXPTw==
=m4bg
-----END PGP SIGNATURE-----

--Sig_/clKL3emE+ugbXgBiGOtreqB--
