Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D544F9131
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiDHIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiDHIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:54:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681361CA116
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:52:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2388jb8O006378;
        Fri, 8 Apr 2022 08:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Q31L00+abnjAfFDhbPHNyb7zCEdp+FcX1kfrEXSkrt8=;
 b=i+dBXbeak+P7Hcjr2z8g0CQI1qh3NXdIvJm7WQwasvuW7zNwfTgJpolkDA9QMOXIWcQt
 KpQzSHmDNegjVUDH+ckzy0F2WL014GjWsyLTCRt34HcHDzym//qSLPjhf+YjYPAO05al
 9TpqvZokTsMh1GZvOaidVlqFjOJv+4pC/NgXYXeojRw/pYtb4n4odWNPPyexnfAl6sp0
 jRG+aKqg1d0RIM+OyNjzNAhWvLiLiKKHFsgsgvH+IEq+yuO8meWgmVRHO6GGzOhfSvsJ
 CbhKnkQLbNc0+kAZGbDtFfpj3mgK7slIoKMEaPVexdFvUUJ70mOfm+LkHOAlqfiVuQB6 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31ph0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 08:52:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2387tbtl013790;
        Fri, 8 Apr 2022 08:52:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97tubbnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 08:52:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BniC2V5kJfJUjYJhMZi3HFuVCwnYHj75vBdQarn/f+aB1TmL9W0pwxvdD59DufBWFBkF8/CEtif3dtoLihhyTQIYYTFS4v/6jLgbOUPhNh5F66cM/RWjAkMHJXTcssOLbBtf0NZGpqHIgGbEjwa53rZKU5u+36bw+LG+jePuBoMPQyxRyMbOwmAjP+pXLBBufFd9vy8fzqIhVDFD1H56uRqDw6q6BfPMRNkJer3mSLKMuYnn8apsir3EBSLpfJLf0KoPjOfJ7GTMvNRYynY/gDDhen945GfMd+pZSN/0ThVoVpK3iORj82rfd5QRo0YlPYvzr9DOLwdSiZr7HcNJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q31L00+abnjAfFDhbPHNyb7zCEdp+FcX1kfrEXSkrt8=;
 b=e+4YGrYBU6MohoUkkhpwCji6AplQruo/dUN4+HaKhS4+4RjTkkr4lWBziYXpBGoHOyMQdwzLngze370tLN6kS97mo7+LKTHPL6pC3yY5i1KSJexL2b73+XIfiOPfz+f+0MCAR8fdomJGyebGf4kKp8SOA8UbCkgHXQ1l3LhmOqO+50N6vX5bMIbqSyK6w14FRHMsEAk7CEG6tay/5OtXjL+RjEB6yZBfja/AuF7ako8skEoIFBze9NYKRyUbu0BlKPT3eby8nlnvqLjtr+WR6QebsUnOZ/ppVvXBbGAkwp2wPzxl/xbYNHuDhNPZXeRvNZOaV5NdYb0idxND9IYPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q31L00+abnjAfFDhbPHNyb7zCEdp+FcX1kfrEXSkrt8=;
 b=dR44bYvAfcr9QSFfKq0cl6CCIfMDDp8hoB+zM42eJj1PvbRPKDwSuAXVJLoY8EeI4vsej6sthaMAqYxgH1GdeytPduIjOYbzJN1AmKWwxxigWWFTlENZsEe0+btXq1NsV9jh9d8sDzVR72JLYQAAZcUMwcXi5mTL+oFvYVTwjb0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2341.namprd10.prod.outlook.com
 (2603:10b6:910:43::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 08:52:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 08:52:11 +0000
Date:   Fri, 8 Apr 2022 11:51:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yihao Han <hanyihao@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Xiangyang Zhang <xyz.sun.ok@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH] staging: rtl8723bs: simplify if-if to if-else
Message-ID: <20220408085158.GS3293@kadam>
References: <20220408074245.13694-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408074245.13694-1-hanyihao@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0131.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31e073ef-d23c-4fae-cff2-08da193d1221
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2341:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB23413A7965860BE3ABC5295A8EE99@CY4PR1001MB2341.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dR/2ElGFI8XjhQICMbDSlSH/6IJ8VZYAXW9UQBtXOIToeFJ+V/KH2+UdaifPh2LS1fxPXfxnmnVEg6TSMugPmhnBhjOgUQCZAvrnMpYlTIYw7PehtFapURsRTlZpeltdLKWBM8ipTPKpl+hvHKDvasr7dozKIRAk0pZNkqPLnlw1w6dh0P7HU8osu5CyECmmN274d2mfoYUdCciRU7m84Ggp0GERoEkwJytYANHbsSJI4T9zaKepgMrpj7qEqBnJBoLOOnEbnQH+01qWcWaFY+7PDyr6nT2vh1QfyG1REgwbYFP+DZK+Yih78QnzbmcRToTtObywRBPhGLkT2WMFMbpwpL28P+6ScQHVx3kggTh8L0gL+odjB2ulR3wTlVCvvrWDJieCg0eIp5SbQZdamacZmX1+6w28SEsQ6sHlj2JpVxiiZ9n5yBJHIgoYuje3pfXtdYbbcmIys+uHe3H5GZ+LFQF6gVOuRu3AkDyeQMsC22zkZLNMFDcjnLKJLyV1nhUIsx9tISDqPkSNzb55iLG3bBcLxbzVILNCxvlIB+Q2TeoEzGD4va+aRyubGDS8Aoln/v/kcyy6fp3eWpwGi89sWyTMXTiykx7ue2iKge6FwsPDot7AO0D57M5cjfQ0e/UI7Mo1539bkcuM9GxuQipKP8KTCTAG9mmFNlyvYQ1gTd/Gi7PneK/IHuzioFvIvDarLwkoquPUCxtknzTAGtfpMrKWEGJGZ9nU+DNfRuvr+9VNx9+Tinz+khTGvlIA/bb0D1kpFEbm1kopUaZpTKo64vrjQLmxNI1cmay3I4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(33716001)(4326008)(38100700002)(38350700002)(966005)(508600001)(6486002)(8936002)(6506007)(7416002)(2906002)(5660300002)(6666004)(52116002)(44832011)(26005)(54906003)(6916009)(1076003)(186003)(9686003)(6512007)(83380400001)(66556008)(66476007)(66946007)(33656002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4V4u9040FNalU2nFWWnF8kvsaBGcYA/+jdqDwy/jBvbyq05sW7RmC0Sh1jms?=
 =?us-ascii?Q?AefvsYJgQLgWcdOC/e5IKlfAG6RpScQlh5XI/23cozL+czJ8RMfOlUwomoBa?=
 =?us-ascii?Q?qwlFugc8VmP2+eWPrgOLRTKmIze0aZc+ncOJ2plJdeq7wKqNNAFGHkdgyQhx?=
 =?us-ascii?Q?Jrqoc9/3tJKcIby/p/tgDP17jYKElVnjVM1QOd4nd1kjKEaj/s2Ok19xUtCI?=
 =?us-ascii?Q?m0/H/znXHqZudk3L9/c7iZfctn4Lf8oKhqOxIIEuqNPoh4qxbuyCkH8OvGaz?=
 =?us-ascii?Q?uycw6MkLRrVjZyjhjn/phFs4zQYLB4J2sWFFtLmxkmljF7yaeviORy70ozxg?=
 =?us-ascii?Q?IkLlfJ5ltNE2/12EibGLK0KLEEcyVvHrs+NqN5pocs2yuAMuzOvkAQTCiLRF?=
 =?us-ascii?Q?eNADp++3QE9iZobpi++RN70kS4HxO+4rFFbQUzH4cfNfw49qBAezfMUJWAyQ?=
 =?us-ascii?Q?yjdZeD8PNp2t90Gz8Gvnk31KmXr8L6bwP+HFSCKI6EqHcUkIkgmRspVpe6DR?=
 =?us-ascii?Q?+LJKEofFJABQzNPCK5GzZAzfGUy7HXmV0WM/w7HQejCDxjEa6seSfLEf5ZFO?=
 =?us-ascii?Q?8gnXydcx+TZOCPCPc//ly6ely8gVgMhOlBYLa5IS6ITwv9CyFRV5DsjMYmjO?=
 =?us-ascii?Q?5Suadn5x19HxVyc2KkpIvS/TwlCM+NyGqrRfWsC6XF9r7D3HrlOiN6LNRKBR?=
 =?us-ascii?Q?8ww0v28CVu8mV19g0pUerab52+Eq9bf/mU7rU6MbNl728QntDtMtVC+uxocv?=
 =?us-ascii?Q?HmZODBeyuhMaUm+6Ur2/v4gvQhsy1gSTnEaPuL4oT2ZHp7MR08BTISBakF0/?=
 =?us-ascii?Q?lom3rcNuzSp1+HaiEUJ0fkC9Wv3dYEFl6spd66ySb8fl6lXTiT1DrKqwb/nZ?=
 =?us-ascii?Q?cfxqGEDGLAbxjmU2XDc2pE1jnjhcm8SUuyyYZlNf124RXQ8G3PCCUbWTlqev?=
 =?us-ascii?Q?PDPPiDuDAdv09BWYRhgm0gyvFbBekF0IXGVleWxPQqAYsj52B2xsIKnX2oXT?=
 =?us-ascii?Q?v94p/4/FO8E73I6xTBNpxKS9YycrG5Ihhwc6XFe3ya/+cECoLebNXz1gPApX?=
 =?us-ascii?Q?843qWh/Z3xAW1G+538RBMEAsEd9fW9r5tkEFRyOo6xnsT5gbA/DsAOrhK2PZ?=
 =?us-ascii?Q?+3/w1hfEow1ZjfKcEKh3+F0TpiTvSBEmwemEyV/rWePisAQUCeaSePJPHFFb?=
 =?us-ascii?Q?irYtSfkLl+Nb56C4ScgqoS0zWFFlpsfknLgIR7FyMR1OYaitqwbUpwrBwX/n?=
 =?us-ascii?Q?NJ6HBYykt9e8O9MJJdrZ7vAUawxqhwInEFN8010atgcE7uzQDqllX5LUc1wQ?=
 =?us-ascii?Q?qh9daJHRw+vg2n1PJkzKABSgfbm2up3SWF5OQkGxduKqN40eVRB5p8ICdoA1?=
 =?us-ascii?Q?LpujgTehE4m7Chj0EuehnCf1Ps1/WYKeryCHqXy2AUgZjMyXztRux7+hwirT?=
 =?us-ascii?Q?3FIfMTipI8NK46w+w0aq6/mey1gvnW49YIBsmAaYTZDF6zJBZQooWV1hGBGB?=
 =?us-ascii?Q?CoDQ2w1lqRH9zW7NhJL2IHPNhmzdmECMUuDgYJ5Pmn3+asnpTpx1ue04yNZw?=
 =?us-ascii?Q?+uzOtR94Lrbm2CjZAV3HjynXGYEHl6N04nVyTA538UGCJY2AOJi8JqLLajDJ?=
 =?us-ascii?Q?K2FqG8iXTP7lq72PAsXgilNwV1U7/JsiyyOU6VPixnBREo6bl6MINDp/+jKJ?=
 =?us-ascii?Q?PbHLp94I4bNqm1QNO21d6Dz4o6sMaCnE4IfU5ldZ+JswNqVvL0DU1GOQvRC3?=
 =?us-ascii?Q?bOFmsECeFLOExz0UJ10elMGHlUqDMHE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e073ef-d23c-4fae-cff2-08da193d1221
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 08:52:11.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfezTP50LXHCn1MhrsMbruOvLzD2IZEBQUPPIzhdO231sdal9RwzXrHfdqVu8DtqRixWiUzzDpsiN4dT2lgwNxZNeg/w7PgVQ23oaq0FGzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2341
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=956 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-GUID: PVA8-4E15ENCuoZygySi2LpEwZzlId1k
X-Proofpoint-ORIG-GUID: PVA8-4E15ENCuoZygySi2LpEwZzlId1k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 12:42:40AM -0700, Yihao Han wrote:
> Replace `if (!recvbuf->pskb)` with `else` for simplification and add curly
> brackets according to the kernel coding style:
> 
> "Do not unnecessarily use braces where a single statement will do."
> 
> ...
> 
> "This does not apply if only one branch of a conditional statement is
> a single statement; in the latter case use braces in both branches"
> 
> Please refer to:
> https://www.kernel.org/doc/html/v5.17-rc8/process/coding-style.html
> 
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_ops.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index a545832a468e..739fea437f69 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -818,10 +818,9 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
>  			tmpaddr = (SIZE_PTR)recvbuf->pskb->data;
>  			alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
>  			skb_reserve(recvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
> -		}
> -
> -		if (!recvbuf->pskb)
> +		} else {
>  			return NULL;
> +		}

Please do it a different way:

		recvbuf->pskb = rtw_skb_alloc(MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
		if (!recvbuf->pskb)
			return NULL;

Then pull the pull the other side in one tab.

regards,
dan carpenter


