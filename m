Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431F859CF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiHWDmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbiHWDmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:42:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081635C373;
        Mon, 22 Aug 2022 20:42:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNx5Bs029415;
        Tue, 23 Aug 2022 03:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=NsO0lW5U3qi1xuMVb8ozV1J6/JEzas4BsmgbessxXDw=;
 b=CndWqF6GHoXjc6bVi+sSAQpcB49z8Wlcblt29zyn3h7m3VjHi6uvTJGSVE5pFsAhYMhn
 P0fIeSMzNUNdmZWCiRqFa94jH9lfYZNMTX1Y7uj+0eI2wY6tTAEylwJWoyYJGgkl6o47
 ZXm/R3jIsRnzFqweggGNpY2sh6IObmP5bx6gBA9VPp4FOSjVayfV+JiVT1DVSj/x+Wwk
 GMkqdjfmAHWRAhk7kbtW1H/Ei0c8bgyzLgPaLnb54AnGRzDrFVEW6qEVHva81TDH8ra/
 2jE8SCY2hWt2l+tBnzykP6CjnbOvcPGACUyNgfFyxy47wD+bwXh6alk81Y04NlwieY0L 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e8c115v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:42:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27N0NeAF031949;
        Tue, 23 Aug 2022 03:42:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjdns2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzcYz1xB1ktX7Iri4SuBmIgdEGnj4jEQniQzi9T1saCdg2N2v+Tqyd171dlZP9+tQb0aZYiytVwpFgl4FVAC3W549MnkgcQHKCpKzXnrdgPbu2oxrkOTBOfMbnKR9fBfZzmTV1kaWrz/gHF4kbM0Zmpp/04EYEglCowPCln8VmtHcBdUM0igxolO0Le1O9zKHAAZqWqDCLr3RiZ5Qy8V6lsrDzgnr3BJiOJDznmOobKpXGpbyz48kyOMGKnx4sF68AdnpTB1K4bv+tFWtGNn2+tdfa1MIP2Ta76nm8debNAjPjb6BSjjbgViayw0AP7uX6kot9trFex3/6Nx9wWlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsO0lW5U3qi1xuMVb8ozV1J6/JEzas4BsmgbessxXDw=;
 b=cXZKzKNarqN0x1vxd2b7rnBBrNRgNd727Lv9NGyTOY5kVTisNEar2GIKxk58QQXW7u3hO63S36Eph6DGfEuQlwc3I9Egv3DkeKdL8uRGqt4QN2B3rQcKh2J2NqyexJUU4Xt1tbLT+UEeKq98DCBpLWHM1Fezd1XJXHfL7y8LjGAQxYo1sQ4PvE81l7RydI8oMOsN13KnaWlP+5Ph2LYJZShT+93LzAm5fZgDgyHO+tl8XyZMe3Ip8VqdhyT+Up4Kud01ZK2bm/RhMtsLpLs0egpe/coij6unrUAQYEdAbQCLt31sCN0UQQQvYbxWarr+Mb4ylw3n5xSUeOyqW3ypWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsO0lW5U3qi1xuMVb8ozV1J6/JEzas4BsmgbessxXDw=;
 b=W7D6a6Sc1VqaKW+nyw0yGsh8kDFWqN+vQGJx73BB19Ch3X5NwCcasxcgpDXZMAM7+YPgRp6x/k8tkkl1Fe7RG3I5VlHj5sk7HNxiCzc0054rL1LVVJY04DDB6IPM3plnL4EcLQo4khmRNYqW64c05DGhZFeDvuW9oBqS6hY1OU8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6130.namprd10.prod.outlook.com (2603:10b6:510:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 03:42:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 03:42:40 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: remove redundant variable iocnum
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilmjaamx.fsf@ca-mkp.ca.oracle.com>
References: <20220805113214.2339022-1-colin.i.king@gmail.com>
Date:   Mon, 22 Aug 2022 23:42:37 -0400
In-Reply-To: <20220805113214.2339022-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Fri, 5 Aug 2022 12:32:14 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0130.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae53cb3c-4093-49be-8344-08da84b98774
X-MS-TrafficTypeDiagnostic: PH7PR10MB6130:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHF+uzxjBOhn6oF/dWeXhYkzeUScJFGb0GwpjcieH9m7zvzx0FFLsycihchxNMg7wGUUJ9qbXvmbL1laXiLX4yJ/rlbnLzsP6bzXZE0K5U9hExDQ2MUjghPgDVp63aSROc8RkQOBuDOR8+K01LMl+y/ZjVh0g9t48uNPKAkzd9qgK40U6zD5V9XF2ESjPksaEm5ItShTwgZgiZdqXSzyp6XlolweClrqSkndhVLRd4Mn0cwIZvNNWqvU/Ub1RTwav/7QP3s2E6cZKk22OOREsln+bgtljgdFzXdha29Rq6lywmT2RAEIghpzNIa/DvLTGErk8UunGh1Nl8GYt+jIRLCCAETLeeu0lW9zTeFNbQgf5iOP/vAFLtpSeiSm5EOfrPxQ4rjaxT+YmT5dbAeBDiwt1BjxZi4TsNci5WD2MqCMIeWUJD3miQnfC0YG2e6JANAgKtp0qqM5PAYNcMvWVudnjSZdtIliQoKSZMYNjudG6HIeX/AaTl2FsaSzEJelIuY08p0u4+TMSU7cacAmBpKpHIpzczyCajdQcoM1KgvpGNodg2aaqosuZb+nQLiLhrymfJWjkARtbtWcoudH5GOSGUhlc8TVrxGM1YLHmJf4kdRy+uWysANTOZofZk3+hMs04kmn8ZoeLGy0qpo92qccoTtlzHFyworC4vM+wGO5nivqrOKb7cflv/AmJk7vQTsc7Q34IJcXdED7aQ10BQuGyFzPAlZuq7FC8N4Clphfd0iFbwNsePjLUzvHXZBabBz5SyJvlVRiXLn83xd6lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(39860400002)(136003)(366004)(6666004)(15650500001)(54906003)(2906002)(478600001)(316002)(6486002)(41300700001)(6916009)(52116002)(26005)(38100700002)(86362001)(66946007)(6512007)(186003)(36916002)(6506007)(5660300002)(4326008)(4744005)(38350700002)(66556008)(66476007)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49cVk5f34wWeyJUe3lJHiljAYCp57T+d1m5FRXqVSspyaUVPz9pWePv2V3hE?=
 =?us-ascii?Q?i+7UFLVNcyY/Vhe/+5GXr94fgJjegCr+yHpLuClWsMySywJnTiQe8gtOwhVu?=
 =?us-ascii?Q?8Pf8RZlLxh9CadweOrhbqtwrPQ6dFJq6JqDACQhpp+h3lggU1n7OR1wjhVVX?=
 =?us-ascii?Q?J+L4jS0ZaOyI+Luw205+0KttfIUfPb07GvKa2k8ThXFNjhCnnEtFM4u3r/3u?=
 =?us-ascii?Q?1skdgQpCY/gAOlTbCelksABLia8sKzZ8BTkWbmnEAJ8s9L/5CxuQAfY0hamt?=
 =?us-ascii?Q?2EnmBUdQk8qgWJOzIlf6fYVtJ9ZsegKFtSzit79BfNEssLtvzfVvm9GRktEL?=
 =?us-ascii?Q?yF2ahrpXUgspwAb+DeuHoIfI+H6lgSWKKtWj/2/ZPJWh81J6rDbFavCGJWCU?=
 =?us-ascii?Q?5np5w51T/4zvJahevEN6BhkGuummbx484uazBGbudnF75LA1Nc17JIdxHkFc?=
 =?us-ascii?Q?CWOALHOytHwX/OchrX6NyYLz8RuDytC6kKJ06h+hQlatd2eLOBy489fjZXZd?=
 =?us-ascii?Q?1pwVeHKVbJa1tEsNZ0afWBuiS4lMBLPqP4n7OzcYnLuE0iS41VtdaGjZj2B9?=
 =?us-ascii?Q?+JSIvd0th43JuEDo6md3y2odIalvfuPgxuDIjLJjXrXqkyUwpOUozBUpoEK4?=
 =?us-ascii?Q?Y8vetpz6LOBmQnxzexRPWmd2SYm78XFwcuuRHMcU2x2McP70pTEPLaZZGmnx?=
 =?us-ascii?Q?ZS9sjOjUXMTy3Fz4MqSb01L8AQYkOsAu2kE+5YlCM1vt9fUeEDRoGSCe/C6p?=
 =?us-ascii?Q?3PqScEfDkFAP+JE+WU7vvAES9tUaTtJLcuDkH3U+ChVcBlv/AIy0yZTcX7gr?=
 =?us-ascii?Q?s3y67Tzh4paURUT0BL6n00diGBo0279sh1PGPNdfVIp6hXg17dMzwM3Crof5?=
 =?us-ascii?Q?Cy9IdWYrurP5VoWoCV23QqGTAukbUOPc9GelBLGR+0fXphbSPU3Ux2Ege95Y?=
 =?us-ascii?Q?WZihqi/izZ5xNuD1HCco2hujX/Vmpcv/SdBkwxOlYKdiO04HvGS0V9XcITWQ?=
 =?us-ascii?Q?PEkhdW7EKc428ByoB+/8WiOhgoEJccrYwhtyKTdqiwaRtOwKNx33BoNShSfY?=
 =?us-ascii?Q?fxCRDk/6dfTpYxq5O8lQS5rCtMTFfMBibjQ+uT/mBP9/ViGUFtGsLpj0TLf0?=
 =?us-ascii?Q?cQ9MqMVK3waYLFVqj5VijvhXMH4RSTP+2c/hWsDiMXOYI7vTGEDF/WlAfIJz?=
 =?us-ascii?Q?/m/UnRppg/50UhIKm78v69irRJtCDy8PmBx0HbeZwrO01NF81blWAWOAYvSq?=
 =?us-ascii?Q?zMvhurkV6j4RaOoOy0aBMhO2JGw2yvo+5t4PkenuB7KKMAwC40h9Ra8bgvJr?=
 =?us-ascii?Q?7jHjH2p3QKIQ05koGRlIR1lSHVPV8y0fld4O7m5tdkiA50mC5Vnp2sjaD5Z7?=
 =?us-ascii?Q?uWXeieN1AKWIEm/mrNzUgLzWQ9Ev5tY/eNFEyV7Su8+8WOw2hIEA+AfNu6Q7?=
 =?us-ascii?Q?9LOX822RsgIIfhA2slhSxNMlJtpCXCdrGKI+ebsu2Ed4qRYUxYwgTTfb4/mr?=
 =?us-ascii?Q?cQ5+QNmSO+Yl+0mng5McatTd9AfyLz/bZJs/ZCdjBdoq7Taii9L3/AMdPnWY?=
 =?us-ascii?Q?BGQ2NLwtaXPZ3oR9kffAAYAKDFZTzCYAwEhWpbHQZO3IAndL6IUaZk6egyO6?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae53cb3c-4093-49be-8344-08da84b98774
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 03:42:40.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIwHTwz4whTV0qSY174pU/TrLyQdJQWtRrdd9gKRoBSe+EsCHTvUYChkr23PiM3zLMq0HBtvd3Zeoe8b/265cxIvN5A4eU7EofwgT4NiVRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230012
X-Proofpoint-GUID: dneAn8e_Vc34y5LATuAP27DG1lJ2Ffn7
X-Proofpoint-ORIG-GUID: dneAn8e_Vc34y5LATuAP27DG1lJ2Ffn7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variable iocnum is assigned a value that is never read, the assignment
> and hence the variable are redundant can be removed. Also update the
> the comment to reflect the correct name of the variable being updated.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
