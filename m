Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3D51B1AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359251AbiEDWQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiEDWQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:16:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6750E00;
        Wed,  4 May 2022 15:12:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244Kx9UW026258;
        Wed, 4 May 2022 22:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QmHOThZ8fnUhpatstW1BVUqH4ECOe/TWvG5t9ZCbXys=;
 b=guOJeKy5Nk78qtv3zmnI03rbvP/tI/EnhEg9BCdKt36OXLE9vSnPOG6OrEALBi6KEBSo
 IXBJSIxQOd+sIMcltNIN11TDG3WWbsVcyDAT+eIvv/Cp+gc5XvabLZugQb+QilTeCg5n
 FWJeted2UFhlIgVai0nzYfjNhoyqKurhfiL5b1jxTy0k3ofplJzCaGxH8/f3LApqjw7A
 Re1dvWr5rIBiFZDW+6n5Mee/8i+SW5cn2sADoitkaboZD4miEc0Kem8/dLwFHmQryuK+
 1H/k9YHzh+9xlE8vFdylGV417zdO9wsP9QV2X56ow0zaAH9b5/BlM+xYs7iBcgjV8JAx 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc9ms1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 22:12:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 244LuU5r005362;
        Wed, 4 May 2022 22:12:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj3t1xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 22:12:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr6UeIELZ6fkVu2N/7gtBRA9BIG9oegJrzERYOi/TDDcokjGvbpPx6IvKgfmw3kXomJ6ddujcxzqHpW/iFf1qPTYu9xgHgiI/J2hu4zRq2rXJYL/bsu183HFLa+Gcs9FlBJOKp/Poqd3aeX6Q8Tuwu+QAzqzueBBAESLy/FC/LYL+Q3AI5jTiLmhFzthNFNbV3qi1UizERQxPDsU0iRHI8GorV3UYqdoN47q+k8iBQWlWd8SOWBe9rFultYuIJdW8WV3oRO06IM80EykV7EQMQhteg4MW5iHeYIUWkbHdO/RcdGTaWbz7It6V5YE+IrsrnzQ70b9Edod12qVFiwFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmHOThZ8fnUhpatstW1BVUqH4ECOe/TWvG5t9ZCbXys=;
 b=Lpfnp+8sPxIqOOLdiyK0Ad9rTNnBszz2y4gpNb9kyysPwa0n3gMZXgQkpoXN/Lja+SrQYCp9vB0L8miQGvu1qTESSBWuf049fEvsOODwTaX8boZmp+cbSqpCXNGeV7y9hz1+r8GAfUV2o2RERPWcj3T1PEBxKH1UUc/wSzxzxIOIRHhn9KIBpN9Q7n1W8TWvH6NudrNsKkdsxNPCF1NcoUcxap+qrX/sL+pnT1NlqpR9f5oWtuuICeFhSLK42OfXsRWnqksy4we3ruYl5sLZ3TW9AV4wvgtysqyJYE6yI0nZEMyJb47yNWW0Wfv7lQAXE8WUDiPRzmZDoWdBhGnVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmHOThZ8fnUhpatstW1BVUqH4ECOe/TWvG5t9ZCbXys=;
 b=S701aklLN26Xl8eq4E7IZER22jd+gJh5Kl1d6LyW1iVHJh7SGHYI2nStSXaOIURL5iNXONBJOi5rj1BumxAMt+rnP1x3Jy4PrB4uGsXPyCHTA6rW8OmJqySrltF28TB4E1NfNMV5e2sRhy3rhur6BHrm5dqK3KN+r6ywwfaxEkE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3141.namprd10.prod.outlook.com (2603:10b6:a03:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Wed, 4 May
 2022 22:12:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 22:12:42 +0000
Message-ID: <eadec7de-2e1a-2fb3-3317-c7b492a84e2b@oracle.com>
Date:   Wed, 4 May 2022 15:12:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220429121816.37541-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c845eb3-bca8-4178-8cf6-08da2e1b35bd
X-MS-TrafficTypeDiagnostic: BYAPR10MB3141:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB31414F2FD9C4F259855E58A3E2C39@BYAPR10MB3141.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wo1AxE0ftqrk+Arl73gtnx3D6GzBNx+UtctMlaxKLhuWIrEU6ZAg0tAT78cN7M7yWNS2sRY5hkjkru9FAJBnUuKp1Un/psn8QHCppPEnfMT8U0TJPLPCHXLAMS5gmi9fq0PAluXNiJQHH9bKNWnV0S8+YseHocNO6nQy4yEbJHI6oBvBI342H11iZW6TO4lYQAdNp3W1+Lplu7wjHv2E6NPwvdeLwS3wXhtOxXvdIStXwxeLtCpqUFC7oK9MdFbtjwS3yI+kgX+Jlu6gUwSGkcV6yutt3DjQm+Akq+2ep6kcG7lWhDW5yUp1V3f6+Z+TKhYPuY9Hx+aNkJNWN7UzKCtX7LPnD6LAVFShvjgDixX4A/BOA2N652eyCD4roReZJcs1PcNJFDXGq+fem6tv+LuEiBgrR1JxB4i8bTf6gkP4oGalqon35ttiI5i7vOWgvpWPpgMF8WORenhCWlTiUbIqxGqhR9JGw9KerRIZMeCCQsl7U5iBhthBNPew4yQTwduZxSrahA6mAyoNuK9oOtay2ww7SncBHetNuf5ZsYLhbIgsEH8mVXdeYc3gp46RUhd/vR+9PHp3AjIfa2IJcoBcUHNdt60VTYDL5S2E8rlj4ZA/YwgT3Uqn3/hIiaw8iXbh6Z0Hha5LvvizTDcc2CjJjpKMX0Zw4o/96sc0M8DdxB+OgRRTtnba4phmCU4s74T81A1U2gYEnjMMV2BQ1pI41x8WGx6x9mt1vkmGIRv4sJRaScNfOAbMV607QuhuQ5SQSHvsmQaXP+SQG2zFWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(83380400001)(36756003)(53546011)(316002)(6506007)(66946007)(38350700002)(7416002)(86362001)(31686004)(38100700002)(2616005)(2906002)(508600001)(26005)(31696002)(8676002)(4326008)(66476007)(6666004)(66556008)(6512007)(186003)(6486002)(44832011)(8936002)(5660300002)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGNIeVA1MGpCN0hKOTFSRlU5NXpnSlRtWmxIR3FWeU5zQUhBdzVRQjdObER4?=
 =?utf-8?B?VEkwS0orRnVjVVRYaklmUFNSUVVvbHJ5eWlMaUkrMWlaVXk4OEJVTE5DSlY0?=
 =?utf-8?B?VHRpWW5ObEcva0l5bXh5OGRVV0QwaForbmFCWlZUVXlMWlZhWUtIQ0NwQmpi?=
 =?utf-8?B?QjdPL1ZjV1I5b08wTUxpUG5NQmV2RWowV2xmMlRGU1F5dlpSZmQzMnFKSy81?=
 =?utf-8?B?TW1OM1pFSFRVNG05M252VjhmNHJXK2tUZFFNb1JYWFVMeFFSRm1wT1E3dVdH?=
 =?utf-8?B?UGVSOVhqQS9SdjBXdU1SMXZJcE11WS9qdjZGL2Q1MFZ6N241TUFmUm9POEJZ?=
 =?utf-8?B?VWxubVorbExaMXpqZHRiMFU4c2JUaURiRVgyWVJ1YUluaXpiNFN3NEQraVpo?=
 =?utf-8?B?cHR1eVB2OCs1ZDZZRlBUZ1ZMWVJ6cFYraUJqKzI3bEsrRktWYXRzb1RaRlJx?=
 =?utf-8?B?NDB4L1VKU0pZNnFObXdWcTZLMHIrWlJteW83YXpUQm9zMm1ieU1scFlla0U4?=
 =?utf-8?B?N2FpVXNaU2VtS0VIL0FFcUY2SzlJUDJpQTlaQ1N4dlhFeDJkOG9VSmY3TVlD?=
 =?utf-8?B?c2NmcFBSamZVQVNVUWJJNFQvUFNmUmdJRFhlQWwvRzBHNWdrTzFrRHJoWFNW?=
 =?utf-8?B?TmZQSVhwY2Q2bmdRVk9XVHd4WXBEVm9mTEhzTm54REE1QllHVG9HZkJhc3E5?=
 =?utf-8?B?eXpTaWY2K21OdStteFZ4OUVnMS9zOTBGMGlZMEdRbitXSjVsQ016empKallu?=
 =?utf-8?B?VzdZTzFOdTJoTlFxaFBBc0VsUGhkVkIrLy9mdkpzU1lZOVp5dU16eGhPTFAy?=
 =?utf-8?B?VXVLWnUwekNsakF1RDh3QmpUVjNnTy9hb25RT1RkYWlKcXgzdTF6bTUxS1dI?=
 =?utf-8?B?eksvT2dNUk5LS1k1SElXMkFWV05sa09aVWtqaDBIc2hkU0Y3WUtUUUJjbVUz?=
 =?utf-8?B?K1FWcGRFNDZpMEJSeUZOMDFhcUpFeUtkTXhpUnFaY1Z1WjlaNGNiRko0aEVQ?=
 =?utf-8?B?RWlNbW1BRmY4Rk1xMWNYL3VteC94ZlZ1RitOSGtKc29Bbk4wZVE2bk1yclQz?=
 =?utf-8?B?WFk0a2Y3OUtHaXhXMkJUNFEreTFXck9rTEZNVC9Ua0FSNlVkd0RESnkyV09B?=
 =?utf-8?B?ekpIdzVjczFIRk1tU3BGNGpuY2RpRjRFV2lST25QVU8yazUxOEVtNTl1V0hZ?=
 =?utf-8?B?ZGd6UmVWTUZ1UjZINjFRcThNdkFteE1yMWliYWtCMEFJZlhQdXNMb003RlVp?=
 =?utf-8?B?TXBMMzZyanFpYmFaWEdWaWlrWU9HRHlFeWhZaFJkR2dOc3h5VTdrWS9Bb1lY?=
 =?utf-8?B?dDhCTllEMGtzZXp6THYrWU1LWWZVbjdrcUdSejgwbmpENzMwQ3FQd1FzUDM2?=
 =?utf-8?B?UW83ZmZGb3l1ZGl2S0EyNkorWjlQNXptcWNSMkwzTlNoU0hob21HMFFIN1lI?=
 =?utf-8?B?ZjZabkdyVDYvUHY0cVlEdUFMNXVKUEpDMWJQdlhxS2J0SC81Zk5VSXZvbnVT?=
 =?utf-8?B?VWp5Y3RaWkNrWmlGc3VYTHBoeVdyT1pITUl1ZForT1NmUDVEK2xxaDlrNUxL?=
 =?utf-8?B?dU5kNWM0UGtaT2JubHM1Z3M3bUxPSldTOTlZUzdVVkZLaEIxTG51WTN2bnRL?=
 =?utf-8?B?RXpPc2tXUHcwdXJVb05lRlpqYkNOb0FER3h4NDN4S1F4bmFJZi9tcmRtUnpo?=
 =?utf-8?B?RzNsTFBTU0d0Z0R4Q3ZWdW9RQy9IVWVlSm5SNTB5c2I5dnlnOVhVNy9YU01Q?=
 =?utf-8?B?anpJcGNQRXhtTHlaUnVqRDE3TjlDZnliOGl4U2U3QTRCZDlHY1h6eStFNC8z?=
 =?utf-8?B?OHk1U08vbWNPSzV4dVNGMTc1V2k0MkU0NTRaUEVpQ29LK2dxaVBGSzgrYVBy?=
 =?utf-8?B?M1RHZmxlWFNwb2pjU0N3NmYyVTdWUm5MYW5rZEJ1UUNQdzFNYlcxRXNTa1JN?=
 =?utf-8?B?d0lEWkkvelNFaG00VkRySzlPTnJKaGRCUFE3cmR0WG5BQXM2OEtkMWJlSTNI?=
 =?utf-8?B?MU11eDhBNWlCYlAxa051VnlDNEtQeWROdk9mNTNVWmRZUnJmVTZrK0Q2cTd6?=
 =?utf-8?B?cnRyWEJxTkdqMUNUWnh2T0hHTm9UeENxZ2dUOFV2M3ZLV09TanM3SndsSXRa?=
 =?utf-8?B?Y0lEL2VONkZPOHN2d1ZRaWZGeHhQS1grWmV2b2NJSUdFcU1wczBxZ1ZKWERI?=
 =?utf-8?B?TncxVHdXbU1IbndzVUVxV2pQdU5yUSszY0l6NEhPUlZoVW00MG9xbmJKR1Ev?=
 =?utf-8?B?SWlpS2F1ZW1DcEx4NzBlY2szQ3BGL3dSQnAycnI2Qm5sb0EyWlFsZkc1cjY1?=
 =?utf-8?B?amNmUGdLTHIrV25uNzN2NXY2QmU1aCtmekFLc1lUdTVjeEppRGViazE4SVAy?=
 =?utf-8?Q?+NPj5e3IRJWXz7p4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c845eb3-bca8-4178-8cf6-08da2e1b35bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 22:12:42.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9/UaCFKrh6cKJGfaIeJfL7Wu5iBoGsubdnemI15CvIOE4G4DvYe/55TD07ViAjMPqdLZne0Hp22ZRFqpXtLEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3141
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_06:2022-05-04,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040123
X-Proofpoint-GUID: 183vKRHzj9eh3YAc-wzfTyAaOqlIa0en
X-Proofpoint-ORIG-GUID: 183vKRHzj9eh3YAc-wzfTyAaOqlIa0en
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 05:18, Muchun Song wrote:
> We must add hugetlb_free_vmemmap=on (or "off") to the boot cmdline and
> reboot the server to enable or disable the feature of optimizing vmemmap
> pages associated with HugeTLB pages.  However, rebooting usually takes a
> long time.  So add a sysctl to enable or disable the feature at runtime
> without rebooting.  Why we need this?  There are 3 use cases.
> 
> 1) The feature of minimizing overhead of struct page associated with each
> HugeTLB is disabled by default without passing "hugetlb_free_vmemmap=on"
> to the boot cmdline. When we (ByteDance) deliver the servers to the
> users who want to enable this feature, they have to configure the grub
> (change boot cmdline) and reboot the servers, whereas rebooting usually
> takes a long time (we have thousands of servers).  It's a very bad
> experience for the users.  So we need a approach to enable this feature
> after rebooting. This is a use case in our practical environment.
> 
> 2) Some use cases are that HugeTLB pages are allocated 'on the fly'
> instead of being pulled from the HugeTLB pool, those workloads would be
> affected with this feature enabled.  Those workloads could be identified
> by the characteristics of they never explicitly allocating huge pages
> with 'nr_hugepages' but only set 'nr_overcommit_hugepages' and then let
> the pages be allocated from the buddy allocator at fault time.  We can
> confirm it is a real use case from the commit 099730d67417.  For those
> workloads, the page fault time could be ~2x slower than before. We
> suspect those users want to disable this feature if the system has enabled
> this before and they don't think the memory savings benefit is enough to
> make up for the performance drop.
> 
> 3) If the workload which wants vmemmap pages to be optimized and the
> workload which wants to set 'nr_overcommit_hugepages' and does not want
> the extera overhead at fault time when the overcommitted pages be
> allocated from the buddy allocator are deployed in the same server.
> The user could enable this feature and set 'nr_hugepages' and
> 'nr_overcommit_hugepages', then disable the feature.  In this case,
> the overcommited HugeTLB pages will not encounter the extra overhead
> at fault time.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 30 +++++++++++
>  include/linux/memory_hotplug.h          |  9 ++++
>  mm/hugetlb_vmemmap.c                    | 92 +++++++++++++++++++++++++++++----
>  mm/hugetlb_vmemmap.h                    |  4 +-
>  mm/memory_hotplug.c                     |  7 +--
>  5 files changed, 126 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 747e325ebcd0..00434789cf26 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -562,6 +562,36 @@ Change the minimum size of the hugepage pool.
>  See Documentation/admin-guide/mm/hugetlbpage.rst
>  
>  
> +hugetlb_optimize_vmemmap
> +========================
> +
> +Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap pages
> +associated with each HugeTLB page.

Should we mention that "memory_hotplug.memmap_on_memory" or an unusual system
config that results in struct page not being a power of 2 will prevent
enabling?

> +
> +Once enabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
> +buddy allocator will be optimized (7 pages per 2MB HugeTLB page and 4095 pages
> +per 1GB HugeTLB page), whereas already allocated HugeTLB pages will not be
> +optimized.  When those optimized HugeTLB pages are freed from the HugeTLB pool
> +to the buddy allocator, the vmemmap pages representing that range needs to be
> +remapped again and the vmemmap pages discarded earlier need to be rellocated
> +again.  If your use case is that HugeTLB pages are allocated 'on the fly' (e.g.
> +never explicitly allocating HugeTLB pages with 'nr_hugepages' but only set
> +'nr_overcommit_hugepages', those overcommitted HugeTLB pages are allocated 'on
> +the fly') instead of being pulled from the HugeTLB pool, you should weigh the
> +benefits of memory savings against the more overhead (~2x slower than before)
> +of allocation or freeing HugeTLB pages between the HugeTLB pool and the buddy
> +allocator.  Another behavior to note is that if the system is under heavy memory
> +pressure, it could prevent the user from freeing HugeTLB pages from the HugeTLB
> +pool to the buddy allocator since the allocation of vmemmap pages could be
> +failed, you have to retry later if your system encounter this situation.
> +
> +Once disabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
> +buddy allocator will not be optimized meaning the extra overhead at allocation
> +time from buddy allocator disappears, whereas already optimized HugeTLB pages
> +will not be affected.  If you want to make sure there is no optimized HugeTLB
> +pages, you can set "nr_hugepages" to 0 first and then disable this.

Thank you for adding this documentation.

We may want to clarify that last statement about making sure there are no
optimized HugeTLB pages.  Writing 0 to nr_hugepages will make any "in use"
HugeTLB pages become surplus pages.  So, those surplus pages are still
optimized until they are no longer in use.  You would need to wait for
those surplus pages to be released before there are no optimized pages in
the system.

> +
> +
>  nr_hugepages_mempolicy
>  ======================
>  
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 029fb7e26504..917112661b5c 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -351,4 +351,13 @@ void arch_remove_linear_mapping(u64 start, u64 size);
>  extern bool mhp_supports_memmap_on_memory(unsigned long size);
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
> +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> +bool mhp_memmap_on_memory(void);
> +#else
> +static inline bool mhp_memmap_on_memory(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index cc4ec752ec16..5820a681a724 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -10,6 +10,7 @@
>   */
>  #define pr_fmt(fmt)	"HugeTLB: " fmt
>  
> +#include <linux/memory_hotplug.h>
>  #include "hugetlb_vmemmap.h"
>  
>  /*
> @@ -22,21 +23,40 @@
>  #define RESERVE_VMEMMAP_NR		1U
>  #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
>  
> +enum vmemmap_optimize_mode {
> +	VMEMMAP_OPTIMIZE_OFF,
> +	VMEMMAP_OPTIMIZE_ON,
> +};
> +
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
>  			hugetlb_optimize_vmemmap_key);
>  EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
>  
> +static enum vmemmap_optimize_mode vmemmap_optimize_mode =
> +	IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
> +
> +static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
> +{
> +	if (vmemmap_optimize_mode == to)
> +		return;
> +
> +	if (to == VMEMMAP_OPTIMIZE_OFF)
> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> +	else
> +		static_branch_inc(&hugetlb_optimize_vmemmap_key);
> +	vmemmap_optimize_mode = to;
> +}
> +
>  static int __init hugetlb_vmemmap_early_param(char *buf)
>  {
>  	bool enable;
> +	enum vmemmap_optimize_mode mode;
>  
>  	if (kstrtobool(buf, &enable))
>  		return -EINVAL;
>  
> -	if (enable)
> -		static_branch_enable(&hugetlb_optimize_vmemmap_key);
> -	else
> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
> +	mode = enable ? VMEMMAP_OPTIMIZE_ON : VMEMMAP_OPTIMIZE_OFF;
> +	vmemmap_optimize_mode_switch(mode);
>  
>  	return 0;
>  }
> @@ -60,6 +80,8 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>  	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
>  	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
>  
> +	VM_BUG_ON_PAGE(!vmemmap_pages, head);
> +
>  	/*
>  	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
>  	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> @@ -69,8 +91,10 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>  	 */
>  	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
>  				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> -	if (!ret)
> +	if (!ret) {
>  		ClearHPageVmemmapOptimized(head);
> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> +	}
>  
>  	return ret;
>  }
> @@ -84,6 +108,8 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>  	if (!vmemmap_pages)
>  		return;
>  
> +	static_branch_inc(&hugetlb_optimize_vmemmap_key);

Can you explain the reasoning behind doing the static_branch_inc here in free,
and static_branch_dec in alloc?
IIUC, they may not be absolutely necessary but you could use the count to
know how many optimized pages are in use?  Or, I may just be missing
something.
--
Mike Kravetz

> +
>  	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
>  	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
>  	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
> @@ -93,7 +119,9 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>  	 * to the page which @vmemmap_reuse is mapped to, then free the pages
>  	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
>  	 */
> -	if (!vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
> +	if (vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> +	else
>  		SetHPageVmemmapOptimized(head);
>  }
>  
> @@ -110,9 +138,6 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
>  		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
>  
> -	if (!hugetlb_optimize_vmemmap_enabled())
> -		return;
> -
>  	if (!is_power_of_2(sizeof(struct page))) {
>  		pr_warn_once("cannot optimize vmemmap pages because \"struct page\" crosses page boundaries\n");
>  		static_branch_disable(&hugetlb_optimize_vmemmap_key);
> @@ -134,3 +159,52 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	pr_info("can optimize %d vmemmap pages for %s\n",
>  		h->optimize_vmemmap_pages, h->name);
>  }
> +
> +#ifdef CONFIG_PROC_SYSCTL
> +static int hugetlb_optimize_vmemmap_handler(struct ctl_table *table, int write,
> +					    void *buffer, size_t *length,
> +					    loff_t *ppos)
> +{
> +	int ret;
> +	enum vmemmap_optimize_mode mode;
> +	static DEFINE_MUTEX(sysctl_mutex);
> +
> +	if (write && !capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	mutex_lock(&sysctl_mutex);
> +	mode = vmemmap_optimize_mode;
> +	table->data = &mode;
> +	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
> +	if (write && !ret)
> +		vmemmap_optimize_mode_switch(mode);
> +	mutex_unlock(&sysctl_mutex);
> +
> +	return ret;
> +}
> +
> +static struct ctl_table hugetlb_vmemmap_sysctls[] = {
> +	{
> +		.procname	= "hugetlb_optimize_vmemmap",
> +		.maxlen		= sizeof(enum vmemmap_optimize_mode),
> +		.mode		= 0644,
> +		.proc_handler	= hugetlb_optimize_vmemmap_handler,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{ }
> +};
> +
> +static __init int hugetlb_vmemmap_sysctls_init(void)
> +{
> +	/*
> +	 * If "memory_hotplug.memmap_on_memory" is enabled or "struct page"
> +	 * crosses page boundaries, the vmemmap pages cannot be optimized.
> +	 */
> +	if (!mhp_memmap_on_memory() && is_power_of_2(sizeof(struct page)))
> +		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
> +
> +	return 0;
> +}
> +late_initcall(hugetlb_vmemmap_sysctls_init);
> +#endif /* CONFIG_PROC_SYSCTL */
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 109b0a53b6fe..19840aa900fd 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -21,7 +21,9 @@ void hugetlb_vmemmap_init(struct hstate *h);
>   */
>  static inline unsigned int hugetlb_optimize_vmemmap_pages(struct hstate *h)
>  {
> -	return h->optimize_vmemmap_pages;
> +	if (hugetlb_optimize_vmemmap_enabled())
> +		return h->optimize_vmemmap_pages;
> +	return 0;
>  }
>  #else
>  static inline int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index a6101ae402f9..c72070cdd055 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -63,15 +63,10 @@ static bool memmap_on_memory __ro_after_init;
>  module_param_cb(memmap_on_memory, &memmap_on_memory_ops, &memmap_on_memory, 0444);
>  MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
>  
> -static inline bool mhp_memmap_on_memory(void)
> +bool mhp_memmap_on_memory(void)
>  {
>  	return memmap_on_memory;
>  }
> -#else
> -static inline bool mhp_memmap_on_memory(void)
> -{
> -	return false;
> -}
>  #endif
>  
>  enum {

