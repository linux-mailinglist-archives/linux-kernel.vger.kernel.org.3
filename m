Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF450FD8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbiDZMum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbiDZMug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:50:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC5217B98C;
        Tue, 26 Apr 2022 05:47:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q9CT22027770;
        Tue, 26 Apr 2022 12:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FcTIe9Z4yoCGYOkIfs7rd9iazItyPnXQN31d8e61AP0=;
 b=scBE4T73AaenetBLjX6Ydjdxlt4tsW4ifv68zcnSBp55Kd2QTpZDpS14ljeohddg77oy
 Bix6e9H8D1dSY0aR+yrwFLjpD+UW/XGeYM9NyNvjJGsxObrr58gxyFDhiAGPbulEirY+
 LNnHYnIyynn3FirG6ZcyCaodyQWzL25qY/fyMDzbsTqCxsueLUX2ldT98j8YSADdR5b0
 UGVmPw1YopZrEQHw5ENXQK16LCppAh2R+gVjd0SXbC6lBDcx0fhzELQ9cMoCLQ+VFhwX
 hr5VQPwxQZg+aoIaUuakXLZTbGNtZEVNwJ0dYDGUXyl1FmEkZ8VCZluS7F3ar+YVFM6t Gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9anwf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:46:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QCivl5022420;
        Tue, 26 Apr 2022 12:46:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w39c1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 12:46:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNMTd+g0mX2URvnWX5Len+IVPAA5tEHnF8WOGKvNRwa+k8AUCSsnjI6wODl6Jc4gcj2Z0BXE0A7EbOtr33MAyMBmuClKmSzIB5ai+grr2sQL1SP01m9F2wCXBvde6yOfAJn90cWTWwupx1j1cKObU6h3yYdJrrlxR6PVZJwJy16IJzkCK8/NQH71d5CUKnV+tyGUkdpYPNUAIXicVFk3L3sr/si4uZVe4kHQelhoU+tHlabTCYoTPGNl7dX9aIBvKDITpsNCdtoyKNcmc0EfyM1k3He6PpiFMaVA5lINcosoBdMAeyX3ztBbueQ+JinKBnuWBjvoFyIXRL8+8+vcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcTIe9Z4yoCGYOkIfs7rd9iazItyPnXQN31d8e61AP0=;
 b=TlhNPP0n73ljbDHJOGLVFyhKspaxfNLk0jj5RI75XLQ/Oj1mA0F2h5tzcFoObNfazO24DdE5Ms33Q3vRUSctahMRLDMiD91xTBHtJBVDiW8H8LlPtKOa8cgE+vE20Ta88T3GHh305AvwU3U7W5Lf5CWrZeGJxkEgDmovLlNhdIRFsacy6FDKHzlHjhRToC3rs19ly6uud++cjXObnEro5EZ+szQwgrAk7bYyvhFhYancSmwQ1vQIFvK/SqADKrLt/4KrkY4FDF5z2pj3qXvd+3Lz5CR2j9E9YLAn7r4D2T+Lpbk+fFCuwTQ56N3tU0r5B3Z+BJCQIB67Xt9YXiSJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcTIe9Z4yoCGYOkIfs7rd9iazItyPnXQN31d8e61AP0=;
 b=MiBap2g3XSH4bqthHqCyhX4hvWvytIDyJawYbPXHBIcmcFJkdUORMAff9UYXVzOY0/RWiTwS2t9mr/8k8XFr4F2xFwt1rNh60dg4kzQHFvbT2CGOEJWGD41T/nOLizlqnDW//qkSr55qljY+12Sh9jj6mDzzxWnhChoV8w8IYRo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR10MB1561.namprd10.prod.outlook.com (2603:10b6:3:a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.18; Tue, 26 Apr 2022 12:46:19 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 12:46:19 +0000
To:     Enze Li <lienze@kylinos.cn>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: sr: add handling of memory allocation failure in
 get_capabilities
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilqwt3ml.fsf@ca-mkp.ca.oracle.com>
References: <20220413100008.522912-1-lienze@kylinos.cn>
Date:   Tue, 26 Apr 2022 08:46:17 -0400
In-Reply-To: <20220413100008.522912-1-lienze@kylinos.cn> (Enze Li's message of
        "Wed, 13 Apr 2022 18:00:08 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b00f9f04-0e6f-4e14-932c-08da2782c29c
X-MS-TrafficTypeDiagnostic: DM5PR10MB1561:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB156129F180693EBEA4FF54ED8EFB9@DM5PR10MB1561.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1W14uu2FgIeYQl0zmagFdRxNiOoidOqOUELKp5Oz3A2LZYk97Dqifog8RTYY8+MP48oTMJ2Ldj2s6mYbaE0ZaurJFmM5JeS+LdCeq9cia4RIakrFzbG+bd0PKTKYjvPa6guEUdqcDFPDhWwSFg9wNegbAoxeNro6CEPKQb3pXYEoVB/WZpYMNEcw8uJgdC4q9EetueTCkNG2lIIqthvsYkgnYWmleLS1xk4R23w+9nWXgtV8V9UsQt1Tg5Y040A52KuCsCFQEZRisivAvISsWQtzsoGAYC1y/VUfJmotnw8Qa2eLqhB3ByBXsXg/XMfnt65/MyZHfNJId/O0HPFO5xg2y/8QL8SHPOi8iqMy8IiNDVaeCcYRw1MkKv0pzdTYOAHppVFXuLtTFzcozFXmFIs1vxPhBfGMV7DHyS99884ahDNl353cLK0dY3i1jkI7XQ1CTpze+kqDlQNEWb5I3vwpzR/+vJdeGSay1YO1FJYz0ja6DEwciRn5hDMb58kCTQSfybR2aAxYYRAtA8jdLFat9XzbZYQUjroCYicnZ3esw+LjoeKVKh/fcYu1/02o8Zyt827xpe4adsEQ0v+jDvQwTF+YPxui7am/rInHqhESdcS3MnBdgEYUdaaD0cw+oV62vE7W2OEDDE7+JV7F4CB2DUfxSKVNjnfXeerwuk1zR7fMTmu8/qizGV4KKP559Q307bZHz70iiqQRY13XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38350700002)(38100700002)(186003)(508600001)(6506007)(86362001)(6486002)(5660300002)(8936002)(4744005)(2906002)(26005)(52116002)(36916002)(66476007)(4326008)(6916009)(66556008)(8676002)(66946007)(6512007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4kVjXCQqzhJfsEFQB9l3LqBh91ZH3kokSlkMNoKt9sqHcAuoTfW56qkftPTJ?=
 =?us-ascii?Q?FuI3d63m3A1QEpQq54rwfGQwU7bGXViE8LhXDSXJ7KzOzsfg+uYyrRkF/ksY?=
 =?us-ascii?Q?9lORi1vwbcPb9+N+yiV7hpkfcl2b4KjV6t85WrXnor0H5oK/tTdVxb763Kgz?=
 =?us-ascii?Q?P/bF/yPiJkA0dnSsmte3RfMr2FakCDRvMJT3wH2K8ib/0OVkLy05ptC0LcJk?=
 =?us-ascii?Q?oTJOv6Uxwyu9ZPpccsBbvEwgfuvlwiNRcWqP7K44KUM+rG1avQDy3xK2kgb3?=
 =?us-ascii?Q?yI6pRhbFvc6rkTBeez1+3p8hYY76YZafQGXkOzbCvUjjDHKc3LWDqrXpymLQ?=
 =?us-ascii?Q?x0VSckn/PMWfptLSnI8B4EbIaOZJqi1cQMIBtxC+6yn3tFGl1omgC+dRC0P+?=
 =?us-ascii?Q?Y+NnrMzEU7p0fvF4sv6EfV0h4U0nW4YUhnqn6LZvwpoyav8HCon54SbT7Fcj?=
 =?us-ascii?Q?dVI0JTDxpUM8W2YllCbokVLIKDFcoOnLm02tP5IKl61yFFhPuBEHTsKD6867?=
 =?us-ascii?Q?khMrcphNTq1OtzRgDQ42qNFeULnakqJ8GWWCGA175cB6UdANT5wXC/XT5Cuf?=
 =?us-ascii?Q?hoG4vev7CpyLbRz1iUb3vrJWykvBjlDS4JayFt0TQkHAYwQZhrlcJUKAsci4?=
 =?us-ascii?Q?KTB4hTtjfW8SOKddzCw9qLP/Wnqqe2rhtxnXq9RHfc4Qf256uNJyb6wSi9yO?=
 =?us-ascii?Q?wHSUxTRZXIof9RHxRKX/tRikD/lXO07ElpmVy9Si5oYgh9j/666SmWf+lG2a?=
 =?us-ascii?Q?/HiTXF3vX+G8U+BkeibkeJZTpj4x+BRCfQgBnezvL0LbTaBuuJokOl7edhqP?=
 =?us-ascii?Q?xX28KcvW3eEWo9041KQoOdNLusPpuc/ROtfhBFghplwB1KoxVd+DxMVwbKkl?=
 =?us-ascii?Q?EAudiZQpE7V6TC3DlepGWnhkVwaFNfeRMyLxBkoQyXzCNs69FL1XtgXMRf81?=
 =?us-ascii?Q?ZxqsXBN/IAumHUe1/8mkeLwCuAZYHxDg+dBncTU/2DGtQDgcSO6mjulIdmoQ?=
 =?us-ascii?Q?29MvtRVk8N2ezasz3SplsUdVNEXm9UT2gCdUBoXcvUad6pI8KBfHkP9NfKQA?=
 =?us-ascii?Q?HDv7hbzskrVwZqkQXjsdufsbB/fzUXrQn2yX62/a496whdf0W9YXLjV/fHSY?=
 =?us-ascii?Q?a/+DsTNVGLVSSeIaRJEcDWT/25eI66r/22WoowESubMLfFE0Y+16cL1Xehsp?=
 =?us-ascii?Q?eWqV+diukOPw67d5gd1WK3hbUqKv+dlfeck4a1YkAYG4LzdDBHx66DcP6gGh?=
 =?us-ascii?Q?8F+Zs/WYMA/U94IiF/S5H+5MyJdFlT8ZKUExEmtO6T4M+T+aSFgezLjBBFT1?=
 =?us-ascii?Q?6rgi/EYXHxXhWy2+nu8QxrFASRdhggp4oKDv3VYkuWs9FuQkUzJAdiec7s5J?=
 =?us-ascii?Q?Mrqhh/oKJv4M/oaH26IqVqVQrePPVHUksISVoCA6UpT3iBdh6ucMH9vpvL7T?=
 =?us-ascii?Q?BgHSc0dVqIP+hMthrFhjXNPo8aiJCcpmkuH77gw3hNwrheaJLijrZ0N60CXv?=
 =?us-ascii?Q?g7MLVgSBEKewE9XIVEy6D3tNC3s4mbVWXmN48OoVXx0q43zPKs4xqE3y6oao?=
 =?us-ascii?Q?3uffo4VsRPvM6+VwiZ/FHPRloTLGanExOdSkJEIgU9c0V4V9GfB760XRhNnX?=
 =?us-ascii?Q?hGzKJUtNGlsJ5nMcH4Kb7i5rckqWDsL/JW/PuAF3QYDL1LJyJrL1oB+qN3P/?=
 =?us-ascii?Q?RUUS5oJGHKVWurqUDArvHLfwYqCiL4av1kqUY91mSGxDCQVhmuSOMhQYIivr?=
 =?us-ascii?Q?oB8xF9qZDdTvkdF3OOmjWTot0RlbsPs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00f9f04-0e6f-4e14-932c-08da2782c29c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 12:46:19.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPTcH1xwQK4UZ3elB0IW+y2SZWbMtpm76rk5mcYwnsczq8KMtcUHUrE5jDvN54xdMPnvaMnT9MqPgxb0wvG7MRCRiowGDl3A2lZ1xKllXYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1561
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_02:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=874 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260082
X-Proofpoint-ORIG-GUID: pSPNX2ku-6vZGFUo6TZ5HoFktMrCDnRt
X-Proofpoint-GUID: pSPNX2ku-6vZGFUo6TZ5HoFktMrCDnRt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Enze,

> @@ -669,8 +669,9 @@ static int sr_probe(struct device *dev)
>  
>  	sdev->sector_size = 2048;	/* A guess, just in case */
>  
> -	/* FIXME: need to handle a get_capabilities failure properly ?? */
> -	get_capabilities(cd);
> +	error = -ENOMEM;
> +	if (get_capabilities(cd))
> +		goto fail_put;

Shouldn't this be 'goto fail_minor;'?

-- 
Martin K. Petersen	Oracle Linux Engineering
