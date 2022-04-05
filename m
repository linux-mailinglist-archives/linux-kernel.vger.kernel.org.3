Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF014F467F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbiDEUd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357329AbiDEMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:10:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675D08C7E5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:22:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235AYAmn014716;
        Tue, 5 Apr 2022 11:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hS+c2wTbn/z5Xf2KRUpMnk24eyTO7kUou3vwAdqLNbU=;
 b=DqA24ppH7JFP8xL9nmBu9umoYC4c38dbRIm3rRBImb/4FRUiIvmAW2vw+gssQGMC33i2
 03yd7hHlrkqR+rXHesxTAeQRdUztvIxMIidk0k7Ntd/5cmt3PhL9INpRAGmw2uZqsCxT
 TR484jh8r4CKk5wKTTDsfNF9CUbbwbNTqzQM5/VXENWMkgEC/9EJvZR1y+0T1782Bemk
 dufxwT5qsY2bFMx+NNge4ZdQDfT0rNwGF/4MVkdwfBLKDfMY9ucmpk7YECaqMoQWulbn
 nO3PXFzFRdV0ltCy5bvNwwzWcxbHs9/y47OFD9HxIZdVugRu/x8jNaDjLvoXOMxSEIvr Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9nn1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 11:21:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 235BAfhK006779;
        Tue, 5 Apr 2022 11:21:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx3fqa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 11:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Usf9z+7eJAor2/OtV5C0mBQvcdmvgMqhgOFo9fg4xTPCSVpT+8K5+m0GKmNkbwis5Nsrwr0WYwIzV2M6HFpp9OMiOJRkKFjbfPS5UmZf+XSWohzIooMFRTN5Dvtx8MSa+FTFxjX+BJGzxxR4xf1348S8Z+wCq2udnFMR5jnkufFPs8x6XtHnakFK1ISEJ0wm9jHCXpF7X0g4ahvQKL9ljEyxzBL5+iD7vhLE7TbU3kL6QeS8TH7OhUGMj+DVjQYP+AxLAfGXcidZ3iOwUeDYB6B0ldkRFPG6a5FeBOo6lLMFlKO53deiV6nboL4/kUzZWUR+LxdgaGzLBLRrWxlVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hS+c2wTbn/z5Xf2KRUpMnk24eyTO7kUou3vwAdqLNbU=;
 b=Z8WVl5ryvo/G5qtE/xAsW9+Clwjbv26Dauyj+RegFR7TKfbq3oSv9E4Fr7DQjvKQWCwgWj9EdSrl5eL1jsRKt+dEiOG8p7QlKzjbNQ9E9GNjXDfmf4HLtp+hOBn6YYbt5AI7sXQlhmQz5fBz9kuLELZeRWTilHVk+4ECzvw/gU2iTfV37DsSGGakQL2cRMk8ctPRLqmFO7jrFKzgvFo5HFqsvDZrjRqo9Yujd1djt1Pty8wiuLkfLgHT/mDq3CslKCM0+7/AWe1AVT9KSUWMW5s2uZoDZZaxIdCicX2MY+fH28eKUnx80pYl83r2IPw6Oq2eCAuAWFol2PvhHLB1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS+c2wTbn/z5Xf2KRUpMnk24eyTO7kUou3vwAdqLNbU=;
 b=fNvbtym5cES7er+b1AabZonMseGGvce/cv437GY2hXsaVDTMtAZ6V5bxVNMewV2k2DdLl59Duib4GHwusOAYbAL/zM9pyXpnbf/pEacA0FovoNrNfFx7pYX3Tr47sEaqNH+ibQqs4kY9tyzW8zP8IezG7Q8+9unCJhqY8xSfwS0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3509.namprd10.prod.outlook.com
 (2603:10b6:a03:11f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 11:21:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 11:21:50 +0000
Date:   Tue, 5 Apr 2022 14:20:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix a potential memory leak in
 r871xu_drv_init()
Message-ID: <20220405112058.GG3293@kadam>
References: <tencent_B8048C592777830380A23A7C4409F9DF1305@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B8048C592777830380A23A7C4409F9DF1305@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4dcf9f8-0b43-4136-1077-08da16f67a14
X-MS-TrafficTypeDiagnostic: BYAPR10MB3509:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB35091D7BC275D0F232D2F4D78EE49@BYAPR10MB3509.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo3rRyLptJQJFYee8pwuckQqEs/CnjeMtdNCsmcHZchX1nkueOLx1F6fTf7jnYOR41D4VmMa2fr+V+RfM0kPkW4FVuYXqlwHplgadVWcHxyrxIecuikrjVeWNACANoygiQQKvdh1FrCAwv2wErBomgJuAR6hvUJ1SL/ch1lSuHxALeSVgybBYODi66NBrl4wUjj5Ddx4KaIHgOfQCxpO0M0qiOaBPiTTv3JPVKRPfLiCQGe4C+SP6gXOe/1L7Gy+QoqUjF8QNhXH5qYV6EWSlQ27fcH9GdoTOE2cmfFJHSginfErZhJAdfMc2uB+gYii63koKRo6GtDbouQiBQO9X0wF9ZFOg0Pe1KObg7TEzzYplPSpq4ePkZKzD0E/xAYd1fyNDGIjwAlRAAtMyBaqOpzs6vSldgFZEE7PUXdxsGFmb1UjGYgsRSc+30eal7ZLZpo3pKk0rqEe8Pr/WqEvmbTkz7e5V2M/5VDuy6PqCQvT9cXL9bBKkgWlNeofc8kWW3wdndhkVghqaaYZ9oi85aLgsMoS/HObUMLX+p+nLs5aYEgUK1R+8KNUV3xaOu0GtMgmG3FtHARZsWt3RQNN2W+p3Uy9MKFuK3YP+RMb2iuGFBi8StHTjsPjynyeuZFwHoI18wrMxd4S4/dI5XQLwyrzTWmjtevvLprBrzCXKtWUYPskKvsNEyQrHpCQoM+eUd5FTD84ZKRXoAtSNUdHH6Y4vVqPjSEO9VtGdhtHCuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(38100700002)(8936002)(33656002)(6916009)(5660300002)(316002)(508600001)(6506007)(9686003)(6512007)(6486002)(186003)(26005)(38350700002)(33716001)(1076003)(8676002)(52116002)(66946007)(66476007)(66556008)(4326008)(86362001)(2906002)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HQLk9cCEa11tdoT5yw8vQKChThSvfRJ+eynZyRzXc9lCsK5HJsz1ka5HAZ77?=
 =?us-ascii?Q?EsK46p1uVZ+Ol+B1xbHC8rHr1acdEiEyBaKsrq5FbbvWkwCklXdDf+YdBXC2?=
 =?us-ascii?Q?OXnFn858r5BB/uLBjxu/2DeBJHMgld6dzxs+zoF0/Pg/lMBv+GVq/YceW4eT?=
 =?us-ascii?Q?qi10bGvxv5059JMqdOW3vkwaAHbINtw7FW16MHGbXZN4seb8BqAF/1i9soPy?=
 =?us-ascii?Q?fOnEe7mPNVN6prrA4pPkKYYB2QV1tDCWRlnCKOb9hOki36/SlfkfuFBVQPdI?=
 =?us-ascii?Q?V6eQwmjYV+uMq2DiPjoUq6vr5CGs2oKe6me1CAeS23RN53O+jmcjpKmDEtDN?=
 =?us-ascii?Q?9iWoDGkObxRWwoeuCmCqDNJyyNN5Y53snJu8xqYaX7rTKsqMUT2ok+SLHmp7?=
 =?us-ascii?Q?XyFJ3LQNXXHp2PwRT5vbJIHqO4iF+tq+23O6uzNSvuPjzEtdJJj9ztJCenf4?=
 =?us-ascii?Q?g0xmuVlr1DYEfjK+tyufEzW6b3XMewEwONt3HyQ31t+H3EAaScbBYrg3G8TO?=
 =?us-ascii?Q?g5y2EG9ogKT7VfheC7bI0vW/m+26aAy3ENOSkzA/CRl1EDBUof/qO5Xf87jZ?=
 =?us-ascii?Q?yMCxCKVsaUGw5BcCiZ2zU9Pl5ilT56WWGL5zpClJa5tlGQqec9/IMmvmTvyG?=
 =?us-ascii?Q?DuWVKmSKx61AOEGRABsp6kantjkg4gH2e9MGfw21s2ALFO3laMnx3a2GUfxp?=
 =?us-ascii?Q?DpGVT1h6n6TTO6K84NBgFGvDAE2jyQ05/fvS1xRCtuve9Lxa4KosGJJJ6m7U?=
 =?us-ascii?Q?ZIedlZlEd0r6r7BUhOBVy6gC2KdG2TRfpN0Rcd3q8V3JNjc0Zc6J+sDlN6jM?=
 =?us-ascii?Q?BcENcyk+kEHfgheTeqlZKeKObSiBkY4Ve7GBUlFImEE7H5lgojzBzbcUW1dt?=
 =?us-ascii?Q?UZ2HsNqysezsbaZJ8RQD3vi11APw4ggNwvpFW/K7oPsfrLQnfvQI2jURD++a?=
 =?us-ascii?Q?/YeK+pbNNdtFbnbtbgUowHmloxiMAcvxESbqMJa85LYVaw5oBBFSxxuUU9/f?=
 =?us-ascii?Q?xeAhViPKE5VULwpY4Cbj+1cYRYAzXF9JUqTx+SFurr6yWbzCdQShf9Ka/U4C?=
 =?us-ascii?Q?6zaNVoecPsrjaPQCe8icVq4UIrs4+PGhypjv5JQtk98VxLLzJob83OhvoFmd?=
 =?us-ascii?Q?PFThjrNHd6hsmye4bxUXAMtUXRq0azRxVK2rNQ6c9n0bGR51JLiEWBDJVwr8?=
 =?us-ascii?Q?/JDfh7Zm1TAL7Au4+sA/y4MOER03r54gYO/+2oDTFZddE0lKhR0ckFiBf7oQ?=
 =?us-ascii?Q?JeNc+pQuoq+Yeil2R09p2fa3QeS5B5wuYp89vtwSfTaHjJqWCixZ2f+ADpCn?=
 =?us-ascii?Q?Kq+9z+YjHhqKNUOxZ/7h8/hUCWCiP55D0RUu+43oATMB13viC2TzM/Mm4oRB?=
 =?us-ascii?Q?z+lAKT9a/vC5yxNo2iZAwUxiAbYsijBb9qgGyGio7SxuH7/9G06eCnVY5UfW?=
 =?us-ascii?Q?vy1tjTYriuHmogJlEkmgK7QpHz9uH55WzaMqICxp0gdyZhsP94nnt0cj1bXz?=
 =?us-ascii?Q?OMMiJm/nFaB2mTSCTm1XfSVZkFVwvgwLe+qVAY61tgE4u7vclI1Uu7sUP+U3?=
 =?us-ascii?Q?Bxhm//zeQ4rZAAshaQavefMuhS/hEFWknBoAmArCPvBJUDyr+buuAryN93a4?=
 =?us-ascii?Q?Ej+t0Vmba3xrV8fc0hRO0+tVE4PbzNo+PJJRdehnGdq4WCI46MgZSECf2ngE?=
 =?us-ascii?Q?GoOVnz5rUoj5deDX4NhbKzsHNUeR6fW/O9qdR35xxzsIkFqyw8u7AB7TMO8P?=
 =?us-ascii?Q?OEOZs/Mrar4TR1ld1RsNu7e5m2fAlDo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dcf9f8-0b43-4136-1077-08da16f67a14
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 11:21:50.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seN/PL0PzImkjaaSMRC1Dvg0tf1QtlFH5ePu4M50VIIIYOyeW4+TsK3DUKqoH7arTV7jDNNq2TqGaMgHqFdley4d8nEKKZdNHzNebY3fSXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3509
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_02:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204050067
X-Proofpoint-GUID: B14sPLyPr3ksH6nH6sHp42HyWqEAydu_
X-Proofpoint-ORIG-GUID: B14sPLyPr3ksH6nH6sHp42HyWqEAydu_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 12:43:07PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> In r871xu_drv_init(), if r8712_init_drv_sw() fails, then the memory
> allocated by r8712_alloc_io_queue() in r8712_usb_dvobj_init() is not
> properly released as there is no action will be performed by
> r8712_usb_dvobj_deinit().
> To properly release it, we should call r8712_free_io_queue() in
> r8712_usb_dvobj_deinit().
> 
> Besides, in r871xu_dev_remove(), r8712_usb_dvobj_deinit() will be called
> by r871x_dev_unload() under condition `padapter->bup` and
> r8712_free_io_queue() is called by r8712_free_drv_sw().
> However, r8712_usb_dvobj_deinit() does not rely on `padapter->bup` and
> calling r8712_free_io_queue() in r8712_free_drv_sw() is negative for
> better understading the code.
> So I move r8712_usb_dvobj_deinit() into r871xu_dev_remove(), and remove
> r8712_free_io_queue() from r8712_free_drv_sw().
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---

Sounds reasonable.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

