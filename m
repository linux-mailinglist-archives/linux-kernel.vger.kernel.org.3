Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C168F57F293
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiGXBkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGXBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:40:20 -0400
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Jul 2022 18:40:19 PDT
Received: from ci74p00im-qukt09081502.me.com (ci74p00im-qukt09081502.me.com [17.57.156.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D9EA461
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 18:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1658626325;
        bh=GsdFZK4oQNZWNc6BXkPULWSnbkpQG2ue3MdM2e30/GQ=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=0CptV9Iz/vhCxOz+MlOz1/Go5VCVLeDJ2h0pg7LmemPmrBHCrtetn8oqlaqsgIwqq
         looD+9jRM6S3CV+hpiFh4iRqCD/A70nflY5gK3X8GhlcjLi6lEmi6iWK32/0kIhudX
         XqftYSYdWc6stW2ougQ1PP3rmGiqhEMCLpyGAaK42G+R3HVpXnoNXupzUluP33aP9X
         Qfi7bKp4merH8SYr+I+ITSSHyi2GYSM/dPDhEzWVJJZLO7e3K2d2PgGD+coR81M4ZJ
         zSRf25jyzIQjyTGjfnMFNceP90tfdwq9kwq0WtyY01VrUsfonkMlfKoKjy+QcThJP8
         YawddyCMIsEdA==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
        by ci74p00im-qukt09081502.me.com (Postfix) with ESMTPSA id 776E228400F1;
        Sun, 24 Jul 2022 01:32:03 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Vee Page <takeiteasy27@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] Add SFC support for Ingenic SoCs.
Date:   Sat, 23 Jul 2022 21:32:01 -0400
Message-Id: <D7ACE3CD-3189-4988-BB44-F32514C70425@icloud.com>
References: <MN2PR17MB33758BDD0221A0C49A13DC3DB8929@MN2PR17MB3375.namprd17.prod.outlook.com>
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Tudor.Ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        aidanmacdonald.0x0@gmail.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, jinghui.liu@ingenic.com,
        sernia.zhou@foxmail.com, reimu@sudomaker.com
In-Reply-To: <MN2PR17MB33758BDD0221A0C49A13DC3DB8929@MN2PR17MB3375.namprd17.prod.outlook.com>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
X-Mailer: iPhone Mail (19B81)
X-Proofpoint-ORIG-GUID: L2zjtVGRKGpQPmIocJ94RIVCaPPsaP4E
X-Proofpoint-GUID: L2zjtVGRKGpQPmIocJ94RIVCaPPsaP4E
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=855 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2207240006
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No problem!!!
I forget to tell them. It=E2=80=99s okay though! =F0=9F=91=8C=F0=9F=91=8D
=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=
=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=
=F0=9F=98=9A=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=
=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=
=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=
=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=
=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=
=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=
=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=
=B8=8F=E2=98=BA=EF=B8=8F
I=E2=80=99m blushing! Last night was fun.

> On Jul 23, 2022, at 9:30 PM, Vanessa Page <Vebpe@outlook.com> wrote:
>=20
> =EF=BB=BF=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=
=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=
=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=
=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=
=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=
=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=
=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=
=A5=B0=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=
=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=
=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=9A=
=F0=9F=98=8D=F0=9F=98=9A=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=
=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=
=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=
=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=
=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=
=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=
=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=
=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=
=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D=F0=9F=98=8D
>=20
> Omg thank you Janika!
>=20
> I=E2=80=99m glad to see everything is okay just tell them next time!
>=20
> Love ya babes!
>=20
>> On Jul 23, 2022, at 9:27 PM, Zhou Yanjie <zhouyanjie@wanyeetech.com> wrot=
e:
>>=20
>> =EF=BB=BFHi Tomasz,
>>=20
>>>> On 2022/7/23 =E4=B8=8B=E5=8D=8810:47, Tomasz Maciej Nowak wrote:
>>> W dniu 22.07.2022 o 18:48, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) pis=
ze:
>>>> 1.Use the spi-mem poll status APIs in SPI-NOR to reduce CPU load.
>>>> 2.Add SFC support for the X1000 SoC, the X1600 SoC, and the X2000 SoC f=
rom Ingenic.
>>>>=20
>>>> Liu Jinghui and Aidan MacDonald provided a lot of assistance during the=
 development of this driver.
>>>>=20
>>>> =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (3):
>>>>  mtd: spi-nor: Use the spi-mem poll status APIs.
>>>>  dt-bindings: SPI: Add Ingenic SFC bindings.
>>>>  SPI: Ingenic: Add SFC support for Ingenic SoCs.
>>>>=20
>>>> .../devicetree/bindings/spi/ingenic,sfc.yaml       |  64 ++
>>>> drivers/mtd/spi-nor/core.c                         |  42 +-
>>>> drivers/spi/Kconfig                                |   9 +
>>>> drivers/spi/Makefile                               |   1 +
>>>> drivers/spi/spi-ingenic-sfc.c                      | 662 ++++++++++++++=
+++++++
>>>> 5 files changed, 768 insertions(+), 10 deletions(-)
>>>> create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.ya=
ml
>>>> create mode 100755 drivers/spi/spi-ingenic-sfc.c
>>>>=20
>>> Even tough it's still early in revision process, I'll add my
>>> Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
>>>=20
>>> The test was performed with Damai DM6291A SoC which is a Ingenic X1000 I=
P
>>> but with 256 MiB RAM. No bugs yet observed on my side.
>>=20
>>=20
>> Thanks for you test!
>>=20
>>=20
>>>=20
>>=20
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
