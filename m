Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F6C597965
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbiHQWBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241472AbiHQWBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:01:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F9A99FC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:01:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HLXdMa002572;
        Wed, 17 Aug 2022 21:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=wSd/c74xL/X/CGi+NsArGmstpntDX5INmjxr8STErs8=;
 b=cG6aAUwDWVn9NbKzcOrYexThu+TT/InV51aMcquyFvhYSN+BN1liHrF9rSk2MDUk7ksH
 jvqn00UogqTDRT2urzOXv7tLHjSNovk2XMV/uiaY/c86+q4Gc0HMY/Umpytsbn+tgbcO
 PGdAU2UtER0V7ykPop4um7mhUWxQgyTms4+c1WpuDbTEDXCYbH4SM+wh8I2WqIOggqTR
 GHLg9Ml7PYLkeOMKFvWgM/5h6MWw0gI1IRV7UKv8aTIT6F5FU7Qjf2CqxHsglT8ASoti
 kjYBuagJNR7AlxGKGaqThuHPhXma5KJ6AApNEDBe4hlaIxI+wHwoqBcAjAQULk5/r2N8 Gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j18bug1jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 21:58:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27HL9ROn025498;
        Wed, 17 Aug 2022 21:58:22 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d3wa89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 21:58:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izERSp35+NI3CSRJv9jOPr83dLUoqzojwqY5lJQhoDrTaOXtxZayQlPu86D9pA7HHRuFPz3DCcD0J1YuepjDNIexn2M5hB43j+sex2vvatnyEfyr9peklH+x9mIb7p5E6wQeXyTe2P/gqb8RRbRZm1+15MSwRsU01G70bGpIX9juEohA7UJkKEoTG7efV8yACRljbT4KkvHyKV+gILtDG2N7ZI/05dO08OLwepYWzndhTSPvG3DVftlwGj811mrixtHCVW7GTjFFjacBKAqItpnGnSwVtfdnkslkz/tE9Bty9uV/52u1xEtXGu6RHpXJRtbzPGr0EZA3UdGuTaS8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSd/c74xL/X/CGi+NsArGmstpntDX5INmjxr8STErs8=;
 b=FjV7p4rBYz9h+o3U4kbMIrKOOfOJCe4C+VOzR07e/uEnOdoqSl8MtamLV6/TIejwIlEmTR0jEkQUrMUoo9WlsmeJ8+ybgcOLeXOu3De8wVtqrvuj6MeezJKNU+BCV8fo3SQFGHsfO5Xugx+uwOdIE7csYvt4xEhKmvRWZRlq5m/IxatzGHRW3t459yn1Cw9/NxY9DcZTlS4FGmKsZICe0v91PmMPflzr53O74EHt2J5Cb+EKePHYwAivnhX7XsahXCVJ10QZgOdP2bZCWCrqAH2Gdmi0GHQqHtnN8trV7mLNuT+lNb2CuiQpS70BVUY17l69qk9qbVj3CWzIqRS9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSd/c74xL/X/CGi+NsArGmstpntDX5INmjxr8STErs8=;
 b=ulmy1FCMzEvbfjRViAu0Zm4ngd237aD3CNVmT4dfcOTf8zENdYVr+U8QmHdV3JlcMQhd+Y0qk+JMylorHjCl4pXrHdAwzrzmkRxkdLon1n6S5NN0eJpV/SYmWVpBFpWblBi4/9I5RcA1WWPifVszXaTa/H2v+V43wWTKbDSix3w=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR1001MB2208.namprd10.prod.outlook.com (2603:10b6:301:2c::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Wed, 17 Aug
 2022 21:58:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 21:58:19 +0000
Date:   Wed, 17 Aug 2022 14:58:16 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Wang, Haiyue" <haiyue.wang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Message-ID: <Yv1kePLTUJbJkpUW@monkey>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-2-haiyue.wang@intel.com>
 <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
 <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
 <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
 <Yv0ku1mn4LBzg/zG@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv0ku1mn4LBzg/zG@monkey>
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69a9859e-6837-46b9-a3d4-08da809b9828
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2208:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PL3T8SKUQzYviyhMgXNUmQtSoeDNpMWHxDThG1V39K3S7Z4qjbKDOagq1XP782vLmaXvhz03Y2J/4TxPYRlxOz7shnlY8VVoGehk008jiZQ5/b7CDvHDNxjW1J7z94LjH2oqdZdK2/PKQCUTeScwQqkWpIEfHdEZ1Un9NZP1XMyS65GrVF0oRZEphJeeQxZrNPse4A7zzCSNZfjIRTnQ9/8Zufq4V1jn1SGHiIi9Fi7I8ZdHutdE7rT/x/mqhRVBvn3YyHfc2zzIEIG0TIg7IRj8q7NrCeRiwPoJuUVe2KAwioBjjLiMdUjJ0NJyH4kpKkP7B7IryacXIsnO4dob04D+Kj1rG49wqJu074nPX27wi2dUmQU2tC7rxMTJJ5uTTgF/0jgrh5w8/g44G3RqJzrMuRUbY0Ls7/1sPn0deYh107buMVoMq4DWVckJyKewBDuuD/78w5jTygVyTqpEt4bwwrqx7O+wqpPGlHxfYyGpy4ydSpRSmYRjT71Miz47pEKifOWFrVCRRFfUBl5LdYPKkMFClTTErlexbZVi76+KUipuLBdC0P3tK7uOC/EgnJRZKRMulKII8eQOR8pn+jfAjh9BnkU+aHkFqjisbFwKpDyTghxhPA95qEqrfGKIhR6RHDnG/Tb0/Xz9u3lqxhuDSIGfkj1napf+02e1pSu2fuFOgZZDHm96m3Z4XmqbMvn/FzmyW2/aOY0Y2MXXGqS4od44Ge+vIveo2BH41oKCojyl4dYxeKTPAg9ubj5R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(346002)(39860400002)(136003)(396003)(38100700002)(186003)(8936002)(5660300002)(83380400001)(8676002)(4326008)(33716001)(66476007)(66556008)(66946007)(44832011)(41300700001)(478600001)(6666004)(7416002)(2906002)(26005)(6506007)(110136005)(9686003)(6486002)(6512007)(53546011)(86362001)(54906003)(316002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5rMCstl69I1qYtXX0sNXnnU3IP5AVySO04XBDgEADUXa4o8dWGQv9om/JYIi?=
 =?us-ascii?Q?rlV/mwEwV1U8VVPhxyfS+E1JpA0bdkMQKp+8Ekdy6zXlwjys45p9Bcr1V99O?=
 =?us-ascii?Q?r1hybkumfXXzj6yjSCT46yHE4zgmdZtOKPSHI6+Kx/GLj2NvJ+k/oVKG2SRn?=
 =?us-ascii?Q?v1UN5nrd49u8AhwqwuG/tPKHcqx7bBjST1R0iSRbqxA9ZFThVTe/+G069qY9?=
 =?us-ascii?Q?hyp0AiIozi45mAnlYEibCQd/kDjEFVumgQVip/iLYwND58GP6pTceIJ3t450?=
 =?us-ascii?Q?EKU5LpuQHqxq5NwXPqo/r0B/wMyV8EYsGi4gdXQ62tp0U9nDf5RmM4U5xFwo?=
 =?us-ascii?Q?J8NITcbFTyXHPhcX9cbVKEUR74Yoe6h34RRniaGjeaGy4jjeSrKmtaaVqJa/?=
 =?us-ascii?Q?nA0InowxxUBidOV341nCGfA3ZV9BzwllfkRim/jjOmoDH+E+wVgN2YIDg3TO?=
 =?us-ascii?Q?8MpILX7fAb8Iqi+A4v4lp11TiwsabRWZ0Fau41hT9Pi05cZvH9kYw+Q0y0ac?=
 =?us-ascii?Q?Qs9vjJ5w9DCLl997sUGCg/+Ascbh2VXmVpesbbVJxO0cSLDejqta6FkoeBGv?=
 =?us-ascii?Q?41MGU5fb27ep6L7QcObb10aDYac+edsw5xz3YSFy55aY+vZ+UwgvPJ7BCGJC?=
 =?us-ascii?Q?5w/Hblj3GsWgeg4zGoA/+LrC9gCjAJkVNwIcQ3VG6mFztCPO06Xr325ThPOH?=
 =?us-ascii?Q?ANWmaSGlOxwjPCiUA/5ekI6I6DfTAtTv8cX0ki96NTpX5aDNQniiFRqvJUL1?=
 =?us-ascii?Q?r6cR1bCTOwyRa6BzyaV8CjMGqIyvTUL1vGg9NYWhFKSyE/5ni3c0vQMmeavD?=
 =?us-ascii?Q?+3peED46UQFtB0shw6I5B86sYopvs6pCfQRdSsWkVydpWp2drF5zpTIisFxu?=
 =?us-ascii?Q?zxm1QHZkK6WkeAqYrQwQPgMWwvZuMfS3MrVGS4AJCT5z+D8SHsaw9c1TaPNc?=
 =?us-ascii?Q?pPS8C+8pMI5KBqX0VJD8w46mHOrhlfE9e0EDo921Q6STn/ZzJIh0XONDPAfk?=
 =?us-ascii?Q?PUbdiILgJRArgoTDkRClObdGcvAbUO3v1pC0pr3cie+ZiJ915F8/bMKFX3O9?=
 =?us-ascii?Q?3HGkC4B3iWfkcHEa6MX32hlTBzaKYCFmehqahoVBND3j3X3WrjcXstJtSZqF?=
 =?us-ascii?Q?30Jc9V51shxqXLcd219GjRxAJYj9NUfV73pF8wfeAhjUv7Rt8EZxknrgWWDO?=
 =?us-ascii?Q?pQTP5o/jY7wLBwl25i4m5aXJHlLjvY2bS+JqcjvDZOQsHCojEw4izFpOdnkr?=
 =?us-ascii?Q?llq0LGYbgHu6NSECFVfKvAie9dfR0Gig3bOAWhU81MkaeEdtjhCtenz4nFRc?=
 =?us-ascii?Q?aLy23ftfFH7PEENYdkDvlSdRLCdKDss1MC1DQG1bNH8qZFX+X5AT4qfCbJXv?=
 =?us-ascii?Q?CjgjXmR6ndiWjQtCJzWJ1tDlOOYvP+aldfbmK1EnI4G2utyo+WpHpgBS5PJr?=
 =?us-ascii?Q?D5UUEa2YZYRodxexRJgszR8uP8SvY/RXN8Mc0jZWavbi8Rv6/sjY9EtqQI5i?=
 =?us-ascii?Q?7oo6y+/US8vdl5rmEN7Vpn3XiVHt995t/v5YIro3IE130G1392XyOoELwIw4?=
 =?us-ascii?Q?qnyQJrFkDNPlW8fTk0wGkMDJ4lzQ1IyBjJynH7ZREE8XeRDoLbc3d0bhFZsl?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lcb3IitYZljYzJc46GtascysfGtpKQotOn1Gj0lmpjxlcZ9A5dG3UilRlTVJ?=
 =?us-ascii?Q?iScvmceaPnlRSVMPMDZ7mJrIxhmxV68oa579JFK0M467NVjYKZf8F/uF4yZl?=
 =?us-ascii?Q?aODd4ZitwoA6TTPkb/qOtVcnFJQRVWEt2iFW+bGRyPZVyKvIsBi+qYq/A6Qe?=
 =?us-ascii?Q?Ef/G+FZnG3Fldz0f6QweaVIdQx7A0wA+Bd/ActpRawCipWla0bC0lkjUwmKl?=
 =?us-ascii?Q?qU6KhbGgLcUA1aCX7A2PHdQFjUSkydVfiMXfOYNBp3EfgcIu74MKJs+gZ6nO?=
 =?us-ascii?Q?OBQgpsTtYCFdo8a88JaxPULvkVtFWet50JGeaGxUg/HRJuEb2Xf1DmMtIY65?=
 =?us-ascii?Q?kFJKd0ZxHfDiaSthv+McbSyENF6s9S8W62FAeOD5EtDO57HgPNP1840lpCfa?=
 =?us-ascii?Q?z41yRGIxAEd6nha90RKgfaUhSvpCbkagaAGPfXrknMLy/yRb90CbUGke2Rb3?=
 =?us-ascii?Q?g6nk/EnfJBLUU95n0XnsvGq2tRh2VHB8JS0380BVKR9Y77oHyVp58RUYsxvU?=
 =?us-ascii?Q?8UISiT5q5KYKiFFuqhjvL7Wyb6ioy+XVmSBAkQ4CDWHTpAL91vBx3KRKqZBe?=
 =?us-ascii?Q?+OMsvQZ7Ysyt2aAqW3MiUq1g4xu1noPTLuRkjQOAKqi8G2aOs1Yw3hoxB6i/?=
 =?us-ascii?Q?F8aSTrkAtAh4Xxi5RoK9Heumgf6ci22VbqfGBpf5BLpTKCaKAGiCUO8nNrrz?=
 =?us-ascii?Q?dSl6HztFgtWUpXl5/JXnyW+at2BjEWQaW+JH3OxmBtlutwn6VNISqAQP3Zbc?=
 =?us-ascii?Q?t1n3hIJK8JHJLJahTOGbIrFwyMS8svXRRez33GSWri3Zc3bgbFmu6x/wlGqx?=
 =?us-ascii?Q?nICwVDY0PiJHWWL0AlKmaGbbvBOrXYiTVce7sPfBR1rKvGd/UowLwUGF4LsT?=
 =?us-ascii?Q?n8YeAQt+QV0lyFoKdMlwYwROipu7isETO9QyrDsK7MxAHoQ5L80pwlaVFRfM?=
 =?us-ascii?Q?9LZcMPcuAPgyqe4w1Hpl6pngBCkFu9iS647tP9/OftkKtcHinZqRwtht0R+e?=
 =?us-ascii?Q?EzxIKKn11GLwrYB+y10EUaSWzpT+sHTeTgAKAQ+LcKGebb2nMJO2asaNxA2o?=
 =?us-ascii?Q?Tr/7TSvrxbRksrDZmfvbY6Kdp6EOT5uwgj7+I3KG6aluk/YGdQGY7M4yrChj?=
 =?us-ascii?Q?tZVjr99UBRLG6KFrxf7BJYjzb4Du1eHRngnbHDVtHXImC7Cxc2ZUT3l95EOX?=
 =?us-ascii?Q?2bwwc2RQnMw4Oj/48+YBQn0+XOAA70XYoIVKE/1fZmTiRXZIgi2j7f1KJo/S?=
 =?us-ascii?Q?+O2uOyRzQO7SL+qypQmyT8qn4a4IAN6qsRAEbRYROWl60QTGUv084T7UEtku?=
 =?us-ascii?Q?udkc6p2fCuBvobRQcnMN8nX/GTz5nJPFjfP7WoFcxWBUb9cGILKOYHY9OI78?=
 =?us-ascii?Q?00zX0qgw6Q688TGQIZme9LW7maEjVFcLPGV+Hbg3mmxQitAB1lJ3BTc/VY9V?=
 =?us-ascii?Q?nmpDj2KbfBwHl5/LDZ+gjPR6YD8eMkQt1W2EJQZ2P40QysVgusQXi7OhKgpc?=
 =?us-ascii?Q?PdiyZoFmyiA5nopQ/1QfZC5Ce95n48rQ7dTA1vwd9nzagtDSoFcemTFsZLOz?=
 =?us-ascii?Q?qt1aQIem1lWRAw4g1FuG/Wykzx8g3us/p3x4MhRkBP3kVsZbpoayBOy3Nbug?=
 =?us-ascii?Q?ozEA44vefuwV0OteJf1+ZR0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a9859e-6837-46b9-a3d4-08da809b9828
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 21:58:19.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6YkmD8BTu1jyGfLhhTfn/sblIECWQvarO/myaGaTlX582U/FEu57J5CZcYliC30oMWR6yWCBxA24f/DL4udeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208170082
X-Proofpoint-GUID: BA7dH6e0o6i_9mec9ZXxTVc9lrbHAmB7
X-Proofpoint-ORIG-GUID: BA7dH6e0o6i_9mec9ZXxTVc9lrbHAmB7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/22 10:26, Mike Kravetz wrote:
> On 08/16/22 22:43, Andrew Morton wrote:
> > On Wed, 17 Aug 2022 03:31:37 +0000 "Wang, Haiyue" <haiyue.wang@intel.com> wrote:
> > 
> > > > >  		}
> > > > 
> > > > I would be better to fix this for real at those three client code sites?
> > > 
> > > Then 5.19 will break for a while to wait for the final BIG patch ?
> > 
> > If that's the proposal then your [1/2] should have had a cc:stable and
> > changelog words describing the plan for 6.0.
> > 
> > But before we do that I'd like to see at least a prototype of the final
> > fixes to s390 and hugetlb, so we can assess those as preferable for
> > backporting.  I don't think they'll be terribly intrusive or risky?
> 
> I will start on adding follow_huge_pgd() support.  Although, I may need
> some help with verification from the powerpc folks, as that is the only
> architecture which supports hugetlb pages at that level.
> 
> mpe any suggestions?

From 4925a98a6857dbb5a23bd97063ded2648863e65e Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 17 Aug 2022 14:32:10 -0700
Subject: [PATCH] hugetlb: make follow_huge_pgd support FOLL_GET

The existing version of follow_huge_pgd was very primitive and only
provided limited functionality.  Specifically, it did not support
FOLL_GET.  Update follow_huge_pgd with modifications similar to those
made for follow_huge_pud in commit 3a194f3f8ad0 ("mm/hugetlb: make
pud_huge() and follow_huge_pud() aware of non-present pud entry").

Note, common code should be factored out of follow_huge_p*d routines.
This will be done in future modifications.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea1c7bfa1cc3..6f32d2bd1ca9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7055,10 +7055,38 @@ follow_huge_pud(struct mm_struct *mm, unsigned long address,
 struct page * __weak
 follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int flags)
 {
-	if (flags & (FOLL_GET | FOLL_PIN))
+	struct page *page = NULL;
+	spinlock_t *ptl;
+	pte_t pte;
+
+	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
-	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
+retry:
+	ptl = huge_pte_lock(hstate_sizelog(PGDIR_SHIFT), mm, (pte_t *)pgd);
+	if (!pgd_huge(*pgd))
+		goto out;
+	pte = huge_ptep_get((pte_t *)pgd);
+	if (pte_present(pte)) {
+		page = pgd_page(*pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
+		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
+			page = NULL;
+			goto out;
+		}
+	} else {
+		if (is_hugetlb_entry_migration(pte)) {
+			spin_unlock(ptl);
+			__migration_entry_wait(mm, (pte_t *)pgd, ptl);
+			goto retry;
+		}
+		/*
+		 * hwpoisoned entry is treated as no_page_table in
+		 * follow_page_mask().
+		 */
+	}
+out:
+	spin_unlock(ptl);
+	return page;
 }
 
 int isolate_hugetlb(struct page *page, struct list_head *list)
-- 
2.37.1

