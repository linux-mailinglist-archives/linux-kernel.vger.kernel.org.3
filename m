Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D335A8CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIAEjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIAEj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:39:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187B4D759B;
        Wed, 31 Aug 2022 21:39:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNn7bq025023;
        Thu, 1 Sep 2022 04:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=iZl+qvt0B11Cok4ZPo3aib4A4Qy1VkUp1akZ4aLs0dI=;
 b=HYdHATjHxs6XPwHmAGnybOpZltwfBHegv0nCzKx+NlXkCSanPT9zDpyVpBy20nzR45qO
 wHzC/JO2j0lQvWWHGySzP2MvPgH4pCrR/Qr7ctXhundFuG/CM9e1EJah2ZSr4iJsvuWC
 kimKxc5MA7/Xc+mxnMD5n8Xk6ttUw8HZzMP5iUN9nzmZGFtEa+EaPK4jK1rcdEve+3R/
 TrTISQEPgv4KU8u0XRVmTdgZf1gMjF1eODRMH72M4PeZ2iee44MRKnWQrS8PRL7w0wSh
 fsACjR4Qe5cMgC98tq0VQHXrnZQtdiahV7mJzKafeiQxfZT6peD2+/XZxrRHzcEpEq0q oQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pc2nnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 04:39:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281317WF031325;
        Thu, 1 Sep 2022 04:39:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q631pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 04:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTZF11pOB/zTdLp3/INr5tiIlFgJVGrsaE9c2tQIg0vKGNF1SmXRsK9BfD6lacId1RUJcdYMk2EEgckkf8oFkBFcaNZfqdr1rmd4zbOqXSDl7r8u/aDnq87VBo9ji2g4tDnSaOYcUhqejeGbjayk/nUORTCwPaXcMoNx5xJ8qnHUNeKB6r9Pji5XoVQUsoClYRMjTA7aQKakMtOtJlbUmCwyVLI3+f000U8rEoQSUwPXBtN5MDL+jAcPvUHws1seII98R4nakzfeTnXAuW7soqHxE0V5t1brzkjIHZJS0Suy8E2wbKpf14ud3NBlepy+Dp7eRJc/zOfLmYYpMlWIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZl+qvt0B11Cok4ZPo3aib4A4Qy1VkUp1akZ4aLs0dI=;
 b=Q9CFCn74COsoHQvGBVzSAIJ15NBEeLXq/hh7/weKrj76a5PbF1sq6Pr4WzQUNuHuwGiob5lRooYlyLHPe0BlKq2jb3BsV9AvPJwqXuODjfMj+piudLmNCrBKeRxtuyxUvb8QB654ISXwPjZhYYnFGlP1+MZ4Fc/pqcF3mLJHQTArWbi+oxSTEqs9hCSUBleq67GDvShFzoYB+6It9QkZTk4J9YTyowv14V2fSenZP0JkUCEDMNPNmApSWMPC9KBpcnTDjAm3MjAoUTLWvH4UP7IufxZAxNMhMDnw9KHyOfVduFeWzKP4DovCcYcEKIXBgQ/prlbikr637XJwA0v0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZl+qvt0B11Cok4ZPo3aib4A4Qy1VkUp1akZ4aLs0dI=;
 b=GEyEUV5AsKpUu/GpA/fT1ZW3usa2QQK/+FgJiAsQtLEBOoy+ZE/iRD08fBb42h2HaoRlkx2rUAmHUQTuckCuZK1g6NWD+6d0lJOBZW2VXRh22djzS5NHZUuN8n2gpysxTRH8kGo8zdjXzpX+irwYcSK6WOJnJpIaBMuMCiOjd0M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5191.namprd10.prod.outlook.com (2603:10b6:408:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 04:39:24 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75%3]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 04:39:24 +0000
To:     cgel.zte@gmail.com
Cc:     martin.petersen@oracle.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] scsi: lpfc: Remove the unneeded result variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r10vlnda.fsf@ca-mkp.ca.oracle.com>
References: <20220824075017.221244-1-ye.xingchen@zte.com.cn>
Date:   Thu, 01 Sep 2022 00:39:22 -0400
In-Reply-To: <20220824075017.221244-1-ye.xingchen@zte.com.cn> (cgel zte's
        message of "Wed, 24 Aug 2022 07:50:17 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0202.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95059515-b47d-4996-23b4-08da8bd3f222
X-MS-TrafficTypeDiagnostic: BN0PR10MB5191:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqQZK9JxmBTApbknaeAJRl7oOz8ThZnoxM6m2Csc6pjOsWS/TIMnV5GBWfCAboDcH7t5fn9Yp8hmVR0EnMt2GNOmy0tpryXSX/9JK3aaPQH7I2D4aSk3nY7SycSft03vaYcpHLCElxQlwTiTPhnzmajHCTJv9Cg2Vni5bAy34xDn7xrm0hf0eAwYWYBncK1a1uL6Sr4ncYg8PukJN2HJU/y+4u0PMJdEqK2syC4atkudBFFbSlAb9rs8Ae0mOtBL3ooXYokP0HM0sivxWAgQx56pNC8A61iybdZq1f7Igj8kxRCx0zjnNXOeJ7UnXz/VujQFrk9C3HbI2iJ4EftkWGWqphGIAKWekK2X5H65DVpTfljYHVVSjV1nh3SzqKxeacATvMwBsPlDnk1D5Bq/mX5F25lZCSEnsKoyZJv/WEo4B2iWmfY49q4mC+Qfb/6jTOkId86n9Gib1sfvESO+Dbc8z6dnIL1De5XSayhyAum7y7pFwCx4OvkB6TWegBo7K26fUNfauZzvgajzsqFFTaiTdgI+ykl5PTjbNsXk37d0eF4HgVIEwzTaPBVZk2AUSPaTvhhrIQT6bOwwA8//W+NiJFF4zn1zV1eQDzQRK9+oYyCUJ70ihtTCZ7b4Gcf6vs/t1GtGCzMOMZAhw2xJltr7/3Yb/OPVyOixMob6poGD9MdVB8WkGw9Q0DV9whvJPGjO4fLjU+aH8piE6cd7LvMIMo63FdJx21H8cUoh252Qy1gLnXrwSes6iOmR+aq/VRfWehhwde+4sJztUgNKKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(346002)(136003)(366004)(6486002)(478600001)(558084003)(186003)(41300700001)(52116002)(86362001)(36916002)(6512007)(26005)(6506007)(66476007)(8676002)(4326008)(66556008)(66946007)(38350700002)(38100700002)(5660300002)(2906002)(8936002)(6916009)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VnhpeBP6tYK2eaH1ANjlrWa35XazV0jKZbTZhSq3XhOmhG0uhJEqdp1KY+a4?=
 =?us-ascii?Q?TexoSK9NJ+Dgq4Y/riG+wqFA9T6QmyUKX2BZdHGKZ4g1No8AZUHryvuFHuwo?=
 =?us-ascii?Q?8B+ZovD+qNEEQWT7qwegQl9+VYhg+hY3M0CmYTb1iFIZD6CQdBKhYOJw7Hgx?=
 =?us-ascii?Q?S12hm8Lz/Gteyf0Uks2eufAnOlr28CsVy2pBplZmgXskthaP92dzbm+dQjaQ?=
 =?us-ascii?Q?yElu0G8pWarsGuWHGF2V9qI8I9W+9zi3B62iZJvEFUrB1kGFt1KmegWeX7+L?=
 =?us-ascii?Q?Ksr1K3ij7LrZcYax+kPDczIffMyan33H4m2tr4ZVydfTI0cRs4Akm14skoQv?=
 =?us-ascii?Q?DbhCGD1HwhX2FBJjuWiimL9HVk8usHbcYD1YZgfxiY8njsxxkm7hCRAokxSz?=
 =?us-ascii?Q?7kS15bQKGupg8qnHOOg3PudgGLo4IOLHV46Ymn+J831go1N8h2perlJMTWuX?=
 =?us-ascii?Q?MqTxVc2eQmKNL0v8uVleNCIyZm/z6GpPKJAZZ6PF/SwCISWr5LSb1Krj6nn7?=
 =?us-ascii?Q?6M+H7MpMmCjG23+CU9ROmKEjd9OiCalZxXSK2migXUcq7u9xFoPn8B5+b7T0?=
 =?us-ascii?Q?B8uyZkfAdZEkgsqCM8e8/W6Xfd79ycPPyPB1LLpuqwcqxNSRJtH6nkvcyLE5?=
 =?us-ascii?Q?UNUXwZzoQAlGyitHe6kfXwak1wTGVET9fwH2r7Ct6RFWKtVR2CxkLCr125X8?=
 =?us-ascii?Q?ADp9AtRKAWaQwpPGZnNGtVGdIuWzsXkqc7smnUw2Ehm43N4R7/70AEwZOMWO?=
 =?us-ascii?Q?Hi2GXY+hn8BavZV9CIP3uImAtGum/bWN8tKGhSspJ8Od1D4zzOSvDYg8RpGl?=
 =?us-ascii?Q?xrvOqb1ggiovOZEV0USTdy2j8UFS1hQ3VamXWAck5+4CnjoEXBo1Rz30Ohu6?=
 =?us-ascii?Q?YRqMbtW3GWY6mczGH0YKDgRASN5ME02hkW2aDrtQdqsRpM3tBO7YBRS0YCum?=
 =?us-ascii?Q?Wk0MbgFD738DQ8YpOuW60B1YC6QUkaQmrPXKI09zRX7iVEqzTJ+Us0v2jNz7?=
 =?us-ascii?Q?auDbgcz11Qtp+MhL8P68f+jtEyF1LB6cwh9aV7Iy4EW7kTWV4MMdUvQ3jERB?=
 =?us-ascii?Q?wI4K5ztLTplEctw2rS9nMlUfw61CTm1byaW4xTfvePwzTyuXn2dkoUCwxKhu?=
 =?us-ascii?Q?qiGtS8mKIkI9ABf9swfHIhFXpgpXVb4SzM4lAG6jjb25qUiw3lpBvxjEJdMU?=
 =?us-ascii?Q?+30WEufL37NCZ3DIqheLIr3l3miDv+cZT+ghp4JszStpteEs7DnVXUIRg2ev?=
 =?us-ascii?Q?vvTY9T+Rbl7Z8esNilYjH3Mx0BpVAa1T3mM7+dhrP0eGQBi7SMSIaf7ha3WU?=
 =?us-ascii?Q?+pVZ639K98L8zzLdWCr3gTHZN22/SRSjx5SVGR+FSV++2Yozy5hsPj++Yn34?=
 =?us-ascii?Q?kheOGcPleuCVY6n9popPMDaC7Bdn1Dp0oaApESrL2P6Lrrb3kXjGyC4WPLVY?=
 =?us-ascii?Q?Os+Kk7rxS6kiuDroKy6UiwScdDS7yVFouE8psXEpIegGYUJFNkuyFKSCbo3S?=
 =?us-ascii?Q?X/4doBqP00WqhdXbxxJzLcZojxX2NsroZ0BdQxR2S1v5aP5GDN5sRDTBGLy4?=
 =?us-ascii?Q?8dInVFl9sA8ZvOCTDYo0F34QtrdNK03GowtpMCtdJR/hyoy+LrcNvc5bdX0H?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95059515-b47d-4996-23b4-08da8bd3f222
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 04:39:24.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9sZXUKcH5c3+flmriRWNttVfy9M3feLYaE9mbsQLRtDynMB/AkUtrg/pR27AEJ+LLBF/BPStEkDf8tku3BIvQrbMH/uDnAWAYZYIaeohSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010020
X-Proofpoint-ORIG-GUID: DGc0j-E9YV8SZW6c0CTgDrtbhM9SWLuD
X-Proofpoint-GUID: DGc0j-E9YV8SZW6c0CTgDrtbhM9SWLuD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Return the value from lpfc_sli4_issue_wqe() directly instead of
> storing it in another redundant variable.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
