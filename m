Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6185A68B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiH3QsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiH3QsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:48:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD0B2CF2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:48:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UGhH3c029355;
        Tue, 30 Aug 2022 16:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pmc0LmnzOwh+bRepWKiq7Xnoi7aOerXOhDsLw3Lt8ns=;
 b=11xEDav05V1ka7IgDGWhfR1NXerHA3p1wpaZUpINuKc4Z/4MBqXtG3ohteQATDRu+Kaj
 mrv5Gx89eQwKjyp3cS2loLRJYe8LOtbNumBBFZ8UeJOEhjv74JsljHCj6i+oltGkcyno
 ++PxSeqxSS3+aBViWwQj0bf2rcvgymGLhLk0p8cNWAMra4A7umNpI5CzQAQ7Okz3/WiQ
 lIoys8xgJqbfITzqISaCTETZPn3YRO/pNdB3gQWTK6PEBqdm0rXcWGzh33Ik/hx0Paxs
 9bmpaP+fB0b2JKiq/7yuUGKvdRtCKjpr29ynJxemsWsY3ScURNBXzegCus6CL0RzbbV3 Ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pbxsyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 16:47:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UGGc49027947;
        Tue, 30 Aug 2022 16:47:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q44vgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 16:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXos9dqz6X6KruFS+TwjHFMfNVWtiRhgAq3hVg0pYY3gL79lH5KjSj8St4EKDdeKHRY1ce3OhLkwB8Scxr3EG/qNOTV8iexsJrICIsJpSVyyusn+uHd+zbOVYF1eqY0Pca3wP/SHbXJagADVxmX1VyP2vVc4pdWjRi55cRGD7rU5WlYYg2zQraKFDKoE0WenmAzHhFrsK4hDMEb5HbrTi4XuaCWhFU/1Ry8+iXC2R5ksSkDw62n7nFH1h9R+bW/8b2I6ljt9zK/6EgL2I4FmdYhLeBV77pjhAXo+GzxjI90geNtCLefpl/4pkuvCeEM5C+14JR/m9iRV++ijU077hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmc0LmnzOwh+bRepWKiq7Xnoi7aOerXOhDsLw3Lt8ns=;
 b=GYaeuqUrxBncJyaOi1pVLNvC37wJnqVf3aBajdJ2ZyCEmQms+oewyNztvxBCRMs7gUlvDKBQGNHMkCvJmmn9CRcLFctVxJ3zDzBlySVuBxdUQo06VVOsd94xzyZZxF/dVNwoPLVM4Q06bv4JoWafZUuIdNW3zcvO7v0rFqTFdg7gV3VcfDc9+DEPojAlFRD8iCFKN8Y85ajFSqyzVqVQv2+Pa7Lx3BPGr44AZThrzyLoyPIo4U4B7PzidVohfNGixyUe/XiVw/swW2ZJgFhFly2ERkIzYa6UBOmOnbnPHJWf3tvkO0RNMg28PU7xSTVH3EnuAmODT0sbRNRfgcqttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmc0LmnzOwh+bRepWKiq7Xnoi7aOerXOhDsLw3Lt8ns=;
 b=RfdYYUS/gXKa2NK9MvNeRWgW49nlfnlRiq1Y/nkYp7ST9aVimyEJHhitJFEbcKPWq+jCvx7kWGemkjXI0+1vOOSwS+GHmHUJTjnQzP9TmCFVjuRy1PCdnOn+kE6MpwcI4OgeIPnGrBMCmDepl92xYIRlw7h/oMfIOdMJ4lBTRAQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SN7PR10MB6449.namprd10.prod.outlook.com (2603:10b6:806:2a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 16:47:53 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 16:47:53 +0000
Message-ID: <fa41ea6d-7cd4-a0c0-b026-f295fbb6570e@oracle.com>
Date:   Tue, 30 Aug 2022 09:47:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/7] mm/hugetlb: convert hugetlb_delete_from_page_cache()
 to use folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
 <20220829230014.384722-6-sidhartha.kumar@oracle.com>
 <Yw2DWCHlivGge03V@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Yw2DWCHlivGge03V@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::40) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b158036c-76ce-4d6b-d0ed-08da8aa761a4
X-MS-TrafficTypeDiagnostic: SN7PR10MB6449:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Zv5HEvKc0mPChlmgY7nKQGxbGC1MS5NFXPMVOqZykUFKSkbXbnOVlz01c/oNtLRDtJq8bdLoRzP9BdJ3RTouN1kQ8zYouMoa4yZZjFMKulJmWpGSRQ/Kq9Rt4jFMmaZM0tKZaQVBwNCPq6gOsa4mKJIYboEdc6ZSu+rpS0HkLaCDrWQCHum2LlhaLdh0wr/y+MX7ESsgD9Z4qG7Z+0vv8b6+slxHw7sZVIlL0FHNAtXFJaKM3a4+BljXQKkY19Mi2SXn3dlhFqjHeQt0A2XigUO5sXw+U5mAXm9e05d4e34JFhr75wWSRoowqoWOIaWuIu4ersg2KvPEriyjBuD2D5ukFlGjjFguuf0sUHLmmEpn6g+rH8wAEuQyHvScBKcLvHcxZ05SONvX91GOZiXBrHcXJBY59CIpQCoehbWyD3s5SGvAG7Bd+sOxXNk8NCSkGD3+oP7EW1k95u9iDfNTOPx+n/j/pCrYt4zzYWT7s2jSZ53uq/zX1ILFj4028lnSbvKBf2W6dBn2eOJnCU3coqNFX2RS3hOKlNr4WgcCKUOD1PUuxzyBQ/ry4dAaoKrM4YeEh1/qaS16crhYpqvVu52xWMo4TRGMfcbTHEfkrT8Simh1A5RtmEFj2lktz2HbxbweXA4yA0UPPyOiXgPiofc+mN8DfPm6iQdERH0SSaidRTxCpU5PX0pKarHaLkdOmU3MK3+aidcrbs3DkK6k1+NAuXksCWoYmSaiEbg8hvJSxHGyVi4cmpaGatdGsD18vikSbvEJLZ/B5F8oh6ZMcfy+4qIayW+wqjrlkTZGmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(396003)(39860400002)(366004)(186003)(4744005)(316002)(6916009)(8676002)(6486002)(31686004)(86362001)(66946007)(66476007)(4326008)(31696002)(66556008)(5660300002)(478600001)(36756003)(41300700001)(8936002)(7416002)(44832011)(6666004)(2616005)(6506007)(2906002)(38100700002)(53546011)(83380400001)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0ZybFNpUG4vOFcvb0RXUUJTREozM1BQOHZ4OUhxcjQ4R0o2STJHNkhnQUls?=
 =?utf-8?B?ZXlxYkN0THl5T2MwY05wQTRXRmJ6bGp3MkZNY3czb0ZCazJNbzRSTVVRRDBy?=
 =?utf-8?B?MTZvRlFQaldOTmtodjRieGZDVElpQVI1SkdQOVZrQlpKWGxSY1YwcmF5eDJV?=
 =?utf-8?B?bTlzdy9BMStlMHQvMDQ4YUJ4YVF1dDEySFJtcCttWU1McFNlYk5xYlFZMWpJ?=
 =?utf-8?B?aGRnbDNLM2Q2cG93c2JoVmZUWE1zai8wK0lXczFocTJCbFlrYkQrazNRN2ZV?=
 =?utf-8?B?a09QL3pJUHRxT3U5QXFkRlUrYWdRMlVXRytFSjRqYmJvNlphaUhFNTRhUG1y?=
 =?utf-8?B?TkVHMzJER0l4aDRNQ1lHc3lrMjZERGs3eHBQTGo2VkFENW1ic0RnQy82QjhI?=
 =?utf-8?B?S3lxL0ViNHB6RThDdUM0TzlFZEEwbnA4dFM3V1FsNktQbGp1NE5vM2ZjMVpj?=
 =?utf-8?B?bG8vVE0xMUpQOXkvNmp6QktUczhObkJuTGo4RVNEUmVvWFJZN0Uzd200UC9o?=
 =?utf-8?B?dlB4Y0tvazFrRTBkOUw4UURWaG91am5MUUx5bTRaMUUyaGFpV1JPbnRSRnd0?=
 =?utf-8?B?d21KaG5lSUJGNDdTWDlCYUJ2TXhkK1pnbHRpVE9Bd2lSTFdEMldPVWRxVnBC?=
 =?utf-8?B?OHZBaHdTR1B6cWhqcjBIRkJZd09Eb3dmNnk3YThvSGhwZFZsYzc0cVlaRW5p?=
 =?utf-8?B?WmJ6NFY1Sm1xTHU5SGVXdHVoN3ZTTjVQbmRLZ1RTOTluZEdzbjYxSy9mMmYy?=
 =?utf-8?B?enhpRyt1TGNiTXpZTGdsMlFrWkxtNGtibUpvamhFZGxxeG04YjVwbktGbFRS?=
 =?utf-8?B?NHBqVUFmd0IvQ2tLTlZ1MGVIR1RJZUNUMHVwQVZBYkZUaFZ5WXZMTUs0WThK?=
 =?utf-8?B?SDZSZnFwUWFCRngwdFVFNVFVemk4SVpKVkI1MVc2eWw3aTFjSUUwUFllOTB0?=
 =?utf-8?B?MkJpcXdMcWwwNEF3czRFU1VhWVpoK0llYWpiVzREODI0QXVkQlpwWnN5OE5x?=
 =?utf-8?B?QVBQZUxoTXI2NHF1dXkvU3MzZjNhb0NxbXpRKzZOZ3FDdkRIZkp4UkR3UzFk?=
 =?utf-8?B?L2JkTlBnZFpCVFQzVHdDRncya0ZUOXB3NnhPbUxxQlBadTFhK2p5ZGZMOUtw?=
 =?utf-8?B?cVhoa3pVRG1sazVHZkJhcnlON2lkTjhzZ1V1RmdOcXdFa0oxY2E2MTRHTzdi?=
 =?utf-8?B?clZZVmhUejJ6K3RyeElxa2pVVkhoV09KV21rSFRUb0RYUC9MYlRCZjdOeXVH?=
 =?utf-8?B?dms0Tm8yVEFsSldKZWVUSFlycU5jeEVOUWQxYkZaVkoxd0xueTJNaC9vZGxo?=
 =?utf-8?B?bzFNQllxaytDWEQ5eW90ZnRDSHBkam1BWVNVZ3p6U3ZEeGVJeDYrNHRrdnlZ?=
 =?utf-8?B?NnczQm14c0V5d2d6eW03cEZ5VHFLOEpSSGg5TGNRYWVraWU0U1REQTVWcVMz?=
 =?utf-8?B?cTc0QVFWM0t6QnU4Q1g2K3JjVThQbFpGTFZaMTVCcnFkN1RtakpPQmV5Unc4?=
 =?utf-8?B?ZmQ1blBHbG1Nc1ZKNmd1OWZsdUtFWkwyR01RRW9sTmxQNHRmWEZkS05IOWg2?=
 =?utf-8?B?aXlVTmxVVitVSzJ4bE03dTUvTGdGaFBYcnpNWUYrakZaamlJSFRvbjA0alpW?=
 =?utf-8?B?Y3U4K1lZL09wU0pOaEJGUWwwcTNjMVBuWTFUR3d5T3pQNGpzWVA4NjAyREIr?=
 =?utf-8?B?QlVhdml5SDV2VnFYbzNmOVcxR0tOYW9XUHRkMFE3ZXRjOS9sQjZ5bGlrM3VB?=
 =?utf-8?B?RjhEeFZRdzMyVWdxYlpzQU1kZHZCZi9XS0pwazZ5eTE1UmRFZC9Cd25rV2F3?=
 =?utf-8?B?djdzU2h6SWpoK3JtaGoySzByYlBpcmRnOTVHVTJ5c2UxWWNzU1BEVldraEow?=
 =?utf-8?B?a3BRdlVHZEFyU0o0cS9aaCtxYmhEL3JaQVVtNkdNdjJ3ZUhwNjh0VU5jRngv?=
 =?utf-8?B?TmQrd1FsZGVUeUUzRDB2ckZtTm5WcWdwcy8vdWtLSUZGaTBwU20vdUxsdGxs?=
 =?utf-8?B?dU5aMmVrbmUwMHBRdVZKdlJzN3JrSEh1TmRJNXZMMEF1NWU3SUh2THI3djFi?=
 =?utf-8?B?Q0pIVUxUSVFUb0JZME1oa1RXZGtaUnkzUGFwTlZXUFV0SzBLV3ZIUTJybGNY?=
 =?utf-8?B?NmpGa0NHKzUxSndOc1dXaGRiVmZzU3BKaWZQTGVrZUhXNk1EeDZITktlQkVU?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b158036c-76ce-4d6b-d0ed-08da8aa761a4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 16:47:53.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyS/Ueu6MgBh3W/08omZVokj8jKtoRmfPuY+ZR2YsfqtWrSyzu8FbqKCfRz8uzecRyPcCJgMeLT/SL6mb0bxpqqOdqe0s8wZHhD1YdZldXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300078
X-Proofpoint-ORIG-GUID: 0-VEAfqvpIu0X9OyLi0HhVsqxilOLQfo
X-Proofpoint-GUID: 0-VEAfqvpIu0X9OyLi0HhVsqxilOLQfo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/22 8:26 PM, Matthew Wilcox wrote:
> On Mon, Aug 29, 2022 at 04:00:12PM -0700, Sidhartha Kumar wrote:
>>   static void hugetlb_delete_from_page_cache(struct page *page)
>>   {
>> -	ClearPageDirty(page);
>> -	ClearPageUptodate(page);
>> -	delete_from_page_cache(page);
>> +	folio_clear_dirty(folio);
>> +	folio_clear_uptodate(folio);
>> +	filemap_remove_folio(folio);
>>   }
> Did you send the right version of this patch?  It doesn't look like it'll
> compile.
I missed changing the function argument to struct folio while rebasing 
onto Mike's patch,
will fix in a v2.

