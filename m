Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0B4567F28
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiGFG7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGFG7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:59:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5C1EC49;
        Tue,  5 Jul 2022 23:59:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266641V8003649;
        Wed, 6 Jul 2022 06:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=W5/5bG3xfz5Fbspyvd4ebyotfqNosAB13hX5PO6Sqws=;
 b=ULPA91cqmA43RrEtUmiPtbe7Kxs39NT68K1lhWJ4R25Qh9Vj3Xr2A6iFDASoBC+ny18g
 rufNxiks66G8RJg87c71Q4kXMAXVbNyEdVce9vsOlWZk9rW8iOPrWgAJImmzDkXs7aJ5
 akfqK2mnfHqBZY1LZrioOQrouPUiDWRfFA/I2PpxqrVFxn0qD9QDU6ZNykKAO9AevIda
 Zz4Cs53dWFn/Vq45RNX4pt+d/qR6y3eFrfQem3hwOLEwI/7c1di3D6Fw7fyJUzT5AYAb
 URGRFG2KABTpkv6gvYJBe1o7I/8l20lXsFsfYQZNv/XlcIJxBNj1TuxZScYnRjk+2Jl9 kA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby920h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 06:59:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2666g6Hh025538;
        Wed, 6 Jul 2022 06:59:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4udeahkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 06:59:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh6B+FpvL9srPLzkQmm0Qw/eB5XmL/scM8m0gPlL5cHgpSyogOj0Pox15j0AfE8NYxLBGoBkeybqx9rpJlWFeapXDzlTUui4t4YB8Z9TVAKjGNJTEZKA4JeuYYWN+90lA1Db9RRTP/XrOOgM3/DDmVP2I7wbx83qB3IyG+0UKZu1rHh9uceeJ1aEKEKGJr2yIlJ5727SUpQ5GO7eVuiNwx2+uj0FzynZ9QQWgUFQZCjtdc8LxFYV5+3Hp+5rSZMHj43YDq3LomOB3XgmcoG+X3LRHlM3Dtq3zL64m4rP2PpiCbbxyap9mBdN9G6lcTlFNtQYVE3BXVd9nULTSiH73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5/5bG3xfz5Fbspyvd4ebyotfqNosAB13hX5PO6Sqws=;
 b=XFZpuOzUGnuKNThqm2tX/GTeDjjnjDwZxtEmOk1YxOpXOcDXCgRXFuTfdUwg0Jz1MjE0nHyUm67eJ4k/fSyx8Z2fyH9Ijgd4kgNlZQ/lBY7zsyHJZcgqnK5LNe8iOpIjnJ+JWNpVU43L41c+u/XqUlkHTF4rP/co0ho8oQwf5Yn5RCnK5Zgz6UmqjiMAmrOXUKOeumEQNOQCV/COvTMUShRozFxcC970E9hRG9RjxZCwCTF6wR4oB1t99+sJ3y8jViPnF8n2SCk28+7JHdNWc0Le0tKvfykDass8j/9vARzv/IwZgkWDs63MiXoWYg3PTOFFR0cADEf1X3FsyKUxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5/5bG3xfz5Fbspyvd4ebyotfqNosAB13hX5PO6Sqws=;
 b=vK1xs+rARkZbU1LtozcpmsNVpKDAzE5WdWZT7NOmYGW5n4zi9+ZuexWIYMzbWlypWNbUzSYH6hURcGAQROAQy/hlbXaHv6y/0z4E0IGEH/fWpHhUMloP1oYeMTdxJR3gkrIutPq1/kwZ6pyAFIDi2dzdXGTaRG8GAbN1vKtUrVU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4642.namprd10.prod.outlook.com
 (2603:10b6:303:6f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 06:59:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 06:59:00 +0000
Date:   Wed, 6 Jul 2022 09:58:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] eeprom: idt_89hpesx: uninitialized data in
 idt_dbgfs_csr_write()
Message-ID: <YsUyqwe9Caxb6k4g@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0149.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 540cd419-76fb-41d4-6a15-08da5f1d00d3
X-MS-TrafficTypeDiagnostic: CO1PR10MB4642:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+0onICNZ5LEsjpaeq+VYSPOYlYzpYNs/QWh4AhcWnAdq1om+zeOVDs47gW5pPcuqU3m/ewvpc+8K5QANrvZB+WjXhhmFfXmXe9OVIUeL9iXChiV5WPxFatIsC4C8/tLjQVbsfAZhZZh750/X2s+CYrljK6i3W84gzHtJW1h6I49GnzSgAOfkeMX3RYCZJs+ZLmJNobvgo6PNeG3oaTOJJ+V6jLKpW5EGJpq4PPAleFF81+ndwlEbYxBBlxehG6CcwNHJwH0LeteYL3YEIE3CBpypTZ2ssKSOXT6presywyTvDjMfhBokMWXbw5jdvqQjeOA75a1WmIf1wZYZwkQeLlY0+qG82NqBaRfrv0kFTCNku4CscasWC3kEAD7IOE7Qv8RV97NupIJIOiouZl3+qWhEkx/Fc/xGTQQLho3sb+ETiB6YtlcBkMDeQ/VtjGsGT7q7bRMIo7XKHG25CmmNkKxAqP1o7+8Vh85LUyRRg8d6s08nExC1anm961ZQTsTYey34bdK0G0xTN0LRd9iNjxxwo6VnZ8ytOIhyuSATquVerxmialeLshvIZlXdlW8T45Q26T6DXBy3CsvtIoDBcsHr5EI3KnihfRdYpWL9rh4/FQjo7HYpXqcf5bpEQy3hfQ3hrpW7vGxkdUQVvXCQPotVG9cc3s70jIueRe9kfykvxT9orIVE9VhOCttUxtMxKF7t8RDofeDwmxJsMBIVOPhWYCU/d07Bet4Us/e6Zph0WKUg5/S5P5Xuh/WR79/4ChxZQDTwk6kO4hs7bbrUU0Ap0gIz/JSrNxl9Org0rBa0DCm6EVOHULZQ/ZtpyHl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(396003)(366004)(39860400002)(478600001)(38100700002)(38350700002)(6486002)(186003)(6506007)(41300700001)(6666004)(52116002)(110136005)(2906002)(66556008)(316002)(8936002)(5660300002)(44832011)(86362001)(6512007)(26005)(9686003)(83380400001)(66946007)(66476007)(33716001)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jWZK7F/+goby3tJNKhiLP5Qbudy7Grrb3DKjRQnSu4ujIYA6uCCU3sjfLzw?=
 =?us-ascii?Q?RbAHj3uUTHGhXmtrPTs519ULpUS91gbwrdqksHKegIwczXVYd7Jfi3Alfq6B?=
 =?us-ascii?Q?R4Y4MFe+fDmyZU9r43hQLNtJbItl/EXekDFVBi1WCWwqewm5uzoJxQ7vOndI?=
 =?us-ascii?Q?qVdY1AUoQWw+SUO3EfxYTRIK4YeeALhpNrhWfz7gIQMe06JzAQ307f2xeHEC?=
 =?us-ascii?Q?F6G/3czp2f2kAS2V7XTObeM/2VDLqyOjiEcEV1oANUt28/XKtoJF6EOf/+l4?=
 =?us-ascii?Q?3vyRyW065+6lopHfIhbZDge/KS6pUyj2LUTrMoZiTD7BxfTaInSO5Dwg7yvP?=
 =?us-ascii?Q?xsyg08GaCc0dAXwXE5M3txPKzTQsO/WCU8FVkBFgqDku84bYBU/mSgf3QPLh?=
 =?us-ascii?Q?+gUbe8kaaDCm638xjFUQXRHLOpNZvf03XXjGqs7u8q+m6qMvILB9atmlPYK3?=
 =?us-ascii?Q?26KA8lS4iFabXi8k2ztHueDM8gieUW+hLtl4bCbcflzzebEZciUk2wF1U1J4?=
 =?us-ascii?Q?v1AQncZUVT3Ch9g/tzw1n6R26lDtjsNsgMoQ04e7xRGF+WHfffdrIJD4pVkQ?=
 =?us-ascii?Q?VlNj3eS/tshBt/bLFfe9UyVROa52cGYmmFPEmdB0uPlgM3E2NvkHEmXfqSuM?=
 =?us-ascii?Q?iZzaaa8ZJdLrJ5j7srLVo8qpytE5Rs1Uh8uIKznNfkFHURwZKZ7Z+sP5Ocmr?=
 =?us-ascii?Q?Mr85yX+gV7YbxfJ3NWL0KzH4vVejjhjMDymnnM0b1T8BKx5qZ7As8fsibuMn?=
 =?us-ascii?Q?2CvWXJHCY/yARZ9d1GHcavanDr0m65j9KXyqSrEuRKIHi/iJg1tFsXRZGRuC?=
 =?us-ascii?Q?0/TLBuJ+tXHY0WSqrbi3Q1F0e5gnGXEs2eM2JDqrozpAv5yztcpSbeJSC7DV?=
 =?us-ascii?Q?uTsM7Pe2jxo6NFXJtu18I6gGnALppUGnSyurAtsXqBszCk6+eBRC8bZyPbr2?=
 =?us-ascii?Q?RmDO55nRo5DPYeypxxl0PRUR8n32REmLKaDORjyizGL4MEmpj8CPljkVItU3?=
 =?us-ascii?Q?OsBuWhHbCQMuLCYjLwFl3Ex42SERuTraIfsaimgy70I+E+hLHr3pJ9th5n7g?=
 =?us-ascii?Q?BKXM/WXyCQQMsDDASLSn1yInGWk/CeTEb1oI/azFT5lx7uiK3pJboUGCvfwd?=
 =?us-ascii?Q?z/eIk+wF3HAEn+ZkqK6cjYDrYZsRP8PzpK1ojnHOZLEN9whDlQ3ml12A95sQ?=
 =?us-ascii?Q?MR3UpgzVkHoUFJXRRbTQhBuLubSQHioZPPjCJzNlgf3YZGzQImB6dxOWemIU?=
 =?us-ascii?Q?RnlyVsRYRXBfFC+Wn7jdcZFNbRx/zg6UzQQGVVdAOCksoRB8bXsUSc0fNtGG?=
 =?us-ascii?Q?EBYHzGX8tKm43YlEcUmBBtGYSKeMaAi4uJIU7pqsZ2anSGa6+kIrm8ABaRkg?=
 =?us-ascii?Q?CBqo7dFhvderfzXNknsNbMMITf6Juv5MAabhSilOFN9hIMQ+QmkEfH1M8rFh?=
 =?us-ascii?Q?CHrWf6lNxM2NJxwMDpNW45nxoW1UAY1gFCi7b8gWWvP1ptMxMri+fE2cRW70?=
 =?us-ascii?Q?5cdVikb/d97deGQI2b8ck+f1kxNJT7nlcB//0sIgOJwLG0JzeC/FIcyXZw6j?=
 =?us-ascii?Q?wNt9K70NQOQqBFOmmq0exTJsNiknumW1P6Rbnh0FJ91+JpB7zg6yOCxAP71+?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540cd419-76fb-41d4-6a15-08da5f1d00d3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 06:59:00.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEgfrWvc/bMcraeqxxcPFekI3jhbeqbOTd6TlEYe8vHa2aPsJSnJvmaF7tpgLMY/lQuUZeIWNkJoCcFpq3hTSCLfBKznpDs5lzj7BStCkMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_03:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060025
X-Proofpoint-ORIG-GUID: iY0VeFXmldIwG5xE2o-SUsi3A9Qu2DMw
X-Proofpoint-GUID: iY0VeFXmldIwG5xE2o-SUsi3A9Qu2DMw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_write_to_buffer() here is used to copy a string from the
user.  However the function call will succeed if it manages to read
just one byte anywhere within the buffer while we need the whole string
to be initialized to avoid using uninitialized data.

Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index b0cff4b152da..30e146b32205 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -909,15 +909,13 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
 	u32 csraddr, csrval;
 	char *buf;
 
-	/* Copy data from User-space */
-	buf = kmalloc(count + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	if (*offp != 0)
+		return -EINVAL;
 
-	ret = simple_write_to_buffer(buf, count, offp, ubuf, count);
-	if (ret < 0)
-		goto free_buf;
-	buf[count] = 0;
+	/* Copy data from User-space */
+	buf = strndup_user(ubuf, count + 1);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	/* Find position of colon in the buffer */
 	colon_ch = strnchr(buf, count, ':');
-- 
2.35.1

