Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4252A36D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347863AbiEQNa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346577AbiEQNas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:30:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED9CD1;
        Tue, 17 May 2022 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652794236;
        bh=vpUV9wOtSPUGJtxRJdgmEOdR6486LJ4F1lsNX6U2vFY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fmvih9ItEss2nhIMKG7UHIL3h8oKGEd/VAyJONRqkxNVIDBaL6IoEdisFhj7ecnxw
         YklK4XW/wGQ0lfL75lQknRfiQoGCUwDCcTIlYxMQpe9Vha8BWCmWlERSkwLA/3+vXa
         ZE6iD/0/T9u8J6vwDuVtsJN9GmB7mF14385V53Hg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4z6q-1nj9nE1q8i-010qN4; Tue, 17
 May 2022 15:30:36 +0200
Date:   Tue, 17 May 2022 15:30:35 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Marvin Lin <milkfafa@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kwliu@nuvoton.com,
        tmaimon77@gmail.com, avifishman70@gmail.com,
        openbmc@lists.ozlabs.org, tali.perry1@gmail.com, kflin@nuvoton.com
Subject: Re: [PATCH v2 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
Message-ID: <YoOje2L13q7d7KeI@latitude>
References: <20220513033450.7038-1-kflin@nuvoton.com>
 <20220513033450.7038-6-kflin@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3VOuve4DtZAiUNkh"
Content-Disposition: inline
In-Reply-To: <20220513033450.7038-6-kflin@nuvoton.com>
X-Provags-ID: V03:K1:rKL42T5zEjvODk4r6oX+4i4mY93WAlOzL+FDn/ypxruZfyPLj5a
 eUWAhEo2/oTCnww0UsLUF7CLyWWtF+91Z2df60qRmU43CaG4Vr434fECQX4nHuBNL9aOMxl
 hrhRojxJQ1U5ow7zYLZeIkm+UlB09lrmBjfnUHKrd/jp4uttYwl4vsRkUMfAtuFf/TzCmFT
 H4qPX6guoCswUlz7UGUcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lh9R2Jw+6Gs=:hkV5MG59s0bTnmpS0R0VZF
 +AHlTvT83VZjmWOPBxcT38gDeXVE0SzotaEQluJrD1cel9yt88T/uXzVgsTJiJxFLRMqBwK7r
 ltw68nF+gapmEI7FuPPtq5LVAbxW+sumUzo8YyKXXFz89dTji/M0LccNTXt4ydqZZFe+S+Vs2
 nqt5kjGpb7km+RaNd+xnF3QqEN5ReoLjsp/eQDhcZIsOc60kjI7mMbTgB2IqSkCIn5PU0GWCM
 DV7OOQ96Ve/b/o1l+zPEDPWi+/lvu/gNmorqpPq7OIN7PQVyOr53b7Yo94tscuUx6epIslK6F
 LSKao2WxGu1x4kmqQ5GXzxDHsIJzbinaqBbnBi2XpzR7RAwr8rLb+/sf0YWlOCOBZHpTXpbCj
 jxm5y35xzBGLq/XSHSxtJ4wlhPfWBCBKd8OMgthhRPnT79bb2pBfSwA3322aNIngqMern/GPi
 fZYJwqeaVM+qvr3sVBGpl4fLz/FN/Ww/vlcIsizsaj/8UcxOweiZ00U3IEXETLmRK08I385VN
 OjATMiROzCystMpvM99/e51c4EFRjxTxkfNd1VayvJC6J1iFQN7u3ACcAHrqz02PNezXoD8QV
 4JfugPiYbbR5MYrQc+f2d9Ro7XnUiogf0RXXPI3PCjgD5VVtGegqBMsLKi7ZkLx98QPX03qzh
 7vVsoOMMhoAlf7YfMfgfu/nBMZVWB5JqLdhcgU6PmkkKrHaeZRdjalie8fWaGgm3EU/nwSJZz
 Zte51oRpaARRzObI5MrftpsvFMCLY/TARq6eCUppACaD4eP94mGhNnykzYVv5UDUTN5DcqBBo
 8kt3KolcYTwzZE0JkMZFbr038kxCDhP9pSPcecUicI0X+9zNnf/JyUn1W17aKP1ZTEGXumU16
 kw6FZ0W8WELSQTd2bDDoVm2Lggef3NanNFctjgnEPfoEARGEyCRzPqSsqsTsNXvg2DNuvixiY
 9DKMtbCNTMZBkXgNfeFGqepBaSXeXpL5RxVFyuyDgbI2cMQKDAqrxAn/E2sVxRT7dwe2a3Pfr
 3OOlTrsfE+RUqAQ/f/b6D5xD4aZMkmNuN8OIXYdoENIUoP69+PWRKzwGcUZEPXetdcva3B54o
 5ds8JrMWPnvfGb/hS6clecPr+GdUqyE+baX1udtTIE1wphg18mUKryL1A==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3VOuve4DtZAiUNkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

first of all, thank you for bringing this driver upstream.

On Fri, May 13, 2022 at 11:34:50AM +0800, Marvin Lin wrote:
> Add driver for Video Capture/Differentiation Engine (VCD) and Encoding
> Compression Engine (ECE) present on Nuvoton NPCM SoCs.
>=20
> Signed-off-by: Marvin Lin <kflin@nuvoton.com>
> ---
>  drivers/media/platform/Kconfig              |    1 +
>  drivers/media/platform/Makefile             |    1 +
>  drivers/media/platform/nuvoton/Kconfig      |   12 +
>  drivers/media/platform/nuvoton/Makefile     |    2 +
>  drivers/media/platform/nuvoton/npcm-video.c | 2074 +++++++++++++++++++

Similar to what I said in reply to the bindings patch, I would prefer to
have the VCD code and the ECE code in two separate files, if possible,
to make reuse of the VCD code alone (on WPCM450) easier.


Best regards,
Jonathan

--3VOuve4DtZAiUNkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmKDo3oACgkQCDBEmo7z
X9tGUA/9GUVxyvf/HAB4kiy11NzJXBaicRH/U2S6qRig8krgDAFPLqMEXqYjJ5/c
mSKzlkGvszm2+cL76YR68BZDM+FJh+S6Flgc4sHSzIC/2FQrFQGnq8eswjHb/75V
sbCOfv2NU8SUUJXcXzliAZGaINdUGRs3blj5FdjkVohne6UMg79Yf4ntZvaOMT2w
VfzGU0m6NwbCUuNutXwshMTcjtxZBvQVvn+Hrd8qSNHjGerOW1aDBWhqjZf+bwpU
3GqTKRLqZ0hCCWjuy5kwdfBUDzhAayDZDu3bGNETOe24nbpSwlw1XCIb4DFSYRER
5phoS7KMlqUrqKKK214EfACd10h49FI+XQo8LZmDksioKfV1OcQwgqw46ztoD3lI
WUNKdVvkZ7TPC1QQXqVvdU7ok6z8AHaTwj+k7r6UdfqzBVyUr37ubQs3Kd/EsvFg
i5x/POh9qRXQzvoNjmLph9IJStXjR+TrVJWpNrolg5CaCd/0EOuLT/hzOqPYa5Ru
sDAmUv67rJ1d0Fq4OYkTW0qMSL073gQN+pt49kMOQ5qrdR2CfQzAYkGj26fvvuSz
zkQN+yWhHLzk2/gU7NDhBupFVuINOEOCPvKZdz84RD2IZNmqGDlM6xbUO3Iqfugh
QpuHolZYKLxgylm6yRR8NC75gpt5S7ZSMrBY49+3FNWq7lMdrRU=
=chtA
-----END PGP SIGNATURE-----

--3VOuve4DtZAiUNkh--
