Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3532A58DFED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbiHITMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347505AbiHITLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:11:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D92C0A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 12:02:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279GdUQ3022303;
        Tue, 9 Aug 2022 19:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dc2HHLe782lZw69ARZBkg0qTJ1uOyrzaLOqggk0/To4=;
 b=bymspl0RQ371Pxr8zj6bWPlgB9rj+b4Xs49l7Y7PtuI4Uk5ksoASY6KIW45gLX+5JxZI
 hmCX1Y/7dOquqIhJ70VUBypyacYY66EvoZBmBIMC0TILD/x7qTBJD3R9iY1ZCOSkWXAS
 ze7NM9yUQQRDQG4eRJOUG2NF88aNTrGUQNVKwmSRhCu5pxiAdRMJAiZWucNhrysuq0tI
 EKdhuOwO9Eme2Yl4pZ3GO2KcyLFBe0IX3KToF7bTbqrfp1hvn9dO00pZxptgOOq6/juZ
 XyO6TJFEz1Ysha9nra5xVV2kUuJeF68q/Tg2AzljBCo5PhS1Jq0EaR5KoloCKSjr1mxa CA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsfwsqdjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 19:02:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 279HG56J032794;
        Tue, 9 Aug 2022 19:02:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hser34kr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 19:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHNbJHxiMuH/OHK+wscZYk+M4CLbFsbb4cKVWYbQJ2EhUbFdfnEkYsdYVD6pSeYOdJc0a60sowlzs/Bjx+4qAdT9822T2W+RP9BcgmQLIswkZT6VkVjcBMYmb4HvyyK5KVgJfJ7z4TzVyJpUksSTH422GZltXcrKon9tn+/PMk5Yb3+QrnqP7ArZvIGhI4J2AXptTmS3zgQYO43vb8CgchZiiCKLuQj9nC4vtxnlfrRhsyiptpSCsxp/iLQzw3srfnJV+WR7L+ky84Hd9sHz89BGLVYjLYi2lB9l2q8FqFnSFw3quZS7Qvb6b7S77cK4nt2K+ykqEWuWrpajsnnCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc2HHLe782lZw69ARZBkg0qTJ1uOyrzaLOqggk0/To4=;
 b=ZDWcaB+HfSnnR1fsdBFPn+dAdXd91kVCqlooGZ03YvTgKPUiQqTDZb8+eZZAOD9zOwgeJDseUwGdjyvPLKt4tswOoD6Z33aNKESijymn8xYWKC9ouUc6WZrp1Hi4G6X67SI79Gwi0YVHh+wd5DWgsCj+EoTZpkeMF4krAu2/kz79X1S6s/mFcUZw+1GMnrBOJ/S7dNz+CuNQ0jGrIm4AuUB3dLR7Ffdu4B/bpnz62ozlfFFCp/Q89OGma+eV9uYVRY3F9sHfeKSiyiRBABblxvVyrGa27ilVzcDoSEkxxsQEIhTBBsD+jFzqkjS6rDIlaEhlGM4aldzAwmBsTlyhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc2HHLe782lZw69ARZBkg0qTJ1uOyrzaLOqggk0/To4=;
 b=Gdj27CVDXqfmABo1KTVhbaXNxwHVuGrmbqcRJ62C0gjPmscd7HSc52qEaYYgWdJXrdYmjFqYky+bBufyYppbFVxTVLeicn3NLsrl19HIaxSg835HQWlDGCDIfRVPv6ySlA2GlW8ajw4zcjJERq2wBg41aXY3UaX3LMGzCvBlvls=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3592.namprd10.prod.outlook.com (2603:10b6:a03:11f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 19:02:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 19:02:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Carlos Llamas <cmllamas@google.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] binder_alloc: Add missing mmap_lock calls when using the
 VMA
Thread-Topic: [PATCH] binder_alloc: Add missing mmap_lock calls when using the
 VMA
Thread-Index: AQHYrAn9C2tDT6s3j06giZb3JwoEAa2m6VSAgAADp4A=
Date:   Tue, 9 Aug 2022 19:02:17 +0000
Message-ID: <20220809190211.ew4taam2lcomramw@revolver>
References: <20220809160618.1052539-1-Liam.Howlett@oracle.com>
 <YvKsI5pMbgQ5Irup@google.com>
In-Reply-To: <YvKsI5pMbgQ5Irup@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f91d46b2-d7ef-44f0-d777-08da7a39ae0a
x-ms-traffictypediagnostic: BYAPR10MB3592:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZaBJDHUd7Kt9/I9/piKUQZUWYk5peLEODYhIYIUnIWGaKSQQR4On3wNXSZmYpd3eokGzHAazLameVxHRyvBg3qI8JOimcYiW6YaStxz2qtZ8egeOlMCcCGVsjIeG7A/DLN/we6Nhyucmnr1wSvweUaRRl3LTsju0Jj5+Rxk2xodPBdA7rsSqbOjPOGXFMps0L0uhqEvIT9AWjcNn30yw319mDQlBsl89XXtZAyvw3KLeC419w+aTl2Ov0fKpAKplcUWiedH+idgLO8y0b+nQiXPpkt0MsoSfoZWGyZR9SHVDJ4HDlDuST3bNUQY8MnoWO39tyX9SzhbhyToPBQfwreM+0LkIrQmRgCybxkPt+j4cT0yiSRYhcTMaThDi/NdY7FhHyBidNFnXvU3i7wkJuqWn86KFnFDNF3muSsB8wW2LWYW1leOVmlw9kQ7ACptTDacPsQg7LKBqlGJpfEwJrWM5apobKwXYHWKyhoXyvihp+eMOfM4/ZX2SBGPhNhvrHbdNz3mS543YN0p7LfhQBhY50MQzpKHEAv2kGfmub2voqVQ5zjulh6zvKXFD6RvIOeoem335hiKhLxl+NkYbAYhr4aek/6pxuyl8TQ9U1581CvbwlIYr0laxFZspkjOzacHHlqN8clmYfEvdgDLe9Qa4+Pv+IQKEi5ZXW1GkzvzAZLgIc6xjHLLTbTJhGDq5pe6rFxk9jIQ++2S1eiTVPIQMmcFxP0CFsOhVC7y8WLcYyVYeGxx8j2HgxnLp9RrW1MGhMU0F11s3qy88APWnJ4Q5p4470Rja8OBRSiLbvM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(39860400002)(346002)(136003)(376002)(6916009)(54906003)(478600001)(316002)(2906002)(6486002)(71200400001)(41300700001)(64756008)(33716001)(66476007)(8676002)(4326008)(91956017)(66946007)(66556008)(66446008)(44832011)(76116006)(5660300002)(8936002)(7416002)(38100700002)(38070700005)(86362001)(83380400001)(186003)(6506007)(26005)(122000001)(1076003)(9686003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DAgAtdhUujppgHL8J4uXN0PiQkdMQAEtEFWU2YsxAB8PcduKnt/g5YJE+I?=
 =?iso-8859-1?Q?fTJs6GjSrza9zM/Aj0FIKz/uivjhmbqGvbmcp/l5lFnPZZyoT1/uM2EW8z?=
 =?iso-8859-1?Q?lezj0qRvsA6YG9AeonNN1JGdz51IwUsJkjkYay/e7R3LSb6lo4SiRyyWvs?=
 =?iso-8859-1?Q?/nBO6Fkw1kB4NxwZzTEWQseb+c0VlWBtdQrhwTbGd+I+X9oWkedbrXdCIq?=
 =?iso-8859-1?Q?sJolvFT5uvtsoplz9giVBgVWVfHn8MLJhp6GUjUAvo5vhjUtib6CtFLvpA?=
 =?iso-8859-1?Q?K8wFH2tQBPpobdqQIZ7uqBWBRB8Z1Pse/9kWZqi5UIN3yO1E5nib+N+0du?=
 =?iso-8859-1?Q?mUPYp3ri3EIP2gGR7TOJ6gkMyfat35BZ/B6jUo8C5kU1ACST5nI2w+5T5M?=
 =?iso-8859-1?Q?Va/nAW6e5Y7+nojmmNrjKRokuEML3lhrTi6KyuSeghPrz/MxNjDpcS5U/w?=
 =?iso-8859-1?Q?sgfT4PxiN2sGPvpFHiQ/z4Jer/fCKEKGXBK8fzBnoF/JxvNterUsynCrXO?=
 =?iso-8859-1?Q?cwZ2wPKb1Ap3cmpOaEOfHweRRVBLJZubX87jm8U1O+h6GHb7R0gvV/m+F1?=
 =?iso-8859-1?Q?sjB8D7kQkB6Eut9ZfewX70bTFyAI6QZLzg+LnAbvkpgDlunO5mNU2Bai3v?=
 =?iso-8859-1?Q?Qs5aZTCIPPoEr1bnWgviC4Pavz91hyW36eJWCmVQYLjJ3YqN9z0T7Yfias?=
 =?iso-8859-1?Q?8EuM4c07eGoAC7PjtL4c7OrZUMJmm2nRfLNDyPZk/rpMrURihQQ08q9jAf?=
 =?iso-8859-1?Q?VK+hVd/fs4SuXfQa6yRt7Bc8HScu8E1RZDR0Lst+CgypbNVGPmUfyn1mH6?=
 =?iso-8859-1?Q?PPf3J0SpPyy8pLciouE6JNgaQD74z5QD/VHDBeIJWO9mWw3RFA7DdCD0eZ?=
 =?iso-8859-1?Q?aWJ0uL+d6k4YB7URt67884JMzVKUGxZB5lU3M6k29egI38bRmofczJmTzl?=
 =?iso-8859-1?Q?oFBApQv0IwMbtZZ4rC4BF7b6aCFrvG7i8kQqp3wZWnKXp2jPapRURsQjPi?=
 =?iso-8859-1?Q?clAA2RvbC7XsV6JD/lkKMjtQnH2/HitBumaUbW1cWHiDFW3MIPNnPIIyP1?=
 =?iso-8859-1?Q?+hVmbpIBWuw+kVd2/woIOWu6wiNQ8Ifi3lLlnw7h1nKnOhD68/ulpoppsk?=
 =?iso-8859-1?Q?it2XtCj+aCYbbO3dBDSf8ank+m3I7r05JtEVlMOnbVwMq5rkTUP6DUcZ0r?=
 =?iso-8859-1?Q?jpnJekU8AtyvmxKQMUrQ5eH/7gfvU/KePJGAZiCqIbh4aCn6c8tcAHIYP5?=
 =?iso-8859-1?Q?HaAMdm0oEzjc/hqX+cVoDFDxocYHUD3HxQ1ibiG/DWl9aAdukO+wDRXaIO?=
 =?iso-8859-1?Q?cUhnEh/YJJNfcCpTU8pg4tpsT0IdLpz23/IOgn9YE7iiSgxJQePx3PMzCc?=
 =?iso-8859-1?Q?/hO3ZEGKeNQv2FoegJyqrbdVKyWAWnfBy1lD4glA46+m2wC+kSWX0dfKvK?=
 =?iso-8859-1?Q?9VcAf6P2DNOsTb7G7g/Q0Ad+o5v4AbphoLoNzJCEHhX/QrqAmQr+Yt/YoC?=
 =?iso-8859-1?Q?Zo7pqz5Q5BM1/w2e6LkuK4eEIBsWymWnA/Kx1bYVbclysnw6zwPNtcU8xc?=
 =?iso-8859-1?Q?Kqdmhe/I7+FrkMLBKQaq2j/ik4/XRorLEB2Xa05hUs9LU/58aTONdyeYqK?=
 =?iso-8859-1?Q?ABJfA8fHbMz1VMIzOxusvIuTDYj7xXBlDkcIYuF7R1x3XasQbLhvVTng?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <896EC046421E064A8683C916DBB983B1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91d46b2-d7ef-44f0-d777-08da7a39ae0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 19:02:17.7704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9NYXEzELkcWVsaJISjrzTanC+tk1DZK0Ej8DgeWIEdMmBQkqZi2P6adbXD4l2llHBK7JiSi5CuyyoXgK3L0NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090072
X-Proofpoint-ORIG-GUID: MtRhjBJxkH4GGPrxnMuIOFO2ZXOAbkxP
X-Proofpoint-GUID: MtRhjBJxkH4GGPrxnMuIOFO2ZXOAbkxP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Carlos Llamas <cmllamas@google.com> [220809 14:49]:
> On Tue, Aug 09, 2022 at 04:06:31PM +0000, Liam Howlett wrote:
> > Take the mmap_read_lock() when using the VMA in
> > binder_alloc_print_pages() and when checking for a VMA in
> > binder_alloc_new_buf_locked().
> >=20
> > It is worth noting binder_alloc_new_buf_locked() drops the VMA read loc=
k
> > after it verifies a VMA exists, but may be taken again deeper in the
> > call stack, if necessary.
> >=20
> > Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com
> > Fixes: a43cfc87caaf (android: binder: stop saving a pointer to the VMA)
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  drivers/android/binder_alloc.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_al=
loc.c
> > index f555eebceef6..c23cad7fe313 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -395,12 +395,15 @@ static struct binder_buffer *binder_alloc_new_buf=
_locked(
> >  	size_t size, data_offsets_size;
> >  	int ret;
> > =20
> > +	mmap_read_lock(alloc->vma_vm_mm);
> >  	if (!binder_alloc_get_vma(alloc)) {
> > +		mmap_read_unlock(alloc->vma_vm_mm);
> >  		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
> >  				   "%d: binder_alloc_buf, no vma\n",
> >  				   alloc->pid);
> >  		return ERR_PTR(-ESRCH);
> >  	}
> > +	mmap_read_unlock(alloc->vma_vm_mm);
> > =20
> >  	data_offsets_size =3D ALIGN(data_size, sizeof(void *)) +
> >  		ALIGN(offsets_size, sizeof(void *));
> > @@ -922,17 +925,23 @@ void binder_alloc_print_pages(struct seq_file *m,
> >  	 * Make sure the binder_alloc is fully initialized, otherwise we migh=
t
> >  	 * read inconsistent state.
> >  	 */
> > -	if (binder_alloc_get_vma(alloc) !=3D NULL) {
> > -		for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
> > -			page =3D &alloc->pages[i];
> > -			if (!page->page_ptr)
> > -				free++;
> > -			else if (list_empty(&page->lru))
> > -				active++;
> > -			else
> > -				lru++;
> > -		}
> > +
> > +	mmap_read_lock(alloc->vma_vm_mm);
> > +	if (binder_alloc_get_vma(alloc) =3D=3D NULL)
> > +		goto uninitialized;
> > +
> > +	for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
>=20
> do we need to hold on to the lock while we loop through the pages here?

I think we do?  Holding this lock will ensure the pages don't go away, I
believe (looking at mm/rmap.c comments on locking at the top)?

In any case, this function is called from print_binder_proc_stats()
which looks to be a debugfs/debugging call so I thought safer would be
better than faster and with a potential race.

>=20
> > +		page =3D &alloc->pages[i];
> > +		if (!page->page_ptr)
> > +			free++;
> > +		else if (list_empty(&page->lru))
> > +			active++;
> > +		else
> > +			lru++;
> >  	}
> > +
> > +uninitialized:
> > +	mmap_read_unlock(alloc->vma_vm_mm);
> >  	mutex_unlock(&alloc->mutex);
> >  	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
> >  	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
> > --=20
> > 2.35.1=
