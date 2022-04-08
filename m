Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8653B4F97C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiDHOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbiDHOPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:15:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A003EDB5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:13:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238CG9Fi004957;
        Fri, 8 Apr 2022 14:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Kz9pqlN6qpIX4wxHzCr8uUICvnYrJFA4CBUhj+7hilM=;
 b=cb2B3DQr9OY37MxiAPO6UelX5kW0iSs2EQDDI/cWUf0LZqfG6VyUMN6Xp9JYf4Tj8C2y
 3v8aSb/GtwSybjQNUq2qOD3xXQZoUt9qCpHw4SDpKLrLG86YnPIi3+POEmycWiGKUnt0
 rcyZb4nscpUJUybgbjhbMKXK/qH2aDTUVS7Z83SN8IuB4heldgLyReOHfh0utmWIsjxN
 K4hVDum33NOe+6KEwsM7w4LQRd76klxwdW/wloTsOOtbmagi2uRbGia3fIBdRkrwgvj5
 zjzgGDoL9ftvmM+NISZvS2hZ8DoSBPOD7rq3VasZZ3uGNCNDHUm9txh4mm6gMnV4Dhn2 jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d9378tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 14:13:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238DUrLL030795;
        Fri, 8 Apr 2022 14:13:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9805af3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 14:13:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yvl7+mvS36l8WILXeTvaFlQVbwy9loBYvzAyELCgtkVSF8dMvJlmX1BPzTj2DCxkak4I5GaQyZfoLgK6IW/kj7rBTxxd9hVUTU4hA7rl4qu8qla8yTZbDA6oDLNBq3kPF6s/Arlz3HP0KWHbeRbZQgPm5e5fKkX2yVu05vSxLQHuAu9Is5Vlndq0d6fxdJT3JexJTtGlgRPCI+M8vBOueSl4JUDQAtFcPw7M82D7pyAdfIKgo8iLO1u8furTbtrRi+4FcyAdAIu8wUiLBGyITanGMNzDrlG7LJMSRELwFydMmQxf7n8s+teeRnoAx+t9KPLLabtv3vzxnRTMf5tCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz9pqlN6qpIX4wxHzCr8uUICvnYrJFA4CBUhj+7hilM=;
 b=e8qvbsBzRQjwXnDbWmLBVrByovDFRtoLpftnIFL2MB/wsU9ttQX62Ri19iiB5lqTwHLrj9yNNC6A1V39sLwiopr8U0rHZMZEeK8/RAOrzW3KX1V/BHpUwEFqMYsBFm+5zOrOSUK4CoH8NHa8M+hBtjOEbSkZz9lVmkJ/ALJtimo5L7sybS++r18sXQPE8N8ZG0nbSiu843nMk48cT0GdXuIZeXJ1HCcpRi2L2nkipsQWXmVtWeYDGrwQRiO49KNQe/K7Ico/Jk1HOtnSTgsbP+MauU55HxB0+oxfIAWXjbnjsSHwbCCP7J1FhX/HsR+1Soz2uvWJKRcHE5QyK53zYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz9pqlN6qpIX4wxHzCr8uUICvnYrJFA4CBUhj+7hilM=;
 b=Z8tXfZCc4jOmWZtvnFHDbidxCSaa/8bWbtcC9zVsR27cblvllJ4JKvWIjXVco0Khvp2kjjniLj0RFjmbUzxIzJMS7INNLRX0XlPAENpNwUxCVqHv9LZgBTie075awJXpmpIhwtb8r+hm/Z+BNPER1clWkEgvArA8Ogw56qMe/8M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1595.namprd10.prod.outlook.com
 (2603:10b6:3:13::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 14:12:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 14:12:58 +0000
Date:   Fri, 8 Apr 2022 17:12:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yihao Han <hanyihao@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Xiangyang Zhang <xyz.sun.ok@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH v2] staging: rtl8723bs: remove unnecessary `if`
Message-ID: <20220408141235.GU3293@kadam>
References: <20220408085158.GS3293@kadam>
 <20220408135921.16534-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408135921.16534-1-hanyihao@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e497210-ea26-4f43-bfad-08da1969e1ec
X-MS-TrafficTypeDiagnostic: DM5PR10MB1595:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1595E4BB87C7149C75EF766C8EE99@DM5PR10MB1595.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5p9/CvDsGDVLg9mRwnre6YZBsYa19bI4dmUWFNbNsayvxGAuu0Utif+SbcFuN6eOvW/M7UmwWwsGtG40ogNVJsThMzSYBrKoOOWczj9FUAp9KIcS/U8whBqiVKXVuTHHQ69/j1eoR9UzQPhw1gTv2bcNWE3x+5pE8jbMAlFv7KIm8qHprEOq47RDbXhBJ9LhX0HS5lbfum7mHbFvEyzgBw/hTeMNe9RvJcYNwGXSltwYcaYs8bE/GbkTbZ6Eg/lAvYbDPh8xWGYdgksZhcVlIR6J6vmv4MHuNNtuJiNs4wolndNPcLKVJ7/ULy4M95CZG122sCWIEDr5ZQkmRjpv4fGqfOVdefSUKHm1i+DWQ9bcj5tf8HZx0ggkBx+3cTqM7UvuOEuE5TKtdI+jQ7QleR8GWWvlUyr5j/YKC/vYJX7f+G2FA88Dxscr3Iwh179fFy6RNPDmhPT6jTOEgk3VFQDbTasz+HDJuXs+BMyeN+oFUW3Zr1s7YuVmQrLVbIu39aslLVLPkCo3GiK07zE6CvCWHJ8RASJLi5wvL1Hu1gCzKcPoyYH/EVPRWPtLvJwhpS3zIhgRw3kVJQLlElxeagbTgrQ+TEJUZqN6ZVU0j9MY0aIgiXCXheShoAuSjSIlt0Szs2hHV/Y3EAjYQ7Ca+Qz5RteXm/TObEGSwDToxEjc+cLu6CnXW5FaJvLgVo95HXhAL/X661R2M5SdbdxKHn81WZhCFi7GQies03ztJ9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(66946007)(86362001)(4744005)(4326008)(52116002)(5660300002)(66476007)(66556008)(8676002)(9686003)(2906002)(6666004)(33656002)(38350700002)(38100700002)(508600001)(8936002)(316002)(1076003)(6486002)(6506007)(33716001)(44832011)(54906003)(7416002)(83380400001)(26005)(6916009)(186003)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wZSy97dxjiVYTQDkmFus/fN2JQtAupv498Qo1zB5jnkvE9YoMuwH4fGw8d/L?=
 =?us-ascii?Q?YXzXjLnmJfEHu7lzdQbVgjdLNeNeHaCjyaPG4TGhnv1BrMujrSd9X9FyfGDn?=
 =?us-ascii?Q?INgoPxNr6gTIGCKf4IiQaRH0OSFj5YtTFGUE84JyVivBb8WyzZBp4MEON1K7?=
 =?us-ascii?Q?FaIt1cKV/nNWSlWpSpjElap/3gUkD5yKBEnTzuLD9QA3+UoRhhGUc0kaCnRo?=
 =?us-ascii?Q?kc1L0lUNxix5ROHcrmLHlclnG4v13Q3094nfdbaDzPtTezo+bGLk0p2FzzmN?=
 =?us-ascii?Q?uZib1MszWodjZEbYC8ew8jMKkK25ZnaoqBjDbxqSQ2B2JJ4HP8LN1zKj/mRc?=
 =?us-ascii?Q?uwQsfbv90qnc5H4yLCy0pVN5muqvG9A5t1HePJ8pzOA7bBVS5Tt5f0tPQQaj?=
 =?us-ascii?Q?wOh1oNJTVIpREKNr1pfZPSdwEp8yetDwue7VzMMolWO3UriMULSv+JZ0Eel3?=
 =?us-ascii?Q?QPgi3tF0BXr4yV0Pmz3dPxv8mkcVHdLsu5sD6VO5FyFd9XztNYg2VLOgus/4?=
 =?us-ascii?Q?gyT0Ravwmt89FdcM1Xa7XppHpQ6LzVHXR7n0JiWinEZ8us8NX6I6+WeLVoys?=
 =?us-ascii?Q?U3pVqVbiXMSIF9vWeIti9oMQk1dti4BztA1aqpa9xaN3s/fpXBST+Qo5aMl/?=
 =?us-ascii?Q?Q2C2N0bHBRuficaweXqaQ7JbtarHRYbRjO1ENezRGU27JpJUEoFHoEvvFXr/?=
 =?us-ascii?Q?WoRnucyMDpkJInbfRXkY+sBfipBgo/wVDZpOXooc0td0DRo0bOMBFEM0gK0R?=
 =?us-ascii?Q?3workR3aIH6Wg46zw3z3DxAdaKDoWVWQ/fihyVaHXeTtIMUqXCdsRgcb5ESd?=
 =?us-ascii?Q?k/udO55LyiV2Qp/Pt9TPJ6xxM01Wl0Yk0Imasgz9Fj3ju9di/gqFWTtr1Mj8?=
 =?us-ascii?Q?xuRrElI70ysf2k+xuPnSqxq36BMCdw+U/spbvj7VUWqSNMAhyEUHyom00zJw?=
 =?us-ascii?Q?yO3DbjGj4gQlehcToy+LmhOfDBDaJhq3o4FDRnzmLGANGSxOKD9gPHg+mYPx?=
 =?us-ascii?Q?2Cv7zzELq/OGISi5eIHnFEU+Z9Une3sTpB7kpGK/F5+cmqgaAyc5fo2nvdDP?=
 =?us-ascii?Q?FlRu5xvtUovbmbJ7UlW+HxkGHmXQiT67JTdkCp3sQihS3nyYkAgKv1v+VFwh?=
 =?us-ascii?Q?Er/g+Ajledf2t270Ytbdo/zjhZxkGRmWN8l76Pa+TF4MwLwaqImvahkvB0YG?=
 =?us-ascii?Q?X+TkKEbKNo98UkVfu18lfk3ziWdSFf9wvuD4YByhAzJiTVTEm+cM2LppGZ6r?=
 =?us-ascii?Q?hYRGb9hGRa1nbtmZRcndXmfEttvhNiqlmOPFdMOCUawgCDaPWXZk+LGZywJ7?=
 =?us-ascii?Q?oPO/PTKiOOQoOcAZu3wforgzUfV6PHgi0H3abKR15i0VZo2T3apxMQcJsiLX?=
 =?us-ascii?Q?qFj12QpgIhRY4t2Jy2A3cLTik3fINlropHnhq+eNCW3K3+/brzsDbkZS/z47?=
 =?us-ascii?Q?DtmzzDPUEPLjz5CuVS7RmQJpibtinkVB5AKp7iOoD+T3PWjghHylHG59kM6x?=
 =?us-ascii?Q?IRrfqGe20xI1uaft1en11CeBjOOkTJWvTyiQiqTN5MZzjiZLnPtdkvbcs/BZ?=
 =?us-ascii?Q?WicYIBZEAT9P9FKXpZ9WQWy1gBw2lclNYtATfg5d1uVEEE6fTGjQd+UObWVJ?=
 =?us-ascii?Q?BGVIfull4uSPFLodyQ5FyMgrFu4xhsWKfqXLz7DFWUinpkWnnQET0VztR2og?=
 =?us-ascii?Q?ecvXEvczuEwEFY8nS8NTQFVrqN2dYn3FTxF5QbgmuXtPl/tqsz6ASPxVWhbs?=
 =?us-ascii?Q?XMPpPxRn0GSNYceNdUGjRnlUrfnzQC8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e497210-ea26-4f43-bfad-08da1969e1ec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 14:12:58.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzkLEsOgjchU1gKjtPzSVEgdl5TCVKkfCjjx4yM8GGDwAYbQJ/ENHwjbwxyNPn7BuE0qJPWHQLjjQzjdqtY8iYE4cmSjf4DjH3ypwEdLaxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1595
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_04:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080058
X-Proofpoint-ORIG-GUID: EkAZSHdSAbT4sHlr3SU6d9Y9xzFHzD6k
X-Proofpoint-GUID: EkAZSHdSAbT4sHlr3SU6d9Y9xzFHzD6k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 06:59:11AM -0700, Yihao Han wrote:
> remove a unnecesarry if in `sd_recv_rxfifo`
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
  ^^^
Under this cut off line then you need to say what changed since version
1.  Something like: "v2: more extensive cleanup.  v3: edit commit message".

I do want you to edit the commit message because I don't think it really
describes the patch very well.  How I would write this commit message is
this:

    [PATCH v3] staging: rtl8723bs: tidy up error handling

    The check for if rtw_skb_alloc() fails is done twice and is written
    in a confusing way.  Move the "if (!recvbuf->pskb)" right after
    the allocation.  The "if (recvbuf->pskb)" check can now be deleted
    and the code pulled in one tab.

To me this explains the problem and the solution.

regards,
dan carpenter

