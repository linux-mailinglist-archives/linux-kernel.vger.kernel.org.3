Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC918567C84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiGFDW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGFDW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:22:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B291658E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:22:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265KwmCP023549;
        Wed, 6 Jul 2022 03:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=gS9TTGX+s79A/vrtd7W9bhzH32sNEsyDyXOzUZ6S7vc=;
 b=Fe7XIoCmAJ2zymbeZzAxFx/ujc78CWNMZIRVy17wLTC6XqGV236kHLO89CMwXl99I5r5
 IUB6Ub/5kpF6mnSgwkk7egZAfVuUxhYLXRZXZbPeQPVoE/XLpUsaDnxNzQETuiMeD4hc
 UkUc0WUmd3XfnirqMDdSD38CIHht8uY7gg+cebm0Hrk123HHRMOgh8iwu+nlvili/HH2
 DU/o0tujJ2mz616j2z84N/e3I33vYOiiSZ03orqjhpC3SucrSTqrzwRyqu8OJVach/BB
 /qs0NMZZMBC3EF6ghMB9OLxZP1dBcvceH7SzZHL+bCYregMVpE18jbBs+GCLsML9iFvj lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby8pta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 03:22:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2663FEr7011221;
        Wed, 6 Jul 2022 03:22:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud4fvk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 03:22:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvgZLY9r12m7/EZlt+Q+2EXNs9tAJQStS/38OsNsPzCctufhzu1W5jCPseGMx8YZEVsByJ8v/qACcXqdE7MFETkYpHmEd/GzP5DVx5A7+b9KBiSJzsZW1Ji8/ND4M/7775B0emsJqtIWrIxopqhTQE6EHu2Os6Q7ZaiXH3ENHey+RFuw/EWCQQ095blcW6TQywt+ML3NTeCjRuFa/qF14fxZGi/us1J1UCPbBSq0amdTGBkd4+HDz2T9m9pHJyyRSEM+vJBVIzHlnFOdbnMfsKcEqEPanN2dQOMmqE6DSOxPRfCAtcNk67NqDHxSLLsEcx0Mh6Qhf3NBDw2SjVfJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS9TTGX+s79A/vrtd7W9bhzH32sNEsyDyXOzUZ6S7vc=;
 b=lTKSZ62WKijVyowVyHlzDBu/zi/tuUehqqoCQaazejmbnJJm67dfx3q6I0mqS9SMAfZp6MT55JcAvva+01dh5AiLA3tkHuSRl8a6LuWsYZnxM2IOdjmJ2O6U+RX/VlGpEE5dphGi0obVHwHia+T83dRS4k9li6oGebJtDj8Rp96iG4CbTFa1yiIQwuBsMwW6klp//SQsnT8hH9Kby3PrNRVm25YYchiDSEplEGX/edPawsZk8h4z0KitNKPWACMkJmzzkQEjOMC6nsrONQTI1BkRlUtw09cllo0gdCpFWQiulhVg9x17eojWH29lBKB390Fo3j6XHmWLgBSA2kisKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS9TTGX+s79A/vrtd7W9bhzH32sNEsyDyXOzUZ6S7vc=;
 b=Nmb2yCEaMmLbr/YX1skC23PvINqbbU8iWYpNaUg/QGXVfYtbviOgukwD67vhCte5LqxUYl6iYaj/yLRW4HlqsMnhfHfUwOmsZXHgEWjAk42N8RVxyge1Qlkrj+YK3Ija/gkdLdCEHCB9KWHW53xzwpluSBOi/7CkgBE8b3Dvia0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2998.namprd10.prod.outlook.com (2603:10b6:a03:84::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 03:22:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 03:22:29 +0000
Date:   Tue, 5 Jul 2022 20:22:26 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [mm-unstable PATCH v4 1/9] mm/hugetlb: check
 gigantic_page_runtime_supported() in return_unused_surplus_pages()
Message-ID: <YsT/8jl2JfDbw0Ku@monkey>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-2-naoya.horiguchi@linux.dev>
 <865207df-b272-c7c9-e90c-5748262d3d87@huawei.com>
 <20220705063918.GA2508809@hori.linux.bs1.fc.nec.co.jp>
 <185c2a5e-8987-c679-b522-418b5072f1bd@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <185c2a5e-8987-c679-b522-418b5072f1bd@huawei.com>
X-ClientProxiedBy: MW4PR04CA0229.namprd04.prod.outlook.com
 (2603:10b6:303:87::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 517f7ef1-60a3-4ea2-7cef-08da5efec1c5
X-MS-TrafficTypeDiagnostic: BYAPR10MB2998:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5SYd2kMEIrHShoSn7cYlPt6JcjwhZFyAelPwQVGRvNhTZae/3IIIO1zBHo2mBo9uBNDZs5g0ECD1i+j0a9L7goYKCPGwxo8Bt5JwVnNJDAmxHQL1w/3SVMX+K6SYueSIZIUfGlESxpURTf4h4aUbTkV8F77EiIS6K8kxbmNuZbD4GzBq1mcKpvktj2bugMmOsPMehmUj6oPBzJqQgByC/jqP6dcJK6yR692STJI/m37oR4epHQ80QBQPo7cNCfYtkGh3wRlZbYi6IdXa27EtMAXiwI2LTRgUMQPvevo8tFjI7DOGpfKwtpZCLqwpBvUm1tIx78MFWPjNLT58TGI5E9P7ga7qrTziFZ0dD6JPLTeHUxNmt5cBIiWvsEUaeDYe9NZHd1Y0nQpM1Qamjp9JlLKBewrzCqhxJfolY5pu3ryy26fYGin/ZJLW+jLJyibtWHTpK3xh7WbW3Zyu2bj52wjR12HlhvGfdexmh92tJtWk+u9L/hzrnBygxyHGavKGb2J+65HCkFIZP42pXQ5I7tZQAsDOLmQu20iq+EizbZzZOPV2Q6A6wA9bC1Ml0jkdajAJCsAGukyrrwbcZfx0Jdo+Gr2qu/X8w/3k/rQamnaSX8WyuEmRLiXjG/Dqgi1bOE76A1laUkSreB1eOIbBoKc493NLVkSohPitH8JjByXDKr//fGOdtiyR4UX9l5eLhw6jzAk3ljNtgIRCaYesZ6dsJAulsJeCjj3ogoUGnwx+z1xjLzN+g+UW/3i5mpR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(39860400002)(366004)(396003)(376002)(33716001)(9686003)(6512007)(26005)(6506007)(38100700002)(66556008)(66476007)(4326008)(8676002)(41300700001)(66946007)(6666004)(53546011)(2906002)(7416002)(5660300002)(44832011)(6486002)(83380400001)(8936002)(86362001)(478600001)(54906003)(6916009)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU1tbkwwK0RsbDBXK3dKL29NS0NwNXlYc2FlKzVlOWJGMThTa01xM3FjNld2?=
 =?utf-8?B?ZW9aUzJ2V0RUb3VoS3NBRmpzbGRpL1U0bVArakdQU25rbnViWklUa2U3NFAv?=
 =?utf-8?B?RWhYUVZMeFhtWE5pUUZTVDdFSEdNWGhVNHZHYXZtMFBjaXJoYTBGb2piS1B2?=
 =?utf-8?B?bEsrcEdSMUNMTTdvYTNVRjVaQ1JvTUx2aXlwSHJkK3BQTzVmTmpVcENidHFs?=
 =?utf-8?B?VTlkYWVMRkgxcEN5aU9uUnEyQ29naU44cDMrTUxDZmFTV3Awc0ZjYjdwalNJ?=
 =?utf-8?B?WWl5Y1dwMXBsdGJjamdTeFZaMWdGWnpCRG9sci9xMzlTVWw5anpHa3NtejFh?=
 =?utf-8?B?YktXVHo4bWpQSTlNMkFyU09hOXhKMWJKNDJPdlY4dVFPbVhBaHpSR1ZOMEo2?=
 =?utf-8?B?dGdlK2JNV1BlTHp0R3RRWDNYdVI5RzBFK3dGZXhIQzdmZFlBZlJpSmNUQVFo?=
 =?utf-8?B?TkIrNThMQVd1ZmpSUlBoT0dnSHBuVkc0eDdtNkpicjN1VUQvQzNBMExlRGJp?=
 =?utf-8?B?RG84dXZNTU1KWkRRdmZBU21mY3d6eEpkNkRrcjdIZDFkZ2dGeEhlNGdlTDRR?=
 =?utf-8?B?VG9LdVh2OWJodHFPQmlNTU45UzE0dkE0TkxrY2NCLys5ZEJsc0xaL0dIbXll?=
 =?utf-8?B?V1BSVmRlM1pqUDNNVnUwckpKQkFWZ0gvTHRhd0pZUmU3bnR3d3hvNkhlS1JW?=
 =?utf-8?B?OUFtN0J3cXpoU1BNdEo3SGU4Z05jcXBoZVljaWdVQURIREIwdXRwd0NPVVdu?=
 =?utf-8?B?b0c4Z0xrSGNROUU4ekk3OHE4ajdCcERSbHZCc1VPeTBnWlR3eUVpOWhWOGJG?=
 =?utf-8?B?cW9xVjhvMTFCMmpUY0g1Tms0SnFSS2Z1SG1GUWxpRlBXbWIwUkV5TXVkSkNH?=
 =?utf-8?B?TWVqWEhmNXFIUFFZQkVoaVNtekpQeHFvdzhaZUk4elYrMlZOQzdJYUNnSEdY?=
 =?utf-8?B?czNIeGZUMldPK0w5dmExbkdPaXZRKzdLaE9qK09YMGVUVVNOeENPRWlkZU5Z?=
 =?utf-8?B?OFJ2eTBmbDVKS2RBZDZ4UzJSWTFCaXp2MlVxODBHL3Rzc0tZbXhZRXM5Rnd6?=
 =?utf-8?B?ZzhGU3U4UzZUMGxJTlI3NXBsZlRNRDJtMDlRbG15V0lsRXR1ZVhkM2M2NTk0?=
 =?utf-8?B?cVFxdzB4NU1FUEZIQi9YSUVxNGZqMTIxY0RFUXRyVm9kMlRLb0RDWS9IempJ?=
 =?utf-8?B?RkF2ZlUxcjhoU1phUUE5M3FpbjJzTVQrSjdKM3U0L2lPWDlBM1dsTzdtSVpV?=
 =?utf-8?B?dTc5WEJ3Um5DOXB0MmVKRW5VRXlMWkk5dklNN05aUVJzNUhCSm9JdFExQjZF?=
 =?utf-8?B?ZEFsWTQyUDN3UVNWcFNpUVNyNktGWG9zUzMrM0RRRndmbXFlQkNSbkQzd3VO?=
 =?utf-8?B?L1phNkw2MHBvdW9JQlBOWFZDaGFoRlFTNmdSbzFUdkRGK3JWcmdkSHNzcHVa?=
 =?utf-8?B?TGs3RDJHTktBNDFLaEVTci9JMjJNMlhMTG1tNHU5SUdIbzNacnhzUW9zMVE0?=
 =?utf-8?B?NkNmdjhsSnNYQzREeWpPYkljRm5VaU1tci9aeUtxN1JWNUprUEhXOUxOa0p2?=
 =?utf-8?B?NmhMUDdvWmE0dURacVhaNnVNVGQ4Qjk2OVlXbzl0NXA5NHUyQ04wdTRGT0RY?=
 =?utf-8?B?Y0w0cmRwREExT2tuaWdKaXhYWVZVQnlJR2pSWGFKeis1bVB3MklGS1hmcTVN?=
 =?utf-8?B?YUpiMGFOd3FNa3FvREdSaW15TFppWllwMXI5YUx1RWJYNXRhY0JJVnliYjZ4?=
 =?utf-8?B?d05jaFV6dm9SZzZzdXhaK3JncjE5eHZkbkhQazlJTDhNVEtFd1lWeGFJUjJL?=
 =?utf-8?B?K2VxMnJSTmRjWGVUeGViT2FXZzg3djNrbnc1MWQvMDl0WkdiVGxZOWM2QUNR?=
 =?utf-8?B?c2wyNXhCdlQ4YnM5aHkxajEreTE3S3FMNld5Tkk2UjlCeHZzdVBoVTJJWWxU?=
 =?utf-8?B?RVRVQTI0SVhLeDh3cFo3cC8vZTMrbUNJRjdLMW81NU1SZldyZ0VDMHNZd25v?=
 =?utf-8?B?UnM1K0YxeHZ5MXhlNmdmaVlTM3NWNHVoVkUwNDdLNUZ0cHZpbEZMY3FwRExr?=
 =?utf-8?B?ZDVML3NqR3ErakVyTDdCSWlOUHV5N3VrQTMyNEdBUHZZRWNDc3RhUC9IWks1?=
 =?utf-8?B?aUpVWmxzQU1Mc255N2VOdUtrUjdyWFI3NkxVajRHVSsyWjJObXYzZkRXT0NG?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517f7ef1-60a3-4ea2-7cef-08da5efec1c5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 03:22:29.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbVlHxgd+EgnMaHYjzHZB6mB6VBq9Zr+DSnov8LTZ4Fapj7tOr9QP2hfvj4sC75SmF78q2PTQv9SgLjuYjAUbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2998
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_02:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060012
X-Proofpoint-GUID: BkXWMrl7fgDg17R4ePp6LfATDLlflXRS
X-Proofpoint-ORIG-GUID: BkXWMrl7fgDg17R4ePp6LfATDLlflXRS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/22 11:04, Miaohe Lin wrote:
> On 2022/7/5 14:39, HORIGUCHI NAOYA(堀口 直也) wrote:
> > On Tue, Jul 05, 2022 at 10:16:39AM +0800, Miaohe Lin wrote:
> >> On 2022/7/4 9:33, Naoya Horiguchi wrote:
> >>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >>>
> >>> I found a weird state of 1GB hugepage pool, caused by the following
> >>> procedure:
> >>>
> >>>   - run a process reserving all free 1GB hugepages,
> >>>   - shrink free 1GB hugepage pool to zero (i.e. writing 0 to
> >>>     /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages), then
> >>>   - kill the reserving process.
> >>>
> >>> , then all the hugepages are free *and* surplus at the same time.
> >>>
> >>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> >>>   3
> >>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
> >>>   3
> >>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/resv_hugepages
> >>>   0
> >>>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/surplus_hugepages
> >>>   3
> >>>
> >>> This state is resolved by reserving and allocating the pages then
> >>> freeing them again, so this seems not to result in serious problem.
> >>> But it's a little surprising (shrinking pool suddenly fails).
> >>>
> >>> This behavior is caused by hstate_is_gigantic() check in
> >>> return_unused_surplus_pages(). This was introduced so long ago in 2008
> >>> by commit aa888a74977a ("hugetlb: support larger than MAX_ORDER"), and
> >>> at that time the gigantic pages were not supposed to be allocated/freed
> >>> at run-time.  Now kernel can support runtime allocation/free, so let's
> >>> check gigantic_page_runtime_supported() together.
> >>>
> >>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >>
> >> This patch looks good to me with a few question below.
> > 
> > Thank you for reviewing.
> > 
> >>
> >>> ---
> >>> v2 -> v3:
> >>> - Fixed typo in patch description,
> >>> - add !gigantic_page_runtime_supported() check instead of removing
> >>>   hstate_is_gigantic() check (suggested by Miaohe and Muchun)
> >>> - add a few more !gigantic_page_runtime_supported() check in
> >>>   set_max_huge_pages() (by Mike).
> >>> ---
> >>>  mm/hugetlb.c | 19 ++++++++++++++++---
> >>>  1 file changed, 16 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >>> index 2a554f006255..bdc4499f324b 100644
> >>> --- a/mm/hugetlb.c
> >>> +++ b/mm/hugetlb.c
> >>> @@ -2432,8 +2432,7 @@ static void return_unused_surplus_pages(struct hstate *h,
> >>>  	/* Uncommit the reservation */
> >>>  	h->resv_huge_pages -= unused_resv_pages;
> >>>  
> >>> -	/* Cannot return gigantic pages currently */
> >>> -	if (hstate_is_gigantic(h))
> >>> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> >>>  		goto out;
> >>>  
> >>>  	/*
> >>> @@ -3315,7 +3314,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
> >>>  	 * the user tries to allocate gigantic pages but let the user free the
> >>>  	 * boottime allocated gigantic pages.
> >>>  	 */
> >>> -	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
> >>> +	if (hstate_is_gigantic(h) && (!IS_ENABLED(CONFIG_CONTIG_ALLOC) ||
> >>> +				      !gigantic_page_runtime_supported())) {
> >>>  		if (count > persistent_huge_pages(h)) {
> >>>  			spin_unlock_irq(&hugetlb_lock);
> >>>  			mutex_unlock(&h->resize_lock);
> >>> @@ -3363,6 +3363,19 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
> >>>  			goto out;
> >>>  	}
> >>>  
> >>> +	/*
> >>> +	 * We can not decrease gigantic pool size if runtime modification
> >>> +	 * is not supported.
> >>> +	 */
> >>> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported()) {
> >>> +		if (count < persistent_huge_pages(h)) {
> >>> +			spin_unlock_irq(&hugetlb_lock);
> >>> +			mutex_unlock(&h->resize_lock);
> >>> +			NODEMASK_FREE(node_alloc_noretry);
> >>> +			return -EINVAL;
> >>> +		}
> >>> +	}
> >>
> >> With above change, we're not allowed to decrease the pool size now. But it was allowed previously
> >> even if !gigantic_page_runtime_supported. Does this will break user?
> > 
> > Yes, it does. I might get the wrong idea about the definition of
> > gigantic_page_runtime_supported(), which shows that runtime pool *extension*
> > is supported or not (implying that pool shrinking is always possible).
> > If this is right, this new if-block is not necessary.
> 
> I tend to remove above new if-block to keep pool shrinking available.
> 

Not sure I am following the questions.

Take a look at __update_and_free_page which will refuse to 'free' a
gigantic page if !gigantic_page_runtime_supported.  I 'think' attempting
to shrink the pool when !gigantic_page_runtime_supported will result in
leaking gigantic pages.  i.e.  Memory will remain allocated for the
gigantic page, but it can not be used.

I can take a closer look during my tomorrow.

IIRC, the only way gigantic_page_runtime_supported is not set to day is
in the case of powerpc using 16GB pages allocated/managed by firmware.
-- 
Mike Kravetz
