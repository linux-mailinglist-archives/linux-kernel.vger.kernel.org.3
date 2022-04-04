Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6A54F153B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347933AbiDDMyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbiDDMyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:54:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A048627B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:52:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234ATZON000752;
        Mon, 4 Apr 2022 12:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=92mICdgQau6O4ZoTfuAaD2nB9bysbFq56gbRlPi6bOE=;
 b=fpFfSG7zruYBo4lS2hdZKFPt9n244l8o5txWRm9hTx3tJ+6jyaFuVTKhKhSYGOGRDn51
 LeAv+ePXlrNo1wnugLq0NafmDd9vaG7TaD+rq1gGHOeJ6QooF9Yo8/HFxTyDSZJGmQox
 ZWtkabcsCdo7XAzKXAUVT0/paJDYrxBWX965ABeieMFpGJQalTGdhRoerE2pVamHmaeg
 melBS5qtks61yufnHXJixsWG1XGAJPfZY+TRSUwyH28dKOa3jyVPNb9xbhL88cECx5gt
 JqHngV1NmFZuGbzZ3CNeKWsJkoA0ozr9hk93Xq2vSlzRrahSvHpW6iP2hKOJykieysju 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3sk1qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 12:52:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234CqKwu011681;
        Mon, 4 Apr 2022 12:52:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2875h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 12:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5viW8uv6lgsOl1zwqd7CMgisHmxVmydEZHsUy3MlNsnogPCw+KbewWrgW6fS2XMhWSvnMq/dm9mKejviQFQobzYC3gXWyIVsHBxfUhur0mRiNDJLrPIKI33Yz+/RcDxX9tnXKJRIdc3DQKS1rNB+RD9CpfBDkxtCiovR1hjiT8NTRY0M1Y0XvFh7E7S1m/7fQG4OOv8qUVF13dvpLEAtuDptTrRGD95bwOXMigPxaXk6urWjUDojxZZVcjqXwC7nadFBkkAaUPyWDyxbx1DyVpgCUah0kJdLFmEyekRnE88Wk7vz1ZrEuTPv5v8togzGxEMPplAdXxN/ynX8QfoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92mICdgQau6O4ZoTfuAaD2nB9bysbFq56gbRlPi6bOE=;
 b=ceJZxNr0gGaFqN7EMG9g01KR/Qp/l6PcdrmvPerWA9HkRn1ttry9yUt+0eSHxspCeQcjhbR3L9Fz5qNfP2awZhsBPBQKqG/y5oOmvQ/5PwpxP+24H/RVzm9a0oqN35Oc626qEm79TnXzUHyUbr6EGKfg6TwZnbmfsSs/Et9TEBZnok31sOqi7zwpTcXJQPHkmH94ruyfwjT+xgqd3KkOzS91R3JBqdJ7e7OHi5CtSvyoFGzMxaVCJ7ITBYFPD02TyvzG07zNAhSpLME4zvOgDYsFDsqf5yMfBG8dc3doBm4JPSD1KUcEEiHRKv6Am7JZHf6OOxwjTfET7OW2Pf/M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92mICdgQau6O4ZoTfuAaD2nB9bysbFq56gbRlPi6bOE=;
 b=I8vNrY0b/kO191FuamEBgTUVYpL6zvLh/9sW/HNNyhvmnfCHbwjkQG8VE05R+OBDpLr9v3Azv3kQFsuIu8LIwHX8OlwBuOO/x2QLtRccSy2THwNSLPMcD7J0kkATxbJdHcIi1uGIoXu28P8AETqobc5gtCw4ifnRhjAS4vG0Vmc=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by DM5PR10MB1993.namprd10.prod.outlook.com
 (2603:10b6:3:110::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 12:52:16 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f%7]) with mapi id 15.20.5123.030; Mon, 4 Apr 2022
 12:52:16 +0000
Date:   Mon, 4 Apr 2022 15:51:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8712: remove blank line after brace {
Message-ID: <20220404125153.GA3293@kadam>
References: <8c88829f625f9847a1db18fe467399594dacb064.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c88829f625f9847a1db18fe467399594dacb064.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::15)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 204654ea-a2eb-433d-1692-08da1639f25f
X-MS-TrafficTypeDiagnostic: DM5PR10MB1993:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB19939C1800AC94CA08ED96CD8EE59@DM5PR10MB1993.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAX5W4nbhSQpHmDgidw6OEm+myrtfUivyfMQH6WlZeYbh0Oz5LIvW2qwZ5/4cpPGv83UL3Mn6q1BE9zx8dyhPkIs/EcXziczjLaBXTCpEfCCxnfsc7Oh46DN6YboH+Gq7QEknvCJEx4LSSORgPaIC6CQUlr1tMTO526Oc0AFqrrotyPBFqgn5ENenoCukwn5C02NBdu4gqInSv2FDsK2G16N3zQNL4xpED6oN4MDYq3BydsaqTDvmIgXrnUfO9Wj/Av7yoS3Ngz4x15qG20CSlX2xXqPAoaTYT5hJtzZ/aJecg/5VnMqHNOXYlKd5JZ9J/yX9HPWyW8afLE1yYzo1lacOqOayG/KItISdf78oz1EOSWk1vHPcqNgTReXLxpcUQfpU+cADodjB8Ky7fcgVp16YaCgL9PGqY6XeGR7Ux1ruX5qM6kRZaEBWBdwjp7tBsW7P0hhlXe6vjcTOwGLTUE3DZluqd5xleqHfGIM/QRaD2tUe9cLr0nGb7utXd2tUxbuEmHM91mC3Wb1Ie04J6js6bNIOARiuRwENMWparuBiris8A6L5RYjcXcrnLWCWDQt4x63rQUW7ZcDyGg0RC9mYjEBFWtIT0Eu6LJG879uH9L0XCtqzFKjJ7l7vl6zC9cI1Ke2f34/4KzqNY25vu7GrurMGKfeRpes7paOBE6yWj/2BvEy2L7G5JnKFJxcGee/K0gLD5kFI4dn7Ik1KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(186003)(9686003)(83380400001)(38350700002)(6512007)(8936002)(33656002)(38100700002)(33716001)(44832011)(86362001)(2906002)(6666004)(26005)(6486002)(316002)(4744005)(5660300002)(66476007)(8676002)(4326008)(52116002)(66556008)(66946007)(508600001)(6916009)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eh8TbyECPi/SSIJbPNzlVmZfPkp5Xt+sNAcWKl8h9u2LQgVtSTZDJ/2TGswO?=
 =?us-ascii?Q?ad1Mrwyc+JAGoMsAU65J8ofasENQwhck63SDRExRVe/OEh9C/0SOtpYw9SGA?=
 =?us-ascii?Q?xB9xHtxEvZkB3X6vHfmA14GAOpbXYG0HetaK7a5T6YWOuuAvQhoubedL7Qmn?=
 =?us-ascii?Q?QZLWt+hlp7gBM+nxrsoqoSe3J6xRQWxWxjOCsGYXlU7Bk1GsBmsx9NVSijv4?=
 =?us-ascii?Q?ZVX7+8c3tJf8CTxzNO5hVNqJEhXAHxGWV2y8KEetXBrhTr2tej9zp6b2u98P?=
 =?us-ascii?Q?CbOKMBEMVLOKqjyYf2H+I+2zBx80X/hxAiaXrFCsdTG7AMXWfI7GVxSEQ00B?=
 =?us-ascii?Q?pDV0iYsbrPD8q5RPLLu5h9UsI9tW+twBd0HM6C3PjUfHGIKw7gzybVaDKJVO?=
 =?us-ascii?Q?8eNyOphbrW7ffkJwhqbEE/NDfb5E4cSroBKkyc3o/0AGFk9JXmTZii/Bn8gp?=
 =?us-ascii?Q?DDVxtynUmet+Q3N6oCOb1wIwxdi+RReCFruTPUAxw2DF+1obeOT+gxTcuquj?=
 =?us-ascii?Q?ebd6jop2BfGJfqYbcYGEPueDScayZ0ITA4jTAl+JjvlR7rm4EHDbcV4MiIXU?=
 =?us-ascii?Q?5XP7mP7Wgpx7fgrebJSaIHf29s2AFA1BPPyaUYX0L7Vm+vmzo6CkySr1Fh9m?=
 =?us-ascii?Q?X92ooi/oUjViCr0eATcdVBF02Y77qLnwsh1oUAv7BtcX/4tIDl6L1CHYmEnR?=
 =?us-ascii?Q?178wXMJNXpDtWZA0qVB3b1yWSWI9p47tHmCiBbWBVn1VqZiPOt3wOXiBD3M5?=
 =?us-ascii?Q?Rl4yQIT/Ya64+AG8OIcp64HREzOb5Uc8Oa6ycBriPc+3zse+o6qfW8vxMbA7?=
 =?us-ascii?Q?4jsFnXCZOcgNp7J0VsK+oE+O9Dv6ewwMEYJ587kWXKWmRPsAdu6YF0x2CkGb?=
 =?us-ascii?Q?H+cBqEcT/3mTvQAESyw09e7BhKoxDcT3hJ1Osc1GCQmemVtfUBMuBgOIxIMu?=
 =?us-ascii?Q?yqtpsG9Rj4AAxYFwTPwTICwh5vQHQfvwFKALQknXT542D2m8/1FZYSxCs5k2?=
 =?us-ascii?Q?ktyOpx2hRiQv2n+L2zDrLxncFtao2u5deBvPlYHIX8v+ElbWlplh5XLRj5lY?=
 =?us-ascii?Q?kNYQlAU3vP1aKGNCIqAaIN8ITl1cXWvcFPBpWlgPtyCprs5eIJHvCQE0HwNm?=
 =?us-ascii?Q?vuCbNFNhLZgHDjpg2vRfVnu6lI5p0kktRaDhPVfrbKMBaYx9f/gz6f0Oy+cR?=
 =?us-ascii?Q?+EfAa3CybOhGI3TJ91iVrv4/a6lcE0hY8KdWy1KNCbckbk8z30emcWif09jT?=
 =?us-ascii?Q?d/CIO5m5X31AVbS3NprMyw58kSuQBmKoYpoNTIi9++pYihQBIzHV4FjnHsb7?=
 =?us-ascii?Q?UkjfrNQ2JX9HRjUKClfEqS0L0OKiURc76CKN4jTIH50YCTK9rlT0Dq//zy+Y?=
 =?us-ascii?Q?i0crYT4aVTvhVRHNQ/upGrp2PBfK7LOBi6B2BkmS9zcCkBi6052LJku9b6Fs?=
 =?us-ascii?Q?TFBabmikdJO+DwOdojgYkyDIrsbEq17whGSkWp99AzwIWL4YxVCuwqFGs2ZC?=
 =?us-ascii?Q?3aVewSdAuIDe3qSuwFcfhbtO7tNRFojoCLTBWgsBQ3cVDgDAINs06EkVvxOi?=
 =?us-ascii?Q?HrBhOaO18aWP5ajI1gqA1c3JTLfkCm90LHVylA1FKICHQNPG7M0pT9NNm6fx?=
 =?us-ascii?Q?aDiglK+j2TEfxPJoTQZTfZtYN1tp1P0DsLcE0Cnf0xT0y0enLlM9HaD32Mmm?=
 =?us-ascii?Q?edezDd4pMkpbq5sB801Q3nEBpo0ZMjWOI3Z6I30sYbJMwNPTJeGy4kVUfzrD?=
 =?us-ascii?Q?LAwr1eGlKD4xHnu5ndYo02xTEzteCnc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204654ea-a2eb-433d-1692-08da1639f25f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 12:52:16.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTSnmSzqCdw9Da6ShoqmkGiZei+j8LfsOe91OLspoLwsbn5z4QRwiWgvIyJ725hchs1XiTGdJTWvywzb/QPyqOtcLX1K9VGUFVTKEpD8FwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1993
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040073
X-Proofpoint-ORIG-GUID: lHLT380eRvTZ9gEuRHmppSNGo43mx6EX
X-Proofpoint-GUID: lHLT380eRvTZ9gEuRHmppSNGo43mx6EX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 02:28:16PM +0200, Alaa Mohamed wrote:
> Fix " CHECK: Blank lines aren't necessary after an open brace '{' "
> Reported by checkpatch
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl8712_xmit.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
> index 84a22eba7ebf..05ba0ca7d627 100644
> --- a/drivers/staging/rtl8712/rtl8712_xmit.c
> +++ b/drivers/staging/rtl8712/rtl8712_xmit.c
> @@ -147,7 +147,7 @@ static u32 get_ff_hwaddr(struct xmit_frame *pxmitframe)
>  }
>  
>  static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
> -					 struct hw_xmit *phwxmit,
> +						struct hw_xmit *phwxmit,
>  					 struct tx_servq *ptxservq,
>  					 struct  __queue *pframe_queue)
>  {

Try be more aware of the surrounding code.

regards,
dan carpenter

