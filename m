Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AAB5A5760
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiH2XBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiH2XBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:01:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1766078BD2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:01:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TME8xK026015;
        Mon, 29 Aug 2022 23:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=IV4QiH6cFOB61EVLnEPMecqQ7ish7sgP42yEy3wSTKo=;
 b=qZCrNbj6cvrdYHLdODIfBLSyj9kfR0Fylu0jfMyOX0dEAVdUgIRzz6EZftpnUsclAVXF
 VHwhLBD0zakhD1eLHOcMR+JpC/85/cakMb1pLsRVGUccuVnWomZCo13OyNB+wL68++Tm
 MUBbDv8Ov+TY3zNZYaepFV/UemtxTYY/ScVGKU6QH2ozKxMEskHf3OqByGLPD1R5cd4v
 sR32C7HmKuse8UNnRPd3PnUkCFPSZMFfMnJWYmLXL6R4n11HkgNQxMVQDOxaUTigFXDH
 UaUTsG4pBvi0RQIt0zcqQWii0MCwAO95WLmjBf8K3gKOMHXbOoSXeiNscwY7SBAFimtB tQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b59vqdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:01:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TLkQ2Q005204;
        Mon, 29 Aug 2022 23:01:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q33ndg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN3tc4Qe6F434YRSfw3YPJOhAAF145Edg6mE+YZnlcxnYww25xw0gu5Mu9FJP+iYQEdEjfCy6rmMW7F2K7IW1Iz+Tz6iKBo9sWsHjILLPGLVrdrE28RPsePMWRpYQr0B/HuL65dNC6yX8AEk0swR2NCd/HAqeIcpDEx6R1MyjtFjtsnRVenKQJ6QPKUrCLiQC8o2dixgH/vf+W8XrKjbc3nkVgaHS/+3qxtlSr0DQcKDos/zk1NRT2B4Oyp/3f1mVB9fMZE/PpfugnpjRUoEE1vYIcRMkpPo/JWH6gChyOol2sebD2tg/XoWOVsdpi0/MDzmHBYBVVdbUmgtyuJ4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV4QiH6cFOB61EVLnEPMecqQ7ish7sgP42yEy3wSTKo=;
 b=B93Pn8AZjE4q9BXs5drckIxONWtZMKRCw0ICLqyColsIwOVihVHHpRFxGYxTI55LUy2itmDRUn3fxBGCE3p8VV7QAzoSams7BTNJ7OvBaTQU1k5tobro5tN0CRFZsbmiZOLzMG9nlkWgt+e74nefIg+C1DbFMXO1XMi7YL9obWFSJ5t66IvA6HuJemsvJ49ZZsvNFmJsfIwkrt9LEw5O9s4pJRWKayzlLqdXOmmrT7/cAcSBJevAHQHFrP5015UGVlx/OepyUL3ehz0NHcNMESNVYUOF5/InKaiux0C8dN9FDYWFO2/bxFVL/8W8GIWqgsjIQvgxBf5CzKWCwhYe0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV4QiH6cFOB61EVLnEPMecqQ7ish7sgP42yEy3wSTKo=;
 b=OeBlqyO3hmvgY6XZl3N1Zbe4HnTGz0HoZfRU9WgYYbgLwj4OmjdrQeLvfc3tlKLh46LIM95HQWSiclYNQVn8uBVcXG7Y3o9qCc56d4Gvc4YOXbGqCVikBJfuraYkwNvw1yrCaxRsK4ERFw/oCLy9t08/adJwzUnwZKthqWHUzpE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BYAPR10MB3736.namprd10.prod.outlook.com (2603:10b6:a03:121::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 23:01:00 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:01:00 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 7/7] mm/migrate: use folio_hstate() in alloc_migration_target()
Date:   Mon, 29 Aug 2022 16:00:14 -0700
Message-Id: <20220829230014.384722-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:180::20) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92e95683-9be4-4750-d807-08da8a125749
X-MS-TrafficTypeDiagnostic: BYAPR10MB3736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUTjnVkyXX3hCaDZRvo0suzDUPt9grjtnw4fdhJ54uJFLuAItD4NpaoTfy+nk80OsScYCTzcoDm/ZZmwYDCRDx8K0ZaDlbbNuDk26q56MtISGA2E8yu8ijWxHD1DNuaORsPeibEL4TbMradEnwkbSYXVE1wLQH6cmhsnQEiVW56VmxDtFGEhys4d+SjEhalmf3fta79n1tU3hOVHMVufaL7UlgqFTrWy6LsWRIAQc0xb2ybS2kX7JDA5/4Ro2Vz9NX2wYqL5i7S+QkguCHcFFmxMeJLpAvTtZh/ytKrxXeEiTonIiSzHUVW0p9ppOhoCWGf4YZIdMTelUK0uNDvXhSgT/pXrUY6RgpGVadu6JMV3nZxasBAFrM/mVOCKW/OKa1JxFqaEs9LY44gnLFovkT8rFcGsfWrhAf/LycxpZ6/WjgYAV8dWLKC0S2E6OS87QVqCP/ifSqvroqX232G3NBqo6HcC0jwcSw7z3KcQcMHJ04iQIuxkHOGz8tFEbNO8glZFcybkhdonpoc6M2NpPknwTV2O7gfy5r92qk50s0+p0gmnEA0i6CVqEUomJ+sPeyFsTZagh8wghh5a1oLudR5zj5SnbIBncbq8Av+5P4iNg6+1Wrc1sD+vWAjaQbtTg7dQfnVA979fwNKM1kAZVtHNymp6zp3V5tqrqp2ANUACWpUWvThTd98MV+RmFsitt7YJ99M4YaeXOdP1FHcqug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(83380400001)(5660300002)(86362001)(1076003)(2616005)(186003)(38100700002)(44832011)(36756003)(4744005)(7416002)(66946007)(4326008)(8676002)(66556008)(66476007)(2906002)(6486002)(41300700001)(107886003)(8936002)(478600001)(6512007)(6666004)(6506007)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3qG+gIWfR+uZBO9YBNt/iKcEXPk648FtWp3UL0PdemSyT/1zgKqkJ4WD664N?=
 =?us-ascii?Q?8klDYQxT58VYzcE7hx2r2UTHQrLjZH4rSAtbij+wj5BY25B8m3MvEAFZ9emR?=
 =?us-ascii?Q?2N7DMclfFtuEd++/mijnjB0AZYNnM4fCDru3iOevpO9gHc/2I7hiyRjFqv77?=
 =?us-ascii?Q?X8vYE6BZ2QTarExpuoNSsXNWwNs7BkiXCLd/jX0qu0n2tLcFZ1sJqFwkaBVE?=
 =?us-ascii?Q?AJWsBq9ghTtd3NpW171BqhJ7zLmqvFI26dve61RCtn6iTrAfm5Y3FZhfr8tW?=
 =?us-ascii?Q?YMAJbXaWiQ405Y0meRaLBv8+vsjaVZl9ND1zR+ANVL1TbW7Z7N7JErFrms7U?=
 =?us-ascii?Q?q1mDX4Qa5Ok69dzMd5DGR0LZB/1e1pN3tQCjUbU8k2lJAgvmSGu+i1e6HO0v?=
 =?us-ascii?Q?Cm+ldLbyHtroEY3+bhJZoJc4gymT9z/t4nAUVJc0oklp5xe1h2x/sL2xnHs8?=
 =?us-ascii?Q?6/qYIvxs1Tf9Klziyuv3ry5YOdWjvMRbeki+whvUtTwxQR0QO3wcSxDWmOeb?=
 =?us-ascii?Q?5IbtwLefAj3VuotRmyCdx8WZuFwrMuR1P6lvbFzLv8vCQx/FDtWwVK/VdQSr?=
 =?us-ascii?Q?0eF3s41VelaZ5mulVIy2Tw+KihRvkTFbKkxy8PGi7B9WMwt6Wpq1MOnqE7WD?=
 =?us-ascii?Q?b/lc/9Lla+Mz5MVOFg/dQk6KTKqmSNk4IeAupNxaBqQtP1mW674wDbbeC4LC?=
 =?us-ascii?Q?6LQacRHc36JxdGO5Uc/41/L9+9jvrE3tiUqyvsBxY95FvVE2GWWumXtdwUgw?=
 =?us-ascii?Q?4ZeRLFkuDvoxB8wy5m5wWbyw4+lQW9pbiEH+VbnUGd7WIAB1tLGHVEtZlK++?=
 =?us-ascii?Q?pVimEtzyX09xwicvn+0EylI9pg/6KJQMMZSBo7ZEuIFJoWsVzaJp7gRqO1bt?=
 =?us-ascii?Q?dx4l0lAFw1c6C4ap3oizueSaTlWIzJZ9I2d3nDcUzMhbih6QWmgkRFIaHY4R?=
 =?us-ascii?Q?UY1Res76F6XoqU9YLEz2/L7J8FD3vyEbHGID+lFq515P8pqW6XzFpmaX4QCq?=
 =?us-ascii?Q?VDwJUBv5uiA/WeC7CHb/3cZ9N87EHNQ5Z3osWUo6NCARgKAjpDGjsqKEIvSj?=
 =?us-ascii?Q?TCWVzvaizythu12K4O4Ep0VVTKdbg6Iz8hRdi03+x9ezUIlnmmZLp2vTznYx?=
 =?us-ascii?Q?evbGDi1+u2kDV2PwpNEABjWewy57/goVB4UAFEDPkNCoWUXFXa2KbZ7aYydP?=
 =?us-ascii?Q?A7vleeLLcw9dWsnwBDHlxxjYeg/en5AAF7dsksawrpbQ7H5foaGYKgHVwsU+?=
 =?us-ascii?Q?vUcHYriSwvwfZSIPJVyAU/HwoErxS5zgAifMQHFYqXMFo4HkSqtY4vctyY7v?=
 =?us-ascii?Q?l8yhfIJdJ8rjs+8hfb03ImF9Qq+s6eVjEF9sx63hULs/NRBQaEon5TB2YVha?=
 =?us-ascii?Q?RgP/nSRPkuiK78RF9VHQ6aXcZkbg//Zm0dyPEIZ0l9NDefb65VNZc3nxXxLy?=
 =?us-ascii?Q?D16LF275GJga6EH6FnjMheCx8Mqy3g8vjtnWAw8CGdfOzblEHnD1VMj6adTU?=
 =?us-ascii?Q?3lEMw+68miKeFxdBVVCPOZFnWFaGR0pd51fREq76p7bPrVWB0duW8i9dQcGF?=
 =?us-ascii?Q?Q9aDNb/sRXDQO2sVh9hY6saCqJ7C7lR4WWjjVEzIaz4bFEmbxPYZVC8YNNUW?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e95683-9be4-4750-d807-08da8a125749
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:01:00.5941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tChZ2P8D4PFWbfDE1WbIGtfakdOTeADeP+UQNzZZXbJUDJVjqyY6/T5NmJIoYQPS/7Gi4orZ2PsHuuEfqWEjZizZsdY2L+TFgaO3Cd7L7dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290101
X-Proofpoint-ORIG-GUID: E-d7TGqjpc8gfZHilHojSxFChKPNcjaQ
X-Proofpoint-GUID: E-d7TGqjpc8gfZHilHojSxFChKPNcjaQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows alloc_migration_target to pass in a folio to get hstate information.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..55392a706493 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1589,7 +1589,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		nid = folio_nid(folio);
 
 	if (folio_test_hugetlb(folio)) {
-		struct hstate *h = page_hstate(&folio->page);
+		struct hstate *h = folio_hstate(folio);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
 		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
-- 
2.31.1

