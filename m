Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF470472C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhLMMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:42:15 -0500
Received: from smtpcmd03117.aruba.it ([62.149.158.117]:46337 "EHLO
        smtpcmd03117.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbhLMMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:42:10 -0500
Received: from smtpclient.apple ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPA
        id wkeYmWeD7Ni3cwkeZm3tZn; Mon, 13 Dec 2021 13:42:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1639399329; bh=HW8jnezXIp3XT9vHzTfAeit8KDYul5E/X+S8lIqCFzA=;
        h=Content-Type:From:Mime-Version:Subject:Date:To;
        b=bW3CLmmFgM9n0qt/F1+oAVzlHW1KaA7xfMT070F5NMPjdRZ5hWmmBluO4pAjko8/4
         0uQHuJHjh2temvPV2ixXykmgaKp4IuDnV7gyp6WvpshPPBH7XffP5lgdr/CEV+xQvs
         dGCIyTBvKycd3okFGdmY8kZuYnk2/Ar+gseo4RnbaYCFbiRd8KB/PmgD04lQXHspju
         6cc4BH/0hG5VQM7uCpunOlqgsDdH+zcT3ImLxsVZiUY1F2J73gtL9re2/L1gnyIrSx
         scXub6a9KanbmbW1+eyNhYCxSney0v5U9RrZp8H7htgb7Z76RSAL//kbtebRcm4oIx
         8NJSNbOKo71qw==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 07/13] clk: imx: Add initial support for i.MXRT clock driver
Date:   Mon, 13 Dec 2021 13:42:02 +0100
Message-Id: <3109BC68-D1F8-4972-9480-F26606085ECD@benettiengineering.com>
References: <CAOMZO5D9ytHBACojwk3mtaypdc4s5gWT7ctJQiUzmmP15hzGww@mail.gmail.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org
In-Reply-To: <CAOMZO5D9ytHBACojwk3mtaypdc4s5gWT7ctJQiUzmmP15hzGww@mail.gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
X-Mailer: iPhone Mail (19B74)
X-CMAE-Envelope: MS4wfPDFt+eQTTflaIECVpAthF57sEYmn4Q2RvQhp7B+4VH2gu3iPMFODYUJjPPdHcfy0G6Olr6hvCyb7WbX68JVtMjscZHWb2lZHmJjosX1cRt7ibrFNqkx
 yF4kBPlqZgYTMtUOcVITfQfiy8VN4ivJgsklw/wIfMFkAaz5W4l+GIk5DlnbnTKasmv8O1VOWWFvDB9xXJ9rs7cKmMBXSZqagQ+7bcGB8eJmRs8pt4c7BBP5
 h8jwR/Xvwg/l0J0Sse6morf+GOhc4gtceJsUYyxByex/TN6/8sg6ndnpGsvIEwngpHu1kbO9dxv3CTGNYWHPufEbxudq34t0e/h5yHqf75HBf0cl3fDNjUzP
 vuCw1NQxNTL070XUcwWKHJHv25LhfHdbqbmWgDNh3rfg/WioktumTv17QRmidJM4cwyZ7xIrFda/3mLcYoHtjzLPui8KhJZAUrohDju+malebuF6Yx409YuS
 tf6InUpQg6WS07uIRu96HGDbpY80pOmkk/+4oBPuvHe1dQNJLwWO/M2kIZ06Jl6zLXSqIL+CjCBmdGdeaW/YNcS/ZF8MpU1FPi0ZEVvUS+BFeNscbVqVoP/T
 oI9igbJe+gzbmG9oSUOng9LZVe8tJ9+3ra1S3HioTmsF9xV+4E/qsDucSg+2JmXFMcaQLDpEliHoyJOwPpWSegkMpVumYTXcZQTkKcuShJa41AwKinGtORjc
 yz7Yo8ByOADmKT6C7zPiigPbKclb3VoEQvHo1VC0/R/kdeLtmyevT9v7KqrwQUZXLRfp7sInHHi0TE4gGKHaRX0tL7/Y5fwvADXrWe4SnpkUwLXvbmh6WUXC
 mmxOm9wVGMQsQ8J/AOE5zHu/xaGBMIkAHKCkBDIiTVCTuycnJsl8msxybTbFdnD3dO0iaN+cCDqv2kukEKc4WzBSYx22mUvptrinTtEtI5m8v3F2vwRF2E0i
 nA5lw7ar99z1ELSnw4lOzhVik6K9W/PWVQ+MRGCUUd3kXFXbQoJDMzwYr1tRlAe3o21zoA/IoQhOOU4BgfW7ogB28mKV0UFdD1PUjL2EWoz6qvkyGUfGTqGq
 DVRGthEjuA7rVNjOX+LkyY7aA3c0b0kBU1nrOoeXdDbzQT4QPcUxc+tTsiOGtwuhenm9GhKHEOoig7xzgy3CHtnrjIqH+w+S3hE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

> Il giorno 13 dic 2021, alle ore 13:15, Fabio Estevam <festevam@gmail.com> h=
a scritto:
>=20
> =EF=BB=BFHi Giulio,
>=20
> On Mon, Dec 13, 2021 at 9:06 AM Giulio Benetti
> <giulio.benetti@benettiengineering.com> wrote:
>=20
>>> I would suggest module platform driver instead.
>>=20
>> Can you please point us an example?
>=20
> Here is an example of a commit that converts the imx8mm clk driver to
> platform driver:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv5.15.7&id=3Daf7e7ee0e4280c29c41b6ec64b892bb53987a997

Thanks a lot, this ease us

Best regards
Giulio=

