Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4152652410C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349330AbiEKX22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349336AbiEKX2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:28:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265D720CA65;
        Wed, 11 May 2022 16:28:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KzB0g1Hm9z4xXS;
        Thu, 12 May 2022 09:28:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652311683;
        bh=F4a8cFIWYBgLdrztn/8QlwsOJpA1TPC1PSpSLZ/gjpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dCrsTU93W0iKh2tyyFdN5bgrKOsBsOnHxFo/+FAz0eFJ6LskoE1oFLGKmzZF05oA9
         Cxg4XShhGXh3iM6SpCZr9v3dbaYwBDR5UUpkvTi8ujoRBddTdW31mZpiDbGCzmG1cF
         nlzfzKx60DPeED8Gytr48pR57QodX4oBE2GSI2y/WcyFuX+4EVHmUFAyHvjB1XYQJs
         pqYW4OwLbaZHTxCPSkOrtYpHDG6iJVIxfFYTDLM5i40kL1WnATiCJslj4sPxr6MTwr
         yZdPrReY7z6Q1lDeuXGU5xkq15UeLStOkc6kXMEzow8cnQXx7n/7Ja8yoUDf9bfHsk
         Jz78kM/EToY3A==
Date:   Thu, 12 May 2022 09:28:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20220512092801.1e6b146a@canb.auug.org.au>
In-Reply-To: <0009a4cd-2826-e8be-e671-f050d4f18d5d@linux.alibaba.com>
References: <20220511181531.7f27a5c1@canb.auug.org.au>
        <0009a4cd-2826-e8be-e671-f050d4f18d5d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FnK09nfmWQXADwUYmVdoIlO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FnK09nfmWQXADwUYmVdoIlO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

On Wed, 11 May 2022 16:42:17 +0800 Baolin Wang <baolin.wang@linux.alibaba.c=
om> wrote:
>
> Sorry again. I think I also missed other ARCHs' changes. Need include bel=
ow fixes.

I will add that to my fix up patch today (unless Andrew does a new
release).

Thanks.
--=20
Cheers,
Stephen Rothwell

--Sig_/FnK09nfmWQXADwUYmVdoIlO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ8RoEACgkQAVBC80lX
0GwDvgf/YtjLd8xr7DxcW+LjsclqkCxwKvu9bXoI1lJ/obw4XJDlLxUurvQpWrMY
Cku5dU/dMmWZRIiKAdretcr+YcCK3BPp+HygCd6GQk19+zxFoboELW8H+ltdq9Gy
PRJ7yDx9I5fV7Nh/crE8CNcUjl86MYHReVpWkt1GaNZW/ClaasRpdTvMqIaUXEgp
/u5Q5s4UO6/RdK09pArp+16CMxb2vX1AddaJ6X+Phan5zYEOiWO4I/e+jl7TzJI5
PFA7g64fBuz8PT/uhcfQVFGGTqqyYkvazb3hGQZP6Ft1iR75QYm+VLyfxCtBSnSj
hMotFTarZe3XprVnYbbWrEawjpyc8A==
=V2oW
-----END PGP SIGNATURE-----

--Sig_/FnK09nfmWQXADwUYmVdoIlO--
