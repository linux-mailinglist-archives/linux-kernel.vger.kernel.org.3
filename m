Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5A4C9A72
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiCBBda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbiCBBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:33:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B3DEB5;
        Tue,  1 Mar 2022 17:32:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7c792bXTz4xRC;
        Wed,  2 Mar 2022 12:32:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646184758;
        bh=2Qup4iKVliQdfHZQ/dyiKxqOCHtCVx5xPxSyD+e9DrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cQpdOvJegGZwY/jHMBviluoXSh0S27XtL4LRQLYiRx+dSWl2A8ChNNjKZH6qKMs4J
         QjJtipFMSddRWdpUsE92TO7WvPFDSH+c+aigi3lJfwxm/hOJb5bcqT67y0KTFd91zt
         gGnaY3ydtFd/nAgkG6qUNfXP2foSWCTBcZJuUd3TJP/0U9V7/u10/POTUP4wB4iudy
         qKTG5GbiM6n91d5cRuCMY7ub2HsGsS7JNf6wsZBOpwCCjzDIAgQakA9STx06RP/6bG
         A4rYczX8z5MR8N06meg9TzRRrBLVez1wvOwxm2o3G4LcWKBZS3Y4G61W0ex7wokIUk
         xZuObx8Yq3auw==
Date:   Wed, 2 Mar 2022 12:32:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm tree
Message-ID: <20220302123236.1b7c721b@canb.auug.org.au>
In-Reply-To: <20220202151045.23205624@canb.auug.org.au>
References: <20220202151045.23205624@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sE0=Cr+s_nWrz3Xx=O94Wjz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sE0=Cr+s_nWrz3Xx=O94Wjz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 2 Feb 2022 15:10:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> After merging the drm tree, today's linux-next build (htmldocs) produced
> this warning:
>=20
> include/drm/drm_connector.h:637: warning: Function parameter or member 'e=
did_hdmi_rgb444_dc_modes' not described in 'drm_display_info'
> include/drm/drm_connector.h:637: warning: Function parameter or member 'e=
did_hdmi_ycbcr444_dc_modes' not described in 'drm_display_info'
>=20
> Introduced by commit
>=20
>   4adc33f36d80 ("drm/edid: Split deep color modes between RGB and YUV444")

I am still seeing these warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/sE0=Cr+s_nWrz3Xx=O94Wjz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIeyTQACgkQAVBC80lX
0GypQQf/a4GZbxJBbUJsZte/TTgnf5Mb7VM2m3++z2VLPCb7SHsRUq7dPYpeDrD2
vPmVX8LMUhsTqityHzZkrr3Sa0DzPipA1GrRI1qk1a6Wt4DC6gsfafancf+puqXM
wnlKaDn8ZLKjiH2y2FI+FHtCa7eybBYF4CV10qEwxrj/kV95NiNik9W94N6Ph5im
bi2Xro4As4NZ3qgJHcyB9cTE9qm86w3APM/ST4+GedqIBUikve4MT9MEOZeBVwtY
m2hmnP6GEZ0051JPH2slaRvtQDhUkg/2389VhF5GroNqfmj/NwhGdfrDuzvjcHAE
ezOq2DF14kB2gLI3kAKglJfwUwYVlA==
=zYdX
-----END PGP SIGNATURE-----

--Sig_/sE0=Cr+s_nWrz3Xx=O94Wjz--
