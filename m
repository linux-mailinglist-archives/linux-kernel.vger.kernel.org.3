Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859E8589819
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiHDHHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiHDHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:06:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248F965E8;
        Thu,  4 Aug 2022 00:06:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2741htaH030441;
        Thu, 4 Aug 2022 07:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=msjMqopQ19B0QnvFboUSkpup3X94iX5l0XCby8CWXOk=;
 b=E0JwbBHEoK9JHiGG93Y3da2M/h0Zwq1jParqgAgWc97TUKut71ujTwgginyrAoDd/GVu
 pxzbK8flSJUo43ATaZwJV9PVjdjx8gwqkzQ+sVsitwZDsceoaOPlQ2sNVYg5rkmLcmqw
 H1jJNs9I58l04X9HeOQKKb0HDZ4qpcinq9It7Cm1RnQsB4ZSApHQlP8ANTryR7bDsHTQ
 ejaqUSxhG7Vd98e1QujASSKXBDOFCKGgrL3jVNc/tT5+jhmAfwkIjctTdLyEud7irZJL
 mjyLuvZx1B8Rxlg3VbVB6cKzqMusa88VSO5V0GdRXDxzsTCSTmfgR9Mdle7L7mIYy7Lc ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2cbsbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 07:06:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2745CVim001480;
        Thu, 4 Aug 2022 07:06:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57svunw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 07:06:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAp5432oW5vXEfLQatGdLo4Idq26e6FequQu+mV2K868ZoeYVvKYx95SzdTRS4Avh7co5XIQUUW/43QY3RGxsHDE3BAnK7/+IwCdqy0nwULxWzCseLYOsPAIJbFO/IV9ipiuhP2GYpzJtlgUb/pMMh3Fau9aBlg/ivFUdznTgmx75/ql0CeMwN9M79l15cs2W/C14idf682VG0woMd9AkOTtssbC4r4nORWuas24vopoTZ+Hiox/x746ZgZwZ5pdKyQ+uhsQB1R7yVe1g/4bobpN3e4zC/UHPIcyavR3zY1yhOvnm7xak5Q5kPrx3xlYG5UCAvke0iNPeS6kv7WoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msjMqopQ19B0QnvFboUSkpup3X94iX5l0XCby8CWXOk=;
 b=PynI6OlhI/VuFn3vSgWdTz90C9JTA3zNlZ0d+/0C4bCUtgvmYyi7364pCkzsNK4aCF3DnC2TfZiqE6G7Daia7SqNxsxkRf6QrjJLYeexyMxd+HvW4WuLb0Vay/U/ks5BJXvJSJOnaI+cXbtSDWFhFwCY1Ma/bkZCX7wYGxf/AhkxQ2l1K7lr/C+rRcpg2GS005/YdrnqdaBycuxLB9nx9zVYoY4q9r3oDf4JwsHY+3lbckwwEK1EcFdPL7/v1rgS9+Q7tIO0W7NGXDrJt2c+3nzSGs6h18z6R1Fzsaktfarh1KIR07qyEsrBX2S6rDcc7luHvqQqb0GgMvYSYzmMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msjMqopQ19B0QnvFboUSkpup3X94iX5l0XCby8CWXOk=;
 b=A4/Yc5Sd+9knCl1fkS3YzB5x6Tv+eY9rydE/LrIQ+CPXGaaXF7BAW4vJLIll1t55xOHTPdtOhluUTLYtNNXQ6vMMqxAf5y4pC4IpbfrqxSwZMjSO70t6UOCSQbBvAbs4xOLaIuw16Q6xUKOUKOYkW68aPr3Vwf+t5774IaTut0w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4328.namprd10.prod.outlook.com
 (2603:10b6:610:7e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 07:06:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 07:06:49 +0000
Date:   Thu, 4 Aug 2022 10:06:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] char: mwave: fix return type in ioctl
Message-ID: <Yutv/mvLNJRgDtOu@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0048.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c07c2db5-9b66-462d-ebc9-08da75e7e67c
X-MS-TrafficTypeDiagnostic: CH2PR10MB4328:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQwST7Db20v+ccanBZ4WoiN5wavRQnIs46UfdDmv2SznDjyGSHQm/vPPI9Y4BalHibKgJyFjZpE7hHwdScvTNpG0leyWvYGcRE3NQjfInsPrm1gYYzDW5bsbrnqqsBhLVNmCgQFF26fZscs2PyBu+K8gwtvK/vBIlRkgwldiXPEyi2bhPTj0YJs3wxFgrqDfGQUv9/7KgGTVTuuybjlAtagcVl4OBA3KEpQHoKEjfvMB+/KdHZFZIG9g2tQlpFJgK8PyFkaD/eVu+xjuwemTNx28Uda0r4yw8zs1uudNZMhE7yAbXNruz0Gup2khm4s/Wb49pI4h9rPliHf9su+BbhtC0J4qqWsXgJfnZfkqH8ntaGiQryFanNhwhluF8OovX/QXSnafAT1Q6c4DXwdOYFAhykGXlyWGcX7AT6Mh/NiAVw3Q2PlFUgSF1jLi4JuU/2/UzOZHf3zX5OSrKY7dol8B0fhFC7oyisDxGfBh701RevquF4R6VlqGXEAVeWnXSNzK2Bi0cYA7xHYGtynmOU8Z1TJkT8s+ziTLCWOXZNiqd9SN94+vQtI8cL0m/0HX4CvIOte+2nVJ3o7OqrlQE3AseWKk0ooaMSy1l7gGrQECepHYkSeKjIgkmwlP6xltZBVKJ2Hfq6m3WGDCBzIrk+bvFl+jN4NT/vbIWpPTs5PocM7eO/uKdi1fEu0YeXJXPMU7v16t5a76Hxy2ezQ3+T+7s/OJZdx0J2aOnutdaDLFVL6/TDpQ/WOoJWZt7PANO1i8aWCzHuJ8DHCrRGs//SQk5ekhDi2tiKlahgz5FEylFc2ylBaK02/ENrCRjhvN0bw/sWc+OijtMRlV3cDKb5QO1GRj3gVqzxHGmr5XzKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(396003)(136003)(376002)(346002)(478600001)(4326008)(41300700001)(83380400001)(26005)(6512007)(6506007)(6666004)(33716001)(9686003)(8936002)(5660300002)(2906002)(44832011)(6916009)(66946007)(86362001)(52116002)(66476007)(6486002)(66556008)(38100700002)(186003)(38350700002)(316002)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cssXgzbV+7npbOPzFxgeQP7y7zMyqirA+d67wjEjIz0iPITVWlX9NbpbtQdG?=
 =?us-ascii?Q?XZdP1ZPPiYrGd701DqEwxOKQmcEuqDtZHbXFv14779TX42NRLzB1A0eVx+/4?=
 =?us-ascii?Q?QnH1gyMBnPwjVl73sE4WRDYbKDRNGo9KlZACOBEseIIn22N/m7GL8dA5meA3?=
 =?us-ascii?Q?uETyGt/c+Y76JQCac7oWzqxrDwSlFj/5NEd5n8HMwnHzioI9rAIpcClC3i3a?=
 =?us-ascii?Q?wyJYuNL1nFC95+QNMvAEPT0GiD5/jqBjh/S1ZDt7wujmOzAJrXFcCa60IfQ4?=
 =?us-ascii?Q?CwoRyhYZqW0PvAtj3Wwk+BdXA1vh9eM8pCu+OwHqvgckpXspGHb9minwB/Do?=
 =?us-ascii?Q?z1eT/G2DnQQOGDAJxXd19WxdtjyZ8qQphEllJmvBChhBNxbiQJZ12ndgee8I?=
 =?us-ascii?Q?r4zGok5lXee/76NTbBC22mQMDQomTR/mzGyDmIRnNT8iZIfsnMZWGfW+OLIC?=
 =?us-ascii?Q?dpr/dXDYQEhYa0uRoLgt9ohYZE8unl95lnulCxw/JlWy37g4dREO3n6ECMCI?=
 =?us-ascii?Q?6Yk8WuH90pTkNEc+JG5jG1I6Afvoalakw5ypuzOEtVOnDyxWxV61W5/2yRAf?=
 =?us-ascii?Q?Bl3jVXImhKYAKXO7/+RoMU5A4EJdFX4VMtDnI9ZSXQVcwfP5pluqzFukcAUw?=
 =?us-ascii?Q?AVOwrdaXaar/YgSBKvzOM3sxGkXxgUXAwEVdGf4e8/mTxWKMsgcMOdDFTiJd?=
 =?us-ascii?Q?CuGD/c3ky1qjZuxixMSS8XfHtrfdnDoyxOTh9g8dpC6qNCXNHrsxrl3xDi+S?=
 =?us-ascii?Q?JvglI4H34tO/t11IsWEpq8BUv90plxwclw1woe8UZfSsPsyg2iyq2S+QOnuE?=
 =?us-ascii?Q?oqmXExWEa5s2q7ueRaAslMFIxT6OyyVr5qmVvCcHvNf5gY5Q8/Gk20huKtCK?=
 =?us-ascii?Q?EbU6EUNLgxiZ322wUGmhR6kAQEuJSFwrCRUjHS4ipNx3Z1eAjSNovg96lFSg?=
 =?us-ascii?Q?nxz7A/85oOUHyi91LDlbNzR6j1iCnQGo0kB3AZWjFOhVJGzdlMDxHnnUajnO?=
 =?us-ascii?Q?9wBcAaYK0UfIXJbGdKUVGRMLb5tiK4q8eGxAGOcpvOHkNVAUw2ENDlonoT2+?=
 =?us-ascii?Q?4SsaBGF8DANNRrG63KoZwr/5Hz4mHVc3bmpTwURZL3YM9HBkE2UeahW9wTvL?=
 =?us-ascii?Q?NXnIM4cW6Vq+L3E37TrqQpxdemNHc+3SC+lfQl5qrjE5VpU/ByIZvK4HEydG?=
 =?us-ascii?Q?wrTFr8cq2jnEceHo3XHej5Enxn9EUKgJ8bTJF7XhPLr8qzWCnZvM8u/vhy0C?=
 =?us-ascii?Q?cyJ2HnV65UAv02KxxOnmjpbUmXufCaPkh0366kUovpzT/5ocT6T+x//h8GTR?=
 =?us-ascii?Q?D8Lt+M/YMVCQe0xrAsDBtsCpKKz6zVtRL9HKGX51shJfcTZVUNlwjBkHB9wz?=
 =?us-ascii?Q?xlpAGMxPMutoVhbLsdXa/jtdF0ISsJgzkT3F8xPVocsPMdz8Dqhyvo1/Lt0p?=
 =?us-ascii?Q?jiinNMWwou0iP8InHr8SVrcg5YvcV09hV08Kx5BTuWqBR+cSuxeNn2QZqtdG?=
 =?us-ascii?Q?cNIP5oZZF/F7PEIKf/5m0xsqRyQwIQshNhq6O5aUZ+54c1Zy00TajlIo1ntN?=
 =?us-ascii?Q?kRCV7Pg8XWhc9IbOwGidX/oDnddlY3xVU83sV9Haigimbz4qrrPIsrXgNspf?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07c2db5-9b66-462d-ebc9-08da75e7e67c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 07:06:49.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sBRalMLJs6Gk4qZR41jSdw7rOvCFUDk+81q9tfFau5z+d8OWAPfZbHnqkXRIKYyTU4zlEYStZdtSfqtddjOURNUqZW7T/mZvQrzBWPKzio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_01,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040029
X-Proofpoint-GUID: --oZIbgYm0hlz0ICqocFDZUSufhCfYrQ
X-Proofpoint-ORIG-GUID: --oZIbgYm0hlz0ICqocFDZUSufhCfYrQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is supposed to return zero for success or negative error
code on failure.  Unfortunately the "retval" is declared as unsigned int
and the function returns type long.  That means that on 64 bit systems
it will return positive values on error.

Fixes: 909d145f0dec ("mwave: ioctl BKL pushdown")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The Fixes tag is sort of debatable.  "retval" should have always been
declared as an int.  But the BKL change is when the return type for
the ioctl changed from int to long, so it's when the bug started to
affect user space.

 drivers/char/mwave/mwavedd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/mwave/mwavedd.c b/drivers/char/mwave/mwavedd.c
index 11272d605ecd..5813517faf4d 100644
--- a/drivers/char/mwave/mwavedd.c
+++ b/drivers/char/mwave/mwavedd.c
@@ -123,7 +123,7 @@ static int mwave_close(struct inode *inode, struct file *file)
 static long mwave_ioctl(struct file *file, unsigned int iocmd,
 							unsigned long ioarg)
 {
-	unsigned int retval = 0;
+	int retval = 0;
 	pMWAVE_DEVICE_DATA pDrvData = &mwave_s_mdd;
 	void __user *arg = (void __user *)ioarg;
 
-- 
2.35.1

