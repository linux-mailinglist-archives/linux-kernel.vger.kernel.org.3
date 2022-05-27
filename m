Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4832D535B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbiE0IU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349467AbiE0IUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:20:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0861A104C9C;
        Fri, 27 May 2022 01:20:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R5tgSn023362;
        Fri, 27 May 2022 08:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=y9SnBodKbkouPME3OSC2WAHLOjG56Ty3G4FXFA7hd1E=;
 b=EEIpNtso/gho3BAHCHJmNRRGy52tYgkYem8myMeMk9yE+uaM6U/CFhMnTB04WV+uurD1
 r+y7pnLVXQzviqEUa1I7RC9WsNqB/os8FWqbdvYQ5+sUeHqy5QnxTCjoF9vy2MvSZ/B/
 PAH1hqR024CfZ17XaQtodG9hGlX9RzmPIO1V68SHS3PcKNdtiQYIQQOh/bxvqiNY3afS
 U109KR6dzDyA+rvvjQ3Dsn7ZxyNMRLhvMY2MVNHk6RZyRdnDsV/vI2p5qy1wTxsErCsX
 PbVBPy+XrHEbu8OOaBL+BSpjkymde2V/sH6xSr0YPSZ3us3coUyPFVpoU4wvZvBIxGG1 8g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tbehaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 08:19:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24R85wGk032586;
        Fri, 27 May 2022 08:19:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93ws821n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 08:19:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpcQXI4nmqX8p9noVX74Zx35qvSXK3WbPQLQOUJiFveiL629lqlxc5CUTc+iKQpOwNWEJRS9AlEFCWZVxHVcNYEi9dIHIpn6J5O4HHgyWi263Knj/5w7rBpwi3PZglwEPxJDtTWVwdpegB5idP43/W1/zfYZZLelqDEmQJcH2u04XqrbJeAq+BcJWDqoH1v6F8B27m27z1ODfTUgZ1sgaZo2wKnSdtSvx2665EqX+6PFjys0S9z5TMAufPr5kELZaZq+l7U63bKPdv9tdjQ0TOVbMydRtxgZBwlPqdboDwSZp9oC0ANaOZljoVhMNiRQn5rMxIIM8QpvRQHc4mFRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9SnBodKbkouPME3OSC2WAHLOjG56Ty3G4FXFA7hd1E=;
 b=Yvd8aIELNuuKlnqfa3n0PvuF/X6pN9XYKLTyW5BQG7MICRo3lapinUIQ915kiti4kSMqOCsWAerilkjWUgSAKxbIMR7YZ02gTIaKVfSPY9LmWk0H0nlSv4wMGRWFLLYSTYpmSbpHM437O/EMRKCRTb1CL2gJqUM6MO4qXgd118MJPQgKUSmimzzTdWWmS2FYt0c/xZzAacOP9bylG7lhwD4oZtAPuqjkTsPikbHhFXhUUkGQ0x9wPwmu8+4Uk7Hab0BUwJWTW2f5DpUjAwdDxvwn/fzzrFXrVFpW3EbHWP8Fq4ylR8pEs4QvqBP+3c9Atdo9tpbb+YLXMkX4HFkkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9SnBodKbkouPME3OSC2WAHLOjG56Ty3G4FXFA7hd1E=;
 b=fR1T+3vPqgx7TjD9cWVSPDGWgVdUM2eDWBIY6ny3T2i5PAgPBWq1+9DwGCsrNrCGy+zjujBWt7Ic6OAaoEf+frZfA8hU4FORYX1Wr/pGwkScBu5i3c1UJSNVqgm5otBoQ+qrLb1Y1khPw1PqX3DARY/rTabZh6X57Jw1iww1IiE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM8PR10MB5462.namprd10.prod.outlook.com
 (2603:10b6:8:26::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 08:19:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 08:19:52 +0000
Date:   Fri, 27 May 2022 11:19:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shijith Thotton <sthotton@marvell.com>
Cc:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-crypto@vger.kernel.org, jerinj@marvell.com,
        sgoutham@marvell.com, Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harman Kalra <hkalra@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: octeontx2: fix potential null pointer access
Message-ID: <20220527081928.GO2168@kadam>
References: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d043ab5f-bd4a-478b-4b41-08da3fb9ac74
X-MS-TrafficTypeDiagnostic: DM8PR10MB5462:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB5462DA49C0D9B0448A762C4F8ED89@DM8PR10MB5462.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jn0TzPF0fvmvsIgJETdso75KNhJ+ig1k3H7v6OYN1ghSnecbj9sDKgSvB2ikHVaU3Vli5gNKyIiIL6Tt9jtElJplxdLEkSRZe8eGnzt1nEzv91hgrbNhMnt6bqUL1AY8l2uTu9DNSeT4BPBqxqnmKi7dnJ8SfI5E7TTzEkMmL8G9mDEUchXtXudAkjUl11+ERRKucInRKrrjnop5fZZWapfFjyB+rCLrSyPDoNVGhDqaWaOqwJgEbxMc/PPnQu7h1NHCfCazcF3yJER2chrKHAwwLHlGfDMfgs7Ll7HUHEwx1tiIsavlKGsSe/yrT0A2j3c/g5o9j9lJ+rAzl2f/C7Wi1zhDh+cd8oA7K66wsMxf/e6cDDS6g04ulxNSRY8F1GKQi60WHf9H9HX8MO/Kw3Y2ZAEGdEU+1i5zItFr7e95Yw1hAiIlEKLXoqBZJ4XQGLd9MerbO7bay/8xHzjom9lz0GO0q5/c0q/4hlHVNDtlp4a2dEkiDjhAOkoBl1MWQnDXSZOs52zsnvizivy5NNl9eIW53pUi7k9CS2A3guFl3g0snBxbQHx9zJnKioGcn20EbHHzHYYmi8q3//Vy3vzZBWdI90skY+VsZ28aj5sqZrQ/eFLKoxnB1a8v6e0FJ6YVv6W1xqWkeu+fo92U105WU8+PNezp/RkYDFcI7RWV7OgIKtvOGbxMLwjjf3uXbyZf52hW12Vs4FyAK5EHcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(66476007)(186003)(8676002)(4326008)(7416002)(5660300002)(38100700002)(6506007)(52116002)(44832011)(9686003)(8936002)(6512007)(6666004)(86362001)(33716001)(66556008)(26005)(54906003)(316002)(6916009)(38350700002)(6486002)(83380400001)(33656002)(2906002)(508600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQWgLBCc8UcQREVqOiGHXEgNlPkZJ35+hrhzSM+B9rkDHaEVg0zsYvBft2CL?=
 =?us-ascii?Q?gWnSjwr458Sc6MG/6cuWA8SGOOt1Ab4phIBx3JklMAcJA3/H5bTG1iBRP/s5?=
 =?us-ascii?Q?TbCaLh2tLHudqvxPjbixL/2l0M/SnXt0S17lhkp/JFvfeclwh7CIkDhLb5RG?=
 =?us-ascii?Q?oxucXGrxheYxV3Cxhv4ElgupSDAuQq6YI3JnwkslnQMIEmpBN8fPt2kpX3ST?=
 =?us-ascii?Q?zLii8Yp41yhvKx27fumROKQUF2SwXa9Owl0VQzioMMnY9DLVGcVI9l4r/+Q5?=
 =?us-ascii?Q?XAwzPS7+KHtkwvQsYT+RI5e/XENz6ay4sL2q3bAusT/pxF+7f7KkldReCW+L?=
 =?us-ascii?Q?mJrTwfOHcC627uBOJhY/6USDGU5dricA8kTKiO1BQQS/05Ch8upn92t2AJn2?=
 =?us-ascii?Q?RUmd7H+xeUpATeHSyNBD8J/evUiel39rF0k3Th/gIrT9xHEc8BSEO3axeLpu?=
 =?us-ascii?Q?ozJ7oYvLzs7UVgx3w/ylmwnvgiCzFjq1KdvHL2lQg5iJpwPrbgPrLgZOlO9V?=
 =?us-ascii?Q?iqMaNa5AZ92bTsxgCXYE6yerLVxkZh1nRO4VfDJ3AATez9Q/IhfH+g+pu89l?=
 =?us-ascii?Q?j0Tn/YyE9tTLFONyd9zlIRMWuQnmHDqEYxLG8zL+FII9k5cXftkE9F5R7ZGL?=
 =?us-ascii?Q?/Xt6/xXQk2syDpXnWMEbe40ZCvtPhbKN+VQXHhqD2IkzLwdLo0q7g/1BDZ8+?=
 =?us-ascii?Q?QWdKEhZ1C/zl7lgLX3YvaHdzl0bZzntCpkQUQNrh47rW/M/gFdxHOE1RQaJg?=
 =?us-ascii?Q?0MuRoPhJwOMGZ54GG+a4euzh6bhZdetrzLtPi1LUPYVR7pS9CHlF4myQM220?=
 =?us-ascii?Q?NH2IQxg7bcDTlBeYI2My1pqnMj6QMBiLJHbGzTp0fHqih5loxiGTxGoIy1d/?=
 =?us-ascii?Q?fCvqHwo13ZBGAm26Yb8x9K306o9E1grM96YJaUHIeqOierintfC7+68rud+Y?=
 =?us-ascii?Q?GKtWQ0EcxH8e9yuPBHk/AhcTaNgnp/G7+2KDzldlwq/6ucRO7d17ki5RvO4g?=
 =?us-ascii?Q?1Z6r5FWQZdrHA5DwEep/tPIAABqlLWMeZUDiCy1qzOwSXERJ98kGLdGE6XeS?=
 =?us-ascii?Q?oWyxvylnmzCt9slR82NEDD4+ErERYUkdVnDO+8375xoeXWUig6vXoPT2qVhm?=
 =?us-ascii?Q?8q/I+yvwBnSfLl0Y790O2afc8h5M1HbvbLvGD6P2NmPdWkws1j9ujhK4E4XK?=
 =?us-ascii?Q?7Z+L2cx1QQisHzRNLi4lrEkgAhjQzrMb0uQN5LFqlkuNQQ2jRJMc5F+fE64U?=
 =?us-ascii?Q?LyhNxrrgwfY8t2nQ79fXoA4eobweRoILV0srZMpAxUa6ZebiOGj00wZoi/fn?=
 =?us-ascii?Q?gyGQKyQP542rSx4puiL1EbLwrjb9Ex7HC+ikVYhaary8s8aG66JY38Cegdb4?=
 =?us-ascii?Q?DxMlPUjfXoTa9EvuiaB2YVa5oZk3gg50128wJcZz7PbbwOrZoY9RM0ytXa6E?=
 =?us-ascii?Q?KiJMYScnnOrXg6JxNJVd5b1p8E8+7CdaBB7GcWPTtY2Piuo9OT3/zxD7lZOk?=
 =?us-ascii?Q?aJDLPTRHNENoFrvTT/ucGQzoAhog8cvqamOiFBupj5NBKKq3UArjtUkuOZjy?=
 =?us-ascii?Q?fDBlU+73Uyc+VgAnwCj9xCLR3VYHEeB1UuTWNQHIW6yvN85cJWHdGyBAkDj9?=
 =?us-ascii?Q?usRwhjOpAl5rXdFQJSG86Ny0qIcylWP0Oke1TGtMHd/uZjYIRelfAcXYIXsh?=
 =?us-ascii?Q?2i797jgsU68n1BsT9jzdY2zncFXscKe4Mnr46MDmDvgvd3S5xDPxWHBXwCVb?=
 =?us-ascii?Q?9U3L1kfQi8/w2pqy3swCxNxvSp3LBFY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d043ab5f-bd4a-478b-4b41-08da3fb9ac74
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 08:19:52.2086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+LaIRnCThP1fiMr/MCBpIsaanF1cymOPrxCmOsgty1G5SQSf2dCke2eONSyHXhMnq8yDsyydrxlcgOM36+AGwmqv/FD7iK3DOkkUs64A9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5462
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_02:2022-05-25,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270039
X-Proofpoint-GUID: 0PJXy7h76jX5vi6r4qXmh64UiyHvX5ZB
X-Proofpoint-ORIG-GUID: 0PJXy7h76jX5vi6r4qXmh64UiyHvX5ZB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 01:27:56PM +0530, Shijith Thotton wrote:
> Added missing checks to avoid null pointer dereference.
> 
> The patch fixes below issues reported by klocwork tool:

Don't fix false positives to make a tool happy.  Fix the tool.  (Unless
the patch makes the code simpler, then it's fine).

> 1. Pointer 'pcim_iomap_table(pdev)' returned from call to function
>    'pcim_iomap_table' at line 365 may be NULL and will be dereferenced
>    at line 365 in otx2_cptvf_main.c. Also there is a similar error on
>    line 734 in otx2_cptpf_main.c.
> 2. Pointer 'strsep( &val, ":" )' returned from call to function 'strsep'
>    at line 1608 may be NULL and will be dereferenced at line 1608. Also
>    there are 2 similar errors on lines 1620, 1632 in otx2_cptpf_ucode.c.
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  .../crypto/marvell/octeontx2/otx2_cptpf_main.c |  9 ++++++++-
>  .../marvell/octeontx2/otx2_cptpf_ucode.c       | 18 +++++++++++++++---
>  .../crypto/marvell/octeontx2/otx2_cptvf_main.c |  9 ++++++++-
>  3 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> index a402ccfac557..ae57cee424f0 100644
> --- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> @@ -703,6 +703,7 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
>  {
>  	struct device *dev = &pdev->dev;
>  	struct otx2_cptpf_dev *cptpf;
> +	void __iomem * const *iomap;
>  	int err;
>  
>  	cptpf = devm_kzalloc(dev, sizeof(*cptpf), GFP_KERNEL);
> @@ -731,7 +732,13 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
>  	pci_set_drvdata(pdev, cptpf);
>  	cptpf->pdev = pdev;
>  
> -	cptpf->reg_base = pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
> +	iomap = pcim_iomap_table(pdev);

I don't know if a check is required here or not...  The comments to
pcim_iomap_table() say it is, "guaranteed to succeed once  allocated."

> +	if (!iomap) {
> +		dev_err(dev, "Failed to get iomap table\n");
> +		err = -ENODEV;
> +		goto clear_drvdata;
> +	}
> +	cptpf->reg_base = iomap[PCI_PF_REG_BAR_NUM];
>  
>  	/* Check if AF driver is up, otherwise defer probe */
>  	err = cpt_is_pf_usable(cptpf);
> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
> index 9cba2f714c7e..b91401929fc6 100644
> --- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
> @@ -1605,7 +1605,11 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
>  		if (!strncasecmp(val, "se", 2) && strchr(val, ':')) {
                                                  ^^^^^^^^^^^^^^^^
We know it can't be NULL.

>  			if (has_se || ucode_idx)
>  				goto err_print;
> -			tmp = strim(strsep(&val, ":"));
> +			tmp = strsep(&val, ":");
> +			if (tmp != NULL)
> +				tmp = strim(tmp);
> +			else
> +				goto err_print;
>  			if (!val)
>  				goto err_print;
>  			if (strlen(tmp) != 2)

The rest is all the same.  Likely or definitely false positives.

regards,
dan carpenter

