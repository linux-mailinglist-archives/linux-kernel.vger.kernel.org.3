Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0D50DF93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbiDYMA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240958AbiDYMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:00:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0939E3AA51;
        Mon, 25 Apr 2022 04:57:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P9Oapr031660;
        Mon, 25 Apr 2022 11:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=NExckPS3nDx/+Z+cUuyzjQ2+gdgP9zjSqvteOMmXLyA=;
 b=i5yVs4N1hhOrmmnocK7MOkDSoEsSzzBk6uzPuf+dlVCO54owwDbv2yIfSlEFCPruNNsr
 8xEIrY3EelVZm/VeX4WQTsOzfXJgtjX6265ioOMCRDDrY2oOxJrMOYfFUBtsIgR3fv/z
 Rm5wAk2L739hgkt8JHiAkcGjeLhoqsOrmzWraAEqOI9xmnznxvUDgjOYKgKkXFoxtDm1
 QDYbO8zEVWzsCOQ1TQLlQ9IcH1TkwVb4ZbWBsVYEYKm6ug5mdR2hmuBClHT890UKAk+s
 0fAhfd6i/9AUMLVndIK7y1DBTOiavzDemazDACnLmBjcwJTzNfjqvh+7cdZS3L9yu2cm Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5ju02f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 11:57:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PBsvdP004747;
        Mon, 25 Apr 2022 11:57:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w268kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 11:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2kVqZ3Bl0vE5G6ioiPSdLZJtZIUXZHYLYEME7HmwSEOMkRVZ8xjz+/edl3Umlhihsn6pCQTb4z0mxI+0JsGiXCWVBdbGlkUKkZIOn9wpdjHr2iLIgsLXp/tysBY0nyCVeQJUaHLDWUJVsjy1YWgIYtS9GfsR0FRA5+vfbgO3wFfRGxJ5rbSFCQUnXmW5plJYX748N0NxrILKdOGo2IGD2TDEJcz16r6XYr92gL6H9T5zo9/BTgRyDSj/NzFMqu3J+eFjsj3M1IGGNM34izaBLItbh1Jw0EWkLzrd+Zpz8PmMvxHA3i5JM8bPrQcvdf6Rali6ArjGpYexXjLiX4P4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NExckPS3nDx/+Z+cUuyzjQ2+gdgP9zjSqvteOMmXLyA=;
 b=V6Kx5oBT9umXziqAh6488radzYeMIGcj8qQ6j2brGvVSwjTO0DH3IdR5yzlQmwpQilDelAT80AYsB++ttUfnYK62uhT3R8q9E74m0ZhtFNrN38+O9FYRD+7EzR3P06oBJLhEIT7wYHPyJQrPu88H7PCc9jIy9z0UczrdzlkLajv8kE0WdQDhqh3Lk+1P3VTWdPe4D4XCOiP9Y3HgHvmGH94OKi4bi3oaJ0b8PET7xHHRKLH0ZZmxNnZdqEmMnW/RdwI1FLqPs9m/6rTWkaIknhkRXMYs28ZE5sn3VYIqGdZYxoAhpbHwikZEZexuhC6yHSiVaNN38ghjnKiA6RqHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NExckPS3nDx/+Z+cUuyzjQ2+gdgP9zjSqvteOMmXLyA=;
 b=gplEUlFzWAm1vcDTekcJWypTjN954DcIdzj72+jTvlQdLAhctKCNo67ccTKxHJ6NF6S33S/4G63J3p4eULXHwmgm3Ma8yVmavavM7NqMpQOz9fb0255Oq36jSI03FcFABavw7ntuRUs+NgDyZKu7j1mwv7Wfa5pakmZ+GMo2LCA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5126.namprd10.prod.outlook.com
 (2603:10b6:408:129::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:56:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Mon, 25 Apr 2022
 11:56:59 +0000
Date:   Mon, 25 Apr 2022 14:56:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Milan Broz <gmazyland@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] dm integrity: fix error code in dm_integrity_ctr()
Message-ID: <YmaMgPr8bM/0PFUi@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bf822e7-7b71-42d7-61af-08da26b2b3ee
X-MS-TrafficTypeDiagnostic: BN0PR10MB5126:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB51265CB6EBE8FDE54D7F6CF18EF89@BN0PR10MB5126.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uf7c9gWcht337zbdr5ZpNqP8Ri0MlPTSmny1SZRoyp95AkQpZ7LCEWqzwwh3QVgtW8octZBxZk1qGFpylT7HZH+hLhhEPlkG05I0BPx/joWcnOaIAzJWSP4817D9OMv3cHqeHBvoqdUOE5AEB2PCucWWQSMF9HCAwfhwhNtsfr9D3yX6B2jLtLl3RZqRr5aPTt0LURYnFpIQVIFfP2EHW6xhuArhp3hSTLB5qW5YIdhCXIFZmds1sXe2Ykp2DqjblOwCcxYsXw1sO6K36IiUEgBv55wX9DgR85sIRgT5EQ9dSmMelNOVSwHHCWuwdLpgwpTNrIPjR+J27mk5IU4/h+zw34Ez3CTDDECGBLTDf1LHGHvYl905JTrsCY9qpj04tBS8nNUo/s3YJBkwB7rasbGHM5eQ0Jy3DO7cdSj7w2TEsJhwCVQnZczOjgLPyGKgnFgYFRZPeCHLG4yRfUduo99MM+TSF0CB866d31dA+HRroH9V7zmr6wmuHASFBjefbI/t9hjq6zchMIqKXLUv3cCOfFf7jQfgfOBsWX/aOppKuE+kx+0mx278qGCPAiHhCOA1+T9N/Sr2AIF5IAxfxVfUxy0fhXlmWjIvWBZFu4PA1kQjVTtW/poLbISg75f3ofhBl3V3ZReP+wYwCPIvzOr12sZdibAyaICzgb9ZXZSSyBUNdUeRG6ELM8NZqgL81lLrMC6Dy2tvQNOujjkTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(66556008)(44832011)(66946007)(316002)(4326008)(8676002)(52116002)(5660300002)(8936002)(186003)(83380400001)(26005)(6486002)(508600001)(6506007)(9686003)(6666004)(6512007)(4744005)(66476007)(54906003)(110136005)(38100700002)(33716001)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IlBpg61Q0vvMk9rz8LJmgFaC1iKwRlzI1w5CCHO9hOakSF2MMduOzNYCXPz6?=
 =?us-ascii?Q?rSIrXlSBxuPK4zz5jbfrOQgZNY6dUoLda/b/M4c4CTzCPL3pjdDY3nRUnGUA?=
 =?us-ascii?Q?J9Nl9UGqQEPdW0t46Ow8AgLKMm8Q4Fz66z+z2WnmqMeKP4wAGJ1RKPihUKkD?=
 =?us-ascii?Q?3h4XiLuS796Nz4sbvew3ayTgf6nP8ciMN0PT7mBw4pWjw3p9wc627OZMYg4G?=
 =?us-ascii?Q?bsthwQaYk4krsGk1rdZ2M1QUTWWPMO/HTxk7nWSYoYlfBoB/8jMFTBOb47Oi?=
 =?us-ascii?Q?vElnWKBUmNE6/5NSlaXYieGay/yIzMAYsI/kmrh4QQKMjrT08oShQrXd2drn?=
 =?us-ascii?Q?8mcRO8pmbiLXiC875McVZilhIczTa6KRnvBa7A8Vph1gKxgOfGHm3jilcHHy?=
 =?us-ascii?Q?00qrX/LXMrENUCoIcGoPbhQ+ekciF+Ycq2Gx4Pv+8ziAYesY+MoJGNWTWnYV?=
 =?us-ascii?Q?AYDLmlaP1OuAq/c0aIgrfyQiWAemRHJmY5tz8k0Os/ykAjEdGuqOPX7bW/XV?=
 =?us-ascii?Q?ra59eMiB+vh9vQ3q0iKsg4uiGLZtLsxGH+OmXL/2ecFH0PlTHOyPOfG+i1eB?=
 =?us-ascii?Q?6ngUrFn5BRDTACxhpVXC6NnFtLUbKZshUpqA7k8arDvJNwBzFpyP0QYOv4oH?=
 =?us-ascii?Q?w79YoFlVuOqxXGddaj0bkvnI2E9UPfuKSDxwz6n+AR53JfYF/kjcggCwOSkC?=
 =?us-ascii?Q?/UPBiIekPFvn98BSZ8dGc+boj0X2ASp5D5cPAU8YqLm5qoKO1z7T+xnL4+2H?=
 =?us-ascii?Q?ls8YrK0XngnfI9Htx7whPE751cQqL1339LeNQKDVPzwwi2QNgd6ooLIb7DaR?=
 =?us-ascii?Q?/ClaOT9yWkiYH+kEelP0CcUCaI8xmptuRIS3LlVJCiozPtgA5qCwWM3aDH6M?=
 =?us-ascii?Q?vQJoMnjw9G5rzyd87xQJ2APsRGenoN2kovNAvmNS/fpc14E48TAVrS29gN5H?=
 =?us-ascii?Q?KQuNyVv0JfViMa9nR0PZU5UyC4S6mjFifWX6LE6QQo3PUTCxl0Hb1rAWuYb4?=
 =?us-ascii?Q?/5UNCgxpvxn67iHbQVv8UCujZpqFA3QBgUQ57VOZGbfkaoZRetNPb8spsQO9?=
 =?us-ascii?Q?TbWxSnaXmdk/6BngvDCy3Hbsp9NNxFn/4j50yZJQnhf13IP9wRNCPyJGwVCx?=
 =?us-ascii?Q?+65hhCEybGUNNyVIjedgrHKmAJ3vtZ58G1/5iNKLwSwn6qG8xwFNVRfpCp7l?=
 =?us-ascii?Q?8Q000P13HK/9issf77ydH4ol7tnY4q+dXUuVqcx3mMgKSZnVaXWsdV2jRXQF?=
 =?us-ascii?Q?6u+D6ros3ER83ylKw2scOrgHcGZ57q49RV7dBf5lXhAj5f7XPkMWOlD3vi/G?=
 =?us-ascii?Q?1FWhrlwL6pu2H5mO5oDaCpHSCptZ+oRbSVscmXm9JF2wCCLgHQbyjjXVdfI1?=
 =?us-ascii?Q?1/rz/3fKjJT0r7m1nma/3/UrdgX3v7WyU8uBN7tRaAkGEH7b4jKThSskUDdI?=
 =?us-ascii?Q?deopPcqxWWvIAyR83BPmVW0GzQHDawsnl/9OwIvEOj2JyrkTxc7AefpPjU7t?=
 =?us-ascii?Q?obwp06W5SjWUKjh0w2w8AuP37eL6X5xA6TZG7JQ8JYTdct7Ak/Tc3Gbu6c/8?=
 =?us-ascii?Q?FCzb/dwNJjYm8Kf+TrbhbuDSaZS/04WI3K/PWEzriwVxjS9JIsvf9BQbgkxi?=
 =?us-ascii?Q?Bp6ugl15d5X9rb4t3DsQj1MzL3G724rf77RCKudMODKLvQtxUt3oMK70mzMV?=
 =?us-ascii?Q?hvLxgk9vV/+ohkKuiZXcQ2eLI+WRYMORGYK+aYKbZrnZhGhKwfKo3Ii41sd0?=
 =?us-ascii?Q?q06fDbRF/NFRi31fml2x3GoW4aZFQso=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf822e7-7b71-42d7-61af-08da26b2b3ee
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:56:59.2062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQvGKRwXdiOCkqtxjOfeKrV0P/H4CrHv6ZCIoF09gcBmWRrFhinSy00qYzn7WmFhJvJ3Uw+nEsPmERmnlYg+dcyE8ONk0JMlVgSAYelk7VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5126
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_06:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250053
X-Proofpoint-GUID: j62BFL0wDx7z03HWVNXn3rKjlSXUIoqp
X-Proofpoint-ORIG-GUID: j62BFL0wDx7z03HWVNXn3rKjlSXUIoqp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "r" variable shadows an earlier "r" that has function scope.  It
means that we accidentally return success instead of an error code.
Smatch has a warning for this:

	drivers/md/dm-integrity.c:4503 dm_integrity_ctr()
	warn: missing error code 'r'

Fixes: 7eada909bfd7 ("dm: add integrity target")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/md/dm-integrity.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 36ae30b73a6e..3d5a0ce123c9 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4494,8 +4494,6 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	}
 
 	if (should_write_sb) {
-		int r;
-
 		init_journal(ic, 0, ic->journal_sections, 0);
 		r = dm_integrity_failed(ic);
 		if (unlikely(r)) {
-- 
2.35.1

