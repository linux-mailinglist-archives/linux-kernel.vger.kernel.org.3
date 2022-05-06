Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AE751D1B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387242AbiEFG70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387164AbiEFG7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:59:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB561116D;
        Thu,  5 May 2022 23:55:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2461RA0i019152;
        Fri, 6 May 2022 06:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=YSYuxQMWKcJv1zj8SnOrUNXKmDxYuI0mrTjDVG1iMuo=;
 b=GizT0DlC15SuS27wTplUZvCoaAWrjNlz3XSBeJpFE4b43ordoVfn8+cSYtVqRgCKYlvf
 SVotD/f+cDEeE+L/18K27WhGBsSaAj5xQqLQQRYqoybjs//G196Eagrj+bAcECSNIhn+
 IjdbnvF8gAcPgQDWhpSIJ3RjgYfy9/nU4aDb4RWM5jgUL/P9dKP4uZgC0IJHUI0Uqx7G
 TthM28XCxP59UIymnlMBp66L8V9T/TFwQghTR8T5J4MC15hdU49fTfl8eXYM+GtLg9cl
 V5JHc9/JEc4wQVoZp0x9oQc+BwLY6JceiHWuPID4NSmhOENQgNknqKV8T9hAqVlguAde Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0avws2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 06:55:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2466pQ0h016162;
        Fri, 6 May 2022 06:55:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a80bh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 06:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF93NUEsOElUIqVOcveIZLVNG+YW/Lf4ppZcAf914h9DvJSwJ7xO9IM1r8HpC3Y7kpZjQ6TK+OphK2sscElW/YX8FtxGXyN6AshLK6g6pesLdQSGFRnKkeU/pwe+C1yHNHmqWKcVPhAenojih+vRmgx47qb+mC2+vLIw2oZC61wsh0as9jv16YJzqMthL2esbYuSGvFwp19mb7LohBIJKLhWeK7NszG0Ch6CYZjbLrhM/lQAq13f1XKHSTV7Jt6ymcf5hYCZFD3wqrWoNNQrJVIqbeG5NZBufo2X3d8IXNJK3SGk7SVzMdB6zo5ousFx32fdwrvlNKkpNOB2C6OvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSYuxQMWKcJv1zj8SnOrUNXKmDxYuI0mrTjDVG1iMuo=;
 b=Jg9jgrEGPUcqIZ0YCGMZWCA7oySFokCHvbnn6UyM4/JxTYsYutNB/tGKj2qaTWPeC12f1XJ3hY7KoMfeBigP0rFQaTTyJDQRAP3m5VVoR9ckwXyEqtE7CzPz4B/crlfHcy3BvKRCdHG/Q62oSnxCgsdRKbR7O30ZOmSgW5xfGYRun3r26ie42Qs0uEYeL6QYC0bKf1LqT6nXdOGbE11s1VxdDxLtTxFWnJ2E5TcUE8RefBCXBndrEuYjcezCTTuyUYRKOViNYzxu3wvMXFfBL0wt1nbpdk4wmrM9iffBKGr8t+ZBDP061uyRKr3vM6A4nZOEOIlZXiisBPE4IpJnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSYuxQMWKcJv1zj8SnOrUNXKmDxYuI0mrTjDVG1iMuo=;
 b=tmZgwKQjKF4zuvOOarvOgSSmr6EBXtD4Fa1LpVcOjN+/ZKQqL2iNCHWjGMCYWqbrYh0SSe/NKsHj7SJDv+sepO0ihHNmjRsYSvv31h6z36XvJ+mPLS22G9Y34B112pXKH9nNnHNh+X7ZR4lnKExGTau9ehYuga3L6VQLt4GTTlo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3747.namprd10.prod.outlook.com
 (2603:10b6:a03:1f5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 06:55:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 06:55:26 +0000
Date:   Fri, 6 May 2022 09:55:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     Tianfei zhang <tianfei.zhang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v3] test_firmware: fix end of loop test in upload_read_show()
Message-ID: <YnTGU3UJOIA09I7e@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36a5ab1c-2ada-4df7-d53a-08da2f2d664b
X-MS-TrafficTypeDiagnostic: BY5PR10MB3747:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB37479F22E772EF67AABCD29C8EC59@BY5PR10MB3747.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FVBwcd7LGianN7+XHcv0QE3xvanbdK6QIjvEEsKGayfoJHqRzA/rRMvbcaBe2TQJ4wRotQdhCVlPWMvtDh9XlmY87wqu1/uQPjXUHmsvykOKZXRqm3TUj9U9bb2y4fYAJedRIfUakH16yHb6zc90FiTPgUrlIv9+fIF/FuFS8HM4fpg1SC9i3o3hJCFyxRn5MV6xZHPqykV1Y10FTO9P9BQrQ/t6gL3tJ6P54icLdTf8kiS+0JmB8S2OL8lXHX1krNGo7/FfeKfAonKW87RIcAFjyPsbHCGt5jRkBsnGogGfuD0r+qQSHARGyCNidCO5k3FuiI4n6puzP5Z5qI1C5t3B0WmPx5Fn+2EcUNjsrNF7y3VouCPSBdiTb39CK4UY4d6Ow35fK+8JYaJIOt+3WVLs9Eh4WjAl8o8yIBASAxue4ek4EGPfUnQ5b+mgv73g/iwpui6grL7sYRS3XEJM5Be93x/GsiXIBaIPJL3gX6FijXF1W8psg9WyFhbeOnKan5U08DXOQ3qACTN2ow7sUgRlvCNI/YXP3ZgbntPEsDAhDmpcaJjMz2DPn4aQZsVfr1OzxzglFf3odXxE/NBKWbnxvHTLE6WjppmJ5Bq1M8xm3yqGBuLpkPingoPIkNRoV3JIh7aoUdYDY3Rh4o6rgZ0Dd3l09/zT1CgfKN6stfn1gM6l9/hUxKTSWcSqqKyJb8dDybAwWC1zmIONHvu3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(4326008)(8676002)(6512007)(66556008)(6666004)(66476007)(2906002)(9686003)(6506007)(26005)(8936002)(5660300002)(44832011)(110136005)(6486002)(186003)(66946007)(316002)(52116002)(54906003)(83380400001)(86362001)(33716001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rBB311+JBkPTyOZyuJT80VYhP4ZEDYifN2zA1lXUlA8tA+P96jdDCQYYlZ3V?=
 =?us-ascii?Q?5XDDC+t+37x71m2l3lOeFNvw7iWm47hOlo3zj6ZQjIR7PuTZfS5RTVocf2gs?=
 =?us-ascii?Q?b6BfgLfP0rbScT2VcgivZJXiqVimv8wVNFx55xBMh+DmNfKZf8So9sOunSwo?=
 =?us-ascii?Q?fkUA6/NKHG+VsxXKQKohEl0jcY1FCopBhUl8WiWaCq3QGgx9QeB54sjHm+HI?=
 =?us-ascii?Q?wNncoWhhLnlV7My1FEOuhheZI4u9bTGuioth9TQxekL0zEv1nMyfbzUUdsg+?=
 =?us-ascii?Q?z2JnExvcjS/+0mrGRrWB+WR7QAoqYxeXZeOfy3NrFRCyTs4mk6JvwXkLbJFg?=
 =?us-ascii?Q?mL05zXv2eabDcP6rw8DKsd24dL1vDh6BHr78XXXVV8j6WSLNjEBrzwyMhFuc?=
 =?us-ascii?Q?PnyuUB4KG3BH9lMNR7xDuC4AJ2qEN7nP9EC2WNFpHO9wfRNgJfr8iDCnpCww?=
 =?us-ascii?Q?nx86oUMzAkIxUWsm+2ZQ7NAzvqmfzw1PHmAAovHTCMS4yVEKeYmF9Ybx7uVm?=
 =?us-ascii?Q?UAOc5+X4TRiYVJ6j/ozNX0vNypuHTWrkwWo4Cm+FtL/9EnIUGRs82H85ro3J?=
 =?us-ascii?Q?IS1XvZNdaWtXXPqi6ECZCPz0kmebt41L+P2LSC1kMtKo/XM/AVjyaoan1Z6/?=
 =?us-ascii?Q?YVVAvp03CvBEolWTz4ZO44GJDLnFoyElZeyxGMf+IqONXIPFNpTKXJcA1lLu?=
 =?us-ascii?Q?snkBMavhzhzm+kivmgub8QnGqkfBfGZAlcoRweNaOPS1JRWO9r6o7XVM36mY?=
 =?us-ascii?Q?LIX7L2LlLNmTRq4wDid6XiEXTzF66JVynzt2sveIoY0Tj0XFRxqid6BfgZie?=
 =?us-ascii?Q?uSRHgM8S4Zcg7rFSSgHrr8P7wfS45etKbjDzAdfYB6PfSL5xp7uiyEKIPi/s?=
 =?us-ascii?Q?HcqVWczDZbQudgj0O+BRbse0BOqxvLfHlWDyhOpJvLh6PEYvvBw4x0hMLxnE?=
 =?us-ascii?Q?HttBHwl31TVHbS3CqwWGC//E0ftnLqnwUSnEkcsGvdBHcrwqciEFfGs/Zzfm?=
 =?us-ascii?Q?mxuCmv1/hLlx1rg1ze7SLWBdwR/xhjwzQLM06zaCsHngb36FTS46UY6f0QFZ?=
 =?us-ascii?Q?5eVgrm8nOFMpOTkDINvXF+AbY7CxBZpNT2uKOKI6VQikIOpudFQD73Say37L?=
 =?us-ascii?Q?BKccpKMM+I0yGyzx5HQZgJl7rd+Fs0BuoJ1V0SUVoE2Spcsi79peze22PYay?=
 =?us-ascii?Q?fCzbl3XeJJwGzdPZd2WIdpTjdNgFuIqI1Vw6JXIYUp/QbK8/yiRFWKMSQbia?=
 =?us-ascii?Q?03xQdhJPk5HyJ55ns3EC9+IZMzhyv3z9kLtbFK4UeKcvNAhiKDVs3gTKMvjD?=
 =?us-ascii?Q?u4hTeLtFXcHFrfuibUcrlxKB1Z3+YsIiqDwcLsfiwlrm+R6GnBxqVBcrCmnq?=
 =?us-ascii?Q?arXYGZdkvfAICas8Rc0z0C7PwGtSt0InRGgJgwyFVPV/gDMFtePsrsNCqeeT?=
 =?us-ascii?Q?4WqS7Lr+4N1N2hbxBAgogq6f6ueDAXsXyM+DzDdL58b3FQuj6vk01FLdkpOo?=
 =?us-ascii?Q?RjVNkm0HEVew6u2PMFVNVlvhlxPwBdg0zffMEro5REAmA4DWy82uhOeHfyDL?=
 =?us-ascii?Q?j2V4m7X6hFyKak/9DsrTSf13v5+CSWwk1cTxTuyCb9rhpTsu4zWHePxM8FHB?=
 =?us-ascii?Q?B+UvSax29tovfVZL8r3+XN/i5JznjP95V8oKgXEZJo7MKdBAQRKwgjGB4hka?=
 =?us-ascii?Q?yx9LEH/i/13cQU+gRARJ3lzVHvfJ4C1BAk6lsQFws4vKJCGSErRSjH2zJQy6?=
 =?us-ascii?Q?Rq61v+bxAr7dpoulBViYN4NMTAP8LC8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a5ab1c-2ada-4df7-d53a-08da2f2d664b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 06:55:26.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czspv7wm8+z1s9S/oNndBSV3gccUDnUpKUa2Fp++QmKMbV3oJ4FcrfiZRXtwYoATb5MW7pVMzJ8DMHMXF3hFOulcuMfVZo3x6bTgR0K6E8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3747
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_02:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060035
X-Proofpoint-GUID: f4AEDEEAWYlwOjmYN3O7bLYwjS11m829
X-Proofpoint-ORIG-GUID: f4AEDEEAWYlwOjmYN3O7bLYwjS11m829
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a list_for_each_entry() loop exits without hitting a break statement
then the iterator points to invalid memory.  So in this code the
"tst->name" dereference is an out bounds read.  It's an offset from the
&test_upload_list pointer and it will likely work fine most of the time
but it's not correct.

One alternative is to fix this this by changing the test to:

	if (list_entry_is_head(tst, &test_upload_list, node)) {

But the simpler, trendy new way is just create a new variable and test
for NULL.

Fixes: a31ad463b72d ("test_firmware: Add test support for firmware upload")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
---
v3: Add Russ's Reviewed-by tag and this --- revision text
v2: Change the commit message

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

