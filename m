Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7288A4D575C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345359AbiCKBam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345337AbiCKBak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:30:40 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F291A06C1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:29:37 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220311012931epoutp0357fc07328a711a812304fa9453a543f6~bL152bpNY0686706867epoutp03W
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:29:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220311012931epoutp0357fc07328a711a812304fa9453a543f6~bL152bpNY0686706867epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646962171;
        bh=Kw8CYzegF0ygwwfGQ8xRLxGfbeQVpxgL4rkPFcEZcaE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=B26dbEdbvA/UMNU+iNMiDeFLvWYiG4ubEKn5DYi1kc2icDh0Go81qS/AU1un+G+E7
         wuqQ972+rUbnWbnkR09A5Fkuw+ln5Ki7PdkDymuR761nW8m33UIuEdsoOfPEQ6hy1/
         bzSv1qBlDWCZoGTZWOUNyF5/RDlTY2diNNXrf29s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220311012931epcas2p26faf7b924a62210539b2d62be0bd8090~bL15fXvQq1858018580epcas2p2k;
        Fri, 11 Mar 2022 01:29:31 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KF7dN5KtVz4x9Q9; Fri, 11 Mar
        2022 01:29:28 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.06.25540.8F5AA226; Fri, 11 Mar 2022 10:29:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220311012927epcas2p217d98e242e8de8bc0129b5d577fa09fd~bL12Nli3g1395613956epcas2p2H;
        Fri, 11 Mar 2022 01:29:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220311012927epsmtrp1fda8b27456d6218b2eb2e09a1baa53c8~bL12MzoW80177101771epsmtrp1C;
        Fri, 11 Mar 2022 01:29:27 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-f1-622aa5f818c5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.66.29871.7F5AA226; Fri, 11 Mar 2022 10:29:27 +0900 (KST)
Received: from KORDO034583 (unknown [10.229.18.132]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220311012927epsmtip1d33b3fc9c0db5e6803e3c3d1a6d9f668~bL12Ajs0k1159911599epsmtip1_;
        Fri, 11 Mar 2022 01:29:27 +0000 (GMT)
From:   =?UTF-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>
To:     "'Thinh Nguyen'" <Thinh.Nguyen@synopsys.com>,
        "'Felipe Balbi'" <balbi@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>,
        "'Seungchull Suh'" <sc.suh@samsung.com>,
        "'Daehwan Jung'" <dh10.jung@samsung.com>, <cpgs@samsung.com>,
        <cpgsproxy5@samsung.com>
In-Reply-To: <99eabe6c-8782-1bc6-e1d7-09b019cee65b@synopsys.com>
Subject: RE: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt
 storming
Date:   Fri, 11 Mar 2022 10:29:27 +0900
Message-ID: <016a01d834e7$72b11fd0$58135f70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: ko
Thread-Index: AQKjdV3S7gSSYh+T3/lJgRyIlCpbTQJQQbEmAWDN/4GrBVmwIA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmme6PpVpJBo9PcVsca3vCbvHykKbF
        5odX2CzuLJjGZNG8eD2bxeVdc9gsFi1rZbbounuD0WLVggPsDpwem1Z1snnsn7uG3aNvyypG
        jy37PzN6fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8v
        tcTK0MDAyBSoMCE74/26duaCOaIVr/a3sDcwLhDsYuTkkBAwkbi75DdjFyMXh5DADkaJzZO6
        2SCcT4wSS3fvhXK+MUrsWv6FpYuRA6zlyfQaiPheRokvs6+zQDgvGSWuLvzEClLEJmAhcbZB
        H2SFiEAPo8SnfjWQGmaQqTt297KCJDgFHCQWnbrADlIvLOAv8fhRHUiYRUBV4urPZ+wgNq+A
        pcSfJ39ZIWxBiZMzn7CA2MwC2hLLFr5mhnhBQWL3p6OsEHERidmdbcwQe50kXvQfYALZKyGw
        kEPi1tSDbBANLhI9Gz6xQ9jCEq+Ob4GypSRe9rdB2cUSnZsOMUI0NzBKfDvQwQSRMJaY9ayd
        EeRoZgFNifW79CGBoixx5BYLRAWvRMPG3+wQ9/BJdBz+yw5RwivR0SYEUaIqcbDxJssERuVZ
        SD6bheSzWUi+mYWwawEjyypGsdSC4tz01GKjAmN4XCfn525iBKdULfcdjDPeftA7xMjEwXiI
        UYKDWUmEtylUI0mINyWxsiq1KD++qDQntfgQoykwrCcyS4km5wOTel5JvKGJpYGJmZmhuZGp
        gbmSOK9XyoZEIYH0xJLU7NTUgtQimD4mDk6pBiYTIP9n/Ina1pwLt9UVGU8XhM146pJ3yNq3
        KWCZVJDNigcuU9bvP7StTOC8gogJg6Z078sZwgob484qtVyxvWJwZNGdt62dB58/9T1pqrHg
        XFZ2yzPlc6xmDO28B6VLrKeJt76rXfvhs2e/PFtCwqucmMNfVgfe23YicOL1zKlTS0M73LL4
        pq1zUX6hudHuRsbcrVt3yh9q+GsZnbqX7Xuj9TzR08WzvoR2uy3I/Lf6fb3xHNFAE84yDZ9X
        jx3ZLqZ//XPdttAyUeX7vzS97xvvzZO0vqwuaa2lYhZ4hKnH4fHts9dNJntcFYuZ25DPsX4v
        xxo+3TUiwRad33c9bbM6ff7Bjeavj0WEmFaUK7EUZyQaajEXFScCAOP7hDoyBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTvf7Uq0kgyn/ZSyOtT1ht3h5SNNi
        88MrbBZ3FkxjsmhevJ7N4vKuOWwWi5a1Mlt03b3BaLFqwQF2B06PTas62Tz2z13D7tG3ZRWj
        x5b9nxk9Pm+SC2CN4rJJSc3JLEst0rdL4MrY/nwtW0GHaMXn5ib2BsYWwS5GDg4JAROJJ9Nr
        uhi5OIQEdjNKPJzxnq2LkRMoLi2xs3MqE4QtLHG/5QgrRNFzRomfm16wgzSzCVhInG3QB4mL
        CPQxShxav4kZxGEW+MYoser0U6iOc4wS655fBxvLKeAgsejUBXYQW1jAV2LXnhawFSwCqhJX
        fz4Di/MKWEr8efKXFcIWlDg58wkLiM0soC3R+7CVEcZetvA1M8R5ChK7Px1lhYiLSMzubAOL
        iwg4SbzoP8A0gVF4FpJRs5CMmoVk1Cwk7QsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl
        5+duYgTHmJbmDsbtqz7oHWJk4mA8xCjBwawkwtsUqpEkxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5NBRIvW16m3cqqf6mcESmjsd436rP/6q2rtyxkX
        NbR847f5b3cMOei4akVGeMjVhV+tO57KzWc/6i45a3rZzWYXzu6kTbUBDn8eeJYu/r0ob3XB
        zNuLZynIPWH5fMHRkEtjyYyOn3EpWtGy1tfvrPjpyVf5fsdJrnM8HOlx6h1/mGapsbi6rQk5
        oLbpZeyFG+uST0d6mbgxBjvJT/2mW7Hx+ot3PgnJE95nqWl3PFB5GvpXtth+5/uCptbV0b/f
        vapV1JrjfERJP/JF8fce2RnJN9dP/hKvrX/6buexe5t+CTybPsWK84B76pfQT1uTJLOKmVX8
        uVe1sDE1aySu2KkeLB8tJPR29paUi5rVYUosxRmJhlrMRcWJAB2pS20gAwAA
X-CMS-MailID: 20220311012927epcas2p217d98e242e8de8bc0129b5d577fa09fd
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
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> -----Original Message-----
> From: Thinh Nguyen =5Bmailto:Thinh.Nguyen=40synopsys.com=5D
> Sent: Thursday, March 10, 2022 11:14 AM
> To: JaeHun Jung; Felipe Balbi; Greg Kroah-Hartman
> Cc: open list:USB XHCI DRIVER; open list; Seungchull Suh; Daehwan Jung
> Subject: Re: =5BPATCH=5D usb: dwc3: Add dwc3 lock for blocking interrupt
> storming
>=20
> Hi,
>=20
> JaeHun Jung wrote:
> > Interrupt Storming occurred with a very low probability of occurrence.
> > The occurrence of the problem is estimated to be caused by a race
> > condition between the top half and bottom half of the interrupt service
> routine.
> > It was confirmed that variables have values that cannot be held when
> > ISR occurs through normal H / W irq.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > (struct dwc3_event_buffer *) ev_buf =3D 0xFFFFFF88DE6A0380 (
> > 	(void *) buf =3D 0xFFFFFFC01594E000,
> > 	(void *) cache =3D 0xFFFFFF88DDC14080,
> > 	(unsigned int) length =3D 4096,
> > 	(unsigned int) lpos =3D 0,
> > 	(unsigned int) count =3D 0, <<
> > 	(unsigned int) flags =3D 1, <<
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =22evt->count=3D0=22 and =22evt->flags=3DDWC3_EVENT_PENDING=22 cannot b=
e set at
> > the same time.
> >
> > We estimate that a race condition occurred between dwc3_interrupt()
> > and dwc3_process_event_buf() called by
> > dwc3_gadget_process_pending_events().
> > So I try to block the race condition through spin_lock.
>=20
> This looks like it needs a memory barrier. Would this work for you?
Maybe it could be. But =22evt->count =3D 0;=22 is updated on dwc3_process_e=
vent_buf().
So, I think spin_lock is more clear routine for this issue.

>=20
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c index
> c02e239978e0..a96c344b9f17 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> =40=40 -5340,6 +5340,9 =40=40 static irqreturn_t dwc3_check_event_buf(str=
uct
> dwc3_event_buffer *evt)
>                 return IRQ_HANDLED;
>         =7D
>=20
> +       /* Make sure the event flags is updated */
> +       wmb();
> +
>         /*
>          * With PCIe legacy interrupt, test shows that top-half irq handl=
er
> can
>          * be called again after HW interrupt deassertion. Check if botto=
m-
> half
>=20
>=20
> Thanks,
> Thinh

