Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E21501977
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbiDNREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbiDNRET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:04:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43861C5582
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:42:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EEcaGj008564;
        Thu, 14 Apr 2022 16:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RuGO9oVHUxgc+q0wTdiuy+tNIrtudZTpnEa5OT9Ij8w=;
 b=ALcx72rAt8qGpNj5qWSTkzArJ/VAKVtuYxBMFwuWU91z6UsLW/v3WDBtOAqO0oTCM989
 UfJH33FAmEjOFjFEj0/79O40EGMK1LakQ85Lwv1hFNBEighrlmD0act7Ul2VuBGmMs6R
 IZhnxADM+rVugLrraxkfYD45qXKv9xNhl02bHskHcP5B17ozGFXyBhoMx9JE1YMIn3wX
 6Z60xRkmvWx8X5uk3giRqCthKXs9CyX+ytkoI1vaX12/4WIHNIt/5Rg7zSJOoztgrDgN
 2t9+bneHxhlcFHcDQGABbbGjRYU7J3ytiuq2cx7DIXi0UwiKMzuiKVVE5OKbaT7fqZsi wQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2nc1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 16:42:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EGbpsM004663;
        Thu, 14 Apr 2022 16:42:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k4yfqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 16:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl8vd8LP3glvsMFNuAepFDL73siQOu/PfIB9c+iUtkM/GNi/nfUcmE4zucB2xWxXAoGOo8qCziTf6cT8oAASC9bX7bD/aj9h5gIGB+xGZSNMF1a/2IFHHAi3QhIu7gO7sPOPUZUTu+TNWGeLxRRw/OARcbEK47cmM1F92nQV7uRUcwqiE4yIgeLZZfLRovXKmfk2147hvPdZKiXUeOevsXM7FM13xObjRHOFtnpeKk77mwtKqbz3waET5KOJ+m0DCxtrYnpg97UirymymJoXnGC0LFWG4JHYjzP6Tk92IjFex5pUED12ANCKFXqPDmTQMiQNjuwSmZb2ClAK3gkymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuGO9oVHUxgc+q0wTdiuy+tNIrtudZTpnEa5OT9Ij8w=;
 b=HzO7dnsKp9hBRU4mXoFA7TBGyZP8ApnOlpIy5a/aPnuRIfISkq6LUZKwjWu7VpQppe5InkwyrSzZhuRlhe9zwgClHs+uODEeJ+kfjhJxDeVWMkUvAfCo6KFqAp30hOxAioEpDyEvRqRdYCfbiqJMbJokn+AQdsBfyxAE85eYEzO6IJIkbeIIK8ZHrvQap7NGQGpTtqheTs9I4Jh2s/D6hINqlLe6hWBNQd2SjYsJWNTLiUcD0S8ZCzJQfz9BPVl+WXdcc7X9vsS5ZLjcQT+AwLNsgLvVU64cDCZnYgrr/1ZJdjl1xrRyvtudOxvjoUSE6eyc16qOK+m2ObeqRSrtdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuGO9oVHUxgc+q0wTdiuy+tNIrtudZTpnEa5OT9Ij8w=;
 b=su6jhx7TSjBwwPWVyZEEgnwaQeFxrRs8uK2haBOvvW45Dt5JuFwbkZR31A8avUiAfTVbBjvzPg2nmdRA/dBRx9KiTUEyYexnbkI7c4vPh4s22vEopif8IADb2iumHlR6V1J4dTLe1P5ryThfvsi+c1ua5yq6ELHdKUdo6gZt7qI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2877.namprd10.prod.outlook.com (2603:10b6:805:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 16:42:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 16:42:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Index: AQHYSDE59w1vuFTbRUqY9YC4imYEkqzvB5KAgAB3GACAAC4PgA==
Date:   Thu, 14 Apr 2022 16:42:05 +0000
Message-ID: <20220414164157.4n5vidcauvoupwtb@revolver>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
 <20220414135706.rcn7zr36s2hcd5re@revolver>
In-Reply-To: <20220414135706.rcn7zr36s2hcd5re@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0dcd444-94fc-4228-e0e7-08da1e35b5aa
x-ms-traffictypediagnostic: SN6PR10MB2877:EE_
x-microsoft-antispam-prvs: <SN6PR10MB28775EB5CF982E525B024737FDEF9@SN6PR10MB2877.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rO9M9NcBhcRKmpOzdiMbQB3zkQBLeFT4W/ZsRv7LfcohO7vuG55XXwHn+vvOjXjP9KxqCSEcheJw7jvtrkclnCxZBPcd5Iuwm801U+rK0oYi4klhmqMHT8uXfMyCdtN4Wj7Qy2LwLvMUa9NmnjSfzbikFkVFLNsTxev6nOpK2uwgCd6khEfTl/AQYU0OyeCo7xKDgMmpotTciNr6W15n+oBBZ4YgRlRvdUXoz1mDaqN6fhxDKQOyDwR9DbRS+tZk0Fvc4LMKk9SJX7F9MVLcb6ErG0KHZiWY5RAS3IeqeUjPJMGQBBIyl+ro84zzMIH5tMuYfzsB57521gaOtacgmnSNXF0MKU01mZghJ2AsBoyLJzM4rVjGRqPST5DSRDkAeDvhWj0y/3215sbIIf75hntI73OaVIT3AvxmoCEEcyB6QAU6nDijyx1SP8SOGNLx8HHqSKnmxvoh8/1vXSmBGhCoHyaYdojYg5/mRiToQqX//V2Eqbrl4Da2YI99BzGTQVWx55ekgu+IYowCeXz242XUSMPncHGE0yewlK7m3U0esRH5MemQdrHqzEXJwlaMBQD4NT1U2ijK7MNYrqy1d+IekcA3gUdHDnczY31E46zF/D1shn2TJM0dEevOS1wiP74KNqDDbIYZxUhp56nKc/OBiMKEvtAIkU2+WxksYa7+9ZZipx3aaCJEUF5NhDgc8hkTaMcni2+BpWHItr3UWN8g8/NOWnErMNHR5C/2bOhV/krL9Pg8d1b/6yzAFta4BA8vHQavxof7Ul6t0edz6boN5xLQqKcrbXPRsi+k0ixCQmI5afMD7uRuFismZexJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(966005)(26005)(6512007)(6506007)(9686003)(6486002)(316002)(1076003)(508600001)(186003)(71200400001)(110136005)(91956017)(83380400001)(33716001)(66556008)(66946007)(64756008)(66476007)(66446008)(8676002)(5660300002)(76116006)(86362001)(44832011)(38100700002)(38070700005)(2906002)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Im9qIJNW41CG7vDsoOadOIs+Z3D7hmZPHOUCWZ0K5W7RBCVvGB8rlED2hxp?=
 =?us-ascii?Q?euboYdjL6d6mZqwNuvF8NUhT/uceMW4q4WlNs8MpAijT0LakBZxTbNogXxnu?=
 =?us-ascii?Q?fQbs9qflM88ra4oP95M/MWggSP9aFrg/sbJtlSQEpHl2S482i7O+dYeVVYhf?=
 =?us-ascii?Q?VUW2DZmYXUxET/q/orYhi51Z7Qq8zHatokwOQeOyRI1MA8qDBjy5zjSegx1z?=
 =?us-ascii?Q?cxCUP+q754sSo4xYPy/yj5TCjTxpean6Aiv2+h6xoh0Iz1cOh6LpeqxchIGh?=
 =?us-ascii?Q?xARLm+RtYVc5I411wygM61meD8VHfuax87LWNMMs0STlITqsWTqEnd+jCdqp?=
 =?us-ascii?Q?B7PD/OCau6fqUaozuXubHdtoiSc6uzUTDOrgb/uUxN7FoZ1XwtI6Mg+5stP6?=
 =?us-ascii?Q?OLVSoyplDEqrBHpGhHP53fL0Henx5QvgXHQE26GdLYQNo8c6O68P3w5xMj+Q?=
 =?us-ascii?Q?Ew5jdgmi9eL6bu+nfvtiTma99/oAGFmtkpbFRzUun2x8E/J0JRiZ1YfiG36J?=
 =?us-ascii?Q?PeEpYIRPPFGPIlPIIGAPb9emi1Hw2dyBDMr3XAxITLtZhQT0yFs4/4YIc7v3?=
 =?us-ascii?Q?j/V87KKuwdXBVZ6YomsNluxnp0VvrkYYjlqKnVIbyC4WjtO2X5y7+t0sNj8n?=
 =?us-ascii?Q?X8+mD6nU5pSMynn7OTvgDlisMXSnBktH6KCdSZb3KBx9ejPOHcPFEC6b1CLT?=
 =?us-ascii?Q?x3mfx4B82ATNvgfqu6kHiuU2SBIWi4wQuno6U645hRLWJocc/f13vl5zhJoj?=
 =?us-ascii?Q?HmwX7TIDMd548orNejuNmTCNTOXeozxq3DCZfQxe9uWS5e2zZspqFk21rrzr?=
 =?us-ascii?Q?ax2snwUFSKmS7RtOmrnwjxD7sRnJLCB3sKZe0EUkwaagl7HS/zhJL4v0KBgl?=
 =?us-ascii?Q?n0Xdg6zurZHfp6HrUM/oP29chFLmXVUtC7oD4egFeds39aFD+sCzMikp51uL?=
 =?us-ascii?Q?m8QXUnH79qpO9HVuoSETZocNnQcTbYA2PGMpsKKw+EbFD8oYbqqlWpzwD6H6?=
 =?us-ascii?Q?TBtouY3AqBr9tJPWbkVEmQgCd3nmeWpETwkJvksfQcRdy4QqmW/9+9PxFBoK?=
 =?us-ascii?Q?1l3vwOWO+ioyGNW1MtK/jNMWlbpaTaiwrYhb40Icac/b9lLDJFW69Ywr90l5?=
 =?us-ascii?Q?6mkjU0k6gQfZT6kTGV0BbQLgOCGRt+mGzXkRr3StQoLIrm3aMXKOjzQlHVQx?=
 =?us-ascii?Q?m0mk0JKdx/XGbaVir0ZKAUv/Kbz0lTjZ49fpRPQ6UkgxDUD+AjWUo3Lx6j46?=
 =?us-ascii?Q?PppO0IjORUxR2nAhEZEIrMPDv4rCQiL5k3EW0utpzepqOTKjMiE6vPWclvQK?=
 =?us-ascii?Q?njfyCuj+SBNNwVy/qrn6P+izaE3p77dIPSs1MTEMjQnXRShZFiGrkHmdp2IU?=
 =?us-ascii?Q?v6YrkpvtyA+4BndE46hTiRnAN1ONYpWpBzKCI5PQN+qHY3vmUGbaMZ+AUAXf?=
 =?us-ascii?Q?P7wb+SJArlLgHUc17oLJQ/aRcL2wNxw/NSzqcz53DfVCcex6LdVgj47noDBb?=
 =?us-ascii?Q?l1HRl0TL37YyXnFnxqCcoSndtyK2bH16+LrwZ7+Kh8ATQsFzziy6K4zi459K?=
 =?us-ascii?Q?XKQ3aQlIxemcKxr0H+D9FGKUwD4VhlSdga9AAlGJAmZ26GSZSij9my85ufYO?=
 =?us-ascii?Q?7M5+1/Doka0jkg4pOAB9hXZF9hBRdHkXuHrvBnbbS5PoNpxMK1KFoOPshIgQ?=
 =?us-ascii?Q?pKWehPU4AdWFexgndXc2yau+yamL4Uz3qLNEFszukzL8VnvVFEx68crBWI0A?=
 =?us-ascii?Q?l9ehRPapoZBa0h+UcehkfFfs5IdtydU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7EC9C8B7E804A84488597124085588B4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dcd444-94fc-4228-e0e7-08da1e35b5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 16:42:05.6008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Fan6IoTVOWf2srQe1+a2Zkp9+rS3s2n47ZXXGPNkg81Mx/jHrfmni7Gl27ISVZrCT3qjNcCpO99T4Zv02T0qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2877
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140088
X-Proofpoint-ORIG-GUID: H2UIXW0CEeUCzHIibYwJdw7VIw6wqBr-
X-Proofpoint-GUID: H2UIXW0CEeUCzHIibYwJdw7VIw6wqBr-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220414 09:57]:
> * Andrew Morton <akpm@linux-foundation.org> [220414 02:51]:
> > On Mon, 4 Apr 2022 14:35:26 +0000 Liam Howlett <liam.howlett@oracle.com=
> wrote:
> >=20
> > > Please add this patch set to your branch.  They are based on v5.18-rc=
1.
> >=20
> > Do we get a nice [0/n] cover letter telling us all about this?

Here is a cover letter you can use:

The maple tree is an RCU-safe range based B-tree designed to use modern
processor cache efficiently.  There are a number of places in the kernel
that a non-overlapping range-based tree would be beneficial, especially
one with a simple interface.  The first user that is covered in this
patch set is the vm_area_struct, where three data structures are
replaced by the maple tree: the augmented rbtree, the vma cache, and the
linked list of VMAs in the mm_struct.  The long term goal is to reduce
or remove the mmap_sem contention.

The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
nodes.  With the increased branching factor, it is significantly shorter th=
an
the rbtree so it has fewer cache misses.  The removal of the linked list
between subsequent entries also reduces the cache misses and the need to pu=
ll
in the previous and next VMA during many tree alterations.

This patch is based on v5.18-rc1

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220404

v7 changes:
 - kernel/fork: Remove unused prev from dup_mmap()
 - mm/mmap: Fix unmapped_area_topdown() and expand_downwards()
 - mm/mmap: Make vma_store() static
 - mm/mmap: Revert to using mmap_write_lock() on exit
 - fs/coredump: Fix coredump_next_vma when there is no gate_vma on first
   call
 - mm/mempolicy: Port Hugh's mempolicy fix
 - mm/nommu: Add find_vma_intersection to nommu
 - mm/damon: Fix stack size in damon_test_three_regions_in_vmas()
 - maple_tree: Fix spanning store detection on ULONG_MAX
 - maple_tree: Fix potential metadata off by one in mas_mab_cp() on
   final node
 - maple_tree: Fix left max on rebalance
 - maple_tree: Fix mas_reuse_node() zeroing
 - maple_tree: Fix extend_null overflow
 - maple_tree: Fix spanning store mast->r->max
 - maple_tree: Fix node_size check for slow path in mas_wr_modify()
 - maple_tree: Fix spanning store on two node rebalance
 - maple_tree: Fix spanning store to a single root node
 - maple_tree: Better protect mt_for_each() arguments
 - maple_tree: maple_tree: Fix stack size
 - maple_tree: Fix mas_dead_node() to work with BE and LE arch

v6: https://lore.kernel.org/linux-mm/20220215143728.3810954-1-Liam.Howlett@=
oracle.com/
v5: https://lore.kernel.org/linux-mm/20220202024137.2516438-1-Liam.Howlett@=
oracle.com/
v4: https://lore.kernel.org/linux-mm/20211201142918.921493-1-Liam.Howlett@o=
racle.com/
v3: https://lore.kernel.org/linux-mm/20211005012959.1110504-1-Liam.Howlett@=
oracle.com/
v2: https://lore.kernel.org/linux-mm/20210817154651.1570984-1-Liam.Howlett@=
oracle.com/
v1: https://lore.kernel.org/linux-mm/20210428153542.2814175-1-Liam.Howlett@=
Oracle.com/


> >=20
> > I have that all merged up and it compiles.
> >=20
> > https://lkml.kernel.org/r/20220402094550.129-1-lipeifeng@oppo.com and
> > https://lkml.kernel.org/r/20220412081014.399-1-lipeifeng@oppo.com are
> > disabled for now.
> >=20
> >=20
> > Several patches were marked
> >=20
> > From: Liam
> > Signed-off-by: Matthew
> > Signed-off-by: Liam
> >=20
> > Which makes me wonder whether the attribution was correct.  Please
> > double-check.
>=20
> I'll have a look, thanks.
>=20
> >=20
> >=20
> >=20
> > I made a lame attempt to fix up mglru's get_next_vma(), and it probably
> > wants a revisit in the maple-tree world anyway.  Please check this and
> > send me a better version ;)
>=20
> What you have below will function, but there is probably a more maple
> way of doing things.  Happy to help get the sap flowing - it is that
> time of the year after all ;)
>=20
> >=20
> > --- a/mm/vmscan.c~mglru-vs-maple-tree
> > +++ a/mm/vmscan.c
> > @@ -3704,7 +3704,7 @@ static bool get_next_vma(struct mm_walk
> > =20
> >  	while (walk->vma) {
> >  		if (next >=3D walk->vma->vm_end) {
> > -			walk->vma =3D walk->vma->vm_next;
> > +			walk->vma =3D find_vma(walk->mm, walk->vma->vm_end);
> >  			continue;
> >  		}
> > =20
> > @@ -3712,7 +3712,7 @@ static bool get_next_vma(struct mm_walk
> >  			return false;
> > =20
> >  		if (should_skip_vma(walk->vma->vm_start, walk->vma->vm_end, walk)) {
> > -			walk->vma =3D walk->vma->vm_next;
> > +			walk->vma =3D find_vma(walk->mm, walk->vma->vm_end);
> >  			continue;
> >  		}
> > =20
> > @@ -4062,7 +4062,7 @@ static void walk_mm(struct lruvec *lruve
> >  		/* the caller might be holding the lock for write */
> >  		if (mmap_read_trylock(mm)) {
> >  			unsigned long start =3D walk->next_addr;
> > -			unsigned long end =3D mm->highest_vm_end;
> > +			unsigned long end =3D TASK_SIZE;
> > =20
> >  			err =3D walk_page_range(mm, start, end, &mm_walk_ops, walk);
> > =20
> >=20
> >=20
> > I flung a tree up at
> > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mmtemp containing
> > mglru and mapletree and a few other things.  Could the mglru and
> > mapletree people please runtime test it, send any fixes?
>=20
> Sure thing.
>=20
> Thanks,
> Liam=
