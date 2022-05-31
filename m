Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA61539978
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348389AbiEaW0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiEaW0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:26:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0884C9CF13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:26:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VKqgga031617;
        Tue, 31 May 2022 22:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=p5/qqv1Qs7SQ0a9uSXQELnic5Q8FZYjDnJrBYeL0UP0=;
 b=CfiYnrqG8AH+ORmALn6h+xvRG0Yq9MC8AorqIvXlUUvLVEJxd5Jr48s/Donw6O9Nhvwu
 wdI51O0UlLNth2aVtNaIRdcjJpjMUvcV8NUWCCtrAUF+074Ge0FQ64M19X+l956pWgoC
 DUviIPVwQzHANFgrzbYb1U9YnTBDuiaOt1garueLIEQJVwRk2A7yL1WjffqPKYyoZHAd
 K6s0pUlxaQe/YH3XguiY5oSIYNuoQf5EyN3PaGy7LpMyR+I//e8Cei6/vlN3tZLrLojT
 3AER/jCrlGxyINUU/8YoDnPB/NALt4zt0VUj7l7WM+pLVRB48GPhcWPOauIejWIVov6S Ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahpchw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 22:25:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VMFvHF014364;
        Tue, 31 May 2022 22:25:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8ht0p0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 22:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6qwEfi9pnlwCYyU78q6DVjoSNKMSu0nTjBfg1XcdkJSEbE7CjSkQMoVtworiglCWent4WXYCem5/QZh5LPenQhtNQQI4jP0aNxdC/jAjy3+aAc6lSg4/CVnRx8P4rH4+8e4TDEWZ6qAamSPJrMBQQL1QcGM9bDZQYUzBq8kikbgSw/GCWZt0PGQ8dAUEulsXc+8MDDDQHfcNihkftsXmeXsvGOo56P0kvb7DlVxLS+EgVbifTzhN6SYoBwyRqzfR6WW9WVGqzvUcKvh4Rt13tyaQZnNUVA/Wt2RM0U35xLCPAEKP2FrKxB0iMGYrQB5ELNcRKa6g4G1l2xJTEDx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5/qqv1Qs7SQ0a9uSXQELnic5Q8FZYjDnJrBYeL0UP0=;
 b=G9ZTtf+byiO68uZGXw9C/2faOQEl01PDaft47ymU6lQU62tLZobfr6UOxvLbVrtM0RRTwYGrRjXYo0XH2yeLhiTezEa4W5kTb2JDoMYzI0IU79FbQa4YRB5K1NkmziQV9sbnRKkZ73Ql6BSCS+yFDiDtVctNx8FlIouKRBFvBu2bVzgFrXtr0CmfnZvJdXzmd3V1JhG3B4dw7hbEvmYXA4x80CWLN7fRkoVn+KImx9FlCnsYV5I/wc9d0fZqyfKQ0hAil7n3yL9NsCRmDZRumA83k0zEc6kTqeE/5oOE0f5rUR3I0QpGMgyUVs+AgBUcQaFz/etZXlN52qfWzM/S/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5/qqv1Qs7SQ0a9uSXQELnic5Q8FZYjDnJrBYeL0UP0=;
 b=jNwjloZkeLhaOJSsiNpf704tY1CaKk/wZqt5VxZGnn0q0XJ81HQGGaWaijbK671+kh+0wYG6TXB38lNj/C9IPGugiS4i4djrcp7UzAzwLIMdWyghQqU6sTmZ9l1yRkjGKpqXpgJSLJuKHJ0LnqACZbKA8KPtnHuh8lNdEuQgghA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB3273.namprd10.prod.outlook.com (2603:10b6:5:1a9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 22:25:37 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%8]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 22:25:37 +0000
Message-ID: <24513679-d92d-ead1-2c1d-98db6a9bbdac@oracle.com>
Date:   Tue, 31 May 2022 17:25:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
 <e4120abd-c3ac-ee4d-1a0d-260126914b09@oracle.com>
 <b38f4597-0d9b-5b17-0b24-13d99605fb69@redhat.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <b38f4597-0d9b-5b17-0b24-13d99605fb69@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 396dae3c-56c3-45d0-8401-08da43547c4d
X-MS-TrafficTypeDiagnostic: DM6PR10MB3273:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB32730A8A6A4ABA70F6CB5CC397DC9@DM6PR10MB3273.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XygcS4tV3ZWcXHU6t1a+swsl5XplLaO9QGe6IOkOnumawv6j197G4POCqHnfMeqKDVfjXrWUZC04nQGemBi+88Ng6/u/BMslDcU9KV6zQrPU2JWJykXDGEQttQmfJMDTLGNIPh9aTd/CtcVCyCD2QyfT+rT6nQ96tu2TPRpUrCq+BoYaihieUioyWWm1as2PNbGMq6on45OsEx+Qtlk4cMPdM/VApVTckqiuplqHUFbDSxrVDetDw3t2iqeuzLv28WF9vx0DmjHr6PUtMlAk3EL1Tmznqhb2k/uKOlkuILR3AlltpYbuwXU62TgltdESaL0s1JhSQIUoJYk5gxDeJvqS3t/DK9y69pKaNfcGs8MDAzL9A6KGdIgFBYqrtF2QoGxK6wHGo0G/E4pni/LffSLk6xDEuiVHbNJxi2wBj76PKtCedPXf/wd415HHh7pLGTdVx8mJeSZcWsBLgRdJPYpNwpRm7lIlLVgFmr0k+mGjLlqptHWf01cQoKNOzixire2KMGIpg9kcUECOfF3oMFiGD20WamBHN2y1HVXd2D44BiY4gMOa2U5c5j2+xmwz3V8V29fV8u1IMSAjZ4s2L+VV7Elsk7oAsSO0nhRCL/bUP1E0TZuD7ZLbdpO/caQ1SgPDeKZLCys/oIcAjTEF0UZP6HvfXOWRXCkWoCNLCIK4LgPo9e9XC+NanXM+NpQdS5FQxSe4cK7MZPua5/WwuoFs3JIdm4DHSConkWjyFN+embkGKM/p8jrXG9NNvrS51F1C6OKcsq05cX3+ll98Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38100700002)(316002)(31696002)(508600001)(36756003)(186003)(107886003)(2616005)(86362001)(8676002)(8936002)(7416002)(4326008)(6506007)(5660300002)(83380400001)(31686004)(6666004)(6512007)(66946007)(66556008)(53546011)(66476007)(2906002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlM5UEY1ZmZJRzRvcEZmNmF4ZU96ZFprRzdNcVcvUmlKRmw5V0hsQVJlTnBt?=
 =?utf-8?B?Z3lzMW0zb2VKY0Vwdmc5RlB3V0RETE1OdUFIcE9taVM1NUV1d2tYQ2RrYXQ0?=
 =?utf-8?B?c1dhUVRYVmZ0NEF2NHpIdjJYbTVUcXIzSS9jdHN6ZWphVk9RRWlJY3o5RFBx?=
 =?utf-8?B?Z3hPT053dmhnL3pzM25zUm43STQvaVBjb0JKNVRLZTR2Wm0zbFNHc21tRGVt?=
 =?utf-8?B?UXpYQVZwTkl4K045dnNuclMyWjVsbk91VDZLb0k0d0xxYmM1N3BWMVFYdXpO?=
 =?utf-8?B?VFhzaEFQUzFiTWFwdjF6dWxYekdMbko2dkRHR1p3d2tHK0wvM3ZNbFpUb2tN?=
 =?utf-8?B?MDh2cjBWd1U1cFhzUEJYTHJldGU3YmVraTN2QTFZOE5BVHZwRno1NytXdGFT?=
 =?utf-8?B?N2hrY1hDSytFczkxUVNDRldCRlcyMWdjR2I3MEJLSmRlSEpXb2ZQZ2NNc0FL?=
 =?utf-8?B?WU1GMG9adWVFNEFrRGNWZlNyVmFLVW42ejltVnJuTlhrUGF4a1d1aVlCYzZj?=
 =?utf-8?B?TEh0ZGFnNk1NNHNZZTRPR3c2N3pqSHNTY1RLVVVZK2dDcHJpNGUwUGxDdlRL?=
 =?utf-8?B?M0VvdThjRHA1ZVpNU3piSmpIRkxVNjlVUGt2Mi8yU3d3SGxheURhbWxuN3JX?=
 =?utf-8?B?aldLZzZwQ1hmQWRoMXl2Y0NyUTRBOCtGZmNMTkJhYldMcHptY2J6ZHJublky?=
 =?utf-8?B?YmZVOXRhTzdLVG5DVGU2UTgwQTdFQ21XOHRZSWpTd1RQU2xvRHBpU0JQbkVo?=
 =?utf-8?B?cXhUSW5yeWZSUnR3Z2F4MDFON091emhEVkFIbmtISlhZa1hjUjRQSFFsZTNX?=
 =?utf-8?B?enZqSU16aDNCOVdrZ1JzMkJ3NDQzSGFKNXN6Z0dBdlN6VkxKWmRXclNsZFBZ?=
 =?utf-8?B?V29LZ1RwRDdaNGt4d2FVQ2FVVzJNWllzdFJRVll0TFpodGUrTW9RQ1ZHVzRm?=
 =?utf-8?B?bXB5Ty9JaHN2c2gxNThURnMzSmpkRzhzR1Vib21yYS9zaUx0TXVRRzVSVjFI?=
 =?utf-8?B?bkJOSm9xbC9zQ3ZpaksySlloYUlxR2VHdjRBQnRteSthTC9laHR0QzNta1pD?=
 =?utf-8?B?OXYrYUpaT3VPWlpiQ1JEYndoYWUzYUhoU3pTZ0RNaW9EWnd2YzhReWM3TVov?=
 =?utf-8?B?azY4bHlYd2kyVmtwUXhhazFFOVFraCsvZTBVZjlmMitlZWZWaTgzMHo1aWJV?=
 =?utf-8?B?bkovVXRrL2RpRmZ6bW8rS1M4WjFZaWZkd1R3OVdaemVJZHdsV2l0ZUJwcHdP?=
 =?utf-8?B?allQOGJ2bEFweTBxV2xWZDgvZk9BeHJ3UDJrWXFsRkJ2VngrYjdhWEhIWSsx?=
 =?utf-8?B?SGdZRW4vZGlnek5pNWtiM3BpN2Fnekt6WHdCMVBsamlLRGV4ZWpiMElCMEpi?=
 =?utf-8?B?R2JrNlFVQmhjZUV1RkgrZTltUXYvaUVwK2psZ056S2t0NnJ4OGprVGZySXR0?=
 =?utf-8?B?Y0pUSTI0RGl3L0dBYkQ1Y21GUi8wRkt5TjMwYW1TVUl0V3dtTEtZUVhqUzIz?=
 =?utf-8?B?T3VCVGxIcXZVUjhWY01BTUVEV24xM04yN0dMZVBhUk5EcWpGU3dGSkhNanNt?=
 =?utf-8?B?eGtUNXptRUd3UURKcmJTZHlVUGg4VkhXcVl1cGxDR0FNdXYrQlF0aWJDSGpz?=
 =?utf-8?B?azNlRzJuZUpXRDZVUitFMWxxN1dZb3cyQ0FEMjYvektNUldoYlVZTWtBb0J2?=
 =?utf-8?B?cWZYN1RBTHBNcDdEU3pzaVJLZHBhdUpBRnlXU3p0VGxvYTRwUHY0d2JsSExi?=
 =?utf-8?B?bWNZQWFqYmZOS0FCWGQ4ZXR5b0ZoYTVCL3lHdmJaT0NubHJqemc0Z0ZpOXFX?=
 =?utf-8?B?bE52MDFRNkxTbzVxemxycjhWWitnZmt2eGRXNDJHTUlwTjBqeFFyT1NndDE5?=
 =?utf-8?B?UGxJUngxR0VtSnRRVW5OblFkWVh3MEYxSmtBZDYzQ1FRQXhRSE9qV2lBQnA2?=
 =?utf-8?B?RnBWTS9KUWNoVkVodEtWQ0ZkZUppMVVaTEh0aFlhN0JJUTVOcUZUN3dsMmJt?=
 =?utf-8?B?a0hUVkFkQTUxcDJVVjZwdUlvbmtQUlJUM2c4bUNjVTVtek1keTBvTStWZkg3?=
 =?utf-8?B?VWdTdXNqTU5vM1h5TGRMb3hOMXVKSm8rczBib2JPaEFrK0RWaDJkL0lSZldN?=
 =?utf-8?B?UHFlOEdCb2FnRUlKb1FVUzI1YWN5RFJVK3NmWmV5R0tGTHBpUHcvMlJmdzRG?=
 =?utf-8?B?MndaZDNYYWVHcUEwYlpBZUVSb2VQYktFNisyQ04rclNuYmZ2Z0NMWE5yRFJV?=
 =?utf-8?B?TUNlSFpnUVcvR25WM21XMHkrNEZ6aDlCTHNMKytuLzZ1cXFEeENDUXJQYk14?=
 =?utf-8?B?ODU0dU9kNzdKdksraUtaNnU1WG1XUVBaNXNXVUFIYm5YOTYxMHZ3Y0xmRmFZ?=
 =?utf-8?Q?WNPd/ad3yIXmctEIYbu1fXy2sPY3jExo31nnX7CPo7SgF?=
X-MS-Exchange-AntiSpam-MessageData-1: TIlv0Mi32K+Y1Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396dae3c-56c3-45d0-8401-08da43547c4d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 22:25:36.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIebo5G+RpfCJOI5FNxhxelJt2hPZX5RJKXVV+OoqbS61yLVQBvnTC+95UpHoBT8+SbjFa95GpW/DmWTbkA/0wXVhWVf0ppRfxCVcYZwiB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3273
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310097
X-Proofpoint-ORIG-GUID: -9dgWCJGh-F65SmqJOqLLCRqsacBxMUs
X-Proofpoint-GUID: -9dgWCJGh-F65SmqJOqLLCRqsacBxMUs
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/22 08:15, David Hildenbrand wrote:
> On 12.05.22 18:10, Eric DeVolder wrote:
>> David,
>> Great questions! See inline responses below.
>> eric
> 
> Sorry for the late reply, travel and vacation ...
No problem, greatly appreciate the feedback!
eric

> 
>>>
>>>> +
>>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>>> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
>>>> +							unsigned int hp_action, unsigned int cpu)
>>>> +{
>>>> +	WARN(1, "crash hotplug handler not implemented");
>>>
>>>
>>> Won't that trigger on any arch that has CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG?
>>> I mean, you only implement it for x86 later in this series. Or what else stops this WARN from
>>> triggering?
>>>
>> You're correct. What about: printk_once(KERN_DEBUG "...") ?
> 
> Why even bother about printing anything? If the feature is not
> supported, there should be some way for user space to figure out that it
> sill has to reload on hot(un)plug manually, no?

I've changed this to WARN_ONCE(). If that isn't agreeable, I'll remove it.

> 
> 
> [...]
> 
>>
>>>
>>> 2. Why can't the unprotect+reprotect not be done inside
>>> arch_crash_handle_hotplug_event() ? It's all arch specific either way.
>>>
>>> IMHO, this code here should be as simple as
>>>
>>> if (kexec_crash_image)
>>> 	arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
>>>
>>
>> The intent of this code was to be generic infrastructure. Just invoking the
>> arch_crash_handle_hotplug_event() would certainly be as generic as it gets.
>> But there were a series of steps that seemed to be common, so those I hoisted
>> into this bit of code.
> 
> But most common parts are actually arch_* calls already? :)
> 
> Anyhow, no strong opinion.
For the time being, I'd like to leave as is. Let's see if the detection of the elfcorehdr
segment gets moved to this code too... (discussion thread on "x86/crash: Add x86 crash hotplug 
support for kexec_load".

> 
>>
>>> 3. Why do we have to forward the CPU for CPU onlining/offlining but not the
>>> memory block id (or similar) when onlining/offlining a memory block?
>>   From patch "kexec: exclude hot remove cpu from elfcorehdr notes" commit message:
>>
>> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
>> still in the for_each_present_cpu() list when within the
>> handle_hotplug_event(). Thus the CPU must be explicitly excluded
>> when building the new list of CPUs.
>>
>> This change identifies in handle_hotplug_event() the CPU to be
>> excluded, and the check for excluding the CPU in
>> crash_prepare_elf64_headers().
>>
>> If there is a better CPUHP_ to use than _DYN, I'd be all for that!
> 
> Ah okay, thanks.
> 
