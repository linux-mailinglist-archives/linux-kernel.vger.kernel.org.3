Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643E65204CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiEITCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbiEITCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:02:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77493229FC5;
        Mon,  9 May 2022 11:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56198CE1B2C;
        Mon,  9 May 2022 18:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70CFC385B8;
        Mon,  9 May 2022 18:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652122691;
        bh=ICjgh2SHUAfsGyKVspdhXwxyeTpLD0tJ1XV/0qJNQgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNOfUt66xaeB9Y2OieOzu+BQCMSPIV/o++Q5uNjXXxOojRb/2rqrD3qCl/8GGhLme
         5PlW3HJImr989z4mRU7QMmV9LiewWaF5y7dwYyx/QCMAZW6DthHimUk72B9J4511Zy
         WZTLc0SuSP+HuRDnWvmjcAVIFNvhXrJZcL+kr1v2nt3uE5bvk77F+CzG8PcSVAiHS9
         ndIgjQsAQDIcTPurHpY8UVc4ru68mDkI1hsAsUOlntkZawahJEYsjkhv0/hXyraBqz
         0AqI5h3DlQFMz8agBSVk/tonMQCA7dBYiTn/jqkQ49wHDIrJGTfWNhbP/Q3c6nDz8+
         SUOMymOk6L5kQ==
Date:   Mon, 9 May 2022 19:58:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Revert "ASoC: dt-bindings: mediatek: mt8192: Add
 i2s-share properties"
Message-ID: <YnlkPTUqcoRk0pNv@sirena.org.uk>
References: <20220509185625.580811-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GjheQb+H4dAxuUfA"
Content-Disposition: inline
In-Reply-To: <20220509185625.580811-1-nfraprado@collabora.com>
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


--GjheQb+H4dAxuUfA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 02:56:25PM -0400, N=EDcolas F. R. A. Prado wrote:
> This reverts commit e056cf4341ae3f856f1e38da02b27cb04de4c69b. The commit
> was merged while the property name and definition were still being
> discussed. Revert the commit for now and a follow up commit will re-add
> the property after it is further discussed and reviewed.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--GjheQb+H4dAxuUfA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5ZDwACgkQJNaLcl1U
h9BBOwf8DEntKvg1X9xyFzUILjpwaenS8uKLDQGKJ8FH2tF11PeS9kYPLUbP9twY
qWF7VO5OYA4wPhBnLf5Ivc2fNWgr0so+LCY4scCEQMxsn9udS+FfRTlBAPx2kfPj
GwrnQtj59gWQrt/9dbe4RZ1JNcPU471ghlaXqPacg+wNQRqcRVdcPtAn4G9uBHxm
rYPBGIcCyMV1hKtPAGfirZ7F6Py1G/DFCKAvXC/huj9nFWsvNOb5uiFnkXZDTlQX
OooS9UNpAbe5uNG91MoRx8lBxHLc6WNnDwFxUVcF5O234cIRI6uNm25qlYQTzgD6
MJOe9k1CWfsum8VGBztL5mYqwi/IQg==
=/Syt
-----END PGP SIGNATURE-----

--GjheQb+H4dAxuUfA--
