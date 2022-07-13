Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F405730DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiGMIVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiGMIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:20:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671CA5465B;
        Wed, 13 Jul 2022 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657700210;
        bh=GAwk9qd7tZg332v44jQUo75pcb1GR4m0F9yZEgaKLCg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=YB09cARecWsHfg3dfcMHTmn2GMVhXwbjs5ThuUDo57Z4HSCZBs32RFnGCm4VbkvUS
         B0M3WR4VfvAicN8dV/F8+1J/cJeE56DihKzCWyK7q1ESMcfVA0pdQHV/uiFoPFa8lB
         70E4DVBXohPiVVUftwOws7EJzPDWSo70X4Vl5nzs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ic-alex-elitebook.lan ([80.189.168.50]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MV63g-1o0ysG0iZy-00S7ih; Wed, 13 Jul 2022 10:16:50 +0200
Message-ID: <afeb858778de9b25d0de655ffccb64b85511c428.camel@gmx.co.uk>
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
Date:   Wed, 13 Jul 2022 09:16:49 +0100
In-Reply-To: <PH0PR84MB195301AA9C44F2F4ECE4A848A8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
         <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
         <8b893c42-e514-bcef-0513-070b3723cdcc@redhat.com>
         <df7313597d2ac3212f10c05aa3d369728f030c86.camel@gmx.co.uk>
         <c89d39eb-17b9-8800-c8ff-8d236b80de2f@redhat.com>
         <PH0PR84MB195309F5BA5B96858024E61FA8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
         <PH0PR84MB19536D04A5625D4DC8B76AF1A8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
         <0e8611ad73017bc204372f491ae5666dd60885a9.camel@gmx.co.uk>
         <PH0PR84MB195301AA9C44F2F4ECE4A848A8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Provags-ID: V03:K1:y/Uolrn3aw6TxRubXzhmxIGTrkjAJiZG08BQOmcALvroOcOkGKd
 sawVpq3jiUu5ds2qwp2Km70ZFnoCofpI9K5Roq1bN+/Oq/5vXpZ3UvbrtMNwlM03Aqp8X2l
 tvZkaPM7Pudq6U6dtN7Wl+auGzEEi81/THYAxAYNACcgvPloI9M4fWY097xp12JuBBtetNU
 UGtRl4SE5VL+23ccer8Qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pODMSipcA2g=:+vRyedoC465yQYymodw2xJ
 vXrbyRyVeZloHxAjUM6KxbdTPvz3ezWjCKDKBT3eJjzwD/xs7WiaGQSQ9ciKbiVDHuJYz4HBZ
 uySTm+I6W3VvJk5EmRdupoKkldvIIr9ahTuFVUvEAs5+nkGVHHrJ7Qya7cDFEhsl37HxPgMkU
 xB1herAAyQIJDxKMEhwmHNkaPbc25XrCo4xoZ+oFe/Rnr77Ohr7Ck0OZSBandWPZLF3cCVH0p
 hCxrkpnTymrxl/IaIbg4TLChNQEn2eSqtbxwEQMPJdHgnumWUerOYv4Fr62h7UwtImc5vaQAm
 qdyOp6DbQ5su0exihOoCO5IxNxslSf72ak+H2GPe25bbLtRTXfMmfPmZFIGTW5FgYeON7UgAY
 J6uoNLQOgWTFoy+qr98dAan8wweUtEuCg4w+HQ0x74OEJv86hcjAdI+3v3VsDxsXopKFK80it
 iWpIAKvSUHVBOR6UyQJv8IY96pE1Sgm9JQBFh3Y5bCELUgPbsOGQfN3x7sexuNNCeQmtRmtN8
 OW3tjGfO0130LrEWHqSpr4L4FEVi3CkIR3AAk6KObzvC0QL8Fi2UWsahGKbjjo4POU1gS91Si
 n5m1bh63DFX/vLIIa737fc5n8069V1wnMGrSqDHC8M2kYppcvuPctLVGZsw0kbJTeGeJSCvAx
 R3tpsIC92KT+LOMBTImkIeYz/8ajaTLXygl/t5S/VCDPJEWevK6HyLFK4lfl1MHeLDtzMcMzd
 mUSy9vnVHmxryBJhc4ax5jllIQEd6LgdUcaNPuGJX7L8lqawl9xmnxSMkUKkFOWNJEzcBEbXE
 i1p8Vx0p2f34May/1n6As8frzRKckvqthnu0WWivCZIKKi7zPyo25d8w4sJY3mr4cj+HvL+1/
 sthYrTDacj2gcrqhmxgcN994lP5/a3K9JK84prdTYSVTRwsjzVEkxblrmT1dwhN0DBH9hfrUB
 L79J8+UQn2vlnM6a5SX+6mO4UNRlUfmTC3uVoaAeiHUWsaiTSCr2MuFKTxVMNeCfr0jQWm0Ay
 G7EWC4PcKqq3yJTmbmTDe1S6pmcFhK4YcgBpQ22zs1nVFmDqvWO6hrKku5SLNlMoK0f0NShFz
 RrCUwCPuGpZZr9a1koSBD1lIMSg69LfTPcHTYpz8NKnCujFVcLbO2Pw1Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-11 at 14:59 +0000, Lopez, Jorge A (Security) wrote:
> Hi Alex,
>=20
> Thank you for the BIOS information.=C2=A0=C2=A0 The problem you are
> experiencing was fixed in BIOS version 01.07.02 Rev.A
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- Fixes an issue where Fn=
+F3/F4 do not change the brightness
> of the display panel when the Privacy Panel is enabled in the F10
> settings.
>=20
> The latest BIOS version is 01.09.01 Rev.A so the problem will be
> resolved after BIOS upgrade.=C2=A0=C2=A0=C2=A0 BIOS is not available via =
LVFS, you
> will need to install it via Windows executable.
> https://support.hp.com/us-en/drivers/laptops
>=20
> Let me know if the problem is resolved.

That worked a treat. Thanks!

And if you have an internal ticked called "Support Elitebooks on LVFS"
or similar, feel free to add my +1 to it =F0=9F=98=89

Best,
Alex
