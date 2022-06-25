Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01555A881
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiFYJP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiFYJP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:15:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2265627B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:15:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25P3wEDr004318;
        Sat, 25 Jun 2022 09:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tnoxhDrCakTxKscrdv6AwgMdu0mXy1EZr8LiiFWD5og=;
 b=T1VJVupsHCR4I1l3VmJ6Fi3zoG+gri9AX48kSFk3Xyl6Us/7QIKj0MgDDTHyY2nDZV7G
 6yg3BqpefQFynMH9LM9XgXHF8/TEDOvVgHAmaqQHYX9lnUcob+2Gn/TgAqcdi/zf+DT/
 qLWnc9dwZvzNNiEsXmtJ0SPJ1+lWj5pyXbzkHomYb08kqb03Qc1Zv2PZbUEynvH6DbwB
 So3x6D7qGXtjIsa9AfnFAZY9VafCS5dRxjHEC6chLsVEyfKKpAzZ6cZ0W8g7+zPjkgPV
 oUGAHwsQ3W3WnpxeigOxZUh6YD72T1K3oxR8ao6JPb7dGOhdig5+EMGogiG6zYh1hhFp zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwu0a4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 09:15:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25P9FAaU018415;
        Sat, 25 Jun 2022 09:15:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrsyn7vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 09:15:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU3A21T3QxduM0poZBdvZoSpw5mA4qK+6kO2p7BzScVrUNw3gYfUsc/t37Fpi6TpDmHAwSEeyUEY8MKMO5B8L+WN35vEZTofCDzSaIQu3XZlZ97rRe4AuHF/TrIE7LX2TYc4PBxhyWnBg8t0h0+hEO8nLkHWKZ6Je1cEZhHN3qMwOkZc0VHUbKIHy5dDxirso4tHeyu+cD0giGMDHU/fLyTymkb7J1ShPPbawb35D6YE79FwqD4vb13/x/bS8wDTbc914cC80EiynG5gVGTaSnm4RZo9MJKaF46vJ4g/kzI4yaEVUhLdt8yjN/9nFCIMcmblGekcsBpPbf9ksVHHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnoxhDrCakTxKscrdv6AwgMdu0mXy1EZr8LiiFWD5og=;
 b=f1maqthQT+eQZiK1I/Vr5jzhDPm2FqPKoeuzbEy/U88eBt50treBmlS+okyD/ETTB7GyokuDfkLcuDRqxjzxwDc5xsEH4+QVHw5H4gvSKmq4tze2k1RRTBoyPJMaxcM/y/BK+5WcJRajpJGg54eqC34v8fxyHtIb23efOf4Mjj6uJpny/4aqv93vMTJCy3dZnxf0grN2Id7+ToruahaMuTmrPXFlw4uoiS6IDSfHAyWVgLm15a8rHfFY1f/xXexLlrEOLfbyrQU/s8BcvtQQ4AtFQq0DcJNrYgJRk3hTp6SHm11sfpNPNu0pSZNk6DCyZQex7ZfcWJ0NMcWx9uRSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnoxhDrCakTxKscrdv6AwgMdu0mXy1EZr8LiiFWD5og=;
 b=nR2438mFrZp1SQgVYDLmn6JgyeAoiaC061MwmXKadGZDinGB+2B6ALGYo5UE4bj2sa0wCwp2WxhLNC6I6/0dvQiq0FAdVKut/NAqb/2G6fGq4/sq/bEmlDhbuoDK05lDnPddIczrz6Ql6XTe5YMm9fxYIqKP16X8bXhw66u3ouY=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CH0PR10MB4892.namprd10.prod.outlook.com (2603:10b6:610:dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Sat, 25 Jun
 2022 09:15:18 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::ad91:468f:db74:53b]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::ad91:468f:db74:53b%5]) with mapi id 15.20.5373.018; Sat, 25 Jun 2022
 09:15:18 +0000
Message-ID: <e6a78b3b-27ae-ade9-77a9-f8677e0850ea@oracle.com>
Date:   Sat, 25 Jun 2022 19:15:10 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] kernfs: Change kernfs_rwsem to a per-cpu rwsem.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
References: <20220620032634.1103822-1-imran.f.khan@oracle.com>
 <YraLOZb2SnKl0wUO@mtj.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YraLOZb2SnKl0wUO@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0107.ausprd01.prod.outlook.com
 (2603:10c6:10:111::22) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7981d8f5-86f0-445e-576c-08da568b38d8
X-MS-TrafficTypeDiagnostic: CH0PR10MB4892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zw9mSUuqfccw95ce7TjcI/Dz4tQxImivNzp7uQmISBHgPWxnSjRweuCWCWJClHne0QQ0yzeVntuHjwFkj9WElhVzhsYIvluIy9axaLEhlAMGTDkV+hN1IWkW0HoBJaXU/y7oiHWPtATPHwQ/P8eLC8Ul1Xz/IrCEw1Xl6O5QA5Tl79/IAvxGIdOHiIPlef5b0r/0X3ei8l+Jv/MHPN815ynj/+hFnVaUiyH520ws9mHPZo4LdOyLxC9nhvaDVaglGV+XkEVtVZXzA8zg3dg3lshiubkNyeXUOjwclbjIhZUpJVv6+Z0T0B4HhtTcYOrfftbSvVxtMZPTI5j9voZbpIs0/GH4OiaSgZrvqWm5D4zbOiQ6aFZUQXGHi5b+A6W7ZA4ErKRcCMipBcMyJwbsSSQn40LiwOLBMAiB5kp+iUMuSp1t1Bm3Yu6LFAwKXX68FRKYilRehA1D8ViQSDUEud7VHeU6whI72t3sKJ3SqBszk941muvcP2rFss2cSWCC0dddd09sTgl2dABJMSTyhaUHKR8bIvyGdrvdWteIya6TFQ9YHd/1WbmShPoYIdCd+F5g/wk7WpV/vUs0cOimo7kVoO8P8abn/aqJcgQ97EgwZf7srIlDNe6nC7kvjjX7oqqTOdsX1C0Cla7d8Mn9dvO0NtBxGhGHFYQwoJYCu3z/btkwzz02eAzemlurdpsWN9pZrGIHqDd55KpLqs+ep7NYAoV23u31FCVOxH1fszbWvUyVglYAPNWRaKPWlmsw1fOBx1RDaWGaPjin9cGTzXdEjngO0MXxIz9aZrDmkFZLdoGNh2iA+TM4uo9fklVCD0wnsfuO37TqI1l97zyCrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(136003)(376002)(31686004)(83380400001)(36756003)(6486002)(2906002)(5660300002)(186003)(6916009)(316002)(26005)(31696002)(8936002)(8676002)(66476007)(478600001)(4326008)(66946007)(66556008)(6506007)(53546011)(2616005)(41300700001)(6512007)(86362001)(6666004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anYzZUtCMC9NeU5KTWtUR0ZhTWs2ZUpLd0FLNkFhOFhmNjd3cWdkVk52MFBL?=
 =?utf-8?B?WmNHR2MwZ2ZHMDdpMDBVbXBwTUNaQ3Zna1dxMEh4dmJuQTd4eDFzZFJ3ZFc4?=
 =?utf-8?B?Wmh5bkFZVHpEKzNWQkdGQ1hKek5FclZYR045RU10eFVZcGNFcklDeGZUK3pH?=
 =?utf-8?B?NUhuS1BaM2o3WVRzMnJvdk1JdFFjaGdITm1aR2IzV0ZMbnFYOHZYS2FiaWYr?=
 =?utf-8?B?eXdnc1hVa1pGQjBnVlZLODE2c3ZCUzB1bTkweXlXalVYcURvQ0owSjFhRnlG?=
 =?utf-8?B?Zk5RMVozc29Fek43dnU3MzZaY3FZQW80UzFtTGtQK2gzb0t3NEE5ZnFMV2dz?=
 =?utf-8?B?LzIrbkw0M2RNRithKzRsWGtjTG9ZeUhMWmpmZlFyVHc5blgzbVZzWm0vb3py?=
 =?utf-8?B?Q3lCcTd0ZE5OTjlINDJOaDdHdmRPRWxPU210WXlQTUxDRGRDdmtWc1RXWXpK?=
 =?utf-8?B?OXFlaTF0dnhIUEEvNFdRYVc0OExoL3QxZHpIa3dLdTRKMXlNODRSejljTWVE?=
 =?utf-8?B?VHhUYjVncTA3S0U1SjdFZ0lPbG9sK242VXg2K0JzbGhITGtiQzZSZCtTWXBX?=
 =?utf-8?B?Um5IRXZnOEQyYmpFMGNRUjN2MXFvSGJKbjdRanpmWVNORW9NVUZZMUEzcHJT?=
 =?utf-8?B?ZzZacEc1SGI2ZlR1aE5EdUlVbkFVM1Z6eU1QTExiQWVEdnNFd01XMVlBOC9o?=
 =?utf-8?B?NXFxZnlkWTN0WGhKREhOeGdNL0NGNXhUbHdIdEFEUzkrUkF5OUN3UVZTYjB1?=
 =?utf-8?B?YVUrSGR5enFjRXdwUUVsRmxBWjVjNW9jc3liVGk4VkZ6RlhHT1VmV2JTN3pF?=
 =?utf-8?B?djB0amlLazZQdkVCZU93c3lEN2ZnVDFtNTBveUhVVkFORzd6ZTQxNHR2OWJl?=
 =?utf-8?B?SGFpc2FCb094eWdwMzliSm11VDl5S3c2VzAxb2dLN21QdXcwR2lDb2lNS21B?=
 =?utf-8?B?N1RZOG1pdWdVbXlDWHFNeW1VNUVZM1IxS0lUQzdjZVYvb3YwWFl2VzN2dVNp?=
 =?utf-8?B?VUUxSXorMzNZM2lwYWlxeCtleW9MS2w3Y0NwRDVwN2dRdStndzIvbzJveERP?=
 =?utf-8?B?TWo0WHArdHpIQ0x1NTlIWURTK2dPWkJ4SnRzWmllUkdFUHIzcEN0dkR5UEc0?=
 =?utf-8?B?ZWIyQW1EWkZwaXVGait5dTJ6WnIvMkFTRzVDWm94dnVHU1MyWnlUUjZkSWx6?=
 =?utf-8?B?WlpEUW8vdXI1d1dPWDFDMC9QZy81bGtNWHBHSE43WGEwY0Z1bkt0R3RmeEgz?=
 =?utf-8?B?YjVXNEhKOHVTK2l1N2FGakFqYXpJU3BDWlpJSE9IYkdkbnFGaERrN3N4WDJB?=
 =?utf-8?B?SjJSaFV1Q3JaRGlqWkhNWW9PY0FoZ1YvSEpMU0lQL1ZaRHowcmdYcU5RTXN4?=
 =?utf-8?B?aUwzcTlsRjh5MHpocUxlOFdhQWZQT1EwZUxqM3ZocE13VTZIL284aGpHM2Vk?=
 =?utf-8?B?c2ZFNlhkWnk4QXNCei9BVFd4ZndOQUFqV0RDS0lFUWxkYkpVajZHYW5NQ00v?=
 =?utf-8?B?RGdhei9WYkZEWldrNVVHTEVxSnVueFZGRWZWZmR6OFpWbnNob1VsV3k0Zk4x?=
 =?utf-8?B?NjlRZjhlTmZVR2Y5Q09VOENNdWx2UXR0WUpmV2hOM1IrdFIwMkhWUnFFUDkx?=
 =?utf-8?B?eTd1aWVCSGFvaklJbVJIMjdnMERhdWpBeTNvT3NBSnY4OFFyTnVOQVJyODVU?=
 =?utf-8?B?N2l5V28yUDBzQWcwU3FpYWhhV2kyRUJyQndGL2MvTkFUQUhTUCtnWkRlZWlN?=
 =?utf-8?B?bGoxRytYaFNYN3RCakVIK3BCa1NROGNLdXh1cmJYaWhBZkoxZjNodTlhNUJs?=
 =?utf-8?B?OGJkNmQvU1liWnBkQmI4ZWtic2UraGRnTlB6UzUzb0dzRXZZZFg4bU5hdGd2?=
 =?utf-8?B?a0c4Q2ovbFNkT2dDNGM4emtJQVRmRnRvbjlQUTUzdjBGalFCS2FKbVBlQkc2?=
 =?utf-8?B?QWpkQytkOFh1SDZGRzJ0Um56MmZrYTNSWWtFWHJpcGxIOFp6VWhNck9QZVcw?=
 =?utf-8?B?Y0ljQmgyU1ZQVlhDQSs2eFZ6dlB1NVB0cmNmNFIzSmpWYWhkekJMZ090N2RB?=
 =?utf-8?B?clhnWkVraHRDV090UlV2N2pZTmcvZ0RTUTFKdGVtbU1DNUNMUzc4WGZyYUxp?=
 =?utf-8?B?VDRuelpmWUtab2s5bVNWZnUwV1g1bEdKbjk0cDBocDdVQkFZMUlUaW13RVJz?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7981d8f5-86f0-445e-576c-08da568b38d8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2022 09:15:18.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxkAJH5Qu4YJ6+aAmt+Lmv26qGXsiLUG5P1By8TVp5j3vW8VrqivdU3aq2Fv6YYvhIpXqtJHQN1dQn94EPMZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4892
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-25_03:2022-06-24,2022-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=806 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206250040
X-Proofpoint-ORIG-GUID: sYBk6D1Q6R2Iz-iKbehVchURQQU1L0LT
X-Proofpoint-GUID: sYBk6D1Q6R2Iz-iKbehVchURQQU1L0LT
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

On 25/6/22 2:12 pm, Tejun Heo wrote:
> On Mon, Jun 20, 2022 at 01:26:34PM +1000, Imran Khan wrote:
>> On large systems when few hundred CPUs simulateously acquire kernfs_rwsem,
>> for reading we see performance degradation due to bouncing of cache line
>> that contains kernfs_rwsem. Changing kernfs_rwsem into a per-fs, per-cpu
>> rwsem can fix this degradation.
> ...
>> Moreover this run of 200 applications take more than 32 secs to finish on
>> this system.
>>
>> After changing kernfs_rwsem to a per-cpu rwsem, I can see that contention
>> for kernfs_rwsem is no longer visible in perf data and the test execution
>> time has reduced to almost half (17 secs or less from 32 secs or more).
>>
>> The overhead involving write operations with per-cpu rwsem will be higher
>> but frequency of creation/deletion of kernfs files is much less than
>> frequency at which kernfs (cgroup, sysfs) files are read.
> 
> The problem with percpu_rwsem is that write locking requires going
> through a RCU grace period, which can easily add two or more digit
> millisec latencies. I'm pretty sure there are code paths which are
> pretty heavy on write - e.g. during boot, depending on the machine
> configuration, we could be write-acquiring the rwsem hundreds of
> thousands of times and we'd be constantly doing RCU grace periods.
> 
> So, I don't think kernfs_rwsem is a good candidate for percpu rwsem.
> There likely are plenty of cases where write path isn't cold enough.
> 

Thanks for your feedback. I will continue with approach of hashed kernfs_rwsem then.

Thanks
-- Imran

