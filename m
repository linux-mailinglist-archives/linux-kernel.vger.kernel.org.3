Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016234F726C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiDGDEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDGDEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:04:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D221B4EDFE;
        Wed,  6 Apr 2022 20:02:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236LH0MC004957;
        Thu, 7 Apr 2022 03:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WhsEfYGTOMtcIuzSBgbS9U41MVFZI0pzwnl86vsfrnA=;
 b=WgvZ5A4KjFlSnccU2stlzizpelznEl8gb/ne+L9bw0GfurSYzeYczIbBSf4UibI9ra2a
 O8rpAb7kJZZA523ymwlyIa5QqDYs95+y1WzIJi1nTBbkWLmmMOKi18iXVe+PuroH7/zk
 vNTR5w6j5iYaP5U4NnVl10XObqb9RWDx/FSGW9sn0e8EUu0zeMoiMlivUz+YWTgpTLFf
 k1nLQbjTaj+7ESXFnNASnfO6VNCGyMlxYUFGfHluQq2LaM58C7nWENLM6C2vKcee2bta
 6yfL5LLlXwgYIxPAKkpWsNINVDyyRuylrM6N6MOvTVJrPDinoczxY7/k8mgHIVayibPD uA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d932m2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:02:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23730Wwu013143;
        Thu, 7 Apr 2022 03:02:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803h067-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRKd6PoIyEAx1zslyVg+YEMi0n3DisauQQvA7d3/TstZWK/ylqqw2sv4JvC7oCWDvm3KKfNW8Bvgcg5/nQL6sDJZp7bHwkFe8FUjUGwZg+FdQ3Jm4JqmkIS3u5lhpG8hxilO+QhY09shqcX9VQy5G9TLHm4MiYZ0esVauVaUtJ3Sr+4RwiHGC03+WVmZfnHzNctp0S0GRkxDuIbRTk/nAwPcBiLteIroZJMA1B3DV1EeQUFbfD0ZbxyMGs/TBQ56Sc4B5hZ9ytGIJo7PwbNz+bAkq4oLQ0vYXd3qcH3P6ogTG/HdVtv3GskISXluqrocezE0LvvpMs0Jq5xAsfg1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhsEfYGTOMtcIuzSBgbS9U41MVFZI0pzwnl86vsfrnA=;
 b=BLdxa9RQS/LQVlTJZfSuc+mqR5irDAdm6KKr+LpCek8Tzs5ctASwUTxKXMC4CxdQs2XxyWzViI4sMXLjmd6FFqzctlrICphr5/qdYmYBZEaKP3bz8c2DirX0p8GIHROzRGjmfxlqqt9WjeWeuBdlRNGvpT6gRbUFpm+kHfLbum+F3vXajKybstXBeAhJKYcTsGjQ1GnJkCFMlKT644upJZOP39LFyCI8kGJwzDo93UtBs/JbxpJ0I9WtqInUSbgAqwkKxh/vZwvkkqp+BRSQEtvu2xE9cx//tziGOv+HOPXpxrWJAF3nCeWR6QDUedwiC9rQPz2Bdk8EcP3Q6J/4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhsEfYGTOMtcIuzSBgbS9U41MVFZI0pzwnl86vsfrnA=;
 b=rQhO9y1RLRAQ7EvLuLxSi86ZpGbf22hFkF1piP0K/hpte4pNtWgJGOS9O+cN/RHM8bbvfyalLRRV2FF4LCmX2l4rpJla775VG2nlqKcZZ2dWeCqXDKGcGgK5kMoG1SAu46AqeS3Wr9dyG2pdgvqt2Ii0hUiD8PO1d1rjBwwz4Vo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5148.namprd10.prod.outlook.com (2603:10b6:610:de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 03:02:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:02:26 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vishal Bhakta <vbhakta@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: vmw_pvscsi: No need to clear memory after a
 dma_alloc_coherent() call
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135iplhon.fsf@ca-mkp.ca.oracle.com>
References: <cd1220c628c89465dcfcbf4aa9bd53110898a529.1648067518.git.christophe.jaillet@wanadoo.fr>
Date:   Wed, 06 Apr 2022 23:02:24 -0400
In-Reply-To: <cd1220c628c89465dcfcbf4aa9bd53110898a529.1648067518.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Wed, 23 Mar 2022 21:32:22 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0050.namprd05.prod.outlook.com
 (2603:10b6:803:41::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 789e752c-8d4f-49a4-78ab-08da18430b84
X-MS-TrafficTypeDiagnostic: CH0PR10MB5148:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5148296BF226E66BAC6F69658EE69@CH0PR10MB5148.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: In2WaigrqTfyZ22gPtoy1jFMKiAMthELIMgMfYPObhNCUNMvPjhGqiYuG2tXlaLG8BBvmog8uhqExa2ZxK79IwBa4LnyN5tM765RrkLi8LeWSBqa0a8NSif32U1s1YTWgRmHbhDQg7aIrtXhrSs9LKZ13GqGkhOxjqSz0V//43vJkrIxjQK3QqLyYMhsHDvmOVHJu1Y/xdaTFe0qd4Xtig3/8/V+9VIEFGH2KSYqhmAwX8unctcdZjxIrfKI5DaCBUN+La5JBcfff+1J3zQLmidhyNKRMCVYe6x096UUOhIy39GPzgtNGkdrHR42LYlZzrR1LS/vrP9fxK7rsB0SrPnTcP+hzMQV5+EzTBcUf2g8Vas2gyvhg75Cfxl0ufYvhb9jJmdEOu7UOAIy62UId/LZVXFO/JYtyMYh2UA4C2c+JfOgT9P1NFoffYB3tp9hie9n2GBHAoHw9yT4286QJKpY8raCRxvgUKgwRqqKwJMNE8ZF3/uw3/+x26USwOsoQ+Gu6jodi22hYx1RmVqky3WYN+905LzTRvslXiVIKgMBQSHk7ZWKEsgt1fyF5OQG0tj7ZGFRTnXGo3iDeLKLrdoFLEYYIcGJXQJRz38ijYScfe+3O+tz3QOrEtZb0Fi/ygQdvTwKDU8CimYdRShhVneeF/vVkY+1btd2h22vtPx4wMouOl/7JgDHJGqlBTEpIYxRuPOZZGBqP3HrNSmniQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38350700002)(38100700002)(8676002)(4326008)(66476007)(66556008)(558084003)(508600001)(66946007)(26005)(6486002)(186003)(36916002)(2906002)(52116002)(6506007)(316002)(6916009)(5660300002)(6512007)(54906003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dSj8AlWVS03W6lAIAiU6ctYuqx0/KLQA3M9fIvO7fsvnyDN2G1610wlJYEP2?=
 =?us-ascii?Q?S6GCZu8SP2aOUT+wI9RmEoyrrr5wQUekmG44+FR56wZXiZVbImiwCFesKg1m?=
 =?us-ascii?Q?3/eHo0x0fY9/pfEttMQwUjZz0AAgllK1nC1rs3ZJV6d5WGMn4+jFksAPcTBm?=
 =?us-ascii?Q?UNNfr80oOLbglaHQZHigKNRDitSfuQsjvBEtCDRdVyHWvJ0iSSc89gYaY4C9?=
 =?us-ascii?Q?VUADnzWmwx13YxW+AIk2YYOEQyn4faPZeiaAiREi/mdmxAOKtJ7Ht99CPyCr?=
 =?us-ascii?Q?hwPPV2YCIeEPgI1R/o/3HdPaNwSX4ptVjOjYup4bUibRpEnLukXgvxiW4j60?=
 =?us-ascii?Q?qbMY2+wQbvoop1ecaa33Uz/qGJ/a0RklQpVOfBcVdIWqr+wjLx4JoM6sd6lQ?=
 =?us-ascii?Q?e40+MJSuqTeep7gr7hBqKC8W6YyGIiKFP8WAqXSP5hrwRqzStGvJB9NedlYc?=
 =?us-ascii?Q?AuUnaVc7HeokcDYTBeF59+t/5Yp9wtZR4LUCXLnmw4OCTjgILie3xX+PaIeq?=
 =?us-ascii?Q?x3trL1TsSm8ZGBEHCxkr/uHpqP3WpEVyFTTsSlr4qkZTEPA4UplU75jPgbXI?=
 =?us-ascii?Q?X91/5YS0EV9ZHA8VsTV7noVwWOU/qDEq2ueeBaXnPoa3KXEsF67ogSPqOF6E?=
 =?us-ascii?Q?dE62FD5lK4XN2Ojuizi3675K70gaGJgAwkSkvGIPvMvX376HE6tiEroX1GOM?=
 =?us-ascii?Q?TTakt1gvXIX3YBs9hjzM3hZ8igVAXCQXRwJbACqeK+HdOLbKBowQEAzlfzoF?=
 =?us-ascii?Q?OTj5ikz+J2TpFMmNy4cb4DcVzmIwvMkWMaV01ZV6SiKEdWs4CunnFCjPGCdY?=
 =?us-ascii?Q?4vRORO+pYpJ1YrGWlJYQNRpUXhG89q/JTLD7bmMINljB+iEEm3KpBpvAls1a?=
 =?us-ascii?Q?QQ0EaD632SHwOg7kSrowQBUW1Yjraq4FhklgHxdmPSaGA8DyLICFWzwltMF1?=
 =?us-ascii?Q?FnF9TeZQSP6VxORrRQI8TmwQSklJ+LZEv3vjFKvQxA94DYuNolkNdV0W9FnC?=
 =?us-ascii?Q?jS68ldjUj+eZwqdd6x6KFEC4PpNnbDUeM0grcLYjOyZSL8EoJrDvXeSPEFIl?=
 =?us-ascii?Q?KgAuUtQ9lkTuYbGFgK6T7hcQWSkx/J1TEVf7GdkCpwBqs9J5E2xpEAivlfFG?=
 =?us-ascii?Q?26uBXWDwNg0phUF6hJj6unzloVTND+2oTCQvaun7OHvrISvuuZuGHVHDSGlY?=
 =?us-ascii?Q?AOXAArzaP3wSEbjbWd6pjqRN2WmWZNC+tPiLXcWw4c3B3IXRrZAGSe+Iltxf?=
 =?us-ascii?Q?Vt0RLbQc4CHFRRK125zP/M9JzQn8YhzU/P2RDJRjUgodmHKUeYBkRZ9Qb1vj?=
 =?us-ascii?Q?Atl+vJDwi7zyXc4vYGaRo1AaJAj3qdYM1rV72hDk/pZyXsFLU2juKsMFDxUb?=
 =?us-ascii?Q?HvoFhNBeC6DyA0f2STpHDcbZhS/8WQX1of+WaKPR6lmzTnL5PYx5y4XM0J4b?=
 =?us-ascii?Q?J2qkb0PwyOTaZ2f/pfRUWfwXuZAfgnFBu728OIdo3n//dJtGXcl3U86D+fb/?=
 =?us-ascii?Q?c/FNlhxCrYsPtP0Tk4Aj7q0/tirUJxPb8n1S0ln2ZG+0cBB38InKD9hh62gR?=
 =?us-ascii?Q?ykq/p5lCbSbHOcd66kmPdMHF7xnzSHic05RH4BLF0YcbOECHZ6A1UH/I8aGG?=
 =?us-ascii?Q?yjOItlaKlQHSHClR1JzEkb8snMo55PGHvsV/rs3STv90P0XPM/NPm9dZR8Tt?=
 =?us-ascii?Q?VUxxZsfo7xH3B+6tZHzEyB4PApOxVOwi2lnmcGkHO1Hculv7oPYIZsREeXbf?=
 =?us-ascii?Q?rt8C7IrYIAqNaI6lP3PQQLc6adZZKHw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789e752c-8d4f-49a4-78ab-08da18430b84
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:02:26.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKxNB55I8t3aDi6OhK712+71TCjzes44QhJDt8NOJHolj+vai4bjcj23M7cTEko9vRvjK0y9jaYeMsBAx56ylYQ42mSe8IBHT6kxy/z1+j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5148
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=597 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070015
X-Proofpoint-ORIG-GUID: SDtwGOIEJtP13FPGZhLcmJ4_1Fn_c8ZG
X-Proofpoint-GUID: SDtwGOIEJtP13FPGZhLcmJ4_1Fn_c8ZG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> dma_alloc_coherent() already clear the allocated memory, there is no
> need to explicitly call memset().

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
