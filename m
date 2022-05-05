Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9467C51C5A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352097AbiEERFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382493AbiEERFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:05:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77394B85E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:00:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245GgoK2019152;
        Thu, 5 May 2022 17:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PqABLicniuA6G2iD8KM1CnO5Rbke6RarVf6FgtXO6Tg=;
 b=WqHwfYfObqyMmBjAU218g0OpnHXolix9xt6BEuct1RzuwQLuwEu8dgyH76JmUbRio/25
 tsQs0WGcZEkRhHo+0FM9s6cV96FZNyn42B4QUAhZNU6etAQ5SEYqL6j0u3Hn29Vx+vJN
 MhShvUSYD5OabtURHoDsHX8SXCJPkyy8ojEGY8kqgAMrqgHFfzI0iTPWVavL5NY13niA
 oh8IHYthIU4eEUXda+vmY7pAjdWWb+5OV7NFIPRgOoF5qU9iMcwUNGJqrKY1HAsylagf
 yM13nWyndMzmIB5pXqv6YCnFE/qZgm4uk8HRygfFYHT0LucACI7yMXKFb1FzVCGbc2vT 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0aunn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 17:00:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245GpPGX016211;
        Thu, 5 May 2022 17:00:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a7a20s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 17:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE3yIxUVzTBkySzM2l978P/7yoECVTuQQU5Xk6Y3KDkdeBNjCo5hlV2aSF0Ci3aM9VjPA5rVUIpw5Ln8D7bEoBuWJcsB6JDDfwv7LpsAl8uGMHFm7lAq2fEsBP38LOz9L/axnhyzmwIqgSGIKbjNzhsETbTKQbs17NRmCnqb+dOBTg+50Nc6XDGhgFvKrA0wly2dj5HnXubfntQAMPyjUUDzm9ZFYD8SUv/XCSuY9+Yhz/e+p3cczxt+Cm3+ZG1jcFDm8GcJE0599Xyjf04l4v9zrN0c4WGDIobOUneyG5KQRBSDb4t19c6rHn4QfyMiyoZMqol2TwVko+1OYZyz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqABLicniuA6G2iD8KM1CnO5Rbke6RarVf6FgtXO6Tg=;
 b=WtdD0o4tj8tH7qAiyH3vsvzgTbe3AQVzuVMN6cMFU8fP5sqRPnntBzP/w1esjqyD8FG4+kxwzYhbVvdr9XCBMCgJvPImh5gsVCh68GZPE6ZIeCRhjDbbye8vsMChda0esUqh/7llmCm73u49/8EhupuDQqq05RHSKPwswHvXYSPmqXo+tf1Sz1z8uxUrlfK0EODCOzlD5Iy3I0Pgfn+IqFZvw506mWo+xPXPT0k3jjuyL1YJVZwC8YSDzsqeR3rhnScE8MWrdX32gZc3CLE5El7KI9cG/w+TzeMUQ8i3rQ5SqojXjBjMAfBkMIyBKcz6yJUXDUMY4ju232g8Xdo9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqABLicniuA6G2iD8KM1CnO5Rbke6RarVf6FgtXO6Tg=;
 b=cjnBSmOFXFBtboVjthWY+apys+i94xiglSgemp8eMrQR9P6zWGDlp/6Jp4crhGgb3vMRyB6z2pbQAoyarbPGVwl8//AYf2mgfeoDwOgK7CfZBSUB5aqiRowYhBRDaom8ExHxiNx2p2B5vBi7wM0vlTaayIkqklix50RiJvFhxJo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR10MB1540.namprd10.prod.outlook.com (2603:10b6:404:47::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 17:00:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 17:00:09 +0000
Message-ID: <dd4588a4-c1ca-481c-ac33-06abef6cf70a@oracle.com>
Date:   Thu, 5 May 2022 10:00:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
 <YnFJss0doXGCmq3w@google.com>
 <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
 <YnMC1jFoPvNLWqnG@google.com> <YnNzPlehofB57XXU@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YnNzPlehofB57XXU@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faae6be5-5329-46fd-0103-08da2eb8b626
X-MS-TrafficTypeDiagnostic: BN6PR10MB1540:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB154035DEAA87B54273848F0EE2C29@BN6PR10MB1540.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgGFAheX2ngUcmJ7UQCq2isCsbUv8IHLsWGGppGHzdrV1/1qFF/L6qD63cYp7+wyg3JiZuoyYv3ip3KloyFuC4mxXEOlQ2psnKdsJ1SbhIQqeNRZmbCD+rp0RkasQZye7YN6gzbMSydMrtR/6UQUMFTKTSfxN797ko0Vsy3JfWSX+adRDFi8RICIH+DHxSCkMGMO+pkZjX+Ih5fe8mIJ8U+S1eaQZXHFZRL+ldPAHK1SMCkwI5CHr7w8aSQd8vaKVdaci0HS5g+x+InJWOvC3tg8Lr+Rh6YtJE4lxRyat/iQxISx3Iw5uRu24P1NKnPi5zRgshoewN6fKGcowr1kg5xZcDTOOkdH2wq+aCmqPud//gWtWswj2iwM+MIlcH8qMU4R0Jc1gbA/zIoV4i/xR1hU0GMGDvJRlEk4VjXS+1BJN56woV8zOrHweobtSgVjGcW4NyP+nsnClf6dDj+Fzw37vAlW/8hmtgy3UuIOt/H4AHwXunJeaoKHypx+Hnp7I31YglCaLs2EM6sGSSDWG1gzOj2ISfSvuIfOnwuPc+maVZYBBmdDTrTEV9WBMkAKPJAmRBwqkxrU8f5yhdaLuCn08S7CdeI0ns5ODS/+DCuRaDUs1EgOk+GHTNr38yjfL7F/h35j4IS5s2WHdvYfo1+Mu+ndk2GWdZG/us5ZNqYa74xfw35xSQdTn76s4A4BGCx3iVieQwIC6jrV1Ms7+ZrpEIChlhswhYazSxaKKu0bKSP58tx0s4qWFoU5zXj02nAGoHfAS1BQ/5UWufu03DzlmE+RoKSWD68+lZT16MvzrDCMZsHf1xfcHq6wdMx5l3aIJlYxRs5WfHN8xoWxjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(110136005)(2906002)(31686004)(5660300002)(36756003)(8936002)(38100700002)(38350700002)(316002)(186003)(52116002)(86362001)(508600001)(6486002)(2616005)(966005)(31696002)(6506007)(53546011)(83380400001)(54906003)(26005)(6512007)(4326008)(8676002)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhOZ0cybEVzRVVvTDVScmd2Qk4wTHpnZEJPU0Q3c0krVyttcUlXMXlFWlRV?=
 =?utf-8?B?S3h3ZVZBRUF2eEdWOWpPcWxaaHkvVlhjZEZpQjR5bGJLK1d0TDJVd0hNZFhl?=
 =?utf-8?B?Ull0NGY5ZHJhVXA5aS9kd3pkL3N5bTJXVElhMFpzZG4ra1JqWTZXbVpSUkdq?=
 =?utf-8?B?K3daN0Eza1ZSdlJFUHc5dDl4NG1CWmJjc3dRUzF5TFJkbCtPWEREKythZUlw?=
 =?utf-8?B?aHplWDJzQTQyaWFrQTNNbWcwWkdBdFhQYlFheEZxeFE5ZHh6dUtHb0MwQlJ3?=
 =?utf-8?B?UDBjZWxUd3hOR3JwS2RVdjBzRk5HR04xQkFFUS9OOWJRM1ZCM2lKd1QzRmM2?=
 =?utf-8?B?VFhxTkRlNEg3YlUxaVFQZE1oeWxtYUtRbW85MHhhS3IxZ1pLOXhtMEIxR0E3?=
 =?utf-8?B?YzV4WFZpZnFJVTBUa1k4amJVcTNvaXR2aXBZYVhmbFJ6bVRMTzY4WE1VUWVZ?=
 =?utf-8?B?cVd3aUc3RW1CUDZkUll5SmkvTGYyeFNrckVCZGVYblhvelBtQ3hzTHZhUito?=
 =?utf-8?B?SERvRGlWUDA1M1dyZHBPV0w3Q0Nqd3VHU0pyQXVIaVV5bkQxL1J1V2FFRHpl?=
 =?utf-8?B?bURiRkU3RkZYN3VieUtrNDl3Z3NNRnQxRzZjNS90UmxReGVmLzhWNlVWVjR5?=
 =?utf-8?B?SUNHd0M3VDl2NTZlRHhYbDY2NWdveVBKZFRqNllsWEVvSlhDVVU5dUR2MU4y?=
 =?utf-8?B?MUJKTkxMdVNUOEZJN2xNc2cxSVpsRnNWdS9zVS90TjN5VGQrNEgxMDloOWhV?=
 =?utf-8?B?S1EyYnNVWkFMK1g1S2hxWUd5N3lxSXJDc1JSejVReFl0WjdPakJlRFBCOWpF?=
 =?utf-8?B?bEEvdEFZRzJlaXF4YUs3U0tOT1JpRmIrTXZFSEMydjRqVkJOUC9Bb3Y2THZo?=
 =?utf-8?B?YUNxN2dqVTFGTjV5a2FQS3FXWTQrY2lOb2ROT1Fydms4MUxOa0xzSHlVZnlI?=
 =?utf-8?B?b2w2VW9rR1BKTUdVdWRHTDcyT0RuWmZUUkkwblBmL0xGd1o3NlJDYlMxK3Ro?=
 =?utf-8?B?Y1FOcXlRM0xPNm9mOHJxbkdmc1RzcXlQQ0RKYnBkalZ4NDI1ZTBhUGRqenpS?=
 =?utf-8?B?U0RNc1JWRHpLN0FkMzVGWVNSS3g2YTZDQllnR1lTTFBXSmFnVFBPQnVybkZz?=
 =?utf-8?B?Q1ZLWkFBakFOcGFnZVpMU3FCNjNGTk1iSHM0NGZLQ2cvMnlEM0VDYnlhbHVx?=
 =?utf-8?B?WWxCRFB3c21nbVR5MVd6VWpNd2VzM0xicVk4YVQ1RTFIUlh1ZWJHMXFQcUt2?=
 =?utf-8?B?S1NSMFRBdHRaV0xhYkhmVkRtV1AwbmlkQzBKTDR5SktXSTdsVnhQdWdqQ0pa?=
 =?utf-8?B?Ykc5ZmdoQkRkeTJ4NzhzKzdjMDJRamdnVXAzNmY2Y1RXc2kvanRQamFMWlNh?=
 =?utf-8?B?VkM4dytETEx4b2sxWlk4YStMWGE3Z1E4WE5rRlJxcjQ1VVF1eXQxaElzV2Mw?=
 =?utf-8?B?UGQxZ1E2U25pL3hJU210Z2kvOEVsWFNCbnlQMnEwbStCUDNQWDBUbk5jdlpR?=
 =?utf-8?B?TTJXY2JVM0NqeXc0YThrelROUVRQbHMyTjNHRC91TmRlQUNJMTgweU1qRy9B?=
 =?utf-8?B?d05MMXFJQzlGeUp3YlJWY1IxNGdvY0srNG1VY1o2dXliMjVZRmJneWx2bUVk?=
 =?utf-8?B?L2VDa1F5Rk1FaytEMTM5a2hlR25hVDdmdUZIT0lGVW9vMjlqd040b0MzSFJl?=
 =?utf-8?B?RUY2RzkvTm9kMUE2bllEME1nQWVLWGRSVUc3aEgwUklXVXF6M1I2SXdxTk5K?=
 =?utf-8?B?aStsby84R1BiOGlaM3B4d20wRERCK0R2dUY3TmxZTVlhYzc2OEdFSnkyVUlL?=
 =?utf-8?B?dHY3TjQrQTdXOWoxUnJJNWN5VTRTcCtmT3JiOGliYjFLWjZyTDZ0YU9hSnV1?=
 =?utf-8?B?ZlFkTFVVM09XemVsdkNZcWd3WXJHUVRwTm5JSFkwOVVOS1JwKzMzUDdtZU05?=
 =?utf-8?B?QlIxbDMzTm83WGp3bDhXeG1QLzAydGtyVzI1cnFYc1JLVzNDV0FzL0NUdmhF?=
 =?utf-8?B?MlY1cENUNjdlOEowWFNsRERKTG1xenpBa2lWNzFTb0piQjJjK3FqZkhXWWtU?=
 =?utf-8?B?UXByN0creUMxL1ZFblhOVlFvMjQ2SGlsZUNoWmRVNHpURUdub3krVUZEVFNs?=
 =?utf-8?B?RFdRMHJ1LzI3TENsWVpzeExLWHFYUENYdk1SV0kvc3pnZHM2bzRUUHY3WlFC?=
 =?utf-8?B?djJWUW5lTDlGWVNqL29lWUJoalZvUHV3eXFLQ24wQUc2UEJPdGRMTURxWVhp?=
 =?utf-8?B?dmxNUGVoR09QUGZOWXk0b3V4K2ZqUEFvYWVjV0ZPTXRUem95Q3VNOGxkZzkw?=
 =?utf-8?B?UVlzTDBpeCtkeXF2NngxdzVTS0RXRVVIbnByOVR3blhIMkhqRHplZ0JKN1JE?=
 =?utf-8?Q?ANCz+Z0fVwAjg1n4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faae6be5-5329-46fd-0103-08da2eb8b626
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:00:09.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSGqgL+Q3etcC/L0a4QTbDIUuqwyhzCddULMV5BIKn4ETDccpUwU9zAb2NFeyvz3UJSmf93X/ZriP+JQewm0uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1540
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_06:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050117
X-Proofpoint-GUID: CD3G4CjT5GgCAtzXiVzY-xOD7ohSWJpd
X-Proofpoint-ORIG-GUID: CD3G4CjT5GgCAtzXiVzY-xOD7ohSWJpd
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/22 23:48, Minchan Kim wrote:
> On Wed, May 04, 2022 at 03:48:54PM -0700, Minchan Kim wrote:
>> On Tue, May 03, 2022 at 06:02:33PM +0200, David Hildenbrand wrote:
>>> On 03.05.22 17:26, Minchan Kim wrote:
>>>> On Tue, May 03, 2022 at 03:15:24AM +0200, David Hildenbrand wrote:
>>>>>
>>>>>>>>> However, I assume we have the same issue right now already with
>>>>>>> ZONE_MOVABLE and MIGRATE_CMA when trying to pin a page residing on these
>>>>>>
>>>>>> ZONE_MOVALBE is also changed dynamically?
>>>>>>
>>>>>
>>>>> Sorry, with "same issue" I meant failing to pin if having to migrate and
>>>>> the page is temporarily unmovable.
>>>>>
>>>>>>> there are temporarily unmovable and we fail to migrate. But it would now
>>>>>>> apply even without ZONE_MOVABLE or MIGRATE_CMA. Hm...
>>>>>>
>>>>>> Didn't parse your last mention.
>>>>>
>>>>> On a system that neither uses ZONE_MOVABLE nor MIGRATE_CMA we might have
>>>>> to migrate now when pinning.
>>>>
>>>> I don't understand your point. My problem is pin_user_pages with
>>>> FOLL_LONGTERM. It shouldn't pin a page from ZONE_MOVABLE and cma area
>>>> without migrating page out of movable zone or CMA area.
>>>> That's why try_grab_folio checks whether target page stays in those
>>>> movable areas. However, to check CMA area, is_migrate_cma_page is
>>>> racy so the FOLL_LONGTERM flag semantic is broken right now.
>>>>
>>>> Do you see any problem of the fix?
>>>
>>> My point is that you might decide to migrate a page because you stumble
>>> over MIGRATE_ISOLATE, although there is no need to reject long-term
>>> pinning and to trigger page migration.
>>>
>>> Assume a system without ZONE_MOVABLE and without MIGRATE_CMA. Assume
>>> someone reserves gigantic pages (alloc_contig_range()) and you have
>>> concurrent long-term pinning on a page that is no MIGRATE_ISOLATE.
>>>
>>> GUP would see MIGRATE_ISOLATE and would reject pinning. The page has to
>>> be migrated, which can fail if the page is temporarily unmovable.
>>
>> A dump question since I'm not familiar with hugetlb.
>>
>> Is above reasonable scenario?
>>
>> The gigantic page is about to be created using alloc_contig_range so
>> they has MIGRATE_ISOLATE as temporal state. It means no one uses the
>> page yet so I guess the page is not mapped at userspace but other is
>> trying to access the page using pin_user_pages?
>>
> 
> Too dump question. Never mind.
> Posted v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/T/#u
> 

Well your question mentioned hugetlb so my mail filters caught it :)

Your question caused me to think of the following.  No need for any immediate
change: I think.  Just wanted to share.

Suppose someone has reserved CMA for gigantic hugetlb allocations.  And,
suppose FOLL_LONGTERM is attempted on such a page (it would be in use).  The
desired action would be to migrate the page out of CMA.  Correct?

Gigantic pages can only be migrated IF there is another (already allocated)
gigantic page available.  The routine to try and allocate a page 'on the fly'
for migration will fail if passed a gigantic size.  There 'might' be a free
pre-allocated gigantic page.  However, if the user set up CMA reserves for
gigantic page allocations it is likely the free gigantic page is also in CMA.
Therefore, it can not be used for this migration.  So, unless my reasoning
is wrong, FOLL_LONGTERM would almost always fail for gigantic pages in CMA.
-- 
Mike Kravetz
