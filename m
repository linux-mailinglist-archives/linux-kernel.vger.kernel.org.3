Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33920539A54
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 02:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346654AbiFAAUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 20:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiFAAUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 20:20:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D0E522F1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 17:20:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251009Hh002575;
        Wed, 1 Jun 2022 00:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VHb9qvMS5kOfpAkCR2PQrrVfWCQDTRI0r6NQLQ+CtQc=;
 b=X/ynN0TsvCp64A7My7dw5nCesH77U7cISQjOC3WTJsRBzkl5Hw7pOraU3WKVP6Il4RRz
 Cb1vQouMT3rSc+riKUT+D+6WDyvKwosrSuxnsYHZt522lLJDVRU4Fv/YJ1KcMBXdlHw2
 4/xPs7W3NH6TnE2zGB6/81nhTIp3vx8CX+kGoQrMxUmm1OxwWh7fHqyJpLImWcrPEglb
 52QMok/es1b8s3YCT3qYMvV6V6p2IoueKCf43tPQKg6LDgG2NoaNwTmixDk9ZxdG+3GV
 GcXb5MVmkBZPjSLFe3EJfw2WkPVsQlCMBwn7ZV4JpSYcBa4jBWZdxgneT/YCKy4QbFJv aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm64jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 00:20:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2510Bciq009823;
        Wed, 1 Jun 2022 00:20:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kg87fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 00:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSVNEZM5e03JwdFEoqF1D6MqevPBa7hsqjPirJQiztTrPjfnymca/kqYIvIztVuRfN4ABHwvxYliccOtpU+z620fJ5tJJTmPaJzKJEgvHLRrMmJevKe3C32aIQyzsQsDGGZRmiH60VrTmHCisqU0XW4PWcPszVUCJgaykceoYRPXQOc9zDbxDQr3FAnezMCk3A3amfpCufPBb/wsPgcqXaXy33vcVrmzvYlip9NnMbVCN5KlD9L6zNqioGuCg8KhToLo1ThYEFJXcXgbe1IrAKIDV8JbnrTX1ghc2pawtfiuAbKQNTGCEUWfOZbIOBgnxl6cfd/R7zmXcvJa6v3cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHb9qvMS5kOfpAkCR2PQrrVfWCQDTRI0r6NQLQ+CtQc=;
 b=h7yr1u+1ABZ/nAT/AsyUImWMReI6gtty1/hAjTIdXuZXZoTw9/zq7yqVHv2UHmU01nwrzODPYAUDKlwo1QJ6AakVwIUSXG/BKMn+fX3LqzZwQwnc1wuth1S7hindow6IATb/ID70sEEiwJpBLq6KDJtETky0jIMkAbrafasiNwJcdTxbwLYHhyWaYQ2QhpUeHULO0liMTNgOAUMHzAJDpUR3E99Px0oLNeOe88tW9UbnwFiOpjG4A64vozFnxTYEFTKx79r9sQx4+V7hshRSDHjyNqzznk2m5F3wgFVoD0d6Ozd+mMwWUvFqL8MmontYVkBgO5nYpu/u1pyqsFMcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHb9qvMS5kOfpAkCR2PQrrVfWCQDTRI0r6NQLQ+CtQc=;
 b=wgUnNCVGqVDg7MGZKsRUi6suFHKzF/J7eeWXlcSibYGUf42LR8PBm4YCh4q5Ks3If51OxZgFRt671Us8kxFkXsER4uXkxBVXJU1VG1PgvM+H1nLKSIR/hFkhssO2+RGP1ywEx9DorkguK20pesaioilF2/wHlSB4fjkztvTQUPA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR1001MB2294.namprd10.prod.outlook.com (2603:10b6:910:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 00:20:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 00:20:27 +0000
Message-ID: <95ef79cb-0afa-ecf8-f1ef-e84e722de47b@oracle.com>
Date:   Tue, 31 May 2022 17:20:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] mm: hugetlb_vmemmap: cleanup
 CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-4-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220404074652.68024-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:300:117::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 150e5e42-16ba-4fe8-d3db-08da4364870d
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2294:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2294A749AB3B4808F020DE3FE2DF9@CY4PR1001MB2294.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPYblrI2Ki2Y4IewiwxN4cl27XhJzhEtlc/ZXKUNTJvkuxluWycWfkhiUiPZpizokHS7qMh/jMKodZQ3tHG1/90y9YjtWb9Fz3VXBFqQnalnjtU4dQU1lNBJSIDEWCJ5MkZtS4505tsHkpmYLkfHipcK5hMM0m9656AjUHSlImknaWqqQrF+LZkcZOFJHX9ArjEAbwbRko1CZWhTbAJRCPBQFaWCpN0ELMzyymQP3wyW6wpWrg8dDVsu1EXUqob0s6rBro1syfEX1Gy4lczmXIc/MrERFhKqYolpIpHIzaaWbCMjOxiANhDITh2O2ybfIg/DfPsjgzeDtBYnUjC08J1FgqiHz4E9A+yMsaIdBAs/QmtW+dcmQgfH8rnrZNYDpkyd2sNPdIAjg4SMllkfYLDIm8vNxzgk98Z81V/3HGU5r0yCPKJ9U+H3FFKnCRFAuGIXmuBYayWbnP3/FEy3DK74dPBVBkuojlhrU9fD5w12GlKzpA8u/gFmqBpj6y8U7cwRhPagAtqJIABx6GgM8ljkbuX6gBLcJRflid72+EOWMPbHwHypS0DwQrsrcKVoq/lGcUHmJnDt6BtPjMV9zh5mY86WBJKg9KEwWIWynqIxwiPyYatau2JciR63vphHX8XGgox6ByO/R9WheDjpVugNjndT1K4LN69RVb7WBfuaUTFapWo2y6DbM0RCxCFvYitOajhqJ7wHYnqiF1Diqad0Hnpy4DMXu1YnFpsiMj9JnXc+9LcKJM+TAjb5ZtG+WkEqvtjibS6XYvocBDekESSAO6lJLX6rxznIousVZeJB4gGhxtaUdUPyu2vnJHdGY34xeLDZ769yykD59QRMe8WFyY7kJTLoQ28IkMOq0+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(2616005)(38100700002)(38350700002)(53546011)(6506007)(4326008)(26005)(6512007)(86362001)(31696002)(8676002)(83380400001)(66946007)(66556008)(66476007)(186003)(316002)(8936002)(44832011)(6486002)(966005)(508600001)(36756003)(5660300002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1VFd2Y0Y2g3MnJpbzJnWVdBd1RrSDFTM1IyMGdWdExyM0J5NlJhS1ZIcGZD?=
 =?utf-8?B?SXpLSjZFS25SZlB3RjlFNFdCT0ZLb3I1QlFqbHlYS2RySTNRclF0Qk0wc1kr?=
 =?utf-8?B?emlGUUQyeXIvU2ZZVG9Yd1l3ZnVCOEdUVGFnVi94ak84L0ovM3laeXQxYkFC?=
 =?utf-8?B?cWpyV0RNL2JyT1dHQ2psWlFjS0RFNm5rOE9iS2NzRHl6Q2pGWkdsMk5RR3Q2?=
 =?utf-8?B?QjFEZnpXUHFyaEtLOUtnT2U5SVd1RitOWnpRVHR6MDVsTzRvS1NDN043NWFx?=
 =?utf-8?B?MHpHRUlXUCt4dFRiQllUREM1RlRlWGVwK0plam5hOFVBdFJQRC9obUJrRXkr?=
 =?utf-8?B?U1JPMFVXVXZQSGQ4eEIvNUgySW42OWdSRk1DNGlIUkE1cEIyTGcvOWdzMm53?=
 =?utf-8?B?eEEyUWJ3RXo5YUtaTzV2djNRSXVMM2NtRFE3dk9DbHgzbmQ4Z1VaeDFmTytz?=
 =?utf-8?B?UnFoc0dyM25iWDBOR2VCN2dzZmlwYkFkazFzbWdiTWQ2VkUzdWtxaEllN0lC?=
 =?utf-8?B?cmx1aFU5SE1XQmdWaFBOZmVpV3h0UnpOdlliUkhENis2Zk5lMVh2THgxaDI5?=
 =?utf-8?B?NFpibVhPRk1zNTJiMm5aWmJBWkNuYnB2S2M5eWNHVGdMTkJhNGJVc0Z6T2dO?=
 =?utf-8?B?cmRTeEVWU244NmI0c09aUHlWNEZmbk92WEVkWDV2a1IxQ1VvdHViY25vYjJW?=
 =?utf-8?B?NTUxemk1dlRxWVBieUduSGVvQUk4QW1hM3lwQlhrbmtHeGRocjJPam5maTU4?=
 =?utf-8?B?eHF6WGc2RldoKzN3RU0vRStsN3draEpZNnlzdEUwK2IzbkFGdmwzVFFVRHNw?=
 =?utf-8?B?TWxNZEoybUMxZTNHNFlPUXV5aWxXeTE4WXVMU0Y1dmh5YXRoMVpiSkVlL1VF?=
 =?utf-8?B?YnBsQWZ3dDFFT2VVcjMxUzM4UXJIZTFtMzZlbTVYeEsrWHgzMlYvZS82cndi?=
 =?utf-8?B?Z2pkSE5OOFFJUS9HbU5WRmh1ME1sMUt3OHEzeVo2MTg4aEUzTWYrdzVBdHQ1?=
 =?utf-8?B?aVpFWUpxcUhCNCsrZmhOVkRBUWw3NTJlaWpTSzRCa1dwaGJRUlRSbEU0aU1v?=
 =?utf-8?B?TGJiQVF2clkxQVVIVXZxcDZyaTAwVUQ3NEZEcS85K1Bob0N4a1J1VHAvU2kx?=
 =?utf-8?B?S1FSNU1oSmhFV3JDSjFnM2dnK0dDQVJPbzNLMUhFZnJTSXc5Um1DQjlUbzJv?=
 =?utf-8?B?UWpmd1h6M1B4QkRaVS9MRHBmbVRHZFdYcGtwQ1ZXQXphZzFIL0xXSEdPSjF1?=
 =?utf-8?B?ZDg5SHBhbDMvcm8wS1ppdlI1YU0xZU54MUt2WUxZekQxVktaMmp4L1pQbVBn?=
 =?utf-8?B?R0MrYnZlVStwQS9nN2ZaODJBUXhickJtUFdoY0Z6dHZLNFdYNzIwUDUyWFRq?=
 =?utf-8?B?M2RjQisxaFE2dUhwc0FJMk8vSUlUbjQzVHRmazVjVXl4UXkrMGJHUXA3QXpj?=
 =?utf-8?B?VzdVVVRuaWJhWDdxVnFSRlU3Tms4TjFSL01Gc3RUMTZlU3VMOFNYbXh0eWdT?=
 =?utf-8?B?ZC90V21BSHlVUHFNbUdHUkpTaDAwZmxwQ0d2TXdNaXBxVlVJV2hDUG9Pa0s4?=
 =?utf-8?B?ZUFYYTljLytYUXlQK05rNWVGS2NTWjh2eTdydk5scms5aTFjd3lub3RWR2ZR?=
 =?utf-8?B?V05ZODJsSmpLdTNjWitpaThpVlJUQUNNcFdoemZJcTVNOFZFRXV6Sm01c0Ev?=
 =?utf-8?B?aGYrTXlJREhXa0VoODRQNzhVZUI0c3c2cjNnUU8vMjFuVEUvLzBnU25wOGZU?=
 =?utf-8?B?MEFuV1JlVDI3ZUpvUVlMM3VjcXJyaGxjRklKelZ4VjJIZEh1MzlpN3AyYW1F?=
 =?utf-8?B?eVFmakNZQ3ZEQThsWVlGaTFwYTFvWkUwbXRCUi9Pbm9rL2hQRHJtSUdYY0N5?=
 =?utf-8?B?N09KUkZJRUhkMXhqdW1mWjZOZlAyNkwzbUh1N2h2a3kyTWd1ZmM0M0VwbTc2?=
 =?utf-8?B?emx6RHdZT2hHcnRrK0dRSU9zSGpuQWhpNWJjSVNwamc4MXpyWkRHVndQcm5F?=
 =?utf-8?B?K0krV2RKa1NnajFZaFJNODM3SFVBQ3RuTGVhMm5FRTBpSHpKVHVzTGs4MUw0?=
 =?utf-8?B?eFdiaG16S1l0b1BqeVdqZWVSU2ZZcFgyR1ZTZzlNMmRKVXF5NmJ6Q1JuclQv?=
 =?utf-8?B?NWpEVEc5bmFXSlF4VHAxZXJManJuUXgvTk1DdnMvY1lYZzBQVGpSY0FDVXhN?=
 =?utf-8?B?aFdERjNLRitxZUxhYnFVVHVER29RdmgzUThjRjdadFBHRlpaQ3VERTFObEls?=
 =?utf-8?B?VEdxcnRTZkMrT21vTDlpN0F2RnZnMUdXQlFFS3dCR3JzUlB4M2U4NG1YUXBB?=
 =?utf-8?B?VWU2VHZ4bnZVUTdLTUpab1lsUS9WS2FpMDcwdFlPaDhEVVdzRHRrWDZoNGJ2?=
 =?utf-8?Q?xpfq/7ctBO7j+fCU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150e5e42-16ba-4fe8-d3db-08da4364870d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 00:20:26.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/Ds3oUjatx7U5ci/SwxZUpyELQeEwNpUYjYVENy5UfNcPTFXMmZ01LEgJ5vR0SktTa8Svi8t6SQQd9oNyGn3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2294
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310105
X-Proofpoint-GUID: xpxtYZVxoUK64lWI420FzTRsITHEnmoc
X-Proofpoint-ORIG-GUID: xpxtYZVxoUK64lWI420FzTRsITHEnmoc
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 00:46, Muchun Song wrote:
> The word of "free" is not expressive enough to express the feature of optimizing
> vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
> In this patch , cheanup configs to make code more expressive.

Commit message might look better as:

The keyword "free" is not expressive enough to describe the feature of
optimizing vmemmap pages associated with each HugeTLB page.  Rename the
keyword to "optimize".

Change configs to make code more expressive.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++--
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  2 +-
>  arch/arm64/Kconfig                              |  2 +-
>  arch/arm64/mm/flush.c                           |  2 +-
>  arch/x86/Kconfig                                |  2 +-
>  arch/x86/mm/init_64.c                           |  2 +-
>  fs/Kconfig                                      | 16 ++++++++--------
>  include/linux/hugetlb.h                         |  2 +-
>  include/linux/mm.h                              |  2 +-
>  include/linux/page-flags.h                      |  6 +++---
>  mm/Makefile                                     |  2 +-
>  mm/hugetlb_vmemmap.c                            |  4 ++--
>  mm/hugetlb_vmemmap.h                            |  4 ++--
>  mm/sparse-vmemmap.c                             |  4 ++--
>  14 files changed, 27 insertions(+), 27 deletions(-)

I see the issue found by Vlastimil is already fixed here [1].  With that
this looks good.

[1] https://lore.kernel.org/linux-mm/20220527081948.68832-1-songmuchun@bytedance.com/

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
