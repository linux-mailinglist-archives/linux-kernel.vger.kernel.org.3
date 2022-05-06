Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E551DB35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442499AbiEFO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiEFO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:57:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D026972E;
        Fri,  6 May 2022 07:54:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246EeOxc032436;
        Fri, 6 May 2022 14:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=8T+/6XoqNMduUbPJYyEpVb6X9u3ddE2U3YClGhuBphQ=;
 b=uf6oDEQw2jaBDgCjCwlF8IDSrfTPyhwGprt3sHCWmiTZ8QHfgKHNo9i83CQ8biYlpMqu
 +ZQAJ/w/rlAslgth0jE95wsMuykHucUgGLalQ0m4BackmTCf8MhV0Z3Fa3AZDoNiiqWw
 BnTHVVhxm+KCPBK+QMHqfYUoo5dw8Nd3nw+GbjII+w6UWjV10r9MXzFZU8eRWKK/HhAk
 cSPex3Df/9h0JUZsYsfgRPAIgNZLmwww2j5MebZXBukAwadyxGST2FL0qAOz8laAkuWN
 smKfCoOuIjBVXqwDn+2XPAHOd7Ld92WwgBOwCMDWfxSdkU8UvT3Nnn1p2ccaiD0sl7cY lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0awxn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 14:54:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 246EVP6r024840;
        Fri, 6 May 2022 14:54:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a8dusn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 14:54:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFNb4KTH63jUXzBZOxHQM6HwwM36sxCI6lAbURCERWqx8777uozSwPkOSoix073zKLeu/A/dxNpE5/bdz4P7bA04lJ6x5PdIH6K7MlL24ymWVbt314VYOQtyrCAWk8adhxSmpfMcgwAnzt5NNjihI6AnyAA0N0CBrISuhPv37Jzvaxfbki2nG5X4fbVmyIiIunbf5TTFPZDSVSQ1Dsm+zDMG7xXsJSXnMxHdwFHG96/eqgE0MC+xRMupzDrEgKPH/4B6GL5i3OswBk0estf9x1z7XXogCZcpGDKsmZJnhLS8xfy+4oAY+swbvua0lu7d380jm9YZ7ith9B9GXXFHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T+/6XoqNMduUbPJYyEpVb6X9u3ddE2U3YClGhuBphQ=;
 b=Si49khX1dQjtpasJSC5qZGTtEpVfAjcxUck6ROj7WXicmFSRT7tDFBknwquNyd3nTAy5cqeL+BgKjzZAvNQhZSqOrL9aPfVriI0zrZ03G+K+Cl1Y6agRVezG0eiGERwhMQDzYYWS/+3u76c4FJYTKvS9RlVcr1435MDiO78FC85HNPPg854Lrj0jJRQ5JNkoFP44wqhHdOglUYWki/mNuRfGw8oXzI0NFjbhYzHtiOiv/fUmmZT7q7Dvk3xKbAXtktCCbvK/uZoKJ7H5Kqx8skTWITMq21Lz7KDlWXbbt6VZz4rdsEZHCOm0zP9iLCi1nCarRAXkTLA3ubBPQX+2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8T+/6XoqNMduUbPJYyEpVb6X9u3ddE2U3YClGhuBphQ=;
 b=db3Cd9vZ9b83UkgSAi2vV3EaYqNOMstKkvxhDL6msMcKNUGBiS2caegU+bveaFv4mHMAlsrZAQzuX8M+XURorhhu8S1winhEz1hg32m6LhUJb4sFZkh/N6nMXZdIi2luYI9RXYIbTMv1frIQ+p4WiTLH/jhVDcOatCFzjtVKL5I=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1821.namprd10.prod.outlook.com
 (2603:10b6:300:107::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 14:54:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 14:54:02 +0000
Date:   Fri, 6 May 2022 17:53:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] hte: fix off by one in hte_push_ts_ns()
Message-ID: <YnU2gHe+QZOAuNyV@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0162.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83265724-abd0-4baf-3e3c-08da2f704264
X-MS-TrafficTypeDiagnostic: MWHPR10MB1821:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB18211D7F8814B9E63F42546F8EC59@MWHPR10MB1821.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9r4SJFQnpDEorL4t4LMagDIn1wts6o1j9lR6wdlRG2HnNpmgmL0sZcQ6LSmlrQ9YWH9GK9sEDuTBGnoVDdI3qKBhfsNoZ0V/PWrXyUEuG//1a2v+wfJ6KtoM2R8xZS4CEUqNeJMtgPkJPEJbgE1b8XP8CLfnTBnIYIFw6f4p+u3p90NS/agQ2XWjAgYNTMJdI1xqB6eaidiZTFVYTxSBHmz/nC1lRcKrabToDFhvdKok42FAxnUVGh9+IlxRBsJSwhFsXCjskv4C9vVXW+Jw9Y7M5BsURCB0kepBlezjraslAtH7sU3YsAia4m/gX8Bhj+GM5iO9pLDq/E81X/9CO7wnN54LzxQI8HdU5fDTGT8hjt+ASLamYtDe5G+e+liXbTnZT3gLiQVslYPn9EYAIZ4edGxkzVj+YpQfKI/HJKDD6oagOOcSKditlKOx9hWV3oVVwuSXE+Fp1WNcWquthIm3kl8EVh7L0K41XIWUca1bx5YP+ArrNXmR6/C1lePp2RsIIHAFqROwYivsO7rzM88+WbaZaTfBDCxnC/wP7WMiS2Y41zBiYKEP71ooUObyXvZ83yn6nl2DXd+C0MAWvZXddIwcmFb0zwpZGobO5x6tSKbF8V58mw4zhjSnHJ8s7Qk7AgZs3R7hRbuDZgb5IJ/N0/26oGq0NfaXl4TigBaVDjguq1DOzXFnQ3RW6UJo5b2qK4GR993eMYaRVcsWE1B+YU29ZX9KCjAVw6MDAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(66476007)(66556008)(66946007)(8936002)(33716001)(4744005)(86362001)(6916009)(44832011)(2906002)(4326008)(8676002)(316002)(38350700002)(9686003)(508600001)(186003)(26005)(52116002)(6512007)(6486002)(38100700002)(83380400001)(6506007)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iJQm6ZxWq9AOfCh/x707TV1vP1GcZLbShEnqaUEfc/aIp9Lt2wWXw2fCAsNS?=
 =?us-ascii?Q?UtmYQcMVSKfKBko0eg/6lVQsaUevV0jpSGQxyH7i8oSOcvoOCQ4zOe14bOww?=
 =?us-ascii?Q?kPzaN7RP3qiku/BGHR31W4DkLbuOkjDH7l3BB3sW4R2xF8boDUFwcJ2u4Vzx?=
 =?us-ascii?Q?HFy5VQxkhIvFUMG5189JUGtBgiXlAwg1HfAD9kM3Hj7DxTKIH/dQJTFWllW2?=
 =?us-ascii?Q?VouVfZanvwBq9NzSt7execdfMLI1iiYbLdY44AQnOCSsSQh/2Rk7QXjAfNtW?=
 =?us-ascii?Q?EsrPOweKqXvouSIYoZ0taPKwLcoigr8r6GqcWs68bzXJQrTJzm0v5jLNSEgs?=
 =?us-ascii?Q?P+p8r5DdTr/Q28qGweTTxWUYhdT9Jbi2yYlq1uQdHq8caw0hzyWHHceTaVUw?=
 =?us-ascii?Q?x64y2aDk06ArTTBKEi2n7D3mYgEv/7DBRSSkixBLin8jTPAJAa1myg9mA+qF?=
 =?us-ascii?Q?1+mPk+klLYa0xL8RYBpyF1RboFGRsqHZhSnQgvcCNRFlFlpCzGvqdwURMre4?=
 =?us-ascii?Q?QSHgCjj9LXjKcowoNSPfzv8PcU461elOCvK7NZEfaiGY0JMTLK2+zp6/IOhn?=
 =?us-ascii?Q?Hp7polivzcym7XybU0A8GXM0kmC4+BcMLzwlMQWG/X2p49R1LdNOdGr4t2hC?=
 =?us-ascii?Q?VXFEyEE9/KgwpKjjBfYlH6xpxeXK5IjRKmOKI9okPQUg5x1L5kkZNNKEv4wi?=
 =?us-ascii?Q?HsK7u2oKmfQ0zRJHlLczvdDPIREi89OmVmuBUNjAsqVlwJS21Gc2vju0Oz13?=
 =?us-ascii?Q?wBw5qVWEpalYypaksz1muAMYQHJ86SiIL7Io14E1Cm8rNBYdHIQ7PSqP59w7?=
 =?us-ascii?Q?q2upkHyiThdqsXr5DNg55gWbmTM+1nUgC4un2Mw2fr6JYhr37cJYxORPAKtX?=
 =?us-ascii?Q?E4tHx5fvOoUzLzQPxvKWaaTyclWt4cTA9i1FXMsfqN7r7cA895Ua3gmgBpn0?=
 =?us-ascii?Q?gArYvwxks+vRITDiQpIVUoNewr5rZ8g9Aua4Wf9Wz1hOz2wDlD0XtFReI2hS?=
 =?us-ascii?Q?m6P4Z7OM6EbUeKjWx3Gmalqs5lhsdgFGgOFGMTotbwtshRqJIG1gBYfERPP7?=
 =?us-ascii?Q?x3deF/qkLeL7dPxeQH1/fza4YpLhc2t9JiUixfVTCIWGuaow6jQJB+Wy9sZx?=
 =?us-ascii?Q?6bYLUmifa6ZLuNOKxY0VuB79ZB0tfK+PVcmqdRKE/aUfXNdV4BwtuJBPH6+C?=
 =?us-ascii?Q?MWU70nJjTl87WJBgnESlvFKCOCTff0m52RI5zPrcv6V3EdDeoXrAgtBHQnG2?=
 =?us-ascii?Q?0I+1XEW0sP+t0RZ2Q7dz7eE3KjYKeQK8u8D1HN4gcfZL5QlV4qcoZovT2rM9?=
 =?us-ascii?Q?gahvzo0cxMuTMKWkOf3Qj2Sio49EMhrl3JlaPmOelRI+7xwVXWmiBAqgh8N8?=
 =?us-ascii?Q?aY4a0FA+jBi9oS88NEwvxG1PDFMR0syy/fMJ88Sw+IiBiLpCEyj5dPAakEHO?=
 =?us-ascii?Q?4d33g4KHADUFOKzYCGB+H2DgKddbdLWssJpVK75ls7BtUSpjFJTx1lhR2czp?=
 =?us-ascii?Q?KYvPpxCgUMHlrcdXL0A0QacEx7yzBOGYO3ZjnjcGH32fVCcdIWfHV3x1NmGg?=
 =?us-ascii?Q?QK/O1jMEnakLwUXjgVBxIoE7L5/lBTpvNENcVEU0rLuhWCuSHh06ZH2+2w6Y?=
 =?us-ascii?Q?nhzPoqKJyTkdnoqQEbIJyfmFrmExZU9/V8M1Y8/CrpfN8dbXlErVTatyVXyM?=
 =?us-ascii?Q?/MpjDNIEGZYLVF3WMQkAtqr9rKF7oJC8BVDAakM43bRBkeWt9tWnd+/3CoeS?=
 =?us-ascii?Q?SG5CXqGC8nxV8PQXbuYRBYOv6p+VVjw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83265724-abd0-4baf-3e3c-08da2f704264
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 14:54:02.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/u+U/FDOzUzCVw9XFysqZXGa+fBCtpcgt8aTl+DsXfgi64foBKtVG1WAjn+bABtUruGZ8ncxhpyFg6kOPwTzqdW6evu4Oj0MLKGkiBtkWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1821
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_04:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060080
X-Proofpoint-GUID: 3VK4PClDEbyVZsqyvDCxRo37BT3kfOi-
X-Proofpoint-ORIG-GUID: 3VK4PClDEbyVZsqyvDCxRo37BT3kfOi-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The &chip->gdev->ei[] array has chip->nlines elements so this >
comparison needs to be >= to prevent an out of bounds access. The
gdev->ei[] array is allocated in hte_register_chip().

Fixes: 31ab09b42188 ("drivers: Add hardware timestamp engine (HTE) subsystem")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/hte/hte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
index 891b98ad609e..a14c5bf290ff 100644
--- a/drivers/hte/hte.c
+++ b/drivers/hte/hte.c
@@ -811,7 +811,7 @@ int hte_push_ts_ns(const struct hte_chip *chip, u32 xlated_id,
 	if (!chip || !data || !chip->gdev)
 		return -EINVAL;
 
-	if (xlated_id > chip->nlines)
+	if (xlated_id >= chip->nlines)
 		return -EINVAL;
 
 	ei = &chip->gdev->ei[xlated_id];
-- 
2.35.1

