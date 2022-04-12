Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A922E4FE012
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbiDLMP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344427AbiDLMON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:14:13 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2485BCA;
        Tue, 12 Apr 2022 04:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649762107;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=LAJfLx6J2WmZC4bb1+JwTUQAf3iNcvFDt6K/GjnBeyo=;
    b=i1+808ypX8DaCa2FQHHrzR2cUPVWbCJQbQR37xzwCqFyRjK/hyEo+6sZb3nZbBAR9I
    S3qa/W9a4pw1J1Sb5tcBB+l0KYkq+bu4/plZytXmxSiGshI6lN9a2dFx/cCnu8aZr/Hw
    UV6WTx4PW7VFDGAsK3oQpg36h6j0abq7DUaFCBBctI9z1Ff4gjFSpEP5sZx8SRaROiTk
    R8VUnKVbnWHkrgXMd6HRHrvbsQ1zMRkBvMzNbVuQeMXtE61uEkPcbWaDqUbxRsqJ3Deu
    0bXI/lwiAJypVETla80H5TAoHy6x9nj7n7XrSxr2ntn98rafoycluCFUw6TyUmunFTPw
    lbzQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3iKs="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3CBF74I3
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 12 Apr 2022 13:15:07 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <3e088e18-5df9-bf50-0070-b24b8a3c5f41@wanyeetech.com>
Date:   Tue, 12 Apr 2022 13:15:06 +0200
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3649C5AE-FDE3-49B4-9A70-431506F78AB7@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
 <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
 <822182F3-5429-4731-9FA1-8F18C5D95DEC@goldelico.com>
 <535e3eab-a28e-46f3-2a7e-f1ffd1913470@linaro.org>
 <7B66AC66-EF73-4F75-A775-589A4F98BEFC@goldelico.com>
 <3e95f567-03f5-bf9c-1856-9fe602e9b025@linaro.org>
 <81BA49E3-AFDE-4DFD-BB77-2B03488C727B@goldelico.com>
 <b6090a27-12b7-0c01-6d33-ae32b31b4b74@wanyeetech.com>
 <8FA36CE4-CD39-4767-B49E-D112E4313036@goldelico.com>
 <3e088e18-5df9-bf50-0070-b24b8a3c5f41@wanyeetech.com>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yanjie,

> Am 12.04.2022 um 11:49 schrieb Zhou Yanjie =
<zhouyanjie@wanyeetech.com>:
>=20
> Hi Nikolaus,
>=20
> On 2022/4/11 =E4=B8=8A=E5=8D=883:13, H. Nikolaus Schaller wrote:
>> Hi,
>>=20
>>=20
>> If you agree I can add "ingenic,jz4780-otg" to the schema file and =
keep
>> the .dts in the v2 of my series.
>=20
>=20
> Sure.
>=20
> Or you can wait a bit, I plan to send out new patches later today, it =
contains "ingenic,jz4780-otg".

Would be fine! I think you will be faster than me :)

So I'll check with your patch and drop mine from my v2 series.

BR and thanks,
Nikolaus

