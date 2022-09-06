Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9FD5AF20C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiIFRKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbiIFRIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:08:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4463E8307F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:56:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286GOLsB026211;
        Tue, 6 Sep 2022 16:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=FHUJ5c6qobDQzw9o+7BujyTo21oQRmHlq2cMfmtHXnY=;
 b=ijEwZjXRjzn9Sk7h7sqbU91sOpKwF9TP7FIWYCTCQjLN+yHnIeVE1xUQHPbClxCb+Xr+
 JyK5ukW8lS2qgnwNn42Lz7k3y8P/+zOMQquEyDb2jNmJxECkWZNCp+tg3MgB92SDJxQL
 xzL06Zl6ZfeSYMB/oWFwSgZJYIv0kV3iHA38rZg7syAB/lvLbiq2YlRY6lLBF92XtWt0
 FBEjoI1eyU0W7BV7dfMnFfXsVtHABErkWHrzIj3ePVsyrwxu6pS3ZCt/X0Sj6EY94sHw
 tWMmDFr9ITdt8zTy638B5pxC0yyQgB7z0lvCrmVQ0FRL99sIcAeX/UhlFFFaj+OnAfJx Eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpds3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286GcibF027583;
        Tue, 6 Sep 2022 16:55:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9e3kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCoM2zIJ/cAsGkx5SwgjHfVV12pP+eE1qGMC1F7T9QHtVlVwKWaqr+0glee/z/HmZnWHVQ9RPp5r3lljc6wXGaE55YcfF8S7MIoz38s7wqN9USmuYwnXgtRy3rjauMiG69BpkY/55s9/CWBx2ZdZ/iyOod7c6pZKOhDkzdoNykXT63MT9s8XwnFU/Sg7IcAq9/CyWTeWCbWF/AocUuFFoCDNhbUQbxbh1RnUcsR42sO+kJQSiDEtCowtQAW5dLDdZXj708fYbbobsP/WIEYsdw88vw+SoO4yGLKP/S20BJqMRBihVpd1VQyCRSl7RFKaXYfWDWMit1DbV6tiaWi02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHUJ5c6qobDQzw9o+7BujyTo21oQRmHlq2cMfmtHXnY=;
 b=S+SHY7iVAfCTEaZTNpA/r55fznBZbSey/CyNu725hmDu6miU+9x9F1MoBgAk5ITxusKIVqyJUqJxQjMCIZmtYyT3ptLnfIipLPxkxf1Q/OYkUQfV05PS9XPBQPlWfE2WammhZlhvkifxtoBNog6mCRpbillDjdbjK57V6YA/NwWmC7Uwh6qHSOnDj4EhF2Sd/zns1S4dNNG3bjXuNItcklOZlLrjuN5ig4jXiYxrCzLTLTCKvbKJLzUC9MfNwU+2UZ2Gb7YpSY5PfjOBTNtrIsu62yFZ81PwgSgL3Mb4OUbTkFSj8DBxSQ0/OeqDXEWGMc0/DpPvPrIRaItM0g5ZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHUJ5c6qobDQzw9o+7BujyTo21oQRmHlq2cMfmtHXnY=;
 b=JJxF3y2iJ/2FNHS/bimSFZPn+EPmyq6qGnkXA4w5hhMIlrw6+TaoKfcxEAtsc4kd2UJv43ig44nH3Nu27HE5N0FAuWxpEMuHiFnK2fdbcYzT7P4xFbFLC2OwS6ig9N0lD1njHfn46L2Obr5nF+4c6cdXerCuBi3yQEBofRzs7Go=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 16:55:23 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 16:55:23 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 0/6] begin converting hugetlb code to folios
Date:   Tue,  6 Sep 2022 09:54:39 -0700
Message-Id: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1be39233-3c08-4272-5a2a-08da902896fc
X-MS-TrafficTypeDiagnostic: BN0PR10MB5078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bkmb+veiZu5QpagKSZ1r210fV9aenxZ6UrPoXgsDwBEsX6aUMKPIE1VpzawlaAqk/fbX8Z4pPs0XHsRG6lQME9pE40QgL/VyIuh9irf2A6PpiDJxLcw9vmL5o4sgpD2FnKptMjMXUy/N8VE5XQIRJEMZlmlHr3Xh5VuWPBYUpaqj/G2mfFeKa2vGPEqx+fLB6X/cnJvCsj7a2DIfslB01sHBxcfb4qvRbNrb3xuGGoIb1HEEuz+N2KvUy3HSek6Dh90MYWv7XephRDHF63g6tKhaFYDN7JTJPeCAe8QnKRZezVFb3C7YhkAzErZBE/CC7eOcKnleyX5U3ES9GeWLU2naDTMnjeA6iI39fiiDSxfCxj7tuu8OyfrF6NveL8+y5MllLK8q3Zuc3vML+wey/P6ZRWmR/NphYQsaWL/WdK2IYNlSDoiT0yt+yQYz983ILSmIMShCLXifEGySRARSNBxHcfeCSk4X5ppMYPW8sJDDfRPf+KLcF3wVIPM5rcFd9b4JLasKV5nqXEKimzpIH4B8DY/p+k3CoRsKlXJ2mJmbKpgYliNformnyynoWBmvkIKQM4wHOGxYZEWlOXxuGGTEYupgk5Iuj54JgdpNGAmJzr1csIw1uH+VdIZIiL+CQKr9TX6GBwSU0K23uvyPdQ0rBzNIoJifeKiUmuh3c7uTIJc0vtGPT1C64WCJ4f+coPj/9tGoqFxjpibE+9C9Ogqs4os0EFoDLX3bGzE+wbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(186003)(1076003)(7416002)(8936002)(83380400001)(2616005)(44832011)(5660300002)(2906002)(26005)(41300700001)(6666004)(107886003)(6512007)(36756003)(6506007)(86362001)(6486002)(966005)(478600001)(38100700002)(4326008)(8676002)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eixTvHbKwYA+Oj+hHWaRsMa+5XPyNdkS/Q5DJM9AgT7Ry3+dDMOVFtrMXZTc?=
 =?us-ascii?Q?+nj6fsz9rkFuqVDTt9uDEx/sjT7bEO3fD8dz66Z1tfl8U92Qj/ORe7EDEq+z?=
 =?us-ascii?Q?QlAtLPeqrtYkQdH9/jAWhKXz4BjGRXtTl/LYxySqT2nlsj83fNqKl5m51V9F?=
 =?us-ascii?Q?nd42ALyvjRku3DD4uNcwpiLNhBizLe8/hgThkenG5qSMI1Zi7W3INnQpE0Vi?=
 =?us-ascii?Q?+692v2IzEnCRGV7xYpME0vesnCFEuD92b9dtnJCiIEBILm0piX5voGQEYYfb?=
 =?us-ascii?Q?s6wzdQ7J8WH2LFo0dquY7SWKPqdldDpAzJzFjgITpZxj2zF/iy3spjmaA7Ou?=
 =?us-ascii?Q?yYgway7hZmzXDQK3tQABjiP1KO6crjSfWhm2UXkHyGPKrGN4OvsNIFY79mCx?=
 =?us-ascii?Q?wqaW2y5hQMbXgIvbKK+gwl/+pM4g5Ic7+7B4OHyw4ozzl+gy+Eqvg17JffVT?=
 =?us-ascii?Q?EFjd68UvsoFi9kf26ti6LpcB3PsEOrX6hyabFF8GBGkWKN1BUw7xsUSMe3L7?=
 =?us-ascii?Q?Tcf4YHdoS6L9DdzurI5BjimgGIpdiAIbaPDCwAwzTsOcy6AUZ/2Al5zrGcS6?=
 =?us-ascii?Q?ycNT6NlKQvBb50fQ4cHrOVXmAThBtOF3UUfM/j7fuVdKhkiT0uPcfzsLZ6Mn?=
 =?us-ascii?Q?7+yI9AeAkgqHx57D/JUlLvJ6690FXN5Qa8uNgAjHprAqiowKxwcHniMSMWqL?=
 =?us-ascii?Q?LI8aDcWKldEPv+kO1XKqCuRZnf286TRYBsVKp3+fMonVuIDNqOS1/ceOtBRL?=
 =?us-ascii?Q?WXGAujUDlUkCsfPkIa4lUmL8pc2BBIl+wjsfgjUrakB6zhAWU8ef03wP+l0h?=
 =?us-ascii?Q?FzuhDmLDolSxnrD6Tr+EOWjeD13f5qhS5WLx20RWF5IbufWgyZ8cHkv5ps+D?=
 =?us-ascii?Q?wdauwz+0t/+t/b+qPLeOfdu+OjJNZ/el/aaRIrRykvHA+WnNBe8gXowElJLA?=
 =?us-ascii?Q?XYoHrQ+JL5cvcaTGtGO0rSY0ASjgMkGjYlLqslt6v2dx7PFzrdmtrxG828jR?=
 =?us-ascii?Q?T4tmYaVTdFsKqjSotpb0TdORkia5LReW440GxCKLsq9RLMi2P9ycNU9x/ppQ?=
 =?us-ascii?Q?d7wq80L5gluZwuGGNNScyF02U/FJAiidrs8Rsk/0yFEdSUaxy72/eDkOMh+i?=
 =?us-ascii?Q?HQOtqJFTAYwPG6XzZnb4D5Vbb8sthzrl7AvIle5VDThiXMJnEsk8QmVayHu9?=
 =?us-ascii?Q?Y5ffngRuYve1dx6t9z5A6uEKbjobtwybI6b6guKJTLBTGHYNZo9nG7zdKY8G?=
 =?us-ascii?Q?jjECbbeOK6Os04P5mduwesBId/IxZFAiuV9mMvcTt+63KuGAmi7buOHxPvh3?=
 =?us-ascii?Q?nyQ9bthzoK+DMPHOnzmz4TWoGAtgIjA7NSoABxvi62NepzX2oNIa7Q/3EXrG?=
 =?us-ascii?Q?+ZGT0wH8uvla4WWV8MLMcLyCdnomWMVo460bAncXmmLQ6aEOhA9jPrAxUwpv?=
 =?us-ascii?Q?lcI4BvaxdtUrLRm/24h7ir+If3t5J5/sG7yPX60oVz58UBXviZTtSdRUNDup?=
 =?us-ascii?Q?BMZinIn4gFFDPTAgv8dXOLtr1Gi+oACbQbE7t/srjlg+rlHzD1xX3NmWFeiY?=
 =?us-ascii?Q?dEl0526U9BvQDlkeLhSPbCM64gbS3XYZdMRZQWPWzinabDqof/ZLi8XAOaeb?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be39233-3c08-4272-5a2a-08da902896fc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 16:55:23.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olpOxFF+hw+YbzAzLp7avKWQbJaHUkuB1xRC9zjlfapetmZwyPMA6ymGhjZDy7BiiZSeGoIlhO0DXu94khYw4Hee1IJ7DmKl4hEtvDKYq3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=648 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060078
X-Proofpoint-ORIG-GUID: mlOM9dhQjJVpecAp9u7-ULlm6zUzjBkP
X-Proofpoint-GUID: mlOM9dhQjJVpecAp9u7-ULlm6zUzjBkP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series starts the conversion of the hugetlb code to operate
on struct folios rather than struct pages. This removes the ambiguitiy
of whether functions are operating on head pages, tail pages of compound
pages, or base pages. 

This series passes the linux test project hugetlb test cases.

Patch 1 adds hugeltb specific page macros that can operate on folios.

Patch 2 adds the private field of the first tail page to struct page.
For 32-bit, _private_1 alinging with page[1].private was confirmed by
using pahole. This patch depends on Matthew Wilcox's patch mm: Add the first tail
page to struct folio[1]:

Patchs 3-4 introduce hugetlb subpool helper functions which operate on
struct folios. These patches were tested using the hugepage-mmap.c
selftest along with the migratepages command.

Patch 5 converts hugetlb_delete_from_page_cache() to use folios. This
patch depends on Mike Kravetz's patch: hugetlb: rename remove_huge_page
to hugetlb_delete_from_page_cache[2].

Patch 6 adds a folio_hstate() function to get hstate information from a
folio and adds a user of folio_hstate().

Bpftrace was used to track time spent in the free_huge_pages function
during the ltp test cases as it is a caller of the hugetlb subpool
functions. From the histogram, the performance is similar before and
after the patch series. 

Time spent in 'free_huge_page'

6.0.0-rc2.master.20220823
@nsecs:
[256, 512)         14770 |@@@@@@@@@@@@@@@@@@@@@@@@@@@
			 |@@@@@@@@@@@@@@@@@@@@@@@@@			      |
[512, 1K)            155 |                                                    |
[1K, 2K)             169 |                                                    |
[2K, 4K)              50 |                                                    |
[4K, 8K)              14 |                                                    |
[8K, 16K)              3 |                                                    |
[16K, 32K)             3 |                                                    |


6.0.0-rc2.master.20220823 + patch series
@nsecs:
[256, 512)         13678 |@@@@@@@@@@@@@@@@@@@@@@@@@@@			      |
			 |@@@@@@@@@@@@@@@@@@@@@@@@@			      |
[512, 1K)            142 |                                                    |
[1K, 2K)             199 |                                                    |
[2K, 4K)              44 |                                                    |
[4K, 8K)              13 |                                                    |
[8K, 16K)              4 |                                                    |
[16K, 32K)             1 |                                                    |

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/f0a284d27efbfcc1a46c2a6075a259e628ad29c0
[2] https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/e829be3202116d9aeb94cc1ff64e89dcbf7c47d3

v1 --> v2:
- test compiling on i386.
- change return type from int to bool in patch 1
- move _private_1 field in struct page to within a CONFIG_64BIT block in patch 2
- squash patch 7 from v1 into patch 6

Sidhartha Kumar (6):
	mm/hugetlb: add folio support to hugetlb specific flag macros
	mm: add private field of first tail to struct page and struct folio
	mm/hugetlb: add hugetlb_folio_subpool() helper
	mm/hugetlb: add hugetlb_set_folio_subpool() helper
	hugetlbfs: convert hugetlb_delete_from_page_cache() to use folios
	mm/hugetlb add folio_hstate()

 fs/hugetlbfs/inode.c     | 22 +++++++++---------
 include/linux/hugetlb.h  | 48 ++++++++++++++++++++++++++++++++++++----
 include/linux/mm_types.h | 14 ++++++++++++
 mm/migrate.c             |  2 +-
 4 files changed, 70 insertions(+), 16 deletions(-)

-- 
2.31.1

