Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46B51D1FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389205AbiEFHOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389397AbiEFHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:14:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107B66F83
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:10:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2464HLCa004338;
        Fri, 6 May 2022 07:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=neMvv5rHRBpMvbDM07sFvuxo2q7ZdyOyEAf4cYg4wjc=;
 b=O9e9ANTMCpnFxD1w+xeUMeuHoUW4M+iwPXTVAxCyIkdcp63twUD7jaCSlVffoJHMBFRz
 tu0Io9FSlz68TXNkRtwshHHnwRbwDtR/ImzDItufFpnRE7QT5/b8IJ5kakRoklEsdlpQ
 l7vc5Ea62ds0D5zY0zqbc1GWFQzZFNKUIZEhqLL9NucDszQEI9odTZCw9e2cFObZ8mqx
 Z/tUJ0JASG9Txhg4b17DFVejCVEfIqcg/hp9/4MqATQ8MZ4BsLyDG2Cmzi1wQy/8IM2D
 rvXg0Q4Jgd6SJis/ULzslTNBtkic6U9m4RkA7I/AZbZ/fs3jDRwLffiMjhlu5OeEwTHA Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0ncnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 07:10:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24676bqU015935;
        Fri, 6 May 2022 07:10:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fus900pwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 07:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdZV9XH6K4ydO3r0YMeP9MV+phJud646HnsfX44DmYuW3ErfnenyWu+4IoJvoS7+GutEEbCm7Z5f7YzeGlhcJFQ4pJnWwTqnng5u2MpoP47H+xFKFoWF2zHGTFNW0QbjKS3BLDHbpnLcD3lo6BOLZsqBl7ujcnaesqnSKVCbvR8sKxzOl/avt6eeCmLpM6MDxgHSDZs10Cc7jpKNPU942hhlaprkrcPEaNkHfISBhOx6kMwTZ3Ahsqta0kXDAD2RWUNKbzUni3ExD1pgoKVV8pRQLiEf4+/WG1+CYmw0qSNkycT5ex3eZ65gsvzmit4dvc6mV63ISpWN2KhqEH8QxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neMvv5rHRBpMvbDM07sFvuxo2q7ZdyOyEAf4cYg4wjc=;
 b=MmaE66Ke+2bDup6DEyyzh1GNpDcU38yNG7henCdeVjzIzNfmgE2DvnLeHmTe3vf57JIA0rM+EijgqbYcdIwTXv/JeGwpJUmxFJbtQITf/RL/X0yay0Vqfrp2FTBVIbguBaOMIxrnHnQ6NoPlTlNGHSrxAmRwtYJPg1QHCtOEJC4oRKZwt8YgdkZmSQpaAvm8i3BMN/6Gi7pAFLucYtM/SDLKcdDr/vmoiHpuxjmMlvswkt+2p05fwzIrRyZfY8Fnn674aIV9a6lOAMOCKK6URRvwcaftaI1+qfLK4EBTCQ0tEldt1zFQw8FuALkNSpzNwVGgny4n0pOtb6NBHNbAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neMvv5rHRBpMvbDM07sFvuxo2q7ZdyOyEAf4cYg4wjc=;
 b=ORoYfaDURGzDPGPJRpIcm6XtXRLsZjTg3yh1zTDMSyUDeRz/mNNN3N8bmG+Ca2sDWrzOrL8GR/cppICst9sbky6k7dHKf1zi/hJ4Lam6zVSaAci/CeWtlHfxxxHNiBp1MNnB+RbTQhfPHCJN7gZnXiaUYv7xDdQPvSltSELQ80A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB2022.namprd10.prod.outlook.com
 (2603:10b6:903:123::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 07:10:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 07:10:41 +0000
Date:   Fri, 6 May 2022 10:10:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wang Cheng <wanngchenng@gmail.com>
Cc:     paskripkin@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8712: fix uninit-value in usb_read8()
 and friends
Message-ID: <20220506071023.GB4031@kadam>
References: <cover.1651760402.git.wanngchenng@gmail.com>
 <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651760402.git.wanngchenng@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651760402.git.wanngchenng@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab8d8ceb-a5b0-40d0-a8a1-08da2f2f875d
X-MS-TrafficTypeDiagnostic: CY4PR10MB2022:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB20224CE6D4C4FA4F28594C178EC59@CY4PR10MB2022.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpZ1Ue9SjkyTheiBXu0F/+EsO/hCPnq5+W3zQPoVOTO1Vp9+vADlLTF3r04k8W0N+14tsOFRwkHPdIZipNRh7PYK3TtfVm7t7NsNSFSAtBIEnH+N8pL2KdzMWRpHDbJ7bYx7uW3nIXLu3v76jbi6qSr/FmG4DmAgB/E6WEH2wni6rmRH8+IWqU7s50S0O+TMi4/jwuFKeSBcQvCruot2kj39d7HmaNv3fydFA2zXikocEpfvyXfpm3eM/KFMj5k4JFlf89xpalszlB8+wKWqk1+oyuGy0C+7gNMPwujLYbPR+XdO7XaWUFpS5KcPJ11b46VOslHjQEcdGSlAi/tWr6KGxGAd1C2JKE00okbfIBEiY4UsGd0uLEzEKGESfzbf3MOYXefK+DnE90QbGjZkY54nN7gtHHe7eGLlaXlXQwfzg/7sqg9z2w1k/G4MH1ofC/CUhY6ImuAZSMWX3/eUm1ghe06V43TsFRo9ZIA3VdIo8m5YPnKuyYIenrIphCm1klNtbW2XKvYPDUIHJUIqien1gEkYMCWJ7FteJCM73lYZS6+Dv4rdC8G9Pq50vdoxrT+7Vj1tEDejhllWBlx3OzJRgsJq5gqmD/dICScegQq33e+JcEG6QUD517M6KjTqS9AhrRuK+y4bg3BITUdGbhNs+LPCX4/FO8Be3+1/s6JdgKLrxnoOuI1dNakpyRCLxudqaYU4uLty73XNlNsvEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(26005)(33716001)(6506007)(66946007)(186003)(6512007)(83380400001)(8676002)(1076003)(86362001)(66476007)(66556008)(4326008)(4744005)(6486002)(2906002)(316002)(44832011)(508600001)(6916009)(38350700002)(38100700002)(52116002)(8936002)(33656002)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4XPeRCukjnVVJwr4Pw8HQ1c3zbNziXjJeF4G0Wccrgbj8xLT9aI77j3jUTQO?=
 =?us-ascii?Q?0gHFRDU0KNPbVyhtS6iArLhfTCpvXvnvq0NG8rDApppEGEGOMH9pUM3mU8ot?=
 =?us-ascii?Q?U0pshqeCs1aHiDWxiAL0Z9AUDuAjSg/kvzb3io9AjtTJfIyg/6zeG2ytZoI/?=
 =?us-ascii?Q?EVKvz1SOD2U73qB6RpYM6M8UUWdgtV5tKahJMbetBH9h6pEp+GTi5d9+hC5a?=
 =?us-ascii?Q?oecz8y1tGNv+5FFcrJxLfMPXW4dDvPhnu153Llje77h78yon4+d7Rtaj0h/b?=
 =?us-ascii?Q?xMEaCBEczHRcM7XI1QxtWu2IPIAKY/s+upGWfr0yHLRrF+50R0JW/AhQRZyO?=
 =?us-ascii?Q?Xnn+EfwW9Avp8NuCcSDlLCWLeuOQGMP1fAQ7y1WcZxhR+NyN0sWEhmEY7Spg?=
 =?us-ascii?Q?CBtVJ4tBMK14ZM2XVj8Mby+Ldld571P8GOD9maIeeLj9A4b9Dt0jBEXw52AX?=
 =?us-ascii?Q?pG1LmnpEQqofuI6PmCI5mpWF925Oa3BW0t77i/d0zoudPEP31mJI4NkqQs9K?=
 =?us-ascii?Q?34ZiZnVbvXSyEWXImq6L/8eLrsAXZ8GIYlfu+tzHL+XyxvmZm8jY4uYz+/4J?=
 =?us-ascii?Q?G0vP1r0wHNNY4rc8QYUEebwuUCyBnycBVjMoBdCcoIQrk95AdlSB+VnBTdjj?=
 =?us-ascii?Q?JaBlVlvjYUYOPOM8WYUzm/5zlxcJowFczUKfP69ZXMRk/F2WV81HfjgOXpNI?=
 =?us-ascii?Q?jXawa/F/CAOYUEncpEAJAilJbzGyngH/jzLQKG4I/7ORHXo6jUAc07JhTdSl?=
 =?us-ascii?Q?x1rjw2ddiHew8Wsx0PsbPCvOxjF8w70A+u39qFNrwo0AyYhapaZLtTCJ/Qsr?=
 =?us-ascii?Q?ewy4Ox+0hPoSi6gp5FBGCe/YjxREoT4EKma9vmaac+lTzzF94NvB7VOm45n1?=
 =?us-ascii?Q?bTE2NCbs3Y6rLn9tvSHxAtoWGVC1wk3FAAClXr7EJrqjHg4TabzTdjG2rIjX?=
 =?us-ascii?Q?oKMv/nYkXeZP0qSXGAY3Bs7BfKaWkScv9GTToxtWt93BpeMVlkXyW/nczYDc?=
 =?us-ascii?Q?YH4GK3xgQGoL+8HZRllR0KMxoLHsqV+n1w5ymWnw6dIdVW5Xxc6Zjr03NJkI?=
 =?us-ascii?Q?O4cQE0gUEw90XW9+DiX6CNHP9ZXgwYJsNY8ONVyOpx9YB0jE/n5agGa8ZwKV?=
 =?us-ascii?Q?LNQZPsk7apqt01pmQSB2R5Fh1RmmfGGGz9mKcjfiK1egFkVE/YggQRTitinr?=
 =?us-ascii?Q?iaNGm7vRob0VPWrp3AWfCLijJ19hQmSVQUbG15IPhMe5VPXugXIeB7gildpR?=
 =?us-ascii?Q?MpRJXUycjDXTyztmQMxyqAHJMw4pzLIj/g/p+l6fqawFpZ6m9ECLXdfdLe3W?=
 =?us-ascii?Q?g4qwY5FJSC61ePJP8tIaIn42Sl7IEnYyLyhhNAwaIVw5sRKyRSZmvewc4yOa?=
 =?us-ascii?Q?Snt/fJfWGD/AF+XkCtIMFxZ93NyFU1rboCqCyh53xnKgFT+UXM6cM2YLiPjg?=
 =?us-ascii?Q?N9P13TowIVAj2IXNE8BfiYW2ynagvWfVQUdRkgf91cditD2Pw/+gtvwgssil?=
 =?us-ascii?Q?12e+tpy3CH1xa6LVy/C0zjeT+hnsT1lxowN21p0RLeV7s+d9x8Icpt1+bfKy?=
 =?us-ascii?Q?WVjvNsX6O8SI9ltoGnd4t1+p1fHgrUbY/t9ZO1M2UooqwQuuc0TffKg0nX2V?=
 =?us-ascii?Q?KHAOG64qglJtYt4k3eMabqaHkQcvkWPK3O5CC63Ml5uBqIIutYxQ1r2cDGXg?=
 =?us-ascii?Q?v05NSkhMGJHeUD8lZ2FmC31fVG2QkdgUBZGIpotqKYPV456h6ZBh6XpJKOE/?=
 =?us-ascii?Q?WjaCzX5rtvNC6dBUuvef0+r+R48cSsc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8d8ceb-a5b0-40d0-a8a1-08da2f2f875d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 07:10:40.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJTDVQOsGwxg2rv3zOfRfP8rCscaOBc5nv+wKHhbIgdc5Hn3NXu3tbPI9O88oOApqLwMu8q2BUqC3z5yG4utI2qh57Wsj6oWhKSn2zU68O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2022
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_02:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=956 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060037
X-Proofpoint-ORIG-GUID: hGQoGcPA8nMYWgoxIn3TDR2GGDOTdnkJ
X-Proofpoint-GUID: hGQoGcPA8nMYWgoxIn3TDR2GGDOTdnkJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting "data = 0" will silence the KMSAN warnings but it doesn't fix
the bug which is that r8712_usbctrl_vendorreq() treats partial reads
as success.

The usb_control_msg() returns negatives on total failure and it returns
small positives on partial failure.  So take the code that I gave you
before and put that into r8712_usbctrl_vendorreq().  That's patch 1.
These patches become 2 and 3.

        status = usb_control_msg();
        if (status < 0)
                goto free;
        if (status != len) {
                status = -EREMOTEIO;
                goto free;
        }
        if (requesttype == 0x01)
                memcpy(pdata, pIo_buf, status);

regards,
dan carpenter

