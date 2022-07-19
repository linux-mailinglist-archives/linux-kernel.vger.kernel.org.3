Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3D579116
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbiGSDBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiGSDBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:01:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B03C14E;
        Mon, 18 Jul 2022 20:01:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IKnNYw032504;
        Tue, 19 Jul 2022 03:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=+Qy/RQbyTHIgrK4n4w2rhuwUL0lUp14D1j0iw+bPTgo=;
 b=Jho+hwUP4czhi2LKr4TlT5rmpfBk32DcFg8p38cIfziBW+WwpJj0qJRm8n2OEACQ9aTY
 bmZwWoznMOdsdDY+ZUKeT6Z00Lq4Svxa3nHW0xabmysPiV8zLI9qj/ZmcqlpGRPSm9Eu
 eLDVQ1B9Y4TpUKEcGhtI+tGYo4TN9o40xmngW3FFSJd/IgBicl8iBQtWbzfeZf3jmVsK
 ayjpMLJadYnYtgHdAsvT8NXaxuMbOqMdI3GeVQiV0xA8w6ZvcLDMk3ixPIfRpxQW2D1I
 MoIiYS9DFAnYnHAWBrk6/3DFfHe3YjD+JijmznHK75pqoe/ndWgSpWP8NVwxFsI15fgU Cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0w0uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 03:00:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J1L010028153;
        Tue, 19 Jul 2022 03:00:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mar52p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 03:00:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwLGtiawy8rsLAOUgvbuRT65wBm/GV95Q1HSGEFaelG6jY9CRw0FHyeAX57SnnRfywDlWnRasvXeil2iGC0jcLuDuf8/X+PRKOsce7rOFDicbys5NSD9THR2lHBjnFnGyW1ZmDyxLzY4L4hBfRkemL1BgQed8ZDmaUbHcz2dUm/63qDrUzDlwcFmB0ATQYubCFc0Ii67IXjZwq+JIyWD/X0zMs2/RTSHlFYoj4sMIbwrWMNsHGKESxAPO/FqcTZXowCUpzPKdwDvhH/F7nvtzIIgWqsFoHFaykVOGJHa8Agm1DOtUtrI3k8izfMmuu6pihU49/ZO3yG+mTePHBBJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qy/RQbyTHIgrK4n4w2rhuwUL0lUp14D1j0iw+bPTgo=;
 b=UFwXnLS2RLZvJOtyOfShmjN7/cjW14I/NXREfzggaO985Mx5DNbxpn+HCHCTV0LxwkiGm6QIowoqbJzY0j9j2MKgVvW0Fs6OXaNwweQxziL0ZNePy5XbGrUTHwOg6PbgugQS2RS05Kk6kTI5IPDQLb668zYnj1LKSO/8uE8d0ptWaIQCGVVnrI7phHKAPVAvflRGgGOjKWaugleDkc8lyyynKOdFzKi5CzLEOz3ppJVhJYznXPK1Q/B2LR8qx5qdVg0+sdq8AJlMe937xYP90CtOVonZKODNwnqiGIbZhFwXZ5215oQHrCurYQZ2cz794cDgJ68umWWkMxo1fVpJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Qy/RQbyTHIgrK4n4w2rhuwUL0lUp14D1j0iw+bPTgo=;
 b=c/bDfgF3pqWOj57UsJt4XC6XYvtrXlkdM2mM++yLyF5U3wcOpZEgE/PxGpCWkeJWK8gFO80YykmJmehmsqS4xdldy/oegzErFc7VLBlgitLIRUcLd0CqBTW0oEZIyKdQpfS39fYE/gTOiOzzzM2GvY70OaHGlfx+odOajDdGJBo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB3937.namprd10.prod.outlook.com (2603:10b6:a03:1fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 03:00:42 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 03:00:42 +0000
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        llvm@lists.linux.dev, martin.petersen@oracle.com,
        mgurtovoy@nvidia.com, michael.christie@oracle.com,
        mingzhe.zou@easystack.cn, nathan@kernel.org,
        ndesaulniers@google.com, target-devel@vger.kernel.org,
        trix@redhat.com
Subject: Re: [PATCH v2] target: iscsi: fix clang -Wformat warnings
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jzdq01g.fsf@ca-mkp.ca.oracle.com>
References: <20220708211447.135209-1-justinstitt@google.com>
        <20220718180421.49697-1-justinstitt@google.com>
Date:   Mon, 18 Jul 2022 23:00:38 -0400
In-Reply-To: <20220718180421.49697-1-justinstitt@google.com> (Justin Stitt's
        message of "Mon, 18 Jul 2022 11:04:21 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bdb0fb7-01c0-4fb5-6603-08da6932dd92
X-MS-TrafficTypeDiagnostic: BY5PR10MB3937:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pl7x5KV17CoCTv5+N2W88Cv8tN4/3i2wakte5mvGcM1v2Fwz1drXBfIDRsEIcOdLDke/S9xc6FS/SjDjsyxkhrxBbyJ2m+GjkE1NHaTzNgB3Dk8Qevj2YLxDqy42770lWAYvG2bgEoHHH2lLAFM2XcEpc4+iB3X0nfs7rc260C86LYhNfTqHq1xnQx7b35snZJtav7UI6dAsqeEoHeZoALNoNEs0Gl3qy49N75To/I/BJIUMcS3B6rloAlaemz5r8eeXkFC8yObGz+LQ3o32DruzHnvMT/RP9bFxE7F69i5RakqFnKBkm0ykukB6GKiyqaR5hUGKE64FOrpTZdRhbELnoMQCx/BW8vvR0/8c8kxeAWQzgxM0sxXgZRszBfl5OiAg4SP6a3pQWHk9VX5Y0qbqOF+kUMf3OWDi+uzIao7Qj2Xd+MOLPD2WCJmJhLG/4YlFi5wLV6vKy7hMSase31yHj+jNPrj7AbDHRxqexHVuSfAvhQCuw0lCnSiEBEKGsryuHse5mfXlidQaIVvhu1X8LCcMsELjOl/VHqxDx8IPWClIGL2R2H5ASLxyQOVNmvnXUa9flSYeyKkOR2MeZUsgiWz9ozBIN1XD3GBa+LAZ+otb8B9X2ThJmKqOl8jaXE+qIWWm1dPfd6wH4AQTnwKVvx6wFMW/FMlLtVDzQvURQNF+axVntyfmkYMr5hPvbnNey8q3WRJ5FsfPSM5v0F8EG9BANUcA8Ip5nFwWNjuyVwqN6ddsW30oZ1uz8GE/hJuxSpvjVeptMWshIqaSRmHU+N7FudCWiVfgrUdapVePKEbR1EoJKOXwtt8fXvGU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(366004)(396003)(136003)(8936002)(5660300002)(7416002)(2906002)(4326008)(6916009)(66946007)(558084003)(8676002)(86362001)(316002)(66556008)(66476007)(36916002)(41300700001)(186003)(6506007)(52116002)(38350700002)(478600001)(6666004)(6486002)(83380400001)(6512007)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WcCu5KBVBNi2yeAYbbHF9UMZs1M8U6/aIU6HGYI4qFOY1tjhNahf3+VpsKS1?=
 =?us-ascii?Q?FD0zXNKL7tE/yFGjv279GgRnL+UOQuWjb9+oMPctzbe+YeRdH1XYnnd51PdD?=
 =?us-ascii?Q?bEmBBH9LjrOUUIbj8PUEj2IwOucdZh/Y6sYkfpT2BKwnUhxk5ZGXx/v2VRMw?=
 =?us-ascii?Q?tqxCmR/mFjZdzpf8i2gm8jdXFKTzBpBS+zS/8IFjnQLuIA7h8iN8L8Flzhq9?=
 =?us-ascii?Q?utrzDm/+k+1Pa/JRLIXG/tveEP72TSpZ338lOsSK1nz1kSpUfjd8J66/o6wj?=
 =?us-ascii?Q?1oEvEIBNqFJdJwjofVdvS93oSf47hvCBUL9ElBqpqlOd1AhdtubOAVXuLUHW?=
 =?us-ascii?Q?NGCRys8T4IfBdequl+9ZbBd6rD5ScdjO3L3zT10qp9O1weC8fSmwPdq7wb8v?=
 =?us-ascii?Q?W/WiUoanNrh2Bq1JOSZpNtqC30wSyDTpJ/Z7AIPZ6bhar3DQk55Bq+7nENlP?=
 =?us-ascii?Q?7mRk7bsu4BqEr4kfeov9MV3lNtjKMH5EadH5CLuq3I2GODpVl6QOrkf9CThb?=
 =?us-ascii?Q?kH/mq9wBQUVp2BCHC0Mya6PMnkhmsyATrz+vMDR0vW2dfGtoD78wJOZChLkl?=
 =?us-ascii?Q?U+P3VCfYPScXK1MkzUMfuc6a9+QSh56ZX4SEnd+I2Tm/LaUz1K+YwDRbhcWI?=
 =?us-ascii?Q?4BugMDyLpPki7lPAMHKdZbRAmkYzb6+dvFZnXQnm64b/trr5i1EC4ET+rx1b?=
 =?us-ascii?Q?sCklCh2hnk00lHItF166qC8TFHUQb6uaX1D0ZDqvRfnODhfEQ75PgwBDV5lM?=
 =?us-ascii?Q?jpuQP0m9+NJpBc9s+a3fCiyofih4FF5Z54u3vx6Qm9QdiEzut2UDcHIjxYHq?=
 =?us-ascii?Q?/bg9zAAV+yzTniRh/7k7OTg4nlKhjEjPtVAyUOyBpKAjOer/KCpqHG1e1/SV?=
 =?us-ascii?Q?23h356kk37qhEY1tYV/rij7mezu/NFWs2hrHaCL+1SAc0+2WdVNfjTFO1Xki?=
 =?us-ascii?Q?y6aMhW7ILnwcJJI+yabpUYtCEwxzSlWrMDBCk6DpI7dK9snF5XOgoA9ym+v8?=
 =?us-ascii?Q?OW/aHMSLRsiCVK2UolQv9JsZnqw37Ye/I0AqummWf4wBAPkDUrO5jRREmsrT?=
 =?us-ascii?Q?o2zpgbBvmcvg9xHGalaIlV5BoyCD6PeuGf7A5/2bJZG71vi+W53D0jzPS9t1?=
 =?us-ascii?Q?/jQYnBMjXUGWdjRQVWjdIHb89Z5gw5CjhP4P2xzdN/e4DC4bvVV7/hxL9WRu?=
 =?us-ascii?Q?hsPWpQJVScdbYBDydLSAoqzJyG5aGM4bs76KXAo7K7OdnDV/A/li7W6fd46K?=
 =?us-ascii?Q?zHzqtRAExXdeXS7pxla2hDsKaqVfXOR7vZI8sck5TbZ1JX9nGtknKV97U3ZL?=
 =?us-ascii?Q?CmGiTxpiSX+UNLhTqJdRyuUjILHNn54rASpgnuO140CyyBFxnL+M4/MgRpQW?=
 =?us-ascii?Q?s+i4aREdw80e8BsY4g8uXI31L3AdmZltyn2KefyMWBfIG7/AgzJZQHnv5aNl?=
 =?us-ascii?Q?uGmsS3Yi0bANQZQQcLc3HO1WfyopYZnl8Ai4gUE8ER23IEskylOjyCwmgpxb?=
 =?us-ascii?Q?cKzQABsuOMQUtJfNcKM7toWIdwvP8m1vtq0rWLnjOkliInfKP31zjzQ42BqN?=
 =?us-ascii?Q?zHuVKWMHLwOVkKpz5ZLYlFxoN/dvRHvv6JVHwUAW/gei/kyiVgZxrQ1U/H7c?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdb0fb7-01c0-4fb5-6603-08da6932dd92
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 03:00:42.2516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6ml9irXejvJR2jtvhmB+Te+XZMZ1QvnnDtE/JVf08gVLS/ZNDPaOnajHBLQyGHTtvDFZdzR8w/E1pMEYNoc3g8tWiGRwgrldNNHF0q2jDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=737 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190009
X-Proofpoint-GUID: 1Htu93G4MZ0ez-cJ7CT9y3C0LYFT4KVm
X-Proofpoint-ORIG-GUID: 1Htu93G4MZ0ez-cJ7CT9y3C0LYFT4KVm
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Justin,

> For all warnings, the format specifier is `%hu` which describes an
> unsigned short. The resulting type of atomic_read is an int. The
> proposed fix is to listen to Clang and swap the format specifier.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
