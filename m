Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252A45788BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiGRRr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiGRRr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:47:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6DE2C651
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:47:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IHYOjR013947;
        Mon, 18 Jul 2022 17:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2WVlBWZSaoqfu9swBqSez5EKIe2Iks2kpMzxLKF55i0=;
 b=EDqu4efmDAB1u/p73PFMyh6hTd/OrY1oqtOGzIH0oHn6wkLMNCPxdttcAbK2C/mLmX+x
 M7Jh/Ng0SXl21RjITvux820CJcxR14jdIsYIRdhejSsUVpBQjXb1saoUvW4u4KsyoWu5
 G1IIGD8nH5VdjWbTUeuQyCazZHx3df2Jbn30HtGv02wEHYddh0Nm+GHc4h8AYalC9Wo6
 VVNMFqN8whAayPWruIYPDvv9bVQ/rwqLewVy9UMFA4RAaUdf86bm3b1tc/7kKqlm9Op4
 16k3gP8y2GafKOZLfGNEQAzKbNoG5sb93CJCU8+IsYU0YlDyF8f5fZV+21yt9NjRzt9c mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs41je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 17:47:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IHSX7b007954;
        Mon, 18 Jul 2022 17:47:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ektsq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 17:47:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjcebfnnwj/6uVFn9JPhh7yZk8200GpES1w0XpVeYi8TrgzQB8EkQCbteo/EHB3J1+r8zKraM4i8pYAgiUoWQYEeqWD/zvZCOxceRRr9iRwRjIs2z1cTCKcNnp/xpy8VtOGtYXZ1pDHocmw0kezg7Aej148nr3uCFbSnAQL8A774EMn9Bgcz4giwUNqJMOqWPQ8m+mofG22iWSu5fLrkkzBzCfVczHEpRA44RcWAplNgv2s3J3/2rIN4+ZdvPzPkiKZeQZhyW8v0/X4Ivm3UyqH7OJv5TydlpuZVqpfQIXpxukBddi4KB3Ls/4mJeBaqT8sc42MIaRCMAUAhA8lG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WVlBWZSaoqfu9swBqSez5EKIe2Iks2kpMzxLKF55i0=;
 b=Mlk+TairUiYWwoPmxfPtTTea8JCF6T9cA/u+07FDic+srIxPV4OToNmAB9FU+qTgMaZW+q2PzZS4NaPJtp/NgaBiJ/txB8N7c0iG6P2CKvxZNGk60R6Go+r/Lr47kNw6XhBTkZ6bvom+ve215J3JYjy00KAXAHklkOa+vj62GmDTY5e+6h7pzt576yS3AaOihuCslH6/jtHTHBQp1vR2V/iwUCtGo6WkX3Aev0L6HfwX3xxz8Ku5miT6yXhi91eMuvDpWAa6+RcQvvCDkXvHFvzvOkkSYCGnM5d619PufhSV5ri2vRx8lbdHJUgxmEh26RtEEBvPzwyyR9JjA5ol0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WVlBWZSaoqfu9swBqSez5EKIe2Iks2kpMzxLKF55i0=;
 b=fU6cPiOhOxYqHCARtvpxAzyqubMntbDOZX+3MQP+kcR7CLpfrZLXclW8OL9PSCZMbYDvh9Mu6AgF1gVLCjoYIyCdDNe5TbOozrvioUKJOAhvkHkb9EE1tmH++1HXnuU4U9gWerl32waEyW+pSvKtwrIvG9McV/t/ZxUAbVw/DKE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3016.namprd10.prod.outlook.com (2603:10b6:a03:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Mon, 18 Jul
 2022 17:47:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 17:47:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Thread-Topic: [PATCH] maple_tree: Fix sparse reported issues
Thread-Index: AQHYlfsoLhkzbf9CQkS2b2OLBBRjJa17+qSAgABSigCAACjrgIAAH/GAgANG+YCAAzbDgIAAXBAAgAAh5oCAAI39gIAADaeAgAA+54CAAAStgA==
Date:   Mon, 18 Jul 2022 17:47:40 +0000
Message-ID: <20220718174733.dya2xjigqeud6clx@revolver>
References: <20220713132926.3sl7gs67dyjj7kit@revolver>
 <44a478e8-2ccc-e82-bd5a-172778c01529@google.com>
 <20220713175013.aoemaelds45aavc4@revolver>
 <20220715195301.r7ozt6ph2scti7vz@revolver>
 <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com>
 <20220718022718.wtlw7grwp6dv5fcp@revolver>
 <1098dd4d-8f12-4493-5aff-1ee489d8e7@google.com>
 <20220718125649.cpatlh7ublgf7bvg@revolver>
 <20220718134541.ucbpuqdfcnfxravx@revolver>
 <7db5a8c5-9084-a7fe-6e83-713e52ed8539@google.com>
In-Reply-To: <7db5a8c5-9084-a7fe-6e83-713e52ed8539@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84b06320-401d-4706-9168-08da68e59cb1
x-ms-traffictypediagnostic: BYAPR10MB3016:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vu+jaiboMWgNnFpRCjndftHEVjgiwQ+M7OXlhG/tMDKg5fprmzmbLcDK7UAtcNWwkAvxDLH9A68YvPo2BVrTs2BN3oxVAHtVT62PXJH6CfBGcQrrKygpwGF71UMECMBkLM3jOg03pu6RI0DJshOrjhL3c+6CVGwLO4dAs56yW3UNpe4LivrDPAr+1nYzIL8Bm/JY+OAL+DUX92uusaeoXThEICzDjo7uCk065fyQ53udhTebjIxHzYi0jIswCz+hTTncy3yq+jrZDxceucm0x+JsdDUJ8cmg5Gg3Bq0pjWmwQSJ5mdijI9YPZ/t2mfLxPpK6v+I4w26SJsV82T+3jhiLNJuGXid6huiU6NLcKwQf1B21WVQKjWorJmlIY/JvPooJlaxKumAldFOmAxmkLvlK82tF3V5tWS1umMQs3Kyww1p3YaW1yEdhmOTJYNykpQ/AYDltyc3MfGroN69vpNBxZVMujHXxdPAmF4pP3IYk29e/T7YaGGtTy4yl/SH4iCnMfuhFsg9ipVdvX2ISmu6QciUaWfrl1Ui8TUltEjLjcNuRKlM7p3GjMH/7XqxTF5Pl5ccuXRfUXw2Zh85GJlL+YH8+tkJpUGLpPmEi64b0VLTP3J59S50NXRyFpRi/4htFLYxrpU66s7GUwxmHscXZwcmrehQEuN5MS8SgVKW2CFLURvYk5SydCV/FWwB3OLc2uzeBMZoA9t5mR+aYEDIdK42QgW6vmkD0eXB7jWE1BFHrwMsQP/tQu56bgDGp7v2xtvOHl+WQ5Ue1D5AZOnY1FtcHK+jj/4m7RCFiQLMpMpfct8T40Oo/fFhibl8bp/PwPQ5eviYIqNvjYlzyUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(366004)(346002)(396003)(136003)(8936002)(38070700005)(38100700002)(64756008)(8676002)(66556008)(66446008)(66946007)(4326008)(76116006)(66476007)(91956017)(6916009)(54906003)(6506007)(316002)(83380400001)(44832011)(41300700001)(186003)(33716001)(1076003)(9686003)(26005)(2906002)(122000001)(5660300002)(6486002)(966005)(71200400001)(86362001)(478600001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q1VHIkKvkJAWlnO+6KPK/KEwofCzSR9uoV1pbk4WZ38kz3ND2FYvSsSPaGq3?=
 =?us-ascii?Q?+UP4cqiM9iYhm+O6EcxIdacWXXrHkVBrc+ruv9JW7OuUf7Ccrp81xv6rGlzx?=
 =?us-ascii?Q?gfJtRDX8bpVcXH3KRb444qxONBN0babVbxbdHKa6q0bndvD7kSzhhGb1UGF6?=
 =?us-ascii?Q?a/R8dtSLLdHJfkHGeJ+Q55gym4qulpH9tvIHT6DZ7e7LN7xKHJzEkv+OzJmn?=
 =?us-ascii?Q?2sEYU0enpBAy1haAFMZfg3Qsw6GEu+5hXd1nqfV5XypyP1l5NkiEvq43rUBL?=
 =?us-ascii?Q?MDvIhlzDWuHEI+IdD4TaNxrYwYq++1btZfLg6U4g/5viLUH5TOq8dOIPBok4?=
 =?us-ascii?Q?0oBQlZJO34cUllTLvJnTvXJcp8C8heHTqtH8rVAjW0ujDyvlFZUPey+wmQE6?=
 =?us-ascii?Q?bzDc2tY3COMs0ctikmhov7iyrsOxK4ygMtc1s7PXVTWxF3KQL0WSpWaD81Fe?=
 =?us-ascii?Q?4UIPTPDwt77ZDdhzTPQP1lFMByrMOoJdmKDM6Gw96uFB+xaKi147hK461JIR?=
 =?us-ascii?Q?tA8gh5+xQ22YYzqlTE21RVHjdhT+jG2CpqZr7sn0Ag8AJQvlpkRL9pXEeojf?=
 =?us-ascii?Q?f6meAGGeVcfGMUP9VK4sdai8Rp52SsKVZG8HAytvfhRHgwy/tK2MwImUiGrV?=
 =?us-ascii?Q?yv7tYa4SCyx9eewJjFGTUf6LyInuKP2iYPhpUGNSHD01Uw8HGJimBoFgApI/?=
 =?us-ascii?Q?DUDa1WoSUN4+MY2unqKNUznnp69KUNyNZdg++1yJxfvVT+c+Lezh8hojruA9?=
 =?us-ascii?Q?tiFCH/L31kAkXrpykGU0Zo9AzAf54mrS37s9fBfPH3GxH2X12H11XXkWXHAe?=
 =?us-ascii?Q?u9LOjbaj02ZuozF0Y58N9htymm/NNdwaawwFrFrzIy9NfLYBbGJCdMDvYu/r?=
 =?us-ascii?Q?VCyLbmGC1MfklLg2+18fl/RChlatHyU6tRH38yr1xz/3X2qPTuqwWNoEl6c7?=
 =?us-ascii?Q?pFs0Wn2PUDtXD0yEUgPehBhWvcShELOc33b8CAUBZyZXdlGHkRdVdrgouVD2?=
 =?us-ascii?Q?4dzjkxDg98k6hUASKjcVHErpsQioJTuteoJOEMTh/SqjodrweP2+f4ZZRe2q?=
 =?us-ascii?Q?xDtOccQJsmtv0OYzXsPQpD+4uk2Al2iB+/tAuZJNU3GzDGH2yQc2EieXKofa?=
 =?us-ascii?Q?IUBie2IU+i71B6OgFtVCtTj2q02owPLUcoVqODnHXpXXACxHKQrf4GYnWCgv?=
 =?us-ascii?Q?R02xEy4Y0IoTf6tJIvCP4hWyt9jWSfUbK8Cxjq7nARmA1aiSe8vNmjK9++2v?=
 =?us-ascii?Q?LLUqfk82oZQPlGS/tm4f/mLt9QYBgSdStljy95EQ1sUMB3blblKPUA9I6cBy?=
 =?us-ascii?Q?NGYX8faHcMK2mLhCibywTBokP9dcYycyUS9wEEMLmP/T3xLIMlNimH/YL93f?=
 =?us-ascii?Q?2bxhpjj36N/0p0HQ/IGjpI/Fj6vklJy0X0VDYfFIu7PSiX5jkPaGomVxvxEL?=
 =?us-ascii?Q?Q+2IAWOEDCYz/2hsDZ4+1K5oQ0ReUyIaCaUZil1K1mJ8FOqAcSxJPFnksmOl?=
 =?us-ascii?Q?4EQiq44hy9EfLdE9M0qrF70rD88/a+uuD/cCex6W/GY8FGLxu6PD3SeGmSwJ?=
 =?us-ascii?Q?TlHqqOyvzHKURZjJ9YXtuzga4SXOdpjGlrlcrm5OxyKkMwo7SeUPcXD+qsy7?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68A1DF37D1EC5C48AA393FF12D3B6E78@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b06320-401d-4706-9168-08da68e59cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 17:47:41.1560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ND1SLWj/OVdu45GMBoB3OOYjFK3VdPtyuWm9sW7OAw2zwoGIZLGx+7RucULzLNLHaHT6ClQXrIK0QRzBnttrMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_17,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180077
X-Proofpoint-GUID: hJCSp7f3euHm8neRe_bx3zFoyy7xCeKR
X-Proofpoint-ORIG-GUID: hJCSp7f3euHm8neRe_bx3zFoyy7xCeKR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


...

>=20
> > So the only time I've even seen __vma_adjust() fail is with a fault
> > injector failing mas_preallocate() allocations.  If it's safe to not
> > unwind, I'm happy to drop both unwinds but I was concerned in the path
> > of a vma_merge() calling __vma_adjust() and failing out on allocations
> > then OOM recovering, leaving a VMA with a 1/2 merged vma with anon
> > incorrectly set.. which is an even more unlikely scenario.
>=20
> It's not half-merged, it is correctly set up (just like if a write fault
> had occurred somewhere in that extent before the merge), so no need to
> unwind.
>=20

I'll drop the incorrect unwinding then.

> ...
>=20
> > Right, the __split_vma() never adjusts anything but one side of the
> > 'vma' VMA by inserting the 'insert' VMA.  This will result in two write=
s
> > to the tree - but one will exactly fit in an existing range which will
> > be placed without an allocation via the mas_wr_slot_store() function in
> > the maple tree.  Exact fits are nice - they are fast.
>=20
> I'll have to come back and think about this again later on: "Exact fits
> are nice" may answer my concern in the end, but I still have the worry
> that the first store destroys the prealloc, when it might be the second
> store which needs the prealloc.
>=20
> ...
>=20
> > > > > Do you have the patch
> > > > > "maple_tree-Fix-stale-data-copy-in-mas_wr_node_store.patch"? It s=
ounds
> > > > > like your issue fits this fix exactly. I was seeing the same issu=
e with
> > > > > gcc 9.3.1 20200408 and this bug doesn't happen for me now.  The l=
ogs
> > > > > you sent also fit the situation. I went through the same exercise
> > > > > (exorcism?) of debugging the various additions and removals of th=
e VMA
> > > > > only to find the issue in the tree itself.  The fix also modified=
 the
> > > > > test code to detect the issue - which was actually hit but not de=
tected
> > > > > in the existing test cases from a live capture of VMA activities.=
  It is
> > > > > difficult to spot in the tree dump as well.  I am sure I sent thi=
s to
> > > > > Andrew as it is included in v11 and did not show up in his diff, =
but I
> > > > > cannot find it on lore, perhaps I forgot to CC you?  I've attache=
d it
> > > > > here for you in case you missed it.
> > > >=20
> > > > Thanks!  No, I never received that patch, nor can I see it on lore
> > > > or marc.info; but I (still) haven't looked at v11, and don't know
> > > > about Andrew's diff.  Anyway, sounds exciting, I'm eager to stop
> > > > writing this mail and get to testing with that in - but please
> > > > let me know whether it's the mas_dead_leaves() or the __vma_adjust(=
)
> > > > mods you attached previously, which you want me to leave out.
>=20
> The overnight test run ended in an unexpected way, but I believe we can
> count it as a success - a big success for your stale data copy fix.
>=20
> (If only that fix had got through the mail system on Friday,
> my report on Sunday would have been much more optimistic.)
>=20
> I said before that I expected the test run to hit the swapops.h
> migration entry !PageLocked BUG, but it did not.  It ran for
> nearly 7 hours, and then one of its builds terminated with
>=20
> {standard input}: Assembler messages:
> {standard input}: Error: open CFI at the end of file;
>  missing .cfi_endproc directive
> gcc: fatal error: Killed signal terminated program cc1
> compilation terminated.
>=20
> which I've never seen before.  Usually I'd put something like that down
> to a error in swap, or a TLB flushing error (but I include Nadav's fix
> in my kernel, and wouldn't get very far without it): neither related to
> the maple tree patchset.
>=20
> But on this occasion, my guess is that it's actually an example of what
> the swapops.h migration entry !PageLocked BUG is trying to alert us to.
>=20
> Imagine when such a "stale" migration entry is found, but the page it
> points to (now reused for something else) just happens to be PageLocked
> at that instant.  Then the BUG won't fire, and we proceed to use the
> page as if it's ours, but it's not.  I think that's what happened.
>=20
> I must get on with the day: more testing, and thinking.


I think this is the same issue seen here:
https://lore.kernel.org/linux-mm/YsQt3IHbJnAhsSWl@casper.infradead.org/

Note that on 20220616, the maple tree was in the next.

I suspect I am doing something wrong in do_brk_munmap().  I am using a
false VMA to munmap a partial vma by setting it up like the part of the
VMA that would have been split, inserted into the tree, then removed and
freed.  I must be missing something necessary for this to function
correctly.

Thanks,
Liam



