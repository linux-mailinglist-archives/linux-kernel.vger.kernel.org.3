Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67B57D752
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiGUXTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGUXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:19:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CBA8E4EC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 16:19:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LNEMEW031962;
        Thu, 21 Jul 2022 23:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=iEOn1nyQUomNd5Gk8OwJdl3dWEKSc0vxjBQH935YHeo=;
 b=nYOYB4TbpZsWEngRv8f/IWoV0N2M7GYh3FBo1O87rSLlNKZtBiA4bc8ECTTmtIJ2I5Uj
 4LyByHM1HmDowilkImQpKNJ3MWjPDHrw0JnHUsFdTW0ZJCIRXm0x+6oT6VwkgKbCwjTN
 XL6J1ZgyuowqH7MikZgVykUVKp3UoYp90lFK38E+7GbQNE2DYxSVoyGik3Dze+6sMXRv
 2OcreC01Pvw4adpCvqOG963TPIbnNAot8J4Oz9o0++NtGGChxMQoHq+96kA6wh6sftCl
 pyEd+0Xpkd1/ZnGU806gNv/pFlfFoCWLz24BN1iYXikmRXECGIZBqxwwdDSilChkSxnc Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxsdxr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 23:18:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LN1FqH016382;
        Thu, 21 Jul 2022 23:18:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1eq5sca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 23:18:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRFafdvJXKhL5Ua0VtvLGBp4s3CBml+YaA1LLRXtQmNMLvml7vnDw/VYT1DrfiHb9IqJHJ86c6QDo5JPTmMB0JAVeMktE1H014U8p8bUJfvmUUB/oFUT8ntpGT3PbABTq03dQV5fkrll1YpwX+JyINh+V9K3AXQ7md0mJDUHHjJgns40X92+AYQXsBPlFhcBPmIzFHfRtZPh6HT2Jwj5PY5k0zzH2ujyIsqrRDHHNjztfIq8FjBCridPiVwBVeDwKEBIk4pP/tV0tCd2o5vqgXw43uhksnrtzz7WrefKkCGDUFUUbaNBoBleHwGo87gC/3K8u/BzHp05rUb3cKGv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEOn1nyQUomNd5Gk8OwJdl3dWEKSc0vxjBQH935YHeo=;
 b=i26Psm147NC4vMEC8pGO82s/NSRZVsCTuZrCMY/eC1sM9ahsaPLTux+CTOPR1Vl5J5vYmhA7C3rzJK8Hj4CQLj7PkfCVJ0YO3M9PqtzrRUqgcMVNGp9kHzuelmeSO9kipOm2djtc7833A5ghUG+aV5tnN/1+sfl2QQa5RRqCj5CWvUz0YAW8JCHECETIvl0ClojEq5RPpCN7qKTRnLQi8oxE6cSoqWwRj/vbMGu8tQGqd1xaU2L6rtjgBogIOEoyS2gJHpgEwWqrYVgKjBeUlkFMYqosuoUuAzr2FaNDdalUF9dOShxZqVWFCutdLdc1rAwsSvPbWXTGuwqbkSkOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEOn1nyQUomNd5Gk8OwJdl3dWEKSc0vxjBQH935YHeo=;
 b=m/tn7XfddTvy69MNLR7zB955BeFPohBF7dMMbUbYIK4ou863Qjv6TJepEpqpziXjBIixRKo9z2s/RLXuDb16K0PuYbLGSYaTbBkECSdaRwnFaWNCQ7yegjNxmsLdHR9GmEIs7miPFJ5uRLlIr5lnWRJZKmVVJwv/S8VRJmDbOEs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1944.namprd10.prod.outlook.com (2603:10b6:903:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Thu, 21 Jul
 2022 23:18:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 23:18:49 +0000
Date:   Thu, 21 Jul 2022 16:18:46 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] hugetlbfs: remove unneeded header file
Message-ID: <Ytne1n5qP3ZEyklB@monkey>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721131637.6306-4-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4PR04CA0209.namprd04.prod.outlook.com
 (2603:10b6:303:86::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c67dece7-6275-4b59-89e2-08da6b6f5e3d
X-MS-TrafficTypeDiagnostic: CY4PR10MB1944:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKtvQdVdUGjrR2tDAdOUiJSeqz22wBMGhAWnK2pSDWgjZW0He8EvtBYn0MjIPsWvF3b/cdhbLJ0lKMDQOJpXaJ8ZTk/b57zM9q92rJ3sx73bPPPz189LBDNcLvSOc13zJx5WVVUUOfGUYm0oh8senXIfOxVGUEoBzERBzIHyV1P+NZk1N2DcppGjWgWcswRDTBZx4BO/oSPJiZGRIlVdUWfPdCfkwDxQp0uE363aYC3bUPDzl2FGIuCuMNMVTNk/odoqZkNHzlW0CtYpSf/9PU6ilXHJVN4bydkXSN5Nx8bWjtdnDj1KeslvuQ+UaP7whsC8xqj8yazNytynOdd8DtgPzzmpDHqTkvGNxOoFenUVZftEFj222NGs6ypKeHgSlq/UX1fMIocohE8DeJ7ZEujpozOqHkWkKB0n/WrCZWukm4oBgcFcUiepEglaqSJowkh+zUo5Ks+cSAKqAgQL//CeIE9f1LNmbZHsPC0wTs0XLPzcnzjgR74qNYO+qLlgs/i/J4dIJw0KG73XzOFgZsaM9bCh3Mltnt+gv9RuHakApHtVarXMq/KZWcaKRuAPjKxYNMsZ5gk1sQVfxZ/qEEMqeBkQz7kckXlGOuCO2mrfF8QKHG6sKAHu+zzisrQYK2dbcMxJeiO2rzOGHJ7KYC5K86Gkfm6LelYIJuVaXWOvsH1xC41ZbjZOUlV3mtB1jJ+g6BTCQhrb+BaEo6GuX/SgfWIqnSCpUAcOzRdB5DdkBl51jjPgZSJozVs4Jhy/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(346002)(39860400002)(376002)(136003)(6486002)(6512007)(38100700002)(6506007)(6916009)(9686003)(26005)(186003)(53546011)(41300700001)(316002)(44832011)(5660300002)(2906002)(33716001)(4326008)(6666004)(4744005)(66556008)(478600001)(8676002)(66946007)(83380400001)(86362001)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fme/D1VMIdWVRCwhQR1dNw6mwO0OgUVE2DVKCK/nOr8oUS6gNaeFaooD1IVW?=
 =?us-ascii?Q?Vg/eHRU2ZxYkMoFTM6K9nmBrdrHu567NuaSVSARwFHNQl8oqxabUD5Ywc5Pq?=
 =?us-ascii?Q?Rof6h2nOmfI0Fm8rePLbwZAzhvrV/bsricIHH7H7SnnHSAfF3ngeW4OSTtTq?=
 =?us-ascii?Q?XUxvnul1cq5YdP7xaBqq7F91alZcOfulZ/xTbDIon7BY7U0RJI2JM6U1Xbvb?=
 =?us-ascii?Q?hXV+IsC0NEwslyFHkP1gH4Qixzq/B7ypVlV8+BsjpQHZ/SZznndRGKV/BBtS?=
 =?us-ascii?Q?4u2nnkYCz6cAfkDaKLN2QALrh+SYs/fK4ONQ9J7Qzu7Lqs1CqagcIG7Zd7tR?=
 =?us-ascii?Q?iEDEs+D7Fy7MmP4gYpX7g3sIPFqb4MO/c+m4pZz0h+CCamGkPrTcYCaR114h?=
 =?us-ascii?Q?EnfL9Fc9BzEXBSZsAVdaKoQd1XzzgddwAyaqnqNdrwpe5h0lDAYBES6g4qaT?=
 =?us-ascii?Q?bgOAxzmytQiI4NHDb976Pmam2DbV0a7c51AVwV7I096qQnrGco86PHHuaDfp?=
 =?us-ascii?Q?4O7LJ2NMeqI/BMv3gJ3S7geARqAcw8xfcF479cgvWDPT+zcOF3Z2A4XrK1ni?=
 =?us-ascii?Q?3rN8158PRNYkHQXjSMnvDZoj/mtjKHGmDT/hMZjf9Wg+N+bZ0ADdkZEp0XaI?=
 =?us-ascii?Q?MOMxiLDUBxuAkxsdHuovIW6qElry7SatV7m7tug0kDn2WUHuudSplml1UIAQ?=
 =?us-ascii?Q?rb5NAi++8ZsSO20DOsqiVwaWPUDlRAa0iyy/zArxr/gbMCfGGS0iv53fR456?=
 =?us-ascii?Q?KgH1hFHtC3fEBjMNBG75PS6PimsNpzyY41B5LXN2ice2BdmQZU8Igha5XwRP?=
 =?us-ascii?Q?C73npTHyGYqdr1nYqT0mYEmCn+jI7X81U7vVuRSRHkZm1T+0y3zlTpi/DADP?=
 =?us-ascii?Q?O3Axx9n5k7TCi5eLKXREsx/KveMj+e4LMUMh+ib78sWYB//arKiG/1gQrczH?=
 =?us-ascii?Q?rrZp4UcuiOONl1JgTRwTdRGmb/yshA1AnzNNFZJFRZyFxsRS9k4z2LBybacE?=
 =?us-ascii?Q?I850sJGZeypg0TTjDGlGsJlKSPtt9cNo1GWwwHcyEfs3Ehw4a9zJdIHRjaux?=
 =?us-ascii?Q?o79pxWbucvykwkhW7zfpKMBrqnR/dbk4kFqf9kVEAHg4Lc0o++Bs7Rlyq0om?=
 =?us-ascii?Q?8ATT8pyEigujVOuN0QR5TcF3jcVbE3P8rdoPOT/ftZxDP8ichzl7hAGxQLCm?=
 =?us-ascii?Q?6/hSuMBnx5hf5FU81KJ4qG4NlupCNKbdA9tfiiP1cDxGpaJp10PO3iB+VriM?=
 =?us-ascii?Q?eq+BsB2jQmqO+ha/MoJ6HE+NwRj6SmNiw2cXWk/v+s51Ixxy6Raw891Loa8I?=
 =?us-ascii?Q?CNWWCSWvB5oE/0wGWPANn2AZfy9s6sDtuu1y5xJdodq74KvA/W91vWLQma+J?=
 =?us-ascii?Q?Nyh1pnF5krQ+zy4xIZEARCXdpabWysGIUBg0YHuHqfuLsVAjAR5EcdVy9NHj?=
 =?us-ascii?Q?1grkuYay5PsE8A+uhRZt+Jn6HX1Vd972Bjdog7ZlH5u7ts+NKPitU9mWJBqc?=
 =?us-ascii?Q?B0xZqjPzr7TdSybeSDbnu1xoBa1pHGXi63S2YUDYVPkbqod8gU6GYY5q0G2m?=
 =?us-ascii?Q?2eG6s+2eU+CsqiNAFXdGO7g7fUlNLk0rFxnSS1M3mmC2zUxh1KLeDNPMrxkk?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67dece7-6275-4b59-89e2-08da6b6f5e3d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 23:18:49.3917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XylN2fKfBFCbtKgsfiXDLUlHZ0k9QfSZ/UOXjhgn6SNDrsd5IKnR2Pbs55RgAUe1kLIjZUomPIdbNCf58JrarQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1944
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210096
X-Proofpoint-GUID: IQMsPhcUWPDEBB_wwweuJkfimH1mWs8O
X-Proofpoint-ORIG-GUID: IQMsPhcUWPDEBB_wwweuJkfimH1mWs8O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/22 21:16, Miaohe Lin wrote:
> The header file signal.h is unneeded now. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index a10156df5726..aa7a5b8fc724 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -11,7 +11,6 @@
>  
>  #include <linux/thread_info.h>
>  #include <asm/current.h>
> -#include <linux/sched/signal.h>		/* remove ASAP */

I see the original '#include <linux/sched.h>' with this 'remove ASAP' comment
has been there since the initial git repository build.  No idea why it was
originally added, and can find no reason for it to be there today.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

>  #include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/mount.h>
> -- 
> 2.23.0
> 
