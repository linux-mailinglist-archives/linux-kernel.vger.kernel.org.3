Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5344ED7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiCaK3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiCaK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:29:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161531F89D0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:27:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V8WVv6027875;
        Thu, 31 Mar 2022 10:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dOnJhAVNp/pmrb0Q9kse78hQo3TEnWUz8//Njg3/NYA=;
 b=C1BXJxO8lQEVvlA2uM4FF7Vu3k9N0W3gagcwqWf9tk7GRb+DoQ6Qpw4Mwglo2r2afytG
 /Nui0ZZBzZMJoQ3FSk2qdlr87Y1lSzLR9ksW3SoFvWamIb/R0geAN3JGZzpQleh8EYOo
 iRBlr42WQca3/NljGYuQsyLEyxDdkBjm6ObXSOTFpGvhPrpQxMC4WKQB6Z+tTA2yT0bD
 TFcLKr97vOAeRLwWmgPSL1SKtUX5ijjzKVtS6QcGFu9OXmEbtG77hC2wbpfzkRlKZzoq
 a6gX159AhRfVqp2Xr+7jFQQ1q3qVmcqi3nd3dg2F5PjGlMPJwZKRcWv+cBvXThqG+WkB rA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2m011-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 10:27:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VABbUG033697;
        Thu, 31 Mar 2022 10:27:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s955mge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 10:27:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2VEhP6bjX+MF8IkgFNlXyhXghIYOy4s5h/9JFAcL1guRHnIrpviwO7G06086JhJwI3pe4b2uV3Oomis6N4U1mFb5izsK3RuHHLm+otSaqF/W3rGGCvUtff5osGWvwqESYPLeGobctcaXwJy8vFu/E0IqITHBj7QwitZbBIWOJQhyVZ7bMMNPtrjAJUmR5fpM+ZTkpLehD4Ms3O/rtYIQ/Hx5a7DMlhZHV5nVzqlwV7EU9i3DErryReom7Jm+ejiEjUXWtPtkWeFdvscU8YKsCcMG6TxObzl5sLEZSUakYx00+B5zUYf7n/RJUzNayZZkfYcGC/vNH+00nAupkQd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOnJhAVNp/pmrb0Q9kse78hQo3TEnWUz8//Njg3/NYA=;
 b=eyx/b65t+D9ycGuix/UTm4J8f8UBGzwSIGw3XB35suuzVMvZJIILj+Zm4qTCU43neIoziB7wNzOs/sAhBvRT+B/kffQ6coL6sFtq0xAEdmnuZ3m95HLjaUDMRYRpmb3XoQ7Pjfy31eNs9ce5OfoamzsTgj434ZZ8SPlmfmU/fgfwdXvJ085eEmkNh5H9lLP9QGClz/qWegGBPfQA7r81J7+d4xKgtNTVKHFRj+TzaU17iZSQnrYLb0runY7HuuualSM5RDJvftMSTxUgr2FjpEyiM9Xa78MLTP+jyttVKSjvtG/s3psP51mBZP0sqIbywjPfv+prYSxWq5i/gh2sFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOnJhAVNp/pmrb0Q9kse78hQo3TEnWUz8//Njg3/NYA=;
 b=dJOX5JACgcVp7RtyNxop3A6rC/S/pr5BV6bZMBom2gC6xJILndE8E89WqBHrnraf1FwcnssBOJSmv5/R+4Yd84fV/0ibW9gwx2f+wwBBLOrYk/hXXGMUEKqfzVdQPVldNIY4r3VTRJwW1lAYAl7kH4NOOX8O9SK8qJ5h+pSvruI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3703.namprd10.prod.outlook.com
 (2603:10b6:a03:122::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 10:27:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 10:27:37 +0000
Date:   Thu, 31 Mar 2022 13:27:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: Fix Duplication of Side Effects
Message-ID: <20220331102716.GL3293@kadam>
References: <20220331101849.71046-1-eng.alaamohamedsoliman.am@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331101849.71046-1-eng.alaamohamedsoliman.am@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 551037e5-eda2-4e7b-56eb-08da13011350
X-MS-TrafficTypeDiagnostic: BYAPR10MB3703:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3703B66705A4F5119C4CD3488EE19@BYAPR10MB3703.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMtILlN5FxuAPv85+0SdM9bV80ZtPRefH3UXiNjs6I1QiBEL6CIXorrlKlPGKJatGhdBCl9e/rtZH3T8VyrT+2rB3ywE18nxg+c19Qdm7GnABZCJtgvpjQbOSi0xkD03O3VEMvMgzGzuCQLFTSA1bTcq+JHkP882cFJ7Y5GOU9tL0leTdatkHRXG8ygT8YGZtpK+MpUQeA/pqV9MKFHjuSMqNNARRCEiDEQGe4Mfd/qSSmMoRGsUupAef5JLhCHE2YM8E+kjGdMzqQ0ZoxrHcNGWVabedkZgU/T53iwHopKNFtdiSEfTj5e8u4athKdmhqU8EvjZxolBOddTJc8822YGsXnAJ9Tw0ucvyzC1cTmm0OGI7Gb6KucmsR3ZOoY1FKhWOhg5MKwzgJRdeeQj1JWiXZd1tOovmNJELzCzxWv3y1jizI2S2gthnlWbTIl2Sm53T1ZTPFXUd0Sqfa2ckJdG6dro5qdnom/0hBt/x5FaUvYs8Bk8Afw+mVwstDkeqRZk67CzQOsksRoUX+4rBmvtc1wwVajioe6LQ/KCDxyQDlkQABdEthSXMJvesipXgmHUrK9ud/eriVJPGuluRuWCBCq0nW2dSrYh2n3t4dANHtlmgU5eaLhpM2Me+xEz/+ZlslF+3BRpiEO2mBmkxuoFtUEQPBNb1HhhxJvILT2+tUljqOjxP05q3mgkD6APjMIEEoPnEe/HxrYR1pdWF9nEUDPSmwh51qJ76BOTgvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(186003)(52116002)(6506007)(8936002)(9686003)(6666004)(6512007)(26005)(2906002)(33716001)(4326008)(508600001)(8676002)(86362001)(38350700002)(5660300002)(44832011)(38100700002)(6486002)(316002)(6916009)(83380400001)(66946007)(66476007)(33656002)(66556008)(56340200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ai4WAFNLHHNni4hWMI/Alzdx98GUQL32DHQOmgH1jcD5KoZ6ceW+fpg+NVzI?=
 =?us-ascii?Q?VegiBJ4y07w6Ry1A4jD5gbNoGrro7yJwiGY/+JmuVZ2dqx3J7+UreKX8tay4?=
 =?us-ascii?Q?oIpolciAa1vB3JJzn0b1eIRUgGsik+C8UkHQWfryB+gRa2yTs5UMGOv3CuQE?=
 =?us-ascii?Q?va4cVSIUvy8AkRhKU3aqjNuZ70DLnOx5LHYCUa4LmjvAknElQPcx2wDcgVPQ?=
 =?us-ascii?Q?PBW3aPKctVLP+6VmU8deXnWm9MFG1ZjuF8/AIQXpmS9BudBZqFkoDg+o54CC?=
 =?us-ascii?Q?3J4/C8l/iHB6JZCw4loTuwjda/JJr0It85QjnvhDHtwapvuAbY2ZnYe6wvj7?=
 =?us-ascii?Q?wTSMtALUkmGTYpbfsRQSYjSxYwBhhKDXDgUg1V8z5vp/4uPBHLEMgSaYt6yy?=
 =?us-ascii?Q?9OTk6XLgD9qMBCrcLTQxCi71B/fnv1G40F/ucrWf7m1ufkbvxS1rJzEi7Ls3?=
 =?us-ascii?Q?G/f4savZXEZpLXgVPnQyOD2bOwaCZyXNcln74IPhqby0BM1miP4Q8+GMn+kR?=
 =?us-ascii?Q?xRcPKxuwrLs06e1Rv88pMZiPdvBq4elHpkMn9R2lc6926vy3e5OZQv8sBkq4?=
 =?us-ascii?Q?cuXHuzxeCHaSMXmwW4FvkoSbD/h4Imho1r0z71+Opc8/EQ3Y6WaQXFXVlLDQ?=
 =?us-ascii?Q?rgavrqiREq62SDjT0FAXBt5kSrvi7SCrDYRa+7VLS6RAkvLy+v8qRJw7HTQp?=
 =?us-ascii?Q?yq0j84tUzirimyzK7cEFx18RACc7spvalwY5LGXSr5ysmdxey1eznIVnxnro?=
 =?us-ascii?Q?FqPqQss8HycKgfl+HBRdMrmLbD3dLz3KXm6NFz8amAoKaKFKS/+//+lV2Ucv?=
 =?us-ascii?Q?lT9d9blgKH61ZOt4cpHQPNljbcqFhQAwG6HGePCCXAHo+iIqZVdMBeeNeWJo?=
 =?us-ascii?Q?LFHw4IXkQRtFuvYBDqsQN2Pgv2P3/3bOcJuprH4sMtOrDv2tzEyWvEv3MPwj?=
 =?us-ascii?Q?s81rjAIUQWS3Q3Np+HcxeZSmbMaBTWQwbdfpIr95xciRz+QkBMfXPM4PMYUn?=
 =?us-ascii?Q?tpWWBnRoETjyigM5Urow1A0z2M1TuoxXHl+gv1J9C9LT/5/X2dpx1odxrFhQ?=
 =?us-ascii?Q?beBNpvpN6Fxet40wk8E+tEdAjmFTxFYHVnRHr5rVO5zbFh9aqM/QCP8s++lT?=
 =?us-ascii?Q?VCdbfLREQwlFVsmy3Powg2BF3a51JSizpjoBw/UzMG+/GfdFQgLEiNGRFenp?=
 =?us-ascii?Q?JDSOYAj0sErGuyUjCEfj6WfcCvBaL/GRRU6o8JHi6XyiKKCNqkoWIao0kSKa?=
 =?us-ascii?Q?gLkjIjRxlZkXhPFp6FFY7SustHfX2/rSLi9pPJw+M5lm9w36cOHBdzG70jnT?=
 =?us-ascii?Q?7JWnf8l79ARVkVt+7kOqwnoM7iuN0bWWsqcU6UEUPiH9ZBIKMf2nwy8pHFcL?=
 =?us-ascii?Q?FQYx4CZsBrflWrvXmKaDymtrQMp23VNR1TKGeOhG1UKPX6pn7owgFyVY81Po?=
 =?us-ascii?Q?RuifFMs64uKabAB1VbPT7PkOcDgj7dV8Qe5jl0fdxp0U43wpj/42SvROmU7j?=
 =?us-ascii?Q?z5DsXUYYoa6n3PrhPo0pGGwdX++7Z0XBUETnA8R89HFAYV05H5gmRidHo75/?=
 =?us-ascii?Q?o6zKrTqRJWj0IL7ZsXga/1rjQKTk0pJjhw/z69096SsgDjU41Wseh8r4BTwi?=
 =?us-ascii?Q?b0wT80k+qlTwakkV6tegFfCPk+hhZuezHR7YCRXA7aVxIpqSaiyOlET/M3KE?=
 =?us-ascii?Q?4lyeJDR3jM7woFgD0fQu0Joe3fwwaIOYLwreIr4jeqKQFll2uYXjgWA9ynG8?=
 =?us-ascii?Q?IKKfogGdhzh9wDNQlvJzNzirTcsPza0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551037e5-eda2-4e7b-56eb-08da13011350
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 10:27:36.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKZPm6JUHpuWr63V7bcyDO/9UmGs+PZvqklwYp+4OfH6vUHnsX3qz581IU3sF1NrMR/tfwgeGJ7bdUWLLew/N+BELHSafFAYAhyqaFHQG8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3703
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_03:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=965
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310057
X-Proofpoint-ORIG-GUID: 6pwvPlM846Urav5NDxYXfGuhLBkLHemc
X-Proofpoint-GUID: 6pwvPlM846Urav5NDxYXfGuhLBkLHemc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:18:49PM +0200, Alaa Mohamed wrote:
> Fix Duplication of Side Effects for GDM_TTY_READY(gdm) macro
> reported by checkpatch
> "CHECK: Macro argument reuse 'gdm' - possible side-effects?"
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 04df6f9f5403..6f0274470e69 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -27,7 +27,9 @@
>  
>  #define MUX_TX_MAX_SIZE 2048
>  
> -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> +#define GDM_TTY_READY(_gdm) \
> +	({ typeof(_gdm) (gdm) = (_gdm); \
> +	(gdm && gdm->tty_dev && gdm->port.count); })

The new macro is uglier.  This is not a real bug and there is very
little chance it will become a bug in the future.  So it's fine to leave
it as is.

Or another option would be to make it an inline function.

regards,
dan carpenter

