Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E843951BD3D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355722AbiEEKdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355767AbiEEKdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:33:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA97527D9;
        Thu,  5 May 2022 03:29:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245A6IRx018740;
        Thu, 5 May 2022 10:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=TMy1P75lfbe3ZA2WEfuK6q0gvVjZmG+8D+erNgZ2lyw=;
 b=dkmzjf4xj+BF+oDkZecPxkSrl5jCj6W1Ed0fv0inmoBP9gmFRRF/bz8rN1WvlIZnEIIK
 BtgKbXknZTT+IZ46pi0QkKCD0IsjG3UcrCI9sEzVdzJANAlEd9VQTPYBXu59TR9XrA4o
 t1Iu99dlNCPUHj4Bm19TbT2pEeEYAsv2M0tNJZu88sVxsBhu+Dn23IXXVRPv9Pb/3XH8
 fCN8PEwR28KYlzNrM75uYKySg2nqRYCR/ZwVf+7DHl8v7xtXp1MdBZot6ZMyiDTX6ngV
 DKpiioS4EWFIf4J2ZLnnAH45WxEBIAHjS7V2E47kDNBYtgrD2sDzJEui6Yry2vmwpEIo kA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwntb0mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 10:29:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245APNki025778;
        Thu, 5 May 2022 10:29:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a6sh5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 10:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDlRBFQGICkEyY2e1aMFdhpoar9Z5CjqggVbya+ZrAaT123RI+Ee2gru5bU2QvMPkthVMO7CWyesxjCJ/4oC/Uy3kvB+4IzBim7zO+pk6qagtdujZ18dFKocSiEqke6onX02xR5xDDg4BPV/exzNWW8QbO3Pq5SrUFVA19XAmws5RZXy/QyVNc+0fdGljY4eC3+ylPmYQfvjzUXKr7jY/1jQZqh+GOg84Eqbdh27Vg2laF8XDoyaALVl5sUnc9yxiXMC+sFiTv7BytGt4G0JJaurW1D8afnXESlFYr3EQwr+GXxPAQ36s+OxGGoZM1sMMiOSpGpMtwW0F09oB5H8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMy1P75lfbe3ZA2WEfuK6q0gvVjZmG+8D+erNgZ2lyw=;
 b=fEbFt9AGWVgLgjYEiiJfq0OGarsGRaIZFSyJDN8jlLHSjzi5bYMaUcZfOufw51VrKpRWp31GVtvKKC3UABTkQv7dAimusT1EYY9DMeBLDbTC/HC+6k++PzGeVu3zJOcwZW2iUURudWffB2WwC/yGRXXAiUgrFEj1YS09XPO5mxeCqvP0H1GYwLS0D6QvDKCheeelwf4d4BglwHRxM3j71t8ztTL64uBgz3tsNr7VotSn6dac3S+eskmJaJ5O0lqsn5VcdEgAQdbU3gNas84v/Ny/YNFNU7lj7ILLDQXKb9OIApiBkWnptSwAzvkj8gTFK2lEdE2eUGttXVeWMRrwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMy1P75lfbe3ZA2WEfuK6q0gvVjZmG+8D+erNgZ2lyw=;
 b=FOj2DNhvtBPD5xxoCaUh7GoddHQIlPjetluWhPHLWgu1Qk2sMEATArP+737CgciAbk/MAVniwl/PtSsliIzG8q6GP5G0hSPOZAaKkF/Mdk7QIeBTj97/EQdIHfvLiAwRLpyDoN6hGS8kCkvLP/YVyW6cLhh/e9yB2bLVc/knt1U=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by DM5PR10MB1836.namprd10.prod.outlook.com
 (2603:10b6:3:10c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 10:29:27 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e%4]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 10:29:27 +0000
Date:   Thu, 5 May 2022 13:29:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     Tianfei zhang <tianfei.zhang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] test_firmware: fix end of loop test in upload_read_show()
Message-ID: <YnOm+9tEN+xerpov@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0160.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::18) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92f551e1-99c8-4dfe-5616-08da2e8221c8
X-MS-TrafficTypeDiagnostic: DM5PR10MB1836:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1836F6F184DE8C645683A6BA8EC29@DM5PR10MB1836.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vaj95zrUcHehXhGzpsd769kPoUAQSSUGABvBD8jLxjFCKLUwui8eH5kcvckstPSigtqkhO1O36fkiM28eR3sRN6Dwbry+lvwrvCh9iY73KtSH8nge3vgkp7Vot7tN4ImrzDOGYBYR5AXAZQzQKN+pXjUgSSN5djU7vMkuB0iW8n+1KW27BpfNRuaLJzCU3EIAC5yEJFbz+saUF6bvUSVdU2r3dYxAD4QqT/FhJleNk6T+zmxWKc2ds6azDwZ55ny4IQz61LAjGLsm7ih9DcHihHIIOzbkS1ByYLqwMkxy3pnBtjPir9f4wvXFAygRQou9hUSZvowEAhT5cBHMw950V7vJaA93bAidU1Il57z1CorC7/22bKKDl+Nwp7cJHan7DbXOO6PpWiPUKSoOnyw6bf7Fv54rbWe54Vy0UOWjiFQl/OO1lG/0q/Ab0QQfqtqgs7Djv/tsH9tpIpAHc3lPfS0yMrHjyoIoF3naRTEr8sf5t8241GUVCR5MKKBuDgxj31vm470MEtXeFLRg/z7rKuo11qiuMItWsUDIQQimcywAEd8XSf8q2q1mMgRWMSXiFk/a6Ba1O449XWWddCvRpWQwirsmIKohy+FzqczYRprmAxFUTa3BZUhz4H0cUYuuxnXVWbWpUpPCJ91vpqQGQUu1HugqyHVWVqL1e9pgOfR41e8EO8BC80QzBn2Bu9wmaAOT4JnbYBYaU2glHkY7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(186003)(110136005)(9686003)(6512007)(86362001)(508600001)(6486002)(26005)(6506007)(316002)(33716001)(6666004)(52116002)(38100700002)(38350700002)(83380400001)(66556008)(66946007)(4326008)(66476007)(8676002)(5660300002)(8936002)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k1dOLqy5lO+vn2PySYH82Et1G+uzpKs0IZ2XIdyOJ2urr0B5agOGPPv16cBq?=
 =?us-ascii?Q?cwRMiQCkTA/vGk6W5NaHunGtaqZYSdS6BMky9iIwmtU4Fdhe6dDcRuvc0KvL?=
 =?us-ascii?Q?BjvVDjhKGWbuvfYoJBzX1LdzGwjnDViZNdeNK97j3XJUB43X/V7V9diWEmth?=
 =?us-ascii?Q?qMRaj+6V3snev8dpPhB+NS+NAYESkDPyIYUxenzqxHrWqv05+IEgetRv7YwX?=
 =?us-ascii?Q?3CupudHk3zECuNKAz7D8DKdSVhSBOgVu3pIRC112p+hKIcdgRMT/ez7FyV4l?=
 =?us-ascii?Q?X+xJC7ZeUGEhJPhNJRwSVneUQUawrJgJ2Y/b92L8KpD6B2hK4xCN2Oe2gZwE?=
 =?us-ascii?Q?YxTf3whiWoeAgL6S67w+FaV183QbI/3mJMV6nPO3RGq9UIT5QbhTuDiamnIh?=
 =?us-ascii?Q?c7i2NFSCLzc/rD+OegHCDx5ytghOC4ujnun2beGvN0NGio/DXQSmAjwVXa5g?=
 =?us-ascii?Q?8TerSOnRmLgixbW19HFv/Z1MXdBy8m+66ouD4d4V69kxxTxINWEVRJeftyO0?=
 =?us-ascii?Q?6Adgo2wDEvLqogURD1AwWNqV6gHhCJJYoqFtZQAAI5mDwyAQ14WWWEc97zIa?=
 =?us-ascii?Q?j8Gs5hXqXBE1K9aI+6sLbNtikFqNsxlG3ib3hqJAHXrW9rclXd1XK9++Xdih?=
 =?us-ascii?Q?w+Iz1L1ERzE+ef7feE/y22W0U71vOtwmMiFC7o28V6SvaRvDFMkVhquln1a6?=
 =?us-ascii?Q?EoSmLv6AblsdrY1S47OwqMUu5b9ppIaWiIyUXA0cHDK4gFdsIcZcstQSMEr9?=
 =?us-ascii?Q?tgQY3Jh709DSNq+/NsAJqkNI/nfA3pzIEGwlLTdlCtLMI+ycQdKBUYHU0jS9?=
 =?us-ascii?Q?i4AUlGJtiQZIZO5ARhRh+fMsUcQitU4ua4RB6ijm6fUv3r+O2MTF2Wdc+Vr3?=
 =?us-ascii?Q?LrsJA/dxI+jxu4NLeauSi+Ag+eD5n683zR8QFnEsnuxgMn87R8azPfDWskYg?=
 =?us-ascii?Q?sZp/YV9EwwtZfXVCYXUkTRhwv8V+A2RUvYj+ZCPzhLj6NWrXydDqWgf+YQDu?=
 =?us-ascii?Q?N7ZdRiKazikrWCZeWTg3gP34kN9RftiZoUsQ0AzsmhlbZh5420D5lnl4J4uH?=
 =?us-ascii?Q?i8xuERyyKWx1G1ntFgi7ynLCidp07NFRmQTjLfjaAs8HMtNOtK8R9A8bSfkJ?=
 =?us-ascii?Q?DiHSUlmKRo5+EY2Tgay1rbwmCv5D/Hyohwy5/NdNfHWoeQNkTaTURfOX6mqe?=
 =?us-ascii?Q?4oGVR77CRGBuFex4qO41LIFIfQUhfR1b6xV6LcbOMJrsqLbbUUpiV4At2gm/?=
 =?us-ascii?Q?LX4hslOvfHpJiHH3S7PDN/0r6RAZZDtcTUTXlF1FNrszrqLT61a7KpvUuGvY?=
 =?us-ascii?Q?3H0iFLdZDvKb2QXJDyD7KM/PVQz98BdnPYE1R6JCO9ti11nhJXqqRgt+K48M?=
 =?us-ascii?Q?g4ejC5g6L1+RrZZiuPbISIiVd88WV2No/uRcU4uU4M6zMCwpvqAcc8VUHOI3?=
 =?us-ascii?Q?XdJpxItiVCMzphx6k5epD7EU0oRN+Gd3wEVzq7XtbBYocArmax+s/TzdXRiF?=
 =?us-ascii?Q?JOHYVtQ9RhGqsGsj89CIonSqZXhi7h2bos6YvNLxKfM4N185RzH8UADVW8LW?=
 =?us-ascii?Q?yy8aqlA8QRiA8b1GAwRU+I5m4gsFiy1oHgtDBNUfZG7BliC6NW8q4gzZBUBg?=
 =?us-ascii?Q?rDQ5tJHeNvO+dI/McFCO62Ij9+oSbgnP87ddjyy7Je8col8u9AynmkZRdmHV?=
 =?us-ascii?Q?Pjzm8XGnXD861YrtUSASpJM1Py6wwB/v6d7PdAXdMgKhIB5px45qeL6SDbxg?=
 =?us-ascii?Q?ld3CtEvIMn3eP47db4Et5Dli8f4ZzBM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f551e1-99c8-4dfe-5616-08da2e8221c8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 10:29:27.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWrycw5X25BsF1NBC93Aotk525jlOlasYtxwY2c/+llxH7szmbMsQCbDEEMB+dbLvwqxe/TTof48qqZHJ2QR2XLmiojpCfbF96Wep1sUtQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1836
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_04:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050074
X-Proofpoint-ORIG-GUID: yfeT_Io4ME0sB1CFFYgPQc7Nk51gFcO3
X-Proofpoint-GUID: yfeT_Io4ME0sB1CFFYgPQc7Nk51gFcO3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we iterate through a loop using list_for_each_entry() without
hitting a break, then the iterator points to bogus memory.  The
if (tst->name != test_fw_config->upload_name) { will likely still work
but technically it's an out of bounds read.

Fixes: a31ad463b72d ("test_firmware: Add test support for firmware upload")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/test_firmware.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 76115c1a2629..c82b65947ce6 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -1392,7 +1392,8 @@ static ssize_t upload_read_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct test_firmware_upload *tst;
+	struct test_firmware_upload *tst = NULL;
+	struct test_firmware_upload *tst_iter;
 	int ret = -EINVAL;
 
 	if (!test_fw_config->upload_name) {
@@ -1401,11 +1402,13 @@ static ssize_t upload_read_show(struct device *dev,
 	}
 
 	mutex_lock(&test_fw_mutex);
-	list_for_each_entry(tst, &test_upload_list, node)
-		if (tst->name == test_fw_config->upload_name)
+	list_for_each_entry(tst_iter, &test_upload_list, node)
+		if (tst_iter->name == test_fw_config->upload_name) {
+			tst = tst_iter;
 			break;
+		}
 
-	if (tst->name != test_fw_config->upload_name) {
+	if (!tst) {
 		pr_err("Firmware name not found: %s\n",
 		       test_fw_config->upload_name);
 		goto out;
-- 
2.35.1

