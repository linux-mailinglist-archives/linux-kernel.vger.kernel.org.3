Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1956C4A6E99
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbiBBKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:23:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49286 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbiBBKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:23:04 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220202102302epoutp02d0dd5b72ea18e665b95f749caf8bc138~P8QKatU-w0454704547epoutp02g
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 10:23:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220202102302epoutp02d0dd5b72ea18e665b95f749caf8bc138~P8QKatU-w0454704547epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643797382;
        bh=uXYenapP+M+skViYeaA8T3CFXnCpSivrd+hyp8bOTAA=;
        h=Date:Subject:Reply-To:From:To:CC:In-Reply-To:References:From;
        b=sEhQFEMmeWQ+zSXvGJQxkgtZIuH2S7nW/DEiRBM44yzq7tsij5aeZDB230MADn9mb
         kM2d+EZ9LrEOeOkaSPQuRUoKibOqaUF32ahuEDucKZbxellg59QAcMDo0lZLZ71AFs
         lpY3NaoDgOBi3agplZcON766PJHuGcYPVBEiyrXo=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220202102301epcas5p20f09cb35e779679944212bd076822a75~P8QJ3cZym0127201272epcas5p29;
        Wed,  2 Feb 2022 10:23:01 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-56-61fa5b1fbbdb
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.6C.46822.F1B5AF16; Wed,  2 Feb 2022 19:21:19 +0900 (KST)
Date:   Wed, 02 Feb 2022 15:38:16 +0530
Message-ID: <1167862481.1626207.1643796496590@mail-kr5-2>
Mime-Version: 1.0
Subject: RE: [PATCH RESEND v2] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Joe Perches <joe@perches.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <b7f445008e9921f41df36077a7e28562675e8417.camel@perches.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20220202100816epcms5p53058dc6f44229f8052f332f2a9b83249
Content-Type: multipart/mixed;
        boundary="----=_Part_1626206_1445824588.1643796496590"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XaOZ5u0OE6jV81Gll0sNbPLEouCqCloRdDFAnd0JzXnHJua
        XahR2VKzrM2yeVlCJsxqw7zOlbHRZUaaRJZkmVpmjW44sDIt59mo/37f896e9+XjYHyLVwAn
        XZZNK2SUNJjwxptsSxaFCfb+opa3/4gWfru5WGisvo4Jy/uHcOEzcwUhPHVfjQut9kq0gRDp
        VMWEqFX3mi1yGnow0bkGAxKN1s/d5pXoHSOhpem5tCJivdg7rf9jL5LbBHlq2zNMhW4GFiIu
        B8iV4Gh8wS5E3hw+2Yag7aWD5QrgZAhoO2yYi3nkWrA9rEGFiDPFPjDR4uuSfcl0MFo7cRfz
        yXnwtOzGdIovuRx+NS52yQQZDgazBXe19yNbEIyeqJ1uj03Vlhd0EYwHHpSp3+MMB0JzbSNy
        MZeMhXK1k8Xos6C37jPbw18f6BHDfpD/5gnGsA+8/dnm1udA3e3i6cFAFiEwfrnjfpQhODt4
        yV2xBozXDO6um2DSamcz7nbBpPaMOycISjtuuV3PhOLxdyyP65YqD4fAqV6Tl2eD0e/f3duI
        oEFtIpjrPmLBp14LUYIEun+H1P03jmEBNH+uwFwpGLkEjOYIRl4I2vNOguHVoFKX4gzPA23R
        APsqYhuQPy1XZqbSylXyFTL6YLiSylTmyFLDU7Iy69H0pwqNa0EDb7+FWxGLg6xowVT5oKnu
        KQrAZVkyOtiPd6d6jOLzJNShw7QiK0mRI6WVVhTIwYNn8x6nmig+mUpl0xk0LacVniiLww1Q
        se72jCbKf/c94Leaa4er1I/PdMSubgo9uUhVu6+gVLMuKKVegm+5dzWR+BA/fHyz2MG6kBA/
        X/5BGrO5PTuvyTLmqE7L3NmtiyqSdXMrLurF+VvH+o40dxri3pzz/3Ms1770z6W9E3ljmsTJ
        JEGOLj7SWJOjzbUXOOssO66P5zuuzDH4PHq+u0vSdfSwz9DZK86JCxufD+uNms6Upo6wmphu
        vSS5qvxkT1ZsVFDDAHtie9gM7ulOTVL8nuiX4ntxXdKMwTVmvtp37TbihwbiDshu6SPskuiU
        ncukISFDG/H+oPcJYluJ4wCM728d4ZnMfgeTXyWMVJZULxi57G+opIJxZRoVGYoplNRfXiwn
        Kc8DAAA=
X-CMS-RootMailID: 20220202071414epcas5p1d329ae4f76c281c1f8f7f07bfb36a919
References: <b7f445008e9921f41df36077a7e28562675e8417.camel@perches.com>
        <4ee87d70d5348949787b2d747f90ecffa3119d0b.camel@perches.com>
        <20220202071405.1872044-1-maninder1.s@samsung.com>
        <20220202095225epcms5p271da4783d86cb7c51d12d80f097aea44@epcms5p2>
        <CGME20220202071414epcas5p1d329ae4f76c281c1f8f7f07bfb36a919@epcms5p5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1626206_1445824588.1643796496590
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

Hi,

> > > >  printk_deferred and printk_deferred_once requires LOGLEVEL in argument,
> > > >  but checkpatch.pl reports it as warning:
> >  
> > > When did that occur?  Please reference the specific commit.
> > > When printk_sched (now printk_deferred) was created it did not
> > > allow KERN_<LEVEL>.
> >  
> > > see commit 3ccf3e830615 ("printk/sched: Introduce special printk_sched() for those awkward moments")
> >  
> > I think with below commit:
> > 
> > 98e35f5894cf208084688ec0c7bb7b713efc997f (printk: git rid of [sched_delayed] message for printk_deferred)
> > 
> > earlier it was passing hardcoded KERN_WARNING to all printk_deferred messages, but now it switched
> > to normal printk behavior.
> > 
> > -       if (in_sched)
> > -               text_len = scnprintf(text, sizeof(textbuf),
> > -                                    KERN_WARNING "[sched_delayed] ");
> > -
> > -       text_len += vscnprintf(text + text_len,
> > -                              sizeof(textbuf) - text_len, fmt, args);
> > +       text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
> > 
> > 
> > I did not search that earlier, because we were fixing some issue in our local module code with printk_deferred
> > and then checkatch reported the issues, so thought of fixing it, becaue without level
> > pritk_deferred messages was shifted to default loglevel as done by normal printk.
> > 
> > So I thought it was designed to pass loglevel from starting stage and checjpatch reports falsely.
> > but seems checkpatch needs to fixed with that commit itself, because earlier it was not required to pass loglevel.
>  
> Most of that should be in the commit message.

Yes, Initially I thought it's added in checkpatch by mistake,
I Should have checked history of printk_deferred also.

I will send new version with updated comit message.

Thanks
------=_Part_1626206_1445824588.1643796496590
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBSZTogW1BBVENIIFJFU0VO
RCB2Ml0gc2NyaXB0cy9jaGVja3BhdGNoLnBsOiByZW1vdmUgX2RlZmVycmVkIGFuZCBfZGVmZXJy
ZWRfb25jZSBmYWxzZSB3YXJuaW5nDQogICAgICBGcm9tICAgICAgIDogbnVsbA0KICAgICAgU2Vu
dCBEYXRlICA6IDIwMjItMDItMDIgMTU6MjkgIEdNVCs1OjMwDQogICA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
CiAgICAgICAgICAgICAgICAgIE5hbWUgICAgICAgICAgICAgICAgVHlwZSAgICAgICAgICBKb2Ig
VGl0bGUgICAgICAgICAgICAgICAgICAgICAgIERlcHQuICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIENvbXBhbnkgICAgICAgICAgICAgICAgDQogICA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAg
IE1hbmluZGVyIFNpbmdoICAgICAgICAgICAgICAgICBUTyAgICAgICAgIFN0YWZmIEVuZ2luZWVy
ICAgICAgICAgICAgIFN5c3RlbSBTL1cgR3JvdXAgL1NSSS1EZWxoaSAgICAgICAgICAgICAgIFNh
bXN1bmfCoEVsZWN0cm9uaWNzwqANCiAgICAgIGFwd0BjYW5vbmljYWwuY29tICAgICAgICAgICAg
ICBUTw0KICAgICAgZHdhaXBheWFucmF5MUBnbWFpbC5jb20gICAgICAgIFRPDQogICAgICBsdWth
cy5idWx3YWhuQGdtYWlsLmNvbSAgICAgICAgVE8NCiAgICAgIGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcgICBDQw0KICAgICAgVmFuZWV0IE5hcmFuZyAgICAgICAgICAgICAgICAgIENDICAg
ICAgICAgQXNzb2NpYXRlIEFyY2hpdGVjdCAgICAgICAgU3lzdGVtIFMvVyBHcm91cCAvU1JJLURl
bGhpICAgICAgICAgICAgICAgU2Ftc3VuZyBFbGVjdHJvbmljcw0KICAgPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQo=

------=_Part_1626206_1445824588.1643796496590--
