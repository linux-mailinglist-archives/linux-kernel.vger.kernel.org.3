Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AAE521EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbiEJPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiEJPim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:38:42 -0400
X-Greylist: delayed 69270 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 May 2022 08:34:16 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98DE208234;
        Tue, 10 May 2022 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652196674;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1DHdJO6w8eC1zqa5giyUkwICF7YwSt9WxYJVNosKBgU=;
    b=WrBLNbK/iZHgM3WyXFEv9bjn7deICFfpiIOXRkf/8/B0GTC2LCGL4nxgpX/wXdmfjQ
    KP4vhAn3An4ZXsgkorXmNaQvWwQt0j34ouWD6EXrRVu/kVUMTEf2D/+pxuNBnge/YIKl
    Mv+yZiDvax9BORutAAQt/MB0xJGJf4rmadFTqRqv8zq2ChEZYtu7V7Z7OqFp6iR1bcHt
    yP0VQIqNUWRCn8Wi3QaGzVHA3b8XfTfxbspiY1b/Kifx4TQPW+6qY/9ckQQzMCZG4XdV
    K7x/W5TwvANjIzKDga5lcJuyVD8JQaiQmlgOhxvtirWJTnOAON6QB1QKmDs37ZV8M1mW
    rtjQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDCocQ=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
    by smtp.strato.de (RZmta 47.44.0 DYNA|AUTH)
    with ESMTPSA id e48d97y4AFVD63P
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 10 May 2022 17:31:13 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: Question about SC16IS752 device tree.
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <8533f999-f584-ea31-0c44-1ce29c066d88@wanyeetech.com>
Date:   Tue, 10 May 2022 17:31:13 +0200
Cc:     Paul Cercueil <paul@crapouillou.net>, jringle@gridpoint.com,
        shc_work@mail.ru, Rob Herring <robh@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-serial@vger.kernel.org,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B523C47-1F9C-42EE-B242-EF63F89B94F9@goldelico.com>
References: <7c89db86-4055-90b5-6a67-611410f5759f@wanyeetech.com>
 <ZYNMBR.VDVV3VHFQBMO1@crapouillou.net>
 <04bd0853-7e34-5210-f1b5-f3ea8c35e484@wanyeetech.com>
 <501852E6-6934-4BB2-850C-B53A07580568@goldelico.com>
 <8533f999-f584-ea31-0c44-1ce29c066d88@wanyeetech.com>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 10.05.2022 um 04:29 schrieb Zhou Yanjie =
<zhouyanjie@wanyeetech.com>:
>=20
> Hi Nikolaus,
>=20
> On 2022/5/10 =E4=B8=8A=E5=8D=884:19, H. Nikolaus Schaller wrote:
>> Hi,
>>=20
>>> Am 09.05.2022 um 20:41 schrieb Zhou Yanjie =
<zhouyanjie@wanyeetech.com>:
>>>=20
>>> Hi Paul,
>>>=20
>>> On 2022/5/10 =E4=B8=8A=E5=8D=882:13, Paul Cercueil wrote:
>>>> I can't say for sure that it's your problem, but your bluetooth =
nodes are missing "reg" properties.
>>>=20
>>> Unfortunately it doesn't seem to be the problem here, I added "reg" =
and
>>> the problem persists, and I've looked at other device trees that =
contain
>>> "brcm,bcm43438-bt", none of them use "reg", and "reg" is not =
mentioned in
>>> neither "Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt" =
nor
>>> "Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml".
>> what happens if you remove the serdev children from DTS? Does the =
driver create two separate /dev/tty ports? And do they work?
>=20
>=20
> Yes, there will be two separate /dev/tty ports (ttySC0 and ttySC1), =
and
> both ports can work normally, but at this time the two bluetooth =
modules
> are not working.
>=20
> I guess it is because the driver does not detect bluetooth module =
nodes,
> so the inability to operate "reset-gpios" and "device-wakeup-gpios" =
causes
> the bluetooth module to work incorrectly.

I would assume that it is not prepared to handle two serdev subnodes and
assign the right gpios.

>=20
>=20
>>=20
>> Maybe the sc16is752 driver does not separate them for child nodes, =
i.e. while "reg" should be added it may not be handled?
>=20
>=20
> I'm not too sure, I'm not very familiar with serial port systems.
> If the truth is what you think, how should I improve it?

Unfortunately I also don't know how the serdev implementation really =
works.

It was my nagging to make it happen by persistently proposing a =
non-universal
solutionsome years ago until one of the maintainers had mercy to write a =
general
solution. So I could switch my driver to simply use the serdev API. It =
was for a GPS
client device but not a tty side driver.

I think if you look up the first patches for the serdev interface this =
should
reveal the original author an he should be able to help.

BR,
Nikolaus

