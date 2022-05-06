Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160DB51DB38
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442507AbiEFO6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376501AbiEFO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:58:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08AE6B084;
        Fri,  6 May 2022 07:54:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246Cl5PV026110;
        Fri, 6 May 2022 14:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=pbmatiwHhKoPdXjdCb8hjMnP7t5eo03W7lor5PpzUMg=;
 b=PFJ621HzHXxOOb0bt68JkChmy3WamoV3DwdS1CoBbSRLQgfJkNu/2BhX2bNnPxpy5CEW
 FVDMj4L11is/ANxEb23QWF1zIqiUcj0c4BqkLMXelav/9vww/YFOT0uzkGAz8MygZYYF
 3M2X06cFKmUBkGutoJmdhP8s3YqWMeoLTWtY+Z0DLKUtEhQxmTyNuhmpxqX5XmtEbcNN
 DEFbdjBVlrx4PdxWafrCiS3/VUHQ1EDnbGLGQ8cKuEhZTMRcoIv5rvmlymKsfrFlsZ3U
 +/oAqQ5TfwAQx/d69cyadeuKKYBmxRxI1+6Zh/VJYcz0o+w+lnf/f0PCMxVsYF/IIEJD 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhce1m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 14:54:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 246EUwB5011712;
        Fri, 6 May 2022 14:54:44 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj61y2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 14:54:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0aTWi2+27IdMB8JWofNT0bdH/e3o35meCthsVtRUdNWtQ23jgabkUzjb51QnAWSLtercmiLd+Gm20tnr1di7z6TjHUSFxOXGv1EguAV72Wn5iMKbISfEoPujsnEk8WjU7+FwWAaPHSv8rH87eWHevI0T9Y5ZxXklLdghvMeKdWHSCHB+sq8Zbb2/fLLsc7URqrmS8OSiTTC4lUvncgmuzgVlNPKKWMpD1Wmixb9WeVVCKwxEk/CPNL2l3l/nqYI8emQlOAIYxH/rzKoN7N+ciTjrWJu6WBIftgxspG8ddyRHWqDkKur+MXER3XmsKwHKzb50PdLrWVpmz6fMe/Lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbmatiwHhKoPdXjdCb8hjMnP7t5eo03W7lor5PpzUMg=;
 b=TU1d4OmPMshOi/Tw4fJIJI69Rzpfu2W6lri5wud7eUkmWX742KuVUyiBF+3FH2eAyTcYCoHJAIOg0eDp9B/Sv0dG0s5Ld8vqA4JpWuCIxwGXfxWwxYirzmDtMgJa6pMf19gkUy48fqX9K+V9t0F+m3RKHc4QPGQ6HbWgcr0jvA0dq0MFn4tA48jsY3qATsW5SeeQ+3nM5NdoNMPPIAT1AqFNLFlvqrhsqeyyi61BJQNsrP9Cfwnr6jpHB5D+7gS4SZ3jNjreB+2x6NmwcfBhNjSjl7ODFECWip3dqhpefpQ25bxuIB1KOAFPD6yStPQJjqXcP10upwmy8LsUWLAzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbmatiwHhKoPdXjdCb8hjMnP7t5eo03W7lor5PpzUMg=;
 b=AH/tUyK5oRaCKRiyte63lPppj1rTEP9GbO7f57wke2dTAt0n2gaZsS/Q888TtAM3hXzHhtJ8r4dGJxGFLN3KKkrKIxU1gd3BSwMc7cNtz5JKJx8XFx/CPxHn8Tnj1ekIAkr/vxI62sxxqyjw8PaG1FHMUcmuBCI9Bi1DH7ylawU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1405.namprd10.prod.outlook.com
 (2603:10b6:300:22::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 14:54:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 14:54:42 +0000
Date:   Fri, 6 May 2022 17:54:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] hte: uninitialized variable in hte_ts_get()
Message-ID: <YnU2p2CoNkcxBUKN@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnU2gHe+QZOAuNyV@kili>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0085.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de307e41-17bb-4bbe-7d4f-08da2f705a36
X-MS-TrafficTypeDiagnostic: MWHPR10MB1405:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14051B1DEA440998ED7F28E28EC59@MWHPR10MB1405.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKU8Mu76VLQikFaQJJf4Zh7JYh1k5s26/2srPON0nrjdWUB0NQ74fvSOug9y2+b90+sheR3F+0aSoU19AhxOOcFl0fnUEfJfQ3dLMUapPFMxup00iD4rw0Z4d7bJ+E7Ka0Pq29Rk0KRtuzSiZcKQbgUaH/3G70RtSuzRz1S01RIR78IKW83ahJK7mx7ww/D/6Db8PXMTR7LzjWiTMgeyCd1+z+KI0YUHwHZhmgwnRYvLzU0zHBMGEMfynEImay3OyZDGvjjzVR3jlelXGXsR+h67m/jdUvKcOr3RaD0pmHgys1H4aNAG7pJzP9Ndwe2y8gKcXQl+0IIOhu1g0D7sTV3l8LjuhehsPvGFc/KtJHlqa5NKqJvMbpOCqkSaFQhnYwUvnwD3wdN2neOY6AwD6p72G3Rtuv0gD0FJFo8aPMGTBMofIAvhnc0Mx4S8S4R8ADpUDHjMAylzXyv+qJBei9un12O/K24R2DSjWeqkWpc3VDmP7eZj9+Bk7TOIGwWm8o8OD/6SWnDfU93H+uf/3+QOwm1xSane2zSk6KI6+r3cI2ldoiJD9glnbwDWt1BfsVaaXZimt9US/RBqrS+Z++QeNMs6+KPDcLeZk1e5WtvfAXElVpFbBTT69GSJiXk67+AbpjXing6iLDRY57W9XgPrDGDjR/NROsEsX88kafTRAIQZ28cH+T+88Q9l3P7Luf+9A0U/kjWuTxDDoiNrQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(508600001)(38100700002)(26005)(66556008)(66476007)(6486002)(83380400001)(8676002)(4326008)(38350700002)(6916009)(86362001)(316002)(186003)(4744005)(6506007)(9686003)(6666004)(6512007)(52116002)(33716001)(5660300002)(2906002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iMo9uG6i6xNqh7T7YTYJ6+QamVcKObsU4uWkxzLLrkxCZaGyS17CKw2g28ZJ?=
 =?us-ascii?Q?aWI3r9OdrZkd1ZB9TMwv6hRbv0PgGeIQaBE0b36Uh1OXnFcrqDfupswwiP/1?=
 =?us-ascii?Q?Dfy2aqI1sFFpOFOa+FN70DrpkFZJd5xkWQf6uUPAnOUvqo1g67xvzFbW3MKV?=
 =?us-ascii?Q?7rOf7Exq4ce7mOdw5T3WfWGWr4M2sJLxsGLapCW5dXuo1JCo6sO+Vy9BxrpN?=
 =?us-ascii?Q?7u0SzE+H0aqGktYbDIfO1K7gP6GmfyvibYIrhPFlPDGRDh1rRg2jQqEgR/T+?=
 =?us-ascii?Q?k+8DrEZLppLO9zIQLNNvC8CShfzFpeUPwNd22dQwFiASClS9Czhkai9tTOGa?=
 =?us-ascii?Q?nacBf959dhIWW2OkJrN6YLttyTXdZ4zgtsEQ5Xf6ng/pu90OWJ+iSCcVUoRr?=
 =?us-ascii?Q?3E1/FrUd1uxGwKayQYGCp4bXCcuhEnVexv5LUX9HuQkoQDhv018wj1bSYz6e?=
 =?us-ascii?Q?TMRSDPJO9IOprgC+Uag8a5gI8wEHbgrf2sLxKLJ6xg/jk6OJKIykRMdeeG8U?=
 =?us-ascii?Q?OLgElYr//ZtXw9o5LKXsAKv3y/AduRAml889MVU7LWVhRhoJvVSNWv8pNCdj?=
 =?us-ascii?Q?BtItPVgNX2IyXEZ7cV3EImc6UQwkVvq2KxvT9BFKDaoY6vROis1KdUPNT0qk?=
 =?us-ascii?Q?wCavVjk6k/p1dnHYhZmvmHQP0mp8dtlQxtkc/ApbZu1s4F4ctm7rdQSApvaB?=
 =?us-ascii?Q?PQ9ILOfI2tdjmR/rnAfgYR/96uCxQ5mH0+MI15KLwzCQQzlRtKGFZJD9D04L?=
 =?us-ascii?Q?b13r+F/RFaSj8kOJf02iLUEqu/oyE3kdYr7U+HuQ0TjyECn8ez2I9cdnwxsw?=
 =?us-ascii?Q?cnBpuu+hehxPhcHLNg6E4emHOnS007uemwKbeKeJVPQiVHKwDF16mWaIQnr+?=
 =?us-ascii?Q?HC6SAN+nGwBxv5dPi+aXHsp0BxcRM/OAMqdFVYwiLQIUY3Ei01tIJtCVOnzg?=
 =?us-ascii?Q?REo4zS4LZX62jUbURyDFO9RxYzMNenNXYhHrjttKmL7+WU1h6LjXkfDEWFJb?=
 =?us-ascii?Q?nnDmOnBqvb7onZ0NlxBJQqfGkivJYn4TIKl2cnb1H6OXkMCsqFwBVhohjmdX?=
 =?us-ascii?Q?rSapbsT7HiYANnw4wjJxcEmLgXny6zYeXSh79PqrjCmfg7VNqk49AGXR74F4?=
 =?us-ascii?Q?tOlXDBdPxxthUYFu328CEw8vFNz51qnroey3hYzUt4eUTpxCsN4y3qfOgwsu?=
 =?us-ascii?Q?hGnq31d3h6s3FwQ6WmiDMiorDxC2uoFEZq0QMzXfCBxU3GzA8PAX+DIivrDB?=
 =?us-ascii?Q?ETUIx0XIuEzGoUkgglyufAZhHompQ2JBLaXw0jk09kJPaQzNbXJ2XXYpjHq2?=
 =?us-ascii?Q?X3JYHD7ZbDqtqBoGDsIC5peF7pNVmuXX9anVmt9MfWMV9MwV98YJmejeRg/P?=
 =?us-ascii?Q?GR2D/AmgYwDKfNn5ipHb+5JHVZxexgWXjz3jFK8ikOCtJhoVioipusQQIJpv?=
 =?us-ascii?Q?iuI4VJD8C5COJxQKMYbnzAxohCq7UCBcxA0Md+1bifeGU4YvYGlSskAEmsxJ?=
 =?us-ascii?Q?kIQG0l+YW8f5WMxMCTIWbTQEN312sSjm4Q1NXbIRSyzNlCUXcQR6mX54H534?=
 =?us-ascii?Q?UQ9QdOJG71Fgz6RtNlOey6LLa/zRjriBRUKorZtqX4AFw7+B61vHoKZjNvm7?=
 =?us-ascii?Q?Q4t/V55zF3W461MC66YJyMqvHZ1Q1t5cA6j/c39F/FpL8DboYTjkKzy2sYJN?=
 =?us-ascii?Q?R+pdBewatuk/qv3CdevU0kLyPM7FLK5bgl3VUyF8OwxNFuhjofKv/Z2OL2KN?=
 =?us-ascii?Q?rM99KT0o4vEwN/UjtYDVqDlC4ZNk3tg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de307e41-17bb-4bbe-7d4f-08da2f705a36
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 14:54:42.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEZGOKBi9miMlMtsy50Ms97GqEPeHvtWv7B//noAF7Nt4UgR79WxRdgDvhQD3uGMbRim8XwaYTQ7XnkVtpJBgrTmiwd77fRYcFrKZnpRu7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1405
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_04:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060080
X-Proofpoint-GUID: tKmWDf0iX0hlEmBtxmMVzEguLj8NopFQ
X-Proofpoint-ORIG-GUID: tKmWDf0iX0hlEmBtxmMVzEguLj8NopFQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "free_name" variable is sometimes used without being initialized.

31ab09b42188 ("drivers: Add hardware timestamp engine (HTE) subsystem")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/hte/hte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
index a14c5bf290ff..7c3b4476f890 100644
--- a/drivers/hte/hte.c
+++ b/drivers/hte/hte.c
@@ -572,7 +572,7 @@ int hte_ts_get(struct device *dev, struct hte_ts_desc *desc, int index)
 	struct of_phandle_args args;
 	u32 xlated_id;
 	int ret;
-	bool free_name;
+	bool free_name = false;
 
 	if (!desc)
 		return -EINVAL;
-- 
2.35.1

