Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11213535027
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbiEZNpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiEZNpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:45:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A02DFEB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:45:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QAnHdT012463;
        Thu, 26 May 2022 13:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZcKB6Eke0C0syqJikLiBTzo5K1lhUtrjaLnnyzxAIOc=;
 b=eQ78KmorB8pZzTIP8SA0IprknS3QZc2+KXQ8z1SKAwiG3esiWFWDlzKNiUu7X+mp1A6+
 YYyqHUoD61QnHS30EIxurl7HcTGFnIsA/Ley9pnqdOU8t26AjGiatIBxLvfrcxaMumbj
 rg0wELejqaAUZosjjGMHLA+FH9LIp65gMXrsjDoejzKFPSsqaeA9iTFNok6ADFCQ7Kaa
 94j92yO2TN9LqKP9e7IjSYvn6g6ucL5g0AzCwuHINA+TObSD2oV9SQxxnUuaD61FffZR
 NRW5ybNZlbftkIY7Muy6pr9UYv1z2tipBGPimsyl+6bcyVL14Vl5XvbYKlrJs17XFm7n TQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tbvuwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 13:45:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24QDaCBe011966;
        Thu, 26 May 2022 13:45:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x0ta93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 13:45:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwQsKO7NkjeZDqPCtkEBvOFCXpjxv0QJyHtjJ1MIGzrt85+UqrHTXZEaPjsqwEld2C0R+fQ5iPJ3Yfh7hxF9k9CuI0bxhhTzTKGYjcVTFvXJpdqaPDV5KniEjFo/Ef8TaOynh3H47NJ3ncPl3L8tOTVsP/ZgOeTCxwKm2AbC63z6CdFGARsofmTodrG2dQvgBqUYNtRPuDcsbI8h8a33oFd2N+GoBGRrwL6ShvcZxyGbWimGoYNSdFsUU9GiV5Mv8zhAZ0BX9CIOiD8gqIx95Ch3CvuBFU/+FGPaHBXOYVV/NWoYpwZT9wxQBJqrRrVEc2ZVRDDlimRtX1rTGHwR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcKB6Eke0C0syqJikLiBTzo5K1lhUtrjaLnnyzxAIOc=;
 b=Gyz1oY5oziXM6B3z6WoDfFsJoFNKboU2rG8z/9cEDSy+yfxuhqXkQzvtMbxIoAdXxA/tHxrXkSxOib40yMsyhMQwyPmPKoUbaw85fYXZ12OPgsS8Az8gZSfDdF5S6dF+SHIH8sZFoX4SbysYPguRdP4io3K0Nan8f+Ml44iln+sw8vCnL3yYwEEJSLex19GkGUVrEmTYXFZLjPG9dSYNTLeiq/wa1cT8e2kQ4f7lpzwOl2YwKviapWX+BbytnZGNuG8wV6cARTNhFRecvHYe9vt8tTchUpDbDcEcCOyB389AcfN/5QQ9HugTxAhoCPHuXVT3+O+z0ppDqRVtwwxPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcKB6Eke0C0syqJikLiBTzo5K1lhUtrjaLnnyzxAIOc=;
 b=xG8TobjUFBsZXnSsYQ4km1XtZYGgadgO/YzZUSLmxhSgHh9wAzh3DGwVi5q0qlO5F4G9ZuVrJY305HwM7A8Qc8lQmu4MxFvW4ChD4CO27u8H8Bpvu71qNX5RUgsFXtVeYi702aI7AgwicPJ4oLH63cn8msZiWm2dfzbz7TpCWzY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB2029.namprd10.prod.outlook.com (2603:10b6:300:10c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 26 May
 2022 13:45:04 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%8]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 13:45:04 +0000
Message-ID: <bdbe733a-e910-6b88-af81-ef756b4f0f53@oracle.com>
Date:   Thu, 26 May 2022 08:44:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <311b0834-c675-fd15-8184-82b122f4a9cc@linux.ibm.com>
 <bffb3d9e-1946-f4b6-d58c-9c44bc0bee26@oracle.com>
 <94fba107-a425-7cf6-2a7b-0562c2dcfce4@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <94fba107-a425-7cf6-2a7b-0562c2dcfce4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:a03:100::41) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 229d3754-7ced-4a35-5038-08da3f1def90
X-MS-TrafficTypeDiagnostic: MWHPR10MB2029:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB2029A46E057A36D996DBB2AD97D99@MWHPR10MB2029.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SydnBdx2lws/0PW6piOIxqdF/LnzNQfwx8Obxd8JNGRpuPb/ZmFeerNvLFNy5YULnyRLFdrRthUJRE+bz8IZ23sMrZE8jxfx+Z0sMbdqSqv6BYpMdOyM0mHKP7oYOZ7O9RsOjfKxotO/RPUnNUyr9ZBm10a7filBakA1pZAgxoJyqJpoVjmRE0+OjKdxu9BN33lps1YtY6DeE+TzSIPlP8HjM8eLn1gPxeBep93WwprydpqQoU/9IU35lmm/CMg60laISjubiZqiLc3HZl8he/ZsQ9fJAGCzGqW5PFzOVs49hJfVz54rx2jORBk0eYfXlHsng1fPwB41rjS6jkL5UsJGVIijOkj6/MKN2vx/uOTy+R6hW2gnXUoLyiOEwngcyPCuKgAYdNlB+1lgSILRGDdhG9NSFv3woD9TgH+s+iNaoNP3ZLxAt97qNibo1oZbI+UHvbgN+4LWh1TWIuMdqGmKbYz4moLBLj4NCyshiuWmGl+SpBscWwkIQv+p8Xojeqkj45OtdO0rYotw8OCFy6NkVfNBVh8DE0Kzb0stYyHL/JRNi918Qzr4QwXRo4l3U0EC3ikQGHirhFfBnYN7HPRh/B5S2jTh8iRSbw3So8D5XbgA8Em5AHJSqftBM45GWYdwxsdFqn/xkAmJv0Fgh9x+8fyHf0F++0CdSTnlTAwj0nPd/p6EzV2UPtrAuo0ZVfwP6AeJpyK7gqTjpLocG6QWFVKMw6wczgdLQhfA4hk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8936002)(83380400001)(186003)(7416002)(66946007)(66476007)(508600001)(4326008)(107886003)(5660300002)(2616005)(6486002)(31696002)(6666004)(8676002)(6512007)(36756003)(38100700002)(6506007)(53546011)(2906002)(31686004)(86362001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUxpU1hDUjdKRXRFdHFVWTNCMlJ4UzE2R2JNcEU4T1dBM3AyTGozNjJBWmxV?=
 =?utf-8?B?RFlpQmg2VVhiUVdvb3kwR3hTREVkbSsvVGhUTWJyc3JKVnUxSnhROTZleTJi?=
 =?utf-8?B?SFZNYVlDQktzWFVDcWVGUE5xdkxFR1gwU1JxSmNkK2lIdHR4R25vcUhsTVMz?=
 =?utf-8?B?UE8wT1dGN1h5bEh4V1BveTF2SDVJN3o0WU16WHZZcVBvVytCaEl5Y3F1amZq?=
 =?utf-8?B?K0pnd0VsNHVIVjZ5SXhjZzNQSU5ndTY1ZUhBZjh1dElTM2dmMjJjVGlTNDZx?=
 =?utf-8?B?RjdwbWtWSHN6aUY3SFFTM016UGIyeVZWalZwWkZtMzhqNWh3RTIrRzhqbE1M?=
 =?utf-8?B?a3lBVkFzVlJSQTZhdi9DZXd2VmxvbDVZOHBjK1VFQlQrdEFTWjAwbXk2eU9B?=
 =?utf-8?B?ckV6RGN1Q2lHYXJOV25Oc3p5QWVYU2hNUDBSajlLRlJCTTFGcDR5UFhXS0lB?=
 =?utf-8?B?dGZrUXlqamY1YWhwdm1kVXczVG5sbGNPcjRBYWRRcy9XbVhmU3U5Mnc1S3J6?=
 =?utf-8?B?WW5nZjhSU2hscDZOVXN1NUNESzhYSGdWelhyTDRqNHNoMnUxU3ZlQ1FzaTdX?=
 =?utf-8?B?QTdHd0pkSzBPZG14MEdWTTVTNm5EWDNIU1FXNHRmNUdKWDdROFFYaXZlV0p3?=
 =?utf-8?B?RDBUNW8zbEhzK0tBTzZzS2RjcDY3SWVVRHZwZ1FmSXhQTEk0c1BnWitYQnl6?=
 =?utf-8?B?SGwwMHlJOVQ3bUFaTUpCRE1rVFYxMDZ2UmIvbHlabG9zbXVTaE1FOFlFS3Qr?=
 =?utf-8?B?clZkWkxFZHhWN28zSWxRYWowNkVMeml0WW1GNmJzMVNyejRLTU5YSlFiQXNW?=
 =?utf-8?B?dmE1RW9WRCswUHhZSjlKYXhhSThDc2Zra2FxWTRIZ3AvdmZ6VldlTFhkOU45?=
 =?utf-8?B?VWhMUnZXMll5QUswbnN0bTRVNUlLQ3YwbkNzVnpiQjRkazBrSVMrTDN5czJa?=
 =?utf-8?B?ei93amZSWXJjN2NtbGVHTU5uNWFBM3JEa1cyUEg1MWpoVk55bk5KdmFtT1JH?=
 =?utf-8?B?T1FMa3pCSHJlREdXaksrbm8yaWlGMGUzNG9qSFRRNTZLcEp4VGVNelpVVHh1?=
 =?utf-8?B?RmNqVzBHSlBPNnJ6T2ZOZ2xqc1FKODNuRHNlWUVUR2xieGVVbVBFaHNDRW8w?=
 =?utf-8?B?K1lMcjVXWDJKRnhwSVJLbDN6ZmNMQkVqR1VZR2JSQXR4YzdFd25QdkhVNE83?=
 =?utf-8?B?dnJOTGZwcGRTTi9YdWhOZjdDa0RPY3VTNVR1KzcwUjRsMDY2aFgvejdTOXBy?=
 =?utf-8?B?V2dMR1UwUGVrZ2ZxRGo2ZDlURGpIZFdNY1FHU21mVGhKRGU4bGtLTTBPTysx?=
 =?utf-8?B?Ry9ZYzNIQ2ZBdE1LRnZ2KzFla0tVd0hmZlRTRUhvZXE0b2U5d3RlL2JncDAv?=
 =?utf-8?B?cmRKQVREakxYdjFwR2JNVkxua2JCQ3VXdkxSd3B6dG1iY3lwaXVwb1Rta3d0?=
 =?utf-8?B?cC9MUkdwQXhhYzRzOVIvUllWcTNxbkJiQ2pKVStLR1FCaXVmMURadEh6cktF?=
 =?utf-8?B?YWEwdE13RHl6UnZNZFdBOHU0QWgrZnkrWWdBc00xbXlnWFFnTkFnSUlncHQ0?=
 =?utf-8?B?eEZieXpaQTk5V1JtUWFWSnNOYnpqZGQ1Yy8rY2pMNVNrd3VaaEwzMVVrRWFW?=
 =?utf-8?B?cFY4djQ3a29hc2N4WURhTmZIUHp2K0R3RXRUK0tVN08rSWVIT3kzYnNlWURh?=
 =?utf-8?B?SWJHajFvOXlrSmEvTDRmdFlnaVVpMC9UdG8rTGwrYXgxeVJWQVBVb0gxdm5r?=
 =?utf-8?B?eDRsZlQrZDhxS0hmTzJCb1h5c2ZUTk05VFZhcmpHYnQ4eTBIZUNpWEdKV2Jk?=
 =?utf-8?B?bjRrUFRXb3pMQ3BEM1lUL05ha05DclNoTkI3S0Z0VEFYbjhXK1NINHlSNklF?=
 =?utf-8?B?RnBjaUNBMmp2b3N5OUFERm5VUGR1aklUTHg1WUoxMG40RHNtTXo5OVdBdWMx?=
 =?utf-8?B?VVBmQklOOGdBZHpHdWRFZzZQbGFpNGpSOHRHRWVEZGRqNG9YeEMvVER4MUVD?=
 =?utf-8?B?VlE3UlAxemg1RzZ5SGkrMHhGdG5YN091Z08xWHU5cTFmaVlFczNhYmI3WEl1?=
 =?utf-8?B?TjZlTGVoUWsrSk83cWYzWFNlT1hoK0ZPcG1VOG1LUWt1cWlRbjVhZ3F3VzNZ?=
 =?utf-8?B?SFJRdElnNXhralg3cGFRVjcwTWMxOHBxVjFoOFBIZWkvalVLMzZ5U3RPQVZC?=
 =?utf-8?B?ZFBnM0ZJQjVLOFpwWmNJLzMvc1A1clc0ZHhjTTV5WDdKaUZsMi8yU1BMeFFY?=
 =?utf-8?B?ZTJLSnoxQVc2SVplOTlJL3oxbnRCVm9mcEI5Mm1id2YxQTRmczNDUk5hZEJ1?=
 =?utf-8?B?cW1FRUVobU11SDliN3pQU1pNNTltS2ZpdlJxOU9yN3ZTaXNFSWtYRjFRQm1R?=
 =?utf-8?Q?gnoGD53yNShlkmtqlLEvA9pfEhBV/FVnlhocQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229d3754-7ced-4a35-5038-08da3f1def90
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 13:45:03.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJ3VxSPGZOmMVu6vnP/1JdJ+JpQzsyOVTtYL418fkNrnpjPxdEvEYWz/BlVpkIQj4hgvQT024kBj1vwyGWskkzIlxZx4xhjoGAf+HQdsar0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2029
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-26_06:2022-05-25,2022-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260067
X-Proofpoint-GUID: IWtM-5KFCkozTEyZTQcJx5OdM9y6F6tT
X-Proofpoint-ORIG-GUID: IWtM-5KFCkozTEyZTQcJx5OdM9y6F6tT
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/22 08:39, Sourabh Jain wrote:
> Hello Eric,
> 
> On 26/05/22 18:46, Eric DeVolder wrote:
>>
>>
>> On 5/25/22 10:13, Sourabh Jain wrote:
>>> Hello Eric,
>>>
>>> On 06/05/22 00:15, Eric DeVolder wrote:
>>>> When the kdump service is loaded, if a CPU or memory is hot
>>>> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
>>>> and memory in the system, must also be updated, else the resulting
>>>> vmcore is inaccurate (eg. missing either CPU context or memory
>>>> regions).
>>>>
>>>> The current solution utilizes udev to initiate an unload-then-reload
>>>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>>>> elfcorehdr) by the userspace kexec utility. In previous posts I have
>>>> outlined the significant performance problems related to offloading
>>>> this activity to userspace.
>>>>
>>>> This patchset introduces a generic crash hot un/plug handler that
>>>> registers with the CPU and memory notifiers. Upon CPU or memory
>>>> changes, this generic handler is invoked and performs important
>>>> housekeeping, for example obtaining the appropriate lock, and then
>>>> invokes an architecture specific handler to do the appropriate
>>>> updates.
>>>>
>>>> In the case of x86_64, the arch specific handler generates a new
>>>> elfcorehdr, and overwrites the old one in memory. No involvement
>>>> with userspace needed.
>>>>
>>>> To realize the benefits/test this patchset, one must make a couple
>>>> of minor changes to userspace:
>>>>
>>>>   - Disable the udev rule for updating kdump on hot un/plug changes.
>>>>     Add the following as the first two lines to the udev rule file
>>>>     /usr/lib/udev/rules.d/98-kexec.rules:
>>>
>>> If we can have a sysfs attribute to advertise this feature then userspace
>>> utilities (kexec tool/udev rules) can take action accordingly. In short, it will
>>> help us maintain backward compatibility.
>>>
>>> kexec tool can use the new sysfs attribute and allocate additional buffer space
>>> for elfcorehdr accordingly. Similarly, the checksum-related changes can come
>>> under this check.
>>>
>>> Udev rule can use this sysfs file to decide kdump service reload is required or not.
>>
>> Great idea. I've been working on the corresponding udev and kexec-tools changes and your 
>> input/idea here is quite timely.
>>
>> I have boolean "crash_hotplug" as a core_param(), so it will show up as:
>>
>> # cat /sys/module/kernel/parameters/crash_hotplug
>> N
> 
> How about using 0-1 instead Y/N?
> 0 = crash hotplug not supported
> 1 = crash hotplug supported
> 
> Also how about keeping sysfs here instead?
> /sys/kernel/kexec_crash_hotplug

Yes, that makes more sense.
Thanks!
eric

> 
> Thanks,
> Souabh Jain
> 
