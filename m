Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331BE52AEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiEQX7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiEQX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:59:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061C73F882
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:59:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKTuVE012482;
        Tue, 17 May 2022 23:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FWw2+RNjJILEsSwAxf34p9im2j6gjsfW0imWrLzyZ2k=;
 b=FjU+qDPlAf4MqMgzasb3edo4JqiGkG2jHPwvCn5HnHqFI58TiPNo+o0QBZQb4yhu4oPG
 c2jun858yMeMuXoJ8X95jW5CqE0H9KqzCLjl6nhi9qX0B2tzv242HoegZngSdFExJJp0
 VFTd+On17PucO8UhUb1vUihB9c6udUw3QaFqhS+xL8qauXXw6Qxroafo+mmHygdngCJJ
 4ditiOcZhxrc+JR0QJgmw8RqmFvM94Oo4Z4R3ZBRh6YEVjOxnH/Gt0lroIgKvDQZCr54
 0HzGxp/z6YVz9zcr4YTPFxg1nzEFwPnxPx+KNq9tdgGkfFBJFoHyoKMtp80dJCAY7HuP 7A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytqune-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 23:59:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HNtmpa027940;
        Tue, 17 May 2022 23:59:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v3r63a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 23:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRcwfTj5BrRAZDoHFtTp7qxZNuUmjlaS1xNTLKsCs4plkw2yYvouex6Tc6Wap6ajNvPfn6oyR28QLSmFY5LROIXZIf0fbMA1l6xe8OCPrvH7CCQPoSA2ViRuCkWttl5tkWB61iUq/3fkbGmqDTviSyMke0Htth7EHTDaKucLTIi1/QJaKHrbf81lkFWnExbt1nDR/lYXS3ZYbOxv150S2poeZlzt5y5tyw4L+TW6Bswxbu9OH7Eu9VS6NHaIcERFN0m1AMeRkvfJWmN0hZWFlH71oUO1ORuTtxutupUP9GcsOriMx206YprhuWb0/JMhUuJeE3Ajg+xkmdbhADyVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWw2+RNjJILEsSwAxf34p9im2j6gjsfW0imWrLzyZ2k=;
 b=MNFTDkff64e2upSNfsWfP4SKV/839Lq4BHZyHSbNGFotlkM3+TnBGHIlHbxUxt8MUA357ayEEyfmcbTBAR5w08erafQn/j+pU49ZTznX+/Ic0Odlu/Ok/CYFEOJuLe7UAB89ifumORLLDP3Jza11GOjmbAntvi/5WlVbC/0JfTLWzd2ubXjFj2lrCtJTENT3sm+fJkA22yQA3u86xKKI7sAyI5SCJBT7S+5hsqJ9XPKNmfnoacw/xHHdAWVdcplymGA5UcNJYU3p4CP3aLWK9waDdYv7EKL0SsQ73Qy5jhj5DtKGuKmXBHmSgRlswYJquSJV4Y9pNLMhQTOtzjbCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWw2+RNjJILEsSwAxf34p9im2j6gjsfW0imWrLzyZ2k=;
 b=jho2Fhh+j3ckv35mwGZ+eYSwSukob+7ZFs19BWqy8KrChS3eaz/0kx3REzHSmMmcZFkvrJCsDicVMX5eFEh1TLcSZiUVk3DWs5gzFHNCfPxbcpavMDPLUAIBTea43LZcQo5afjhYiK+m6reC3dTu9cpjlbwHI3BQ4yVPMX7Z2fU=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB3859.namprd10.prod.outlook.com (2603:10b6:a03:1b6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Tue, 17 May
 2022 23:59:02 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5273.014; Tue, 17 May 2022
 23:59:02 +0000
Message-ID: <7a5c6eca-c9dc-a663-feed-67794dc6116d@oracle.com>
Date:   Tue, 17 May 2022 16:59:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 5/5] vdpa/mlx5: Use readers/writers semaphore instead
 of mutex
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220517131348.498421-1-elic@nvidia.com>
 <20220517131348.498421-6-elic@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220517131348.498421-6-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac933984-02be-4cb8-ba09-08da386137ac
X-MS-TrafficTypeDiagnostic: BY5PR10MB3859:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3859DB4C18B44616E71B0EF8B1CE9@BY5PR10MB3859.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6ShRdu9SMYaBZ5LX0v8gjIvCOrPC5YEw0j60mSArlKS+TTuBkgvIpOUJYZRdf058nQwi7cybLn3g9VLmGLrmqUyGWpXL4M0yJFuHLjsv0KwOGXeQCxxfRK+o+7q9ehi1jmuPhAFEP2wnVk34p/I/xMcZdC97iPilq1BKqBreW/8cRB7ycLhu218VLZcHfa5tzcNn0MyVuAt1yjgXjd/qxuc++cIbIYfK2umSUq6fyl3AgZM4cbnAptloirPKfBLQPg+vSwJnBNsGBYF0iMTwNj2dUjOFHG6+HYB2RpcyrPmsyG3NFSFevqRBs4P8D4mjI9U4DhJaZnKNv0OGSlbtxvslUlGGeU3hbhLqcHd8AOp4arCGyU1iaYh0ZUiBqE7bYbfQrcqiu5JJV81zr0rIVfNC6pj8BXUwdbpGhYdq9X8qms/qHedJRxGVKFIZIa5mW7Y4/BCoJiR63dmm3HbZvJ5gawd1GNkdSXsn0d5GA+wBUASx48qu8HV4sZ0TynI8WyL13LbvaxAJ4CrdfBkx8mY/ul/BRO7w68eYn/ndXEfJBwiv/30q6ao/xVuY4t8gxLZnQQxOo82ma7FknTb5bkr+0epEC4Cud7KDyZ9ByMJkWRT854jnotF/USeHxn6In47i8Oku44X5LHWMsdLi83NEpd0tHh+klu9oXLWoeMZD7IpD6tNzyurZlCw92/xn23S62d6WDYlEHuCB+bJP6PSd4mYPwV7wC7GDwXfPvp/nW7cXyiMmAqzQ8Ph67cL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(8936002)(8676002)(5660300002)(508600001)(2616005)(66946007)(4326008)(36756003)(6486002)(26005)(6506007)(53546011)(86362001)(6512007)(38100700002)(2906002)(36916002)(31686004)(83380400001)(31696002)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVpnZFYzYmJ1VnJ0OGhmOFpFbjkza2ZvMzlEazNwL1FHUnd0dDRWc3h2MjND?=
 =?utf-8?B?eG1XSUdJTTFOSHRDZ3pwSFVTRFgwcFNqelFOQWJSNjFhL2tMUXJEamcwbVc3?=
 =?utf-8?B?MmpaSUxwdVhYd0Z2Tytnd1ZhcGlxU1k0elp0NHpWazUyS0MrZ25ZZUV4NWlP?=
 =?utf-8?B?cjBwUWZwbTQvSExnSWhubk91Qm1FbVVMSE5TS0lnUWM5dGo0VUlndmRjeHR4?=
 =?utf-8?B?VkZSdEIrQ3RHQWQwUkFGeEkxNGNUb2p4eWY0VGYvMHljTTJRM2pBMSt5dW5Q?=
 =?utf-8?B?WmVrNGtqQ2JnVUZFaENFbFZvZUVtZzJKWlB1d2VWVjFyRXlNd1JRR1JPY2xa?=
 =?utf-8?B?SGRxWWk4SjgwbXFrK05obGQ1cHFQR3lvM3RjUGl6VjBDdmRld1dsSnhvczhl?=
 =?utf-8?B?MmlUMWJGc3E2MmNEQ084bzJMcUswdzFMZVFJVmIvdWlDcW56bGdSSzlFVHdu?=
 =?utf-8?B?VFVIZllUR0RwbVNIVWpRcFpsdkNtUVlxbTJvS3haYi9vaGZLallDMlRHdWZW?=
 =?utf-8?B?UXpGWU5IQzdpV0Z6anYzMEVwVC9ZakJLYzhDMEppYzNkUFJKcXo2aXdrc0Ev?=
 =?utf-8?B?cGM4MFE1eTdyMnE1cnZrYkdwR09xVVREUlhtQnlHQUtLRjJXWUQrd1dzOUt2?=
 =?utf-8?B?aTJKdDJJVlhZdXZNTlBWWmxURG9wMHJuK3ZPUlhxVnZ0TngraE5CYmVXVE54?=
 =?utf-8?B?QnNsaFRIdXdkV29yNlpVWlFvcWMxRS9HcWEybU1PdG8zZ3VIR3FsOEJzU1RO?=
 =?utf-8?B?M1F1V1A1dWJXRVBGWlN2OTZGNTNWZEdZV1RYdExQd3c4eTVJQjFPVXBNNzJn?=
 =?utf-8?B?Y2t6NkRpNTgwNWpFZm1KeUk0QWJJSlUyZjhibWxDYUthRmJJbnBkSnEyWmdK?=
 =?utf-8?B?a3hDS29WYjBJRlRmTHByK1JSNVNyTWNUa2Y3RTRoMHl0VU0xNFIwOTF5dXFs?=
 =?utf-8?B?VjlEVDg0KzdwMjZaOWduQ0YxalYvRjJUM1hCSE9aaWUycnl6T1lDSjZFc3J4?=
 =?utf-8?B?a24wRzAxRysxZGJPRWdZSUpEdmhiTmpaRUZZdW10UUZFc2JiSXRCYTFGV1h3?=
 =?utf-8?B?TitaZ0REZUJJYklhZUJJdmladDNhb1FRK0xSOHRWY2Nub1lmZ1ZxRFZ1MnVu?=
 =?utf-8?B?MjVqN0pkcW9kQkgyZk9QTlh4dVpqaUsrL1BGNUhyOEIzWFlQMytDNWU4alpi?=
 =?utf-8?B?dnh0dFR6Z0srN3AwdDZhWVUreHBZeXdXaGFMMS93aEVQN2g4ZTAxdklMTUt2?=
 =?utf-8?B?SnJJTTZEVG05T0I5dlEvdXV5OXdnL2xQVWNmK2MyeFVaeUhWOXRSenp4ejJF?=
 =?utf-8?B?dHpLVlNxemVHZmtmRXJNandLOGd1RUF1WE51ZlBsR09taUg5VXpKYzZERjRM?=
 =?utf-8?B?VFRmYkNibGxWd3hPZ0VmK3R4ejVmQ0lQbllpbi9wMVMrQzM3aUl3UU1mOWRn?=
 =?utf-8?B?cnhSRCtqdGJDL1ErY3JVdTl6QWtvY0UxNDlKNVhobGpROWxRWjJ3SVdEK01x?=
 =?utf-8?B?MnlVeUkwanJNUmVpVFFFQ0VOWStaR0FrbjRrKytMZUh6T0lKcnprbkc0Q1Rw?=
 =?utf-8?B?YXV0MzVIbUlsNzFSRjZOZUUyd3NJaGI1WmlVdHduVHdZOVVVcXZrZHcwanN5?=
 =?utf-8?B?eVN5ZEhjR0ZQYWZCREFvdW5oMWJpQkF5ckhUWjBXaGhkanlVenFSUE5qdUxY?=
 =?utf-8?B?UzVkb3ZETURyWUN5dXhUUGI1S2J6NnUvR1Y1akZhekFBcEZ5WkJsZVMwTzhJ?=
 =?utf-8?B?MEk4N2pzcUVIVTJKQTBvL0VjY1BEVkNYZmtjZXZvb1gwSW8vQUprSUkwU0Nh?=
 =?utf-8?B?K3JWSk02Vm5YSlRJdUR0aitxbGZ3RWFXR05HclJGUUoySG1XVmZxM1NiSXNC?=
 =?utf-8?B?WWQwQU9jVTBILzRJckt5eFZ4Y1Zka1c4cnAyZ3BUNjIrSWF6alhDN3dpMzl4?=
 =?utf-8?B?MW9CVTVSVlB2V3NTQVJreGthRkJDZlFvQVEyaDVDb0Rrbk1YRi8rRjUwLzVN?=
 =?utf-8?B?MDFkTlZmS3hBeEEyZ3VpQkZpWkxiVHBSRno4QUpVL2FTVmdSRlltSkgxMGN6?=
 =?utf-8?B?TmlaS2g3MmR4dDZJeWFMM1BCamZpMnBKRG1KV0JGWWhqeFBEUzZvSWlYa3Uz?=
 =?utf-8?B?US9VUkdObmdudUllTEJHeUlHUDNrdGMvbTZsMEpUWE1uV2JWM0E3WWExZjhx?=
 =?utf-8?B?M2MwWXRjZGlRQmhTMERQa3JJcHFVbTF0UFZNVmp4VnJSekVSWGxWWmlmNkhl?=
 =?utf-8?B?ZUwxSGNlZllycHhpd04xL1Z4V1U2aGJCTG02OUNZMjkyeXpWVzN2NTd1c0pw?=
 =?utf-8?B?enFIakE1K0F5RnNybHhtREtlbGhTKzZIRlg4enJza3MwclNGZFFlOU1TdzBi?=
 =?utf-8?Q?yy4aCak9cFXN+JwM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac933984-02be-4cb8-ba09-08da386137ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 23:59:02.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu5TZ0k+Z8tEix6Zj8XAzI+qzEV7N4IX9mi5bHTEP+oP72o25ZOEEQvtJmbZl8klEKvPqXhXR+5ViU8Z3Tr4+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3859
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170141
X-Proofpoint-GUID: X6IU7u5HPh7QrLPollnYwMofUOir_Hjb
X-Proofpoint-ORIG-GUID: X6IU7u5HPh7QrLPollnYwMofUOir_Hjb
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2022 6:13 AM, Eli Cohen wrote:
> Reading statistics could be done intensively and by several processes
> concurrently. Reader's lock is sufficient in this case.
>
> Change reslock from mutex to a rwsem.
>
> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 41 ++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 2b815ef850c8..57cfc64248b7 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -155,7 +155,7 @@ struct mlx5_vdpa_net {
>   	 * since memory map might change and we need to destroy and create
>   	 * resources while driver in operational.
>   	 */
> -	struct mutex reslock;
> +	struct rw_semaphore reslock;
>   	struct mlx5_flow_table *rxft;
>   	struct mlx5_fc *rx_counter;
>   	struct mlx5_flow_handle *rx_rule_ucast;
> @@ -1695,7 +1695,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>   	ndev = to_mlx5_vdpa_ndev(mvdev);
>   	cvq = &mvdev->cvq;
>   
> -	mutex_lock(&ndev->reslock);
> +	down_write(&ndev->reslock);
>   
>   	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
>   		goto out;
> @@ -1746,7 +1746,7 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>   	}
>   
>   out:
> -	mutex_unlock(&ndev->reslock);
> +	up_write(&ndev->reslock);
>   }
>   
>   static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> @@ -2244,7 +2244,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>   	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>   	int err;
>   
> -	WARN_ON(!mutex_is_locked(&ndev->reslock));
> +	WARN_ON(!rwsem_is_locked(&ndev->reslock));
>   
>   	if (ndev->setup) {
>   		mlx5_vdpa_warn(mvdev, "setup driver called for already setup driver\n");
> @@ -2292,7 +2292,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>   static void teardown_driver(struct mlx5_vdpa_net *ndev)
>   {
>   
> -	WARN_ON(!mutex_is_locked(&ndev->reslock));
> +	WARN_ON(!rwsem_is_locked(&ndev->reslock));
>   
>   	if (!ndev->setup)
>   		return;
> @@ -2322,7 +2322,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>   
>   	print_status(mvdev, status, true);
>   
> -	mutex_lock(&ndev->reslock);
> +	down_write(&ndev->reslock);
>   
>   	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
>   		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
> @@ -2338,14 +2338,14 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>   	}
>   
>   	ndev->mvdev.status = status;
> -	mutex_unlock(&ndev->reslock);
> +	up_write(&ndev->reslock);
>   	return;
>   
>   err_setup:
>   	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>   	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
>   err_clear:
> -	mutex_unlock(&ndev->reslock);
> +	up_write(&ndev->reslock);
>   }
>   
>   static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> @@ -2356,7 +2356,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>   	print_status(mvdev, 0, true);
>   	mlx5_vdpa_info(mvdev, "performing device reset\n");
>   
> -	mutex_lock(&ndev->reslock);
> +	down_write(&ndev->reslock);
>   	teardown_driver(ndev);
>   	clear_vqs_ready(ndev);
>   	mlx5_vdpa_destroy_mr(&ndev->mvdev);
> @@ -2371,7 +2371,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>   		if (mlx5_vdpa_create_mr(mvdev, NULL))
>   			mlx5_vdpa_warn(mvdev, "create MR failed\n");
>   	}
> -	mutex_unlock(&ndev->reslock);
> +	up_write(&ndev->reslock);
>   
>   	return 0;
>   }
> @@ -2411,7 +2411,7 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, struct vhost_iotlb *iotlb
>   	bool change_map;
>   	int err;
>   
> -	mutex_lock(&ndev->reslock);
> +	down_write(&ndev->reslock);
>   
>   	err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
>   	if (err) {
> @@ -2423,7 +2423,7 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, struct vhost_iotlb *iotlb
>   		err = mlx5_vdpa_change_map(mvdev, iotlb);
>   
>   err:
> -	mutex_unlock(&ndev->reslock);
> +	up_write(&ndev->reslock);
>   	return err;
>   }
>   
> @@ -2442,7 +2442,6 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>   		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
>   	}
>   	mlx5_vdpa_free_resources(&ndev->mvdev);
> -	mutex_destroy(&ndev->reslock);
>   	kfree(ndev->event_cbs);
>   	kfree(ndev->vqs);
>   }
> @@ -2527,7 +2526,7 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
>   	u64 completed_desc;
>   	int err = 0;
>   
> -	mutex_lock(&ndev->reslock);
> +	down_read(&ndev->reslock);
>   	if (!is_index_valid(mvdev, idx)) {
>   		NL_SET_ERR_MSG_MOD(extack, "virtqueue index is not valid");
>   		err = -EINVAL;
> @@ -2566,7 +2565,7 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
>   
>   	err = 0;
>   out_err:
> -	mutex_unlock(&ndev->reslock);
> +	up_read(&ndev->reslock);
>   	return err;
>   }
>   
> @@ -2835,18 +2834,18 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	}
>   
>   	init_mvqs(ndev);
> -	mutex_init(&ndev->reslock);
> +	init_rwsem(&ndev->reslock);
>   	config = &ndev->config;
>   
>   	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>   		err = config_func_mtu(mdev, add_config->net.mtu);
>   		if (err)
> -			goto err_mtu;
> +			goto err_alloc;
>   	}
>   
>   	err = query_mtu(mdev, &mtu);
>   	if (err)
> -		goto err_mtu;
> +		goto err_alloc;
>   
>   	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>   
> @@ -2860,14 +2859,14 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	} else {
>   		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
>   		if (err)
> -			goto err_mtu;
> +			goto err_alloc;
>   	}
>   
>   	if (!is_zero_ether_addr(config->mac)) {
>   		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
>   		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
>   		if (err)
> -			goto err_mtu;
> +			goto err_alloc;
>   
>   		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
>   	}
> @@ -2917,8 +2916,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   err_mpfs:
>   	if (!is_zero_ether_addr(config->mac))
>   		mlx5_mpfs_del_mac(pfmdev, config->mac);
> -err_mtu:
> -	mutex_destroy(&ndev->reslock);
>   err_alloc:
>   	put_device(&mvdev->vdev.dev);
>   	return err;

