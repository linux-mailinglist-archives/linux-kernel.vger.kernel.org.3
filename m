Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E537D536913
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355106AbiE0W7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353186AbiE0W72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:59:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC3E13327E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:59:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RKa7a7031976;
        Fri, 27 May 2022 22:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Hv1f9nzRIRgOjLnyq76u1nwHP098Cmk1ys2Z+2fIVT4=;
 b=YOw7dWP7X6dNQJibHzKysbzBETuHUJjuPkWuQJQZ1XySh06S/lUEpydGU0SgZ9NUFtAl
 Sj29XV+u7POBehkH9FMIw7AEBE51GGO8KgeLCYG+mP0RlOcQWy1fHT+7S/AJNtwWTb7W
 /80+167PZlfdgp7KlR/EB5xSqVtv9+ID+fRFEYJe+KdekNgKE1/EUMvpedQC9oP7RfmE
 UZFNOI2wVErRbSUi0t6GlqROafwLgJglBaHuFb0L2xf6C7kGLjNxmiJ/yP3qVqqL4tpi
 uwPgxAxpvl4WoEgxb92j1UtW4L1OurQskQ/UXGoEk9yjMSz9ODIcvYUly4VPU4DpVBsJ ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tc0bun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 22:59:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RMoWma015163;
        Fri, 27 May 2022 22:59:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93x2xs7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 22:59:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdC1i8SaXSkGFKe8JuPbsEuwDc1TxbeXf6h+iuxmU/BL7N/DBpL5eqRClmYfeA3edr0/Oi8+Pq5v62oz4217Fja3MG1ITZZpQbZtwXvt3Jd6D5vah+tE2ftVqymi+ebjOzsZhommai4PEhHlfQvJl+XuEObiyRfWU98jXvuAHZmhg+oxtnJjl3alBndsbZEoL8sADE7xarN1wna1vMB8lc9zOBsf5l28piuGJkzjrVFZgk8nadWaHyZo211T8EQ1Szk/QZabdDkmSfXRAoz5aEvHiBYD+eTS6F+BwUOouizQO6NTnCccRWOoT8mB+AulF2eSZgDnHR6ovZiygjayEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv1f9nzRIRgOjLnyq76u1nwHP098Cmk1ys2Z+2fIVT4=;
 b=J41YajpuuMK2MSjaATMt+SEtsmT036z100Z+jSjP8buin4iygWIJV581UqDM9O/9HlomMIulCUsSKY+G563J/TCR2htt7tgSak+kuNYR8f2vPfqFkQMrktOFjbmeJEy9TmTptQoD2+HHn08LCrHEGbPog0Kn8wP+sQClRUZhPxTfxbJ6ChCAzfU1Q+SgsYPt23QUphRyYv/+uEHX+fGe4NWEZ9Ioh7RO324yDQsWplaMu9XQDtzMETgB43zoP6IIQ4E/H7Z+lZHhAPjtRTSTLN5zIkOIcWmR+jVRdR4lVRtQL/uGFJoU+RZf0Aq/wNBB6tBuQO/dEUY8rpFI6aH/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv1f9nzRIRgOjLnyq76u1nwHP098Cmk1ys2Z+2fIVT4=;
 b=xKZlk2rZG8wf1u2nxc7Klz5smKIc5JR2csBSJJ7fT65cDzeA/l3e0FQ/e1AB3neGnYD6Vf1suVfIdSAT8LmhthdTi2h62jpOtykNVz26b/BxPoS3TddKqtCVHcnBl5kqNHafilT2IrRpNQ/fF06mVm0SHHmHEwWh3hAF17ZTvD0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4831.namprd10.prod.outlook.com (2603:10b6:5:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 22:59:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 22:59:00 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 0/3] hugetlb: speed up linear address scanning
Date:   Fri, 27 May 2022 15:58:46 -0700
Message-Id: <20220527225849.284839-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR17CA0091.namprd17.prod.outlook.com
 (2603:10b6:300:c2::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79cd8584-7775-450d-3a2c-08da40347cb8
X-MS-TrafficTypeDiagnostic: DS7PR10MB4831:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB4831208112387059EFA24619E2D89@DS7PR10MB4831.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVEAY9fWPUodjdgFVLMPpd0JVeznHLSVMFnf+OawRcwdBv/dYUwiF4utM/rGnRXAdvvNGYP8ML0ufXVRKLiFSWQ6dlTOQJEv7D01aP1KSm64wL8gcjJAXDubvyV4aCSS4k1ZKPUzRK5ZHg7+NXSfIrfhk3lU4Azn0W2PiOuTQizDyToY6IXjzOLKDu/EvBmH5JFFnO0iDOdeQCLQSK6TN62lJnjtmZ5PUBfNQXK7SUZ2/WdrH4VfjpDDIfkoHd7pOeFm747P6NdcpgptSs6REPNUY3boxrTAZ9xrJLTeqiIfbu0lntySLJlSCa0qvUc8R1TR2W2qvcf3l4NQyxKO0N7aEjCtveRdJkraRussqsELXzHI8g1f0nzKEJM87DhXK7SFUzOqcxe5J8RbOaa9hZt240HgKoTrFrhhrkFudBFr+0pBuDHSN+TwT6wGdrkHZMaoBI+lc3HwprJcQBcIdM76gF747L2ccYJaJC04PD5Nv6CvZbXIoPVc1qPs26BfBVzHJyOWwqRgPMgJs/SflnWMLRjS4XTHOaZy38Z99JlNCjmrVbPJYjttKA7jf7t1Q35Mc9+CVlv3cB/KN8zVSqCnwddIWGWPNjIEXHXIpDkigIh4dPVfLmwyhXAj3naAlngXpDKhXZco1179tl7EoyiblBBoDd5/VGpRq1tHZyGpW9bvNO1vShR7QyAyrlCUyNsnO0L3OIPA6/jQuIYCzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6506007)(6512007)(6666004)(5660300002)(2906002)(52116002)(508600001)(44832011)(8936002)(316002)(86362001)(66556008)(66476007)(66946007)(4326008)(8676002)(6486002)(4744005)(54906003)(7416002)(36756003)(83380400001)(38100700002)(38350700002)(2616005)(1076003)(107886003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYnPmjwKGOORuDdbUhPifeO5Dm/lRJ7RVOCimQQa0VjG2Sz4ogHb0RDxNQAC?=
 =?us-ascii?Q?6fx/DLFiajYsynXDW1nOzuWfE08T+2+n5zf4LQSNcQ8GGRHghEjexloLDZOt?=
 =?us-ascii?Q?Bzgs1B47aFHxa/aW6Px1EupsyWr0HI6j7JijQeS9vFJJsBQl5hfStYT+hfLd?=
 =?us-ascii?Q?bCVJGJMor+D2cMF9WNUwjRZd9YtPbcr7mTaDxBd8+KBi8VllgSwiEs4vV20r?=
 =?us-ascii?Q?6fhbjgIIfF5v/Y8dgMB+S6EubCv5DyTg3r81d3WVWEgmugQ+/jpgChmXqhQu?=
 =?us-ascii?Q?NprGa8tD0HQ1oFgPVe4m2l2R+Mw8hYgODamq5ECTbQZFBSXOSPTmNW+c6n3P?=
 =?us-ascii?Q?zem5Zcd65kOn/5QxfDFjSamYjZa+7AOldAPuQemnSe/GRXuP86GbX+Uo1BeQ?=
 =?us-ascii?Q?SSgrYUmDh7DUPNftCHDNaDYjpVyvOSkSJsUTqN0Y0HGfYnO8jRGMdmLoL+ad?=
 =?us-ascii?Q?TMJBuEmxDN1FxKNoC7VcbJ7cEMsNNulJ+bNydFZFU0CXJfqhy87MLRhqOCl/?=
 =?us-ascii?Q?u4wL+calr/d5ayjJiJj2YYtwjoxqQfFcYmGgXUK8pEV/e8UTYBCDRdbpRz3m?=
 =?us-ascii?Q?qoeuVgy2ojlkM1n9WcPgBzn5LwEKBvyveNHspXn3niLP8gSKa/n44jAyLyFU?=
 =?us-ascii?Q?iKb8CdewBoSd0wR1uNET5K85Lfg5dP6/+lWIk6bk5Yl7tCcefEKIi7lxcl2n?=
 =?us-ascii?Q?d+vCHOmyzAe37wexC+UO9nHvKlYcfDTM/0bxM0DcADNmpWR4e1xs5wVC/Zrz?=
 =?us-ascii?Q?/lo6eCo+TqhvBr0M3+r4qfWMcpoIZAnUKl2zEpxAJHhAVcgDWHxd4I+tHXhY?=
 =?us-ascii?Q?lwAF4mx3INe4ZffQYYDGzmOr3CQiezXz/Qrq6L3hK8mAZCw/U07/xK8EzWw7?=
 =?us-ascii?Q?0VerBVhsriLTR5huYtyo9JSR+OypLFBmQtQcRllxSz3PXjdE+ZzJjzlGXbp0?=
 =?us-ascii?Q?CHefGX+vkgGxfbn7ajnpr86McQeSL87DsUHTpxEpSlv05QXcjlRihNahO5/R?=
 =?us-ascii?Q?OlyaaYCjWVwROUM5GVyj1RyfcofuWmfRgn6flr/RZxZezoaIkIfB4esE9byM?=
 =?us-ascii?Q?TOCUg/H1WoR2a6lgvU9WgkhWlUODaW5GBdCDlRJ4YU4Q7ip5u0gVmk1S1EsL?=
 =?us-ascii?Q?QQk+m9vzKEvEpUgWI61SZaIk8Y6wlOHhdEvBTPJ6469eGPnwdzS4SFzmYbTu?=
 =?us-ascii?Q?wVr3kNyi6oMzKD1JdpHSSF9eYkHOMSoqZX7rJDgl2oiA2uy/Wen4IBf3YC7M?=
 =?us-ascii?Q?FuoIcPt9M9j0NnH9xVv67N6XZBp9xsPegE73Mfl1IzwqAAVp5o/X/qcpbB7b?=
 =?us-ascii?Q?kyVDnYoLfdcE7B9U+s6qFMU6zFDzFpjCcZEpUmc2s762+luvB+YwaHvCpveQ?=
 =?us-ascii?Q?/j4a9TEedbAA4hh/5ibYTRf+FAcY/G97sEnR62V6qf8rBPl2PHk/qbK2Ew0+?=
 =?us-ascii?Q?XycKKc1l1QGDPJMm8JeCUo0ak5Kz4FY4u2mS7zar16iWspKihlPq5JVw/FWU?=
 =?us-ascii?Q?xnKZQq2B9D/26gpHCzFidTM1RffR/VDLmiYhlehMS8yUPX4psY0s3ga1AkMy?=
 =?us-ascii?Q?7nuMwFRRptbrQSqgrMziE5qAZPTMlayhSLBgGmXDdGCA+Q6KUr+s0XXb3GFa?=
 =?us-ascii?Q?R2ofHyo7Fx8nFjZ8Kz65Fqe+mj/dNtU/5z4/gBjXm9fBKWrdppe/d5haBYhD?=
 =?us-ascii?Q?K+7Nty8S7k+VOU5O4mcHPyz/sx9rTkLgJUSz/sfek2kQBqUkeK4HPBxcZh6y?=
 =?us-ascii?Q?iVAh1rtPlRz9+QXKktnXQQYIIHhmz9w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cd8584-7775-450d-3a2c-08da40347cb8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 22:59:00.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huLo6g7ms2YEIWbJjceFxNOBBGgV4ooh+CVWXW5dws/UMVIHYq2wrbN3fZRwfLI/O0XMQvoWaEnp3fb+Fq2ocA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4831
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_07:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=493
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270111
X-Proofpoint-GUID: ptRljKxhGI6ahLyEaWy5sXmyZbY_rQOK
X-Proofpoint-ORIG-GUID: ptRljKxhGI6ahLyEaWy5sXmyZbY_rQOK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At unmap, fork and remap time hugetlb address ranges are linearly
scanned.  We can optimize these scans if the ranges are sparsely
populated.  Also, enable page table "Lazy copy" for hugetlb at fork.

Mike Kravetz (3):
  hugetlb: skip to end of PT page mapping when pte not present
  hugetlb: do not update address in huge_pmd_unshare
  hugetlb: Lazy page table copies in fork()

 include/linux/hugetlb.h |   5 +-
 mm/hugetlb.c            | 104 ++++++++++++++++++++++++++++------------
 mm/memory.c             |   2 +-
 mm/rmap.c               |   4 +-
 4 files changed, 79 insertions(+), 36 deletions(-)

-- 
2.35.3

