Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677924DA71E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352872AbiCPAxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbiCPAxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:53:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F605C868
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:52:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FKiJue018383;
        Wed, 16 Mar 2022 00:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=D5oGmtdNMTtm5LFPAJodjB22eG2v5qOL+g66G6N6cVo=;
 b=XeI2cQoUJxfDKOWIoB7+DzflwZ7KGeHu66DCQM6g3R1nAmP9W5+9/1gYlBKRZ8jjHgmH
 jfKsCL4pvjpZ0a7N3z6FRNcFVMT5rjOZ3Aj0Wz3QKeya2Xwfk4QYVDH8JI9BgEeL6g6o
 1mscbBBUw5HzWlULgVmr/BzAze5uGXGqHQENg3VmTWkN47MKe+5hUObNHB/p7IpxH40Q
 BS3u25Y680kgYestlEkpQTTcbvhrs9k7Mw6VTosAtr8VZX0lnHHTgmYIDAt7BkNGKt+B
 tBfGECxzaQN1DsYWjViEtMW+Qw6yMiqW8A+rko2M/39KsP31zTplbyRe1lJTCVthqRcH Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwmj9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 00:52:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22G0p2gl019150;
        Wed, 16 Mar 2022 00:52:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3030.oracle.com with ESMTP id 3et65ps3q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 00:52:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZmB0YM4Y5Xjp2lDcXPf0qqLZTzNjbAI6gzICxgEd/VN9wgLBnxOncVdH6Fko/h8IoXFStnseAMiXY0FsyYPWBCxaHHh7/JUb7EB2TIHJNAexoJucc/UjFpV0uSk/jZFQolgUOw3xOx9s4PQ6jkaQrwN15Xg2XCDuiEJwum7KscTVLSuuNyPf3NOyvfwq5TO4VeURc14SMaXZQm+HWfxduAIoc4MCzKJ7OMJ+jhCuT/hiKNMvSb5kPVw4ICQ3+r4HGE5Qz4xPKY9xyoiyA2ybUiLOgLMqo9EAmcqqb+VKvqjrNobOs2TOggvaTt4pVLuIUSKYhaIihWNz/xN6xnxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5oGmtdNMTtm5LFPAJodjB22eG2v5qOL+g66G6N6cVo=;
 b=atz74ony4w9QefwUs1T5OaO4mE3bUPcWwqB2ymscUHFoP3Xs1F/2TR9EFE7jHIgIqwdP+z60aKik2zTuVDhKrgEAcYY/benuVxcIOsVz78fOZK/f6UQilmyISBETbbSAtp/aXa/+jCS2dCMwlZap8sugmSswgMO4aU6QEMC9DKYM+n18drGmiGBm/2pZGjU4V1Fa5f6uCNop+X/J8JOg3Wm9bPJBbg2ferqTzTivIbT4YBJpZDCkDiwUuc6v93C3W342YyvKuU6dJQ4b1C9x+QZDVF5y8NXqDEwq6P93aANKQUilstTjR7L0kRzwcZtFGzA/q+8lIoiaw2eJ5FlhmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5oGmtdNMTtm5LFPAJodjB22eG2v5qOL+g66G6N6cVo=;
 b=q+NQo+SkH+zbNrWhZHcxoW0XH5Bl36LozEALMXaF8AGtQrIffDxXeQHhtWn1eXOH01m0cPs5qUj3kavx5F9QTU02luzqz+KfQxsZpaV/w33gitLPNFp3NZFd3kKzLygIryxOlYc4ocx42qLN99seVYCMG1NPSlFTUVydstb5EA4=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DM8PR10MB5495.namprd10.prod.outlook.com (2603:10b6:8:22::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 00:52:22 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755%9]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 00:52:22 +0000
Message-ID: <30c3da01-5284-6915-cc91-188577ed148d@oracle.com>
Date:   Tue, 15 Mar 2022 20:52:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] xen/grant-table: remove gnttab_*transfer*() functions
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20220311103429.12845-1-jgross@suse.com>
 <20220311103429.12845-2-jgross@suse.com>
 <63365484-7035-f2bd-5317-2e95d65993f7@oracle.com>
 <1633fb91-3771-e37c-14ce-43f1b0cda6a0@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <1633fb91-3771-e37c-14ce-43f1b0cda6a0@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::9) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe94ae3b-ef47-4564-5615-08da06e73abc
X-MS-TrafficTypeDiagnostic: DM8PR10MB5495:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB5495D5707AC814D8FD657D2E8A119@DM8PR10MB5495.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4APOm1SrBtQsYyaX/VOJV0NZ0F8/0rrlsqluUUCxIX6FVHa9JsqIIxTpxDNyrJijtsNPq0VjBX485waIKpFcFA6bBtTAs/uOpF7N9YwIAbjAg/SOfy0/lrBI3ApSC5ue/H/rifi0D5FuWSP3NWMcB/08LFNsgi6lZsRBjotJnKvrlNcXYu3/GyXR2vt97vDm/Ei+u323Y2rXMZNsTG/NHSZLFm4agp3oW7HEJlm4ntPjNRVlpV/3V8GdFo477A+ZvrL0sDBWzAFwAZU1QD4h7clQvF3k1DabC1xwlvdbiX4fV97Pd8L231uwoZ85lQiJNvWvFe6j6J6Vg9A3tYidSH4dNCVZTguJ42gJGv9qcu80QdaGKD+pVhF1PbgjYB6EQGCyGrFQ0FTFRZ1KE79ipZryosGnn5UHAA6u7sY0yQPumbTEUq+Z6scv0eWvhvnN7b1lZv4QFZNzXgGVgwppHYVxqhZN1MOCIym1uj4pSSnJm+KSwu0rF9oHkgMvKjKXMJTUPsAMObSmChEOZukgPFys8BwNwpUuQ2bnVwgC04+ZV7U/OIXG4ZpTxwNEmIwTYhNCXfHhBo2eSFgFsVaeH996hNCASwSXw7jbhVh/L+AMn/t9LWujG4JfGgzlEt9A+p8TMsaLukzo+OWKE77RH4wY7sUFFZpfGtxt7jvwso12axETLftEHR4sbq0p5vIOSZv6UbfINXcK+SyaieVAme98n76AMmWk+8V3pvmugOB6AgA9ymg0S3K2QCzuH0/l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(36756003)(66946007)(508600001)(8936002)(4744005)(66476007)(6486002)(44832011)(5660300002)(38100700002)(4326008)(8676002)(31696002)(66556008)(86362001)(31686004)(6512007)(2616005)(6666004)(6506007)(53546011)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWdyaS9LVEdYV2VNN1lUWGxlQVJoSnNpQStSek1OdytkTHI2MlRWVS9lLy9L?=
 =?utf-8?B?SDJURmxFRTl6Y2Fra3U3UWZEU2tPZDl0QyswdHBRWWRvekdwRjkwN3lIZjI4?=
 =?utf-8?B?bUJaTVBKbW1WVktHZG1oYlcwaWJsMCtUUzVjTllXMytNY3YzelJDN1pjUFk1?=
 =?utf-8?B?OGVESnl4bUlnd0tEKytycTFpUmRkOUxTbXhFdndJbGNQOHpNSW9xVWdwL0Nl?=
 =?utf-8?B?cnI3QlhnMnl0VndzTXM3YStUVUVXMDgxai93Y1Q4L29SOFpiVjE0Y3NKYlVl?=
 =?utf-8?B?Wk5sRHZxdzliMVJKaDhwNVc3ZkUxdTNoVWtuZERaMTN4OG05NEE5RnVGNEdJ?=
 =?utf-8?B?WG5ZSGNWeENxc0ljU3FQMVo1Y2hFL21nRTZXM1FFTEdlL3RtdHhxNDNtVXRQ?=
 =?utf-8?B?MWp3NjRpWHkxT2ZWTDl4ZldVVUp4aUdZVmNTVmVwL0RnbVZWSlJhbUxOVWh3?=
 =?utf-8?B?ODhGbVZpWDhpMTRoNlRQSGZUL0lleE9tdXhJcWsyVzY3c1FwRHJZckd0NUpo?=
 =?utf-8?B?MXREVldDTEJNLzR2QlRkSnIvdkNOTlY4Q3U5WjQyYUpLalZhZ0pOS0ZFdEt6?=
 =?utf-8?B?N0xTN0pVQlk1SzRSZ0g2NC9Ud0lORXRaOVZWTWhDbnQzUHplV0pEM3ZHNGxh?=
 =?utf-8?B?cENHSkc4RUdJVzlRSGZDN2JYRXc2OUExUk1WcUdoMmUxc01CaFpvMDh5L24y?=
 =?utf-8?B?U2hQNWlNMitLSFVPcmFJNXE1OHBkQW5RbWhncUFtY2Y1eHhRSXAzR01NWkoz?=
 =?utf-8?B?QlQ5c0FoYVJEY0M5THhkWlpScjlZdUpRcTJ0bEloa0FFZXZOTGFQRWRadlRH?=
 =?utf-8?B?bk43V0VBbXRiVzFyS0xtMFd1U2F5aU1taDRaYW5LZmlFRzBydTJCS2dDTkRu?=
 =?utf-8?B?bUs4SWJyaUd2ZjNrczlNcUhRODkrUGQvR0NJOXd0NUIzd3lKSlBRQStnVWRD?=
 =?utf-8?B?UkNHMUxVQ2gvbm5TTHJILzYyamNVNEJHb01OV2szcTV6K1pFQzZKZGdteGxz?=
 =?utf-8?B?QnNEVm85VE5yMk5kT202M0J3T3hSb3JyWUREZlF5Z21hdVJJeDlURmp0cnhm?=
 =?utf-8?B?Y1JpazF3SEtLRW1QMDRKN3RQQzY2dmVTWlZtMHcwYUptVnBXYnVobjJMTlhh?=
 =?utf-8?B?ZkVzV2llR2V4UjZmb1FVb3c3MEpVSmpJQ1NCbE1CRng4QVZma3JPNUIxNEsx?=
 =?utf-8?B?Nzh4L0pVdDRIRjBQRlJRRE9GTlJXMEs4RGFtOE1rS0NtOXJGSDNvNjBsdE9w?=
 =?utf-8?B?SDI2eWQrZEMyekJmVDI4dGNjcU9LRHZLMTBLa1dNZ0x5bVZqc29UUUxMclI3?=
 =?utf-8?B?Vnd2THpZeWFmQTlNQVk4RTVSZHhsWnVrZHZSeEl4Y0dmNDh1V1JXOUpZV0xH?=
 =?utf-8?B?cGVzd2x0K25LMjVwSEUvY01MWjJnYWdyc05Nc1dlQ0FSWGdXSWVGY3RjbTZv?=
 =?utf-8?B?RThYemFDSVZTM3RIR3IwMk12aVFXaGJNeWtya3hjc1k5ZUU2Q3M2Nlc2TG5z?=
 =?utf-8?B?dWNTUUtiM1VjaUtRUkVyRUFPWXc3NkdJbjUzTW1sMVYvUHJBMEZIL0xBTTB1?=
 =?utf-8?B?U3pMa25XaUpVQWxXN1F1ZVZ5VjZVSldTdUxVVWRKTmpUTkFTSUtDNUxwQS9q?=
 =?utf-8?B?c0VLSGI4V0xzeUdNekRvTlNDekJoQUpKbktyd1QrQ25jWk1tcVkxYU1TRVVu?=
 =?utf-8?B?NHZ0a0IyKzdyV2RtMkFkcyszUlZMdlVZTFBRaWIrb0x4eDBLd2hMZVc3am90?=
 =?utf-8?B?WjFVWTZVVDhXSklseEY3NHcyL3FZM1l4ajFHNTgrZDZ4UWd6eXdZRTRQTk54?=
 =?utf-8?B?WVd3WEczVERzYkozenBuMXMwYzlhWjJrYTNKY1VsUnlmWjNIeTFSTVRYRXVD?=
 =?utf-8?B?dmF0em5SM3dIVUpXVzd1K0oyUWphY1ljTU5EWXpnZkgzUWRSUmcrLy83S0M1?=
 =?utf-8?B?TVJsT1Y5OFlWQTBqbnNnaUpPVkJGL2E3WmlraDA5eUV1YmlHM2NGTDdmaVVi?=
 =?utf-8?B?WjhqR1BCcUx3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe94ae3b-ef47-4564-5615-08da06e73abc
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 00:52:22.1479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maD0d0gFZLX2CLbALkBrVdSDZAcekyv63DRGWVOUvGpdNoLNgEP1ajkBaxW6GCG08pE5NqL/5DR17NvFlOgj8th/Ok5YfK6DiumgkoumUck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5495
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160003
X-Proofpoint-GUID: 0YRsdI6P-oItgD7VcED4I7DCD-vxJUwv
X-Proofpoint-ORIG-GUID: 0YRsdI6P-oItgD7VcED4I7DCD-vxJUwv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/22 2:10 AM, Juergen Gross wrote:
> On 15.03.22 00:37, Boris Ostrovsky wrote:
>>
>> On 3/11/22 5:34 AM, Juergen Gross wrote:
>>> All grant table operations related to the "transfer" functionality
>>> are unused currently. There have been users in the old days of the
>>> "Xen-o-Linux" kernel, but those didn't make it upstream.
>>>
>>> So remove the "transfer" related functions.
>>
>>
>> Do we need to assert somewhere that transfer flags are not set?
> 
> This would be an orthogonal change, right? My patch is just removing
> never called functions.
> 

I was thinking of having this done as part of code removal (maybe as a separate patch).


> In any case I believe checking those flags is the job of the hypervisor.
> If an operation is illegal due to a transfer flag being set, it needs to
> be rejected at hypervisor level.

True.

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
