Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F9F54A70B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353194AbiFNCsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350908AbiFNCsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:48:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF40B5995F;
        Mon, 13 Jun 2022 19:26:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E0fH1J027238;
        Tue, 14 Jun 2022 02:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=o8BFDEPALOSYBemBvGKGPnQwW78zkzMD6Tb6ZD2GmCc=;
 b=lBV4WVrBHJAuuDu1yjKQRrmCmXwhjlFtEaU68UMPk5e5Z68LrPGApHJ9HjqmjoDRVoa+
 b2vqF5CVYY80MaHGv1+ngmMSEQTyhWoaVq0BVzdDek+y7lIOj6jR/Gk69zNP5I/1/HWZ
 3xSM5kIMyAu2Y8VTJD5fY1o7XnRczv196gAG7sQ/JgEr8feKtx1ZK3Bl0Yujv4Uwjdgd
 OCq7TQ8IxS1OqRgUISxJkjOq9LCOIva9TwyJYHiedvDeq8ryDMhwIknxCi1Qjq5Mwwm+
 m8HQCJYJ3HJvKruaNaDTyisD4U/aa2HswkKRlHjUA792f5HcVUB9YQsSbTLiCObAvujJ 0Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns4j47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:07:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E20IKx025494;
        Tue, 14 Jun 2022 02:07:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpgyerats-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:07:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESo3zYlXRVYzxb3rAom1Ju8e+KCp2ywTMZvZrmnTTcYz4Qe44xTwSQMTEEA2o8JsNjcmvG9k0qasx+UyDgB46+bxmMF6QhIptMIcF62V/LQG3O7JrBPQeVzpzrsCO9pdbT1NlyjURNN/Qp6UOis7RevsUu4Kh2iyu8cFj8z6uJ8zIaCitkojI3KUPYXCr02SPk5EJ7xHnK1MUkRuZb7UtDBgrX8o3rlJZWDXjPB2B4pwdMyR2JyNqIwSd3XwKcuLE+Qfpf17AXxToC6VeMyLglXU/r4igxGvvWgsJTjoHcOBjze8VjdnOvpLT2rqrJdi2L30zoRympozb0e1kN/Eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8BFDEPALOSYBemBvGKGPnQwW78zkzMD6Tb6ZD2GmCc=;
 b=RDOpWyXrwbf72Kvlp55lycmlOPuQWrpXvSp9iL7Dj/CaqSVX/c3pOl88Y5XWefMOyIhTCYDNIXJ3wxdWATz64cmQdCDLBple7cXaeUbD6ADS+dykP0ueNmI0D9pi+6uph8LOLaObxOPgHNwhuQ68Vfksc2zYklBLRQqvwGszK/ltdEhWFiIe2yCMwIZrddErfXWghM545NOKRqXwH29Lj+c6zBCH82Is8KHWnyhlFo8S0Wa1OIIR2uvj1cDuHrEgtYQA3maM5UYeKxYYP5n4gRf185eV/9eC5eYpsfcbZdEAvMoRMfrx2Qsh1ku3hKExe+PBBu1yJriCQe6CX80bfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8BFDEPALOSYBemBvGKGPnQwW78zkzMD6Tb6ZD2GmCc=;
 b=jaqpK4vnKFt6T3e6lc3CRjeJctXd38JFoy/dqDj08BsQBaFbpwaHaHNcsOSJS1blL6k2o7d50VvHpWN5ytlfHq9yTUuu2xqJLd84BTzTOyq8/m2gYMpPq8uS2+9GvVe3sDAT9EV3epbk7XXeMPZT+BcoxDBvQZcUGbjqCa/NC5Q=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR1001MB2251.namprd10.prod.outlook.com (2603:10b6:4:2e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Tue, 14 Jun
 2022 02:07:47 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 02:07:46 +0000
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] scsi: target: iscsi: Fix NULL pointer dereference
 in iscsi_conn_auth_required()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15yl4t2tz.fsf@ca-mkp.ca.oracle.com>
References: <20220613014321.107045-1-yang.lee@linux.alibaba.com>
Date:   Mon, 13 Jun 2022 22:07:44 -0400
In-Reply-To: <20220613014321.107045-1-yang.lee@linux.alibaba.com> (Yang Li's
        message of "Mon, 13 Jun 2022 09:43:21 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ab40420-7a50-41c0-3efd-08da4daaace1
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2251:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB22515716EC4B83C70424F34B8EAA9@DM5PR1001MB2251.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdXS2gCvnyN2MdaIbLh4TYRzLfhATn4i6xMB1U/S0CDK4bi7IfAvvaoOgS5SoFvq2ApBWqMGLj8arT8dXxfeg3gIka430BB+IWFI6zh/bzYlOi6hlMALkTlOAslDeXBeqlnOns+OWv4934AAbbVloNBnluOMsa1OJMx/30yAxnshV+Sxf/76+N+EE9sMcFAfXUw7e8hWPCJ/luR4oai0xKj9nZkXmaO7uqJ1kTJ8P3c89oogen709X6ZqHaakW/Gq1N7qqyIJJ8ZfuhozFucOa/yiU+ZeNHEPTkpIhGxZRKpyKcBmOq0+B6cxGMK4T+39QvWrS82MLFWx0FL9i0xcttmyFgi3Gwm/HPH7vxymfA2NceFzM4uIYKlyj0m/GT1UZ5TQWsauzTdAmhq9neaDK0WxVj5/rkmD03FVffet1aH5CrBY0FgNOoFA278d5fksCogGEpU1Vp+Ijh5DgEJqn0+2kMqAlJ1LpUgv9U0kmccZF82Ggi0N4YONycIE6CqtcoMtPmcjJuLfpD+lgEsDDB9biz1J0HZPxTqd6cxZddn45a0lK0hn4TAShByCv83RECM6rN1Big2RZZHj6NWUOkXdHwjAozqPaRMBhgQw+6PWcT9aHm8P8M4k2VCTePBO1EAks7hEMqI3tACxNHFnJfKqioHZ1j4g7/tiVYWCALhE3e6M1bY/BO/fjnTiB/TFAejQos6+haXQsgCXmJavA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(508600001)(5660300002)(4326008)(316002)(8936002)(6486002)(52116002)(66476007)(2906002)(6512007)(8676002)(86362001)(26005)(6506007)(186003)(36916002)(558084003)(38100700002)(38350700002)(66556008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v6qsCd+B9+O6cas2cQreO+/H6IUIgvIQV60bl6xEa5iG6fr+4YhupVQ5hMxS?=
 =?us-ascii?Q?tZHxFRjor+PPcYZe8CGU8zysoECOJWhj5i7owdnR1YWGm69lL1pXlwMUSaMa?=
 =?us-ascii?Q?D44NSDZSv8kYU2ZL+oku4RmMC96C9shvZ5vKKMvnpVYtE86X6ACANevIsyTS?=
 =?us-ascii?Q?d9DyOM/9rcwFBGtT0nneLmvas4NZFRHGFWnxq/MixrksRbN5NuKhvs84wQP0?=
 =?us-ascii?Q?ew/nHB6YzGAHyK/1JypTFF+xFe9X+Z9YjVtt53aXMZnZ/nxjOBsTLuOX5k/N?=
 =?us-ascii?Q?CbcwmENs9dmsvntsZv1obQbMaztEKjEoIMJ/zEn8IJ5MvAvdC0ZgGB8zzFCx?=
 =?us-ascii?Q?J0hzY2smUF4UZd01md6NzMXsqLg9J5o0ALj14dDdC3V/FBNWijN5LAVI6EWx?=
 =?us-ascii?Q?97JSIAT5GfG36kRFnUQhMHdSuo2fNhGLH8QyKdYwv0Wl3xIKBls6RCcFfXzU?=
 =?us-ascii?Q?zJZIZgch+yFmwF2R2Zk5PVTqNsJIlHrE8C3Rs1blt+6wAzdSVtSuqFNrcz2w?=
 =?us-ascii?Q?mK5hKdc5rm4uGGwSYx9XaBTOdo3VVNEilj0UPK9nFyyvXbbd8BVlBtAem9f+?=
 =?us-ascii?Q?N4nkHrGvHzPAg0hsDuYzxucoouECegvDSCuRo2YGheZ3MoqZfkdxNcGbShpb?=
 =?us-ascii?Q?uEGT8ZLz0808nVrprc0ZX8kT3Y50f1CQVFdy82E3h6CVd/o5Hf18LZoCHlkg?=
 =?us-ascii?Q?jqDTjJzYDGU+F0863zlU21PEY+cSZVR5fHlfS2FIHHQhLYxvMBE+fpz96bMr?=
 =?us-ascii?Q?0GzBDSBC+DAlc2omU1il26OCPNygTkpLANWFgAawSex0+kbpo+AcyZO8QSPr?=
 =?us-ascii?Q?ndLOEXn3XEogLXQTV4UVXGDcq4b2zlphNM1bQg3yKciz+8/6nfa+IzTYpORI?=
 =?us-ascii?Q?W39LkkNqk0i22sXNYa7OLfZGnmR6mcABVu0wVX7c2YNiVwGKmHiulM9/EUeL?=
 =?us-ascii?Q?qPay+MSnkv9t3fIou/FFwnd6ukWVyDvdAOeAS46zdTZ2qktz4sactGTuyZFD?=
 =?us-ascii?Q?hlLOyoOj6upFjU2SWuHrF9ck9Cht1z+SZ3897WWCUUs2kmcLeQZBh0WVxVnr?=
 =?us-ascii?Q?ZoTCSM/yVXHzJB1uRLYcl4YDS04X+fwzVo4wobZlsVSsvGRt9r4fLPbb7j3p?=
 =?us-ascii?Q?HFWGccmYfOvD2BzBWj6Mme1zpOr0RStdei4gn/DLHaSLMt5BFYehViyFrPl0?=
 =?us-ascii?Q?VxxiwSUott0Yt0yDS00R3Abzw8F1lKezq2t9xXHhTc6UBKPRejk/BTzWezxd?=
 =?us-ascii?Q?7FMqkiCbxbp37U19+3YD0G4tXzp0QEFVZIrKUKp4BWA97HwcujMnSgr7CbEK?=
 =?us-ascii?Q?h+A9IFFSEWGORHWofO1P36HzJ10zut+A6swLedFsJtHemE09MGCjlVAhOdAA?=
 =?us-ascii?Q?0aomMpVsXwfzqSU8S4emVMnuUZoTCz4mZi89tbom22JNIJAMzk/WfTsTN70i?=
 =?us-ascii?Q?ejOIGfxQB0T40kbPrxryAKlHI21C8hVSR4NwXF9dBDlp3602uc43r/CFYpcL?=
 =?us-ascii?Q?uiByD2VZdUldS2bseNZsy34vRdAQEgqKKuBdbmKlP4xtymYLzI+HJnXIxon7?=
 =?us-ascii?Q?kDoYpu6SIm1RFPjP1WU6r8KF38DkoDG5sUCdv+4A2DYKNLmFKc7FX9iTqiJ7?=
 =?us-ascii?Q?hULf3bNC/Flppqi7zVJemudRBUndIgcYbUGbEXENtLvEmXdRcKAid+bBoLSl?=
 =?us-ascii?Q?ns95a5F8fhi0xtnyTcGj+Lqy0Gx/ttPexLFgQCaRcrprM8mpUs944sTVCb5h?=
 =?us-ascii?Q?25yQFsipy3aTH5q4Z84EGu+C6Zk7QRE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab40420-7a50-41c0-3efd-08da4daaace1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 02:07:46.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di/CfnGbg8fI4khJrXNBU4mQnsY+s5UsFtfMFpbHDoRqyxCxkbE75YMkj6iEFRD5oVc/vKMIz3Q24IVdwmDF3+a2rUoqZuiud9yReNxKp7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2251
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=942 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140007
X-Proofpoint-GUID: BAU0R1xAkfb-l4N9uZ57kl8MyLMv9wT6
X-Proofpoint-ORIG-GUID: BAU0R1xAkfb-l4N9uZ57kl8MyLMv9wT6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang,

> Fix following coccicheck error:
> ./drivers/target/iscsi/iscsi_target_nego.c:831:13-26: ERROR: se_nacl is
> NULL but dereferenced.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
