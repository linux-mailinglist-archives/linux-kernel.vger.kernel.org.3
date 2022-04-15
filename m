Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5BF501F73
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347963AbiDOAGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347940AbiDOAGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:06:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25AFBC840
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:04:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EJsTju008887;
        Fri, 15 Apr 2022 00:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kpnIL1Dv9w12KhjOgYbgqRPZqlVQgv5G1t23XMBIM0c=;
 b=tcpsjSXpS+miE00UPmZe4iEYybd5ntp36vSP3cP8Qj8+mbQyGYy2EwZEuXEiwTJWwkMu
 Yfbxtf8GNdAMI1vYB93m2m+mREdSqzr8Q/HJDMn0aU3PAXdkGPOTpBNkiHhce6uvsVif
 AK9C8h6HvLzMoY1pcmtnD1rDIrdTzh3ReWXutXOu9Rm0R6YI4xJbElRt71JqxEqCgHb+
 bYZ2fu/ADoJch2XffA8ipLxm3xZRzR5+AcBZQWwV+48eXXBwrGrniRsu4aFj0McZGLah
 6uGSM5/Q0g+nBwA1Jemvp71ELUTRsD+eytWaYjrgpszmGbx5sMM3FDJllfcF/I/yucMU zA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2p78y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 00:03:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F01WMi018501;
        Fri, 15 Apr 2022 00:03:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k5w4fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 00:03:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCu6Ys6cA02as+7jFbbhfeovm7JFqqcR7Ya0Ynx7WZEJGIiqK2U/ssXCTgA4qCZm8u8alVGeD1ryehSVVfyvdVFXGexyz+FqmwaaWJ9WFBYqtxTncn0F+VPcjtey0WMiAdyCSs4VX1iRKAyX0c2Suy2eTOjjCNn1qnFdfwS/gKsJ9UIkmHs93PGk2U+UJdHhn0gflyG0sNhb9sgjykCAuEdLQbI5GxraivUNYA1BZuOP6HkbNHxkDDe/KLLxD3csZD0e68T5XEjeoZtF+V/F0CGyXhFC1rOz66RloRI5o2NNzDaml0YC0UjOXnMQaY8JvvCMCQRVUO5f5ABTU8UORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpnIL1Dv9w12KhjOgYbgqRPZqlVQgv5G1t23XMBIM0c=;
 b=jaVbxoQJszoylUTcxgNaVYLJKW8f79ai9dFwck9MkSHDlHo/aU9Ov5wGk+LhSywJ5qIDU26rjRijDjJAp0YxUjU0fBb4IHKlYcjFhz3iK8L6qW20xd1Wzbp5nmzesTHyUqJJTHReXI0g5kTb5o31q5yUwMUXVFYBwb4iKIFJxBFr79klfT7owWekWo7AbhItVv729yd9nF9wwDLRPJOzjPfJWPZBFzK5fcMDMxwis6wYkTJyrlcE0nICDMmF2r87DBrrk+aTwikOQu4rBUFQrNkuAVxAD9VDeqgStjBYYVbbW/5qOgyuEfSn3c23G4v50oaYL52Zh+XkND9755INQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpnIL1Dv9w12KhjOgYbgqRPZqlVQgv5G1t23XMBIM0c=;
 b=wwfZB7SfUoMzmlD6n2QQpJTHNt3oMLY+XzyFoZjCS32ZwfGvIZ8eh1Wbe31x2nmpBM7PgwNyInFBETBpnkCFmbBIODz30GKKS5riBMQhRHcMAsiqszgqzNBerbVfFLy0/ER5P1GP5our6Mbscq86qLSZbttZaQkyMBWUGYC817g=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by BYAPR10MB2952.namprd10.prod.outlook.com (2603:10b6:a03:89::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 00:03:44 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d9e:d013:c6bf:3635]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d9e:d013:c6bf:3635%2]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 00:03:44 +0000
Message-ID: <1d4610ed-d76c-f02d-5a64-7bcf77070e6a@oracle.com>
Date:   Thu, 14 Apr 2022 17:03:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] hugetlb: Clean up hugetlb_cma_reserve
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-5-liupeng256@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220413032915.251254-5-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44714edd-bd6d-4195-b6c1-08da1e73681e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2952:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2952C14B4616A4B4E890921CE2EE9@BYAPR10MB2952.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yZMJY1vhKZMcX9zx2FOBTkulbO0wZBH6maOGlTLShOw7oR9z0qnA29AAj3kjlW/4AHbfF1R3NYoPrHTxzkOjdHHYlUTT9QCBl8HjEEDK4SOpkEESmxIDRzWxSxrZ974fpzc1DwthlUQbrgLconxtmOP2NMJJUE2TbOmY37zUuKcoV0O+/OatnzGnbOJtQaEUFdbtWAr04Q0D63H22AaLurMj+Mf/NPP2gzZN7XVtFzqHZoJOv4xhSqCA0odRlPg7fMQsMKFZ0IWBOLUdrPxcNOk7bIYDmZLtI4yvk9DMuxXK5EE40hs9vMk+bpjHG8oOzKSOQKQq8KZCvN3pix1c+awithRpGu8Kdbi5bMZy/z+0nzsvckV+TTtEvWgLbqJU2lrwsAV3Sn3Z/NWCwVqFuXgD4iEO2aUIEAt6/bWbhCgl43l/S/nFB0W72KahJuyI+KZsntYWiG9inzx756z73/Mfv5XF5EAcj1Vtqq3wu8q5nvMzhWkcuv5eYAnfKl43pTWX5nwMXXh6ZlG1KdtRxPUjhxamzMxsyWUB5TurkH+aHR/0G/2r2zJiwfK7sD9Ilm2RdwO2zMVoEsbXcz4KhhtSvHk5XE5sI35k8vTxEOaxUd2d45leUzEdy/SwvzBC9mJw7WReraj5m5SLLTPaQFx1zgOpddCrtpzojTOheyDPU95NgmgGyR0JBmj0i6r3TZfwLLUCDRwSpDNXsUWvIZSydCMaFZ6z7vkhLJZhhK8fUPgfVz1hzgiq2bP8+0s43VDuS5PZmZhnVhHb9I5PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(36756003)(44832011)(66946007)(66556008)(66476007)(5660300002)(83380400001)(4744005)(8676002)(6512007)(508600001)(316002)(6486002)(8936002)(2906002)(31696002)(86362001)(53546011)(2616005)(186003)(26005)(6506007)(38350700002)(38100700002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmFWaXdKVXU4STBGR0J4azlOcm5EQnJyT003MzNGZElFeEdNSTZWdks5VTZ3?=
 =?utf-8?B?QXg2cUlIOTZnZEs0cEVuYnhXYk5zc1VkMmFxRkVEMGR6MFJEck1Qd2E0ai9t?=
 =?utf-8?B?UTZzVTNQZ3lBR1VVdEYzcHB2WVA3bGlza3VueGtlRkg2anZ1UXNnaGc4SDdy?=
 =?utf-8?B?eHd4UGFMZS9IV0gvUWg4Ui9MMHN1alM0dkVGVDF2MkRyTXVSWWx3cmNPVVFi?=
 =?utf-8?B?TktydjJtUC9XMEtaREd5S3k2YmQ0NjY3b2tmNXZST1IrZ3Rnb0haK2l6ZVVt?=
 =?utf-8?B?ZzJObEZUem13SmJCam05eGF2T2RMVzZVV0tRYTRDcjVUZmNQRG5ocVZGT0VX?=
 =?utf-8?B?dU9xSmtrT3FrQ0pKYTZLM0hjazNjOFJiNjN1VEN5QzN2Ynh6VGt5KzZTQVJE?=
 =?utf-8?B?bFBCUzZzNzhtTjFjRi9xYnZkSFpBLzlwVlhVTnRvQWpDSjNSSTEyVEZSaE8v?=
 =?utf-8?B?ZmNUcDBGRzJVWk8ycTRkSWtwenZFeHlkVkhEL3ppTTB5M3hVMEFlTWdRTmxS?=
 =?utf-8?B?ZHRYYVRYMml2VjJjSkVEYjMxSGprdG93a1NrVERhaU55QWgvTEN1STlNNmlC?=
 =?utf-8?B?L1ZnVjZsRmNaMHBEcUxXTkIwU2Y5dHF5dHpaZ3B0bkpYZUhWWklOSnNkUGFM?=
 =?utf-8?B?ZVhBOW9ETXEvbm9zMDZDNmVybGdRMnRLRFA1cThKMDFNNnJyNndNaG1LUDZo?=
 =?utf-8?B?QWFtNmM4bk8ydjcxdXRHcFM0UGZYZWl0ZXFpUURVd3duL1htaDRJTmIwL3Fo?=
 =?utf-8?B?MVJCallweDZhYUh0aVFoNU1ZYzNNMDV6eHRzZUdLV09tMjRFZURQQ3lmbmgw?=
 =?utf-8?B?cVV1RlJUL1JZbXlpVTcxbUFGK2VlZnhRMkVMK2xPa0pSMzArWWZFUTQwWTJM?=
 =?utf-8?B?Uzk2cFNMakludk8yZUpFVUllcGdrdFlGR1liaXlTeXlvTVovcVRrRElaK1Bn?=
 =?utf-8?B?K3l5cE54Z1dxd0VlWjZ0RXBNWTNveTFUNWtjZDNyVEtNV2lrdXpnRld4ZVhu?=
 =?utf-8?B?QmpyNTR0VVBZd3Z6YVd6MUE3djA5NlVadTVIeVFaWFViT256WnhRN0IvYXRv?=
 =?utf-8?B?VmhGZzZaNjlFYS9pWFIxaFptYWVSamRDMWRsVmh6VFcxYlgzVXIrcmpaRVFQ?=
 =?utf-8?B?TTlhSjdrTlJtc3E3L2htR1I0R3FrZTYzSitNV25mdHBwRU1PVXdlc1RZM1BU?=
 =?utf-8?B?bnYxRVJNazMyY2ZML2JpMWg4eDVkb3gxWXZnL2kvNnBsM2pqelNjU0ZmSUp3?=
 =?utf-8?B?c0c4d0srd2tnMUxJejdGMTBNeGdMeHBrb3U5WUZOQ3hZT3ppREI1Wm81eVlV?=
 =?utf-8?B?dFN3MnZuN1dsOUJFcG5Ob0lYYklMUUdONW5qVW1LaTVNWEx6b2NZKzdjOThL?=
 =?utf-8?B?Nm9NRUlkdERuWDdkRUNvanZTWnJWdmFnR3VNMk9qdjBhWjhGUi9XaDVFOXE0?=
 =?utf-8?B?NlppYzcwU2FTTHZLL0EzQlVyUXdnYU1FVzVKa1NvTDhpTzF0STA1WG9NNG1V?=
 =?utf-8?B?dHRVT2I5aDQ0aExSM2tscEFtTkE2QTROeXUxWFg5WkxQOWZaVFF4RlhUL09Q?=
 =?utf-8?B?cFVTT2NxbzJwSjh5RHpxYmN5dXlEOVNSMGtJMStZcFplMjVHSDhJVmI3RVN0?=
 =?utf-8?B?WHpvQ2lwOWdkSjNCWUphcW5SYmdKaTl5cVpGTCt5WkxqVDRGOXhFUW44S2NX?=
 =?utf-8?B?b2RjWmdJeEd4bC91eFBjRzFMZFRZMS9yNEdNdk84WkRiRGRSV2FSSTd6K0N0?=
 =?utf-8?B?dXBxOGNZUlVaNnVlVENreDArWVZhN1FnMG1zd0Z3NDhXcTJXcTA0MTA5VFJO?=
 =?utf-8?B?VXNva1hIbWM4OTE2WmNsZHorWkxGd3U3TTVCTVZyVTVWRFptNXBnamdLRG9Z?=
 =?utf-8?B?SUhqUGJSRFVJSSsxZHQyc1RCM1ZDcnMyKzZSN0RXN1h4cnZOS3AyRXpucEhm?=
 =?utf-8?B?ZmNPVEp5ZHpEWUYvSTJUK0xEekJaR0l2dTJPblgyWWVRaHEwTWsvTWZYVGxQ?=
 =?utf-8?B?UW9mT0hnUG1TNzNwMXNKakpuYjZsUDllK1NXMzNibmRSanRBWUlvRHBISFBr?=
 =?utf-8?B?T09oRld1N09rdlF6YWtwSWI0TFRqUEZ2T216MHRiV2h1TUZTU2V1djcyV0hl?=
 =?utf-8?B?eDBiSTBFVW5YUjJSamg4WXoyV283V1FmRjJDOXZpdC85RnVPOTYzZTFXM2Zw?=
 =?utf-8?B?enZHMkkwWXlkS1BBZzNLZmEwcm5uaXpzbHFPZWNubzlQVU82Wm5yaTMxQTBZ?=
 =?utf-8?B?TFUrODRLZ2VtaE1jRTdZTzNBQnU4RXI2R09OdWQ0ZXZnOVNRZjZCcTFKVDVm?=
 =?utf-8?B?M0dQbUwwQmk2ZnNYT0J2U1NlMVU0TkY1RU16dUtuUVJmSVZhNnVFSFREMjFW?=
 =?utf-8?Q?TWW5fuZ3wlfOU/5o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44714edd-bd6d-4195-b6c1-08da1e73681e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 00:03:44.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9b3cuHe2TUVMBBfb67vvI6TCWx2+3vRllpNk1zFVWgIPn7EXclKQkGoEFA4EULuYMqwbFkGZ+VVc2OWHiv5TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2952
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140126
X-Proofpoint-ORIG-GUID: jzsRu8F8-v0dhjEN7J-kTUqrorz3zDTt
X-Proofpoint-GUID: jzsRu8F8-v0dhjEN7J-kTUqrorz3zDTt
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
> Use more generic functions to deal with issues related to online
> nodes. The changes will make the code simplified.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thank you!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
