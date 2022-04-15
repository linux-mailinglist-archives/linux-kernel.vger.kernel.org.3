Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D851E5025EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350807AbiDOHBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiDOHBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:01:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF89554B4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:58:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F5l79p012784;
        Fri, 15 Apr 2022 06:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=7v41giAXTJCCd+h8auiIGMFxPCYKlogtbLn81XLDu7s=;
 b=jYryt89wsARZahmqzSyZI5nhjGFNe9/7erw1FHvZWGtMhKXEb37aKABueKqzcHk58fUW
 Krqg3+22X6QhfVSh5dS5PvzL0aIuktc8ODoTIQKKV24fkEchg+KiDir1c5SX7tp5Fbrq
 H6NO6pnlPWCDdHGo9KCwIchOueZ7G++J6L1ydaC4nkvgPXgYZqGuegn90btHuLgypkVc
 V5kUQOP28OUvVC6NJBmxb2oOp2psUE/qNVPaejbM9dWzg7jFZDAhNEtbqw3rqIGuG7tW
 7P8nYmryUhlZCaSfWgKHELked8zs6VDN/fwCqQ5X091Fr2hCw+qwuz/6mj9fbpp6EM0c lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu6uv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 06:58:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F6uYFO001177;
        Fri, 15 Apr 2022 06:58:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck15pkyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 06:58:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwWw6C2rdI7Vu2JwoPbxvvB8Alfh5cMTJqWvUisqXryvhJAXczlZ7LSq7KSL4vh0aFjZ5zj9gz581oWdaszQGBe7kkP3lCqyqm9+HhJ6L6zSiCTwfXGZB1PbJuyRRmtFmM8W4FoB9Gh6wAHJaC5oZvMqZX17vJbP6FgQQI2a1vke1zcLisnmxYDxHC8VU4Ud+bj/TOUVyDcnG50A15l+9gFedEuBtupLj7+l1uejQSIAjtM/L+flJBzKGpb3n9WcKEXU+123fwYFjIJjew3P70fsWmR8qmMRbSFRjX3QnTvjXNs+V/2+CNYT3SMzDMYFcTrE4pfYIxwztmMaR3ZC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v41giAXTJCCd+h8auiIGMFxPCYKlogtbLn81XLDu7s=;
 b=U+aGv8nt3X1mX/yq5xDK3laB6IlqxrzRSXtC20O69t3xlrFCmuiITX4k9KbKiLH+JKNIpu9s3JuZiJMHjylU2ULVxHz12TCFRjRx3VtW4XVJRrfGVuW4INwtk89shvCE+B6EL6Os925L2fe1a+GnouiPY/8mjEOQfcnPV04zvIA1HjFnTJaHO4KZ8NmeTiGljiFvJCQvIN9aAr+gIOtDZFf7gQn6kYZuftk++sD3aRViy5OmPwsQsN5kL1S5QRWucw++8lBkiCngY9+Ty+FjOFLEidWV+OzsfdF8Rkmjc+dOunkXYHOJr6Ee0LkS4LTnct3SS8jsnyEpZ4fRFn/C/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v41giAXTJCCd+h8auiIGMFxPCYKlogtbLn81XLDu7s=;
 b=LvJIqJZj7KsSrnLq4sStVg/uZHsy4nQq6NPNOlM9FyTG4/i/MWDAaJOEkP8gHlkNjO1lGC2k8EnfPL0GxK3JWC01FwjuNfyI464Ekf0fc4tL0DuGb0a2cXxK96Z7gXiEEGJ310IFLiynLkC2CP66GA2MIytYpx5TT3mPz1hb6qM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5042.namprd10.prod.outlook.com
 (2603:10b6:208:30c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 06:58:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 15 Apr 2022
 06:58:30 +0000
Date:   Fri, 15 Apr 2022 09:58:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] staging: rtl8192e: Fix signedness bug in
 rtllib_rx_assoc_resp()
Message-ID: <20220415065810.GQ3293@kadam>
References: <20220415062000.GP3293@kadam>
 <1650004767-27432-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650004767-27432-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27590d99-e00b-4a5d-cc68-08da1ead5922
X-MS-TrafficTypeDiagnostic: BLAPR10MB5042:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB50427635C62FB3870787A3A58EEE9@BLAPR10MB5042.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6yrNe/IW7Y0EcYIQzbudZMMF/CTLH7RwczI9x6pph/uNUSmvYnYELhNydXU4seupZX2a6x2wEaQFUGqZDQCqIH6jk4oz5wW6PmcmmvnwewXcBEoKnKvT6Av24MprDyDRhbDRjVL3OuRYoQvl3XFrNFprM/kZVXQUTSqGxyrZAZoyyrFWtYLQ6euUssmNjNlHfuMKmxX2f8AUMMLF8kOt4ZOfC3LbBtACL31rFV7nErbAi/SmMvXPOo60InfFqgqg1VEX0w9PdtPgMidsCKKOAeP5cFHvKR8ZyaEAx9ARYqSjdxkS5yUzpHfO8mifc0HB5kC1Rjuy0m6vqebHvEEMhR7YHH4EW+Qp3aBIJAwoQYD4xom5wrUGsDM5+nuyO1Ru854TfuxuS8EnrkS7l3qXYz4ALmFNN0beGYPOP3cFp5UxjkqJKMAHSCIOcEiv1U5saXHMdR3daxLE06Nu9WfxokanqQ6dASP/4S04xQq1aHZUcGCJ4Fd3joDDFPZ/Vh7OYwMJe3iRRTwdISpqiiaRlpLeqjsdvRpTr5pYcd1wEOB2zsSudQiEv2AoBjtOw1An3kmWS7blNdS6rfWI9DWr759oi5Mu1hPOtRhAXDWLp6gWEgBaHkci3MUuCRovZ1DhBRaEGjZv20eB50ghYN4MapbWeoMl4KIXOnmsQKUDBswFKS1BabwGPvzf0WniVzHFfmYoE6rrf5CqP04uxabuIf/7vjC5I1Lce0ELKZ5E/nUt2toaBElmJ/SO5M+7LDXeQ8yAKSEU8WOFq/EzvC+GoGm+DOGEJsU+UtrVEjp6hQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(6916009)(2906002)(66556008)(66476007)(83380400001)(86362001)(6506007)(52116002)(4326008)(33716001)(8676002)(316002)(38100700002)(38350700002)(5660300002)(508600001)(6486002)(966005)(8936002)(6512007)(33656002)(6666004)(44832011)(4744005)(26005)(186003)(9686003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mqz8gcUlRGGi92kHKAbjJ1Rru6PV32KR13mnQYJpLoKvM1Ay3MdFKqrE5hdi?=
 =?us-ascii?Q?Ak5I98MmJ7L0RzNvKogDpJp0FevJwkmM3yQGPqbbMBnzpui953oZfYhhgOSX?=
 =?us-ascii?Q?Q0usCBjv53GoRb8jSrVUobk/Xx0Use0lGiIXLx35MXp4iE5h4FJ8fRBUOsEY?=
 =?us-ascii?Q?blF7xk5+l3w1hZPlEXclsDj//efkVvjo8lcwnA94QJPE4SlvngwWCF5SdzKz?=
 =?us-ascii?Q?Z+Kv0bxePw8VYyUYIGhJbeOwVRbNifha41tniFTbA4nrVn77u0+kF+gYtuji?=
 =?us-ascii?Q?Tv+zuxUhrD49TheYruABoHb+OG22t5Veo8kb74buJRa07DboUhB0qWVjGZBb?=
 =?us-ascii?Q?4OOP74U1CozRpALsmMH/m3uAcNo4laFYccuPYQ81GiBHQxAyZ24IEek+sdhq?=
 =?us-ascii?Q?dDccovNx976Ku1DntpI84aItuSEbiWHJ5qjewTvWF+ax4hVW2N9FFLG1yYk0?=
 =?us-ascii?Q?dubEnscXzFOtbkp6TzjFlGVQXi5fOW/Oqf50fJeDq3NCNkcLqo3QWY4sOfIr?=
 =?us-ascii?Q?jtwYMdG8xMucerEW6Ys833EbnJ3LFoWrzhjWt+jy6dQbiuVa/WJFZvBAGiAV?=
 =?us-ascii?Q?BneINE9BWPoIywpqzQVMFSnCsKST3kjJStklXdzcREB4FWkmA7Jp1Hrpxg5e?=
 =?us-ascii?Q?5raW1bHu3ctJzV4SFEaaKA0ciYUja1SO43WLexVXNndz0L2EGsAdztoPsfdL?=
 =?us-ascii?Q?iOnT3yWZ2KkAgXhgAxBI2GpkeFryq16g/pNVrkmWplcf2ogMrJE1CtslD/gw?=
 =?us-ascii?Q?iwce+Dr2C4suo5J6NvQMWNwZI72hyEmxEqEOMyUZ9lEeHOmwJy+Ph7oYm/z7?=
 =?us-ascii?Q?W5J6Ek/qPxCByD1INOnBJXTQl4v2ai4ul1j5HaFCxw1zy8NekNALoeknNANe?=
 =?us-ascii?Q?HvmMhbP23XzHWjhUMG5PCiOoCsQXozX+TD8KciZinUu/6oqyyl3qnUOLTx0a?=
 =?us-ascii?Q?wST37uXlXYFFR+iUWmW0N9hYkLvbhPinln5L/DljMfpUtF+IXRfQWD/2/x4d?=
 =?us-ascii?Q?Y3nGdf4YJ/SxT2rnuHmhCXRsNQ4yygXLonjwMk+kLCiGX5kI0xXfZalM+wac?=
 =?us-ascii?Q?CZ+uApHPYOAK6HYY0TdhLKqQqvl1F+1u/Ro1loga/SElz623FMyGSEeD4GNM?=
 =?us-ascii?Q?DeZOkXU92xjpiSD9DqItcJs53yYdhyGs1hgWuFNlmxs9Yv+bbQWVE7+5ue10?=
 =?us-ascii?Q?B+ixZJCTQ5h4lPyAJ4N3qP6lV5sQM4IMw1E3cPsj5gHG4gRRGJ7wFcXL0cDq?=
 =?us-ascii?Q?/4R0ScoC0e2/vRfKvwhCZ3XF4dr2L4SwjVtpGOn27NPKXPIZoSnnxB2PQfh7?=
 =?us-ascii?Q?p/UT6RPQeVMAuEG/MyG9tzyTpZDBTXR0xyM/JADjpcCODMPCDBJjnBg8U21v?=
 =?us-ascii?Q?37wTZVew/T3MgCC3QzjAcXialaGb9gjJ7iwCSgz8SQpx48GIoPSP+MJdgQ6+?=
 =?us-ascii?Q?g3u86FE2mzFtxNWmHrUPOEMXQG6V+8nOjKbBKMEI8xbiOEmCupoxQALpCyrA?=
 =?us-ascii?Q?r34352jyzgycazu3RiBlTZkFA51+4R8cdOqvCgxh7wJZTLxtNxlkeWIbTYAl?=
 =?us-ascii?Q?er4Y4kbxTF1tAua5zMgxeLwiRAG70/e9mB8T7aTiWIoifYPubLV3y43XI2V/?=
 =?us-ascii?Q?O6YM/T+zXzVMkWm53RcodlndtLCJEyJk/1Lsn9GLRDPIDmBQmmIUTBbKGOxk?=
 =?us-ascii?Q?Mo75qpZ3ruuaoAkXbitpq5CQsbfPJtwlqnPS8/zum7WextSJnhZQmrBrsCGn?=
 =?us-ascii?Q?yOnto3dgnv0gbRTRNbnvb4/kVsOG80c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27590d99-e00b-4a5d-cc68-08da1ead5922
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 06:58:30.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZSyUYuu76vJmqDNp72qAWyzObYNISfBhN4C17zUQJbBW71Yv7yHJsSsqEUa/xA6FJKICPUeIpwKR0/5x5iIarSMcjxkjpWZot7ckQTyA7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5042
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=880
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150040
X-Proofpoint-ORIG-GUID: RyvPYxhecaw60YIX-R9F8jjr7vYawrzs
X-Proofpoint-GUID: RyvPYxhecaw60YIX-R9F8jjr7vYawrzs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 02:39:27PM +0800, Haowen Bai wrote:
> This commit message suggested by Dan Carpenter as below:

You don't need to add this.  If you feel you must then put it below the
--- cut off line and it will be stored on lore.kernel.org until the end
of time.

> @@ -2292,8 +2298,8 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
>  	if (errcode) {
>  		ieee->softmac_stats.rx_auth_rs_err++;
>  		netdev_info(ieee->dev,
> -			    "Authentication response status code 0x%x",
> -			    errcode);
> +			    "Authentication response status code %d",
> +			    le16_to_cpu(errcode));

The error code is not a le16.  It's just an int.  The way to prevent
these kinds of issues in the future is to run Sparse with the endian
checking enabled.

https://lwn.net/Articles/205624/

regards,
dan carpenter

