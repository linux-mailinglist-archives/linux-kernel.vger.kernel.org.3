Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65B9501F32
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347711AbiDNXjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiDNXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:39:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB99BB91D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:36:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23ELLEqV012645;
        Thu, 14 Apr 2022 23:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YNoRVgGgHwgUIoagyEUKVYC8ieI93EWKH3Uoke6xxkU=;
 b=qKRZV3Uhh90MWz1eoZns1GP7MkiI3wE8RM6ZGC8uNK1Qxfyj1yBjiGDJL9wPPNQVyj1Q
 LuliWCN+tG7x+gEj+MK0d6huAkiAlqc4sYhZ1SoW8rkpUvyL0isZMeCJ0V92rdGAFH2H
 z4Hz5UOTLb+g+eBrT91AhVDMJVYfBHRO+Teg3p4rKk1xYVyZw9vPrF9K/pMpWfwVmNg2
 CwIVuY1A+nYp4znGRTBaC2LUWTO/s7DIYxHg2svN0HzAdi2tfk6/vXjX/DCA4DbT/Kd4
 t6tUEQwqS4S0gVJ+rIQHqhy09rE1sZEOTI/ulVtvGdml0dv632W2BHob7Vl21cRSh85C Pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu6ecr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 23:36:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23ENZpfl010398;
        Thu, 14 Apr 2022 23:36:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k5qhx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 23:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvsHp3lEbPFmnE3e9jzrwkVnIBUaw0MMuif9NQTYyQXCBLj5T+GMV3D/6JugnMSCEUJekljV93fMsVyOU7XPUrei3ELuKLLPhkZu6h8DwUKB9rsrC91m2vBhYyBSOSzq4z2WIC8aFrFZZ7sjf1IRMQ9KuBlCdOTRnqTZtJ55V1ApTNIzQwS8ZRCjDbDOxlv/+UVZwo7eStuM0cMj/BVaBw8PCGLGhNTl1EYufQvHk7MfYokSmkOeZGZ+mgRJpjcBifSldUQtoP12czJOiSqsWb4MhIAbLlL7Sbc48oAsRT0sb0XkKiqaO4eyXtmZ56Fa+aSFP+NyFz4dEzawTvV9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNoRVgGgHwgUIoagyEUKVYC8ieI93EWKH3Uoke6xxkU=;
 b=YY/Tc5ObTdI2AydwpABs5FRcSdLvrk5jEnZ0tay3Z2kO7JpytmBcijC42abrtrJpYQRIsyMRcOlKEQxHlsDLgmhQmPnAjNpfPzxfykN1nrHYiY1DJHQwvBYoHXGQSwgThvQlwVcbETKZ+G92QT0d0HYWCvqv0nRTEz5gWLhr7pViFR8oTLlkIbiPl96SI4mqUve+O26/DyN9/IQmSBwLUcvfadyBD6BMOj0Z6fRzHiz5B/PyGstCsyZjiZgVoQAO0z3kUEMvIz6qAIUVvbzOcWA2zuJOpSo4JHrJWU2bWaKMITROgmVP2C9VMaIMmaVBQtSKAyIUCQoTnjp0V5byjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNoRVgGgHwgUIoagyEUKVYC8ieI93EWKH3Uoke6xxkU=;
 b=LWWg6qTGLvvo7FlWoPx8/Vku4OBxix/n+dgJ22Dt8pXrPryUvb1lCyx9a6no3xWO7jbQ4id/HKs6Mo2HRzLMvLl6qWq2x3NAkGHUe5RYdEgZxuwBtS83RwxG1ebfw7CKULzHdx4+JWEy1Q0E0sHC0WlYKkHHLgzInZeZS5kj7jY=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by CY4PR10MB1846.namprd10.prod.outlook.com (2603:10b6:903:125::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:36:20 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d9e:d013:c6bf:3635]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d9e:d013:c6bf:3635%2]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 23:36:20 +0000
Message-ID: <f2a6087e-145e-3f79-c93b-c510854e66ca@oracle.com>
Date:   Thu, 14 Apr 2022 16:36:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] hugetlb: Fix wrong use of nr_online_nodes
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-2-liupeng256@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220413032915.251254-2-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:303:85::30) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a925b2e6-1c19-4414-a101-08da1e6f93c4
X-MS-TrafficTypeDiagnostic: CY4PR10MB1846:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1846899FD068354C80770225E2EF9@CY4PR10MB1846.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoJAio6rQtiB4/zazhHAeaIeQERGYJpnZC/LYMfjRc+O/wSPPaO140jHCRnehcrgqFIy0TBRRpoUJXCUOT0P5/cxa3p3q1AlbPTAdvjTq8NZdVdQP2cDzqNvRxQ7FjfcroFtcZDCsT/1ZUm33z/bKLkIgrV1+QWb2Xrmy5jAK4esdKHZ/tOS7PIZQErKVnixxItNV13junc6OCUbxX3FpsH9+YXXWX/jfqJKe7b35xJAWL2P1ad7rdeN5r2PquJCDsC0apQt+4VGCR4oH90WMVY2PzOSWfLj/5EM8Eie3G8qzuEGSUeBTbnUTgEWtCkXcD9ZFzgVr9xLv3SuLOQ1hrur27gSjYXO27pMdBplsIo4947+N9chzF0sXyWWoqAyoYIsTe94kvTntaJd5KrluypBzzHhLIV3AslAFrQr+EbVrKmezaNQmXXMCFgPywcAzVU4ZvnG8URexJOq8l+9CpGIfeVkeH4aTM89CRnUh+5yygBNbkQbHnZEz83MK0Tghy7DGnCkybLYwLIows+78rs/6jDGWz4H6U2c8hK+akflE/l1Jx0+Shahw2NlU2U6ak8ErBPUVuu5smOlD2nDw04nccRPlkHuQ841V9TaLnqKSRD7WSc5boTej6naNg8+p2vpwqPlLn6dNThMJElSkkE6gufBUBHCB3bZXn6w0pZ/ro9rIu8FwPqkmihutG5nmrSIt41lbztgrl6QMosSWZrrqor6/6xBiIxn3TlP9e84FG6FnzoocOWGyrOHOd2sP/jANlonXxFdRKDEAH93wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(86362001)(66476007)(31686004)(508600001)(31696002)(2906002)(38350700002)(38100700002)(6486002)(53546011)(52116002)(8936002)(2616005)(26005)(186003)(44832011)(6506007)(36756003)(6666004)(6512007)(5660300002)(8676002)(316002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3E4TSs3eFFyMkFhd05KZDBPT0NqT0g1Q1dneGE0QmtvZDF0WEpwbVhyNnhj?=
 =?utf-8?B?a2NaSGo1MjdUTWRZSGhTekJmdmc2cUExT0s0a0RpemVhWnRVTFE2VFVOR1VC?=
 =?utf-8?B?aDY5WHIzdHNadUlhbFZPN3lEWWhsbXZ1Y1h5dEVnaUdSRm52UXhJSWkrZWhp?=
 =?utf-8?B?c2V3Qnl3a2dWQ2hXUm96MWZnK3FFaWdEa0REODZBU1U4RTBiTXBRdFprekRR?=
 =?utf-8?B?Sm1UUUM5RXN2V3IzbVFXYnQ2OEFJTnd3Tk14S1FXUE8rR01zSDEwZ1ZLTzg1?=
 =?utf-8?B?VW1hYkVXcE1aK0FEdHlxK0t6anU3SGtOVjlMSVVLa3d0Sks0bTNsZmVRZVlG?=
 =?utf-8?B?RVJOR3NvZms4eTBnZjJwK3I4WE5BRW1sSk9oeExIUWRDYzVZRE5BWUN5TmVL?=
 =?utf-8?B?ZlVDWit0aStybStlRnBrbGtsQkFXdEtKMkpYUDJQUE5SS0MyVzQxVVBBYjF2?=
 =?utf-8?B?MlpQZnFVUysyWFZLV2xiaVVSUlo0UWE3U3VDdndWbnhLVWgzby9hNEtaeVlR?=
 =?utf-8?B?aTcrWTB6YnRxbG90MnVKYWdHWjZGOEpXUnMxRW43WC9BeTBzVC91aEo4dGpJ?=
 =?utf-8?B?WE8vZU52WWRZMm5BejBCSHRva0p4Szdkb0NVUU1pTTIzYVFIczRYL0xMbloy?=
 =?utf-8?B?VEJyRzB5YWR5RU12c1RmeTZwZDNtUjJtemh2RG8weEhuQ0xSVytyMkJTbEhJ?=
 =?utf-8?B?OXo5S0ZnQjhtQm5iTG50VlptR3Z1ZzFtSWVxUThFRmFwR0lSNXFtVFNOOC9q?=
 =?utf-8?B?QXRiMVcxM2dGaU45cngyZjl6RlM2Wkl4amk2WXpZWjQzNlFtSlV5Rm04bm94?=
 =?utf-8?B?YWpCNS9rQ3ZyY3NSa08rWjJJTFdDUzNBNURHYUg5RmJvMFp5NXl3cldwQVlO?=
 =?utf-8?B?YnI5S3lEamthV3J6aU1pS1hKQ3hPWG4wQjRpTGEvcENmcmdqS2F5TFgzaDJP?=
 =?utf-8?B?VTYzRzJ1Q0IwYmRic3o4UEhsc0VyUG5QblZZS05USm5xZG5wV1RNVk83YTlH?=
 =?utf-8?B?Ky9uRS9pSDZER0l4aExNM1ZzSXhVei9EaFQ4dEp2cTllUHNzQjFtNU5GODZR?=
 =?utf-8?B?REVPdUZQNTdVMmZQK0NZQUgvc2xHM3Blb0x5Y3g0YlQ4NFhaNGRnK3hzWmRy?=
 =?utf-8?B?NFhldFdzSjVTOXpRNkQxWnNaMk5XZ3AreEpkUmsxVEhZL1czOFRZb04zazRC?=
 =?utf-8?B?TnBMSkljNURxVjlSVGJJY1E2Zm1OS080VkVJMkRsVnVCdEMxeG5VMnJKVWJ6?=
 =?utf-8?B?eEtERzNJM2pteVhjczJuRnpua2FKYlVITnhCams5bEtueWR3U0FyM2J1RW1N?=
 =?utf-8?B?NjdxQW9zMlU0VWZhMzRyMmNHT3JlcnQ0Y2tqL0hDL0xBVkVnUXNLMVE2WlBw?=
 =?utf-8?B?ajRGK0huQjZ6NkdaWEtneVl5NzNYOXdUeGhyTk9XVUJXenMxeE84QUQ3MlNl?=
 =?utf-8?B?VElqQWF2MjFlcTRzM0ZKOXYrVVU1TzRiei8xckJSeGplTkduaE9iRFVZMElr?=
 =?utf-8?B?Ty9ZTTVodmNHZFEyWkZLektvd0d3NXJsV3FwcG13U0dHK2V5R2l4eFJ6OGpu?=
 =?utf-8?B?TUo2LzNrRmQyenB5QS9RSW1RVGtRNE1iSU1DMDYrT2pDazliQ2JIZldab3la?=
 =?utf-8?B?M3hhLzhzdFU0cktGZmtxS2U2TlJ3YjQ4RG9rdFVVdTJuOG8waW9kelVDZGlw?=
 =?utf-8?B?S1ZHL3U4MEZxNTJuekQrOXROempXNzgxc0tubDQ3NDN4ejRFVXRpN0U1b0dm?=
 =?utf-8?B?ZXdpeUlmU0FXMEd3dGpkUFY3QjlqTTRiS3d6citQYUlQb1B2N3hTaEM4cU9X?=
 =?utf-8?B?bFg4L01DREhwam9CMHZXaFBZUkhtTWtOeVF4Uk8yeUZCR08zOVJGY2tCZEdz?=
 =?utf-8?B?aFVrN1ZyODUzZzR1dHp3RFBXKzlVS29XaTI5WnlBd0dhNEpzYVdVVFNtYnVJ?=
 =?utf-8?B?aXR1MlIzRTE3S2Y3TnRjTS9sNlZKN2pRbDlPZzNaUlhaR0lDbWxkclk4S1V3?=
 =?utf-8?B?UndIYiswa0ZLcXNiOS9xYng4RW9sVGJ0TW5wWkhNMGlra3A1ZURYVWM0SmdF?=
 =?utf-8?B?VThUUjhvRTJpZ1ZnT3BxdEZqYUdJbW5jZFpQL0VFVWZZVkFQVnRWYVNRNEFk?=
 =?utf-8?B?QW9GcHdyajNrMGhkWE1BNHRCL3JPQTE2V2JyTThPdERXdVoxaU9oMDhCTEZq?=
 =?utf-8?B?alNDa2FjTmsrcVF3djZLcVRvR1E2NEs1dDFaR1NLQkF1YTlJYk1FS1ZjTzls?=
 =?utf-8?B?NG4yOEorUTBpMnIyd3lsbVVuWldtQjBJTjRhTFZvckFhSFZkNitZeHZTdWxO?=
 =?utf-8?B?S1lkdDVFaDhBTno0L0dhQ0JpT1NUbklWVHFaNzhIa0hSVDhKeG16dXBFOXM5?=
 =?utf-8?Q?YomQCgxn/F1xtSdQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a925b2e6-1c19-4414-a101-08da1e6f93c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:36:19.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cmzq52IULtKn0LM4ZvOy+weW983tCwSYrpfDzRDLMZ7D3epV5zmbb89pZWwCnGB+SdBtRsVh/yNOtGpja/+VfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1846
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140123
X-Proofpoint-ORIG-GUID: K86kMr9BdywNBOLlx1WTz1nANFtCV0wp
X-Proofpoint-GUID: K86kMr9BdywNBOLlx1WTz1nANFtCV0wp
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 20:29, Peng Liu wrote:
> Certain systems are designed to have sparse/discontiguous nodes. In
> this case, nr_online_nodes can not be used to walk through numa node.
> Also, a valid node may be greater than nr_online_nodes.
> 
> However, in hugetlb, it is assumed that nodes are contiguous. Recheck
> all the places that use nr_online_nodes, and repair them one by one.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Fixes: 4178158ef8ca ("hugetlbfs: fix issue of preallocation of gigantic pages can't work")
> Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
> Fixes: e79ce9832316 ("hugetlbfs: fix a truncation issue in hugepages parameter")
> Fixes: f9317f77a6e0 ("hugetlb: clean up potential spectre issue warnings")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  mm/hugetlb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Thank you!

I am guessing that at one time nodes were contiguous at least at boot time.
When that changed, hugetlb was not updated. :(

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

