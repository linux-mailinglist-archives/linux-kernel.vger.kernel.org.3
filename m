Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41685486BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbiAFVd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:33:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:44181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244236AbiAFVd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641504800;
        bh=UMvIoROr/73nG2EcGTazV53/qUgYAF8KyqXKOfOpYLM=;
        h=X-UI-Sender-Class:From:Subject:Date:References:Cc:In-Reply-To:To;
        b=ctkrLWH/HgbRn2mlMx45AIG6TT6WrYveii41h46AT93R7LhkfcGP/g354QWsIOBWj
         OqiJbUGCRS7RXWC7NHviVKMyXhF5GzOuOcLZYjShTdPF/HKeNo14rzrCOg0cYYjMc1
         4cn0mHJsoE0tJWQA0bKxD5S34AJ5WAOc+AIWKsfU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from smtpclient.apple ([46.114.34.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1mYjbT41m4-00bajE; Thu, 06
 Jan 2022 22:33:20 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Sebastian Parschauer <s.parschauer@gmx.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] HID: quirks: Always poll Anne Pro 2(C15) Keyboard
Date:   Thu, 6 Jan 2022 22:33:18 +0100
Message-Id: <3DB5A377-5918-4304-BB35-589B594A5E82@gmx.de>
References: <61b44254.1c69fb81.ca496.5d65@mx.google.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <61b44254.1c69fb81.ca496.5d65@mx.google.com>
To:     kortanzh@gmail.com
X-Mailer: iPhone Mail (18H17)
X-Provags-ID: V03:K1:Q0YLyumya81FczRiWG/CXmts1FXXLWSpTgOFJQxa+qibH3PKpqn
 VkJbx1P8dj9mxwn5nz0IalogaaijMXPFDhCGAmjrOzzM7NQ3cz5aqhEybXhHHtDT+sVqJb4
 IF9D9YMax1WvTETZlYkuF5lFMsM/GQYCUVorYlhCJXQr7df4fKuM8BQoYElPM6OI9klNdRj
 +uejTo6YsXf0aNox6RKmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HG8J6o0vkhs=:FSuXykpHlWBrDOslgBT2ON
 InAM7gmg5DtrFu//ElMtgG7HA+hkFP1rG4M+eUdFaGw3JI6CW+zIKdF7aVBKHJxojSqHRS1a0
 YjsBBb+nUv1tqoQ45hda1tkqsB4a/hXQHQah488L6ulQrv7fFeYW5cuILy5h6WDKW1nTK5B18
 nPtQJLZoa5Tas9gb/f/s7DfJxBeTuZlfjD+BbCYLNksJ8jXMKBSPRCrTtMU/imtqsL5mSkRXV
 tFDnIozX7XDAaXT2fqblKAS2fAYeISrBSY50Jnsi2rlkBrDQkkOM8/FJKPpkWrxSTi8ODFwQT
 JicviqRdZyhLNIeXGY/nMusCZ7BAIM/Xd27WzmdUZVM93uWKg2vmgPQvF1EZFEgMwA/gTJJbt
 xulXEREkOt7AZTJKpncpsj71S9Z+gfR33SBjXmaaYEwUFkg5Vz3WvQRllgnVsNDegMJp5w+OI
 tVVeqlkijKDUv/AYynzTV0ZyDtgu7aduquNnCGfpyU3RbiFGAU46RttCMekPuJHgF6V6hnJkp
 5HoRFr0oWOq1pIITekZlCYOABEsnIbponaWqEc7OZ0WtCB3rDSdGmcMiPcWJoy8ManB6hkyNg
 Lw2ZBVg2E2X+endKrUeqbI5tKr6ykq43y+RB+zmnrvIEPIyUgA9bXMOgUWNLp/4po3aGyh0vu
 Q5srO7f0kSEr3NdxRI/SglemDSZyeqCewa8eRUbcGR78Wdmddz5cTcC17T+S5W8b4+QgjCqhG
 kqyVPQiA1EQAlk57JVOWVwVIxImOzcRLXtgYWa6Ak7nEXi+y2sdfHytpU/cUQoh6MUHZPjZWH
 5o1qC/nBAIHkxsdj7U7fCsuzG4HSZ2MFG2GG01cKRy0HolfDArtdS2OXaL+P4K4WhbbjcRro2
 9kbKlpsB5AQOqRwB+xUQFA7+4v6y/nPpogMouefkLh3VCjI4VUXpJzFMIhnX1HNfRTGLtmu+4
 qTMzReOo1EC8FK548qP0mdVcC5UzmD0XUrKuWgBS9vNNsR4twebox7sk140zyLmezn4DTS05n
 OZW0Ag7vZJJnv5eEEiXf4zoSPFwnpH/ZxZqn6nXMpFXVdRgcRhfERSrmS9S2ccRODiA/k3+z6
 cuUzCuoGHj8Uqc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 11.12.2021 um 07:16 schrieb kortanzh@gmail.com:
>=20
> =EF=BB=BFFrom: Kortan <kortanzh@gmail.com>
>=20
> According to https://openannepro.github.io/ap2_revisionas, Anne Pro 2
> keyboard has two hardware revisions, C15(04d9:a292) and C18(04d9:a293).
>=20
> Previous patch submitted by Sebastian only fix the C18 revision. This
> patch add missing C15 revision support.
>=20
> Fixes: ca28aff0e1dc ("HID: quirks: Always poll Obins Anne Pro 2 keyboard")=

> Signed-off-by: Kortan <kortanzh@gmail.com>

Thanks for the patch. I was actually the first one reporting the bug to them=
. They replied with something like =E2=80=9EWhy do you do a kernel patch? No=
body reported this bug before. We will fix our firmware.=E2=80=9C That react=
ion actually surprised me. Does this mean they didn=E2=80=99t?

They didn=E2=80=99t say anything about a second hardware revision which migh=
t be affected.=

