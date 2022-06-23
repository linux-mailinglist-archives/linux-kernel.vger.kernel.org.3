Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337DE557D29
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiFWNkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiFWNke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:40:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A5C3AA6C;
        Thu, 23 Jun 2022 06:40:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NARZXQ009478;
        Thu, 23 Jun 2022 13:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=m/BbruLwyuRao1lgeSfYyh1m6hUGxjB01WsNqTbfU2o=;
 b=ruzxSfWmbQPIbm6PUavZdLge7XzXhd/HP4FW/tPjyqlzvbgb0vMPpZWnop5ic4Ly1kz9
 TZI6oF+sbyiu3ej8+jCs6oQ59pMmJrS+pl85exLNCTVyy+Am1+S8/lo0sHr8gRSZTOj5
 Nfmgp7LjJEsFQ8RNujDw8lmMjualb+6MstW/zzWQavlTXVU/bD+Ksh0d13XAVwWcwrnK
 BHfz2la7gudpckQq7czuXCjrIo9/1Tb9TyT3yQUXLdFWb8rSoCMSczwP/0V/C9t6SzWn
 tuEIyy/gPKDzf1M39cduVlJW/vSdzGOG0aw2q+t56lape+wBCEQih0MnFcpRilygYUoZ Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g2396v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 13:40:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25NDUmcC033165;
        Thu, 23 Jun 2022 13:40:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5wh0a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 13:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs62j9bu7HbZKtT8KBDI8CxgjZe9ohYkTA0GthNqrqaGhhzAXgjX9krF03j5xkkHvCZLKKRKN6IIjPNAg8XLA0HpP2/AhkeNcBnYLEvQHzdEb8I3mOTTxapjfp1DcXJCB2daO/Gk7+1dv6usP2426EcSghIo0BLhU87QbvPh9A7hv/tRtW/MrSLXipyBp+1qvdGejqb6jxCQ65vPkfbZBk8Ijsw37+st6n55FbL0iH6QfXowo/+REm5phydok9d/LxpZhm/Kn6GwxxKS3ekVMz9Ogea8hjrA8/ix502k3t+8iJClL5AIGMBR8CF23/PcBIBYLzBElwRQrZQlnRdFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/BbruLwyuRao1lgeSfYyh1m6hUGxjB01WsNqTbfU2o=;
 b=Amj9vWVTSfnFXaAL/4xkysK2mv9+yCw4RhUpsj3NMfg87iVyGU/LcqbR3TVlXXLeTtwtU9GOMUvXy4q1V6PhJ1f+3j7oYp6pr9XyZnKCO0mvU1wsSx6vMs7zp2UD0oUvclmAqxs8wSNtL5pCZHO4dnHiT5tIECsQo4B86W6DhyjcSDb0FUCCSb4ckUtaTwQhgGmMIkVbQ8W5iPBKiqG4m5JrhghMOBwLtkiv/DmzDsiELzWWtLh0VGIJQEsp49gAHwlT7S1ESgkPu9aA3hGR24iqaSYMgX3G0OX8SqYruYJmE7gwyxRm9jr/VkGaID0pt+YZ+woVb7zuJpoO75P7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/BbruLwyuRao1lgeSfYyh1m6hUGxjB01WsNqTbfU2o=;
 b=Pd/pdOWkmHvWz4bBA2L7trCtFI75XFbegFZ9DdsgWCxRYtdvv/xDcOY1Jbu78I+c3ayay8CpOgadF7Cp7VWEc51xfOD8fM9pJV0fuKdr6GXAR5iEOmr8Ce2Bk8pStFPbobfbvZe466amvoG7545IXzvAl4VLCQgzzkdtmTwSizg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5365.namprd10.prod.outlook.com
 (2603:10b6:408:117::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 13:40:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 13:40:24 +0000
Date:   Thu, 23 Jun 2022 16:40:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] pstore/zone: cleanup "rcnt" type
Message-ID: <YrRtPSFHDVJzV6d+@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0124.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92cb79cc-fc31-43b3-048e-08da551decae
X-MS-TrafficTypeDiagnostic: BN0PR10MB5365:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB536597C0DE4F9AA5CFF5006C8EB59@BN0PR10MB5365.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIUTRO/ULiV2KiWIZQjWg9UzzyJ80eZdAWb9gfDK4zk8KWn9Yh95RJOmYjzZfKa8Q7EeTS7IEgIThq+viGpuLjBzsfpXh7LG7s9tCiSmNs7/RfDmKjnDcBbpTZZZ9GJmSnsN/6+Hgrw1PEWYbEg1tpsXnOh6RP485mk/XdVPCJNJ0yMypIItj5zLKgcuhihxLR5W7eVtnSrSApPN2eLLbrV3aAnzDFEeLY//7CMgLAtxR+ZeNaupxmfNfeSY3ePLLCZbtI748kvSI2Zi6pLRjTVX0cBv8dIQ93Yk0iWNkwUkz21aMJx65nTRWPMWgVSk3HOdaLqUG0xg9WaeXirkG/OiX5KElKosi/ANS2hlJdAih7ih1ebyqHFfz7p8shNMUrhJdfE03aiCZWeDMtzFZXKz7QKKdrC3T86Zsb/zEouyWDM5EthdgfBA0cWfrrPx0gcC8hslfAPb72PVHfx/s9wh4IB8TAtRM/ABHOLI8oJ4YmJvimX2xn7sTN9ekrOYS+E+jezHDbWvdqqUupyayy7R3iIUii+LI8ca8IKhSvlslASolzu9hTI5ccqPY9DHqNnhbQb4oFOOeXFzZ6u/h3BbFpT4BT23wYFjB8mxDLN+EAt2CMAbUs/0DSLq7JlIy3ulIUxsRVnZx/mxkFAWD1WScqxQjnHKv27lJYxn1D++n2xZnp65qddE+jyXlnksxzvm1Poud0HvaMWTKd0s7QKbgJ+YKPMBAxfa1Qr0Itx78eVerj9oqTEsP75f/1Nvo3GolWj+HqtKDOgE7YB6aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(396003)(366004)(39860400002)(346002)(4326008)(186003)(66946007)(66476007)(33716001)(86362001)(478600001)(6666004)(44832011)(6486002)(26005)(41300700001)(83380400001)(66556008)(8936002)(5660300002)(6512007)(2906002)(38100700002)(6506007)(9686003)(52116002)(8676002)(316002)(110136005)(54906003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kMSjYDskgwcvAKnfcXwiSYWVsqjYgGsZEo6HKZnKHt6wUlBpT/OSGfoc25Oz?=
 =?us-ascii?Q?rL4V0TMR+tJ5vNHrZ/Y/5zAdajdEFtGaniHSabymOh7ydgLUA9V5AIIo2zgP?=
 =?us-ascii?Q?Z2+pRjITkHdnhVozQ9H1nOOhqIJcRa7RNzqhx6oVMDo5kbPsc3KydV4+CB6s?=
 =?us-ascii?Q?gfT7F5VjDRW9YDHj2pk1h8Q9SwaKIvvLdjLdIJ0xkN6rj/9iubP+yNgCAXD9?=
 =?us-ascii?Q?Q+GJFu0WY7JYM/7Pg1yw3k/M9Ifn8jrQE8pyQt69jM3mTXZnaof5vqnd2gcJ?=
 =?us-ascii?Q?1aBT1U+tctjyo9N9WffBz2Wu0xXL31dbp/J/6s2SwHIJa+dSrQJROQElfDGm?=
 =?us-ascii?Q?lyWQ/PdgUO/FMFfG3HCE/mLBlKrHKsgycDGHIWHNPlzHBSKxfYga8O6F+U2E?=
 =?us-ascii?Q?8iHhr2NwPDt/9QQ2YgJ7OpKmIsXxOEw1eU6/0mXt+WSNEbN7fJuotgKiZK0N?=
 =?us-ascii?Q?XKBr1xMGg5e1WI1whSXLjraTsthEeMnwlRyuHri3CAD1ds72rEli1pQs4g0G?=
 =?us-ascii?Q?4ER3bpAuYpznPr3JvO1QBYc0eXiPDzZeimGhi/rVftuGARe2yypLFezF8eY8?=
 =?us-ascii?Q?pBs3KecgBm7t1tyThFthPdOrgKY46xJ1Joe12EvSirQBCYYbpUBWHyAnFmym?=
 =?us-ascii?Q?bycsk1QK0kFSnDkiJ0kKi8d1dJQ00gCEvptWxS5ToX/+I+89Z14dLdIsYKiC?=
 =?us-ascii?Q?KnkpVKKA5dKzmSksKn5gwd9zja53FUR8L6kTz/WJ8Ccdqe6v1wgeK3hrHriN?=
 =?us-ascii?Q?16DOqm2MQXgoyXHEuplqeTqaBQv8fFvFzx9uSHRw9fMaSqS8OcFpmhXnIGVP?=
 =?us-ascii?Q?WwYvaVTfj+QPODYgsKKhRi0Pke6GsieBojNK6U5W04Jv04VYztjMhCdDYOnu?=
 =?us-ascii?Q?WNCwkdWkdwVCvC8l9PbRC0+W08o4ZsasPtd6jAag4GMZ9/iqU9rsUF3JvcFg?=
 =?us-ascii?Q?zmbnAp/QVZBTYAiqseQiVEQNGzbMlp2XJQYjJC65mh4xyfyVugQ+C27QfqOc?=
 =?us-ascii?Q?uJb8EQwtHtEoMPisB9fAO+nOoMlRpnXS3hg3dLhTtmt1spurtFX18WSMG2MU?=
 =?us-ascii?Q?t5Bf93HFcs5fXDaN6qUN2oS8cJDSllPQWyeXhkKkpwGrzkDAu7dAWRCWw9oY?=
 =?us-ascii?Q?AEEb7hrXRZ9fAiYo8xhGHIyTkIdi5525uGwiWItZ6LwjBLMpsjlKBGyTalGB?=
 =?us-ascii?Q?ygmoeAHXsyQYmX1CNU99LhqMbwxef0rngEJuaUuIVOuH0PWJoulR8G2/Dfwh?=
 =?us-ascii?Q?tajjGQXFVhg55ozBiDIxOFEji4gbIwUfUSgFWOX1SfxtYYIK3MzyGnreeYMZ?=
 =?us-ascii?Q?89vDToKmWUofL0ihAz2Cp7LuMnCs2ojOZbLj5gdKnsNPYqQvG1AhseP0QS4F?=
 =?us-ascii?Q?5d3J7SDv/KFPM8+CcqpXWcf4lxzJVs6klBk+pyu7uk05MUuQuhnY7DetV6KX?=
 =?us-ascii?Q?uyMwvnx1zVQotkexLgDVI+Nd2UTTVVeCjvAVu9AZokqkzR5vPWpRD8ew6OPY?=
 =?us-ascii?Q?kk626+/AHgrAnj0jQfwl9DwouyYO2qx+Yd/oMaieVfJLsFg6WKrvYxta73GA?=
 =?us-ascii?Q?e1IQZjuwoBNJpLMnF2k8Hl5WW+eNcmFnwYk9VP82rlP4iAjEvzGw4yMRkjWn?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cb79cc-fc31-43b3-048e-08da551decae
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 13:40:24.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQ12BOI1YNAwwwUcZOf8PKC/PTFI3PveexSRjOc6zLSGMS4inICVkSYkEXzEqhVrY0OGHV+sfOa6ac8KzLY2YAoi+66OF9z61mHmY74eeXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5365
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_05:2022-06-23,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230055
X-Proofpoint-GUID: SVBHdQ_4QDthjHpPahkhb1i3gqsGQ85m
X-Proofpoint-ORIG-GUID: SVBHdQ_4QDthjHpPahkhb1i3gqsGQ85m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The info->read() function returns ssize_t.  That means that info->read()
either returns either negative error codes or a positive number
representing the bytes read.

The "rcnt" variable should be declared as ssize_t as well.  Most places
do this correctly but psz_kmsg_recover_meta() needed to be fixed.

This code casts the "rcnt" to int.  That is unnecessary when "rcnt"
is already signed.  It's also slightly wrong because if info->read()
returned a very high (more than INT_MAX) number of bytes then this might
treat that as an error.  This bug cannot happen in real life, so it
doesn't affect run time, but static checkers correctly complain that it
is wrong.

fs/pstore/zone.c:366 psz_kmsg_recover_data() warn: casting 'rcnt' truncates high bits

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The static checker heuristic in this case is looking at ssize_t
functions which return kernel error codes.  It generates very few
warnings.  I haven't published it yet but I will.

 fs/pstore/zone.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 7c8f8feac6c3..017d0d4ad329 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -363,7 +363,7 @@ static int psz_kmsg_recover_data(struct psz_context *cxt)
 		rcnt = info->read((char *)buf, zone->buffer_size + sizeof(*buf),
 				zone->off);
 		if (rcnt != zone->buffer_size + sizeof(*buf))
-			return (int)rcnt < 0 ? (int)rcnt : -EIO;
+			return rcnt < 0 ? rcnt : -EIO;
 	}
 	return 0;
 }
@@ -372,7 +372,7 @@ static int psz_kmsg_recover_meta(struct psz_context *cxt)
 {
 	struct pstore_zone_info *info = cxt->pstore_zone_info;
 	struct pstore_zone *zone;
-	size_t rcnt, len;
+	ssize_t rcnt, len;
 	struct psz_buffer *buf;
 	struct psz_kmsg_header *hdr;
 	struct timespec64 time = { };
@@ -400,7 +400,7 @@ static int psz_kmsg_recover_meta(struct psz_context *cxt)
 			continue;
 		} else if (rcnt != len) {
 			pr_err("read %s with id %lu failed\n", zone->name, i);
-			return (int)rcnt < 0 ? (int)rcnt : -EIO;
+			return rcnt < 0 ? rcnt : -EIO;
 		}
 
 		if (buf->sig != zone->buffer->sig) {
@@ -502,7 +502,7 @@ static int psz_recover_zone(struct psz_context *cxt, struct pstore_zone *zone)
 	rcnt = info->read((char *)&tmpbuf, len, zone->off);
 	if (rcnt != len) {
 		pr_debug("read zone %s failed\n", zone->name);
-		return (int)rcnt < 0 ? (int)rcnt : -EIO;
+		return rcnt < 0 ? rcnt : -EIO;
 	}
 
 	if (tmpbuf.sig != zone->buffer->sig) {
@@ -544,7 +544,7 @@ static int psz_recover_zone(struct psz_context *cxt, struct pstore_zone *zone)
 	rcnt = info->read(buf, len - start, off + start);
 	if (rcnt != len - start) {
 		pr_err("read zone %s failed\n", zone->name);
-		ret = (int)rcnt < 0 ? (int)rcnt : -EIO;
+		ret = rcnt < 0 ? rcnt : -EIO;
 		goto free_oldbuf;
 	}
 
@@ -552,7 +552,7 @@ static int psz_recover_zone(struct psz_context *cxt, struct pstore_zone *zone)
 	rcnt = info->read(buf + len - start, start, off);
 	if (rcnt != start) {
 		pr_err("read zone %s failed\n", zone->name);
-		ret = (int)rcnt < 0 ? (int)rcnt : -EIO;
+		ret = rcnt < 0 ? rcnt : -EIO;
 		goto free_oldbuf;
 	}
 
-- 
2.35.1

