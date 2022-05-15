Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006935278AC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiEOQBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiEOQBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 12:01:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D001707C
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 09:01:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FE9vRg014217;
        Sun, 15 May 2022 16:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mzQP91SCSbH8FIX/3a2OoWUUuAWkXzH/tx7qUG3yjGE=;
 b=S8oMy/5T0gQyDGf2XUcRHqjNuojCsTTr+hV3VCvxHTrS9pjZjBttkcOQGfWNJ1iAtORk
 G4BTewr9sKjN4HXG8eKHdumWyPxPEzxuGWyQRGTM8K6krxSTLd2GvpYgY4hdMkcCnMEm
 vRaaCYuowRipCzwvf0RN1CzReH+OSju3EisPtHh7Hyr8cOqQ/yBIgPxYRIHwz6cuoqLa
 xeTKVQu2f579OFa4X8rM6HIXBbtHeXQ0VESlUJvCjOKQhBBaNN9AVKv8FCEs9Q0xZcLJ
 ONOibH9rUn+lNvZDykEIcTKCCJRzyE3X/3yVjrLOyiu3ftDZxm28c5eVySI8ZAf/eC3h /g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371sppt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 May 2022 16:01:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24FFtvqi016293;
        Sun, 15 May 2022 16:01:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v10bs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 May 2022 16:01:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBIXZf7j0Hz4dM1LcuTTfNmbmbGIhBxcpiFTyZ9SYLCWrWRYmlxkoIBYBbsSiB44bf/sOzlvPyQrU2qLgwJ6SeGuo4+HMnzDnfGMZ2K7SI25Zh5AtAeQKWccniMI+SvJfGiMmwABbIOrc3F1uY5sY3DVDVuy/pQ+dSNyVkwSkiLV6qjeuE9HyHn8YSzAaN7z4qaJYExqlXKyEiFPgOOP/m61F0Drmox4isJQom8dkNWe6g70doRUVCP5rCzJHzs6Z+wDqTN/FKpSEb7VYt8Iv8wobBAfEcKXwkF4ujhuwMMt15t3snoF+rGB7wYEytMN+Zqbc5INzOpwbTO4Bn0A4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzQP91SCSbH8FIX/3a2OoWUUuAWkXzH/tx7qUG3yjGE=;
 b=AYnmiiyFDXL2jCwjDgzKWWKXeBJebH5tUYzo3xCG/cflOM/oTrOXfy/r/RDl7sWfHquLxAIjM2sMMSUQnevqdM+UKKW8+Cyn1LLsMgOnk3v8ov7pt2STatqqvtUyyGlSBVn4RDYj5Ha0psZAJlJ0zg6VD7BN405HrIvt6+vwj6Ah13U08okpQKUL5aEA36/eiFvugMP9CpSv4A6UdxDX3fWlsMR3+K2cQtzlmDfe4di2nOVtymW5hqdGgFqAVHnqTNmpZPeJe4IgrnZ6XA234Zda8d85I5eAI1lwxzFk/m5wajli0X1W+9jUTlydjWvLNzoDFG3L//TgnvEt7egHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzQP91SCSbH8FIX/3a2OoWUUuAWkXzH/tx7qUG3yjGE=;
 b=qfVt9TymvKhAcvqZvIykJzG8iUGtb2S8AK7Y+rr6OyA8xHePkeAN/z9OJFbYf6S0DFw/7mqsitgSMIWAcLos0cK4fi4535WDYernH0mLhRDuUIfZSDU4O83XhWFz4psbeniTTohVR9c3ciASLsqNmecuBZ/rHkypJDyNN0rTVms=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM4PR10MB6110.namprd10.prod.outlook.com (2603:10b6:8:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Sun, 15 May
 2022 16:00:59 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 16:00:58 +0000
Message-ID: <526b46a7-7daa-9050-1276-e19836816991@oracle.com>
Date:   Mon, 16 May 2022 02:00:50 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] kernfs: make ->attr.open RCU protected.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-3-imran.f.khan@oracle.com>
 <YnQtL7+GYHwpo4n2@slm.duckdns.org>
 <f5ff2554-580c-c817-b77f-25e2ef46411f@oracle.com>
 <Yn0/RrgMRie2YPEb@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yn0/RrgMRie2YPEb@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0097.ausprd01.prod.outlook.com
 (2603:10c6:10:1::13) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 687de138-f996-4baa-7b4c-08da368c197e
X-MS-TrafficTypeDiagnostic: DM4PR10MB6110:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB6110DE0D4DD488C695012AE5B0CC9@DM4PR10MB6110.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzVnXnENqWI3+JcMGKhS1u6/CZ2e/UHJkOpEJGrS8rXV3QX/yTvBxCj9w5AteX66vvUwFM2RWPebAUNBfp+SPiXv5R6tBjby8efh+3uKWieVquVFhfoX0L6qCjkbNwk9/5ETbcD+DvwmKlzrxqSXWxtdokd/KuAWPgoxJR1C6rC+AQhKb2Ci+i5fcoxeRPdSNd1D8Tq91QkcuAutxXiAY/pU2KWiZCqyxqJcpV32kdFHjmc7yu6TmKssz49MKPEjWGwH6mVoCJhIkvxGZVytoBtQcajEPT3qlx1IJasF0TulpxlQWyKbV9QQDXx32qSbUgmI0mgI9UbICJdfjcwVkPH9MyGmI4L4/hEbaq+n97vg1Imo4WvALtr8tI55Zl0a3WLKkPFGBW/J8m2LdyY7FCO7ebxLl6iNyH1d/tf0CNld4dYajaxQTaNTkvLf7yH6CQ4gptENpOKyZ7CJ6HHH+seSV2oTeKo9QZhKqCHZ/jED+fYXku+nNuuycIM3IXg0I4vcUVmZQOmB5f9JFjyNyI3gfgeBg0zGWwGR+VH4uqM78b+pYlpMjO4ccGksD7hU1I/XsruCiwDL3rQO3AXs7DHDpyY0Ud2UT6Vu5ETO5xIjikisgh9ECdad0HCEr2laDE5xMKd1vz/U0YLKl3y5qIVnY0TOCmgYermvW8oH68NuBlUbiNd193fAePgoo+Si14IZVYVY/9XP0zdNmmU8j3Hqx9OKTAQVVCpKrlYgvLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6506007)(53546011)(38100700002)(66556008)(2906002)(8936002)(6666004)(508600001)(5660300002)(31696002)(6512007)(26005)(186003)(36756003)(31686004)(66946007)(6916009)(316002)(2616005)(83380400001)(86362001)(8676002)(66476007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2tra1RXdXMwVFArdDhId1NhajErZCtjMDNRR00zTzhvK0ltY25ndzVFcVZH?=
 =?utf-8?B?TDRjZjh4RzJvZTJEeVRmR1B3YzdEc044bTNqS1M5Z04vN2NmZXRXUWhsVE15?=
 =?utf-8?B?QjhFOG1QaXpmUTY4bk5WcWZaMVo3UGRvSHNaaytZWSsrMXpvRjhVcm9COWg3?=
 =?utf-8?B?MUJuN1MwVytybjJkSUhlbzZyRUZkL1grcGFKUFdTT2hIdkpmUHpwd0c2alBF?=
 =?utf-8?B?Y0c4R2p3V0FmWk53RWtzQ0ROaXBZY3ZGeW0wV3ZLR2NuczRBaFVtUWNhZUxi?=
 =?utf-8?B?Z2xkSFVpRCswYVV5VEZiL3dXZXNNQ0JYU1Z5QU9veHZvZEUrcXZSOWtIVGty?=
 =?utf-8?B?RHZCZDgxejAvTURXSUJLQVlrd2huTWhaWGd1LzIvWEh6MjI3Y1p6TkNqZmVy?=
 =?utf-8?B?WnlvaDM1TVRmaWwrc3R1ZWpqVFRYN3dLYWRlWWxWWVZTYlRLSFFsQ2drdURq?=
 =?utf-8?B?M0RsNmFqU0R2MHNMV2RxbEl4Tit4WW1Za3haek9hLzF4UVFjc1lzQnZxaWp0?=
 =?utf-8?B?Ui9yaDJ0NzArTTk5SUswTUpBUVpyWkcvcUJZUVI5cDlJWDUvdCtUZ1BGbVZm?=
 =?utf-8?B?STJzUEk5OXBRWlRVdkRoYXlUMW9keUVubFBFT1dlQW1hL2dLRFMrMVF0ZFNx?=
 =?utf-8?B?S1BxT0lXdUp3bm9QQzNuSDdHTURpSmR6cDc0SjhTNHNGZUw4akFhTm9WNzky?=
 =?utf-8?B?bGZ4YWNwNUFJTmRUa3B1Q3F1WGU5bTdHdWZ4eTBXWGZmcDVPVERxMkE1Rm9z?=
 =?utf-8?B?UjJ4czJmeE9kNWZFK0J6M0hHVkh4QUNXOUVsbFhxYTN2ZTBkRnR2OGs3dG1I?=
 =?utf-8?B?STBZUmdKMUw4YndOOThDUWJvOEZvSFNOWFIrTjNOYlFhVUNKN3U4ZUx0REdP?=
 =?utf-8?B?WWIzd1ZyV0dJSjV3eStHTWlNL1R4NzRGa0dMbmE1endLNXgxSFU5b1hQS0pD?=
 =?utf-8?B?TWdmWndEMTEwSWducklGMWd5WlE0bnVQRFljMTlrcTRuYUROeU80MnBXd3o1?=
 =?utf-8?B?WTl1THhPVWNpWkVaOUplL0lPbDJybnJUMUFTTjRkQ2dhSFBWL21NRTFCdnZp?=
 =?utf-8?B?YXNSeGw0Y0pNMVI3TTQzYXc0MjZoQlcwQm1oZ0lDVkYvbUpFTkUvaVFyL2g0?=
 =?utf-8?B?d2o0bFBEMmc0U3lPckxJZUlzWjV5ZjBFUFAxZ1NIcHdZMW5ZYk15Y3MxVmc0?=
 =?utf-8?B?SGwvQlc0Q2hMK0xNQXNLNEtiZTE4OG9XL2llVDZaUGVYQkp3SjRPeFFwSjVp?=
 =?utf-8?B?UmZyN0JILzhRb1VwdXdjcXpYcUlTTmhtUEllcWJ4cFBwemYwanFmbllkWk53?=
 =?utf-8?B?M1BNS1dRTmlMZmpUNFdwT0gzeHVWb05namxyK21zTmQrbExaTlBNNTdsdWkw?=
 =?utf-8?B?NWZVYkVhNndXMTlsQXZzZmVpWTg1M0VQZFU3bnAwd3VSS3VpVDRvaG5tWldJ?=
 =?utf-8?B?bStNeEdoZHErTkdyNFQxa1FaNDZ5dlFkSlN2K29Md29NbCtNVWRKWkVKbkJW?=
 =?utf-8?B?MUxodzE4RG5zVVZWblBLR053K21WQ2RJblBVNVF4TXVRenVzUXEvVGhLNk1T?=
 =?utf-8?B?UDMvZ2p2UzBPeWRVZnNSS0lVSkgyTERYd2FtcDZzZW93MHI1eXc0cXNVMDRV?=
 =?utf-8?B?SFU4MVpZS0ZZRjhVMUFkbDFreDFEZmFCbzFnSHc3UWZuTkdsa1FxbmE2VjV2?=
 =?utf-8?B?Zmc0WURqWENCbFlGQVBDTEExZzg0dTFTWGxXZUlxSTBHMit0UkZacmx1c1F6?=
 =?utf-8?B?dmpaTllVMDl4RDR1L3FrMUltQWFyZlZBMFdlR0Z3Sk1PQk90MkZ4Rk1Bb2Ur?=
 =?utf-8?B?TUx4YnIreGU5TDNJYlR0TjZMKzV2L2tNQWN6M25lbjlybjlHWlRPMVN3M2Yx?=
 =?utf-8?B?U212Q01kdW1jejV3bDA4bzVjVkw1eFMwZU5CSU5oWEQ2OGJjNEpTN1FpcVZZ?=
 =?utf-8?B?NEZwazZGQVFpREVjRDI2TVpOSlFQK296dlJlR3Jla1MrRUFzMG5LdUxhd2VR?=
 =?utf-8?B?Y09MajBsV3hESCtRMVdaQlZuczhub01WSXo3ejJVK1Azczl1OWNrY0k1SGg2?=
 =?utf-8?B?TlNDblQvZDhvYURvMjdUS0dtbEtCelQ1VmsvRjgxZnFQdnJwMVp3d3JsbUM3?=
 =?utf-8?B?Vm84bGFQZ0xNam1XeUV3MThFdXJJc0tSeFppSVlGSkRQdThsQzZtaXQ4NkNr?=
 =?utf-8?B?VGREd0JMYXhvUWd3SUZ4bEViWmdEMEhlV0ZXT1g5M01WVjhrZGhTRE4yakl6?=
 =?utf-8?B?czBZdHpCZUM0VHM0S2xOa2wrd2E5VXZpaVJib051bmE0aU1jOG4zKzJoUTRq?=
 =?utf-8?B?U0VkYXpyeTdnWS9xV3hOR2hWU2YrOEJ5Q3dWM1Z6OXJXSTd5eE1EYi9tOHQ2?=
 =?utf-8?Q?I+oV0kswyDnGap0Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687de138-f996-4baa-7b4c-08da368c197e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 16:00:58.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WG+LdSDSG5JZlMBogUE4vm0TnLPoph00WfJezoek9PcnXAtrEkJlvCYd7rMQSCcOMylXc3A5wCYklUW6Us/wrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6110
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-15_08:2022-05-13,2022-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205150089
X-Proofpoint-GUID: wcW_8Lx6LBbTH1vQ545b24uzYDewUWsG
X-Proofpoint-ORIG-GUID: wcW_8Lx6LBbTH1vQ545b24uzYDewUWsG
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

Thanks for your reply.

On 13/5/22 3:09 am, Tejun Heo wrote:
> Hello,
> 
> On Fri, May 06, 2022 at 09:12:23AM +1000, Imran Khan wrote:
>> On 6/5/22 6:01 am, Tejun Heo wrote:
>>> On Thu, Apr 28, 2022 at 03:54:28PM +1000, Imran Khan wrote:
>>>> +static struct kernfs_open_node *kernfs_deref_on_raw(struct kernfs_node *kn)
>>>> +{
>>>> +	return rcu_dereference_raw(kn->attr.open);
>>>> +}
>>>
>>> Wrapping the above probably isn't helping anything.
>>>
>>
>> This change is using raw deref at a few places, so I thought of putting
>> raw deref under a wrapper and explain in the wrapper function comment
>> under what conditions raw dereferencing was safe.
> 
> I don't think they need raw deref in the first place and if you *really*
> need raw deref, the wrapper explaining why they're needed and how they're
> safe is the whole point of it and I don't think the wrapper achieves that.
> 

Okay. I checked with rcu_access_pointer and CONFIG_PROVE_RCU enabled and did not
observe any warning(s) so rcu_access_pointer should have sufficed here. But I am
using rcu_dereference_check to accommodate checking of @of->list as well. The
checking of @of->list also covers one of your later suggestions. I have updated
the description of function as well. Could you please let me know if below looks
okay:

+/*
+ * Deref RCU protected kn->attr.open.
+ * If both @of->list and @kn->attr.open->files are non empty, we can safely
+ * assume that @of is on @kn->attr.open and hence @kn->attr.open will not
+ * vanish and derefeencing is safe here.
+ */
+static struct kernfs_open_node *
+kernfs_deref_on_check(struct kernfs_open_file *of, struct kernfs_node *kn)
+{
+       struct kernfs_open_node *on;
+
+       on = rcu_dereference_check(kn->attr.open, !list_empty(&of->list));
+
+       if (on && list_empty(&on->files))
+               return NULL;
+       else
+               return on;
+}
+

If this looks okay then I can replace usage of kernfs_deref_on_raw with
kernfs_deref_on_check.

>>>> +/*
>>>> + * Check ->attr.open corresponding to @kn while holding kernfs_open_file_mutex.
>>>> + * ->attr.open is modified under kernfs_open_file_mutex. So it can be safely
>>>> + * accessed outside RCU read-side critical section, while holding the mutex.
>>>> + */
>>>> +static struct kernfs_open_node *kernfs_check_on_protected(struct kernfs_node *kn)
>>>> +{
>>>> +	return rcu_dereference_check(kn->attr.open,
>>>> +				      lockdep_is_held(&kernfs_open_file_mutex));
>>>> +}
>>>
>>> Maybe name this just kernfs_deref_on()?
>>>
>>
>> Sure. I can mention in the function comment that this should be used
>> only under kernfs_open_file_mutex.
> 
> and in the check condition, add the conditions that you need to make this
> not trigger warning when used in all the places that you wanna use it.
> 

Since ->attr.open is always accessed/modified under kernfs_open_file_mutex, I
have included this check in helper which should be used only while holding this
mutex. Do you mean that I should include some additional checks as well in the
below helper:

+/*
+ * Deref ->attr.open corresponding to @kn while holding open_file_mutex.
+ * ->attr.open is modified under kernfs_open_file_mutex. So it can be safely
+ * safely accessed outside RCU read-side critical section, while holding
+ * the mutex.
+ */
+static struct kernfs_open_node *kernfs_deref_on(struct kernfs_node *kn)
+{
+       return rcu_dereference_protected(kn->attr.open,
+                               lockdep_is_held(&kernfs_open_file_mutex));
+}
+

>> +static struct kernfs_open_node *kernfs_deref_on_raw(struct
>> kernfs_open_file *of, struct kernfs_node *kn)
>>  {
>> -       return rcu_dereference_raw(kn->attr.open);
>> +       struct kernfs_open_node *on;
>> +
>> +       if (list_empty(&of->list))
>> +               return NULL;
>> +
>> +       on = rcu_dereference_raw(kn->attr.open);
>> +
>> +       if (list_empty(&on->files))
>> +               return NULL;
>> +       else
>> +               return on;
> 
> Put the above conditions in the rcu_dereference_check(). That's what it is
> for - describing the additional conditions that make the dereference safe.
> 

As mentioned earlier, I have included checking of @of->list in
rcu_dereference_check. I am not sure if we can include checking of on->files as
well because "on" itself is the dereferenced pointer value here. So I have kept
checking of on->files separate as shown in the earlier snippet of
kernfs_deref_on_check above.

Thanks
-- Imran
