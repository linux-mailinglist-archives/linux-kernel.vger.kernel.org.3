Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC70349E748
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbiA0QTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:19:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47902 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238237AbiA0QTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:19:49 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RFtswm012326;
        Thu, 27 Jan 2022 16:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hglquywLWzgHUG1h4eN7LroaN1FDkBfRsrXFqPVQYrY=;
 b=mpXeC2AU/pc45479xsRONKcSIY6Al87ZRMwI2/rvIOOZkzF8T7pKUzgdOzsPT01NdVt3
 2medbVM4qNUoEn7/jonvMFkANBDnFSxupqtkj2u8vwiCBPQTGznUPWJ7MqsszuJZTD38
 qb0t9WILtrkI1JiskIdjA8y/H0lW12n15f0e36yKXfFDTojK4gQOtUxK4R+ATcZZ7Czp
 0Yu2PEUSFr2XJvk53qGF0QC6tXvb+Lgwb04qwjdBlj1PZzZsDv/H0m+DW/aU5ulZOlfb
 3c4O3POk2+OCWmHv+nzy+NaKKH6HCKxd0fdlutXObsitisLx6MyvOL2p12zxDZgGNPEC VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvnk8ges-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:19:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RGAZId141842;
        Thu, 27 Jan 2022 16:19:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 3drbctsdm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgPH8fB0+DkR75ZbM5KPwcl6g1J0TLXWwQR8mgEoEKmbxtmwHIdPlr/XkXIX2KweJRTQmA1TPaEZFIuPVa90If3f7YPFSnd9yARc7iAXIAx3dbuNyP5ZmZsrPoZU1fg0WnMYAeKaN3ht/779rpkaqP726iSuJP48xV0/bdiBaKut4a/h+OPEDsiK3ndensAs/Hl1clgDQyyaGIejT5RyvgJvP//eb3aHtN9m7ATR3Ui3+luy2U0LA1qlz9C5mb+D3vqesj+uzRde7Aw+Fvgu3/fud9zM0fcsjlLII0eVuPi0MNgTYEhZrcvhS2fCSJGT82eU5C7NiybnvlDDZ7cU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hglquywLWzgHUG1h4eN7LroaN1FDkBfRsrXFqPVQYrY=;
 b=Lk0s/4VqkSung14erBXIP4BY+fhAkkUpmeXdeVDAe7IzYotXBkBSTNPrwC3JwtX/47oq/aAGfVVs+RskzqUXC9tZnUTXtIOk2PRaO71F388qE/3YjTeeyG7/RZ4WtM0YijV80s0RA0FIUejV1Cul16ajR2vhaCCOdP9LPQCCEmUbPFTz9QXRR+pgLMIHZPUbX7HihZTpNF58qg5wj5HuL75+a+5O6wIdovtqi0pwZYZ/ObOfi0BcEn4pfFY/lgzFAy2uf41NiL7RwPzSvTpKXyJZgTL9XmxJW6kddHGC1lg6TabX5ow4549phhdHASdjYy9Nvttrg9asbcoyECV10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hglquywLWzgHUG1h4eN7LroaN1FDkBfRsrXFqPVQYrY=;
 b=p7R4O/BNlGyMoT5wxgR0IQy74KT3T7SDQRPZy9CeHkpvTjv575CztIK1R1m4ogyAXyeGwdMf21gajA5nSygZYT99BqPdfpuVRGhwkNDNZdPMmaa+CrItN2ramygokir5ZzGRfg7w5qpsUAIYUA2x24YMIfMDtcjSCPuJESsaCYU=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 16:19:01 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%5]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 16:19:01 +0000
Message-ID: <def78722-f825-14a9-d68b-9326d9ea2c21@oracle.com>
Date:   Thu, 27 Jan 2022 08:19:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] printk: Avoid livelock with heavy printk during
 panic
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
 <20220126230236.750229-4-stephen.s.brennan@oracle.com>
 <YfKxUQdGn0SmRnB3@alley>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <YfKxUQdGn0SmRnB3@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b3a62f7-bad6-43cb-8156-08d9e1b0bac6
X-MS-TrafficTypeDiagnostic: MN2PR10MB4173:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4173D4C77495AD7A25A09CCCDB219@MN2PR10MB4173.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J06IlUsMu7K1V3/n6GtWwPpwvvIgZZBHnrwJtz57bgArTAoNdQWU1VlQQ6SjQAv3g0jM8YHmnI5sGS8NGjGjnsvX/b0DAZzqMdeuWA0SFWAJWWFLQrYFt7APWgN66WIVQpmqByNpVVJYZuJLv+TaQdkjSTZVDTMOTBRQXmtMcrHPPDPVkUqrxrsldJVU9m8T9gG0uzItJcvgdoCX/6Va4kQtTH8GdVkFH80s72JqCOsUh2bKTt4VGa2vKYkJ3y3RiHSNrEE2AwO8xtBgrWQajDicoT8vI01+M1AHC8nUqCx4N4KE2PEa7UF8oj0pSJZt7CsnqA/gW4qPMnd/OWCrS49A+1Ynys1qELySr2dssgKcd0RI5gElI6zEpwv5JU8XGlL4gsBOZO08kAjkatkuhVMn6cU0PNDB8R5gGlZXDat5Iam0B73MHEDERGL48KRgCjmJL9G+aWfgRdBdVLoSoSkDu6gbXw/rRzwfL3zeR8U4s/3LOgW7IYVotQRZ088SKhSRWcIhXkCTD6jQRhFJORnLJ96pBGxRH3sIZ4TvaqmDsb9o4PBU7xb1ZIFIQaTq3xqDWyVlysQSNhMGO6milAX4NpuMWpI9thTUqT8c2FYsY9N8Rkl3Qym0J/w4NPbJBqpb7kMtvyCCvt0Mc7FZoxFTBcL7ICKqKhhNHlSeLOtcNKjtqUgo9x4hlxaWmcFL5gH/TRrZhHizZxOEkvKX4wLNcV4q8O3CxNyUGCY0WDImXWi15fZtcIFWODlf8am3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(6486002)(54906003)(38100700002)(26005)(186003)(66574015)(83380400001)(6506007)(53546011)(2616005)(508600001)(86362001)(31686004)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(31696002)(6512007)(2906002)(7416002)(316002)(36756003)(5660300002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0pkT2dIdm5DcE9lWE1WKy82UEtzOUhncTkrZGQycnlXbEl2UFkya09SZDUz?=
 =?utf-8?B?Rk52b0lXMjQ0TmdNREt0WUlFY2lEN1Y4SDd1U3NWQVFMbExyYklqRXdSMnl0?=
 =?utf-8?B?OEdlYUxhVkNhelY0aUFiblBLaWVqdXkvRFhvQzZHVWwyR2c1emo3d1VNL293?=
 =?utf-8?B?bmdTZkpQRjdUWkxWSkhXcXlHRWJjT3R0Ulo4UEoxNFdwRElFVlBncmZtYjNa?=
 =?utf-8?B?K3RzQWp6dW5HU3hINmdGUkd1QjNZdHRBcTNnRk1xSGlmcnhKTFI5Q25xaVVn?=
 =?utf-8?B?VkVtaEFMV1Q0L0JNUTRKNUFjMVpPUXkxS0lLcUYyNFhtVk5LRmJTclNoemRh?=
 =?utf-8?B?aDN0VjlFRStTSlVDNkJkZ1VncW1DbmFuaXpvb0hZN1VWV0k2dmlTZ2Y1c3VH?=
 =?utf-8?B?UkgyMXN5RlNmQlJuQWUrbVVUdHU0UU5uaGl0UU9OVUl6djZyWHdUOGJqajBW?=
 =?utf-8?B?eXF0SXdLZzUvS1BDVXoyTFFEMjc0aVNmT0ZtZi9kVHVEcXBnY09EVFc0SmhV?=
 =?utf-8?B?TDBvZUlyNkhRTnU4V1VGeUoxVkQxalZ1TWtaN05HK1A2UUhTM1JEd3dUMHZ5?=
 =?utf-8?B?SWNBWGVTSGIxaUU3czFZNTVOd0orRkpsVEttZVF0NGY3UGxreTE4aE9QNWN5?=
 =?utf-8?B?UnBZUDJaN0U2MXN3ZFdyZGEwQWVreFVIMU85TmpmRnZXZVlIV3ZFc2hBV1Fq?=
 =?utf-8?B?NjhFWTMweTNtL2dNcGRLUjRWTlBrc0VSU1J6Mk5RVHlSbVYxNnZtQUk5cjRI?=
 =?utf-8?B?MXA0ZmFNbTVtRUs0clA4Snl5ZFEzNk5oLzFNYkh6bllRV3R4ZXNHUHNuMXpo?=
 =?utf-8?B?SEE4NlFObTBQRklycW1aaWtTZmJJVFo4NGE5WlhYTnBmaTBLNGdkellSNldC?=
 =?utf-8?B?NFYrUW9nZmZCVFBUcklwWFJQQk1CVnZLcC9CWjNEUmZXTmlEUFBlSFZyZ0t4?=
 =?utf-8?B?UEc3UDhMS1NsODJVWTFSUE8zeUhpTFFaOW9NTFR1NWJGMCtpMWg0Nk9zREtI?=
 =?utf-8?B?Ym5NTDZ3S0xSTTZSaFVTZ1BMMG5RYlZyVEptWlVSdURRcGEzT2N5UHpXQjkv?=
 =?utf-8?B?RDVNNnFqc05RZHMxVEtYZjh5QUs5RlJUMDV2Q3ZsTFZsc0x4NDFoamovQXNK?=
 =?utf-8?B?ZGs3WjJNaCtSQllrZ3V6c3d6VitiQnB5ZUNlWVBoTzJUQUxMVElkWmpCM0FV?=
 =?utf-8?B?TkdIWjl3QlRJdVNaeHdsa1kvYjF1UmxCUW8xQkdMZVdsbnNtdDgwREZOMThp?=
 =?utf-8?B?YmtrUHFqQ1ZPeW5YMmpFTlM0YXNRQUNubUJ4Lzg5QW91bjBJeGMzNTFNZFow?=
 =?utf-8?B?S3BtN1FTSWV4WHhXNm9EdU9qS3FZWlA3VnVvWnRpbUdYamQwYzJmc01BRTFu?=
 =?utf-8?B?TzJMRmFYYXhFbklVYkVzQjZ1dFpLWDljVUFjd2dsRGtzZjRGcDI4VnlGcGli?=
 =?utf-8?B?azZpM1VoemF1WG1HYjc1K3hXWXdXVElUbEVDUHVtVmdQNWRETEhpcUxYM2Yy?=
 =?utf-8?B?WEdnSE9Sdm5QblNLbEJvcVRwOTk2blNITitqa0dUOE9pWEdxdjQzcVI1bEhs?=
 =?utf-8?B?QjYzRy9pUXRIb1liWXpVUlFOR1REaXRlVW1nMFZnZEpWYVJmbVkwNmR1a3gy?=
 =?utf-8?B?ZERGRTE4OTBKaFFnQzVTYXp3UzlETlpPWnJ2Rm5hS043L3doTmRBWmwwUEZY?=
 =?utf-8?B?cGk4QWRiSDZmY3JFWTZMVWZzUExoYVliYjZoRFgrWXJlc3MycHRTeGF3MzBJ?=
 =?utf-8?B?WEl6RmoyRmt5QkFjYU5wU0Q1K0E4RzdtWkxYa01XR3VKRE9VS0plbkFPekZX?=
 =?utf-8?B?U1MvSFBzWENFQmxEaHZ6ZHdPcnVaNEh2OFZidnVDQkswbmowUk52ZVRtV1M5?=
 =?utf-8?B?WHdvSEdHSy9yTDNmTjNHQkZGQ1Z0TU9wUmN2VndtZDQ2Yjk5aEhRTllVM3dX?=
 =?utf-8?B?YlB6WjBodTR5eXFRa1hXMUJxTTBFRjJFSW5obGZsK2VIZE1SK1Y2bk92TURH?=
 =?utf-8?B?MFNFL0ZxOFJpMnNDdE5odG0zc3N1dDRjbExtL3YvNnZlK0RYLzZzZCtMcWQ4?=
 =?utf-8?B?VGdRREswVVZZSU1NNFFkeEczVUQ1K1NYQXBkYnprNDd0czAyaWFLQTF2RHB3?=
 =?utf-8?B?WEw5MTdYWHhLNWowUjBNcDhyMVE2ZWZpNTY2RVp5OEdGTmhmOUtFV1l6VlFz?=
 =?utf-8?B?VUhKeFUrQzEycUJwNDh2NUx6LzRxaEdPcWc5NlpRZlh3UTl5aEg0dVFiTWh0?=
 =?utf-8?B?aVBmZVRnSW9wVHAyTlVuK3p0R3FBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3a62f7-bad6-43cb-8156-08d9e1b0bac6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 16:19:01.6200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc64fDWDAdYgybtYcP6m1PZRG81Z6xZHPHqXN1TJrS7g+Ntzof85rBQI/J5/inpnmjEtBcNQhvaJmRDg5QPfibFs9h3kKCh11DbxXmZ0u64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270099
X-Proofpoint-GUID: aJzjASL4bzWEi7cZoVaX4eqTz3mjwLLk
X-Proofpoint-ORIG-GUID: aJzjASL4bzWEi7cZoVaX4eqTz3mjwLLk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 06:50, Petr Mladek wrote:
> On Wed 2022-01-26 15:02:35, Stephen Brennan wrote:
>> During panic(), if another CPU is writing heavily the kernel log (e.g.
>> via /dev/kmsg), then the panic CPU may livelock writing out its messages
>> to the console. Note when too many messages are dropped during panic and
>> suppress further printk, except from the panic CPU. This could result in
>> some important messages being dropped. However, messages are already
>> being dropped, so this approach at least prevents a livelock.
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>
>> Notes:
>>      v2: Add pr_warn when we suppress printk on non-panic CPU
>>
>>   kernel/printk/printk.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 20b4b71a1a07..18107db118d4 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -93,6 +93,12 @@ EXPORT_SYMBOL_GPL(console_drivers);
>>    */
>>   int __read_mostly suppress_printk;
>>   
>> +/*
>> + * During panic, heavy printk by other CPUs can delay the
>> + * panic and risk deadlock on console resources.
>> + */
>> +int __read_mostly suppress_panic_printk;
>> +
>>   #ifdef CONFIG_LOCKDEP
>>   static struct lockdep_map console_lock_dep_map = {
>>   	.name = "console_lock"
>> @@ -2228,6 +2234,10 @@ asmlinkage int vprintk_emit(int facility, int level,
>>   	if (unlikely(suppress_printk))
>>   		return 0;
>>   
>> +	if (unlikely(suppress_panic_printk) &&
>> +	    atomic_read(&panic_cpu) != raw_smp_processor_id())
>> +		return 0;
>> +
>>   	if (level == LOGLEVEL_SCHED) {
>>   		level = LOGLEVEL_DEFAULT;
>>   		in_sched = true;
>> @@ -2613,6 +2623,7 @@ void console_unlock(void)
>>   {
>>   	static char ext_text[CONSOLE_EXT_LOG_MAX];
>>   	static char text[CONSOLE_LOG_MAX];
>> +	static int panic_console_dropped;
>>   	unsigned long flags;
>>   	bool do_cond_resched, retry;
>>   	struct printk_info info;
>> @@ -2667,6 +2678,11 @@ void console_unlock(void)
>>   		if (console_seq != r.info->seq) {
>>   			console_dropped += r.info->seq - console_seq;
>>   			console_seq = r.info->seq;
>> +			if (panic_in_progress() && panic_console_dropped++ > 10) {
>> +				suppress_panic_printk = 1;
>> +				pr_warn("Too many dropped messages. "
>> +				        "Supress messages on non-panic CPUs to prevent livelock.\n");
> 
> It looks like the message might be printed more times when
> panic_console_dropped++ > 10.
> 
> In theory, no message can be lost after we disable printk on another
> CPUs. But the code might evolve in the future. Let's make it
> more error-proof.
> 
> We could use (panic_console_dropped++ == 10) or pr_warn_once() or
> both.
> 
> I prefer using pr_warn_once() because it looks the most error-proof.
> 
> 
> Nit: printk() has exceptions from the 80 chars/line rule.
>       The message string should be on a single line. It helps
>       to find it using "git grep". I think that even checkpatch.pl
>       handles this correctly.
> 
> 
> With pr_warn_once() and message in single line:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr
> 
> 
> PS: I could fix the two problems when pushing to git. But there
>      is still time to send v3. I have vacation the following week
>      with limited internet access. I am not going to rush it into
>      linux before I leave, ...
>      

Thank you Petr, I will go ahead and resolve things in this patch, and 
the others in a v3 soon. Regardless, no need to rush, please enjoy your 
vacation!

Thanks for all the review and guidance!
Stephen
