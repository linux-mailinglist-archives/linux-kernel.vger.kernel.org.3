Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12B94ED564
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiCaIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiCaIYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:24:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F6E1B98B0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:22:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V5tZN0027080;
        Thu, 31 Mar 2022 08:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=YRnghIyPqiOOXk2J3bi0F0L1oHGXMqFSA3YjLfiEoXw=;
 b=ilfEEe6iHj0LtAYjBdYDBCDiPJfpFG26BsRBpfgVBT6xE6f++XLohXDrWldg7WZY4pi2
 RoHmFmZX604G9KIdtGUMPuHjPjdqRGWPR0BzdiSecbHjRaIL92t3nac8wIf61pj3cWS7
 18fhdaC0BH3g/PgctnOjMkUHsA/eB66ykgdQcNVIpN9IK6gcMdlZtJMDfgoxGW1FO6c8
 pBi4S9BoqUN+wQzTOQyo5PnlZ98Opys5x8ioPx3/w/co3noWCwZSq+MzKAYiTdWNUyOw
 YiHPtUBzvsJwA4NjFfaWY/ig8JNRZ6beaVVkjWJWOCep9+XkKW1FGXHg6vKCqlF1pLIO jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cuc4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 08:22:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22V8Aa7p020389;
        Thu, 31 Mar 2022 08:22:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s952q12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 08:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuHUZaz5e+QqbBNrnPyDX4+WSWzKDJAfF7El3pXOe3+YzVxtctjVQNMAd5i11iOfJ3k2Y4KkmuDsB+auYOEf0NKqngrpE3w1dD1E23E1lgpZihEtVxQ3j+BrglaxuArFv81SeN5dfLRexQYiaPMAfZm1gkpUE1I4OcMohuicEUXL0F9Uf3GY2qwiu9ExXO9wo1jMBA350ur3SGFapEPm0QV1en7LDIrEqpIo7x2wgCN/8yhVOOcg0SjBclieTvTqWTFrCofBG5c2LGpfFM+z4iBqQ3DRhbvkmSer42T8n82PQEANhsX6R1b7qqFZZIPsukXZPcHw2aEVEzVoFJQ07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRnghIyPqiOOXk2J3bi0F0L1oHGXMqFSA3YjLfiEoXw=;
 b=fm274Y6KJ2Gpah7HR0mR7JWsFDz1svVdi3sPIVJiKmYbizfxOEI4575j55AfYWtW9Sj8KqJPKvdHNmCN54qY802TsX7q7dAkPjW9J4wFV+TVPf3VKwfsgXfNCtb3vyLNpFcnccy+YZvWSrR1CcYzB+xXRrSitePCb94u/UIlKQglDf3/0vKkXZnZLTNGwKuzT+pSqvfk++O2tuSfYPZfaRFfiEA0LqHTDDtlLGReqoC6CfEQxTrWrBTa2gK6yodM96qGWmxdP4GcgRq7lVVz+7DFgEcP7J8UZc7iftb8DkOTkas8Pe95q/9vgcPhvINFTU5vFxoL1qgdtbSnuookZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRnghIyPqiOOXk2J3bi0F0L1oHGXMqFSA3YjLfiEoXw=;
 b=K27i/EyrdFwV2PBARbUSkR98a55bFrOjz+b4AYvONSFV8op8eudMaBEH/Zy3ReVGIbNwIuK06M4Jf6hvdQlTrncSepfYE2YEezjwKHVc3NhoyWuWY2sqO098IM0ika38NmH5RakIkEUpfs3M08fvXeAS7Y9kZhGAd1EYA9hr7YU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5474.namprd10.prod.outlook.com
 (2603:10b6:5:35e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Thu, 31 Mar
 2022 08:22:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 08:22:14 +0000
Date:   Thu, 31 Mar 2022 11:22:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: unisys: Remove "struct dentry
 *eth_debugfs_dir"
Message-ID: <20220331082202.GZ12805@kadam>
References: <20220331064751.29634-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331064751.29634-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0046.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dca9d4f5-4c72-4188-ee55-08da12ef8fbd
X-MS-TrafficTypeDiagnostic: CO6PR10MB5474:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB54748391205F6C9B4E280F018EE19@CO6PR10MB5474.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 332nnhFEn5sK2vmdW432af9pzrnoDeOMmuLwMTIqIrKtowvmNBfMKnlLcemUqGNnDkrI2fs32UB+zV+CzI8H2PE1IGnaO7zFS++nekw0KCFskUmOgreh6GgPyOn7rw1zLOLCcrUYcf4mUiQYfG7kZ2Gn0a3ncG5GOcgWfuDXMv7QLCRbpTgIlNBlUvE3lDnk2wto8EAp/xQ7AVH1n7h9Y7lJmDJ8fgbn7P9fnQjz5w4wN5pCuBZy9Qn3irVSrJpSdQwQPTQWdi/Aweh0g7S9lowx4JHmnuvqycJoZyaR58SOKCZbKE3gFS5dUfi+vJrS2IoQKyweNXDuMnHWxC5s1ohxNSjD2Mf50aXGFDt4UoAXJykJ/CC+i8xeftDcT7c187SUzyaLp1c+DGvUY5UAqInjMJmUE2F3G/4qe8feWb9YKh9eMhCYNQ0ylgvgF/EuVtPv8Tv9DgXlDUbH+diT7eGgqtUXRw88IkkeUv+dZLK3HWZ9VrjLrPByVwoGn/Ql0XRydsBsjHFdOJvOytk+XZ4JTRVB8HP+++cCh+n3oE0/77alqaE/z6pLVYVw0K2JvEMst6YFsnI7wHfXWNdx2jKKvoX0NygpfFSEvd8smjZlczCfGlNtBkEbldWadYRBMc68QTWxUXM5A954gIoc57zFOP6yZC5WRUE6DzP9R+HtcFG3Ave+C2LFWrJYvD8aEUI9s+OAUwYXZWCM6q2hJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(33656002)(1076003)(86362001)(508600001)(316002)(2906002)(52116002)(26005)(6916009)(8936002)(4744005)(186003)(44832011)(8676002)(6666004)(6512007)(38350700002)(4326008)(38100700002)(6486002)(66556008)(33716001)(6506007)(9686003)(66946007)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7rHk4U+Lr+ARkfl4nu2wbDiNv2l6V8/LtZ5EvJG/en1PXIcY3L9a8mGKV4G?=
 =?us-ascii?Q?rhgwAPa5ZQIC0Ih9tOMrtq3TK2fh/aI3Fc8Z5CtQTVw8I2sPnJGFJsIdk4MD?=
 =?us-ascii?Q?DAkofmqFcmA9SG/cjokJzMwS2YSgc/AVKcYdOEl+kj4Qrs61VnNST0cf+WlB?=
 =?us-ascii?Q?PoWCKszVm0SE9N7q5I1OjjowBapggpiH1XOpGsF28hI/g6imnRjSYT7+9WxH?=
 =?us-ascii?Q?EIicciV/DIZYFxe5SBC/kiU9LE3yGwFgzSf9Z3dTY0wQgNP1JDi91pbfPSAh?=
 =?us-ascii?Q?OYnXEh4CiGwpre1J+7GTyE8JQRk/v9qBGPs0w/+pWmMh1bui132nAvDJIpXf?=
 =?us-ascii?Q?d1L4PJ29BCdAAbTNCt8QAdJSaV2GDlHCxgR2kF4YOJsh1Io/2SaQKg1yBlr5?=
 =?us-ascii?Q?zUZW+hn/5bZTQGtWjzsvf+7RYDxC8g08vDGCzDSv/rdGc4WCDjkUnL8ch8Vt?=
 =?us-ascii?Q?qM24z7/wXwT+aC4qyjmyS8WWGoavClsvoOtJ6PpNLTPZyJuzBiK7Maxc3PPI?=
 =?us-ascii?Q?0Z2IJ56cJtTg5agoPBFDZY1hdkIuQ2qSc1O2MBBkXaxooctJVIh59s50u/Wj?=
 =?us-ascii?Q?Y6Nm7o+w+Z4uVuer+oFH1eMqj2UIFBYZduWqqXzz9CTbqxL/SxCKSvITlRuo?=
 =?us-ascii?Q?VDUmlg/vBQ4bliuQ/hnVTFp5RxcoZPHNQiFi945GmyZNFiXAJ62vDEWrUj+j?=
 =?us-ascii?Q?MO8Gktc8JbEiOhYAU1UinsuSJdNEifdzhZCGd7xL3/xtN1LO+1MJ88LdIhDP?=
 =?us-ascii?Q?sawzZt2XGtudlS57SES1nBd6dZ76YKbc2li+a+y+till3f5u8LNvyJ2L1Xov?=
 =?us-ascii?Q?xo/+E9SpZx0WfyzdwgxNzPQlB/KQdOqXDrKUL8EFPgUIr9m6BY6Z1GvEwRdH?=
 =?us-ascii?Q?SU0vXfxc21FUqA6/VMqqgOCbgID2WeGEx9r+773xUsR8NWaEdAWNiLWX71Hw?=
 =?us-ascii?Q?89lJKC+Tzund9gKIkFElKmqBKM3jDvmqe2f9K6gYsKnMngR8k8NmHszZUmMX?=
 =?us-ascii?Q?jWk+E5Yt0YhiC/NeB039Ym9u7tJfnFoVPidHSJjV7/r2YQyRyXLWGihZSC+2?=
 =?us-ascii?Q?RBvKwrjc54dTORv6ZoWYkXTc9oxAKzEf/GPYK6gEhIOZfVDYveFxsm9SWPC4?=
 =?us-ascii?Q?Tf4CpKFKfmLC4ibT7q1TVOfrDnmjB4KtrPQDVwCVICemwbFw2aF6FTEI2aIg?=
 =?us-ascii?Q?suqu/os72A5ql6d7IrFiPNGD3Ixpio9jUOjyf4Vy5by28iZH8/8zfDzTss1i?=
 =?us-ascii?Q?9ShIIkSvgbYgdOxksMmqmpFp0Ahd2IyjrGoevNFOCKZmrbvtPcFPfh8Ee0OT?=
 =?us-ascii?Q?1yNQ8EE/pk1QwS+1I1ZoX5pvhsHD9Q25z9bwAMj/JSkgaxZprjAuncsH9ZtD?=
 =?us-ascii?Q?oMklkn33XVw7Cs8pYNyFNFh0T0LlBK6h8j6ItwNBqENxPis2YQ4frI1cjyrF?=
 =?us-ascii?Q?7IZENVKwfDlUm3+Qq+kl4Vv0Sj2yJZ8v0VPb01K064W7j6DQmIlWboRbGSbw?=
 =?us-ascii?Q?FYnDWDcfyv8dOpYOYF7YwoMxyGf0+m/5gf1DgjoM0WAQcA67UhkRjpvUJ15p?=
 =?us-ascii?Q?OoCkRPYUzI0+5YBfli6JxFFdO3fBTFzgUjljhe7rFVutox+t15Dn5sAwTKEo?=
 =?us-ascii?Q?6I2C/4WsTp42tziQEdY7F0SIt4ywek25yqoX2DHLxvAZCwlLce26fN9zGH8o?=
 =?us-ascii?Q?pdmgTYxm/W+ADU/eig1CItiZB4a+2xPpZ/+ZqEZHfPXlEA+3UlFSqs3J4+Si?=
 =?us-ascii?Q?D5I/XVpKECBQPnfcxsMwPBml/p86V90=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca9d4f5-4c72-4188-ee55-08da12ef8fbd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 08:22:14.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JU8xJm21a6xc1pbNIHdKnIYyt+2PPOoznYkiZycEQtkas9L9Nye8wWSY/GMSauUhu2TbCTyXnQq2uf4hbyO2p17s5tJ/ddU3qni2sp7+trs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5474
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_03:2022-03-29,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=805
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310045
X-Proofpoint-GUID: UxkyHAjZaNkyEOwzQ5z-FQupR_w6HRYd
X-Proofpoint-ORIG-GUID: UxkyHAjZaNkyEOwzQ5z-FQupR_w6HRYd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 08:47:51AM +0200, Fabio M. De Francesco wrote:
> There is no need for "struct dentry *eth_debugfs_dir" which is used for
> debug / sysfs directories. Therefore, remove this "struct dentry" and
> everything related (i.e., creation and removal).
> 
> As a side effect of this change, the code has no more need of the
> "cleanup_register_netdev" label, which can also be removed.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1 - v2: Add a couple of "Suggested-by" tags which were forgotten. 
> Thanks to Dan Carpenter and Greg Kroah-Hartman.
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter


