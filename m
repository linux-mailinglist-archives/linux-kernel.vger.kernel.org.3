Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F988580B96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiGZGZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238065AbiGZGZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:25:15 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 23:20:52 PDT
Received: from st43p00im-zteg10073401.me.com (st43p00im-zteg10073401.me.com [17.58.63.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BEE2FFE3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1658816001;
        bh=yRHmeERdlt7oqcGU/fHpnGc2WxHp6d3zjEXgoabUAwk=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=aX+M5MX+VDddd7H88p4TecgeHOpVuobIXQ+gzJ48svYqMd/DyJwJBvhMzz32ryFMr
         uCuEoksObANKG4RBhNqtAqqDmGNhwJmBF+txMZa72GJpwfDRAF1rUgcbBdKZ/pNfrg
         6OklwSQwkAvNT+Yf9kdnAcHwDj1gpYp2rcjUhQsgF9J/KQRwMu+9Rfcl5zUtCAiP92
         vh1PLmSRqkRoUyM1TLk7kFt7xttqmUxU0rDkA4RkzXPagx70Rb5NDg6grg7KqiIyM1
         pKAQszZOLLg1C+UJjjZaroeIQ7LEytpXS78KFlSqSQ7ZuAbWkIs4TdOW7qoguBjmJS
         i0hGGOSXKEx7Q==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10073401.me.com (Postfix) with ESMTPSA id 4172DA80313;
        Tue, 26 Jul 2022 06:13:20 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Vee Page <takeiteasy27@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] Add SFC support for Ingenic SoCs.
Date:   Tue, 26 Jul 2022 02:13:18 -0400
Message-Id: <38D8BFA7-21BD-4DC1-8B6E-68FC1766B6A8@icloud.com>
References: <D7ACE3CD-3189-4988-BB44-F32514C70425@icloud.com>
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
In-Reply-To: <D7ACE3CD-3189-4988-BB44-F32514C70425@icloud.com>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
X-Mailer: iPhone Mail (19B81)
X-Proofpoint-GUID: Ll-uXQn0_l-BYjG1NU7j_qT7ADjy8jrB
X-Proofpoint-ORIG-GUID: Ll-uXQn0_l-BYjG1NU7j_qT7ADjy8jrB
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2020-02-14=5F02,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207260023
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y=E2=80=99all stank nasty bitch ass niggas don=E2=80=99t have nothing else t=
o say?

What now mother fucker is it past your bedtimes?

Go society a favor =E2=80=A6..go to the nearest bridge=E2=80=A6and jump in i=
t.

Y=E2=80=99all can go continue your conversation six feet under. You sick stu=
pid fuck.


> On Jul 23, 2022, at 9:32 PM, Vee Page <takeiteasy27@icloud.com> wrote:
>=20
> =EF=BB=BFNo problem!!!
> I forget to tell them. It=E2=80=99s okay though! =F0=9F=91=8C=F0=9F=91=8D
> =F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=
=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=9A=F0=9F=98=
=9A=F0=9F=98=9A=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=
=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=
=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=
=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=
=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=
=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=
=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=EF=B8=8F=E2=98=BA=
=EF=B8=8F=E2=98=BA=EF=B8=8F
> I=E2=80=99m blushing! Last night was fun.
>=20
>> On Jul 23, 2022, at 9:30 PM, Vanessa Page <Vebpe@outlook.com> wrote:
>>=20
>> =EF=BB=BF=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=A5=B0=F0=9F=
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
>>=20
>> Omg thank you Janika!
>>=20
>> I=E2=80=99m glad to see everything is okay just tell them next time!
>>=20
>> Love ya babes!
>>=20
>>>> On Jul 23, 2022, at 9:27 PM, Zhou Yanjie <zhouyanjie@wanyeetech.com> wr=
ote:
>>>=20
>>> =EF=BB=BFHi Tomasz,
>>>=20
>>>>> On 2022/7/23 =E4=B8=8B=E5=8D=8810:47, Tomasz Maciej Nowak wrote:
>>>> W dniu 22.07.2022 o 18:48, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) pi=
sze:
>>>>> 1.Use the spi-mem poll status APIs in SPI-NOR to reduce CPU load.
>>>>> 2.Add SFC support for the X1000 SoC, the X1600 SoC, and the X2000 SoC f=
rom Ingenic.
>>>>>=20
>>>>> Liu Jinghui and Aidan MacDonald provided a lot of assistance during th=
e development of this driver.
>>>>>=20
>>>>> =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (3):
>>>>> mtd: spi-nor: Use the spi-mem poll status APIs.
>>>>> dt-bindings: SPI: Add Ingenic SFC bindings.
>>>>> SPI: Ingenic: Add SFC support for Ingenic SoCs.
>>>>>=20
>>>>> .../devicetree/bindings/spi/ingenic,sfc.yaml       |  64 ++
>>>>> drivers/mtd/spi-nor/core.c                         |  42 +-
>>>>> drivers/spi/Kconfig                                |   9 +
>>>>> drivers/spi/Makefile                               |   1 +
>>>>> drivers/spi/spi-ingenic-sfc.c                      | 662 +++++++++++++=
++++++++
>>>>> 5 files changed, 768 insertions(+), 10 deletions(-)
>>>>> create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.y=
aml
>>>>> create mode 100755 drivers/spi/spi-ingenic-sfc.c
>>>>>=20
>>>> Even tough it's still early in revision process, I'll add my
>>>> Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
>>>>=20
>>>> The test was performed with Damai DM6291A SoC which is a Ingenic X1000 I=
P
>>>> but with 256 MiB RAM. No bugs yet observed on my side.
>>>=20
>>>=20
>>> Thanks for you test!
>>>=20
>>>=20
>>>>=20
>>>=20
>>> ______________________________________________________
>>> Linux MTD discussion mailing list
>>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
