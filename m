Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE46562AA3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiGAEnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGAEnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:43:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0B5395;
        Thu, 30 Jun 2022 21:43:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UM47Xw012824;
        Fri, 1 Jul 2022 04:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PZXAvZisTuH8M1aXPN6wTk4lVY+e8mIGZ5Pm7/UQEVQ=;
 b=OqjLzlVrBgRSLRZQEeYF8pfjBz3jl6cL+yagMTRC7DH+eVI0SMeWlOj8JAqJjOldrQeD
 tTjDs/viHLYP8+kDEv9vG7OCXglpKBjmqo9wBHSpFPe8zeSuMrtm0jXlcVD79AKp7V/s
 7y31KW5Fp4TNessvCjQJiEe4KGVcN5rWz2KdsaD1WMzWRk5YuZb8Hn8N26qGq9X9Z2zW
 CTj2zgmmi2R6Eft4hE1Kvg2/teo1fL+A9e5M94kWncavohoT2S1ELHTNOHwLtLHzPVms
 lcAlOwKNymzmuil0ZE8ugC0V+QOt2NivzqUYtyW34zyZiTPprlzV6OPOg2nQgQ1s5CuH sQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwue7ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 04:42:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2614Zgui020648;
        Fri, 1 Jul 2022 04:42:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrtaksa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 04:42:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joDC2TefqESnsqrt06Q3YD6ns2JHJ7UZ8oikRJm4EyRpWtjVy4YQGFDkMTxB4LMwD0Pk32nYlI2Rod8X9zAOZe1MrMfrTlmVQo2c7HDHUzTYa2C1nRRKIDLpNBpLXbZF1PqQCv7TANq4q+c9/9o2hWeRg/fjtx470CmuBVCtsM9YSwmaWAdMlzfyj6+8JTr+/guqDcHDSp6dKvlpOAGixIXb35bjNRqJpQ9nYXKbksdSYPOlMSoEUG+wfivsN4XooFU8xSQwZLcKzZ1kWxbxCZGlb9obSYdBB9c0HBPTmJByUownN4BMM2r6eB5HJpQQyGIkXVGgP3c9mQ2VBRqSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZXAvZisTuH8M1aXPN6wTk4lVY+e8mIGZ5Pm7/UQEVQ=;
 b=gYrs1camW//+vnfFFU0dYYKFPX4QwYw+wSep0UYzLJc5GZWehe4LcRwQ+DrHHAtxGMf4a/P39h3bOtG4cJoNYiHbl+RD0fzD6JC1rgfQEJitEvqrf3Y/Qh6MVci1Vl3ABnBkocP7h5q1vsj0hk4ok5HzqtjQYYdxy+AlAPAKSbTJQBNZWL63UsxY20h1lXQipP2khwm4J1qsJsSRDNB8Qkb1lqyYm/byDQp+SVj8Pcp/FU6ofCIrxKSN1b7jM6CrNIjaYMpAealApznpzHiZ9V/mb4hwr4wb3QUaWUNsmmUDNKxZsYxJdJTPpH87yJDDRRcspw4NTRkD0tlMHFruag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZXAvZisTuH8M1aXPN6wTk4lVY+e8mIGZ5Pm7/UQEVQ=;
 b=LoT7JepWIOpCP1kszfcDax59lvPXG4uDrxYDmlHNWNGAWpuU6Ih3Y2QtJOCkTcrupL8cc16BQIEv/nvNSGd6TgHBnK9xr3/Z7F08m867AGgqBl1Tdgy9lRcD/Y3p8ggNgdqri8/fvR7KmKtIoTcEC0p8PdfSaTrUZEgKCRIs/6E=
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 by PH0PR10MB5872.namprd10.prod.outlook.com (2603:10b6:510:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 04:42:53 +0000
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::11a1:1f57:5f11:ab1a]) by SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::11a1:1f57:5f11:ab1a%7]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 04:42:53 +0000
Message-ID: <0b3c1362-5f0d-44d5-d3e7-c01de59a4e86@oracle.com>
Date:   Fri, 1 Jul 2022 14:42:45 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: Regression for duplicate (?) console parameters on next-20220630
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>
References: <8460ecf2a963c85793cf325e16725044@walle.cc>
 <Yr37D4P2Dmnbkb+M@dev-arch.thelio-3990X>
 <93f5abe324cba9de1bff4aee565f8d5a@walle.cc>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <93f5abe324cba9de1bff4aee565f8d5a@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY2PR01CA0024.ausprd01.prod.outlook.com
 (2603:10c6:1:14::36) To SJ0PR10MB4479.namprd10.prod.outlook.com
 (2603:10b6:a03:2af::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c2dea74-b4c3-45c3-d0d2-08da5b1c28ef
X-MS-TrafficTypeDiagnostic: PH0PR10MB5872:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1TKbL3gWq1JaWVxSzielDkh8L/r3IZKFwXDJUkUJyd4K/ps93WPpB25zl5CGlInYcjEAF+veFRhFWEAGgrm/jiqr2en0n/Z4AHKM+Owd/Elzyr4KiLRofI8yqotPHJBRZY7U09A3kcQHsAVCQ0bdQ7jkzyzhKOC5CHYUVesE2XjA2biGzQAo9JkOm/bbzBABPbfnYKdbANH5HbDyvTeWDONM6Uuh09VHBNMbr2X/4xI5M4SyKpW/WDdO2XDj3EnmdP+ztWKgm/i86EthFxfFKAM6x/xYU6xO0mLaFrg720Y3C+b8ZhIJIRhUTrwYhQ1aQIjx9K4n4rYUzaFzmGY9BVS/5g0fTBecsIlVULCIWdOD7wwRCxpoQcO2mJdGs9gKdL6QmKmqvhg5N+oVilVj9vVNWnvznUG9mLB4GRBNmpk1MiM8N2lpmJLJ2WpTedpGujBUr0ONnGK6/bIrLyvuASd38HYECw7A5TUOSmty9FRgEoZfE46zbd6/lWEVs9lK/sDAQ0Y5OAbfsemigUpGH+fStpWQrCNAcJ+LsN1PcAuh3Tij6iDqwxRrIM++24JUNy+N1K/w50fEOBgY28vYtPA+f4YEo9ZU26gM74Yu5AiClQ+1ihxKSdk3IWkpdDXbmJc2VhbSNRF38V58Nar2o0cwBx2/xDaN/WppiHgIMuDzTkPd5/lQFbjsgmIjG6YLG552TRsnVivhRwFSYK+Ws4LazZ9az/dHQHubsNhyXTEJrAP4ELgSz9KuOb9Dus3tfIib5sZzGp/4H5obU+fr2kk2XCcK3fcjUHvZn6KtHB0SrsU79DtSK54lONI2supOl2X8X1B2FuIAX0nt1tVu+8dUTXCEw/iUYDFNe8PCEC59fT9P5Pjmv+goR2SUiVE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4479.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(346002)(366004)(136003)(4326008)(316002)(31686004)(8676002)(36756003)(66476007)(83380400001)(66946007)(66556008)(38100700002)(26005)(6512007)(966005)(86362001)(41300700001)(6666004)(2906002)(5660300002)(53546011)(110136005)(2616005)(54906003)(6486002)(478600001)(31696002)(8936002)(186003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1F4ZjcxVUFiVDhFa2FPL0VNSHAzOGp3bTVYWXJtNHV2ejhLcXpRUVZJSndx?=
 =?utf-8?B?OE5mK0x3SEttb25EVjc3bDFNdEl6UGp3UTdtc2xNVGFzTXg3OE1IUkN0RmMw?=
 =?utf-8?B?TVFqditlc3oyc0hBU3JIMGpQTUNqUVJxTHkyYzFsRkJBcGhkaFZpQ0RiSC9I?=
 =?utf-8?B?OUluUXJVTHE1eUc1ZkY1MkxxUWszOUdFTUoxZ1BiSUZMUTByV1BLejh5czdp?=
 =?utf-8?B?R25URTI3V3NDVHJPUmFhU2pXNDk4TzdkcThNajdYMkdxWWdYNzQwTTRxNWIy?=
 =?utf-8?B?aWE2b3JGWXJBWVZCYTRhSjBsMFhDS1VPVGYzRFdWM0k0eGNPQzRDbmRYb01s?=
 =?utf-8?B?Z3NrcUNXUEdKRmFlWEhaMXpITUt3NXU2RTFOTTBjY3VndThyYmMweExOODhV?=
 =?utf-8?B?b2tLZzRLeCtZWjN2enYwYU5pek4rRmFlODgzVStuay9YU3p5N3BkZ3Y1bVow?=
 =?utf-8?B?NWl4eXFpZ1lndUowOXduYlFpQ2pRZXd1ZjMvRVJ0WDlKWTNWSWJsL1Brcmlx?=
 =?utf-8?B?QTl2N1lpU1huVWlUMHlud25yZjdSbUthTmdpTTBmNk4wangwTDZYQUhrTVFs?=
 =?utf-8?B?ZWZtcHRzMjhVWVRQVDF4V3FjZXF6Zk1oS1dwYUl5N2owaVJKc25uN1o3Ykhx?=
 =?utf-8?B?MGxzL1BCbVUyQStKTU9VUTd6Tmx5clNsTGhlYjNRTGxpRU5UeDlGSU9OU3ZU?=
 =?utf-8?B?azBZR1BvNlZGWlA1ZGs1YUtsY1BBVmR5amd3WUtqbmVQdEpXMllpSnFlL3ZJ?=
 =?utf-8?B?QmoyVmx0K2g5eTg3a1lKVUVHaXJYdElrZUJkS0pURWpkWmtlSE5Uejd1Q3lS?=
 =?utf-8?B?REx0QlBsb3NhNUlSbC82OVRmTXZiQWs1aW9GYlVkaUpXOStjdVBFdDBGSHo2?=
 =?utf-8?B?bWNmdVoxYnBCaUR2YmxibWxTaUg0SGpyMW5XaFp2cTJIem8veGpORW5rSWYx?=
 =?utf-8?B?RVhzdjhkOUhZNDJVOG5jWWtqQk85Ym5YZGxDcFBtbkxuQ1p5NG1jSkE5ajVw?=
 =?utf-8?B?VURKaElqRWhuTlhrUVlqUGlCZ0MvQzQ0OUZuZE1BZzZrdU1CbGh0M1owT0dQ?=
 =?utf-8?B?R3lTejFMcW85enN6Q3cyd2pKQ20xOXYyWUo0RTB1VUh5VkRmZ2xBeThxSndm?=
 =?utf-8?B?ZUlGTmpxZjBFMnJidFJBaDRtOTRKNHB6dkg3WWJEVlpWZ2R4NGpDWFk0cDgy?=
 =?utf-8?B?UTFkU0ZZK0xocm5kTVJ2ZGl5cVlscTVnQTlmWkJTKzJYSGJRQmRwTWkzZVBW?=
 =?utf-8?B?bzY2bzhsWTliNGdMMEt2Tyt6d29oMDJmM0ZiWmNkUlNpTGFPclZrWXkyejR3?=
 =?utf-8?B?Nkc3cVdrYzlMMjhrZjVpT2tvQWJxbi9uZ0xTMDB2K25XZVp2dlAzRi8vMUhs?=
 =?utf-8?B?L3czcEhiWFRlYXd6ZStuWEMzcTRtSDFPVS9VOGV1VUZzbkJHVWJvZmFKdys0?=
 =?utf-8?B?Yk9tN0taZ1NWdWgxOVM2NFNhWmJtazExakpjd0o1Z1ZOdzFYVHhadEFPWVNF?=
 =?utf-8?B?QWtPQmdocjJaZHlBVFJPM3Bsek5TNytFUUdHMmlNVnR1SWUzT0oxV2g3UlN0?=
 =?utf-8?B?SS95RTBwZEJOdnFFdmQ5Sk1wNkI2Yi9VNEJuWVRPQUdzamJrNzh2WDhHWUd0?=
 =?utf-8?B?ZlUyVC9FV1RiMDIveXQ1anNoSS9mK0lEem1RRXVIcTg4Tkd4NVE0UldXeGdO?=
 =?utf-8?B?RndNYnFqMkpST21pN3ZCNHRROGFxQ1Z2S1IvcE9kWUtTZldmWjdzdDBuazU5?=
 =?utf-8?B?Zk93cTlIelJJQytiaXNVUmtuZW44VHBrd0JSV2RmaHhUS2hXbXVqMlc1aENv?=
 =?utf-8?B?eWFaeUh5dWZrSDZ4cCtkZ2FsVm9nRFdtZWRoWGZ4UUwrQUZwZXIrZDlKNWRh?=
 =?utf-8?B?OXVsdmN0UG5CckxqSlFMeDN2YU1LMng0Mm1VYzJtay8vcGN5cnN1dEgyQjNu?=
 =?utf-8?B?VXhHUGo5bUNJSTRETDNrbXNobHRBTWxDZm9jMDRBTzFMNnJYMkRiNFMyNmVS?=
 =?utf-8?B?NGFTMU92dmFCdjhVY3ZMcXZIdUZtVjhxSHBPc0hRaTl3cTBaaFh4STZoWjc4?=
 =?utf-8?B?WGtMaWgwdDdveHZ1SFNTcUp6alFyRVpDa01jUkdkQUIrYTFBYUdQaTNUSDFv?=
 =?utf-8?B?U0t5RmozdS8wMm9yK3Z6REZaUi9BM3dscEZ0QkNnZjI0dE8xazBuYnJreksr?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2dea74-b4c3-45c3-d0d2-08da5b1c28ef
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4479.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 04:42:53.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7PkQODgGcD/uWSZ+L9uxjFTGU5X6iJySJ7tM1EDeBHaAR36/g8v3gfRU7pAn2mer7269t0ikRhXFGOCN92P/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5872
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_02:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010014
X-Proofpoint-ORIG-GUID: 64SkOu9VkEmB1Unf3OLSoc8EizaZkHf0
X-Proofpoint-GUID: 64SkOu9VkEmB1Unf3OLSoc8EizaZkHf0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael, Hello Nathan,

Thanks for sharing the test result.

On 1/7/22 7:18 am, Michael Walle wrote:
> Am 2022-06-30 21:35, schrieb Nathan Chancellor:
>> On Thu, Jun 30, 2022 at 03:11:58PM +0200, Michael Walle wrote:
>>> Hi,
>>>
>>> I'm not sure it these are the correct recipients, feel free to CC others.
>>>
>>> Since next-20220630 (or maybe also since next-20220629) I'm getting the
>>>
>>> [    3.707900] WARNING: CPU: 0 PID: 38 at fs/kernfs/dir.c:531
>>> kernfs_put.part.0+0x1a0/0x1d4
>>> [    3.716313] kernfs_put: console/active: released with incorrect
>>> active_ref 0
>>>
>>> on both arm and arm64 boards. See for example:
>>> https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/62bd840b330c4851eaa39c16/__;!!ACWV5N9M2RV99hQ!LGrYRXVZCYKcB-xmJ52QGhidx1F_PJNpJPqzVxrbFnprXCDPx0p8f7uqnH-_pc0KrO3alOkTJuvOm2q2qzA$
>>>
>>> I have the console set in the device tree as well as on the commandline.
>>> Up until recently that wasn't a problem and I guess that should be a valid
>>> configuration. That being said, the warn() will go away if I remove the
>>> console= parameter on the commandline.
>>>
>>> I haven't had time to do a bisect yet. That will probably my next step;
>>> or maybe kernelci will already do that for me, Guillaume? Unless someone
>>> has some more insights/ideas.
>>
>> I noticed this as well when booting ARCH=um defconfig.
>>
>> I ended up doing a bisect against next-20220630 and I landed on the
>> driver-core merge (5732b42edfd18ee888e127fa13d425ed3ed1bef3). I did two
>> more bisects to figure out that there is some sort of contextual
>> contlict between commit 5831788afb17 ("Revert "printk: add kthread
>> console printers"") and commit b8f35fa1188b ("kernfs: Change
>> kernfs_notify_list to llist."), as it is only when those two changes are
>> present that this issue occurs. I am happy to provide more information
>> if necessary.
> 
> Thanks for the info.
> 
> I can confirm that reverting b8f35fa1188b will fix the error. I couldn't
> revert 5831788afb17 though, didn't apply cleanly.
> 

I tried to reproduce this issue on a qemu ARM instance (-m vexpress-a15, rootfs
based on buildroot) but could not reproduce this issue.
If you could share some more details about test steps/setup it would be great.
In the meanwhile based on the stack trace seen in WARN message and reverted
change, I think following change should fix this issue:


From 6bf7f1adc4b091dc6d6c60e0dd0f16247f61f374 Mon Sep 17 00:00:00 2001
From: Imran Khan <imran.f.khan@oracle.com>
Date: Fri, 1 Jul 2022 14:27:52 +1000
Subject: [PATCH] kernfs: Avoid re-adding kernfs_node into kernfs_notify_list.

---
 fs/kernfs/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index bb933221b4bae..e8ec054e11c63 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -917,6 +917,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
        if (free == NULL)
                return;

+       free->next = NULL;
        attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
        kn = attribute_to_node(attr, struct kernfs_node, attr);
        root = kernfs_root(kn);
@@ -992,9 +993,11 @@ void kernfs_notify(struct kernfs_node *kn)
        rcu_read_unlock();

        /* schedule work to kick fsnotify */
-       kernfs_get(kn);
-       llist_add(&kn->attr.notify_next, &kernfs_notify_list);
-       schedule_work(&kernfs_notify_work);
+       if (kn->attr.notify_next.next != NULL) {
+               kernfs_get(kn);
+               llist_add(&kn->attr.notify_next, &kernfs_notify_list);
+               schedule_work(&kernfs_notify_work);
+       }
 }
 EXPORT_SYMBOL_GPL(kernfs_notify);


base-commit: 6cc11d2a1759275b856e464265823d94aabd5eaf
-- 
2.30.2


Could you please verify this in your setup? If I can reproduce this issue
locally I will try myself as well.

Thanks,
 -- Imran

