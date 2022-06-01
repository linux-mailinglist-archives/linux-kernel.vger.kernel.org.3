Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CAB53A645
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353432AbiFANwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353398AbiFANw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:52:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0AA2F3A9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:52:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251CGX9t010049;
        Wed, 1 Jun 2022 13:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vu00EuVB8wUBNVXH+m9lB/sS4w+wXz1rZEcbOm3NRPE=;
 b=r0E9MI9UHKKUcmReiL/e/WkDb0a053G4lnp+GEu5ICueJ0pBztImd69tX3ZG1LeHldrx
 tMnlNCBosycswlk4P6ea8z/5jv+znDCGvIXtX125xtnbdsXONdcAHM1BEbfjSDJPTamW
 r/xI2oiXk/1vQbZgg59SS50G+jJhkMCDy2B41kchW/tiohN46it5OULyJem26WPQHwIy
 xE28W7mwX6LbUeNtIU2Ol2Vo46u4aHcoFyMOwZUx3m4e7IO8l6eOtrniRRNGYKgIy7LO
 285kkmEJzqqu4O613cnKvFGzQihH6uns2zSel37z+BYn47WWjMPQVkwMArR0uXioOPPz Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcauqxus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 13:52:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 251Dq1M8002254;
        Wed, 1 Jun 2022 13:52:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hu49b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 13:52:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ4pC57WvcMawJggEpuoeD/8a392MbUhYTP2lFq6xL1jeu3kb8Yxcur/nlvsZIh4zJjx+d+qLN8/jfpohVYxnwDG/WaYiO9dBZnIC/XtzYe0+8VUO38VXlH/zchnxhOQZeqshhEDrj5SFSaWzmonw/subgVjlRITq3OOR8IMbiLNaZiGEl/k2M8dQqlENv/2rH8rbir57N3zRiiEt1gdzkLj8bbxH2rLnwWCEC/wdMBmxLEVOP+qpK3iX4l0KrjMJ2wnhKJE8k9+5siN3LekGia6Z4n6LXQKL9G0CKvZ0nbsL/Zi0Sz/iGN8W76OJkpUpzTm0AHT0u/xRa8+8NBFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu00EuVB8wUBNVXH+m9lB/sS4w+wXz1rZEcbOm3NRPE=;
 b=TwWyFx2vTuX8BzI/0eNpGbCzwIzA0yX9qDVyxSBEcS3Hgxog30EPcBmGyKImy+lII2earv30EW+wpLShWjWtx3GEh3zri5q3kS4Sh8vajwkcno4b90ufH8v5RMJG4+g+goKa5NH78fs1vEzTIsXy0ACpvhrXQhu0rcA5q9kyHMsH4rusog402UBeNkQqXGUyM+l1R82MVFrZ8BB9t50bV8QkqlbNwLmklyLtTCy+V1lmRb5edbhKRiiH+iy+dKX4qrxNw5vHlNSjbgyNBbdtqqLsjLIFofaoQ8G0TjttashHod5xEQ/KlnaHjfAoAgl4aVLZEFOdAAdtL6EiJCDxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu00EuVB8wUBNVXH+m9lB/sS4w+wXz1rZEcbOm3NRPE=;
 b=WAxOncbbc9q0HjP2Zr4hrWahZBOP9cOG6MBFZ4PyVKC3IVdy1jzNyauGN5EaCfjwOGjE6EAKSHeeGAQ1jmWjROLJ2rhmkcjdF2g4baqFfSmHr2mK6QHNRj9PcfMuGP/E5hSMDsGaPNSiNUhS/RzQUEl6fNLYS66H4fpPzqezgwc=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 13:52:08 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::cd04:db71:3df4:581]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::cd04:db71:3df4:581%5]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 13:52:08 +0000
Message-ID: <c79978f4-7304-fe62-73c8-7cbcc4b2b24a@oracle.com>
Date:   Wed, 1 Jun 2022 14:52:05 +0100
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
 <20220531162152.GH1343366@nvidia.com>
 <10f16c13-c50d-892c-a20d-979b2135c953@arm.com>
 <20220531185110.GJ1343366@nvidia.com>
 <56bbbad7-bcba-a440-692b-64e50b4eddf8@arm.com>
 <20220531231039.GO1343366@nvidia.com>
 <135e22b8-14cc-446f-98b6-9ee059236641@oracle.com>
 <20220601123321.GQ1343366@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20220601123321.GQ1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0291.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::15) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9168e54f-a4f7-42ed-0f11-08da43d5eb2a
X-MS-TrafficTypeDiagnostic: CO6PR10MB5570:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB55706CD026FD649BA9EDA934BBDF9@CO6PR10MB5570.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtUL8csvch+DvfavK/tZqxAXBusnvY3OpCjbm2Jcuy/vrfU6rPkvnBfEIo9AUJWdBtlIORGIhf331Xoohtg44Rj2fz7ZKvLyBC1tk9DrRHDcN5wCW8YDnWTDc6+fORgAvC7Smq7xL92JOwuPw8aqj2e3RLx7iaRQaxL+jyh6EVRELCQ7wFOPownCRc9lv53OfGu2uwsdtFqK3444d1295p/cAI1Zn/bo1DFfGobH+nVsdrPFrLhZmYbrn+UUp7qfnlZwQ0CKRayGRBZCcMuXLErpsYTq7MSLe9cQEQIp0lTRUwx548tMmmdbrapBxJM44WM2rzUPG2HtXjN6SQB219wVolcNt6LoHEpRKjqwuyBexjfa74mzd/4PtHlrkymukBAAytQKLon+2lKuZmqBve8gR/DkLr4PaVPl2J1dDcb0zVncUpg+ow0OEUlqqiY7Gennc/YrUC+Zx8e8GZaPgZg36VaI+yxgF++ci2SaD7sZxY4wu5QI0peqNPqUaMjCEd5X3ewaeVPvOXK4OIpcLD5dRpqi3fRHYWuY9coJ04GjuLWWUQMbcyZ0bc8DbqZLargeZ6aKTnfvtL1b/Fjj1VUdj22oQhtBMZatuu78ZOjUulaRSLw6lnA+iiJczGv2MQwAPaAjJ0YGyN/VXtEbFdbErn8kSh4h0DYjWclKkDacPxSKvhCzzIo1+x4Dk1V4CdKH3CpYhqIYV9hVocBfLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(8676002)(2616005)(6666004)(66556008)(2906002)(66476007)(7416002)(66946007)(5660300002)(316002)(6486002)(36756003)(8936002)(4326008)(86362001)(53546011)(6506007)(6916009)(6512007)(54906003)(26005)(83380400001)(31686004)(31696002)(38100700002)(186003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHZTQXI4SjFJZTR1WWdOZkZZeFJUaXplWnU3TFkxMFROMHAyQ3JIYXZ1aFpm?=
 =?utf-8?B?TWZlR1kybGNYMzBjVlFPRUdVOUdQUzNZNk53dEcwZDRGV0gyK0l3ZW5wck1C?=
 =?utf-8?B?U3pha213d25GZWhQQjRPR0x3M0RoVVFYcXAxOFB2enZ4TXl5QkFHelhleVhK?=
 =?utf-8?B?VHBleWg4K0Z3WDJuTVU3RUM2QWsrTGQ2Z0FuOEErY0RKbzNiSkNGSWc4R1lB?=
 =?utf-8?B?L3Q4NEluQnU2OXpvOWhpUFZDUWl3bVhTaWY4OUhXNDV6WkdIeGNRWnVOem52?=
 =?utf-8?B?Z1pKeGhtMGlrSXFiTTI0b292MzFCYXlyb1Y2enZxaXpvb05IR0FCRnJ6RFBx?=
 =?utf-8?B?cFZ1Y1ZjYzJObWJmSjQ1MGlGWjRrUUxjUy9Kc2JkdnNWblg0ZVpKbUpudVVG?=
 =?utf-8?B?VnNqSmpZVUJFajU1Vzh1Q3BDTkxwQVpTRzdIbkxBQklMaUxVbXNRRi9kSVJX?=
 =?utf-8?B?WjJqWERGOXdxb1o2VkVQSWlWSXhFckEwUFpMa0ZKZEdMbXNTYWhTNnU5eFM1?=
 =?utf-8?B?SWVLbmtjU3BGRlVlUFF5UzlvblJKUGM0WTJWaC8zYndaSC9MY280MXU1NmxK?=
 =?utf-8?B?QWJPc0dLMTlTbS9RR3hOa1pMNzFBVG5TS0hmRGkzUmFITkMveU1hK3hrU0wz?=
 =?utf-8?B?STJ3am9JRmpRblFXV1JQdGFLMUx0Mk9ncTljN2VKMEd6dFBzZXJBaUJWenZx?=
 =?utf-8?B?ZlBQa09Gd2NtQi9hZnpRb2hIRXoyV3NVOEZkekpPVUNkT0F5UHdBdytmdVlw?=
 =?utf-8?B?OVJUNlN0VEg3eWV0NnQ1QUJkNXZpSmVTSElHTGdnamxmQVdIV2VoWkQwWmZN?=
 =?utf-8?B?cXFISUN6TnIrN1F2aGs1MFpMdmRrRjBWeFh1eUtkQnJUUmppYUJnVVpGK2xP?=
 =?utf-8?B?dWtCNUN6Ti9GcU1HajZ1STc5K3hISURlZWQ3dUtMNWR4NlgyVThrMzBPc0xi?=
 =?utf-8?B?SXRiaXF2M0cydGFIdjhITmpuNGM2K0lUQVB2UmM2OVVqSVJGSHRrUDduOW1H?=
 =?utf-8?B?VCt0Nk5nSTNXK0FBR0RDNnFJRHVtRWdzQmhCWERKaFJLWXBQejBmb0d5dVJF?=
 =?utf-8?B?clJYUXJybXNheHRnNzdBMlVRZmVFcURsV1kxYW9CRll5NFQxcWEwV2hZZGU2?=
 =?utf-8?B?bmhHWDFYQzZHZnpmY3l0M0lJR3pucGV5a25Xd2lwRWM3bjZ3M0xCQ2ZIN0tQ?=
 =?utf-8?B?UEhHcml0Yk9zR3A1S1FLSUJvRkZzWHo4OEc2TkNMeFhnT3pybS9LeFFFbmNO?=
 =?utf-8?B?L2VHZVBucnp4dStoTU0yUzZiZGp1THVLWlpYSG9LanFidTJXUUorbTQrcGgx?=
 =?utf-8?B?Q0ZGOUhtS21ENUpZWlNra0h6NDRJYkdYaFdRV2tobHNLU0ZYRmozcjROM2F4?=
 =?utf-8?B?NW1aZnF0RzY0eFozdTZCQ1Q0bEhVdzhuOFY2UVNRRGhWeXh3bFl6SGZTTnZ5?=
 =?utf-8?B?ekpjamxPSVNBNEZXckpCRHFUalFkbWxuN3BYZ2VpcVlSS3UyeDZtOUhDc2h2?=
 =?utf-8?B?VUc2dkt3S0hOUzh2SjBTMmJHbGRKOE0xOGtLdjFveDlmSFB1UFVUZDZXdmtm?=
 =?utf-8?B?SnI5TGdNQW44NUM0bWhHVXliZmJNZXIvWTRUU3lRcWVrUlgxUnc5WUVWbDBv?=
 =?utf-8?B?RURZYUtaTGlBcTZRWGpJR2NQckZ0eGNCN2U2eU1UNEJONzh4cDFldUY0UWtM?=
 =?utf-8?B?Z0ljR0tSV1BMNW9EcWl4VTJ5aE9NMGdScDlVVzJyeFlwa21WSFJudU10YTN4?=
 =?utf-8?B?R0lHV2plZE5zUy9YK1M4Tk5lamgyUU9vUW0vbEtWbU90dDZjbEpGeitWWHF1?=
 =?utf-8?B?eXFxU1BPeFJ3YkJoTEZQQnJCZkxqaXdwSmlHY2YvR2tNMmkwTHFvT2dOTUJz?=
 =?utf-8?B?RExlTXMzcHFRdk1LK0EzVmMxdmxMSVpiL1hqcnM0T3FsV3YrQ1BJeGtLV1My?=
 =?utf-8?B?OHNNV0N1UGY2U1kxdGZCNDVmTWNsaHdCMldyQ2VYc2RSMTJicGptWDltN3hC?=
 =?utf-8?B?Ym01QmVacUtZeldLa1dXQk5hamdGcGM1Zm52Nzk1RzgwTTR1ellOcE1kRW9L?=
 =?utf-8?B?ZTI5MjBqRXp1YVZBdENkaWlFc0NoYklEM011Ykw0NkZ6TkxxR2JBcnVIeTYw?=
 =?utf-8?B?Q0psRjVjandqRHp4TlRzcEpvRERzL1Bsamk3T3RRTHF3c3p2VW1mM1Ruekxu?=
 =?utf-8?B?UmRGcEtmdm44LzJnczRkalVld1NnTUNkdVVHOHZjWm1tQ2pqZTJBSEdmQUtm?=
 =?utf-8?B?TTN1S2pvUXQ0UE52Nk0zQTIvQjJqci9RcUhjUHptU1pidFJQTytGMFhDbHk5?=
 =?utf-8?B?d240Q0VDdE9xd2Y0N2FhRjJheVFmazJCdkVFZ05WV28vVTlBUzdzZDRGblhJ?=
 =?utf-8?Q?Ys5yRcXTf0hfTp+o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9168e54f-a4f7-42ed-0f11-08da43d5eb2a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 13:52:08.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9jcA82+4nfmy9e7rBLM1flc2oBWrB7wFNeW9g86zl0JSB1PmEiC3YkBzKRqQfqe+ChMr6kUtjAyYagz4bu5uqFlmTpv5BYqASYGshAjqa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_04:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010064
X-Proofpoint-ORIG-GUID: _W4bxCw47lfmtUtdjRZ8ob-x-5ZNx-TX
X-Proofpoint-GUID: _W4bxCw47lfmtUtdjRZ8ob-x-5ZNx-TX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 13:33, Jason Gunthorpe wrote:
> On Wed, Jun 01, 2022 at 01:18:52PM +0100, Joao Martins wrote:
> 
>>> So having safe racy reading in the kernel is probably best, and so RCU
>>> would be good here too.
>>
>> Reading dirties ought to be similar to map/unmap but slightly simpler as
>> I supposedly don't need to care about the pte changing under the hood (or
>> so I initially thought). I was wrestling at some point if test-and-clear
>> was enough or whether I switch back cmpxchg to detect the pte has changed
>> and only mark dirty based on the old value[*]. The latter would align with
>> how map/unmap performs the pte updates.
> 
> test-and-clear should be fine, but this all needs to be done under a
> RCU context while the page tables themsevles are freed by RCU. Then
> you can safely chase the page table pointers down to each level
> without fear of UAF.
> 

I was actually thinking more towards holding the same IOVA range lock to
align with the rest of map/unmap/demote/etc? All these IO page table
manip have all have the same performance requirements.

>> I am not sure yet on dynamic demote/promote of page sizes if it changes this.
> 
> For this kind of primitive the caller must provide the locking, just
> like map/unmap.
> 
Ah OK.

> Effectively you can consider the iommu_domain has having externally
> provided range-locks over the IOVA space. map/unmap/demote/promote
> must run serially over intersecting IOVA ranges.
> 
> In terms of iommufd this means we always have to hold a lock related
> to the area (which is the IOVA range) before issuing any iommu call on
> the domain.

/me nods
