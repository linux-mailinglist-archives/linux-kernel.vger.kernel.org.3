Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B58E51034F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348348AbiDZQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiDZQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:32:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ECE16A5F2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:28:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QG24Xb003733;
        Tue, 26 Apr 2022 16:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TkWBVdNJ19Iu3vckw7BdQR5eju7SqSwT5X0cvuTIU/o=;
 b=EECV5fI8sVlKX6V9ujnp0btZ5DiZiU1/XKB/qFIMPSrJx827jv/OucPntBs7QMo1XBJd
 vqe8iTB2oBtX7STlTb0k77ZgI68gHPJ0nsB+VkFwFGZsiCb7CUwX12Jv+o1IWOjtOIzg
 t8+wCOXHvcm/ebVKhxKTnYj1Gl8Xo593BywNEQFUBhuwm5Lf19xIqdFECSbXy9xhtwDm
 lDem6htZ5TQC4SCyAM3jy1Ky3D4fnahQFXcF4FQ7/rqZV7K8jpnBowYOQQUys4Vm8IfU
 +Pe82ycOaMvnhWHV91Xr6x/f9m+FH45/aVr9Bkx/V/QqlQVm+sGmt8xDNgn0MDFQtcQK sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4perd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 16:28:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QGH6hl022607;
        Tue, 26 Apr 2022 16:28:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3j4qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 16:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h34HCiNfNA6mdZxoH4rRUR5mkBu6y1wN46N6dScnmQzdjsVc3Li9LzZHFh6zi/Yh3R+3xiNZmQdbsHH1WQC2Zyiob4rIL7zVHxPWR3Me24ckFTzbKEkwpGCaDsvl0IzBWNcPRNLuxg3rqQLweLl8l0GsRzdHh1ggDrgLEgk8aJPxH53mJSUSs0rBjj4Ba4yyyWYQZdR/8EZYbjJyYOcmd461KZrLHUMhXOQ3ALqIYkKmR8MVezaiL4hPfhVRHM5HaSZK73DRfy5I/x5RjNuqtZxUmacEdtZRHBzFBFV7HV8+snNpTqla91+wnp5dsOaiuUIyV7XbikLAyc/4a7vtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkWBVdNJ19Iu3vckw7BdQR5eju7SqSwT5X0cvuTIU/o=;
 b=RZgxSeG2SNr7szTR0RBQfqiRvDFpjIsvbL4I3UUcKLj4QN4IdUrXvSHuKzCh+bubJt/7IW40aQDFw+ivyvb7PfJwacXELddPiii2Oqq4zndImSsRfzjDL2EdbkwdcLolqCkUrjo+sjYRrJwWnhcex6CtXCDtZpCudMxkJqx0EuIIIomRQgkVXpA4kkXZWSl4g2VJdS+05dd/ll+cqXE5+HBJeVb5wH7v4+rdGLRJ8giYTbTd/GaM4ecA+hiOSsdQj3zJeIb4b35hKkc1oyocCm9xeABqDQZ726tNjYkUZDzLRKcoH/b2MHM/LoB/l2HQv2sXyYzn51nz8iePhNi5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkWBVdNJ19Iu3vckw7BdQR5eju7SqSwT5X0cvuTIU/o=;
 b=Ogz+MS5HR357fEwQRedZaBZI7pwPL2u7x9Arp7e2cWYscUgotw8ab5O8UWJapEp+BPFA8tzCepiB5EHwozKEv6ZCSVC2OfALZ1eIrbRCxEDGxPkjxq5ueiKbwnpg6kDr7kNuZ7ok8FgmGoF+ugqLud5cVElwbvv94Ld1hHWsbI8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4050.namprd10.prod.outlook.com (2603:10b6:a03:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 16:28:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 16:28:43 +0000
Message-ID: <e403764f-cdd3-2ed5-4f79-fc6ace6dcd99@oracle.com>
Date:   Tue, 26 Apr 2022 09:28:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] mm: rmap: Move the cache flushing to the correct
 place for hugetlb PMD sharing
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1650810915.git.baolin.wang@linux.alibaba.com>
 <f5e3b77c5a4c646e000ffadbf6c3db0531a01795.1650810915.git.baolin.wang@linux.alibaba.com>
 <064da3bb-5b4b-7332-a722-c5a541128705@oracle.com>
 <82632a98-e7e8-cf04-ea5c-f8c804184af8@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <82632a98-e7e8-cf04-ea5c-f8c804184af8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:303:85::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96bf128d-db23-4940-f8c6-08da27a1d458
X-MS-TrafficTypeDiagnostic: BY5PR10MB4050:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB40500E17AA13ECBB05B80C4CE2FB9@BY5PR10MB4050.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMzB1KwbQUbqAfXpvrZFWJQpU6uTm1ggNpl35AUz8hr197bKxQXLlplhicdsllEmf85tb9RIS0FAFMnKMwkj4zlrCXjR4w+QsGVBr4CyZgs/EAe5EeGTq4mCAcwD25u9ShsV8YlpfB5Or2tXrcuh2fdvSSL/Ol0N597HzXQw1SCnR4oirG58fQhMRnf9YQO3LbJa4RZlZM3+r8S+h/UDQvU+eUZ0v6QAJ4G5kMENFw6OjNIeUehzwnHyQdilQIx0Dp71pFnj0cfkFZV7pLeqdgPl0sou/AvnEpIb4BbGctb9M8pZY8CUkQF7cEndpD59o9ej9OyJLjVF66Es6jP42M4LMJHzsxHPCzlYX/GplDH2CcaAD8VZ9WZORGWn3vCI2Eka/DibhfmwwoLc08e0IT1Xx+0vSWt/D2xLZta6nxH/IX8bCSXo6iN3W0U1hzPyVJErvz/PVJeksDUDPHKelLneT4hn+k0KdNXJCfgzSeGI7khtNQVANpJtXLHTJuMOHPWk5YZ/N4Q1Dzy5goKPokxYtarfYbX7zavO45S0kFq+bWkg3sQASCpMrpLf6wN/yWQFsusINDr+663BkzMS9SEoTixSxga0WI4nxIk8pOtYjGzKu8c4tq658V0z1bn329856HqLCoGO/tEW3CE+P798eoIqPsbDQLhWhQ0muIUh4Wq5AcOfA6TA1Bt3uEc+b4qwrE3k2Fq4TOKqJtJxmnDWgaHfqu8ROTGUSmwksnPxjgyAX+2xwb3YeB/X2gdjvduyFiHbFAdL8O+GhjnsLLFFtyHdgRkFr/k0SsivN9Lst88JruJ+9VkwMNHB82ikwLf7w6Kv/+HMEM/olWaMPNIMnAKHYT0uBg5e07sdNWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38350700002)(86362001)(26005)(6512007)(966005)(31696002)(316002)(8676002)(66946007)(66476007)(66556008)(4326008)(2906002)(508600001)(52116002)(6506007)(5660300002)(8936002)(53546011)(6486002)(36756003)(44832011)(2616005)(186003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWtkVHJIN3NrVWV1QTZSdEh5K25nWVdHNU85d2EvWEphSm4rRkxoWE8yOFp5?=
 =?utf-8?B?KzR5c3VQTDFDdll0aEJVNHN5RlpPZVFMRlhUUWRHTEx3RTBmM3I5S254MktG?=
 =?utf-8?B?ZDVUU1M1UnpZSXQ4YmlXZWV6SGtwQ0YyMCtRb3ZWZnNzYWtKcDFURG5UU1dp?=
 =?utf-8?B?NXkrK3FmR2daWU5FM3haeFphQ2wwQUxIMFJtQUFmbE1vb3pLYW9mUktJWmRr?=
 =?utf-8?B?OUJqdUZjOEZKR3ZXMTZweGVIRzRUb1k5dVdBbDRKVEF4QmtxblBrbWpMTytQ?=
 =?utf-8?B?WGlBVFhDanlTN1JjeWJIWlZmSWdSWk45MUxvTWRNTGM2MlhsNzJRVjY2SlJN?=
 =?utf-8?B?RHpSUjFWWmZCaFFjZUwwYVhocktUUTdqYWI2TG4vMWRYVUtUeUZGdm5zT3V1?=
 =?utf-8?B?Q3A3ZUV3S21VVjFUS2NsOVhzSVF5cjYzV25uYTZYdHdQYmNmMUpwWk1Hclpz?=
 =?utf-8?B?cjBOSmxhZ0VwTmduRUFnL1FOSktmYzNFR1d4ZTlXRW9qMTB0R1VTWTI4V2Fk?=
 =?utf-8?B?YTNEVGN5azF5WUhIOW5FVWFxYTBhTW1QSTFOQm14NlkwNDltMkZhcmVLK2J5?=
 =?utf-8?B?dGxWYTlINjJwQ0h2VUlBTkVIeEZPRXFPMyt0cDNQQ0JpZ0Y5VTNuTDM1UmIx?=
 =?utf-8?B?U0Qvd2ErKzhHbFVxKzlJYmYyVkpmVzBVZ3V0L0RQcGtidW8ydjZqbHU1YlNh?=
 =?utf-8?B?YkhETTQyVnk1SXB6QXZVQjhtdENWSUdkMnpsQkdSWjl3NEgyZmpFdVA4VDZO?=
 =?utf-8?B?ZFFFVGlwRExXeVo1ZFBsWXZHNFE1U1Uza3pUMmJwL0U5b29pTlJDWis3OVBa?=
 =?utf-8?B?UDFOSk04U21IVDhJVmNCcHJhZ0lVU0xUVXJrS24vNXRDenI3eVdBTWFmMmNj?=
 =?utf-8?B?ZENQWVd3TkpHaTQzUFRybjg5dkZPUmkwTlRSdU44OExkUm1IREhzN05TVnB6?=
 =?utf-8?B?YkQrUVpKV28yOUFVUm1xaXA0TDQ4ZThwZ2srMHJkVENKYWtxRVVPaHRBa05w?=
 =?utf-8?B?U3VhTUU1U3RVTlNqK08zTk93bzlJWXJTckUvTzYrTURneDZDUHJ2TStuVE0x?=
 =?utf-8?B?UENIRjhpOFFxTWU3T1VSdnRCcVcyY3Jma3pvWmFLd0pxSitJYlVpb1Nhd2JN?=
 =?utf-8?B?VHMrNmt0VjUrbHVkeWNDTnhTbnJFK3JaRVQ2UWp0eGJoQU9DNW1paU4xWktZ?=
 =?utf-8?B?ZUQ3b3Z4WVE5cmRZK1JsUE5PLzRjL2tTaXVkNTdKbDBQVHNVdUtvNWhPc0hT?=
 =?utf-8?B?R0JMTWFvR0hiRllEZUkyd0dOSGNWN2tIeGhhOGFqdUU1d3ZTUHBoOEpxK24w?=
 =?utf-8?B?WmRZbS85Tmd0VnJDcmhwbkRQR25VL3BLdWtGOTNzWUUydXd2UjhDRHVWL08y?=
 =?utf-8?B?MkQxMWpTeTlNR0FUd0VlRjlZNTJ2SEg2Q0VpOEFGYlZWSkZrOGhpOVAzamNB?=
 =?utf-8?B?Z0RjRk8yM3ArVUg1R0ZpeUxQTzdVczlXU0RrODkwdHJaODljUis3ZU1JVFNF?=
 =?utf-8?B?SG95VmdjWDdGQ0xPcjY5WjJSMFhtQlNCVGN4d0hzRGh5dllqczFXSTlFY0ZT?=
 =?utf-8?B?bmsvN0t1M09ydEplK1Z0b2d6WUFVM2pQNVlPVmsyQVREVnUwRGRFQWtudTlM?=
 =?utf-8?B?cDhMQkFxV0xFRXJ1SUgzZHN6dXRWbXg2dll1TEZzcDIwZE9WMCt0czJTa0Y3?=
 =?utf-8?B?R2VBOXlNeERhL0tSWFdQM05uQlYyVmxtVlBGRHN4ZG8zRHlXTktwMWhYdWlm?=
 =?utf-8?B?bjhZNllxVkNwb0dZOE8ya1VUd0NOcEtiY3AxRWZqYVBWOXZuOW9wYTVEbmNh?=
 =?utf-8?B?SGFNL1VpN2VtdVFRYmNpZlhzVXlnQnA5a3ZaeHBZVHVoUDQwUWVtTE5EUEpB?=
 =?utf-8?B?ZDBHMUszdDVlVUxOQ0N6S1hGM1VZM1AzbHoweUt2UkV0SG4zOHNWcU81eitL?=
 =?utf-8?B?K0NjK2VwTDBFMEI2SDdqVlMvY3dIMjVtZ2h1Y1ltZjVMMkpCNCtQVHdEMmxo?=
 =?utf-8?B?RTk3M3F4d0tnZjZOcGV0d1VHMzhmVTNwbXZYSTIxNzhTcTJiSmZHcWNSVTNL?=
 =?utf-8?B?dDh6bnBUV2VLSWVOdGVKZG5Fc3RqT2pHaWZERmFJSXF1NGFBZUpKMnBPeUN5?=
 =?utf-8?B?UnNUbFQ3K0RGdi9BbkU2dU1FNUYrdm9GRGZkbGxLUkZUZVBaQmI0SzJRYWhn?=
 =?utf-8?B?SnpKRmRmNkRoSUlCWHB4UUFialBGczV4WVAvV0FyZXlNbERCSUlQS3Q2QkdV?=
 =?utf-8?B?QVV5T0tLQXRFemdwZnNGalJQbFRsd25pZEdhRWd5a2hUNkxLSm51cmFwTnpO?=
 =?utf-8?B?ek0zdVBJbU9nRkxnVW9zWjBWc1NIUUo0c290STFNeE1WY2t0bG5ETVF6SEhz?=
 =?utf-8?Q?Dr6FPpSVmP0a5t/A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bf128d-db23-4940-f8c6-08da27a1d458
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 16:28:43.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PorYdwsF/uER3xKCF45Xmpax3fKlw1YkVCpEGQ+aMpp3Si1ioGLiM6Ci0Rpl+wUkGljMRn++amnlRUtoRUj6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4050
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260104
X-Proofpoint-ORIG-GUID: Dp1RyFEkyk17fyTWNXjgtDvZo69c4uUN
X-Proofpoint-GUID: Dp1RyFEkyk17fyTWNXjgtDvZo69c4uUN
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 23:26, Baolin Wang wrote:
> 
> 
> On 4/26/2022 8:20 AM, Mike Kravetz wrote:
>> On 4/24/22 07:50, Baolin Wang wrote:
>>> The cache level flush will always be first when changing an existing
>>> virtual–>physical mapping to a new value, since this allows us to
>>> properly handle systems whose caches are strict and require a
>>> virtual–>physical translation to exist for a virtual address. So we
>>> should move the cache flushing before huge_pmd_unshare().
>>>
>>> As Muchun pointed out[1], now the architectures whose supporting hugetlb
>>> PMD sharing have no cache flush issues in practice. But I think we
>>> should still follow the cache/TLB flushing rules when changing a valid
>>> virtual address mapping in case of potential issues in future.
>>>
>>> [1] https://lore.kernel.org/all/YmT%2F%2FhuUbFX+KHcy@FVFYT0MHHV2J.usts.net/
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   mm/rmap.c | 40 ++++++++++++++++++++++------------------
>>>   1 file changed, 22 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 61e63db..81872bb 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1535,15 +1535,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>                * do this outside rmap routines.
>>>                */
>>>               VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>>> +            /*
>>> +             * huge_pmd_unshare unmapped an entire PMD page.
>>
>> Perhaps update this comment to say that huge_pmd_unshare 'may' unmap
>> an entire PMD page?
> 
> Sure, will do.
> 
>>
>>> +             * There is no way of knowing exactly which PMDs may
>>> +             * be cached for this mm, so we must flush them all.
>>> +             * start/end were already adjusted above to cover this
>>> +             * range.
>>> +             */
>>> +            flush_cache_range(vma, range.start, range.end);
>>> +
>>>               if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
>>> -                /*
>>> -                 * huge_pmd_unshare unmapped an entire PMD
>>> -                 * page.  There is no way of knowing exactly
>>> -                 * which PMDs may be cached for this mm, so
>>> -                 * we must flush them all.  start/end were
>>> -                 * already adjusted above to cover this range.
>>> -                 */
>>> -                flush_cache_range(vma, range.start, range.end);
>>>                   flush_tlb_range(vma, range.start, range.end);
>>>                   mmu_notifier_invalidate_range(mm, range.start,
>>>                                     range.end);
>>> @@ -1560,13 +1561,14 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>                   page_vma_mapped_walk_done(&pvmw);
>>>                   break;
>>>               }
>>> +        } else {
>>> +            flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>>
>> I know this call to flush_cache_page() existed before your change.  But, when
>> looking at this now I wonder how hugetlb pages are handled?  Are there any
>> versions of flush_cache_page() that take page size into account?
> 
> Thanks for reminding. I checked the flush_cache_page() implementation on some architectures (like arm32), they did not consider the hugetlb pages, so I think we may miss flushing the whole cache for hguetlb pages on some architectures.
> 
> With this patch, we can mitigate this issue, since we change to use flush_cache_range() to cover the possible range to flush cache for hugetlb pages. Bur for anon hugetlb pages, we should also convert to use
> flush_cache_range() instead. I think we can do this conversion in a separate patch set with checking all the places, where using flush_cache_page() to flush cache for hugetlb pages. How do you think?

Yes, I am OK with that approach.

-- 
Mike Kravetz
