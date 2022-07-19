Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF01B57A27C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbiGSOzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238947AbiGSOyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:54:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C791F357F8;
        Tue, 19 Jul 2022 07:54:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JEpFYQ031777;
        Tue, 19 Jul 2022 14:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KVGzy8PfHNuEcn+fGHdWNX1NW2L3mkgZ2gOk6Eo6p9M=;
 b=2g9BsRCExkW/6CahJjtiR1T7fJtpX0ytrKErC3VZujpM1D6JG/a8khqtQzBHjPCJaBLs
 /C7E/FWow84zwG1M+WKsbGVabhMnMfg5IRpcgOvY6fRwYC7eyKPgRXnNV23m6ir6N4bU
 kDdzioZYxMT4HVv9IPNWoP8S0oPBMrFBcQO/bv6mzEB98ko6jVowkA5ZkiXywMA7Sn6Z
 PXtjjqEJA30OfdVb03C4MUrSBO3GSAPmPyHeS+K+yLhVmuJFETuvsKpwrjksMZ7/HvMX
 O5Fl8c1M77JsEKP9o1JqUKeS2Xw2gewZNn+PqlNAEzvstZB87rYbL6Tl5quu0RS9XpJP vA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtepm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 14:54:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JDomA3022149;
        Tue, 19 Jul 2022 14:54:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hryn1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 14:54:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT7egUOUOn/pdTqey3Tj0I8yUwfNrQqxq2AXAnIBiybX5hPpBLyNz7MiWuuXpM4Oz6LgjtVqJjp595zcthRX2xK5k9+0joS2lBym+2rZu1NrKJVwCRRQiQQlBvLL3RO3cWEmbyW+8U1pdDSNAAFfq5cKRx+5s51jGjiMiX0zVVtfbleWjJdQR7wTULwWHjLgagmA/+h/C6jxbXKXyMWjANyEu57NdGDkJp2Q+Kw2LWTCgOZP2mF4WN1T+AHmp4QeTJFe83z1VhbqFq+DwRAHOZDa/b5Mthg0AwyW5H2nfLPa5VIbsWoDzyGqIk4KWK0JA4IuPSc0U3Y0urkSt5tzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVGzy8PfHNuEcn+fGHdWNX1NW2L3mkgZ2gOk6Eo6p9M=;
 b=GjBxUNn5C2Tx73iEHlo4xn60GNH6bh2eVu3ruWieBdcIRB9Qg5Dcv5CKxAJd8EFwAAzXf8HZnaxvkGO44+WmhBDhlBzJo83UukOMW0P+ASF3Y8tdJtrqharPUwA0RFQYgzT0LK0PiECoseHqT0XiLbhxAF/2yj2tkXJmQTjhyhR/z7rSuPNjrYPgdZLwH5oSMLvJOACjp0+cYp/YTl5Y6+nHy4uJoxrAqPaWbfdGOs221LXfPvKD0d1GTe52MOP7Ix3fGRd2ulcyK0ibw6ogvJcQOdRa6H9fXVXGkmxlsam5DeevRBZXzxuNlW4BVx/tSBMK1KGiKxQmtUpEsb689g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVGzy8PfHNuEcn+fGHdWNX1NW2L3mkgZ2gOk6Eo6p9M=;
 b=W0fVxgTMvA7aWVg444Uk2IlBDGTiAbbzkUdtNj+gVuzaXjRFflEeAovD7dvzgKpeiCnlB/NGO5/tSm7/xYXoWYZnMjETdgVggPb6wL64suiq1SdaySZeXakRvnzdyjHfu0Cd3BIPYOcq2EAReXg+B678/DCSFrN1fEHImT64VdM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by DM6PR10MB2473.namprd10.prod.outlook.com (2603:10b6:5:b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 14:54:22 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 14:54:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "alexander.gordeev@linux.ibm.com" <alexander.gordeev@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v10 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Topic: [PATCH v10 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYhbALqTBpFGf5+k+LdWHoM0UZLa2F6jZlgAAJPoA=
Date:   Tue, 19 Jul 2022 14:54:21 +0000
Message-ID: <20220719145415.dvtpwfykfmddi4sx@revolver>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-14-Liam.Howlett@oracle.com>
 <yt9dy1wpi3pi.fsf@linux.ibm.com>
In-Reply-To: <yt9dy1wpi3pi.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d65f380e-d62c-417e-679c-08da699690a4
x-ms-traffictypediagnostic: DM6PR10MB2473:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tL9v0bSL9KuvP5qYGpezra9evAFqMs6zcor/g8fhcNOXbR+phVd3pCusdsE1HLs/oXYsaXh8rptO8vuADPrrFeqxKAXjojjRLVr9SePjSnF8KuMkygMwD0gCq0VPLoEQP8VPTY+2K38JtNDwgMygBnhWo0jayvoc5STi02y6k/K9n9nSP4EOac6wrXsWWSFiqbSbgdB4LZAE3G/mH25BnAj3maiZRInIv6b2RoT5gyod58eiHFPXr7D2tT47hrlrbprkhE1S6z1locD1hliZct//Ck9aFG+mUg30i/smpEefeNxBVdpRUbjq9Ahaq0JkDQExbBOTZGU0RF+wfQ6DgH3can5qlnhKyXelJCJlrcTaFN3jgbwMc1XusZEzrxD3El3Q0Ccbou71SOsV6tQ9z10mYnrlzidJWiRxiAjvopOu8ki9RlpHoctR4eLstP3yryR6JGYEJSHpaZmnZF/ARhi3Si6LOXZsZMA8PWZ8Qu8Y2STMwT4qk65SSMul82xOHWz2lhon2H0VGUGw7EUXWcSrvjT5eJBgSFFXA5/Zmh48K4B9X+MtGyPDIBEAIoVzC4F6SOWkSkzC82kGTBIWepyaT20d58aMXH815r3EoB/mSVQqD/d89Fge3m1PYyuiOkn5wz8sJD020vrsPCoNJsoDAC0Jh6XW6ZplYRCLhApysJq1xAgKrANeMv0AjK7hR/JB76TSvuFhqd3mJHOIYFM+m1zuChufNXaFX1rAFYd894lwmpZTadYI2Ju0mJWv7BH2ZCaBxiigDyin20YVKv9xRSGgE6ZRep9rc5WYkv+iHd1NwXSnsZFjbc1grNtqvvk59F2MdrUDvfwSXYqFsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(346002)(396003)(39860400002)(136003)(38070700005)(6916009)(186003)(71200400001)(38100700002)(6506007)(316002)(33716001)(41300700001)(54906003)(478600001)(1076003)(26005)(9686003)(966005)(6486002)(6512007)(86362001)(5660300002)(7416002)(44832011)(122000001)(66446008)(64756008)(76116006)(66476007)(66556008)(8676002)(91956017)(83380400001)(66946007)(4326008)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQteXfpTC4zsLKU0BsStJRjfmLNlfPDF0ISWpzUOSqTHRjlIVlKXwLYDp4IG?=
 =?us-ascii?Q?ItP+wsrsc46B0kmnj5sVQYncWP9GQqyNFyOoBKvMuAAFdP+pNR5N/1L8qhEF?=
 =?us-ascii?Q?LqRTqgrd1SHcAgxQCN7nF7aO/bbkPvrOi/frYWf0FlFRPYfk7SdWMgaKKbiU?=
 =?us-ascii?Q?9xAHYIGzB5oeAwGzjZxTSr8DvH/jsgF7bh3RXjYv31i7/iTRm/XBGTfB+Iyl?=
 =?us-ascii?Q?GawGtEwAG0QMVJCtqnhsk8Z+RwL6SRnoVkr6GGPefc/FLGY7cEif1wAy2nTt?=
 =?us-ascii?Q?IcL4etmArH0SnHW18Zh0R8OUMG5nEoFYIrbLSGl0lgllY7BCO9JISB3DlgL+?=
 =?us-ascii?Q?69+XtQ9v/Y1OoiXZC4hdMaAfbSI7i3Ih9AIhvbcY/LE143CY+ANs8QfLv8c2?=
 =?us-ascii?Q?hHsxxioFd6lt+8xkqnZu+le0dpxSvqapfLIUvEZ5wbBgvR+UvFfFT6vvCBZq?=
 =?us-ascii?Q?5BIilKdP36H7Xh5NsFug3sTSxHJYe08tUf9BGc8WHnBVjfQu3MzTuJI/HGPX?=
 =?us-ascii?Q?A75108YMf9d2Vit+H/LwLdFMnwWMe1G4nWCboWEWrePFlbYaZSbXxWlRaRU6?=
 =?us-ascii?Q?Fvh5kQW53GUHjGpXKhSgiGnME2gWnlk55+N280qpiYvZSwKqOARwtw0xyVM1?=
 =?us-ascii?Q?cBoLozEq2k1FlyJ5Z/VSDOMv7Mwr/BO4sRrujhKXqrxqhiYwhlbn2pUchMiK?=
 =?us-ascii?Q?cxQJX/CpF4iqnSrxAqnbx0JOeA0aN5DOdEmZfTszC2g72IKbBSvTN8wpdwxm?=
 =?us-ascii?Q?aOdRz/8ECvMKKNPH+fBqjOCVVXl1K9JZ+Novhtp3EjBI1DQYSQRl6kDDgSwy?=
 =?us-ascii?Q?4DMLC0AS2T0iK8dVfijuL2DN9Z5iH1rgnetb4cJi8krDe94NSDMl9ly5c1bV?=
 =?us-ascii?Q?XLgonRK2BJVUXWPBHW3WMz1Mt/NWHNdeR0Nu3IF+yoN28Y/fEg8aR43DWm82?=
 =?us-ascii?Q?MpAfMq8x5K1/X5w8NSu6UaBhCDcberhqywLue6/zzzE1sE75Vzm6B+Te9mf6?=
 =?us-ascii?Q?AOgpbffy4MUqyBQaZ4koDP/F9TcUNtupPRuOPrjdNOP8wbpx0Pph41PhR/1H?=
 =?us-ascii?Q?8ViMmuvJEF1jwqb7RtQdoiHF7gJu/F8hKUipHMihrnB7Jrs62wX4l9mEuHTj?=
 =?us-ascii?Q?WPzuLZhwTq5jGqjJmXgn9G7tRmWFUEgJfCVVkyiM+ZrXGx+d6U++jEozvE1t?=
 =?us-ascii?Q?7YxiSp8W92bgZOjZ++vfpR+k4NUMoupTNF4LHhd7xnITnchwIMzK7mzgjKq/?=
 =?us-ascii?Q?AqyZebcFL3K7hdmBwuJZlh6a/yyu7fRi9WsfvfZ0FdVjbgyf2yV++f50WdOi?=
 =?us-ascii?Q?/DCnf0haqXus5B5HPgYSeZj4Svf7uyilajOFBtwDjME4bDnom9IXAggIh3ru?=
 =?us-ascii?Q?s5SUXUZe1RoWqWvEYgh5EZNNwRdwQUOCrw/AWWLmaU3tQ8zJqQGMrqvHAUWu?=
 =?us-ascii?Q?iTIiOIhw0Y/gJVHEZB08fqPCtdy53IJtQFhdr9bPK3W3AYgdAc6BPq8cmwOv?=
 =?us-ascii?Q?mnYBXF3ocrJyYEBzf1QIvTEDfQXY0eQLhwjfgwO7Yj+8avszxQCJtYHKqVHa?=
 =?us-ascii?Q?4hcIkvzxIDsA9WoaNjRo9URRsMBu1xtKxlmQdqusbsOYWTvO6oziS3VrxgYk?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7170F88643253B4DB059FD6F1DC57D5E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65f380e-d62c-417e-679c-08da699690a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 14:54:21.8738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzVOVh4t1AJ1TeKAplGs6seZmbWrCYSMNcCaDHdze2CX6kupJw/f9UdkOoCQeroou/dLt4KRRGSJq/8jHQe1MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_03,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=929 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190062
X-Proofpoint-GUID: ECd7s82GWHndxdKGCFq5qj_AxJQ1qNNB
X-Proofpoint-ORIG-GUID: ECd7s82GWHndxdKGCFq5qj_AxJQ1qNNB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Schnelle <svens@linux.ibm.com> [220719 10:21]:
> Hi Liam,
>=20
> Liam Howlett <liam.howlett@oracle.com> writes:
>=20
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > The maple tree code was added to find the unmapped area in a previous
> > commit and was checked against what the rbtree returned, but the actual
> > result was never used.  Start using the maple tree implementation and
> > remove the rbtree code.
> >
> > Add kernel documentation comment for these functions.
> >
> > Link: https://lkml.kernel.org/r/20220504010716.661115-15-Liam.Howlett@o=
racle.com
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/mmap.c | 253 +++++++-----------------------------------------------
> >  1 file changed, 32 insertions(+), 221 deletions(-)
>=20
> With next-20220718 git bisect pointed me to this commit because the
> following code fails in compat mode (31 bit addressing) on s390:
>=20
> #include <unistd.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <stdio.h>
>=20
> #define __2GB__         0x80000000
> #define VMA_SIZE        0x10000000
> #define VMA_COUNT       (__2GB__ / VMA_SIZE)
>=20
> /*
>  * Repeated mapping below 2GB until all memory is exhausted
>  */
> int main(void)
> {
>         void *p;
>         unsigned int i;
>=20
>         for (i =3D 0; i < VMA_COUNT; i++) {
>             p =3D mmap(NULL, VMA_SIZE, PROT_READ,MAP_ANONYMOUS | MAP_PRIV=
ATE, -1, 0);
>             printf("%d: %08x - %08x\n", i, (int)p, (int)p + VMA_SIZE);
>             if (p =3D=3D MAP_FAILED)
>                   break;
>             if (p > (void *)__2GB__) {
>                   return 1;
>             }
>         }
>         if ((i =3D=3D 0) || (i >=3D VMA_COUNT))
>                return 2;
>         return 0;
> }
>=20
> With linux/master:
> # ./mmap_compat_anon
> 0: 67a00000 - 77a00000
> 1: 57a00000 - 67a00000
> 2: 47a00000 - 57a00000
> 3: 37a00000 - 47a00000
> 4: 27a00000 - 37a00000
> 5: 17a00000 - 27a00000
> 6: 07a00000 - 17a00000
> 7: ffffffff - 0fffffff
>=20
> With next-20220718 (and older, we're seeing this for a while, but i
> didn't notice due to vacation and other priorities):
>=20
> # ./mmap_compat_anon
> 0: 67600000 - 77600000
> 1: 57600000 - 67600000
> 2: 47600000 - 57600000
> 3: 37600000 - 47600000
> 4: 27600000 - 37600000
> 5: 17600000 - 27600000
> 6: 07600000 - 17600000
> 7: 40000000 - 50000000
>=20
> So the first output is correct - mmap succeeds until there's no space
> left, where it returns MAP_FAILED. In the lower (failing) one, mmap
> instead returns an address that is already in use.
>=20

I'll have a look.

Thanks,
Liam=
