Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2A546745
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347188AbiFJNU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbiFJNUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:20:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD2F59E;
        Fri, 10 Jun 2022 06:20:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADEAbp012733;
        Fri, 10 Jun 2022 13:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=QVIpPD3OmZ4dGRRLhM3f5nmvVgmgp+Wi0TvBNMLgiAI=;
 b=VpqoBa39q/3Q2OSyEaQ84aTn9JWvv86J/+mLL+XshmgoN0E8JLlwe0BN0I6nMk1tmC2i
 qAoTJbexKzWc6A5VKOQeVZu65uT8vClfi1sjHwtXPHr2Y1bUhIBWiogvRKn5varTLJR8
 elVLDlyJ8rXpADaPCOnVxUp+R8+mngmeXEL/CfARBQNt/rcMaSXUSYuEVaC1/As7UdAN
 /xLJ2xQtZIFPFniajvndWA0MTMpsdjBYttC6AhnwVFCIi6CY0h5Xt9uE6+WD2g51ZOVx
 O7+GkwTd2wEnz/RPxqRMsGDHd5ARjdXS8BUSkWljREqVIcoBDtvcPrHtZbSk2ich5+11 dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxsnwwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:20:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25ADHXEL040662;
        Fri, 10 Jun 2022 13:20:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwud1e4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:20:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q57c9blQOHeotzOjqdo1HfCmDbwUieZVCUD/SStcRi6+J58JkJWNbGBZI6/+B7+LQBXQuq9Byb9mX9rYtdacizWwNqRpG0PkA/U5jNMem+zSL/ni9Lb+/p4acvHrJQWCSTbZeLCIy+/63gFQI9EpoOEdmYWOzReE7fvvvlkF7/O3jscLUvb607Pl2g2EKGPQmAMsAt3i7XpYBk7FO3ZSvG0yXMwF97IwjNJ4dqZdB1fps4j6HUpVBcZXKRQtWz56SNHjRDobrG2lDt1KR+A1FbCbC59INS82kRxCoSAl0qYo9wapKOD8oQ2PlpDV5gwwmNpeiBep0fHHXLQn/dS0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVIpPD3OmZ4dGRRLhM3f5nmvVgmgp+Wi0TvBNMLgiAI=;
 b=hoLt/BVanaySRQfqg1p7qc6y8fArghSlnh4U8tEfR6S0CCXF+D/jl3ouCMOZ+TjJFDYd/zIgwWaO8u7KkrkAnJhV4ZVbc9XJ32uuSjdZZNur+sYXIZMDU/rO0JmsGGHcAphVQLM9BcF4eu+J8u8kJYohNLRdGvan/b8nDa3IPh2huex1IUod4Y9BkbVFbc0QJhMe60SudYF0g+PbIBbY0Xb7xWJMRu6XLRlHjTooO+oYQ6YvREhd6O601nbq9SoRIGs8hhw3TnlkEBTethTgCa/cnUN2SnP41aPXW3eXT33iEza78/mSEvmnfH8ZdyusP4Q8eKbMy9bUhHBd5C1rWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVIpPD3OmZ4dGRRLhM3f5nmvVgmgp+Wi0TvBNMLgiAI=;
 b=vnawC/ucCy9GW0751XjMkAMyOkvQHYGfPKvb066Blr4IcH8UgWkULlUEBRdJYejrSqB5YH+hEMnMBHfcQK7GTY5S+p4y8YXblEqgeztpnudBNYCzEkSGNAgy/1lX3qJJ3RUW0LnGx1SONeNVKrnDVbaL+jrOEDJSOlmCUKYJNUk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM8PR10MB5479.namprd10.prod.outlook.com
 (2603:10b6:8:3b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 13:20:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:20:28 +0000
Date:   Fri, 10 Jun 2022 16:20:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] media: rkvdec: Re-enable H.264 error detection
Message-ID: <20220610132017.GD2146@kadam>
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
 <20220610125215.240539-5-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610125215.240539-5-nicolas.dufresne@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::31) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae728dc4-3539-4c0d-3834-08da4ae3fc7a
X-MS-TrafficTypeDiagnostic: DM8PR10MB5479:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB5479639076CACCF2749C41A98EA69@DM8PR10MB5479.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6M8duH1+do1WrXnzdPFfC+/5wWPWRR8dg7cyeRq1SENSTlsbDfmoZJDoWdFYKpMbI1G9pxrt8iopI+1BCn89+T8gUi3JVPXgyypPGsz161UsLGmY6hQxmaOZtPRJ80n+MaUZqRRHSWK6MxNdEUkr7dY+rrMJOkxVhLIUVf8GvzBLzZ8ZJFRtxVkkd2s1Xck1NlmM7mMLWvm64Yy2XwA5Zcdp4dFtjsSl9suEnb0MHkfIDODXS0gEGXQcVYsYrx93sLX+a2goGsExlA9Ox30cBASh3IjNGvGrkAwWh6mKwInoxt3u25qKL1ydEBYNkXm3zLBH8jRI+17uVTZB4a9xThDaYF28MfaX0to/Gh75Nyf1uZYua3yUNqTGHODhEb23KrUdzTRJyi0Dq752fR8Vhq/gTPWdHEaIino08z1YJf1iabIYygYLVuRz2ybPfobED31WT398wNRAWCQTCxRhlcj6Ov7jyDHvx2E3nxQVXlk0dujvpSTl6Dm0j7JATGHRbKyf3PZCymI5epepftuAmmos+qZuid3Yks4CGxZrCOXfcFwDvCtW/N/9Qdg03uq/R+dvGgR25Um2X/KkDcHbGLF7zyDQjIFXWqaWl6BuCFw/3hs9GPZsShY35+HvRT5jgW8F5Vbwo/KDKwmcXFoGiDJylmU80tvqT8xGZZV+AjiLsHeipl1zpcwWJITL0WRCFvj/dWpfIx6vJ/CaUiEBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(54906003)(2906002)(33716001)(1076003)(6916009)(316002)(83380400001)(6666004)(508600001)(8676002)(33656002)(4326008)(66946007)(26005)(9686003)(6512007)(66476007)(66556008)(44832011)(6506007)(5660300002)(52116002)(6486002)(38350700002)(38100700002)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9EGMGY2Nko+bi8nh6OljxZY6B3UhOPuV4fCi7vCI8iBeY9T8sNFcwFtl2nd?=
 =?us-ascii?Q?flId9KL4vHjXOYx2dsHLqbpgmDgBmsfbLWHLGV3IK4VtSpxaRaa11vn7MHXj?=
 =?us-ascii?Q?LDaXAsmaCJ110e7A5aFDfqVt+Y32EEZSfTtj7oCX/vAPgaYts0+jUOPnza5T?=
 =?us-ascii?Q?dI8B6/eOwRFb1X8zpry0jJ2+WjHLoyTzU3K654Xj7Cb1W/jQdbNvw8ALOGTW?=
 =?us-ascii?Q?3qkcYCNoRs1zvq8jprQVQzlCRJxBoyxUl9Y337ynQygy5dEgoXp+mqIM0+5C?=
 =?us-ascii?Q?v7nSAUquGZlSD3NWA4ShR/pfdioKkbvVUqPeKLXvdZXldAd5OHYWnigaCWUi?=
 =?us-ascii?Q?/mvwc/XM+aLnEOxrUVccS5GHruxi2TOTskYnr8KM/L9JVtnv+mUxeMiJyE4O?=
 =?us-ascii?Q?z7wRpbk1eYovGNmHtr9GjnGyYKf5zi/OqpKj4JRzkbGD/oHuQt00WhWr33Pz?=
 =?us-ascii?Q?ho9YybmL09cBSnECgrkz190E1JJpVWhoxcMOAD16tBAtjFX5wrJsccN6VOBb?=
 =?us-ascii?Q?lMbZlWtvz8VEeA46VHSew5d6o19V4bhvblOZ6O5E6ZIr91v8CvcGkGc25/XA?=
 =?us-ascii?Q?qM4soVcENlAlGhTydFle6UwoNaX8FbxF6qVDzTGO+U+2wIYkzlP1/RHFFh37?=
 =?us-ascii?Q?rB6MYB46ClBMks/GBYVqcPr0lZYEFq4Iz1sjhrLKnbKa8rS3r/NDuBKGlnlW?=
 =?us-ascii?Q?QQs7HWtsjBiY8gX5GOY4g3AhO7c/b6h0whFNzEzpH2yYP/2uCBJyBQxKW8OD?=
 =?us-ascii?Q?dwATein2nEh1EySU0QXOquYhyNAelMhzTAN155CIvj0shM+l1Z4WsNQD1R8g?=
 =?us-ascii?Q?FbKEQwYBUEMuVE3rjH7xJe7P0JuPE2aZNnDx1mvh/aROutAtuCPIdDTrpmH0?=
 =?us-ascii?Q?VvcfUgqCM11KgMLVB/zv2V8+7wBhIPCL/Z1ONMiw/A0nqPlyDXwYne6sZEeg?=
 =?us-ascii?Q?EO4nY8bIxnkCuCwTEpHNdY41OwrDzbI2kqpLYKbgsDm/aOgX3ttW1yrhSdoN?=
 =?us-ascii?Q?aO0GKNtCeG7k7qf/H4YMbSFpWhAM7x+hLkqyOmPHkGtnMGvrnTEjmbrw18J2?=
 =?us-ascii?Q?1MxCeRAgfjNpEXFLiOYelTUkqFzkjloBu2gxRS43p6WhitzC835TNdKy0Cvx?=
 =?us-ascii?Q?CEeXpjre7H42zYUNFGaNDH56A28j1Wm9ufjxpPO6xBcJ/cYw0fRhyPivzwtj?=
 =?us-ascii?Q?goBPa5t99xDt7W5pcFdVPN18NioS8yY6ZlG2clRHnJ6EO0vRB41O4wB0XWSW?=
 =?us-ascii?Q?pjKdapQYLngZXdFNDg9D79kTOediWHACsYs95kZPP4ebXMQn2TsZu73qa79v?=
 =?us-ascii?Q?T8P3SMiJv73Fq+YG0GxqhHFsBIeQA4Rb2prYsVNLFXHh+SiGmEplM827LSii?=
 =?us-ascii?Q?SiNU3fLc3frjMXxZBZ+CkfTlEkO3JBi0azBNDUTEgDNlRfEC1FgXhb6AM1z3?=
 =?us-ascii?Q?VjidiAqCYek13l4fv2eL7XorrnIW4sbYICJBuo43FhmtKkC66pvXN1M3qy7Y?=
 =?us-ascii?Q?mvt1Kzn9VVjz2t+EIoTZcNyeRvwn9CZlBz2U0NgP+hseKnjLPo56k6CJJzzP?=
 =?us-ascii?Q?jwNAwmCtB8JJ+6fIrptSR5dXmveohCAHUxWRCmf9ytkAvlmjXOCUgznBHuI0?=
 =?us-ascii?Q?VKQRsO6BAvt1TKY7Lhh+dEN8IM4Ck/ec7Xo8lVz6z2BGzqWGSFqh82tvXVw9?=
 =?us-ascii?Q?RYFSZgR9VkqkHZ0WWZIF6/xPq0YLRJfW/fOidB8gPGxFQDK7iJtOn2kmdN9T?=
 =?us-ascii?Q?Qm9DbqtBuNdGzCvF0uu2OG5YTdPOvP4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae728dc4-3539-4c0d-3834-08da4ae3fc7a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:20:28.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mu+pz4Rxx1lXKDE4DNYlFhGv/0b0RX+AW4w+6MAxjE9NqdZKhguGnwtTIowAariu7SR4IUBDRgXK5LdtA9a4suJv++e2KZEtlBEeteifWtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5479
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-10_06:2022-06-09,2022-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100054
X-Proofpoint-ORIG-GUID: Q2mGQDqnv_rXBSsGusKgbH6Zduhr4qNt
X-Proofpoint-GUID: Q2mGQDqnv_rXBSsGusKgbH6Zduhr4qNt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 08:52:14AM -0400, Nicolas Dufresne wrote:
> This re-enables H.264 error detection, but using the other error mode.
> In that mode, the decoder will skip over the error macro-block or
> slices and complete the decoding. As a side effect, the error status
> is not set in the interrupt status register, and instead errors are
> detected per format. Using this mode workaround the issue that the
> HW get stuck in error stated and allow reporting that some corruption
> may be present in the buffer returned to userland.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 23 +++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index 55596ce6bb6e..60a89918e2c1 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -1175,14 +1175,15 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
>  
>  	schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(2000));
>  
> -	writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> -	writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> +	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> +	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);

This reverts the changes in patch 1/5.  Could we just skip patch 1/5
instead?

regards,
dan carpenter

