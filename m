Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247CE5AF1FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbiIFRK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239501AbiIFRIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:08:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BDF83053
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:55:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286GO0ga016830;
        Tue, 6 Sep 2022 16:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=zuqwb6dgHOy9jGMh5uDPelU5jXrFj9rlPoT4bWsVfOk=;
 b=prWE75XSq3u2CGY6LjuBGQOObeDpUVs9it9Hl2ji7KI/3rBLM8XoEKYrWhqiuQ/viL4n
 7hPMX92+vSEL6hmFhCAWNKUsWaw/OaebXfJ8KvbT23uQVaaDZ40+aKj/JUGMq6GsSIYz
 R1aWOJ6hw12j+FjwQjYSeTZ+cWNPZaczN8Ohh+v7AZbbYzD5EUbcynDWpc7NZsA60NO4
 do59TxTBcNLjrldWthQwU2oNgvFgja5WSAzkE7Ce2n3bbZGg92zMeRcZ37fGfo3HDiYp
 llv+P53XSywVxDM5Ebug0ipntc+TEvKMqTEyR3GhA6i9Mo7FEli+4wtsbJKXbHQX1oFq qA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhspg8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286EcrxQ031327;
        Tue, 6 Sep 2022 16:55:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc34rta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVp1myvGxHYuiqiHgIQ/JYZSJQobtYv23FuBsHIArwRnmiW+PURcs912Ze2S3c/kOdGR9G9DMa0ZhHzZv8VNgROYjcIKwybi3NOYZG8Ms2GCsOarIPCJL2dOdGBxrGv8w41JdZaA4NkTN2smxgmU73GsbecQmQD5mLWkFUwNA3tUyXGLwVpSflQgXOxGA1rNIrydhmOXzYPe7biSg7aqavgcIbnpMAsDMyPG0Wu4gq0q0EB1AQloSbDXQBo1gBw65XQOnydAEnTz9/m5y6K51WklyCxDesqGwLOMeljcP9N8wV5uR3xxtRgT15DXwwbannqnAarAVP6F+aWNd9DtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuqwb6dgHOy9jGMh5uDPelU5jXrFj9rlPoT4bWsVfOk=;
 b=eBqiio1Wt32NrYWsuZQ7Wk38uAE+Tos+PXyEx/gSzU5u/ITyh22LA7lOyg/diiSnAK7CGEVyeR5vCaWMxq16yrvXXfa9Zfj+F62yV0ekh7ttt2ydtAOqZXM7KFPGDH0JIQzpd0WJ/ft+c/C4f5m0UsRHvb9NU+K2IFOLaMATPStRQCuT1SgapcNuvRIdr2NFqNCw/2sd4H9zB8Uv6TBSQHFt/V8vgp3XdkTepIXOzZVjRoRzCrSnDUEfwwimeA8Cvmn0FJpiH6DCxd1bWtGp1mDosaEtCoVpQCL5FU2ViobhZbp0LNBw/qN1GZ0WBCBTxKJtFw0m64DOF2iNcMjd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuqwb6dgHOy9jGMh5uDPelU5jXrFj9rlPoT4bWsVfOk=;
 b=AGDmZOt1SeTilVFKQaG1L1dk7B0+KRyl8/jukuBpZgyH3D51TOKs1jKPpqqXmzo2kc+TF90cW1+LFYhrtqJpHfZQSkRJdXcttVeE1otha+m/nhRXbwsfXlEr1OtGyBc+HvZCy9I9K2wZtXV7TD1FgMATq8cIw6aIT3vtH0mY5a8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 16:55:35 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 16:55:35 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 4/6] mm/hugetlb: add hugetlb_set_folio_subpool() helper
Date:   Tue,  6 Sep 2022 09:54:43 -0700
Message-Id: <20220906165445.146913-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
References: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::33) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f85a53de-86f1-4877-2c15-08da90289e43
X-MS-TrafficTypeDiagnostic: BN0PR10MB5078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDYuBB2lvhLHJZKSibytcC4I3c0GrbulCxHGcv3K8lWa4pSoqFgzej2pIDfJ9xFTb9uTIrNiIlRXtJIw9Yxdn2IJxVTDP8OvODhVmdGahNaVQvaC9lbb2mGOvcJOKMImqtqJD9u9jYTO6u6Yzub39VP9oQE5AG0i0EUgxQ94rdPeCS37y9NUvDdhH/zgnLQtYuOkNp6yzbJq8rXM+DqR9WBlICfIoPLqnWiHZmw2r7h4MnWx9weVOjccwevMQcBaBMPme+JPNiu54E3AvlORf4yhgWd12JE7tNXaInJA+cT/gnJxteR5A2moxuyq/If+thxIYevd8hcRperj14xD6HvZh0HZFpI4ODBV6li4icZUDMUEcQeD4Mi2ID16cpnwK0H/+sRmoy0oMpXABxPeHdsIcVzlT72B2N81LVzgbmyFo+cFzLQWVNxtW5LQmdbAlgLdK/s5rkXHTARgyjszIyQFHSRGShEYI7Q5rPEZeivWwBCYN0bvsRIB+k+wpk42MuqlP4uMIU/xWp31b31XF8CYSj+zFh+YVbdmbZEV8HIx7jN/DpvtU73g5WRzyVrHdNK39QUhq+eCyLeNZ8rrcIymB1m3HzgD6RK0ByyMIclfw+vrAoWEppu2Vst9NiF2HrOnv+2ncn4w/5b+gCie4PzIGR/aNLWTG9no7f/mATokNJQEEFVfuc6GvaCl74AKO7QS5/OoV1pOBOyu/GD/Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(186003)(1076003)(7416002)(8936002)(83380400001)(2616005)(44832011)(5660300002)(2906002)(26005)(41300700001)(6666004)(107886003)(6512007)(36756003)(6506007)(86362001)(6486002)(478600001)(38100700002)(4326008)(8676002)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MIHxZVoopksqC+CmbLVhPY1lpFr1uHkMuLrs8Gn3xnhJ+gaa6g4CH3x8moYz?=
 =?us-ascii?Q?b22nCv0Vb/ooFTFem3/picWc2kusKlz0zKzhYNcM5qS+1NmK6tW9f5wZ6lmF?=
 =?us-ascii?Q?6oomwbWb5pCPDW0KvujieW6zMxXcGNcl01Sl4eCAGKNuJupb3uvQSmVYj7OV?=
 =?us-ascii?Q?eS7VpZtR0V2JJVVOmCvWOxHRkvEGIi3vyV3yQFqWz1BTsPeO5L9P5M0U/dJ4?=
 =?us-ascii?Q?k4nWFbHWzzY7nb6OSzRXeHGbLgddLwqlQeP/5tIPGs6yW8kFDggJI18QmDeq?=
 =?us-ascii?Q?le11NyFQOxD5oQnC4sS23qvMvfDpDa/KTVEKLclrMutXnR/Rq/+T7ABtc0XT?=
 =?us-ascii?Q?mblezS9dWk6y7g56Oli57QGbIBwdcXQzxYYz/ZPHTIwtnPqS9xeh/wmaoTcu?=
 =?us-ascii?Q?ndNNd20aYSxJF4OTS26BNNz9Htzzcs+R7YWgPglDtwU7dg5sJqVi4wgR54YW?=
 =?us-ascii?Q?K9nL3kzWWyPU8STSSUmR7JZxBTWi3RZGe5W+Gke0Wj480DWFLSijyCRgatMv?=
 =?us-ascii?Q?gqW1Anc6xD8GdZSNi/3Kvd6yVaaSKnh2cKJTpRjWCLlcwG63bIqd+vpaDZWP?=
 =?us-ascii?Q?64pGadOFo9eEdB7DXORKJSuwVHdUlTe7aVpIREl1bWygyfHpGBbOedkYRR9U?=
 =?us-ascii?Q?9MV5DC8rupr3AweeXLCC3NV3kyFH0tFVCXrjIZ82YVyiNl+WJOpO0fn11FXC?=
 =?us-ascii?Q?LK+1zoZYHiL3GPZan4y4Y22ax5S9xMzo1kvKS+oAU7cGilU0SFyBAe44Ke3s?=
 =?us-ascii?Q?AiRlL4gxixEbsIq33TUkX6fmO7VXOfikZdVRC6AsXNR1mvpo70jsIDEY1ZAL?=
 =?us-ascii?Q?WIOCgHp1DixFPjblvHiEvBIJi9XF4abdgbGz82pw6cWXirKFKKCye3rwvNjW?=
 =?us-ascii?Q?Txv/6gsp08At4ENhqZTGTkr/+nK8vobju3z6ls/+JI7Uox61vSqw6u0BO0xz?=
 =?us-ascii?Q?YAao+Cubf2D/S4DBxfGl4xWQ0lRpKiYn0OxHxyHX0LA5Jo8aJqFaGFxg8nA4?=
 =?us-ascii?Q?oBRldMVr7CditrBQ2J6J5tdqHnZ6HLNkp4VpBlHfclj6yFZuZaNU4rjWEoZT?=
 =?us-ascii?Q?ELScyNF5hiLawHVcn41ymZ88KszVPPsdmw9iXyu+CTl9/aN6c5Dj/Urwjv9b?=
 =?us-ascii?Q?nmYPBagWOuNkjCCp4H74e2UyYgFCaAGvkfR9ypSqoF6QjWXNE/igzc5IUDYv?=
 =?us-ascii?Q?bjTyXSsYaVf7iewQmAh5yX86jow42gOuP2AuJFdr4YzVi2pItdv6F68PKkKu?=
 =?us-ascii?Q?u89ZfpT7/NxNbNJ0/UpDX/bT2jAfn9vjrR/KqsfREEACO2v4VnNn63ISCQpE?=
 =?us-ascii?Q?szZYLi0cv7p0X6ql/GWAHFL/aSfx63h8c4Z+n83QBp3F2q4BJlWu5KOV9wy+?=
 =?us-ascii?Q?Wx0Es73U3DfFGXTfuTp5An/77ONqS7Lw45fwFDpTZQENTbkBWN7BRB0EFd91?=
 =?us-ascii?Q?5FrRYRkXedzVzP5Hiks+s/A2PIh5mEloVKNSJbQg/94JDPHI/3p1ar3Due+y?=
 =?us-ascii?Q?JwvFjSfGzUoUVDd27fzET1sElPt0L/JZvjAJNBAVL5eb1sBcOal5TC7mihqS?=
 =?us-ascii?Q?oFR7uI5RjvIexfKxpUgQJkzKsuw9cHcPF0JnoyHX9QiSSurUwdzm/8vzfSoL?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85a53de-86f1-4877-2c15-08da90289e43
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 16:55:35.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbeV70zok1iwrFUZ5Gv5q/4OhQ7F4EdVqj6t5JXF/NrlL6AnwOKaj0n9PsLpi8R4UryedKw8PdmCTnOdSdI3U241p9yEDmBjDJ0NmxibISA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060078
X-Proofpoint-GUID: ILkg-64B2Y4r5Jqn_XsfQ_RpmZX_aOWf
X-Proofpoint-ORIG-GUID: ILkg-64B2Y4r5Jqn_XsfQ_RpmZX_aOWf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows hugetlb subpool information to be set through a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 4 ++--
 include/linux/hugetlb.h | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c2e9c0cdbd81..d9e08c445e2f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1152,9 +1152,9 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 		return rc;
 
 	if (hugetlb_folio_subpool(src)) {
-		hugetlb_set_page_subpool(&dst->page,
+		hugetlb_set_folio_subpool(dst,
 					hugetlb_folio_subpool(src));
-		hugetlb_set_page_subpool(&src->page, NULL);
+		hugetlb_set_folio_subpool(src, NULL);
 	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3602e4cda31f..68177725a897 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -757,10 +757,16 @@ static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
 	return hugetlb_folio_subpool(page_folio(hpage));
 }
 
+static inline void hugetlb_set_folio_subpool(struct folio *folio,
+					struct hugepage_subpool *subpool)
+{
+	folio_set_private_1(folio, (unsigned long)subpool);
+}
+
 static inline void hugetlb_set_page_subpool(struct page *hpage,
 					struct hugepage_subpool *subpool)
 {
-	set_page_private(hpage + SUBPAGE_INDEX_SUBPOOL, (unsigned long)subpool);
+	hugetlb_set_folio_subpool(page_folio(hpage), subpool);
 }
 
 static inline struct hstate *hstate_file(struct file *f)
-- 
2.31.1

