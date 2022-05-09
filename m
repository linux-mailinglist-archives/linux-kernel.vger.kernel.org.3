Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057B0520159
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiEIPrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiEIPrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:47:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD881BC8E6
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:43:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249FTEgL023694;
        Mon, 9 May 2022 15:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zy8pjMdroPCKqkqYm03kO0Y2lU2+lTc5BuBv2enyBl4=;
 b=LlIcPbMjISSV6iQZKP/w+CJXwL6bR6ULdG7mTZz4Jz6VYUjOYqg8SiL3KHKLgrz9Thiv
 YuEM188eU7gnfkqr7VxJwArGVz7Miy71ayETKUaBEESz/QbZvZ6tL3bzWgg3yoSUZo6k
 vgZXD9Xix5SISu++47uC3P0dc1+Zv+Jod98/ACOrxELXiau1iLag7zZCR2A7I6cWdDQj
 B31fP+2ji3/1F7jFt2mXq9jGaYH36hm4vrJ75sPF+J9xDHP9erFzzpei9wqyapadx/xD
 KnO75cZEPpFB/H7KlL1gqEd7XNRDjBUwLkZpC5LqyiTbUNhGvD+9pC0bjndkXDq5Kv/z Aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatbyaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 15:43:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249FZGrV031562;
        Mon, 9 May 2022 15:43:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf7155vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 15:43:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izOhBTw/fjUK1X8NOb3ji+tv81DbwbF/jD7qDJUp9UdZGn/l+N4jhEahMCmWbJ3WzNjPQHhjvEYp5TSb64xwwiECNb4lw92iC7lyx/yu21UNll2loCAZmyOZOytqBVcZ2Un9TVCUrsiTefYZrRjfaYRru+Wwdk9WbfvfayGoDP0bydezF7gTO6UbAqA3KOyuPHrf9eWHE/o3LxwkXf44S/baP7xzsblMgxV+PDKiKV/vTR6/mXaSz3apX1D1TaVJUseXw8KjcVLKRC+ypaB8Y9F+EtSmTF4y2dXsFKXETu2UbIOEoXT23ogpXn7019AM34QKLuQ31k0jQ09fxDt/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy8pjMdroPCKqkqYm03kO0Y2lU2+lTc5BuBv2enyBl4=;
 b=NVx5pFplRgN0Uwcqzl1ijIQ/n9rCDhDhtJHccrhneyThuCeDUTlAFFLgmPhB5UmVdhM2jt0d3VvoUtwfYDxzm4/7sb8yZQBPuXkhSnoONs1T5OV6So0bUuBu6VMMbrXXqlxhZTarG9u040t4fS7l/om+kqLdh7VlOWe3L+RqPfQLa4Cs4quLKBKKxU6LcZHshzcAGu1DvSQ0PuB2+n5Q4LRu9CNm/zYEc8I/GBLJ1aTunHsIheJ3p+xvQka9vxd6b+2FCuOIuE1O+UcWNS+dqvdzQuoqUXbpN9SyWEtQzY/z9V1jcoBmn9XQY+aPOB6LKXgp/Mtp7S7snIMXG+e6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy8pjMdroPCKqkqYm03kO0Y2lU2+lTc5BuBv2enyBl4=;
 b=VPjvDLlS3pZBoevbMCBRMX92teq+vO+hBuj1icLnaymPsvXm2jDVcTG86O09LnuUej4EKbGCkvk1kiJxzZCgjK9IczpzQKJOl8aYLU2IWwVJA+TMeAlyHQ5QrvTrPwgr5Edx5a6rYt401h+UGowrRLc6D+nWzYwa4z7t+zu55t0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB4987.namprd10.prod.outlook.com (2603:10b6:610:c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 15:43:21 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 15:43:21 +0000
Message-ID: <2da2e67a-864e-246b-b9d0-673c7af937b4@oracle.com>
Date:   Mon, 9 May 2022 10:43:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <YnTKcvkCoRBxqGSW@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YnTKcvkCoRBxqGSW@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0968dc-0216-4560-539d-08da31d2a4fe
X-MS-TrafficTypeDiagnostic: CH0PR10MB4987:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4987CBDFFD1D2139F8E3D9CA97C69@CH0PR10MB4987.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uQ+w4YtNbWt0ct9e9BTiIbCb2VK+Usy7YYMWRAfnkryVDP3Mfls9A6TMMexDnyA22ZNdjgvZGCCJ1eXN3YKD29Tlwu+xFxLpV4XoMrgELmLYtCG9OUYvVAUh6iDUf/mJMKNY3i4+gbUh1LSmZ0olXNGys8bSggyvbPPTn3wrikKKMCWziq+cnmJv+EGFf1e/pHxWzaQ/byRcpgAIoIa5rDY84hGwBoIsNNYh5R6+y62dRqhPlV2qwtP+fnMw0sXVpG2qE6YMdepCgg/x7ZSb0d4aCboNDHVRgVcT1F1cFdkvGeDsrchXpGWg6m0PFnjH94HXPTCxrdY7Ye0an1Kz7UlUahMzTgyzrPmdueWye1lA1fimeI+tukjuqT2uYw5jDbe2+wYgkhPT3AiHrdQMNZLMA9BK72jH/llvAO0KES3bWckUpoCR1cPWZTkcsBIZbvHH8OQdNibhOhYjsNXZXvVl8mqVV6dMS5QXq0rdz7r86KpsRZndfIo5dkCNq0W7DSEjOqDJV8aTnY1kjv/eLxeIABZBuvlBuK/I5qt+xGg2u2wJtdGswMrJf2BPGGBsx36kUCuiF/v5c8j1RlvKIF2HMoF1lEo08I0KO2BVmQf1MmabcZrg+dg1AwIBh6zAupAVqVc9YK2Fw8Noz9GdoyD4h5gv9PNfd+8dlHOosJqdWPPHV0mbLpXUOyLFCYp01kgSM0IoyfBPQe8IVTCq7gpsxWAvn0c+hKOn/APmp9eFC2QtPXjWUUThh77TfZu6UdfxHmnNk+Um6XaCiGRxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(6512007)(66476007)(38100700002)(53546011)(8676002)(66946007)(31696002)(86362001)(4326008)(8936002)(7416002)(6486002)(2906002)(508600001)(6666004)(6506007)(6916009)(2616005)(316002)(36756003)(107886003)(83380400001)(31686004)(186003)(5660300002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE51VWNudXEvWWVoTGVRYU1CRWJ3bTRSSzRaTUVZMnFoT1VXdlhyN3JDM0Rj?=
 =?utf-8?B?aEdDNHB0VlgyVG1xcTlINlFSUEltMTZLQWhuYmRsUGRPU0ZZeEFybHE0RG5T?=
 =?utf-8?B?UWtnMzRDdDZNQkh1SGE4ZnVtOXJBZGo4dU5VZjlZYkdNV3Z1TG45dExrVy9G?=
 =?utf-8?B?Qjd2OVhLWWRGTVNjZFI1MFloZEUrRVRrWHA5OGJBQnBUVnF5TGVMaEJCRlFQ?=
 =?utf-8?B?SERpdHU1bERRdFkwUUlFYmpFbkpldGpSSUpRRzJhU3N6a0FNSlFxejdlNjVs?=
 =?utf-8?B?TVZMd0M4dkdId2NOZzQvMnhkTDlJaXBTR2tpcDhEelZzMEYxSkN2R3hhZ1lj?=
 =?utf-8?B?ZXR4Q0VJRytxWVRnUjJqYUFxS2I4VTVvSHliTVdrbDFOMFdYWHBnbE4rbms2?=
 =?utf-8?B?Z1ZaSEZxVmlmOSs1VkhIdDgyNnBjR0tCRlc2c3U2dzNWU3Vrc3oyWkJvYXN4?=
 =?utf-8?B?L1Z2dmxBU3JYMGNYOXlNdG52Nkx6NmxBV0RYby9uMjZvZFBmT3Y5QkFicXN3?=
 =?utf-8?B?SHg0c1NDK2V3RmZjMWdKK2ZXdFRvamJ4Wmk4NUJJVkx0RUdhMnlzZFArYWg4?=
 =?utf-8?B?TUZ3VEJpKzhZTExVenJQSytGUEJkZU9CRm5WRVdYb2twcDJ4WWhPUDY2TUha?=
 =?utf-8?B?RWx5TjFMMytEejBmNnJ4QTZOSVl5bDlnd0Z6UnZzcjhkaDFxblFQelNUcXZo?=
 =?utf-8?B?bXlpUTJvdWduVkkzaXpuYXNVMWVMeUFxWFp5YzdobEczUlVSM2hURWxVV3dj?=
 =?utf-8?B?S2d5N0trS2xFazBNSFU5NWpuWmZINmdkL0xNRVNzWXJHUGd1OWxEWFRxMkZa?=
 =?utf-8?B?TVpxTDJndHNtU21SNFdWeVQydmI3c0h0cVFQTDhjamlldTV2bnRMa2dXOEZs?=
 =?utf-8?B?V3p1SXRTalpsemdzbUo1RDAwaUpoc3pOZ3ZEMFVtcndDWnZXS0JqNHRXaWdt?=
 =?utf-8?B?VUhyUlB6cE5sSUx3VFBtNnNhRDQyRUtMWUNCNzI1TkNnQWhTejdtVWJXT2Jw?=
 =?utf-8?B?NE1CYkVsdnpxN3BtMHREcHUydUVWYmgzM2RkMHdHMTVWWGpwTkxEM2RqY1pt?=
 =?utf-8?B?ZW0wV3Nvd2d6Q1pQenFPVndheTBkczM1YnlzNUNxcmkxTDdNa1NpakRDeFlK?=
 =?utf-8?B?ejZzL3huOXNna3pOUDlCM0J6cjJGc0RMU2xaTUlENm96bGhnZWZuRU4wWldt?=
 =?utf-8?B?YlRxSGxBRmNKT1I5VW5WV1VEanJSYmxiMVF6dm1QOS9FdnpzQWN0VWQ4VDFw?=
 =?utf-8?B?ZHJwSnh2bGJDWkx6dkdQUTl2V0Z2N2RsenZlWHVLdlFrc0p0OHRjUkUrRDJn?=
 =?utf-8?B?OXhMcjBhYXl6OTdDU3BCcnlMNGt2d2xqd2Q0Y05PTWVhRHZ3YmFpMDVKZHg3?=
 =?utf-8?B?MXczRENCNEVDVnkyOEYrcEFGTnZ1TndDN1dDcTBsMk04bmxkMXh1V0hkM3g3?=
 =?utf-8?B?ZDdWYm5hOEU2WUg5dm9YbDVZTHJhaXdJNkpMM3V0SklBM2pDN01sdlpxSEJm?=
 =?utf-8?B?ZzFpZmpubDlJNG53aXlPY3kxdTBKbU5JZCszbjhaSVZPWjU4SGFZQzNjUlVt?=
 =?utf-8?B?YmxFWm45N0tFb1YvcjZhdks0elFha1JoOGZWWVoyaVlEV1lZenhURitPUkJv?=
 =?utf-8?B?dS9GQTVzRG5zRXZ3T3pxME5ubDJUL0dONVU0S3Y1SXRFNXJMeTI2b1RwMCty?=
 =?utf-8?B?bHU2RWIyUFlPWm83cUFxNm5zeWlmdGVQNGJEMEZUeUFPUHI4aGhhc1FKUzN0?=
 =?utf-8?B?NEJBSTBpL0RaYWU5dVBOVXdmYjFJQW5LckVoY0E4VGd3bUgvcEJCRis2dlla?=
 =?utf-8?B?aVZYSUdnUWx3c3NicDRFa1J5ZWRxcXM2dlNncTd5M3pzNGlFM0hSWTM5VEla?=
 =?utf-8?B?WWJEL3ZqNTdVN1JzVHhHZ2lLbXJxMW5nZzVRUlo2VGh0OTB3ekl6aURKc0Q5?=
 =?utf-8?B?SU9id2hhT1BBNyt2aFBUVnhBYlgvdGF0eG5aVC9NbjM4cC9WQ2tSaEFFNnYr?=
 =?utf-8?B?YUFkVmo2ajhHTXVUd1JpSVNXQ1BSU2t3UUVDYkxtR2JMMWVCUytIOVlmV2RH?=
 =?utf-8?B?NThvaEVvUGsrN3NKTGd1QURLV1YrOTNtWmV4bmtLYWVYbERrYzRJdG1TN0cw?=
 =?utf-8?B?Z1pyUndCR3VZYklKMFR0TnhVSFAreU9aMm1PU2RxQUNKTGhDcjR4QkNTUmYw?=
 =?utf-8?B?ekU4a0QvcGU4b2doT1c0Y3FhYzdobkJtVGlTbmM2OVdneisvRHRHdE1ZYlhl?=
 =?utf-8?B?NnhoT1hCTnBrRkJuUVcyYjA1N0JhRDRXcjB1aE8xVk9jc2J2S0VkcVpneVFU?=
 =?utf-8?B?Sk15YVFvRW8vWUpZdGFWSXRBNFFyb2J5cXBmRUd2S0k4TFlKbkpvR1BneU92?=
 =?utf-8?Q?n9DfmH3M/IBvUpGP/PgQrPyNjfoeN9+voTKd60065zVNQ?=
X-MS-Exchange-AntiSpam-MessageData-1: pqMU9xk4Zr4A0g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0968dc-0216-4560-539d-08da31d2a4fe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 15:43:21.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGToligam78HFlGx0tmuz/2KIN8bEM43UOS/RolEPVcmDQxHVO12rjDL2vPEIv7X9eTN38k5BHL42jV64+9qlDAL3G87sGsQeIH5ufSwS9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4987
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_04:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090088
X-Proofpoint-GUID: msQ6J77npPx4zDtkWc8pDC6agaYAAPpo
X-Proofpoint-ORIG-GUID: msQ6J77npPx4zDtkWc8pDC6agaYAAPpo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/22 02:12, Baoquan He wrote:
> On 05/05/22 at 02:45pm, Eric DeVolder wrote:
> ......
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 256cf6db573c..f197af50def6 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -9,12 +9,17 @@
>>   #include <linux/init.h>
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/highmem.h>
> 
> Wondering where highmem.h is needed. Just curious.

Ahh, I missed that. At one point in time we moved map_crash_pages() into this file, which brought 
highmem.h along with it. But we have since moved map_crash_pages() into x86/crash.c. And I missed 
eliminating highmem.h at that time.

I have removed this for v9.

eric


> 
>> +#include <linux/memory.h>
>> +#include <linux/cpuhotplug.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>>   
>>   #include <crypto/sha1.h>
>>   
>> +#include "kexec_internal.h"
>> +
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>>   size_t vmcoreinfo_size;
>> @@ -491,3 +496,90 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
>> +							unsigned int hp_action, unsigned int cpu)
>> +{
>> +	WARN(1, "crash hotplug handler not implemented");
>> +}
>> +
>> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (!mutex_trylock(&kexec_mutex))
>> +		return;
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
>> +		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Flag to differentiate between normal load and hotplug */
>> +		kexec_crash_image->hotplug_event = true;
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
>> +
>> +		/* No longer handling a hotplug event */
>> +		kexec_crash_image->hotplug_event = false;
>> +
>> +		/* Change back to read-only */
>> +		arch_kexec_protect_crashkres();
>> +	}
>> +
>> +	/* Release lock now that update complete */
>> +	mutex_unlock(&kexec_mutex);
>> +}
>> +
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +{
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +		register_memory_notifier(&crash_memhp_nb);
>> +
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
>> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +									"crash/cpuhp",
>> +									crash_cpuhp_online,
>> +									crash_cpuhp_offline);
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif
>> -- 
>> 2.27.0
>>
> 
