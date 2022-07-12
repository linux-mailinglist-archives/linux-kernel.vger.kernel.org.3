Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742CB571533
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiGLI6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiGLI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:58:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65011A9E73
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:58:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C83bXo030530;
        Tue, 12 Jul 2022 08:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=qBj/pxUA2LgDY8pr/MFqPz5fraJxR3qiIj8rpT0taIM=;
 b=RaOb2fqyzzEKghqaaJbmmPL9MmC3U+RWM984oywRM3PopQ+AjJK92HdX9A7pkGGRlaKO
 Tfh//xApcGbDUBITIDAjtIuA3AVX/OQgzNpRC7VPtRa/BdTY7UDyXIn4/59cgyeW4R08
 6Hgc0Jrx7Siw2SWeKSxFInomy02y9teD+DpZ29TlhVnZSrWhTVF+eTDpbgh327gpNR8e
 PoyghBj9+BV9aXQsbYsg/kovBQMtzMghTqwv3CxiKfvzm+qdz0Yni/a5PUCOgXqJJ3mx
 J1EKQhAqL0ygNY6olI92bvjpiaje1rSx7H1Mj00879ktS6haaSJyDnoR//nPWiPEvlu6 xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgnv3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 08:58:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26C8khOx031532;
        Tue, 12 Jul 2022 08:58:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043c2as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 08:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey7WdUa8hsGrJdl/wyEum72zPliA0CigFn4AQ7W+KrrkB0IwM1iK9jRxYkITp9L3qx6hLIRpWa/ijQyA0bRVdjiSWGogEq7s9g7FXHiQSZ89Z7vnqQERhiBa+XsQfnKHW547SWi9RsjpxEgMMCbbOa8MVn5aBy3KuXqaNM2IQKWD/gEKzAuMJHmePgpUs7VAukEi5NdAjg8Cue3q3K1xJLyWWQMDbtMiyTTLtqjE7BgvTX4wZ7hZOEnZAntOu183yOu/KGUHoba7KqKdFZBy0+4hImK5rJ++rPRcg0VobWFEd+TtckB5gJJPavJKz+L+GgDrPb1kBX42riCtMQd6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBj/pxUA2LgDY8pr/MFqPz5fraJxR3qiIj8rpT0taIM=;
 b=asUoGxWdLs1d1wC4mTc/1fonlrDtEQOaAUwUUuazQhN7ScY0LtaNL7R8zjNVTQW6gCpbSnt35PDixUuZdrokl4NfRhol5aUxRq4UVIpe7uarrc/0ftQL3M+M+5jSQ6BNskKrGXV8cqnG7DiBrJQSETrVXDCjudpZCXjcA/ffDzwvj4ZPzPHHgj1HhQ0t/BRpXk+nMmSS7Vx5uUp6u4HCjvSQD2DuEYKrNPkCR3a1sZB5lRbMWG6aHYgGjnEMXauEnBv64Cm0vHfWjoChu3ehUK5BsdbucZ2o6kayqH6HCjzAAEZsu0uNavNlLcBobPyq/Lg9wc9Nt2S+5RGXUZOUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBj/pxUA2LgDY8pr/MFqPz5fraJxR3qiIj8rpT0taIM=;
 b=tCHsiiG8GlJIjtXLJov2r+H+bRVmaxnb3RAj7EiY/FpwchUrQ7pgRv8DPkyclaDZL55N4WyKjr9xgvpBhTgR1/EqgdZLLdaHYSQKjgIqYbLwlO6R5lIiRNrxrmJfv1E7Bnx4ouJmAA0nE7yrwASNrd+OOaAWe2wh9JfIkPHXusA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5754.namprd10.prod.outlook.com
 (2603:10b6:510:148::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 08:57:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 08:57:58 +0000
Date:   Tue, 12 Jul 2022 11:57:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Rao Shoaib <rao.shoaib@oracle.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/unix/af_unix.c:2471 manage_oob() warn: returning freed memory
 'skb'
Message-ID: <202207090117.Ub3gbT5M-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0119.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca9e4285-9e2f-477b-fc4c-08da63e49e3a
X-MS-TrafficTypeDiagnostic: PH0PR10MB5754:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSbIaQANgv/NRRzbsxBSl1Dtm/gDkGXnqCEEsKEHCH5aYxSxckmvUYcJJS8q0sb0FBwqijFonSSY7EyzS5UG0zzuexHb7dFWGpG9c5G5i6sUSSV/f9zkvfv0jQVp0WHLCH8PzP3Nt9mNegxG3MwEVZHHj4nfybb6fbDAD12Wr8WXPFRGNsh30T4eqO3wZx6wpQ4pp8PATWHyTw6XY6iwoNoD2aWJsmTOnRnKmlUcbWLqandOaVWjxHQiBNmpMu1THJ4CivtIbZcEMuuTgze7BscuWEybOxNJjmEAQ04H+l1EWdMI+45P3sCGpj1ln6iWvGJXEEa018YSQxx+soCbzaKH1yCnM0fVetjXBYwbolSkwgr7PZ5mvYAOgeJDbfEcFMNSWrmSpG5rcxhSntJU7/2YjhHaAqVkabgRZmdoLJ90eoDUZERbksQQ1vQjdbH8GvoyQFXwUHrDGZPaMHBh6GlHfIVpv62wPtGbKMyWw3hRnR2dYUkJdGM8420ATu+RwRUtTGnRR+ZimVv444hA528UCYVGoKm7kq4V5tUgFcHVy84KmadIDJCJdF5HqjcX3kq1umlHwBzFUy42rL+nYeoz3wDmcQsMLbm/W+OODgGDlZkSyqiY0kJSLFTTvT0GalXPXaKpA27OjWBPYUTzp9WDvVa7LFfROoOGTj5j6hf8JNKQe7MJ86ClcwIclbqYE6HWwacRy06/Ll0HUNiJ32P7eg9VsDMXDfxQ8jDIR8wnHBLdnV2/ss2TdF7ZmOaVQH7TRaed1lB7neW15psIKUc/ZZkLTuGhuu/Y01lwK9juPjyCfRX+BxZA7MFFLXmtkMCj/r9ZuBwfX0JJvPDcw87QKyxdOnYbsvh6m43tllVMwW97lucGzoO+iJLFYMWrzfIMz109MU33CiQ5qMug4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(396003)(39860400002)(376002)(966005)(66556008)(6486002)(478600001)(316002)(41300700001)(38350700002)(44832011)(6862004)(6666004)(66946007)(8676002)(2906002)(66476007)(4326008)(8936002)(86362001)(9686003)(36756003)(1076003)(52116002)(26005)(38100700002)(186003)(5660300002)(6512007)(6506007)(83380400001)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T2bCGLYv0WXXD5X54xt172SKBlqdgB0FAvoXy/U9ditNB35bQZNeSA8TM7SG?=
 =?us-ascii?Q?iCUQ6ZSNArjOhpAmkiteng14LOEt3MFjwyT3FqaX0qZwgWeIUVtbNu8RgHQZ?=
 =?us-ascii?Q?x5iXrXkkaFboWykMY8SaahXgn5FBhvZBxSzD3Iq9YTGIva4HiOehkr+oZTCL?=
 =?us-ascii?Q?XH4loa5bqcdsHh+I4eLBum6uQ7w2ItII0OgdCFFP47as48OsZsGjMigx2Ebu?=
 =?us-ascii?Q?rYmOWvZWJFCIvKNCtEirimF43v4ngRiGoEvtHRtNhKmynH8ED9U689GSkPmJ?=
 =?us-ascii?Q?W528cjTExKSAUSX+Lng5tIMMLZ6mMcu1JvxEU7Vv1yP3u1K92VQLTs+zJGaD?=
 =?us-ascii?Q?qYiyhsyGTWuPXfTm7hz0iypFzMaF/CdE1KAt2wfKoOzz2u/vKWUTixHke9xP?=
 =?us-ascii?Q?5fd1cMH/wbu+nD6d2kRTAu92K4wK8e99jfOFZylh3Z1nqya9x7tMK4ZGckCh?=
 =?us-ascii?Q?VmioXwA7xvVnRc7bNDUL2bK3bdPE53K68yX1fSXvAyVU+IRFhuKcWDEVYFGT?=
 =?us-ascii?Q?gggYkJR1ZfuUiO9oKyQ3Mf0nljMHBX3sW51v+F9a9IHg5q0YeGIsbC27aLn6?=
 =?us-ascii?Q?hhppQjSOmMAewVHVgGrzgH11hXrPsTpYff+odrsxwmr2CfzDqX3PD9lgSxn0?=
 =?us-ascii?Q?xJjcdvYPOLDh4+BglnjY3qUulQq/NaqIOuIRU02Y9eT2I/p+9jPg7onJ9HsZ?=
 =?us-ascii?Q?AChicLe4h8R+emmMBjClkJ0Q4S5+X1WKS3mxBWX/y2pKwu3wQd5PSP91X7SG?=
 =?us-ascii?Q?ydn+yFnq/VQE08zeGM31TJmqkQZP1ucl/HW1JL2DReEkJ5Gl/70wUNM6ACKd?=
 =?us-ascii?Q?P6HPKDpX3lYPp2gvP7/m0BoN50mCJ7Ug1lIIeW1XQwzoDSyxdBTk1iZUyX5z?=
 =?us-ascii?Q?O7nKMhMNgX3o49d6DqLcIrGxypy4GFRyDTDjq9aYXcezPDkPmjY8muYfYtUC?=
 =?us-ascii?Q?WJ9nWdu+kKFLsIWp2mBhz2Hww2T5KHUGa2ORL+ap8PkosGlGsP/tw4tNqqAL?=
 =?us-ascii?Q?DPqe1R2nFCBGaw/GgHGkaN/KKBouxMETNIPukNcAx7EVO5mpCz6nuvW1L1QX?=
 =?us-ascii?Q?kjvO2ZLkPNY1pd+GacaEzUTX2fOUyi8mbcuRbFKy9XAythTojYFiQycyFQn0?=
 =?us-ascii?Q?3fl7iJDyG8o18K1MyA8bxz7LEyHAtohb+yFiU+7pJj2XPxxi3ZtIn+8GhmXt?=
 =?us-ascii?Q?IPvI4sPrwDDalJVJZ5H/RsAzbv4u1rOjeN2KAwPhcuURdDUb1pdGx/rucWRe?=
 =?us-ascii?Q?/CKx5xdeZCV8ZAirXMgqFe1NJbxo6rxPSse+ZBIAnj7BWN4GL0QNPM47ckZk?=
 =?us-ascii?Q?aUL2rrPB7+Cpoqa9KBvUWiX+aP2q4/ASKchDGP+oLZL/R965lNOhhRbcuDHb?=
 =?us-ascii?Q?BuKuS75zVydFRdqgQ6sLgN3gJWYzLPqTLqWXxdw8I+DBeSxYvDPvYfGqlknm?=
 =?us-ascii?Q?CSlrVGulPtEjGNGBLy7+7gwzpHiknmrmmSDfvpDMbzZx63TtVSyKmEpk7Pqe?=
 =?us-ascii?Q?+gq3UCObdUJjtSNbukhC2HqdTciTR+wdiCrB4PYX/r0MFkgbKLwj1oOTUG6g?=
 =?us-ascii?Q?T7Zi7yscX4byQgq7yEKi0/JGuWCokLAuvZmneCpd1mkjiLBMY8IMSjL+LVuT?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9e4285-9e2f-477b-fc4c-08da63e49e3a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 08:57:58.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWCd/erIKXcf/p5uLhJbeM3I+hk+CU52wGVK2yFGiYT8EMdX5qYjs/G3ULedX7MbE23Gv3rLSse05u6SF2GzkTKvMtlg5NiW+NibB1JRyUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5754
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_05:2022-07-08,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120034
X-Proofpoint-GUID: WMx2lXq2QHomLgb2OK5KF_FZtJRLm-Dv
X-Proofpoint-ORIG-GUID: WMx2lXq2QHomLgb2OK5KF_FZtJRLm-Dv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8a4e1c1bb697b1d9fc48f0e56dc0f50bc024bee
commit: 314001f0bf927015e459c9d387d62a231fe93af3 af_unix: Add OOB support
config: m68k-randconfig-m031-20220708 (https://download.01.org/0day-ci/archive/20220709/202207090117.Ub3gbT5M-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/unix/af_unix.c:2471 manage_oob() warn: returning freed memory 'skb'

vim +/skb +2471 net/unix/af_unix.c

314001f0bf9270 Rao Shoaib 2021-08-01  2446  static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
314001f0bf9270 Rao Shoaib 2021-08-01  2447  				  int flags, int copied)
314001f0bf9270 Rao Shoaib 2021-08-01  2448  {
314001f0bf9270 Rao Shoaib 2021-08-01  2449  	struct unix_sock *u = unix_sk(sk);
314001f0bf9270 Rao Shoaib 2021-08-01  2450  
314001f0bf9270 Rao Shoaib 2021-08-01  2451  	if (!unix_skb_len(skb) && !(flags & MSG_PEEK)) {
314001f0bf9270 Rao Shoaib 2021-08-01  2452  		skb_unlink(skb, &sk->sk_receive_queue);
314001f0bf9270 Rao Shoaib 2021-08-01  2453  		consume_skb(skb);
314001f0bf9270 Rao Shoaib 2021-08-01  2454  		skb = NULL;
314001f0bf9270 Rao Shoaib 2021-08-01  2455  	} else {
314001f0bf9270 Rao Shoaib 2021-08-01  2456  		if (skb == u->oob_skb) {
314001f0bf9270 Rao Shoaib 2021-08-01  2457  			if (copied) {
314001f0bf9270 Rao Shoaib 2021-08-01  2458  				skb = NULL;
314001f0bf9270 Rao Shoaib 2021-08-01  2459  			} else if (sock_flag(sk, SOCK_URGINLINE)) {
314001f0bf9270 Rao Shoaib 2021-08-01  2460  				if (!(flags & MSG_PEEK)) {
314001f0bf9270 Rao Shoaib 2021-08-01  2461  					u->oob_skb = NULL;
314001f0bf9270 Rao Shoaib 2021-08-01  2462  					consume_skb(skb);

It's so weird that we're sending warnings about 2021 code...  I looked
at this warning on Aug 10, 2021 but for some reason I didn't send it.

314001f0bf9270 Rao Shoaib 2021-08-01  2463  				}
314001f0bf9270 Rao Shoaib 2021-08-01  2464  			} else if (!(flags & MSG_PEEK)) {
314001f0bf9270 Rao Shoaib 2021-08-01  2465  				skb_unlink(skb, &sk->sk_receive_queue);
314001f0bf9270 Rao Shoaib 2021-08-01  2466  				consume_skb(skb);
314001f0bf9270 Rao Shoaib 2021-08-01  2467  				skb = skb_peek(&sk->sk_receive_queue);
314001f0bf9270 Rao Shoaib 2021-08-01  2468  			}
314001f0bf9270 Rao Shoaib 2021-08-01  2469  		}
314001f0bf9270 Rao Shoaib 2021-08-01  2470  	}
314001f0bf9270 Rao Shoaib 2021-08-01 @2471  	return skb;
314001f0bf9270 Rao Shoaib 2021-08-01  2472  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

