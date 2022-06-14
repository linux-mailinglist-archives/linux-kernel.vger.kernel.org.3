Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC554A616
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354085AbiFNCVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354940AbiFNCPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:15:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF02A3D1D8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:09:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E0sSH1004107;
        Tue, 14 Jun 2022 02:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=pdJO+aEpYLGXObleIHLgCdwuzE+ycCfmRuAl0qOGuIs=;
 b=O9XCXGAGmLiV15l/RATVBFB0cahPjPDLsr4zotHJKwcJ9EJ7Cnbi9utmhQlRhVvcgbnd
 v173Ut7J8dr2SrUYGUK4DWB58FP9aV6tMiimgnMnEBOwnF8gncSXYp3XqYzfguCi5ItV
 T4MFHmZCZ6dzWRAkC55l2ohqzcDBqfKWvTP2kYhyI1paps2r9rDWXB/0Rp9Y2NzEkmNR
 6wTinQkk+e9hBF8G+wxZI4LBP5Whtr42bsfaauCLvzggXWj+FVs6nFMzmtHQFPGxPDu2
 5SsfAbr9DPtJLA0hRYGYBng9ZLySKwoVpG+XaNE2v6548H1EFGXGke4RXyJy57SpjSyc Eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2mmu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:08:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E2047c024450;
        Tue, 14 Jun 2022 02:08:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpgyb8b8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwtPu3wIh2cIgAILJ6Uqv5ZO7qrxBi0PrOUuIFXrLU9/Xmg1tz5MqU1I9G37EwCcT6EYAFyzCPtt5PqHHhW/S+i1h4agFy2Wp1FMBCtThcpy2C2MzwOnCs091+cSbI5XaewRZJGv/4gWLKBME4Obz+buLt5JAKhZ8F6yYdHu92YTU2MywGLFn+ZFdZwkatiQA+eYLAw34x8wWyZc/ZGwaX03q57CEBq5aG5XXEFw4/FXOY6g2/jR1HUklWlFcd3qYavDdreKUfoJGfcbo1MQdkFnTJfQqcgL+ekhYYi55s1rEOQKlvd8rsfLQvSKgf3TNgUjoLkIxwJv59FxEdHNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdJO+aEpYLGXObleIHLgCdwuzE+ycCfmRuAl0qOGuIs=;
 b=Rke47yKrCdLrt5Xwjmvjn37kOlRUSxqyrUynuYhvOjFS5T07yBEH7qA6+mMJJ374SOjGnURmu/9UiiHd/1SBHCBNDkGX0ktVVfzFDMkWZTRGvsGmD+xlQlCqaDJeg9nNYBTWiBM5A15NIZaZnSpEj34U1ImvrKT/pSuMGNiAq5nZKv2LnSdpZt3tSRxlP/Y1JJTrrjaP04yEIpgZrc4+fweWI/Ds1Jy70B9jt6W1k3y+FyqhRgIlrTT+RDnvWQDN3sxzapWq2ZCPdALY4m5w1Ck0C45T19DMqSwaHsyTFpCbzAgaNR3scs/yUXSWglFNjlD6FCEboxRXTPHKAKluIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdJO+aEpYLGXObleIHLgCdwuzE+ycCfmRuAl0qOGuIs=;
 b=RGggxtt5zV3mXmNwP7PJYrAzJ5aNZOww1Qko4LMtaIsYFKMRau+p2VTWwV+QkY1uvlmvcGRhGC8HN+I99CvWRMvmYNJlxtNJzaoOgCX5K8APPqAOjuoozfRsPTSeTPkrsCoMat4pcz1gHzd72c7COktFyG7Yiq1Laau46lKPIDs=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR1001MB2398.namprd10.prod.outlook.com (2603:10b6:301:2f::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 02:08:52 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 02:08:52 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] kernfs: make ->attr.open RCU protected.
Date:   Tue, 14 Jun 2022 12:08:36 +1000
Message-Id: <20220614020840.546013-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7323eb99-36b4-4e1d-03de-08da4daad3ff
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB239856EC7D81C6BCE7B13451B0AA9@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CH5nasul88SpZ4ihXUhMzJlmO8bDnfENDVNsT4XVcnHsh1j3e+K6E2Hrz+kPs4/y5YoeYrQCeHr7t1pIJZi9O7P5W5XF3H6yOO6fjs+rscSzLwA7XkMO4vQg3ns3LUses9arQdhdksNx/JhqfaIgaAWp8I4yTkUr3PsdrJhBRjP2p8pTN1N4ad3uchVMstPC4P6aL01XEhXmffSy2TkJsdHEN/LAeEOVP7eunV4OFITzsJUeu5+0Kssb1vD/vkvlm95r1rn+MfIo7/kFZZUYhMCy05m27HEujoJiGWablo7kfK4lHPiD9H2kKqJ0i8GLH2NjqWq2FSahTxpNqIX9/+0suKvjxlIC8QFnJjJGCK9oOLpAjkj9zIeHjuYgj2WIILoVj4LX3EClMrKKYH+vGVTOzJi/1tUiY+Q4Ez/T6+bB832ywGE4NhNz2C8sUHaGFH1fOzyKUY64ySkkCkWXfZ3FCfVxUPZSw9Ku1aqz9nYy1k4fHpSVaXRgS9qQ+bS3qkaeiS75xD4m4aQnefPxU01m6blyj/A5vhUdwectYJOSYuWtc3KozVW81HSBImRpBArWqqb+TfLgFFH+kU32L99MtJ2ven3NIT00f7DB08rOf1qpaXdVVyje5+5q3mxkw1pymfJ+0W9wb/SXOXQZe0uDD5DcLWUwkKNJKWfKRGAb22QWcyHG8DWLuRD7SNgNPPOl8y9Ovu1Y0xAtjAFQbYKsYYA2Bd5s2upVrOyiutUBgwiDFd8J9TjeJ+26CwkztJa9CAEjFDg0EFCaTC2lylYWyWE730E1JrEQnUQqoO6u51YwwwG58fCrPCGjPzz4g76NeKGDR58VCZkNNQ1XC11E68FrURarVKiuPFRiyBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(66946007)(1076003)(66476007)(8676002)(4326008)(186003)(5660300002)(2616005)(36756003)(52116002)(6506007)(6666004)(83380400001)(8936002)(26005)(6512007)(86362001)(103116003)(2906002)(966005)(38350700002)(6486002)(38100700002)(316002)(508600001)(87590200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8AZmKWKYP31P3dzPbuXncJkQL8WIQugF+jEsm4PkbH5PkOmOlSVWrJ4GVWsq?=
 =?us-ascii?Q?nPkMseDZW/cZe7+zBNQcqrHHYCawloKjWoQhLHKIf+idiXSzSkSzUZ6UNQsf?=
 =?us-ascii?Q?uVV1ZQmylLztUTgjxMfZ8SOpNoEd/RsBY9Lz3vlIEMYahNPJNcRYl2TIRAJN?=
 =?us-ascii?Q?PoX4M8uSwX4egnKXrlb51d0bCpWsYYOYmqs1Np54Fu6ExdGOiXuqANfuAdQo?=
 =?us-ascii?Q?LXwl0FJ3GMTZghx0vZlG2NrPOouGOwQzFlDDEriucbRoHvC4lx0PTYRsFJpF?=
 =?us-ascii?Q?S1JIlDvyKX/obICs86CtOgsNSqM3G+kuiavqXt1skvKCeNhB+ShwUXTcIqEP?=
 =?us-ascii?Q?GZzIQFQfWjjNIt24z1P8GxddFz2C3YNTFeqWwVbc4y2yPzkc339M3c4Q3nna?=
 =?us-ascii?Q?LX0r0ob+nyDHO+/aWK5mD55qWm7R7Xz/PqtqCj6fNa/S8ev7lGmMebqDTi3r?=
 =?us-ascii?Q?YwEOcpO7xoHREsFZEo4c/I73GSbZLouLU5tS5e5oBorG++oNwe70DbeCV1vf?=
 =?us-ascii?Q?OZwvygRakvLrMckAESbgt9Q6BtxzvtYr3nQ7ohefKPm8A0wO9xT7JXwAdvXh?=
 =?us-ascii?Q?EaLV0iKdZgntrdIiijvCkdzSEQ2EYhAEyZnIi+YekSu1g5aq5m5rQ2ThsA9d?=
 =?us-ascii?Q?c9tc+KUmPzvo3PWkpoZ4+LPWqSEwRkTfLhrGD7EEGBM63Xt22TCdm/Ebj7M2?=
 =?us-ascii?Q?G1fA5TfAsG0KNVw8LUkJ5GK6do9iEC8e0KyKuhpJQtifPHRHXX8wV4bfaach?=
 =?us-ascii?Q?cHR3rAgOT/IiCqvGIozpqtBJYmZ4PmtGYPCRN+GQy4wRvgf7hhtqeVXFrIcc?=
 =?us-ascii?Q?hlet9WGDPqO2CmLow71OblPBoP/o+r/CrttzcOd7pr+Avyk7gPHhFZ2FNGKN?=
 =?us-ascii?Q?hKhvAY443+ms9nkX+7kk1RDYKGTNWeftjhJYXCRIrjcQaeRtRjQLBSPOoj6l?=
 =?us-ascii?Q?1pOnReeXm3/8oGgZKefL3VRgMZ5xVSUtrBilg8NIvDd7y4vNzP/j50kEtcxd?=
 =?us-ascii?Q?PKrxxShqE40BdXqhSNZW5d+6HrFSNYVrYdQFUkHvKvJTECoN2pWsoK8H0qid?=
 =?us-ascii?Q?eJrtRoBJaag9Y70lalu4AGeueMeQg9Du8tRCJwhXWGI4uMwJH0kUqbaOEOL2?=
 =?us-ascii?Q?4ah2uXdltv77qFQpPqe8xB63QVVGNtKp+L8UTNd1BiNEXXCe83Fm+4/vlBoQ?=
 =?us-ascii?Q?muCh2WP57lKqATlitI5eoj8mggKi2fBz6qDAbgxVKk88b3gBObyel7M4bLnp?=
 =?us-ascii?Q?uZFxlHC/2fErtIi1qSJsihUay2k89J6dVMmc0pfT62E0/kWRCH1cxprrteeY?=
 =?us-ascii?Q?FEwKdfRX0cv6PSOO9YU6YaXbcLMkCpuPC6FakoMwEbDUfRzw0Qc0CoghkTye?=
 =?us-ascii?Q?VrnQEGf3nvtqVUZYi/gTGqOIGck7w5b1CSFV4WA71usi+kq1d9Zz78RAYDXl?=
 =?us-ascii?Q?oA8aDqcrZdgD+6ek0diPjJssBMEDEX53j/sm2RU/Adig6yYZhVe5KC1HRuPO?=
 =?us-ascii?Q?9/YXnqKUvpZBnS4r0msIc86LfMSAZKOeoyy0PPD/PEaCSAeaGQi0W0En6BOd?=
 =?us-ascii?Q?wlDjrnSmRqqkoVudZMBH8lyqAaJ8qO/vcc/LQZcDU/99XJ22EFrqmX/AG7Uw?=
 =?us-ascii?Q?4kU5+5QSMIX1ED2gwH9q7rwwI+BNFJEfF5YASyoDHsQbhokwzpJrEd8A3wBT?=
 =?us-ascii?Q?ZYZLngwviEU+1J9hZoifbxdFSYd5Je1Nb4/J76e3qmDH7qJBXWW+SOesSwem?=
 =?us-ascii?Q?Nt650EBk1nc6fqj6SXnMWrudiqh7P2U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7323eb99-36b4-4e1d-03de-08da4daad3ff
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 02:08:52.3768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69j+ecsQXclA4oOFMDjyjneFaofO5SAlXfTmOUyKljx8bn6x1yDTGF7PNeJvmw9DQ3nF3dZ+2OO8G5aw8VH+VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140007
X-Proofpoint-GUID: -2I6IvOPu7GpV3O15ODyjL4RJ4BcIeCn
X-Proofpoint-ORIG-GUID: -2I6IvOPu7GpV3O15ODyjL4RJ4BcIeCn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches in this version of the patch set are as follows:

PATCH-1: Make kernfs_open_node->attr.open RCU protected.

PATCH-2: Change kernfs_notify_list to llist.

PATCH-3: Introduce interface to access kernfs_open_file_mutex.

PATCH-4: Replace global kernfs_open_file_mutex with hashed mutexes.

Changes since v4:
 - Rebase on tag next-20220610
 - Use one helper for all ->attr.open dereferencing.

Changes since v3:
 - Rebase on tag next-20220601
 - Rename RCU access related helpers and update their description
 - Address errors reported by kernel test robot
 - Include Acked-by tags from Tejun for the acked patches (PATCH-2,3,4)

Changes since v2:
 - Rebase on tag next-20220510
 - Remove PATCH-1 of v2 because it is present in tag next-20220510
 - Include Acked-by tags from Tejun for the acked patches (PATCH-2 and PATCH-3)


Cover letter for v2:
--------------------------------------------------------------------------

I have not yet received any feedback about v1 of this patchset [2] but
in the meantime an old version of first patch from [3] has been integrated in
linux-next. Functionally first patch in both [2] and [3] are identical.
It's just that [2] has renamed one of the functions to better reflect the fact
that we are no longer using reference counting for kernfs_open_node.

In this version, I have just modified first patch of v1 so that we use the
modified function name as done in [2] and avoid those parts that are already
present in linux-next now. The remaining 4 patches (PATCH-2 to PATCH-5) are
identical in both v1 and v2 albeit v2 has been rebased on tag next-20220503.

Changes since v1:
 - Rebase on tag next-20220503

[2]: https://lore.kernel.org/lkml/20220428055431.3826852-1-imran.f.khan@oracle.com/
[3]: https://lore.kernel.org/lkml/20220324103040.584491-1-imran.f.khan@oracle.com/

Original cover letter
-------------------------------------------------------

This patchset contains subset of patches (after addressing review comments)
discussed at [1]. Since [1] is replacing multiple global locks and since
each of these locks can be removed independently, it was decided that we
should make these changes in parts i.e first get one set of optimizations
integrated and then work on top of those further.

The patches in this change set introduce following changes:

PATCH-1: Remove reference counting for kernfs_open_node.

PATCH-2: Make kernfs_open_node->attr.open RCU protected.

PATCH-3: Change kernfs_notify_list to llist.

PATCH-4: Introduce interface to access kernfs_open_file_mutex.

PATCH-5: Replace global kernfs_open_file_mutex with hashed mutexes.

[1] https://lore.kernel.org/lkml/YmLfxHcekrr89IFl@slm.duckdns.org/

----------------------------------------------------------------

Imran Khan (4):
  kernfs: make ->attr.open RCU protected.
  kernfs: Change kernfs_notify_list to llist.
  kernfs: Introduce interface to access global kernfs_open_file_mutex.
  kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.

 fs/kernfs/file.c            | 240 ++++++++++++++++++++++--------------
 fs/kernfs/kernfs-internal.h |   4 +
 fs/kernfs/mount.c           |  19 +++
 include/linux/kernfs.h      |  61 ++++++++-
 4 files changed, 228 insertions(+), 96 deletions(-)


base-commit: 6d0c806803170f120f8cb97b321de7bd89d3a791
-- 
2.30.2

