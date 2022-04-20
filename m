Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B5C50939D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383224AbiDTXdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiDTXdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:33:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141C72E6A2;
        Wed, 20 Apr 2022 16:30:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KKo3HJ012445;
        Wed, 20 Apr 2022 23:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mQO82Wn4XppUol32Qb1YNHx61g8ilIgnpNBkKNo4Jpw=;
 b=qPXR88uCfvxJc30lo6txhzcVMTd3ZugnOI4GYZQgBOO1SsqAjdlF0df+hgUH9hLOH7Ml
 FP8TOkET3pvuPEycblQGTnucEItj/EsKhJjvKuGswQC82FFf6NLQ7/7Y6XXuH/xRwUQe
 3zK+exOLzchz7+N99bQOkzSSj5YXU1kiVYWeuiJPWr6fYzpvabrITVROCmDposRw3p+O
 fhnBqJbP1xsSJOHBgBhNFBun/NDTc9O4tSd3qtp3W4JB0YXmYzsc3O6m0odB8K/R+K8g
 72y08gYCKo8/WismMrfMutRQNllzCM+qxl88j/j8xnjic+vS1XSgdZgSyqCahe8B3iDA Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbvar9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 23:30:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KNBoRY018379;
        Wed, 20 Apr 2022 23:30:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm887g2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 23:30:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIQkMaN59k74EXleTtx+I50Z7tvtpkUbYxAq74OZaldfgsJSj50yAmbIx0P/LCR2q7wLHZMNdALrNUhvJqhETpqmVIJGnXuf9iqPqYZ317YESuCdUK42khyl5EK/IZIa27tJ0TGbbAewBNSLWefNH04U4sSgKFAm//HjuAvRD4zfOPow5rSnOdzOfqI3/s44NjJWy7Eyow126jpWR/uYyQPWwQ9abtZBPgk+5lnPQPoYhmKd1HFfWYTMv1qjl22Hb4cUiHONnXsNNDtnjrsqdp42PkYj7JdPnUlctNXUHxxP8imobyGW6I7avNaUWf0IEfRi16+m8/4FS33z/bN98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQO82Wn4XppUol32Qb1YNHx61g8ilIgnpNBkKNo4Jpw=;
 b=W73mz6EBaiMxH/FkGiR6mT+gF/ske5Ee9DFT+rPnnYT1YHI0slZADKsbyKaigtAiVFhTBwXHL76QT7wE/6HeMEw9t3EFuM5KnhC9SsdaF8GxRJ9gBG8RirsnQJzBxr9QARuMTqcE+igCFwrHp1jvBAhc5iL9w1OzntPq47SRUF29Kj27LhE6vsV8wsNVaC7yTibobfRX58TyZqhipIVbIem9KnAdjsVAfkFUOpX2UCMuPBMsCtLNInnEI0atQr3OgRoJVw662N7vwy5ePcNcUd6nyyJ8gt/v9/vya8iGux4RfEup1z2DRvR1P9pAPRkN7hSSC8ESgE2G5CV0Qj8ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQO82Wn4XppUol32Qb1YNHx61g8ilIgnpNBkKNo4Jpw=;
 b=MGJRGwjKFMpZacpqfwYb/QGOw11Bi5tzrsWLKb568YPhAbH1IOFvTQAfLMN561e8ymEoGUWUE40FbpAxl8LgqYuH9v+oDQ7eL9meagBYOm8PJa+23zvXUWUKRg9lLqROSX91sEkjWrjrUOyUn2yMBnXR12+SsaunMZgyEFaeJsM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5740.namprd10.prod.outlook.com (2603:10b6:303:19a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 23:30:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 23:30:04 +0000
Message-ID: <9bd9c89a-b2fb-04dd-0aac-c42f2ee9e1a1@oracle.com>
Date:   Wed, 20 Apr 2022 16:30:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v8 1/4] mm: hugetlb_vmemmap: introduce
 CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220413144748.84106-1-songmuchun@bytedance.com>
 <20220413144748.84106-2-songmuchun@bytedance.com>
 <CAK7LNARNyYNMMYcEwU-pVFb-b21cKN+K_jwseLTtoOfscS2Ggw@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CAK7LNARNyYNMMYcEwU-pVFb-b21cKN+K_jwseLTtoOfscS2Ggw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:303:dd::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85b4d73c-ed0c-4344-9f88-08da2325b2c9
X-MS-TrafficTypeDiagnostic: MW5PR10MB5740:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB57409FEE3241B1E786EF03AEE2F59@MW5PR10MB5740.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Oi1nHK1HJuamYbYAwXojIc8eIGlPKyuyWnBZzjq/UV9giIJCdA+KkXQePEdlH0UHoiPBXD79BoRF86EpV5ctzTzIGKKeC7EpZ8je5cO/YWkQ+s+P5Qd+kGWS/rCPUQxexNKHqWdGisDQnjuViTlLQGTrHsj6bvKqKTdnqcMHSuTjE9+Z0T9lMAMONnCtBDy1vtkBM8D3GUDy8Y8pbZfQu+cXeOGJ9selnHLoiYyhzz7taxXmHtvZ0w3lkXgh9W7s5cQmxoxofo54uWzS8wrGNoZIMAGovOiw+E/XZa7ZvkXdmA81F/1a4TSG2XumxKesq6srfH+4NAZD5v1iepRb9tUG8ONI1pLhAUKFeus0YMCygVQ2nHTvm2gLisShQUPLf9mpRNEKHhVDRvQuD8e+cRjx8Sid/TFfaBMDBMucxL2T6o3jQ1Er4tQg1OUlEgxuQf21Fs87RNxAiITqYNH6xYqtOxLQGs/a8Xh25U7fgejTXT3rR9Q0PvKAIRZCkrSDKWsKgmSr7QJspzped9xyDQ8QkGrnYvhrXAGMjXEBTLdZ0gj6qnwEx7+1bQ/ihJGb/6ePV9soRdcyZfdc+O6HTJLdqP5L0FM5dpnQbF9oRD6yg0pkDbpabNEvTzKSe+HwGfIzl4jiFS1da1t4midZXWbMwt2EkaPYZH7sAOKF+o+2q47D53k044szOvCEEIEMSIW3frHDCBuq2c0VL6Rx12FL9cv7tA2TN2hOyZRptuAdf8oNh4qLXQFqhj7h9JgQoN8WFdNb/v4Fy6RlhkapA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(54906003)(44832011)(110136005)(26005)(38350700002)(2906002)(38100700002)(5660300002)(31696002)(7416002)(8936002)(2616005)(31686004)(52116002)(186003)(53546011)(6512007)(6506007)(66556008)(83380400001)(316002)(4326008)(8676002)(508600001)(36756003)(66946007)(6486002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJXUENNTjJXT1I0akhvZUNaZ3ZRQXNPVThOVUl0QjJlQlJ0SlVKU1ZQSXJy?=
 =?utf-8?B?Vm5LL01CTWIvTkRaTUkzaVpOQzZxcGxDVXpkWDI1Tml3S3ppU2VYQ3J2ajRt?=
 =?utf-8?B?d0tNOEN4d3luRFEwUDlNbkVrUDArekhVQUtGYmVzSEcyaEIvUXptdTRoRVZ2?=
 =?utf-8?B?YVExc0llaG16bVlhc1pRVzJoMVc0QWowZkZ6dytEblYycGZNNFdMR1FPQnJL?=
 =?utf-8?B?MEowZmpCNkhqaFZJYVFCZ0tSOXBpWCs5ekNOQnozdzFCekV3ZkUrOWlleHk2?=
 =?utf-8?B?cGhjV3p0TU01NkVLRTlRY05mRzhSQnlpSG81ZHh3RW85eG9abGZNMVF2VitN?=
 =?utf-8?B?U1l1MWdNaUpIUE92bXlKOGxyVk1mRW4zaE85UGZmVHdETXJzcFdqZnV4dTY1?=
 =?utf-8?B?SnlrSFhteTlIcUFBbGpyTk50MlpjMTc1WUZqaTNUdnFWdjRNbFErQmtDd1Rj?=
 =?utf-8?B?YXRqeVFlV1NJT2lKcDNnOGxGWlJRdUJuTW5YYTVobExkK096WW5ocXBLSjBk?=
 =?utf-8?B?cnkrR2RZd21LUmlPOTBPRzFMdFRUMWNSMGxxU3paOVhuTzY0SlYxZEJYWVds?=
 =?utf-8?B?WHZKQzQwcXVRZVZOdWtYcG1tMDFDMmVKLzdmdHhKT2RLNWNvMTZDSFF6L0pE?=
 =?utf-8?B?L2hOY25zNWh0ZlJXdnB2eVg4bkQxd2Y5YytHUzZlditDOTdMelhrWGpnck5h?=
 =?utf-8?B?d0N0dHRwTTBIS0hRbnY2bXNmZHc2WEh6dUdXUHlGVFRpNXhjdUZNTGw3UXhQ?=
 =?utf-8?B?UStsdUVBSnBCWHhUejV0b09WNGkvZElZSG1hUWtPKzcwYSt5RTJXbEpENVg4?=
 =?utf-8?B?c2N0M0NmWlpYb3V4eE81aVhPbzRCMGJpNVd3ZWRacS9nYkVYOG1PeE1ncjZF?=
 =?utf-8?B?TFBXdEFWMGw4SmF5LzY0dDREN01FdzBSa2JmQVBNcmRmeXRUakgwa3N3bTlI?=
 =?utf-8?B?cytvb1NVUzV1T0xlTExVNlB1Z1B4aWJBSnZYSDNUSTcxbWI4UFY1ZWVXS0pi?=
 =?utf-8?B?TW9rRUNlZ2x2NSt2T2o3UVoxWk50M2pTSGdSSWhkL1Z5VHZFTUpQcURsMFJN?=
 =?utf-8?B?ZVJrWGxDYXBMZnk0Y1JWc0hqb0VsV1Y2bWlVblp2WURNaGR6K0RyWU9jU2sz?=
 =?utf-8?B?ZHQySjBwZHBZdmV6N29yK250RWh2ZHIwQWNOOWw3VGZpN1BhR1VvQXpRTHZB?=
 =?utf-8?B?L1k4WWxTT2xxTkFWVURwa1c5bXdmckFVQXNkZW5DSDlLNnU2VnlXenArT3Fq?=
 =?utf-8?B?WHA0VEhYTFFnKzBaWHppUWJscWMwMUVWNGVPeEQxaHFvdjdGTSs0Y2NOeGdV?=
 =?utf-8?B?czhuRGRkKzRqc0srNVRUd1dkT2JuczY1WVpSZ1poajdoS3doNTVDWEJNRjVD?=
 =?utf-8?B?VTNwZGJzRURrWHZBaUpSWlpvakY4RUxCQXp1eHRYbWJwTHNEZ1RuRG5MNHpS?=
 =?utf-8?B?bjJTRXBVbVRRellqR0RsYndUSmVYTCtkYWRHbWJMc3AyZzZWMjl1YUFpY1pz?=
 =?utf-8?B?ZmptRmJEeWpINFN6TEhDRHhpY0J0a0I4YUQxeERKUnFQODgrOW9nNXZTUmJv?=
 =?utf-8?B?OUVFWXhkTGY4eWd0MGRZTndQTnpUSzU5V0Z4VzFXWnZYUVlQMWFEbHh2V3Nr?=
 =?utf-8?B?R0ZYRUJiN3VIeWZkZVF6MGxHRzlSYnJ1OE40ODNnVnlzamhhUHZxRXJTTnp6?=
 =?utf-8?B?WW1DcEFyVHMxUk1VU2xObTlZWnQzbkRCMTZ3U2xQZnVNUkdWRTVGSm1TcktT?=
 =?utf-8?B?bDdYTTExcVhubmM5Yit4OHBtZUVEaDNaMldlSDE3UHJoWGRHSlgybmRwMWFI?=
 =?utf-8?B?bSt4dkJvRHAwSjhBa01OdWNYVWxVOEY3UzlXek85bjlXT241YTA5MHhad0t0?=
 =?utf-8?B?UURJdEhCeThMWmdQMUtNcXJkVDBNSFByN3U5aG9Fc0cvVzNJUERDcjAybDhQ?=
 =?utf-8?B?R09FOHplS1RIZlV2VzhwYmcrMVVrMTc2dE13eDJHbm9NOTFSa3RkZEF6bm50?=
 =?utf-8?B?V2h4L0tqY3hoSEJBSkhrd0V6U2pDKzJZRjFSSFB4d1l0bDZ5c29OUTVuYkQv?=
 =?utf-8?B?Y2VkeXVaNTRnVnNqL0RVam5oa3lpUkFXUDdCeDRxVmxUR0RWM29YdWlhMW1j?=
 =?utf-8?B?Z1BSU2tONENTR1Y3MVN2UEM1bVA0QytudVRMRmg5TmppRVRaTE9iODFicEQv?=
 =?utf-8?B?NU9MQ1liSG5sbHhEMHUrNzNZdXNWc08zcGhFTTVGNjJubkpsMHVDZE1UZEZU?=
 =?utf-8?B?UzdZWEdROTVPWGFiTWhPMW44U01ydmppQUtJaUhNZEhnUkU0WE8vQnNmRXdY?=
 =?utf-8?B?SGwvVUROS3Vkc05ienRzemo4RnBLaUowVDd4OE1DTVdLVWhWL0FwNjZ5WWtI?=
 =?utf-8?Q?xm1yMFEhOxQwH/1U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b4d73c-ed0c-4344-9f88-08da2325b2c9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 23:30:04.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKXA3R7oQzwkmLt4evzjI1XLPZ1mFP6inzweSW88/nmDGG/jA7CXkEUs1gpx25509o76vKiaJshViNjlbD8Tog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5740
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_06:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200133
X-Proofpoint-GUID: rfKq2R9KS4rPeLk2S7eH_7Sr6ux_kjLo
X-Proofpoint-ORIG-GUID: rfKq2R9KS4rPeLk2S7eH_7Sr6ux_kjLo
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 10:11, Masahiro Yamada wrote:
> On Wed, Apr 13, 2022 at 11:48 PM Muchun Song <songmuchun@bytedance.com> wrote:
>>
>> If the size of "struct page" is not the power of two but with the feature
>> of minimizing overhead of struct page associated with each HugeTLB is
>> enabled, then the vmemmap pages of HugeTLB will be corrupted after
>> remapping (panic is about to happen in theory).  But this only exists when
>> !CONFIG_MEMCG && !CONFIG_SLUB on x86_64.  However, it is not a conventional
>> configuration nowadays.  So it is not a real word issue, just the result
>> of a code review.  But we have to prevent anyone from configuring that
>> combined configurations.  In order to avoid many checks like "is_power_of_2
>> (sizeof(struct page))" through mm/hugetlb_vmemmap.c.  Introduce a new macro

Sorry for jumping in so late.  I am far from expert in Kconfig so did not pay
much attention to all those discussions.

Why not just add one (or a few) simple runtime checks for struct page not a
power of two before enabling hugetlb vmemmap optimization in the code?  Sure,
it would be ideal to never build/include the vmemmap optimization code if
this can be detected at config time.  However, it seems this is a very rare
combination and the checks for it at config time are very complex.

Would we really need many checks throughout the code as you mention above?
Or, do we only need to check or two before enabling
hugetlb_optimize_vmemmap_key?
-- 
Mike Kravetz
