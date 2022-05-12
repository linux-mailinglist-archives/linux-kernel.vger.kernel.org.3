Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABB7525715
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358760AbiELVd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349444AbiELVdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:33:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B9720F778
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:33:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CKVRgn010450;
        Thu, 12 May 2022 21:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nTUEzT9SuZ5CxeQjnCvTkwNfFtS4TtT0X/AqyuzdL74=;
 b=QI8PHXPDgaweoA0qRVWSiqBebc61BYS/IF83lq7B/yHpLyDy7q/KCcMymGuRZzbVBtOr
 b+AGxXab7/pSVpieXfSj4l23i5OECHkR7KIaao6rfnboc7phL2aATUMnloH0/bNUP77Q
 liVL8kAR8Zbtzl6I/0VM4hE49LUfr8Vnc4eX/v/yfOXAUb/H8+5p8S5sN/ziAGxtzmm3
 hsFZigAzu/9lqbE8zMQzDWnA6AsPzQyPwx9RoLSrUvZfioLkLWQFvmLX1pbWkEr2m+3V
 RlfyrJmncI3zM53nS2EiiJadn1u/+yx+xEAvCFQbQZOsJIoxuSR6TdkGYl4iORiNuhzo sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6cdma3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:33:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CLVm4K015892;
        Thu, 12 May 2022 21:33:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7c8wgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKTI3OPXI00+trzN2h1mHWYsnLTAmCtrYAVdnTfSJAugBBg4vcOf02Wou8pg65sG8RSw5G29uR/ZXpEGVPWPerdg5/2NHUi0EQcCoJ8wjFrw1UFCfEHbOlZfF5UXmOMLXNt/p4BVt8AHGyGqk5CSMiKlI2AOU0It8J2yE3SDRLCnxeq7PyzCKnyLyi0pHGkUEg+wNAI5M7YXZwqSZZdpxc+UYMmZfLPcceaxLWTUIaQWKqYVTGmaAaNYmDa9pMkSjy94EhB5eGYUvLiqCHyU5b+PjLd/M2MXhlBWi98zX+TL0M4KJr+ZADSgJN/EwbtjZXquEzlOQvB48ixOXzHcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTUEzT9SuZ5CxeQjnCvTkwNfFtS4TtT0X/AqyuzdL74=;
 b=NeRaTA9R86ltvd0ZvZlvGrFirkWq0tVaMYRY74sg9oL/YbDR/zfjOrNfuEdxc3Rrk90lNevdPXt3u5RvWXvZO1wiIsfHyRv3hYAWcwmRCWVXAjWTBPMEy8ZF+FMtVVWWV46Z0opCq9RCz3i48GomNWmziopN63DoxrepUfUmA85zcVOW7keIYmrtaRUvWMXIP7LUyh0G8lxZ0zBh9awOnb+xY7JoaPQ0Kek7Y5xTKglwr+v5grvJUX+lXbJFvDrBdWH/3gi03X4vktiSEw2dqhiLd3dlnKYy9dpuhffxVAa1LXi8yUevyJUrm4QL6CKV+PI5hO6z8tSeElcI3Sw0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTUEzT9SuZ5CxeQjnCvTkwNfFtS4TtT0X/AqyuzdL74=;
 b=NsVAn4FFw1w8jlJMBe/pezaJCtNTCcOLOlE+aenv4jU11GLJKU6t5oyZxlQxn4Cx/793tRf+GU8MTCa4a4bF4FY/jqqloRgsmfhg0GY5BhJKEL5mtaZ2ctriBzztRrPSN3fwFYrW7NxU5rrs7HxeGTa0X/EjRDkrneLxBOkO5oA=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BN8PR10MB3153.namprd10.prod.outlook.com (2603:10b6:408:c1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 21:33:44 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 21:33:44 +0000
Message-ID: <5164c886-4af5-1d69-e0bc-0c30482d5c8f@oracle.com>
Date:   Thu, 12 May 2022 14:33:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 for reference] vdpa: Add support for reading vdpa
 device statistics
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220512054006.3509356-1-elic@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220512054006.3509356-1-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::18) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0be06cd-e94a-437c-6f18-08da345f1761
X-MS-TrafficTypeDiagnostic: BN8PR10MB3153:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB315330EB485E9F3CFC253166B1CB9@BN8PR10MB3153.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LcIcrYqMvcpwgPdapYSuMUacfVbtBHSUD3A5rvATkiUzkG4EYEKAov2g73hmpWQgGyuy6Lsp1kuF+ieSHPnW6R3EV1Ycfw6StsSrcaJ8UanmlYgsaOjcqKDIsm2v9b/9P+FThJMO+XEzj24ozFpQ2zj0RNMf8QLPisr2xYmYmBJKUA2SvHuEjRjmatzu4oi2d2ui8UcTQST70L1OM6b8NADxYvdNJWfrhRY5w68unOYgkTN5V5dGEfCciVvwDeMyFFwndqQ5McytZQh52km2IVr0nim1cRugJmGDYaRpxmkUR1rQhWW4K2pC9YUAn6S2qzQ4aYVudDI7aA8QjoQSynWm16cU7o7VZxcEmMA1pfHHB58hBjONYFDo8XFNOL6kRUxU6L/Eg57wQB1q6TbuLtLh7fsHlkzbybEhEQ2kQbqbZzGL5OLg6JoVKK1Dm8eLdBzip+rnAeA5WC8FPaL5QOzlx5kTyP+H0Hh66HapQ1+yEWVPYibHgGwWzIH9i7wSlTVrDjchs7sIY7B5jxKgt2uDoJabzgwJHLzGw1UoDfSsVeP/sAPxHt6EzvyOq8AIeNWEyCVF0IfAxoKkIw05Oj1C81RXrpLLCYo7/PlRM7rmH2XqXDR+wW4HDRe7GCnKCcBrt0/Zf36IQcekY/m6NWkAbv26B+iqjtgJXc2zFdtlwMbh9klbe2wxDQUzxDFSet3lJiEW0RCeI1zRjHRaFw050ypUfvd01QLhvOTZETwG3+feYjzNLDw1NCiCnhtZ4VZQjcdSW+OwxjPfjSsAZdKYW9BSZvH1k0MxVznSrh4dgHYchoAlQZ3hTgYXpQWhUFkboSktx4h/LnmKfl49gPZyl2vvDky59bi5rjq6AI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(45080400002)(31696002)(53546011)(86362001)(966005)(508600001)(6486002)(38100700002)(6506007)(6666004)(36916002)(83380400001)(26005)(6512007)(186003)(2616005)(36756003)(5660300002)(2906002)(316002)(66476007)(8676002)(66946007)(66556008)(4326008)(31686004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1lkMERlZlhUeVJjOS8veG1JOXJiZDh0b1ZnNkJmM3RFdnJzZXc4Y2FKeHNk?=
 =?utf-8?B?V3UzTis1Q0NiRVhlUmo5RmdnUmR3SGRKWGhhSnFjY0l5Vmh0bW5UWXJraXJV?=
 =?utf-8?B?ZXkrSitJbWNSakx2UVhUdDg4dDBWTTZINzhUdkxraFNMWlpLSld0QXdZbUlU?=
 =?utf-8?B?MHRNc25qWEY5N1hZcW11SG5xNE81aS9YY0JtbTZsQzN5akF4dmdZOC92SEFO?=
 =?utf-8?B?VHhDOUUyMm05M3QzR0JCMTRHLzhwQTRIVnV0VTB3V1VVc0pJcU1sSUVMNFpL?=
 =?utf-8?B?WVg4WFMyZDc4bjhmQWdneFUvMy9sd21CalNHVEtwQStQWFJJZ3VWY2kzMFFt?=
 =?utf-8?B?VXpMSnowTzBjMkhEUnB6Z3ZuUko4UVIvdzhhMXNJblQ4WWFra1FZc1RObjJS?=
 =?utf-8?B?dE56SVU4VGVkQm5mMGUrTGJiWCtpeHpMQ3Q2M3pUK1ZnWjBGVEhEYUpzVkg0?=
 =?utf-8?B?ZGllTFFIc29IOVRUK3BoWlMzY2JHOVl4NFFpM2Z3TWRpTzdHQWZIVk1MeG8w?=
 =?utf-8?B?eElDL25wWGduMldmK3lKbHBZM0M3WVlFQlcyOTNrMFBoS3BTWGZTNXQwdndG?=
 =?utf-8?B?TzQrZXhuU09rSnNXeDJTSjVadUJGcWhwZ20wUTEyVHl0Zjd0Z1Y1bUM5aVV0?=
 =?utf-8?B?Vkt0aHhhdGJpV0dMQnY0eCs5amtTT2R6enErVkZMRHZib1ZNa3pJR1lYTkMv?=
 =?utf-8?B?WVUyOHMvYytFNjUzZm8weGdDQmR3dDNnWFVxM20yT0xRMHl0eHBuYWVHd2lp?=
 =?utf-8?B?dU4xaWpmcDdGd1JCZTVHdkdZeVprNnBkUXk1YURNTjZ0Vk1jZnN0MFNFNHEy?=
 =?utf-8?B?Z1VnRnZKQnJEVFVUa1lsVEJySmNuN3B4NVpCUlJ0L3RIMnlaRWt6K2FpN01B?=
 =?utf-8?B?ZkVlcUEvc2ZWa2tGVWs4aTEwT1VlNnVqTGlTcy9NeXlIcnZrTHU0QlM2Szhx?=
 =?utf-8?B?QjJYVi92ZHY4VktWaWVadFVZMllnRTVqMTVVN2JQSitMamsrOGtDNUZtWUpG?=
 =?utf-8?B?TU5GcnZZQllEU3RoVEplc1YwcVJ2RE9CY283OFROV3hMdVo3N3FERjNhZTVY?=
 =?utf-8?B?LysrOWdSRnZjMVoyMGFNRDd6LzJCQ3RwbFdFdk0veXo2VWZIOFkwRkZxT1c5?=
 =?utf-8?B?Mlo1Zk9PaThzdm5BRWJkNzY4ZUM3MnFRL2dnOFFsd3lzQk9tQ0h4MmVSVHVI?=
 =?utf-8?B?aXlYcEtJSDZxQzd4ek84aHM5aktKbTR2OUl0M1B5MjVTcXkwazFnSE9UZCtF?=
 =?utf-8?B?c2Z0aTcrTzRUTlA0bng5TXhObUgvRFFscEg3VnZwbGZqWUQ2VU1CTEo0Zzlj?=
 =?utf-8?B?Z0xhSTVvcnZvdFpXRk1hRXNYZVNJSXAxTTNtWkRnTXJqa0NidHFMTzlBTERV?=
 =?utf-8?B?bXZVNmRkM1RsNlo4U0Zxb2lXdjdPZSs2RU5kNnhHU21jamticEgvNVdSd1U2?=
 =?utf-8?B?bXc4YTBpUkFVS0JuSjhtcFlqMHFZc3lWSUhlVDBMUWFzRGNEV3E2WERoSnpp?=
 =?utf-8?B?dzZXRUFzSGoyZjlyeXd5MHZlcmpQVzNTanRhd0FXZXIrZXZxU2tLZVhkcU9m?=
 =?utf-8?B?eURTZEFBaS9jSHQwZERLVlkxZGRNUDdGU2FjTGhZOU9JdlNFYmUrSTdWbHhZ?=
 =?utf-8?B?RFVqeUpDOVY3bDV1YVNIdWVxUDBmdURZTlpPQ2VoOHpSWTVyR3dVY3hqL1or?=
 =?utf-8?B?TExBVGw2QjFLK1BYMlVsZGk3alhQd3ZmSjFtYnl3ZEdFUWtjaTAwY2xCeWdn?=
 =?utf-8?B?RDZhUm1iVkNRZGxMTVNTNVo5NE5oSmZNOHcrbjRmaXhlVzdpZklmUTRqcnJP?=
 =?utf-8?B?VVRHYjc2eU1wMVJZZDIwREhZNnUzN0ZaSmpCSFMxQXlVVFQ1WU8zbWo1TTVo?=
 =?utf-8?B?RXFZc0lhQVhpcklQUHJqZS84SDFjL3VsUUo0elk1RHo5VVl3Q2N2LzVkd1ZB?=
 =?utf-8?B?VGFOQ1loQmphTlljNHVGNEJsNm5VMTY4dnVvMEE5cGo0bDhQaXZsVXdSL1NF?=
 =?utf-8?B?NVBva0FTcjlsaWQvaXFzeFduTDBldEpibk1xZHprQ0M5anlEV1R1UWl1U0Zp?=
 =?utf-8?B?UnVkb0kyV3krR1B6ZnBGeXNMSmFtajdiTk1lSmJObTVzMXcyYi9sSTg1WVlL?=
 =?utf-8?B?bEFlbjUvTDRuWDNkL3hJbFZiOEFsSmpYVDZDVXRnOHZVZWlNMnp5N0FEeXpu?=
 =?utf-8?B?Nk5ENXpSenF4YTJvTFBlUWNYWDBlR2txN0ZvVER3V0dnSVgrR3FYMjZMZWp2?=
 =?utf-8?B?ZExBL1RJbGsraGlDMHVJWTRndVNTaWhITE44d1lmaTdhVjlPbTlCOXNFbk5r?=
 =?utf-8?B?NFQrMzVFcmk4M1BwcUlOVC83N3A1b0FaYU90SWVDVkZSL005T3g0Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0be06cd-e94a-437c-6f18-08da345f1761
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:33:44.6707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BB7gtianfGkizWjELwLwoKH4s+HQAaEhDAHRzbmx/unfZ4+baateegVOrIS0D3/bBKR1i1epFk96dd9MWSjDMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3153
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_13:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120090
X-Proofpoint-ORIG-GUID: a4V5qiimdIRoOoHnuHBkpm-oiviKDjX0
X-Proofpoint-GUID: a4V5qiimdIRoOoHnuHBkpm-oiviKDjX0
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2022 10:40 PM, Eli Cohen wrote:
> Read statistics of a vdpa device. The specific data is a received as a
> pair of attribute name and attribute value.
>
> Examples:
> 1. Read statistics for the virtqueue at index 1
>
> $ vdpa dev vstats show vdpa-a qidx 1
> vdpa-a:
> qtype tx qidx 1 received_desc 4583367 completed_desc 4583367
>
> 2. Read statistics for the virtqueue at index 32
> $ vdpa dev vstats show vdpa-a qidx 32
> vdpa-a:
> qtype cvq qidx 32 received_desc 0 completed_desc 0
>
> 3. Read statisitics for the virtqueue at index 0 with json output
> $ vdpa -j dev vstats show vdpa-a qidx 0
> {"vstats":{"vdpa-a":{
> "qtype":"rx","qidx":0,"name":"received_desc","value":490205,"name":"completed_desc","value":489964}}}
>
> 4. Read statistics for the virtqueue at index 0 with preety json
>     output
> $ vdpa -jp dev vstats show vdpa-a qidx 0
> {
>      "vstats": {
>          "vdpa-a": {
>
>              "qtype": "rx",
>              "qidx": 0,
>              "name": "received_desc",
>              "value": 490205,
>              "name": "completed_desc",
>              "value": 489964
>          }
>      }
> }
>
> Issue: 2888554
> Change-Id: I137115fd3db258c5b95fa53dabc2cd4c364a174b
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   vdpa/include/uapi/linux/vdpa.h |   6 ++
>   vdpa/vdpa.c                    | 153 +++++++++++++++++++++++++++++++++
>   2 files changed, 159 insertions(+)
>
> diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
> index cc575a825a7c..7f52e703f1ad 100644
> --- a/vdpa/include/uapi/linux/vdpa.h
> +++ b/vdpa/include/uapi/linux/vdpa.h
> @@ -18,6 +18,7 @@ enum vdpa_command {
>   	VDPA_CMD_DEV_DEL,
>   	VDPA_CMD_DEV_GET,		/* can dump */
>   	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
> +	VDPA_CMD_DEV_STATS_GET,
>   };
>   
>   enum vdpa_attr {
> @@ -46,6 +47,11 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>   	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>   	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
> +
> +	VDPA_ATTR_DEV_QUEUE_INDEX,		/* u32 */
> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,	/* u64 */
> +
>   	/* new attributes must be added above here */
>   	VDPA_ATTR_MAX,
>   };
> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> index 3ae1b78f4cac..4f217993c73b 100644
> --- a/vdpa/vdpa.c
> +++ b/vdpa/vdpa.c
> @@ -26,6 +26,7 @@
>   #define VDPA_OPT_VDEV_MAC		BIT(4)
>   #define VDPA_OPT_VDEV_MTU		BIT(5)
>   #define VDPA_OPT_MAX_VQP		BIT(6)
> +#define VDPA_OPT_QUEUE_INDEX		BIT(7)
>   
>   struct vdpa_opts {
>   	uint64_t present; /* flags of present items */
> @@ -36,6 +37,7 @@ struct vdpa_opts {
>   	char mac[ETH_ALEN];
>   	uint16_t mtu;
>   	uint16_t max_vqp;
> +	uint32_t queue_idx;
>   };
>   
>   struct vdpa {
> @@ -174,6 +176,17 @@ static int vdpa_argv_u16(struct vdpa *vdpa, int argc, char **argv,
>   	return get_u16(result, *argv, 10);
>   }
>   
> +static int vdpa_argv_u32(struct vdpa *vdpa, int argc, char **argv,
> +			 uint32_t *result)
> +{
> +	if (argc <= 0 || *argv == NULL) {
> +		fprintf(stderr, "number expected\n");
> +		return -EINVAL;
> +	}
> +
> +	return get_u32(result, *argv, 10);
> +}
> +
>   struct vdpa_args_metadata {
>   	uint64_t o_flag;
>   	const char *err_msg;
> @@ -183,6 +196,7 @@ static const struct vdpa_args_metadata vdpa_args_required[] = {
>   	{VDPA_OPT_VDEV_MGMTDEV_HANDLE, "management device handle not set."},
>   	{VDPA_OPT_VDEV_NAME, "device name is not set."},
>   	{VDPA_OPT_VDEV_HANDLE, "device name is not set."},
> +	{VDPA_OPT_QUEUE_INDEX, "queue index is not set."},
>   };
>   
>   static int vdpa_args_finding_required_validate(uint64_t o_required,
> @@ -228,6 +242,8 @@ static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
>   		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MTU, opts->mtu);
>   	if (opts->present & VDPA_OPT_MAX_VQP)
>   		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, opts->max_vqp);
> +	if (opts->present & VDPA_OPT_QUEUE_INDEX)
> +		mnl_attr_put_u32(nlh, VDPA_ATTR_DEV_QUEUE_INDEX, opts->queue_idx);
>   }
>   
>   static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
> @@ -304,6 +320,14 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
>   
>   			NEXT_ARG_FWD();
>   			o_found |= VDPA_OPT_MAX_VQP;
> +		} else if ((matches(*argv, "qidx")  == 0) && (o_optional & VDPA_OPT_QUEUE_INDEX)) {
> +			NEXT_ARG_FWD();
> +			err = vdpa_argv_u32(vdpa, argc, argv, &opts->queue_idx);
> +			if (err)
> +				return err;
> +
> +			NEXT_ARG_FWD();
> +			o_found |= VDPA_OPT_QUEUE_INDEX;
>   		} else {
>   			fprintf(stderr, "Unknown option \"%s\"\n", *argv);
>   			return -EINVAL;
> @@ -594,6 +618,7 @@ static void cmd_dev_help(void)
>   	fprintf(stderr, "                                                    [ max_vqp MAX_VQ_PAIRS ]\n");
>   	fprintf(stderr, "       vdpa dev del DEV\n");
>   	fprintf(stderr, "Usage: vdpa dev config COMMAND [ OPTIONS ]\n");
> +	fprintf(stderr, "Usage: vdpa dev vstats COMMAND\n");
>   }
>   
>   static const char *device_type_name(uint32_t type)
> @@ -819,6 +844,132 @@ static int cmd_dev_config(struct vdpa *vdpa, int argc, char **argv)
>   	return -ENOENT;
>   }
>   
> +#define MAX_KEY_LEN 200
> +/* 5 bytes for format */
> +#define MAX_FMT_LEN (MAX_KEY_LEN + 5 + 1)
> +
> +static void pr_out_dev_net_vstats(const struct nlmsghdr *nlh)
> +{
> +	const char *name = NULL;
> +	uint64_t features = 0;
> +	char fmt[MAX_FMT_LEN];
> +	uint16_t max_vqp = 0;
> +	bool is_ctrl = false;
> +	struct nlattr *attr;
> +	uint16_t qidx = 0;
> +	uint64_t v64;
> +
> +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> +		switch (attr->nla_type) {
> +		case VDPA_ATTR_DEV_NEGOTIATED_FEATURES:
> +			features = mnl_attr_get_u64(attr);
> +			break;
> +		case VDPA_ATTR_DEV_NET_CFG_MAX_VQP:
> +			max_vqp = mnl_attr_get_u16(attr);
> +			break;
> +		case VDPA_ATTR_DEV_QUEUE_INDEX:
> +			qidx = mnl_attr_get_u16(attr);
> +			is_ctrl = features & BIT(VIRTIO_NET_F_CTRL_VQ) && qidx == 2 * max_vqp;
Here there's no guarantee in the (userspace) code you could get valid 
features and max_vqp value although these two attributes may well be 
present in the table right after the VDPA_ATTR_DEV_QUEUE_INDEX. I think 
it's with less point to make userspace code complicated to check the 
ordering and fail buggy driver implementation. Why not follow Jason's 
suggestion to have vdpa core insert DEV_NEGOTIATED_FEATURES, 
DEV_NET_CFG_MAX_VQP as well as VDPA_ATTR_DEV_QUEUE_INDEX attrs ahead of 
other vendor driver stats? Then there's no need to duplicate the logic 
for the common attrs in each vendor driver.

> +			if (!is_ctrl) {
> +				if (qidx & 1)
> +					print_string(PRINT_ANY, "queue_type", "queue_type %s ", "tx");
> +				else
> +					print_string(PRINT_ANY, "queue_type", "queue_type %s ", "rx");
> +			} else {
> +					print_string(PRINT_ANY, "queue_type", "queue_type %s ", "control_vq");
> +			}
> +			break;
> +		case VDPA_ATTR_DEV_VENDOR_ATTR_NAME:
> +			name = mnl_attr_get_str(attr);
> +			if (strlen(name) > MAX_KEY_LEN)
> +				return;
> +
> +			strcpy(fmt, name);
> +			strcat(fmt, " %lu ");
> +			break;
> +		case VDPA_ATTR_DEV_VENDOR_ATTR_VALUE:
> +			v64 = mnl_attr_get_u64(attr);
> +			print_u64(PRINT_ANY, name, fmt, v64);
> +			break;
Likewise, I believe these vendor stats need more structured message 
layout to ensure pairing and order.

>
> [1] 
> https://lore.kernel.org/virtualization/PH0PR12MB5481F6D44451F01814470112DC089@PH0PR12MB5481.namprd12.prod.outlook.com/ 
>
> [2] 
> https://lore.kernel.org/virtualization/6175d620-6be3-c249-5482-0a9448499e4a@oracle.com/

Thanks,
-Siwei

> +		}
> +	}
> +}
> +
> +static void pr_out_dev_vstats(struct vdpa *vdpa, struct nlattr **tb, const struct nlmsghdr *nlh)
> +{
> +	uint32_t device_id = mnl_attr_get_u32(tb[VDPA_ATTR_DEV_ID]);
> +
> +	pr_out_vdev_handle_start(vdpa, tb);
> +	switch (device_id) {
> +	case VIRTIO_ID_NET:
> +		pr_out_dev_net_vstats(nlh);
> +		break;
> +	default:
> +		break;
> +	}
> +	pr_out_vdev_handle_end(vdpa);
> +}
> +
> +static int cmd_dev_vstats_show_cb(const struct nlmsghdr *nlh, void *data)
> +{
> +	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
> +	struct nlattr *tb[VDPA_ATTR_MAX + 1] = {};
> +	struct vdpa *vdpa = data;
> +
> +	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
> +	if (!tb[VDPA_ATTR_DEV_NAME] || !tb[VDPA_ATTR_DEV_ID])
> +		return MNL_CB_ERROR;
> +	pr_out_dev_vstats(vdpa, tb, nlh);
> +	return MNL_CB_OK;
> +}
> +
> +static void cmd_dev_vstats_help(void)
> +{
> +	fprintf(stderr, "Usage: vdpa dev vstats show DEV [qidx QUEUE_INDEX]\n");
> +}
> +
> +static int cmd_dev_vstats_show(struct vdpa *vdpa, int argc, char **argv)
> +{
> +	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	if (argc != 1 && argc != 3) {
> +		cmd_dev_vstats_help();
> +		return -EINVAL;
> +	}
> +
> +	nlh = mnlu_gen_socket_cmd_prepare(&vdpa->nlg, VDPA_CMD_DEV_STATS_GET,
> +					  flags);
> +
> +	err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
> +				  VDPA_OPT_VDEV_HANDLE, VDPA_OPT_QUEUE_INDEX);
> +	if (err)
> +		return err;
> +
> +	pr_out_section_start(vdpa, "vstats");
> +	err = mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, cmd_dev_vstats_show_cb, vdpa);
> +	pr_out_section_end(vdpa);
> +	return 0;
> +}
> +
> +static int cmd_dev_vstats(struct vdpa *vdpa, int argc, char **argv)
> +{
> +	if (argc < 1) {
> +		cmd_dev_vstats_help();
> +		return -EINVAL;
> +	}
> +
> +	if (matches(*argv, "help") == 0) {
> +		cmd_dev_vstats_help();
> +		return 0;
> +	} else if (matches(*argv, "show") == 0) {
> +		return cmd_dev_vstats_show(vdpa, argc - 1, argv + 1);
> +	}
> +	fprintf(stderr, "Command \"%s\" not found\n", *argv);
> +	return -ENOENT;
> +}
> +
>   static int cmd_dev(struct vdpa *vdpa, int argc, char **argv)
>   {
>   	if (!argc)
> @@ -836,6 +987,8 @@ static int cmd_dev(struct vdpa *vdpa, int argc, char **argv)
>   		return cmd_dev_del(vdpa, argc - 1, argv + 1);
>   	} else if (matches(*argv, "config") == 0) {
>   		return cmd_dev_config(vdpa, argc - 1, argv + 1);
> +	} else if (matches(*argv, "vstats") == 0) {
> +		return cmd_dev_vstats(vdpa, argc - 1, argv + 1);
>   	}
>   	fprintf(stderr, "Command \"%s\" not found\n", *argv);
>   	return -ENOENT;

