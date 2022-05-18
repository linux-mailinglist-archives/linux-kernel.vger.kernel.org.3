Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9252B1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiERFkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiERFk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:40:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0DD60D7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:40:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I27ORH031717;
        Wed, 18 May 2022 05:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=A8j58ASuGMDu/45JMAMRn+nso/H2DxHiymllBkOOKA8=;
 b=KsoUXUdFgtXAWGMgMgvl7YEkhM06QEYFwtKgrBJrPi0HM+H1yvsj6xaoAuSszxMioy6x
 Ghtbsr6aiWME64olOH7QmgKB38BOBv/Eb5Y6kesVATqfzeALCf/HthyELkDc2u7mmVJ0
 6BQ4eaqFkpQpFcvuGt2FiriZ28DYpUx8JA7yoO5PDQf4MW2LA9aLbYhi3VZ7V5AASm9I
 MzR3Paet7UCU8Ra7GedvPwjyySQgxTdTlM95qy4NL9hPeXdIDvz6dj+Dpu4stoZoP3tI
 X8+Exf1qeE8y51RpacSqTNf39HWj5S5D3PU535ujhylCD7DUqJn6DwdIl6//+Y5uBYgl SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aag2yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 05:40:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24I5aQfS018054;
        Wed, 18 May 2022 05:40:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v9ds4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 05:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOKVUDOwZ/BDnaKaeKz0TTuBf2db/t050jKdRK0F/8rHIl+SjHCRghzFJFMyegiKupjnMfvrx8brXGe5bsmyEtUa3jkgNh502+GaGG/HNLXz+a7fB30fYI7Fql0gY7KPPxs4DVt05/3l6sDMJftDCyVsBCOTkgQNm8F4Q2FG6kHrMBBi+1LFnA3rmKLVo4F5HlUnUc7sZWVkpTPgyJBpZMiRl5EhtCqgzZ99l01EoNuDvfzBS1hCcSNzKsCBtKui1bXb5HamYPsLpRjh+OY1IT2CM4yHgM3R0klxCtYkz0zDCaubqTbRwZrk2pazhFJrwM0E+wU4VhZZHmNvGtxsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8j58ASuGMDu/45JMAMRn+nso/H2DxHiymllBkOOKA8=;
 b=VhbYzCyJXomw5Xjcs565VHhPC8iczwwo99WTuRgF9afdjBCzPf8fKWuBlmbcupA4CiiAnGMkw7pCVFf1pzCy81+e+HkueXWN5zb52xHJXCjvqWfMeSwSC95OWa+vFF8Z8IFHkBKXmBoSktLWSFMR89HmKEcLTrwDtauyiOP0UzyQUiD7Zpye6GypTcdmC/z3m1TPK6zPpb1Ue8lO7YPSCiFrBFTHWCrs1b2g600QZ2CaifEfr3ThDtBK/Y8SXOoSiB+hyaVezeb2R3NxixdnMzu2gk3HXaV4B1YNqQbOgw0awDuuE13ceQ7ZWVXnxrq1Shc1lAFogyncL6YqIxn8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8j58ASuGMDu/45JMAMRn+nso/H2DxHiymllBkOOKA8=;
 b=gu05c3C8DwGbxDwDbjprnkJXpWCap+Rr5tXpt7VWUP6tvurJ1FlVBnS37Da4a8Nz9aNAn+p4R2r2QBfgyqmCwKj3tKh/2a+s1jdiAhspY6EHFr3e8uOA5FxLNTG37xfWTP6Gpiut1wGU+TB8J8mNlpNIjEW9DaYnKYbsSK5KMBE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Wed, 18 May
 2022 05:40:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 05:40:14 +0000
Date:   Wed, 18 May 2022 08:40:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Uri Arev <me@wantyapps.xyz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: axis-fifo: fix indentation according to
 checkpatch.pl
Message-ID: <20220518054003.GQ4009@kadam>
References: <20220517222710.678033-1-me@wantyapps.xyz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517222710.678033-1-me@wantyapps.xyz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f3c2949-7b0d-461e-db88-08da3890e1d8
X-MS-TrafficTypeDiagnostic: DM6PR10MB3851:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3851B1FC82A67ACC3D13C2EB8ED19@DM6PR10MB3851.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLvClC2bHp/EyH0Mmf81D0MYvuk4U3EBapcRdjkM3sX36iy9S6l4hmJvklXR46VSxlzzxmZgUjvpTCCX+kaUDQ2S6HR6IOX+/TxOEHzzAfW770Rjh1Frh7zhp5urJ51zFq/XKGHhl8jp+VvHhf71D0w4FGpqrqibz41ioNcDAoD26se76IUhMUUpAEMYKitQBP/Ik9+kjPoTv6IwC9ZH6vrDEY7Xld8HV0jPv44DL3s/0uHToKM9n8i+C+l6xJJ/EmZ9ZCHZN9rxF09iXYSuoJg1WaG1y7/NyX+mbFd9mfIoEJZdKH2tMi0NFZiafe+3vS5klIkPYFqPrnIypvouwpFtMlT+/gJbdk8VXf7L1OLACvyVsyHjKAcXaL7xdyTW1b3xuN0Fse1g8YKDil8fmVu02/fXzT6Z+pmP8kxJe0Dm2YTXTWJQlK4Lym1iJ7rdmYvknf32UfeLWgcxGg0BN9DPZjFBc6VLfhpd1bxgVkN5klb07H19Xj2YjEmezK7J+6R1H6Fwg3LypLjN8G0k3c46onsIPKTr/Q11EaltE9stc7k3wjHEBOpF9SW4f/aCW1ANBMGIRvLPoCPn3MSwFDlvzxPJhKBxnIXc7+ZO+rTssNkjfPP9sADE+pgxG/N15jBmVszC2ld8Bz2824HFmE9qCqPswPWwX/QU6Gj9N0164pdRAyCLiUl1NbCR9MQzdRPxZx7bxeW1zyMW89RyZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(6666004)(6512007)(316002)(6486002)(52116002)(9686003)(6506007)(2906002)(66556008)(86362001)(33716001)(8936002)(508600001)(26005)(66946007)(4326008)(66476007)(6916009)(186003)(1076003)(54906003)(33656002)(38100700002)(44832011)(38350700002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wKGs04Lg+GXc18qAxLa8ewLNt7mS/p3oZXh37GLYg/HI2b+hzhHEdxFhPd96?=
 =?us-ascii?Q?SKnsJsWiytCVfLi/4cTRJ09HM3V2bzNWHhoDLmixTGWosOF5E76aoDPwdINU?=
 =?us-ascii?Q?QdkJdNZllG/7SdGCP8894NcXH+ZYftr3IXLP3QQiivoadpkkFHptCdxnklpt?=
 =?us-ascii?Q?7haLxoewtKAQkUwC2hjFcd8Mq/zkrS2no/7PYmjH5+mJ9EADP2ENz28FzAYU?=
 =?us-ascii?Q?41KIbLXEb2NJVoeU3Zl9tnftqPjh/hclf1d7H/bH8mUZRLgt1IKhwRsFvnPb?=
 =?us-ascii?Q?yzlCyVC+fLuCj8Ft9+lI1Sn/gNqX112YSoCDBIqWQAZwVrHhGBOYnD90wHVn?=
 =?us-ascii?Q?53Q7fVWUYsjJG3oU0lHD9ZCIVewZ98ukzUe//EZIuV1gceQhNyqHQn6seEr3?=
 =?us-ascii?Q?+OxvAOQjuPyO5ls0YWDWgayt+3AfhvQ5nsooNKGGfdxVGgrT277XjrMnk8Fw?=
 =?us-ascii?Q?GjmJzvBvV3a1okh2Otq6wT8KJK8vln7gr3qN7Nv23Hf/9cZzncsNPs/5bZ5b?=
 =?us-ascii?Q?WM66KcnA0mz7R7mSvf37DgeF3WhruL1UVH9+EyzAm5icMq7hsotxcR4ICEAW?=
 =?us-ascii?Q?Zsgo8C6olSe29k13PLYRBmUknIJC2seSkJaarP3k1nXGsXMiZXex19MfCTAv?=
 =?us-ascii?Q?VIMKdJz6e1kD/Wj2VHr0bCg+XF+pC78FoIvhh/s5zlRxHjL2Kec8Y1Zn1pgp?=
 =?us-ascii?Q?y5Ug3t+uqstjNQ5YGn/zFfhw1R1GxYGOg0O53eTX4kvF0BzCQuRHerSKcauB?=
 =?us-ascii?Q?ouos4jLbWW8TIYQTIGLHTE8qigLt9vtnZ1smb3Yy7rXk2DkLp2TqoyfP5ALF?=
 =?us-ascii?Q?LObrzu475zZrFH2uzSscXAGoYgkJnTQUP0105yTiYuNAYnKOVqdp8dw3QcDg?=
 =?us-ascii?Q?rkuJVslts0ApCiFoFj5NTSlKzcKTQiTD+7/jyiZPDNIkhFRwuNATf6D7NjPs?=
 =?us-ascii?Q?4gjJ63tVWYKIvsg0y29kId1RUOUWqGjf16NFQrKzTPgST/ZtZsr+F+l0FjBK?=
 =?us-ascii?Q?h8hgvMbzq+0d8YFS4F+ZiDURB0sSKKJi3IUvTD2R5nNrZWeXsTE+tchrQAS+?=
 =?us-ascii?Q?/eaF4zSG7E75OT2B7lLrCvQql2VeVsSZorVogjv4UTe/Ex22y7OBTwX8LvG6?=
 =?us-ascii?Q?qRQqP+kzZKqHeI564DiTm4v45pY9ZCSzjxK8yPQHIu0sAYiRgr5iMpLcPK67?=
 =?us-ascii?Q?TfQzIuwNuIRHcuTCpkRsjXrpd01edupMeCNENMSrXXpcXTXocTK4wC0R8qvm?=
 =?us-ascii?Q?nbpHAuTtMS0yVlg0bafHEeFGheExmcN7V3BjJQ1VAoEMU0wo9XfjbLuRn4zQ?=
 =?us-ascii?Q?FJVIyptDGMAtRwhasxv/ROSeq5FLPeZ0+CoAH0ZigKDJ9bJvVHknx3n2WAo/?=
 =?us-ascii?Q?LyE+IPxgmWM830Jz5dC2P8Mk1YOEqW9ka5c3yXV2eZFys/ColuYVl/aIVmfy?=
 =?us-ascii?Q?ClrP9Nr2iWJjboDfpY1QM3CnjnjPULQte8W7I4Yqp3RBb4Xkg6SJPw9xGIEu?=
 =?us-ascii?Q?weCIWidUZ7xyB4U9epqRReVeBorLwt14VXyNWbPFFctZ3DTVPuelw8LTMMXv?=
 =?us-ascii?Q?ubQH6Nu+5Pp8zxsyo4mC6UCTaf9cn9zBbV1VrekjK05HknJePEvJgrj+v8T8?=
 =?us-ascii?Q?4mLoB/DK2ehx5YyrjfDmlbxpCgHepu6hOq4WCJPAc/9bW/9bvvE8tGnFeQF9?=
 =?us-ascii?Q?msZUPMmHy+6nco+GujdClsRD8Pq9vKDCnjF3z2siDtM6YREst82h6Lza473A?=
 =?us-ascii?Q?THTorpaJcjJ9P5Zx1E5lFS84009/WrE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3c2949-7b0d-461e-db88-08da3890e1d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 05:40:14.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUYL4iTl6OTGn8WWQlXMkbCzPj48P74GJ+Ivr4Nm8h4AElYGGUmBAtEWIBKoyG17j0xLudhoVgHPcRWBkgJtz6Wp/oHceePlVrPoSh4ZWm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3851
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_01:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180032
X-Proofpoint-ORIG-GUID: 3rKH0_B_1Z9AK9zEWiRcIMFcXAvXJ0kz
X-Proofpoint-GUID: 3rKH0_B_1Z9AK9zEWiRcIMFcXAvXJ0kz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:27:09AM +0300, Uri Arev wrote:
> (My first patch!)
> 

Don't put this kind of stuff into the permanent git log.  :P

> scripts/checkpatch.pl warned about an indentation problem in
> the axis-fifo.c file.
> 
> Checkpatch warning:
> 	CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Uri Arev <me@wantyapps.xyz>
> ---
  ^^^
If you're sending a v2 patch then put a note here under the --- cut
off to say what changed since the previous version:

---
v2: something something blah blah blah

>  drivers/staging/axis-fifo/axis-fifo.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index dfd2b357f484..51ce48e68e27 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -383,10 +383,10 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
>  		 */
>  		mutex_lock(&fifo->read_lock);
>  		ret = wait_event_interruptible_timeout(fifo->read_queue,
> -			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> -				 (read_timeout >= 0) ?
> -				  msecs_to_jiffies(read_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> +								(read_timeout >= 0) ?
> +								 msecs_to_jiffies(read_timeout) :
> +								 MAX_SCHEDULE_TIMEOUT);

This is too far to the right now.  It was basically fine to start with.
Just ignore checkpatch this time.

regards,
dan carpenter

