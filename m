Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F4A4D8853
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbiCNPku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiCNPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:40:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73712B1BF;
        Mon, 14 Mar 2022 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647272337;
        bh=0hiQdLYzzJrthQHxIhtX0qW9S2gMLh89hdfAM3B+VpA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M0/CkdUgHniD7my+WJFaXS8on2DZoU1UHIumjJY5/RLve9LM0/8rrNW21QQAz90xK
         slsFpODg4S9QyM78LqFlRSM9d/S6hOM/0x25yyct1wRenI+dYZ2Bqr7D5zwaichfKl
         iRRF6kPJmt5FQyFDrn3184Z0XUlQOsMH7LGNrK8c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.151.147] ([217.61.151.147]) by web-mail.gmx.net
 (3c-app-gmx-bap56.server.lan [172.19.172.126]) (via HTTP); Mon, 14 Mar 2022
 16:38:56 +0100
MIME-Version: 1.0
Message-ID: <trinity-0f1389c2-6d2b-4499-a2fc-3cb93f4d09cb-1647272336831@3c-app-gmx-bap56>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Aw: Re: [PATCH v6 3/6] ARM: dts: spear13xx: Fix sata node name
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Mar 2022 16:38:56 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220314034940.rxkgue2kllnqhucp@vireshk-i7>
References: <20220311210357.222830-1-linux@fw-web.de>
 <20220311210357.222830-4-linux@fw-web.de>
 <20220314034940.rxkgue2kllnqhucp@vireshk-i7>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:gLht/1WascKmAkHg0tigkfra0fk/gYur/IiTTMyyGSmcqwrhVynoTW1YUGql3lgRW5ger
 mr12NMylEOhVVALt80u84ZjKVBJ7oI7WqUrWb/y/OBKCMtUra5ihwbKArSFZ48al4xvyGvZIatZc
 qPw+YSSsjtiAU9rOy1BerK6PqUP/yOza87QD0B6s53j7t/F2lFW3Xe7UrjmcriDTvRkmKWtJCMrF
 ySC9cjsPCU5IlctIX9DIy8McWyMOmjjQe4/7EhuseuCN1qDetJTTTaqHNqOjmCc+Ov6wkDwHIS5u
 sE=
X-UI-Out-Filterresults: notjunk:1;V03:K0:P7tFke7m43c=:1oXfuKyenANOYRAc66LkBH
 cVYLR8BkFV9yGq6h5Cit41aVWt3DcoBXnFIcJzt1mTDjAe0DmxngO8L6jeCoPRsolhVm0ZtSu
 IdXGjL8mhV7xFv3XH+TkMigzy+9ztqKB2ZZ+Bdlg4voJlHu0mWpUEj5xXR9p7sZ1Yu0kp+zdm
 K0Z+UhFD99hfNjsenukQ6dmMw7EduTiM2v5jkLSzSEk41v9P/kDsegjxrq9EI1LSBYNmeWOvk
 DcO4bCa7B0Y9goU/p3td+VEvFyQozMa2fFFR3jsXad+J0NsuRQ2KCvdA5xwRPOm76n22IkL7x
 RYYMVS/ts8/S5g/jBZrpBQSSXdv9TfPbxgucfhI7MkYneu29nmTQEv3r7nmlrbzlDMUUZ9AJ6
 J3n78jqaduZ2tTtOpCUL6ZDLDSR++qiM/WKSzO5vJyZc/BVdb3NPUl6vWb7K4UMopvzMEGzon
 Jv6F49GZ7lAdSsw1U/vM+gcSuBbbPtkQPBsSBqzrF/Wu+j++/g3/ll2jcGnahhojK0tO5bCa2
 3uDUdamaugIC/X9BUzS0JqakB2Z2PULqJlphjCuRzw9xPk0BLZUPDAy4L/0LAubmtqtactreL
 J5KqriwpQm3aZvR/3OG6DL/dA2uvtR8mPktV5DgJ8K92+SkDHfW+KUjeGGE88GiFsu/A0dqMC
 5xrpYuuveosYcslnNHfV6W7AXDlmgUDbVSW7mmX/7C4lObY0ZugyXUBxLvEXN/f22vk+E+Xlg
 kUULzqwqxwAlZxSRBHp1UPfO5ZlLJ9CuCoVoNHaSvYSwzpquEJqx2TgEJiiuFQ3DrzCKyzqW4
 TrU16gE
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for for checking the spear-patch=2E

> Gesendet: Montag, 14=2E M=C3=A4rz 2022 um 04:49 Uhr
> Von: "Viresh Kumar" <viresh=2Ekumar@linaro=2Eorg>
>
> On 11-03-22, 22:03, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files=2Ede>
> >=20
> > After converting the binding to yaml the node name does
> > not match the standard pattern, change it=2E
> >=20
> > arch/arm/boot/dts/spear1340-evb=2Edt=2Eyaml: ahci@b1000000:
> > $nodename:0: 'ahci@b1000000' does not match '^sata(@=2E*)?$'
> > 	From schema: Documentation/devicetree/bindings/ata/ahci-platform=2Eya=
ml
> >=20
> > Fixes: 07658d9a659b ("SPEAr13xx: Add dts and dtsi files")
>=20
> I don't think this is correct=2E The above patch is correct=2E The first
> patch in this series changes the names and that's where things break=2E

it's right that my binding will break it, but the nodes are not named the =
right way=2E
And i used the commit that introduces the wrong node-names=2E
Maybe fixes-tag is wrong in this case=2E

> I think you could have added these patches before changing to yaml and
> then nothing would ever have broken=2E
>=20
> Since this isn't a big deal anyway, I think you can just drop the
> Fixes tag here, and other dts patches you have=2E

regards Frank
