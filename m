Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01552301C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiEKJ7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbiEKJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:58:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FF61B1769
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:58:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B8os4Y003160;
        Wed, 11 May 2022 09:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u4E3EUEJPYpmoosenrJnoc/i8dae3DOu2tCbNc4MsWY=;
 b=regad6o1EiAxzxZdrvnkcU6lh8sjHsCFl5qqnWS0sESDvG/t6Jq0wg6uaQQlYqET4iyD
 qk/vX6r32YC4uXeoQTw/5pi2c2fpZ+6Gn0yWSo4NiiV1iq9JRSljrI4sQVwLav/mZjp0
 8ScmIqbE90L7wAaB/17RpNiYBMJOpBDz7bATvk8lcsTS4MmTrmTsP+CgL5kGYWmHv+U9
 tfifY8zj9ZYwyTQPJ5dmvSLg5yJjSqOilchL9HDInrDpGcao6q51QXmW9r1gNT3+9Z4u
 qYvFe4DY84veeGR/MZbBpumXa9K8Y2QlMyL0qnR833c4Ep6vNTiZsCIctQxOSbPCZEfe sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04g5np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:58:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B9v9mc008520;
        Wed, 11 May 2022 09:58:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf73w62k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:58:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dmk+vo6EK6t+bqFCgw4hl01AOT8LpSciykfIooKMvBCRwmvAKRU4mYr0T++SEl13jdD+HRA1Siox2dOpiXqqCo+dpmlILSOGXrqDYgFuuZPYges23B43SQADHyEus9/+Fc0ETiCHhKSuJVbEprBnn3VCAe4EQEg50Pzpis+CLExcepAnDHCu79qkmoWbnX8EUqHLJ+jRKfAhVMuA0YNBbJj78n8R2gMhRX9RKZiJ6VJOh9Z7pdBWa60Vw4Tu6OiOjMxusQbyTL31zAXyGj8UvKQsUFLdXuTPVi6kNAp9oHzRsoI5SEPborQj3mRHL1I+0HeCLkARjRdt7rGhFDKDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4E3EUEJPYpmoosenrJnoc/i8dae3DOu2tCbNc4MsWY=;
 b=GYFoLEzeEUkWefCWwW5+SWVpO5vNgiGy945KM/pbyLHmsISRnREtkmGqlGGyCIk2zmTtG43vsdR9mbLYWt55O0wOhQ3SZUhbsCA0ThT5HAT4mP4f/lunJ6jUj+SmQ+Jd+iyvYtX9Sd4eEcxR9tJTRpHmBY6aAPoEaA/PKjzEhsrom2Rqi46BcfCuskeT2TFe1RmSp3hDu3qi2Z4ZOoKF9zaPJF9j0gc6brXfn6xSVEjmZZZN1o72pHyHeKsE6yLhpy8zmv6PVhqn2+5kUVkLX3bOECQo3pSoO6JHdBnYBLlBnSopf/r5NaGKKgxpIamr+Piksto0RvKjRYWHCcx81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4E3EUEJPYpmoosenrJnoc/i8dae3DOu2tCbNc4MsWY=;
 b=es4t5Hy5RuQ3mHrTatfKFSUd/uxJgW2QQUoh+j9sbBE/b+DZncNnxYQCWtKvVo0FXqfhqQS6o4wWiLnhK0oA4bNNsGFkMB4P4qxWW0Udb7G1OcO9unq1eQ0yZRK4eaTaSFkvkQtLrj7m9pc77BxPW2iZ/bUUNIdMJL9KZtCEl08=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB2886.namprd10.prod.outlook.com (2603:10b6:a03:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 09:58:17 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 09:58:17 +0000
Message-ID: <0db84168-5448-7a55-a074-ccd49ef063da@oracle.com>
Date:   Wed, 11 May 2022 19:58:10 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 5/5] kernfs: Replace global kernfs_open_file_mutex with
 hashed mutexes.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-6-imran.f.khan@oracle.com>
 <YnQuH5ijv6bWUKPM@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YnQuH5ijv6bWUKPM@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0026.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::13) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a7e2eeb-5e02-4d1d-eed5-08da3334c5a0
X-MS-TrafficTypeDiagnostic: BYAPR10MB2886:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2886DC4319BF870DA99B5718B0C89@BYAPR10MB2886.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FPThX+S2TNgKBalhk5VtQt/F4hwVqlwb+/cQ3zE8RaLb7MfECtXPA8TlApv0/4gA5H5aulRKM8DXegku0i1bem7HBJB4jNF/fhunCOISuO6zF9I7/c4yrQaQalAATLjshDWqbJEcjUuZDmOJRoXIEpk21J4xwb+oW/cB7/VlDppakeLXcxuyFLzr0V1FMQ1Q5KvEz+ECMC6Xt5yiuklGDTUdUU1FwFP8cu12+YcGcaAY7id2jxNcSIhIqy7mM0TUwPwdLGAZn32SJetjArycDqp1bxXnRDMvuBAILQl8pkR0n9JYrDs7R745dKQqjP7HCot7G3uwwccFqvFRunU4KJzN8j8iQ1IY/HIQH5rSIcb+FPuacYmiA/Jq6hPFxjHsWjQ9Iw4py0Ro6FNCc1FMw2D4lkbQIUCuifVqXleRbPE2zpjEOm/vxB0g/nT7d/x3F8O19Do9fypTa8YnYNoS8JEdTBXz4kf1WFCgS/V6sPXRzsMoNqCo1bRZ/gpjOzKkhOFiyXiuX5hS8a2BdNwst/UsMRw+PbdfDs5HjsJJAYO7MPQ7JEa2iPm6d0rbclPKAwmp23qsZubCroUR2DEKTi+NdWXNp6OipRNtGUAilW78COIGkm0PvwMvZSQbmMp23nhsIJMf17VpyARr2sbcHqXPEc9cEGc6XITyv4RA6jNeT2j3Ar85Sy3piNuAl/WMKA0gvPXYjxsySzKfPvKb4axhqb3f1F0tD4+JPfbCzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(508600001)(36756003)(38100700002)(4326008)(8936002)(66946007)(8676002)(66556008)(66476007)(6512007)(26005)(83380400001)(316002)(6486002)(2906002)(6666004)(2616005)(6506007)(86362001)(53546011)(4744005)(6916009)(31696002)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BnVE02K1pmblFOYW9ucGRwSTU5S3lGaGtFTlFUTFRBZ2U5ams3czkwMWUy?=
 =?utf-8?B?cDZCWWJWb1R2dnVzZmp6MlVnUGJiVjAyMjRoaTVuVVB3SnVpcXRaYWc0Uy84?=
 =?utf-8?B?azQ3b0t1dVBOWGRadkdvWlU1bVhPYkxKd3NFTVZpTnFma1dVQjI4bWg5VGdM?=
 =?utf-8?B?U2VVMGZKOVl5T1k4VFhCY0R2L2hqbkJXQWg0U3MzZnRqVURyc0wvN1FUMmNX?=
 =?utf-8?B?enN3UmNUNnlvRWQ3WXZETjJyUDk2VStjSjJORmc2N2hqTUp4ajNoaXJBRTZI?=
 =?utf-8?B?VzErNGpadUJ0MHB2ancwc2J1NXVJSXhITXd1MjFQYTFYWWlXcXRick1YaEdI?=
 =?utf-8?B?MVhlME9GTFdLMTAySDk3NUcycTBFTVR4ZklvNzBiNENIRkRLTkJyMWhaaFRv?=
 =?utf-8?B?ZmwwQ1NIb01kdkF1MTVkOWhIaEJnZ1RaUTdaTGhCTW5mcUNjd3FENE8xUmJj?=
 =?utf-8?B?djR2ZzBlWVVZM3hJdnJVNW1aUnEwaTlpRDJlV1RORnZpNlczQVA5c0pKeFVi?=
 =?utf-8?B?VDllcU5qYUV3aGVQREVyNzlXZnpSL2toelk5aGpnd291QTJTcHd4ekNZMlBY?=
 =?utf-8?B?MS9ZbEJScE8yWm1aRklqcmNRakhyQysxNU9xd0oxOEhMQk9LUHByWXJManBu?=
 =?utf-8?B?dEdOY1kwKy9MWXZIaDdST1lSckxiR0U0MW0zNWhxZXZNSkdkUHlHaThwMjRq?=
 =?utf-8?B?dUtRK3ArZ2NJMWVCek9GQm42RnFERVNmVzlldGRZemo5Y1oxNEMxeXJZdkIr?=
 =?utf-8?B?WFdOMExJeVhwczMrKzNuV3RERHpmTzUvM0J4VFBOUG1xU080bzdMZUVXeEN0?=
 =?utf-8?B?RUZaUTZjNkEyM0IvcEh5K2I2WmlqZUlCVWY3WFBPTGZ4R2ZjTmJ1K004TThJ?=
 =?utf-8?B?TjdJZmRFTWNrZFFUL0VTMzhiRjZjR1NMRHl3RTNwclIzY2txTXFoSW9zV3N3?=
 =?utf-8?B?NTMyblNyakpnMit5ZWdjazRxemF1eHRtaDN3b0dnTW9NUlIzYS9UTEQxWkhU?=
 =?utf-8?B?SXFTdHpxSGlFWnJRTjZLdWtqaUgwWXlWd1pFRDFIZTlYRnUwMlBueEZxaStu?=
 =?utf-8?B?dlNIOENneFp5NWwydzBjU1VmOVo0WEJGVEVIYzZDRW9KWHYvV0tFQVBrVldG?=
 =?utf-8?B?Qk5HWlFDdmovcHNlT3NXTS8wT0tXbjhFY3pnS3l6TFBuRFluTmY2RU41UUk0?=
 =?utf-8?B?cGUzdksweHBDVVZHZ1hBOHB5NnJ3VWlVYm5aYW0rbHJmR1NDMVBlOVg0cjl1?=
 =?utf-8?B?bExXdlVUU0oveU5HcU1MVmVFdjF4QjVnTC9HNWZwcVQvNmFtWFNkOUQ0cWhI?=
 =?utf-8?B?M1FycUF0eG83cWNYUHlmbFZMVUdTdk0zcU9WVGVvYWdpU0VkeWhsWTI0aG9N?=
 =?utf-8?B?cnhQZWsxOGxWMWlpSmsyZWhjTWZJZDZLc1I1amlCRHRwa2F3bUFRQ1hLZE41?=
 =?utf-8?B?T2F6VzJTSEFrY0Y0ejh2L2RIT3BlR2ZqbXI2WUdEL3pBNU5taGl6aXlSdWxK?=
 =?utf-8?B?aUxsWTNnZXVrc1FBNVZuSDlWVTM5Zm1Pd0dRNE9MUGl0ZVBseFl2TzE4Y0hM?=
 =?utf-8?B?OUlSWWJDaUxXcG1yVEhBaTdseXNFOWRkMnVnaEYwdHhuWlgwRlhEWHlsNXNm?=
 =?utf-8?B?Q1NBU3NEMU44dTVhanJzdWF1UW9WR2xUWENjUFB5dnhCeEFVMy8raStIR0k3?=
 =?utf-8?B?eWo0ZzB0c2FPdThaQWJIbEZuSUZzUEYyUHcrVjBJZGpaUmt0K2VZb3JPOHVW?=
 =?utf-8?B?WitDN2EyeVFzbzVmbldwdjVURnB3YUdBUUs2c2ZXT3VMaHVMTjhKWXNUcnJI?=
 =?utf-8?B?ZkdLMkNOenpGbUQrMDVnUmFHNFIyTFRDVDFlbURXY3RzQ3Q1TzNXT21zci9z?=
 =?utf-8?B?UVlqZ2hxb3ROblZ3bjNVN0JRbE52U0dta0w4N3ExKzRTOXJackF5ODNXYjdh?=
 =?utf-8?B?THR5a0Jqc3kzOXZCWTRLbnJkanZ2cUgrUXI3cklYZG15Nmk2WWJCeHl2aW1l?=
 =?utf-8?B?M3ZOQUxDZGhBejNzbDJsRHppcHU0eXJlTUNtQmg2U3Z1WVIxbVpjYW0ya213?=
 =?utf-8?B?Q3pzSkhMV3o3SFBKanc2MHdVVVlqQU9hZHI2ejJ2eHVuNHFQSXc4ekRTejRU?=
 =?utf-8?B?bjlwZFlhM21ZUGp2QlV5NFNkRVVKSHpaZEl5YTRhbkpxek1FditvZU5kZzYz?=
 =?utf-8?B?QnRuczkvQWpvYXRlU1hUSW5vS3FKZEE2bHI4dHRJRHFkNzM3aFFqSnAwT1Nm?=
 =?utf-8?B?cUhSdFZEbTZUcVdkekIwUDlMZlNwQ1BPS3hsd2M5TU0xVFBYY0JXRTFWQ2R0?=
 =?utf-8?B?VmVoMXJGL2kzb01BY09ONDFDc1JLOUFaZXJvTHdYVXFVc2ZsdFpKN3VLREM0?=
 =?utf-8?Q?H2+7pICNBbirTGPI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7e2eeb-5e02-4d1d-eed5-08da3334c5a0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:58:17.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWj50LJeeOjHe7pyzhzTj/cMdY+xb38uQeVth8GRYCLcpTY3GAM7JA5fZdpyduQbSGg+dNROxFfJ4HHBGuuOXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2886
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=957 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110044
X-Proofpoint-GUID: onAmUq_D4sGObOKTZLw7IP1Qw7rKUpHm
X-Proofpoint-ORIG-GUID: onAmUq_D4sGObOKTZLw7IP1Qw7rKUpHm
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 6/5/22 6:05 am, Tejun Heo wrote:
> On Thu, Apr 28, 2022 at 03:54:31PM +1000, Imran Khan wrote:
>> +static void __init kernfs_mutex_init(void)
>> +{
>> +	int count;
>> +
>> +	for (count = 0; count < NR_KERNFS_LOCKS; count++)
>> +		mutex_init(&kernfs_locks->open_file_mutex[count]);
>> +}
> 
> Does this need to be a separate function?
> 

Above, I have moved mutex initialization from kernfs_lock_init to a
separate function kernfs_mutex_init. Could you please let me know if I
am missing something here ?
>> +static void __init kernfs_lock_init(void)
>> +{
>> +	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
>> +	WARN_ON(!kernfs_locks);
>> +
>> +	kernfs_mutex_init();
>> +}
>> +
>>  void __init kernfs_init(void)
>>  {
>>  	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
> 
> Other than that minor nitpick,
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 

Thanks,
 -- Imran
