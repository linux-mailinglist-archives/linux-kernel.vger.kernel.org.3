Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994BD50E18A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbiDYN11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbiDYN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:27:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAAB36B65;
        Mon, 25 Apr 2022 06:24:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PAq2pM008853;
        Mon, 25 Apr 2022 13:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=KPdiVNjMLu97eqbInbHlQeLz9KScwPshV4NU3F9t9lM=;
 b=ofeSJumS3ADU8UzH7C0gfgIeDPOGmK4qBJ7CTCMgJzV8YWSRnN4OoDRTOvX5F8F8QGJx
 PTCOnG8IhApm6l9NOeWgbIn4eviTZgWPFQ7CEC7f5bEQJNKRZ84uaBAz/YAvV004U+FM
 LBMuhY1H4HNVU6vQibQpKMynZywoNvEqGWPRAQ9pWIVix1ws6J8+02C6JRP7z4GfJBZt
 CvW3GW/dlfCedRICbufDFnYQn7mTiOnnYJJxfjq++iLzHSYvRUxEzUTI3Vfv9UCLGtqj
 /Frdu49MYP/KQBIIiU9TdAek43UhyrO3J3cHkV8Q1d53FTxncSJx7gbKs0nqIDzM+5Sb 5Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yu343-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 13:24:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PDCQWb033877;
        Mon, 25 Apr 2022 13:24:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w1pxd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 13:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qxb06mDlSGNwKzf/L6PM1GNUEZkZWntTZpcGpIcaFWIRE+pjTNlZeyLf4teemsCZKv5xIYCJagC3RVKb5SjDDV2+phuVePntw5bvBPCbBfqwUXoy7t1/3kKXiSfROZDP9v2DholYEUN46zayIg5qvdOreQOt8RtiRrw3XeAvD2WWg3mUYamBa9J7dzXloNyW1FXrkdLcIdc3ECEjJ8x8JSFOirEJK5M+jTZm2xeWK4lVYYrOeiPm9IKwPCXavFqwMmHs7dhyBf8vZEVzzN0FXUQcV5vyNQRBzxxblNanU11S1AuKIFPnRKyDABMQBL3SJCEVKWTF/Z3NvmiCtS4Rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPdiVNjMLu97eqbInbHlQeLz9KScwPshV4NU3F9t9lM=;
 b=XMqZGFDFEuU8IXktPXHzZKSTpyp8KRbn7tXeVNLxGnn+0MbAL+vJbvfqzLE4btDwNDde5YrPbXVlt/41SIA3c0Oi4QYq3Wc3uwgPXo/GQ5umXxwb/rKMiXafBJ8wE0xZDX2mKzT+fw+tsEE6+RL8HfTrQ1UukwGKUbDoqgirkzKYDPP3coz6pJOg0MYL2IAIz9zk3GL5k7yOYbRkTCTHCcDjzlWKyVFgjfoJCYDdNsYOMx7FXbAbOw0IXc8uE/CB8MFDma/mTNZE1taJibd0lRcb4jZR2lNg5WJuCLnh7x8poEfm8orwrcb6v8ZXimjnnUewDnC+xmbGrdTn5pNRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPdiVNjMLu97eqbInbHlQeLz9KScwPshV4NU3F9t9lM=;
 b=J0TytDuihhjWz1Ib1r+qs0MnNBDJwifm6Cn8FtYd4X4o6Ld1yMzTXe5pZf8/ku6iZynDy7i0XOE3fJM4WoIlrLVajjzcSLN87Z+qzmoYO6/5eysSAkPE2s1lWrVfKrcYfx73rjGO8rjLck0odCeisnLkjG0TPa2fAHQflhkmuhk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2110.namprd10.prod.outlook.com
 (2603:10b6:301:35::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 13:24:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Mon, 25 Apr 2022
 13:24:06 +0000
Date:   Mon, 25 Apr 2022 16:23:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Zqiang <qiang1.zhang@intel.com>,
        paulmck@kernel.org, frederic@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Message-ID: <202204241503.imwh5SqZ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424041747.3172671-1-qiang1.zhang@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0098.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f20e3f3f-7db1-4a01-0cf0-08da26bedf41
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2110:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB211010C09DC87B88CB7073E08EF89@MWHPR1001MB2110.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aj50B7c8O8hNXSNWEpwGjMyolYIJq8XdH4AwEJaco47vV1TZkyLyQQYXUlgx2V3JOz3P5M9gq8GlkUzhJi4p3lpHkapQQ6jKA7lBxJNeeIOQOBpU/Lxk+kFw+j/OUrMjf6WUbFBmXSgvCR8dlmxmc8X81Zqafs5FIKLPZyNAj7Iwfp4GTmO6c64RqVvFTcYPU3hlbNux53QHPHb5nuNiEohAsRE8oAyblWOwzoWSOFS/uBnzeXYG1FQKEarDKnBJr+OMY3HuAEqk7O1vu1PlxlhTZm8mOpaBwIsxNz6wyLi7MyCPBZPuoB2Iy0eks9/ExY/BbLt7DfxOj7FN6POAN3MfRBYXUZO4XPgoRRsNKbqrAEGu1pmbNpleqpRzq3rafYDLON8pJy9iRu3Qv0x+x3lO7PzbzNE9+HQZeJ2Hpfj1nnbkRO+U5BaHEoIAG/Jos6PZXRMDUuvWt6NPNEeJqa6iScLl94OmiiJbQfCpavDghiwfs82cK/bEcnSe5yxZqeLzD0mnSfPhKCv27g2dgquWgLzw4rp+7pDfBUDkgGFLtYHVoGmO16kEzdzdx/VAM+ZGcAvEvGAfQlEzMqbhoCH4Ly9mmKOro5wtvsRaoXrFsMEElHsvd6AuLaVT5hcKiaXUM7Tglb90IGSuUzAM/E8Jqw0nvepfkFIODDVr3yCcGGcEu0ZnOj9Fwu1nB4EACDuUtoH9WowhDM+sXYj3es2rdhsRZ11nWUcx86+Tq+3NEMdt1+InbP8Vfjsm3ffqHKnlDFyYjHJHQVfZT2ppVMB4ER9FHgTcJdOKer1/W8mze8LsLhW/lLTEoaEu+LAews1icqTIXrYpy4DgltGizA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(8936002)(8676002)(5660300002)(4326008)(52116002)(316002)(6506007)(26005)(9686003)(44832011)(6512007)(2906002)(508600001)(38100700002)(6666004)(38350700002)(36756003)(966005)(6486002)(66574015)(186003)(66556008)(66946007)(66476007)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clMg+9Vn1j36fUINFHsEp+JsVqbKlMwUxcFq1DPvxXnikDVNagG1AwwxYSOE?=
 =?us-ascii?Q?v7nnI651MQYkNmi2dpe1g8eF0PBtwFWK8INwRNizlHAfqCJrnDzYJIMdJjh3?=
 =?us-ascii?Q?M7+thfJ/0Tg4mDTl/Xgo8HZumUhtp2WFjgyyWCy93bAa58Taw77U3R4g2lvv?=
 =?us-ascii?Q?fNx+/LTkLvSfT/CkEZEgHIu09MuTVWAQAXadPhqzo0whaKwttPP+StM3r2Kq?=
 =?us-ascii?Q?1D2ExsCaTeUtExSekZXxz0c6QP7IVMP2biwcAIEKxPlRppls6fmJvwsozHop?=
 =?us-ascii?Q?bh6H+8gGPF5waCIKq2m98GRlxlKSbtQaOR5LM6nEQT9hQQl6JhnYuZH8bmTm?=
 =?us-ascii?Q?IDSgumjI8pKcOJ/BLyNqm/LFabyN0+q2/blxcl9IAWSw1oE3svayq8kw258R?=
 =?us-ascii?Q?rqEhJW/ZYf1osPDmWf2xAxF4YWGo+BMZ26SWglBg65oPfYwHKG5zvDzerIp1?=
 =?us-ascii?Q?6eWhA4ImojMY3NuC6qsMU3DnXWHyINOYiACA2Nnnqnmbz004aPuy2poYEqwK?=
 =?us-ascii?Q?T4+Y7sbVdMq3LBRr4vwrQQ6pkH3kAvjcCxajkdiRPE7y5q+zPrKowYBdLfJv?=
 =?us-ascii?Q?vWXHvs8OymsHfZT+RXj92YDwUaJLDGvgn1L9xhIv+K6aHLn8yogwSGxkVfrC?=
 =?us-ascii?Q?x9DWpfgDBMql2MN2rwEbfEgM717PTUMElRxLs2CHFhVn07bfrIcof1dxNDbf?=
 =?us-ascii?Q?8+AFmt/SdoYLH1hFNQVX9lqa5mIEtw34PDvtySMr694Yw0QluSt64taDYlBu?=
 =?us-ascii?Q?LbaKG5TlgyHlUnsIhn5/F/VZ0F4wEnO5n3KVAn8JBAuRaKNNsWMOZDkgdM3Q?=
 =?us-ascii?Q?FTGn3OSvnFNzsQUL7d0YlqPeRO58LwxlQLsFZ0gIgUMgDvqx2bOTH3y8xIdC?=
 =?us-ascii?Q?pgb3+Mm8Ms/GmBfVly6g8TcmoZ6NAhhzGmtGg1x11YCEK1LFpSYBOzsC6nX4?=
 =?us-ascii?Q?kge8q7CKguOJaJYHoqNYD9WnodkFytQyYn7NlLaUfJaBX5UM9qY6C79KGKZU?=
 =?us-ascii?Q?Wi61M71QxVGif/bsO3nmX1it3MoyrLsXl3FADfpCkFowcHAdbvQ+6Ros2Ftf?=
 =?us-ascii?Q?9Yg6hLI93YZC9yT5AC1/XCozXBRIN54XIHAugctofsHIb0MLnK8LAh50Ia7l?=
 =?us-ascii?Q?L9rkh/sICgEj6ibbKCOVNVD4lHSeQWI9JeuF71wYXUcsxRU41wkxMCW8R3Qn?=
 =?us-ascii?Q?jihjTuiHX9crikas9UCzF/yZYtZjGCUwzv4p58Oy1XjvDW08+lKZGR7Wi2ho?=
 =?us-ascii?Q?oMidg8Eez8Rh/dOnkoCliybp8MrribKUilk84mz+jTbXv6OJgd+SPkVOgVMl?=
 =?us-ascii?Q?dOZXzVHfvNjtkX8/lFmH6Zf9N4NGFbl7N3dS1t8mJFPCkfSlUSrR3kD0Ic10?=
 =?us-ascii?Q?H98IRMstCCxXPCNqoFbXHbBXj+4NxarRSmDRH5NKuKLq9y7iqIg+KKTfFDcn?=
 =?us-ascii?Q?7AUehT5LSyjheg8HkfCkfd/ZhS/6z8MhE12e2LfGxcmE+Lk0jv9P5zUEoLta?=
 =?us-ascii?Q?FNtpY72+ZvSy3WOzB1vcC2KohPwH3D/Qy0gIrb8lZ3hgIK5by/aAbbrKbsed?=
 =?us-ascii?Q?JkirfjCTfhqg7ZMwGgks87MWiA2CmfqCljR51XERYLpzS8LyXqcjfuX2EZwK?=
 =?us-ascii?Q?gFNkt1Gqv69xS80sNlHvZgO9S4gqk7NGItQ2B3dAbg7wyOx+YESOvmUIkSog?=
 =?us-ascii?Q?O0pWrnuHQ8kgKP4Y0+ccVTVFdCtB4zNGigFAKH5IZVeLXeKNnKoHDYph3C4q?=
 =?us-ascii?Q?NdHODgE8FmqhE9SxUwupdYVXffWoVL0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20e3f3f-7db1-4a01-0cf0-08da26bedf41
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 13:24:05.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAykXS1MuQ1lvNllEBeOBKBBeZ0UhDhrUUSTQ/MifNVZ5Ooycd72nQlySl31k4TOBR6UuRkWnJPCF24LLB09Q8BHQe0e7CEinpEtsCd6zRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2110
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_06:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250059
X-Proofpoint-ORIG-GUID: n11l47t-lURtsCEl34XpOkIgFbs9TyRQ
X-Proofpoint-GUID: n11l47t-lURtsCEl34XpOkIgFbs9TyRQ
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zqiang,

url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-Dump-all-rcuc-kthreads-status-for-CPUs-that-not-report-quiescent-state/20220424-121850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220424/202204241503.imwh5SqZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/rcu/tree_stall.h:467 print_cpu_stall_info() error: uninitialized symbol 'j'.

vim +/j +467 kernel/rcu/tree_stall.h

59b73a27681c58 Paul E. McKenney 2019-01-11  440  static void print_cpu_stall_info(int cpu)
59b73a27681c58 Paul E. McKenney 2019-01-11  441  {
59b73a27681c58 Paul E. McKenney 2019-01-11  442  	unsigned long delta;
88375825171c7d Paul E. McKenney 2020-03-31  443  	bool falsepositive;
59b73a27681c58 Paul E. McKenney 2019-01-11  444  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
59b73a27681c58 Paul E. McKenney 2019-01-11  445  	char *ticks_title;
59b73a27681c58 Paul E. McKenney 2019-01-11  446  	unsigned long ticks_value;
17d9de741a1aaf Zqiang           2022-04-24  447  	bool rcuc_starved;
17d9de741a1aaf Zqiang           2022-04-24  448  	unsigned long j;
59b73a27681c58 Paul E. McKenney 2019-01-11  449  
59b73a27681c58 Paul E. McKenney 2019-01-11  450  	/*
59b73a27681c58 Paul E. McKenney 2019-01-11  451  	 * We could be printing a lot while holding a spinlock.  Avoid
59b73a27681c58 Paul E. McKenney 2019-01-11  452  	 * triggering hard lockup.
59b73a27681c58 Paul E. McKenney 2019-01-11  453  	 */
59b73a27681c58 Paul E. McKenney 2019-01-11  454  	touch_nmi_watchdog();
59b73a27681c58 Paul E. McKenney 2019-01-11  455  
59b73a27681c58 Paul E. McKenney 2019-01-11  456  	ticks_value = rcu_seq_ctr(rcu_state.gp_seq - rdp->gp_seq);
59b73a27681c58 Paul E. McKenney 2019-01-11  457  	if (ticks_value) {
59b73a27681c58 Paul E. McKenney 2019-01-11  458  		ticks_title = "GPs behind";
59b73a27681c58 Paul E. McKenney 2019-01-11  459  	} else {
59b73a27681c58 Paul E. McKenney 2019-01-11  460  		ticks_title = "ticks this GP";
59b73a27681c58 Paul E. McKenney 2019-01-11  461  		ticks_value = rdp->ticks_this_gp;
59b73a27681c58 Paul E. McKenney 2019-01-11  462  	}
59b73a27681c58 Paul E. McKenney 2019-01-11  463  	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
88375825171c7d Paul E. McKenney 2020-03-31  464  	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
88375825171c7d Paul E. McKenney 2020-03-31  465  			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
17d9de741a1aaf Zqiang           2022-04-24  466  	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);


That tree has some new returns in rcu_is_rcuc_kthread_starving() where
*jp is not set.

17d9de741a1aaf Zqiang           2022-04-24 @467  	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld rcuc=%ld jiffies(%s) %s\n",
59b73a27681c58 Paul E. McKenney 2019-01-11  468  	       cpu,
59b73a27681c58 Paul E. McKenney 2019-01-11  469  	       "O."[!!cpu_online(cpu)],
59b73a27681c58 Paul E. McKenney 2019-01-11  470  	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
59b73a27681c58 Paul E. McKenney 2019-01-11  471  	       "N."[!!(rdp->grpmask & rdp->mynode->qsmaskinitnext)],
59b73a27681c58 Paul E. McKenney 2019-01-11  472  	       !IS_ENABLED(CONFIG_IRQ_WORK) ? '?' :
59b73a27681c58 Paul E. McKenney 2019-01-11  473  			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
59b73a27681c58 Paul E. McKenney 2019-01-11  474  				"!."[!delta],
59b73a27681c58 Paul E. McKenney 2019-01-11  475  	       ticks_value, ticks_title,
59b73a27681c58 Paul E. McKenney 2019-01-11  476  	       rcu_dynticks_snap(rdp) & 0xfff,
59b73a27681c58 Paul E. McKenney 2019-01-11  477  	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
59b73a27681c58 Paul E. McKenney 2019-01-11  478  	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
88375825171c7d Paul E. McKenney 2020-03-31  479  	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
17d9de741a1aaf Zqiang           2022-04-24  480  	       j, rcuc_starved ? "starved" : "",
88375825171c7d Paul E. McKenney 2020-03-31  481  	       falsepositive ? " (false positive?)" : "");
59b73a27681c58 Paul E. McKenney 2019-01-11  482  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

