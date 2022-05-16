Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2B528C72
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiEPSA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiEPSA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:00:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1314239BB6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:00:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GHXLuJ019520;
        Mon, 16 May 2022 18:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5LzktpAiqDEp/wnBPYYRdHoEZBdZPXfXMlobdU7mxFU=;
 b=DRjB0S7lrtZvXU8peQFtYb3zlUtYL4s3D1+GJgeNvjJEcPsOgaZTi7/U3A+gfhG4Vy4u
 dKiHCg7WVp2a44rUgWcw7y0oJEmuSU0dIttRxYrBFhKZMU/5J1HZx4j2IUGHbhz1sfHb
 vhrZA55BIjRjto2D/4Ror2ri4otzPUj7T+N+2j2e8sf8QiZjyXtfnx2ZMVvJyZA5ny34
 yI6YdIuY9ddYSPKIuoBICvbTWRL5oo3vJNtN1vCtnRlKOLyQnKVm+YsgDX2T+Ug/cW35
 Bmjlu5LfVtNvmoXayVMfjaSavw9OlUcCJyjOqvPAwKeb61Q5V/IvphTW9QQNOZ5UtevL kA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s4378-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 18:00:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GHZSQO024925;
        Mon, 16 May 2022 18:00:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v1xkv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 18:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJMF/+kH3QLq0w80WgHqLmUY8gRl2yTMIXvP/sxMg7IENsBGdgZzs9BLX3wUEi/FTTFF6WSMq7sBlsfHb96gYO3rf6qn3RmO3GDuJ22IocXHgqL5er8KaTwNrxfkCY9ptWnUaBSi6BW+g6QVK5cv8C1o4hvhVty3lt1e+b5HWnE2yEhyYweHBZbgirXRRWWvik3KRMkR0rkYXsyVhWkGOrHTifae9S4+MqRKIRM+FJM+Yt0+xTtL8uHh1L+6qiqCBKiQSBGh63GPE2p4ncIu1PpGrM19NvDEYMzEDCQ7MR9xL1Pq6790ksosJfhAlXIktW05CwSxw/BdsaXR1wPGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LzktpAiqDEp/wnBPYYRdHoEZBdZPXfXMlobdU7mxFU=;
 b=IjHJe3HGEg7yu9T0oFKsnhBiw6y9lZsT5YFme3bdznEV0RZbDrXJVCq5j+EzOSVqI7WhK8BSSTEp6pCT4h0nC1FPqDFNAi1bUVh45HH9Q2jvcJFNQz7VMFcyqA+QULop2gBtPujcrerqasM/Z8ag3r8/UkcZvvGzwvCvnWxNvnQnBLmIgDfsxLgHoGEusVE/04oMzn8k3/+oxfRvb2lZVeGuDX6xFLWbRBW7ScxWBkZCoKjJbWgHbYg94BcImgXDmtJBGEzMA3I++hwIUZb61YkgGdBPe9PVusATKdD3tEBZK9bF1u52KQSYsH6hvwW3tAy2cOMdTE5xNBwFimrZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LzktpAiqDEp/wnBPYYRdHoEZBdZPXfXMlobdU7mxFU=;
 b=icEEJRAZU8zQK7yxJjUuPuuFXT+M2yoaBPq2bJ960oe2nXLDQWRS2RIX3HGFFdWHb0yJVbZIDDSEIS2rwJQo83lVMzfAlYY6xzBYmWbO1PJehGxl1qt9cLGxe7jX+CpR6JbMxwVL4MKFoyE8gBm/itkK4H1qsn2pEfKYsKvgbDk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3791.namprd10.prod.outlook.com (2603:10b6:208:1bb::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 18:00:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:00:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     syzbot <syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [syzbot] general protection fault in vma_interval_tree_remove
Thread-Topic: [syzbot] general protection fault in vma_interval_tree_remove
Thread-Index: AQHYXh0PTeRSgseYNUW5AO29cTaGG60e404AgAAI3gCAAvUcAA==
Date:   Mon, 16 May 2022 18:00:06 +0000
Message-ID: <20220516175958.cswumupmeddptzdb@revolver>
References: <0000000000007f31db05de0638f0@google.com>
 <00000000000057d2f405defe7e00@google.com>
 <20220514135010.2528f75eb053a7b38d80584b@linux-foundation.org>
In-Reply-To: <20220514135010.2528f75eb053a7b38d80584b@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e11b1eb4-6742-4a85-c4ff-08da3765e8b9
x-ms-traffictypediagnostic: MN2PR10MB3791:EE_
x-microsoft-antispam-prvs: <MN2PR10MB379142CB1A2AD5F7DE64FCD0FDCF9@MN2PR10MB3791.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elUJLjw0OiYZqdhwtZ4nzjSo2mgP58sQ9Sucb5ViEu628d9HoKmKMMcKRGyIjZhZ0oWXwP/KdQCjrFMtN9K8/ErwWHs+VrvI4p1Zhgg7swjpvMJ4EoyhgO1t5QyEVDXUY4r2kd7mQbXBtrpq26wOumfnPhLMOd2GKqAdqG3qXDEMVqQLwAyUA+IfcdliYnQVCDlGUnY24DTVJII90Cdx+5xvyqsS2oWhpUUsdEgIm3Kz54vumSIQD2Pai0kxL/hALFDC1eFgFLLQeQi7/HExHK6d0Fjq4M1VLdZ4qMJsAFE8A1SPuUhInxhyUgNyCJa0+MBRmENFW89G0ZGZ/uWDQIXSC6Bi84J+M8ClfInR3PxnHO79S+SjfBzhaaaioeX+RXsyjpRvvIKi3BL+g2/cusQofgJsbMF0jrLKNsoCb7Qr1DJmaYDM9xg19lsiIXxWHOg7utAAlGvGe1YdFXZRf6AjeOoHY/H6ev3ZU2O2/qhpLBDl7+0wPBzSfeplpe2xON3Q/QtKYTnZ02xrKAB2c+Ipvf1Rf+e/nnuZppWcNBXVxytyCtzZUVvxWkLC/YAr7ydDNFiekASSJtd+SlWXRMHoQ3kM6CGluzZVqC7PxlQ+O+hknPGdkcMm/UpOuyBXjThmQLnX4MTGmhjS8paJEv9Up9AwGvfLfJPR+L1j5z6fOqZhZ54O2f0FN4ZJWUIOv7S5mn2Ag/B0Mh3EFAnmecoai2PmIem5LSjea5/kxjvG8jupZnTLBULu0klWgUX9g5e30i+Lx37T4VCixbj9h0ZHx7TBDA8KK6o2f9fhw+o0oMj6NrMoBxP8ze/PfPUOXtDr6I3pEwi2v0fRK7tTlekJwK8wpt2aPjkoEu9KKfI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(66556008)(76116006)(66946007)(66476007)(8676002)(66446008)(91956017)(33716001)(2906002)(1076003)(9686003)(6486002)(26005)(54906003)(6916009)(64756008)(6512007)(6506007)(316002)(186003)(8936002)(83380400001)(122000001)(3716004)(38070700005)(38100700002)(86362001)(5660300002)(966005)(45080400002)(44832011)(508600001)(71200400001)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MRyG4nlYtk5D8vP+MhksKSM8S1Euol23+VSUpfx0fNLw7G+wjSCUA6l7aL+5?=
 =?us-ascii?Q?bGLNYm4neMWabghj8B6d8NLcSxacZJrAD9L3DUcSqKagcprGCSLsFFvlNvTf?=
 =?us-ascii?Q?QhJMEnMnldFcdKfGdU15WK4zcUN9FZV5SlWJawo9UQf6CUo+o18AgF8Ww08H?=
 =?us-ascii?Q?6FYiClchzfig3XoRNLzdcYDifAZaneDqEZrO0zmey8SGilV6kdcSzh89pxmk?=
 =?us-ascii?Q?MMYP2QyG/mk17orZm1DU/i8eWm34pOD2BHNty2VUtArNLlqySJtAGx8LB+EU?=
 =?us-ascii?Q?2wMjiWxISxeZFYZTHHwykx+VcHTO/pm/rz2rhwXOvZEybOEO6D4H1+2mcSib?=
 =?us-ascii?Q?sG9lxVraEB52eN6e8uIgVwU9Qz9o9EhE3MdLhBZivR+LaPwbpKQ35NUCq89Q?=
 =?us-ascii?Q?QU1KGV2nw3c8ZpMQnPhi/BYehkqQCGQRSWiuZt+Qxsgl4wSHsCDoDnucU303?=
 =?us-ascii?Q?z+KpFqFUIHlBikA8ko6D4/KCagLQD5f7TDhy/k8+pjrkVaiJCYvgHU5tgY6f?=
 =?us-ascii?Q?hsBzJg3C8c6gN5Q4hlm5DCVQJ36DnmNn167VAddI0fR7t1dkYa9BIbNV+XDy?=
 =?us-ascii?Q?ZXA03ufJ2R019zEKAfc0j4OQdwq5i+h2yImv0yGePmHXvwJaO8gdt7Y+lW1I?=
 =?us-ascii?Q?BKdh5M31gjtz/jGddmnKJx1NZQiFawQr8uiAGuACErVDRKyHue553pIykHLH?=
 =?us-ascii?Q?Iv9q2p1quHIPaSEQCGnClAKah6cZxOPa3dQ+C+GQ0wEbZgT8PVOGgzghbFid?=
 =?us-ascii?Q?R7GTdhWJZZOb25j0gVQHdLNYWUWKHmm7dgVee38n/IC6l0kGbgRHTxw08Hu4?=
 =?us-ascii?Q?MkSzcfGrjGnDLy28aOyuu5PSzK3ZNgCCFRah+7mGbs0L8VaHkUOdCNKZr0Rv?=
 =?us-ascii?Q?WchUI0lqfKHfTYOLNPd2Zz2Yy4RoFT0SOxkmEcvhQ9ljRGTuUcBhibDrFK7T?=
 =?us-ascii?Q?jnYauCeKaCSdFShKBjnUom62ZwWSRONjYSGFvok6BkfOWCkYDFuF2J7l/XA6?=
 =?us-ascii?Q?5lHOtGXhVWDHcjD4Ds4j4IbMWIeMrNYrEzWvqfZb6nUzrR7md4abOOlaix4u?=
 =?us-ascii?Q?XgFLuaBwVajUbq+hArJeq02TLrbRPy+mwGxQwY1gcWHoqSJI4QJkwhExZu+8?=
 =?us-ascii?Q?6fpgDzHZ9FzW3pkTofirVh4QDK1LOPd18viG83pHXB8aw3g2ULfRzA0QRI4o?=
 =?us-ascii?Q?knGDR+0jVkRQg5AW1C9jkCLtM8kFynrPdxio9s4gTp4v9/k7pgATbjs9JClh?=
 =?us-ascii?Q?GaBvXpae7jB766oyudIGxb3uTXaEE/wjmGzZHbZVKKkN5yDf4Cf1wrtwsJQ7?=
 =?us-ascii?Q?q3L3Lag23BLjAjbdpGCpctbbzJWffBgXOlE+sjaVsBBZnrf9BUcRzED0CmUA?=
 =?us-ascii?Q?Xx1ICmivtq4NgVOSPdT02kTj4EVxGTv0iGib2Ufl7REaeTtsEghhf6aLAOpf?=
 =?us-ascii?Q?3bPBzra9+nvNIm5dzQz+ebNTAKYd5N4AxTV9nsDyPMnVnLzY9/DgS8IXVnsV?=
 =?us-ascii?Q?YC7qoDYcQg3qZVuhY1WU0SlxMWUtctXwjGqk2gNbNbDc2f5O1j7hCZLHv5GE?=
 =?us-ascii?Q?XmsM3rCFUsS3VcJe54qEwaSOD9crdL/mICudde+6tYiPbmVCJiBhJrTFgvtw?=
 =?us-ascii?Q?wKHzHW7ZHg1qnyQsLEzw40LWW0fhvxvTXWCvBocKZiSWm3RNPM5en5tVz3uR?=
 =?us-ascii?Q?eeKL9ppdGo5cTsJzFRmLKXAu0/JsegDrsBpLJOgq7i9ZcpomKDxTFg2mD9ml?=
 =?us-ascii?Q?TlL9XG4QOzeeZZeX8V1iDOnUb4HX4yQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F96B2C4F23D6F047937F9B47691DDBB3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11b1eb4-6742-4a85-c4ff-08da3765e8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 18:00:06.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VsnrtdCXtCgFDLy8k8zChpo3qWABKZQvl7LJHCGUtMdz8GEiqNaMXhMVbH2r4hlsMsz6i+bJQ4NMyNy4E8u3vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3791
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_15:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=948 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160096
X-Proofpoint-GUID: mu9M31V5rhVd0Hi7BoAekk_fWfNxaG2R
X-Proofpoint-ORIG-GUID: mu9M31V5rhVd0Hi7BoAekk_fWfNxaG2R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220514 16:50]:
> On Sat, 14 May 2022 13:18:26 -0700 syzbot <syzbot+ee1fdd8dcc770a3a169a@sy=
zkaller.appspotmail.com> wrote:
>=20
> > syzbot has found a reproducer for the following issue on:
> >=20
> > HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D11da21b9f00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De4eb3c0c4b2=
89571
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dee1fdd8dcc770=
a3a169a
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D142757f1f=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17cf0966f00=
000
>=20
> Thanks.
>=20
> So it was there on April 28 and it's there now.  Liam, do you think
> anything in the mapletree changes could have perturbed the interval
> tree handling?

It is certainly possible, these two trees are intertwined so much.  One
area that sticks out as a possibility is vma_expand().  I created a
vma_expand() function to handle growing a vma and potentially removing
the next vma.  I do some interval tree modifications in there.

I'll add it to my list of items to look at.

>=20
>=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+ee1fdd8dcc770a3a169a@syzkaller.appspotmail.com
> >=20
> > general protection fault, probably for non-canonical address 0xdffffc00=
00000000: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 1 PID: 3612 Comm: syz-executor255 Not tainted 5.18.0-rc6-next-2022=
0513-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/01/2011
> > RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline]
> > RIP: 0010:__rb_erase_color+0x159/0xdb0 lib/rbtree.c:413
> > Code: 89 ed 48 89 c5 e9 f5 fe ff ff 4c 8d 45 10 4c 89 c0 48 c1 e8 03 80=
 3c 18 00 0f 85 3a 08 00 00 4c 8b 65 10 4c 89 e0 48 c1 e8 03 <80> 3c 18 00 =
0f 85 6a 08 00 00 49 8b 04 24 49 8d 7c 24 08 48 89 f9
> > RSP: 0018:ffffc90002e877a8 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > RDX: ffffed100e8d3aed RSI: ffff88807469d768 RDI: ffff8880202132b0
> > RBP: ffff8880202132b0 R08: ffff8880202132c0 R09: ffff88807469d75f
> > R10: ffffffff81b02518 R11: 0000000000000001 R12: 0000000000000000
> > R13: 0000000000000000 R14: ffff88807469d768 R15: ffffffff81b01300
> > FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ffe92002ff8 CR3: 00000000764a0000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  rb_erase_augmented include/linux/rbtree_augmented.h:305 [inline]
> >  rb_erase_augmented_cached include/linux/rbtree_augmented.h:314 [inline=
]
> >  vma_interval_tree_remove+0x694/0xed0 mm/interval_tree.c:23
> >  __remove_shared_vm_struct mm/mmap.c:160 [inline]
> >  unlink_file_vma+0xbd/0x110 mm/mmap.c:175
> >  free_pgtables+0x255/0x420 mm/memory.c:440
> >  exit_mmap+0x1ff/0x740 mm/mmap.c:3219
> >  __mmput+0x128/0x4c0 kernel/fork.c:1180
> >  mmput+0x5c/0x70 kernel/fork.c:1201
> >  exit_mm kernel/exit.c:510 [inline]
> >  do_exit+0xa18/0x2a00 kernel/exit.c:782
> >  do_group_exit+0xd2/0x2f0 kernel/exit.c:925
> >  get_signal+0x2542/0x2600 kernel/signal.c:2857
> >  arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:869
> >  exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
> >  exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
> >  irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:307
> >  exc_page_fault+0xc6/0x180 arch/x86/mm/fault.c:1543
> >  asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:570
> > RIP: 0033:0x7f1771dc98cf
> > Code: Unable to access opcode bytes at RIP 0x7f1771dc98a5.
> > RSP: 002b:00007ffe920035a0 EFLAGS: 00010206
> > RAX: 0000000000000001 RBX: 00007f1771e78138 RCX: 0000000000000001
> > RDX: 0000000000000001 RSI: 00007f1771e78138 RDI: 000000000000000b
> > RBP: 000000000000000b R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000008011 R11: 0000000000000206 R12: 0000000000000000
> > R13: 0000000000000001 R14: 00000000000c3ec0 R15: 0000000000000001
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline]
> > RIP: 0010:__rb_erase_color+0x159/0xdb0 lib/rbtree.c:413
> > Code: 89 ed 48 89 c5 e9 f5 fe ff ff 4c 8d 45 10 4c 89 c0 48 c1 e8 03 80=
 3c 18 00 0f 85 3a 08 00 00 4c 8b 65 10 4c 89 e0 48 c1 e8 03 <80> 3c 18 00 =
0f 85 6a 08 00 00 49 8b 04 24 49 8d 7c 24 08 48 89 f9
> > RSP: 0018:ffffc90002e877a8 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > RDX: ffffed100e8d3aed RSI: ffff88807469d768 RDI: ffff8880202132b0
> > RBP: ffff8880202132b0 R08: ffff8880202132c0 R09: ffff88807469d75f
> > R10: ffffffff81b02518 R11: 0000000000000001 R12: 0000000000000000
> > R13: 0000000000000000 R14: ffff88807469d768 R15: ffffffff81b01300
> > FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000000c3ec8 CR3: 0000000023516000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0:	89 ed                	mov    %ebp,%ebp
> >    2:	48 89 c5             	mov    %rax,%rbp
> >    5:	e9 f5 fe ff ff       	jmpq   0xfffffeff
> >    a:	4c 8d 45 10          	lea    0x10(%rbp),%r8
> >    e:	4c 89 c0             	mov    %r8,%rax
> >   11:	48 c1 e8 03          	shr    $0x3,%rax
> >   15:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
> >   19:	0f 85 3a 08 00 00    	jne    0x859
> >   1f:	4c 8b 65 10          	mov    0x10(%rbp),%r12
> >   23:	4c 89 e0             	mov    %r12,%rax
> >   26:	48 c1 e8 03          	shr    $0x3,%rax
> > * 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping inst=
ruction
> >   2e:	0f 85 6a 08 00 00    	jne    0x89e
> >   34:	49 8b 04 24          	mov    (%r12),%rax
> >   38:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
> >   3d:	48 89 f9             	mov    %rdi,%rcx
> > =
