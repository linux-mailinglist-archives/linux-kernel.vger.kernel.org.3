Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6853A56AD6B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbiGGV0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiGGV0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:26:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8492CCB6;
        Thu,  7 Jul 2022 14:26:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KCF4N013678;
        Thu, 7 Jul 2022 21:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=y/nTJdpTweQNfkUdUUTw3Wg1yd+vdYAu/eDGvUs4Ewk=;
 b=ZkB7N59/38oAYl0d3SLHcZYNHAj96ji1F1CB718DNb3VFe0SIio4zZPfk8eUP0NmDEk6
 449XpVqsq8b8gJWBixclpPPx5JfFHy0FP8+Zs4y6jEvxE3+DJDe+loYKoi9aeuwkUpxH
 ZFpTpJJ1FQKkGtKxo42ivwSUOPu/903MLPrO0BsqzoSV9PVgOaTpGljE4mc5r+2VFVjZ
 iaPiy359o146mgV6L6P3c0+83wW0sm/ItdL8DLtlMoqadWRx2je1ivSYc8Exsik9FG4x
 Ik1mOnDFD8lX6umFokg+8DP+SnsRX0hYusiFRt79twFSysGAlaCSaapJHPI26nnzWXiP pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyege6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:26:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267LB4vF014554;
        Thu, 7 Jul 2022 21:26:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud2247q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOoRy23xLfImPSGwBGEStfsPG1eiMgjiV+jdIy8uKgpoTgj2uZUCN4LV2BKBI3x+jcgXmbTBPpNLjNTQtQN0G3p5kBpw6SSLYLNvhZnUctlY1atxM+0yTjJRL/rnZM7oRpswwOPq08Bt3usCgJApQ6VGMZjgdYt4WM2iw5nQ4A/u+K1GlDaUkx9skMHFXgriUApb+CNDybeI2luCLfH8d9SeA5S8kcJLPQsLwbKpnNYh8wlUaNLO4EVvZ87Q0GEFgSXxQWfq7PbtC++U6RmiMQKKkAuH7Ptl7kOauKvBIstxma9U+gFmjrbOzlowQut4CrJ8JciI5+ifT90W5Z1iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/nTJdpTweQNfkUdUUTw3Wg1yd+vdYAu/eDGvUs4Ewk=;
 b=dNsK9sK8bpgn6XjD4Ny9hnDQtJw8N6MLYndbIiNh5Iz33KHIxAmuIYzwvpWAY6jNGYzhXADPkariqCOUWI//PFpLrO6iredBx3BNUlOIYRDx1K+fsVCZgjyTy3g0p61CtC9+Z2oeN+W6+/d0XRBYaB5m+HYeJsTY1iQG/Ec8S4Jl5DtHsLysJOHfMETeWfQuMl6rB2X/I05pDUH1HbhpVomGOEgMxCuDHJVC7ejFgNLBql+yRGvKf7eBwZuk5DtrR/EfxyZLk4m7xQxewMADK3mZiwqBTQEyjVRn/By1x4Ms/xbREI5ska+7rrp5LhmMf3Leg/AEMC/DP8ApQWlOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/nTJdpTweQNfkUdUUTw3Wg1yd+vdYAu/eDGvUs4Ewk=;
 b=DAhM/wWr4A+QcnKCxcYy7PFlcnhA91c6baR4oH8IAJKAxycHJ1dfAh+y5FBxIyeUlwHlxdsWl0nhdwDiciHn0VKfPlr+QOYn6oIf2iZkF+I19qhD6/V9SUCv/8ElN5qIJI47i11ezF4z1wMgweDpRNv84rCrHtP/d2E++MokjOo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY5PR10MB6238.namprd10.prod.outlook.com (2603:10b6:930:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 21:26:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 21:26:20 +0000
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: ufs-pci: Enable WriteBooster capability
 on ADL
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilo862ds.fsf@ca-mkp.ca.oracle.com>
References: <20220705165316.v2.1.Ib5ebec952d9a59f5c69c89b694777f517d22466d@changeid>
Date:   Thu, 07 Jul 2022 17:26:14 -0400
In-Reply-To: <20220705165316.v2.1.Ib5ebec952d9a59f5c69c89b694777f517d22466d@changeid>
        (Daniil Lunev's message of "Tue, 5 Jul 2022 16:53:26 +1000")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0003.namprd07.prod.outlook.com
 (2603:10b6:803:28::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d27e60f-b7fe-4fa7-c4bb-08da605f55ed
X-MS-TrafficTypeDiagnostic: CY5PR10MB6238:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kphn+9Fx7HvuK6rfBgMO7ekmuo+UT9KRhWkL/g2XioPRkePKIVXYYzKTNmRpWTuVidjsEhgfiAJh2lPfSfh6xg2lm8F17O8T/5nAeo8kLGdzfAsktcw3zzrP9L/faLD8x/Mx7kc+lr3vPj4irSHQY+NxfUjoszum9tjJSoD1qFLc3gj/PWtZk5n93NyjFaRSillhuNPEw5NVFg0n0a4qd+7pWYwRooYijtNHAp3Ujh6JFdU+K1EjxP5XymA9cAvFfMYMsdmw8yqmsw/ax5JP5EK+TIcvXxARQ4b3cg+LW5XUhFJoJ0aFkJ2sADoRjYNDj1HdIzPA0g0SJ/U71H+rFhr0e5la7GcuasuNfpXml/miLg5BDTel11tqv8pLz/ZXa2R9th+dgR9kvJ64KHPXICsCRfAM0Bc5/xbnYo76ys1EGmkXJ4MKVvc+sXcq44aZPpafL5ZWCs9/994v52IkTJ7D4B5yvCNGtT4ZrrFXgTLX5Dbw8tcUAngcSfuQ2rGQZaTyBopA7FjmSyguATU/31vQRnbaxlO9GeS0UJe28UdSK2b56e1o6orcMrzp0Ia65iqevfhX7KWJv55TfW2UB02e0/AeanUTPTfzRYO4n1kIM8yBRA9W3OGb2wR0926fryZGfbj/5lOhwrzOdb2fvoHn2FAABd/AsB7Oezja3Hhez6fap4PRrUiYiSioxHS93y8+joY75G0vea5fcWFqSx/QG1xh+V5ajWlioTWkrqwEHhzL6LIxXWwrmK8i9WTlLC23RSDKpg56lr2UsH+EdOtnDtaxbbVKAu7A6RseDmz0dJv5Uoxx8k/2c0FZuzb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(346002)(136003)(366004)(316002)(6486002)(86362001)(6512007)(478600001)(6666004)(558084003)(54906003)(66556008)(66476007)(36916002)(66946007)(6506007)(4326008)(26005)(52116002)(6916009)(41300700001)(8676002)(186003)(38350700002)(8936002)(2906002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ESGLUIc9zkinBmHhwMVKc6ini84Jg3Aot/n8VMnpyJ7bcCVOylCJ/x/j7p1W?=
 =?us-ascii?Q?29M6wYUGmwFNNZJ0z3sBtzJrvvDpuTMXhHs0T/gzlVMLb6jE69g/F3WEjL+2?=
 =?us-ascii?Q?QtYIhpHv39ZO9P+wkSWuWW6U67viX4DxhyKlP4DiHJwq6+SRjmMQ+LoBapbp?=
 =?us-ascii?Q?rgc6M7zZI/GCjk/n0+zH53d6QtlnbjOBcyEzziPIFnLjutQSZe2NxIzqmUrL?=
 =?us-ascii?Q?ilC89m0safDUOU9YPsEYjOpujUw08om+dZCYgUCpf2e+r3MAsfZJfmp1t9eK?=
 =?us-ascii?Q?xcCFTVbYhYBo1vdsi106uA977bBgfVmG6n9VBZBgZX6uI3aM85iz/E+bnbQz?=
 =?us-ascii?Q?WNkUazbCpgMXoK5D2fSanU9VpDpsnwszFr7t8Tes6iY55sQLnEYsBS8F/xfo?=
 =?us-ascii?Q?wWj9ooNw9vq/+LPwjrjT4Xr3wfTDdC4itWQGv+QYAcvnZxqBOWqy6cpRLo4j?=
 =?us-ascii?Q?wYpMobNJuN6gOQtY8C3TCtL7mlE/1MYm5MAOpRwQkhU17b+/d6ys0I8Tf1ar?=
 =?us-ascii?Q?8rs7LjCrDTjMq79l6GKT/L+9kk+OTxxDzPGQs3SW6XnMryazDOIH3Pd0G7Uw?=
 =?us-ascii?Q?rLR5L8b7UDPrKkAa/aI8gth2Yaq2gblPIpbOq5zQ5oFA9R7rUN3pPg8enInL?=
 =?us-ascii?Q?uNmz827qSFu68wfRVZOq2Yd2+KpmyfTJ8UsT1V0Jd+Ko3PFPA1MqKDNPbMgS?=
 =?us-ascii?Q?sZ5ruAyjsqSiSve1C9/x5KOcrsRIeq+tAfG+90m8L4gF6sNkw/CNX//oDYKn?=
 =?us-ascii?Q?U4OoW49F3oaBIwBk4UCc4It/lqaLokuXOfzk/kAvbG3rUliJEAGrSy8niESm?=
 =?us-ascii?Q?0w8uSdJ/zZDydR1630vU3qq65yaBmHRH7MrFjLq2Y9uD2fIb+f7kB1MdPD1K?=
 =?us-ascii?Q?hxrSMQ33GDpc/7yM0rHHabZXmYC+EGr4D7ANZQLvx1sUKLB/PTIH2IJ5RaAZ?=
 =?us-ascii?Q?34/y5w5hD5oaQ6c87jAk/xn80zdMJptLbfagNfox7u3e5BpWZekxj+HVQBu4?=
 =?us-ascii?Q?x61iBBIthWUuKr1shE5DnVDF/ChZmNaT3jopZNVcRx8/sx4znLUY5/SMDWwP?=
 =?us-ascii?Q?Z/KYqvNrw7Ck+fOZnHMHaEltIpI94mOCvJeNlh9It7cgnZrkxEOxK2/yxw5O?=
 =?us-ascii?Q?vN5zWsae6MXd3XIpmDIslRCg2yHG0LfIXsRF+BVEHc1/VM2R5MdrHqr1KwUm?=
 =?us-ascii?Q?MlllFxOQCV/L+Cm3Yr6f9Vczeb3N7lRztQoN4wsb2uU8gGBTOvaA9y5Qfkjo?=
 =?us-ascii?Q?l9z6HEY6ULEHC3M52g7tQqtNfgkpzSMhYJjeZC+ObbNtMEAQ/CEZaCjLrHl2?=
 =?us-ascii?Q?yqx3+NL5QTDG7o0zLmH0E1kH/YPnPrJBAYPKG5mt/GE4ys9NGmXdQJ9YUBvc?=
 =?us-ascii?Q?H5npPNe4vzI3tsOinlEQZqUMdiw5oOtIX2AjGX9hV7cHLQtpUl+tJscNh0C9?=
 =?us-ascii?Q?oHGGChjWm0iIRpi/8X+hWUxy9j7RM3cdhYM6h4rXvwpF5a2K8pET5kaVJEK1?=
 =?us-ascii?Q?0IouTxlgX8Vx8dx1bIW/Ixv6TRpi+mRhfAsBbiZUSRngi/07Or6HUUhAj6BV?=
 =?us-ascii?Q?eEX/C9zdX62f9opMKz6i/iMkd2wtpAohX2nxAxKkOVo72zTYoTzyp1QtzJiF?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d27e60f-b7fe-4fa7-c4bb-08da605f55ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 21:26:20.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwHF3aL5rzF0SpPxLur7oAEQRvuWfmQCWWtfGh7xHAMcvRVrF7lCHOoLqZP/TcIuS0lj7qHmV849p1C0siPjJyyFjD+ketno8J83pnHVjGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_17:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=618 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070084
X-Proofpoint-ORIG-GUID: oMdto1wVg6KrLPaZ4DX3xcwuCVLb7K6D
X-Proofpoint-GUID: oMdto1wVg6KrLPaZ4DX3xcwuCVLb7K6D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Daniil,

> Sets the WriteBooster capability flag when ADL's UFS controller is
> used.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
