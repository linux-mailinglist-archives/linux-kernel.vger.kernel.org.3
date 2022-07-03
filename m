Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FC95646F4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiGCLJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiGCLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:09:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508789592;
        Sun,  3 Jul 2022 04:09:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2635tqTL023099;
        Sun, 3 Jul 2022 11:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5BMm9cVQ3XVz37A2Nrn/86cF0FzeF3a3HMC5u/9xCZs=;
 b=ctF2z187zhxXvaJTQZUZxiEhIhAGNIhXwiiZovIDDs2sidvoTWknlzyFgypwXF56Qqbk
 k+43ADGdMaYrudXnPj01WwdVJV5YxYk549EbFe8LVUkES0Lnmx9kZSkKPDcIsnJapvtN
 3axy5VvBRjlZCR7IOqZbaW7dG1GjLn4hawdbUsleDcycrKx/53Hg9oJr4mBuyf3wMqRt
 vtrW6tsKqh0GkXIEXcFn6etXZG8mISNFBPtjaRdCNrBAKlakYYMzgjeTN3K4rl6rJNbX
 z+jzQMSTqkzR3in2KcuWady6Glpu9vJUZXlbMAaL9cL75OMnp2nbD4qIQS/966tc5DH5 Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2eju1jgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Jul 2022 11:09:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 263B5Hvb040575;
        Sun, 3 Jul 2022 11:09:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf73v9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Jul 2022 11:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em5IEXhURBrroxv2bpZ8gzsUhHIetzV/BkA4qdGkqC9ZGxhFsHeclqdYTrBsHhM0rHijyWYpZ6Umgeyz/EMS0Ql7Y5DVSUYEz247pUlUWAV6p1jG/xMtLzfY+Eqs26Ft9ouvdhqfa7tMpHPC8cynh34BDOFSNN7s01J9VciTcKj6/Nkar6vTI5BmNY22eKHea35B4WlleOR7YY7NjzosQdPfv+gdMdxWvep2V2uhO/7/vYd1F4OxyEXqs+s/KlKMLcoyEpC1YbPjas6LItHhKGoXcfDTWluJ13+o2C32+3GiRbsBStKGlMI8PzbKXym01jmTjOoO4A53dzmK121pDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BMm9cVQ3XVz37A2Nrn/86cF0FzeF3a3HMC5u/9xCZs=;
 b=JCm9GOngfppgWI9c9ZfrbBGIJ0MYqLvT9OrBmAz74NPRpNDxmXf1ywUawMM595qd/78kt9a3XUUzAH3vA62FCoDahfLo1lormMyke7Th2zeLvZIr1IaIFML8HHaDdBNuQdtggJEGMf1TlV14xPuXSXrgRRX7QaEJo8NfaV6QlTMPIaFo9S+2b6hPoI14HiGGIfBoqIJLFPzQD4uZgxFF3GetyH7hlNiXHTbzrcOM6B1l0+egI8eb31xzKEOdDGvYFezu6ElkSNlw73JO6ffkhEOXKIyAy4x4fbTiITLpafPv8jP7SEO12LCDng+OgDXhIQ1E67Ey6osiEoxbbwgZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BMm9cVQ3XVz37A2Nrn/86cF0FzeF3a3HMC5u/9xCZs=;
 b=vbI+gD7u9omHS5w0e+7JLt1YTNk9tiLp11Uct5SA1xegrh5jyU22Rl84xHxsVPmgPPT2Hdsuih5MBxLWpRywZ/xh9BmDzcuiYMJzXiUYFcAu/IbCzhFTU2oT8Eu12szqu2JyFsAZ33xRcHMwCoPSeFi85xxVekJ7LicdaGRAcCw=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB3838.namprd10.prod.outlook.com (2603:10b6:208:1b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Sun, 3 Jul
 2022 11:09:21 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc%6]) with mapi id 15.20.5395.020; Sun, 3 Jul 2022
 11:09:21 +0000
Message-ID: <deaaabe5-0a0c-b6f9-c85b-5080874f6437@oracle.com>
Date:   Sun, 3 Jul 2022 21:09:05 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH] kernfs: Avoid re-adding kernfs_node into
 kernfs_notify_list.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        m.szyprowski@samsung.com, nathan@kernel.org, michael@walle.cc,
        robh@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com,
        pmladek@suse.com
References: <20220701154604.2211008-1-imran.f.khan@oracle.com>
 <Yr9U1q0BBinCgyrT@mtj.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yr9U1q0BBinCgyrT@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c2f7bcc-ddae-44d8-347f-08da5ce47adc
X-MS-TrafficTypeDiagnostic: MN2PR10MB3838:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIcN5pvSvFofbUGyx/GXVWDerCQKtc082dpRQ2O/HeC334F7mv/Gj8oa+UfQof2kSwZEQeRWjtYOkMZ3uWcr+XEidhGVWJayrd0nKMLNpCUzew+pFfkv2b+Rlakd54R0/PHWo5saNyTeR6XZvTggEhgDU1yng1FU25nl9R1zajJlXmCeT94sEXLx8tlA18TpcJazsJUg8SuPzZAJOaoMMU9CWwFDDDrl7YB/xFfHy7KMuVih1RxU73HvgZZ4BsYWbhjDFCsTMYqcvUMgk8/U/MMGsxG6IBIlHG8QMWdrJ3YMHyXm9ioehksnBzgrIkqp9UbNELiSdyCTS5cGOTCDvKyZfAhJC8rZjto+/MJPjpnWysQ+QpYmLseYC/Avj99ZEr17L+peh8rjJqTurNBgXkany2218igMLjbvrQ5zos81lzeMGx6eDhK3c9PAyBJnJJN1BbfDxnK88eM2UDni6BHVhD2PlDOfW2Vv0bV7M6zAGrmnaIhqyvloIai14hXH+l+tGheXp3N/REMgIQHElXNpiMHaWdF08rP4UxFnU/QAhf7M29ykEAxOS/f9MFqit89cmdN/F2vKJNClCVeSi6eW5wuJ783e60q9UqzgulGCdJOkyPWcFWTBgJhd74T4eckmn28UPkRoRjd6+MPZbOVod3TxrOQcD5F+Tl+O1Eferu1Di7oO8wgbNmlQOSE8chGypKdP3xBf7MeCOMBcrb+qFAw3Frqe9tYgr3yDnLYmbB6dzY4EsfZA9dilKArdwGJ0bRkZzPLM6SKVQxdKDynRXQTo6FGtqQn54RPHQ5SAfW87MAhQJ8wGOP7W2A0C2AXoeD3C8E5i+K+iqy9FWn9A4MVL8iaecQ1lAH9KT3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(396003)(366004)(136003)(346002)(316002)(6916009)(2906002)(478600001)(6486002)(31696002)(86362001)(2616005)(186003)(83380400001)(6506007)(53546011)(6666004)(41300700001)(38100700002)(31686004)(6512007)(26005)(36756003)(8936002)(7416002)(66946007)(66556008)(5660300002)(4326008)(66476007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExuL0pUQmJmL3ZCZEhtYzRUVmJQVkc0RjlvbDNZd0RlWE5aZTZlYlFDeWRN?=
 =?utf-8?B?SWN0U1ZsVHF3UE9jQ0dweVU3Mkx0NjhsRVFURS80ajIxZ1UyS0FHcTdyNWM1?=
 =?utf-8?B?aXhCYUxaMFRjWS9ySkwwbXRCOGlCZllOTjVtRHdocVJERFI4cm9YVzM0Vmd3?=
 =?utf-8?B?S29hQWt4STI3N0toZzNlSHQ5Uk82dDJkNTIwMExoS1V2WmJsTWg4R1JMeFhX?=
 =?utf-8?B?dXZsZWFsTFBHTm5VRnp4eEpCU3lVWFFIWFM2WnRmU2ZpS2ttc2NNNTNGSVFQ?=
 =?utf-8?B?Nk1MWWlmK2wzcFg3TVd2ZDJpQW5iVVRlNm1BREo1cVZ4ejFVcVlxeGxWTyt5?=
 =?utf-8?B?bGtZR1JNYjdBN3FIbTF6dzhJL25BZlUycmdBeTREcFg2TU5MdWVRdUtkaDVI?=
 =?utf-8?B?NHBKVEhjVG0vVy9Cd09oUXJQcTU0THMxRC9zY010S2pTMzlycWtTR25lekcw?=
 =?utf-8?B?R2pHS1p4aVNzY281bk0vdHJDalFOb1psNjVwMFVrSEZTSjhnekJIUHlUMVB1?=
 =?utf-8?B?TTh5YlhLLzM4cHcrNHl0dndFV2ZYdC9rcEw0RENuaWlnNFhBejB2bzQwU0Nx?=
 =?utf-8?B?dCtCbnBtVHhYNjZRMHEyV3NrcDJCRVhkVGRVSitNam5zVEF1bEdvdGkvc0dZ?=
 =?utf-8?B?SllEUzVVcFV2clo0SjJlQ3JVQjRLRm01dXdYU3plOGtJYkYrekMxcnB5aWg4?=
 =?utf-8?B?cDBVN3FxYjRtei94WTJTdXpYOU9zUDdFY1NGcmJCSm5VVW41R0czcXAyMy9I?=
 =?utf-8?B?YkVveFY0VVlBMmIyT0RSdVFKMDR1aGw5ZGJqZitRWGVra21yMTBKRXdETFlJ?=
 =?utf-8?B?MXZYZWpoR3o2bHBDM1YxR21IWE40SS9iSFpEQmJFZmlQN2ZKdEs1QnFxRjhX?=
 =?utf-8?B?TTF5c2ppYy96OStzYUVybHdEbVAzWkxsRG92a0NuaEllS092dkIrVnVYRlVH?=
 =?utf-8?B?NGtaMjNac3RzR3lyRzNuR284T3R0YmVsNGJUekJ2VnlyRWVKaThZdXNXVTBU?=
 =?utf-8?B?RlpXbXIyWjdyRWtmcjZOUFZBOHJiU2ltNHJmVzlsRWY4VXM2NXl5U1NwUVZ4?=
 =?utf-8?B?bFh4ZExFUmd0cUE1ZmU3YnNwZUFYSE9LSk5XV2dXbnVNL1dEcTQrSXVuMEhH?=
 =?utf-8?B?OS95TC9EUXhTQlkvbTBkRWN3V3JwdHhBM25DZXJUQkwzblRrdmNNdlRuYXhO?=
 =?utf-8?B?RkkwS2haUUpVQ0R3d3JiUVpoT0I1V2xWNHN2UmtqaHBDVnhNdk0rWTFZeGlF?=
 =?utf-8?B?SXdBc1ZhYk01WS8vTGx2ZFhuN0VaWkZqeDZuMXExV0lrR1l2T3BkcWVFQjBq?=
 =?utf-8?B?UHdJNDlQakxzWnJaRm9mMkJNVWJHTm9acmE2VGQxR2p4L2xrbitqWGVjU2h5?=
 =?utf-8?B?c2M4U1QvY3BvSGlmZ1ZHbCtoalN6SmhSSDRVOWVnRWFaZGZEd1oxMjlScW9F?=
 =?utf-8?B?MnpCT294QUNBeVBKdjlMa3dSNDJXWVFicnBXSUt3VEJIaFlnQytoUGpNbG1B?=
 =?utf-8?B?NlR5UE53V002MjQrYU9VZVp2U2F5c3Q3RnhObGFHY3M2QVlrSmpKTllXak5X?=
 =?utf-8?B?elc3MlZaWXM3RWtORFN0bkVUaTlBb2VFS0s3eFFvT0RQaW1LU0VnTkJNZlJM?=
 =?utf-8?B?aDNZa21UZ3BwdkxvRS9xN1BaWU5Vb3dtWFQ0c1Fkanhjd004S0lqOERZNlEx?=
 =?utf-8?B?THQrNHJyV0pYZ0Z1TWJIdW54N0FZOEFLaUtpOFIrY1FWb1RFaGxJaWtCK1dJ?=
 =?utf-8?B?UlBsMlcxZGxTYUZIUmlFdWxUWGpSTFg1OVFQbytRV2ZIWjJ0bnU4dENCVHdP?=
 =?utf-8?B?elVUVnJnRzhUZW03bStMbVZtT2JVSEVxZzdmUWd2MEk1NzArQTdzNGJqckRz?=
 =?utf-8?B?WmxMTitsemkvM2xVS1Z2Z2lhYldZSjU4NXFmakgxZU45cUlXbHRpZTZWVGto?=
 =?utf-8?B?SmVtbzFZMFIxUFN4L0FNK0xCR3lvdnMxQ3l1VHNXQWlOMzh2ZHRtUS8rV1NN?=
 =?utf-8?B?VGZRbWNtS04xWDhTZjRhcHY1WE5hbzgvcndZWitHTmtpK2RTbDlFOVM3MGRS?=
 =?utf-8?B?cEdHQWY4c3ZpUThwTktSTTdoR0s2YWlkSnFnNCtRTHNRc2NkQ2ltcEhxYUMw?=
 =?utf-8?Q?c5xQMx54Ed/7lmd2S1aAxUoen?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2f7bcc-ddae-44d8-347f-08da5ce47adc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 11:09:21.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQcNVYHqH9ykgjosMlc9y8yhty0y6m8HcyEzosZTqueW5sWnSqDW9E0Y8tXN0FdjDncx5sHMuzFVzUzNxJ4ADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3838
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-03_07:2022-06-28,2022-07-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207030051
X-Proofpoint-GUID: 2DlKlnjopHlb80DufvwHz-TXv1VTB_sR
X-Proofpoint-ORIG-GUID: 2DlKlnjopHlb80DufvwHz-TXv1VTB_sR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,
Thanks for your feedback.

On 2/7/22 6:11 am, Tejun Heo wrote:
> Hello,
> 
> On Sat, Jul 02, 2022 at 01:46:04AM +1000, Imran Khan wrote:
>> @@ -992,9 +993,11 @@ void kernfs_notify(struct kernfs_node *kn)
>>  	rcu_read_unlock();
>>  
>>  	/* schedule work to kick fsnotify */
>> -	kernfs_get(kn);
>> -	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
>> -	schedule_work(&kernfs_notify_work);
>> +	if (kn->attr.notify_next.next != NULL) {
>> +		kernfs_get(kn);
>> +		llist_add(&kn->attr.notify_next, &kernfs_notify_list);
>> +		schedule_work(&kernfs_notify_work);
>> +	}
> 
> Aren't you just narrowing the race window here? What prevents two
> threads simultaneously testing for non NULL and then entering the
> addition block together?
> 
Indeed that is possible.
> Looked at the llist code and it doesn't support multiple producers
> trying to add the same node, unfortunately, so I'm not sure llist is
> gonna work here. For now, the right thing to do prolly is reverting
> it.
> 

Can we use kernfs_notify_lock like below snippet to serialize producers
(kernfs_notify):

spin_lock_irqsave(&kernfs_notify_lock, flags);
if (kn->attr.notify_next.next != NULL) {
	kernfs_get(kn);
	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
	schedule_work(&kernfs_notify_work);
}
spin_unlock_irqsave(&kernfs_notify_lock, flags);

As per following comments at the beginning of llist.h

 * Cases where locking is not needed:
 * If there are multiple producers and multiple consumers, llist_add can be
 * used in producers and llist_del_all can be used in consumers simultaneously
 * without locking. Also a single consumer can use llist_del_first while
 * multiple producers simultaneously use llist_add, without any locking.

Multiple producers and single consumer can work in parallel but as in our case
addition is dependent on kn->attr.notify_next.next != NULL, we may keep the
checking and list addition under kernfs_notify_lock and for consumer just lock
free->next = NULL under kernfs_notify_lock.

Having said this, I am okay with reverting the llist change as well, because
anyways it is not helping in the contentions that we are chasing here, but I
thought of sharing the above idea to see if it is reliable and better than
revert option.

Thanks
 -- Imran

