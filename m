Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3724CE41B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 11:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiCEKJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 05:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiCEKJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 05:09:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4253EF39;
        Sat,  5 Mar 2022 02:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646474868;
        bh=YJqn1NC2PcONovl+FeGlrbZLfeART2llhJv+aFruqL8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R4D82yx17Ur9XFddyt1BtT8rQBFwwHNMEkM2Y9Uftfb3Jtx7H7JMo92zGASLZqeW7
         hMKfVRnjVoTa5o1XQpab6J4m2CCZ37A2s+vClm/7Zw8KfRz2Q3Q9QsvZy7BPZcmMVe
         +jHMjTYalA0KxDWHnD0svKkQ3mScBfs8jlEA+tEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.79.220] ([80.245.79.220]) by web-mail.gmx.net
 (3c-app-gmx-bap19.server.lan [172.19.172.89]) (via HTTP); Sat, 5 Mar 2022
 11:07:48 +0100
MIME-Version: 1.0
Message-ID: <trinity-68e1ed73-5a31-42d1-838e-0a837e686c4a-1646474868401@3c-app-gmx-bap19>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Aw: Re: Re: [PATCH v4 1/5] dt-bindings: Convert ahci-platform DT
 bindings to yaml
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 5 Mar 2022 11:07:48 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAL_JsqJMZ1mZ91SYZR03rMkK-ZqFd-tCwV6zOrNu5NmP6V+duA@mail.gmail.com>
References: <20220301152421.57281-1-linux@fw-web.de>
 <20220301152421.57281-2-linux@fw-web.de>
 <Yh+0B+iKx1gJXXCk@robh.at.kernel.org>
 <trinity-1ca1f3fd-1eeb-4c8d-a7e2-65851eb8002b-1646291055736@3c-app-gmx-bs69>
 <CAL_JsqJMZ1mZ91SYZR03rMkK-ZqFd-tCwV6zOrNu5NmP6V+duA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:/P0vzO+iE3b5I3dbtGgMwtxR9U6OKwczttbAGfwTXkfKWsHrYxxTETEAvFpR6TjrKXlHj
 CbsxUsZvI7LPDJbP5Y62qRUxeM+tT+vL0+BSNLGg3EybiyTLZbjIykCpxvz+Rwnuz2E1yiPspb0j
 t1qM/Cr8NFDw7DJaII5b0gvdZfJpCFNOvCvoJaNqbBKauKdhu5HZOwKwNRe9m2SjU1Y2s8XoKvh/
 vDvOSsM9zY/kHDK0CVOr7/tq8QaQd+1K7Qv5BSaZB6ROwZhCYgXwmYENMCrMzi+y7pRYmJtb0g8E
 c8=
X-UI-Out-Filterresults: notjunk:1;V03:K0:xhCga6P51Tk=:BhJdX6j65ejZ9fVOAYZOhq
 hN1UYc10YfWYB62IOfbzb/+zGB1PgJ0rofHpQiRaNchSj6/6hdji2p7hD1KnL/zXdNw5+yXYJ
 KdY8nzqsURgJo6MEt81IT3U+tkdjix62yn8Vxsm9WlyKYPb00Pl27IOlQS/sb15AX4CDj4hJp
 v2/sKOk9AOxQZOfHKi9vxOAsE3/MDq6J/x/nvi4o9xVnaq9RgoNMljKr5zxHXhwu9R95MwTiY
 UzEYI4EvolulY/GtOV8nMMD1eSPEYIU7gK98vTcvbprwuBi4XzQsDirtj8LztSJGV9DzJ1Ock
 5eXjtECIz1zVmirc/BCoxY8q1PQzeZZmHG+xV4ps0Y2IvnzKYn/yxcsLzy1CueZ3FDk4csnv1
 MYGicJaSddUg4g6ePiPsH9VW1tD5O6UkCjsodAaxiG5NTFtOUnP+JQWqs4wymQNUwjclUkpBa
 r2bYyxVA32aZhW0un+F+2sHugUsiNRaXJb/fNzTju0Q+TiAp/grYvcSsruPoByfh2ZdDzGTYx
 aC3BikVbtgJhBkyA1MpOFy/VBrOfzzCC/8K56k+oBBMYx0UkmUSyzFdjftONRSKXxSrZJ3SmY
 VCKqi4Bik8pxvpnHktviqaP/SHMYbnLLwo8KSWROLJtIchrY0w+wLaxV0wURJKPamozPxIGYI
 74sgQFbMVOt3THPMA+WPQe32icT/X8u1WPSgRkdleA4DdegTmDUTK9uNDQj4lECR6flWJD2cl
 6BxG0b0Fh+6GuBU+SW+EH8FXXzmzkjFYmQVBMVoJnIvGMbhA81Y2X0paMDYQonqbOAjidUJch
 XugSAYi
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Samstag, 05=2E M=C3=A4rz 2022 um 00:37 Uhr
> Von: "Rob Herring" <robh@kernel=2Eorg>

> > > > +  ports-implemented:
> > > > +    $ref: '/schemas/types=2Eyaml#/definitions/uint32'
> > > > +    description:
> > > > +      Mask that indicates which ports that the HBA supports
> > > > +      are available for software to use=2E Useful if PORTS_IMPL
> > > > +      is not programmed by the BIOS, which is true with
> > > > +      some embedded SoCs=2E
> > > > +    maxItems: 1
> > >
> > > A uint32 is only ever 1 item=2E Drop=2E
> > >
> > > IIRC, isn't the max here 0xff? Add constraints=2E
> >
> > i've found it only set to 0x1 so i have currently set the maximum to 0=
x1, is this ok?
> > If some higher value is needed binding needs to be touched=2E=2E=2E
>=20
> There's a spec for it, so no need to look at what's used=2E Calxeda AHCI
> had 5 ports IIRC=2E

as far as i understand code in libahci=2Ec line 535+ [1]
i guess i need to set lower 5 bits to 1 for 5 ports, right? resulting in m=
ax value 0x1f

> > now i have only the marvell-errors about incomplete sata-port subnode =
(without phy/target-supply) like i mention in the patch=2E=2E=2Ehow to proc=
eed with this?
>=20
> So the child nodes are incomplete? They should be disabled then
> (status =3D "disabled") and that turns off required properties checks=2E

thanks, have disable the nodes and reenable them where phys/target-supply =
was added [2]=2E=2E=2E

now the dtbs_check is clean

[1] https://elixir=2Ebootlin=2Ecom/linux/v5=2E17-rc6/source/drivers/ata/li=
bahci=2Ec#L535
[2] https://github=2Ecom/frank-w/BPI-R2-4=2E14/commits/5=2E17-next-2022022=
5

regards Frank
