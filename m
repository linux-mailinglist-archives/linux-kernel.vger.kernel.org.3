Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD952AFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiERBTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiERBTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:19:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A42F541AC;
        Tue, 17 May 2022 18:19:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKQrne023081;
        Wed, 18 May 2022 01:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JxIsSTppPYbbCcjVai72H/CEN5wouOvuiwPDbtgqen8=;
 b=S4R6I9b6jmewslA6Zr1cRXRVJsuva/7Vos+aCqHBjSBIgZPqBaSYtCytqU9QmaomJXB9
 FvCGWynQQniTsf6pjMKxIuz8eixXFpYxXgc92dz7Izd6ekh5tWD3s67vOuUIJ615r4+c
 NEh4PqatbkoQQv6N4T88FcLnZEi0UQMaoOPugLCpGr/G1uNiPDzsOcPE8tawQzYQwWp4
 ssCNZWanoylB2dsUDepl8ula8rvhXU/CKsNsogLskhJFHkKaDNezBYeCZJUplxUcn6XP
 K9yJDnjT8umXC7Uu0/wl+iygiA3beyL8ujdH1jT6i0GJQTsyAo+gnXeJ2fP56CWcGm6F wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s7v5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 01:19:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24I1BhUd001565;
        Wed, 18 May 2022 01:19:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cpsuyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 01:19:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIDRVX2AMD/SMD1XDBSDbn2i1l+IkxcsyM/Mfjh3g6TRdRwQZEtjNS8BLsQQyNE5Ffo/RJo1pmNa7092+luz6ykBGJDRE4E78rWH4Y9CAVfrZa9V4ZNooNk44orfpaZCc2YJyitjoO4TQJCtyWLTF2L85pHhUq6uoWZjszsp4X7Tc8Om4c9jQiaqZIKeXoVeXfWSvTFCmvtpN2eUTncDMGO6zFtyF1ngTS9fauVJbIuXW7WmcM2n/aSvHAGI5unyXbHAQqdG0ZMibaNMk6h1AvsdQw4wcHb7qZmDvaHVbkqm0xP0On25AmPlHqRoC+wWba1krWI0JqSXOrcEaVEIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxIsSTppPYbbCcjVai72H/CEN5wouOvuiwPDbtgqen8=;
 b=mLXSMnP4ExWp5LrB7L39+X9PNeMemefFtv4U5N+zl0H3KoOVsMmIH1WM4ICXEnsh5Dji/ZtfwsOar+AePEgtbj41hebbbzvjFaYg6TSUYaKUCdGYGm6coU2QsYLuSQhWQiSaJaAxq/plkr1zFXKeaCiEAaWlUgTwdQuOF5KRsY+XEW1KFpwvoVZ9NSpqJFLtw+X//XS2lubKYfLgZ4LIbs3nCCBvo8BS4L8HzTknC6BCeuygahgPF06zop0xQl3u/5CtKNBQClIGKvCy96G12ZcFsA8EJjXMwvuoCMAbikxptnSfhDxWQUdoF3Z0iZhx/bYo06p9fFHGvbzg5J8Tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxIsSTppPYbbCcjVai72H/CEN5wouOvuiwPDbtgqen8=;
 b=Ya12R0CwRwmcY5w7YzcekK5dAwbyOE6KjvaJxgfsIBa7YGJd9xqA/4M1Ws/3jX3lgFEWKhLkAgV1MtFzyCQUTNjki6nNtX5bdU1MrJOovBlFfI19FVkPH3AS58JIL9R+QjYU9i0xh1ZQDw9tn6lyr21E/xSwc4lZnur5Mc2xp6U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6203.namprd10.prod.outlook.com (2603:10b6:510:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 01:19:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 01:19:26 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH] scsi: hisi_sas: Fix memory ordering in
 hisi_sas_task_deliver()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135h7ocx9.fsf@ca-mkp.ca.oracle.com>
References: <1652774661-12935-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 17 May 2022 21:19:24 -0400
In-Reply-To: <1652774661-12935-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Tue, 17 May 2022 16:04:21 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:a03:117::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e86dba53-7dc1-4544-4059-08da386c72ec
X-MS-TrafficTypeDiagnostic: PH7PR10MB6203:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB6203FF2803EC9C52D4A615CC8ED19@PH7PR10MB6203.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YL7cLHHhZkqhDNnXOZAVlSLUZXdg/gg9VLm/KAiu8pS7uKUqH4/QpH6pSqx9w7gExh7PfLEtvJMXKhP2JVe80fE4w0a4RwzR4LBL7G7eAuAMADkKQ2PaxE8b5tfDkFJVKmP+vdMzePkF30tH6CXLZQ4731ufFONCRGVZtW0jVsuTbwvPXBnDPNi+7mCLQjuz5PxfdMxEdcqOOhdT3ro/FlOJtLzmmZ5dUDVWAPjlcgp7SynQkTwY7J44F1l1LoStgZjyro52XYaur7KdXpviiavr+0PJvaCUgd3/tF2fIfwNrpWDHo4gOlTTVCLYwljHVNf1ancyrWvzsDFSUa7xywMJkIOMG1Kwzv+JLkiNk4QbCkguEpZc989f0bv0AJi+1/JHTR1U2ako2zkrxbeXc/NbaqTpMLUnmY9O0R2AxZ2g6MIu3IanC7E38mRgSwttrB+9p855p3EC8zxga4uqEpK4CJiz/nR0oz2PAIvnOppH6u2fUYVhaOyCIsHQorJav7/gYxk56hdOmXEcwy6yg5Q/K8DSo6PdbvsCbwo3TSR/4kN3P/3jY1t2d05PXOr4MXCgCGwH3DMU3FspuNt9ww21Es7dD3G/sTtGQ1YEkX4tL/a9e1iZpnJv3c0HJM9YwTr2+k+9g5lgCL0NK+vYmIOfI6OHNRmLUrUG7c3Z1TFO0Grbm+Um6CIjJUkcUrPY46gHP21uF1ZlF9WLG7XUEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(36916002)(6486002)(52116002)(66476007)(6506007)(8936002)(5660300002)(38100700002)(26005)(2906002)(6512007)(54906003)(6916009)(8676002)(316002)(558084003)(66946007)(86362001)(66556008)(186003)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K05TA9cWRJkGCekLF05nP/P7woDFPC16q9wL6qk0P4LUF8X+fYXm2uc1usAW?=
 =?us-ascii?Q?5uA19C1p5wU6DergpLYkayFYgg2vKJlxu3SL4V2hv9EuVePrKCa3KMwwWEsL?=
 =?us-ascii?Q?fRWbVl6tXnrJTITvXazCTvxj+4ZRX5V+PGgETVFaF81sWsH0k08CP8qBmvCW?=
 =?us-ascii?Q?tNsj5jZ7TXmE4thtKm18TnNSlK1nHdUbQoYJviPjb7S34RjqnssDz6H2i5Al?=
 =?us-ascii?Q?sE2+C93BhpgEpNpsct/2HknFm0WRupl1gi5mpF6R2DVMNgdxABwchS90+lch?=
 =?us-ascii?Q?/iR3bbtBbGB6/d2WeloSH5sP9H0ocLkTrq7PqcWgkoP5vMoHFiBGNjYA40Co?=
 =?us-ascii?Q?sJFF0zQhsNLEJDIphyMz2GDSr7CCl7omobxg2e9yFSLcA+Qr8TkB+jhJIMCm?=
 =?us-ascii?Q?S0RuhtfAUmTnxTaZXLE2CpcWRo5Fo51A3WiQ4KWuw5RdKQX32tBuHWqIXMCl?=
 =?us-ascii?Q?EfYZ24hXEIZikwM7KNDGVjPrlGA5FxK/iPVKSzCGMvAdTHSAjdEm2WvRy0Wo?=
 =?us-ascii?Q?Kw+6IuIUDenMf/bg+xQtkltx4x2zuoSj3mjpL3iMFEn8pV6wBww7FItLmHUH?=
 =?us-ascii?Q?AiVrUXbFmV41LmOPj5/DvE6bQkHyV+ypVa01PhcJmbyXO/J//lOmrMdeCaM/?=
 =?us-ascii?Q?0jg0EslCL+/OQFRTgQQC9jPYTpHklrkSuOJ6l6g8vAzKESvzWlFeUcX148Wz?=
 =?us-ascii?Q?LX10vvk46d5tnJKsBGGMDNtulBi1qbeT0YnrcKNjLFOLYTDOLYd0u/AnxLtT?=
 =?us-ascii?Q?KrhR8FF8pf3sOH6JcLiXvfQ8OZWgYFmDV7NW6y+kisdMGZI5KcdQVmSy2BLU?=
 =?us-ascii?Q?8hBU0zFoo4tmygmxvT9fnfCUqgc6ESOy6VKU9YezO04VYXiBJ6r38lgb3HWP?=
 =?us-ascii?Q?Zm2WopYMTBGF49bN1Da3+iYtoKy0VfZdgo37rZQ2emIPWpY7Sy2/Z1Mmv6bd?=
 =?us-ascii?Q?29+aNeeGn6HHVgwkyd6s9scF9QDlTbtB36yf+AT1r58JyQ/sQazk2i82aj0S?=
 =?us-ascii?Q?Fa7MbRdPCL1EvJvBMIdAFNHVRQH7VS/HfusJMspUSluTxmpyS18b7aN+lHAf?=
 =?us-ascii?Q?89zwy3g/oeHG5O736t4ZsCzn7+1YIR4G6lnLLBLZqcpB6jb/S93itZKbP/hW?=
 =?us-ascii?Q?79gLZOZPLrmZcpP0nxiqeJo0Cbo2dLOHvYR9uXj7hctc9iBo7syQjaIcxI54?=
 =?us-ascii?Q?PdmepjQLX0qXlIKkrGVvXD1+46ED6toOJybVmPOAs1xmeh8ug4EF2Ky9Z0CV?=
 =?us-ascii?Q?rfYZu4t4VNfRHdra4qoyZeF3xIKfGYVERFnWIi0+tCbOgeH+3HdXz706ThWC?=
 =?us-ascii?Q?F6r2D3yAyb3WWZSVMePFHLq8VjPHkUuaA+5OAB5VUxN5O1ogrUn+uwIwk0YA?=
 =?us-ascii?Q?vBHZwt+BZQ9dhftUDDfhfD9q9Rpb4NR88goMs8Vb9wicTTV9cxqfNviGu8uB?=
 =?us-ascii?Q?8NozyHRpiVt8p46xxqu6lRdTUJrUuyeEYia34rPNI/BCdKNz/MoQUElI89DO?=
 =?us-ascii?Q?Wvis0IDo5mxBmacNfzttRu1XLCiRg3dLZAQij4kF9RjZMKlVxIOh9mIv928n?=
 =?us-ascii?Q?F839s8Ie3N4PtAWW1anDfYQQ+jj8ml21wziEeCTkNpawdPv0MeligMU2ocm0?=
 =?us-ascii?Q?Zxv1OuKWcRFaRlRcB39tV+JB8oxhK1fuurz6fQMjlKCYMaZhmoR247ipqY9k?=
 =?us-ascii?Q?Z3XanY22k9AgpJturYwfipimgORqwUfq8+Pc42HKBNfc5JUMD/hlJHnZf61z?=
 =?us-ascii?Q?Is3LFVRgBYuCRtWHga99IC/7qk84gmI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86dba53-7dc1-4544-4059-08da386c72ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 01:19:26.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0G2B3ZJwB1tKtfruO+Ym0Hn/wLWw249D8OjcxmjDwGG8qphccgpcGhh0zesONNIcU8fgz+X8wmKzmtsrfk3AXNcCf6lRlggKpiQAXIV/JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6203
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180006
X-Proofpoint-GUID: 6NiCcFLYT4pvk8ipYGy33kHXmv4K4j7A
X-Proofpoint-ORIG-GUID: 6NiCcFLYT4pvk8ipYGy33kHXmv4K4j7A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> The memories for the slot should be observed to be written prior to
> observing the slot as ready.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
