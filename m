Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED91250EF04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbiDZDIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241091AbiDZDId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:08:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5701D9;
        Mon, 25 Apr 2022 20:05:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q0MJAc023432;
        Tue, 26 Apr 2022 03:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/pRWDC429SHh0lHBGsbRkJApbJh7u2AQKaqmuj5AUI4=;
 b=eUX4QP+sL1ZdkIKXuLBH6BRobdjDCg8bfZS9tplwaCMvV1qWUH5EuusNOLv7jvIwDKb9
 JJmyIa7seFoEY0oLZcC5+EVlRu/N2xJQM3VFv3NyQ81q8KcbFnWmkYNmEKi7Z92ly6QC
 Uw9vitKe3a8U7eDCNKuHaoVoiNTIzWAtWMKiRCtgmgLgawv/hnHW/8kD1caheUCDIPtq
 Ke+Z3Qw/mZ6o65SBzFtfUf5EN9s5WY18h4pusgEQgVVtBJ2E6zQeVColNPTCdtP03ujx
 GNHTuTnpEG3frUUZGDmgEf/OEIsTNLTCW+xpCRR8IwNBtgxKbCtsRfJZMC7kST1rg7YW ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yvpfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 03:05:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23Q303sQ033191;
        Tue, 26 Apr 2022 03:05:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w3756e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 03:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSMkw1taU7o49SrGrOunB/MPuYf80cPa368Vy+HyWYkuQXiyoG4ekcGzZeeyTcqe++KD12h/vXt+6XbxshdenKC3QWkCzfABjvk+CydlHdFrtR86YPBEhhR919mBMyqD3GusA/6K4g+kB0n04wZYB+WHY8pWs3BS6RlVOuFmQTTbja3LtDOivEFFQhfbT3yY30mQdtTVZF+6bY3CCc/u6T05gaOy5JConcprBdevFngipNzQL2+YQ+FhOOWL1RNExHdeordxaVdUBfNuDrpjgIvzdGCfiMVXXvhK5MIXf9BDI50wR4qcRaR3/882PggNlxcP7Q0wAFKXxHTtPT/0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pRWDC429SHh0lHBGsbRkJApbJh7u2AQKaqmuj5AUI4=;
 b=Kh/MlP5+qPQzCi2+lB++IQekCAHYVQRLtYiiDi5KRHHZkr/9ngH1VmSKwByec3IvOrMXq6uCVD+Fg7IfaTkquNR4XICipR/Tbb2UN18PBzgXAgwExtkiCA8gl/zpFfPvbq5G04KUZUWeA928cJNd3EOeoRoxDPPt5FmFzqz1roMy2F2YHH4qoFZHVJZBrLIqlaNh95ifIYpguNmwrtUjxS9gdlIm3ssFlYefvuUEZEPknT1BKB6rSFHaJYkEoUKUnaOkKgw1YFMp2QYasSFlGfnrPPZu4CdzR8/SdNiQ+ct9dW1WUEEjWxDECjUZ9PY9Ki8OS1RNQpo6VDeiitcgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pRWDC429SHh0lHBGsbRkJApbJh7u2AQKaqmuj5AUI4=;
 b=nSrYGneD+brNoOuNP/KiJp1oYIsHy9ONhD65zcXfSbvqEH9yqZ7PJ9W/8lTiTeY4k05ZsusDuhT/LpdgqEBVFppnYlD4zEdm47Mftgq4Gl39x3GTQInCpNHbopBZN4UF0cs3nAh/s2Moa3MpO96I7Dhb2FhkYwo+3y6mGP4K10A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL0PR10MB2833.namprd10.prod.outlook.com (2603:10b6:208:78::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 03:05:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 03:05:13 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 01/11] scsi: aacraid: Fix undefined behavior due to
 shift overflowing the constant
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15ymwwnmq.fsf@ca-mkp.ca.oracle.com>
References: <20220405151517.29753-1-bp@alien8.de>
        <20220405151517.29753-2-bp@alien8.de>
Date:   Mon, 25 Apr 2022 23:05:11 -0400
In-Reply-To: <20220405151517.29753-2-bp@alien8.de> (Borislav Petkov's message
        of "Tue, 5 Apr 2022 17:15:07 +0200")
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SA0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:130::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf2a1217-874b-4557-ae40-08da273194e7
X-MS-TrafficTypeDiagnostic: BL0PR10MB2833:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2833C7B4C2B782CE996145D38EFB9@BL0PR10MB2833.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tuUF8c3azJsd3fD0SpwDB3Psk8yeT6VeSxklGqdHCdIWtzlN2Kh87yj9I6vny+m0fXshwJ4PlxeidHFXscxeBWjFxl32s0ft+akAkAy/iNhRb7M9cIcOXmgmdPgD8v5A2wzktXXD4vhWiyVpCrGVy+Zt9jWoBdgXVCJh/zs7FaHL5TeVHPeP+Rv65jBMD+2XgmyubumyDRZCc/P0laL7i0IFjRzhFwOzYe0WRbcmdqFErHO4Qa3B96m25H4YZr8+mhFMc2HUglxdcNkwGwN03gUOtO5r+Oq/ucBIaSj3mKKnqfsHcqYrw1OvbEDTH54LRTlDPu8+ZvoOtfwJ+3OML/BPOcal8pvsdXotpoN7Apj1n1THrBy97HMsOXVGS513NkyJ1BZ/pGBKslHcGiRaAC+m75I6aFmDorJSuWxrVvTUnNu5iv1YNIimMTEdaFQApsudSB4AeGJ+RqxHmnp2xF8tHr0ZYcRc1GhzxbvmBGNDkFLlUtZqqupXEg7wcuk7wsGiuQEHEK6XDTFZc9RVwO/g/NFAEHgaSiRRSqWVXDLadOuJQufRotHgdZ5D+Av+arN0ogeL9e4xe6pRqzc+ove4ATv2rUuKJaS1RvOmHHUvYbFaWg+m9e5tqwtZzs7shHprHpSLU20CFHuC0/QoTKr1F6VcPvLD22LGUHtVW1I/e+Kk5K7AaLfH23KNRBED49fvgIOzKAkMGRtOr55Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(54906003)(38350700002)(38100700002)(186003)(5660300002)(6916009)(316002)(558084003)(8676002)(66476007)(66946007)(4326008)(66556008)(8936002)(52116002)(36916002)(86362001)(6512007)(2906002)(6506007)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXRYNlVQN25CUnd5c1Fzblh4bzJJaWt1RTUwZHFFa1RTUXJjUldwTkZXRnVY?=
 =?utf-8?B?WHVaUTkxd1AxTzJNeVpEVzdNOENKRGxlMHRTT2VWMEdjZGFoVnR3NUFxb0xK?=
 =?utf-8?B?cWVNOUp6QnZVcjVWd0tsUnQ0WVFXN0h1TXE4eGZydXJTTEI1RWFtcEdHVHkw?=
 =?utf-8?B?ZFBrODJ3YXRtakkzKzZOWGU4QmhHbFhzSHNsN0hpWCtLUUk5Tm9pcExJbDQv?=
 =?utf-8?B?Nkprd3BKMmxTTlcwQnJzRWtUNDd2MnBrSXFCd3EyQjAvUVpJNW5JVUV0Vklq?=
 =?utf-8?B?dG9NSlZMcDhhZzB5N2hpU1lLMERqNXZNV2NEdXh4bHkyeG9sYTI1U1FZSG54?=
 =?utf-8?B?L1RWL1ZIazUxY1VYU0xlZVJBSEhpbWI3ajh4SjQvTnZYSDZHVzZBVG9BWVdv?=
 =?utf-8?B?RTVHUWFybllpWHk2Rk5jTW5hakl0ZWFBYVJPSXlVRzRmblNEMXFtV2RpcDdy?=
 =?utf-8?B?NVRuOEluQXFWTlkrTHJxajZmWTlSMmMvOHRwa3BUaDhQSzQwSGQ0cE8xTU4w?=
 =?utf-8?B?NlpRbyszSFZhK0FKY0xGWHJGd1FRb0xvUXV2YzVQM3E4M2ZFdkYzZW1GbEZQ?=
 =?utf-8?B?N0oxbkNJOCt6NjU4clVuSHJ3NlFKN3p1R3RpcnE4cjZFTWxQcDBhQ1IrUkUx?=
 =?utf-8?B?SnRYenlBeWViZkdIbmU4S1ZSYUwxUGFHeGFndElQZ1g2VytNZGxYNG81OWFz?=
 =?utf-8?B?TXVLNjg1cU1HazVQdFpGZUY2YXJxWGJEbUM3Z1RWcmxoQ0xTR2JFWWRCdVpq?=
 =?utf-8?B?S2s1UStSZWl6N2hLTW9TcnR2RWRQTU15MlZlS0ZaaTdzZjhPTTY0TWFyeUpX?=
 =?utf-8?B?VlJmMGxNbkppeStEVDFON3VTNG9CTmJzK2Q2THl5TzBlSVNPM09xYkZCbkZ6?=
 =?utf-8?B?RFFCbmZSaXVJNUZISDBTdzJoOUFRR1RSMzZxbjVHVnN4ZDhxM1UvR0lLdGhF?=
 =?utf-8?B?cVh0VTNyd013VDdnZi9OTGJWNDA5aHUxcDExejAwUHpWWEEzUFpzMWwvb3Jq?=
 =?utf-8?B?QUxmSkdMeHZ6L3ZUVjR3alVYa3V4bkdvYlFUcVRrRC84N2M0cVpFSnpCS0pz?=
 =?utf-8?B?dHp4WlEyQjRwZ2NWNmE1RXRneUdoYkEzLy9ucHhiM0NBYzhrL2ZvT3FaYmxS?=
 =?utf-8?B?Qm9XMC9hWmRITGFvTThaMmwzOXE5QWhOZ1NPSVluZVBvV0RXRXJjTWtpWHBv?=
 =?utf-8?B?ZndCMzI1Sk9HenZMT3B1emRvOHVHWi93dnZQV2ZuN1dhcTFYV2N2ZnJDWUZX?=
 =?utf-8?B?ZEtJTWNrcnR2aVc1c3VFdVNaZ1I3dFBac052L1FTT1hWRm5ZWjlGNWwrSkto?=
 =?utf-8?B?Q1FLWW1laXh4SFQ0cVAxb2VGUTUxRlpxaHVqVWxIMzZpVUVId1RxMVlzOEFq?=
 =?utf-8?B?M01TYzhVa24zUTZoSjZDaUdCYUVmb3dNcitYTktKRTRnVEpPZCs1bGtnbUZN?=
 =?utf-8?B?R3ZVSFlGZFQ3M3VQaXJoczNPNmhuc2c0enhPWFpnQVZCQXE1YlpVSytCZi81?=
 =?utf-8?B?NTJOQ1E5b1BxbWVDaGhyVTlvQ3VVcTYvTjF6TEh3UDdSZWJ1elRRcTNyaVBF?=
 =?utf-8?B?a3dacUMySkFHQ0FSKzl6ZGIrUWhKdGxGUjNlbGhnN2Q3Rk90T3FKT0F3QmZx?=
 =?utf-8?B?S0x4RzdXWk9XZkt4bmJQbGp1bGlUN3ZiRi9YMnlzNGNUNGo0WFpGbitaRmU1?=
 =?utf-8?B?S2hZb09qd2J2aU8yTlNGdkJvUUVwR2VBNCtWM2xZd3N4bGFwVE5MMUV3Vzkz?=
 =?utf-8?B?Rk5iWFd3NHNxUFdoRGRmTDVMR3ZaTDczYUduZ28yV1lYUml4OTZ2YWNTZ2hm?=
 =?utf-8?B?c0txQk5rSTcxV3hLSTFMRjZVYUw5SDFFRDBWKzNuTzYxd2E1Nk1UQzJJUzU3?=
 =?utf-8?B?QWxHT2VaODdubkdHNURPZElheFhiT0pnRWJ6Q3F1NnNpeDFkQzdON2FWZ295?=
 =?utf-8?B?SHlHZ04rS1k0bHFKc2JuRFVtbmF0V0dyVnVENDFOdWg1ZG1XQ1k3QkJpRGhP?=
 =?utf-8?B?ckdvcnRGYjZkNEVuVG9GTnplRjFhbjBMeVVXYU1UQjZHczdDRmU5MmVyVU1v?=
 =?utf-8?B?RU55VXd6M0ZDdWFNMWcvSWJRTW5NWUU4WEc3NU9TdVJGbzVBc2h4djF0a3lG?=
 =?utf-8?B?eCtvSDRLa3ZncHM0aGtCRFRVZG1MdDcrUVZVTVQvVGVIcDczZkFXbUR1bDhJ?=
 =?utf-8?B?WjNpaWdoZ0h1d3FSSjRuMm15bUk1SHMwNWFjTGhrNzdrbnoweXRJQlpJVGJk?=
 =?utf-8?B?NVI3WS8xNkk0blJiTVFhSGdhSE93dGFvcVdzZTVqQ0YvZ3BjMTdYRXdTSkhO?=
 =?utf-8?B?cEFvVUMxdHo4MmNLSDdIeXlOQzRTaUY1U3VXRC9ldlRXZndlaCtCdW8rQkY0?=
 =?utf-8?Q?/r26HG1FnfuCrydM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2a1217-874b-4557-ae40-08da273194e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 03:05:13.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVMD1eYNJeBrn4+fGPR+H1J55ukW3P6EmsGK9z4zA9KO6EvBSnyIrZwEVmbvUEnAdc5vCHCUbA4/1MFHZvBaW8kzAWYnmKMzeNRKgAf4+/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2833
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=685
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260018
X-Proofpoint-ORIG-GUID: gG1QY2fbBQRn_FQlHbaeg_fYwAOQ7pc2
X-Proofpoint-GUID: gG1QY2fbBQRn_FQlHbaeg_fYwAOQ7pc2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Borislav,

>   drivers/scsi/aacraid/commsup.c: In function =E2=80=98aac_handle_sa_aif=
=E2=80=99:
>   drivers/scsi/aacraid/commsup.c:1983:2: error: case label does not reduc=
e to an integer constant
>     case SA_AIF_BPCFG_CHANGE:
>     ^~~~

Applied to 5.19/scsi-staging, thanks!

--=20
Martin K. Petersen	Oracle Linux Engineering
