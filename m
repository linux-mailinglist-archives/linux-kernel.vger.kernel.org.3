Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87E15748BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiGNJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbiGNJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:24:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981321CB3F;
        Thu, 14 Jul 2022 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657790580;
        bh=XLh6uW9piesBKYmxZS8eU/yFhlZ7ljg9w80HtVriwhY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Vmtx44ECV9ap1hh8yWh5jWQ+LCJuQoI44B2NTwXkLuvH9bhetObZPIUHXJWcjcFnu
         ycLYl542YQX7ynINixqYnjxZDcUeIjZeKr8hFKQb42mfQ9Jug44F6Ja23yBStC7HDD
         3Lh714xi28ZzXfMAnY4/IOoACU80NycOhwpjUr0I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from dyn3207-67.wlan.ic.ac.uk ([146.169.207.67]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MNt0M-1nwTdc0ea0-00OCwA; Thu, 14 Jul 2022 11:23:00 +0200
Message-ID: <7b35628c152bb039a526adf404076ee43fa3a130.camel@gmx.co.uk>
Subject: Re: input/i8042: Malfunctioning brightness keys on HP Elite
 Dragonfly G2
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Date:   Thu, 14 Jul 2022 10:22:59 +0100
In-Reply-To: <PH0PR84MB1953BA49D88304F1D61AB7A0A8899@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
         <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
         <8b893c42-e514-bcef-0513-070b3723cdcc@redhat.com>
         <df7313597d2ac3212f10c05aa3d369728f030c86.camel@gmx.co.uk>
         <c89d39eb-17b9-8800-c8ff-8d236b80de2f@redhat.com>
         <PH0PR84MB195309F5BA5B96858024E61FA8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
         <PH0PR84MB19536D04A5625D4DC8B76AF1A8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
         <0e8611ad73017bc204372f491ae5666dd60885a9.camel@gmx.co.uk>
         <PH0PR84MB195301AA9C44F2F4ECE4A848A8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
         <afeb858778de9b25d0de655ffccb64b85511c428.camel@gmx.co.uk>
         <PH0PR84MB1953BA49D88304F1D61AB7A0A8899@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Provags-ID: V03:K1:M5IGv0gfR25O+6RjBWtSy3Eg+LMJ6HabRMW08i0VAPOFbzkerIE
 /5bIqNXv76Y9IG6QXxx2/nkj28Qx6CKvm5sVxDItnWPeJYWeALzpJp+LrQc0cPGgmHLUls+
 VKvpl1mYea0lu2NHT//w1Aoxs9HpIMHcbL8ni4h0DbO0PN2QASOu+HOwamBBeBCRBce02sk
 zwd/+zKSG/fwIpTSm0lAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dMlmKG7/Z9Y=:zS0Pekc2ujzE/wkK7i70Gc
 vCnQyNRlBC8Vx6cSZKwl1e7xVtS6BlKK68imgBT1ep6DobwvyZmREN8BrW7tzLTaFQtBOQTHP
 EnTFMFA0dxJKskv0iLHxoaQmW60XncpyqKyVHeqk18ZeZQb2y7oKrJYl/sj17IRpQGWbsKrwm
 D+vz6s43hi8YczNPzo/UHjEE1qBGeAkiVdjhvRiL4dvRRqFN8CilAfoLZM9yTWKd5TR8RLkuh
 8cyuEh+6BIqWz7xddNeOxqpiTfla0Z8OOjlTc1q6hoNzih4ZTTA+ADpaUFaHZM9MmiTeKz+v/
 B1HindPMezSNxzCiFGw1knfrZGRQLcr4D9/Lb7cA9B/4ml4oZt+ddVMJLLbXxN3ZBLIURbiUm
 IJYPB6946+81jU9WmfxP4/WtpfrHRAbkQwExIwcmsqADrqzu5OL5DtvtGpRwyAfyHLO2/tEyM
 +lyc2yw9W12eYHlh+WZHd5t11lARW7NIBPmheviFgI2HO8YwDjIPlknSwT45BFT4wMhZPhmii
 k8SZbPmOpVfki/itcdw/4mCuwbnnC0PQ/vKxEz0cBlCYMgda7xgy2m7lI7u8ewO1cOPYO6Eoi
 Ngsf9PlKf2RULPq9gAXD/85lt4iBsoVMh0SMXlnDZJy32Ar+X0K9K2smhE5qiYGj5/Rfw5WXT
 LPBLnPVYJ3sXaKQCH+2a45iaTB7ByN9ezVNEz0kOdWDRUczIZL3okXaOHY+Zhrz+37fL5RU80
 8bofDyLQNZ0BOe7qZqhB6L6yPqVKGCxdzktDbEMxES3TbMnYaxK/8zey2ozI8zH4nTth1N1HA
 4EFEiVdv7xo0W+bKxIfyTinm5UhaX6T9KbsmIe3sOwMKPTFOglrM1t1+kwdrvc8ecPr89Qe2i
 kNnMp0dWPCziGwboMK47D8nfH87giOhFx+N8yXuH4M7xaKYAdEid7yQJfxLWCf6YmT2E0w3SI
 V1nzKWvoAWuy4UIedSgI+DJD4lIDbgznf2FqyPpwv7eLsC8uG+FFUz7CK6+HYbSl1hlWnsLNk
 xPaVEca9YuBdUKKt+Dn6k35+8BXg/yfu2Qx9JK5BvGF435nXRFIxowS49ewIXpm7x75JI5rZ2
 xOQ0RI5lFQp936BXh+u7lqBEz5IRTtQz8yI+ik29CYk5DY4zlvhhBRCCg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-13 at 16:34 +0000, Lopez, Jorge A (Security) wrote:
> HI Alex,
>=20
> HP is working in publishing HP BIOS to LVFS and the team is making
> progress.=C2=A0=20
> There are several BIOS published and it appears BIOS for your Elite
> Dragonfly is one of them.=C2=A0=C2=A0=20
> See https://fwupd.org/lvfs/firmware/10948.
>=20
> The BIOS is applicable to notebooks with T90 type BIOS.=C2=A0 If you
> decide to try flashing the firmware, please do it at your own risk.
>=20
> BIOS-System Firmware (1)
> HP BIOS and System Firmware (T90)
> Version: 01.09.10 Rev.A=C2=A0
>=20
>=20

Great! Thanks =F0=9F=99=82
>=20
> Regards,
>=20
> Jorge Lopez
> Hewlett-Packard=20
>=20
> =E2=80=9COnce you stop learning, you start dying=E2=80=9D
> Albert Einstein
>=20
> -----Original Message-----
> From: Alex Dewar <alex.dewar@gmx.co.uk>=20
> Sent: Wednesday, July 13, 2022 3:17 AM
> To: Lopez, Jorge A (Security) <jorge.lopez2@hp.com>; Hans de Goede
> <hdegoede@redhat.com>; dmitry.torokhov@gmail.com; tiwai@suse.de;
> markgross@kernel.org
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> platform-driver-x86@vger.kernel.org
> Subject: Re: input/i8042: Malfunctioning brightness keys on HP Elite
> Dragonfly G2
>=20
> On Mon, 2022-07-11 at 14:59 +0000, Lopez, Jorge A (Security) wrote:
> > Hi Alex,
> >=20
> > Thank you for the BIOS information.=C2=A0=C2=A0 The problem you are
> > experiencing=20
> > was fixed in BIOS version 01.07.02 Rev.A
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- Fixes an issue where =
Fn+F3/F4 do not change the
> > brightness=20
> > of the display panel when the Privacy Panel is enabled in the F10=20
> > settings.
> >=20
> > The latest BIOS version is 01.09.01 Rev.A so the problem will be=20
> > resolved after BIOS upgrade.=C2=A0=C2=A0=C2=A0 BIOS is not available vi=
a LVFS, you
> > will need to install it via Windows executable.
> > https://support.hp.com/us-en/drivers/laptops
> >=20
> > Let me know if the problem is resolved.
>=20
> That worked a treat. Thanks!
>=20
> And if you have an internal ticked called "Support Elitebooks on
> LVFS"
> or similar, feel free to add my +1 to it =F0=9F=98=89
>=20
> Best,
> Alex
>=20

