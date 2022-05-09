Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE55205E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiEIUdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiEIUdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:33:36 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326922C5108;
        Mon,  9 May 2022 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652127578;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=SBaBb5ku3Zc6QOsULhZnMQK6VkkGuN4gnq4axlkQKFk=;
    b=Dv8/bL2/NzmgNugIUYSykCh2WPTWR5OctQC9knBmSSpIiahEES7bbyYZ29iaIiP0fM
    B9bsoiefHhAuEgOTB1RQR3IA1ipkOaFlmizBgZaBCxsEIQBooV3Fm4AwbWVUEx0qJgj5
    mGoCGHyuCjT/WRHK9PjVlIjl+yeklJwY1J3ccdRdMUuXAxzYLSVGEgYCGTNNAFXGOlGP
    c56NQElTLt92NT93Z+Upg1deI3Dlwt6V5NHGPYkyXpXm6QpjH6UH5qLr5eJy40I6emPP
    bcXJ05azaQh7LAIis6pZeVjEYTk1eWMHm2EVXAihA2U+sqirFJ3nsLZXiM/gzZ870CLA
    TpqA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3i8IRUA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.44.0 SBL|AUTH)
    with ESMTPSA id e48d97y49KJb1Ld
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 9 May 2022 22:19:37 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: Question about SC16IS752 device tree.
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <04bd0853-7e34-5210-f1b5-f3ea8c35e484@wanyeetech.com>
Date:   Mon, 9 May 2022 22:19:36 +0200
Cc:     Paul Cercueil <paul@crapouillou.net>, jringle@gridpoint.com,
        shc_work@mail.ru, Rob Herring <robh@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-serial@vger.kernel.org,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <501852E6-6934-4BB2-850C-B53A07580568@goldelico.com>
References: <7c89db86-4055-90b5-6a67-611410f5759f@wanyeetech.com>
 <ZYNMBR.VDVV3VHFQBMO1@crapouillou.net>
 <04bd0853-7e34-5210-f1b5-f3ea8c35e484@wanyeetech.com>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 09.05.2022 um 20:41 schrieb Zhou Yanjie =
<zhouyanjie@wanyeetech.com>:
>=20
> Hi Paul,
>=20
> On 2022/5/10 =E4=B8=8A=E5=8D=882:13, Paul Cercueil wrote:
>> I can't say for sure that it's your problem, but your bluetooth nodes =
are missing "reg" properties.=20
>=20
>=20
> Unfortunately it doesn't seem to be the problem here, I added "reg" =
and
> the problem persists, and I've looked at other device trees that =
contain
> "brcm,bcm43438-bt", none of them use "reg", and "reg" is not mentioned =
in
> neither "Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt" =
nor
> "Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml".

what happens if you remove the serdev children from DTS? Does the driver =
create two separate /dev/tty ports? And do they work?

Maybe the sc16is752 driver does not separate them for child nodes, i.e. =
while "reg" should be added it may not be handled?

BR,
Nikolaus

