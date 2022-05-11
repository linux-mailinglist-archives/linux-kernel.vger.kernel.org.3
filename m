Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6B523B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbiEKRea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345629AbiEKRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:34:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E1F2317ED
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:34:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BH3ovZ010445;
        Wed, 11 May 2022 17:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cx0nSc0iScSvG7tttG8DluWDW5ToC1t2R/9vOb4eCu8=;
 b=L6C+JdoyhgTqlfzrc/GpSCEbEbcnILibibvuyXg7qZoWkmOn2OwGVq+O+y6eNCOUJsKa
 5+qZylb65RLZ9YX1GyBBbxca1aazLn/MmfPLHbddUmWDDmwc5WscixPwYXUwGaQU1/+R
 MkRjmyBHNO1WCdbBynw8UyKVXx5g26bAe8R6wNmnaxu1ykjm4OZLB96Rzd4kLqnAsdqq
 MlSpjkNH1rlYKA+I8M142s8hVSRFK8/DzlFOkGUAxFShdlEyUDk1ZGKu2jCuAbaHoNRz
 bigd/VASbjFZx+rzkNIFonMo4KW5e4SV/VXD8/87iS/rfevixYPCm4XC6j/FrZf52sL/ lA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6ca9j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 17:34:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BHVhke001554;
        Wed, 11 May 2022 17:34:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf74n00r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 17:34:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9lTksmXOpIlNqCAooq2+q491rs48qND63fqQZ1X9JE+r3npzvl37jB7gnSJBdEsGCeZ0brPTHweGgKJ9NKpZbbqnTQloL+31NIrebxMFjzyLfiMkRyHYnweJ5DHoqeux4aoesk4QIrEWE5EcbNDRv7BpNXocdHBkt45MoAXgGR+1MFVGxLfuapdNPgdS+TKIlqXJ+6VcAFLUdwSvIEc7xOxFpssczZH97FNYcPpkQuUl8Uie+Q3Nsu6J7e5FpE5yz8wYBCmKHRy5bqBDbJqcq0IS4xRSYDBNtgYmTVKlACzgFXIUCZZJ/jeshbFPL24ObmfNA5sx7vpwIjSs0CDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx0nSc0iScSvG7tttG8DluWDW5ToC1t2R/9vOb4eCu8=;
 b=EFjMw05YZAACeXdb20qvEkTQqfBdqmSCnWzoIM0LzUEFrKXKrFwVeqhn3fjvBSmT+yqzsZ8ubAjf7wZHrlNooj0b+q3mF4gEMsXMXJmGlsM0Gf/SoETZSwgTkiWc0V2QQuj3FssTAml0oSC3DVqS11Vj7jk8qG0/w7Rrxu+FcPJTCYlEqOgWy4LBnY3RU1qGA5TWRru0rUDJP0lXx6RJsFJcp/bL6Xv3wQgtqAZbgW5cpLleP9SkE+UTyv+czWs3M8Z9jBa12GkUd3m8BXMFWV+MP7ZtBRTCBolktsWG/Pl8lUtSpdHg0pMx1aK2aVUh9hqs3BTJDxXnWD02go5Zfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx0nSc0iScSvG7tttG8DluWDW5ToC1t2R/9vOb4eCu8=;
 b=viI/2VUjjWL9akl073aDjP6ftAvl7cxbF3i3yQzaEZWk0bDQPYtEwS26+PLEEnVzswvz2+9fKjXJVwIhxolqg+JQyHddBsujQqxSaPTCile59R4ojlSsw7FN8aGAnsR2QZDC41MbLCX3EWaEr++2BVNk+02uTHElkVi6z2WCP98=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BN7PR10MB2676.namprd10.prod.outlook.com (2603:10b6:406:c5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 17:34:17 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 17:34:17 +0000
Message-ID: <bf8b9a97-e499-55e3-be91-12fa3a76687c@oracle.com>
Date:   Wed, 11 May 2022 10:34:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] net/vdpa: Use reader/writers semaphore instead of mutex
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220511125845.1332586-1-elic@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220511125845.1332586-1-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21fe32fc-6d84-4036-6e54-08da3374796b
X-MS-TrafficTypeDiagnostic: BN7PR10MB2676:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2676D458AE01B15A3FEEFD41B1C89@BN7PR10MB2676.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U23aMhnYenclgwdLJ/gq5wVvtDEodK2FmwE8jhGEa893+AGWTI23mJAbWFzzYu+RIp3oZ3M/jZE49xr8kaseTKjnj0clPHNnCflghNzVMY14js3NttIre88B6FP+Z0EbCljMRF5p/dJvU24yneWo+XkHg4IMdbOeL2w+KZJW8P7PEDmrkHGID3jCNxD8tifUUoPyjqBZrXY7QxrkRyr+kAiDBQNT+k9f7On61KsV9m0XcPuqFFL8M6vomMzo94Mp+Uxlnh/Cgd2Tgr9rofjRfGx2Vq4vxEZTvBYlUIOE9bWvq0WwemK8qEnKDNLt9gsrTBYx7490ErVEPI8B1e9XRjqWwKehrhXTJnCq/yH3nufafnk/1xSUiCg/pFSYF/1Pf4Id3zkf5foKKS47yG2DLBX+DOXHZn70sjTZilLkl+JosY9pNsR4Z7dwiFuY2r1tCW+WpzKpKSRNd0o1J8VqIqsFnz/ndEkbsUn50O1oogwmGRv7FwALbCZTaVJ/mpUZYZj9vuwsj8dNadDGC8ANYSsu0butC2Zt8aEh6dfdWLy2eR15ad68KYrB0QZiZVirDq+zLb6G5kLN802INNZmSye+mTphakxflfV77T0h/Kr0/QGn350Pm3d8nNP3YC8kNGPxRb6NUq5Ngt0x2DpPAoYX6HL5oBWHCC7y1KjawWnOnOr2odYN+0XSpFd5Kj4hQBJKPSXQs8L5aoGE51rM2IZMtk2otqcAMo6y0zhLOhU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(31686004)(508600001)(186003)(6506007)(316002)(6666004)(8936002)(5660300002)(2906002)(38100700002)(4326008)(8676002)(66476007)(2616005)(66556008)(66946007)(83380400001)(26005)(36756003)(86362001)(31696002)(53546011)(6486002)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZ1VG1EZXk1aCtjNFhLbzMvNFBUazY3N0puSy8zSnpVdDZGenhwTmN2enU5?=
 =?utf-8?B?WVNHRjJ3emZYYThSdjlwTUVrelk0U3hRYkZtcEF4cGgyYUZ1ZnY5V0JLWjY1?=
 =?utf-8?B?YjUyTy9uOUV5dWk5ZitSUnQyTlNjZjBwZWJEMGNMMmlLV05rM0lSR3Rvcm9P?=
 =?utf-8?B?bS9ZcFJnL0tiOG51WjB0ZWNvdjgveStORFlGS3d3MFo4bmdiaXhTcWNtSHI0?=
 =?utf-8?B?VlFwMU1TdmVQZHREMXpyc1MrOEZRblp0MjdEMDErVWpNOURnc013TGZtM0Zo?=
 =?utf-8?B?VVE3cFhvL05uSjVjaFROMHNyNkE2cWJUZHhOL0Q4aytCMmErVjE1WkRlOVZw?=
 =?utf-8?B?OGlWOXNtZjd6bHBUSExFMTF4RFFWTHBlVmgwYVRxU29ud0dlb1F0MzJxYVdR?=
 =?utf-8?B?dGpaa3VmVTkreTREOFR2OTArd0dlTnl0RXRVZDEzYUlpSlQyT2V2dG15RGFQ?=
 =?utf-8?B?NnppdUkvd2lOekZnci9vR2xYc1JoNUZJcnZiQW5wSGVSMFNKZkhMUlFGcEFz?=
 =?utf-8?B?bktUVVpYMVQxeW5Zb0xsWTFXQjdJeFdCNFYrd0tCTHNCbDVsOXNJRHVvSWZs?=
 =?utf-8?B?NVlTVEFwdVNZdm8yOENzdi93RWMyOXhsUkxBbFVFU3g0T0JGTGoyWUplMUpm?=
 =?utf-8?B?dkVzVWplSW5weVdmdFZsMHU2dm5pNEh2bXR5Y1pSNDljRzVyamlQUnJmeGV6?=
 =?utf-8?B?RXpBcG45UTFxVXFkTWhFbExhR2d0ek9vdTAvbDFxQ096dm9hS0JlS1Ixamh0?=
 =?utf-8?B?VmQzMUloS1VSSkcxbHhSTHo1ekxtVmk5bnd3cFJwYUE0bW9WNUxlN3cvU0Y0?=
 =?utf-8?B?UlNwNEI1elNGaVNYOW84ak90dTFDL0pCd2c2SVZWekpEWWp3M3ZBczk0NzRV?=
 =?utf-8?B?WHZVQmsxa1lQNGpkTktMRDErbmZZYm5kMlplYjZFRnk2R0tLc2cwakpTUjRi?=
 =?utf-8?B?R2NNSXBBaFFUd3YxZTBmVSt5THRjUlVMZmVuaWczSUltMTRKZ3Y5cDdCbE9H?=
 =?utf-8?B?NmZVZXUwYTY1SE5wZjNlV1VwSk45eDJzUUZ5OFp6VjdJTzFpeVd1N24zRW1m?=
 =?utf-8?B?c3Q1cnZ0cFRjeWJjakdiRlJlYVA0THhtUUYyWWVWbk9PM0ErT3hQWDRISkI3?=
 =?utf-8?B?OHdNWEoyOEc5a0FmMGNya1FGU2NZSzduWTBVRVNsZ0dDOEpOazVaUlpnZmFa?=
 =?utf-8?B?c2ZEbXFoREROZjVjd2tzY0g3cTVhOHdiaUpIeWU2cXNva1craE82dm9GNGxt?=
 =?utf-8?B?a0RSMTVxY25YQ2hwMHQrNmE5MStxVyt5MVh6WEM4WVVIbkhrU1J1dkNFa1RV?=
 =?utf-8?B?NU4zditJQkpHUlhpU0RMd1VoOGR0UGtXT1pEZ1dQWTVyR0h0KzZra2xiWkRI?=
 =?utf-8?B?bzBaa1Bmci9kbC9yczVSaUNYQ01ic2t4S29EdnltVnZjaG9xc3BLcXExcm5D?=
 =?utf-8?B?dGlWMGhRM0lmbDhPQUJoTDRvUEJFdmRPcmYwM0JtNmhZREdibzF0YTU3TGI1?=
 =?utf-8?B?MHhrbjJFZXlmS2FDZnNGUzZXdXJIdVNBenlJZ2FHZm5Xak1pbnhNZnNudU5E?=
 =?utf-8?B?ZWp5eGptQjBOZCtJOTdtMmJzOUxsem1jcjI0TThmdkpoeEg3eUpmQk9vWFVH?=
 =?utf-8?B?Z2I1TEQzaTR4K0gyZG9jNENOOU1ZSEpiWXVJeFFNM3lkRlFnTEliSzh0TC9X?=
 =?utf-8?B?RHFYRjgvalZrclJPakRKUzlkVW9sTDU5U3hlN3hPVmRVVTd2eGxOYWVNU0sz?=
 =?utf-8?B?Nkl0L0hJaHJ2QUdhRjZYaXZBakpqTFJxcEpuelpsd1psWmlHck4vTVFnNjRE?=
 =?utf-8?B?TFFmdWFIdnhhM1hsTzF0ZnM3ZmF6d0V3YlpkeG9LaDdPVmhJUmhqWGlzREIr?=
 =?utf-8?B?eUZDNzZuR0txNDZiTmx3dWlNaEtGT1J3NVFnZGl3RWh2S2VCd2tYb2NndkF4?=
 =?utf-8?B?REQ1UTY4RUl4Um5NanY0czdYR2ZTT2Z2akZTNmpmUHIrdHRHVWhkRzBpbDJh?=
 =?utf-8?B?SGdlTHpRL20vYVZBT21XUVJKMmdaYUlQR3NrRGlvdGYvdFc5MDdmOVRNamdw?=
 =?utf-8?B?WXhlZURMOHpONXFVUzBpSThyZkYrMWdYMzd1NjN4dlFCUHRFRGdVMGJLWHZI?=
 =?utf-8?B?Rk9MZWFZMks1YjdtMlowZ2xnYWV5a0lSM0ZoSzBBOW94amtlZG56Z3ZCVmEx?=
 =?utf-8?B?LzVJYzVHVlErUXdZSUM1YVdSU2hYeFNKNS9salhiOGFJM3Jjb016MmlpZ0ps?=
 =?utf-8?B?VVV4MG5NRGZSQWppQzJ4ZXNxVGNNQk5aTitoRTZodDZsVXEvZ0JhV055K1Zp?=
 =?utf-8?B?YUZydjNNbFpxQ3Z4ZXdEd3crUTFsWE5NNFQzRzRTNHc0SVVrTGpHZzdYMmY4?=
 =?utf-8?Q?9p0e+OKXSx9f9R1c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fe32fc-6d84-4036-6e54-08da3374796b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 17:34:17.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+AAz3g3T3FVrZ4a4lzsYYx+OzW/+etMVgNZGQUfD4HVdzAGfRR1oXo4uEdvL689Md6ZLR0smXg+82jLD72kSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2676
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110079
X-Proofpoint-ORIG-GUID: zgAkksweUUdKcZUkdroj-EzzE2BlUs7L
X-Proofpoint-GUID: zgAkksweUUdKcZUkdroj-EzzE2BlUs7L
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2022 5:58 AM, Eli Cohen wrote:
> Use rw_semaphore instead of mutex to control access to vdpa devices.
> This can be especially beneficial in case process poll on statistics
> information.
>
> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
LGTM. It might be good to pack this patch into the vendor stat series 
such that the newly added vdpa_dev_vendor_stats_fill() may use 
rw_semaphore on top.

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

> ---
>   drivers/vdpa/vdpa.c | 64 ++++++++++++++++++++++-----------------------
>   1 file changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 0fb4a615f267..ced634f94f76 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -18,7 +18,7 @@
>   
>   static LIST_HEAD(mdev_head);
>   /* A global mutex that protects vdpa management device and device level operations. */
> -static DEFINE_MUTEX(vdpa_dev_mutex);
> +static DECLARE_RWSEM(vdpa_dev_lock);
>   static DEFINE_IDA(vdpa_index_ida);
>   
>   void vdpa_set_status(struct vdpa_device *vdev, u8 status)
> @@ -238,7 +238,7 @@ static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>   
>   	vdev->nvqs = nvqs;
>   
> -	lockdep_assert_held(&vdpa_dev_mutex);
> +	lockdep_assert_held(&vdpa_dev_lock);
>   	dev = bus_find_device(&vdpa_bus, NULL, dev_name(&vdev->dev), vdpa_name_match);
>   	if (dev) {
>   		put_device(dev);
> @@ -278,9 +278,9 @@ int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>   {
>   	int err;
>   
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_write(&vdpa_dev_lock);
>   	err = __vdpa_register_device(vdev, nvqs);
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_write(&vdpa_dev_lock);
>   	return err;
>   }
>   EXPORT_SYMBOL_GPL(vdpa_register_device);
> @@ -293,7 +293,7 @@ EXPORT_SYMBOL_GPL(vdpa_register_device);
>    */
>   void _vdpa_unregister_device(struct vdpa_device *vdev)
>   {
> -	lockdep_assert_held(&vdpa_dev_mutex);
> +	lockdep_assert_held(&vdpa_dev_lock);
>   	WARN_ON(!vdev->mdev);
>   	device_unregister(&vdev->dev);
>   }
> @@ -305,9 +305,9 @@ EXPORT_SYMBOL_GPL(_vdpa_unregister_device);
>    */
>   void vdpa_unregister_device(struct vdpa_device *vdev)
>   {
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_write(&vdpa_dev_lock);
>   	device_unregister(&vdev->dev);
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_write(&vdpa_dev_lock);
>   }
>   EXPORT_SYMBOL_GPL(vdpa_unregister_device);
>   
> @@ -352,9 +352,9 @@ int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev)
>   		return -EINVAL;
>   
>   	INIT_LIST_HEAD(&mdev->list);
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_write(&vdpa_dev_lock);
>   	list_add_tail(&mdev->list, &mdev_head);
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_write(&vdpa_dev_lock);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(vdpa_mgmtdev_register);
> @@ -371,14 +371,14 @@ static int vdpa_match_remove(struct device *dev, void *data)
>   
>   void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev)
>   {
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_write(&vdpa_dev_lock);
>   
>   	list_del(&mdev->list);
>   
>   	/* Filter out all the entries belong to this management device and delete it. */
>   	bus_for_each_dev(&vdpa_bus, NULL, mdev, vdpa_match_remove);
>   
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_write(&vdpa_dev_lock);
>   }
>   EXPORT_SYMBOL_GPL(vdpa_mgmtdev_unregister);
>   
> @@ -532,17 +532,17 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct sk_buff *skb, struct genl_info *i
>   	if (!msg)
>   		return -ENOMEM;
>   
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_read(&vdpa_dev_lock);
>   	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
>   	if (IS_ERR(mdev)) {
> -		mutex_unlock(&vdpa_dev_mutex);
> +		up_read(&vdpa_dev_lock);
>   		NL_SET_ERR_MSG_MOD(info->extack, "Fail to find the specified mgmt device");
>   		err = PTR_ERR(mdev);
>   		goto out;
>   	}
>   
>   	err = vdpa_mgmtdev_fill(mdev, msg, info->snd_portid, info->snd_seq, 0);
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_read(&vdpa_dev_lock);
>   	if (err)
>   		goto out;
>   	err = genlmsg_reply(msg, info);
> @@ -561,7 +561,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>   	int idx = 0;
>   	int err;
>   
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_read(&vdpa_dev_lock);
>   	list_for_each_entry(mdev, &mdev_head, list) {
>   		if (idx < start) {
>   			idx++;
> @@ -574,7 +574,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>   		idx++;
>   	}
>   out:
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_read(&vdpa_dev_lock);
>   	cb->args[0] = idx;
>   	return msg->len;
>   }
> @@ -630,7 +630,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>   	    !netlink_capable(skb, CAP_NET_ADMIN))
>   		return -EPERM;
>   
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_write(&vdpa_dev_lock);
>   	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
>   	if (IS_ERR(mdev)) {
>   		NL_SET_ERR_MSG_MOD(info->extack, "Fail to find the specified management device");
> @@ -650,7 +650,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>   
>   	err = mdev->ops->dev_add(mdev, name, &config);
>   err:
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_write(&vdpa_dev_lock);
>   	return err;
>   }
>   
> @@ -666,7 +666,7 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>   		return -EINVAL;
>   	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>   
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_write(&vdpa_dev_lock);
>   	dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
>   	if (!dev) {
>   		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -684,7 +684,7 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>   mdev_err:
>   	put_device(dev);
>   dev_err:
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_write(&vdpa_dev_lock);
>   	return err;
>   }
>   
> @@ -750,7 +750,7 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
>   	if (!msg)
>   		return -ENOMEM;
>   
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_read(&vdpa_dev_lock);
>   	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>   	if (!dev) {
>   		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -768,13 +768,13 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   	err = genlmsg_reply(msg, info);
>   	put_device(dev);
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_read(&vdpa_dev_lock);
>   	return err;
>   
>   mdev_err:
>   	put_device(dev);
>   err:
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_read(&vdpa_dev_lock);
>   	nlmsg_free(msg);
>   	return err;
>   }
> @@ -816,9 +816,9 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>   	info.start_idx = cb->args[0];
>   	info.idx = 0;
>   
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_read(&vdpa_dev_lock);
>   	bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_dump);
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_read(&vdpa_dev_lock);
>   	cb->args[0] = info.idx;
>   	return msg->len;
>   }
> @@ -1016,7 +1016,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>   	if (!msg)
>   		return -ENOMEM;
>   
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_read(&vdpa_dev_lock);
>   	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>   	if (!dev) {
>   		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -1037,7 +1037,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>   mdev_err:
>   	put_device(dev);
>   dev_err:
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_read(&vdpa_dev_lock);
>   	if (err)
>   		nlmsg_free(msg);
>   	return err;
> @@ -1075,9 +1075,9 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>   	info.start_idx = cb->args[0];
>   	info.idx = 0;
>   
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_read(&vdpa_dev_lock);
>   	bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_config_dump);
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_read(&vdpa_dev_lock);
>   	cb->args[0] = info.idx;
>   	return msg->len;
>   }
> @@ -1104,7 +1104,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>   		return -ENOMEM;
>   
>   	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> -	mutex_lock(&vdpa_dev_mutex);
> +	down_read(&vdpa_dev_lock);
>   	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>   	if (!dev) {
>   		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -1124,7 +1124,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>   	err = genlmsg_reply(msg, info);
>   
>   	put_device(dev);
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_read(&vdpa_dev_lock);
>   
>   	return err;
>   
> @@ -1132,7 +1132,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>   	put_device(dev);
>   dev_err:
>   	nlmsg_free(msg);
> -	mutex_unlock(&vdpa_dev_mutex);
> +	up_read(&vdpa_dev_lock);
>   	return err;
>   }
>   

