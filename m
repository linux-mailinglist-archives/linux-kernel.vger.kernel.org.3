Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC31A53A4C0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348854AbiFAMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351863AbiFAMTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:19:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFE95002C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:19:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251CGWQc010022;
        Wed, 1 Jun 2022 12:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VNhtNQ3qrm2dl+l1skwnEjzr548+D0VZY+E/eZpNR7w=;
 b=nlyDPuGkfwXQ86173c2sm8tScoRzIGtmWSghs4eiSS7Nf5Hagx5WH00vKWIPLXCpBItg
 PwN2qOXPCDYt5+5IV/UHUbME+SKK74chhEmxqGFkc1AIBC7lNd3HotKphScLTgdqGOlh
 X5Qdj5xR7O7Gfo4x7rbjMPOjQU1YCkk4oCjKyXts1MVQAFRLaIpPZaju2D5rxmGXHytr
 HKV9Fx7UfGTP/GvF2DuplJlcG+oJjSTL0tYQYNFeZHiKnnv9JVZmgaOsVjhRnIHP1qKJ
 5L8J85vpiahyYFRISgDMAUO7jILnXvDCxlxbokDGxTcX3LEpbDy7LRRqByg6a+PUCI38 kQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcauqqv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 12:19:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 251CGoba009504;
        Wed, 1 Jun 2022 12:18:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kkmjp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 12:18:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRK5YhRljwLSIA0MmRyEtMul9rDHLS07mzK6q6awZ+ODrp2Gg+AP+Rjbz8fUarNdIX9Ps1QvekaE2/FASB1pvjetrdd8GF/VHUDRjd5kO5k+Zd5yM0OOUTAwGTc5/NfoHgWabNbs9ACAqLxAhPkYOBlNg5++Hcmzss7+lYPTaArEZu0F3dzmhCneBmYQqHYO1X4OguLyw7XB7TDUjcJEPbvaY15mtNoegQ68IZ/4dcLNEOuN5+aHL/Zq8MiLxWYl2hj+e/w2KZVsF+pdMpclTr3w4WzIkraHqz+rGW5/eN5AwNFAHaehZAKqkEPlUISUNQ5N4MzUVgBvZd+kAHU+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNhtNQ3qrm2dl+l1skwnEjzr548+D0VZY+E/eZpNR7w=;
 b=HN3KXojpMGYaZ7rEV7BDJCMOlZnJCBD766Ny0Vj3k8x9lSJnXI2QYVegWoSE/Q6HnFlEU2qp2jfO/cUzo7NuHCEbP3PyiqHun/bra41Tg7nPuQmNk2vOA/u88qq1vpDICNmo9jcogO12h1Tm/cSwL9kTlq6j38LakYBnasx6uPLX8/xP2ueNGFjyfk4ZC/UedpWlNw0uZ2Wmy/Hh1fkKNyxDuWJsuxoZ4ugdi1cLZjU/FzQobefMZUWYltg1sxhwwjPHgHpZWiVH4yG/1er3gLv50C50EpteE9lkBCP/sCYC7y6SZpo9zeXAa9uttLYeMR4Dcpf81Teyba0I032Mxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNhtNQ3qrm2dl+l1skwnEjzr548+D0VZY+E/eZpNR7w=;
 b=pzqEevMrFdhZ++iproKUg0VghkklT5vl4LXOi9SSW2wDw5+x5fw0y/hMdvnTs3J/i/0nOBZuJwjt7M37l0tg8tvDdwRDOKNI0t/TuiIpKEAA6PD15fV7+xgAP1jaTFLTUhQ3KM/OaHzFpCYE6dIa6akF7qpttq8Hcy5p8qv82Hs=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MWHPR10MB1373.namprd10.prod.outlook.com (2603:10b6:300:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 12:18:57 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::cd04:db71:3df4:581]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::cd04:db71:3df4:581%5]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 12:18:57 +0000
Message-ID: <135e22b8-14cc-446f-98b6-9ee059236641@oracle.com>
Date:   Wed, 1 Jun 2022 13:18:52 +0100
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
 <20220531162152.GH1343366@nvidia.com>
 <10f16c13-c50d-892c-a20d-979b2135c953@arm.com>
 <20220531185110.GJ1343366@nvidia.com>
 <56bbbad7-bcba-a440-692b-64e50b4eddf8@arm.com>
 <20220531231039.GO1343366@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20220531231039.GO1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0075.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::8) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e707ceb-4a27-4b72-9526-08da43c8e6be
X-MS-TrafficTypeDiagnostic: MWHPR10MB1373:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1373D409A10DC694D80A2CC0BBDF9@MWHPR10MB1373.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8vqv+tZAbkzVAJ1xngmabgepBDKWULHl+rmCZWAwqIqPzdfgMA9Q6XkOkHSV18oPRuhDPymptbex4HoR3njUVvm9vrv7mgaEUcjpTbaq0n4b8urO3oPs5GMlDXBDaSFQCKlW0LSvWqS5w2knfwRrpYPalQ/ncNdOMpFJleaDsyKufQjtOvCPNMiFD5pH0IAKb5vw6t/osnsHypf/V5kFnz2tWLbXgfL8ThhvGIlmHO6tbmZSLhpmrn/E6GJCEj1EKZeXMQswm12EyAfC1uG4WdVxYnQSpONYwfeUADRjf4WGPd/IVXoA4wTlgaqAL46A9ujhhR/2ptG7Wv98bGKyeq2vJOmRSCNRD0dBQO9DxrPRRaSDiKydC0BrgqwkyIgmQmx0pM9d2YTvqWC5kLY6w/tMoEEhdQ35McLkqv6If72/hp9VLFmWjcWnlozSiorYuL+Y8j9i6el3NR/umb0AhvY+XYAlr3zpZSKNLjXDtaQ+FYOcHMApQfmlw/MExiq0X05lOG/NUAfMxl7gLf1fXWCt7zpJUdTW2D4YwIdPuZrIuoOsir5kuGXrn4qgiz+/+8CComBTxT1AbvVRF0aWIMXyhp9E/4Sg6UjCSnsFto76bV6AcbwfIJb/L6/68eImsXVQSQXAFSTc/zbJpq+TQLIOauj4mvJUQxfD6wFhkF2ljTMRG7/X2aLzI4e2/6teDqC5fQ0zcfr8WxmyWldCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(31686004)(2906002)(316002)(26005)(6506007)(110136005)(53546011)(6512007)(36756003)(31696002)(83380400001)(8936002)(7416002)(66946007)(38100700002)(5660300002)(2616005)(86362001)(4326008)(8676002)(66476007)(66556008)(508600001)(6486002)(186003)(6666004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZjRXN0ZUdOOG5yUFBkT05OZTByK09YTWpYM2lodGZwZEpGQlY5VUYvSGhy?=
 =?utf-8?B?Q0R1Y3cyZE5qTWZjWURSTHBEVjAyQjRnMHlmV2hLYTFYUzlpNlQwYm41dFFU?=
 =?utf-8?B?S0dtQUxhRXVhYm9DVnY2aVc2VHdkYUhtUFFISzhySXJRYlgrVE0yK0VvbGRk?=
 =?utf-8?B?djRPeDJqV0tsQWZFMTNTNERLME1lOFdIaE9FVCt1QlV1N1BZSHVQWDdPMEVK?=
 =?utf-8?B?b2liRXM0dlNZMXZ1d1VneC9ZbmNZaG90UWtOZ08vSnErQUZJOWdXWk1lMUNa?=
 =?utf-8?B?em9LamZMaWpvcU9la2VzUDZlNnhObkc2OW9QL2VxcVljMWZkVmVJWkRCYUxi?=
 =?utf-8?B?dWJjYi92M0FsaDNkanlBTHlJVnpFUUNMV2dzNzZoU212aFdjODJsWnFJZDJr?=
 =?utf-8?B?VVJuTFEzelk3TUNZczNLSlFkcnRUZk9PQWlydzZ3YW9YRE16empoMXpxOE9Q?=
 =?utf-8?B?cXl4cnNiZW1zYTZ4Zjk2bkRUbDBTaHBGcnNIRUN0L0lnVUl4WExkYklMcGdh?=
 =?utf-8?B?TmtqclZ0eU9aWDl3eVFRK3lidzB0QUdPUnlvTlZxUGlDT0FlSHVZYTN0c1Rh?=
 =?utf-8?B?VkZORDFCc0VoVE8wamJKYkxSRmlpeldKMHF5ZWpEc1RvK1VKb2ZPd2FnTm4z?=
 =?utf-8?B?bWRpRHNqY2QrY1B1MSt2eVJzeGtvTjM3a0prbGwyR2ZzNnZRV2dQUHdHMEd1?=
 =?utf-8?B?L3I5VHIyQjhYQkFFenpudlZKUE1lbjVrVDNJbS9vK295Z1hsNFBGWlFIZ0k4?=
 =?utf-8?B?aUpVZkVoUUFnMkpRdHdpUVdyNGNiZE1aZTZoK3JjdFB5U0cyRVJ6ZlVxTEtN?=
 =?utf-8?B?ZG9aZzZRYTJpVis2OElMTTBsSUxLbmVYY001QmZyNUZjK0ZFYm52c2N0L3dy?=
 =?utf-8?B?aXFyd0V3QjBQM0Y2Yy9YM1hwLzBoeXBUM0tldUxKZ25BRWtZcTc1RU1rR2Jy?=
 =?utf-8?B?WmEvaDh2TkZQU3Z6VzEydjkyeEx3OWNOTTJwR0VTZm9wUzJFdytNamg2UlN6?=
 =?utf-8?B?S2FETDFTOVMxUzg4TDBGNTg1TUFmbkZLYmdYZUUrRXRBay92V1JmbFZhbzEv?=
 =?utf-8?B?WmR1eXR0QS9qWThzdlpGZDVycnlEeGZndmZPT3BVT3pzbHhhSFVDZW8xdHgy?=
 =?utf-8?B?cklWQUNEdGMwdUE0UE8wT21nVWVjZ3Q4SklVeGxFMU1KUUNPdFZUZTlqdkdj?=
 =?utf-8?B?NXoxaTl5dlY1ejV6SDc5OG5HcXI5MFgwTW4ySGljU1ZKQTRLRUVRYmtwNFI4?=
 =?utf-8?B?NWY4YUQrTmtvMitzdk4wVVc5TlN3bTlHWmd3OHVSZURtbm4yRXZrMi9aODQx?=
 =?utf-8?B?MjZLYkErNmRKTkIzVXlUTGVxVy8wbnpPL0VQYkdJbFN0L0FaWnpadDFlMkFL?=
 =?utf-8?B?c2VScTR4c0dKUHIwTytEcmx0bmZkWVd1TFJ2UVRwS3llUHp5Y0JVQkMxa3J3?=
 =?utf-8?B?eldnWFRBMEl0ZUNiQng1UG81T3hhejNzSC85NU9lQVpVM2V6d3Q3S1R4eGZY?=
 =?utf-8?B?WkplZmlFRnFqYWo5NXRXc3J1cy84aDFXM2g0U3A4dllDOHVSRlh3R2xVazlF?=
 =?utf-8?B?K3hha1VhSHFYTjUxMDBwR3VSNklRYUszTG1IM1UzdUVqUUxWVURvUStKcHVq?=
 =?utf-8?B?UktrN0RIc3dCM0pNTVUzVVc4YVV3Z1QxSTh4djJ6VU8wZ1gxMk5uMzNHM1VH?=
 =?utf-8?B?YXJabFdHMTdRaUJjb2lxSHFGQnhxOVZaMlRQOUZ5bFUxOFJDN0JEZE5BR0lo?=
 =?utf-8?B?UGpyQ2pGK0FLNS9jcTc0eGxYcDR4K243cUhHUkxDZ2pQR3BzaHAzUVpEa3B2?=
 =?utf-8?B?ZnB3TDBsc2hwRmJpVHJCcU1OSmVtTWp5b0I0VjBVZzFXeXA5NDFDeTgyTVlY?=
 =?utf-8?B?Sk50S2RiS1RjWkp2VnFUQUhkN3dvTGYzWmRnbStwcWdqdWtIaWU1Nm5UcnF4?=
 =?utf-8?B?ZUZyaUJHNlIxT3BvcjlSTjBXOTFTcTJmUUl5OFlCeEg3bW9qeGpHUHd4dUdN?=
 =?utf-8?B?WjJSbVB3L0YycGZvZmd2TmVkYzNrb3ZzNXRuTnFiVW1KN2tzVkd3VGFKWk8v?=
 =?utf-8?B?RysxT1psQ2hvbmFIdHlFZkpaYUdEd1I5dXV1OFRkZDJCNnV5WUJNVEx0aGJW?=
 =?utf-8?B?d2Z2eXdqbXl4cXR5bEFRM2JCYTNMV2tkOUptQUhjcmg2ekJMVy9ZdFI2OHRR?=
 =?utf-8?B?NlJ6YVptUUNrdWJlUDQwaDBmNGVlODdjek9nQTRSMEppKzhSYnF2ei9oNDVk?=
 =?utf-8?B?S3NrWkNMV0V6THZTdDBKYnAvay9hOGp0S2hndThqVGJjRWd6di96aFcrMmJV?=
 =?utf-8?B?RGUzNEhNNnFvUSt3czJmY2lVK2lZVWR0SDlZVXdPbDlGb0R5RGsxMHNBaGtJ?=
 =?utf-8?Q?94oQiKdWqLtOxdvU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e707ceb-4a27-4b72-9526-08da43c8e6be
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 12:18:57.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHW80Yr9VFQP5xUeQnXk41g8izxfggO5ZXQvrsK3//jmIh8WcWn0KQ4pCyG+87t2lNKPW4CpXkwYwBlAFMCmGVwdNTy4XDiFqQfUbZ/A5c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1373
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_03:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010057
X-Proofpoint-ORIG-GUID: eIPmjlRaX6pWghf_yL2J0JnLxnD94303
X-Proofpoint-GUID: eIPmjlRaX6pWghf_yL2J0JnLxnD94303
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 00:10, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 10:22:32PM +0100, Robin Murphy wrote:
>> There are only 3 instances where we'll free a table while the domain is
>> live. The first is the one legitimate race condition, where two map requests
>> targeting relatively nearby PTEs both go to fill in an intermediate level of
>> table; whoever loses that race frees the table they allocated, but it was
>> never visible to anyone else so that's definitely fine. The second is if
>> we're mapping a block entry, and find that there's already a table entry
>> there, wherein we assume the table must be empty, clear the entry,
>> invalidate any walk caches, install the block entry, then free the orphaned
>> table; since we're mapping the entire IOVA range covered by that table,
>> there should be no other operations on that IOVA range attempting to walk
>> the table at the same time, so it's fine. 
> 
> I saw these two in the Intel driver
> 
>> The third is effectively the inverse, if we get a block-sized unmap
>> but find a table entry rather than a block at that point (on the
>> assumption that it's de-facto allowed for a single unmap to cover
>> multiple adjacent mappings as long as it does so exactly); similarly
>> we assume that the table must be full, and no other operations
>> should be racing because we're unmapping its whole IOVA range, so we
>> remove the table entry, invalidate, and free as before.
> 
> Not sure I noticed this one though
> 
> This all it all makes sense though.
> 

I saw all three incantations in AMD iommu /I think/

AMD has sort of a replicated PTEs concept representing a power of 2 page size
mapped in 'default' page sizes(4K, 2M, 1G), which we need to check every single
one of them. Which upon writing the RFC I realized it's not really the most
efficient thing to keep considering the IOMMU hardware doesn't guarantee the
dirty bit is on every replicated pte. And maybe it's clobbering the fact we
don't attempt to pick the best page-size for the IOVA mapping (like Intel),
to instead have all powers of 2 page sizes allowed and IOMMU hw tries its
best to cope.

>> Although we don't have debug dumping for io-pgtable-arm, it's good to be
>> thinking about this, since it's made me realise that dirty-tracking sweeps
>> per that proposal might pose a similar kind of concern, so we might still
>> need to harden these corners for the sake of that.
> 
> Lets make sure Joao sees this..
> 
> It is interesting because we probably don't want the big latency
> spikes that would come from using locking to block map/unmap while
> dirty reading is happening - eg at the iommfd level.
> 
Specially when we might be scanning big IOVA ranges.

> From a consistency POV the only case that matters is unmap and unmap
> should already be doing a dedicated dirty read directly prior to the
> unmap (as per that other long thread)
> 
/me nods, yes

FWIW, I've already removed the unmap_read_dirty ops.

> So having safe racy reading in the kernel is probably best, and so RCU
> would be good here too.
> 

Reading dirties ought to be similar to map/unmap but slightly simpler as
I supposedly don't need to care about the pte changing under the hood (or
so I initially thought). I was wrestling at some point if test-and-clear
was enough or whether I switch back cmpxchg to detect the pte has changed
and only mark dirty based on the old value[*]. The latter would align with
how map/unmap performs the pte updates.

[*] e.g. potentially the new entry hasn't been 'seen' by IOMMU walker or
might be a smaller size then what got dirtied with iopte split or racing
with a new map

>> that somewhere I have some half-finished patches making io-pgtable-arm use
>> the iommu_iotlb_gather freelist, so maybe I'll tackle both concerns at once
>> (perhaps we might even be able to RCU-ify the freelist generically? I'll see
>> how it goes when I get there).
> 
> This is all very similar to how the mm's tlb gather stuff works,
> especially on PPC which requires RCU protection of page tables instead
> of the IPI trick.
> 
> Currently the rcu_head and the lru overlap in the struct page. To do
> this I'd suggest following what was done for slab - see ca1a46d6f506
> ("Merge tag 'slab-for-5.17'..) and create a 'struct page' sub-class
> like 'struct slab' for use with iommu page tables and put the
> list_head and rcu_head sequentially in the struct iommu_pt_page.
> 
> Continue to use put_pages_list() just with the list_head in the new
> struct not the lru.
> 
> If we need it for dirty tracking then it makes sense to start
> progressing parts at least..
> 
The suggestions here seem to apply to both map/unmap too, not
just read_dirty() alone IIUC

I am not sure yet on dynamic demote/promote of page sizes if it changes this.
