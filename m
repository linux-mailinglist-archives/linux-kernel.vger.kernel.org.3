Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9150BD3F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449774AbiDVQlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449755AbiDVQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:41:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604395F268
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:38:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MGb3tQ013493;
        Fri, 22 Apr 2022 16:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9Dh9m4dRXnjgFlbU+Vvi1NYJaq0yb86t6jHcYKItQsM=;
 b=aMBBR/ORybHCyxCVjt3oJdI12b1hc5YT5I7oxBgD03VGDftEbnz0HF3U1wpQe0TDOMPF
 6GU9l5MO25Oa136HJcgHoPYTelShwYtTsnQfBL+MVnnboF1GLSmyxUHm0ikZBLHflQRz
 fSuhc3dnzTqpQ865K79qmFcg67II95msWDUUXpD+CFj6SIFTH6lMKNciyrOjCMYOGehr
 fW2+xouV0GfZZeRtEZ8gK7OxQuSa34jtenZtfVPeOdiZ8Iylfip9lB8WMODD+e1MIBDf
 3LBHTtTupvyLVcClix4JNJ+kQEQ2ZuAlFGGhclKsCwupG0TYsCxu6swQwj8AVOM+hg3o 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndtq8vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 16:38:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MGAKi3036754;
        Fri, 22 Apr 2022 16:38:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8dwpgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 16:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYyKGyX02d0YL7ZU8BnszMt+QYFOh4L4PnVwLDpBXlfVmEAySXX6nqeFzSVwJU+RjEmkq5tztoDdpnLrc0PA8JJB3lGpMgp3U4bZTI5htYF/WeujqTicXlRb6hpx64bO9Uis0HYKFUwd5TLcvelRhaGCKRAE4F4Eo0/eoW3TvFlrqRzO1lghFbT2B9gLhefggSact9Immp3S0H387lEhzXxVnMCP5H0X0eTfhVh86I5yvem7+h4zM/k1idxCzeHCMVDlU+fraG/dluK1hGwh/qJAuNArw+dYbbyifwVookj8vIW2H/0NrPbpA/zEbTVmBcbPJZ1qnQq/u2RVWRoecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Dh9m4dRXnjgFlbU+Vvi1NYJaq0yb86t6jHcYKItQsM=;
 b=ftF/gr+Lbq0Qyy95PNJiTAkK47V9+G+DD0Kwe2yIWXJsToWp27UaM0ShfCnuNPQHCiZvEi0BidLX3yJn7hc2cZL7YFVp17Ns7b0VbWcpoiHDT0PduCB/7aqmLf77YaR3SbkNC8CR8vQhdTMw2jNXtfzeRiDQxqGRN2BzYX52R/211h4HoisUFFvAbI1zUgg35OMgDpTKEIYa6zTHHjxGPWTF3NeTu9gCJiZSRaOHKn4ecNQhCrtfz83P/lG2LpMVqDiHU+Ft9onKE+/hTlhNvf5uxQAS3sjy12eeFca/yxX8uM6NC2iUheaISf5ekx23fBSK+Sy/QHTxJWVOgyVY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Dh9m4dRXnjgFlbU+Vvi1NYJaq0yb86t6jHcYKItQsM=;
 b=YOrLAPP1oN7fUMXpf25S0mQ22WgquR4fGBJOPfw5fB7auYYVqWpi4UciggqujMrHzBcbRf8So1RcYF53G38fNwuizrfClTVB472W6zBFpaV98iiUdj9+vGY8v6aBPK5uIrp5q8YvtoiEPwfhbHQ/eyGg0Z7reO/9NY8EDI2vfug=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5335.namprd10.prod.outlook.com (2603:10b6:408:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 16:38:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 16:38:36 +0000
Message-ID: <cc4e1412-e439-6359-b80f-5c51ff6952aa@oracle.com>
Date:   Fri, 22 Apr 2022 09:38:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH v2 0/6] hugetlb: Change huge pmd sharing
 synchronization again
Content-Language: en-US
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220420223753.386645-1-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220420223753.386645-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e71f5ad-1395-406f-7ed5-08da247e8c45
X-MS-TrafficTypeDiagnostic: BN0PR10MB5335:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB53351302F76D214BFA2F121CE2F79@BN0PR10MB5335.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOgM1v6Yw1AJSY84y9cElynwMIhPJwJlIy5iXbHh7oCkI2QLaYP8l0jM0ssmMJEWfz0Rdz4vYA58jnfkYz+3JH2bQeK7/m9Wq0BDehvyMiWqIk+e7ciwl8cbzIgD8Wk2N+AYHXj7kTsrm4UfeFH48rW7lC5s0d7VouvKtgVsl0P+t6ccEemhfDq7W/PksrB+MoV7UEz71cHdDpNSNvDo6OCkfHS7PvLhdMLejbtQkHSsuli6+6QKclyli4jMhX8Prhk4TUCE5/nPGNR0IF2iEmNve/wNQasqy2UFKiYnpQwFKPhfSm8XfAXO3xoMODmXb1HpiNxRknWfzaPpy2CvjjJo2cWiyWAOoR8eJOZK0j4F6t0o36y8adN+L4LkbJmYTByNAQg0I9bNui9Vr4sWkJvh2apjoEtYAmXCqKrlaQ8ShalaR+5Q2/nAzJVAvKgXKDVMw5nXFzNC9BYjeCqOEto2gQeCjAaJo8O4L3rM+ZUjzKTlN7s0HpkDaPMBof83zD92ogqzTKCFoVyrUOLWO8gm246XVrn9NHqVj7oNC+/ZOiJDUAUYXgPWi5dKbEXo1KsxiUlX/RaluwZAQ/ls8vt5Hqlaqzm6r5OUe8Fr2ZwvVbFF/yRzPA+peTiUZ/2YqNWM/XY5hhtRSrZ25TOY9ckg8GA9RbDpUyWhi5MsEHjb6X6Kq8+hskBECKNawSLU0RkiJHM0oH1VZFtpJNuFl1V0OAtjRyAueUvi+XdY1qUi3DXGwpsANTEUEGb+aFh0CgKehohj1bPunDOHzXQft5D5V6G0kA9Sb44qJ3k0B5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(38350700002)(7416002)(38100700002)(52116002)(6666004)(53546011)(186003)(44832011)(6512007)(31686004)(26005)(36756003)(5660300002)(6486002)(508600001)(8936002)(66476007)(66946007)(66556008)(83380400001)(2616005)(2906002)(86362001)(316002)(31696002)(4326008)(54906003)(8676002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlXZHlZQjRxbnZoampzRGYxS1praHFmYy8zTmFhczRId3p1dDNWNmNUK3Fx?=
 =?utf-8?B?MFdpM1oveThTQWdvR21sWW1ESllKNXhJTkJrS2hVbUdDY3pNZjJ3bCtxYzFC?=
 =?utf-8?B?YityV1k3YVlVMmQ0VTBwOXR5am1wM2xiRkgzeDl0WWw3bjYvV0h4UXRKZHVr?=
 =?utf-8?B?ZElDbUppZ1FuOEdvckNLcSs5YmpoSzVTaGJBMUpMaVIvWU1NRzFVU1dPd1Y3?=
 =?utf-8?B?QzlvcVh3bzhZVi9JbzRSOTBNT1dvK2szN0Znb0xmSU1sNUg3cWdxNG1wM0w2?=
 =?utf-8?B?OHM1dVZDeldUYUJHelgrRHNEYzdjTjVRZTFZbUVHdHBIOFdUYlErUngvU0lW?=
 =?utf-8?B?QTRGbkt4Q2FuUm5iWDF3dTlUWTNXSWpadkZ6aWFINzgxSjhtK1d6TUoyMmNV?=
 =?utf-8?B?QmxSOG1QK255WFZ4MkdXY2VMOFhxa1F6Wkk2VVl5YVFyaVVvc1JoRm93QUFJ?=
 =?utf-8?B?VDRtTWxJd2NjcGpxRzJnbHUyQUFEZ1VzVmtnZTdmTFBzMUNrR3hTdGoySk9z?=
 =?utf-8?B?NzlrSXJIOHBXZkhnQXpQaVZod1kwRUl5RDN2U0lFUzBKaWwrVkpqb1Bka1VY?=
 =?utf-8?B?d29JT2E3WW42K1NqQnFJbExvanpsN0tZalk0M0xBVk00MktSblQ1MjRKYlRI?=
 =?utf-8?B?M0FocUdUMng2MVFpbGdWUlQxMnhHWk11V212Zm5xSGM4aDRqTHo3UUNkUS9Z?=
 =?utf-8?B?VGowaWtha2R4M3F2M0lid3JVa1RUaHpzYnVDYVMvVVdYYjhLa2tqZjVlNXZ0?=
 =?utf-8?B?dThZQ2oyNFhyV2IyblZRMUwzMWVOS3FXV2JuemtYVFloNHJueW1Eb2MvL0xV?=
 =?utf-8?B?RVk1NUtyOUsxOXlMblZheS82dzh4UElxTWVzbnBTWTBHZFAwM2YxWHBVWHp0?=
 =?utf-8?B?NTlISkQ2M3NmSmU0YXFFd1BadWc2WjR2QnI0OHIrTGJidTEvR1dhOU1XeXRQ?=
 =?utf-8?B?MGdqaDBSTTBIQ2lHaFA2eUgyNWg0M0VqM3o0dkc1NXMvQ2Z6QWJCajQ3OG5X?=
 =?utf-8?B?dlV6Yll5STlhY0VMdjRJU216L3lJdXVzN0xiRlFOc3ZoM3RwWGRJQU5RemVC?=
 =?utf-8?B?SzNmNGQ4bGpGS01Lbm9heEczQ2U5N0thL29BVVRtd2NXR20xVyt1RWxaTjJB?=
 =?utf-8?B?cGFIaUVGdjRqaUNheTJ6QnRHTFJrQTZ4ZlI4NDcvK1NXc0E0anozTTI1R3g3?=
 =?utf-8?B?NnFBU2MzeFNJMWYwM1hHdjdtWUdHeEc0NTUrcXVVbUQxQVU4akIyalI3VEtV?=
 =?utf-8?B?RkZIUkRwTWJmNFprOThJSWNUaWwxTGREVm5JZWYzbS9kVkFTenBRUExBMW1u?=
 =?utf-8?B?bmY4M1pBR1VsanE0alpXOCtEUUlJMWd0Vnc0UWNnVnFhMTJCMDlvWnhSUS8r?=
 =?utf-8?B?UTlsM2xIaisyUENVMmU2YWNrL0F1YWZ1QlM5ZDFyOUxTRGlPRWVTYjhRVU52?=
 =?utf-8?B?bE9SY1VMRXFKaTBKRWRHcmUrUTVLdUprNS9MNm9kTHFiMk16WHZYMU5xNytP?=
 =?utf-8?B?Q25jRVZGeEhhaXVjSEFsbnpFUEZOYmQxZm9EaXQ4U1lHUGVkaU5jUGhHbEdm?=
 =?utf-8?B?d0tJTHY1TXNkT3BmOVFrblV5byszNHVnWEU3TFNCVlN3TVBIQnJhend2UFk3?=
 =?utf-8?B?aDBWOVBOcDlVT0NaeFZLd3dLZ2x2ZWR1eUNqZGU2RlZTUjkrNWFWZG1waGt4?=
 =?utf-8?B?YnhudmNwNkRCMWdiT0YyN0xpV3dqZ1BUZi9HWGphRDdqTWhHS2xaZnJVd29D?=
 =?utf-8?B?L3p2QTM2V2xYUVM0cXppcGJJbFFDZ0lGL2VOMWcyam54OXpqR2JwUFZNZkkz?=
 =?utf-8?B?cjR6VWZVMHlBcEMxSFdlTGxjWkVBVjN4VnZCaDF1RlZPRXI1WCt6NXE3SEhH?=
 =?utf-8?B?bm5Jb0doeGlNVW02TlZLRDJMTEg4Vnh2QytSaW0rRnF2NDVGRWpxQUlKa2NH?=
 =?utf-8?B?Z1N5QmZBMEJ0eEJXd2gzTXJKMFBRMXhXMFgwdm5JeG14MjF4Zko0U3pnVEp3?=
 =?utf-8?B?QjVFZjg3c1pVa3IwZTMwTHhwR0s4Y0E2OTd6MWh4R0ZDejZiQXlEK0RFK09x?=
 =?utf-8?B?alBCOXpNT01wdFpmNEJndlJOc0xOeG1lckFSRDdHVEVZdCtMUUdDQnNDeGpC?=
 =?utf-8?B?K0dkWUF2N1BMM1FuY3crTmdwOTRUdjVCVHRtMzN4ZWljQmFmN3BBaVJQL1cy?=
 =?utf-8?B?UXZOeUtWSFJoNFlNSW9XYWR3Mm10WTFvSTBnMmNsOTk4N1hHaWxHR0N3ZHdN?=
 =?utf-8?B?YU5TWm9ISjdsT0h5RXowS0pnK01CSEFJclJlMUpBMm9CdUordlp4ZGtTSFFt?=
 =?utf-8?B?eko2V0s4T2NCci95azFNNXR0cWJ4RmVWZ1hkV3E1UGxaQnIvdDBXNmRsRjJV?=
 =?utf-8?Q?CFxTo9t2NA54fOLI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e71f5ad-1395-406f-7ed5-08da247e8c45
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:38:36.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmxdW0leQgmMtOJ9U13XHO0w3Uo7ezwotmt9Vxpzl16th7PAb7NWbsNSeHm5a2gJAKhQ327+T3QXKTGtWBtB/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5335
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_04:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=920 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220072
X-Proofpoint-ORIG-GUID: kVpScXRzhvzQIMtyscnYSqm8IICyweBQ
X-Proofpoint-GUID: kVpScXRzhvzQIMtyscnYSqm8IICyweBQ
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 15:37, Mike Kravetz wrote:
> 
> Patch 5 in this series makes basic changes to page table locking for
> hugetlb mappings.  Currently code uses (split) pmd locks for hugetlb
> mappings if page size is PMD_SIZE.  A pointer to the pmd is required
> to find the page struct containing the lock.  However, with pmd sharing
> the pmd pointer is not stable until we hold the pmd lock.  To solve
> this chicken/egg problem, we use the page_table_lock in mm_struct if
> the pmd pointer is associated with a mapping where pmd sharing is
> possible.  A study of the performance implications of this change still
> needs to be performed.

Sorry, this approach is totally wrong!!!

If sharing pmds, we MUST use the pmd specific lock as that is common
between processes.  If we use the process specific lock in mm_struct
we are not synchronizing pmd updates between processes.

I am going to rethink the idea of a vma (process) specific synchronization
mechanism for pmd sharing.  I abandoned this early because of some lock
ordering issues, but think there may already exist code to handle situations
where we run into trouble with lock order.
-- 
Mike Kravetz
