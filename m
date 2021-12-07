Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D42646BFF7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbhLGP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:57:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54856 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239205AbhLGP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:57:19 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FNhdx016355;
        Tue, 7 Dec 2021 15:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=NAXnX1sjao28mvvQL2fFZoaHCIcGO8Y4LXN38zOX/FU=;
 b=lho9c+Ei4lowLApmbhYJirm7NO/QIN/LAwMj/hFGtVApVNLD33uehbfBP7o6f3M1Z0CI
 RnmLzwV4UqrKR506cSyrkW6UjzPJfyJQoMJsfyFegyAvwe2NJ20VvYVV9s8/6VWLswbp
 nH1NEDWv2EzEFuxM0URCP8QfRIsX5A2rZtHmpxGjGvD2skOT5bn9j7FzwfkwqQO7tFW1
 bCxBaoWLK9nO+0+r2e12ifgXyAudTBTS/Ma6RPu/dmx06acXIykiWzuI8V0LzRDhSJbb
 WfXizNOxejt+uN/nwyCG8AZlPDk+Og2UfVLnukBCsuixxkpv23eUj3pc29XCS4kFabSb Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwnsyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 15:53:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7Fofpr152915;
        Tue, 7 Dec 2021 15:53:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3cr1sp60rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 15:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw5HBpAbVl/bsgBsA9460K41QMuRZIuDPkmnUZa6BclBknrcgGnPKdor9Z52M6e3LVRuMz5a3xd4A7aLfjLDgHXy8HvO1XIoN20yK42OkHRHlCgOC/CUd0TTYqjRUPwdaVDFVARrR0UACNN+uGP4H+0qvWGmS1Kvg71pURXvmK96+AeDTrlQekoRm4KzcbkOtNVU85SP+DhuxWVmdJMtpY65gLVap24Z+B/kjlOt3EdXbnt/fDhuPdhWIoLfzZ6DrsNOhWgoosraz5hNTwGgax0IErBRcLQCK/F7J6qWadP3MYnMWF+VWIjtaxzPVv2Z3iNOWt4RuVVVpGQDpDvBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAXnX1sjao28mvvQL2fFZoaHCIcGO8Y4LXN38zOX/FU=;
 b=LFJbSu8CQD11HPkt1GnovYBNmO9uzUTUKG1y/5hQ6oYF6C0/YDSjoTRm7pAAgTGTFWXxWhOxifeN84PJbNtmXhtVqhI+em/MZSxzm55SFTAPhtAmmE9sl4LTAko6HUT9h3Ep/KARqUSx2HPVwN98RtkB9q1438CDocvj5pbehOjsdw/DJD8zO7dPfYV71lNFJR66cNLnvbaydDWeeJdfTDWQpC33g7Pz32U8i/HmTQy97+mfKdDkwiTZ70BeYcveaF1wdriRjJEeUjZPpv60ylE6ojShlV1/GdXmU8NaPtfM0u719sXIerWeEntto/IQJWIcMIaxkXVmMUKjt2+U/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAXnX1sjao28mvvQL2fFZoaHCIcGO8Y4LXN38zOX/FU=;
 b=o4/ij2ydIpNMZKF32XhIvqIMKoG8+f80tlwPr2YlA6eAAiFQt0WioqSwdIlGPlQqQVBIvEE64d3YxofFOkwI6p3QyTUf7FkkVC56A0iQjlXc1TiAWkN7jfORPAV2pOaMB/uUkgZKp2MtcDCtuJJYmiY7bQKVmv4shYqhFNAaByg=
Received: from BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 by BN7PR10MB2467.namprd10.prod.outlook.com (2603:10b6:406:c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 15:53:41 +0000
Received: from BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c]) by BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 15:53:41 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     gregkh@linuxfoundation.org, axboe@kernel.dk, asml.silence@gmail.com
Cc:     george.kennedy@oracle.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Revert "block: add single bio async direct IO helper" to avoid UAF
Date:   Tue,  7 Dec 2021 10:51:40 -0500
Message-Id: <1638892302-14475-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:805:ca::17) To BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8)
MIME-Version: 1.0
Received: from dhcp-10-152-13-169.usdhcp.oraclecorp.com.com (209.17.40.42) by SN6PR16CA0040.namprd16.prod.outlook.com (2603:10b6:805:ca::17) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 15:53:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42ed4f6f-e7c1-421c-e73e-08d9b999bdd6
X-MS-TrafficTypeDiagnostic: BN7PR10MB2467:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB246725B8B18AD4A9485E74D8E66E9@BN7PR10MB2467.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21fdYhWr+csE8k6sopEfOp7CDfiWZEKBsr6bX+rILCpVMKa9N5VcZp/zuV0ve6XbemV7MSA01TH43WfuAksFNFSaZQzzOubKRPqmz+v1xEd8KCA71Qv2tuHKjO00CYdh5dsNkeaZAbUSogJxzlOpHO0F/AGjAquEhWZjjmDVtjSxZo62FrslJ8X02c0ziF3U4z8UsHDNmf37iCOU7LfHbgDCNjVSuJDSxCKQ5qEzdJ7i4QvMmFq/k2OL7ek13GsOjtdqpuUNIwWbN5DOrFhjfIgE8Ljl2YtLda7XzPUHpQDGbC8E0lsDBdMwka+SUJTKFC8m8w7Doej2X3zbAi4HzEAmRyAxgZmFp2S/CTS3vE4zAmjIpkSPbgV0vL1z65p9E5LGf2Txy8v3uDRGk/IBrdOmh3GsJE1E2no7Jtce6FzRVxr8LUp/m9GqwlLG9juoqQjvC2cNNF2hQEh7EqTrX+Ic/9xsq61msMnpwL5may9kpBKMFaiehFTobESVbkER0PzCYUaDeSu31EiBkJXuWNxqmZxItlLQaT5NAM+7STcFAN1rZrEzj8W7UeedCPOs5R9sf0g3kpy601AhTwxNbyUzQdwTDv1k+TcZDdqnxg80m4doyjwiaVIohzVtkGM0R6+5Ez75ykyvU3+y2Irvg2BM2eRL29bomviO/PXLhDCRliP9QV+KGtxKtCqGkCy78bvA8gpHoMmW4rsykKl2ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5192.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(66476007)(186003)(4326008)(6486002)(6512007)(956004)(26005)(83380400001)(4744005)(6506007)(86362001)(52116002)(316002)(2616005)(5660300002)(38100700002)(38350700002)(8936002)(2906002)(36756003)(508600001)(66946007)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HN8VsYGVPLfuNdGG84BYK0S33XNBoqh8m/EqAr5Ch50K/n42dmM4/d6JWT+a?=
 =?us-ascii?Q?OW2hHGLghTECMfacnlufUsQrRS5Y+gTpbo3Vuoivtt02yfXRO7VvkqmRRs5Z?=
 =?us-ascii?Q?oVwtzngn+eOZDf2UjAjIoLe9bVXrtMxv9mhwkSXq1JOgURFjSNk/82d3f7wK?=
 =?us-ascii?Q?SFez47v3tkgOM1cMjfEFUZC1/aVwSLk4ESwU2Z74vq2e7l9a1PTvhuydBxz/?=
 =?us-ascii?Q?iBVYKW63AT1cEXDus5VZu5nFK9loka7nTYmBKFeKf/dZ3kClg6KvMXunJ7M6?=
 =?us-ascii?Q?+9SZWW2+US8tnVICjyR8ewLGtY/B8Wp0+OngwezEoYc9o8hH2//mIVrsBx9X?=
 =?us-ascii?Q?YmSmLePAPinYxeDl2O9bO5CRg7NDJ0pbpXdWF536fKZ4U9J7DQkpQiCrm06X?=
 =?us-ascii?Q?j6tAgcVE7RHUBKuK2ZF2qg97WFG+B4A17NJxxbLCyG802OJGKqqVe7yiC7qv?=
 =?us-ascii?Q?zD+1RwVZA201wK94YMIKX1uC0DiqGzbG+KzC3T5FoFP319rQnJRQDCIEckVD?=
 =?us-ascii?Q?s+p8Dfx9Ta/oN3UxKo4zHD0WkwpkE7I/04Sa87OOTYuUS3gVkzWA52z9txYz?=
 =?us-ascii?Q?KRsk9VTHnqV/iMae9I96niWdPACKhXy1gN0+4AW122+VfA0ZLpi9x7coo18k?=
 =?us-ascii?Q?QpYdOyYyuR3aAi8qLpcJgAcDhHA+v12f5+8OTX+fdl+VBQuXqH7Ly5F2BACn?=
 =?us-ascii?Q?/hQcmmLowsdH3xmN8tPvKV+eHF9IwRfl5lmnjdd3mPfVgJbgLY7M+3mJa3nG?=
 =?us-ascii?Q?VT3yIaegqUanAvWWPXbx/KSLj576u/e3fTE7oiY9E3SYqNI17ytJh7aCkkZn?=
 =?us-ascii?Q?hGc81bJKtrx4M9z5H+GJpdH5uZkbvOoD7Vhh2tyufGxey1GYqXRaxdUONMYV?=
 =?us-ascii?Q?YprBJSOT6uyPixNurD5l1Qk/d7pxYwb66JBUrv9/0VnzHHYRGb/jQ3Gye6ES?=
 =?us-ascii?Q?9yGtyBIiDi6IN6WLhGEtjCqvMw5t72Px8BLd/qDVqO3BKaXDb8lHGC+Qwi0B?=
 =?us-ascii?Q?ZRf3NY2XgJ4JA5osOt8bGkA0tEEzj5akPGoHmAiM2wGP9X+kW1E13uwWXDn8?=
 =?us-ascii?Q?a+QqWPU05NJEXsiZJZcYH2gHXFxTu1cUlx5prrbWCfHcMIIYgscDiqiUM2x0?=
 =?us-ascii?Q?0QSjw3fL41v60uPM3zjR+v0VLaDD/t6zzu6vt1LZG5aRTHJH2nxyCNsXCwBN?=
 =?us-ascii?Q?w/NDacjrNG+suLrBrbjP6gdDn75iVau49R65VbLvFkfJIOlC4m34cXjg/Lzf?=
 =?us-ascii?Q?/wu2Hel7gnQZhZTX4NwMaKhFXtvIpiMGMv7BXxT85gLp5JfOKG/S5z/Wb3DD?=
 =?us-ascii?Q?rsaFVXoRh+rL11PV+qGaXipuhhFz3pdAeafw7H6uU5yD+Trqmvwl06TOdRR2?=
 =?us-ascii?Q?F8JX4GnMCco/HCUfwCihH2N9mx+Y0Xo5mIOR5wkjW0vkOpGqFdzseD/YgyLK?=
 =?us-ascii?Q?AHQ18yrlrScHnHaHLyx1dZojZ1DnLqEp1n0ibYe0NOvP2u8KiA/aIICR06rG?=
 =?us-ascii?Q?Fvmma/zEeEGOC/2MWo/YRUDhh30hH849dM82pfZahJVXKFaCiIoS7AusGju7?=
 =?us-ascii?Q?wb2aHmodoLa8uW3fM6dI6Lle9PlVIyzdPGTfA29Cb4XawbWsIlZ3pDka7KBM?=
 =?us-ascii?Q?jr57PX5xkjZfal8OZO2NudPQpshvVrdjQT+4ZOz0zprP+YPJHvA0h9+vDQky?=
 =?us-ascii?Q?lWTKqA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ed4f6f-e7c1-421c-e73e-08d9b999bdd6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5192.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 15:53:41.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ydVLmn8/skfv3fTknEaJ068AOflEOb2a1a6GhLPi9jCAtEss0m8Df6vFDzsDyct3Wiss/MlC1LpcgLVFbQPBQNHm2r1a07lBh8grMP3RgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2467
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=622 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070097
X-Proofpoint-ORIG-GUID: 0olkuLCspT9sxT0HVKUFEKIR2fn2zafO
X-Proofpoint-GUID: 0olkuLCspT9sxT0HVKUFEKIR2fn2zafO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

git bisect shows that commit 54a88eb838d3
("block: add single bio async direct IO helper")
causes the following UAF: KASAN: use-after-free Write in io_submit_one

Tried to root-cause the issue, but need the patch submitter's help in
coming up with a fix.

Needed to revert commit 1bb6b8102945
("block: avoid extra iter advance with async iocb")
in order to be able to revert 54a88eb838d37af930c9f19e1930a4fba6789cb5.

George Kennedy (2):
  Revert "block: avoid extra iter advance with async iocb"
  Revert "block: add single bio async direct IO helper"

 block/bio.c         |  2 +-
 block/fops.c        | 96 ++---------------------------------------------------
 include/linux/bio.h |  1 -
 3 files changed, 4 insertions(+), 95 deletions(-)

-- 
1.8.3.1

