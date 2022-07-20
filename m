Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632A657AE23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbiGTCro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiGTCrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:47:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041836FA00;
        Tue, 19 Jul 2022 19:47:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lng930zfMz4x1Y;
        Wed, 20 Jul 2022 12:47:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658285255;
        bh=MTCnWIpDJsB5jJPEXNHIjEL/1RoyMJ2q28jK1kla4/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j4bVr8mxvqAvKvitFxLVg/t2n+JSMxZXaKqgW2uh6BiGpcIebdw0uI1pX7v5Vrv9T
         QGoHsPafWB5FeSwF3kRpDp8xC7Pn1O4ypYebFFFK1aMgzlWZsy+ZnM8ZJmgZNGLfJz
         SJkp/n386U4aboWXiNp/NBoIL0irk2xfAkbMOiTtNmDlEnygMv0AXkmZiSK9pXCJYI
         /7+RUYOTxMo96KRO5fYLkwfbYYoLbZIpeCRLVaNQKyGrvlOvQL4DZnUu/aYopbo/rh
         dwCCmP+SMkXFQJE9BniQ//OOkiN4/MEJkpfBJUfoXugrMSfjoXMbDoG/VydgZF4Q0/
         RpDhfNIuFVuzg==
Date:   Wed, 20 Jul 2022 12:47:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220720124732.4aeb3748@canb.auug.org.au>
In-Reply-To: <20220719123607.63cbb3c5@canb.auug.org.au>
References: <20220719123607.63cbb3c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bAqkNotV=p56vHJYCfytCa7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bAqkNotV=p56vHJYCfytCa7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 19 Jul 2022 12:36:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:=
 In function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPe=
rformanceCalculation':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:=
1659:1: error: the frame size of 2144 bytes is larger than 2048 bytes [-Wer=
ror=3Dframe-larger-than=3D]
>  1659 | }
>       | ^

The above is fixed today.

> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:=
 In function 'dml32_ModeSupportAndSystemConfigurationFull':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:=
3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-Wer=
ror=3Dframe-larger-than=3D]
>  3799 | } // ModeSupportAndSystemConfigurationFull
>       | ^

This is still here, but the frame size is down to 2336.

> Using the amdgpu tree from next-20220718 fixes the problem, so I have
> done that for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/bAqkNotV=p56vHJYCfytCa7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLXbMQACgkQAVBC80lX
0Gw68Af/fUmC0SSaPlOJ9Sjug3IL+2hL1flEUmVRMg5OgLM9EFFSSRkb9xs7riPO
RxTBlg36lLGdOyh0m/qGCpO66uG43LgX+M6g/yZHJi8UJ40sMP3jAifhHAnB3j7r
ldb3+0RMiwgFNLXQyrXlRPGDsQLZRBJSSuM7I1qmupnh5i7hA04nS9K3RD0IYioi
yloiid2bZq7Z3a8qkGX2kY2BzDukqlug7eRuN1oBU3/2NOARxdJDsLeNVRK88HgY
kNOG38yI8ghHVn+ybubpfKJv0AzCscbWCkjrxV59X8HIf09p5RocdNi7Sj5bC4bZ
mIullasXmnSOyuHKkTG/30DVJFWDQg==
=AUtf
-----END PGP SIGNATURE-----

--Sig_/bAqkNotV=p56vHJYCfytCa7--
