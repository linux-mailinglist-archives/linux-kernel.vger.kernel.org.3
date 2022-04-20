Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D014C5089B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379186AbiDTNu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379191AbiDTNux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:50:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A8F42EF8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:48:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KDBpuH012431;
        Wed, 20 Apr 2022 13:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=RUyY5P4cE8J1f8seQyFpGa4mI+1UWGl471SYZR/ifjQ=;
 b=ChpcAmw5TgXkG62JVfw8Ta1eXzdjWzVhljvQohJM3RW23346GQRpgEA8YGid5IANw0mi
 Z+fY/ScIe/jFdRjZuKnJU1rTK/piiKzlgOXba7csEGz/ot1GiVLJzL+I4k3Vv8IC7o7P
 Fseq7p+q74/QkcJtiD/c+KzZeezGctJEU0umb/rLJVuSRCrAHU0gTJsY93BZTYM4Zrwy
 FWI6ZlZPpM3WoSSZYMh0DmViTtj8D6TcqxMajQ03wVbwSLrWr2hoozkeRlvVihlgN7cB
 vv3X3yTTET+GqJwWZ24iDXrDTs4JEidzp9tymSt6I73gAS/9H1LMYMieCnjr1uGGXpJL Bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbv975q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 13:47:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KDfmRv003977;
        Wed, 20 Apr 2022 13:47:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm86fpc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 13:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLopXI6ptduJ7F2Hidxjlh4TiFGYHr8VBzGmZihoUN3wvPYlb2Kp1BBS78wFk/jX65AamYFPea6VOVqOcTDU3x5tAll7K/xNK2MSi2rEw0doBku044POSpt+2yWJNlf1bt6qDV4eLwr5IQG4368oFfIPhkXU5NcV9ieGQXX3MIV1jUtjBj6tVTClO6B++B+HvlT++o2ewLGbH9rVdO6TzP0EYZIWvylcRKg8OTHiG2NLUazLnl4p7sYqMMnfz6lj9Opz814S488TiFRZLB8DI882jmeZ7S0I1oeSrkK76lel/1btP7YRqfPQquwpVu+98hp7EHj4iNQ4fiBt/Mr/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUyY5P4cE8J1f8seQyFpGa4mI+1UWGl471SYZR/ifjQ=;
 b=cwJ7H6TZD2iRN0cRIUJxMQd4r3Yc4YVWBcI9euNbECxeoNrVyTFAAJsBZqfHXtSRRo88PHkBKI1eBgFwxZ8N285qS1JQiPNjkbheCRS23oAgv5610szm24JClUi0IBDlPRvUZMsZd1oXK9wzKu/fZtzAuNTG+r7m3ksF5bOHdTcNUEnZVYbfCqJZ+672sr7KbD/ir99rMmCHWJesVJJEd6mwiUreBATTTsZSh4UnDDHHJ2vj/uBwiyxLek9LYxIDHUrglmoQGzjR6ItWrXhdMRGil9FzOk6GVscKN9YF7dffq9LlhRoO8Lfy3BZ6/W7hoye7YCxns31aSrT9eSD6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUyY5P4cE8J1f8seQyFpGa4mI+1UWGl471SYZR/ifjQ=;
 b=B/leYkyEdz4zQbhEKm+qVvXEaen9etOI6WxM/sxCGsx09Zs4q8tACNGmxRzB1t8eQwR65msabJPWtOqZX/08FrIfe0bx/6ZR9FPUjJ/a7/uDDiSeespA9dz74Tur+CU53lFH/VtYJ9jzHHsewaEdb1uM564/K21yvH4VHji0aFE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1609.namprd10.prod.outlook.com (2603:10b6:4:11::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 13:47:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 13:47:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v7 07/70] Maple Tree: Add new data structure
Thread-Topic: [PATCH v7 07/70] Maple Tree: Add new data structure
Thread-Index: AQHYSDE8DkCjbdTP2E+hzXnGNGH0raz46gGA
Date:   Wed, 20 Apr 2022 13:47:53 +0000
Message-ID: <20220420134737.yuhkl6znauwpp7j5@revolver>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220404143501.2016403-8-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-8-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a477830-54cb-4d69-cb2a-08da22d45e55
x-ms-traffictypediagnostic: DM5PR10MB1609:EE_
x-microsoft-antispam-prvs: <DM5PR10MB16098FA72BD7D98100862613FDF59@DM5PR10MB1609.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZA/SLFsVg46GDtXY+XNhH7TOjsA8Ygd+iGnBdHyS2NuqbX31NJq63uIAsOJWgBvox6yTYl5Mykw2oM559tNQ7B/yp5uhtarRCR9b+R891M6yfzMCucqtut2Jwq2Tk/IyTR0o/tUo3wGnX6WMRN8wrREHdqtjgVh8svKC5L+tjlRHhWT2QUhvxLnNyam3xdaK2HQu3rTSdk+5hVa0Gvn+wEh/IK4Wk4RdE8wyt1DjjQWuBWyfklPHVJeAJrXuFaYphY15JPgFOgeYpN6znaVCOMlAL/Aba/jgQ95qm0fJKOgHa6JXDV8ScRNMgqWFHvg38L19cWjAP40Pm4C4mGbKNAi5jBkmZ1PzwLLVrxd3wbBfClfwaffvclRctyxo4JNmHt3F7E0t2grHB77hxijHzuN3IwCkYh2lX+CGJa54Et/OzWfBYAzrp4a3ZsmzDmj4DIOwwQCOtEIRnIRkpy2MJc7QuGjlwtxBns89zEUNkRyOf8IUVgQyU+drxQ9X+W/SrjmhMISNu4oEPchtZ/ABmu4wjEMeD83FUN/afSWXcdIjuTjFnn9UJGmklpfvqZfPItIBSqrKU1s3eJ26UEDMR+dI7zp0bJABTFEFCbh2/6yBW5jEMhh3UKlaMTUsfK+eiWbNGQRuRUE0DE5l96pUNXKJfqpJDcDpB7pEbyvCzPbg6pN50/rsq16QVxsqZCIpzzwEsr2ngr0XawyCM7QAew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(66446008)(76116006)(38100700002)(66556008)(66476007)(6486002)(316002)(44832011)(8936002)(99936003)(91956017)(71200400001)(8676002)(110136005)(38070700005)(122000001)(64756008)(83380400001)(5660300002)(186003)(2906002)(508600001)(86362001)(9686003)(33716001)(26005)(6506007)(6512007)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GskvBeH/HoELQRnzZbOOLFWh6NURMsGcjbIQA2KalYSAeVjYzkot4F2Tp9GN?=
 =?us-ascii?Q?HiJLSXER7uANPZ6NiarHLt7ZmmXlumdBNxfjUmGMxC7eDpYQKkZmO8U3Vt1x?=
 =?us-ascii?Q?GWm6LvCGO3o5te244ApEV1GQoubuquAH78c28K4HuoQmsPFJVJGKa3TLrJcO?=
 =?us-ascii?Q?eH4ZVceOXBffO9WUXsy7Nbe/9uFRGMCdjhMo4Q/G8es/OPq8+sn58Fm0NYoY?=
 =?us-ascii?Q?NmmOPyrCWTNJ/zq2N2BZle+39hJSxyCxtuLOypJX3XDco0uEpB4+rr0nfQmS?=
 =?us-ascii?Q?pz0FIl7Tz9U3DnI/9cAkhUG/b+HYyknQcZRtbBNMgpSSMYgdsCjIO3lVKXgQ?=
 =?us-ascii?Q?hzjnlNlrdUvmkPesoHu6zZDB28BZXkIQMMREW8wexZL/Qu2TiW4D2D7Uw/YC?=
 =?us-ascii?Q?NU/OE/Z+Z68B7BTKgwFA0N+v84rcXAUk6Nu1dO520AjQN+ZkrcS7UuMMWfFq?=
 =?us-ascii?Q?doEnh2cL3izxdvre1ao6eLGeCCx6AS4kSxnslBEWgpwJdbXu0UPUCfGtOLxJ?=
 =?us-ascii?Q?1/mRTiRhP2suz4W6eoQIOlyKwzPOcuart3lWkeIHJT+vAM9onfkcG5ZhV9Rs?=
 =?us-ascii?Q?gxbqAAWE7TEvKWo5dSe/xvgiYA0FfgbmwCAp9nRvU7dzpvrBEAITu40iLJ8X?=
 =?us-ascii?Q?v3RKNQJxDDBpFh4Gl2eCGSmoe8UUT2IRTgGSfdmQd9bXmGxo9xJ6HUOxi4yj?=
 =?us-ascii?Q?bXmtCXDWuxtnpcAJuOMQZrHVBbNMRxtjUstfIt95pbjlhQkhrHA31ikmgYzQ?=
 =?us-ascii?Q?Qjrma/VOMJqDnv6DhnKlVf/3NMw3qhUm0jJJOfmYYGPYuE7nPQ6TRNRbaHis?=
 =?us-ascii?Q?AU2FFJqFBeDDJ/HUG3o76nLHKQu6Du4VBpm+neDEcW1LgzV/A8AE5rPXx5H8?=
 =?us-ascii?Q?pRnjy9fJSycf1YM5HUAF6y1/An4yfwrIAzOjbPCmw580AhEZfh3avCfcw7sK?=
 =?us-ascii?Q?KVVJT3+yYJ4OhFHQe7tJDvdUeFDv4OvyAIr9A7FVzQQ53qOJGTw2NDGwilLB?=
 =?us-ascii?Q?9Qn1GDISHNl+4pFObRPzHPY5TS51zQ0EPbteWsiJVOuhV/jvK+nIpnedcQ5M?=
 =?us-ascii?Q?tBUR9V+pTPkyf2UMF8YwCrYe2HkwRxy23iui5qwHnWpepeyXxmXEl6cMBNuz?=
 =?us-ascii?Q?D8KAuAbAEDI/vGcR8soQ+bc1ndDDizmjrbd7wrtrI8nLOZ332wFxkYltrys9?=
 =?us-ascii?Q?0vDNIFq+mmBp4b62x/j5IMkEKo8DckvHOaksHFK+QmrCSfmo5ej7DtS0pr//?=
 =?us-ascii?Q?1WlAZNhKJqWq0TYUB7TZN0KX+++LrR6n+B1PbHkpOUzK42hfPtUVCGp31+ql?=
 =?us-ascii?Q?F55y2PDnFRQPnPHSiivj/g+oej/41znD2V8IlrKGPRCBGOpiBxx9ol7P+6ZD?=
 =?us-ascii?Q?oATIKYZ9TqctyYY+snOTAt79dAW2JSZc6qs6COJCx9uqGTLUP2zXTMcssiPs?=
 =?us-ascii?Q?x40NBhxssxHroC+CYqzIOyjaaza5oDx/QONtveFA82qFH8/gx07e5aDTgbWr?=
 =?us-ascii?Q?KW9OH9TrTYJtc3Rxf8pYD+A722+/afeuXiz+/iAzsF9YhV/lArBQlO2nfw7j?=
 =?us-ascii?Q?ZndlmHDIqV6R++dUku8ndsJQP1/OyFw0RZF3t6lLGh3RpcPNF7MstO3IuoVL?=
 =?us-ascii?Q?tOtf4iIgxPJ+ptge3xbZO2zy1PN1tKmFCh8h9jSJ3V8eix4tJ6u8ljEH9mut?=
 =?us-ascii?Q?fx4o328hmkS5MnscsJsH5av1uZf49BxW/HB4JADdf7e767ztWkyDzEB0zU73?=
 =?us-ascii?Q?m72w6wE/RZPLv51QKQO/9CRhVRqf1UA=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220420134737yuhkl6znauwpp7j5revolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a477830-54cb-4d69-cb2a-08da22d45e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 13:47:53.6969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssw/buyDM05wn5/M1rUToizInljUijL4q6A9XHSJXWYA5Gu4U8eyOKGvjF2vKRdfjIddbdteG91UEC2s7dh1DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1609
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_03:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200082
X-Proofpoint-GUID: 5_WWc2NEFS1cbXBUmRsFuK2R2yDXl8dK
X-Proofpoint-ORIG-GUID: 5_WWc2NEFS1cbXBUmRsFuK2R2yDXl8dK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220420134737yuhkl6znauwpp7j5revolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B0E569068A7A54EA5079CC91D107B36@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Liam Howlett <liam.howlett@oracle.com> [220404 10:45]:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>=20
> The maple tree is an RCU-safe range based B-tree designed to use modern
> processor cache efficiently.  There are a number of places in the kernel
> that a non-overlapping range-based tree would be beneficial, especially
> one with a simple interface.  The first user that is covered in this
> patch set is the vm_area_struct, where three data structures are
> replaced by the maple tree: the augmented rbtree, the vma cache, and the
> linked list of VMAs in the mm_struct.  The long term goal is to reduce
> or remove the mmap_sem contention.
>=20
> The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
> nodes.  With the increased branching factor, it is significantly shorter =
than
> the rbtree so it has fewer cache misses.  The removal of the linked list
> between subsequent entries also reduces the cache misses and the need to =
pull
> in the previous and next VMA during many tree alterations.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Tested-by: David Howells <dhowells@redhat.com>
> ---
>  Documentation/core-api/index.rst              |    1 +
>  Documentation/core-api/maple_tree.rst         |  218 +
>  MAINTAINERS                                   |   12 +
>  include/linux/maple_tree.h                    |  682 ++
>  include/trace/events/maple_tree.h             |  123 +
>  init/main.c                                   |    2 +
>  lib/Kconfig.debug                             |   15 +
>  lib/Makefile                                  |    3 +-
>  lib/maple_tree.c                              | 6979 +++++++++++++++++
>  tools/testing/radix-tree/.gitignore           |    2 +
>  tools/testing/radix-tree/generated/autoconf.h |    1 +
>  tools/testing/radix-tree/linux/maple_tree.h   |    7 +
>  tools/testing/radix-tree/maple.c              |   59 +
>  .../radix-tree/trace/events/maple_tree.h      |    3 +
>  14 files changed, 8106 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/core-api/maple_tree.rst
>  create mode 100644 include/linux/maple_tree.h
>  create mode 100644 include/trace/events/maple_tree.h
>  create mode 100644 lib/maple_tree.c
>  create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
>  create mode 100644 tools/testing/radix-tree/maple.c
>  create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h
>=20

...

Andrew,

Please add this fix to the maple tree patch.


Thanks,
Liam

--_002_20220420134737yuhkl6znauwpp7j5revolver_
Content-Type: text/x-diff;
	name="0001-maple_tree-Fix-potential-insufficient-nodes-on-mas_s.patch"
Content-Description: 
 0001-maple_tree-Fix-potential-insufficient-nodes-on-mas_s.patch
Content-Disposition: attachment;
	filename="0001-maple_tree-Fix-potential-insufficient-nodes-on-mas_s.patch";
	size=1181; creation-date="Wed, 20 Apr 2022 13:47:53 GMT";
	modification-date="Wed, 20 Apr 2022 13:47:53 GMT"
Content-ID: <40A70CFC22AC83408A1E3CAA7320A36D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAwNzczZGZkYTIxOTQwNjRhODhkNTMzMTg3NmEyNDg4MmNlZWM2ZDAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCAyMCBBcHIgMjAyMiAwOTozNjowMiAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBtYXBsZV90cmVlOiBGaXggcG90ZW50aWFsIGluc3VmZmljaWVudCBub2RlcyBvbg0K
IG1hc19zcGFubmluZ19yZWJhbGFuY2UoKQ0KDQpXaGVuIGEgc3Bhbm5pbmcgc3RvcmUgb2NjdXJz
IGF0IGEgbm9uLXJvb3Qgbm9kZSBidXQgY2F1c2VzIGFuDQppbnN1ZmZpY2llbnQgbGVhdmUsIG1h
c19zcGFubmluZ19yZWJhbGFuY2UoKSB3YXMgbm90IGRldGVjdGluZyBpdCBhcyBhDQpub24tcm9v
dCBub2RlLiAgVGhpcyBvbmx5IGhhcHBlbmVkIHdoZW4gdGhlIHNwYW5uaW5nIHdyaXRlIHdhcyBk
ZXRlY3RlZA0KYXQgdGhlIHJvb3Qgbm9kZS4NCg0KU2lnbmVkLW9mZi1ieTogTGlhbSBSLiBIb3ds
ZXR0IDxMaWFtLkhvd2xldHRAb3JhY2xlLmNvbT4NCi0tLQ0KIGxpYi9tYXBsZV90cmVlLmMgfCAy
ICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9saWIvbWFwbGVfdHJlZS5jIGIvbGliL21hcGxlX3RyZWUuYw0KaW5kZXggM2M3
OGU2M2VmYWVjLi5kNmExMDIxNjUyMWUgMTAwNjQ0DQotLS0gYS9saWIvbWFwbGVfdHJlZS5jDQor
KysgYi9saWIvbWFwbGVfdHJlZS5jDQpAQCAtMjg5NCw3ICsyODk0LDcgQEAgc3RhdGljIGludCBt
YXNfc3Bhbm5pbmdfcmViYWxhbmNlKHN0cnVjdCBtYV9zdGF0ZSAqbWFzLA0KIAltYXN0LT5mcmVl
ID0gJmZyZWU7DQogCW1hc3QtPmRlc3Ryb3kgPSAmZGVzdHJveTsNCiAJbF9tYXMubm9kZSA9IHJf
bWFzLm5vZGUgPSBtX21hcy5ub2RlID0gTUFTX05PTkU7DQotCWlmICghbWFzX2lzX3Jvb3RfbGlt
aXRzKG1hcykgJiYNCisJaWYgKCFtYXNfaXNfcm9vdF9saW1pdHMobWFzdC0+b3JpZ19sKSAmJg0K
IAkgICAgdW5saWtlbHkobWFzdC0+Ym4tPmJfZW5kIDw9IG10X21pbl9zbG90c1ttYXN0LT5ibi0+
dHlwZV0pKSB7DQogCQkvKg0KIAkJICogRG8gbm90IGZyZWUgdGhlIGN1cnJlbnQgbm9kZSBhcyBp
dCBtYXkgYmUgZnJlZWQgaW4gYSBidWxrDQotLSANCjIuMzQuMQ0KDQo=

--_002_20220420134737yuhkl6znauwpp7j5revolver_--
