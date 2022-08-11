Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027EA590905
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiHKXQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHKXQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:16:46 -0400
X-Greylist: delayed 542 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 Aug 2022 16:16:43 PDT
Received: from gimli.rothwell.id.au (gimli.rothwell.id.au [103.230.158.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CA8A024C;
        Thu, 11 Aug 2022 16:16:43 -0700 (PDT)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4M3jBY2S2CzyZt;
        Fri, 12 Aug 2022 09:07:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1660259255;
        bh=MQdGlv7/KuLvICsIqGjekw2CdHuPtmyaZo7g6m/4FjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=adZNluClMa2RHl848Ly9cmmxaBRWrS5jN925SdAWWhmWEqgqt1j6UPqyrhqmTz7dx
         5/OLBxkgKq0xH+1eeUdBZkuhyMZ6W33mnxSu+fPSPNXEiixZMceZ9S/ONjEGAScSWq
         fQ34MLaIPk3soIwNg5I/x8Z5iovR/F+idT0otWFtHsiEOrN/GEpoMVrKzeniPK8foV
         uKaaFFVdJkGqulsfxrpHZbdNDVSbIYC9eVLwOe/dzR0IjlMRiOAc2VHLSzWh3GvDQq
         jzl/WG7CdoDbDm4z2Da/8yZnUMmvlMF3k1MY5bX7boTxbH1evSclE2TEWbk2sZQ+WQ
         5jx5A7bpu5c+w==
Date:   Fri, 12 Aug 2022 09:07:31 +1000
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: build failure of next-20220811 due to b1a63a0b48ad
 ("drm/amd/display: consider DSC pass-through during mode validation")
Message-ID: <20220812090731.31da7d85@oak.ozlabs.ibm.com>
In-Reply-To: <YvU4GD8HtZ1A4dhI@debian>
References: <YvU4GD8HtZ1A4dhI@debian>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lBwBYWJZfaTJxqb/SqOb3za";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lBwBYWJZfaTJxqb/SqOb3za
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 11 Aug 2022 18:10:48 +0100 "Sudip Mukherjee (Codethink)" <sudipm.mu=
kherjee@gmail.com> wrote:
>
> Not sure if it has been reported, builds of riscv, alpha, s390, arm,
> arm64, xtensa, mips, csky allmodconfig have failed to build next-20220811
> with the error:
>=20
> ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amd=
gpu/amdgpu.ko] undefined!
> ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgp=
u/amdgpu.ko] undefined!
>=20
> git bisect pointed to b1a63a0b48ad ("drm/amd/display: consider DSC pass-t=
hrough during mode validation")
> And, reverting that commit has fixed the build failure.
>=20
> I will be happy to test any patch or provide any extra log if needed.

I have reverted that commit in today's linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/lBwBYWJZfaTJxqb/SqOb3za
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL1i7MACgkQAVBC80lX
0GzSzAf8DKPebARHzdTqD13VNr3O67jzPL8ES7pQodgFmZMSKK3Y+vrG88X3EVSk
ix+XD73wo/KvGZwASDZf7CMKj84ihNm3re6hPjsLcHMeZ4bpwJi46enWVl+EA3zQ
cDzSOP++Vl1dm/RNZXMVm30CIvVjX8MgDuwGqXhWvbWL2Q0yq1xg3dddCYLl9y4p
R3MSWvVXijrkQSdsM0v6oYI80x5GpcQPk+H+fpsmkd0EwKDKG0sNste7Sbk9XfqM
ljtDoOkgQ85wzHC8IExlgQnjDMswtlW/b78kzXfdysl8KIQrHjo5aOsds0ZeHkCZ
tbr3b9HgZktRYDXh16COSYyVZFzJKg==
=Mbox
-----END PGP SIGNATURE-----

--Sig_/lBwBYWJZfaTJxqb/SqOb3za--
