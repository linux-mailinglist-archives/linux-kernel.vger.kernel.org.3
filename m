Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97066507600
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355671AbiDSRHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355612AbiDSRH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:07:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AFF18E0F;
        Tue, 19 Apr 2022 10:04:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JFdb2i024809;
        Tue, 19 Apr 2022 17:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6DyonRoQd0mXm70ZL0AMkxzlYULYH8mDRjwh+nwRdnI=;
 b=TwflyOQcWNwhc5koU8rhiS5S0e+Pm43PlS+NSlbemKOVfQ5eBIKnweKPkJyj6XACnKOb
 fNs5ftmj3KOcxs4SqZHj8zGVu53fxOsKKS2bCVZBF/KXX4BsTQh7+V1aq2Xko7YV/rEY
 1b97hFrtpmEB716ksfi8JQbI25BTx/cDbKfGPB8DJcVoVTnN1DVvIzXX5Xbpr2aNYRrs
 YT9Ep1cff63QP6qNAUWyJKBMYVYsAxh4er++b+1YDVcOCXlw+m0+19wJ12oQnxWxyUzL
 e6Fsd50ol+8Q6GejNNJo/i1V0+PV2bt0QYpKzEgGcvKzfUD4cDhK1JPT5LSAbMZxH9xd BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffnp9ehx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 17:03:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JGuW8m009492;
        Tue, 19 Apr 2022 17:02:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88e98x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 17:02:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvfCmn1unPt6a0JiurDia1Kj83vA0hMF/dyoM0yK+Cz1o7NtvWwzSc87ctVQUDq0FS7BdUcXtw5w92SWopVYEKP3crGLknEBpv0MU1GdIeOfDy6g1qtj9GYSv6Tp5Ijwz7S2GNk5gPQUSEH9enNZaIGflTUVynYfpQGpwEc77NVVf5fJeeR/A3JQ6VTLy2ij1RBKWQpZcjcVmRHCfat3RnVREUojtPQ6qzAOvkOMqJ0NIi8m5WeabDGS+cSbF0dcOx5H9PtWN51tGRgazaQO+wEBWUTvalzqOKdSvJyLn6bOWb6tPaamoOx6+6RQiDI6Uv/H0nQWGA0AAxrNhzogog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DyonRoQd0mXm70ZL0AMkxzlYULYH8mDRjwh+nwRdnI=;
 b=UPLg6q1dGny3InfoTWF7tEoZ6ID0x0MTtLjH8N+X+T46phSbiA8kTDe97qP8baY25WVJDW+K1Qdi2jkxsmamkHECHSobqWKTHiMDpUR1xDNXTnO6fr4YVLArR22gErcS8soKCsx9n9TmbSsgE6xIrp9JBizBHj8zzatSnNRLFVHmMBzQYXHlAszfmzYrAWm9YdeNx5PPCf94edy5exN8a+ZJu/pjvJQIlPbq8zyPIkDwTgctLHD+umUmDqWFJLNH+MYZPTDQxPjUdgaevnJepZbvEhDd+BkE018sjUyK6JLWVYWejmujNb6atILkzi7hALxeM1CEiQ6IPXWkL7kWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DyonRoQd0mXm70ZL0AMkxzlYULYH8mDRjwh+nwRdnI=;
 b=addqM99yKEPPF5lRlg+SbrGnEiR/3oS4Vyq1SDktHEnBuK6RnL+5eDlHTDd2UWjDLTMuhkka8/tggZ8LdpbDreRMMM2vKWeWnJrQYpGBfMEd0Ycexgg+52xTWWjFFwkyqykkbcG0elAEk/v9XUFj4DnFLCPcoYuuIF9AzPanVYc=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BN0PR10MB4903.namprd10.prod.outlook.com (2603:10b6:408:122::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 17:02:54 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::f481:9785:f002:1dad]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::f481:9785:f002:1dad%9]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 17:02:54 +0000
Message-ID: <65950afb-0b35-7bc3-a376-ae8d8f12211c@oracle.com>
Date:   Tue, 19 Apr 2022 12:02:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v22 0/9] support reserving crashkernel above 4G on arm64
 kdump
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20220414115720.1887-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0102.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::43) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4f772e3-57e2-4d6d-5941-08da22267195
X-MS-TrafficTypeDiagnostic: BN0PR10MB4903:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB490361EED752386D91EF0CA887F29@BN0PR10MB4903.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sqgBkNmwBJl9oq+xCQjyGXwvLruvgED2qZS4Vkg/yk6hIGu+m/+UKF/Dj016QcnSdNjpvPKqz2T3u5MKRh6bglMKGv0Ye1F5a+yB3HkgKi/nxU0NH2bzx6zoeM4CA29+2XOfE08vkhbF376hXuK6wyOosYdxeoPQ+LI/duP9tunZYdRQyI7Y5JEhY/QTP6L8lYDtqAhdlPXktXJQyem5HSJe7R0LjS452X5zHPXLLnNCJ5jTEGc8UGDRnirzrOyxEhLvL/5q94DS3PRdbI3hl8QrA9MQiF2MCGQzA5Ce2N0b6haTTrby9f5JLbVrqdwx9ByxoqNbz0DrPhtUnpYYBrGFZnxvEXF1ucOp3C9uKfRZfhVoGDOuEfuMgmBB/27hR0fYcTXn5nV1UGqyTXUTmMPkKrQ3QpIEqwUEMRTeNv3G0j5HpxokpWKU0kW0+8nBbMUVqeY55fAKhZNxKxIDzs33sO4OraYHaE6OS+jPk4eFkWTCxRKA0DOk/aAcRtUizJ6wSjErqv4lRsLj9sOlCylDyuJJ1S+hMnqQiIn+IIeoXIccW9m4itPeFv0vqbRBXR2IgSjbsmX+PCM5ZLSeq1Nf2N/ycPZ6R58FRIGXrOVDHlnTr35WyolvSgbrPpI7fRaX3R4/vCFMai3Hm4BAcatlJa48JPRX2okEMVRlYgfowjc51xE0yM0redDrxJ6KagoEQBd57xL1h11k0KXGcG0Zoc1IwebA14dlS4ncB4hgsLqPfnT1GvTb3Oq+DFtkkM7aCHs3ilguDirTGAOOxQKonK/0bn/39Lw6+tBtKqd73dqJjxY8I4x9Gbrq+v3rCTRKxF2/bHBJaDZrLBiVCC8HzsKypRGiPaEX94IxmcnBFE/qINEPcGmIJOLigjv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(4326008)(36756003)(921005)(30864003)(7416002)(8936002)(5660300002)(966005)(31696002)(2616005)(508600001)(6486002)(44832011)(186003)(110136005)(86362001)(2906002)(8676002)(107886003)(54906003)(316002)(31686004)(83380400001)(6666004)(6506007)(26005)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHo1T2RPa2h4TitaM3E4bjdyUUo3RWJ4QmxrYnUzeGpzVU1RSkIyYmpKdU1p?=
 =?utf-8?B?NHVxT2hKVkZRY0ovYUxtYWJCVFQ4YTFoTHd3RDZxZlVVY2x5ODBaQmtnNmdl?=
 =?utf-8?B?djdCUitqM2NWMzFubXE4Ky9wczIzeE1RNDVtRHRtLzVuU0gvSllPa0hSRmNG?=
 =?utf-8?B?c000VVVuV1YvRGFiMDkvS2hlbUlDUzU1SUU5TUpMeXYxQUFWeE5MQlZXbDFX?=
 =?utf-8?B?WEp1UnVTc0Q2bU5JOElXa08rWURPSHJHdHNFd09KMmV3ZnlUK3k4eXgxd2NN?=
 =?utf-8?B?OTU0Nm9aakYwemY0T2xtdk10Unh5MlpVUWNxNGVTeG5ocldqOHpHRS9DbVd6?=
 =?utf-8?B?eENrN0JjZW5sdnBPUFhtaSt5amNxS1ZLNVhQbkhnTVp4SEpwK1BFenRKL1Rn?=
 =?utf-8?B?V2JacndjYm40Tml0SkpLa2tEOCtCdjdUL05SeDhSaHcvem5LOVEwVy8weWtp?=
 =?utf-8?B?clQ2aDFNYzZNYUEwUlM1SVg0ejc2NW9RUGtHc2psWXdMek05MHBFcldUN0tB?=
 =?utf-8?B?UENHRGx3WG02RFF4OVAycWRPeStHZmQrVExnQ3VzdTg0cUJHZHBNdzB0NjVl?=
 =?utf-8?B?NHhSVzR4ZFVTT3E4NU16cWhIaFR0WXBLWUZnY3V0NFJYakFiMVlHaklzVXpw?=
 =?utf-8?B?WDNCMmJZSUZUaWZ0QkloOWkyL3cxdkg1SlJOTDdHT3U5N3JtcXg3ZHU2YWls?=
 =?utf-8?B?aGd3Y2tBeWo2NDd1WGxKNmJGdFlXTVMxWTRseHJDQzczRTl0czZmWHUvK05C?=
 =?utf-8?B?VGdvQmlObFhpcmYvd2MyQUZNR3RzTk9iVzZxY0NKeEFZemM3Y0h4ZFZadlc0?=
 =?utf-8?B?UjNuKy9uUmQ5alNLK1F5TGJDbzJLZzIxS3hlM2w5OUNraWFXaFQ4Ri9OZEFG?=
 =?utf-8?B?VDRBZ1ExMFBTVmxXZGZ1alF0dzdCQ09jR1BqekxzblU0RnNaRHBEVllvQXEw?=
 =?utf-8?B?a3Z2bGo4QW5iVm5RaEdJWjNNdDRxT0xhbUg2NGtQY3dsZW8ybXdPY2JTUUNH?=
 =?utf-8?B?OXhPR25YcHJ5ejVQUmpXRWJubXA2OFlaT24vSDkxV00yb3h5bEYzalMveURC?=
 =?utf-8?B?SGtxdmUvNG5laGovYTR3NXJnTzBSeHl3TmYySE1WZDF4dU9KS1M4R2FrV0pz?=
 =?utf-8?B?ekcwZ0xiZG5FYlhSMUROSThRazFKWkFRM1c2ZUtuMVRtd1d4SUhuNzl4T2ZU?=
 =?utf-8?B?Q3c3WStLTStvZEpxNmV5cmJtUTdXYUxlYllIbFhMYVBHYU5qaW1uVXpxNlVG?=
 =?utf-8?B?RXF2QXdUZmlTZzFNOFJnc0VoSlJFU2o5OHBKTEtoaUs5c0hUOGl0SDQxK0Zr?=
 =?utf-8?B?LzBISXlBdUpSUFRoWWtjVDFlejhNeGl4MmNXaWdEQ0JpV1B0T2huRWo3aDJN?=
 =?utf-8?B?YjlCbjUwUkFITVMxQ2F3eVluWm4wWDVieUtaNjE1U0ttajhiTGtUb3JKbXdU?=
 =?utf-8?B?b2x3ZFZDeGthM0dSdEl0VG9kRC8zVTBjcElNdWx6Z3M3eHRkU0h6VlRNbDg1?=
 =?utf-8?B?UWFxb1AyVndpSDdTb2lkMGplWnFtYlBFcEhQeFdxK3ZPWSsvSUdwNVFzK3BS?=
 =?utf-8?B?M2h0WEJ1dnJVbWRpUG96OW11Uk1LL2dFbzV0QmJrUjJiY29ZUGVubnBKTTl6?=
 =?utf-8?B?ejNDaFVIelFPU1FzY0JyUDR6UVVxa0F1a1JBemtDZkNxeTRYNmYyUnJyTlAv?=
 =?utf-8?B?ZUZmYmt5UFNZOEE5RjRjYW0waWZ3Wlg1OFZNNmlWYTVUazdSWDVORytaRDJi?=
 =?utf-8?B?OCtvYmxHbXZBOUg0ZGtVekNSaCtYYndJZjUwQkNuN0FlTHlQcjcwd2ZhajhM?=
 =?utf-8?B?OGNsT3p3MFVBSFJzZ1lIdy91MG1lWEJwYWw3azViSHhrLzI2a0FncjQxbVo2?=
 =?utf-8?B?ZEl6TURkR3VKbHp3RTdmR1hoM2s3Q1ArYlVoWEQ1SDFkVmh6QXlUY1g4NjZC?=
 =?utf-8?B?RmhabHY5UklVdThGdFNNTWs3ZHFjRGNFU085NTlIdzYzcUh6ckY4YTlZbUxX?=
 =?utf-8?B?T1dXcFR5SUg0QWkwT3ZYMld2R1ZDaWlmMjFTY2hSZjBqdmptSVE2RFkyc09S?=
 =?utf-8?B?cTBubkNURlBId2xDSmNXWjJ0OXNMYXhQMi91dndhVUs2NWI3NEYzT1dDdXU1?=
 =?utf-8?B?clNTVWtQN3orT2xhTVBuSFhSSUdDMGFUYTJ1OXEwK25yMXBaRk1XUEwvSVk5?=
 =?utf-8?B?MXkvNHZ6SE5GQXpFUUJtUEhOSzc2dFB1ZGtneEhxTllveDd0dmxQOEQxNVJC?=
 =?utf-8?B?eWVIOVRMZFZ0VGJGOE9pNXlnaityMHBVcHN0eEFjNEl3SzhDajczNVdZOUZ4?=
 =?utf-8?B?M1pqVjZXSVpSaEx2OFVndk80NzNjWlQvdGVzUEtGNGRFWFJxTnpnSmNpT2hX?=
 =?utf-8?Q?AGVuHy0y+PBcGY18=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f772e3-57e2-4d6d-5941-08da22267195
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 17:02:53.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvlzRZOD6snT41SoG2RntDdF4o940nbG7QH6LbPr0nHKWWVVKNbxq2eA0h6z+rjib3nGZora6Xq8EYD6c9mRU884/ouLHAtwO1LMN0TzPxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_05:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190097
X-Proofpoint-ORIG-GUID: 2xO3pRRaQXHGvRCHISEreGK_kmN213B_
X-Proofpoint-GUID: 2xO3pRRaQXHGvRCHISEreGK_kmN213B_
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the series:

Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Thanks for keeping this patch set alive.

On 4/14/22 6:57AM, Zhen Lei wrote:
> Changes since [v21]:
> 1. Update the commit message of  patch 1 and 5.
> 2. Add some comments for reserve_crashkernel() in patch 5.
> 
> Thanks to Baoquan He and John Donnelly for their review comments.
> 
> Because v5.18-rc1 has added a new patch
> commit  031495635b46 ("arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones")
> There are many new scenarios:
> 1) The mappings may be block or page-level.
> 2) The call to reserve_crashkernel() may or may not be deferred.
> 3) The the upper limit of DMA address may be 4G, or less than 4G. Or the
>     upper limit of physical memory, because SMMU can do the mapping.
> 
> The code of patch 1-2, 8-9 keep no change, because the above-mentioned issues are not involved.
> The code of patch 5 only makes the following changes:
> -	if (crash_base >= SZ_4G)
> +	/*
> +	 * When both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are disabled, the
> +	 * CRASH_ADDR_LOW_MAX equals the upper limit of physical memory, so
> +	 * the 'crash_base' of high memory can not exceed it. To follow the
> +	 * description of "crashkernel=X,high" option, add below 'high'
> +	 * condition to make sure the crash low memory will be reserved.
> +	 */
> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) || high) {
> Change SZ_4G to CRASH_ADDR_LOW_MAX, because arm64_dma_phys_limit may be less than
> 4G or greater than 4G. The check 'high' is used for "crashkernel=X,high" and
> "(crash_base >= CRASH_ADDR_LOW_MAX)" is used for "crashkernel=X[@offset]".
> 
> Patch 3-4 to allow block mappings for memory above 4G.
> Patch 6-7 to support only crash high memory or fixed memory range specified by
> crashkernel=X@offset use page-level mapping, to allow other areas use block mapping.
> These four patches are for performance optimization purposes. For details about the
> technical feasibility analysis, please see the commit messages.
> 
> Now the implementation of arm64 is very different from that of x86. It's no longer
> suitable for both of them to share code.
> 
> 
> 
> Changes since [v20]:
> 1. Check whether crashkernel=Y,low is incorrectly configured or not configured. Do different processing.
> 2. Share the existing description of x86. The configuration of arm64 is the same as that of x86.
> 3. Define the value of macro CRASH_ADDR_HIGH_MAX as memblock.current_limit, instead of MEMBLOCK_ALLOC_ACCESSIBLE.
> 4. To improve readability, some lightweight code adjustments have been made to reserve_craskernel(), including comments.
> 5. The defined value of DEFAULT_CRASH_KERNEL_LOW_SIZE reconsiders swiotlb, just like x86, to share documents.
> 
> Thanks to Baoquan He for his careful review.
> 
> The test cases are as follows: (Please update the kexec tool to the latest version)
> 1) crashkernel=4G						//high=4G, low=256M
> 2) crashkernel=4G crashkernel=512M,high crashkernel=512M,low	//high=4G, low=256M, high and low are ignored
> 3) crashkernel=4G crashkernel=512M,high				//high=4G, low=256M, high is ignored
> 4) crashkernel=4G crashkernel=512M,low				//high=4G, low=256M, low is ignored
> 5) crashkernel=4G@0xe0000000					//high=0G, low=0M, cannot allocate, failed
> 6) crashkernel=512M						//high=0G, low=512M
> 7) crashkernel=128M						//high=0G, low=128M
> 8) crashkernel=512M@0xde000000		//512M@3552M		//high=0G, low=512M
> 9) crashkernel=4G,high						//high=4G, low=256M
> a) crashkernel=4G,high crashkernel=512M,low			//high=4G, low=512M
> b) crashkernel=512M,high crashkernel=128M,low			//high=512M, low=128M
> c) crashkernel=128M,high					//high=128M, low=256M
> d) crashkernel=512M,low						//high=0G, low=0M, invalid
> e) crashkernel=512M,high crashkernel=0,low			//high=512M, low=0M
> f) crashkernel=4G,high crashkernel=ab,low			//high=0G, low=0M, invalid
> 
> 
> Changes since [v19]:
> 1. Temporarily stop making reserve_crashkernel[_low]() generic. There are a
>     lot of details need to be considered, which can take a long time. Because
>     "make generic" does not add new functions and does not improve performance,
>     maybe I should say it's just a cleanup. So by stripping it out and leaving
>     it for other patches later, we can aggregate the changes to the main functions.
> 2. Use insert_resource() to replace request_resource(), this not only simplifies
>     the code, but also reduces the differences between arm64 and x86 implementations.
> 3. As commit 157752d84f5d ("kexec: use Crash kernel for Crash kernel low") do for
>     x86, we can also extend kexec-tools for arm64, and it's currently applied. See:
>     https://www.spinics.net/lists/kexec/msg28284.html
> 
> Thank you very much, Borislav Petkov, for so many valuable comments.
> 
> Changes since [v17]: v17 --> v19
> 1. Patch 0001-0004
>     Introduce generic parse_crashkernel_high_low() to bring the parsing of
>     "crashkernel=X,high" and the parsing of "crashkernel=X,low" together,
>     then use it instead of the call to parse_crashkernel_{high|low}(). Two
>     confusing parameters of parse_crashkernel_{high|low}() are deleted.
> 
>     I previously sent these four patches separately:
>     [1] https://lkml.org/lkml/2021/12/25/40
> 2. Patch 0005-0009
>     Introduce generic reserve_crashkernel_mem[_low](), the implementation of
>     these two functions is based on function reserve_crashkernel[_low]() in
>     arch/x86/kernel/setup.c. There is no functional change for x86.
>     1) The check position of xen_pv_domain() does not change.
>     2) Still 1M alignment for crash kernel fixed region, when 'base' is specified.
> 
>     To avoid compilation problems on other architectures: patch 0004 moves
>     the definition of global variable crashk[_low]_res from kexec_core.c to
>     crash_core.c, and provide default definitions for all macros involved, a
>     particular platform can redefine these macros to override the default
>     values.
> 3. 0010, only one line of comment was changed.
> 4. 0011
>     1) crashk_low_res may also a valid reserved memory, should be checked
>        in crash_is_nosave(), see arch/arm64/kernel/machine_kexec.
>     2) Drop memblock_mark_nomap() for crashk_low_res, because of:
>        2687275a5843 arm64: Force NO_BLOCK_MAPPINGS if crashkernel reservation is required
>     3) Also call kmemleak_ignore_phys() for crashk_low_res, because of:
>        85f58eb18898 arm64: kdump: Skip kmemleak scan reserved memory for kdump
> 5. 0012, slightly rebased, because the following patch is applied in advance.
>     https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/linus&id=8347b41748c3019157312fbe7f8a6792ae396eb7
> 6. 0013, no change.
> 
> Others:
> 1. Discard add ARCH_WANT_RESERVE_CRASH_KERNEL
> 2. When allocating crash low memory, the start address still starts from 0.
>     low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> 3. Discard change (1ULL << 32) to CRASH_ADDR_LOW_MAX.
> 4. Ensure the check position of xen_pv_domain() have no change.
> 5. Except patch 0010 and 0012, all "Tested-by", "Reviewed-by", "Acked-by" are removed.
> 6. Update description.
> 
> 
> 
> Changes since [v16]
> - Because no functional changes in this version, so add
>    "Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>" for patch 1-9
> - Add "Reviewed-by: Rob Herring <robh@kernel.org>" for patch 8
> - Update patch 9 based on the review comments of Rob Herring
> - As Catalin Marinas's suggestion, merge the implementation of
>    ARCH_WANT_RESERVE_CRASH_KERNEL into patch 5. Ensure that the
>    contents of X86 and ARM64 do not overlap, and reduce unnecessary
>    temporary differences.
> 
> Changes since [v15]
> -  Aggregate the processing of "linux,usable-memory-range" into one function.
>     Only patch 9-10 have been updated.
> 
> Changes since [v14]
> - Recovering the requirement that the CrashKernel memory regions on X86
>    only requires 1 MiB alignment.
> - Combine patches 5 and 6 in v14 into one. The compilation warning fixed
>    by patch 6 was introduced by patch 5 in v14.
> - As with crashk_res, crashk_low_res is also processed by
>    crash_exclude_mem_range() in patch 7.
> - Due to commit b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
>    has removed the architecture-specific code, extend the property "linux,usable-memory-range"
>    in the platform-agnostic FDT core code. See patch 9.
> - Discard the x86 description update in the document, because the description
>    has been updated by commit b1f4c363666c ("Documentation: kdump: update kdump guide").
> - Change "arm64" to "ARM64" in Doc.
> 
> 
> Changes since [v13]
> - Rebased on top of 5.11-rc5.
> - Introduce config CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL.
> Since reserve_crashkernel[_low]() implementations are quite similar on
> other architectures, so have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in
> arch/Kconfig and select this by X86 and ARM64.
> - Some minor cleanup.
> 
> Changes since [v12]
> - Rebased on top of 5.10-rc1.
> - Keep CRASH_ALIGN as 16M suggested by Dave.
> - Drop patch "kdump: add threshold for the required memory".
> - Add Tested-by from John.
> 
> Changes since [v11]
> - Rebased on top of 5.9-rc4.
> - Make the function reserve_crashkernel() of x86 generic.
> Suggested by Catalin, make the function reserve_crashkernel() of x86 generic
> and arm64 use the generic version to reimplement crashkernel=X.
> 
> Changes since [v10]
> - Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.
> 
> Changes since [v9]
> - Patch 1 add Acked-by from Dave.
> - Update patch 5 according to Dave's comments.
> - Update chosen schema.
> 
> Changes since [v8]
> - Reuse DT property "linux,usable-memory-range".
> Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
> memory region.
> - Fix kdump broken with ZONE_DMA reintroduced.
> - Update chosen schema.
> 
> Changes since [v7]
> - Move x86 CRASH_ALIGN to 2M
> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> - Update Documentation/devicetree/bindings/chosen.txt.
> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
> suggested by Arnd.
> - Add Tested-by from Jhon and pk.
> 
> Changes since [v6]
> - Fix build errors reported by kbuild test robot.
> 
> Changes since [v5]
> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> - Delete crashkernel=X,high.
> - Modify crashkernel=X,low.
> If crashkernel=X,low is specified simultaneously, reserve spcified size low
> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
> pass to crash dump kernel by DT property "linux,low-memory-range".
> - Update Documentation/admin-guide/kdump/kdump.rst.
> 
> Changes since [v4]
> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
> 
> Changes since [v3]
> - Add memblock_cap_memory_ranges back for multiple ranges.
> - Fix some compiling warnings.
> 
> Changes since [v2]
> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
> patch.
> 
> Changes since [v1]:
> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
> in fdt_enforce_memory_region().
> There are at most two crash kernel regions, for two crash kernel regions
> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
> and then remove the memory range in the middle.
> 
> v1:
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 
> To solve these issues, change the behavior of crashkernel=X.
> crashkernel=X tries low allocation in DMA zone and fall back to high
> allocation if it fails.
> 
> We can also use "crashkernel=X,high" to select a high region above
> DMA zone, which also tries to allocate at least 256M low memory in
> DMA zone automatically and "crashkernel=Y,low" can be used to allocate
> specified size low memory.
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices. So there may be two regions reserved for
> crash dump kernel.
> In order to distinct from the high region and make no effect to the use
> of existing kexec-tools, rename the low region as "Crash kernel (low)",
> and pass the low region by reusing DT property
> "linux,usable-memory-range". We made the low memory region as the last
> range of "linux,usable-memory-range" to keep compatibility with existing
> user-space and older kdump kernels.
> 
> Besides, we need to modify kexec-tools:
> arm64: support more than one crash kernel regions(see [1])
> 
> Another update is document about DT property 'linux,usable-memory-range':
> schemas: update 'linux,usable-memory-range' node schema(see [2])
> 
> 
> [1]: https://www.spinics.net/lists/kexec/msg28226.html
> [2]: https://github.com/robherring/dt-schema/pull/19
> [v1]: https://lkml.org/lkml/2019/4/2/1174
> [v2]: https://lkml.org/lkml/2019/4/9/86
> [v3]: https://lkml.org/lkml/2019/4/9/306
> [v4]: https://lkml.org/lkml/2019/4/15/273
> [v5]: https://lkml.org/lkml/2019/5/6/1360
> [v6]: https://lkml.org/lkml/2019/8/30/142
> [v7]: https://lkml.org/lkml/2019/12/23/411
> [v8]: https://lkml.org/lkml/2020/5/21/213
> [v9]: https://lkml.org/lkml/2020/6/28/73
> [v10]: https://lkml.org/lkml/2020/7/2/1443
> [v11]: https://lkml.org/lkml/2020/8/1/150
> [v12]: https://lkml.org/lkml/2020/9/7/1037
> [v13]: https://lkml.org/lkml/2020/10/31/34
> [v14]: https://lkml.org/lkml/2021/1/30/53
> [v15]: https://lkml.org/lkml/2021/10/19/1405
> [v16]: https://lkml.org/lkml/2021/11/23/435
> [v17]: https://lkml.org/lkml/2021/12/10/38
> [v18]: https://lkml.org/lkml/2021/12/22/424
> [v19]: https://lkml.org/lkml/2021/12/28/203
> [v20]: https://lkml.org/lkml/2022/1/24/167
> [v21]: https://lkml.org/lkml/2022/2/26/350
> 
> Chen Zhou (2):
>    arm64: kdump: Reimplement crashkernel=X
>    of: fdt: Add memory for devices by DT property
>      "linux,usable-memory-range"
> 
> Zhen Lei (7):
>    kdump: return -ENOENT if required cmdline option does not exist
>    arm64: Use insert_resource() to simplify code
>    arm64: kdump: Remove some redundant checks in map_mem()
>    arm64: kdump: Don't force page-level mappings for memory above 4G
>    arm64: kdump: Use page-level mapping for the high memory of
>      crashkernel
>    arm64: kdump: Try not to use NO_BLOCK_MAPPINGS for memory under 4G
>    docs: kdump: Update the crashkernel description for arm64
> 
>   .../admin-guide/kernel-parameters.txt         |   8 +-
>   arch/arm64/include/asm/kexec.h                |   2 +
>   arch/arm64/kernel/machine_kexec.c             |   9 +-
>   arch/arm64/kernel/machine_kexec_file.c        |  12 +-
>   arch/arm64/kernel/setup.c                     |  17 +-
>   arch/arm64/mm/init.c                          | 204 +++++++++++++++++-
>   arch/arm64/mm/mmu.c                           |  68 +++---
>   drivers/of/fdt.c                              |  33 ++-
>   kernel/crash_core.c                           |   3 +-
>   9 files changed, 278 insertions(+), 78 deletions(-)
> 
