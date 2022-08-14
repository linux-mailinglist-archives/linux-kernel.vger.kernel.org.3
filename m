Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11B859263F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiHNTym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 15:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHNTyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 15:54:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25DA2AD8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 12:54:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27EF4oEA011333;
        Sun, 14 Aug 2022 19:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=xeya5/x+Z10Ozwztf8nL3qkoaLyRvyZcn39ef3RS3zw=;
 b=vSXjEE84sHhji68dYm4RbogX2DCUWOR6vMwty051DWKbYqB5fOMPh7idTkkxMJk2e3ag
 QxAYderYQ9oMcb+SzIE+x9PVX6p/hUCUvclf1lW392t47zAGcK9JNc/+nSXs+afKDyMl
 991J6FHoTBIZYCtmXMvi/kkSa6sBGPG/nAiqdSbnAvO+O76ABbdVEoQAMG0F9tgFQcct
 S0pBqjcLSrwqplpuEcZYwVoTB/JSjTeYPKWV5YwZiCvic+wNaor9JZAy46YkrwjgFkqN
 NsAdwzVlIgia8B4V+X+w905n1MjvtpP0+abJElPRgmBu+1+4AndaPo41Ie/CxxS7ikZV Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2j0hrru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Aug 2022 19:54:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27EHrjdM032436;
        Sun, 14 Aug 2022 19:54:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d7ddbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Aug 2022 19:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgbLCmBiYyztlbXLDxzD7+W35Itnr2BhyM0wXDLShGqxivxOoQ6EcBSFe0zRll2703WzECMsuHnReZJSdYkJXcm1h28hqh2rpVFgLd2iUEPlXFBeWDW7BxmosrOhD8ZShRhwbYADXwEaT03kTEfj854OU3XhAPuyXz9C0j6xOl28c5yETcn8V0qOROaIV1XWdAHgS+OQkuTsO/yGokKb7fFbcQTO9/E8k2BoPxkY8vhYT6F45u2FvYSkqfJ81hHRjud4WCMjdBOtozCR2tna+FHiajvDuhDeWZZpbmeRqDTwgRsttIgZWhUWH9KceWZtnOVZA5kOuUFsJxCoqaTu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeya5/x+Z10Ozwztf8nL3qkoaLyRvyZcn39ef3RS3zw=;
 b=Oc4oBPjoJUQtZ4jPOtWZ/6eR0xzrMSj2WNDK05DmZ2eZQe7UxKCySNpRYHLsAFJpghPCdCGe6Oel6O4+8pk4tDoZTgLuNXlXZDWoUQYlXQvvlB0uKdW9NkwNbOQFPE6Dba4OWmgcDiZozF9e129CNgVd0Ljgl6r8w8O3oG40MjR+ejCrI8Aiow/i+YkZiKuBWGMQsjYoHhBBJxedFaJKaHGN7/whad5XeRm4saa4wKpSYEP7JEkJYoZGnwAgQsacI/dWKKDgbgHl7dapulcFdC3us7Z3usX8h5/tJUp9Qed5Y2ca9PDIJEvx5vzBAWk8eS7Yp+4a+y9v+57BrdUzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeya5/x+Z10Ozwztf8nL3qkoaLyRvyZcn39ef3RS3zw=;
 b=nFbSvFVCQlEQDpKLcadbODnPyH7Mx4ioXlfDfCc5iyQUFb5aH5CEcyNLW0sqEZDUzPb1+UPV+wo21fv7y8X5RDIspOmm7N4RmwLbLztuOON9aCN7xxoT8ruNA3I8gAFNa6UCb1J6F5FXTSxi8CHQBH09Axdjk1Cl91+b/bmaxjA=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MW4PR10MB5776.namprd10.prod.outlook.com (2603:10b6:303:180::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Sun, 14 Aug
 2022 19:54:08 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Sun, 14 Aug 2022
 19:54:08 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     vbabka@suse.cz, glider@google.com, dvyukov@google.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: [PATCH v3] kfence: add sysfs interface to disable kfence for selected slabs.
Date:   Mon, 15 Aug 2022 05:53:53 +1000
Message-Id: <20220814195353.2540848-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0197.ausprd01.prod.outlook.com
 (2603:10c6:10:16::17) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 313b98ef-b83c-4776-df16-08da7e2ec03c
X-MS-TrafficTypeDiagnostic: MW4PR10MB5776:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5vu+gsXuf3KzkooXVOt6VpDSw75TVP0boDFkaDU8YDqM/C40zlX4bUraNh12EHl87KIR92o+7mcyDIBwWEpzADu+Vikwg+qtq2ZFkBBq2cKxBbHWvVoXdPhRVpBt8u5VMmvyUp+OezF1/r7xfCgh1tKL5w7MOsShQyPbWf0H3qqQZkP76S8hEIPItpSWQSIFjOFw/pSTmp8VkIYn4YNR5acLk9MUiNSDJ2t+Hm+d0LSkNmEb8qOkaqnBQ0B6RqQu/0npf9ymA56gN2PEgegXvG4ot/duSM/Pc7y2qutdArRUiOAiZDv5CY4j0e0VD7ZPFnbRTfwfb6FHnlg2lkjoqLVWWdIsgPoYtlLb0NaM/MtgPzVFexrD6r0h3+5ou+HmxOQA9Cy4ZaFcNYuuW/unxfXJ8K3g4Ai+itnR8JHaEebGtc33zkthwavYulucvfY0b8vEV53wviYKLPOysS0s4isxw4Ue0qn2Nfn5uq1Y9xAWdGz3/S1YWcW6INOrvSbgBiGSQB+AENJoikxiD55U4wMWwlVyXh02c+nDgv+DJbczfeBtQEyO9XWMv3WdUpcMB6+i640IUi3GqThcTbxK3zYJF7Zdf4XSkadUhZWQ+jxVNwQhyv+5C151j8fhzICK5TayOJ6l6Vdc34Ju6076R7FiETEcZT0S0QsRyWIeHEQEQjllfhbQZPv80Bs+3lRa0PbOXfdGMcFalhIbQ443bhfDxzxqlVqj2FViQGf67Bf5ttbWXtkehZPO+txlRJIp/S42F/awOrErbemQnsXHuH2+umFwYMBs2R1yPsy6DhNeXI+lYqyVEg2Ff2Q++HQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(39860400002)(396003)(8936002)(5660300002)(36756003)(921005)(7416002)(478600001)(86362001)(2906002)(2616005)(186003)(1076003)(41300700001)(38100700002)(83380400001)(4326008)(66946007)(66556008)(66476007)(8676002)(38350700002)(103116003)(52116002)(6506007)(6512007)(26005)(6666004)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PsdWyoU6G39ncDI55mnE4AXjvVosHaqdeoIZz8U/pAp/XBPYSmxdcMiHCiCO?=
 =?us-ascii?Q?B963/nz1o2J4PhK2w9vOFutyu/CAa+ky3YyS7JADdtdPBFWohj8DvWFxcx/s?=
 =?us-ascii?Q?Kb1E5YCRzDV2myLU7C36zU0CKzwqrpSP/X1A7Ihe32FmEhZuPGCn271DW7IZ?=
 =?us-ascii?Q?t8NitM0eQ9BPjrcv9VNgXt9YPbVd9WG5bHuarBgozOlzfvpVtZjayHZVEpMT?=
 =?us-ascii?Q?xhXjRaWbCILYMoKs4c6UETaCYGbe1zscDf8gG4OenmPygZMIg/StjU33YSod?=
 =?us-ascii?Q?FEkfeSRQk21HDhsDzqevnCwyjuf8mqkXNnOAOoMBAvMSKfW+Q1X1QSlnhRif?=
 =?us-ascii?Q?YHyS3Age0JxhrW/08R8jmss7hLnK5FbD1Z5jcUhQd7H3ZesxYlLyi6rheqOq?=
 =?us-ascii?Q?KxZWJNLjDOja0K2OKKH34Y1RWvt7YJ5QnAbomrNHAFjAYcZuZv8+2hjVFagz?=
 =?us-ascii?Q?PtYW2pcKGRQaD5Esgh40XcRbuW6kzHobEvQ32oOoJQ81hA5H+Z6pUQH6zrzx?=
 =?us-ascii?Q?nuHY+puEMYLUm6mtk50+0Zr52T1kyDxhZQkFFAEHF8BLL40lf9/AOQl2h/jP?=
 =?us-ascii?Q?irGZlJgANrudTiLt6pvHn7nqgET6Zr7LTfEIZD78vzUnQUtGtqNTgLXTYYfm?=
 =?us-ascii?Q?XmNi7SNn8Mrkf3yarH6yTHNNIE3Xa4+82EF8Z8lKjTPof/2WDCBTqHaMHKhz?=
 =?us-ascii?Q?ARq1yOZGPtkIT0ldRmY6PedH3sWewuY8h00lUgzL+H9eNVoljfYkjc3+hSEq?=
 =?us-ascii?Q?YCZd6umZuRkILzggMuFUupdObOCqZvnm6oWIXXHBGJErmCUF+gOB3GZycTWs?=
 =?us-ascii?Q?dLRq5g3AbuVWjwdZO768Qwrl2zVvSDbXFkqEVIfnc7ItHi8ERVVZI7by26jN?=
 =?us-ascii?Q?sL0ragAvMWFvtl+g8WptkPX32qciaTJ1DPAEyyPMmWPSDWWi3WupyJHp4fTM?=
 =?us-ascii?Q?8HuudxDdEgeek95IrHihtcHjdQ0Asrsi4WXYRpKHHPxmtISz3ihOZbdcSRJM?=
 =?us-ascii?Q?+fePGuLPcWnqRT6XwVqafOix3hHJa9V16J44aYLRciiFsBBiXlmoAXxl7Jky?=
 =?us-ascii?Q?lLh77J2NzYrNPWB3L7v02BhkR9l37aYgeZzRZs/Gx+Ythu4xeNgn7Rlcw5Rq?=
 =?us-ascii?Q?6lbN5/TOkzfzixDxUdkAg7U2rCBHfUY7mbg7sReXsKcbgHstKpHNwr9ejNCp?=
 =?us-ascii?Q?iodVuj9Ry2IT6dUQaz6pJCr85XycmN8iitTQPE4nD2HBh+1CpqAg4uk93Zpj?=
 =?us-ascii?Q?KUVtQBJIxKOrMDgEe4YBwHRvgKBC9/s9rqF5nBqofwd+bE8eUru5vyH6TeUb?=
 =?us-ascii?Q?H/o4xlrEGQ4xrwLqPMczXOZd8I1Gedk/NKR46Z5Tr3Xdux/uYlyJfzx3h0K7?=
 =?us-ascii?Q?39+yC3t1LRUXH+p9wCvBHLCv68NLQPsiK/7JXGeOgX/mcmsNgu6F1gBO64kL?=
 =?us-ascii?Q?4caGP3mVK9Xhe83rVDvmk1BqmeeEVoiofmDpbLmMDaKvjtO5k1LG/fpzEr46?=
 =?us-ascii?Q?SxAIJbgwtX53Y1vEvyAW4lPtLxYljmCw9xIHaSB0TJUGPkcErag+hWY9emA0?=
 =?us-ascii?Q?yCmCNNLpm+iNf/hAFEqvAxM/06neydqD7C4kQ6WsbVOVG76lKSEl0gZQnnQs?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LAOH1QoGID7Q62Oxq3FddfXGUqk83Vrbdi4BTG+5oISrIyyZfAQbMVeT+DpZ?=
 =?us-ascii?Q?SZh96i44zTRK7Ma9B4i2+gSVKYEim0kebsgfe0BSueUx9n8UQyz+DbSa6JSB?=
 =?us-ascii?Q?d93I04wHbF7oWQvsZ2yL0ZmnW4zne7d5Sap/cZon/be6OkJlDWyI2lzWWH8B?=
 =?us-ascii?Q?S5OF3LxUt6VxELCLLakDHREOk/L1Ldgf5p2s17GSAXhOlaeUp2HpomRpP6Sb?=
 =?us-ascii?Q?KDdbJhtZ8ZHkoZgAznoX5Rr8pL5evAmcTh5qVM0lGuudfwBDZSJRqLC9vL5W?=
 =?us-ascii?Q?vRDW40PHhAamQcxyEKlIkXMwkB1BdswaQw40uTlAVKKZEYITe36INv2Hf8fj?=
 =?us-ascii?Q?SBSdTMJFUA+xGVezs2ySAseNSmGO0TPv8v6mSlrh+7NfOZjxOhPKESJKyLui?=
 =?us-ascii?Q?7LhUEJ787I5cL7XI8dVILqOygMe2qdzUZ53SbCEfZhUYeuC57ignqHpK9fHW?=
 =?us-ascii?Q?lR7+k/pUHg5iJHwsT9gvR92HucrT4ep6Ih3wZneCy6LV9Z+Ei0JQ1oJ/O/vl?=
 =?us-ascii?Q?Duaj/h3iElmzDKOBY2xLvJ8WNIelUEo0GEijJP8ccFAF4GHDziKDy0ETKJPq?=
 =?us-ascii?Q?R0VowOvUJgz5KA1luApFFjujATq6ZrhSuJwTjYmv9pXnjhmZmLkJqfgC/ioH?=
 =?us-ascii?Q?XNlWjX45hmehj7VTNPCFvSzVOs1+Vu0T3J2WvzRqsQHKGbJzdR1eojKrk4bq?=
 =?us-ascii?Q?FjzL2Gp9myVvK9HdT7jC+G7rvtVNslyL7o5GoUtFnjull8/4hO6Dso0pTHT9?=
 =?us-ascii?Q?ZmI5X9rkUEzme8VI2f3zxZtw+1wAjrrmP/x6MewVXiEVwDkFUjb3ouo5Nodd?=
 =?us-ascii?Q?pVtk+7e5s5EiLoutYpiI7UE19V9BPrujENQqwi9ccuPBWhmWbfZTIype9TxB?=
 =?us-ascii?Q?EdoWhc0zMvIe1oKmpaW+OCCtYPlKILQkqS3Wu5rwu2+WkUyxJZr16NJfM8hK?=
 =?us-ascii?Q?Gb9NLKXXmpAazWPfOXdYJT6Namso3aeOrRboEdchxuiRDQuE10J/6XBufHSN?=
 =?us-ascii?Q?s78Z2tDoGiPSoVbQWd1gnFgZFt7GJ9IKxhyxXiHM1dze6F3lgI8YRGzHhUi4?=
 =?us-ascii?Q?lgP7BZJJLTtccp5Z92NhL0+AeIO8WJFtyQsFr0Tw2VoCZgbzDbvSSB9VN/ej?=
 =?us-ascii?Q?x/uJEJHFL1kCuvk2MDMUsJuI0ZUGkb7GQ+tFm95nBId7bIV9IPjGlNXK7XBz?=
 =?us-ascii?Q?6WYscYmJJDG0qGsys3cJPGL8eBHhUAlZ+ZFhQ9TjligDvRlYfHFAWe1K0qcp?=
 =?us-ascii?Q?TNrABfPPlQqIWYzbps52xa13kIAeswE/S6FNO1rvvd0lcpL48bQxjkQi28M9?=
 =?us-ascii?Q?yVtO0WDtlWJo8c0hMj0MWFiPHZRCeyu87b2pPpwxVCjJ9GnxloBnLQVStQFh?=
 =?us-ascii?Q?m/p74oU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313b98ef-b83c-4776-df16-08da7e2ec03c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 19:54:08.6407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5FrUsjP9xvvL1PPgBQIF4JJbWglHffsVMwV99VMTIgj2LKmLuhHdENnTfLJH5N+A5PICkcTGfeayaL7sLFQeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-14_11,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208140087
X-Proofpoint-ORIG-GUID: CHPEKjzzD89qmaZ-dBHTaHf-NIaRyRSL
X-Proofpoint-GUID: CHPEKjzzD89qmaZ-dBHTaHf-NIaRyRSL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default kfence allocation can happen for any slab object, whose size
is up to PAGE_SIZE, as long as that allocation is the first allocation
after expiration of kfence sample interval. But in certain debugging
scenarios we may be interested in debugging corruptions involving
some specific slub objects like dentry or ext4_* etc. In such cases
limiting kfence for allocations involving only specific slub objects
will increase the probablity of catching the issue since kfence pool
will not be consumed by other slab objects.

This patch introduces a sysfs interface '/sys/kernel/slab/<name>/skip_kfence'
to disable kfence for specific slabs. Having the interface work in this
way does not impact current/default behavior of kfence and allows us to
use kfence for specific slabs (when needed) as well. The decision to
skip/use kfence is taken depending on whether kmem_cache.flags has
(newly introduced) SLAB_SKIP_KFENCE flag set or not.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---

Changes since v2:
 - Change patch title from "Introduce sysfs interface to disable kfence for
    selected slabs" to "kfence: add sysfs interface to disable kfence for
    selected slabs" (Suggested by Marco)
 - Addressed formatting suggestions from Vlastimil and Marco
 - Added "Reviewed by" tags from Marco, Vlastimil and Hyeonggon 

Changes since v1:
 - Remove RFC tag

 include/linux/slab.h |  6 ++++++
 mm/kfence/core.c     |  7 +++++++
 mm/slub.c            | 26 ++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0fefdf528e0d..352e3f082acc 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -119,6 +119,12 @@
  */
 #define SLAB_NO_USER_FLAGS	((slab_flags_t __force)0x10000000U)
 
+#ifdef CONFIG_KFENCE
+#define SLAB_SKIP_KFENCE	((slab_flags_t __force)0x20000000U)
+#else
+#define SLAB_SKIP_KFENCE	0
+#endif
+
 /* The following flags affect the page allocator grouping pages by mobility */
 /* Objects are reclaimable */
 #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c252081b11df..8c08ae2101d7 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -1003,6 +1003,13 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 		return NULL;
 	}
 
+	/*
+	 * Skip allocations for this slab, if KFENCE has been disabled for
+	 * this slab.
+	 */
+	if (s->flags & SLAB_SKIP_KFENCE)
+		return NULL;
+
 	if (atomic_inc_return(&kfence_allocation_gate) > 1)
 		return NULL;
 #ifdef CONFIG_KFENCE_STATIC_KEYS
diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..6953c3367bc2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5745,6 +5745,29 @@ STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
 STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
 #endif	/* CONFIG_SLUB_STATS */
 
+#ifdef CONFIG_KFENCE
+static ssize_t skip_kfence_show(struct kmem_cache *s, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_SKIP_KFENCE));
+}
+
+static ssize_t skip_kfence_store(struct kmem_cache *s,
+			const char *buf, size_t length)
+{
+	int ret = length;
+
+	if (buf[0] == '0')
+		s->flags &= ~SLAB_SKIP_KFENCE;
+	else if (buf[0] == '1')
+		s->flags |= SLAB_SKIP_KFENCE;
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+SLAB_ATTR(skip_kfence);
+#endif
+
 static struct attribute *slab_attrs[] = {
 	&slab_size_attr.attr,
 	&object_size_attr.attr,
@@ -5812,6 +5835,9 @@ static struct attribute *slab_attrs[] = {
 	&failslab_attr.attr,
 #endif
 	&usersize_attr.attr,
+#ifdef CONFIG_KFENCE
+	&skip_kfence_attr.attr,
+#endif
 
 	NULL
 };

base-commit: 7bb4fa8a025a1bd305a146022083f0287653ea12
-- 
2.30.2

