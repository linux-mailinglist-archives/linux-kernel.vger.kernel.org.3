Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21592502C62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354872AbiDOPOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354869AbiDOPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:14:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C0A8B6F8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:12:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F9raR7008564;
        Fri, 15 Apr 2022 15:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/TZzWWNV8gNhRVQ97NRrMNaPCqn7t2DAevU25XefZxk=;
 b=KlSI5vjUgxLsZCkxFGT41XffDlFJgdiYJSHmeOYASXBa6wF1Ssec90uVkLoGdWZNpeaM
 gBwo/16ceRsOMmCCVFWfoiiw7xRsZEpKus2kgkmOgzQrFnJgSj/nqMozEP0J8PUUCMyf
 zWUK6ttIO9k4O7s8vNhsN4BnCEedZoGd0MGqDgUsJzcrlACHgmII4xYZXdRfO66jQOiO
 vTIFdUklafACw4yL31RByS68oKMBpMLnqq4WGQkF4MOSOFSlJ+4rl1csnw+N/7cVizVh
 viHUeEVB9xNc77S244VFBeUTwZdSHbDR5l0wtjz2PNPLYpLUGYZUkzLdjjHjqnx9+Isk PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2qc1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:11:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FFBrtm016677;
        Fri, 15 Apr 2022 15:11:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k6193e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIsRogA3sUrXRDxkrjGImzv4Egxk0Ew68nqtszqkwFXW0Lz+uZZgRle3uP33PCXvuYOfiPa/44Bfytzn6+pQhObtwySBWiuxzVnI+/ebFWFv43UQhCHryLNBgM7sf6FgA9g5F5YkFCfpcXpag6K6SXTRgbvDZ5J3ZhMjJJxjVKG83zFzIcEkLzt1iQaHHuZv9V1md+9BuqQdutraukwJ5wnbj0YCgtN6+kcwSeZUvfMnKSK45spSBH8ZHLb0j6T6J/0hUVVumLxMmfde9DL/2aKIhFW4pUZ74c5+r8zAz6ByMRCmWZzrxKAkUSaU+7od4NouK0oNIewxjYAeccZx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TZzWWNV8gNhRVQ97NRrMNaPCqn7t2DAevU25XefZxk=;
 b=PJLo3Gba/ihwOXlnl6J8Kcwz3r1t8tScXga6C89w/hCGpI8Pz4i6dy6vVQ9lgY6a5v3PmoxfHn8sVWGmdh4aI6vi2VsDmkH7LAweJfedeM4pvCLnsSzRIHrhiyrsoMZbN1IOY1N0Xv6UPYLOtz3qUFf/WOvYE0mVH3cOg5t3XspR2YGecsqz3RaqutBQEp8bUP+hVVpD1VQ9pjTNp96zON8o5Nre/O96oY4ITkE9q3TPVggCr06GHY6JSN4IYWRxXFhlMQe4+S+c/AcE7Nz+QbFnFHUKVjFSz8F6UTZ3NX4Grz9usq78hL/+aiRQBaUnA7X5ZgvJlCMh2KginZiSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TZzWWNV8gNhRVQ97NRrMNaPCqn7t2DAevU25XefZxk=;
 b=EBO/Zfej0FxhbZGbw0eUrYoItvYo8GdT2oC0gqkt7lH0pO1s2OpmsUw9uSRjFGECMhqkOIISRo5zua0i4nr+MtojKXBMYaJmVX8l07fMF8Pi7cXpiiukw7j8xfMIgPP5GFBBRt2vZK/C689cbYA82vsF90qkQsYsAeWpp1SpvZI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5206.namprd10.prod.outlook.com (2603:10b6:408:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 15:11:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%7]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 15:11:50 +0000
Message-ID: <3b83b483-34d7-bf2a-a3ef-a40f2f4b0076@oracle.com>
Date:   Fri, 15 Apr 2022 08:11:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/3] mm, hugetlb, hwpoison: separate branch for free and
 in-use hugepage
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        naoya.horiguchi@nec.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408135323.1559401-2-naoya.horiguchi@linux.dev>
 <5b665bcd-57f8-85ae-b0c4-c055875dbfff@oracle.com>
 <20e677e5-01aa-f8c0-0ce1-bf33da58b7ec@huawei.com>
 <20220415021233.GA3357039@hori.linux.bs1.fc.nec.co.jp>
 <20220415041848.GA3034499@ik1-406-35019.vs.sakura.ne.jp>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220415041848.GA3034499@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:303:85::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 028d0804-a0a2-4e4b-5fa5-08da1ef24461
X-MS-TrafficTypeDiagnostic: BN0PR10MB5206:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB520679CF578022254ADD5109E2EE9@BN0PR10MB5206.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hb9kzgfyYwmZ2uui0Nyi3z98INqmI2IRSEFF2AK8QAuN4cgxIiFwHthVy0mGwyRDNaE/+aL5GNvPwjOZZqibNWDojj0egyT8gh49hwv6EG467wP8R+/LnP26YRUtFKD2fQCZV/3MqYgf2XybCfuU1klGi5lIVXGxEZbGrxJgJAg0vVm0ooiXkrCNM/UGgkJg1yZLw4BQetVQwEjjM+0DlbSTazwBdjO3igtHxhp2tzzh26j+ZgQpper3df/w524Ndl61vUYmiIBRMebyUOIUV4LBCWFGjT354DvH9klttpcQPs9ypfZBymz+MaFk2CQs8tIttcXGZ/8JwggA+EKyBdhdawcfoEIjCDL0EdgyU/h5Qxw/Umo/WXhYmGghrCzlr2DoqFPhrsntjQhLI76dAHlg78SirPJt0kR8/aMH/EIraCZAE6DjrCl4fXBEQTKw/XmURqq1rVKUlYa73U7Gc+I+hR48HE8ICdvMbA/+7Tvl+1RgKpePWksZoyzMJvuxZ5BLU0b5uPzynk7BbuRL7WfNdPejfW5fUvUwIKu8URmQUj8fm347cbL1nDuPUdRb5Ixvjp+PlcijCwCSXR0aKeg66/TjbgrzvW7vCxXRau7uuv7F9Cn3OgJxbajPXvuP7Ctwql3DEvrdHoF961YgDliCrOdWp8o4h7hqJ55LtwjjWxCwLEkWlr/JuxjlR0RERAIKCEK1gbMfF/HSav1J6oAoLMlrflJAn8dinNaNnZ9RBF0FSABsmLTr715+f2Vago6BEcsBfDqBg12AqWQMgEojBktRJYeqyf31zCGnlVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(83380400001)(8676002)(5660300002)(6486002)(54906003)(8936002)(4326008)(6506007)(110136005)(53546011)(36756003)(38350700002)(66476007)(38100700002)(52116002)(44832011)(31696002)(6512007)(6666004)(26005)(66946007)(316002)(86362001)(508600001)(186003)(31686004)(2616005)(66556008)(45980500001)(4533004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVMyKzlLU3hQR0NvQVJodGJoaDFiWEo2aktpd0lyN3dJNDdjRmtueWxMLzFy?=
 =?utf-8?B?UmhjT05weFNGOTEyWFo4NjJyaENJTXZSd2s1NXhMeHp0SzJvSlpSTEVraUht?=
 =?utf-8?B?QXlLQ3dxd2U0YklpR1pzMm8xVFFpM3UxTit0QlZONVJWYWN4YmpwYmFMM3Q5?=
 =?utf-8?B?U25ZSFpJTFJCY1JlQ042dmFublNCTzlldmh5b3ArSXl2K3NzbWc0NnFXdmli?=
 =?utf-8?B?UGN4a1lyUkdScjNCZWdNcUxVRTlyUXB2R05zbGFtODFTR1h4VE9YREh2d0Ur?=
 =?utf-8?B?WGRaMitFQVhURVg0dENpdFc5NlFxVngvcFNnVWx5Q1grTklsZ2ZlZ25WelBZ?=
 =?utf-8?B?WEpYY2VZODZPelIzVGZJNUhVbUVrZjlvdTVURThUd2xqQktGbHJ3MmFUZ2ht?=
 =?utf-8?B?TUpKMlFaektpekFqOXFYaU0rZXFKK2lPdzhJcW1DZlcyT2thZkpndkZJY1Vm?=
 =?utf-8?B?ZmVDNHdvbzkrWlpqSzJQaVdPUCtoYjd6U1k0Ym9kRUdsZHg4dFZMTkZDVUJo?=
 =?utf-8?B?dEJCU3BjdkNGNG81czhBc2g0YkZQTm93N0J3eC9Wc1R5ZVdJNnhFYmY5dVBk?=
 =?utf-8?B?ay9MVDZlOExQajY1VC9wSWpMYk9JNzhxVVBoYThOemR6UlFOYmRFNzJwOW85?=
 =?utf-8?B?SDQzd2wvNUY1cnMyYWpMdkl3RkVKQXFxODIxa0ZzeXFNb2V0MGhBUDREY2R5?=
 =?utf-8?B?ZkUveXdnWEdCaHBvVkphdlRGbnVEUHo0Tlh2a21ORDhoaXV1d2NwdkMwVjNy?=
 =?utf-8?B?cWVDL3FNQXZROFdwTHJUa2RJQk9uZ0hZSS85T3BVS1hIQ2ZhaFFTUytvTlJh?=
 =?utf-8?B?OUVwb3ZTL3FheVhNTXUrcDdxeDM4UkJDb2VsOGx0UlE4djlPeXplOUpXRnhs?=
 =?utf-8?B?M2JhZUtucVhWWTBTZDduU0dnWmVsN1pPWEFnbzU4Znc3SUp0K09IbHhDbUsr?=
 =?utf-8?B?VWprRHQxME5uVCtKL0liS0hjenNPUFRnSjVJRFQzMk03YXg3c2FEYjdyYjJn?=
 =?utf-8?B?cGpUVVdLOWNGdGltZ0RoczA0Ry9zVE9qaEEzTWhmTWdCM3RENDFoK3B1Q1I4?=
 =?utf-8?B?Lzd1T3llRXJMbFJNUHlvc3ZwK2hHcVlPb0RUYVJyU3NibHp6TXRWa1JHc2lN?=
 =?utf-8?B?NEoyOHlSQ2Q1QlRXdjc1bEpGQ0ZYdTB4ajcyb2J5ZXF3VlFkT1diTWdMRTVl?=
 =?utf-8?B?M0F4VzFPSEU2d2xBRnVMSk1WMzdWMFVzU29PY0dZVjlUWmc1UkxJSldtNXJP?=
 =?utf-8?B?MUVxMENERVBVMTRMZ2F1MElnMklCeTFseHhBQS8vQlJPL0xHYnBkNGlaamdi?=
 =?utf-8?B?TGNLYXpsa2NNSTZRUlVjWUl0enZ0RThjWXJuSmlNaEhlampzTHdaSndhZDU5?=
 =?utf-8?B?MmhjTnExOU81THorWFprUHYrMmV5M0ZWQjFXczU1UWNhb05xaXBsSzBQV3Rr?=
 =?utf-8?B?c3BGb285RUJ6UTRHaE9ranJOaG1PcEkxM2IyZ0d0anJqb0dpTHc2dWdhYXJz?=
 =?utf-8?B?TFI1UUFSVlkwWXpvb244WjFIWUwvRGkwTVRRR1NuZnltV0ErbXUra0RGZTJs?=
 =?utf-8?B?ZmkwZGd5VlpyOVlDa2dpaDJNTXp6VU5TSGoveTRRaFdMRUlZVGNxRlVKKytL?=
 =?utf-8?B?dy9PSmhtQytNRmEzd2RmVG5yMWFydXJ1NmdmemcvNFFoSXFPRFZ6ZFZ6NVVP?=
 =?utf-8?B?VE9CbDlRTUZHdXV0WXJ5bitsOWJBZjZkVVY1eU9ZY1N0dFdHYTBrUTF3Sk1V?=
 =?utf-8?B?QTlmZnUzYUxyNEE4YityemJZVWF5WS92RmRTVFFnc1Y5dXNHTEdtb2ZxM29u?=
 =?utf-8?B?TnJLZjY4K3p0SGw2UXFMZm5hVndYbHhkZTVBRXNQdEh0d0RSaXE3VHNpY3My?=
 =?utf-8?B?bUMvVEVNRnI2cThyNk5YWXVnUzlwTkZRekNNR0NCNVltYmtNUlRsK3lQdGUr?=
 =?utf-8?B?SzBNVE1vTVhZS2RqSDJpdjRhTzNUdmdtNHAxQ0NYQTU5RCthSlVVUTZ5S2xB?=
 =?utf-8?B?TENEU1ljVndaakpwM09YKzY5ZG1NL3RNMGNtVk9MOFo2T0VORWFqazJHUXB1?=
 =?utf-8?B?ckpLdmVxalVCMXM3ZHdiOUdZU0lFdkV0WDlDalVoWE1oUHFJaXk1ckhGL2JC?=
 =?utf-8?B?ZERNUHJaWVA3ZHFEZTk0UDdHNWRpaEdBQW5uVXgwVzMwUWp2Mk05SWpoT0gy?=
 =?utf-8?B?dU9TaFMzaCtLcHpvNHk4bDdHTnVFN3RVWVlZMDcybkJBbmNtZ0Zjd1duYWFY?=
 =?utf-8?B?MHM1eXNBWHZNSEtXa0I4U0RDNnRiRi9XaGtZWXNWa292UElUcTBzSW93Ylpv?=
 =?utf-8?B?WXFmNCtIWjQyaEpobi9ObjBrRk9SUmFmZmFWK3ZkSVgzeTBkcHFGZmFDRDRu?=
 =?utf-8?Q?FbswYV9K4s24eguw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028d0804-a0a2-4e4b-5fa5-08da1ef24461
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 15:11:50.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKD7A+FgqQ0rH3X+k8RIPASJdI17vXiWrGNLIrkt0z0WumDexHBbNsQwGQClEyWPoUD18U9ulGeA1CTJ7fcoFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5206
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150090
X-Proofpoint-ORIG-GUID: 2uX0Egz3BQOSrADhJx6oRqH4ECcVCu7s
X-Proofpoint-GUID: 2uX0Egz3BQOSrADhJx6oRqH4ECcVCu7s
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 21:18, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> We know that HPageFreed pages should have page refcount 0, so
> get_page_unless_zero() always fails and returns 0.  So explicitly separate
> the branch based on page state for minor optimization and better readability.
> 
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Suggested-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/hugetlb.c        | 4 +++-
>  mm/memory-failure.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Thank you!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e38cbfdf3e61..3638f166e554 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6786,7 +6786,9 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
>  	spin_lock_irq(&hugetlb_lock);
>  	if (PageHeadHuge(page)) {
>  		*hugetlb = true;
> -		if (HPageFreed(page) || HPageMigratable(page))
> +		if (HPageFreed(page))
> +			ret = 0;
> +		else if (HPageMigratable(page))
>  			ret = get_page_unless_zero(page);
>  		else
>  			ret = -EBUSY;
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5e3ad640f5bb..661079a37f29 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1517,7 +1517,9 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  	if (flags & MF_COUNT_INCREASED) {
>  		ret = 1;
>  		count_increased = true;
> -	} else if (HPageFreed(head) || HPageMigratable(head)) {
> +	} else if (HPageFreed(head)) {
> +		ret = 0;
> +	} else if (HPageMigratable(head)) {
>  		ret = get_page_unless_zero(head);
>  		if (ret)
>  			count_increased = true;


