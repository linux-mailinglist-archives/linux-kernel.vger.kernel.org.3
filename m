Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A608D51BD4C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356028AbiEEKhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356000AbiEEKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:36:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956E63F89A;
        Thu,  5 May 2022 03:33:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245A6ITC018740;
        Thu, 5 May 2022 10:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=VlGJYyjuiXAfgqip2Z+MrARycW36EyDdF/93DT/GVxs=;
 b=vH+yQ7/QeHI+cyh22qEVtu/4nf4gndTcSWHg3AtILa2x+zaw6EXaywWiyXasHP54NttJ
 QlBG3pZTk1fNHUnCp0W4GnrYuQHMmyLue/xsZt55Or1j7e/P9qTR677aLag75VJJ4XfA
 DWP4tmmBTZgW5EpdT7UJTMTgJ0lZa765uC2FHyi2myB2v9jxywYtLf0ZtPs+9n03bUHH
 lc6g2lfc7lx+OS4D2lLS0JvJBE9kBqu8tn/DlTV9gOyO+KrXr3X3AeVMEVnd4A/zr0Kc
 bsLejwLP4TM3et6GXBXXtU17GJklFqtvQRyCgQSS74gO5fx7UAoXK+4TOrapzFFEkBdc Zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwntb0wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 10:33:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245AOw9M034334;
        Thu, 5 May 2022 10:33:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3frujahdrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 10:33:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdV6byhRRt8VaB79l3lZQVY4cHj3VPgtacPaUKwpkrDtNesDB8WK6a45hF+5XBAAl/RvchgG3GMuYxTKYAzReaI3ksni+9j+a5+3JTseL7gfx4Ovf33SCtszZiThiEF+HzVlJl2WOeth7VnGD1kyi6ihIBE2uK1ducag9qbAlCOzhPF89rend7M3ZofHQDfGN+5QgnMF9yZPdgusmOUU3ozjBToO6tEkXrs0QnVgHDMhEwqHA/XMP9F2we9SEY9Mus5xgVnaKjLUkG64Bo70JMRkU6jAe2BSXqWmhO2bJ9BGbm0AQ/+k4xlRP04kzgn9TeD0UjSO2bJ6kLM28tfXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlGJYyjuiXAfgqip2Z+MrARycW36EyDdF/93DT/GVxs=;
 b=gsKmDyPT001ItkQsaT8V9ZjoKwUa/PF/qAqRq7lMNZ9Sxu93lPk/FnCZtFv1Rk8mL+R+vGq6wwhNH+/HN/rBJyt+vuTInH3Hb4gZucQxQjozQUnecMViDVgUOXl88hOwj6z4PmIvaNu8XBWmHcEHQirqfV9BxoaOIjQT9sfU34Cl+TyAoNqzAZ69v0xvk8JTh5z/LepT04I2KiaqXD/pbs6VRJ7FpghP6WClPMg+u3c5B/o3XGylA7X45cJL6/+cK3bpGhle1PqpjMM4llYXD0obsZ/25BeK7mRDMR85s++tN2j4IIs75Hpb926+p68LqNz/ZjgaY5LOihAvcAWxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlGJYyjuiXAfgqip2Z+MrARycW36EyDdF/93DT/GVxs=;
 b=eIsg16tZ7bDDez9zs9uH18gs2eCaWdNg79FrXbqQAD/W9NOPvoNCSCPz2LxzZjaiB2DigMA8wev3kHhlfw0X801A7OHuwCyDDd/AQe/eAffnzvZMl/NRviHOhU4tF6eMislIVKaetEYFviVX1/QFWGj84IsK3DdiqxlXc5Z09UQ=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1541.namprd10.prod.outlook.com
 (2603:10b6:903:26::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 10:33:09 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e%4]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 10:33:09 +0000
Date:   Thu, 5 May 2022 13:32:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Won Chung <wonchung@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] driver core: location: Check for allocations failure
Message-ID: <YnOn28OFBHHd5bQb@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::27) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b05579ac-3f36-485b-0287-08da2e82a5d8
X-MS-TrafficTypeDiagnostic: CY4PR10MB1541:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1541881707322E177885945A8EC29@CY4PR10MB1541.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8FzHYkd7jvGnvBmxqBaLrTb7B5aro3IsId3F92EJf53Sj/TiOZhDL8HJ4EjAshxbhfdCOmNC53a91/frp3GPrTivkOzPGYXOXeB8z2VKO0xBL+cWIyeplGsT9g+SRygLiEFWAfbGS81kFjzZ6/0cLaONO/+D4IzPFaci41TCYwEj/B/83AED6cWgVzunKNgZBn1e1BBziFKzmF3aomWpdmR/twOWv9inVrXXjRWmrit9M0yVbe0FprPxTJd7Vs6o7npb3CUWIHZNBmN+ivFZ24pZAIyGxsqPG/AE/TO88GnWYAv0IV4lMb/6+Iv7trcJceBFYeam/5mJqMf03p4+QZMZ8pXH2aoVN00KgIz2tep3TR85MKvVixmDGKG4cMt97pB48DMJFdrPWV4l8sSDfv0hpMxMi3/v6+rW5QSrgXFowGONciU2m+8xWng4qquFtGUlKi1HBwfk7iCe5oNZ3xjN6LoDpirdelEdrlYNSUhOg+Qj/NzS3yQYFMoeGQfquGXUANY/+pH2QdMlVKqCN33sU1KI0/3ZmGsPYU2mNbxJnJBfkb5t5i+u0ddAFaAjfXeAF87Y7W8Es6VewgwBeaKk3iss5/EpS/1zGt6FehHqYo8A4xTeW6q+JANa/Lcoo56UWCO3G9/x894/BK6ogzna7cEmQaW3Bqs/Wzko9TZRWwTAPUi3ojxb+FgLdCIPpGZvjBKWl6IQOaxjoPHHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(5660300002)(6486002)(44832011)(8936002)(4744005)(316002)(6512007)(26005)(9686003)(186003)(110136005)(6506007)(86362001)(38100700002)(38350700002)(33716001)(66476007)(4326008)(2906002)(6666004)(66556008)(8676002)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SBAsj5vlUVPNDA5Vz/cd1G8qIaA0PSajeI/wlZU9+6anBM0mSvYqFbBv9gum?=
 =?us-ascii?Q?4h+YwC44pQbXOAyFIBtnFn5y+4Z6lOPI1bS0acqCi8AonbA0V9FR+hY9YzTQ?=
 =?us-ascii?Q?P8d2nxzCRN/rKdwodnQSu8GCk7LkVSLbDDlxSOclcE4P9eorrJ8yb2V0mZHr?=
 =?us-ascii?Q?7TVOsiAClI/IgrCu/PLRMbfRgg99uCRpPYxLREfPASJHwYhYYbJtYHAnd568?=
 =?us-ascii?Q?st1X6xaIvTOO80gbSTMDiEtazHoeb0vle6wjPTA/JSBFj7AIuXoui8TFGV/E?=
 =?us-ascii?Q?7drysdtO2jPpY7wGIMCRgW9NGg41qI/YnM5WjF99hoiJGVXRtm78HBRBIv7X?=
 =?us-ascii?Q?1LsakszgWuI/ts+1XgqXXOiFIaQyix1mWLwRT+x/BPlC2C4AR17dsIs5IokB?=
 =?us-ascii?Q?k/yd4o7KIm1Gj7up5U5ra1F1Qdk7hs9eWPScVq2M8OcJ1jhJlrT0nqW2nHbk?=
 =?us-ascii?Q?d0lX1OWrz3xho9tuO5QNpTbBV/9yTm7GhBWvu9s/L5vSuz0uD6PnkOCyDx4Q?=
 =?us-ascii?Q?zn/iaVRtJbqUiD6HqX49iARUDshAxcgMqs2uifDYac8wSg0ZDMLvFefMBNjo?=
 =?us-ascii?Q?/q031AbwF63qHY7ns2N+ubtvn3oQpsFiFHgQ8jg31sYErO0nffooZ4Bybmfx?=
 =?us-ascii?Q?lcW5/0B76ekCFINFNBQqUVh4ffrwBgaWtMoYA4x5XtkWNK4gm33xaaZ78WQJ?=
 =?us-ascii?Q?jP/POhANt5bswr0dtsOKXNetKqntnjgklEcJQ8ccuaAV0ktecsILQxjwItW/?=
 =?us-ascii?Q?OrbyHVyymiFwY38nVGWQYlX8XN9ui1jwWqhltP3teJpy3PZ8aO7Ua+n8DCIA?=
 =?us-ascii?Q?G7n83h5pY9m5f5i4LkiSxPpw8ydsM1uozzwVUgoAPT025T4tpTEsZ8PIs8F4?=
 =?us-ascii?Q?0DH+e0mfST+QonCnWZSI8FWcPQC5BaHi+GNzxK2+4Qnsa+dA5M4Cq3j7EG7b?=
 =?us-ascii?Q?OPYfD8ORDq0IpmCsOm2aHLA0LsEdztfaflecxGkb0zLAu01GEDOVhppFPWc3?=
 =?us-ascii?Q?FFexhs1kXmH+lsH8LYQbU68ShMGdvLeRQCEzd/Pc75SWVVj+OJvBBnsEg0Uk?=
 =?us-ascii?Q?OK6B7YZQ5rl2tZTqDChPoe2na94gMaHhH3iKqj2rfBGWrjz9XCGpHUWzrYvt?=
 =?us-ascii?Q?UZxhxSmOREmnbpD1Cg73JsJgw3DXTtI0GdLl9v0sxzPlX4eXyqOrRq63mlgY?=
 =?us-ascii?Q?5MR8lgg4lttkquDW12BlJyL50ed6Z4qFhqKpCJOIv9bwJJGRo68ZC0DsZyob?=
 =?us-ascii?Q?YYOQe7o3MUXhuJH4fJ8ZVRC70tOCN22yXsxlLGacAEvE3Nkf1SPNHaNxHWXl?=
 =?us-ascii?Q?Rh0HNX892/DlEvj3pLUbm9tCWXP9UuuXDvdlwYNXuisGRZJrg2UnY05Q+QVy?=
 =?us-ascii?Q?8u4n3QfWVKrsO9v5P+V4IxHq4sCCfclpL+8dMiV0kPHm3tD5qvxX2O0BTwkJ?=
 =?us-ascii?Q?zLHbjNS3nkt1F+biQQU0nrWuPKXERrFtmUQBNMqYHnazwCqdkWeQfRr1ihX6?=
 =?us-ascii?Q?f772dyRSArwu1rRJF0lKfNMoPLh+cP8yKyL/nuoFgbu2Y8SGa95t91APZw5D?=
 =?us-ascii?Q?FpjtulHkYAr5XRYWAI9SM0Pg8Ip4vAD0nydwSP0mb/ZfATNQKWUhDpkcFr85?=
 =?us-ascii?Q?gA5Som6RQfBEryjUo53oaD3uHH7tvkc1yziOq6j2H+w4b+n81Le8PXQtK2o3?=
 =?us-ascii?Q?vYd3mWVslFkUqCLMTEYRxvDTB5/HMDJgTy9tt9Cj0mRKxBWiJ2aXVSkk+/+P?=
 =?us-ascii?Q?cGIPOYu2e2pe6VikC7c1a0DK3XpZTL4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05579ac-3f36-485b-0287-08da2e82a5d8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 10:33:09.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RncEpbj5F68eg8cXnpkDJWnxbPGCiv/lDsaD6giFTN2tfLI/0JAzU3wNHWv9mvGALuy9bJwMwf3112xzweWW0mBKdcMO9PgujP28NuOQlQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1541
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_04:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050074
X-Proofpoint-ORIG-GUID: DqzirWcElAXAkoufVVyJp-ivj9D7vCYA
X-Proofpoint-GUID: DqzirWcElAXAkoufVVyJp-ivj9D7vCYA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether the kzalloc() succeeds and return false if it fails.

Fixes: 6423d2951087 ("driver core: Add sysfs support for physical location of a device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/base/physical_location.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/physical_location.c b/drivers/base/physical_location.c
index 4c1a52ecd7f6..fbd9f9839e92 100644
--- a/drivers/base/physical_location.c
+++ b/drivers/base/physical_location.c
@@ -24,6 +24,8 @@ bool dev_add_physical_location(struct device *dev)
 
 	dev->physical_location =
 		kzalloc(sizeof(*dev->physical_location), GFP_KERNEL);
+	if (!dev->physical_location)
+		return false;
 	dev->physical_location->panel = pld->panel;
 	dev->physical_location->vertical_position = pld->vertical_position;
 	dev->physical_location->horizontal_position = pld->horizontal_position;
-- 
2.35.1

