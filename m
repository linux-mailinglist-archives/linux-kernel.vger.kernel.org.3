Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82487597512
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbiHQR1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiHQR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:27:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA92A0324
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:27:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HHJ3PR017947;
        Wed, 17 Aug 2022 17:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=zlmxeRIXwSZQwNxLn2aNOXMBf9Qg+B3LeKKH90zOWSM=;
 b=DkcH5vc99L1RGzL9O/Vdu2fFmNedz+ZNJ4EnfFEA39p9RiCiHOBJSGIDcXUz43mDC6+S
 eZUWBjGTzasBVEdaubNe9kpbXPybi3QI0oh3tpZxeCuBS0RaNA1L+UrRastNx0pGbU24
 AMRJCWU3ZFKCUztNELRWbNov7tu9/mGJFxFHiqsF5jzbkBRcJ16A8Jus1wuC9k5wQa0a
 zR1lH8J885gJ5ptBhPz+kqTTXrYurY3Sa0sr+7lv0EXzTNm6fQa+/L4LHGDrSPvYZGdd
 fsznH9OgGyMnVU+H/axFDQvttidRNxUBTkknfi+WrJs7hdPq+dgHg7c+IbOFKEPJcLFh 1w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j0nt924kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 17:26:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27HHL2YT032766;
        Wed, 17 Aug 2022 17:26:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d3qrtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 17:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwW1qBoNrvr1mPT3mfkxYcqEsm7sDYC6jWZBxHu2yeION5UMZS6X8MFEMTqc0K7DPbYcCk1pnskXfGnQruI2+u6DvAyTMy8RWYd1VrrtstozOISJqaW9aNbuDDqcmdx/l3pqehlRF+Rsm8fQYy4Uqo3fS3m7WZPUodwCaN0Ig1p+eDrlY2btxfHWkVHzxTQx8OTOK4PAKro6sI7s4nSokAkRspPfGmNPbouRBT1y5TKLpbJHBLPMqKDCUJDPrXoPMrotF0J0OTixKMLCwFAQbAgNn7dW7csszI4iIYrL9W9yiK9anLQTZyLz6F/sf4BZpFhOu+HWX8WAcjLwlrlAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlmxeRIXwSZQwNxLn2aNOXMBf9Qg+B3LeKKH90zOWSM=;
 b=JVGcGuc6L48A+zbj5AKV9Ot0asQBAJFr/2lHsf5UCtNpj5e+4DlcJeWJli1MO0Wp3ccARJVHDQaNS5P/ZTMMIMr0rMbYJsNUYLdi6TYnaZSDcyFk7pvHCfWGSE7JaQjyjFt6x/XNE18tqTwusyVrE+LTQ0vQGWtMHp0n2j7xkBhXWVjh/E7E/Ygl1uJUzlF6dkn4nRiAtUeiS+4NO/XvQLffAuuYpuMd+s0PbiMzIyiiNwh/KL31KKzm8PwC6lqBW2a5m40NjjwGaiZ+hT4rT/S+Uv20/4XqAh8RrDYB4CPk3v8KbwYD8a7Fi9DE5m2O7y0ppt33Wtbafevrz7uSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlmxeRIXwSZQwNxLn2aNOXMBf9Qg+B3LeKKH90zOWSM=;
 b=kf/kQDm6x1clT4s0USjwPYJ9YIDYrbli3SOX5rSeW0OcIgTWGLIfE0CjD5W9xwJ3A4v2Og914kOQdTfBPg21l09dSTQuJsSO82/TgJ8Jzo7vT5MgdXhgMcyyRAgbF3CgFkzkVZGbQxHZjsnym/YQCq/iz9KNsE9aQlY6d+5RgUg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR1001MB2051.namprd10.prod.outlook.com (2603:10b6:405:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 17:26:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 17:26:23 +0000
Date:   Wed, 17 Aug 2022 10:26:19 -0700
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
Message-ID: <Yv0ku1mn4LBzg/zG@monkey>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-2-haiyue.wang@intel.com>
 <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
 <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
 <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c76d7d3-2a85-4cb4-30dd-08da80759b15
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2051:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UG+4Opkl25I//ZZzoTUjCTiUS0pze8zzu+KXOZav0KcOsLUQ1DfgMw6sWjGdIZD/Mdhz0ArSX+OE3wq9j7TMBwm6g7+KicJYnivs65Fo2HaZI43OSrumznGAeHHnz+oAmo4FqEzsKaX3ZPyW2k8Cv0Ffludpv+5vLnV3WJbIgopkTWkAl0/FmTFfgtjaVnHIg6JLkxMWAr9sZEa8MXExFf+s5PMxEujWtC7B7ZMTaoW/7IU5HOaOr1UGmCONLQzCd7dW7Iorbqw/vIc6Z+VYDd90SEwrY9crcTK/AJX6mNf+0FAjvlUg7cTTGJsks050b+6eW1n6EBUkP+ENjjPuaFHNIImzYSqBnLRlNU/bKDsA0LO2q+rmqQQh8oheCq0CXjyry2ON3ebD/hNVcNobQLd6r9RoZaMMvESR+6+OnZn6yHix9+DRnmzDBdLDyHjQ1njwey3Mw30QhuzPhxrrpETAIrG3RxhSxPOmy0p/K1HQ46pM2P7CdwtLJCmQ1VY7dpfiofjRz1urkWnhod7Ft5vp7Msi6cNmq4Y/GVXRqgvlaBIRDBSH6An/RLnT98rJPEyvWpjo7ZsXk6POAg3t98lCv8No1XfHIBWPCOQYsvKkmIbL23fy30IM/XNt8i4d5PmHu2m9g62U+3Ksgh9Dd4b220SpNlEKTCPium+1E32V+u3O/JFY38SfNLhh8ZYBN05cNQVV3929DfC842QUPjdPzBynlRTqneHoXatkxj/4mpUy/LEdELntRCXqt/Q/Q1ErYS+w9fzTV/CzXJ7Ffy0xv2CcUAuT0XgA7omh3VM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(366004)(376002)(346002)(136003)(83380400001)(186003)(33716001)(6486002)(478600001)(38100700002)(316002)(41300700001)(66556008)(6666004)(54906003)(6506007)(44832011)(5660300002)(7416002)(2906002)(8936002)(66946007)(26005)(9686003)(110136005)(66476007)(6512007)(8676002)(4326008)(53546011)(86362001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikx6g+9RNz+27AGzUckka+bLqG9KIc+/IcZPdqOHy8qJe8eG7YthDm3daJ5I?=
 =?us-ascii?Q?Vnv9EE7ufxXEZqDL0QaLzcu2YjEKMWpLaR+1PrkMZcjCbf8VfIQjAb+jBDWv?=
 =?us-ascii?Q?rEg18/pf6BkQv7xoEbanVscTdsCd5iZ4Zn2mii5bEbsqyhNeEvULbKGNBbjA?=
 =?us-ascii?Q?DKdDCn6bEuWlZTJ3zJZqtudwuBmpBTe9pYH1tvAU7tigKW4NjNgX7RHkPmhG?=
 =?us-ascii?Q?6ZiLSHidD13mzYyHq3gGQGP6QW4mAB36ymJtVjM9oNWe1ms6H1/qXOf0kW7E?=
 =?us-ascii?Q?Xcb+eKZdawZQpkypB539JYeQ+o04niuputLn8b0J6l0PLhlYs4VDfQtMZ0tC?=
 =?us-ascii?Q?KrFs2sPUvNfQOkieKdj/a6oUpf2VkpZTyM/t+r6Ns4sGBZou50dNdBn49V46?=
 =?us-ascii?Q?yhaX6yn1UZlq6W/T17abYW+nz9qx97NhN969vINk3A38ajofOSsiYz07uoC0?=
 =?us-ascii?Q?cPWbVe27YAtb6Hw3QLg6AircPoeP3B1Sf3/b+PaQV6nx5Mfblp7v1f2M2TjE?=
 =?us-ascii?Q?XCtdAcIc+w1JjbHMMgpPWqwYPq9wI5JSsXY7UJTLOUJ/uPc9UrA02k7K4BAO?=
 =?us-ascii?Q?xIERxJNV4zF77IZEJvkHWfQgY8CBgcpPp06uiZ2MJM2x/HQWW64UHcqFqE2R?=
 =?us-ascii?Q?a+Ngduq7IdwNvGQvjf3bJvHVqceBm8yp4Ri8a2/l4BjxbqtYbyCBE+aJa2wW?=
 =?us-ascii?Q?m6lksE6PgO8b/cd9xBFCJfRIO/Q39ZRlKFHaNSapNmgA8X+1tjwDYvVT7tYM?=
 =?us-ascii?Q?+mtRtHH1J472aNcPk1WSS+P8xS5bZrkJxtqovPEUc2aEszZy17b2BwYtesSl?=
 =?us-ascii?Q?o3+pe+noWzeWu67XuT76GlsfchDJGWCwupyTHF+HWX6MVtYCrY0gG6G4jR2V?=
 =?us-ascii?Q?0qhez+wlSwecrK46kWnklCkSn3j+zMKFGmfvM7LMFeGp4t5mtHItbEB+q/q6?=
 =?us-ascii?Q?Qzj5HI4VP1Xe05fEocTxZnj16OmQQ/F+C+llz+t6P6cYKcmXa8wn8guUJ7qH?=
 =?us-ascii?Q?mlZHuP822sOde+CY63Bh7mjC2sqzDuQL6cIwnEooa648NN+rJzs9j9BRMhMV?=
 =?us-ascii?Q?Mm2VQ0K3rGAM76vWZ/E06I0n0CyJhQLfvBwe9txr9SxzlMmdGSpSwTsOQnDr?=
 =?us-ascii?Q?+x2ijaNwTFSPhes2uWD+t+qpTPFR5oTWCISHe+siovZLtwQvj9q9xXHJxV0p?=
 =?us-ascii?Q?8MjlXPbYxiu4A8JkssnhoJKrsd7XZVt8ovpg+WePKtfUr/mOJN+FnRcxPBbg?=
 =?us-ascii?Q?tFMf4sP7BA7cjUx9ra2vU3SjWQ6yjLJuRrzSryCi+yZxWW6yWzakHbB2Kykh?=
 =?us-ascii?Q?qdIN5pef13KvfI0e+L/3CXLUirmPIsyB0uTcGEe/p0vCZ8rk5vlgFwRqI3xA?=
 =?us-ascii?Q?FJTM/GmrCablcX9PR3vo2XeNYrrYLMrCKvlVz1uk1ZQAnop53XRwmqalQpny?=
 =?us-ascii?Q?R/aBeMLtS37OBwJFD7yi6Kx5fGeFjzlm/tTYihThwzoXWErlpYK72nqTiq3Q?=
 =?us-ascii?Q?F4WXAthYeI/Bju54p9X0N896WhH3Us7L3Y/388wl+oWYyglJlmLMRvYnSp9+?=
 =?us-ascii?Q?kUx+pCfVCjBqo4VhpsGq1wZIyQL2R1UjcyopDetFt9JlSjt1GsVdXeN7iTUz?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MUiLKYyxqHeEcJB8BomFAIDdLWfy2xT1aZeJEQpQt6nxbAwy9qbR3xNCtiHp?=
 =?us-ascii?Q?cEzE86PSpLo4BjGdyj1v4HbKY2e7KgxMNLKxPjcuS3gWTYHOs6Wi6RjZjKgl?=
 =?us-ascii?Q?5uzmxEEv0S0HPKy/FWaoTPC9imcRlS1AK3An4FR/6mIpv014Ijc+qQpoTnNK?=
 =?us-ascii?Q?aNFhHsQvkklVFuYlDQGx/JPyPJ3lGXHF0RLFlJd/MumNCZf+phYWcVvPC/ae?=
 =?us-ascii?Q?0oZPg257Bs35+2o82oZ9N3FQlQ1YBHY2zF22DDJ7S9eg1yEoSzFZRD0dqsQs?=
 =?us-ascii?Q?bLHMvUd0IVx9P32shLdnTbg1O1fE2oI3x33wftUBDmsjFWx4cBZPYTm7eDqL?=
 =?us-ascii?Q?ivdXM9Nm8bTlTkhjcr0CjpTeWyVaojjsDejS0zmGn8iPlcYTwBZWEw1QZc6z?=
 =?us-ascii?Q?0kdQ8O9XESjbEfmcobgwA0IlRgtri3XgyBdbjcKdL20kzaTUMIjcvmikPZYm?=
 =?us-ascii?Q?8DijzfJe+6XLY5jltX1UoMpWhN8wWKivrHxUtGmUnWUNKtymG114EbXG7M7l?=
 =?us-ascii?Q?5HrigbPPk4fUPcC9Z98GvoQkxrpxwDxpS2/d80KvF3qhwaRta/5gGyaz/S6T?=
 =?us-ascii?Q?j4ifMFaBNHeKJGUh6W5fDGjpOtZcpjwkv9maCrDU+ygSmqLBRga3v1mNfAkH?=
 =?us-ascii?Q?KnRnqDHL9zVeTho2fiRT2FqMvlck/L9at4zPbi5Wsf9sKeSjsXJbbadwCuxh?=
 =?us-ascii?Q?cu5MblyqHjiagY5F508gzQ0UJRnM+upJDozmIRAycuRIdse6ul2ncIKn6ZOB?=
 =?us-ascii?Q?JMdWdd7KhY4QbZAt+pcnP7N2We0lK41tsYvzWKli4VUKGVlNWGcmwlRm9BtM?=
 =?us-ascii?Q?i2gMp5/fHsf7Bi5gT7x3Q2OywSGO3xe6wamk9tMncnigZUSfw7RJEh+x8wST?=
 =?us-ascii?Q?aU3qFqhVFIaKHerJqxemIwPYQP8J4QLi8n+c6jfJ8cAmT1Pbr4zbQF4oNWCh?=
 =?us-ascii?Q?KgfUoOMz5GTaREN54pIuDyvqmcOqeLjGKoTTz0fG0DECk0E3xgatslcHdLGb?=
 =?us-ascii?Q?FQDvqd71EPLaGtBysq+i+bRVvOvPwoDvu4sKcMbKfWQ0RFucli15EfjbLXad?=
 =?us-ascii?Q?oy84fW0hrJ+SABW1LYnKPmrgaturpHFnMMnvCRlWSXPtSJrzV02irEd3S6nn?=
 =?us-ascii?Q?dYNUUpx5si/OTOKi5RHBz6ZjKBH37R0ssnnWz8/M7nGv8tT57OTPyOmKJrHT?=
 =?us-ascii?Q?qiPQ+97PuDqEfx1B0pqoKWxiouVHwwe0mq34c3j0YVnz1Av2V3t2kHa1tsmE?=
 =?us-ascii?Q?Warxom7gqUYP3Un8c82nZ0JFDMYmfNSoHS72hy/PSQnroUmVg5hZim0LvHT0?=
 =?us-ascii?Q?xdaHz64qjMrXTzMSEg/We6yE3prSlW22YsYvASobdIuRTIIjXZZFzxBYIEkv?=
 =?us-ascii?Q?Aa480AcyIQP6FMBNIZWuKOd4GN56okNX8Kjptm71iqAQ2wajKTfFilwlNYZn?=
 =?us-ascii?Q?lVSNOIIs2eMkDm/VjyODtAJykzj6/UrI4l6LhJ7WN6yBmDBN4ZvQnjSYuwIm?=
 =?us-ascii?Q?sLvg7QIMeko9gG77oZCv9MVskIQ575T8uOm9ajVAaZdpeMv1cJIdx4zLfp/d?=
 =?us-ascii?Q?MicI4Wu3ah8U5CLyGFPaJDi3sEaL4cGCrvIFBeX+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c76d7d3-2a85-4cb4-30dd-08da80759b15
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 17:26:23.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qq0d6Mx3WxXDHP9Ic6qWCmxyVDufZQHpe5cS33oP4ag+sDMyoSeDy1qn2eLGw9doAcaJVteWrVKY1Rjkz9J2AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_11,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170065
X-Proofpoint-GUID: 6nSxvZlqdt22b7nWlL0uOvgBqVzqrt0M
X-Proofpoint-ORIG-GUID: 6nSxvZlqdt22b7nWlL0uOvgBqVzqrt0M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/22 22:43, Andrew Morton wrote:
> On Wed, 17 Aug 2022 03:31:37 +0000 "Wang, Haiyue" <haiyue.wang@intel.com> wrote:
> 
> > > >  		}
> > > 
> > > I would be better to fix this for real at those three client code sites?
> > 
> > Then 5.19 will break for a while to wait for the final BIG patch ?
> 
> If that's the proposal then your [1/2] should have had a cc:stable and
> changelog words describing the plan for 6.0.
> 
> But before we do that I'd like to see at least a prototype of the final
> fixes to s390 and hugetlb, so we can assess those as preferable for
> backporting.  I don't think they'll be terribly intrusive or risky?

I will start on adding follow_huge_pgd() support.  Although, I may need
some help with verification from the powerpc folks, as that is the only
architecture which supports hugetlb pages at that level.

mpe any suggestions?

When Naoya recently modified follow_huge_pud, it ended up looking very
much like follow_huge_pmd (as it should).  I expect follow_huge_pgd
will be similar.  In the end we may want to factor out the common code.
However, for a backport it would be better to just modify follow_huge_pgd
and do the cleanup/condensing common code later.
-- 
Mike Kravetz
