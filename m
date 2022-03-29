Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EBE4EB40B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbiC2TXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiC2TXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:23:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538F63AA61;
        Tue, 29 Mar 2022 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648581688;
        bh=YKGLLajiWM4+txgQG1y+xnhwR4uQqHF1m5v9e2rrGqk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QUVZCtTi/gNNs/GgNEt/jk/KE0h+JdBVQgMpHNVt6lO9nMEO39UG0HY2SCMsgsZ1h
         j7JGm8T5MNgSYlRZO0BMQU7xzmO1PHrF1jzX7lqNOk8cpKYK/HCEG6zibcXXze47Iy
         CpRIlqACpmfyrCYdxDWQ6vMpqA15JPArzKNy20oE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [91.65.110.57] ([91.65.110.57]) by web-mail.gmx.net
 (3c-app-gmx-bs54.server.lan [172.19.170.138]) (via HTTP); Tue, 29 Mar 2022
 21:21:28 +0200
MIME-Version: 1.0
Message-ID: <trinity-2ca61ae4-4f05-454d-94fd-d41e1afbec2f-1648581688394@3c-app-gmx-bs54>
From:   Robert Schlabbach <robert_s@gmx.net>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug 215726 - si2157.c: mention name of the missing firmware
 file
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 29 Mar 2022 21:21:28 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <5f660108-8812-383c-83e4-29ee0558d623@leemhuis.info>
References: <5f660108-8812-383c-83e4-29ee0558d623@leemhuis.info>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:YGuQiANBFW6fdT74J1oXl5Bso1V2fH9bq3wlNnu62Wz/O35rDADmOSmTMSVhKLgKRXh8Y
 MriX/2c7Aw//PJZ0otIvRWk+calDWtJi5mLfNrz+Hw4jvGOissaSrJqhZXyEI937ScYbmjj2MRBf
 1x12AUnDHIicomCHMcfYrdPlBuR4IQDjAkE5qNO0NnyOGUpsp5i3Pw1iluJ6jJZnpjunuwBMPCb2
 iB3M3YTaiuRZ0zYd6l8N0ZB3laPCHOFukq6pcOf4peVDWLnIwOuEgtRw28WdPBSZ7yCWTcyue1cS
 94=
X-UI-Out-Filterresults: notjunk:1;V03:K0:x3xM+rGwV/0=:vdC65pZCywfZCJuMc1x/C8
 hRz3bF/RWRD4q5hxTLtZvN3wbMUH+IqT+wGCIMCmQEONaSmiqXctofPtXBz3Z7XfeSBbaG4xK
 lnP+wAVTHeDuWRJFy5DQEDVsygm5yNQTF1nzUy1iMZPr2rIATMubC0loGkejNbvY8cv0ePGt4
 MuV4ozYrAaS0DYhXSxXfzmHn2nhLzNUDqSW5IDHGV2JCCSuUmAjUwvDx4Lk+EtLBlVO/9VMxy
 SmuJcVEXqOkVNg0YniIYfp9gKYyh6ZZWm//yBGrSuTT0XDXE93k+R4pfgLjROy63RjQnOPeyd
 mj0e2dSYJNnB+mKnXFiqqaePqnJ9KZtQmeU6+xN4TS1SbhOALrz9IlXfcrvnHuGZz3sPexY1s
 Qe3ZxTIOvtV/9SOfUzNOpP3/UzNSdr3tpdM79jl1icVp9rwwvXjt1BBxy3fuEzqLug6tE1ywB
 1ENvKl0a3/IcgKZgUCXWDgAi3Lnh14psR9NsMqBLmwlTtBNAfsmitlCQ7fMDKES60qpsGlJkX
 zjgwUxX7SPhZNRPZsFPwRGAxd8ydLtYh9FpbatV+zNxbB4T4nkXurtC8D9Mkw4lWVmHyl6BlR
 AB7UOxIvpxD5OvoGTmp2kEdGyVcEImR15ONf5peg0urmV1+UdmTG9OBFLnu+0XcSVxsklEk2G
 ap/RylD3yMqc+0VhUCB/EIcXD5JccXavhnPGPl0f23u1Eme7scMTmO9h27ZjIU6pKKWBIpZel
 dUEHkzxbQQzVT5X9RmUaU18m2HVHCktIUnR774QgoxfawMr/Hoao1M8tC2h9BGl7eSYLJlYr3
 eJUVjFW
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

the patch linked in the bugzilla ticket:

https://lore=2Ekernel=2Eorg/linux-media/6f84b7f4-3ede-ae55-e99b-a9d4108c80=
e2@gmail=2Ecom/

should indeed fix the issue=2E The error was that the rom_id and required
fields were swapped in the table, so the non-zero rom_id was taken as a
"true" required boolean value, thus incorrectly evaluating that the
chip requires a firmware file to operate when in fact it does not=2E

I have tested the patch and found it worked for me=2E But I do not know
how to push this further along:

https://patchwork=2Elinuxtv=2Eorg/project/linux-media/patch/6f84b7f4-3ede-=
ae55-e99b-a9d4108c80e2@gmail=2Ecom/

Best Regards,
-Robert Schlabbach

=C2=A0

Gesendet:=C2=A0Dienstag, 29=2E M=C3=A4rz 2022 um 10:33 Uhr
Von:=C2=A0"Thorsten Leemhuis" <regressions@leemhuis=2Einfo>
An:=C2=A0"Antti Palosaari" <crope@iki=2Efi>, "Mauro Carvalho Chehab" <mche=
hab+huawei@kernel=2Eorg>, "Robert Schlabbach" <robert_s@gmx=2Enet>
Cc:=C2=A0"regressions@lists=2Elinux=2Edev" <regressions@lists=2Elinux=2Ede=
v>, az0123456@gmx=2Ede, "Linux Media Mailing List" <linux-media@vger=2Ekern=
el=2Eorg>, "Linux Kernel Mailing List" <linux-kernel@vger=2Ekernel=2Eorg>
Betreff:=C2=A0Bug 215726 - si2157=2Ec: mention name of the missing firmwar=
e file
Hi, this is your Linux kernel regression tracker=2E

I noticed a regression report in bugzilla=2Ekernel=2Eorg that afaics nobod=
y
acted upon since it was reported about a week ago, that's why I decided
to forward it to the lists and all people that seemed to be relevant
here=2E To quote from https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D=
215726 :

> I get the following error messages when trying to use si2157=2Eko in lin=
ux 5=2E17:
> si2157 13-0060: found a 'Silicon Labs Si2157-A30 ROM 0x50'
> si2157 13-0060: Can't continue without a firmware
> I did work in linux 5=2E16=2E16 without a firmware file=2E Unfortunately=
 the driver does not tell me the name of the missing firmware file=2E

Could somebody take a look into this? Or was this discussed somewhere
else already? Or even fixed?

