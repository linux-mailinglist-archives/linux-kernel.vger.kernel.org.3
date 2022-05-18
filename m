Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2E52B2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiERGvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiERGvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:51:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A126B1F9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:50:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I1jmj6019084;
        Wed, 18 May 2022 06:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dv3ylftw1IpqylyssMnizwMF1U3yaF3Pe6VVN9iKL3Y=;
 b=kE403unOyWJzsl5AiD2Gv7rhRqIXpQG8xHNeiCmTGe/pUINzLeTid2r2LWREeP9XzkED
 1vspLDfoXniKLt2JptWwO5uil0KT8mnWW+w93H8MnAPQTFaq0EPnbaJMLMusKOqk0SWU
 7tPWt94014FHKk5wd7WIhVt8smSu6jjqmP59lriLBArtbBx2rwuXVmD9ONG2qznrFZZ0
 clz/Dr+M5D7+/RofZ83CfurJx+GZt9aJz6xUWIo+U/8LYdJVqwXmpftX8OLhqV7M6qVe
 Mo4hKBGztXSlS5/u+f+fJ1BbrWU4GcEafin6k1JlEbz+1dMzbAal8NqpUtmBIz432M4P XQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g23720efe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 06:50:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24I6TxEj001228;
        Wed, 18 May 2022 06:50:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v9fm9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 06:50:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3BNZRxUu9vYuAufo46Q3TpLbggm9o0DKAHS1JvFIl9W50GOD6asLlZiRlBo/3CtuAsJBCKwv+1hARo6aNXuubF9t4iLMGLqTMv4Ttclu/gCrBpVupVvdOWXuxFD9nJW2D9gQhVMghbcv5mXiDdbUkQcEQfJRoeEaB9vpngnCxTzSwjjc9A9jBZa1Ng/tnKnscmzeAdfQie1GaTFUXblhHtgjzuqyqsxduGa9j/LT7FC02O3cysZJSjwIqBTaBqIjCZqAn9M7zZuHYThrYTjuXZmcmktvltlriwWAlohmf8fy9yX1zOgzSMuFf33JZxVgwfRatC7ZddqyUkLf5Ly4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv3ylftw1IpqylyssMnizwMF1U3yaF3Pe6VVN9iKL3Y=;
 b=RhJUpdJRJEro9gnmfAroBMZtRFfDXpSL+5WO2HW4qeFlYTDSo6C7kxB7mFJS/k3F0fh3Exp73yrTKQ9oAX2Ocf5IBI8Xcn4B5K9U+0sgOqHaLHvigPw1sl97UIrYPfgqq/BKp3M3ZELlRkcXm1yUxEYDsBiX0xAS0J9T0v3lQsH4yvtoomXYbsifjutD5TibkNdNP0Ku7QpFcwyLZP9hfLpfJKy9GXceQcJUHhKslSA8pM8GbJnDuQcT5Oy9HzMYKDXECRD8oA6Zu+Ix6YOCqyGPOLc/QMLRc5ClzGFsRRh0PB/sb4JcUbkCH9SPqyxIFiBywmO9KwaLdtJ1DOatHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv3ylftw1IpqylyssMnizwMF1U3yaF3Pe6VVN9iKL3Y=;
 b=fySYO3DNlJxblCcvS1NcymUvpo+6PO9Tx9XCTmMlANdgQTItKRTedWLVuHYMjI9oe79T5hkjk6np5W4VUl79PTHMvRxWTKzjIyYcqXve0Y/OHokVQBdKwfZ3dDeeB0gs0YL1uWAps5On9jxmUMviS8WzQrki3lqZV8CFNlknvFk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2642.namprd10.prod.outlook.com
 (2603:10b6:406:c4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 06:50:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 06:50:10 +0000
Date:   Wed, 18 May 2022 09:49:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: add check for kzalloc
Message-ID: <20220518064959.GP29930@kadam>
References: <20220518063024.514280-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518063024.514280-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3df0540-5faa-4d46-8c49-08da389aa6b0
X-MS-TrafficTypeDiagnostic: BN7PR10MB2642:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2642A87D477DC66FE8E5B3DB8ED19@BN7PR10MB2642.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egxV+UsQRYDynxRZp0yeJLMqeQVuEnP+9q28IrWJtN1r/A2rIYi/B9LaUl9zcRLjhSASwvv+G7DNrs6suALkxViOsH1dytSC4XSKoGDO5AIbvdgsksmoujf0/GxAmlttwgKrTOYWi7Mei7AtG2t2jsPZqFhktvFxx1gLXxexsW4wAPVmCjDSDg1RVA9Pxnk+EJoeu+YTymJ0RVRDhMp+KzPTe302sxyKWYor88nIpfMSaaA/HrkGo++wykdQ9CKQQLfVAFoJ8TsCCvNrJZf79DoPAzXBwgGJQ8WWwt4/WR8/K4nxc9rleZf68LWmyC5Q+5R8/Fa70uy2FVu5a2cxgMYVRPC8pZYx9rdTo1nyIar+a6dhiRipd0YYcPWDTJtAINIw1Nk7zXWNvJ9buG6F5N5IF5wgzW2YTS4cU5LlhtYKWu6l8lAwSyPlKRidNQ4ihDAqvES36kjkbwuSab2exV4wC8P7KIS9JRjH9h70Qr/1+GDj2h3NKCiD9qt+AkUI4/1jQk/9B+tWRGrmLDa0At70sXOk8yF4EAPrytgtAis7F6/M9GRZPwi4ud/Uvg77+dDDUM56diF0mGugybCKRIvsuXNpocAZmTpNd3KE7ZLFnENfv34UMg7Z/XU0MxKEIzZaCxVtm2eF/kbUhyRVzej6OfrdM6W0Oz+JInXjhLHG+2gQRN8Bwy3yVABkLOtsbr4+kW+uNSTjNiyQ5JGcFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(5660300002)(6666004)(2906002)(66476007)(6486002)(4326008)(8676002)(6916009)(86362001)(44832011)(6506007)(6512007)(26005)(8936002)(4744005)(38350700002)(33716001)(9686003)(52116002)(66556008)(316002)(66946007)(38100700002)(33656002)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3QTtIwD7rZZ1P9USCMt0t++FM6al95hcR8kzz09zefEyQQCy8qTeq46tzrBi?=
 =?us-ascii?Q?sDkHr+UYyaGOzjTMGlKU1wy1P5FzeOu3NhvGZKn2bhKzjDL4RIzqObLuA/2Q?=
 =?us-ascii?Q?j4cK9aIHH+Cv266QHUs8HD3IuxLk4/bz9TapjlmvVoN+wzY7ClTZo+tP6qWj?=
 =?us-ascii?Q?QXWJhD8lE7h1FZEJfsG80KJau60CRtKAgYmN5XvGO5Cyrc1n/8OTW5SluA1g?=
 =?us-ascii?Q?7Z0JJm/QlZV6+DyxVOf0x3SO6amvqn7JjISS4gD/PFnB94xP0shJyMnl9LfV?=
 =?us-ascii?Q?Xq7OUC2uZyvV3LCJEEvfNIHpAwly3+pm1a5dUKySJ/3e6yKZQkfR+SRnCd3v?=
 =?us-ascii?Q?RoNKaj18YHQYnQHTiqWEIBBdZs7mPO7esavzxyETLWTd+mTU3mFuY3vuqkHM?=
 =?us-ascii?Q?0VhoaPpDk5I2MmZGHlmoMxcaubTGMORH4SOk1IaHqwAdFls6t90yGfoCzFt1?=
 =?us-ascii?Q?75Bs0IM/bjpgqfrrg9px1+4A3iE9QOP1qCW/aKDlZ27OHH9/XLuuUx6Qt0+w?=
 =?us-ascii?Q?x+ZSPchpv3RJMSpeKl1kzpCWJF+/DDs6xvyGIc9mIwaUjB54ma8VZuwRlyVq?=
 =?us-ascii?Q?XcIWzk7gbny538BkN0Q0CJwB16lBxe4cLyj3LDmSE2Fb5iPhqwbWOIeQTt62?=
 =?us-ascii?Q?ye1uO0CWxMXnkXa2dq48WpPs7f5ABBgkEVc2C8uRU1BYE1Thx71DVC1hxldc?=
 =?us-ascii?Q?6Eo0mBeSktsML2g5Gee5lv/YjnkiNmf8In6T/JOhMka90IC1NW73a+QpgrIq?=
 =?us-ascii?Q?yCnQMTAQeM5C1nsafRtbB0qHCZO0esntPvnpTRPb2ebh1hZt0ZmRzxATsXgo?=
 =?us-ascii?Q?+6bPy/elzQFBj3YL+7kC9vHG+r99J4uFJpFQP13Ekyfz+gaiqC4H8xYk9pfQ?=
 =?us-ascii?Q?Qk8cSneNmjuTCQr29n7jP+IvhNT5ff1AngaCQ4OfqTY0VYKZcAgxmdplHNcI?=
 =?us-ascii?Q?AZ0jvOxGrK3kUX6jT1RpCrRYYr0+fRjtY0jfCSn5KVYZpCAdLpsvbL5VrEqt?=
 =?us-ascii?Q?AWTOmyIoDFjDKRbqIo5EAsMZ7pCELzH2cNCKJIgCx8ZU+Zp900LkNX7yLuoQ?=
 =?us-ascii?Q?51qx4EI8IInn3P3SivTnW7NNezIHSsSo/7F2PxY0IpzFLH+7jrYdMrqE2Bq2?=
 =?us-ascii?Q?OzarO2Zv7Af0tWVSb7jcsrXdLvoX0t8KLLtWApRtbfiSbzi0aLZwm0BOw2Bd?=
 =?us-ascii?Q?aXJgBmcDGgVXv84UBk9x6uUdSWso2WXKmBfYzperpvpFPdHYGwHEYA8kf1j4?=
 =?us-ascii?Q?UIuwRFDxkKKWcNwZb7rW/q7hj9+ydY7aPMwfqsLd9qC9He1bedAxDB86f6W+?=
 =?us-ascii?Q?1uRe/SChe3rn4RrkVFiZPaI4/eAbzTfY54jjzW3v6zKPSDxx0wN2sGCKLORI?=
 =?us-ascii?Q?jJqG4VcWbw58ne2B97UmI648/yWJLlDy55Mj1rmiRd1jd+AMNjeHhbiZnfeo?=
 =?us-ascii?Q?M42bNTL5SiqOOwEe3cqj1/oP1Bozd2zRNdmBpIM5uyWpawXOoAzIyX00tOZh?=
 =?us-ascii?Q?s6h+rmvXMmFU/IX7dpPWQMkzzvIpShON5kP1pAQ9aZPen42itEyJW2ER+ygY?=
 =?us-ascii?Q?6JAG0ZAtyqIWjO0QzCfnhLzfjAGkn2zf1l3EeJXPP+QZybUHN5G246icB9nk?=
 =?us-ascii?Q?ybkfiFuLcERvtrYbs1Isv6xPIuLUcHjCTi7GpVHMHECaInCNIrOr9tK28zg3?=
 =?us-ascii?Q?Oeq9sOrql48BRyvrtBNuKwFzDiMjRj2bVAOSfxcW9KLrVvR4sd4lItn1V0+9?=
 =?us-ascii?Q?3gT0U4B6TIQgz4BZ9lHRWTMvqgIsvM0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3df0540-5faa-4d46-8c49-08da389aa6b0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:50:10.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WesNqB34wDnjrMFAzBvEjYEgbfNvlqxVBLD67h2sD/U0LUp1jFF98rxLhz5CPHXHw5cELBu9WAXRbiFnLX/dwPg47MMUTbiL50BytV4XxnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2642
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_02:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180035
X-Proofpoint-GUID: cYUhx2mlCFKtZsL67o3zuv8bWLJciwzO
X-Proofpoint-ORIG-GUID: cYUhx2mlCFKtZsL67o3zuv8bWLJciwzO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 02:30:24PM +0800, Jiasheng Jiang wrote:
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index c2a550e7250e..0b3bcfbf22f7 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -178,7 +178,10 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  
>  	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
>  
> -	rtw_alloc_hwxmits(padapter);
> +	res = rtw_alloc_hwxmits(padapter);
> +	if (res)
> +		goto exit;

Unfortunately this needs to be:

	if (res) {
		res = _FAIL;
		goto exit;
	}

Eventually someone will get rid of the _FAIL garbage but for now the
caller expects it.

regards,
dan carpenter

