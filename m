Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A7496CBE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 15:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiAVOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 09:50:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:56599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbiAVOuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 09:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642863025;
        bh=zB56piMqb3QFqfIGyw04VjXD8/VAFWe90tLhSM6eli8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KVYfPXTomdn+GqrI/6yF9fuvolYVGeJftbnKC31EYcyktsm+Hne3Zy+yCwbZgySo7
         LCyBzZ0X5fDRQ+JtOLNkrpEDy5vfCvo1FcugEqceKG86PT4frfTzPYHpymdSh/GcbD
         NEZlkHf8rJZ+9J9MJ1SFFZwYiGaj6azqnhP55wdA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.72.118] ([80.245.72.118]) by web-mail.gmx.net
 (3c-app-gmx-bap44.server.lan [172.19.172.114]) (via HTTP); Sat, 22 Jan 2022
 15:50:25 +0100
MIME-Version: 1.0
Message-ID: <trinity-d0efbf68-ed45-47d4-97b3-d3788c5a9de6-1642863025116@3c-app-gmx-bap44>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Aw: Re: [PATCH v1 1/3] dts64: rk3568: drop pclk_xpcs from gmac0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 22 Jan 2022 15:50:25 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <236548630.RelmrRfzIS@diego>
References: <20220116124911.65203-1-linux@fw-web.de>
 <trinity-5a2f356e-2777-4624-b921-f8f56ce282c7-1642420742957@3c-app-gmx-bap64>
 <CAMdYzYrNQCcOiLf=jUGtCTM44SU8bUpBBOac6_SGJtqX+hvUuA@mail.gmail.com>
 <236548630.RelmrRfzIS@diego>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:gaQ/3c90UUPF2Jbp9f8wd+LAvN1+K6cRGUCFerTnftOdNHcZoI5Y0mvrnVNcvgE/UFZNW
 /XxzKKffXwCh0BSOElja30guvJfvN+rmvt4k03zwsIC8dp3cDiotLKXeIxWVoJ7HoixZ9iGMI10a
 pLk/0kBQu0rNos48UGn1voyGpaZX/8Z5ZzYHiwbXXgKRrtwh4OoniXU6uzR78W34uMeVljDax8EI
 /qd1zhfBV+g3DAl7+J8RUKFtotPosfSU1cvFKXnY3V62OjJxvtQAOlRJrTVasV2uVNk8w2PGklja
 UA=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iL8gm4DntU0=:1mM0GcOTKFCz6W/iyoa47m
 ajofLsDYUm7ymKbdmmtoek6INbOCCJc5/VdD31L4XT6hbz9yIe9/NJGZm3E0t3N0O9zdtP9SX
 XQNXInRSYbdWW4cwfgAk6cc47M7o0ewooYtOFTxK0kKyyXjs+Hy3oGCj4+F0haitm+yBtKiUL
 1mo5KsW+jOPcx59a9PC5xMJ2nUZAtv8ZaIS9Lxah+UR+m/39PHJ5CQFUli+TxT52q8CeQG30T
 XSSOZD2O0koW94NiucEGKKJY3w7r8Uw45SmGQUIILmYHcpI5wqLzL/KiERldPkH/RhV5HiaOf
 Uw7P77g9qmOmx8g14Da0SSUlL1/M4gkdlIZTjN3amXZGLLsDdgxHgFt+AS9Sv1Fl8AgWwy2tf
 QoLYp/+jq6m+8jROdbRqaSf2vo84dpSFLM9/osaHzDFAmFUo4YGO3cGBW94dAx7KuRFQUruti
 bp1jzQaLFd/GqYz/Ut4uxxSUtI2s59z1qsi6AkbzQg3585vtO6rFZnlFUYNsKDqjm0gsVuwL1
 ECU0/nMifLkhD1YWbWufc7hbedgVg/EFyAOdRHKWaX1+/JnedrvIFqCiyEs+PgmqzHZ7H9d7l
 dmAbJQNsgtXFrKhUO6IDI7UqRBtZ7XJP0ffVyIv3f+HVjVt3pwXyCvdZD7P9KNAHakOQlo7EZ
 oPBWN1aBb9Mbr7tAwCDrZQXN87acLEzb3XiTGa3QDqMWRG4E9ALOHDTmJkp/zghAjMgJ6nQUa
 UzY3f3otzOyGcebMNip7X7JSpXFjpO8Lhy3UBjd9q0JVs+wgITRAvN4yH7yIQ80kpH/W91o+u
 5bO7FPB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i plan to send a v2 of the series after 5=2E17-rc1 is out, because i have =
now verified
the functions from gpio header and found some pinctrl-changes=2E V1 had on=
ly prepared
the nodes to know which devices are present on this header=2E

should i include this patch again or do you pull it from v1 (maybe as fix)=
?

regards Frank


> Gesendet: Montag, 17=2E Januar 2022 um 22:05 Uhr
> Von: "Heiko St=C3=BCbner" <heiko@sntech=2Ede>

> From looking at the documentation I got the impression that the
> pclk_xpcs is related to the separate qsgmii_pcs in the memory map=2E
>=20
> So yes, I fully agree to dropping this clock from here and then adding
> them to whatever ip block really needs it=2E
