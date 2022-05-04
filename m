Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D895192F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbiEDAqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiEDAqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:46:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2953E0FC;
        Tue,  3 May 2022 17:43:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243MdDXL019339;
        Wed, 4 May 2022 00:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=se5j+JWV1zNJn/24cd39GTjelq9otBQRjG6CD1OKygw=;
 b=U8r6VrFWTXPlM1+M0/YO5x6kdWn3Io2ZrJLaEuhrEUouDrs569H51DyBnrju8IeWl1HM
 +62JE1ljTLzbjm0GMU9Mpuhkcd5v2KZRArdYsR2rJo4hVvBiXDn4UZ8n8zi/tRoqIK/Z
 9zLKIF5xPZc0Ril18Mc7YDupeMHB6K0zGyp+qvjguM5FiFB1Rvnz4KWMOvC7kmWBlPv4
 gqf+RVluDszHiXPzTxDbaVo0ilrJV9Sm5ykfMvVIKWuTUJgYQOKu3cQxwP/w5VoGbu3L
 SSmYYmaKyAmssOowZ77Y3LOCwSKr3dZGupx3zAxzSYeLXjwYrDTAZZzdRRDHu9FkRjY8 pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt73md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 00:42:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2440erj5005024;
        Wed, 4 May 2022 00:42:48 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj91mws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 00:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwP32NWGqrNeOW8Yqe2iob0UE7adbRb4OEwV3xgQXLc6wFmMYd6H07EmgYlwFzYgdw5BXuGx29Tg14K+jVkEYEgzoyXBI1AJcBJfZdBE904x74SMVoaqigSs93eDha2AHpgEOeATJwn+D6CMQ+0zdVyup9hQ1sRoRdzOMzRp5dChLSnBKm5otGd+PAW7oNSMKdCRmreEZWL/STyG7/DBzd9s26DlOcBofEaHaOTic44M2+8yFXzbGHliKKtq5870sedI6td7pMvVLUe9qTEWtSHWK9fTg6NxEeSjAqMQcNm4nN+jjx53wciO9p+dBOzdlAen87zcc2ksgi8eIYcAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se5j+JWV1zNJn/24cd39GTjelq9otBQRjG6CD1OKygw=;
 b=JMiHWFj2Xmps1zSza7mTiXXALOIw5eZcU2IkJq+eMB3sPwLhdL0/nUxfgk1Pi8pbxn4g3AVMVN9Ak4nioGJyTufkgOSTVMqhXCHj/X/ZsTUavU6Gg3PYqByOciGehW7QoE9prS4Wgtp4IeS4gZC/b7cWfSzkuc+vkzhOFvS4BjiQTmDBufqsU94vbQDPrZvs86qVs+681apQpJ0KCtsfgni8EQpUkWhVp6MFVp8Gue1bPpJVVJdCjwSyId43KrOiz35l7da224bEvUATDbgSA3kYPQfWAqDhuA5cpe1sRM2SrvjJZw/Y2yMvJUruOVWyzbUoxbGByWH2inaQR/Xq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se5j+JWV1zNJn/24cd39GTjelq9otBQRjG6CD1OKygw=;
 b=OKcF5I6kpOUnF72NwMRL8RgfoPhMeMfampCapBt5uxyZ+AxMpMw+SvNVg+/FWDptUF58AP438wihQHqgipS3MymjF6M9UiezyX5SUW/rDpgGwql7F7ybYHQ3H8RXEyG/nxNvCYWxZOTF8DbqwDMrlPUFI4BZtz8OOdcGrRUo4fU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB3436.namprd10.prod.outlook.com (2603:10b6:5:63::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 00:42:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 00:42:45 +0000
Message-ID: <24e3bd32-13ef-bca2-5815-93a20ebe974f@oracle.com>
Date:   Tue, 3 May 2022 17:42:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 3/4] mm: hugetlb_vmemmap: use kstrtobool for
 hugetlb_vmemmap param parsing
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-4-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220429121816.37541-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a45ff5b7-341a-4119-7b92-08da2d670179
X-MS-TrafficTypeDiagnostic: DM6PR10MB3436:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB343606F4E7125A3D720B9AE9E2C39@DM6PR10MB3436.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c90+HGWo60M2ArD1DS+xjYnZVE5WPfMYN7wZMkkszaANOq/XUJa/h0h5kCRt64iU3PMHBH5GoCniwKsyvkknazyI0cOJyVnf45HsQm4fIsBmsIatfoZXZRSk1PpXj4xNzMWc/QtgMRKyoIGcShDdFqXVE0oy9Cx7eI8SIdoagQMmCK73l2IASiHwqmYrKEl4lxiOpXqC9MrR5Sj3iJqbS8H73qjHiIru8hzJx1WDJ7kRIjqyIFAvkURLYU2nXA3JUSC9Phw+OPUPeMFgmX9bufw2WD01FMpQFFK5ekFnvZ0wvwCCZlc7zHzu4JZQcIxdXbA4yKqxDadK/NXusUfODx+014zCAHlhC+YgH7KOdttPMziqI+BENuOsLVO87iNTtgt7QXtQdEM8WHqatCrYuB2vOBq3q9dq+gmtWwUWfgtRmCSslf1z1iXjmHbovhGtjIk+t5FqoJeDt0/pmDd52Kp4XRCIrqAVFPxbxiG1IjuxHqCSD7+OwIrFH2h5I4uxrSHeiGuwHDakkf7XNMbhnIrKLoyhbJBWge/CrnK+AR1mY4zzsIxjCkTdn9DCxVfA/srz32jp7baApKg8S89wv/Xc3PlGG95N86p9Ap+gHb5DkHqoyFMUYzaDjsT9/XTPBooBLIdFZhUPYmdId3r3PNAhsV0YpYv2vdmKZ4BXVCAW+5FnJmZYfIRbujtr1Hhon+gFEwS0YDvGpnlJ7gw+Iq842ijmIGP9dW8+VogcKM6V+kILJmWREjBvqTJ5rYTIJ6+92P10M1h1HgZ+eOcazA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(4326008)(8676002)(8936002)(31686004)(7416002)(66556008)(316002)(66946007)(5660300002)(86362001)(31696002)(44832011)(508600001)(6486002)(6512007)(53546011)(2616005)(26005)(186003)(36756003)(38100700002)(38350700002)(52116002)(83380400001)(2906002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1GcDJqWEZ2YXJsUmZQOVJDKzhOTno1R1dGTlpReFR3eS9hNDFSWGttVndH?=
 =?utf-8?B?dEZVbTBOVnBaQlpzOUNKYnVlMVNyMVl1RVQyY09SRU9XV3JUYkJqc0E4L3dK?=
 =?utf-8?B?c3E5dFpqSm0xYVJHWUczaFMwd0JIY0tPbXpxVGdKOUFuY2dsN25zT09HMW5t?=
 =?utf-8?B?ZVhLVkRGYkZYRE53R3FoVGE4Z1owQXgrcU9kMGNrVVZtN3FCRHZ5MWw0eVN3?=
 =?utf-8?B?NDN2RHhUSWhMWVR5UmJoaG1kaEFFc01lUllFOHpJWWQrZUpPM0lxYndOYktD?=
 =?utf-8?B?ZFphN3l6eHQzV2N5dXhUaXluUm1FTHp6ZHdLUDFQSUIveTBpQzNMenJtK0ZT?=
 =?utf-8?B?NU40RVlQdUFIRmhnWnRwd2ZIT1ZVQk9yVTFtU0N4UVRvbFFUVXdGMlRBYkpR?=
 =?utf-8?B?N29mRHpPQzIzSGF6WHBKQmgyWjdQNHNKOVJsdFdORVhjWml4Uk9iQzQ0TGxQ?=
 =?utf-8?B?aDdtcG9UaUIrQjkrdzFZbmhEZ2RXZ0FwUzdGUmhlemp0a3FmTWlJa3hQUWw4?=
 =?utf-8?B?M2pKOUVWV3FuNUZuTHlPRHAxNmF0Wmw3d2Qrbks3bkFkRUpmZkhzNmFBQmVw?=
 =?utf-8?B?czc1cXhUeUt1NjFLc0lPblpJTFBTbG55S0orRmI1dEJKekhnYVJtVzBYbmZS?=
 =?utf-8?B?TTRSejIrRjkrS0dnR242TEZZY0RLMSsyRmRUNFJpR0NrU1JETks3c3ZpM2s5?=
 =?utf-8?B?RXVNUi8rcmo1M2pha3JTUWNxbm5FTkdkK2U1TzJNUEo2c0M3STZvV0FMVmRy?=
 =?utf-8?B?OHpVUmVPanJJZUlmODZqLzNEV3A4a2tWRVpCcEloSEtEY0M2NHh3UmFwWEhj?=
 =?utf-8?B?VGlSV2NoWU5PZURkU2RpaFpzN2dvQ0hHaC9EWWs2R1J6RXFkQTdLak8zZjJG?=
 =?utf-8?B?ZlJITzQ1c1E1eEw3N08rbHZtalVodGYxTHhSREppYTdIVTZ6VEZSNytpK2Vq?=
 =?utf-8?B?Wnl2VkJTWjAzZFFsOEtjdWh3WUt5Rnd1ZVFzWlhGMnk3c1RDRk1JSTNsU1hT?=
 =?utf-8?B?V3JSNC9lcDVDODQ2ajNqSEVNVkJoclR3TUhIaDczZEJ0RlVaKzFKR3h2Y1ND?=
 =?utf-8?B?VUJtdE12TXdEM09VNGRqK2o5blo2STl5Y2cwNitDS2RWSmpyUGJTYlZIZFRv?=
 =?utf-8?B?THl1MGNra2toelNPNUk2T3VJTEp3ZjJVN1BtMFFSMkUwTkxpenVNbHlFenVF?=
 =?utf-8?B?aTZ1MitXUHZQWUwzSlR0NVlESVBTcUxOYks1V01XdkpycjZxdWxUUVVHdmF5?=
 =?utf-8?B?NjRFd3Rwd1hBNHJYbnIxMzc3cVV0MzU3dXA5NXJKdkNybHdUc2g3UzJTdVBi?=
 =?utf-8?B?dkZpMWxYYkQwNFlzaWdjV2VaVldpaThRNU1mV1ZjTmh3Y01BZ2ZQdWwwOUlq?=
 =?utf-8?B?UVJBdFBtc1BFTElzUDUrdEo1dFRmUTBvRyt5djc5Ni9vTzBOakwyNCtObVlk?=
 =?utf-8?B?QVN3dVNTZXA3TXFuQW5vUXltNGlMOVpOYUpadnFLT2gybWtYNEd2eXFScmpH?=
 =?utf-8?B?Kzc4QVVibU0vaUlmbTQrNUd1R1JLdWNxNk5BK0YvQ3VnUktCcmoxTldwWGtE?=
 =?utf-8?B?c0Urbk54NVlxOCtXZjE3RVFOamlPN2VPK29Ma1lVbzJ2bXlJUUdQZWx6UlJU?=
 =?utf-8?B?VVFid01wMmpqQTBpUjc3T3NmNnBoV3JGbWJMODJLWWF6bFVIMjZ6UU1jRThF?=
 =?utf-8?B?Tmt3Q0VWN2hQd1A4c2FjOGxzNVRxRWNZSUJmbDBCM3FoMlNpbENmSy85SmtQ?=
 =?utf-8?B?WkNPam9rL0xVcWFIYXhVZnlyMVBCZTQwTnJveGhXaWpjbFNVb0lYT0VhTnVF?=
 =?utf-8?B?bWExV1ZjQkRvK1lhOHpTaHlHaWx2REtKckxyL25TVVhXS0FnVkJ6ZjIrT0VE?=
 =?utf-8?B?VTFZZkdKQTdXKzFlZUlPbEZwcWpialJmUjh6aDErNld6NUdId0p5ekEwbjVP?=
 =?utf-8?B?ODNlM3Y4TEhpUWZDZ01US2NlSHRRdU81UDhEVGlNUlFPNzMrcWlKbFBYd3Qy?=
 =?utf-8?B?Vy9tYmhJWXpybHQ5Wnc3anY1bno2SlNSNktsRmxpWVVqMFU3WURDRGUvWHQw?=
 =?utf-8?B?WnFnSXdPZ2dDdEpxY1o5dVQwcnkzVFh6SXI5dUt0T1ZCa1huOEZPRjFnTmtK?=
 =?utf-8?B?TDRVdndyZEtTb3hnMWJDV3dFbUNodHBPdk0xOXhyOHRsbWJRV2dLcU1wM1B6?=
 =?utf-8?B?VHRRRkw5QlRnNG44bFR0N2hVUjREZnA3d2t2RzJhcXBiWEM0ay9udy9GcTlS?=
 =?utf-8?B?bG02OUVtcW1xNDhKS0RnY2xhako3bFJoRytLVUY1cWtZbStVTVVLNnlTeC9B?=
 =?utf-8?B?ODhHYktIdE5TV3VhTGs5Mm9ZUUFqdFU4bHZXdFl1eEVmeEhrYzBHVTlsMVpZ?=
 =?utf-8?Q?FKEKRTsfXkPt/+uc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45ff5b7-341a-4119-7b92-08da2d670179
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 00:42:45.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1Nmh66fWHp/2g3dbRkO8lNnu1F+XIze2ioUGC2NzunzJQK8kFRU7KGfZQA2IQ8BMbS5jyBl3QBK7p4LKDZFPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3436
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040002
X-Proofpoint-ORIG-GUID: vCY554GBRz4Kr5bJUuSSdTVlYWUKTIKF
X-Proofpoint-GUID: vCY554GBRz4Kr5bJUuSSdTVlYWUKTIKF
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 05:18, Muchun Song wrote:
> Use kstrtobool rather than open coding "on" and "off" parsing in
> mm/hugetlb_vmemmap.c,  which is more powerful to handle all kinds
> of parameters like 'Yy1Nn0' or [oO][NnFf] for "on" and "off".
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 +++---
>  mm/hugetlb_vmemmap.c                            | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 308da668bbb1..43b8385073ad 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1703,10 +1703,10 @@
>  			enabled.
>  			Allows heavy hugetlb users to free up some more
>  			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
> -			Format: { on | off (default) }
> +			Format: { [oO][Nn]/Y/y/1 | [oO][Ff]/N/n/0 (default) }
>  
> -			on:  enable the feature
> -			off: disable the feature
> +			[oO][Nn]/Y/y/1: enable the feature
> +			[oO][Ff]/N/n/0: disable the feature

Fancy! :)

>  
>  			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
>  			the default is on.
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 6254bb2d4ae5..cc4ec752ec16 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -28,15 +28,15 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
>  
>  static int __init hugetlb_vmemmap_early_param(char *buf)
>  {
> -	if (!buf)
> +	bool enable;
> +
> +	if (kstrtobool(buf, &enable))
>  		return -EINVAL;
>  
> -	if (!strcmp(buf, "on"))
> +	if (enable)
>  		static_branch_enable(&hugetlb_optimize_vmemmap_key);
> -	else if (!strcmp(buf, "off"))
> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
>  	else
> -		return -EINVAL;
> +		static_branch_disable(&hugetlb_optimize_vmemmap_key);
>  
>  	return 0;
>  }

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
