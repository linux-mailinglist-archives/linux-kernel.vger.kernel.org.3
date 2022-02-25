Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9647D4C4038
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiBYIjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiBYIjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:39:11 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2058.outbound.protection.outlook.com [40.107.215.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684B324FB9D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:38:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHSOQq32xAxcwdgyYMNJjKXtQtD6kkkldzNbthHClwHGXiCq3ak/8wmOr0p4DFOY4+qf8pnzCAfjXSItPT7KfoQfZMj5SPIZhkWQP2p5lxQMWMYDY0dyW6zsKZUQPKUHsS2ASHQs+Ltc/Yrj4BvuDRCPDrqzjjnvyKOczA5+GXqtZ/WQbfKW+j4rBYj1PgawbvBxeaXWYcBVEoN+D4nDrgNcT3A7s+Tn2maHeAgWZN591K34mTFcKf6AY/UsTGWqkItLd6CvnZoCpBsJeZ4VfIg+BCG9phkKhergm+3cH6lBTLhS1YMdSkOBidJwS1RMElqg15Yo255xu4x7xjg8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4bZ2bsKvbfTAnsbMgcaeap9AP1VFPE4Inu8kttsLqw=;
 b=e1DNm7AFSzKDrIeGzG/uKndFNSON5V4dD3eYgwnXv9hu75kFlzBqWNyGkQkZwtVhLPCS/RxCFHwI07oeVAp6EFwfz05L2f37Ek136q985jkLifE4TWEqkwDVRkurmfGP3crudKJeSTiamO1ktLgCfTxd8i9VRIVUVB1QxrdPKcZkLR60rb6VyDOOcUj3RTjIvVCap661gP+yQgzP4Y+y7Cc67StCEROtN9IjS4XP+pXJiEBqSpco8P8Umuxvanu/6Vy9NsavKwxHWroqkzkd6XeC4A69dwQoxmZdsikhsqBuQzzQBIxkFn54tCt2xF5jdylTtylCemyrTA1wjDh06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4bZ2bsKvbfTAnsbMgcaeap9AP1VFPE4Inu8kttsLqw=;
 b=qtDnrOx62X6UwQgc2OYBrH052qrItv7dIoVmoiaOWDkhkQVcCUbx3oArGfXKGhlyZNe2h3CR252W9NnEnJS2rO400HKLNalA0EknQJnRAzKuMT3r0gDa/imCAUGfOJj5F8QkmjdSrDbeWewNE1n2YUaxcEnzmHllhSSVBlak0X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB3165.apcprd02.prod.outlook.com (2603:1096:404:4f::13)
 by SG2PR02MB2955.apcprd02.prod.outlook.com (2603:1096:4:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 08:38:33 +0000
Received: from TY2PR02MB3165.apcprd02.prod.outlook.com
 ([fe80::cc04:c674:b67b:baac]) by TY2PR02MB3165.apcprd02.prod.outlook.com
 ([fe80::cc04:c674:b67b:baac%6]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 08:38:32 +0000
Message-ID: <1c1fe250-09ab-d8f1-40bb-b0ef382b2782@oppo.com>
Date:   Fri, 25 Feb 2022 16:38:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [f2fs-dev] [PATCH -next v2] ext4:fix file system corrupted when
 rmdir non empty directory with IO error
Content-Language: en-US
To:     yebin <yebin10@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
References: <20220211093527.3335518-1-yebin10@huawei.com>
 <621891D5.2070800@huawei.com>
From:   Chao Yu <chao.yu@oppo.com>
In-Reply-To: <621891D5.2070800@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To TY2PR02MB3165.apcprd02.prod.outlook.com
 (2603:1096:404:4f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2d9758d-c1bc-4f6b-fa54-08d9f83a349f
X-MS-TrafficTypeDiagnostic: SG2PR02MB2955:EE_
X-Microsoft-Antispam-PRVS: <SG2PR02MB29551C8F2F1FE4A1E1460AFC923E9@SG2PR02MB2955.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VgoP0QI2aqS95WJBHA5Y91+YdXuuG/NxVeKRhKqHrs6S3Mipio7xWs+C/igVWx7Rwi0ob3RXTEK/B5MBvxyQyaYPCPjsWA9iQW3rnLJ83u8Gd+5BqLeQgjPkAl3SXIuL0CUmmbw6Yt44oGVAA70BYTjPLwUzvEXYXZCxrkKdrVUZOYr+tzdxVrm72ZQB4vvueYIMnPO9CF3Bkcb/XRDMGu1hCjkSBGrigPKM1alOxV5qd4RnlLTlhlyj0c4VaFuZwCslCIuOVATAOqDArm1XSffyqOIo/h9J+8MUUujvry9h2g3YGOGNOSJ79d4dZ9bu6Ty413DOc3vJmWNxRAnxCLA9qOlNNjOALQI7jA5fdJJwyhqNwmyHAq0G/A7Z00wWFSdbeQiFfZ279TGTxvUA2RqumExrpo5Nm/DqyRAGFL5/6jxbYEiVbg/EE07QjsQv4W/cd3L/gvqBC45h9MxfcgDLtWzqPAVMppuxiZI/xF0pYMn4u9nWEBlP411mDRp7nr8Ljk1JT6a7kZ7wbJpg7qH7dNUq5km3W/82finf1MJpDOAZ3DWqgGl4YTs6X2PTFx1eEM0C7mKhIO7Q8tBvibkTZgvCSl/XY88cuP2y72Z+cgT+vUMx/SuDjmS0UXChba6kDg9B7XfVLSKTUr3/XN/3UIJKyWXPpfyzuokNUPJDpeJlrl3URoEibqSCGXEx1kEOH52k8urC0Za82I+FVpQkSb7EFfkvlBtVQJqWxjhMNGo1oDKNntpyaMA03EW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB3165.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(86362001)(6666004)(6512007)(26005)(38350700002)(36756003)(6916009)(31686004)(83380400001)(38100700002)(186003)(31696002)(4326008)(66476007)(6506007)(66946007)(52116002)(53546011)(44832011)(6486002)(66556008)(8936002)(2906002)(8676002)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE9Ha1BBZi9sS2dIMnl0cGUrZVgzUWt6UVFHVDZVQzE0RXN6bFhBZkM5cmZu?=
 =?utf-8?B?dThZeTNVdks2aFpQYUt2U25BbEY4dTJ1dTl4aXRqb01iM2hiekpZY0ltV3JP?=
 =?utf-8?B?MU1ZQXVpUFBkQmdlaHlxdHB3eVhRdXNwbjN5RVNrRUFodzJkM0NTWVlQMHF6?=
 =?utf-8?B?NnpvbEJmV01CNTc1TEZzYmU1c2RqM0I0VU9KSmVDZGV1S2x1eU9hK0xZZkhH?=
 =?utf-8?B?THJLOVAwckFKTU0rQlM1UjVNazZGS0dub2dVUHhkTGpDWlB4ejBnMGdleC9S?=
 =?utf-8?B?VnpzcFMyMFZhU1l4SGtLSTVYellNU2NqdjB3WlRTVnc2TXZ3bTBKOFErZXd2?=
 =?utf-8?B?ZXNqMFkrRmJHcnE3QitvcStpa2J4eDlSUXAyU09SMVZRcnd2ekY5U3lNL091?=
 =?utf-8?B?KzNGOWdZTTlranEreTY2SjNncC9rWEJwWVp4T21OcEhKRTR5bEtqRG1YWWJY?=
 =?utf-8?B?bklFVTRrcWVrVWxzSFArWGhsOHhXd3lHMHh2QnJ6ZHlybnFSL0d3eHNRcjhj?=
 =?utf-8?B?VEN2VThHTGdEdDBjUkxIQ2RkOCtHS05qWDdiR1lhSlErOGoweCtSU2pKVHJM?=
 =?utf-8?B?NWFQdnhHYzQva0FVUTYwUzcxK0lheXkvZ0g0a2F1OGM2VTRTTkZpYjBNclBs?=
 =?utf-8?B?ZWZrTE5HK25NQTZxQjRENzVSSWhORDRoZEtvR2k2dmY4WTFpSVZUZTdBSTZw?=
 =?utf-8?B?bE4xeW9wREJIOHNQY0pNY214MEtzMjFhTTBzL0NoUDJuQzN3Y1hUUlhCVkM0?=
 =?utf-8?B?UzI0aUZKYkpmcGxtbDV0V2hnNDZ2MW9TRFh1bTdZRERqQ0tyc2EvbzU3cW83?=
 =?utf-8?B?TkdZLzJqaXB0bVBLV3ZGMDJ1ekxVVnRNT2NrdVRLdDFpWFVKRmd2Z1FCR2Y1?=
 =?utf-8?B?a05kRUQxT1AxSlFWZTJ5SmFSUm00Z2UwVFJ3b1Z4OURpQnBDamFTRTl4c2w1?=
 =?utf-8?B?QlJDQVZXRktVSVpyMlpGWU90Q29vdjZUbU1JZE50K0o3aGcwOGdkTmFZOFBP?=
 =?utf-8?B?V2l2WVVyeWgwcktYQXl5UWUvWmJCV3V6OUVPMk40bXZiL3lQYUJ0dnFjUHdO?=
 =?utf-8?B?UktOQ3VJb3JFMGxYWDlrZTEwcTYyVnFnNjJUTWNGSm5SYURpWEZCcmsvYWs5?=
 =?utf-8?B?dGp1QkpXK3NOZ0N2SVQzRHAxeWFka25mNGZvYWUxb3kyd2lVcTB4a3JRdUZN?=
 =?utf-8?B?cSs1UnFTbENiZlpvK2xuRFhhT0FTaU5xanpFaDJBOWVpUHgyVzYyaGF3U1JR?=
 =?utf-8?B?KzQrSFZZeGp0ODFnWFpScGRyM2VZT2RoMnVmTEN0RzV3citZcFNGOHMzUXpM?=
 =?utf-8?B?WUZ6cUM1ZVlpaVp1VDlSN0hCWDlPWm9ZUHpiMUswZVZwVkdRWlVUV0xzQk1Z?=
 =?utf-8?B?bnFFVDVwcFJncjVKQ3Z5bVNXK2ZnWDU5aGpuM3dtSGRmTnc0WEk2K0tMc1Ru?=
 =?utf-8?B?WU8rV2p6bFg5TDZpWEd3SEpVSXlnbTliYnVrdFltY28yMHNEQXlIZlNiUzFq?=
 =?utf-8?B?aWJpU1NSTFdwdHJHK1FxRFJKeE42REhucUJCSEMzTHFlb2YwOHpKNXI5QU96?=
 =?utf-8?B?NElWYWpvcW9WK3Fnc25jcXZLRWNFalBQZGJ3VUpsSDdqNDR1TVpNSEVUYkVm?=
 =?utf-8?B?eGZYTGl5Q1dTNVRHTkRQMzBOUjRXeVBIOXBPMXpkSWpoQmQ5Rjl4dTZxdGtZ?=
 =?utf-8?B?Rk5QaHAyVjNJVTIrdVE4S09tUklubXZtV0djNkxVWjZ3ZDVsaHZZTjlLMjN1?=
 =?utf-8?B?aDJvTFZNOUdtZVhFbm1CcmVSZVRNUE1NU0tCN1g0QVpmeGtSUndDQnRIR0xR?=
 =?utf-8?B?OUF2N0wxZytGUW51SlJ3Z2MzSVhsQXhJTDNKUVlhT0Nnc2Y4TmRBbmNBRGNB?=
 =?utf-8?B?bWdiSEcvYVlKL25tcGFXNG5HNGZKSUVFZC9idDNvT1pCNmhVTUUvRHlxRm1L?=
 =?utf-8?B?NWVoVVZseExadG8vc0lIWkJDT0NzSDRlbFFMd1B0UW5hajFrMDZqOEY5OGJh?=
 =?utf-8?B?dFBPbDYyMkpjSmJwWXVmZHNVWDdSTDRVQWhqSWw4cEpjT1Z4Ti9PVU9hL0NO?=
 =?utf-8?B?WnFaNXJScnRsNlNLbG1EbllZSkFSZUdmN01hU00zUkUwOWhSdW51eTJOdDc5?=
 =?utf-8?B?UFFoak1FRG1jSHVlRUxsaUQvWURkbGZzUytwc2JKQTBhMlJBeWFackpDbnhs?=
 =?utf-8?Q?7xid82HVJpEnUtYsBEfUn7g=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d9758d-c1bc-4f6b-fa54-08d9f83a349f
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB3165.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:38:32.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2bnLs7OGYzd2uBIbsXoPrAMQIK1aDURTQn7D8fKP++ptKb6WmXbCJ3fuJhf4ve6ThLZRSvP26tHvy3+2s3L2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2955
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/25 16:22, yebin via Linux-f2fs-devel wrote:
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index a0e51937d92e..3de5a1343070 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -953,7 +953,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>>           f2fs_drop_nlink(dir, inode);
>>   }
>> -bool f2fs_empty_dir(struct inode *dir)
>> +int f2fs_empty_dir(struct inode *dir)
>>   {
>>       unsigned long bidx;
>>       struct page *dentry_page;
>> @@ -970,7 +970,7 @@ bool f2fs_empty_dir(struct inode *dir)
>>               if (PTR_ERR(dentry_page) == -ENOENT)
>>                   continue;
>>               else
>> -                return false;
>> +                return PTR_ERR(dentry_page);
>>           }
>>           dentry_blk = page_address(dentry_page);
>> @@ -985,9 +985,9 @@ bool f2fs_empty_dir(struct inode *dir)
>>           f2fs_put_page(dentry_page, 1);
>>           if (bit_pos < NR_DENTRY_IN_BLOCK)
>> -            return false;
>> +            return -ENOTEMPTY;
>>       }
>> -    return true;
>> +    return 0;
>>   }
>>   int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 5c30a65467e2..09617d7b37fd 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3465,7 +3465,7 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
>>   void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>>               struct inode *dir, struct inode *inode);
>>   int f2fs_do_tmpfile(struct inode *inode, struct inode *dir);
>> -bool f2fs_empty_dir(struct inode *dir);
>> +int f2fs_empty_dir(struct inode *dir);
>>   static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
>>   {
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index cfdc41f87f5d..a3b60d6a58f7 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1846,10 +1846,13 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>           return -EPERM;
>>       if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
>> +        int ret;
>> +
>>           if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
>>               return -EOPNOTSUPP;
>> -        if (!f2fs_empty_dir(inode))
>> -            return -ENOTEMPTY;
>> +        ret = f2fs_empty_dir(inode);
>> +        if (ret)
>> +            return ret;
>>       }
>>       if (iflags & (F2FS_COMPR_FL | F2FS_NOCOMP_FL)) {
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index 13a0ffc39fa4..e4d1821b707b 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -786,10 +786,10 @@ static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>>   static int f2fs_rmdir(struct inode *dir, struct dentry *dentry)
>>   {
>>       struct inode *inode = d_inode(dentry);
>> +    int ret;
>> -    if (f2fs_empty_dir(inode))
>> -        return f2fs_unlink(dir, dentry);
>> -    return -ENOTEMPTY;
>> +    ret = f2fs_empty_dir(inode);
>> +    return ret ? : f2fs_unlink(dir, dentry);
>>   }
>>   static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>> @@ -1001,9 +1001,7 @@ static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>>       }
>>       if (new_inode) {
>> -
>> -        err = -ENOTEMPTY;
>> -        if (old_dir_entry && !f2fs_empty_dir(new_inode))
>> +        if (old_dir_entry && (err = f2fs_empty_dir(new_inode)))
>>               goto out_dir;
>>           err = -ENOENT;

Could you please move f2fs part to a separated patch?

Thanks,
