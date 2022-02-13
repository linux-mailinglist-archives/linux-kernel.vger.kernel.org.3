Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5F4B3DA0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiBMVC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:02:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiBMVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:02:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9168C53723;
        Sun, 13 Feb 2022 13:02:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jxfv62xf6z4xPv;
        Mon, 14 Feb 2022 08:02:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644786162;
        bh=zipA24rISKzacmzNZHflBti7PV9p/DiTxPRCpOoQHQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MXaZHmaewY7lnoQ6vJlQ0LEr3wh/sDxBxDM4yQdyAZqtrknsRVXiapmtYs0UyyHeR
         /hXyS46ePJjRgs4uwemgQBEkDqRKWh8dU9HpIhqRTxrd5SC6xhdZORK5zd2GRG0zYR
         HtO3bTe77P3hs//BzG0Wb40AsiTqvyEdh7bdUroemP8O22EFvcsX+t6lrAB+MTFeVG
         tTuOo+4cYmHYRiWAkSt99otE4V1PMex8PxLe+gBS/RT4KdaAgsuSwqp3yAtBpjbiJ1
         Z91p7RrO+qBzKNQrBlu3mlzlxiQNOuqksAZ7EwMasCzCgntJTiLn6G0WQlNlw0HUwS
         dnhEdjggNDfmQ==
Date:   Mon, 14 Feb 2022 08:02:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20220214080240.60277d85@canb.auug.org.au>
In-Reply-To: <CAOX2RU5NzOK+d-QEMsOiSPX85M2_B44SeJUteZepsyZny7fgnQ@mail.gmail.com>
References: <20220213213935.2c5ef8c2@canb.auug.org.au>
        <CAOX2RU5NzOK+d-QEMsOiSPX85M2_B44SeJUteZepsyZny7fgnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3j5HSC1iskQoDEo97m.iwuu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3j5HSC1iskQoDEo97m.iwuu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On Sun, 13 Feb 2022 12:52:45 +0100 Robert Marko <robimarko@gmail.com> wrote:
>
> Sorry for the short hash, don't know how this happened.
> Do you want me to send a v3 with the fixed hash?

That is up to Andy.

--=20
Cheers,
Stephen Rothwell

--Sig_/3j5HSC1iskQoDEo97m.iwuu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIJcfAACgkQAVBC80lX
0Gwecgf+KsvzhW5TMBKaAkTZSKq/hrA0C+i9zPUr+lg2ccXabUUR5aqBoGRl1Nnj
N206Q9k0KqWQ+Oa7AIU9HDPtrEcL2n/0iOZZX2MuZpX/M49y+zjUCd1wVWqhuiOx
tBjj8QL8XMGwI3g+mgB+kXqUmTKXlywMwr4v55Z5TKMm2EZUSlnAoWb8gr6eLs81
wq/yIOLf+7n+ZJIm8r5sYGeOmCs/iD/P62PZbmbpsrqUYr99JoaDynyEK9aE54jW
tOndconjg64dIuvTbik5q0bqiH6SHn/mJhl4kARDDDwKqmH4RNvB02DCmBa5uhR5
oIGuAG3dOcoqI3kMpOhs9fLqpTOe3Q==
=rFAl
-----END PGP SIGNATURE-----

--Sig_/3j5HSC1iskQoDEo97m.iwuu--
