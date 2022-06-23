Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FF8557468
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiFWHsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiFWHr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:47:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1D2FFD;
        Thu, 23 Jun 2022 00:47:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LTC5y4yXnz4xZj;
        Thu, 23 Jun 2022 17:47:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655970471;
        bh=ix/DajIzg43HKlGKICbftZP/HTh2T/l0UKcK7J6EmxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jNGeEVXUPTw0ziOduhBHXMzl74s/2YIGSTZ9obIaZEYgoQzr9CB+IKQxGJpaTNkhI
         ieggZjn3A8dwyAGv328xM6uA2n3CQCO4ZoquhpuFci3dFqw+DDFAFx4kBpAjlbX6SR
         xT/pMGme8Ro0UTwOZPlvQV3s3+HZL7r5SuWzJIE42Pz/uz0P4WRs8W5YyVnUP0FVyW
         LPj8Xc695ivX55WdanOmkffAzLxrzipJG5xevXuFE2oocMlf57W4sqWZ62SeCp89IL
         6RmNain/YOOQLOMgLQN+6rFI5uMd4Gj8fTyzHxu/KNMEIrpH+gkmt/0uChhm2T9qjg
         70N8Qhf1uc86w==
Date:   Thu, 23 Jun 2022 17:47:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220623174750.49e01139@canb.auug.org.au>
In-Reply-To: <CADnq5_MZ1HqM3C49MNn=4+nufbWOQbQhDtVpAeqtKzKOC+e1ew@mail.gmail.com>
References: <20220603144315.5adcddbf@canb.auug.org.au>
 <20220615150013.30c9d7ad@canb.auug.org.au>
 <20220621181551.5eb294f5@canb.auug.org.au>
 <CADnq5_OxNm9EwLDXishu+pMfT2mgOSTvkmgSm+cm98JiCsiJog@mail.gmail.com>
 <20220622080726.39cbeb14@canb.auug.org.au>
 <CADnq5_MZ1HqM3C49MNn=4+nufbWOQbQhDtVpAeqtKzKOC+e1ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L9kKsRWbDOiF2C1dORFQW=J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L9kKsRWbDOiF2C1dORFQW=J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Wed, 22 Jun 2022 10:48:50 -0400 Alex Deucher <alexdeucher@gmail.com> wro=
te:
>
> Thanks.  I think I fixed it.  Patch sent out.

Yes, that got it.  Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/L9kKsRWbDOiF2C1dORFQW=J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK0GqYACgkQAVBC80lX
0Gz28wf+IB2XHQPT0dyiMky1xSPDeSNu5OXHxMm1VR+e/kWzoXPe3OkazoZfdtDu
ff6s6jmrEEjgRnWwRa7nAyaDpZJVqlyU64m+8gHqtQkHVromQgOzRiUSp8YC7jT1
w4thsbyw04/jvmUFXS+AkNowf1gPGTvGadqqjd6bEcLmMViuvR/m76el7RQWQCgM
wA//dGCinK3x9StWBm8uF2WqfoPE1KZrdotBDuRLiy68+knbNVZGq/lzofHgsrJp
WJfyWNttgc9Gxlr0uizE5RxnNNv+UcZ6ZlvH49whWDsJtwA4DvMBFp/rZFgMF2dg
/LTTB8QqHjgg5SojeD1bx/pMaWKktw==
=iagx
-----END PGP SIGNATURE-----

--Sig_/L9kKsRWbDOiF2C1dORFQW=J--
