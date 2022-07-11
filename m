Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF3570C49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiGKVCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGKVCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:02:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86831F639
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:02:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BKNse4022860;
        Mon, 11 Jul 2022 21:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=BvoiwAMeddH8a0i3Cquk8kIH6sScGh7vl5k7hVG3n2w=;
 b=WBeY+mE/Hm9kNBap0e1gNhhqxZt6Js0//ycUfFxvC+AzU8H6in2wL9k3e3w6aFmVbn4r
 uf3/Kw6dAasyDUgXWooPYugHWLtbXouqO8zyaWgArY43ZSzVUTGsxUER+eTmeGlUVMzV
 uXhNNMA8CnN435KzeE/pMgu/vBJyoNi8qRWnD7wHZDcETYDCS5rV+qUrCIR0kJNFOJBw
 NE8YZuBjIrH/pegy6tXXXB0vZKzuccrYwFSBu5dz1RNx5jrvxr7YEtrl0aUPqL07u45w
 EC6f5lMAPOyWskr7vO7hfXRvVBIS3Ass92ARTdh8psQGzVNTFJM1wkKs7N9iZpJWSJzp 3g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727scu28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 21:02:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BKoYOZ009161;
        Mon, 11 Jul 2022 21:02:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70429j3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 21:02:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgScF4OeTp7v28ogX4d7VNpULidLxTYHV5+s1E2F+PL4sNcIbwgc71Sx0YcGMxF9nFTBXIObd9emrjryKw22Z7T2jp6YGOwimUSsIgylavfvb6w5AJWKMU5lvfFz5Ez7kqygvf3c54rDsIQe3lyBP/vldh896C1mHVTdUeTNvFTC4oi/ee8WrevO7Kw9wQTc5alwXFeHfBlytcnkdQzkrMTEtDesQb0SdWCGJsfpmIIfmyQCVQoEWXedu0pFiQ1u9UPDKWFCmVz/IVWOaoRGRp9FvSDvWCMKikFFfmsIywZY6yaVUaqSmD+z8tvB85wQlcdG6WQ5nrWuZYbm6gHMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvoiwAMeddH8a0i3Cquk8kIH6sScGh7vl5k7hVG3n2w=;
 b=OWeN+jWYYajA7y2ZBdFOUeiCwD4xRgwniqjar7wG82bdigWi0c7Bjpt1uK4fZyPUQoBX8yFIcAG9Dse50mKaioI4MoVLll3b1SymGje57sLkhSCJOgcRBFXO8SMZ2jUSBvvegJ+T+MNvAAadcE1uGvsO86iiQFssYSO1MMDjewOT6o5zm0oHisHsGI8gs3bfEQcZjsKUrzH9fqgrydFI2RNOCDPMH0Lb5A3ARCdiOFbhTXwQc/zeiL46shkljwWIvV6YRbQ9d19jwVSou9kysMJtgmaIJkcgGuEcXX0Fq9u7fRyNIb5KlImU7/YoH+dRJJ5fOd+UJwm+mAgGCaPBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvoiwAMeddH8a0i3Cquk8kIH6sScGh7vl5k7hVG3n2w=;
 b=G819U7UOblpZ08reZFy1CiCMER5w+6D44CrB0YR1AUXU7XYlpvO3L2IeouM1oo3PJkVVVgmEu83wnUgvn/RbBIlNpljjzsIdozxnMgOnh5FY2BKaUE/i8lWTQuhv2TvqvaltfyD7dnRjY9/qY2KwjIplu7rGP8GsRDRCOKV23dM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM5PR10MB1562.namprd10.prod.outlook.com (2603:10b6:3:8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.25; Mon, 11 Jul 2022 21:02:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 21:02:21 +0000
Date:   Mon, 11 Jul 2022 14:02:18 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: fix memoryleak in hugetlb_mcopy_atomic_pte
Message-ID: <YsyP2h/zIwJhp33s@monkey>
References: <20220709092629.54291-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709092629.54291-1-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01868f77-c4d1-483d-af53-08da6380a56f
X-MS-TrafficTypeDiagnostic: DM5PR10MB1562:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwLn+Ym1/OTaLRauKJkE8zuaeFXAfQGG0GF1bn+vEsIPsnXX8KZqB7eKTNdDjvJ5eB5v1lSEeE1R+CZBT0X5H23IMkEhwWlJW7iiZGRAdbvVu3oq5p6vNEeMzw5erUWmRK7k+sUP80WpPYo8YUCDaGfcYyUphunR2v3diooV6CKxdYHOzI8bnqfrVMGKz54sfQds/FaNsEfYgBBaAwc7diAP+y07cEwGSvcrf8Np4R6FsF/F55QDUX8UaP94SpP4J0izAlkJ9YDm/O3jqT2uQLiqt6J4I3D/x2D49QJ+KK3y6XtP1iWdeChN7twNQE3kLLrujeK9uOQOAk8eJNJwqI85ELboPzK3HQrlOAHYoWJ+vsDQXCIa/tnvLuixgyvmhMfQulsaH/HzXNZpwbjWN9+QVJOrdiTx/lMgOxwaAEXLFmzKPAuCHEjvA3o0QfZGn3Hw0n3kB38Z/R9VgDpB/uceFCVDeta38zE8gYVTaI1iP/et9lP4Fa9TJ23++6m4IYI9U/5EJqzRFO04HQy3r5SHjyhRlB0js8jP4J4Xt5Ua6595/qz4OkHdskz6jGBkpkqgbAnMLsAT3BMJjIWoRlffPURrZ2DhafY3QGmNm91+LNNoW77NaIyOvLxl3krNhgLR89Nk075fLnmYx7APiFRX7kXHaYmbym7wpcgPdyELKfqm7i1JhptvheLSs+J/41ieBCqziXWHoL87O0gdTvmyo0MtmkX+2vo+DRdYxKD3QJnm72rmSCCP90NPsJxk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(376002)(396003)(346002)(366004)(66556008)(6506007)(66946007)(66476007)(26005)(53546011)(9686003)(4326008)(2906002)(6512007)(41300700001)(86362001)(6916009)(6666004)(186003)(316002)(44832011)(4744005)(8676002)(8936002)(5660300002)(478600001)(6486002)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVEkPRw4RuUksYyxVBtth/XL2zgGzuzftAwggkvuMs7v1xDPq9WAEwENDcvk?=
 =?us-ascii?Q?H/EjB9mqSVzhnFFVFHPcLbZe9XUDfyLeTs4k/5uxJ09py5UNayFBgsBYANlY?=
 =?us-ascii?Q?5/vHedbzV8Go9lle5OStx4dcyTnvLWQRAGz9ardUNaFgJrbnXwTdBCv192JT?=
 =?us-ascii?Q?z62x9n/jjyVf8VP9AexzkKPIjqTp/vhmpAuB4KFQYIc7TQbftRMtkU1WsSIG?=
 =?us-ascii?Q?a8lQHTwl8Ao2oH+broAnxxmGNnt84npqaM6FOCT8sMk9Jefl+X0sNJEjYarc?=
 =?us-ascii?Q?TwXzcMvjNXxsU99L4Boiu65pRGs7eqjzkqYPr1ZCyhOktVqpqZDQ7ygLJqvj?=
 =?us-ascii?Q?cr6CAPRztCjViZ3nd0ReW0CFJsPxHzVNEdK4sjzMcdHJsdK7HUidEVQtiACB?=
 =?us-ascii?Q?JkX83kNVTiRmJvHzb5///Af/5Fni8pc61kQ7NnLFF8i0X1nuSWb5oDCbsGKi?=
 =?us-ascii?Q?0fG4ibfKTku0IXm6CFvP2qjbVFOmHR3djXdY7eb+9X72Mu2Vy8quWtsdAnVs?=
 =?us-ascii?Q?MIaJltH2k/+5ZP5EIgfukPLDrpeEvxVFsRvJLbCFsDF7gaEotbJxBHRiLpjD?=
 =?us-ascii?Q?DZAobkKVmr8D+YRynr/fbV72uEIoWsAdLTo0ElPHc6kdbThEp1UYQeNrRbdz?=
 =?us-ascii?Q?CtSYbt9l18ZpKqP+JOQGDXPLmSYrsxSqyl1I0au47VdDmN83YztGnZUM55nT?=
 =?us-ascii?Q?Knm0GPGAKWuGkBrZj9A9bnD+aYSHRAtdlxM8Uoowi7q1xjgc6BOmwf0sHEAe?=
 =?us-ascii?Q?vokFfqVB5eFJ+axpPe17adAPS9R0nyBgShytnMF27mwUUnQomab7pba6BfCP?=
 =?us-ascii?Q?7pCNzCd/AXTmxBe08lw4xZOZJfNU1jhF+BdGo/cqbgvwGiOLhTabf0VDdYXg?=
 =?us-ascii?Q?7wdklV70lffWFLuCWDoW5350S2dhpgTyFnxdTNF94E8pBEUabF1P3dxMIOsM?=
 =?us-ascii?Q?wu770iqnWvVJDfIDme1DlDpeFrPqyzh2YEcxrdhkls9cn8qPCNN9bptlDJvz?=
 =?us-ascii?Q?nZf9P2eitK8Xwpfe2YtppW1vc+U1Vc/44YK62lfZ0VKTQcqEwUtLfVr2HugD?=
 =?us-ascii?Q?wpsU0hnDBNxSXB+AwEOwyi2g3C/zM9f+GwEsfZpCTz+9ZEoBfy4I87CznZ0K?=
 =?us-ascii?Q?YZNiwPm3ZwlBDHbtpt3QD1eFbU4yph7U/0iVKDwKnBW1MiP5t9jyDWHaNWi9?=
 =?us-ascii?Q?J14Enndjo0Od6r5n5SKaiJm2Gzjk2GpKAppnNhF7Nru1jHumIEQfD/wMbuHT?=
 =?us-ascii?Q?pYg1SWUmbWxL/7jexeH2gA1NPGcnXD+4BtQa4kHqmHrhfn1ixxhE/ljkkygq?=
 =?us-ascii?Q?zNZvmDB2MK6VnjpNwv4ST9Qbiu4a6xEu5YolPhY80kyPPuYzN/S6mraxslC9?=
 =?us-ascii?Q?dHiwWT5TGahzKEvsxtwiX82Xcl5KW8iVJN0+P+FgmTPmWk8mWnHMCdHJcvVI?=
 =?us-ascii?Q?BRItCYs35RCdWFdi4y+b+18q6t4c2FfnznwXXflMbMErNQzjnfxddNlzHlmA?=
 =?us-ascii?Q?eR6eryEHGzWnmORmnSm3E6s/j89kqjYn4+zhHyLCkDmUyBT6rXA6M+kyIlMS?=
 =?us-ascii?Q?E5xByUnfG+gz+kRSftEY0UdyNsgOhXPa555BrQ8spGx4WVijpuieQmjminx5?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01868f77-c4d1-483d-af53-08da6380a56f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:02:21.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYLzHHFHht/HLdVj+zMrlFU81++rH5aak//4p2JHqkO79J4MlIs40kk8/iG6s2mn3kpwGeYZRYdeI+2DM0d8Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1562
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_25:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110086
X-Proofpoint-ORIG-GUID: hlIesDrs0B9t7sfX2Rx-_3xKOIa165CU
X-Proofpoint-GUID: hlIesDrs0B9t7sfX2Rx-_3xKOIa165CU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/22 17:26, Miaohe Lin wrote:
> When alloc_huge_page fails, *pagep is set to NULL without put_page first.
> So the hugepage indicated by *pagep is leaked.
> 
> Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks for finding and fixing!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz


> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 06c2d86b1ba3..598c37279fee 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5962,6 +5962,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  
>  		page = alloc_huge_page(dst_vma, dst_addr, 0);
>  		if (IS_ERR(page)) {
> +			put_page(*pagep);
>  			ret = -ENOMEM;
>  			*pagep = NULL;
>  			goto out;
> -- 
> 2.23.0
> 
