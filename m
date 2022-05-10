Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F0D5213DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbiEJLiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiEJLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:37:27 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADD54738B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:33:28 -0700 (PDT)
Received: from ktm (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5C5D184245;
        Tue, 10 May 2022 13:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1652182406;
        bh=ZFo927e5FInTbURE9yWoxLxrY0CAVoAwYdbjul31wsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H8XhQxHadPKetSG5ktZXFJgUXytoZ5rqH6ZHBXorAJO0s8MoZtrJMmbXcQNeAqNEt
         S1RbjPuGi0mFIFfxvRYP1cJS7YW1yElGv/eLV+qQyDFrT4K33kBLvkVf7pBj0ih0BY
         KEnSYGC7iDiUq3skG5oIdaUr120T1XSigkUVJS68vsfPsq6+jCIxfnnM/2AxHGRrqF
         DOlO26ax2r9Hiw9JeQoyQ2GwL4epK8j/4bPA6Pz9AOWBKZiNxvUpPalcQrCHCw0JT9
         Uqhr0dzaqTGsBFxvFQxAH5sptt5cKDA20rbxUcRb6rYEIy+kzz2S5mE0RDjY8KNSZy
         wlixoikveI2GQ==
Date:   Tue, 10 May 2022 13:33:20 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] ASoC: wm8940: add devicetree support
Message-ID: <20220510133320.52f1f934@ktm>
In-Reply-To: <YnpI7CTiXzCYn918@sirena.org.uk>
References: <20220509121055.31103-1-lukma@denx.de>
        <YnkxIe1nVUiKNmdq@sirena.org.uk>
        <20220510092438.528ef474@ktm>
        <YnpI7CTiXzCYn918@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/CzcUOznd1uIj3ksgQ3evhl3"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CzcUOznd1uIj3ksgQ3evhl3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Tue, May 10, 2022 at 09:24:38AM +0200, Lukasz Majewski wrote:
> > > On Mon, May 09, 2022 at 02:10:55PM +0200, Lukasz Majewski wrote: =20
>=20
> > > > This adds devicetree support to the wm8940 codec driver.
> > > > With a DT-based kernel, there is no board-specific setting
> > > > to select the driver so allow it to be manually chosen. =20
>=20
> > > You need to provide a binding document for any new bindings you
> > > add in code. =20
>=20
> > The second patch in this series adds proper *.yaml file to Linux
> > source tree. =20
>=20
> You didn't send the patches as a series, you sent two separate threads
> so they got totally separated in my inbox.  I did eventually connect
> them.

Thanks :-)


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/CzcUOznd1uIj3ksgQ3evhl3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmJ6TYAACgkQAR8vZIA0
zr16Mwf7BLc80ZONSnv7u0SrL/p6P7EKRzUbTFz3niaxGTph6E38ggtVgyNhm0L3
ll229or66g9c3e2zjkccHaWLceyrn6nladyy1oczecQSrJLYazBmzjSJZkJO9tMG
4N/ofOslQzJ5mlIrYTEZu8gVSNdl0k52Vxu1aHXHaf5sfRYLbwVc/wkrd1zvxg9T
MqCXmJuYXA78bGTfqVeW8HP3jbmtHVBM3nq2S2ujW6ucT/ZzNThyTPr2g+ZnT7kc
dG2s+lNla5+l38z4ABLxtBYO/r90fYiYz0V0ht38sYRkuvbRbayjxHxacXjUaU5M
KHNRLUNSr3yy9dnA2Yb/1z1yP+gAkQ==
=3UW/
-----END PGP SIGNATURE-----

--Sig_/CzcUOznd1uIj3ksgQ3evhl3--
