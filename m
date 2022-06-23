Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610CF557463
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiFWHrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiFWHrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:47:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7D646C94;
        Thu, 23 Jun 2022 00:47:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LTC5n33rQz4xDH;
        Thu, 23 Jun 2022 17:47:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655970461;
        bh=lCVSLYnDLg+PNjd9UfgZeb1MsdZoUP47+6Sm5hqdtfI=;
        h=Date:From:To:Cc:Subject:From;
        b=HUv1zsddFMk8QapOJwc1BVGvlev1TOO/wz/oWduCJTbK3gP73GHqev1WKDAim8kyv
         xpPCayP3JogyN/ugwHTI8vLJY0Jt8HCZYnVYxUxzsb+QbmsceWwrVEaKVy59nApX9m
         UuKJy3KboBiOicui/ytgWIPZTjqe3BhSiniDV9s400zHG0EeJE/Yo0s6eIHVivrjaK
         ITDOaxER32CtwXAgnU60lJ6mIox+eK5QhwfoCgQD2qfQQ+HL4U+bTmNCqEK89xMe+M
         m355aDVgHinRSipO3faikvEY1Nuwz34i3E+tztwarxu1vD8Js1DAPiZ73uwa58bsfL
         hq7CAoKX518tQ==
Date:   Thu, 23 Jun 2022 17:47:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20220623174740.67b3cd85@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OF.n70kBoLZ5ero4vXl2DaO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OF.n70kBoLZ5ero4vXl2DaO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5094: warning: expecting prototy=
pe for amdgpu_device_gpu_recover_imp(). Prototype was for amdgpu_device_gpu=
_recover() instead

Introduced by commit

  cf727044144d ("drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to a=
mdgpu_device_gpu_recover")

--=20
Cheers,
Stephen Rothwell

--Sig_/OF.n70kBoLZ5ero4vXl2DaO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK0GpwACgkQAVBC80lX
0GyIVAf7BijYY8gpfOVjM1NmO3j1GDmIBe4MXC4n7g0z6Rud8LWqP6kP1l9+fJxb
R0S/JPEcepHE/Zr42WRsGmI1WQTm0HrJwLs7KUjGJ7D8JdyNqqJw0Fmp5RDnV9Sh
cbjYpSnvosBpnK0oeI0JAup681WWgU+s2lbD/UHeQ834TkI6tuxd5ZZUiJlW4yrt
p/TjjoSVa/dOovEVI43FikGI7Ht54PkdlyzxuV5autSRu2tvN6jnUOYgJMyMaaNi
v61rqpa9DWnkIigBy+p3Wk+G6N0XKsknTQx/nzsPly4b3skK5+UokyUC5nFyBfT2
ria6reNhbRAU4mSpI3DsWecB0b5VqA==
=sPri
-----END PGP SIGNATURE-----

--Sig_/OF.n70kBoLZ5ero4vXl2DaO--
