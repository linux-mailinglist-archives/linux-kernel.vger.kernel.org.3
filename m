Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30E58EC52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiHJMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiHJMwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B367FE66;
        Wed, 10 Aug 2022 05:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8252861386;
        Wed, 10 Aug 2022 12:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9738C433C1;
        Wed, 10 Aug 2022 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660135951;
        bh=EeZ6kGDwIthkNr0WdkLZfmH4fwpEIdTMd52+9j8dKtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKSO7imtRSUEtQHKowpG0xMVEWpNXtFKlhX8kwjtSm3OHAvoKIw9a3jb/YXBG3DhM
         zadk7wKa859TkjrEwZapBVWJMVxWeL2buxjRDhNTKsPaFifA9kDJKkwbWQ+eyG9gl5
         CZJEAi8DL74jcf0R/oR1FNAN3Z45VObIW23LdNWVNOr/arWPjlaXNYobkw4HREg5dH
         ix71nyRaq47fwD+9eoiy4iopNg7U8mj6j8yWRa+Q+QP3MY40maYRdrF6CjoS/e0CFH
         XIZXeHeAxq+KSt3BW8Q3cVHS6zyEGSXjCyIwOYzDX4/mgrY6rNoLHS6UKSF3AirTYl
         6rmj86jxZ6ZlQ==
Received: by mercury (Postfix, from userid 1000)
        id 027321060840; Wed, 10 Aug 2022 14:52:28 +0200 (CEST)
Date:   Wed, 10 Aug 2022 14:52:28 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>, linux-pm@vger.kernel.org,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v5 06/20] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <20220810125228.qmphht5g6xtrwoay@mercury.elektranox.org>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
 <20220804021553.14867-7-tinghan.shen@mediatek.com>
 <YvOXPOidrbySvFwZ@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vmv57ibkudm7wwj2"
Content-Disposition: inline
In-Reply-To: <YvOXPOidrbySvFwZ@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vmv57ibkudm7wwj2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Wed, Aug 10, 2022 at 12:32:12PM +0100, Lee Jones wrote:
> On Thu, 04 Aug 2022, Tinghan Shen wrote:
>=20
> > The System Control Processor System (SCPSYS) has several power
> > management related tasks in the system. Add the bindings for it.
> >=20
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 67 +++++++++++++++++++
> >  .../power/mediatek,power-controller.yaml      |  2 +-
>=20
> Sebastian,
>=20
> Any issues with me applying this?

No issues from my side, but I only handle things in power/reset and
power/supply. The power domain related parts are usually handled by
the SoC maintainer, i.e. Matthias Brugger in this case.

-- Sebastian

--vmv57ibkudm7wwj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLzqgIACgkQ2O7X88g7
+pplsQ//ZfSJ5/za7EWKT8zgB16un9iktfuKPLwTAwtR3u8YHSppWNyWtyBziJG6
t6pM2qpCGNNocw0wdP3KimWTBp3pLALaRE042raxDxKOKxKAn7ZYhYcxFQhFVaaR
KTG8mvfFCW+2EwbFXGId1v730W+nfETk/8IgRS5aqUnP0B/s9Yot4q8ehyzPP/4o
8fEWm38pzxIPVDKJC6FajFFJBehozxSvd2ukodt/eQzZ1j+OeZ8NB3gKpPOCDgm2
4qX/mFLDCsL7Ru3sdh2NJhblo/MzWn05nlXvIUJMYHKwMg1UaUDmnWBu18d3h2Bi
3iRwTmuxKitm+P4B1tykugUR6npZkx5hItlji+a3qKgTwhWvBSYiJJg7mMUOyTjW
ZdacoZdQwG1Pye8opVpYO14iz3qOWAFNJEgd4PWeQhuSg/w494wzy1SXzu9K7zct
z+sZEOEO8EHpkvkMsonIcZyl/GTOpeyIeQ7/2nGRHP0Tt+XkVovcbV1j+9s3KU2N
0PN9vRGRCwGr5FBcvwOVCr+i2bdZgZqPttMTiePAhYXpE2yZWYzYZ/KeBauxGGOa
yhsq0dmX37VBO9WeMcJVnDA5x2hDyM9s40jFRSowkHOKKur+GKVM2uIZDTcHx+Eh
2QshyHefaB3BpL3Qpc+tV0LXx17f4/iJeB7gf8IiEnxn8dW86Q8=
=S5X0
-----END PGP SIGNATURE-----

--vmv57ibkudm7wwj2--
