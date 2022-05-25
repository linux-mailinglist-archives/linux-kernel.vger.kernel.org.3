Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC725334D5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243037AbiEYBnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243331AbiEYBnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:43:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34A8580CA;
        Tue, 24 May 2022 18:43:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24P0AM3r010199;
        Wed, 25 May 2022 01:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=A1im4lxl7whin3jfueQIrpdL5EdsVeO7j7gShiHmRok=;
 b=HXvLScVBlgpJZG9r0sGiMb6fySXwtiZZhPERbmiF3vFxT4ItRWfDYqGbl74bkaMVOmSe
 j2jG7EY8+NCsp4rsboapwC2zjO0JV1tIKsOqH1bSwqMmZP/sAEnE8gZuPVjDD8tO/GfW
 B1EVXDM6/ZB6OuSTiusOPBwy+qGyZfa9iO6GqZYEwlCtPSsWAFkKV4RA1LC7eSV9BUNn
 BI9f2Hgcz4LvVZM93Ae4zXhVJd/taTrKL0DXXLpoiLrHs5g6+CtTq9se6AyGL8Ci0ySE
 uQ70U0OgwE9c/psajLV0KMHrFbIxggdwk94R6+zLrI0sNVNwPK99eMCLP38vicFExMN0 DA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tdru70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 01:42:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24P1Zt5I030521;
        Wed, 25 May 2022 01:42:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93wy9n72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 01:42:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzqbMlg26QVD9tWjy2UwpzaOdvw3KN2TxIAgA+5MLGkU+b3w6kgjxDnGBBXyBDFp2eKeQfUX21Y/fIzOVpWPneopWddJnHnNyrbBAvcN7mcU28MYW82t4Y7QTRYRk73K7kjtorzVqUR8/uTQlR7sxw4XNPhBWy/D2F8QpdPmnoqS6X367L8QayKXCsQznyYZTnRoREKioUcEEMUP5SusHb1+jHt2+NLwP2zdOf6vMn2rMdycvs8JCclEhJek0JpP7e97+bsxdafEyMlo9/6JMMJZ7VRgviNkvL88loOPxAdbEVCT7zyw8SpZNv5aV93d8QmUX9M1aRZZ+OPRDYKosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1im4lxl7whin3jfueQIrpdL5EdsVeO7j7gShiHmRok=;
 b=KzFFdIY+VxWeqAt75Qt4VADynL0jzhZVNU1j1zO8xMvKR0Re9zfK1KYiAIuwgMwiOXZG5XsfaJguS6PZe/o3Kv/iCeHfxpF+oshnRpw6VieGWGpC956aLZ+dzyuzlhrQ1MOqSj1cIfRZyFeE3XvFM4BE4kkelxXvQdCMd3gmR64iKCn8L/rU6pJFJn2FoCJ4LUEMFy4HPMN9nwaD3w2hHTV4y6jxHkrEzjyjo1OKR66+ksS+lBOpKC93Zogvpc7opLt82fuU7B9arZmLeBdKnfpWkwbO9BNW07djs67S8mvV8Ns6mU40m89z0mHviegEEZEuvVzvV0+whkcZE24tbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1im4lxl7whin3jfueQIrpdL5EdsVeO7j7gShiHmRok=;
 b=OawsFCDSbB8E4TXh5eVtCoak6x5FryHw/tptCvdY30tbU27sAgv9hW4JnfnKBtiIedJx4t41AzOmBknKFd79fv+YBM4HNM6kVF2gMjkvmtjBr2Goj/OXTU3hip+ABoaDZRTM8Gvyh4qEMaFaH1+BkJD+VUSiU4s38OF0WKxlbjE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5336.namprd10.prod.outlook.com (2603:10b6:408:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 25 May
 2022 01:42:52 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 01:42:52 +0000
To:     Chao Yu <chao@kernel.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] scsi: support packing multi-segment in UNMAP command
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8tue6ex.fsf@ca-mkp.ca.oracle.com>
References: <20220521113259.3953757-1-chao@kernel.org>
        <138141eb-6bb9-88bc-cdb0-85f6df8b18cb@kernel.org>
Date:   Tue, 24 May 2022 21:42:49 -0400
In-Reply-To: <138141eb-6bb9-88bc-cdb0-85f6df8b18cb@kernel.org> (Chao Yu's
        message of "Wed, 25 May 2022 09:34:52 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:806:24::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37967454-61ea-4fa1-46a4-08da3defe192
X-MS-TrafficTypeDiagnostic: BN0PR10MB5336:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5336F2A25354FA5B491C8C928ED69@BN0PR10MB5336.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Fcx7eJjcOvD5Edcw4Jc/UME6kTPsqI22GW26nB3QJmK4rJwBZzHoRn+mRQINdfpw4qEHNr/1kHB/IzaSzRYDUDO+AmgjRRmQrLCdmQov5drqtUyeVpxYFrt1bI5Uf8EzA2wjtnAHZ0CjGCSasT2g3lQfmCf8E09DbVW2q5c+hIoGxK8AhtkEmd5Jt9hTlskcoeSeaBhEiZE+1tPLxD6gXKYNytFowncvES+quoopEErOhK4/BHQB7rtcS1OdwsGiPv4LRjCla5yQ78a0hTBMf7aRLBvfo6BIo63DLKN0EKkawLyRztdoaAZ48Gc9ZAX6JZ22hz9+bMhFWJGVYRrwGpHa+4a2ZgZPjKA1wVodQIWH+soaKMvPB520NXrZ6Lx75p+JZqtwmEOm6rdZsv5Lc1CVigH1vKNwysah37YXmq3xCOGXJlhfV9k1is94E5ZjDE1Q7sMrr2En6oMseuYj0lkWz9Q77IVF40y1aYlYOJsngh7egjkTqwWr+HZi0UzbUGo9Jy5D6iGrs9WRQUoQHH9rZsG2AFZmwICm+CmibgEWK0wIxdhnndvmzggyHyVrSAUfOx19ieREqzYRwyFq/Yx91csNm+5yfDEy/PgTe3P2V00yM4Qz9BAda7zdLJcc1FxgV34HKUapRx2rWuVirStCxfKpbgklRUNOtgN6Q0r1ja3cEMpWkKW/JgeJdJREwbQAbUz3U2AZO+0mEJ6JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(52116002)(38350700002)(36916002)(38100700002)(2906002)(5660300002)(6506007)(558084003)(6666004)(316002)(6916009)(8936002)(8676002)(4326008)(26005)(66946007)(66476007)(66556008)(186003)(508600001)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FyIml/Y/XsGKzQIXlEh4di1PvCEJemu5CZWD4C6Rtx67aGUf1yBmGD5FNfR+?=
 =?us-ascii?Q?MRsLHzcfN5FN+ufWpyyeW79UgGEHiCTsmUaO4JNWQO5bRmuqTrM3fWpztWmF?=
 =?us-ascii?Q?GTx8NVPjIpuZ1HK+IRf6q/wVnCOsKcJ60iP7/rVnxp6gCb9RonvnoZsw70/Z?=
 =?us-ascii?Q?GS5zuxuAko8POt9KM8yNIrW/OpBsrBJIT2VTALofpla9GuMJ5f6oJ9049huJ?=
 =?us-ascii?Q?iOP8lhmykpmv2bn3WB1J9CX2ZJroEwOsFRYIka/NjTgIfnxrgzzvCeXyCPKx?=
 =?us-ascii?Q?FBAroWvvj2W5vOMlY0Rp+PwuAjVbAkSrsuPPhvHWp9URGgr3Id8XA7gkHjQd?=
 =?us-ascii?Q?Gj6kUXpRywBvdlnqAlFSr/DrVmo9hEddKmLzozdIV/i7NMiQZ2USKoHUQmQT?=
 =?us-ascii?Q?vRchDxj35sfGSoTPZIRUfpapwvqxevJXyPB/uE8EKMg8jeo2UBauMPRmUhCl?=
 =?us-ascii?Q?/tzDGl2JQM1bLCh1MKBS/7mNatRMyUzixTUI1qSJrnX8ujonh8jFJ1NzWgpS?=
 =?us-ascii?Q?kSXc4iCWK3IMUH6bVIvwWGWTePIOqxGqiGP6EwpFcMVcv3BUJoPYiUQjmijL?=
 =?us-ascii?Q?mCRcFTv0Cjbq+GsN9zr3lpcdqAZoAYjDGXByIJZMNMFLRh/E5G5o+kdgUT/z?=
 =?us-ascii?Q?dtAYxN8RdL4XNb83vn6yE/QXKptUNFzmYnG/K5xoogbbCzb1xnGtB0JB2xup?=
 =?us-ascii?Q?QeQjM7gyVtv8Fh7NBp9Ffjydq8SnB0abA9p4krM3r53CMP8qezvB4GkM4iUN?=
 =?us-ascii?Q?bQ7SvUAwenP11t1AroUkvrP+LF/17AJj0bh4GfqgYVyP4OQ56ZBnKjvfnd6A?=
 =?us-ascii?Q?F0+xZ28NyE3kLmR3yFZtyQlayTGcsevi8HZDgKSPikXfVwZuHenNQVteuO71?=
 =?us-ascii?Q?0HS897FHdQpa4+HOYtsU8TL8JQ0l6OKTKe0STGu4XBxYJRMnKwPZhCGkiREm?=
 =?us-ascii?Q?WEfHXAY8cKuTR3QNiOEVJflf2j4uOpTJGDqWFXwfI3sShAyhAnuc9+A7ZmH5?=
 =?us-ascii?Q?XtHRk+OWzh82F6CTHNmH60qgUFPNXxROomv1DQn2jhesml2Em42CKN0PeQsy?=
 =?us-ascii?Q?KbK7xHd58XHKZDP5GUEDkCXeMflEZVsXArMrygPIYubbQz4hdG3exm8ybXF4?=
 =?us-ascii?Q?qkorHTvQCw8VUSexj3bhZ/Tje0DEn5wDRVbW35Mkk1c7X3OrwhQbmPJA436s?=
 =?us-ascii?Q?UWYRgYlYlFhdZ9u4m1sksrHllbsREBw1+9zCtjuwnKJP16VSzqXptjBcCrn0?=
 =?us-ascii?Q?O63tDP0EeFHHLoOjJ7vLRK5KQBlVk7hFajbJW9x/PFi1N3pjfIDYoTFfIcsb?=
 =?us-ascii?Q?TZXZhxmcfi4GvnebzkzPspVS49B9DfMmPGZ0RKAZl42Q1qZHFJ/eh/RIVKXl?=
 =?us-ascii?Q?AZaK6bNp0fqharebW6IUh6jlwAZcUJQ3CxvZroiZENTdGwuOUsHneGD4UREU?=
 =?us-ascii?Q?yBVvJayacMpUlme47WLB3v1UkCXPbOmTSflTEF2u4Ys6dbD74socNZbOjSbX?=
 =?us-ascii?Q?3Ie3NV+LHbRzqs5RCQEf9VKtj07cIzjSzpwCzaVpfm7WrS68OZp90NI9bNYj?=
 =?us-ascii?Q?LBVLampnG3tc5ZNlGeCj+2abxs771O23KqNmnCAi4dqnsLBGgJLd5/EDN92E?=
 =?us-ascii?Q?LsoKCCZNzTmhaA2aI4V35slNpUXIwHxreoxEFfjhbjzZVI0pt7WVE+aNh45r?=
 =?us-ascii?Q?iTwuPZcvz2S3Y4SxFN9+beFUZKnmJA/d6Jc5tk20XGaweclYK1kSTId2E9H7?=
 =?us-ascii?Q?hDBtTBRIB9bMc9yNFBxj6byYIujNTx8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37967454-61ea-4fa1-46a4-08da3defe192
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 01:42:52.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7W7rFvTbXJhpkcN/kIdQewsNHEGYNAxM9S9JWF03DSsQ5bTusx6l5iZERoDYrZlPAW8SOAh/d0VJ8vm+srBl9PymovVznnDv8UoMgp740pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5336
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-24_09:2022-05-23,2022-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=803 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205250008
X-Proofpoint-GUID: Nh81TbsBGszAp6eLkAgGHE0ksKExJcA2
X-Proofpoint-ORIG-GUID: Nh81TbsBGszAp6eLkAgGHE0ksKExJcA2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chao,

> Any comments?

It's on my list of things to look at for 5.20.

-- 
Martin K. Petersen	Oracle Linux Engineering
