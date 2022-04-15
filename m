Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3075C5023EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbiDOFeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiDOFeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:34:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4B6A146D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:31:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23ENjooY028053;
        Fri, 15 Apr 2022 05:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=YDaBWqGYr+mGkT6wSd94FnP+5A4izxj5cc4isg6GJXU=;
 b=MIDob2lFhf2nqURCwMEg3ksMWslPolAZZXxzIsRRrC7EcCANNNEVP9ECXQMwKOylYUFT
 pbNt8z9fM2VuNeS1k3QH2FUcACFwxi0M3rsSx3HJw69w7INdeTrR05bsiP1PDQy7h70K
 2roEHmoifXed08A9kOJvChpZUdUdUQCGnoU7M8WM1y8xVDmS1Qjusa1gcEIz18oOucFv
 wnlR/FkZgUO3oEd6NXsYmazOk3m01K5CHIjLzTZqX6lDRcH6ZBtpVwYDat8h2VrZ8i0A
 euCpnzHBf2rAENjdDgYb3wxOG0iNqYXeA33nDeYNlqx9q4LNQPjecnSNUZWPmzk+ipNT ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a60nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 05:31:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F5VWDW039355;
        Fri, 15 Apr 2022 05:31:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k63r18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 05:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwQ3ecf96lCHeDyOOiZn6xiHR45MJ301dzlnks9Rg5k2LkSHP+q9h0lNObx3jQT6JoVMRDB0F87cmNOZI5uQfnZSGV9+q6moA8fieIMUs2s5sJ3yMj6kEC3pJM1Bf1AeT0lqt4uc1xRpYDSzQ6tCugxxnYHhiKVEQNOeD/t2nyXN1CwmqoIsjH1bkuSBC0jmZSKzCvSizOoF0Hd9xOpygQyJxLkgh2b6ucMQDkoCJXp1HF6okwagDucVC/z9G9qgpptarVApdQiX54Xhjks3YpYYdNsNAEqVvMd1kJXPgcjR186U7IQ5i8r2Fcu2PYS42v54lwSJRpoUTJrN3x6c9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiEJQmpF9kHYbA6kslMkfbR6ofP6lerKAcxTzP+7NmA=;
 b=bHUm9H4DXQNw8sYQSJe2oZR6i3m5eXfg3CcD3u7V7LBLwCtYet5qaNNiZqlXLwgWLGAsC07H5hWfgiaiYhlQMfwvUTrERhvDqN13SWjJ71UU8A/cd8d+JyXmAyM1mYLLeb+XXdHaldr+cLacQ12eeRLWnNy7fNP7BKfvHJ5HDprjhsgXcMHnRLNp5m/ng54zJNRhByndLBkXbE8Yqx5dtaJmfu9/A5KLUfTsj7j/BkkT5Xu4pdE8zxmENRX2kF8hjy8pvQvLZ5xHVFPvVgelKFT8VJi5fNAIo6zXxgayvdzCmffFTkby8S4RnUWGZ7B0z7wi8G3RD86t3YGyfroOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiEJQmpF9kHYbA6kslMkfbR6ofP6lerKAcxTzP+7NmA=;
 b=N2CGonVndbEbAEkqW3S8An6C5RWAl8KFub6p68OrM904jar+8jLTERmMlqwnoN6fxRHRhyxIkg1GgnfTr6Yvrw8xeweKazVp8KGw9fbMALlkZEkeOkti/Ss+K6cQesmQcyHXqZtvYAnl5GYtCPegQi2dpnrcGnTdcu1QFMPKXO8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1446.namprd10.prod.outlook.com
 (2603:10b6:903:28::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 05:31:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 15 Apr 2022
 05:31:30 +0000
Date:   Fri, 15 Apr 2022 08:31:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net, len.baker@gmx.com,
        dave@stgolabs.net, edumazet@google.com,
        Haowen Bai <baihaowen@meizu.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: rtl8192e: Fix signedness bug in
 rtllib_rx_assoc_resp()
Message-ID: <20220415053116.GN3293@kadam>
References: <1649988571-19923-1-git-send-email-baihaowen@meizu.com>
 <8973092.rMLUfLXkoz@leap>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8973092.rMLUfLXkoz@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e111ab6-b458-455f-cb88-08da1ea131ce
X-MS-TrafficTypeDiagnostic: CY4PR10MB1446:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1446B4DA379BB47CD5E6C9A88EEE9@CY4PR10MB1446.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ooKEr4Rl7Jx/Wgk7eiiL+r2uytME/QIAx0anWdUUdSK7EhZvn51FXHAZUupfkc3Mz8SFmG+6Kr6X1Z+7JKiWjEXAT6WeuP8L3X4uod9o7e9Nq/46k2hxjg9uDzVM7B1BJdhvLY/dbrn2L0qIbRMnolNtZoSj4PADe3SRLW+ROpcFqgQhJs1bhErsaAVKlbWa+bUs2/duhXNUov7RJ64a6YXYY1dguBjrrf7oMnKIsZ4V+DNZo/o09DQKyCWENLLTNumyEZqFiHdvCrTxn2sWT8HCjlT1/V/7vc7XMdJrRv3hBXiV/OOuplNeRmu9odI4zQaLy6EyLkKaEtfoQ6qfSu2GHrQbI1DBeA3MyMEne0TXVFok1dj3ZGh9icCZbt8n3a7kAXMQCc8V+EosLzi8XH9C2Ru7AAnyCImxN6znRAZbl270hBR5Il4sRpsKvhPjSGK2szsbflCelgOApMZ52w12cHOt2Lm+FpfMux/ICgmwNjQN2g0So40sHDW2snY+/sbjWT9WkdrhISc/dRf1zsFao/8p7888Wk7AvvgA+3X1KbG2jBk9Jp0/J3pDACahMF6zq3ul+8PBu7eCGXN+9W0ChMWJ6/u3nEXHwBJp9qEqlIIr+rjzFjqszQQqinlAXXvT4KId4KF74C0F7jP1urA8cqpn3l9Nh8NJcxF7om6nTHB5OUOPrcYTIlXE/CrIfps7ByyAoEhCiZKqxXKkQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(9686003)(6666004)(6506007)(52116002)(1076003)(66556008)(66476007)(33716001)(4326008)(66946007)(8676002)(33656002)(6512007)(44832011)(26005)(38100700002)(38350700002)(6916009)(83380400001)(316002)(2906002)(86362001)(6486002)(8936002)(508600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?g9+4CmOdbmVeC7bmxfqbFKh/XnEg4niFL3l4vT486ZyzyYzKAgfpeCXN6f?=
 =?iso-8859-1?Q?nwRf3q18W20a7FZE91/ny7cZdfGnVVRATm3Ew5gofGhrSWcnvuuG+w2rhL?=
 =?iso-8859-1?Q?/WHLNNmRKfx/UH9WV1HoKdg9W92gIctSrNOh8V2VXw7j9isVEWri4ssJzm?=
 =?iso-8859-1?Q?7CAzeGO0puH8uBiqjnAon1ZN8c4ARo76AyfV+zRnS/LLEtbTV0MoSdanv/?=
 =?iso-8859-1?Q?btDx9/ZDrK1Of7Hx9J9FpTDCKDjiilUbbUXYFMzBRughRDpth5wVjEaU33?=
 =?iso-8859-1?Q?jG8Iu+le2jIJBEDM+yLNOJo8dsvfCuEr96rvLUsX3e3kI0mypzqKxhINzb?=
 =?iso-8859-1?Q?edZPp1mu1c9M30GLqCQrzhjumYyu87vud3a8oIDF8EzsmVpFZorCDH5VVg?=
 =?iso-8859-1?Q?lIhG7AoA2NWWZ4IVsb4Nqvmi5aID+90hoV/TypLtuzV768wNmxjHfa4ORZ?=
 =?iso-8859-1?Q?TcYtDo28aqKwS0mwBNVDufujucn+nwBoxF2LQCW6zUBBStR6EQuId82/iR?=
 =?iso-8859-1?Q?r2xdmh+MBylviKZqDLzDevMCluBMUYFqhZOWq5y5ggW33EE0qDrhM7bGF9?=
 =?iso-8859-1?Q?sp1dB1iJkB2KLOZarXJg6qLi4ay8vf51zfAGflwQYHgtYovSevrdjucG8q?=
 =?iso-8859-1?Q?mepJnrhDZ7bhFforYp/L9DjGCobCWvILdac8vBBdBQi9QAR8MakmZpiPT5?=
 =?iso-8859-1?Q?/hmDdW7Hnx6EFhIFPGKAKgQ/x+6ZZZqd/K+Nr+7TT7v1PLTELonHX1Ewbv?=
 =?iso-8859-1?Q?wgDABDl0nUqFuDCK6vY4Ey7yUwpwhbZMgaBo2ilmbsB8iPp52Vj3aGHoNN?=
 =?iso-8859-1?Q?PegFtdH+8bzYbuiRpKCgSqW2UjN2hHSAL2kNCr38s8umelsFGnLOuWUptG?=
 =?iso-8859-1?Q?xub6KiMsphx9QDH/C0l771YRT01oATgooES1kf5akeCeWRFDadonELa87H?=
 =?iso-8859-1?Q?Wcl2TS4xwxPY7qPLnJ3FPQRGaXCHM1EyVZz7wmKTGhX5qhTC+WVBIDDNKC?=
 =?iso-8859-1?Q?DucnIoUqT9vTKUhOUWoCmGyW/sGK/e1ZaNnvF6QCZkmEKzZIdV6vXSxklP?=
 =?iso-8859-1?Q?cH1rz/m8YIRowdbIut/TtOtKn+CqrgQuS1FxPStpXDQ9S45t324sxF/Nz7?=
 =?iso-8859-1?Q?2CPEGvuMYmoOux+Eh5+izkg8tH59r8dcErCtlUqQJMi67CVCpszCbFPMlg?=
 =?iso-8859-1?Q?vjenCDOHF4O/w7hhCRB753LF02bJwNQ1e/P8tFvyGNOPkVkH92rykOSGU6?=
 =?iso-8859-1?Q?M2GcCRFxl2Sg6nSY2kQ9/ar1JPT/ZKsMnxCP9fJoUvIKXYGsXQw85EWWGj?=
 =?iso-8859-1?Q?Fv9Ayx8PB8SP2DoL2F/Rvc8jRCtjYiKNOw7Dwc3Pee3wkwHOe0SORQ+/XW?=
 =?iso-8859-1?Q?IGfUxgB6huKBzYq7TNgJ2DINOcxFy3bBXtKJ77hP/875y/sT22XDNUm7no?=
 =?iso-8859-1?Q?Z++PzNs32htq5KP44pURf+a4+LoauXZu5ZzqWtmWwJ7QOiibqKQdgWOIXJ?=
 =?iso-8859-1?Q?oKwOw5rEDKVZjRvYQn8ZjJ5Vusy7fgkN3J4axZiANtRs30D1QGqOICfOwd?=
 =?iso-8859-1?Q?+xKhk/600/NMM2PjRNDH+mpUjonNsj7/XuzuxtTuPayZXjzDw6Z0/TKm28?=
 =?iso-8859-1?Q?LboM7+4/Z3KeeCoGxjAMA1k2aSjVjAMdLN94SHFl9LHrL3+623dKYnEJQe?=
 =?iso-8859-1?Q?sQlMOt6bA5ZCfF3jOJjRcoW/sG+uHrRSU5XuSoRx4QIZKyE4/sD/Spy9k0?=
 =?iso-8859-1?Q?RprrKJVE2z6VU4jXZQllOu/9rwBLu2REgAo3M6wSraVGG5hRdnCe1TbZX1?=
 =?iso-8859-1?Q?XtqXbi43eP5ZDs4g/kv5faOHMPZpvrs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e111ab6-b458-455f-cb88-08da1ea131ce
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 05:31:30.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7lp0GhiWUFQWX56nDr1jaMQqbxD2DQAWJuHS/BVgPc5hx593lsA+pyVv2VoaH0LpyMkK5uSKLJ1zvrPR3adR1JCvfKcFaMbRw03fMVu6oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1446
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150033
X-Proofpoint-GUID: kRSNacYKdB-hw3SdFx3cnZnOAW5Ga8EH
X-Proofpoint-ORIG-GUID: kRSNacYKdB-hw3SdFx3cnZnOAW5Ga8EH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 07:22:36AM +0200, Fabio M. De Francesco wrote:
> On venerdì 15 aprile 2022 04:09:31 CEST Haowen Bai wrote:
> > function rtllib_rx_assoc_resp () unsigned errcode receive auth_parse()'s
> > errcode -ENOMEM.
> > 
> > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> > ---
> > V1->V2: reduce return random value; print its own error message.
> > 
> >  drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> 
> > [snip]
> 
> It looks like you are doing too many things and that those aren't even 
> discussed in your commit message.
> 

Nope.  The patch is one thing, but maybe it could be described better.
Here is my proposed commit message:

"The rtllib_rx_assoc_resp() function has a signedness bug because it's
a declared as a u16 but it return -ENOMEM.  When you look at it more
closely it returns a mix of error codes including 0xcafe, -ENOMEM, and
a->status which is WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG.  This is a mess.

Clean it up to just return standard kernel error codes.  We can print
out the a->status before returning a regular error code.  The printks
in the caller need to be adjusted as well."

regards,
dan carpenter

