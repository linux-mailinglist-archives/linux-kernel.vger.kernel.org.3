Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E735790FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiGSCrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiGSCrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:47:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1D632DA7;
        Mon, 18 Jul 2022 19:46:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IKsUeU023346;
        Tue, 19 Jul 2022 02:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=8nRJDpPzdtXM6mEY1gswITLP/pcNEbOlvju7w8DPDCU=;
 b=2ASsr4ZA5mgzJXD7EU00AvJzqvtRswzdKTi9u4WrCavjnG7Po6Fimn+Q9eubZp3LEMm2
 V7JxTDixqeR5upDOz5z9D+bsJs2lR9t3XYbMbwjYecpS7LanC+B88vBmC3RCfxzMBjFk
 CPMwStxlWbwuqDbNOxIZLBTA0Q2PEvwZI2H8wuI2GUETP6vUuFylw5KPDffmFDX8+qRX
 pYNtxUj9V5kBd/H4F9kSWKqDXUG8lCWhZNlm2Wp5z5Oh4APOuMuL8ZuLGQnyNDowUntL
 eaI9B7EIkjlMGrK1IsrdC9ZQ2La6V3PaFxcf5xpVucszDvOK8XsWzOxQVDAjrgZVCABu 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtcx4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 02:46:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J1j4d5006440;
        Tue, 19 Jul 2022 02:46:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gg25pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 02:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4bsCVG0NprK+jvjGs8a2MuUChn3BlX4xhKE6OwHzE53/7ApE7WPoI9oVZiHWgeylwOiku5ovwHII7emGS0WU2lVwzBIFmVVpqlrBh38NbYDBCHSrsJxkxAVHKDTkiwJN7+5otBQj6Wo81Ti6Ndxv3WPZheU0CkpDnw1GesIZSHDnVrOmoSqRTikyv7P7qlAOxjbyhN4J5dXimxUrbITYknAecrM6nzHAu3w5rN8OZ829hsqSTHTfwmDMKRFVWxM6wfzk0FmgDDOv2O16jPShFhelRXO8l13mjeZPPXRV3ZYDcfG7C4IoAK3pW4UL0NoYHP7uNyKYJ6dXR/kyhWegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nRJDpPzdtXM6mEY1gswITLP/pcNEbOlvju7w8DPDCU=;
 b=cE1EjT18Q66XvrCwTKoL70Jk8i3sXt+DlZJ4qndfBeB0v5xzrM/mbEA+rACrkM1zI6q8LS0nTmT79IqLMseRko3F7BYEr5Q8hsv8UpBE35zjtDB9ww+ukox4d/aOrqCmWi7SRWFYlgImvC0lyaZydIdWX86WFofoN/RfZaHAj4mqhCpXqd3h/5Jiy3J0PjihNMZpMLCtURN7i24TXkQFepbOA1vcOyJxwdpkAiiB1BtkAanmjlVVtpW5bj9vKxKFtMh03TZ3CqNOZ+TtgPDfDrcLYfLwOVo2+6e4fHEfra4RN6miGu6wEvabOE944j5U75q9NaV8FQf+H1g5/nt8dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nRJDpPzdtXM6mEY1gswITLP/pcNEbOlvju7w8DPDCU=;
 b=cSKOGD7786LygTi+5sk0UDXvermKGsDYboI+NiT367aeBfxoU+D24/D3MGDAMQzGwHNUeDLp5VtNq+8JXS0fwQC2dsXiE5X+WEYK6mD6sI9vSVCYXdEVtbJe7i4ADpcbVgvzYWdbHrE0AJSTREss60FPDAWU7FhtNxpDcdRmrAU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5206.namprd10.prod.outlook.com (2603:10b6:408:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 02:46:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 02:46:48 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 0/5] hisi_sas/libsas: Some misc patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lespq0ok.fsf@ca-mkp.ca.oracle.com>
References: <1657823002-139010-1-git-send-email-john.garry@huawei.com>
Date:   Mon, 18 Jul 2022 22:46:44 -0400
In-Reply-To: <1657823002-139010-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Fri, 15 Jul 2022 02:23:17 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a2eea98-4c94-4ee5-5c8c-08da6930ed09
X-MS-TrafficTypeDiagnostic: BN0PR10MB5206:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+749BJ2H153J7bFvNqZbB52A7vp4qbRBwsjDPq19ARk89bEZSQd/GTWK4YeGmJL3pn/k9YQ6nViBa59EqM5uiio5tJW/F2aAScQnrmYof8lqWXjQa0MuO/PodzyVNrz3g87huIP5UfSDGLHt8PQUH93GDpsXrdc2BaZiRol0paGcOoY6xqvO8XOyZZmazuS9CRTzeMK6B1uJJqEtbZTFO2bi8SetkO6FP0icovF7CfPOi3A/ct0+Sa1DmWcO58EKnQ1HJJZVH+JJbWxikPtsT0vLX5lfQLCa491sJMIUiAHccLRH9cKE4CLiP5r6w1t8AAdQxNlll1NpschVGPQBLD27ZLUC94BMuJ3mSxuno3DRNQO/ybYiM3aIrJYBXnSJoDqzdIX+oaZSzNztrQv5LanSt+8WgXoGW6MgBoE+DRYRfNMS5bNCAQu7SwPe+9D4IUOE+gPCLXts3L9KboHuJQfcw9l+NXr963qRpyzFcmXrtwyD6FbgTRLVXiOX91YuEQiVhlahAg+PazZMBoasXtEm7GG0XpxnXWo+C8fbHpQZ8gf+L14KWstKbKddtb0HO7ZXArwjpTdyMXJC9UM1vDh1Gp7MWqtMcbivRWjHIwuZuzQ5XwK2BQhtXqLu2SGIgEKJdKo5C6jklu+JUQ1m9nXOSJilE4Q3zC6NAiFy6yHCpXNYwWEMbXtO386de0/U3ZTBZgAORYKEaDm3OIaQGBD+kdsZ+CBfYvJg+wum0dTqNAfT815bhOG3lO6bExpybVzhVdlr9+I7+60S2mM/yaOlRyOeEaRRxrLaFyG0WUl3PEccX+qBSCBTRU7hDdK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(366004)(346002)(396003)(39860400002)(5660300002)(478600001)(8936002)(66946007)(66476007)(6486002)(4326008)(8676002)(66556008)(6916009)(316002)(54906003)(86362001)(6506007)(38100700002)(52116002)(2906002)(36916002)(26005)(6512007)(41300700001)(6666004)(558084003)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GCdNZmP332jkjR8RoC6M4yp4r3nx/9q03xXb9qD7LSR9dwk9y0kv/TA06Z7h?=
 =?us-ascii?Q?1/JOAv+dESWbYb6edDDpbht6R6EM5m3Gr/KgXQzn/YKRwbI31iVuaDDMCbOF?=
 =?us-ascii?Q?KoDK+QaDh6yIcwIkNpFwNhNTzkpQsqh2pws7Jsp5qCChva7K0eAr82rQDQJ1?=
 =?us-ascii?Q?7u4d/GNb+weqchx/nkk4Fwcs0d1xLFxMtv9+2D9+aPrCldmPDH3RkdanOJjq?=
 =?us-ascii?Q?6cFoEtvKQEzu8PNhbi1uugeBHAirlCP8kGwILss7XFxwB3eC64S90lIx13p4?=
 =?us-ascii?Q?gPGsfve+4ffXmfRiLjiaLLpjYt5ZZKzCxIZNwLG0fiHD2tlq/hpJVnDAv/3J?=
 =?us-ascii?Q?46aRMOwmAN7nAjeJqpobJxixsecnu2PJ5F6Uy3vMit8uWANFBOgqkQJfdipF?=
 =?us-ascii?Q?CRT6PQrqSPQMu/r8+clE4fV8xMw5x94oSV6MfLLho9x8WM+rG0EvAiixorBB?=
 =?us-ascii?Q?HerbzKLMrdHbzQ9bwjmUjxDsD4us9xKAasfKgZvo5dipB69W9/9g0ybEH3b2?=
 =?us-ascii?Q?88dfj57LRFVLUVVCLYbro/xJGbLs1zHCLBbMddBQRTX8Uvi0fvl16WoAauft?=
 =?us-ascii?Q?/60NU25QHesdvr/Y9xEqOUZieZrZyHz/+RhAhv2YzHkX5uxs4ohrFj4nOTzM?=
 =?us-ascii?Q?lpMGQ87c3zhTd7fcOM38iE6bY0VLuYsHZF8q4U42pGujTy8m/kFBebkhJIcB?=
 =?us-ascii?Q?FjSoZSNwiyTSGv8Genqj3se5TgN6LQ9vAtNN08HoaqYlSEjEhb8ata4nSm7/?=
 =?us-ascii?Q?xeOY2MpOxBYhJ5bHgmobKfRi7bCN18FAe6rWDw0Dt5yUzKZFyEmPJ7hXCqqK?=
 =?us-ascii?Q?w5Zh8RohqKH0PHGc7t/jsavJYVlHQRZp8F/5HDVEV2uvNN52YQvu6AE4+H60?=
 =?us-ascii?Q?mMRgbDL1TBkkh2tBCOO0cdExBDMAnpldOHp1dDItOcn8LfjuCRPH9cbfq9lt?=
 =?us-ascii?Q?TK7/CZvBci5jOXQHb9yKXPmhjCLO3s4K79PMrq8PhKtA30jg8pfV7TUbx/Gs?=
 =?us-ascii?Q?1glOjsRmaR5anIV9TktG1Ret6pXRojNjGSOHwSuVvRyEDLJnEpQUEgQL7z4t?=
 =?us-ascii?Q?XbR/vKvN8fzNkN6z29M0FCPg0lyg+oPiHeDidaFx904fvzcflyUmdKwf4ZId?=
 =?us-ascii?Q?AEm3pC8l/+Aoi5VDij7nk+0NsGTbulcchBL2gcJkAjd2JqK1LKR6Ri3hWVtH?=
 =?us-ascii?Q?509+E8kl/cFQCgL4Lw74ybCTGF+t5ifksVa7Q7EN3f+FaHMGFETBHb+iNZ1z?=
 =?us-ascii?Q?meeg6UEg6Luq6gXXugX0kYqsMYW2Lk3cV0r9f29aZSFcFouCSzE78zSAEJLg?=
 =?us-ascii?Q?mW9iMOINVkSup8pw1K8PJUrDyj0Ob4qlV2KuZ4R7FR6TS4GwrCPbO4XkFyIU?=
 =?us-ascii?Q?MGlWeio3Z1eFxR0nXuU67SoSvgGiPx8tosz97zR9ccEIJPk9SYERU5hzOJjY?=
 =?us-ascii?Q?BZGubwq3Zx6Vc0llY/jqmWeLw1aniVk6TtDyiegWZjoz5ytE0cjCco3HCdyC?=
 =?us-ascii?Q?IMuNgYV1cBRZds3LIWow+TloyoBw2Nb4NdZDdaspw/0oNG6Ob1tulHL1EFUn?=
 =?us-ascii?Q?7BSyogbTa6aK0G0CXcEUn1v11fR0G1Awg1FzwRyxgrfo+VLJllQM4am7pAo6?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2eea98-4c94-4ee5-5c8c-08da6930ed09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 02:46:48.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yUWRKM5VQzuM0A0k5eViQmfdXRcDm85ULFMcApVe59eFJFSk2gXi9Zemlkt7iyUma3GePrEiAZlkD3rm+Hwf3tUpjDN59O/JbywnsDZa5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=910 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190008
X-Proofpoint-GUID: rHLa212dfwuvQjUGjR3247HVzM_vX-CT
X-Proofpoint-ORIG-GUID: rHLa212dfwuvQjUGjR3247HVzM_vX-CT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This is just some random patches which I have collected for the hisi_sas
> driver and libsas over the last cycle, described briefly as follows:

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
