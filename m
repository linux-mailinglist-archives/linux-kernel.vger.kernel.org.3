Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4D530B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiEWINj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiEWINT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:13:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0A635C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:13:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N549Hk031223;
        Mon, 23 May 2022 06:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=IiCTImOl3TPYMScqFIRj3I/yfvrEQXjjqtFiw9YcQLI=;
 b=ygHCO6ZjmwYY8dasTXN4F8xZjd4dPBqr3MqeoONu7rMoGLZABGIviT+iKjZ4Hun1qDIo
 xi+iKXP/aIRcWMnNN8wOMxBnlh6s2biPRHQaS5Ci3Xwrk8HgNv1xJUxKJzWnDnhqvEYA
 386z+Itfg3vA02JN3LfHD2740BKmeB/JbsbuxBN8sxwVfPndGvj5FQLF5lHhXWN2rBSe
 A802zYB/+mwpq0Dp2Nzq6dr2n7wCKHgLHryHV/n/RU2MhF2Gcp46bkIqIio+2Q61V2Lc
 K2Q1E4fzp6bW6aMDoVCOmuQxb2TJv0AJ5HUZfsvLKJaGx1lhg+Cg1aIeHjOXfFX/tkho WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qps2bhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 06:27:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24N6K2Lt032379;
        Mon, 23 May 2022 06:27:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1a010-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 06:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Phn4cCg9/EJc/17mMza1yq7NfA8lhu15KdolvjgtEpdZFIqgU5LQU7x/DlhLqGULCvoh/55FGrsHpP34K6qDkDX0O+4A5NKizMkqt1RDmXXnyDg4PCZSqSLoCcljv7GgrQMstQCNMyf0SZKUoxpM01lNo4gECUq+H3Vm8eAmXMt5+aoZD2J70cM3IyC+gcEJ3Rr3bhPoRPKxJky5rHKd36+vtAEMvX0IcIYlBe2EOk5QfhqbkZJrqVYleyVvDfhEH6qyCFchkGL0PHBAhaBy9FhavTSVFQ9nRGsVs7K9hakexfUFIztQ6hTTrA8Y8NkHEj9cXb3+nLQqbHNLHFUExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiCTImOl3TPYMScqFIRj3I/yfvrEQXjjqtFiw9YcQLI=;
 b=dPqpMPN/76cLzEHtFLyP+F0hyjQz4ZEspAbJz89v4xMaspnP0F3M9kpqes+/KtlFanDZxqplfvCIpz5KZVsgiMgH/hRQV8VB2eoBLWlQGo18Xxz9vYuo3KT7OT2+bUABpwukNDwnya8IvBzc9Cly+qqJOEmIMZKiacy4JVV6FHfppX9OjkjmmrjUQEALBveKuYn1J5U/MPQSjZ0EK8D4RigaMnIUjtzuhpIGBhmRjK8CzdHH2FFlrjoyBOM6eD2cUyxz91Ms6SulzVrEXkrS7sBfthxhCSoxXERPm+LDHg47pYny/K3ArJu0MIFsgpAm3lkSRZNBCHmhVgZaa6Pl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiCTImOl3TPYMScqFIRj3I/yfvrEQXjjqtFiw9YcQLI=;
 b=MHa5iBrOC5Djt4RQeNXkWjBiqBd1bYuNX5JbaCzgGl/ordOzpEpZRkg9JZEb4kBDiVcbzdKZab/IT0rGudaXrK5xi93zE7GRtYxPZ9/wmi78bzSQWFNKYkLOQtUlpIeYHoxAHz0z8kszimVWlpmuJIujAyMfdqwIebTBy4jZkWE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BL0PR10MB2867.namprd10.prod.outlook.com
 (2603:10b6:208:77::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 06:27:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 06:27:41 +0000
Date:   Mon, 23 May 2022 09:27:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Uri Arev <me@wantyapps.xyz>
Cc:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Fix indentation
Message-ID: <20220523062717.GA4009@kadam>
References: <20220522185157.151125-1-me@wantyapps.xyz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522185157.151125-1-me@wantyapps.xyz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 348239e9-e5f4-4ff9-0669-08da3c8556d9
X-MS-TrafficTypeDiagnostic: BL0PR10MB2867:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2867C377603EDD5A1E934C028ED49@BL0PR10MB2867.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7AMStujO0j/OOdiKKZ9KOxZstof352G0FKcjvZD0MWt2iiJ5FfZvyqgjS+KvUeWLDRpk7z+jjEbmuhdGN4qVxuDm3NPoZBUcAvJNDEiCd8kq8QUYd431iB53jNMdmW7eGwFW/8O377w8Ll0U8KZvNaLFLhkQ2KFUC4HvT06BxcICvgifqxCHcSlUGL0zo6prz8TBQZ2u8SPRQf9lcIEnj0fl94pS8myUX17hJ6NAw1wsyrSqjRy6zHqfgFu/bvqffIxCiIg/EekOL466HrUI+PESzm2HwdM35aUsPDZTpbRA2c2ZHvAVIorbGrwo7YAtZNz67ZVoScLglTwziUv8ABLuk2hxEV6i/0e2s52HFec+6Z8Asid1VdLV/lxMlFt2q+ZOniuwx6Ge9G3h8VC5lGVyxCX7yA38i/cKNwFruMVn7q+eSjEH/aB4OBEt0LOtMHrSAMUzNQcGk5ZKj+gb4beeqm+BNZ5r8Pn6vBZsf09OtVoyb9yPJA8QcbxwfypUORQ91nb0TxVDGDiQOJIbd0fAww6P3ReHxjkuMCzDbZs1AO7CJZKK+Vgcs6thpFS28dCpCv2NfA5DGvnnz2/p2DvEcLXCAD3uQJCgKp2BCTA9aT64ESujGV/YkMZ86T8xkDZvZ8EuwHl0ghX2ImlYYE/D99NOQmwNdXyiLdaXgPDtB+lEtEyWkqMolTYFcYtVDO8siubDr9/OhMvj4Ld4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(8936002)(38100700002)(8676002)(4326008)(66556008)(38350700002)(44832011)(66476007)(66946007)(6916009)(6666004)(316002)(54906003)(1076003)(9686003)(6512007)(508600001)(6486002)(558084003)(186003)(33716001)(52116002)(2906002)(6506007)(86362001)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FjQmh3P3ZwQoUOT1UMaO/j+NC8ZbYkA6Yu6xipcLykan2Oz6VCCgwyNLmm1g?=
 =?us-ascii?Q?9bRBnLzMwPTCmUo0y7vfJ4NFd65aC7viJ3cOslWCrCcfM4QStBM0bBK7u2lM?=
 =?us-ascii?Q?xoAI3QSqMPVt7PGh3i7TAHIqj5HIa3KypRV8uFtPpbH0uQkNOAADjwU6I5je?=
 =?us-ascii?Q?2PXIfg1FuxkfNiwVGmYt4KhvRcAF595yhv9rvG2ExXOHj7AQMsr1M/IqwgQZ?=
 =?us-ascii?Q?hdowvK/ldbB51XFid6ugCK0xa9T3ZQRORjaYc5YBNIukyWDZpAVbbbnrdL8a?=
 =?us-ascii?Q?jRuaMBJaN4mbqeNvGHCS6KEGJhl8aaAMZRxXxbhLToWxUZKXf0VpQrf0IdN7?=
 =?us-ascii?Q?VeDD5DGYdjJKrY1nogC/0QworHjhMHxNeKH7X5oDRpKrsCLrwZ2LKeZ/2hgI?=
 =?us-ascii?Q?RSNKxH+91++bGLOcbEf0n9MkPZk59hPed1O+Hic34SoBh21ID+GDk2YXSFRo?=
 =?us-ascii?Q?jULcJr47dOOR/hWnNyM7N79QS9jNpRkPmyvE89bYCFqTeRTwUewHL1C8fLda?=
 =?us-ascii?Q?A2NlkVaJp+Ocjofj2L276XJXkOyT5uaExgwNFOv++FH46GxAAzgfc8IlxTk5?=
 =?us-ascii?Q?IipYfSMfVKGYWUj0V4tSmqPBk4g0D+Yh+ZVFpia9XpC6RLsTmEWVGVwVnM69?=
 =?us-ascii?Q?Ds55cCuMHiGVnd9BTv5iEVbBRGyxwZKNi3pperbPzAML2Losum5rE6Jis/AG?=
 =?us-ascii?Q?ZdUXGws3CN0U+TtXFNmotOpanqaoQ2egByMIXsojqFd8X7on0ueaKvyDcdCs?=
 =?us-ascii?Q?iTGP8fxAvZUi/64b8wdL2n0mxrI7DWGCpKPxtLEYo/iYdqEmD1JqdMp16QrK?=
 =?us-ascii?Q?J4WtdwaMjWjlGzYotrQs22UFc4e3coghJ2YqYYXjI4c0PCHpRgNlpf6nRick?=
 =?us-ascii?Q?hr7l/L3AE3Ie3grVP5oYADogfKWfO3Di/45c0JxfPftYvqgoAiVjBTMO/he3?=
 =?us-ascii?Q?aWEBluqILvUk+jEtrOJOrKHTolf8bfpbY0Cc4MiEThnOH4aqUfJ4bHtWmaHx?=
 =?us-ascii?Q?Xa8iBZvSV89l2oVekdqL02uPKJ+OF/RIpyuuTTGp6KL7ByWFvStd/gsGdIHU?=
 =?us-ascii?Q?phcPxO6bIZgNxsLnSH+dHZdLGgGKOJSOyyV9IWqsiVGhg2gcL3WUa7iLUghm?=
 =?us-ascii?Q?hoNHwrI6HDRDIYriWQqayoD1MtFsWcAeTUC0zRmQrmLNM8tI8YD9kNMF4fKK?=
 =?us-ascii?Q?n/Q3WpCOdzd3B9oiqsE4E1W7IEhVcOs6MW3Zgbj1hhxSvUc0A6u0C0oXklpH?=
 =?us-ascii?Q?oqy5xfD13QSxSq2kvA3zbaV9sxER/JX+H/OPV4E+z1q51xlhQxuuNw5vZ5u4?=
 =?us-ascii?Q?Qll6GRsKqbuxtx29NHV0kdmosZJ1JdbrwP2nT1KmXZmg6+b0RXttwmgm0N48?=
 =?us-ascii?Q?zt25SbHUd0fF0OIUmnopJDaG3JIF9a/rB6SiOoFedBgq0mwW+FJtooHmtPAM?=
 =?us-ascii?Q?Aa/f3nuFcrR6IcsAZym+6UwTCGFWdzks5U+Vm3bcx0e466RrfR/dW7ebNV7n?=
 =?us-ascii?Q?fA5SNh1qOZhUFsyiMXakxEWuiFnReupEYxDOpY+Z1wh2GT1HPOTMVehYaYRN?=
 =?us-ascii?Q?CtpMlJs9KVyunZm5vLkWgjfjBxA54plxahZdr2Aq4yVXEm3dSR7gsVpCJ/ps?=
 =?us-ascii?Q?Qk+YDaNVEFQL49FbwpFbpLlGMEWGD0yHZ0drgMIRDLjw+IUPp6Zu7zSGSpOH?=
 =?us-ascii?Q?rP1NiFTihT0icb7hQPvj2V0wPwO0ZD0aIzIt1plv7BL+SAtW5x1N3OZmroyM?=
 =?us-ascii?Q?IPCpSQheGHMEQ2Req/VNlIgFFkdHOeI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348239e9-e5f4-4ff9-0669-08da3c8556d9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 06:27:41.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUcqsxuvERooSspMtzMxdd33aKotbHlmFGTz4H1nPtUWmDhn7g9vrEeLq7bmbjIjLbSVTbD2trkVDREyQczyJHxAXvx02VeCrqdDvrhr7pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2867
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_01:2022-05-20,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=700 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230036
X-Proofpoint-ORIG-GUID: 5Vla0ZxiwCFbmMeXmAyL5Fewu-Btbc5x
X-Proofpoint-GUID: 5Vla0ZxiwCFbmMeXmAyL5Fewu-Btbc5x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 09:51:56PM +0300, Uri Arev wrote:
> Reported by Checkpatch:
> CHECK: Alignment should match open parenthesis
> 
> - Uri
> ---

This not how you format a patch.  Please run checkpatch.pl on your
patches.  :P

regards,
dan carpenter

