Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE404F1354
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358312AbiDDKxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbiDDKxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:53:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5488A3CFD7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:51:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234AU0Go012575;
        Mon, 4 Apr 2022 10:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NiBwotI2F6nRcSEJwstgsWJ80CJG83jAAaMwkCywjF0=;
 b=WC2sXk8RcvNdZsvdpuhnZsO/AdfBpx8N4gf8yvZg8DL/2F0HNx3nYCfe7nQiMhdmlswb
 AbijvM7fZKeBkG8baOPmSgKzsVkOI10KI5sXsarJZLu33mb4mhVLlUANMvRkF+R71I3i
 Fa03ZWBU+J7yaPqCSVlkfgkc5jIZ7UOYld4VJnQfkexNxOvLv7aI5llK3g6ke0wwNU5F
 zFgy83puiP/sGtkR4DvyqTNlfPBeSKnDXbrE3eOpDUPtEWgSVNDwL0+gfEW7urHy5iZV
 mibkJm+2fIvGS3f4hdWqPs87UqNjFizeGXopFqkUuZfR6U04T1HtgXPAnstCBgAdewv6 cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcat4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 10:51:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234Aodfn028406;
        Mon, 4 Apr 2022 10:51:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx28kkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 10:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZm+EIJrhR+NMrV70bZKiTBC/sk7BOrrSPEkfhuxrOqu8Z53txR4ISAyLW2jLSdB87p+gTGHmyjX5E5H7mNkmG9WU5tX224p1cgW8AlLHFcAt57Sa4ptYXpDFqUvOE7upwS/ZDDLN3OZJsfBIT8E+lKt4kBrxPcMeoX+P/GI6KcEXo9NAPMTfeynhLk11EKnaaytS0IhH1Sw+p26kUPUSmRvF7MsQtLxOkhHrFJk7fcWLnMrTPnoQkAHPLvmpRDMjvkBojNFSUpVdf+nKIF0xrXXD+W4C79NNHHV0PKGPzFmO5/ESnYCJEZyzd19fQVP/SvALOxgWLfnhZutuTE8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiBwotI2F6nRcSEJwstgsWJ80CJG83jAAaMwkCywjF0=;
 b=BlBxFifCnxz6hIBBhyn1xziLseLNSQw8fXFWHWVU5S6gxeXPqyN+0XzUI+XNFokeEN+Snm8OTH0UFTCUJB1Qg7r/GOO6XAUTJ1qxxHyV7jHvTYG4shnDCTWlPZAqstCtfAmvOGNN7Ex7ORySyaEMn8h/GcfdhOENhxVxtAuynd0QL903mTGUQ+rpz7XoxKJA9sXoSqCYhLRRFG20nk7BV44Acfjdi8mWf2dU0P+BSLdb1eijD+I5P4J97bsY3OyQbIZmQ6BHcs7Kad4S+H7QgJ2aMLdMxb5OBhNqCykZ00aFhDjk2Tnmymm1ADyAGUA9kXsSmiBR80npWXPTQUBURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiBwotI2F6nRcSEJwstgsWJ80CJG83jAAaMwkCywjF0=;
 b=QEEi0UasHdHijSmcaVN2JgOwnvnMKj/HMgqMt92KYbDwQuiSxrkSq7pXlrEq98hrc+L2VqUZQ+p4qD+J6kwJSe4znI5k7rU5RlVcgwDmd95dZ9Xz9UDLZkf0T4SdlPmv4KHobu6t3QrThwgyRuFODUdvGpdHhU9nTaAvoBvg74M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3187.namprd10.prod.outlook.com
 (2603:10b6:408:c6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:51:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Mon, 4 Apr 2022
 10:51:01 +0000
Date:   Mon, 4 Apr 2022 13:50:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Charlie Sands <sandsch@northvilleschools.net>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com
Subject: Re: [PATCH V2] Fix unsafe memory access by memcmp
Message-ID: <20220404105041.GX3293@kadam>
References: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea0ff85-c751-4144-0f7c-08da162901b4
X-MS-TrafficTypeDiagnostic: BN8PR10MB3187:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3187AAB2CB45EA29D04779318EE59@BN8PR10MB3187.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bk2GIQ+1qi6UBIr12U/l/0eljmaujscPUgkLlOsj5kQUYOvCjpdIPsGu2HOYbXp5aPUf9CisNeWDSIbe5miKEIClYstvaB8wSMvgKHUAVhvOOgDRuR+yCtE/KgHPzgTWKZC0vdRX/PLDVLetz40/UYkbQSek7JS5fjmiEgLqkQr5+lS4q0qlUI9h0HnbZsCU8qlpBHt7sREW3b50VRTW9uzavU40w0AcAwRwxp7oPOgA+JdDmTlyOiJCDbtsvrPFkgIjAjL2jXRU8gVrSnZ4sPas5QAFdU1xt1cisti2IZLs+biHWn62ROEu5DVSi90mmQpbSkOO+uMfVh86ql9TW48vkyJLvsA2PHVFOPy6vnedqkmxroJRDVjW1YcNoBZfknMBlX6vvKScxTXh2LI3BGk6o9BlWn1JNU1WY//nApJOsaiyvMUCLk0XaSSbCvrl0RBZRj2uT3Ex0e1vv2K4Ao+MMThvK9aWYq0FSnGXbMIVXsxYfebCiVcq/JadKv5/HJAnEpzDivGl+zJNrx3mQ3UKbG2/mef1fS/nN+qVE0TQGg74VAPlttd5kT7opWaEQXOYqGnw7664+eAK0tATzFk5wXYKsASrJeTCJj4ax8KffFzTU8VBzqxenHbsJF3vcLzIDW3f55+/OHXyBTMUavDp7KjKWWnRvbYOrA9o+ASlrKwVZzUvytp5GX/a5NkjhbA8gdVdbCSXX73KZa/NzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(2906002)(33716001)(66556008)(9686003)(66476007)(6666004)(66946007)(8676002)(4326008)(52116002)(6512007)(316002)(5660300002)(33656002)(38100700002)(1076003)(38350700002)(6916009)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fgkeXo7C8B7vC5tAGERaIinqCiNTK33uD7m5TTVqwcMwr+GruAbmQYg9Cd0N?=
 =?us-ascii?Q?pFDS6OhFS0GM1NMf+ljM/bRnQh86S7nXV2+kaB51W4+L7T/0X0ejtxJSQe3U?=
 =?us-ascii?Q?j2dF9QX8OQbJH9nCGU4TWSVq+8RnR3tj+PWmii+k/u/F/XQ22Wp97Wp4fqDg?=
 =?us-ascii?Q?MQflwagQUQrcfutbvp/VCTYLj7ycKSaiyP0LFVRw0WvZjH8Qs5t9+W/9wBOJ?=
 =?us-ascii?Q?BfOAJakCR7uC23dlevlLJqA/LSgKEg4gNiswpi6PCHuMSyQ2GDHsbDFE98BR?=
 =?us-ascii?Q?0JmwxQSQO2i7KH5L1xBPXg4BxiS6lT3lacp6KeeGgV+RH9gDOW5pcIoNYkmR?=
 =?us-ascii?Q?AjxybluH6RKmq5QrAIqGCVESQsYoNHFErAjyLkG4zS+ELr74KO3oC5CQfs7v?=
 =?us-ascii?Q?BtlGkqc6oseWMGhNNh1lwNPTLRsdDI6T1rtSRo991by6nSWp/lOdbN0Lf0cC?=
 =?us-ascii?Q?HssJhqxo1Z4ceBLMGLj4t4/pmr9LIWpkK3qjKhh4wugZyW+v8E/EfV8dYH7w?=
 =?us-ascii?Q?7sCaeAvACXxRWv7bzw5V6JcXFTXc2F0D/Pma53eZY4XxOpkBBUd5bNw+X5Z6?=
 =?us-ascii?Q?IRrrokuBIG55EGcdOibwK6qgVP5dwKpfXd/Nprw/3CGQwEliHZ2kQReLrOnT?=
 =?us-ascii?Q?xHw22wgDF2zo/B0uHSnl21eXw5foXRxa3XfGdvUSFGjjm9hdCh27/OGXZaez?=
 =?us-ascii?Q?BQu2TPJLtU/+glZg8v+Kzraz7oegekTi6EdCHaGC3E8KvYGCa5XUHkWiQO4q?=
 =?us-ascii?Q?9LZMIHo68AFDnnPN0lIBE4oeuZ55DBElHjHu3j3QGOuToS/p3fVWACI4xT02?=
 =?us-ascii?Q?KkDcZY0g22jaPFSKM/79COCUeO5fL1p7ZGgAbJyXwGWLh4iU0yYgy01fDE+I?=
 =?us-ascii?Q?43OWfc60AtLExSbe2Pw+RukDLIKqWtfeuGVNuNv04+exbfxQ7JL4JbDkTyt3?=
 =?us-ascii?Q?GbUcG9SVBPkMB0hou/ufqpryP0mC5l6V2Xh9v+Fb7lQVKk0lh1wGaHJXyIGC?=
 =?us-ascii?Q?dtio2mj1kBJ4nObWT++zsbI8EUdA1udqzbjSuB9BGsLIW8WCdGLz6NtgClAg?=
 =?us-ascii?Q?SNKPswMcl55y6NNHiIYy0Ka/iP2S12KSf36rGUK71GM8UQZFVSw39NwcP3iF?=
 =?us-ascii?Q?DrYpneMS9rWbIQ9Kfz2xRjYopcCwECLrga/P1vRVxrZZDGChj90t9DB4UZry?=
 =?us-ascii?Q?kErgynY0pENceUYtF/Zq8dVtvGKl9jbBsTHMKyxeTH2oi/gQ9Ud5NUwVPlf/?=
 =?us-ascii?Q?2mWSYMBv7swZ8wdyP8gO/OzLKoj87ymMqC6A/4jUwHloBGPHEtcC4nzR7rlt?=
 =?us-ascii?Q?gRuoCLxHixzoiybtEBbQUnkvQ4C0+airslemkmnlXoFW9mb5HbylNKnwhGKo?=
 =?us-ascii?Q?t98JmTyh0xil8elNS8Iyh1xPZtVvdgFTDv/bx3mc7G9gsl5d+0Cjw3NJdvXP?=
 =?us-ascii?Q?ApFu+X+GjwNoWKIP7+vCUApaorKGE5RcVFSjqVAXBUpNag2shfwf4X9FA6v6?=
 =?us-ascii?Q?xPFaEl3JNYta4evoarqI/ywtoo7cJTY4U/cNU/Dw26DkDQmKMNaJNFUw7rDd?=
 =?us-ascii?Q?qovhZRdHbKP1kzfLXSR9+AbgpFw+yzSEiIeLH/h9Ep5KtlIqoYFH0hiMZH4C?=
 =?us-ascii?Q?kAG4IzuCrYdULX+wy0iP3Xzukh1+d2roEmKNNgUj/iIFTEd2dbAWDJRvz6Kw?=
 =?us-ascii?Q?lek1hVVReY8XMOPGJcfPeLZjRCqR7ggu0J2CXW7sfsPj88QfRQvADoXK92Zb?=
 =?us-ascii?Q?+gZwNddW/Amh6I/xwcxizixEFk1QML8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea0ff85-c751-4144-0f7c-08da162901b4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:51:01.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMfVaTljp/GKGTlYG++XCeBx56mA6hTFJltNKqysk9u3JitQnGvyw9DgO2D2tDVm6b3eoYgyyQvDB2RnVeJ2qfv/6QbdaJkt/3jRA61ybt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3187
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_03:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040061
X-Proofpoint-ORIG-GUID: 6NIKwbmr5w3gv5nPd9TaTLHFa2-sAkZo
X-Proofpoint-GUID: 6NIKwbmr5w3gv5nPd9TaTLHFa2-sAkZo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 10:52:07PM -0400, Charlie Sands wrote:
> This patch fixes sparse warnings about the memcmp function unsafely
> accessing userspace memory without first copying it to kernel space.
> 
> Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> ---
> 
> V2: Fixed checkpatch.pl warning and changed variable name as suggested
> by Greg K. H. and improved error checking on the "copy_from_user" function as
> suggested by Pavel Skripkin.
> 
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 ++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 7df213856d66..4b4eec2bde96 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -3233,23 +3233,28 @@ static int rtw_p2p_get(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       union iwreq_data *wrqu, char *extra)
>  {
> -	if (!memcmp(wrqu->data.pointer, "status", 6)) {
> +	char wrqu_data[9];
> +
> +	if (copy_from_user(wrqu_data, wrqu->data.pointer, 9) != 0)
> +		return 0;

return -EFAULT;  We can't assume that that user wants to copy 9 bytes
especially when they're passing a 4 character + NUL string.

This is a custom ioctl.  Called from ioctl_private_iw_point().

I think if you try to dereference a user pointer like this then it will
cause a crash, right?  So that means no one has ever tested or used this
code and we hopefully we can just delete it?

regards,
dan carpenter
