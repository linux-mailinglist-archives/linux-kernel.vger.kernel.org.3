Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A7859BB46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiHVIWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiHVIWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:22:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F98F1EAF1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:22:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M8JceW010431;
        Mon, 22 Aug 2022 08:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GPhPCZhg7ukmm1pQ03LSE78R4/1si4QTRF3m6t1yPs4=;
 b=nXYkyx+riTKx9r9SpW4BbeDt627f6mFAZHGK5awdI/GmcIb6uGJfMdIVRJgSfoDK3Y26
 2zgsNAvbxwSDjtpM6cwDacSzBGo2fvaRb5KmrCzpAvBznzMP8XJjXCPJPouCyvwAGxOi
 g2gn6MK7s5m1eWLOyDnqveJcSPG8pUvt7BClAjBMLx8vr1EaUM2L6edEE6C12ScEakWb
 UiyK6aFDJXWnqDBx/aLoUNLBToS7yN5VYU6mJeus2oZqU+WFP/8qivLlp9WkFrpSNGRz
 6CS+KT5cEemvf76+9KcsLEhaYuTG0qKZW2K1hnOmmGPBL9Hdz2AM5f0cMRJ257tBPRE/ Ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j466g803n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 08:21:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M5fbTe038088;
        Mon, 22 Aug 2022 08:21:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkfrmp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 08:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idn33+EICxDhGovlyScYbk2Ct1wP9GVZpfEAcJCDOtneNPRwueXjbpctsFv43CzuOKvIhSA0GiaB0Fy9c3F4soH4HwrPrhNO4nAj/f2FFZCMv603HQba6aU+MCHFDdBz6DybOnd7aaKlem35z3ioCeW50HfCR9tMJO8I1VqgSfFwIxOjY228+OQ4hulsVPYLGjJMI89VwOAbkC0J9Ps3Mqty4fJ8Hb4c/49oXqsSUUW5IWvi3v1qpfw2HdrReDC++FxeNlKtdYiabAEo8izD+7Cd3PsQqIJJXJwsEkqQQUqpfrCVLswprU0ZOCCvk+ZOD8/n8nEVPSTeUtXpqZfZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPhPCZhg7ukmm1pQ03LSE78R4/1si4QTRF3m6t1yPs4=;
 b=C2G0OUq+L3HusZTcvUfXLJhm1xYXcdh+xnAaSLuGFDtOk9opfpu9Vczy/zY5iUVDdf9XJ6W6jygKqxNBpQ8w0sLi/5HcIFpVAGbj2LJUqBp2qa6p8GEgUasQQi7SJRhuDbpEWSC4Q/EBvkDFhGJExbxJ70lVV84f4P5VhcNBnl7BSKBU7tMdd4hTjb3ThWvpNFMOWLNymvcLspO4WCkwWOdYh1Ya62m3M8JpMu2jck9/A0iJ7no6WmWiMvNE+Gabe9lAXeR8QHtBXo9go4XrrQR1FU74pZij7ms0HtVN+7Tg44UsZ/MppluVB0GB5UVkMeRP57jDJGhCQfVfwuhTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPhPCZhg7ukmm1pQ03LSE78R4/1si4QTRF3m6t1yPs4=;
 b=cmgygFN93/30KwVNT7qSX0CKAeD2p1kgEzo/mz+k0i2iEueaWa0cJkIP3+jeg2yhas6SNRzs/YaTXjDb8uGkuaX3df9O8N4xPLkU6DM1tfBdJq24VLnxkdQXtaNyqLB/cwwx4la70mr5y5GgQJwuq65GvAizk3Uc/5vEGyo00y4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4989.namprd10.prod.outlook.com
 (2603:10b6:5:3a9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 08:21:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 08:21:32 +0000
Date:   Mon, 22 Aug 2022 11:21:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        lkp@intel.com
Subject: Re: [PATCH v3 1/3] staging: rtl8723bs: remove unused function
 ODM_InbandNoise_Monitor
Message-ID: <20220822082119.GB2695@kadam>
References: <cover.1661018051.git.namcaov@gmail.com>
 <46d73e331bae2192a328f6691763f39ea6c18b08.1661018051.git.namcaov@gmail.com>
 <CA+sZ8B9Pa5h8K9LS17fB2Oy8oRadnVSeup6dqfWoVfV1DKkckw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sZ8B9Pa5h8K9LS17fB2Oy8oRadnVSeup6dqfWoVfV1DKkckw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0176.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 542eae0b-d1da-40e3-7b6c-08da841751d0
X-MS-TrafficTypeDiagnostic: DS7PR10MB4989:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MmOH2Q3meB0AHe+hwWmFYJNeH8/NnC7k4mJShT1lrJlbNQeJVsZ3+jJKmBxL+F0MiZ6DWXbbhQney0PDBT/Uxqv8vXZrZVRR0KVVYGN7ar2+AQyVaY+72iePsub9wg4JeIHVNYBEaBHUssQ29yyRPs0eGte8raxd/hWUxbRX9IrWLOD4SHHqIkPFV5Ja47qObj+q02DyhAm4UpDUCq1skrDpM7mmFt2gmAYLnZ/g7wfIrOm26LhbWFyRwTFjspADr4+0f4CWyHCumCYfY+XsTMv67+yXGYdZlXWfw8khnK5uaemRLiRrUeLCKusXLKQBSeVJP3FP/H1116hNLQVfi40gVJFcg7fYYmbMy4kh4Q/zWWGLg5x12l9s6BPAf1VK7duL89c3wKjjk5tfxBx5okfc4qscrFemaa4eB3rG46icPIlLrPgp2Q5vwo3/3c9rJmcV6OWUxaT7ouLzrq41nBCn2cO0gYJfw8vJZD1x67R59I5hiVMY1L5ryaxLtPejjquxVNPdOCibVmryDjUSBkxinGV5RO8B8f3MJ00YAfFGAn91oInAKGkikp0iAZ/XtSD5EcEVzpOl9BW+C5qobxHa4CIpejM/YnclZ4n5InSMrbTanHCMSIIxSoOwxpCZJxMBy365x86RlkteopxHyqZMe7/JMS4v8A+VKgVWxRvYBIoyRBIUPRM7Ac5p21BB7RwxWKQ8CRI2Vr9xNvaGo7Yua8Jw/FVMwjuMfSH1sk6HT6GapFmiiRaGLAZlWKLH8xJoFaH9phnK9njSJYfjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(5660300002)(66556008)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002)(478600001)(316002)(6486002)(6666004)(6512007)(41300700001)(26005)(6506007)(4744005)(8936002)(44832011)(2906002)(6916009)(9686003)(33656002)(52116002)(1076003)(186003)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vw5fX+1JLj45fl0ESFqrH5O91/J9D9ACUS+ZDnEeyXxdhnKE3kF/FtzM70uf?=
 =?us-ascii?Q?yp5tb9sc+OGJz6qQEOvjzNPYK/7YjXO/mWojP7n+bGE+lpZxLbULImM5EM78?=
 =?us-ascii?Q?pmlc170E75ev3ulFNpPNeppiiPY+/Du0LJEkAJMbH2YYa4qan2LBaz4M0Qaj?=
 =?us-ascii?Q?xK+BNCPa+w7uZ4sWJO9PIugFr942nSd0mVA6kv/Wv2pCPhZpfTrTlao07uZP?=
 =?us-ascii?Q?PUT4SlV6VE4pUqBUQ4QRqMc4T9zKjEZSOvPghDmDL9ttKmfmY676R0cdHJ2J?=
 =?us-ascii?Q?dkp8begr5m5asqQ5sFANa/vOk70tzdcN6Ekc895Sf0ncxTlJXnZqa75ecxy3?=
 =?us-ascii?Q?UgAdo0Gyiq2ick92n4Tx2n2pL2yVGG2OMh9JmMgPXkDuT5BgsgCTJL6xEPNQ?=
 =?us-ascii?Q?i31ypIIpVvvHZK+iV1nJOp7FgVHMeylYhCrf4ejYkzZLwSG3C3V7o8SBOtd8?=
 =?us-ascii?Q?J1YbH7Tl8/nuD8DGFM7Ge/lJONmLIUzhbKrOFQI95oDVoxc1w+xTn7pDN+Kh?=
 =?us-ascii?Q?oSL5uWwF9BFU8tXq+6bA5ch54wZH6MAfLo6CzpIUDUTtyLezt+gxIDGm+wMC?=
 =?us-ascii?Q?/2PEycjr+xymAv85u2VlUt+lr2x7STlzmsbGI7vQ3o2379sBgdMWxDyu63a3?=
 =?us-ascii?Q?HcX1CE/Dybjen9VzDfnlTYeD0NcPSOUa+UTkfqW/QIaMIz6XZ0eWIsXIl1qi?=
 =?us-ascii?Q?5W/fQoTr3kojXUzRsxUUeyFHqAzz3zH5nZCbif6SuZOBqDMPsZbo7McqaqkB?=
 =?us-ascii?Q?yTmUzMm7TioKu+WsEUEd9Ie3l5MA65YWpV6LeQPpQVDtr9WK3gSBv9+5HbNt?=
 =?us-ascii?Q?kAz5obvuQsE1gWQ5P4eywa1w+XbIO0i/++x149rhrs1JoiipT0JjmJnz47to?=
 =?us-ascii?Q?UfAUaXQYJxIp0Dw+CIpaf//OLoObjgQmqpYP4Fiv+hn5CpkrfHgEJCknHAa0?=
 =?us-ascii?Q?21E466QSDBqWrypjPwPdWH3yBZhhrDaqHL8Lot5c3QEl+O6PhksShaNTzVxA?=
 =?us-ascii?Q?SEvd6UD9ZNwwszOg7GzcubF7v4UnCAU1QljPH+Q73PxJHVIxVhzQqjfoKO3K?=
 =?us-ascii?Q?4+s4zvKCXUAl4GweuPXe0asJFDO/Hya4NSr7RwkwSM8GxKxZLUpQIzzpoke+?=
 =?us-ascii?Q?VyRXEg0tFfSgBmDDgLap1EEyMBrXHZyc4Yuyo0weFQdQnnhn9R9VCdjZ8Abk?=
 =?us-ascii?Q?bWQJj+/3AHSJKFOuIp+YdeH8nqnHdOoN7YJTHW52/IpigNgefjwFdnuH9w2s?=
 =?us-ascii?Q?n6PASJW6F00NFcA9NsFWOdEZeQNA74lMOiLS8ash+fJVpTpYXuKRMAK0AZ83?=
 =?us-ascii?Q?ds7bzv9C7kZqjvpaIiG4i3G1BPKZxk1apVg6a1pXDDah9X3Ityyh31XeK8B3?=
 =?us-ascii?Q?Mx/mk9yG1fBopU6rRpxaY4bdHbcnfRj1aOV+zaCeA5CfiqIb30c1ZvkGMuiK?=
 =?us-ascii?Q?/495ZGzhNVlu17iq49qYMl6snVVCgNbYIfQbqXDCudutBBzcKwQAIqJoO7mz?=
 =?us-ascii?Q?GjDNJFCBMritv1qWZOoyPP/yizyXlwaV0aYhgCzZVyB37Im1Tw3bOCv94hVU?=
 =?us-ascii?Q?ZT8tC/mzYElcTeFb7FiPvztPuhFctE6Qv3Ql48ojOi4ffB1N+mOsiAlRQM+d?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542eae0b-d1da-40e3-7b6c-08da841751d0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:21:32.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l61hcpdAour97pUwPShvPzX9jbsafEQoW9PL61L+nFytFCL418HEjiqmZowpboOv583gVnjRGI41AL/cbBLNDefkEWKoIIXQxzUPRH+AHGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220035
X-Proofpoint-ORIG-GUID: 51TrClmKRGbJtemzboBbrDMydPwmLgbJ
X-Proofpoint-GUID: 51TrClmKRGbJtemzboBbrDMydPwmLgbJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 08:44:19PM +0200, Nam Cao wrote:
> Please ignore these emails. They are detached from the thread for some reason.
> 

It's actually normally better to just start a new thread when you resend.

We used to tell people to use --in-reply-to but that ends up being a
pain.  The threads get messy.  Also these days some subsystems use
patchwork and patchwork does not like --in-reply-to.

regards,
dan carpenter

