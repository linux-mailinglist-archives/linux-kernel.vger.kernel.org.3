Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7730051E8A6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446678AbiEGQyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446665AbiEGQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:53:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01271205FB
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 09:50:07 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 247GnxXr103922;
        Sat, 7 May 2022 11:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651942199;
        bh=WUG61tWhXrM8j8Y5RTXpv668W5wE9p5I0V9VLwC9u2s=;
        h=Date:From:Subject:To:CC;
        b=SWCtgObFp4KvXtE/kAzefhJfYhvHkRQ9Nxu3Lq2K78gLMy7Fymr68Fgs53Q3tS/0l
         nFwrfWhqv/d5Hn//kVZfl14myopn95uzmQjwRzg+80GX56bQRuEVKaav4sDyqwgE33
         DPSeNvTDuprLTTKVgjQaJ9DLa1nQDbrGIQA47X0w=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 247GnxHu027647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 7 May 2022 11:49:59 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 7
 May 2022 11:49:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 7 May 2022 11:49:58 -0500
Received: from [10.250.232.100] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 247GnsJR010362;
        Sat, 7 May 2022 11:49:55 -0500
Message-ID: <88cd734e-47a7-4307-c119-8f6ec6c40452@ti.com>
Date:   Sat, 7 May 2022 22:19:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: [GIT PULL] TI K3 defconfig updates for v5.19
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc <arm@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        SoC <soc@kernel.org>
CC:     "Menon, Nishanth" <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="------------Dqbvdhn0vzaneJUrNPtm6nSp"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------Dqbvdhn0vzaneJUrNPtm6nSp
Content-Type: multipart/mixed; boundary="------------me9XVEwUocRrF21hisKjPrR0";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 SoC <soc@kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <88cd734e-47a7-4307-c119-8f6ec6c40452@ti.com>
Subject: [GIT PULL] TI K3 defconfig updates for v5.19

--------------me9XVEwUocRrF21hisKjPrR0
Content-Type: multipart/mixed; boundary="------------FffNF5V4Aanz6E2JyPdBf06m"

--------------FffNF5V4Aanz6E2JyPdBf06m
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc=
17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-config-for-v5.19

for you to fetch changes up to b7d8a9973374e57a85e7296f429f50770ca68000:

  arm64: defconfig: Enable configs for DisplayPort on J721e (2022-04-27 2=
1:06:15 +0530)

----------------------------------------------------------------
TI K3 defconfig updates for v5.19

* Enable TIDSS and Display Port related configs
* Enable Cadence Torrent PHY for Display Port

----------------------------------------------------------------
Rahul T R (1):
      arm64: defconfig: Enable configs for DisplayPort on J721e

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

--------------FffNF5V4Aanz6E2JyPdBf06m
Content-Type: application/pgp-keys; name="OpenPGP_0xF903332F551A78E9.asc"
Content-Disposition: attachment; filename="OpenPGP_0xF903332F551A78E9.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
dzayyqRY3caNHPU1pnHtwsFzBBABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0F
Al8dkqAACgkQ3bWEnRc2JJ16whAAiFFo36qIL9ROGUUENx6NdOvQuZ+8miQgVKII
EKTA7lTazQ+DUKgrEpjvca16ujoc2wYzfVf6XsFby1XFfQmHEIJLQJEo3MJruIqy
M8vCUwiKHj5K9Mt5Xq2zXR7Qj3OFodUP/XkqFlGar+lT9LiFMglBaE5xG1T7DOEN
l24AKbACSBRLEstlZS2akFyHtoHW7NV8I/7xwypgU72yNKHCFii84Qbw7nKUeMnl
csDPafxrb+28/tDR6gx/c2DHzcIFlLOAPMn+AqFQBXRccqvYi2eN8N9I+hjIQgm7
NthQwLgVEWvWEmEU/iqi1Of/aHXkXqppJ/wYPMpbOhcBuzXIWkio21nSenRYnbbn
3E6yEf+MPxGco9Oph+TJZ+QqwthntubBF8EvmKQI+BgCjZazNeeUZNZkzwDRy3PD
6UCLEZw1+yzvxZUTRIKJ+Oh83XpDd5ikbJlKw8YDT8aNEdw4hCquibLMVat8vXp8
QQX9f1KCXQCezNWudyOKpd6VqpilXNzBXlKY5pYPRyYSCdqCS4FPmgy+p0rSmxWd
Idj5o9a/HUFcGEft0VI3Z3nRJhVVki2HhENtMVjp5x9RmuwBxRyFv083vSyKmQCq
9fTjIRoJYr1NQMB2itjc0nWQeok5VUSbB7yF4wdnIE/ZxlSYFPuHnb8PGvBQm+NB
3GEjCF3NKVZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQGtlcm5lbC5vcmc+
wsGUBBMBCgA+FiEESlpxHo5+RPnxLyz6+QMzL1UaeOkFAl3BCR4CGwEFCS7+ECsF
CwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ+QMzL1UaeOl+iA/+Kjif2p9LVDje
36EguByuKPGrIu01QMYWhxS0bSuXCq57am7M4/sIZNvhFJTro31BcVHS4lwVofEy
IwNtq3qDFYQPbw65oxTDltRGzqceMtNbUvZGyOhmmoeAHz3Z4F2lFZqszlB7+Wgb
zaC+OtGnjPP/1YXrjBDDLvmsZBUGIxSnpjwuYgqhYImMXtRVAyAta9hiQ9CIx2GA
krczU9iwGDnTcHqK5v7PK6K8nNc4ATRaGR55M2dBX2g+2tXs2F1vNhcb4PXbyX7h
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
GJNVJcTcoQm87b8LAkYrmlob7AjOAg0Xezz3
=3DvYBn
-----END PGP PUBLIC KEY BLOCK-----

--------------FffNF5V4Aanz6E2JyPdBf06m--

--------------me9XVEwUocRrF21hisKjPrR0--

--------------Dqbvdhn0vzaneJUrNPtm6nSp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmJ2ozEFAwAAAAAACgkQxEYeRXyRFuNP
8Af+JVx4Coh+nPvzfHIiPFSlDYUSUeUNNIJsRtkfsNU7/YAhsxbW/kZFMVFS/WjJD6oBEPqf6zoU
Y1CjhhEV/OD3S/gfC7ghB2QKLO0CR88IUWO6v4By9P6m8ov8FsmArczQS5E0zO/KKxu8Lk6qzfGS
/pkOVCRoSQ7qbEfmT3e9ga1FKsazGB1PzeYFrcEoNQ82JpJHzC4/Nk5VPLLflC6bSKxAmrC0qtap
puCkx89xGC5BE4eJ8VepBxI+r2iueGiaNoqr/ujT23wfRAcOMCHAJgeBraiwfW0cmNI5G/FDtK1A
B7k3xR6g2fyyw1+9YwIZ2MqUvNVpGvu1xaaaY4Mt+g==
=zH/E
-----END PGP SIGNATURE-----

--------------Dqbvdhn0vzaneJUrNPtm6nSp--
