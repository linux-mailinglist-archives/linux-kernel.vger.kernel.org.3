Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27A14F229C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiDEFiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiDEFiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:38:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C4F6D87F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:36:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2350EIv0012570;
        Tue, 5 Apr 2022 05:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MSD6ETzIhx9ZuKGykQFs0o2UxiwGSyTjf5hyhVObuyg=;
 b=CxjRrVDZmemJs+ByMWxnnX2sYqvap4ALApRb1PMqbMATK47+Yjscm/qz1i7hTFKEjUFw
 MImS4Hd75tkvGGDvn2dsukT06iRzVVMla3fuEc/3s+Ql2aGSipGCAky9R8irPra1uS+F
 Nk5V+LNZwulsGHpoqxec45MXpAQx9KF8Z/oO/xiszPp+hm5SJCANKetBYDo6n2cy2fmS
 n4AgL7FaUWlLfKIh0PnQiI7J2+ke7ntKfI6BgX9P3fqQ2Ce+JEoYC7YWwj8f/dhudaBx
 ZNRG66CucjMyMbjSatWP6yQ7QGT4EsboQh4zQdRjB283QjzclcSO/Uu5JTkH6q6jw8pl EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwccy77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 05:36:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2355Viw0030156;
        Tue, 5 Apr 2022 05:36:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx3d6q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 05:36:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk2GzelbgFdtkK58HBYMzDiRFUSWMW3kL96vSQFuykZXPCb7XgmOiBDwRuzvKvNxQ3one+ecUJCEtMaW5zIjfX9Il2bENOkgjLbxJEcGKfQi7XlDdEF/VvOGUB7NpI/FB54zUrhB6appebnK8exIOgJrptfRadq3jPWjqpw/zn2rDPWon3xkbanFBmx5bFwjRFCDaOqs3K8NYHLMk6xzmuqIprfTurBWKNTSf6Zfm3WmLDG40hdIsTRl5gx4Xt6lIcBQqq5OjuHimN7p7faJPC4Gq13SAUPq5k0CMiibizk/8Rjqfi8ONqLLsaHgQISNEeYZSIbTbAqHhue7rLwWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSD6ETzIhx9ZuKGykQFs0o2UxiwGSyTjf5hyhVObuyg=;
 b=igHqQj5kL+9/AvJ4UHYvOqxOryy4tDZjnG+E/h7OZ79dGGuWbS+N0lk4Ozlj5HyzMSAdH5CgpEGKpVYAaVuzyvHp3zugXWBv+0+hI4OGuIdCmndhIqWD9qYWppkHvk6ysdCTSkTHrSq93HvOauIt2N0Zaet8Gn8hQr06e2H/bsXdXi2XdwgyhyuDJgBjemV4D9yhYZrLTy13woEOHCFnxrOTDi8cUn7k4sJYIzOpI8eXR9VX0mfQjPS8YtlTlpPnMC3saYIVzyszGYSbBP58cxuaoU9V9QXithKez5gqs+FRK0KQGpCQIreAJMYlouWgGDEqvic7WiOiQMgDCNUsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSD6ETzIhx9ZuKGykQFs0o2UxiwGSyTjf5hyhVObuyg=;
 b=RbAArNIsrQRc6rfj66XWq8yq4EvRvhW5kYNSHUpBS7zAJ1H5Xl8VQzJgrJYMOZCb3c81i4nx5CufgUem1ozRWpjbxUyikHbBaSKG1Q7+nyIGxuVhlZsXmdxzwZAsbnp9SNkfPPmjvnaPKDRL8P1dWtE5nEagxFoTP/TOeiAtu3Y=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB3081.namprd10.prod.outlook.com (2603:10b6:5:62::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 05:36:11 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 05:36:10 +0000
Message-ID: <10b5d071-7f69-da59-6395-064550c6c6cb@oracle.com>
Date:   Tue, 5 Apr 2022 15:36:03 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH v7 1/8] kernfs: Introduce interface to access
 global kernfs_open_file_mutex.
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-2-imran.f.khan@oracle.com>
 <YjOpedPDj+3KCJjk@zeniv-ca.linux.org.uk>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YjOpedPDj+3KCJjk@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::11) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8f8acc7-b8a8-4855-0cc7-08da16c630eb
X-MS-TrafficTypeDiagnostic: DM6PR10MB3081:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB30815015A323295F40BA6201B0E49@DM6PR10MB3081.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/1JSrh0FAVLCjqNf8ZJF5KXWtshsPA4dRkCXvVXRuGk90pt4Q3JVnrIpoTQLOHkq5ZhG/m5Ol4mIoSVD7Yf/kjmkBSTY/FoMH/JTqDltDhy0kqHpmP1tCWXAB4DuzP5v5F36iT4o+w/hJp5VgknphNuc+GQ3rQssH5gp+37K9PZTzleemPs6mqlUka4Cjm/5Ev37/ajezVTjZQhtEtyg7UrRxVso98XsopYfZUYCbSoudukIvLjz3JeAR8Dq0e2qKL7I7Q/B8iOHOcpdTVYPS/nYoX5rEyFMzrZySHzuuFsSzwnkwddvvT9gtNNQItYodysSQ6WIk8/sNdwiG78Qv/NxJyLlUyZ0lg2/MG+Nrdh8PaGVXUVHfZJdCDFhfnnkJBHO//gNsj9IJ4dIm9y39i2u53xPimcUArs4XMTOcF9GVhKPqYPtjEEzEzORo7r/GG5VC0FdP3j4J/vHpbHLZu5iMx02C5PS0ovcFZ/QWWqVgSnwRcgudw8PdJaMRSwhvkOokJaGxogKJuk7SAl/g3RdgtU2WFNOuO7bYU4IPybOAJ4MVGTM5q6UQQqYTym/ER2SH1dtH5s45h0hEylhg2bX3SVHlvaxgTwq9IkEbxDhD3P9KcWzbJoxk414XKCXiIwizv0d4oPzFXrqNqArIhFyPW7FGurQGDEQDFm+NUkvYdYS1xGI/Nwfn6CX7hb5L6AchIu3vk79rR++gIf4NUTRr9Y/r7fjvS/lMP5yO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31686004)(6486002)(6506007)(508600001)(36756003)(316002)(2616005)(186003)(26005)(6916009)(31696002)(53546011)(2906002)(5660300002)(66556008)(86362001)(6512007)(66946007)(4326008)(38100700002)(66476007)(8676002)(6666004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3d5K1lnRkxrTXVBamJVUFBTQ2d3ZGl1NzZ4b0hLSHZZODcvcEF1SUozSTFy?=
 =?utf-8?B?VDQ0UkNHL2t5T0RzNWNPTXBSRnJNZVBDNFoyTnNXSjd5ZFRVdmUyR2t3YjRr?=
 =?utf-8?B?cjZJWHdoMWpMVlVKbyswd0YwVEtlQVA3Zm9VRjZjMXhXYlBrL0R1R0tOZGRh?=
 =?utf-8?B?cG9qUjVVT3VyQXlCNHFnVm5ETUtCN0lnZ0t3RXE0WU4wdG4zRi82eDZhTWFk?=
 =?utf-8?B?ODQzaVE0TnMxb0tYSGNtaWNpTU41Y3ZERUcyS04zSlFYRzJzWTRVVnMyRmRk?=
 =?utf-8?B?MDVTNDk3TTRoT1hRYlp3SDJzNUxVaExZRlZRY0UxcEFxNnBuUzViVEV2U0RH?=
 =?utf-8?B?bngrdFhwZXFzd2huNjA5S3lzOEFSN0h0OTFTbk1NbFFoU2RJbGo1TSs4b3hx?=
 =?utf-8?B?dENOZmcvMm4rcHFBWU15SWswQS9yK3NFcXlhd04relUwelBYdVMzbEhmRytz?=
 =?utf-8?B?ZE1QeWppQU4wY1MycW1DSVlLdjUycEpCS3daT1FBYUs5SXd1YmRYRjlRMXM3?=
 =?utf-8?B?cFJHaG1wdlZjOXBIUG0rQXpFa216RUdIUWM0ckdNUEZsU0lZd3llaWJsMGZQ?=
 =?utf-8?B?anhqRzF1TGlKRDZPSkFiaEVSQk9hQmZ6aVF0MnlPbzQ3SHRsdGtJNkp3aTYr?=
 =?utf-8?B?RytvUjNsa0tEdFdkdnJLb011azdIN2ZtTkZaZHVqOWhpd05NRlBLK2Rvai9k?=
 =?utf-8?B?NHltQnN2NWF1ejNyMnRBcHJiUGhoWmY3VHJsczYvVENVRjdKRWRjcG4raFBP?=
 =?utf-8?B?RnREOU5wWm5RSlNhNUdmK09rc1BrMDllVEYydm1wL0FobEdKNm03VUFuNEYz?=
 =?utf-8?B?ajNWbGFOamxWNE03MmhWQml6RlM5bTZHYkV6UHN2Q04vT2NpSFRQVjMzdUVC?=
 =?utf-8?B?R1ZOYzFCOC9Fc3o1ZTFpQlhOMWVUdFp4blYxc1BjeVl0SlRRb3dYQVFsRWxR?=
 =?utf-8?B?VTlLdEZGWVQ1dnNMVmJzQTQ2VEtiajhkaDBReUFQY1p5VDJhUUVSanJkWXhZ?=
 =?utf-8?B?WG1hUGVoeXdKZFkvbWJ4WmlYaEFqWTVBckhDSWZWcmducXllK0NVd2x6azNR?=
 =?utf-8?B?SXpwZ1ROSU5uZitVaFVCQVhJbHdWamVGNmhLN1ZDazlZeW1UbnhUN1AxaFdr?=
 =?utf-8?B?M29pQkp4eU9sdWVYemU0L0pGV3FHSE1GZjV4b1dacmFOVkJqTVRyWnExM0N4?=
 =?utf-8?B?N3FuZFVnUzBzSSt6WEJzamYyaHVXQ1d3SFlxUHVuNU1yMEdaRWFnSWpqWUtt?=
 =?utf-8?B?NUtFK0pJYXhaVDhKcjFWcGlieTFzT0lBekx0RVF3SUthS2FPQmVMc0hCY2RY?=
 =?utf-8?B?aFlpS3VkREtQNHY4OTBvbVErdVRmTWx3ZU9MaTgwQThuSHpzZWpTU1V1dWlW?=
 =?utf-8?B?RWlKMno4NzFBUHE1a1B0cERYTEliR2FPYXYxajUwVWhBVmNrazNhaXpHU2xK?=
 =?utf-8?B?ZGRhcVplYUxIYk84V0VlYS85ZW43eWowUnhlQmhBdzJRZWhmbTIvcW8vMytv?=
 =?utf-8?B?dHNJRjUvUzhCQkRrOGpweHppZzVBSk01QXNYdisrWGVJbzM2YzRacDdHWE53?=
 =?utf-8?B?dEJDVlJab3FWWFBoMWgvMGcvTEh6RUxjZktsYkpaZC92a0w4VDhwRE5uTGRa?=
 =?utf-8?B?S2R6QitXMWJJRGNHaHFCc1k5elZTdkxoa2cwRGFQUVNUNFN6bmlOdmZzdndh?=
 =?utf-8?B?QXBhUSttMUVSNWF0cWozaFh0ZDczVWJsSlh6dzhtSjlCN1ovcVdENU5MQm1y?=
 =?utf-8?B?RWlJYkFWNHJmQzdwUkdLc0JXQisxWjlFVlRMKy9ibjNseEpwcU1zQjdmZDVj?=
 =?utf-8?B?dzRKcEVwVmhjNWlEYkcydEtnWDFlemNwTDJ1YVJRMTkxbTVCVDBoM3BnM3ZM?=
 =?utf-8?B?VUFEbm9NMU8yY2FEM0tkTTdCa05nQmg2eEpETVUxZnBXOS9RMFVJaEFFanJr?=
 =?utf-8?B?SnEzZlZ2RzBnd3RRekdnS0pKYTVHMG9pclJkckJMZ216TXdYOEV0ZDF1YlV0?=
 =?utf-8?B?dERkWmZsVWdZUTA5Z1I5U0w4VWs2aFBJVlRjOEFKcVhrY1Q0d0UzYzFHOTZv?=
 =?utf-8?B?ZWxRcVkxN2p2V05OWnZtL0lPaXFSYkRBcG5Dbks5N2MvT0JYdDFnZFdPQnQv?=
 =?utf-8?B?cVNDVU85UUpEVi9uOXo4cVFCZE54VExnZG13T28ra1VKSWU5dC9sOUNBVVNQ?=
 =?utf-8?B?aTVUQ043d3N4TXBqK2I0NGhmYnhmTGI5T1hIQm1sbjR0dUEwRVR1OHhKOURo?=
 =?utf-8?B?T1VuYzgyMk42RGdzeWhNOURqZUE4WEU2ZGpCb0pVSUt6cXpuaXZ0VFFBalpr?=
 =?utf-8?B?NVhDV0xwNjJrNVUrM0ZvNEw5YnA5R0tpVXVWdDZlUlhaQ05aRkpJQ1pFRVFk?=
 =?utf-8?Q?m+HHziQTR7aBeEXw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f8acc7-b8a8-4855-0cc7-08da16c630eb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 05:36:10.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9oVfOWqXnq2fvZf3zua3Vy0Zyd75zcVhtsT16eChvw8fOPihWFPZtB0FeZCIxsgWgbTho467gjHUYzlL7YOdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3081
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_09:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204050033
X-Proofpoint-ORIG-GUID: sLMg-h5rn6iair6kgFWTXxcWM0TkZAlH
X-Proofpoint-GUID: sLMg-h5rn6iair6kgFWTXxcWM0TkZAlH
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al,

On 18/3/22 8:34 am, Al Viro wrote:
> On Thu, Mar 17, 2022 at 06:26:05PM +1100, Imran Khan wrote:
> 
>> @@ -570,9 +571,10 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
>>  				 struct kernfs_open_file *of)
[...]

> As the matter of fact, we can do even better - make freeing
> that thing rcu-delayed, use rcu_assign_pointer() for stores,
> rcu_dereference() for loads and have kernfs_notify() do
> 	rcu_read_lock();
> 	on = rcu_dereference(kn->attr.open);
> 	if (on) {
> 		atomic_inc(&on->event);
> 		wake_up_interruptible(&on->poll);
> 	}
> 	rcu_read_unlock();
> and kernfs_open_node_lock becomes useless - all places that
> grab it are under kernfs_open_file_mutex.

There are some issues in freeing ->attr.open under RCU callback. There
are some users of ->attr.open that can block and hence can't operate
under rcu_read_lock. For example in kernfs_drain_open_files we are
traversing list of open files corresponding to ->attr.open and unmapping
those as well. The unmapping operation can block in i_mmap_lock_write.
So even after removing refcnt we will still need kernfs_open_node_lock.

Thanks,
-- Imran


