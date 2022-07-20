Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066EE57AFC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiGTEPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTEPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:15:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D2B6D9DF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:15:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K02wpu031777;
        Wed, 20 Jul 2022 02:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : references : from : to : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4YBNVusGpdz5SOEFgMufVD6zRMtqYM3KOMIqUWpMezs=;
 b=AMpC7Rfq4q45N1dVyRv4nCwLHo7u6QYainSG0b5ztBTaxLSGAXVrO5bixUM/dESVLf6u
 53xtoUX03j0Da8Eydc/Jj4BXW5vMPgpLUghgdr9waMWOCzCDiygjQu2FYfjrPF2CgY+n
 1c9eJoMIqzzihOipZAR1idNqqyyvtUF1GpQMmDwqpsXFk0XGNb8nGf2XGpYFsqNnts+T
 eegUqpd/tY2B0/KIfEpwPm4lH9AuCgsCMaDPiEx0dti+M+b4DqGi2va2T4E8POpWquz1
 w7CxsK6M4TwA6nNjUKouYlirh7dHXZAGMovKHdqN+ecgkboEdinAUiRzcMgpoBn307Sp Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:39:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNP27S022239;
        Wed, 20 Jul 2022 02:39:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hsejda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM2umOJSaUDnSd+sFJED7wNW+0AUS0wDkJkT9nWcPi+dFfA6ebRsG1Y+YdTMSZ9pkx3QMSgnJFFK2mRLUMJ0rGWRId7/whqK9wtSPKOE+JEuHbjQoe3W9A1DHYCAYF2A4ss5N2YKky/7LyKrLFEWCVmkq1jNlpRWIjexkHoEOH0esTx4SRPqLGCQZ95NN4H7Xybw4il+hbDsn7RT/Glnim/V/3shyK3k5kOq6Yp8AYuB16kn95e2V/D4149SOVBaWmnca8lUS0gFHDOgSoB7eNlADUhMxbeQY3+zHniEzFcwfeI/I2aEqvQzHUZTbKs8iYQbBGJl08yaqU2ub5PCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YBNVusGpdz5SOEFgMufVD6zRMtqYM3KOMIqUWpMezs=;
 b=IF/HHCirVCpr6IHiNfT+d2yFhNby11AgvpGj7RXWveVNDXRIYyLMamGRwSnPYG+uHUj6+gsILuYCfZlknr8eu3VeUjloGYYelF7OfcBrvGb40J/Ak3mzxeXBZGEq/9ZdaVfoD3ucmA3uynCmQ+c+PH6YLGQeo4gicrb0WTr3dPwJeg7qAk/C+CIiO4V4nHeYGJBcHVm/H48n07X5i3gcAGXO9UNOv8NKMtoWrgRhrISf8AMozsWs6TdrWdUe596mUGiUKj2sg7IvlGb9uN3S2aQ6MRgWaY3qLH4GNKIfzL0KPxQ56teIM6YZnM+/I3XHgRyu/yWAihwshKeDiJsb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YBNVusGpdz5SOEFgMufVD6zRMtqYM3KOMIqUWpMezs=;
 b=capiLRAerPqkTQn+R7HoULxCqwZyaG+ixQ3Gje9Q9Ppz8olGCLXSDWeLeUCwL2VE3xqYPEt68S+hofXwU5rHUjpOdnQoHN0rwCBNw1hvROxR7gR18pd1RVwszATDePUDOc2HpyRkzp3n8OH1S8Y8AlM6kwMAZsChhO2Qt0FN9Hc=
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 by CY4PR10MB1350.namprd10.prod.outlook.com (2603:10b6:903:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:39:02 +0000
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::11a1:1f57:5f11:ab1a]) by SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::11a1:1f57:5f11:ab1a%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:39:02 +0000
Message-ID: <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com>
Date:   Wed, 20 Jul 2022 12:38:50 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Query regarding deadlock involving cgroup_threadgroup_rwsem and
 cpu_hotplug_lock
Content-Language: en-US
References: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
From:   Imran Khan <imran.f.khan@oracle.com>
To:     "tj@kernel.org >> Tejun Heo" <tj@kernel.org>,
        lizefan.x@bytedance.com,
        "hannes@cmpxchg.org >> Johannes Weiner" <hannes@cmpxchg.org>,
        "tglx@linutronix.de >> Thomas Gleixner" <tglx@linutronix.de>,
        steven.price@arm.com,
        "peterz@infradead.org >> peterz"@infradead.org
Cc:     "cgroups@vger.kernel.org >> cgroups"@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
X-Forwarded-Message-Id: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0227.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::23) To SJ0PR10MB4479.namprd10.prod.outlook.com
 (2603:10b6:a03:2af::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd14c4ec-11e7-4771-1b6b-08da69f9018d
X-MS-TrafficTypeDiagnostic: CY4PR10MB1350:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAzSdOD1k7sCi6dUUqQbwM+Z2LwENB8OwO+jzXKuDjRo0iwO4qtSnne/n+57Tp6mg0fcjAjQCE8vecNugzfVDHukbyFTlB5VMFl6UUinvvH9YtP+E3Nj6bs6yTeFkPqxiJFwxcClv0YVP6u+BMtp9NdC4oqEU8wPL1eErXq78+uzDEm9Mn38UvtRX7IOeL+Oa5dA5PoxvnnEtTRZo7gRySIr9B69sII+KI4sDKk18mCKF6+L6nRcWRKCwPZ0aBunsHxL6JV7iOpX5CbiOapRDQZpzCRIsOD3npag2QQmCdq/AxLE1o2vMFNFPAH7UtCLZNKswuXi39ddTgOmG/f3wso9nuaWHQZv/QR7rNEwdWHn0MieYXDylwnAM0nVNjIOomlLyKsMj0orJC1HVAf/mfNz+x1CD3eWsdkTOBNz/ljvg7/6wENxYpv8xMaG/73gd2XiyRKr0VZHONcMMt4Og8Jd9xnSzowUdseP0/+1BqD+WCC0PTmCAyra+BQ+5L9L3sg3wCVFvwdk3eCf6caWKtGmhKdHWhnD7U8anGEIY69FVTiHAzEvjcCBOVoerZ9ma686O32/5Y6+7pEVZbXHefWEB2DaTNKUoviMDje7Mv0zmDk3TesTkHC9uz4xLjixVZHObXN6klkoNVK/hoCfmzTweVxtYxmYD/IjOTGILw4YVhKHDL7wCqRixxO736JvOxdO2I9yQywLib0tNP76VoT5EpBsh7mrhPiWRdi89VpKfTuNFgXLXs/ETWnvp5gxk/QH+bs+ex4Da+cgCjdr6JS5erBppw6JSxuAr8A//6q/vN3F+22Rla8DvZRwB7MecUXMOq375OxW/6MfQfm0fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4479.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(39860400002)(376002)(2616005)(478600001)(186003)(41300700001)(31686004)(6666004)(316002)(26005)(6512007)(86362001)(5660300002)(6486002)(83380400001)(66946007)(38100700002)(7416002)(8676002)(4326008)(66556008)(66476007)(8936002)(31696002)(36756003)(2906002)(110136005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0tFS25pbTYvY1ZVU1ZiRFUvWDRPL1JBU1V6UUFhT0hZMUxqRll5WXdOT1Ry?=
 =?utf-8?B?cU9ZQzBzeEF0cTNsa1plR2lCSENVbEVQbEFGNGFEdlBFdE1COFR2VFJMWWxq?=
 =?utf-8?B?d3VOK3JHeVhDeE9sbnFmUnFCUFdvbFZicC82MWViMFFJb29wZ3dSTnVSYlV6?=
 =?utf-8?B?YVNycnIxdWpRNERINEVramFKa2lVL2pWd28zNkpSbnYzN1VJWGFZa0FtcVRC?=
 =?utf-8?B?R1liL1I4aGk1RTN1WkxncndXcy9JNmlSWllhSSsrWEpKNjBTUmdxenlrbzhM?=
 =?utf-8?B?bVdyTXQ1Yk5pajh0Q3BpQzRBR3QxNEhtaUNPVTlyeFRXYXFxWEZxTVUyZnNp?=
 =?utf-8?B?OFcvRkVmdDIrRnJhRWxTSXM0NVlpbGNxbDRvbDZFTS9TcHM5ZDhocHluc0ZL?=
 =?utf-8?B?U1hHWXVuLzhRNnFGZ2hFRy96cWx4dENpazRiVWtyNEVLbGpQUTlpSy9aeExv?=
 =?utf-8?B?c09RVXZhUHUybmhpK2w0NXozOXo4WXNWNE1sUUIzT1N0L2g0a05mb1dOQXhv?=
 =?utf-8?B?Um9LbzVzRzhhcnhWVGR6NTB4ZDRwREE5OTZPaXk1VmpDYzU3ZVJBRGFkR3VM?=
 =?utf-8?B?bzVTbkZ1S2JyOW9xdjdhSGFsZFhRYk1CZkdnS29nVEgrTEJMVzFOVkxROHJP?=
 =?utf-8?B?NlRxN3NONnlYTWw3UU1GeE9mSHhBbG5ZYmJLTno5SHdSb01ja2VHMmJMbjhY?=
 =?utf-8?B?L1NJcUFGS01FNm9GMm1ZL3I1OFJrK3Rnbjh0dE92NzJqYkxtM3dVL1RKZFpJ?=
 =?utf-8?B?Ym1IS1R3bzlVVUR6T3I4TWhOVEgwN3VkTFd0cEJOaXZ4TEs5bWR1elY0d0gz?=
 =?utf-8?B?VUM0TDVZSE9oT3lnc0JSYU1UV0YzOWdjZWhadWgrd1dpNzhwYTZxdlZkTHJt?=
 =?utf-8?B?Q2lKUnVpU3g5VllnZUNFQktpNUxreFBzc0pqbWR1dlNJZ3BTRUFKQU5aWDdp?=
 =?utf-8?B?U2hOWkhFbGpmU2VZNVJGbzFJekpkcmdXMHZMSWFWc2VqcDh5R3hHWGRIMHM3?=
 =?utf-8?B?QlRkK3g5bDRWTnVsak85RWxOKzhadWl3RXMrcjdoeHpKRzNsWmY2Wnk5MWsy?=
 =?utf-8?B?TThVT0NmeUdXWXAwWGlITUNHUHlaK1VWamE5UWdaaG5CQlJrTXc2U2dadklJ?=
 =?utf-8?B?d2lxUDY0dW1ySkY3RG1TMEFjbWE2ZDJXRHpnc0VNbWtYY3lFRFgrQVdVQ2d1?=
 =?utf-8?B?eFhZaTEvRGdNZjJFR0dxUzdMSE9pTnR0VlkzeUdCYVkxUUxTb1dQYUhYbHNq?=
 =?utf-8?B?QzJyQXB1VGI0dENDYTZvWlVKM0tqOGhzUUZDL1h3UnRUQXhzVmFaRFBiMlRh?=
 =?utf-8?B?K2Y3VnJOUjNGdVZyWkR4eDUxR0d2Qy9jY242Y2Jia1hBR2pUU2JkWStSZVVo?=
 =?utf-8?B?azBnRGtZbERkcEFVN1pMTVNqREwvd09Jc3pERzV2QTgrejV1bFNvZXY1Si94?=
 =?utf-8?B?Zjl1SGZuNUk5b0VCTUJ4UUlENktsOFRQN2FDQm1POUYwcFlvTnBlM2lGN1M3?=
 =?utf-8?B?Q0NMblBsR0lETm1iTi8zZ2YrWWtpMXVkNCsrL3lROGRJUGQ5R25KSFF5VFpm?=
 =?utf-8?B?MG1VMjlSV1p0WkhlN3hYNUFQVElmS0lRTVpNVElqVjZVdEYwZ1FqVzBHejNH?=
 =?utf-8?B?Rmg2WUhlYk1hMUZjTGxGVWxRK3p0MVVrOEFtSnd5YWdLRDZ2eEdxL2x3SDEz?=
 =?utf-8?B?c3JvQ2hVcDFJeVZPYWIwR0d1TUt0MU1MYmpKSU82L2QrMDhZUkRiS1J5Uy9I?=
 =?utf-8?B?RVYwSlptQ2YzYUp5VkVkMi9LcTJmeTI5bXc2akg5NENPclJDRG5hVnd2UjVm?=
 =?utf-8?B?cUVTbzFZSUVDQnV5d2hDTUdTQUpkVWk3TnZhbTYwekx6ZjYzWko1MXBYVmR0?=
 =?utf-8?B?bXBwNDRXZkEvK2dhSE41RENFV0tvb1Jzc0NURDJ3NFdELzVGWHFxMFhYK282?=
 =?utf-8?B?cm5ybjJ4Q3QwR1JRQWVZL01zRVY4NzJNbzg2WEFZdnlvd2pDYVhBVjBTc2Zm?=
 =?utf-8?B?ZkhqTzAxa0E0Tk9XV3RQK2ZleXZuTHZjanhRbTNJd09HT0Mya3ZZM3J2OG1n?=
 =?utf-8?B?RFh2d3Q0THpJRDcvakJXd1NraWxyZUZWL2lkWlhMcXkyZmpTNmd1eTdxUWQz?=
 =?utf-8?Q?zQgN47GYK4BbnO2a3qFEauCzt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd14c4ec-11e7-4771-1b6b-08da69f9018d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4479.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 02:39:02.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIkOEXK2bEWqRiphrbbpyK/ii9u0HvCVGmY+4FckOUdr9j15esRMjE9mHXSlprpwpJZTd/eicHmst/q/jECF+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200009
X-Proofpoint-GUID: YH8z01YfBPYmlexsq20nB73j66s1zUsL
X-Proofpoint-ORIG-GUID: YH8z01YfBPYmlexsq20nB73j66s1zUsL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I am seeing a deadlock between cgroup_threadgroup_rwsem and cpu_hotplug_lock in
5.4 kernel.

Due to some missing drivers I don't have this test setup for latest upstream
kernel but looking at the code the issue seems to be present in the latest
kernel as well. If needed I can provide stack traces and other relevant info
from the vmcore that I have got from 5.4 setup.

The description of the problem is as follows (I am using 5.19-rc7 as reference
below):

__cgroup_procs_write acquires cgroup_threadgroup_rwsem via
cgroup_procs_write_start and then invokes cgroup_attach_task. Now
cgroup_attach_task can invoke following call chain:

cgroup_attach_task --> cgroup_migrate --> cgroup_migrate_execute --> cpuset_attach

Here cpuset_attach tries to take cpu_hotplug_lock.

But by this time if some other context

1. is already in the middle of cpu hotplug and has acquired cpu_hotplug_lock in
_cpu_up but
2. has not yet reached CPUHP_ONLINE state and
3. one of the intermediate hotplug states (in my case CPUHP_AP_ONLINE_DYN ) has
a callback which involves creation of a thread (or invocation of copy_process
via some other path) the invoked copy_process will get blocked on
cgroup_threadgroup_rwsem in following call chain:

   copy_process --> cgroup_can_fork --> cgroup_css_set_fork -->
cgroup_threadgroup_change_begin


I am looking for suggestions to fix this deadlock.

Or if I am missing something in the above analysis and the above mention
scenario can't happen in latest upstream kernel, then please let me know as that
would help me in back porting relevant changes to 5.4 kernel because the issue
definitely exists in 5.4 kernel.

Thanks,
-- Imran
