Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186294A6CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbiBBIJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:09:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:48977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235829AbiBBIJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643789343;
        bh=820tgtoHVmXtW2g38BiyEN1zqOvFz/u+26LuG/3A3bc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IgVDqw5W/z/+WvK64MJNjag6nmpS4iQbFS7pHLyvBPF3v56OoozQmD09kSRmkhJsR
         ASHT6+UICmaNS4QX5dQg31S+zSCknfzeYltjBHqEsK8B5bQ68QZvaLda1h8R7aZXpq
         F3V2fjZGcTPY0eaRCd2P0G3t8fkVHDn8QG8SYTmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.149.143] ([217.61.149.143]) by web-mail.gmx.net
 (3c-app-gmx-bs68.server.lan [172.19.170.213]) (via HTTP); Wed, 2 Feb 2022
 09:09:03 +0100
MIME-Version: 1.0
Message-ID: <trinity-af7448eb-fc1b-403d-96e5-000cf4686b68-1643789343739@3c-app-gmx-bs68>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, justinkb@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: BUG: [PATCH v2] isoc: mediatek: Check for error clk pointer
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 2 Feb 2022 09:09:03 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <YfmyD7bmJS9f+e+m@makrotopia.org>
References: <20220130024335.114461-1-jiasheng@iscas.ac.cn>
 <YfmyD7bmJS9f+e+m@makrotopia.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:1EwkLNZnWM1Vx8vTjzzHWiLrocl/t3MzK258AeRKyf0CyfSk8UoEcGyN00gEc5vF5Yqp0
 dGv+HtwvnZR+NAeVkp56j07jiFb54Hv14mMjX2RGnOfy0JIjz7d6vobvG4uUw3ZE1DlSlDHohpNA
 aEzvoi0r+fo2IUUa+X7Pj6oeVOFmlsruDYI3b4YASO0Ic0rFLDbY5oC88t8SNRvQOruYiGM2fgki
 GKBQ35RBX6JiyHkccHd/45cE6aPOydCmxtJIWii3CHe5StRJUXn1WawvDeKKpLyKSl6WzyZ/Zrai
 Rk=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fxL53vkBNuw=:SFb/MXKg5ahJcnNWLxxgFk
 OFEJ0juz6Z2gSfWfD2ll5u5kh3CAlb9ev8pMgfqta09rpZzKRFU/Vwn0za433yhNIuhXMHhpZ
 x0jOqBs2Wm1Th/CVuwZWHlELatllksTuEbA+YQI+P9aEIe9cMV+7pf5QZHV/jDCltCIfhDtea
 i9WP+W5yuMlPW/8lXIPTnbH+hcRZZV72ehm1/55rdIQbEFKrI+3xAHvgBs9C6tIK6qq9jCSMh
 dQi78Ki1xMtirWglr1k744/2fNo/fcPtlOYuPHbZimhpQcp7t/TZl64dY1p3NrLhXdnPbCtci
 LU1SyukvrMKz7iqu+srbZLrTQbzlamPC3us3krqaKHmS4oAsgT5qQYbyNjJoOgjtA48B5iDhT
 O4DK/YkADjvBEyQJVR/fRIf119Ch+FRiFiW3dyp3jdq3RF/TDhT/vIDYvU5McEqQYu2z8Xwbu
 9mbdYpxBvseg5n09LmI3eVZsRU+g/kjjTMrIDsenTOEpIjKxpUznJzkY4iO7i/4L7g3560s0U
 ingDijarflGlPypgW4s/RdkUUsYgHoEtd/p84o3zOc30KiDxXIGWl8RLbhO8fATDvp02iTXKg
 Y4KZ9XgmAPfQRmFxbqupWXsC4kExnjbrymJWqY6K6dxLwC7gq5QsqEokQ9lK8ZOi5EYWPrGzg
 jAmyVP66D/66PET8xTEBCq7rQCrYfd0AmQIkHIiNrFkIO2rlEDMimPTPNi/aCnA1c11QrIWUb
 2fKWoZDa9gOzxvrHHKCtIVEdIi0YXfK/P5kUWWCRp/+Vvm8wV87b74u/cJgpDYIfDCyjwLmDy
 iA1Pn9l
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Dienstag, 01. Februar 2022 um 23:19 Uhr
> Von: "Daniel Golle" <daniel@makrotopia.org>
> An: "Jiasheng Jiang" <jiasheng@iscas.ac.cn>
> Cc: justinkb@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.ke=
rnel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-mediatek@lists.in=
fradead.org, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
> Betreff: Re: BUG: [PATCH v2] isoc: mediatek: Check for error clk pointer
>
> On Sun, Jan 30, 2022 at 10:43:35AM +0800, Jiasheng Jiang wrote:
> > On Fri, Jan 28, 2022 at 10:26:51PM +0800, Paul Mulders wrote:
> > > I guess this breaks all MT7622 SoCs since it'll prematurely exit
> > > init_clks (and subsequently init_scp) completely once devm_clk_get
> > > fails to get a reference to the mm clock producer (which happens to =
be
> > > the first one tried). This is because MT7623 has a GPU (so no mm
> > > clock) and MT7622 doesn't, and as a result the other clock producer
> > > pointers never get initialized (and other stuff in init_scp after
> > > returning from the error never happens).
> > >
> > > The patch seems fundamentally flawed, I guess it was either not test=
ed
> > > at all, or only tested on a MT7623. The initialization functions see=
m
> > > designed with the idea that it's ok if some clocks aren't present, s=
o
> > > stopping the initialization when one of them isn't present seems
> > > wrong. (For example, there is also a MT7622B variant of the MT7622
> > > which probably also lacks some clocks MT7622(A) does have).
> >
> > I don't think the patch for init_clks() is flawed.
> > At most it is incompleted.
> > What it did is like fixing a potential error in the tool platform
> > providing service for the upper application, like what you said,
> > MT7623 and MT7622.
> > We should not keep the error in the platform because of the upper
> > application.
> > And it seems like it is MT7622 that is flawed.
> > The better way is to fix both the bug in init_clks() and its caller,
> > MT7622.
>
> I agree that further cleaning is needed here.
> Yet the commit in it's current form very obviously breaks at least the
> MT7622 platform if no further fixes are applied.
>
> Imho the whole approach of this driver to hard-code the names of all
> clocks it could try to grab in a string-array accompanied by an enum
> is flawed.
>
> The correct approach would likely be to add the clocks actually present
> to the device tree of each SoC and then grab only those.
>
> I can see that mt2701.dtsi and mt7623.dtsi both have some clocks
> defined for scpsys, mt7622.dtsi however lacks them.
> I didn't check other MediaTek SoCs which also use scpsys.

re-add me to discussion :)

have not yet tested mt7623 without the revert i applied for mt7622. will d=
o this later

regards Frank
