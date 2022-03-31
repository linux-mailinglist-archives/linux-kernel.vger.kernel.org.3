Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421DA4EE312
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbiCaVNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiCaVNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:13:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA929216FB1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:11:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VJ7bEa027080;
        Thu, 31 Mar 2022 21:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 message-id : date : subject : to : references : from : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=e3Ta9GEahGRpG2xvARiY2fJ8jcMbI9/c6AsXnhQXqqE=;
 b=wxXnFir6cDgWr4N3uRpv/m+hfihqwZV98NRKJH91+sDWGPB5jCmyJxWxkCCzQ3oY1AfZ
 kNMv/DIINTd9NFpGnjwoxIzY8KP861DGoxY1q2gw8lZEjcxwGpd1YPkIKShr+5a0Ygp8
 Of5AWHVH22q+QNOZj5caheHaAfEoOLX5zEk5tt+gJVcYbUnOGsmQFSibxyvb9QJPhdd5
 /0H8HFRT0Az1JxD3be4c0IzGmVWKa5XqpnTWXJro5A5R5D98oHs2tHVOz5r8syHoiYv3
 tdxLwSkCy0LbVjLqmY8Gj2uJcqzLMWmH2P0LVmNETjQDHOM/jFnp5bD7wKwJstD5d89n pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cw57f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 21:11:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VKuZsC038214;
        Thu, 31 Mar 2022 21:11:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s95wk23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 21:11:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNOsR6ucXU6O3pskBHBKFvpXo5TpvEL2AO20RU7C5dQAZoQQCAGBtBD83cvxMQT75aLKzu0eprk+XZj/pHpUc4igOzhIfCp9we+XHBKV/D8c4wJVlTCw3/EDB5VLAEe08KurZjjdhDnVm7kI3edZwdyW7A1KkFgF/jwl7cxMOpyH2MvFkKav5M88PQbU+0UCOy/Fiquv+TcNNAXtFmh7nsDh+nvEmkj8uyy3syGt5KWcvKqUADT5F6rCqJsqoEaY7KR+aw2fULsE5n3rxyKhNzQn8qvOGJcqoJ9yADD2MJcq5jJTyV6stw23ei7Y2pNCGGTQB2Qp3RTAGmZAXVoAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3Ta9GEahGRpG2xvARiY2fJ8jcMbI9/c6AsXnhQXqqE=;
 b=dR0sSHjpl6QSqP+azxzhDP6ScBhBtYclMG/xr1vdCVL58iCYEUOM+0851ZOCzx5NosFZMJFNpzjtqOtGtWj/M1NoImqJf2Q9e7dso1Vwt89yB1UYwPMe/YUXgRiC9YW0ojM7pB2rd7xbc8yEdq5TmP177APaea6Me1yh0f/+bB7cjCrSnAyV4SdUGM3hAsaS2Payjx4I+G9LQjHQyJFS4j79pcuGMjKoSA22UTfwLUTypbXMYtN85h15m/db2npANhEBWnJtYzzte34NtRcFYmLUdcYH5BDGrgaNQQkrt9wOQNsqocEYJVLjmpZhqshMnfy/ZCddIbwbAEpYe4596w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3Ta9GEahGRpG2xvARiY2fJ8jcMbI9/c6AsXnhQXqqE=;
 b=zh5Pgxw53zD5DLMLzYtil/k8RgayRmFSUak2Btj03PRcZ5Rm0NLhhkIh9VYswTGyxu2R8ti5ZAcyvn7l9sTG/RdCD6SqNbE3hyT93qmGQDDPY4ORRXYy+YqRlkvKuuilKd6WeOeicCjd4RD6xuALawziey5nb9lmHHIOtJyPcuM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5110.namprd10.prod.outlook.com (2603:10b6:408:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 21:11:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%9]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 21:11:32 +0000
Content-Type: multipart/mixed; boundary="------------miv2pOQXNB9GV809L4xIitRN"
Message-ID: <74166b6c-ce29-5bec-5513-7597afdbe5d3@oracle.com>
Date:   Thu, 31 Mar 2022 14:11:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hugetlb: Fix hugepages_setup when deal with pernode
Content-Language: en-US
To:     "liupeng (DM)" <liupeng256@huawei.com>, akpm@linux-foundation.org,
        yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20220324074037.2024608-1-liupeng256@huawei.com>
 <361111c6-921b-e129-edf3-367748f6497e@oracle.com>
 <ec312492-fea9-7130-8be4-1c362c2e84a6@huawei.com>
 <e94ea60f-9da7-98b7-7d47-1183c0fd2ddc@oracle.com>
 <d992f076-5eba-929b-e284-57bd5471cd85@huawei.com>
 <c33ab0c1-6b73-2489-efab-972c8d7fa80b@oracle.com>
 <b4d3cfee-9364-3315-652e-7f8b156306eb@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <b4d3cfee-9364-3315-652e-7f8b156306eb@huawei.com>
X-ClientProxiedBy: MW4PR04CA0351.namprd04.prod.outlook.com
 (2603:10b6:303:8a::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7ac14c4-6429-4ea2-b1a5-08da135b0803
X-MS-TrafficTypeDiagnostic: BN0PR10MB5110:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5110651EFA8D4232233435E3E2E19@BN0PR10MB5110.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQ/ytC8b3R1wROPQI8ndqCn++efxTEBYaEAoKsQ/cc3tMcl750EGTg5CtOf72AUrYuRb/WWsNdZurVVvGV7NaVwz/goxvav2BwDZuX2tl9I3kYtvY5ZcAkbyw4dSBCCPq2YBnHYO0mKZjZmzf9bAvBrkJYwJpjR9gWNSeFROEpwoiV/+t+WA9t3bnrtYjeQRfM5L7FxTqtE0ojAdjcQGqnbDxTg5NizbV3oiKYcj1+OHqMOCQIPAEEC2WcCwoxRIkl3Lt5e4WWz3RpHvFVyEQNEkPAQhP7NJtdPOJIEmxMSNIUrOgXBCUzhMCMp+zxRVVPHeHAuNTrCVOuIsmvoSjcnuXD7gxyNr8bNeiB1+Xb3As0oyEIyCmjWYka372X6mEZ2B3RW6K71gMzMnsclHWqfus4MQfCGvmTenLyOU0QVpPrAi43hruUCXZ7GKgASfO2O58APRKvaVy1ZRQkyCyNEpqayYa3FGhJ9dh28V1roLj1aDRtDH+k+yXDD3Nvud6TtXWXD58NiG314tpJQziBkm41oG1QluWXUIuiEHmVSZjPRfs89w1uCmL+haZhRNdLPo9OsyAsaC0ILEHFyteM0M5P5tRXNFfTlu1ULQBOqSxuJC9ZQipBg/pWWmrNFmdkmO25nnRCA7hdTNsBwXBluUwDnyVdPK6Lb4TT2nKndSKkq6EhOC+8oS8xpMYahmHSQ1KKwb+lzKR/0Gk2xxBRUjKYyImOGUNVgjC8idOHnvCLDusjmrj9g33jW0boaw4tdHMLs1MTRQ1K2AjKimVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(33964004)(52116002)(38100700002)(38350700002)(6486002)(2906002)(53546011)(6512007)(31686004)(36756003)(66556008)(66476007)(66946007)(44832011)(8676002)(5660300002)(508600001)(235185007)(31696002)(86362001)(6506007)(26005)(2616005)(186003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJLYmhWQTFuOThGQWdqQjUvbHRYM1ZYZjJzVU4vczZydG0xOGVhVSs3UnZO?=
 =?utf-8?B?SWFMRStZL0dNQmp1b2VDVk9Kd21zcFJWa2drUVZEcCszd2ZDbDVFRS9PcWNn?=
 =?utf-8?B?cVdrSk5XZlJqSHNpTk5Zc0hyeFhJZy9zZ0h5M2FsV1BhRVV0VERWNlRXZXRY?=
 =?utf-8?B?Y2dZSnZHZHdsR0VIY3Q4a0RjelY0NmlzdklBN0JTQjhwcndzRlh2U01Xazgw?=
 =?utf-8?B?d2xMem1SdFVUOTZnKzJkNjNoOXJTL0dSOW1JVHI4akZ6OUNEa3ZLcGo4SjdU?=
 =?utf-8?B?U1orak5MSzZkaHZNbzBLeTdoWG8vRERaTGs3U1loaHQxdHluelFKV0ZIaXNh?=
 =?utf-8?B?SUhScnpBSTJvWWdXTnFRbGMrdjVuTFNuaVgrWXY0d0hYMEJsMFNRMUVsUVN4?=
 =?utf-8?B?bTVkdDkxdmVkbTM4WjhOWVl4d3lSaW00TGdNaWhUcEthaXNQdzlYNm9XM0ZK?=
 =?utf-8?B?U1F2V0NScUVydkp5cS9TUTA0aHYxa3Bva2N1RDY5REUzWkc1by9QR0ROMG9B?=
 =?utf-8?B?ckNBRU1YN3RRUktLRldsbGVGVk4yaVNrWXRUNkVLeDFRWFh1R0JnVnE4YWYx?=
 =?utf-8?B?UzMrRWJLNXNkdlpsUjJJdDFjR3dmbHhkRjBtWld1YTF1R2tneFlXaCtNcUpy?=
 =?utf-8?B?L3g4aXVsekJrZWNNdDRZenJ6TG1WcW1ud1hpMDkybmU0aVR3T3NJaXREVEtq?=
 =?utf-8?B?VEg0NmllSjh3TUpEdU44ZWIwZ2FNc04rMjM1SEYrR2VRSjNJUHVnSUJKNkZZ?=
 =?utf-8?B?L3N1cmJVTFRpN2toclU4NFZ0L1VqUkR5SEN0QWNqdm8zbVZHU0thZXllSVZE?=
 =?utf-8?B?YVZZUUdvakxtRFpsWXN3SHVOT0dIVHVmSzcwcTBxRHl1Y1R1K0FlSUhBRHpn?=
 =?utf-8?B?eVpwWHNNbnpmck5JQ3Jld3liN1FSa0gyOEhxdDVCdHB3aFV1UmVqWlJIdXNx?=
 =?utf-8?B?T0FydGpWekY4SVVqRzdXV0I3MVFzRkJDMHFSazVKWGE0NWFwcTdlaGJnUDU3?=
 =?utf-8?B?ankvUUdkMGpqak94UUcyS1crYXkwWmV4RWc1cGo4ZHcrOUVWMG5uQU85ek5k?=
 =?utf-8?B?REg2SVg2RzlNbmVxMk45dmZjWXBqWGFkVFhDZzMwK3NVejMrRGhrTy9xSXVR?=
 =?utf-8?B?eW5ROUtNSk1LQU5QSGNFVXlCajlKSkFteitlbWJYZXdaMFMxY3ppYy9sMGNF?=
 =?utf-8?B?a2ZYcFRJM2UrR0EwQmdOUUMvcEgwSjI0OTY3QkkxR0dDbWQwY1BBNGpxZDZH?=
 =?utf-8?B?VE9mOHZSQWdEa2g2ZnFDQlFqTEtqZjJiL3V1VHZrZ0MzQ1RUY0ZBMmtZNjdC?=
 =?utf-8?B?Z2YyejFjTGVvMUdDUVhiNXBCNU9kYVJ6QUhoMnl0dFp6SFpLMXVZMDlOMkNR?=
 =?utf-8?B?Rzl6SzJReFNkbjJMOGN5VzNhM0RPSEpvdUNNa3p1ditkNUVZUk1reW5Yekgr?=
 =?utf-8?B?UUNORE9hWEpXbS94ZVAyRkIrWTdaRjFaS1pVQ1A5bkNzWkNLMG5NeDJLNitD?=
 =?utf-8?B?Z0k4cFJyZndxMjhER0krZkdDcjZnMDFxUkRaNUQvbUh6N25PbjN4ZDFYa3A3?=
 =?utf-8?B?a1Q0RENYdFJqb3pvNVFMUThVbFVPUC9LWk8xQ3JSdTB0aWZQZUJYQkZ6a28z?=
 =?utf-8?B?LytudTRMK3NKMFBnazJLN3UyRVhrb0lYYzRORkZjL29mdTd0b2JLeExYdHlV?=
 =?utf-8?B?aXY2U0ZWa240b2JnTnlkeWdrTFVwenBYeTBUdXlrNWJrV3Bta21pcWZOTWtU?=
 =?utf-8?B?cW1vUmhDVXZ2VVlrZWRwRFIxYXBQaTBqZlA4RXNsd3FCWmxZTS9qWkxzbyty?=
 =?utf-8?B?NlZnanVkdm5uS00yU0ZDQ2FQRkY3UmZWWE5OaVBrc2pYYW1iUGNsdG0zTDhq?=
 =?utf-8?B?aDdxQ3VRTFJ1TVo3QUd5NDN4UjJyVTZuOU9LQVBFTlBKMzR1Z3E3SmJLZ0Fm?=
 =?utf-8?B?OVVqOWY2V2JPUlpXTTNvMVlnWnpKNEh4Q0pEbWRZdFlKUlY5RWVxK1NxTThM?=
 =?utf-8?B?UThmcHFteWhVMk9sbTQycDN0SGMzRW9EREtRRjBRckpaU0JNK2ZRZUNwMDdW?=
 =?utf-8?B?ZS9uaUl3ZldjeGFoaVBWczNpUEszQWl6MmJrMHFYS2QvTXZvaFFjMkF4Y0lz?=
 =?utf-8?B?YzNySkZYVlVRTG1ZNk5DcXF5NHFOSVd0TDZHKzlGZmNuMERDVU5JRGsrZEJP?=
 =?utf-8?B?dUU3TWRBMUNPcDVVd3VIN1JzckZtMjdiK2dXL0lhVVgyTk0vaHliZTZsa1Ru?=
 =?utf-8?B?UnVONWxreWQybjRmZjk5d04zb1IySDhOUnZBTjQ5Y2RSVDNiVHA4aTFJVGNF?=
 =?utf-8?B?S09iNjg5aFZkVytzTFhxY3M0REVjZy93MUxla1I0bHVDTWlGbWI5UGdnb0dV?=
 =?utf-8?Q?fT6Io7MbEJvVLDEs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ac14c4-6429-4ea2-b1a5-08da135b0803
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 21:11:32.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xT9O7ZaqGjdq67eMIXx2q8/FGzq1dkR7cBMYA1MNNN7SPSfUo9EXhOtBn1+FuMJP2JXmfBR6Hl1i9+U4uXdJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5110
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_06:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310111
X-Proofpoint-GUID: 7X2AKS09Wleov-8D0244p1YORtyKr-No
X-Proofpoint-ORIG-GUID: 7X2AKS09Wleov-8D0244p1YORtyKr-No
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------miv2pOQXNB9GV809L4xIitRN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/31/22 04:23, liupeng (DM) wrote:
> On 2022/3/30 1:43, Mike Kravetz wrote:
>> On 3/28/22 20:59, liupeng (DM) wrote:
>>> On 2022/3/29 10:46, Mike Kravetz wrote:
>>>> Yes, I agree that the change is needed and the current behavior is
>>>> unacceptable.
>>>>
>>>> One remaining question is the change from returning '0' to '1' in the case
>>>> of error.  I do understand this is to prevent the invalid parameter string
>>>> from being passed to init.  It may not be correct/right, but in every other
>>>> case where an invalid parameter in encountered in hugetlb command line
>>>> processing we return "0".  Should we perhaps change all these other places
>>>> to be consistent?  I honestly do not know what is the appropriate behavior
>>>> in these situations.
>>> Thank you for your carefulness and question.
>>>
>>> I have checked default_hugepagesz_setup and hugepages_setup will both print
>>> some information before return '0', so there is no need to print again in
>>> "Unknown kernel command line parameters".
>>>
>>> Should I send another patch to repair the rest "return 0" in hugetlb?
>> I would suggest two patches:
>>
>> 1) Fix the issue with invalid nodes specified.  However, leave the "return 0"
>>     behavior in hugepages_setup to be consistent with the rest of the code.
>>     This patch can be sent to stable with "Fixes: b5389086ad7b" tag as it
>>     addresses an existing issue.
>> 2) Clean up the places where we return 0 and it would be better to return 1.
>>     No cc stable here and just let the changes target future releases.
> I have tried to write a patch as your suggestion, but the best way I can carry it
> out is the original patch. To meet "Fix invalid nodes issue and leave thereturn
> 0 behavior", I have to add the following redundant code:
> 
>  invalid:
>         pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
> +
> +       /* Allocate gigantic hstates for successfully parsed parameters*/
> +       if (hugetlb_max_hstate && hstate_is_gigantic(parsed_hstate))
> + hugetlb_hstate_alloc_pages(parsed_hstate);
> +       last_mhp = mhp;
> return 0;
> 

I was thinking something like the attached (untested).  It is very similar to
your original code.

-- 
Mike Kravetz
--------------miv2pOQXNB9GV809L4xIitRN
Content-Type: text/plain; charset=UTF-8; name="patch"
Content-Disposition: attachment; filename="patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL21tL2h1Z2V0bGIuYyBiL21tL2h1Z2V0bGIuYwppbmRleCBmMjk0ZGI4MzVm
NGIuLjRkZWVhNjJkYmJhYyAxMDA2NDQKLS0tIGEvbW0vaHVnZXRsYi5jCisrKyBiL21tL2h1Z2V0
bGIuYwpAQCAtNDEyNiw2ICs0MTI2LDcgQEAgc3RhdGljIGludCBfX2luaXQgaHVnZXBhZ2VzX3Nl
dHVwKGNoYXIgKnMpCiAJaW50IGNvdW50OwogCXVuc2lnbmVkIGxvbmcgdG1wOwogCWNoYXIgKnAg
PSBzOworCWludCByZXQgPSAxOwogCiAJaWYgKCFwYXJzZWRfdmFsaWRfaHVnZXBhZ2Vzeikgewog
CQlwcl93YXJuKCJIdWdlVExCOiBodWdlcGFnZXM9JXMgZG9lcyBub3QgZm9sbG93IGEgdmFsaWQg
aHVnZXBhZ2VzeiwgaWdub3JpbmdcbiIsIHMpOwpAQCAtNDE4NCw2ICs0MTg1LDcgQEAgc3RhdGlj
IGludCBfX2luaXQgaHVnZXBhZ2VzX3NldHVwKGNoYXIgKnMpCiAJCX0KIAl9CiAKK291dDoKIAkv
KgogCSAqIEdsb2JhbCBzdGF0ZSBpcyBhbHdheXMgaW5pdGlhbGl6ZWQgbGF0ZXIgaW4gaHVnZXRs
Yl9pbml0LgogCSAqIEJ1dCB3ZSBuZWVkIHRvIGFsbG9jYXRlIGdpZ2FudGljIGhzdGF0ZXMgaGVy
ZSBlYXJseSB0byBzdGlsbApAQCAtNDE5NCwxMSArNDE5NiwxMiBAQCBzdGF0aWMgaW50IF9faW5p
dCBodWdlcGFnZXNfc2V0dXAoY2hhciAqcykKIAogCWxhc3RfbWhwID0gbWhwOwogCi0JcmV0dXJu
IDE7CisJcmV0dXJuIHJldDsKIAogaW52YWxpZDoKIAlwcl93YXJuKCJIdWdlVExCOiBJbnZhbGlk
IGh1Z2VwYWdlcyBwYXJhbWV0ZXIgJXNcbiIsIHApOwotCXJldHVybiAwOworCXJldCA9IDA7CisJ
Z290byBvdXQ7CiB9CiBfX3NldHVwKCJodWdlcGFnZXM9IiwgaHVnZXBhZ2VzX3NldHVwKTsKIAo=

--------------miv2pOQXNB9GV809L4xIitRN--
