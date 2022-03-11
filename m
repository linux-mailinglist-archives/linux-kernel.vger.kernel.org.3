Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C971B4D5A34
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbiCKFDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbiCKFCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:02:50 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261D1AC29A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:01:47 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220311050145epoutp02dc3f881024e4437e1a9a17c883feb4fe~bOvNpXPf12092120921epoutp02y
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:01:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220311050145epoutp02dc3f881024e4437e1a9a17c883feb4fe~bOvNpXPf12092120921epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646974905;
        bh=GBOlJ6MVhTSZPcEgEpSFrY5u5VTXP074LWgPQhN+1+c=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=gpmHWvSRI48a3mgBhkq7SMfbveuubuRWgJY5PBCqxTvgbgdOLPFRc/A6QMesA016v
         sxBBmq6jzIqQWNcU+W+RYkK0H2XK2InfFK9oX0Vt/g3pIaElgO4/qHghQruaeB/6QG
         gfEW/E8J8TxDvnZW6yvOtDkKz7QNDkPPE3e+ElUE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220311050145epcas2p4b09b203619c9556cfddebab58eefb713~bOvNKGZC71417514175epcas2p42;
        Fri, 11 Mar 2022 05:01:45 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KFDLG539vz4x9Q2; Fri, 11 Mar
        2022 05:01:42 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.F3.33036.4B7DA226; Fri, 11 Mar 2022 14:01:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220311050139epcas2p4fdab8b9b2eff9bf67d88809636237daf~bOvHwsUi11415014150epcas2p4q;
        Fri, 11 Mar 2022 05:01:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220311050139epsmtrp2263c76455c37fb97d1bf42f9e0f9512d~bOvHvd-M22829028290epsmtrp27;
        Fri, 11 Mar 2022 05:01:39 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-b4-622ad7b4e547
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.65.03370.3B7DA226; Fri, 11 Mar 2022 14:01:39 +0900 (KST)
Received: from KORDO034583 (unknown [10.229.18.132]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220311050139epsmtip2abfa9628da94ae1ae6dd8379bf8654fd~bOvHfGvgD3189731897epsmtip2P;
        Fri, 11 Mar 2022 05:01:39 +0000 (GMT)
From:   =?UTF-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>
To:     "'Thinh Nguyen'" <Thinh.Nguyen@synopsys.com>,
        "'Felipe Balbi'" <balbi@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>,
        "'Seungchull Suh'" <sc.suh@samsung.com>,
        "'Daehwan Jung'" <dh10.jung@samsung.com>, <cpgs@samsung.com>,
        <cpgsproxy5@samsung.com>
In-Reply-To: <a1b9752f-96e6-7abb-d6d3-ce4742742a0c@synopsys.com>
Subject: RE: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt
 storming
Date:   Fri, 11 Mar 2022 14:01:39 +0900
Message-ID: <01cc01d83505$177fcdf0$467f69d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: ko
Thread-Index: AQKjdV3S7gSSYh+T3/lJgRyIlCpbTQJQQbEmAWDN/4EB6fufUwOJLlPlAwpg8+wBeBNGKQGGkImxqqmnkvA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhe6W61pJBk/mc1oca3vCbvHykKbF
        5odX2CzuLJjGZNG8eD2bxeVdc9gsFi1rZbbounuD0WLVggPsDpwem1Z1snnsn7uG3aNvyypG
        jy37PzN6fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8v
        tcTK0MDAyBSoMCE749HWg+wFd6wreq/fY21gbLXqYuTkkBAwkdj28xhrFyMXh5DADkaJuzd/
        MkE4nxglzsxeAZX5zCjxoucAO0zLy5t72CASuxgl/l19ANXyklHi0s1zQBkODjYBC4mzDfog
        DSICPYwSn/rVQGqYQcbOfNrOApLgFHCQuH3xAli9sIC/xONHdSAmi4CqxP3GGJAKXgFLiUM9
        3SwQtqDEyZlPwGxmAW2JZQtfM0PcoyCx+9NRVoi4iMTszjZmiLVJEvMWHWYEWSshsJRD4kPP
        OhaIBheJ7V2ToJ4Rlnh1fAuULSXx+d1eNgi7WKJz0yGo5gZGiW8HOpggEsYSs561M4Icyiyg
        KbF+lz6IKSGgLHHkFtR4XomGjb/ZIe7hk+g4/JcdooRXoqNNCKJEVeJg402WCYzKs5B8NgvJ
        Z7OQfDMLYdcCRpZVjGKpBcW56anFRgUm8LhOzs/dxAhOqVoeOxhnv/2gd4iRiYPxEKMEB7OS
        CG9TqEaSEG9KYmVValF+fFFpTmrxIUZTYFBPZJYSTc4HJvW8knhDE0sDEzMzQ3MjUwNzJXFe
        r5QNiUIC6YklqdmpqQWpRTB9TBycUg1MgW5Tbm8qnnSbP3raColq9dWZW058tU8PWvHjQZGV
        35KX+rk7jm3T/DVbwj/7/IuNL4/oFnhXPmr419li4JNdwbhFqcTG5+J9Uxul1XOvT2huCrn6
        bKWZpvYkua2zN3PXcKislI65mPPZ9sTUg1OZjk1e3nY6JOXGqq9LFwRZrdo4sy8gUWUCT1V4
        1aVw6z9pOprrat8pZAQ+j2cpvSM9a99P4326lhu7prqnR+/hyrI8ED+rIfvxHYWQZStWHzqd
        derHlg2z305cK7BHSfOA/QHh/o/cweH7zLMv6vce4ShMK7dxueXEKNSsGGV47fjKHfHRk5J7
        doVkaCr99fs5ffKamBt2f/iyr7ROLnxRq8RSnJFoqMVcVJwIAEnpIHwyBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXnfzda0kgxdHxS2OtT1ht3h5SNNi
        88MrbBZ3FkxjsmhevJ7N4vKuOWwWi5a1Mlt03b3BaLFqwQF2B06PTas62Tz2z13D7tG3ZRWj
        x5b9nxk9Pm+SC2CN4rJJSc3JLEst0rdL4Mp48jK0YKJ2xZaudYwNjHOVuxg5OSQETCRe3tzD
        1sXIxSEksINRYvfW82wQCWmJnZ1TmSBsYYn7LUdYIYqeM0o8vjgZqIiDg03AQuJsgz5IXESg
        j1Hi0PpNzCAOs8A3RokFiw+CdQsJHGOW+DYlEcTmFHCQuH3xAtgGYQFfiV17WphABrEIqErc
        b4wBCfMKWEoc6ulmgbAFJU7OfAJmMwtoS/Q+bGWEsZctfM0McZyCxO5PR1kh4iISszvbwOIi
        AkkS8xYdZpzAKDwLyahZSEbNQjJqFpL2BYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLz
        czcxguNLS2sH455VH/QOMTJxMB5ilOBgVhLhbQrVSBLiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        e6HrZLyQQHpiSWp2ampBahFMlomDU6qBib1L+Uu4vF8o86WvST27pQwv3LWr//bZev/845+3
        rsqveL663WF1m5dZxpYb708lNH4u23Rt7Y9zq7e/N2fbevG0nWHTqgYZ/jVh2+79n3/3oxDP
        ogNubYeDAtO1FTVKfPxKlrzbFPztbO9bQ0X9BQdTnzNm1nR+YNh/YlLdgpy/yxusIkq0OYPn
        7e+JdXLoP7lOoW3Fob2rsv+qHuozO5/Ccuv153/nY8rPX1GXMBVdd27iC/+z50NWCydp7Zkh
        tnP7UubU5W3mmz0fGRrfKY61dHqn9zHmTPz2KN8P9ac0r9x4PYfhWJmBo8mB45/2Lux/ZvPD
        +u9uT56mufV6Bjd+y35W7BS+cOqIyKGASYuVWIozEg21mIuKEwEzayeNHgMAAA==
X-CMS-MailID: 20220311050139epcas2p4fdab8b9b2eff9bf67d88809636237daf
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
        <017f01d834f1$bc3a9c30$34afd490$@samsung.com>
        <0ae388d8-0809-f09a-55a8-b682c9dc42c5@synopsys.com>
        <a1b9752f-96e6-7abb-d6d3-ce4742742a0c@synopsys.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Thinh Nguyen =5Bmailto:Thinh.Nguyen=40synopsys.com=5D
> Sent: Friday, March 11, 2022 12:55 PM
> To: =EC=A0=95=EC=9E=AC=ED=9B=88;=20'Felipe=20Balbi';=20'Greg=20Kroah-Hart=
man'=0D=0A>=20Cc:=20'open=20list:USB=20XHCI=20DRIVER';=20'open=20list';=20'=
Seungchull=20Suh';=20'Daehwan=0D=0A>=20Jung';=20cpgs=40samsung.com;=20cpgsp=
roxy5=40samsung.com=0D=0A>=20Subject:=20Re:=20=5BPATCH=5D=20usb:=20dwc3:=20=
Add=20dwc3=20lock=20for=20blocking=20interrupt=0D=0A>=20storming=0D=0A>=20=
=0D=0A>=20Thinh=20Nguyen=20wrote:=0D=0A>=20>=20=EC=A0=95=EC=9E=AC=ED=9B=88=
=20wrote:=0D=0A>=20>>>=20-----Original=20Message-----=0D=0A>=20>>>=20From:=
=20Thinh=20Nguyen=20=5Bmailto:Thinh.Nguyen=40synopsys.com=5D=0D=0A>=20>>>=
=20Sent:=20Friday,=20March=2011,=202022=2010:57=20AM=0D=0A>=20>>>=20To:=20=
=EC=A0=95=EC=9E=AC=ED=9B=88;=20Thinh=20Nguyen;=20'Felipe=20Balbi';=20'Greg=
=20Kroah-Hartman'=0D=0A>=20>>>=20Cc:=20'open=20list:USB=20XHCI=20DRIVER';=
=20'open=20list';=20'Seungchull=20Suh';=0D=0A>=20>>>=20'Daehwan=20Jung';=20=
cpgs=40samsung.com;=20cpgsproxy5=40samsung.com=0D=0A>=20>>>=20Subject:=20Re=
:=20=5BPATCH=5D=20usb:=20dwc3:=20Add=20dwc3=20lock=20for=20blocking=20inter=
rupt=0D=0A>=20>>>=20storming=0D=0A>=20>>>=0D=0A>=20>>>=20=EC=A0=95=EC=9E=AC=
=ED=9B=88=20wrote:=0D=0A>=20>>>>=20Hi.=0D=0A>=20>>>>=0D=0A>=20>>>>>=20-----=
Original=20Message-----=0D=0A>=20>>>>>=20From:=20Thinh=20Nguyen=20=5Bmailto=
:Thinh.Nguyen=40synopsys.com=5D=0D=0A>=20>>>>>=20Sent:=20Thursday,=20March=
=2010,=202022=2011:14=20AM=0D=0A>=20>>>>>=20To:=20JaeHun=20Jung;=20Felipe=
=20Balbi;=20Greg=20Kroah-Hartman=0D=0A>=20>>>>>=20Cc:=20open=20list:USB=20X=
HCI=20DRIVER;=20open=20list;=20Seungchull=20Suh;=20Daehwan=0D=0A>=20>>>>>=
=20Jung=0D=0A>=20>>>>>=20Subject:=20Re:=20=5BPATCH=5D=20usb:=20dwc3:=20Add=
=20dwc3=20lock=20for=20blocking=0D=0A>=20>>>>>=20interrupt=20storming=0D=0A=
>=20>>>>>=0D=0A>=20>>>>>=20Hi,=0D=0A>=20>>>>>=0D=0A>=20>>>>>=20JaeHun=20Jun=
g=20wrote:=0D=0A>=20>>>>>>=20Interrupt=20Storming=20occurred=20with=20a=20v=
ery=20low=20probability=20of=0D=0A>=20occurrence.=0D=0A>=20>>>>>>=20The=20o=
ccurrence=20of=20the=20problem=20is=20estimated=20to=20be=20caused=20by=20a=
=20race=0D=0A>=20>>>>>>=20condition=20between=20the=20top=20half=20and=20bo=
ttom=20half=20of=20the=20interrupt=0D=0A>=20>>>>>>=20service=0D=0A>=20>>>>>=
=20routine.=0D=0A>=20>>>>>>=20It=20was=20confirmed=20that=20variables=20hav=
e=20values=20that=20cannot=20be=20held=0D=0A>=20>>>>>>=20when=20ISR=20occur=
s=20through=20normal=20H=20/=20W=20irq.=0D=0A>=20>>>>>>=20=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A>=20>>>>>>=20=3D=3D=3D=20=3D=20(struct=
=20dwc3_event_buffer=20*)=20ev_buf=20=3D=200xFFFFFF88DE6A0380=20(=0D=0A>=20=
>>>>>>=20=09(void=20*)=20buf=20=3D=200xFFFFFFC01594E000,=0D=0A>=20>>>>>>=20=
=09(void=20*)=20cache=20=3D=200xFFFFFF88DDC14080,=0D=0A>=20>>>>>>=20=09(uns=
igned=20int)=20length=20=3D=204096,=0D=0A>=20>>>>>>=20=09(unsigned=20int)=
=20lpos=20=3D=200,=0D=0A>=20>>>>>>=20=09(unsigned=20int)=20count=20=3D=200,=
=20<<=0D=0A>=20>>>>>>=20=09(unsigned=20int)=20flags=20=3D=201,=20<<=0D=0A>=
=20>>>>>>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A>=20>>>>>>=
=20=3D=3D=3D=20=3D=20=22evt->count=3D0=22=20and=20=22evt->flags=3DDWC3_EVEN=
T_PENDING=22=20cannot=0D=0A>=20>>>>>>=20be=20set=20at=20the=20same=20time.=
=0D=0A>=20>>>>>>=0D=0A>=20>>>>>>=20We=20estimate=20that=20a=20race=20condit=
ion=20occurred=20between=0D=0A>=20>>>>>>=20dwc3_interrupt()=20and=20dwc3_pr=
ocess_event_buf()=20called=20by=0D=0A>=20>>>>>>=20dwc3_gadget_process_pendi=
ng_events().=0D=0A>=20>>>>>>=20So=20I=20try=20to=20block=20the=20race=20con=
dition=20through=20spin_lock.=0D=0A>=20>>>>>=0D=0A>=20>>>>>=20This=20looks=
=20like=20it=20needs=20a=20memory=20barrier.=20Would=20this=20work=20for=20=
you?=0D=0A>=20>>>>=20Maybe=20it=20could=20be.=20But=20=22evt->count=20=3D=
=200;=22=20is=20updated=20on=0D=0A>=20>>>=20dwc3_process_event_buf().=0D=0A=
>=20>>>>=20So,=20I=20think=20spin_lock=20is=20more=20clear=20routine=20for=
=20this=20issue.=0D=0A>=20>>>>=0D=0A>=20>>>=0D=0A>=20>>>=20Not=20really.=20=
If=20problem=20is=20due=20to=20the=20evt->flags=20not=20updated=20in=20time=
,=0D=0A>=20>>>=20then=20the=20solution=20should=20be=20using=20the=20memory=
=20barrier.=20The=20spin_lock=0D=0A>=20>>>=20would=20obfuscate=20the=20issu=
e.=20And=20we=20should=20avoid=20using=20spin_lock=20in=20the=0D=0A>=20top-=
half.=0D=0A>=20>>=0D=0A>=20>>=20This=20issue=20was=20occurred=20by=20watchd=
og.=20The=20interrupt=20occurred=20in=20units=20of=0D=0A>=204=20to=205us=20=
and=20cannot=20be=20released=20until=20the=20bottom=20is=20executed.=0D=0A>=
=20>>=20If=20it=20is=20a=20problem=20with=20the=20memory=20barrier,=20the=
=20value=20should=20be=20updated=0D=0A>=20after=20a=20few=20clocks=20and=20=
the=20TOP=20should=20run=20normally.=20Isn't=20it?=0D=0A>=20>=0D=0A>=20>=20=
Can=20you=20guarantee=20that=20a=20value=20is=20stored=20after=20X=20amount=
=20of=20time,=20every=0D=0A>=20time?=0D=0AYes,=20I=20think=20it's=20guarant=
eed.=20The=20system=20was=20working=20with=20other=20cores=20for=2020=20sec=
onds.=0D=0A=0D=0A>=20>=0D=0A>=20>>=20And=20Could=20you=20explain=20me=20why=
=20we=20should=20avoid=20using=20spin_lock=20in=20the=0D=0A>=20top-half.=0D=
=0A>=20>>=0D=0A>=20>=0D=0A>=20>=20The=20top-half=20and=20bottom-half=20are=
=20serialized.=20While=20the=20bottom-half=0D=0A>=20>=20handler=20is=20runn=
ing,=20the=20interrupt=20should=20be=20masked.=20If=20the=20top-half=0D=0A>=
=20>=20got=20called=20in=20the=20middle=20of=20the=20bottom-half=20handler,=
=20something=20else=20is=0D=0A>=20>=20wrong.=20There=20should=20not=20be=20=
a=20race=20that=20requires=20a=20spin_lock=20for=20this=0D=0A>=20>=20partic=
ular=20critical=20section.=0D=0A=0D=0A>=20>=0D=0A>=20>=20The=20problem=20yo=
u're=20seeing=20is=20pointing=20toward=20a=20memory=20barrier=20issue.=0D=
=0A>=20>=0D=0A>=20>=20Also=20you=20noted=20that=20there's=20an=20=22interru=
pt=20storm=22,=20which=20doesn't=0D=0A>=20>=20indicate=20to=20me=20that=20i=
t's=20due=20to=20PCIe=20legacy=20interrupt=20de-assertion=0D=0A>=20>=20dela=
y=20response=20either.=0D=0A>=20>=0D=0A>=20>=20Can=20you=20test=20it=20out=
=20and=20we=20can=20take=20a=20look=20further?=0D=0A>=20>=0D=0A>=20We=20wan=
t=20to=20avoid=20spin_lock=20because=20the=20top-half=20shouldn't=20stall=
=20for=20too=0D=0A>=20long,=20affecting=20performance.=20This=20can=20happe=
n=20if=20some=20async=20call=20from=20the=0D=0A>=20upperlayer=20driver's=20=
holding=20the=20lock.=0D=0AI=20also=20do=20not=20think=20that=20the=20seria=
lization=20of=20the=20top=20and=20bottom=20of=20the=20ISR=20has=20been=20br=
oken.=0D=0A=0D=0AI=20think=20that=20dwc3_interrupt()=20called=20by=20dwc3_g=
adget_process_pending_events()=20influenced=20the=20serialization=20with=20=
the=20bottom.=20At=20the=20time=20of=20the=20problem,=2020=20seconds=20ago,=
=20dwc3_runtime_resume()->dwc3_gadget_process_pending_events()=20was=20call=
ed,=20and=20the=20problem=20began=20at=20that=20time.=0D=0A=0D=0AI=20think=
=20so=20that=20it=20can=20make=20deadlock=20when=20using=20spin_lock=20in=
=20top,=20too.=0D=0AThank=20you=20for=20your=20feedback.=20I'll=20consider=
=20another=20way.=0D=0A=0D=0A>=20=0D=0A>=20Thinh=0D=0A=0D=0A
