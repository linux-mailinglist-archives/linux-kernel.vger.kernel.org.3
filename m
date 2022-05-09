Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE952046B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbiEISXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240150AbiEISXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D28213C4FE;
        Mon,  9 May 2022 11:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADDFA61627;
        Mon,  9 May 2022 18:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3FBC385B2;
        Mon,  9 May 2022 18:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652120377;
        bh=sEtyjmgOrjIs5NYv5HPC0xk/tdYrRW3tbsJDYBclXYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxjxEobBOscR/f/wqE5KqFFibxHBYEbMltpkRKBAnS7TIDyAfo31CyGMDkGQg/3J2
         CSgYm/b4Um//Ob7QXYzVoPwq7Z+JBR8dbsnNgYaeueJZy8t17DNMQygwvpK3Ztd4sp
         iqilsKMgPqHknWIpd4XUmv70r9KdcevXWafnn9Kxcc4NQn0UAwBjC7LxSYF0TC0gmK
         qL4VqlqrmaY02ut3JmWVbdGokASWh1yIDvabGmSm3M115Vb5a1oR0FMSqdD65VgbO7
         atMKHSrq1S2Ghayfh4VZYne1f6GlRhNOm8OTjChJMqHU6gc4Hf6nbzZyDnK2jaYSap
         Q7aUkUZatZjPA==
Date:   Mon, 9 May 2022 19:19:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jiaxin.yu@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, shane.chien@mediatek.com,
        linux-mediatek@lists.infradead.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, kernel@collabora.com, tzungbi@google.com
Subject: Re: [PATCH 0/3] Add missing dt-binding properties for audio
 components on mt8192-asurada
Message-ID: <YnlbMjTEORFSbxXS@sirena.org.uk>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
 <165211666198.1065748.1151009730882312510.b4-ty@kernel.org>
 <20220509181629.ettskdxfvwvqaq76@notapiano>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4y1TD9hR4+zXz6BZ"
Content-Disposition: inline
In-Reply-To: <20220509181629.ettskdxfvwvqaq76@notapiano>
X-Cookie: Boycott meat -- suck your thumb.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4y1TD9hR4+zXz6BZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 02:16:29PM -0400, N=EDcolas F. R. A. Prado wrote:

> this series wasn't supposed to be merged yet, I'm in the process of prepa=
ring
> and sending a v2. Well, for patch 1 at least, which needs some improvemen=
ts
> still. Patches 2 and 3 weren't going to be changed, so those would be fin=
e to
> keep merged if you want.=20

Please send a revert for the first patch with appropriate changelog if
you want it dropping.

--4y1TD9hR4+zXz6BZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5WzIACgkQJNaLcl1U
h9DR5Af/TprbNPs5eG3YL7V+LKRWqR7r5/vg4Mv3tT5GnibQHJMnJKNy2UouZxTo
rkacxPv3r1VyUUeK8zHUkyzJrNx2E3UkAlpZ1lwC/HERm66keB5ugaBQpSDEj9/p
ACsF6I1K/fAJq4cwI0vhDWWUXG5Ha0veDao+qfUaTVOyn4EsHCB21OBnsJFRTuLN
26cIS9fHHyxKc055J2rLi4LqpTdxVOuuuJXkD4ScZmflZkEfH1Nea8JMeCnPnXXy
AANm+RFzCi2lMMAO8BCv8PQCbuDxJHXCbx71WenqSS0Cd+r3VlGv5u19fZRGuv0z
k8nbklED1MQtWoNvx67Kz6aY9MpB1w==
=BxKV
-----END PGP SIGNATURE-----

--4y1TD9hR4+zXz6BZ--
