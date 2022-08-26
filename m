Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840B85A2B07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbiHZPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiHZPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:22:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9CDD4D7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:16:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QDcjC8024532;
        Fri, 26 Aug 2022 15:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=eCKdWAZgilYpROrkPEgz5sRh5fTR93yZhpxj0q2UUnQ=;
 b=slleDr1YPoRDbLjKRIWJkVwW3+GCVpRAgxmBDgnkJ36LHs2IvQ/szbGdlYFTS2Egisnj
 KHoGhiWuLFLX/4EEdCZWVXT3l9nJFnNw1iblXdVJ1i5knFNNU9nLRijbeWvmr9ftwaRw
 odm75oH/FiXnCXIOr1b3h0N/0aNzmi5T/qL/qcKlo/TjQnxOyjR07wU9VGsHFl6UWhyl
 W8A6GpluTchpY0p2GwM6yl1Ub0cnWeHUj6ayQoPXv0bBCncHDtNXafAHHxotMb+N6T1C
 q2y0g06nbNUNiOAYdvkcycVouGbea7NzXIKHnmtTxj3I7n6qkS1O8fORn/rmHM4qECjp cA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5awvqkv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 15:15:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QDqIBo028260;
        Fri, 26 Aug 2022 15:15:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n4nxrag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 15:15:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7Z4B+W2J0NTnvDgREClMwMp0j4Z/uT39GRaCLnIVmc1J/q0Ks1N/PijKfr6f7CEB1fH5nH+X6sBzE0y46YGUVQr3Q8zRuptr3z1sQh4B8HTxFXh6ACviYxcSdR7dWEtdiPqSmaC2/7qYTNQvE+L2nC8i+KHnLqawUuGta9sFazvmYUuaYUrvTkepWjO3F+0u1Qy01cipGeOTmZTge7y1wwO/IrNQoWTz75seQVI66mgMEq+MEsGyGW5X76xSiQEj6bNwFV+x0lOGksWkQels4PDfyu7ZgPkulB8Tt3KbyskNJSy+sDpo+659QHl1fdk8kRIsabrqyaBXJz1zyp6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCKdWAZgilYpROrkPEgz5sRh5fTR93yZhpxj0q2UUnQ=;
 b=DBL9F5VMe+ekZXgcpXYTXfS0YGM1+DZN/Fv/mCdcnmoFTli95ZpH3Wa3D6jHUig07ukA/9fAweIARyXPX8FHGcEe0DGzUBbRG/R2k7Hv3IE0WjXzmu+jesF5wRMmDEVochPmL1s/fI/9f1kYTf1o67WyaiKYcxb/nu0Oixx9Tt+VPM7IYHZAMSzrnYEookCHoGCAFSaovoVgR0vQYjyjypqhsRESycWZLGDFsQhE9d7LcmGfzCpTQmCTcmPhe3rFlcU3zN+ELJJFKNRrMMv7jK1aS8wgQA5EAgF3SXPu5kjGwf2KI0PILsaArLFPDBK1T1eEZVs49LS/rPrQtz4ZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCKdWAZgilYpROrkPEgz5sRh5fTR93yZhpxj0q2UUnQ=;
 b=kHwuL3GUbHkLo9qCOEYltAa9m7yvvndMK604iTmjK7Oby/UFgVnlLpijmKxb8DG72uGEPS6vYg46r0hqZoJYk+QcU2WTbWajnyRdxOArEcsowyVHRW8bQ9954Bmd4qNIqqjiVZ+Eib7R9MzJT7C4jj0iv3ehTjjUoEbn3p2dfOU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM8PR10MB5464.namprd10.prod.outlook.com
 (2603:10b6:8:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 15:15:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 15:15:32 +0000
Date:   Fri, 26 Aug 2022 18:15:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>, akpm@linux-foundation.org,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
Message-ID: <20220826151520.GF2071@kadam>
References: <20220826122735.2690-1-yin31149@gmail.com>
 <20220826123257.3826-1-yin31149@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826123257.3826-1-yin31149@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0196.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48a5dc24-6069-4bd2-18c3-08da8775d133
X-MS-TrafficTypeDiagnostic: DM8PR10MB5464:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCnz/Z0uqQdjemZ1NioieQTxpz3MfErZQs3uyqUHWn2ipSdcE7KJbWKdIm1FEK1P2RpC09TQcAN96ZtMXEvgwUGk/aeNEUTYXERPBh91MOiaFbVeGoSTkiddnw2iyAs8L62f3UKUYrZIzb6M5Z7HsTUh7o8Y5QKIoPuEgdwyRtRv8RxLpxAjFc4JGxBKH70/PpodP9QuZNiYh/RlSUA6L5hUmwnSpXTFfLcozrBFs6OhNStm1lKTiL1R/sufgabyT9YruehhoXfsPzQMghCBtQriRQ0s4B36TnSXWhH6Sey7nJQbFKoHKblpgAzysAOUbiQSqwJCj0njZlajmTYaW7iEOGS4BN+FZU2sGLeMC/r6fqM8Ixslqvx9dpfoL2bKKrWZlpfcqS9pxg8nHWm1VYgDFvePHEQEI7ykqGtXWQsj0dLpp/DWBqrcmb0nOkzxT3FywmOi9IX3w4nH1/1spEJIJ/q7YjCcTXAa1H0wezlfwIVIEsr2j0pBY0T3vz6oKKJFjpND6ETqmQq6KNN11ezBj1/Tcce5kGbcE2M+QwpNSwQ2AwGN7yfzlkeglOYuPuiYo+1dkNX3MT6tgp/YJlDGKCsrf3dOAHfsBLR2u1Ys+cipHwuL5b8SK9nHSiTLydqhjDP5/8Wc0Aux4ULfWe7ZLAXkB72MXb7oYhG13WCO0YPsJyKSvkn2Riry3u7Sx3GkA2LsQXXeVCwR3nyKVt25hHPnCVhwOlq65CP6z0i2bcPsZKSsSIlqRFjgHBq9FS1m1W3THhvxY+7+/SOZQkutnlWUJEakbbpX3FU9/3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(376002)(396003)(136003)(366004)(1076003)(316002)(9686003)(186003)(26005)(2906002)(44832011)(83380400001)(33656002)(6506007)(52116002)(6666004)(6512007)(38350700002)(33716001)(8936002)(5660300002)(41300700001)(478600001)(4326008)(6486002)(966005)(6916009)(38100700002)(66946007)(66556008)(66476007)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YMHGDk4MIQbjFr4/egI4kbSMHQU3+wr+ecMppW8eoQxeOh7h3HMdq2W/NAwm?=
 =?us-ascii?Q?O5mfWh/8soW8qkGFWQ7u0Biwg1BC/J38Kuor29jhM14DniByDcmZdhLTJXYG?=
 =?us-ascii?Q?rJsK8CSID7Mwna/F9ug5iMbfPAG2bFKI1lteu/n7IJKRvtRE3PkKtJcqE99W?=
 =?us-ascii?Q?fjEVvOr0QQ2NTckrHX60Ps/OXxw/xqO2pBOJ4lqJ0v2Ijdrh6xg/RF/1EgaH?=
 =?us-ascii?Q?+sosERxUcrhNdF9wHnFMkb1+fAWhI32SMv70CuqCZ9uh8QsRz4qx4PQrOmzN?=
 =?us-ascii?Q?r9avHlDd70t9ib5hfwqpoV52IZSfrhSugbnNuBYzaUR/sC0oPBuojrF1m/vB?=
 =?us-ascii?Q?QA0aOA9Le5BDwPDoeOzKX9niydLj4QhRHh6QQhPBgBEtMcU5P7VyL+DUvLss?=
 =?us-ascii?Q?yVc9ZGM2vAlbboqRGz9WmmgoSi2BqolZKhKbJcgZaeTbTW98ObRnLOBB3n80?=
 =?us-ascii?Q?4wwKqVqZvb9lQibfNxTlAUyzHiIMM+XtMp47yahrCxe5uNz4QNSNSl5G5WSI?=
 =?us-ascii?Q?Ch+J6YPpwZ+I0n74doTkOBM8s8BdzLsbMVBs8ply2tYBJ99yW9ugzRocbvgr?=
 =?us-ascii?Q?KYHYc6L2W6tTXDvXVF76ezVDmSDVpyBO+egPlWijGjcX2wR/FnKe01j3Ze1M?=
 =?us-ascii?Q?tLcpTs41KNxCTryubh/fIz0KnDWOm+I2c24BvmU2vSP9z1TpFJXTW8LRcJft?=
 =?us-ascii?Q?8B3CP29hadBNiKagUWEYgdN/gQW55rS1dhNS9K7A2/qzVas19PCMYzrhfsWC?=
 =?us-ascii?Q?ylqdHBAJokXhLDmPL5CcjMp/of2DmQO/7TXlRiAGh+l5tZ6y6dc/X2614P5N?=
 =?us-ascii?Q?ABEAiIownAZ1wSy8B6xvI7dGt5tFjgrZtr0FwyqENys+EDsKtMpPxiJaZvWF?=
 =?us-ascii?Q?g050JEeNcUqEI8bwqom4yiMQkiq+ZbqihwsVjcutAX0gTfG9ln9vUV11RLXO?=
 =?us-ascii?Q?TupKtmtQsUuHyFrYOMYdg0lGWYQHKe3N/PL5XbRw6a04m//firT87rRe/CY0?=
 =?us-ascii?Q?Rm50R8RsatTsMaqRy8ZabqL8I+/TpPOhVr9Xx93fY+H8kI+WfkaQpiOBAqNT?=
 =?us-ascii?Q?UdBeR84/gQCUasTpvI0S4OUDk7iRsSolEh8l2Ed7u3xlZIS0SuGWo9PrYgKe?=
 =?us-ascii?Q?i3T2DA893nBp4FCGQKenULZkcErmYE3U+WDySgMkF7MPwt2oI2g78P8DNhNX?=
 =?us-ascii?Q?6NmL/I4Y2GUt4ASnUQ/LuGaNc+RflBI+AQGlbEM1JudDs4P5bRf56Jo+k/8W?=
 =?us-ascii?Q?j+ta97Hhq3CgNs/M1bnQUND/arM5Q8TB3CuXzl3XXnRtoH6ZUeWJlmS+jiHg?=
 =?us-ascii?Q?geGj9OOLbP0ArBi/hwanqU65ogAcrTwNytRFc04IUQ8tYWjRo8F3A5jD9sgT?=
 =?us-ascii?Q?3dJ0SvrxTu6tuuOOLQrVdxy+v+L30gdt6C1Zqub6tzovjlTNqCOb8NpvVJSy?=
 =?us-ascii?Q?ASwfj29XLcEZUzuC4BIcqf5wZRbblSvouuXB+Ny4JitOGm0lTiIzZ33fgZ2h?=
 =?us-ascii?Q?kVRuJekceGick6z7K/mqn3Jd5RNE5gXiVBTZVRn28giidRaxa7uBWNcGgHNa?=
 =?us-ascii?Q?z0dhXzojPWP9hprGXOCOsQ/6FIe+b9UgJN4gd6uIrMvvUX1Tk3kYniTNe+SW?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a5dc24-6069-4bd2-18c3-08da8775d133
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 15:15:32.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xh99oDDf1N8JG2S4vrVf/rdBLOp1kDyWfqBNhfAItyglcqKOSCEiqEJ9NWLl6raK4m8Er7HVG7mv36zLOU1LZdSzkaHjQGxtdyiVEEW0MZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260063
X-Proofpoint-ORIG-GUID: Jl1hdRoL3F97Nr9f2R0HILgu8mftVxin
X-Proofpoint-GUID: Jl1hdRoL3F97Nr9f2R0HILgu8mftVxin
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 08:32:57PM +0800, Hawkins Jiawei wrote:
> > syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >
> > Looks like it is improper check order that causes this bug.
> 
> Sorry for wrong command.
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 52615e6090e1..6480cd2d371d 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -594,10 +594,11 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
>  	for (;;	a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
>  		u8 *mrec_end = (u8 *)ctx->mrec +
>  		               le32_to_cpu(ctx->mrec->bytes_allocated);
> +		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)
> +			break;

This definitely seems like a bug.  But your code won't build.  Syzbot
must have -Werror turned off?

Btw, this was in the original code, but those casts are ugly.  Ideally
there would be some way to get rid of them.  But otherwise at least
put a space after the u8.  "(u8 *)a < (u8 *)ctx->mrec".

>  		u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
>  			       a->name_length * sizeof(ntfschar);
> -		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> -		    name_end > mrec_end)
> +		if (name_end > mrec_end)
>  			break;

regards,
dan carpenter

