Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBBD535B64
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349499AbiE0IYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbiE0IYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:24:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C5934B95;
        Fri, 27 May 2022 01:24:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R5xXKI023346;
        Fri, 27 May 2022 08:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HB2UNhvzIStMac7Qu3/+zQBxsF+BtkhI0Y6hDZcwUbE=;
 b=kJt4ebYk0Wj15nOiKZ1KkZhP1gRGp2RmFXUCaE/Mb8+3VDcyOvsIdX/NtMlX1JIzBowy
 4231sKnzEuy74cYtKr1Z3WEboc4WFFNzNYAbsT7GWnHUvmcGXJBOThaPCkSwwvRWrfnN
 barDeOti9LHyB34xsJ45UHGSocgeDlzntwHtSVIIrIrtsnnjIu1B8Jn/DH+8oXp610+f
 bKE1caVNjQUYZdiCnbTTjjPwl2SEGxHRF6pcu1Fk3wgAWNR9hMVA6xjjCE5kugkUhBUJ
 dsobj1iv+8tjDDinAhyW7F1HVth9UrnwKcnH6fokfRCB/s8iBlpiAsSotw6w7FOqXlE1 uA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tbehjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 08:24:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24R86Hdp013259;
        Fri, 27 May 2022 08:24:18 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wx2tan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 08:24:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kkt9725iTY61Ase2YnGOaqAvksE3aZkxo3dFI3Eh1X8IYznD6W0uTXVeZZR8cDnXxzLl/4SGoKvkyln7QfxK/65J1AFN1VIFZ+LIf9seuspNBa866nedJtu1rrR836NBhMUUX4xDtzxScXDScyUB5H2WZs0paThF/LDZCS1NaPxwMTnl1OQ479UejlzRKK4to6svegGkhM/cLAsyYDfawGflMkS9y5tHlPKeij97ygEotbQuGja3UCr/HEBI0dWyeQLAmJnuCIle1kNgxdWQ2sqP+nIZ5j8BeOuIpCmDZCNtNQvz/+qyjEjBmDn+9AlLzU0+IsYjAVuO99bt++gnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB2UNhvzIStMac7Qu3/+zQBxsF+BtkhI0Y6hDZcwUbE=;
 b=XPb1AOtMH9Yuv1SpdxKbVe22SEn4T6gG7NpXDobHqIZG56wL04Z0cT+YqCTm1k7Bz902i2kWBmPry4YOXUZoO0b7gf8J+fN3Z4qMjhhe8E+AtjCX3rC4rRJ+aYEhZPOf49yFpsqtshrik+bKc/Dj5Ys3aXYf1SuBB5JFKO5Fuljgfxzjq2NY+XUi38f759p3bLDztXUOjjxsBJ+9gvwJHyoX57swirwJyZBJZ46urGeJyJpALOP8b+213QxumjPfa9M6t2NYw6De8F8l1CtG02HPi/heMA8NBfIoemOTWxrUy1Hvix7T8I6HZX5QSwQ5wr8TIEtkqbcXqOMPtiIEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB2UNhvzIStMac7Qu3/+zQBxsF+BtkhI0Y6hDZcwUbE=;
 b=EJm7ztxsAeJ9ewO1UHj4kpEWBq8urdYP8OYPu04TcwcFx+r80ugXmUbl2ZRiBwoToYcaL1AE4Ap6HhWeP1mku9zNa0i+1s381h/2zzI+sbAkH7iCauzqiD8OnRzHgxejaV3zVsWHAmPyYPWlNHhfK4PeIhVQA73buX6RzdLGXxg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM8PR10MB5462.namprd10.prod.outlook.com
 (2603:10b6:8:26::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 08:24:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 08:24:15 +0000
Date:   Fri, 27 May 2022 11:23:52 +0300
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
Message-ID: <20220527082352.GP2168@kadam>
References: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 299c5059-7bd6-47fe-74cd-08da3fba4995
X-MS-TrafficTypeDiagnostic: DM8PR10MB5462:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB5462F5C69369C397287727D18ED89@DM8PR10MB5462.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmJtKhjW7ovQEl9Ab8xskI11WaVa1YhdUfXxzn/aJvIUHf0vZueAZm5clG2s8oDYMYwIfSdw2nARf0ngqkyvUbK5Rgan02ghoSdwL18v3ZqWPyAzhMNPXlAGfl+q9H6SgwuwKNv3pMt20yqEMDgdFSmQ2OvqEQ9ehSFTeBLgOnnq3BHK0hF/AinpiBQRu8NKh1O5R4Gut/uErquEkOsW5EOBZye+/c9zBYZGMMCmG2kknN89E74Tp1Z05P2ReQRROCfSf3GoWmWSw+55wfAAsXWeZXB3KztdUhbUdqq0gP0ZkJQMOJAegj8oA+YhcUmnrsS7yQLOHeaF06SJ3vXq4mEiUBj7SKGvLwTmlyJypXhYEvp9AzuxoZkTk6GrfB9pJt/u1AzRPRZC9xMPPbqa3Uyj6yrPSjdWybbC1ONR+N5wXSxEjVfAzgg+wGazC+DJbJuDf3w8RtwlpPZjiuDp6I1etcH9Efd6nsEjJQdHccJRtqqz2GPPG/sIaQjvMybuTuuesdN7Rrt/TeQyNZycbapi9w3a9KNW8Uc7DCQfwWi/fImfEt6A5foUP+MQy/sLUgMsXiwJaVq9wV9AOjPwf4SdzcUitin3zhi3/4FWR5YMcDobo0C9bPnCiSOGPMCqX0AUK8QohDFTDCPXh+QQ1twhyhYRIINiShUB05RTizIQY7VrLzrs0uQwKMpargON8v1DcJ+9C1K8IzPocMqikA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(66476007)(186003)(8676002)(4326008)(7416002)(5660300002)(38100700002)(6506007)(52116002)(4744005)(44832011)(9686003)(8936002)(6512007)(6666004)(86362001)(33716001)(66556008)(26005)(54906003)(316002)(6916009)(38350700002)(6486002)(33656002)(2906002)(508600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3GNvNDu/6rfd17USS/E99O6kKoQNEslnq47DHSiR4Uux8oxTo8+k78lsa9+l?=
 =?us-ascii?Q?SVxP/ATxfz5HBAGX9WK+gvlOKUE4/nvZJX4MOyGphDI9XjvnJmLbqzWe4rlx?=
 =?us-ascii?Q?bC0QvjGyWTomgJRLyvGCRL+/W8Fe+KOTkWJdCjHoZNXFseIdclPj+iKXZU20?=
 =?us-ascii?Q?of7zhMd6wOi0KVxHUxzgNarowlfcpHgM8qTm5Kr4y5G0ikDg4XXJwodNbx3x?=
 =?us-ascii?Q?kmJQPKpVUrnLwQpp1SdskCFiHLhizRrGbFLNe9B966EimmYn2VLYhyjOGsfr?=
 =?us-ascii?Q?wMcg0tTFTlkhbOXf9WvF4LSg3jroTJPo7zotsWYSxUiktYpyOK5z0Sns5CzD?=
 =?us-ascii?Q?j5rEVv81SFcI/FRdR4PObv+CwBSmbk2YIK4bAg8awESfLH4e1zDhx6Q8V7FV?=
 =?us-ascii?Q?krk5lnXKp9/dnYF4nid3+Vf52KUz71Fe7uzVGygOh3jJeEfR0/nkIv0JgCUn?=
 =?us-ascii?Q?B62jd9ccYoAyyYCUkK74vUuUWDbmaIjq0Ro8Is+pSWxjhw3xYNbTWPQst6cS?=
 =?us-ascii?Q?r05L+zUeAUnQJoIxkPXHXV2M1Z6LoTvlXOgfrCWsuVM3q/UCZDjj2465c8qv?=
 =?us-ascii?Q?tv4RrYfZluji1uImfZPcNQhEi8rvjJba8f32uyqd/UQTQ0X5UaN+fHrKoNgd?=
 =?us-ascii?Q?eTrEvXSE+1BCG2cRYKy2BYi1yWEQftucXQaCmm+b5Xo48WNRkSPzYfpTVKrR?=
 =?us-ascii?Q?OCgKuQUwJixla9Gs494lr7MJFDTM5HPc9U05GoXtSK90BHuaHCuFUC3MZidJ?=
 =?us-ascii?Q?ECkcmlZ6FRqs0hbYuqV1SbQPceSCOEQLLg3Uq0i07Bn7s3B+76R9n5o9kOmq?=
 =?us-ascii?Q?juuE+kRbBCLbPSiK8JYc8344StgD5lmAFzfIjEV0d7lLYhCexdgDKihuyv8U?=
 =?us-ascii?Q?aXtoMSJdgGVcXzXBRkL8YWCdviK8CX46LXh3K/tz70EV8FzvhRQpEQVEK0vk?=
 =?us-ascii?Q?LdvAVy3V1P/5cVpusfWBe3Zrro+Nbdrmo+w3wtzkz8iEZ7pmcn9XexT1ViJW?=
 =?us-ascii?Q?cgL6FfA0OB8BvMJt0alfnB/uy738aHJiVflJeQr12fnTSDQeDWwTQnEFklDM?=
 =?us-ascii?Q?H9IBOkRo5kUkgoZizrOgSmRw7Zql/NXEdBch4ODwpe3Xe/2a7mhOB8FG3CDf?=
 =?us-ascii?Q?nAHQNx3k9sX/VgZQEkv7fRie45u9W9ts/J2Qm/5BTqrDDCZLn1jDu9fLR6qW?=
 =?us-ascii?Q?heP8oc+n9fOVVV026R0cPogT7jQciHCGPTtw+DzI8QRSg0j5Q8aueuP6c7+a?=
 =?us-ascii?Q?ZcHNxUe1DwBkMLXVnytrQhap/DjHtDs+RluNPeP+P1o7XNqPQTVecAc/H4vR?=
 =?us-ascii?Q?PkFXJV993jO7QXBG0mVERjTACMJ4ZbH/hoh8TW+SnEuFi/wgnrOPm6pLKG0q?=
 =?us-ascii?Q?MMhJIyr7ag69loxxFUNg4rqjSbEsGsEWzyOy17vxRM3dxYLWUfmS0QUa6fa1?=
 =?us-ascii?Q?Wsvpp7Zu+G2GhzllqK1i+2XdtOKKMtGAr0MZRj3owkfpDOSEPozY+IBxaISd?=
 =?us-ascii?Q?TyU2owpwavGdrx3stbX0QFTg+ipXFWI3kf0KfbgMmU+KVrYgEjb30u45bXdC?=
 =?us-ascii?Q?pnXst+h6Ts4B0WU2nWUILcUZ+5GVAImjJIicG+oY0pG7KUUPx9kKp3/20iYp?=
 =?us-ascii?Q?ogvllHhB8VicqN84+yudhAsDMbgIQdFa93HCiYlnpX841e2Gq5/RGyGNhCzt?=
 =?us-ascii?Q?ChB086F88gj/E+Q/XqorGH40kNuwmw9sPzOS8i9kmm48Yr6WquC5d+CLsNdU?=
 =?us-ascii?Q?O5YgrYK/nRaTKqghlZlqLJn0EKXu1CA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299c5059-7bd6-47fe-74cd-08da3fba4995
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 08:24:15.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rr8INVbquk08DkzMWyhVdiLgD884iUD+/fQFIdLwZEmU1XAKY5TjK+9Xt6Sv6lw61rHTStKVRxOgmECfWAg39WCwpho5bE06R5I97bqdgY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5462
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_02:2022-05-25,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270039
X-Proofpoint-GUID: oRMevPDBTkpvcHs7L51x9uHoAiMZ-L-N
X-Proofpoint-ORIG-GUID: oRMevPDBTkpvcHs7L51x9uHoAiMZ-L-N
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
> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
> index 9cba2f714c7e..b91401929fc6 100644
> --- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
> @@ -1605,7 +1605,11 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
>  		if (!strncasecmp(val, "se", 2) && strchr(val, ':')) {
>  			if (has_se || ucode_idx)
>  				goto err_print;
> -			tmp = strim(strsep(&val, ":"));
> +			tmp = strsep(&val, ":");
> +			if (tmp != NULL)
> +				tmp = strim(tmp);
> +			else
> +				goto err_print;

The check is not needed here, but if it were then the better way to
write this would be:

		tmp = strsep(&val, ":");
		if (!tmp)
			goto err_print;
		tmp = strim(tmp);

Always to error handling, not success handling.  checkpatch.pl --strict
will complain about the != NULL.

regards,
dan carpenter
