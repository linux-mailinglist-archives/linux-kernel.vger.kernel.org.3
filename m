Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3125981A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbiHRKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiHRKtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:49:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6327783F31
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:49:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IAjbS8022676;
        Thu, 18 Aug 2022 10:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=TLYj9M3ajQniu+8GcFliR9tcGCejayr+8UzYytFHy8o=;
 b=df6gZBqnuHdU2guMo5g79XdvucM3mnbl4UFKIFFj/9ylU6PDcPv1qNrrF90hzGGgqtnM
 d1NgbSG8MucWA2lUwyIoymJZtruJeHldyHOf2f0eRL0rd4JLAs0cOCWJjmB6GcRRTCO1
 mnoHMqZap5ccJmojUdG9VlnjqqL+h6Ua4ok4eEHFJahBvpAeshp/3xvacteSIMnXKJyH
 UberU3WdFtLjyun2wLB2SZ84y/uhBy0KHVkBtP9ckGLZLuy7npiBJZ1HC34z8pAwdz/w
 dO4tSCHYnNAUyCHePmcEjrtgWqNTtXz0vX3LvnKhxnvIeEDwmMgADfX2okYbTAHAQIJE jA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1kxvr0bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 10:49:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27IAXqQg020773;
        Thu, 18 Aug 2022 10:48:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c48pea2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 10:48:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCdvucw/LQlPI2kj8qdUqoQ1Z1rzE5DeJacUpWeu+Ia/2QiVx5xQ7NwUC3omoagg91o3T50MCIRQDf4j614qAwolmuOXPj2aGEz9PnrweUo5tKAd87QAI7YNQgFd6o+MsW+CGIeKYtoawfmHZMy5A6MqfMAFmtyvQJjYqUh5ACsE9gIM+1oQ7i/pkS2h+Lb+uw4r4h48IRyDZdna3583CoL/+6csWT2DFQVatRHHUmdxWkiEYnWNJSIUbMfkzqcpqs487LvWe7FPKtMxJaR8nCfZe0m7VJKfnbOkQE/XtCJUAMEv4qynZfUJA8VlR/K075U+AmLWhU834cjcBk7i3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLYj9M3ajQniu+8GcFliR9tcGCejayr+8UzYytFHy8o=;
 b=esko8PET09qUlZyGc0pbZf1i/kiXn6+9G5+Pnp1ugRlJkbgdBrJsWzXW1g5Svs/7uxENT9akxBiFal5DTqGZgABgLJtytMSAFA/KiK1TOglfq8hJcxi6WdOxMrLklI7I3R8cVU2tuAsi/6KrJ5n8Arys0JQAnkgwuPvHRux49C+IssXYXMOjPKezyLCuUGD4jCdr29oInYRE8eee3xClU3jYiU6xub9MZ+PM8vIiSdL5Sz/29afduF5Ix/dU/MTwXyBjWFV1Ay7g5ZmmxjqBM9Sb5hpVCsS1fexKDOU3YDV6oAEp+fmETOqt+ln9i9uK0NsmUesFKIQEaG5/5x5qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLYj9M3ajQniu+8GcFliR9tcGCejayr+8UzYytFHy8o=;
 b=Ss+6jNPVqBXWWN5Mj6UhMGtTJ7gKSxm2Uj9+udNxfzjdGXho8H2Uvhza2UFh18xGrBcHDGdQ5T+RQFIyI92vsNMb4SNG4zKXspsvEEsXuDRjqtotlea4ZfnTJu9pXmRU3CQxYviv2T0umxUsjEWqjydZyOu1GUnndDqHA2k0/pY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2599.namprd10.prod.outlook.com
 (2603:10b6:a02:b2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 10:48:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 10:48:48 +0000
Date:   Thu, 18 Aug 2022 13:48:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Chao Peng <chao.p.peng@linux.intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 150/308]
 arch/x86/kvm/mmu/mmu.c:7276 __mem_attr_is_mixed() error: uninitialized
 symbol 'entry'.
Message-ID: <202208170542.XpJ3DGlU-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9edc557a-70c4-4643-42f9-08da81073b5e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2599:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqaXoIOF5XmsJdZ6taUIIDiBSblksBDU1mRPh6ra/IqDiN/ygGymZMGMcZrLuTE6sAD28nkhDgit9Oblgpo61LTw4VkRMQU8Yg2E6gEeKvLRdQQRLvobGOptJYyNfOvaxJPXRjodbOZS87eTHEO/AJ4eDGtYDk+wQHaaQBspr5o1UDMRRBU4appMdgRlJigg5VTwUYsyJli1u+zTGHiR72riw9j1VUzGx0n7RBlE3dRKBcUB1CVd4BTZqVdoPTyJg92X5Kvns4TTnACOSZQoPVzugY9mkMAoSpgCaWb47fztelHRDk5oAkM4qEKW3fXNWLYIRjukNQ+TFh0exrUWyhTpcxsA5ZPtAgPHjlngy3bHRWaoYk4JGhczJ7fqsGP489xeIDYHffaCqTfCLcKLZl0IDCWSJHMm1mVPAq9rbIO+GB66hphgLWx//0hDt/Jtuaa3pDYJoUT4VcwCdBgzxA2FXQ7+c3momNo4nMfwS77+DffuCjf9y1tzQi5ock7HLZMvLsKeYAINeo/Fi6Z13UoHPWu6vo38l+5kK9LTp4CCgsypgwrgxLOVEtU2O+TeWyQAN41Mqa5ubQwEwQd19Q1Ily+gmj3xcnEcVDpCP3/BhB60/NrSbn054Pi0wcz46t4JIkpteIXwEYVCDzNqTldvydr7OmB4IZJG6ArGU/kG+6DPUK0SgOVJWjpg+8BF9Sk2QdpXuK0tSQdkIUUQMLYIRM2LvfDuE1emdrHNibi4zk4TFPz5Gy2QD4C8pfNKjRHtQzk6GTom7LAr3dciUc/LOhZ2o0LN8mw0n8scis+KTInSkj62YC9qzHwdnT8ybsex5Li9MuVjF1kGKRWkXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(366004)(376002)(396003)(26005)(478600001)(6666004)(44832011)(6512007)(6506007)(9686003)(86362001)(5660300002)(6916009)(41300700001)(966005)(8936002)(316002)(66946007)(6486002)(83380400001)(66556008)(36756003)(186003)(4326008)(1076003)(8676002)(38350700002)(38100700002)(52116002)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0KTlCxzaOGr5FgDBi9ZbPoSN6g3rn4M6dshle97svC+ue2zaMhbsUNv/2uPj?=
 =?us-ascii?Q?bNLIHaTC4gKnI0u0DCJAgD0hYo2mt50KNep+FoC9V3hRinEqs0pabpyICEcw?=
 =?us-ascii?Q?ZLaRHlICSPjo0kY1jN8oA27cfzv/6RAgyFkD/9rWFjnKJHiBwa6tzpYIBqmB?=
 =?us-ascii?Q?NVlcqy8z2cQ9ydC4997QOMEdGQwHImIsvjqp3UQ3NC9G9n40t1ObPd8ku9e0?=
 =?us-ascii?Q?Xd6ZoqldjyPuYWbifmoRhCMAAjemepcf9QKIYW+bzb19vVKaA35d76MKukfC?=
 =?us-ascii?Q?/c/rdz/gKyerSN1DjUkgZf+B7YexaOKiCNb5YQl0I2dunjyBxBBz5L8JrkVe?=
 =?us-ascii?Q?q9ih57RXIGjb7F7kc33azKUIbsKKvNxSolTuqpoYVWavovVeVwR5rQLrTQSV?=
 =?us-ascii?Q?tCW2qEOfeD1BvaeqPhbWRCXUFUeTmd9rQfkT5FErag5eo7VyJXopV+arFEoz?=
 =?us-ascii?Q?MU8EqKUxCleGCFQ2SvGC8phAwlK5uNDNJFPKo6i3K4DOS/k/zs5H88wroy4s?=
 =?us-ascii?Q?VLsMy0cCiVThnaOAbP4lCWhkG3w541/Av7AQhbtYzXbmafk4yiuK8bPk5IwC?=
 =?us-ascii?Q?6wi+5Rh6tIjis9vIwjc8NgkOoFB8nZTAy/CB/ICEC546+whynT9aBpBlCW5C?=
 =?us-ascii?Q?vipIX/yAEdW8xzySljuoG03L13eGju5+x89GhcS9bhDaYlg4OWgd/d5sJWJw?=
 =?us-ascii?Q?auqair/FU9C2pxkie5RiwnkSlw5AK7MdetHvuEwDOA7qhnOrhwYIhdMm9RFl?=
 =?us-ascii?Q?64HHfZu6pT6IXGEKBNgH53cVnjV5xGWHhgYz3SF7AY4VMh3aY1omFqBmUlNC?=
 =?us-ascii?Q?WDBliQ3LhvhHq//mSpCJlc8u/oIo61GFv5AfOO0OZnsf52x15BsWVcCp2qnf?=
 =?us-ascii?Q?XzDjLmLD7rqgkVnlzg14Crfe3IDGPhu6vaW17FJEmx56NyztjjFpIvDm3iw3?=
 =?us-ascii?Q?CRy3O/9FMMzbk/tvgAsV0AiLT0qNByu8zSSiALyISfzYPZsNgFeBCBBueXSO?=
 =?us-ascii?Q?Pp+ZcZ0fyauuGezoGTxaoRdxdD7NO/dPV2y5cM7mhjnR+ntOTLLldR55g0da?=
 =?us-ascii?Q?Wt920kCTN8bekBDMtbJe0iGFbBx7Bouh4dsOnOUVCYvyNOmt1Idx8Nl8bUij?=
 =?us-ascii?Q?BFGpleNYxL3a/kzkMLnzqcwnh3Y2aPxOMkQwz8qS2vcQS575AB3pqSirhNh3?=
 =?us-ascii?Q?nfa0VpTz94DBpCxkVuKPNNqACUe9vaXHOAmy+/akR7DID7OwFqOPYUslrFWx?=
 =?us-ascii?Q?BRTC/76vYgKC73PiiLgsyKGexRdEv+AK7mMa50bxRXeG/khSGkiLf/I1+n+K?=
 =?us-ascii?Q?uwZroU5fuqcfY1ml+9TjHZY0ojJXdQ2OHYcfWLILqfRUDIvYyLq79PpQZWzN?=
 =?us-ascii?Q?MHAYzHSP1TA2pViCYAmjbnUVvM9JzgCp8LR1XzNWxI8Qfiw4EcZjU2ey168g?=
 =?us-ascii?Q?MDCW6F1UGnx4MQF0l0l4q/BheVErJTMAARR3zrCp407+u16gDm9J3DSsLVeq?=
 =?us-ascii?Q?X1Ihh+iE548t+1BPeMfl+TaCrpSBNTjXqU6aDhw3YQVxUGO1Fjz03WHOubS4?=
 =?us-ascii?Q?FAVGVPdBfiBqQ7imbGn2HH+/k2MGqQ8SZzaM9AKi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4Gsvz+5JRMUR7ebBpBllKiAMDc/nvsvZJaUqaBgbsCgkJXIr2TIr99wVsSF9?=
 =?us-ascii?Q?UW64k80k+WHsrYcCybEvQz/1z2200PbRSzqScf9up7aiefPdN/9dJ2U7EIec?=
 =?us-ascii?Q?aQ2F624dMHI13A6kTzvtGegIAO+PTS/XQkCPWHxOaOtpA6Xo5+B4Z8fHrYX7?=
 =?us-ascii?Q?3toStzT1wql2fcqSIQeVEBnwCV5FN0TcPItFbdlhMVAsfNJPAlhqgz8NHZ6q?=
 =?us-ascii?Q?xzgKgzyQUThIIgDNoHgu7zHsyU2emwQuKm42kwp+s6wjT4baMm5D2lqaxxxv?=
 =?us-ascii?Q?gFROutchVGiHbmwmNawfD97YybBjrYSSfNpJiqkkqlMQIa8n5XeFTgQPyEPp?=
 =?us-ascii?Q?CMzN//s+2glO5THT6wAIt7Od6h32NXUu1PIWTwY0CNoZjwrPMW0eeWGz8PKC?=
 =?us-ascii?Q?pjCOZBTWI1fL2A53so3cufszv+et/mECa6avhJ6wdfCvkAlMtn6OAgwvT0k+?=
 =?us-ascii?Q?vaCAn/J74Tv2pK91q6s2BuZPerrtntVnJbrhPb4wqnltgvYNc+Lokv9lLFnd?=
 =?us-ascii?Q?hLonZAof6xfKvptDccj2r5KJFgl2qFkt/8rNK+xqb+k/GoGl86hr5R67WPTP?=
 =?us-ascii?Q?RDlR7r4s0/MNYWJM+KYKrA8LC5g3wVcj8XFmk0EkNwfrDxfSdbnJ+/61MRib?=
 =?us-ascii?Q?dvdDsCW1isc2gl6PxR0mqLLF2OpYyQ8ClUgHrbp1lYCzBOQVnl2etEPXDAPm?=
 =?us-ascii?Q?LfZswI9+Q+ZADW3nNNQcQlWe0A3txHwkO7HSl66ld748Y36l2NBih3yqPPKK?=
 =?us-ascii?Q?Trv7CKWpMCh9rAI9dopxjncL78/Z2VZUphvR94otWHGcrCjuO7iGlSCno+0V?=
 =?us-ascii?Q?HwOv9OJwAvltFx26p4qYgJjQNKB3BEAGQi0sg6qVLb35muY4wWecw46C00rn?=
 =?us-ascii?Q?k2fdMBseShuU3tzdNge4SJHi+AbKK1G16Czk3wAqQT8wm5tk5Ofh1IbxK7C0?=
 =?us-ascii?Q?x7zm7f0n+ZST5/e2Ex5TyNnVo/AKtxoct/9o6c3wlIlDNb4Bo3zsnYRQ6eEY?=
 =?us-ascii?Q?iU0nK83sCPlSiUO1sfo7LUopng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edc557a-70c4-4643-42f9-08da81073b5e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 10:48:48.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WN9DRagM2UwoVd9Wy7H+NE46F5R8WA+nhy8kmYTAeyCNczDDaO8Rwr2YsC3cbGdSh+iWX9avNWsKLffmzH27rqCkm84JBpI1Tsvm1J/poAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_11,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180037
X-Proofpoint-GUID: mqopglWBELhv3oQ-LILT9n6RGCVnMJjV
X-Proofpoint-ORIG-GUID: mqopglWBELhv3oQ-LILT9n6RGCVnMJjV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   85c097fdd1667a842a9e75d8f658fc16bd72981a
commit: a3b11dafa9058bdecc235b9c02aaae2d6b39c24d [150/308] KVM: Update lpage info when private/shared memory are mixed
config: x86_64-randconfig-m001-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170542.XpJ3DGlU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/x86/kvm/mmu/mmu.c:7276 __mem_attr_is_mixed() error: uninitialized symbol 'entry'.

vim +/entry +7276 arch/x86/kvm/mmu/mmu.c

a3b11dafa9058b Chao Peng 2022-07-20  7265  static bool __mem_attr_is_mixed(struct kvm *kvm, gfn_t start, gfn_t end)
a3b11dafa9058b Chao Peng 2022-07-20  7266  {
a3b11dafa9058b Chao Peng 2022-07-20  7267  	XA_STATE(xas, &kvm->mem_attr_array, start);
a3b11dafa9058b Chao Peng 2022-07-20  7268  	bool mixed = false;
a3b11dafa9058b Chao Peng 2022-07-20  7269  	gfn_t gfn = start;
a3b11dafa9058b Chao Peng 2022-07-20  7270  	void *s_entry;
a3b11dafa9058b Chao Peng 2022-07-20  7271  	void *entry;
a3b11dafa9058b Chao Peng 2022-07-20  7272  
a3b11dafa9058b Chao Peng 2022-07-20  7273  	rcu_read_lock();
a3b11dafa9058b Chao Peng 2022-07-20  7274  	s_entry = xas_load(&xas);
a3b11dafa9058b Chao Peng 2022-07-20  7275  	while (gfn < end) {
a3b11dafa9058b Chao Peng 2022-07-20 @7276  		if (xas_retry(&xas, entry))
                                                                            ^^^^^
Uninitialized

a3b11dafa9058b Chao Peng 2022-07-20  7277  			continue;
a3b11dafa9058b Chao Peng 2022-07-20  7278  
a3b11dafa9058b Chao Peng 2022-07-20  7279  		KVM_BUG_ON(gfn != xas.xa_index, kvm);
a3b11dafa9058b Chao Peng 2022-07-20  7280  
a3b11dafa9058b Chao Peng 2022-07-20  7281  		entry = xas_next(&xas);
a3b11dafa9058b Chao Peng 2022-07-20  7282  		if (entry != s_entry) {
a3b11dafa9058b Chao Peng 2022-07-20  7283  			mixed = true;
a3b11dafa9058b Chao Peng 2022-07-20  7284  			break;
a3b11dafa9058b Chao Peng 2022-07-20  7285  		}
a3b11dafa9058b Chao Peng 2022-07-20  7286  		gfn++;
a3b11dafa9058b Chao Peng 2022-07-20  7287  	}
a3b11dafa9058b Chao Peng 2022-07-20  7288  	rcu_read_unlock();
a3b11dafa9058b Chao Peng 2022-07-20  7289  	return mixed;
a3b11dafa9058b Chao Peng 2022-07-20  7290  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

