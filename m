Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ADD584564
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiG1Rxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG1Rxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:53:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2342F74CC9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:53:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SGxLaf028363;
        Thu, 28 Jul 2022 17:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+LcvXuD7TMtpUz0N6VAxCfBayWwnVDBtMzRyRhuXz74=;
 b=WJZX28y3of3srzN9hPRZuH75aWYVrT3LhMNUF598vxQAOktl8P5EvhpkVHLQN08pZwEB
 1iHdqqSyEwx1xF5//vMtM3r6MZQKciAhvg4R7GEUJ9HMiztl42QW2YNtqmhk5vHBbz1l
 wex20Bap5Omj0FUezl0HGHcolIbtqHGWbBuEt8PkJVckB3pGbJotYR1qUFQbDJxvmkOB
 amX53lr7MKYfocl1iTKTYKJob3N14ZEKbfMM1PiCFgmj2BKHf/D0qYkNd3HTTM8Sj5hh
 Lgtfv8nBF0RO7Ux8wWrIWsjg9aKwclU3l9CjDOZ05QbA03Pj/zZFKOpuLO9uc3BeYSaz Ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940vyu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 17:53:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SH5TCj034392;
        Thu, 28 Jul 2022 17:53:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh635wefu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 17:53:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+U/ZQCdEpy4H12bjyib+SjxwwkYk2WtkiJS1l/6vJDcD1/nuR8jnpRufKBoxtMl/qsJiG8NyZycocsihITo1ChrHrqnSoCF9KQrxDHDoaMnd6FAiNsgT/jgiQjHGhOGIHhjZBEB0okx6lB9IiRh+NQ1OPkkQv0AuGvN99o288b5LE4TafQ7ljPA4gf0vMNjWO08fIDtUw0Xz2DolqtfgI37KXXerK3B8jgRLPsvJ8igQjb6Eln5L4JzPKqbkW5pxJhcYfnlZt1MUIqlwCeRy3OMrlaGzvyYk8zLr0+HnBbzX+7dKfsQ5aKw6TTDcduWm09vch6tQ7MO4PurmAK7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LcvXuD7TMtpUz0N6VAxCfBayWwnVDBtMzRyRhuXz74=;
 b=URL7uXH/mrUF+tltTFqu3CuWdSwFpxs6UZ9n0pqvEAciEQhxEUDHT6XklH4EUbwYPFSq7E8rn01DQjEnRmmIbZtUd9bdJB0GqHaTd8P8tqQkO4tAGB1EvGX88JtZU4wYwV4TqXS8imqpWuh2Etj0G2JAa7+poXmRJbrX9R0L+7Dtwv5DvCH+WjD66NwuIKWphiRWTr7KcXIyX8drWy71A4zu311in527NESNuP2X5QptFu0447bBsf2H55Pgun4dDO2tiYOdaYWil5p8HbeZveoWVlzQ5j6i802T0cY0UzttC67VrA9Xs21Put7oWtJ4T8HM9zhs4hnIzwjsqjobtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LcvXuD7TMtpUz0N6VAxCfBayWwnVDBtMzRyRhuXz74=;
 b=U9QcYzno1zdhOHpgEnqZ97EnnSdfijbKm3ZWbJFVNDxk+lcqAL2C6WOT5ZeK1ilSluU5qH1xKI5zpPVxVJ8arHzp+q27JJt4A0awMkkkGFI/o/81KwmvE8yeqVQTsWwReYfu6liO9TqxCJPC52wwts6ZJdnjyfMz3Pdz95vyQI4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Thu, 28 Jul
 2022 17:53:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 17:53:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     syzbot <syzbot+99551d8b4d180f6cb1c0@syzkaller.appspotmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "ccross@google.com" <ccross@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in exit_mmap
Thread-Topic: [syzbot] KASAN: use-after-free Read in exit_mmap
Thread-Index: AQHYocLImc9EhReSUkCWW0OtqU3+7q2SgngAgAGPzwA=
Date:   Thu, 28 Jul 2022 17:53:17 +0000
Message-ID: <20220728175310.6kynllh2cvdw4ooo@revolver>
References: <00000000000026269d05e4c9fe23@google.com>
 <0000000000006de26305e4cd37ae@google.com>
In-Reply-To: <0000000000006de26305e4cd37ae@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0da84c58-9241-4ab1-48c8-08da70c20d90
x-ms-traffictypediagnostic: SA1PR10MB5867:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IaLwwB7JoMUPAe9EHcVVcD2wzAUaOwDlXXvhnrs8IuVWoAV3UoZs/+wNAqAIkZZbMbr5DVJmFyFZtFVhJvCs3DbSQ94xgKDfT1TNEfEd/3hZAV05haYxPZ5GAABavE7bphv3JOT0t2MWWn841KlNSb+aQg2iNI2Q35JeqRnu3QDYVB+5xlvxbFAz7/SbP8k7we3c0r+wbpdYD/YyHup611EUKaJRTQW1CNxaZMBbxOoH3kPcOW8hd1BWvQHk9Li4Z5j+niC+JSZ9ptMBIvKH27k+DElshgPXlMe93+Azz57nSwc6YKF3K8gtSrIMiNApkA/+BtN/oJ3xON2a0s0MkbSHBqyxp/MQyuhToj9sIVphAtvAKjSkzcKqBd/hr6CRCxNawwPPJ6maf+tCr5PRQBJlNjYb0EaXqS6ihAXcYNT5ptkYv7N+JutMRRz78TjqGroORpnjeoiulaHwZpqehoTJ8/C9LAlCMx9rltAO2w1Vz+lSo4xD/kLLQLnc2pp2yKmd/t6lNBFiQckIRpPPxVWNFTyOmLGYc5k/Kc4Kg2aCB7ZV3RnS2peyDqzNOcSXONDJxE3bfXJE6x0P/rXj7MWmz1OhF4ReLc5z4NfnGIzxeLTenQE/NcNqIr6Y0mIoDtAMeik0DUOGuJvIvgqakL8ESCMj+Yw0bjejj7D3SJQwBZNAM32sgztpbSg4BQX+V0y0CX++MansnzlE/Mt83jNcRnPUZBWzI2OFCmWlGxMQ/NZsDpHKn/MmB9iTF5B2IpfNB6V9rEEeZ64Mk4mRySnBEWLNjOIwGGl//obKmwBlAr6Nq0pkfO+QYikLNTgJCOQsTdilQZQmhOsgXF1+F1/iJ+79cn2hXgJ1Dk2ReVmZat3G52XWJHbXEKu7c+/k+o12kRyfmum8oYfFTOxcjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(396003)(136003)(376002)(39860400002)(26005)(9686003)(1076003)(966005)(41300700001)(6486002)(33716001)(2906002)(186003)(64756008)(316002)(478600001)(8676002)(86362001)(6512007)(71200400001)(44832011)(54906003)(91956017)(76116006)(4326008)(66556008)(66946007)(38070700005)(38100700002)(66446008)(66476007)(6506007)(5660300002)(7416002)(122000001)(8936002)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VcrmwIp+puAVusQdCvbkzmODixB/spjky0H7tbf/ZiKigJITH1k13y7FcS0F?=
 =?us-ascii?Q?YfKKRmZrg8QYlPBYXbO/u5i9rjjNIKiG1xiD0Z9fCIgW1GceCEIGpH08/laa?=
 =?us-ascii?Q?j1w1PlKKQuZ2/eJSygivsUy101eLj5lhlifyd/LZ5L1FA6H5Zor5Und7ykrv?=
 =?us-ascii?Q?aWicwb9+gkeQh0s2FLGSyJnBxE1RPiXcgqKdy/4WiXVgME81+aig+bPNk0fJ?=
 =?us-ascii?Q?KVtJCO+SpmyqaqZb+az1lQGqJ1VFsuvhAHmhZxyFKAPeRDoSL2i6qHN5UDcY?=
 =?us-ascii?Q?3/VHL7fsKTnQHQArNB0fhe8HKH0KPznPysnrd7yQCMTWzFEEmGb2Kb2VLhq7?=
 =?us-ascii?Q?hWMVUWvKWnfmB03VQv9rkskHpxO6Or5hF4R/eS2HOeDTV2Vlj1C4OpIcrfq6?=
 =?us-ascii?Q?5/ceZQ1PRGEw6JF9bHcy7Ny2GMKNnvUlvDeGeUZzol00grYobizYiT6ITmNX?=
 =?us-ascii?Q?jfGzfmZQnGY+qjnHpbb9LMuBAOuiEpdsfd+P4uc0MS9/NnvY7HyPyRnr68fx?=
 =?us-ascii?Q?ntjGv6FQQZ/84yqooyREUJDbE3702oxjKbYuMv3j4+Daz0OiUUA/ePLce3wn?=
 =?us-ascii?Q?nRo0QPJD8IoYbOfE9UAueSez5QwnGV6AqDlCFWUBrSd/foyrQN06EaM2Wf2o?=
 =?us-ascii?Q?FjbpGmx0E6IBckjYFk6C+Yy2Y2dpe7F5ob6WpyJM5FEkUygBFV0T53EtT/gW?=
 =?us-ascii?Q?xf4ots3blo4E9hMXi1RSaZczeNh6Sta4W3gef209gpdY3lkLg59yiMUSUYUV?=
 =?us-ascii?Q?ypyOheyjsHzTZHwwVDCaS1qhiwEq7429uaMHvKbofQu4NWeDH7Pf6e9d/kiP?=
 =?us-ascii?Q?HhnU6Z8IgyClF/0CjTWsPrABvD3+0HsrB9CIePgO4QqspdOhNlFs1vAwrhRm?=
 =?us-ascii?Q?d4aDRea7ZbcIOSgYzpSzrgX6Z7oFB+JnpJfUV6Iu8y2pgc7oso2GO4dy2IhI?=
 =?us-ascii?Q?lBwZL3JxKjYaUNe/88mfzdXWedGYejTX4QASRJcgeA00hio7bmQHOBFrVWs6?=
 =?us-ascii?Q?Rt5IK1Cp1ZaF6tX2/Dzo7pKWjqeuHWG3YnlNrs1fOw3Hdz6LEC2yYblWuj3S?=
 =?us-ascii?Q?apmSMTaIjFwkgTD0JevPOm5lKqIWtM8Do2ZknEvbs0RyNHTu6X8q085W4RcY?=
 =?us-ascii?Q?OEHvLg6gxvYjFSoPJGAOwe+IgvTIFgs9NCmrVgNmI3EhkCggTMDb4h7L8pcS?=
 =?us-ascii?Q?6MdZvqrxeB7ZrXq+ijGzuuLfsrBVa/RUE8d6oivqCWkzf5iAdWXx9VdmlB0B?=
 =?us-ascii?Q?fQt/fU3z8/cYpHyz59KYKoKTvb9t0CziTjOyVc57atqeFVn7kQFfS8+1Yl4h?=
 =?us-ascii?Q?BAFSHGpZon6T1gOaAxO0IJXq7wzGfueQTGvlpE6UdKOu4dGehq1CNdLzKOaA?=
 =?us-ascii?Q?TGNvtc5Cv1LIGpXr3Zo7JiiHKdgij5AgOPKYUT1PZts7hdOBOApX0j4iECFh?=
 =?us-ascii?Q?TSL70DArF/xq9qRb7SWwIR3fsrCfBXQo9Mw/JSOnPE7/+H6l0nW+Etut2qbU?=
 =?us-ascii?Q?VJ4UZSeLawEOjDHIPudOgVE0Qef8mrJqPdmByLYJ/uGD3gaW7G+Z8BtnmCne?=
 =?us-ascii?Q?0nEWBBp5MmKC5H7fBbzq87cnHWZm9Df1+Yj9G7Ca2KimYmlIw8XXGJwaRCOZ?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A3ADA7A8D1DFD4A9CFE52DEF2581B7C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da84c58-9241-4ab1-48c8-08da70c20d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 17:53:17.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0z9f9m+zMEaoQZ5tacTpOhOwuXYxxtMnrzi97iAtQrFn7/xYFndMaEJIEt0mZc77cdDTs+6zyj/9c8aBvrAzdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=882 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280083
X-Proofpoint-GUID: YcSkcieFR1J39Hr8OgiYcy2i2uqUj-oq
X-Proofpoint-ORIG-GUID: YcSkcieFR1J39Hr8OgiYcy2i2uqUj-oq
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* syzbot <syzbot+99551d8b4d180f6cb1c0@syzkaller.appspotmail.com> [220727 14=
:02]:
> syzbot has bisected this issue to:
>=20
> commit e23cb70bcbef5c189790042d1d6d89e33308c386
> Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Date:   Tue Jun 21 20:47:14 2022 +0000
>=20
>     mm: remove the vma linked list
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1078f20208=
0000
> start commit:   cb71b93c2dc3 Add linux-next specific files for 20220628
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1278f20208=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1478f20208000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbadbc1adb2d58=
2eb
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D99551d8b4d180f6=
cb1c0
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D117dc816080=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12695b2608000=
0
>=20
> Reported-by: syzbot+99551d8b4d180f6cb1c0@syzkaller.appspotmail.com
> Fixes: e23cb70bcbef ("mm: remove the vma linked list")
>=20
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

Thanks.  I tested this against the most recent patches with the above
kernel config and the issue has already been resolved.
