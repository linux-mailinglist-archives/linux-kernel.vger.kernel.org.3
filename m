Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2556507A95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiDSUER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiDSUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:04:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C316326ADB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:01:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JHlWYw020622;
        Tue, 19 Apr 2022 20:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GVMTbuv3oOTj/7zKWEiuQahlIw1imR7fTFSbjPKMjhs=;
 b=HbTWjM7odYtq81sgoQDAPLSbZk9gkOI3MXm27sYuhBk/MGTNFh+c0zPW3i8T6i3sV9iC
 UXiXzPsDaJ1ZL8pjAbSy5W1HjJRimFEYyoMivV2z0+HvCZI813/KBuRBpTJmXXoejYjX
 ExEAeJWb96nHoZsx6E2vRCBDwI3fBh9sLdg8C+THVCtbSt60DHzKA6KpPI1uMMymyXms
 9rbSUKsWQl3PrJLVOR4yBzCISWMc1XwndRC8qzTq+4yu34Z0B1tfHRRLXjBWO3QqjH5s
 E6mR8IZrL/IO3Nii8nOR71vgJLT4qm5nJowU1BEZ75Tb3x7fl7ueBXDW+Udn4i7vbkrX FQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd1761w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 20:01:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JJtkxa013311;
        Tue, 19 Apr 2022 20:01:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88s22e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 20:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB9yKikSGlFSEHJ98aG0EPzrFWZi6Dgx3/S907mRfSm9Tkk3HoTIpZDbNiTuYfhY7OkKcBGUn2WvMdRgeCdodqDUN9zyjVgkTXwPj3C74ACKKhvM+2rVA0iUr1LEfpBgk0v+yOjgGnNvmn6aK6eAJCGBGLZ7sm9dkwlCNWHbi8bPqrez46y0kcIbqSE8zZcXZ5XeRgr1pv5EQFXhMXymK5z3TKUUotJIwGp2mICguoh2j8YisHWYZ8SQlt0WC8uFoVaSCOVb0euH+JGFvsimgD/KPZ/meqOyelQ4pBHpql4jkSS3j19uucsDg4uDr6wGHqTUHG502VexRZX1WZzoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVMTbuv3oOTj/7zKWEiuQahlIw1imR7fTFSbjPKMjhs=;
 b=Ua6+3yqj65AheV+0Bim+D1DRdxwDTpDeh0hEtbiWWzzgvbzmMeyQHcJ2KGNpWrkpYNXxULaSa0kzoX0DhwAaXXCxiiSi7WE/UFeRgAXGTZ7Uh9aVLlCitjgBSXdlGUrNq1f7M/dWLvpRnxeyfsKBbBx8xpHIs7DRuornntmmERk9SxusH1WuhpLROxryYtjHof+lcN+f05okbpbb+x6QikFz9tbP9zJDethjrFdPnmZjnJb7xdWxMKicUBMGXe0c4fSUcNEytOTF+idll3A0APQvdoK/ltX+ta6oPk6tBY9lQP4bJum7lrST06Ct6fwOxmkuZBMilXcuPEViB8MtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVMTbuv3oOTj/7zKWEiuQahlIw1imR7fTFSbjPKMjhs=;
 b=vG6qeTX2f1c0U6uyMvGDtDI8w1EbyYPu5yXegY7bkIxB+SZmKL5Q50sRcyZUHnY3vxxfIFbai4dKPm2jx9vTyBY4RX2dPcFjVa3ET+v5N6b1kBa8WF0aE8vy45pJNAW07awLxUwKV/2HdUQeehvoIwFNDyyTa2PIcKf7jiWNM7I=
Received: from BYAPR10MB3206.namprd10.prod.outlook.com (2603:10b6:a03:155::20)
 by SN6PR10MB2512.namprd10.prod.outlook.com (2603:10b6:805:47::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 19 Apr
 2022 20:01:09 +0000
Received: from BYAPR10MB3206.namprd10.prod.outlook.com
 ([fe80::b9f4:f66:550a:3cc2]) by BYAPR10MB3206.namprd10.prod.outlook.com
 ([fe80::b9f4:f66:550a:3cc2%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 20:01:09 +0000
Message-ID: <56ed5cf9-f526-79d6-08aa-e1e8dd1852cc@oracle.com>
Date:   Tue, 19 Apr 2022 13:01:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: plumbers session on BPF/BTF support in the GNU Toolchain
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <CAKwvOdmFzNZ_r1itJJkAh-VPMCjqvCCB1DPXSUwUFeeAjoJviA@mail.gmail.com>
From:   David Faust <david.faust@oracle.com>
In-Reply-To: <CAKwvOdmFzNZ_r1itJJkAh-VPMCjqvCCB1DPXSUwUFeeAjoJviA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To BYAPR10MB3206.namprd10.prod.outlook.com
 (2603:10b6:a03:155::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a785f8f-cffc-44ea-1a6e-08da223f588c
X-MS-TrafficTypeDiagnostic: SN6PR10MB2512:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2512C6495E2268A7E674110986F29@SN6PR10MB2512.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14+FAe4BQ1WmjI2Sg5ILth62i5r1UT6XqhOvaI7YcOdIwqPn7FYsTR6URWxV3SzYZJIU+9k3SQPOGtbQD8hLdPA0jYjaXBJ9KZd51U2NaE2oYxLGqnRY/U02o1H0fIc87XNoSy0ynNplSmEyP8j5Tlo7fLKiCgL/xT53HZS2h844kXKJ85HixW1MVPJt7IUY9GGfZTVxXhOG4xSm4RRp+cV3VrHrRA2Qcgn9DABv3Erov3UfmgaRVNv1l1fq+DZ+Ov3NpIpKBgp5NS8aHsox5o6wn5NHh3uqBJO+lZS0xJ8vo8fZPUUoaGIMi7PHB2UCTD/2whEzbL0GMOyGDRm7J+eDS9MF8hIGOsW63p3VmE1twBqmxNQPoLyVFD5Fr4Rg5W6e/YOiBHovjrCjf91xK+wQhnD82zbKsQ+rWCrfTyGvRAIUYdwc9aLrrhrq6e90UTpag/NHLNVidILnQZvasLtpU/gsSprAzYiMVz/5WiywwkhvPfo7zKn0zOBFVOarEXqJeN1icw4MM05ymlLYayOAC9fNUQct6/UAFVKR84POo1CsKpKmTdNt66ldqLrAj75MwxQyNndDD3EW7tTFwGWTNjJJS/kARZCv1FivAzTMIhTRv6wyGcR2ejZ5srZvo1uXFmhH16tEAANeNIXZVnYVho30t8y4wyG/F6a/4PMEuOjGJrr0o6xAQ8SX5wFFklzfokUxgBo1SOxpj3qsHYSjlPcLV3xoVKI/bnZK1gQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3206.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(6506007)(8936002)(2906002)(5660300002)(6486002)(4326008)(8676002)(66476007)(110136005)(38100700002)(316002)(66556008)(66946007)(31696002)(508600001)(53546011)(44832011)(86362001)(31686004)(186003)(6512007)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW42NnE0TkxPdFZGb0Q1K0l6eXRPSlhrN0xYYTVQZWF2clgwcUNaeXk0alMz?=
 =?utf-8?B?YndqZ2kzcjd4ckJucGlhclR0UldTazRZYU9UL1NCcjRtWEhialROSFBwajZH?=
 =?utf-8?B?TVlEbHlwQXoremxZWThQeTAxYjdhQjY3RkhrUHV1VVhPUm1QV0t5MEUyeEZY?=
 =?utf-8?B?eVhseFFKZTVIc0g2NVg1RjNEQnJuRk5iUlVzMlVGM2ZPSjdqQTdqVDFWelBm?=
 =?utf-8?B?SkZjQjdySTVpQVJLZCswd2JjbkxVYTRndTV6dU9sb1J5QzRsRVlBL2JybFl5?=
 =?utf-8?B?MTZleFR4S3VEb3VoQ3FzTHY2QU9rSE1ERXNZRUN0Yk9ONnhZdnluSDV5eUx2?=
 =?utf-8?B?Q29DbDBodFpCYklzcEsyWGVkUzZjV0VZcE8zbGxnQUxLc2xpQWExUzdCVkhV?=
 =?utf-8?B?TE9JdG5ZTUdGZEkrOEdPd2FnV3VSOHpMMk9lS0VqeWNyTzdSZGVnRHNLS3VE?=
 =?utf-8?B?K1pxVUkxY2J2eU1xc29KTllQMlRmVkUvTm12NUMvMHFxUmRsRmJqYXVHK1dI?=
 =?utf-8?B?NDBnTVdKTTEvakNsVW1teFlKRnBlUHhkRm5Ob2dWSHUyOVk3L2E1UXNSZTho?=
 =?utf-8?B?c1R4Z0NVK0gvT2g4TkZ6WUkzdWFtUUF0Smo0U2NpU2IxR0ZqV0I2aEx4U0RN?=
 =?utf-8?B?Um83OTkyMUZvVXlhVTBlYlhmNDlMMEROc1NXbzcyMVVCYVBhckF6OG1SMUQ1?=
 =?utf-8?B?MFJEb28raFpON2hFWElTZHVCUnVPWFdEWEMvN21WeVhoN1lUNGxsMVZoem8z?=
 =?utf-8?B?VmRBZ3VlRTJOY1l1VFhEMkwrODdCSFp5NzdCSXB4Z0pWeE9BaUFRRVAvK1Fy?=
 =?utf-8?B?UHVnQ2pZQW1DbEszcW15c3N5V3pJNi9LTzR0cFNYdFlRY3hkWEVGWVZzTk00?=
 =?utf-8?B?TU5SbkJ1TVoyUlJhUEJhcGptZEFRZU9hNjZUTXRRSSsxdmJ5NG1Rb0JaNXh4?=
 =?utf-8?B?N0FEZ0RQVXFMeWd6WnF0dUdrUG9YaUZkUjZvY04zYkFOejc4b25CamM3UUNJ?=
 =?utf-8?B?R2xuL3RaZFZyVzB3ekdBd1pYNklnSkEyZ0d4V2ovd2VPQVF4R1RSeGlhV3Ni?=
 =?utf-8?B?YzE5TmhHenRoTlJPZ056T1hYUE9MTWcwVWJlb0lpckJaOHVsY2Z4cjkyVVBq?=
 =?utf-8?B?dnV6NG5QZlYrRkhqYlphOGVxbm5xMHRZdWR2Si9TOGxVMXRLaXl2TWp5Z3di?=
 =?utf-8?B?ZVFvQmdrQXRYeFZBNGJ0ZVQxNkxPWGUrNE9aSFcyc2xmV3JPNzI1NzFrZWE0?=
 =?utf-8?B?ckJ2VWphWVp5TEhrOElUckV0dXJTT0NyZlkyZkxIVEhPS3VKZFdJVTRCSkt6?=
 =?utf-8?B?c2d3QTZvQ1JVRGZlWVhKeUlNbnVBRk5QdGRVTnI5L2tvb0w2QUlhUzA5aFU4?=
 =?utf-8?B?aHgxZ2hOMk9UWWlXcEtscHpVZWVRRHFRQWQ1WExWNkVUb2NxNy8wV2EvalFu?=
 =?utf-8?B?OEJvcnozQ0NacEVvL296d2tTRXpvdEFmQ2V4bExXK0V0N05NNHFOVDV2Wldt?=
 =?utf-8?B?RWZaZmhqN1B3V2g5dnY2QjZCNjh6TFdyeUN2c09oYkxMRm9UUFRqVVNuVkxy?=
 =?utf-8?B?b0ZONWNXb3JoMy83OTJVN0l0Z1FIUlZsSzdPNmpqdWlYejJsMldKVVloVFZz?=
 =?utf-8?B?MUgzSnd6bWlEYTZqQkRrdjZZWFhuTEROaFBGWlQ1VENYdGJtL2J6ZUJRUlU2?=
 =?utf-8?B?ejZUVmQ3a1pOd21SUWlCR3IrQUF2YWVOQkFialpaWmNZWEE4cmc1UGlUbGlm?=
 =?utf-8?B?Syt0TVkrSUhaVUdoSGFxVmkyK3JMaCsvb1lvaXVidHJhMVFNb1JjM1dUTFRa?=
 =?utf-8?B?SjFuWnNVaXFsemx4WlJGak1aOWpMRzY0QlNtNUh2R0VaRTlBWGVxVFBORko0?=
 =?utf-8?B?NlgyYk1DbjZBYmVabXRoZmRRVlpVeEVBYlRXaitudzZESVE0RHd1ZGY1c2pG?=
 =?utf-8?B?Ry92OUxRdWpQd0EvbG9hWUdscmVVL3I2OXRiK1ZOYmc2eFhBM3J6emhlYzNp?=
 =?utf-8?B?Qk13QmlGQTcwbnI3b2FpSERveG9QbWlxbERmbDFUNHJoUU43bjlVOUJHK0JU?=
 =?utf-8?B?NjRGaTl0ZFJuMzZySWdGNUowR2U3dk41WUU5Q1VzU2V0MUh1Z0xrbmJwNWl3?=
 =?utf-8?B?VEJMOHNNcUJZNEpnWW00bmJKYUF5eTVTbm1RQ29DVGpaUEhUbXBrTkFxcjlR?=
 =?utf-8?B?eWQyQnVRVXUxL3EwS0hLTTRhUlJ2aU9xUko3VzN3THBJVFVxb0RrYWVqYUxH?=
 =?utf-8?B?NWJuUXoyNzgxcTRWU3pxTHVMZlphckZVOEgxR05YOTJSUjFRNXBMQ2lhbHZy?=
 =?utf-8?B?Q2h3bHZ6OGZXczl0R1IyMERsNHU1QStSUHZaZkZzVCtiVXhrTGFZTFNmOEZQ?=
 =?utf-8?Q?CfgGKiPoFBd+xEA+hebcC7RhnPQIxP8+z+09i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a785f8f-cffc-44ea-1a6e-08da223f588c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 20:01:09.2082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puS6e8EZiruT9yaBxE0GcB0NuqZ8L9t9U+77bOm4KL6NfxHth7+U0VXN/L3sdjmhCYcoRUwyk/BS0y16HZtGmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2512
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_07:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=888 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190112
X-Proofpoint-ORIG-GUID: lUamdIE7bx2YjKLJEZ0-9AwTGVCwPF7u
X-Proofpoint-GUID: lUamdIE7bx2YjKLJEZ0-9AwTGVCwPF7u
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 4/15/22 10:50, Nick Desaulniers wrote:
> Hi David,
> Jose and I are currently in the planning process to put together a
> Kernel+Toolchain microconference track at Linux Plumbers Conference
> this year (Sept 12-14) in Dublin, Ireland.
> 
> Would you and Jose be interested and able to give a presentation on
> BPF and BTF in GNU tools?  There will be an audience of kernel
> developers there, so discussions with kernel BPF folks could be
> facilitated in person.

Yes, we'd be happy to. It will be great to have a chance to discuss in 
person. Looking forward to it.

Thanks,
David
