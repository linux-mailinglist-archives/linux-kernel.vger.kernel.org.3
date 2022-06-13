Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E5A549E36
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbiFMT5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243386AbiFMT5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:57:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5414D6BD;
        Mon, 13 Jun 2022 11:28:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DHnWek011713;
        Mon, 13 Jun 2022 18:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=3E3mFo5U9eJ04AMwO3fkVOI8KevRCRIZ7OPL0sSnj3Q=;
 b=ypRIKLKG4cy0BkfWcRVkhYXhBnz7NZEXvU0jCCwBScHVwQerQAkOEU9T2RA38KTC4KKo
 RW3WSegwCZkf6LoSSPufKgiv7iOACBujHAVgVRdKYlCeP6KlVxhVNfkJA7OyGJrgwy3m
 t4JGX4zDrm4ycyfFzi99LSyYhYZZBmLxVpo7T+soMGKjPPpSyK1YuZM3/NXjlyBEOsQl
 tByP0l8BURRMfTjZ5jnSscaqiy7LHtA4dRJYZa+HYPy7/4tvRbzncOdsNdF2f1s8hYqH
 82uy0qY9K5Bjm3daTQROpEv4ElOsdU3D2mUF5HBHV7N/c1Gx5I4nhzq0QxoRYGHTXwtN KA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9btje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 18:28:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DIQupk011535;
        Mon, 13 Jun 2022 18:28:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpah901yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 18:28:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU16WLfwSfrTtE7IzUVLnACIq3nRUIBJn0TjtpWHeSaOVT90PjXWOKRPB4RGCUKiBf7f8iQ2t+IYTX3oyXsdWz/gcEfanFcOYyEjC28+lE8AyYoHU3s0GLS8AJzKdMOVm0zWifiSuMOs5dyotPO21V+rdqFbYAvmhEghYWxTcCJSrvs0+RHuUZEGCt9X0zD18hfWUBETAmcxBs2NYNpLuXDzqB/r0lqPgw+vgofVWJbw1TJfhmrIPlF3aspW0sjrbkehFcSt4S+eiBNs1tmYb9mEmF8D5l5VHu1X24XdIZxw+oqal1MEvtUKWUZ7p6TLkdritFRWxYxEtZLw96g+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E3mFo5U9eJ04AMwO3fkVOI8KevRCRIZ7OPL0sSnj3Q=;
 b=fVvGMf9EU2xaIXQnhx9Z7BdTjKmcwZLN/op3mGRgxoqDiNTDoEV7OuBZn4AzWk8+/aYurmnJOETSL8JCPqx4H67xiIoesSsazdXoq3mkm4gaMubcJBarW8lYfqkMeJ5kooVwPhwejQL/ouk3hZEKQHPlQp3oX6HKWU2uBzfEGNb6hUTBD+Glw9NGZ5OXwb1YLhfnpQZMVGpOWUmM6vn+p3bYKJn4dmaKc0DcJS23EUDQFCmfJQXhxOmuVhqs7y75nSSOuoKlD1ajMENvoOtl5Mn8VDLVcnt+4nyW4uRXRX41nlBkwGVis/ZRWYL34zex+2VgtSE9Ex0Hb8V4nv04Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E3mFo5U9eJ04AMwO3fkVOI8KevRCRIZ7OPL0sSnj3Q=;
 b=ur8gIr+kOjL1E1IfWTzqOUydFhvVfTqfalqVvbQU2KsGcC3rNNrU+RGxPzm2vudxAWxzxAeQfBjolYWMgvHU+eQ2NhC/d8dQmCiSPQc6FS5NysN6yEzQ04PIosioIUbIOf77+PZSzs84wbKZNvbD3O2/YU72lAZAVJ8PDAgUWEA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN7PR10MB2641.namprd10.prod.outlook.com (2603:10b6:406:c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Mon, 13 Jun
 2022 18:28:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5332.022; Mon, 13 Jun 2022
 18:28:32 +0000
Date:   Mon, 13 Jun 2022 11:28:28 -0700
From:   Mike kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: hugetlb_vmemmap: optimize vmemmap_optimize_mode
 handling
Message-ID: <YqeBzNYrgFGqtfaj@monkey>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613063512.17540-3-songmuchun@bytedance.com>
X-ClientProxiedBy: MWHPR22CA0072.namprd22.prod.outlook.com
 (2603:10b6:300:12a::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f13c2e6-6b58-4a5c-d3bd-08da4d6a84f1
X-MS-TrafficTypeDiagnostic: BN7PR10MB2641:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB26417028760ECF0673586018E2AB9@BN7PR10MB2641.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+IoiwfwG4S4gS4vTH4W4BqX9vTZ3HPofkdjVq9+5la7utiRXRHsalAU128fov2djLxYwy2/+v3AQFyzCCeovl4kgd05zhTHPmDyu9xWMY+fJFK9s6/L2hHyH0AZ00dN4X96SGXlFjyfwrTsLqz2H0a1A+yNGgV6b9JC5Cu6rcbYnpu2v00P5Ja1RU+Tp5BVmx6Ex12ikERaA80dHXOBqyNUGAFPbj58T/d3iJwTybrbwKuTZo9bGmdhWc42alY8voT15gmc5QfNo2AYAXE6iuSdwoQVhrETcjzdyDl57QhiobxGWsrXpFFdyR+IHM7frjcsswwyAd1kjbfZ4vIR77ftXGvMCFB4oyXWoJzAXS117sUE/3WW4lveNjydk1VLOJP8BOyQrK7Vrob6RVBVG9ydWOCwKjy0KP85xB8MIzViEr+M5SIGrf/ZgbENas2Vst9Vbt8MqOZklEFY8s50qpc6JAEcX4AZWeB/wRSEsabBpDKMhBLSDMaleDvJ0noPQM/2A7HD6kP1QCIvc4CCun5mOHTUQzH1/C72bNSiGGHz5HDu/l0D6epPtFy9LHdssXA2U/SYphI0fpWcXGk80kwfuv/BaSMDhkL9VzRd01EROuEGVq80iHOUYqyD7w2/75k2w6NCpofuF+d1079rvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(6666004)(33716001)(2906002)(508600001)(26005)(186003)(5660300002)(9686003)(8936002)(6512007)(6506007)(86362001)(6486002)(38100700002)(66946007)(66556008)(6916009)(316002)(66476007)(4326008)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJDSHZzQUtjei9VNzFpRzVlaEdZU3F2NjdHK1J3OW5TUkNKVWZSdElOZFJ6?=
 =?utf-8?B?clZkLzROaXFyc2pRdHQ1cDFScW9tSUxWYXpaRFhMRGlyekNmcE0raEphRUlr?=
 =?utf-8?B?NUJOTUpMTGJtNHorK1dyZk9xUHVhVVV5VnVPZmNPaUpWemJzUkZ0TmQ2OHhq?=
 =?utf-8?B?Qm9HdmQxb3h0YXNsZThYRkZjTUxWTm5pUlJONWJhQXNZeG1GZis1VTczYWZm?=
 =?utf-8?B?MXUvejNicjd5K0t5Lzk4S1p1WkVCdVkybDFsOUdDcEw5dUtwY2luaDFzWUJV?=
 =?utf-8?B?MWlYSkhBVU5GSzVmNytzREpyMG9XZnlXWDNtUUdsWHdaMytPNkNheE0rTDNl?=
 =?utf-8?B?c1JadkZUUHhwZVNSQ0ZmaEowV2RzVkVwSmsxRHFmTHE2c3NFTGZjQnJpeWUx?=
 =?utf-8?B?UXBQejNibG82WUd1Ynpha1cyTEM0RDd2MXVIZ1V6M3VvMEx0REMrVStLZ0xZ?=
 =?utf-8?B?dm8zV0RLdnBEc1RERXpWWUhUdHJtTjFGNUlwd3kxNkFLbW8xRVV4VXpJdEVQ?=
 =?utf-8?B?MmJvbWRqNmNXQy9CODB2bjdTdFZLUHU4KzgwMWxiQ0QvQzl5WHoyaW1DVUIz?=
 =?utf-8?B?VkhOUjU0M2s0bkxhbTI0Tm1WQUY5VW1JVTB1Zm4vOFkwdEY2QUR5Qmc4QmVl?=
 =?utf-8?B?QUp5OWhxVmlaY0RkalloRmE3dW1acngwMm5LNVZ5aTZHckF3VzcxWGEvcGRT?=
 =?utf-8?B?ZFpUNWsyRFVncjFtUnR2ai9FV3hRUk9jR3JHT1lsWmNsSVE2Q3ZWcWM3dVVE?=
 =?utf-8?B?bmhaUlVFT2NKMCtzZ1krc1NXQXEwVmVHSkRtRExtVDRJK21BOXZ4dzhOYkZ5?=
 =?utf-8?B?a2swWDdRV0d2QW16aUUyczBYSFVXWnpXV2pwdm9nUlpMb3BzYzFIR2Q2V0tD?=
 =?utf-8?B?cWI3c3hvWjU5ZFl5VXBiZlF4dmhKZ3k0SjYreHFZbE1LN0FsM0hSdDh6VFAw?=
 =?utf-8?B?YkpOYVc1enRjcmthZ01jbld2anlDc05pS1NoUDB1VkxwUU5mbU1wdi8xcjN5?=
 =?utf-8?B?VEg5bTB5NjlWaGVUSWN2UHhYU2VWV05qb1ZLa0xHNkRuRDBHYU1UdFE0ZFRW?=
 =?utf-8?B?NFNKVTg2RnNkRGtINXFJTGdpYVdwcm5JaDJXOWZMVENCM2x0ZGZOYlc3K1Nw?=
 =?utf-8?B?OStqREdCUytuQkx5VXB5Uys2dDdMaUNuaUx3M0RPUC9URHAwWXY0ZnpzNFo4?=
 =?utf-8?B?STMramhtTVpFNXdjekJNQUkvWUVHbGRCT2NmdXRpU2xhcENNdEV1RlVPLzZ5?=
 =?utf-8?B?eFU0ZEord3YwWGlQSGIvOHhwUkxBTW53Z3BSanhZTWEwNDZtb0w1ZFEvK2Zx?=
 =?utf-8?B?Smp4RkhkSktTZUdYRHd5akRoSG1lMFMycHdTSXlWT1JXUzE4dGNNa2RiWTlW?=
 =?utf-8?B?QitkVmY1eXhFVlFDSzIzckMyZ0tQRzAxUHVBZXhpaWRCYVN6UlkzVzlYeHY2?=
 =?utf-8?B?c3lNVDFKb2JsT0g5QndiL1NHR0NxSzdVUnhNZ050UUNuMU05RmI1QzJHSjJM?=
 =?utf-8?B?endveGxDYlRzYW9nYk13NDV0Z0VSdnVXRXd4NVI1Ylo3WVVZbmQxaE04ZWdF?=
 =?utf-8?B?dWQ2VjhmMW9OWDNlY2l6UUVTaGlVUHJHckJyVnVueGhRYUZDbWxHaWZZNFdH?=
 =?utf-8?B?K1Y2TFlyOWpWY2s5dTJoNXZvWThMRENRNTg0S0VOR2dhQ1Z5NWRRWXJxcUNN?=
 =?utf-8?B?WnpzdGJOZ1JDbFQvZFEvRERqRWdyaG1pYmhHcTA0cjJ4cTVINkVYTlVCblZ6?=
 =?utf-8?B?bytKQ29NbzVETFk4TTJrcFBObThYaU5DYlhSdGRSU0JwZlpUNVI0elc3bXBa?=
 =?utf-8?B?NTg2bGJjZ2VnbHBYay9vSXVmaDhNeDZRSkJHZSs5SHVYN0ROeTNIb2kvTVh1?=
 =?utf-8?B?bTlsVnExNnArcXJHNGlRQjV2V2E4blZhbFVINENUdWEzUXByLzVLU2J4WFhh?=
 =?utf-8?B?N3V0V1BPL3FjS2o2aFA0ZnBYQ2R6dXVmRGpsVW9iT3NwL2xOVFZ5OUxMd21x?=
 =?utf-8?B?NVRrTWtFcFFGaXNHUExwc2tTZzNrU1VubjdySkJyQmNXT1hlTTB1VlJOcHp1?=
 =?utf-8?B?alMyMk5jdGltVEg2QUlBSDFWYXYvemhjYVIxckdVSmZiUXc1UmZCRGxMQVJX?=
 =?utf-8?B?Skt1MkcrZUJia3BOQXhQU3praG1hUFZjVXAvMGIwOExDZmFacGY5djE4MW1u?=
 =?utf-8?B?ekdCRnJIdDZRb01CNUdDalpEVElQcEVPNWtDSHZEL3NCY0hLbHZwakFKVk1X?=
 =?utf-8?B?R1g4eXZMUThaeDB5YjBGMEg2WThMdXhyT0FucTNlTGhVZmdsL0pka1o5NmpZ?=
 =?utf-8?B?U1k2UGVQUWZ6bmRqRkVNdU54azVrSU8rQS9vN3FzYkZqeFN2azBEMjRRVzNm?=
 =?utf-8?Q?zt+7O9Klag707lmk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f13c2e6-6b58-4a5c-d3bd-08da4d6a84f1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 18:28:32.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+AYFU2b5qQxwcCsajf02zP9pdhKlpf8Z7Yw14LMh3enOy7JkPlxd7rymDoxBckmqyRoYF3vFdfGYc6CxOtadQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2641
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_08:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130078
X-Proofpoint-ORIG-GUID: BRX7zyKQ22yXFOL0oiGCqEGE0GMlA-wu
X-Proofpoint-GUID: BRX7zyKQ22yXFOL0oiGCqEGE0GMlA-wu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:35:08PM +0800”, Muchun Song wrote:
> We hold an another reference to hugetlb_optimize_vmemmap_key when
> making vmemmap_optimize_mode on, because we use static_key to tell
> memory_hotplug that memory_hotplug.memmap_on_memory should be
> overridden.  However, this rule has gone when we have introduced
> SECTION_CANNOT_OPTIMIZE_VMEMMAP.  Therefore, we could simplify
> vmemmap_optimize_mode handling by not holding an another reference
> to hugetlb_optimize_vmemmap_key.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/page-flags.h |  6 ++---
>  mm/hugetlb_vmemmap.c       | 65 +++++-----------------------------------------
>  2 files changed, 9 insertions(+), 62 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b8b992cb201c..da7ccc3b16ad 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -200,8 +200,7 @@ enum pageflags {
>  #ifndef __GENERATING_BOUNDS_H
>  
>  #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> -DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> -			 hugetlb_optimize_vmemmap_key);
> +DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
>  
>  /*
>   * If the feature of optimizing vmemmap pages associated with each HugeTLB
> @@ -221,8 +220,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
>   */
>  static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
>  {
> -	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> -				 &hugetlb_optimize_vmemmap_key))
> +	if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
>  		return page;

This also means that we not incur the extra page_fixed_fake_head checks
if there are no vmemmap optinmized hugetlb pages.  Nice!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
