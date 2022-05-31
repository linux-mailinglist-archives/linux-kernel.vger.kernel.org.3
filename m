Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C1539A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348716AbiEaX6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiEaX6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:58:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D6340F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:58:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VNmimB014828;
        Tue, 31 May 2022 23:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Gkz8fO1FK7716a0BE37NZYPY6DINeJZ9n8jJpj5J55U=;
 b=hxj2I+oSh0ml9US32rs9QeGTVyCfXuLLhsY46Zo4vHrQP0wGoRW0PfjYjGl5U6kfKyFa
 ChJoq9Nd8vAUq0L4zbhDsCHI7QE4cLpOgLiPkZpLMyonl3Am/ry6W2GR7DzPO/2XiHfF
 kJa1rapb4dkewA5ZUqegFFr0Jj4aQNQE8HbK93a43cUuuxabtwTptRvg40FzHXKDe4ZJ
 mXFtjkZcCKEiYsl2pq1N20Syw/c7PhaemVnhUi040nmu1YtAJ8PKkBphu8HdV0LqW6NC
 R3JNjb3510GLdj4YrfCeI4BvQKlj75tvEDuFYPDMeyEcrbpvV7xYPoPbNFkVhOARVB44 XA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm63r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 23:58:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VNtu5Y015775;
        Tue, 31 May 2022 23:58:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8ht4knj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 23:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD+ospk+T0T+RPmxH6rW4E/8W+/4W07cJ66iIo3qXE+x7hhASLNeKcEpmZ4ZjX5GwDAuNWr2p0/4nXNmM3W5qPB4o8bwwrNtqWOdN9iL1pJIhHY9DDF369zzb5rXQYeKPTB07+dKYoKR79BwwH3vKHAAXFhXjaSISX85LB8bUZ8wJJCr+vNXbX9OkLpIlj1C/s9oML6L/M4xmlo/Q5y95GqzKF4KnzjuHJ4AMQZN8RxXvlxL8drqTJ7Z9bJ66UTMfL0A6kFrfDV0EiXWJT1spZ+DbeY8/pwMzN66IcfH7IZ/+Rx5xU2FczPDFyiOXEoMR4KoagYqDpcxBhl/Oj6EGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gkz8fO1FK7716a0BE37NZYPY6DINeJZ9n8jJpj5J55U=;
 b=bZmCLNuEZj7gNJW7vTBHdFsh9nCo+pFRGxQXaa4dYsncGAuktFYT7fdwdPnNQzOqQMvVAIT2uLtUPjmDAl+Y8z/oUEE6KwrrX5Mjh4xu+Y4OvJXqWJUkKrTFbiEVc4VhTqLigSOVOvH1SCwa5ae9ABnRGQkB9whIiIAmNszP4Uttj2VqUOTXhEt9RT8xJuqk/ZCKCACgXZOy7KLz9TJQ6TyWKLm+6OCm/qzeuqfIu2uw4zU0PJf6bPmOopCUyhmy9ySbBCPRwyC0luarPbKNj3Gwuo2q1ctfALMJpSOb+vpaL84DXi0gS0//lWyORpyunuljsRX1cmbz65b8y7+9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkz8fO1FK7716a0BE37NZYPY6DINeJZ9n8jJpj5J55U=;
 b=kSvALdEWQrjuovv4o79EmaT1yiTx4YApSUI94lgc4wq1xlws3X9gGkGXYXy85o3XTHSmPsnBIVCkj5PJ5dWkLaYv/Cp8JcXBGDkgwN/DqLAkv/F7s08lSFOZG/9CecQ8VdVlVSGqw+N2MbRax+F1ZSKtFkrJVmh/Ghwvlv8dcOk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5065.namprd10.prod.outlook.com (2603:10b6:610:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 23:58:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 23:58:25 +0000
Message-ID: <09b60548-0495-5365-2bf7-97cc597100ac@oracle.com>
Date:   Tue, 31 May 2022 16:58:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] mm: hugetlb_vmemmap: cleanup hugetlb_vmemmap related
 functions
Content-Language: en-US
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-2-songmuchun@bytedance.com>
 <ec5eefa2-03f7-5f2e-bd99-24c3ab76a0b4@oracle.com>
In-Reply-To: <ec5eefa2-03f7-5f2e-bd99-24c3ab76a0b4@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0324.namprd04.prod.outlook.com
 (2603:10b6:303:82::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e51e8708-9fe0-4f9d-fb2b-08da4361739f
X-MS-TrafficTypeDiagnostic: CH0PR10MB5065:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5065537FA4BF3445D757B672E2DC9@CH0PR10MB5065.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aN10C1fqRIGDpE1MqUpwxKJkQ3fJNZD0j/96WylWx1t7HN86S0xg09cMzFrdppMp/z3QnIBVjMQB5qnd5ACKyjCLhoG/ykQNJG0xYHUdcs6wlUNKWqyXnQQ5R4KRym0ZPY9vSwSWyFKfU7HGZIWWODNspRi/tBHEytmJDvF0S1IOjujlwbZIggYMQpli1zJ3NQYYK2sXCgF8ZLD2fYZqriglUMIYltYMy/1Yj06PNG5gmIkW+7qn+1N2vw+v4sAGzuo7RnB2o6hYiPvaNFmw43vb0CElFSJJwsGW/UHbwoN2bHqidtBiS+4oLawGY7ma4OOWJeXeRTMc5K+SXhFymhEc4LaWqMt5qpZoIZ1uAe6wiVPnaAqyHjvtHhcmiGZeBsjTmMOfFijNBSQxANFXuYUEfyOTC0Mg091pcZvXFiMjyAYyvRF/GoUNWY6gLTt9c4UbVbdJAXI/5nri6zJi0ZoplOhJWIFbSqmWASs71Fg/FCcy6JiV+Dvz0WZW3vbUWppKt23K7PCZp4UKZNKb8RhIXWO23NzmfP0s3Wv53WQgGHzQJuNs8V9mxecsq9JF/tnctrUKPscXJOLAsxaXW5XVwrjHnzYeX1Gb/GwvytCoHBOJbDsQ9gEy22of+3PtF6wD7BDkfbXzo/k5whpC5JeDAMq0mgF+xkxhepbARH6nW1O1+l+q5JU7ytu6eji3dbwk5DonXx6ilThQHbPxjBu00WRrEIYIzO1HgqGOPYncUFQQHjlj5QQBtbswyQU2iBzgrXNoKgiyJgAVFANolw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(86362001)(5660300002)(38100700002)(66556008)(44832011)(66476007)(8676002)(4326008)(8936002)(66946007)(2616005)(31696002)(4744005)(186003)(508600001)(6486002)(26005)(6512007)(53546011)(52116002)(31686004)(2906002)(316002)(6506007)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEFNdTdlWUk4OGh6ZndzajBISzVkMGYwb0dCRVN1VkdZcTBXRndnQ1FuMHdJ?=
 =?utf-8?B?K1RicG43UTh6R0hSd1pQeElLbW1hQjE1WUVJaWZ2WW9GKy8xSDYrRUdLd0wv?=
 =?utf-8?B?OEZaNEc3MlpReEt5ZU9iM0dxSVZraGVYL0o3dDk1eW1PS0J3NUhsaE8zNVR5?=
 =?utf-8?B?NWxhWFRzMzdQRk8vRVpOcUtvMUQ2Ny95VC9EK2lYZE5qVkhKemVOcjhYWnJW?=
 =?utf-8?B?bk5qSjFTRUdXTnliOHo4UEhaMldrdTdmS2FiQ1hyZkV4eUFVZEhjMmU2NXZV?=
 =?utf-8?B?czBxRDcxaGVkRGw5N1kvb1VXZ3RQTkZuSjN1QlV0VXhtWTF5VUVWQmtWQ1Zi?=
 =?utf-8?B?QjEyR013UzRBSXRaNkVTM3pDWW1qUzRDQkViRXc5K3lCbHdNOHZXOTcrNnJQ?=
 =?utf-8?B?VlhxY1Z3US9iUldHYndBc2Uxc2RZeERIVXR5UVNXRWdRVmxoR3k5TWRBdjE4?=
 =?utf-8?B?MTdSY3crR2E1dlp3aWtEYUl6WEtsLzE0b2JYdmNuT2U4ZGlvbUZHNVNBUXRB?=
 =?utf-8?B?Mmh4b3cyTklEQ2RUc0FEanF6ZnVTTmZGZnRhbUE5M3FqRGtBRVpmZzhQcFdi?=
 =?utf-8?B?TFBELzZVM3luTnVKcDNFNmZvRXhqam1ENUJHNm1oNm1TOEo1bnNLeXNBMkFB?=
 =?utf-8?B?N1d3RURhY0tDa1VFd2xRa0gxSTl1OWpIQTc2MFBLNmRmZ0FTQS90dWRPOXI0?=
 =?utf-8?B?ak1oTFA0ODFYT05XUG1QK21JT3o2NGRyTjJjMS9TdnZwczhFdnJPYWFpRnA5?=
 =?utf-8?B?aTk4VkZSajQ1Z1c3RGJqWlR5VUZVTnRtQXJQc0lYS21ka3VJTnRTSHBzcnBq?=
 =?utf-8?B?anJlZ0VrVmtkVjV6UXZlY1N2UTNsVjBaY25uQnNtRjNQSkJiQ0gwYnZJdmNk?=
 =?utf-8?B?ZEVvbFp3ZHFtdXJ4VTdqZ0tKdmd4SWxCVHdZekhBZE1xWk9LNSt4cFdIWVJY?=
 =?utf-8?B?Rms1bncwSVhtcUZXYkhWUVhnaFhXcExOYUQ2L3ZGNnFCNnZVMlVlUlh5SHJD?=
 =?utf-8?B?NkZzaEpwc0V2Y1U3M3puUnFGbkZMbDhBRlM1MS9kQjNqeWdUaFhnTzhmYURG?=
 =?utf-8?B?SFRoYkhxTUpoZ08rREhock1kRUlFNTdiYmg5alRjZ3JOUmpUbkg0YjFnYUd3?=
 =?utf-8?B?RjZWUmdweFJUd3I2di8wOE52dlVLK045bVM2b0tFN3Ywdjd1am9tTkdrZTk2?=
 =?utf-8?B?UWF1OXZwQllCR1pUQWpkS00vaEdFdGV6dGdCRUc0SndQZTU5TWJMNW5lRlMy?=
 =?utf-8?B?eXExdDMrWXZJaDd4Yzk1SkZiZmNPeVFYd1cyN0ZWdkVYMjJHT0FTc0ZjdjhD?=
 =?utf-8?B?TkFOcHYxdlI1dnMwRTk2NTIvNkJ4RkJ4b3lPZUNhOHU0aHR4QXFVcEJWTVYz?=
 =?utf-8?B?MHh5US9GOHFrLy9sK0tQeW90UkFGYnFPK0VjejIzSmFzRmhLejNYQWpNeTl0?=
 =?utf-8?B?NU9OMFFZaXQ3eTA4TDJ2Yy8zdUlrTGtNNVFaeXEwQUdWZXpmQ1BVV0t2WEp0?=
 =?utf-8?B?TVBaa01jUE9iRFdkUzRBTGJ3WnozZXlFckdoUzFvWnFuK2JVWWlPZTF1ditR?=
 =?utf-8?B?MmNSUHhKNjBhalUrNkRYVTZTSHM2MEl4OEJaQ0w2d2dvZmhvajUyV0x2OGJr?=
 =?utf-8?B?UkxHOC9XZTliMG1jZXhRYnFEYWd4WFFJeEpOMW93a2RPTmdVcys4dUFac21t?=
 =?utf-8?B?WTZ5TEtPN3EveVMyWCsxMC93QzdkaFNXN254TlZuM0QzdE9sMlNxNk05MmlL?=
 =?utf-8?B?ajExVmNlTGd0bTNTVWFMZVZobkpxd25adzU4MDBGZFlRZktxT1B6TVRZREFX?=
 =?utf-8?B?WFZhc1l3ZHNYbG9SZXNrU3NrS3BVOWsvV2tJekhWR2tGNS9GM1dKTnlBeEw1?=
 =?utf-8?B?SHpMcVhXTENFSGFpTGhEKy82MTlyMkdRSjJmdVNaQUZoK1hiL3hSOFRyM2F5?=
 =?utf-8?B?ZzJ5RGxBMEdHY0dOQVY3Vy9ZSWIraFU4WUpnYitsQUJwNVpRMk4zNFBubm9l?=
 =?utf-8?B?aEdwQURFNkRVTmFTbWFOWHljaG1Kd0NIVlFiU2JXek5qMThoQ09kaFNmbDkw?=
 =?utf-8?B?RzNULy9EbVZENnh3MkdaSWRJejRYYXcxdHNCVlpjUWx0N3pMckNBYmZPM0tu?=
 =?utf-8?B?NTRDd2dOcmJZUVVQRkV3YkRRcFNjS3UzcjZWNkJuVUZGL3lTT0lEd1FRRFNI?=
 =?utf-8?B?L3lwdDQwc1NqM1lsVmtGYmgycTNHRUlWd0lPRjFkbTFvc2RKbmRFcnpKVVpU?=
 =?utf-8?B?UWduT20xaWlmNUFYcEVpOFlkZjNrWkM2Z1lpa05PVzlHRmdFd2RQbVl1cjVo?=
 =?utf-8?B?T3UvLzhFS2RDRTV0aVR5RFlIK0ZQYWdMZGtnMllSOGUwK2QydjZEWUVQNU9v?=
 =?utf-8?Q?JJ78EbA+hYVDxJC4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51e8708-9fe0-4f9d-fb2b-08da4361739f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:58:25.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2hjPDnxRdob5vX1BL59ZExsfnkfuPwmBLZbVEPvc21IhHZJMnFbdcoBb9ErF7rwmEHP+nBpvWzG/YwIo3CfJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5065
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=909 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310103
X-Proofpoint-GUID: MGsiYV9VTyFaNdF11nL5QQVi8T-e4Wrz
X-Proofpoint-ORIG-GUID: MGsiYV9VTyFaNdF11nL5QQVi8T-e4Wrz
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 16:47, Mike Kravetz wrote:
> On 4/4/22 00:46, Muchun Song wrote:
>> The word of "free" is not expressive enough to express the feature of optimizing
>> vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
>> And some function names are prefixed with "huge_page" instead of "hugetlb", it is
>> easily to be confused with THP.  In this patch , cheanup related functions to make
>> code more clear and expressive.
> 
> Some typos in the commit message.  Might be better as:
> 
> The keyword "free" is not expressive enough to describe the feature of optimizing vmemmap pages associated with each HugeTLB page.  Rename the
> keyword to "optimize".
> 
> Some function names are prefixed with "huge_page" instead of "hugetlb".  These can easily be confused with THP.  Change function names to make
> code more clear and expressive.
> 

Sorry for the long lines :(

-- 
Mike Kravetz
