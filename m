Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496CB532167
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiEXC6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiEXC6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:58:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FD49CCB3;
        Mon, 23 May 2022 19:58:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMhkOn009825;
        Tue, 24 May 2022 02:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=gduGV7z0HabbvtIbaTKpY9glk+4+14UUXVYLs2ozTy6HqXerx4LrBp13eIH3cfPRH/Tk
 PDctWdyCpDBmy69E87yXn07rsLTPRFwd+P8hbzjG9so0YfgR0+eUs052YDeLPxyYbcCu
 XBfzqB/23oRKSvzXFj3J64SnPumi21eYoY81Pi8X0DL6M7zcX8jJINl0qkNvGTPegVg0
 7YmkbGu7gDFIozy6b8aMhCm2+lvtAto029gcSuZKGxxeI0peioGUDaWu2RtsKMA2UmIE
 iWE/NhtbQ9ZQuExXOkU1V8QVk1PAaHTboneU+efIYo7houpmrwP2sfPYcuT+4KIWpo2d VQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pgbn326-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24O2uQBS013832;
        Tue, 24 May 2022 02:58:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph28gx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3E0o7ucIAHGNDyJxSwzSD0HURlHlGbX5S9Svc2ecsfuiHuotgaFSqjAAbfU4hXQgpwHRCcgXyVroTo1Y1FvAHEF64QC4bU1KYOhsBMM1jTGB3OYaPxZT3DY+3cWDGncj4ewdDxAs0+D3bWAoNEMARafkEsjXdOmdSgKxdEiESCDdBolxeQ0ED2mhZ7LApc770KZ4K2MWGPW8NazyuGfJdkKBy5S5AKQDDVMEb0gOg4GxeUXaLOZGWlw+pmcaomfJ0OuKpmvGSSORkJ6lAe2/Z+6XCYAvItlaA82aLvyyArHI4A6Shqjzxrmv2YefgTeqGfWFDpv1ACdoY35THw50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=mEEAZu7Ls5lsY9ki5PnwpmEJBn7MDClTEYEdPYAab8UxtsYtkt+rz/d5CsMHfKUbWEGOUidZU9usdxIr5D6EU/4CMEXoMLNMO8arcOqtmv13Cw9RCQq8P0oUBB7UezFi8+PvABnsBq5NbpejRksCezsk3gl+EBDuYTNvj6qxZJMvJLoXkHPqQPMvOMkuPjliRasPQXhogiccQhuWbu7xLKvDoBs1AbgRdEVU2qg1ZdwuC70aQ64AjdcouesI8dy0gvBRPrFmKwwkEY6VtFBI/g4i86nnC6L+5/S5uh4QUHPT+oA4pyOa+bp8pozURdo4+0+nn52Fc2G6r0/SwddLfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=gx1XxwlFXF/QjZsyE2EntPfEHe+GkIaZaKmOKCgB5vO/PBtroKR5FCqwicwAi2QUaF5IsBY3kS0leV++IDs7FvMdp1QPKJEcA092qITygPIQhOpW29UdvxDFifvxph3kavknqe5CDaaLxRJ990rnLLKC3L4u5hPzq49oYzW53CI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 02:58:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 02:58:20 +0000
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        kernel-janitors@vger.kernel.org, Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qedf: fix typo in comment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkvniqm4.fsf@ca-mkp.ca.oracle.com>
References: <20220521111145.81697-75-Julia.Lawall@inria.fr>
Date:   Mon, 23 May 2022 22:58:18 -0400
In-Reply-To: <20220521111145.81697-75-Julia.Lawall@inria.fr> (Julia Lawall's
        message of "Sat, 21 May 2022 13:11:25 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0177.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e3a4b5b-08de-488a-0fb6-08da3d314241
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4685:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46852FB6A08CF2F02C4AC34B8ED79@SJ0PR10MB4685.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BwkvTYn/mbludUBikT+2z6nf0AHoijotIE3aaaidtA/X6XdYbzgbF9UUnm/J6ZyHuU/ygbBMfReXtw8pxJ5fvkx2WoNRwlCo9P/3ScxgmPtv3U6Y74JwTVYlOK/sPH/lUUy3T8tAc52Qhhs4jv+wtGyTj8wkx1ky9vsH34/qqnkCkXOhoiMQU7z2QVcbvdCjvTc/6XNe6VUsyr4z+jGhtwqUgLmsYUpVo+gpD5k6jWaWyLv9VUsoB8FLIZBPJjTExYWAli4A43558HjdpU/uspr+MEtf4mojSjc+msHoFDde4drcdCZh2RJfH9bJ9/lV+Nh0RST/AAfjUnwaiAp2O0lz+RwhyW3PnVuPfYe4i8bY+UOC6elhRPTK4OzBxOTYiu8tC4vC804GeS8T281q6ER97592k+FVn2JjooZhy5u4a9pAtCga5DJvoSUcjFNQH4dtDUwyXBOx5Nb5GFr/8BOIaP+CCbPK01a+opPw81/ipOfPT3oNpAMfUSxFHjlahDDqIXPM+e2PzUQUv7cPiHg423ZE08uEiK52qoQ8oJ3MUEEYcB6dn6Gr0E4LGAKtPcOMD6XBiWla3aLZq1Zbfu2pDwj2GXgAbkYJukuB/iGk1m6ApDIQTUyJsTvx/NhhKLjT6yAh53aXQgMvRutAnnSY9ffkhuDo/mjwGHmWAdfE+mMfOk6Ypi7EPRrMyUwmI844fJ6fKhp0iwHsqzTfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(36916002)(38100700002)(52116002)(38350700002)(6916009)(5660300002)(2906002)(558084003)(54906003)(6506007)(26005)(8936002)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(186003)(86362001)(508600001)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JTtwzTpfDeT/EhxoPY/X8kaZ3JzuRAy81+oAesNmNObNiNrVr1l5YpRhxcfK?=
 =?us-ascii?Q?gZT1XZ2VxtA+hRqYELeJj443vkXCkqrpv37Gsa0+6hyA9l3r1341Z6NQ7h8F?=
 =?us-ascii?Q?L83iFkWIBVzNz/y8O4AejAX01bphMn7LS3G9ZPGbju7BjWTusA4HvJlEWBFz?=
 =?us-ascii?Q?Nd7tDI5V75ypvVTh4hMfmo2/Lxqi5fYhACq7CeP6jrJ6zMZx4sd5wnIGipgD?=
 =?us-ascii?Q?abnJj/oTyya6vJBw2Vzh3F1RsVLoSW3EX+e2pZzzXDhnWJWD00f+Qojv/a2h?=
 =?us-ascii?Q?Rx2NqvZDxbGVKKYd0LzCYM6N1G2GuYMbBSjV/7oFU57BhEQLkvMXmnVqrJLd?=
 =?us-ascii?Q?OQeHQxmNTbl1pd6oOdSuGaRyhjDVi426FDV7NitlOtOB7P7As6aU0T4UMeg9?=
 =?us-ascii?Q?VSqXXLSebNDEBlM1tTF0vPUkjmfrh+ys1aKrNZaoD2EO2NpYwp38HLkr+GZl?=
 =?us-ascii?Q?PMJ5t7/av0MFOjSeUB50roBGormbKB7mfPiM2U+3lKvNn3oY0QWFLnMc3rWk?=
 =?us-ascii?Q?dDJMtgvUiKk2xW1MDB6DjL/ElWmPlzYSymC7gh5J831jaKrgrbsVjzHR+TZ4?=
 =?us-ascii?Q?taTtc+YFUPoOtCduqYsLhWxrNSwkh0KSLVLuieOXVBoQjI0mBR/QQfzgxndc?=
 =?us-ascii?Q?mqQNiAMu6dpRh3jze9P3/Wg2NnkssGkZKHUDi18NUp+dwxzKEkBUm6shtsKC?=
 =?us-ascii?Q?bApGYKarz168kwAp1iwHnfZXP9IptPKO/SiTvTnNlib/63rpLEpMHpgsNQNK?=
 =?us-ascii?Q?fNkNV/4FlsJmf35Mj+sqcriH2rZxf4XZ4c45VdYxC7XGDa+rLwIUSNZ7O76/?=
 =?us-ascii?Q?fqv3JV8ar8y7GlN1DAIl6J6HDAyMnx0LEJgO7VGqVnY/K6CN6VYdTH+0z8ls?=
 =?us-ascii?Q?HBMMgZ95kFgYyeNUzeezDgJ43wvbGjxDG9jdySIaVdkXESBeVS29oqFk/qsX?=
 =?us-ascii?Q?YTc3v07DOaar9e6iYiCuIMpjtFeu2ppoQLqJK8W21tmBUnv7OG/MWrEhugVW?=
 =?us-ascii?Q?mChI2rhari6zTpKNYtzGlYnoxmv93DSQEcDhvMX/naHn9FGE9LHU3l3yIGph?=
 =?us-ascii?Q?vwR/ACvNthpBHdXG8HdFogK02Oy4iU9Mxc/ruVXkdsRgpzFymNkJqJrVUNf/?=
 =?us-ascii?Q?Dndw+gJ9GevDshPEl/Ij4QvHzrDTA8E/oeyF/2tDrglgMjygLwkHH5Qzankq?=
 =?us-ascii?Q?HMKF77wEiKbGKKp7Jrjc54aD5TukU0X8ejzWNPw2OMO2e71hFQAPrbZ/Z9vs?=
 =?us-ascii?Q?87wvop0vEQiuqm3a1qMvs/1RxWRvD/p5tV/M+FNgbSQDIMcwTO0UE6OiY2nl?=
 =?us-ascii?Q?4mxaxhVrfAOiOYGVFrSvk/tgFPUz4wqvfrF2BQaloBWukn5w9Jcm4WilvvlP?=
 =?us-ascii?Q?jkJLNDQ8qVINQ4zZGaNjPAQ1YcS7WOsF0CDDcmc7pmWsGPMahBt0+J91gind?=
 =?us-ascii?Q?LdPFipmQqJlvxvDTGjTOIcWE/f27wkBhW8e/3DimlKnhjlXTUtxYnLwa68T9?=
 =?us-ascii?Q?W+swceVTirCRo3DB/+F0mVpl6BUq41Ev72syoHZ8mcQBVBB9spt2ORUtWZfC?=
 =?us-ascii?Q?C6AARo2z+o4I4hoDPhvV7dQ0mUadAd2rEaoRoPAYY7bVf5gHrELe5ucmEmg7?=
 =?us-ascii?Q?wkRsxzErMOJioHBsiRQldGz1w8YSI0D1ytIlklBNGjrSEAyhAu/GaFJNcb0x?=
 =?us-ascii?Q?m60azHslj+gwMHDibQqWKUNqbB6IrOjHkye/tEbyuu9VByTV+OvWgm2uQZMz?=
 =?us-ascii?Q?gDdrZW7zFipbLxK9dDZzGVmnyfR7578=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3a4b5b-08de-488a-0fb6-08da3d314241
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 02:58:20.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1JcrF5UYNdXEYqno1zsbzNKPr/oulajT+Jf0bNno6eaF9yLs2hcolR+y2VtN+iKLLnk02CB6nmTknMMFLaM0kW+jaO9tOD10aEVJ0n+k2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-24_01:2022-05-23,2022-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=840 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205240014
X-Proofpoint-ORIG-GUID: PGUeWR5yjVw1rOhEVUUNokglkK_jBoZC
X-Proofpoint-GUID: PGUeWR5yjVw1rOhEVUUNokglkK_jBoZC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Julia,

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
