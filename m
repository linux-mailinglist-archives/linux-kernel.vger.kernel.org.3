Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A852A5A5763
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiH2XBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiH2XBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:01:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880657D790
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:01:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TME26t026282;
        Mon, 29 Aug 2022 23:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=t9Jbr6B6wMq0V0oVzBjaghz7DnvZffnOEoWagnJz2Po=;
 b=iW+ynyVfSZx6LH80xtChKs/HpN6r5xMxCSuwq3Tg2EBNPLt+NZIGrbZASb7PM6Ekm8N8
 INI8mmVw0vB57l1NzJqIs9yQSxG0aTBaVcge4duEosP+s8t9ecrDAF570xi3pCPBOf3Y
 Tr7t/UAMNU43bqe2Ou8cmeCpaVZlLjQKjYMB/DGLCJFqyy/G1lZ9WOM6rFh/zMj66c/9
 K/hNycrT/GBBYvVICS76Bs2D6OHw0XTPmYEn7Smz3YdDXwcOJeEmGpfnvQIjx0EvF+Oq
 yrX5+KAS22XITn9rHYNcUkYty3/qRe4PlbCr0WOeA7QdGNK0A/K1OW39ebb0EdwALWy3 gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7avscsjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:01:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKqeDA018004;
        Mon, 29 Aug 2022 23:01:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q3b70j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:01:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMjOp/x0VtjXfUy9IHs0EuvQiWas47UQnriDXvJHaP5h3Wspe2BHzDaPoUWtT3BxB2BSESVl03tnGPJoc/lCPoABdjicJcq2N8qRW80Rss+hCHq2oRPrqnHDDukKjsflFguou/nQ1zM1b9CdBOTCS506WmrD7zDQqUuii3aU/A32WB3GNHt5gch1vQozrcGaaeslu3pl8oxr6IGOsrXZ9smTSZBQSbxy4Sg006GGAjIlbwExRCDvjP0xpGYfZz7oFx3AlaJINa+DpWNlS+VPGEozF+xZPEshwnJKKX6WESWvXo4dClmd2AwCsGfTNl7Qt1H+QyuSDMCvSJme0epjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9Jbr6B6wMq0V0oVzBjaghz7DnvZffnOEoWagnJz2Po=;
 b=cWJIgOKDPTAExd6XSgeiYDDP76rIXiSKw5/zAqRxm9/a65v050vaWO8EbS0EbQBJPxBNSkdonV4IhicaxE9X8RIhd2+Ax1yNPxg1HJp4iaINQG66HJGGv97HKDCp1EtKLmnBZ0uvlbd7otr8MBIeLIwFLo6cHx7iDU+HPWGcUA32FmVEhAfSQH3azTa68e89vEzb6u/hvXmat99pzRE+0x4fu3EJYfD8mP14/0vsFYbz/RrhNLWmX7vVbnitrTzWa0+OPo8jlTO1ASanSZCsi52T5kcIRVCIrMrThpmltLZbzT1zfF0hl4bdbyIIYZ6yPn2qyG00mRAE3OqYlFoFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9Jbr6B6wMq0V0oVzBjaghz7DnvZffnOEoWagnJz2Po=;
 b=Qzh2JSFT4SE4/M9AkLl6oP9lchqapL8TM1vE1XRHiM2e11C5M3CnEJF6kNO2HZ0SgOT89O1gqPoDL1i05Fj3QziVyBi8ap7fIgLNDJXPAjxsodTuouhEOOITJiEdX6vClBsFhNLp669Wi0B1hZXJfs6eoulIFEcJjcTqiZYWy3A=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BYAPR10MB3736.namprd10.prod.outlook.com (2603:10b6:a03:121::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 23:00:58 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:00:58 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 6/7] mm/hugetlb add folio_hstate()
Date:   Mon, 29 Aug 2022 16:00:13 -0700
Message-Id: <20220829230014.384722-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a77229d2-80b8-4f1a-660a-08da8a1255d5
X-MS-TrafficTypeDiagnostic: BYAPR10MB3736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+rz1SvToCBKONBKdyOefrb31daVSH9ji0+N8Pf69VcQko1sqiOtm0f2Pu8F0uMYTM8QMQfGqpsr2Fu62bYWjOoOmM/pVLwzG9VE53yFzEYP/Np9apaoEDlGvTnuAELfa0xVUTRW+s4c09x2Sifgja20WYz1Bl2k63TGpr+q9KrgMF3ShBaHpwln7Xp0xuoteyoxEmmVbE0NdaqOSXDswORTsdstPSnH/SNeI5+EZTzaBGLQ09C/egnuu2KWfTr+W2xt1g9biwnVXTPIex5SAKRA8M30z3j1yV57Ai+2SZQG7icdX1vZNzWPqvp1mzlEXrtMyr1Q4Xpb6EpqDpsgr8OG+sNoGoj2RWLE27RTSKwO0DBXolEKL8MbStRPATH1yyzHgPKwwaYpsUdxYMaoKmDWrRhw7RLWRd/SPYBZKMwOx+ISaep6HbVWYX4Rtq1PK91ddhWMjoLeygrDAaqNkaLcgPpiuyAx/ptp6QCCCy2BsniiVJ0FSXKD+3WHZ6Hpfmdop/cFwVhsaUpo5LqCQLqiUxIxsTKsnyfCWzvLSNiAg9SMvUzfKgUZfbjBH3FylCd9bMdx01EmR9av5A5SnKlFQBAe77t3i8y43I0G82/EB4IEZdASvvUEud6qKzoeRbI5IDFrtfOi+jOu7CBEuMvM7sccm8962u/923Lxop0/jNXixr5jroJjb8a0F+LreAwzX/l0gZ/WiKrgkoLsIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(83380400001)(5660300002)(86362001)(1076003)(2616005)(186003)(38100700002)(44832011)(36756003)(4744005)(7416002)(66946007)(4326008)(8676002)(66556008)(66476007)(2906002)(6486002)(41300700001)(107886003)(8936002)(478600001)(6512007)(6666004)(6506007)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I/DAQJC9p/yFBGYL3VOsKwZxgrPZMu+Cw8ju7GDjDu6SeXdvLM5U+L8bN2+2?=
 =?us-ascii?Q?KGafIn+ojUZrTpXVk4agwwDFwmrV6uyN0fCimb6C02Bv39giBZQuJjuxzP0l?=
 =?us-ascii?Q?uoK3HqVq0g9XlE8LMSF5a5mdQnJ6GV7cq2gN1rpeuYl787aeldozi+VM6aBQ?=
 =?us-ascii?Q?owPjABwHNFas82P2jz84EIYLrv6G0SIk+7c9VskhgjF1W4DU2wFfLL/mNrs2?=
 =?us-ascii?Q?2AgjdeUQ3mtJwTS/XilQhEfUh/iSu7Gu2AvY5Z16Ztk4/fw6GfceCM88sd3I?=
 =?us-ascii?Q?ZLIAwUJnfwCUgbSZSzzx9XVj4yzWmbPihGipHrgV7ov3tgl0YPxm/xgnPG2V?=
 =?us-ascii?Q?C+S/lcaZAURmo9AdJuuEMpx8kiC50QP7tVyjNL3E1wLGUPU/8nOlo4nlDcnK?=
 =?us-ascii?Q?e+CBGipdcdD+1Qziadx55S0cODLUSWuAzHd+CaqMAp/e0CMtOid87tWA78WA?=
 =?us-ascii?Q?MmL+HO5I8OnN+E//ktD+byp8ODJ0ZHJs9bxD1/EfWUD5h5UTDIKsmrJcHZlg?=
 =?us-ascii?Q?biRpep395z7OLykG0Niw61Linsfs53v7XvJ7kYeDMe4/p6wuLnVokDwTgoGY?=
 =?us-ascii?Q?YVbXDhYUS9wgW79SxbsTCvD3YwxOE4THatAyAn2zqdGCu+Rab0tSIvkqqu77?=
 =?us-ascii?Q?wlRJSBba2U2JZIDnzFFtpE+Tyw8C5uxCw2roFrXPISGxNaSbyRRk/D7clblQ?=
 =?us-ascii?Q?rVd+rwgzQnZbrDzVKDon1IIw6sJ6SYEJwucH1ijfDUY3+pExqpuKmDG2GGBt?=
 =?us-ascii?Q?P9z5ifatYjxKqlKtErFXlaJ0ArA2SDjZtssZYkaMqcPaUqaD8oeixB3tUfBZ?=
 =?us-ascii?Q?jxpm9LCfuwcv3obGTiNAhafyr1xwtQrRRbNR4T6/J+Lp4C8//yLm/G/bnru2?=
 =?us-ascii?Q?hS1om9tBUws1p4u7Bwadb3IwAhcxq6C41YnTT285z2E1Bwhg1ESqHyRxoJtR?=
 =?us-ascii?Q?/nx029162sLaM5AZ+jE6pDAMnKRUlJKKsMtTMSj2p3mMySyTex9A7f4bXXDu?=
 =?us-ascii?Q?VKk12L20m9Z5SYjDGv/eIPdUZaKadhm5nwXkwWHYv3uZCvh+TohgopzcBMjr?=
 =?us-ascii?Q?zxYf4HoY4IZ0xSEULnLl/QW9Rh84difzBogAvj90H5jDwnDGwszCoOXohwUe?=
 =?us-ascii?Q?K75Vvxb1nLmU56NPeru6lZoVD38uq8ybn4yfivbK4Cqw6Am4LHONZQubBPUQ?=
 =?us-ascii?Q?2YngMaIfp+xU4m0ABR0DL7sJvraYoWJBplX/1GqZxPk/g1vwJE+qC8XrqP9u?=
 =?us-ascii?Q?Zo0Af/ltXo4Zp9SRX52SgcGFgNMvLrNmRZO8QxpK+WR0NYZcxE9bFrRUnwwI?=
 =?us-ascii?Q?smkiekZJ+6V3TEfgIhKfJtaf0sDiwxqaHhlIAf8JBXEFrnfwzguP8ffrjZQ5?=
 =?us-ascii?Q?AOqR4JZxgPp1it/23SCKeNlZ6N58RqngElLx60awt2CDHPXG/LLUzG6u8xYJ?=
 =?us-ascii?Q?uGUe+3U2N+BukX8fS+VCOb7P8EAPxqHxm7fAZEmrl00MexIPiNVNjdmMyRAm?=
 =?us-ascii?Q?dpuhObqX366yCHEg7RRwwhGLOX9LuSVE9/vdTVyGYVeBM5E44DA8Y7jh6PP8?=
 =?us-ascii?Q?mSvD9ZC1ClmBy1klPmkC0C4EtXSf0c30E6QRji+wyMIdOkLY/Sq9cadFznd9?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77229d2-80b8-4f1a-660a-08da8a1255d5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:00:58.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ywEYuEa17UoQEs4cRsNeJej6F0sB2OCpwuu/ACnek40qt3HwrnnlHAB8fh6FiTwLEVcurSSicMXFQk22H2XoAjA+Ung7b2FIJWVsfDRtDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290101
X-Proofpoint-GUID: qowUH1oN0aFptCaoB1vndt_ML2utoMzd
X-Proofpoint-ORIG-GUID: qowUH1oN0aFptCaoB1vndt_ML2utoMzd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helper function to retrieve hstate information from a hugetlb folio.


Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d8742c5bf454..093b5d32d6b5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -815,10 +815,15 @@ static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
 }
 #endif
 
+static inline struct hstate *folio_hstate(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+	return size_to_hstate(folio_size(folio));
+}
+
 static inline struct hstate *page_hstate(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
-	return size_to_hstate(page_size(page));
+	return folio_hstate(page_folio(page));
 }
 
 static inline unsigned hstate_index_to_shift(unsigned index)
-- 
2.31.1

