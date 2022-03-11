Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E34D584C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345727AbiCKCoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbiCKCoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:44:18 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01EF5419
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:43:14 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220311024311epoutp0392c2ba27558088c576b3899b691fdfd3~bM2OFuSSW1894018940epoutp03a
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:43:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220311024311epoutp0392c2ba27558088c576b3899b691fdfd3~bM2OFuSSW1894018940epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646966591;
        bh=NUDTE57F0DdzRh7R26Cnm6vu/JSZJxqGGYbS9+198pM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Lf8V44Ao7oJXRQ3nD6Ot5eLIbpmpluXETSJrhHCqNQEpRacHfw3dDQO6+ylQYtcv9
         64BGjRaYlGh8rWb3ihZl4OCWeHYzDJtz+/mJu/VXcjjl/CwOablT1XsO1SyrCMIKoA
         Jtj9CWACuDtrkjTd1CPZbZ24a0uz6QDDXWA22xxk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220311024310epcas2p16a64a2c2320a57c11db648bc2f62edea~bM2Nc-AgL0101401014epcas2p1P;
        Fri, 11 Mar 2022 02:43:10 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KF9GN6CGDz4x9QR; Fri, 11 Mar
        2022 02:43:08 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.8A.33036.A37BA226; Fri, 11 Mar 2022 11:43:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220311024305epcas2p2f9482558b88a8a5ebb9030440195dfdc~bM2JF4CXH0992709927epcas2p2B;
        Fri, 11 Mar 2022 02:43:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220311024305epsmtrp113ac46e10b1ba0d9fee6a520fc76af10~bM2JE-L8y1486714867epsmtrp1j;
        Fri, 11 Mar 2022 02:43:05 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-f3-622ab73ac96f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.46.03370.937BA226; Fri, 11 Mar 2022 11:43:05 +0900 (KST)
Received: from KORDO034583 (unknown [10.229.18.132]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220311024305epsmtip2844dcfefe601145efda0e37d64fe8339~bM2I5p6Yp0645406454epsmtip2E;
        Fri, 11 Mar 2022 02:43:05 +0000 (GMT)
From:   =?UTF-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>
To:     "'Thinh Nguyen'" <Thinh.Nguyen@synopsys.com>,
        "'Felipe Balbi'" <balbi@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>,
        "'Seungchull Suh'" <sc.suh@samsung.com>,
        "'Daehwan Jung'" <dh10.jung@samsung.com>, <cpgs@samsung.com>,
        <cpgsproxy5@samsung.com>
In-Reply-To: <559b00b6-8b3d-9422-6a25-674f719ad237@synopsys.com>
Subject: RE: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt
 storming
Date:   Fri, 11 Mar 2022 11:43:05 +0900
Message-ID: <017f01d834f1$bc3a9c30$34afd490$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: ko
Thread-Index: AQKjdV3S7gSSYh+T3/lJgRyIlCpbTQJQQbEmAWDN/4EB6fufUwOJLlPlqtnLqfA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmma7Vdq0kg9OP+C2OtT1ht3h5SNNi
        88MrbBZ3FkxjsmhevJ7N4vKuOWwWi5a1Mlt03b3BaLFqwQF2B06PTas62Tz2z13D7tG3ZRWj
        x5b9nxk9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCdMePXbtaCX9oVE+9xNzBe1+pi5OSQEDCRWLLuPQuILSSwg1Fi0QPZLkYu
        IPsTo8SEdUdYIZzPjBKrFnSxwHS0/X7KApHYxSixcsc+dgjnJaPEwYMPmbsYOTjYBCwkzjbo
        g8RFBHoYJY603GYEcZhB5s582g42ilPAQeLGhKWMIA3CAv4Sjx/VgYRZBFQlpjb+YASxeQUs
        Jb4fW8AOYQtKnJz5BKyVWUBbYtnC18wQFylI7P50lBUiLiIxu7MNLC4i4Cdx7NoDsL0SAks5
        JO5/6WGFaHCRWPz1IJQtLPHq+BZ2CFtK4mV/G5RdLNG56RBUcwOjxLcDHUwQCWOJWc/awY5m
        FtCUWL9LH8SUEFCWOHILGkK8Eg0bf7ND3MMn0XH4LztECa9ER5sQRImqxMHGmywTGJVnIfls
        FpLPZiH5ZhbCrgWMLKsYxVILinPTU4uNCkzgcZ2cn7uJEZxStTx2MM5++0HvECMTB+MhRgkO
        ZiUR3qZQjSQh3pTEyqrUovz4otKc1OJDjKbAsJ7ILCWanA9M6nkl8YYmlgYmZmaG5kamBuZK
        4rxeKRsShQTSE0tSs1NTC1KLYPqYODilGpjOrao7/MwgtiMg9K68bphW2U/zPuOqb43Whtls
        Fc7a9+T/3/mtGHs59s6RJxcmuIWLLvmkNdlG5Dmz499H7ikvnOfp98wJisj9tbNcxDhPf/r6
        t5b/4uZ8CbBNj9ZfwfnVc1fBW7/p6+zslEIy5p9bcC9KccuvhUvzWJ/94Ot98pdV4cHivWGS
        r86E9vt3f9ITTrRNYGO8HpJetaaf9+KPo6/XKoacX3yXddJVzxtLnhkxRfkb1O54PKd8tmng
        m6kLz+59f2PH5ievDrbM3s1+ly3uk931DY6qFosvMWtF1T8/nhpx9rrqzaNJmxgvM/XKNXFr
        5N17OX95ndd7seqrs5/nOEsHBZj3GAuuaRNVYinOSDTUYi4qTgQAyOzBQTIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXtdyu1aSwbVbRhbH2p6wW7w8pGmx
        +eEVNos7C6YxWTQvXs9mcXnXHDaLRctamS267t5gtFi14AC7A6fHplWdbB77565h9+jbsorR
        Y8v+z4wenzfJBbBGcdmkpOZklqUW6dslcGVcWHCXuaBdvmL9+SVMDYzfJboYOTkkBEwk2n4/
        Zeli5OIQEtjBKHHu6hlmiIS0xM7OqUwQtrDE/ZYjrBBFzxkl/s/4xNjFyMHBJmAhcbZBHyQu
        ItAH1PxnLTOIwyzwjVFiweKDTBAdG5gkPu/8wAYyilPAQeLGhKWMILawgK/Erj0tYCtYBFQl
        pjb+AIvzClhKfD+2gB3CFpQ4OfMJC4jNLKAt0fuwlRHGXrbwNdSpChK7Px1lhYiLSMzubAOL
        iwj4SRy79oBxAqPwLCSjZiEZNQvJqFlI2hcwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dL
        zs/dxAiOMi2tHYx7Vn3QO8TIxMF4iFGCg1lJhLcpVCNJiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBibL76ZpBQ/mVNqnP/w/Y4LgxVem9aLvdubIaObv
        fF+W3F1Sfv3qj71RrGfYlgR31ahfWZ3PcaswQPha58MLp7aYdE0/f+izZ9KnxyHSx5pY9yU5
        iepqbPk9ObizxN8068HMlbvl4o1nndb8lP65PvUAl8KXU0/EeNrWPH/l96/t5KSafYtmGxuo
        /PXPfr1UV2uLzqnHMXYNqWuvX09sOO/0J/PfejMfxo2yGs5WWyfIuLf1T3oaznzElpuF957S
        nQV6h5wnu33NO+ntIrFwben5/U0Kmy/MWLLouFwNq7i8qv2/+3LcbI6JnFps+YqX1jW5r+cI
        n10xX8C+XpT9mruw0o/d6Sf27VBn6VMqi1ViKc5INNRiLipOBADy6SOHIQMAAA==
X-CMS-MailID: 20220311024305epcas2p2f9482558b88a8a5ebb9030440195dfdc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307052605epcas2p2b84f6db2642863ed61373070f508e200
References: <CGME20220307052605epcas2p2b84f6db2642863ed61373070f508e200@epcas2p2.samsung.com>
        <1646630679-121585-1-git-send-email-jh0801.jung@samsung.com>
        <99eabe6c-8782-1bc6-e1d7-09b019cee65b@synopsys.com>
        <016a01d834e7$72b11fd0$58135f70$@samsung.com>
        <559b00b6-8b3d-9422-6a25-674f719ad237@synopsys.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Thinh Nguyen =5Bmailto:Thinh.Nguyen=40synopsys.com=5D
> Sent: Friday, March 11, 2022 10:57 AM
> To: =EC=A0=95=EC=9E=AC=ED=9B=88;=20Thinh=20Nguyen;=20'Felipe=20Balbi';=20=
'Greg=20Kroah-Hartman'=0D=0A>=20Cc:=20'open=20list:USB=20XHCI=20DRIVER';=20=
'open=20list';=20'Seungchull=20Suh';=20'Daehwan=0D=0A>=20Jung';=20cpgs=40sa=
msung.com;=20cpgsproxy5=40samsung.com=0D=0A>=20Subject:=20Re:=20=5BPATCH=5D=
=20usb:=20dwc3:=20Add=20dwc3=20lock=20for=20blocking=20interrupt=0D=0A>=20s=
torming=0D=0A>=20=0D=0A>=20=EC=A0=95=EC=9E=AC=ED=9B=88=20wrote:=0D=0A>=20>=
=20Hi.=0D=0A>=20>=0D=0A>=20>>=20-----Original=20Message-----=0D=0A>=20>>=20=
From:=20Thinh=20Nguyen=20=5Bmailto:Thinh.Nguyen=40synopsys.com=5D=0D=0A>=20=
>>=20Sent:=20Thursday,=20March=2010,=202022=2011:14=20AM=0D=0A>=20>>=20To:=
=20JaeHun=20Jung;=20Felipe=20Balbi;=20Greg=20Kroah-Hartman=0D=0A>=20>>=20Cc=
:=20open=20list:USB=20XHCI=20DRIVER;=20open=20list;=20Seungchull=20Suh;=20D=
aehwan=0D=0A>=20>>=20Jung=0D=0A>=20>>=20Subject:=20Re:=20=5BPATCH=5D=20usb:=
=20dwc3:=20Add=20dwc3=20lock=20for=20blocking=20interrupt=0D=0A>=20>>=20sto=
rming=0D=0A>=20>>=0D=0A>=20>>=20Hi,=0D=0A>=20>>=0D=0A>=20>>=20JaeHun=20Jung=
=20wrote:=0D=0A>=20>>>=20Interrupt=20Storming=20occurred=20with=20a=20very=
=20low=20probability=20of=20occurrence.=0D=0A>=20>>>=20The=20occurrence=20o=
f=20the=20problem=20is=20estimated=20to=20be=20caused=20by=20a=20race=0D=0A=
>=20>>>=20condition=20between=20the=20top=20half=20and=20bottom=20half=20of=
=20the=20interrupt=0D=0A>=20>>>=20service=0D=0A>=20>>=20routine.=0D=0A>=20>=
>>=20It=20was=20confirmed=20that=20variables=20have=20values=20that=20canno=
t=20be=20held=20when=0D=0A>=20>>>=20ISR=20occurs=20through=20normal=20H=20/=
=20W=20irq.=0D=0A>=20>>>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=0D=0A>=20>>>=20=3D=20(struct=20dwc3_event_buffer=20*)=20ev_buf=20=3D=
=200xFFFFFF88DE6A0380=20(=0D=0A>=20>>>=20=09(void=20*)=20buf=20=3D=200xFFFF=
FFC01594E000,=0D=0A>=20>>>=20=09(void=20*)=20cache=20=3D=200xFFFFFF88DDC140=
80,=0D=0A>=20>>>=20=09(unsigned=20int)=20length=20=3D=204096,=0D=0A>=20>>>=
=20=09(unsigned=20int)=20lpos=20=3D=200,=0D=0A>=20>>>=20=09(unsigned=20int)=
=20count=20=3D=200,=20<<=0D=0A>=20>>>=20=09(unsigned=20int)=20flags=20=3D=
=201,=20<<=0D=0A>=20>>>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=0D=0A>=20>>>=20=3D=20=22evt->count=3D0=22=20and=20=22evt->flags=3DDW=
C3_EVENT_PENDING=22=20cannot=20be=20set=0D=0A>=20>>>=20at=20the=20same=20ti=
me.=0D=0A>=20>>>=0D=0A>=20>>>=20We=20estimate=20that=20a=20race=20condition=
=20occurred=20between=20dwc3_interrupt()=0D=0A>=20>>>=20and=20dwc3_process_=
event_buf()=20called=20by=0D=0A>=20>>>=20dwc3_gadget_process_pending_events=
().=0D=0A>=20>>>=20So=20I=20try=20to=20block=20the=20race=20condition=20thr=
ough=20spin_lock.=0D=0A>=20>>=0D=0A>=20>>=20This=20looks=20like=20it=20need=
s=20a=20memory=20barrier.=20Would=20this=20work=20for=20you?=0D=0A>=20>=20M=
aybe=20it=20could=20be.=20But=20=22evt->count=20=3D=200;=22=20is=20updated=
=20on=0D=0A>=20dwc3_process_event_buf().=0D=0A>=20>=20So,=20I=20think=20spi=
n_lock=20is=20more=20clear=20routine=20for=20this=20issue.=0D=0A>=20>=0D=0A=
>=20=0D=0A>=20Not=20really.=20If=20problem=20is=20due=20to=20the=20evt->fla=
gs=20not=20updated=20in=20time,=20then=0D=0A>=20the=20solution=20should=20b=
e=20using=20the=20memory=20barrier.=20The=20spin_lock=20would=0D=0A>=20obfu=
scate=20the=20issue.=20And=20we=20should=20avoid=20using=20spin_lock=20in=
=20the=20top-half.=0D=0A=0D=0AThis=20issue=20was=20occurred=20by=20watchdog=
.=20The=20interrupt=20occurred=20in=20units=20of=204=20to=205us=20and=20can=
not=20be=20released=20until=20the=20bottom=20is=20executed.=0D=0AIf=20it=20=
is=20a=20problem=20with=20the=20memory=20barrier,=20the=20value=20should=20=
be=20updated=20after=20a=20few=20clocks=20and=20the=20TOP=20should=20run=20=
normally.=20Isn't=20it?=0D=0AAnd=20Could=20you=20explain=20me=20why=20we=20=
should=20avoid=20using=20spin_lock=20in=20the=20top-half.=0D=0A=0D=0A>=20=
=0D=0A>=20BR,=0D=0A>=20Thinh=0D=0A>=20=0D=0A>=20>>=0D=0A>=20>>=20diff=20--g=
it=20a/drivers/usb/dwc3/gadget.c=20b/drivers/usb/dwc3/gadget.c=0D=0A>=20>>=
=20index=0D=0A>=20>>=20c02e239978e0..a96c344b9f17=20100644=0D=0A>=20>>=20--=
-=20a/drivers/usb/dwc3/gadget.c=0D=0A>=20>>=20+++=20b/drivers/usb/dwc3/gadg=
et.c=0D=0A>=20>>=20=40=40=20-5340,6=20+5340,9=20=40=40=20static=20irqreturn=
_t=20dwc3_check_event_buf(struct=0D=0A>=20>>=20dwc3_event_buffer=20*evt)=0D=
=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20IRQ_HA=
NDLED;=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=7D=0D=0A>=20>>=0D=0A>=20>>=20=
+=20=20=20=20=20=20=20/*=20Make=20sure=20the=20event=20flags=20is=20updated=
=20*/=0D=0A>=20>>=20+=20=20=20=20=20=20=20wmb();=0D=0A>=20>>=20+=0D=0A>=20>=
>=20=20=20=20=20=20=20=20=20/*=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20*=
=20With=20PCIe=20legacy=20interrupt,=20test=20shows=20that=20top-half=20irq=
=0D=0A>=20>>=20handler=20can=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20*=20b=
e=20called=20again=20after=20HW=20interrupt=20deassertion.=20Check=20if=0D=
=0A>=20>>=20bottom-=20half=0D=0A>=20>>=0D=0A>=20>>=0D=0A>=20>>=20Thanks,=0D=
=0A>=20>>=20Thinh=0D=0A>=20>=0D=0A=0D=0A=0D=0A
