Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427A756933D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiGFUYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGFUYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:24:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7877C17052
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:24:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266IQWe6022831;
        Wed, 6 Jul 2022 20:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=8Mr7nue8oB6jg8dX67sSTwPcLqfzfCc+7IJnVpQ5VwY=;
 b=VehlQ6ZpX0KiVSPolOFWrWCQ/WbRNQTXw8VqcGue0iyWQBFC2EiDPSRAo1QrEBNeaUqN
 ggDx3aj/966sMiAJHAlgtjZccEmiGnEamOVSI6YrizS7q0O+XgKfmiS2GfZUoe+2HTyJ
 1gxVdIoToJm8BY4AWFbLr5gvkkJmwnjNPYr9cYs6IQ9jrBKCrO/uzVvx/BDioMbxd4XH
 bckeRGugTOalmCjlHzPmX8aCSwI/JmyL4F0tKbL26y9+LcuZbuQSie3MOdOzhysSNMZw
 uO3zk1IyjiwlF/O0T/m3Moes+/+LS+vIergd6uyqitXRE/Uqi/+bGYq1JU8UoTs2XOD9 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyk9w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:23:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266KLTiq036182;
        Wed, 6 Jul 2022 20:23:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud8c0th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaErHjQsEpQR+YB2rfbwznMhaOvVfHcy5W1KWpsuI97Lj0p7agpIC3sEOK6756v6VBwe7AU/y+aVRTXOReDGmMzGP6D8tgZ3ooCVryD7AiV0P817lRlrMypBmnys+G0MSFZDANSCkjI8qWAit/6CNfgdf4bY31ZJSGhf9js9k4XM13VoOu1QMHUhyabjZwKRJOyKXA3BNZKNYnnu3wFpYFcLbYLiR9snMIL01eT8xOi3IiPTLIpg90RvsJpS8myz6ZKl1rotRd3neKvJkCY7l1yRfIwlV6J4Cb6d9tZQXy+rDo4WPYLug7JHzI/0nGz2GhZgmtGx07Wt7Td2nd3Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Mr7nue8oB6jg8dX67sSTwPcLqfzfCc+7IJnVpQ5VwY=;
 b=dtmQrsZp4mcumSjgh/vgpLbOOUuGnMmdiOdz8TgKVTQUXnBF02puH5o0RKRiOXWgx2RnNE0sob4OibTUvJqMoX3rC3m4vZ6QmJZfked2O/SZyVS5fK5sE9aN/pHgdynPbQM8hMLWJ8NWMAbC13g7Y+vavfxKmCpQ3aGN3BNnEBQ3RON+8h4Z/bYLHcrbIsSZc2+BmXrOfijO2zaV/5DvYUqTZIhHvaj8tgwm1M+XqBedGddiR/jfCaP8QaIsSqCZY5l2Poz6RHqtrlwZiFoFI/nE6B0QKwkegbUmluXXRfvniasPdCUErFnUmzIEOXLRI6N4AbGeKX5F2SBfCMlxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Mr7nue8oB6jg8dX67sSTwPcLqfzfCc+7IJnVpQ5VwY=;
 b=RpB+OdWEQoPyo/ZsSklKEk0/8t6e6vIrKj9Mt9ZBhPv/xUTh6lzd61/TvR0W/O4XqZFUgm7CvwejBeWDgOKUuBvDoWW5TZHHQHis6jEphPrMI6YWibIAGTkRJk8Xa3UYaPvHRQIxtQf3rgb0uFUXyu1jFHdsW5HBQe+j02H+VCA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4032.namprd10.prod.outlook.com (2603:10b6:208:181::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 20:23:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:23:51 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v4 0/8] hugetlb: Change huge pmd sharing synchronization again
Date:   Wed,  6 Jul 2022 13:23:39 -0700
Message-Id: <20220706202347.95150-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR1601CA0012.namprd16.prod.outlook.com
 (2603:10b6:300:da::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43478b46-3167-49d1-bfe4-08da5f8d7092
X-MS-TrafficTypeDiagnostic: MN2PR10MB4032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7U2EfldzisR7qhYqHCAXTTYOSXvlJOMjD2FGXezF2uNaeE7YpG6g9LCWqXBtl2QIU2lCdlStwi0OI35kqMh5jIhbnQj5/X1uFBJqAEU2tfSuzM4LSMOJHHnw7eFH5GRg5wwJZn+VSyvmfY+psLOElxIkw/Ztuq/ixFn6JkQbF7pVClAhkgkvO8LG7rfw2CNSwTdkg4dfXlb6olFpafkEA2yWPyfULUcSRZZqYnAH4LM6SkTHQapKml0eZTrwr2ns55JrqyZr2tDMp2ZUcUl0Znd0MOQgGViiWGoFZ3GYwNWhXwe76G0iVdLVLR7DQihfDD8JgkChrTTWOyr0FzR79s45iSN0OCYfONfZzkIz/ucMvL8vuRqoS+6praLmCF/cJ9J7eeWK5ZEDT+vfVlYvw+bXgDKILIs+nnWS5iQhExkviTzSivEEq/UN7uea7dRg+tsm25B/xvXDt1EFBPvCe6MR5Kg01arqJBBUapQh2Pkhhy3vJ2w2Ji30k0cGLI5krtJLp67tqcsHGMO6C4bGzi82FwZ12Yt6NqG9jF5+6RIVeYEWpqtlzOop0Kw+VEzMRNmoiOJhAWwrRYVw2XtAS7Wrtp06KGQbRiCPK1CAU7KZc/WKkqQ/Q0oXg+j2ROk+TorM+B5IQuhXldkV6E0AKXqN2+q0UF8eHcvya3DK8evwJZOBg/Iy3UaZ9dMvXmijPhmY0t4Q6hW680nxvA7UtZN2f3/X5x2XHb2gkvziQDBpJl7Slkh8XhyfzasL+4Jndgpk1ujzM8wS/nyqGOaBaicYdBKAqL/KleZizpmIpaj7shpvZdZ7iPPvSTCOrLtjXejEAd+c8R0JQGZcUZPYxYNLGImUBZkCN1F3gysDOeuTO5UFr5iwr7Arj0FAb+q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(346002)(376002)(44832011)(8936002)(54906003)(5660300002)(7416002)(316002)(478600001)(6486002)(36756003)(66556008)(66476007)(8676002)(6506007)(41300700001)(6512007)(6666004)(4326008)(66946007)(966005)(2906002)(26005)(2616005)(107886003)(186003)(1076003)(83380400001)(86362001)(38100700002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LM1JFT3fec0l5VRSMtIAsyrnfSDi8db2rvQjzUL/Kt4+6/sigIADNT0OA4vT?=
 =?us-ascii?Q?SKQbpG/88Z5Y5X5qWCsue4fGsADQRzTY7wiDw1hqDCXJBJpzqq3RBmM3ELE6?=
 =?us-ascii?Q?2x276T73w0ZDk5+8n0tija8anWmQnXfNxLCkEBkS46p6UqTEAefQQlSEnBGp?=
 =?us-ascii?Q?Bijh5pgi3RG0fOdRG9q8iPA+QqN86jKBrW6QYH+Fu5OfRy6Phpbi+tLQiKoQ?=
 =?us-ascii?Q?gyNlgfb27gqEo1nh/ckY54f703496q0vXwiA4j8Td9jlGJ6sGT4JJ6XyTqEu?=
 =?us-ascii?Q?MH5Pzw4ZFBHVICjd9YjW47tu7i5kUCIDprE06UdBd/uNKff3okSVNKuwSZAS?=
 =?us-ascii?Q?ywr+Q6jRBQIqfG2z/MjGBc6RL6nLL+H4ncuupSd5Z0oNcCZvLwpBONL+pn6U?=
 =?us-ascii?Q?OOqGK4UyOtNqo/JWJl7HZf4U6hn++VsLKftIOdZXu9Yp3cXVHLlZsK54v4xF?=
 =?us-ascii?Q?8QJoMfZJb1P166/prFAz//X69NF+suLjCJ8wGd4fEbiD7h1B9ThApfqbxP46?=
 =?us-ascii?Q?pCgxBH7SFjEdYdAV0JuMVGz0ho66aEvGxPeBSLDZCov8VFtSrzIZNuVozu6M?=
 =?us-ascii?Q?NO1+APz7I6QN7Hy8a67d5y/VyzL+9JYW6+Qnat0bXaqSeT0YLQgV37fKbdnZ?=
 =?us-ascii?Q?qypwOZkXjU7CUvo5OxhYw6eGoFb8oBX/iiLp22ZLgboJkLL+dDjX5sJ4JkJi?=
 =?us-ascii?Q?QLARMIDLBfPFZQyK3AdMNWhTzNOZBLnNS9vEx5x7shhy+8sp2bW5Gbj0rDZB?=
 =?us-ascii?Q?VR58EOtB0gAwnfGuy4DbdZCqZABEJwElIngrujwx/uVm78PYE3DssyNTebq9?=
 =?us-ascii?Q?+fOTrFcKLZ3DkSRePBgqVorLpuznrfus9lgf/76v982ucngLd/WvnG/y2Nmp?=
 =?us-ascii?Q?AbDCBUYGnubxtcAgYDqCsRQMTmtLqF1emcs7RsfG03rG4GP/PmD8IuCBtJ1X?=
 =?us-ascii?Q?ddfDLgOPZJqO+7uo0TXiMZlveBCa7irVXuW/OuYcqwciUcHm/2cUtxgiKVAu?=
 =?us-ascii?Q?jN9xpiYlaTG4MHzAJ1MZM3GIfov7f++rIch3l4xb0m/P1ATa+3QHUQkdzcs9?=
 =?us-ascii?Q?OXUqhTMjWQ6IExX9fk9Yr+o8yxSvBhp2XeRDlo1xLeqtDollCZv+5WJP2G86?=
 =?us-ascii?Q?QHO9SovO9DJ+55ja8FGldPeVBq6SvEaFXEBGCM/Q8y3EUElrG1Oy3SS7f0iR?=
 =?us-ascii?Q?dZCEwp+g1jPsznZcdi6sbfnfp1fmrVcS8G/EATVbj01Bgg1k32H1GlEYWhHJ?=
 =?us-ascii?Q?FmIBrA+2d+gDrA+/VFwbPtxYMlIOJDWR6o/Jr0caVHldjktwaV0Ge51GAEDQ?=
 =?us-ascii?Q?j6cF1B1XY8haLl2Twm6HK8Sw8kFWtyBSrhXk3NE9ajPZeXcgebn/Md65A7Xo?=
 =?us-ascii?Q?VeF4+sBwLQyn+uM5J5neYFZrAjns7hVCJFRRDLXVLwOy5bg6ajr0NtId8x3Y?=
 =?us-ascii?Q?EKyBmy9uEDiQCPAXXBJ127mad9yQcssKnoZxR891CMOrSS4ugzL2f+yBQtzx?=
 =?us-ascii?Q?v0FBpY6PiXzYPIfAuAJgaZdRue0fG4m+rtmp+W5VlNVd1thghQNH53x/KaDb?=
 =?us-ascii?Q?4qbe5ItcaQimZVMQJJv8UJfkA0KZ6Le9OQq13iTFXPmJNCVxZG0forFTUwBY?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43478b46-3167-49d1-bfe4-08da5f8d7092
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:23:51.3007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVK1d34AwQl6FukxTtnl9gGneFUziVN3B/LITOouFwdRl7uHXl8XwSlcynbwYdtBjwvnjd2pVpLv4x2FqNQ9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4032
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060078
X-Proofpoint-GUID: KYyNpegCUjI3pGAaLr_614Hi0t-2Foug
X-Proofpoint-ORIG-GUID: KYyNpegCUjI3pGAaLr_614Hi0t-2Foug
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sending this as a RFC once more in the hope of generating comments
and discussion.  While the changes are intrusive, they do show a significant
performance benefit in my simulated workload.  Code is based on next-20220706.

hugetlb fault scalability regressions have recently been reported [1].
This is not the first such report, as regressions were also noted when
commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") was added [2] in v5.7.  At that time, a proposal to
address the regression was suggested [3] but went nowhere.

The regression and benefit of this patch series is not evident when
using the vm_scalability benchmark reported in [2] on a recent kernel.
Results from running,
"./usemem -n 48 --prealloc --prefault -O -U 3448054972"

next-20220629 (unmodified)
--------------------------
samples		min	max	avg
48		492006	523305	502552

next-20220629 (revert i_mmap_sema locking)
------------------------------------------
samples		min	max	avg
48		497107	522704	507234

next-20220629 (vma sema locking, this series)
---------------------------------------------
samples		min	max	avg
48		494480	532461	505579

The recent regression report [1] notes page fault and fork latency of
shared hugetlb mappings.  To measure this, I created two simple programs:
1) map a shared hugetlb area, write fault all pages, unmap area
   Do this in a continuous loop to measure faults per second
2) map a shared hugetlb area, write fault a few pages, fork and exit
   Do this in a continuous loop to measure forks per second
These programs were run on a 48 CPU VM with 320GB memory.  The shared
mapping size was 250GB.  Changing the locking scheme results in a significant
performance benefit.

next-20220629 (unmodified)
==========================
fork program (forks per second)
-------------------------------
instances	min		max		avg
1		3546.404513	3546.404513	3546.4
24		577.559827	583.790154	581.428

faulting program (faults per second)
------------------------------------
instances	min		max		avg
1		491608.876328	491608.876328	491609
24		74535.644215	84787.975212	75485.1

combine forking and faulting
----------------------------
instances	min		max		avg
24		445.067848	451.480526	448.606		(forks)
24		2119.829757	2215.549965	2144.06		(faults)

next-20220629 (revert i_mmap_sema locking)
==========================================
fork program (forks per second)
-------------------------------
instances	min		max		avg
1		3494.161969	3494.161969	3494.16
24		736.786700	744.573732	739.105

faulting program (faults per second)
------------------------------------
instances	min		max		avg
1		495692.786855	495692.786855	495693
24		94290.781748	96456.033087	95231.3

combine forking and faulting
----------------------------
instances	min		max		avg
24		74.797786	77.671360	76.0802		(forks)
24		82633.819315	83689.377936	83110.8		(faults)

next-20220629 (vma sema locking, this series)
=============================================
fork program (forks per second)
-------------------------------
instances	min		max		avg
1		3467.288792	3467.28879	3467.29
24		660.194795	669.520649	663.257

faulting program (faults per second)
------------------------------------
instances	min		max		avg
1		477994.366435	477994.366435	477994
24		89544.336665	91933.002686	90512.1

combine forking and faulting
----------------------------
instances	min		max		avg
24		149.437608	152.865862	151.34		(forks)
24		65078.863949	66276.888544	65596.6		(faults)

Just looking at the combined numbers:
	i_mmap_rwsem		No locking		vma locking
        ------------		----------		-----------
forks	448			76			151
faults	2144			83110			65596

Patches 1 and 2 of this series revert c0d0381ade79 and 87bf91d39bb5 which
depends on c0d0381ade79.  Acquisition of i_mmap_rwsem is still required in
the fault path to establish pmd sharing, so this is moved back to
huge_pmd_share.  With c0d0381ade79 reverted, this race is exposed:

Faulting thread                                 Unsharing thread
...                                                  ...
ptep = huge_pte_offset()
      or
ptep = huge_pte_alloc()
...
                                                i_mmap_lock_write
                                                lock page table
ptep invalid   <------------------------        huge_pmd_unshare()
Could be in a previously                        unlock_page_table
sharing process or worse                        i_mmap_unlock_write
...
ptl = huge_pte_lock(ptep)
get/update pte
set_pte_at(pte, ptep)

Reverting 87bf91d39bb5 exposes races in page fault/file truncation.
Patches 3 and 4 of this series address those races.  This requires
using the hugetlb fault mutexes for more coordination between the fault
code and file page removal.

Patches 5 - 7 add infrastructure for a new vma based rw semaphore that
will be used for pmd sharing synchronization.  The idea is that this
semaphore will be held in read mode for the duration of fault processing,
and held in write mode for unmap operations which may call huge_pmd_unshare.
Acquiring i_mmap_rwsem is also still required to synchronize huge pmd
sharing.  However it is only required in the fault path when setting up
sharing, and will be acquired in huge_pmd_share().

Patch 8 makes use of this new vma lock.  Unfortunately, the fault code
and truncate/hole punch code would naturally take locks in the opposite
order which could lead to deadlock.  Since the performance of page faults
is more important, the truncation/hole punch code is modified to back
out and take locks in the correct order if necessary.

[1] https://lore.kernel.org/linux-mm/43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org/
[2] https://lore.kernel.org/lkml/20200622005551.GK5535@shao2-debian/
[3] https://lore.kernel.org/linux-mm/20200706202615.32111-1-mike.kravetz@oracle.com/

Mike Kravetz (8):
  hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
  hugetlbfs: revert use i_mmap_rwsem for more pmd sharing
    synchronization
  hugetlbfs: move routine remove_huge_page to hugetlb.c
  hugetlbfs: catch and handle truncate racing with page faults
  hugetlb: rename vma_shareable() and refactor code
  hugetlb: add vma based lock for pmd sharing synchronization
  hugetlb: create hugetlb_unmap_file_folio to unmap single file folio
  hugetlb: use new vma_lock for pmd sharing synchronization

 fs/hugetlbfs/inode.c    | 283 +++++++++++++++++++++++++----------
 include/linux/hugetlb.h |  39 ++++-
 kernel/fork.c           |   6 +-
 mm/hugetlb.c            | 321 ++++++++++++++++++++++++++++++----------
 mm/memory.c             |   2 +
 mm/rmap.c               | 113 ++++++++------
 mm/userfaultfd.c        |  14 +-
 7 files changed, 561 insertions(+), 217 deletions(-)

-- 
2.35.3

