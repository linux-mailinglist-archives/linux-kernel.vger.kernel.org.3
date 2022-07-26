Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA49581B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 23:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiGZVUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiGZVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 17:20:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933E0B1E9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:20:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QKnKIg010349;
        Tue, 26 Jul 2022 21:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=vw5Bt9snkL5SVVqwrm5rkLrs7jQBTPfXqdWaT3RqwfE=;
 b=b6VKFkWR7EZrS6RAosqtyQwN841x+aYrYtM6L4EMRIghCMaHb+2PxzBzXsgvBm4mNJhU
 IytMdAx1zunWjJW2Rk8Wj/d/bIEnA/gmv+KzYMsNVgJTTwaZoF4IfKHiygJnanesNO/c
 mS2kJDEvfdVv9rI1WZzaiQtTXlcNGdbR0o+tZcK/ke3d9982rUAkvez6MiJeWh1PxF6b
 ubUpb4PDHN7QPHhTAos0LrOqF5tvtNRp3c8N+alDP0Cno6W5v4QE1u2nbCNofV23tn6v
 9ocwsfv6YhWDwQ1ug8Zhdg6EaX0gsaL34HFQUlCECWPL1Dt+qjqQd7ceu0GuUoVpN8nO Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9fru9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 21:20:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QK05KU031548;
        Tue, 26 Jul 2022 21:20:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64sdtmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 21:20:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4/yGutUdhmNEsFFfxJfcyEk4Yi29yOr1egfzbMkaqtQU1AxIPLPygwZC3cSkX9y0eW/U4hSHEcXofuAhEcrtFmFudAnVo2RQ4UOD/YGQ2OPnTdeB2+nBgm0pHHUdBEOdRkJaGBtKoSWyDMpyYZMsPqfr71ZvbYWo1rwNrunax5DVB8pRlAI/p5NMAq5bCWeuum4ib85hRdngTCeS8YmrDwL9NDtHML2dcfoQlt4zMjJP4Qhk7ae02nQ+8c6jciCZ010QoSKxhd2kIacb9uDN3KS1xeqogYyc1WtdiWGmDm3sOblrgEQbVtEEpElFE1ZZP8GlZnXzgO8Kw/bI+Sgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw5Bt9snkL5SVVqwrm5rkLrs7jQBTPfXqdWaT3RqwfE=;
 b=WkjYzgHBs1CT9EGuTkr9u917SzRLMW0R9tcsHfTLiXyETgGKBsLxz15N99E8/hwvuhFCVIwfkdBqBn45r5J4d5DTv0M8D51uroDpgVoS7GwZV6KK8gcE/tmyg6QTQ7dJuBbg9IzNYvLODh1pYvx3Z1Lh0GtOJ4HgfofTh4FJ69zS9nlbFOCTmlnboPeU2H01peVE8AMbxo82oo+UUXzXmq+K8LsyazayBoUW8Km7p/OIuxVt1xnnJ6DA2+l4/LShOLyl19gxoIztgUd3AH/9TJlreUPbWjLEDAPlXif4yfi1T58efI28Uii/HrlRBZmu4DiLfclFL+1hdhsCQc8tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw5Bt9snkL5SVVqwrm5rkLrs7jQBTPfXqdWaT3RqwfE=;
 b=m+3H3WHQmFwA7ybPUdtd+dwiUajLuXXJjECEOY99jD2rHD1MSlrLxmzUENgfaW586dsR6SCOqkgslRblkmtnCWZ5i504QfdSffLltgrvXlbja36tYrvtnANYNE0UfEh+tBgCckcfcvC1es8+5cSrpYTKz4KG1KsQB2bStM4cN9I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB4964.namprd10.prod.outlook.com (2603:10b6:208:30c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 21:20:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 21:20:38 +0000
Date:   Tue, 26 Jul 2022 14:20:35 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] hugetlbfs: fix inaccurate comment in
 hugetlbfs_statfs()
Message-ID: <YuBao9x/n6QTUWNC@monkey>
References: <20220726142918.51693-1-linmiaohe@huawei.com>
 <20220726142918.51693-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726142918.51693-6-linmiaohe@huawei.com>
X-ClientProxiedBy: MW4PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:303:83::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd8a8e4c-a72a-4a8c-3811-08da6f4cafa2
X-MS-TrafficTypeDiagnostic: BLAPR10MB4964:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4cDakvOmQhdwzm3pSuZjmLv5wBBlthBu2y2tvkccrgxX/UUDcVuRniU6fIE7BDHewvj9qOFb5ioDM0ItbG/ZU28j65nVpVrpLEM9WoHA3aTn0o4JuyjKUSHE8SO6QIhG69I/Hd15da8jGx+w38Cx2kEdHgsvn+IFZk6ZfykdWQ9YgzKw6VIth+KNBzVeV1Ty0eiV5s6oPGwhXg30eb6w/Sshg/gSvMQb/qt6/2Car07zC9Dw+8AevTBdKlCH33jjlLM5MFww8ukESWWCKc49eZTH9WjOCI9dIXhxF0tpC8yCXlywOs/JaUUr4SuUp1NXIMKu/9pEMkOHpi97uS4ld32cXQDO4sXWDhBtRVucsN/zmJTBaldl9meEfE8/KpDQdrpPuGAblNZgtK3bNT8RzrKabnV3wNVXy+7UUyQyab5cvgAMjeoQ5C8jfdze2R6PhPkmui1Uf7rL7AKUGnD0nb5ZI0jojggNuPhM9H1RqlzfotTG3+zSKzwZYB27UEJedUnTKteQDei4iele17Ahpu6nNWoYChS6heG2A21bcvQsrNd7qR62UQkZ5rEinhrNZpn0bUQD2zdDs5BHWkzDYyaAR5eNfKqf9VsdZ/U8JC+/NTH/5HMZZ8JZz3Yov1UlIlSGyoQTnlPWY9M8kIFVPYCWkUsY5GKGOHpkwUM9wQvAb9MKegIwUwVAD06KPWzpxLKoKKf/X0+39HPBj+LUbou7G/e8O+hjcaCR8x9zj9BAu/9ieV6ugXYp7b7Co/K59Rcnd3sYaa5ElPArRzpQUiQBEvqVjy+9CFzkBnsTNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(376002)(136003)(366004)(346002)(396003)(66556008)(53546011)(26005)(2906002)(66946007)(66476007)(33716001)(83380400001)(6512007)(8676002)(86362001)(38100700002)(4326008)(9686003)(6916009)(186003)(478600001)(8936002)(6666004)(5660300002)(44832011)(316002)(41300700001)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fHca0NqB4108KZhaEPNoEhWOU/BssLmOlZJOitIwTQXYkZeqnOgfOAXqpC+9?=
 =?us-ascii?Q?+/Vdmx3IiaURWSI+nkOZyqWdm0jLkWWZNZQlWjDdo9tG3Wbo/0/AUikhfwz9?=
 =?us-ascii?Q?kMSsb/bv5Xsj3HjrjLCahuUVfAkn/JgXfEMstg6jg6BnZMMrtSUq3pP60REw?=
 =?us-ascii?Q?rsr8+HeiR5FypxqeRgwzps3zWx9AvTqvhhRHNelXI/OmLNJ3z/ePwAyab9Mo?=
 =?us-ascii?Q?vsbs+srNlsQ6Gy3GjpYG/xRuihx9CEpEXEysh1wWc7kG0JGIKI7j3CtuNF+a?=
 =?us-ascii?Q?whYlQkhhx7AUgWDM6Pd6MhFA/vWkjyN0bysZIcfP73JvDOxKLDXrjWJu6zQX?=
 =?us-ascii?Q?srMm+5JmCkymhLPhLGRplQ3EvhQ/4UEA5PW/xdLiL2ZA5BzbRKlAD5KQ/dZC?=
 =?us-ascii?Q?s/guX1VVp93wH0gYmJXu2CH9uR9QSRP6pGrwmpYc0vSBs0xI8A/Ct2dzEh4f?=
 =?us-ascii?Q?uP7eShFQMZB0LzJgdvQD2WozYyWWKjZ1f22NS9iYUXMUz/QxDZM4bcdIqoIY?=
 =?us-ascii?Q?7WKygKqrU7YSt/xxd4T6r1As7bbq53Y5kNFrQ3uj7w8IwCVXoZXH4L6iXWmc?=
 =?us-ascii?Q?lG1agMJHsYjqpkERLgkJHL+6gE79LJW0fZybjLjl3o2zzFFgRoCCOu1BFUcv?=
 =?us-ascii?Q?kmoHCux9mdvSGdeT/b+/tYGPqPFGXPf/hcLA5pkYxObSHqcAN38WapFAxpkA?=
 =?us-ascii?Q?Fl1XNjRVGUtFN5TEC4UqJvXi6yLosxx4yEgIcaIFJula8NdZ3Bozc9QS0vSj?=
 =?us-ascii?Q?wSdBAXUpfrrs+WLudiO7C09gYOIKr/B7IliKLAwff1JwapImSNyvBNdSLmGu?=
 =?us-ascii?Q?0/6A5CBcH25o4uc2CkV5wLn4OyeeUl60YLMhAUyFElCLkPY7w39QCJhRoRyG?=
 =?us-ascii?Q?bjRL/KFzbBKh09WQYXYzVqFF5r9csTMYQxKOvxyabFrvj/5RV5dTFflt/cUo?=
 =?us-ascii?Q?Vaso/e7mmWzgEd+Sfb4wyBfNTM8cwBX2z1RJXEoV1QoDdyRbl3F8k9484aPB?=
 =?us-ascii?Q?5zyavxh309s2/+3GN9rpWnDXqUyL4OdZ3/G3y9YRmGsgthZ8sZaUTIsZTOsu?=
 =?us-ascii?Q?VWe6qHdRwV5mxgKwSo4LzA5Vu/mHZD9aMdmvVbsQ3k7T0U8VfVxz1oU1NijM?=
 =?us-ascii?Q?gd7hF+vaosEOlkveoGKJmozGUGArpcrwMSqw2SlMYyL//spV1dLJYz7ftwaD?=
 =?us-ascii?Q?zaEnjuVxTSEQC+e/sR+SH8CtXodc5+gk4fb8uQYJ2MoYhWxL3kepy+zpUoxJ?=
 =?us-ascii?Q?Hll5+UhVd5RvP0e2wjI2YB05BxF+FxEQr20OCe7n2Ueq2/WFHaJvVMTjLfUc?=
 =?us-ascii?Q?VEHqrVoRCEjcsFnY3IDUMFt9UFv9fxYJ7uBozcOsIaFwXUGol4mZE7syj500?=
 =?us-ascii?Q?nLmrZEuUoJ2Fv2nvvzhlkhRb0vU32gnAwCqqD14embV0pbo46P6jX6ljGtPO?=
 =?us-ascii?Q?YOnontr8BCMUuDq5h1Pkl7fFRuhbsk0zqHAMpd45a6+3pp4LL9Xat+/OPXEN?=
 =?us-ascii?Q?eWHMxXZ7fli2wbJ3rneQei2AW3ELxNsPyP5ruY0X8hG7F1sXduvqO1RpQvE4?=
 =?us-ascii?Q?2sHOBlX6RlaZ6GN/OSC1laue9bGCoakquuJgDjZ515WSAcSjsZiXmSc9RmhA?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8a8e4c-a72a-4a8c-3811-08da6f4cafa2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 21:20:38.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ll5fHcZCK1urd6NZ2TE1vgY1by8tmE+2JLoKH94kbdaNXN7YXYCQgRSYaO9H2nAPQnROCwLBzyFWxdutvsTLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260082
X-Proofpoint-GUID: OJphDrGiYVOQ0f3kSR2-YsiS2p-OHle_
X-Proofpoint-ORIG-GUID: OJphDrGiYVOQ0f3kSR2-YsiS2p-OHle_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/22 22:29, Miaohe Lin wrote:
> In some cases, e.g. when size option is not specified, f_blocks, f_bavail
> and f_bfree will be set to -1 instead of 0. Likewise, when nr_inodes isn't
> specified, f_files and f_ffree will be set to -1 too. Update the comment
> to make this clear.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 96c60aa3ab47..fe0e374b02a3 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1079,7 +1079,7 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_bsize = huge_page_size(h);
>  	if (sbinfo) {
>  		spin_lock(&sbinfo->stat_lock);
> -		/* If no limits set, just report 0 for max/free/used
> +		/* If no limits set, just report 0 or -1 for max/free/used
>  		 * blocks, like simple_statfs() */
>  		if (sbinfo->spool) {
>  			long free_pages;
> -- 
> 2.23.0
> 
