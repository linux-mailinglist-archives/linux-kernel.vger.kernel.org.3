Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B65AF243
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiIFRRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiIFRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:17:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159D632B98
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:06:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286GOEC2001897;
        Tue, 6 Sep 2022 17:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ZNc8bm9IXLjaHBXvEHJFswdMKmxe0hW5uSNwNJAOouQ=;
 b=f1JQwet4TP1QSiC4WcoP3S3OFwKoB9aPkSRVJbhsgehAXK3GLXzUnC9yhpZCXoLXmBlB
 BxkpL8l9hYQTR1dTEhuXNbg4GoK3pjiMfApXTG+Jb/hJfZZdlR00x4Td+CFM3aVFWnpL
 Vy6e7/ENIhVQ1rMxQ5ghAldEniUqlkub7+9fkcSZo3L0WVn69PNcDoaGIHl/r7KYny6G
 3Byd+W93QnyCptSirLN0X3HEE5N5mKWCdm7K85K7KEIcwoIMJvTJXglLdCRvlbE9F1KF
 qTT6AjsSS2RbtViBbxU48GJbqIOmjNMAmxMbxtfHAOyxK5k2xGcRe4B3GB8COErFzn/u HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaecsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 17:04:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Gdmio039691;
        Tue, 6 Sep 2022 17:04:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9er6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 17:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8Qctc5rEQ7f8aOHAdeLtnL6KySfMYKSg7ZYQAQ0MgsTSnUqfLfjCta3JUkdVXlT6AsvDQ1Ldg5ZsotwPfR4l85LyBlO3wIJn5l8uFKrCrhoVEfTuv+Oq5y7lhBG5cINBodWSLOQZBhtX/pFwpT2NKA4TMjNQ9/cfKODDjDEquE3t3tCk3v4BIkeUC7ZvH4RPFc/JoA+xNPlDpwBAW28ZnY4otBcQzBIGswsItsyst8NDBZpL1LxpuWf7rhB8R8rOpL8WatmgZRITS2Vwgc7Jmc8E3NQWjyuCIaxreCNXOJ7W/kZ6EQwdQq9FBGz4uNW+vllSZtbyfKGXyK5Ulr3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNc8bm9IXLjaHBXvEHJFswdMKmxe0hW5uSNwNJAOouQ=;
 b=glsQh8KfEbMm1jGs6EyfnAhrLtBmODEsqPQ8Y3nTtGkzMH2MoHw2ve0Ru7cpgH48m2c2441vb+VNyhqMxvemFjsoia+logKgTL7e3PCWSsEyfCM9olRY443wrzC4TbiqE4bP/VsVUmIHguIeGpwnrrj6cJbIXxQtGuugXqdHj57op+KxZLmPPtVhDi1S8uTZr0sxRgPsN/FtAwxEnJFbrc44rc8zhHPvkUxFQr3T0yAjYGasvNIu+Txu1OHF9qb+LzQ5ncMVXHO+RupV480WZuCvK6H4/WqTGI+31sZYKKwyj76pV6VMls7E4FM6BqdxNh8zFeX9HpsAoREGqQUbfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNc8bm9IXLjaHBXvEHJFswdMKmxe0hW5uSNwNJAOouQ=;
 b=Gp2H2+ncyXzBabip+IVJtlDCInfDNfb8eC6DObKYiGBEHYENqiRcgd5uQZTBoQffy1VjY4GxRrPWSgQbB3rXbHnl16fCjf8Bx/6pNdWtFMzNc93yWsil83jA1K9h20XKxBVVSY+542R8vzPwDVIZ+NRw4mCr8ylb31V+QgC3Ujs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 17:04:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 17:04:55 +0000
Date:   Tue, 6 Sep 2022 10:04:52 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Cheng Li <lic121@chinatelecom.cn>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use mem_map_offset instead of mem_map_next
Message-ID: <Yxd9tA8ThZtB77dq@monkey>
References: <1662300161-22049-1-git-send-email-lic121@chinatelecom.cn>
 <YxUVZpsmukNW5NyK@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxUVZpsmukNW5NyK@casper.infradead.org>
X-ClientProxiedBy: MW4PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:303:b4::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaf6a816-a645-41bd-4bce-08da9029ebe8
X-MS-TrafficTypeDiagnostic: BLAPR10MB5011:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3eut2J7ETz9h5lYWCNuFGCl/Twdbp5HGfmIkmX72kgEW4A7YXv+oxfQbB9A8BPlmkSO9bZFSKWAQzxbU+nutCX169L38j8hdG2u9AGU00Y0HBJcuC1g5o9gjbgwpAak4yWQxYjRz/7VTxryxKz13R/0uoympDgzZnXnS71XonInCom665gbVlOQRkwQJym05DYTKpUj2vzOmEVK1rYOOJbPwaK/hJJCSezhhxZqUwwluesyknjxgnaxh2LfCTyYhRvBNqTGo8WaE5f22F2CuNGfw2t+tZDaxpvfIVwEW8EvnwaWAA/00aP25qL8MTy1tyAsFomrgbpaHht7soEAoL9iwhgzzNkj4mptz6+PpJx/aJKi/GDwM686nrWfIOr7s6nRtSfSVM7DEg7fIpaRPLN0CRLkxq3eK2s2syQhLOcnmJyuTj8ENWIOyxkmwLHqZc3Dx+McBGtr3GZzaxSH8bzyJhgWgSx84ct+SkdoGQpbTrdPLwFSdGH9Xu0sIG9ZFuNTkmhU57KWivVZKu3dJXiYTGCXd/AfQkGyDEvcvBCwYCgYLkMyY7SDVIJjS0YDK2ztAG0m9BRDRM9+apv72cplbHi5c8IQM/CjuyldaHvE2bdq1eS1zAUu5ritblKtPgCKEbikertOHHBSqGwzVlH1UtEeZRrRNCGdyn4wPqmhH/aGHLke05suC9xxVCGoBNaDIZNGN3li/zcpqZPSPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(366004)(346002)(136003)(39860400002)(6916009)(316002)(186003)(41300700001)(2906002)(6666004)(26005)(6506007)(53546011)(9686003)(6512007)(478600001)(44832011)(4744005)(38100700002)(8936002)(33716001)(6486002)(66556008)(8676002)(4326008)(66476007)(66946007)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sTN3tdS20k2ItiiVSyUwYB8pY4rOrt6IbqM9c4oUzt1999KWTcArflhqn2mg?=
 =?us-ascii?Q?EgbRqBA4HqzNGLY01LKSR4Q/PZEAIJQu4AmrjfjnG/YzLR3j3Vlu+uh5rh4A?=
 =?us-ascii?Q?Gk88/i6dv45YYE8gKqHkQNnC2BfRI52pkLj20zueTI0vHzqGZRzTrbBFx9Jo?=
 =?us-ascii?Q?vfikKWbmafv+Zhj2M7l3edhFAcwcOglXQFBjApBPVYlKnvZJ5hoOdBRm37ti?=
 =?us-ascii?Q?LURD2Y0VVZtjMM5xSDKG5smlBA3cycLyMog1Y5cv/oRBroqXSGkA8L+TZ9y1?=
 =?us-ascii?Q?uzrhMMNNTdBOcmrlzo+IDJ8r82IX4YAumvTLv4vBbxF2HqZpdzVQrCzXRcAt?=
 =?us-ascii?Q?DRV7dLHxP6Wj+ujtrPLnKTTNIio0QAAKPbFagkAL34ai557EPKbf7xX80Ksg?=
 =?us-ascii?Q?QwNpiCY2wiaO0dPGxlkjuNzge+KoIwfs/Duy4+c5v74FejusxumnzNqb1FKM?=
 =?us-ascii?Q?SSYiNoPpBuUZ3xaOgOhESH9wYf9LJsQkoPtNv6zXK6Ti4Rhzpg4ITycoltLS?=
 =?us-ascii?Q?87D3ijxmFbkWW3XhZ0YEKicPrIviqQxeBWorH831gQxysVqghMIPXI3ulRJW?=
 =?us-ascii?Q?yCUgZjXSyn9ZPfZdJaWV3ZEi0wMrRX+RClUPOVLKuMOV94aoUXS3oa3FnhS/?=
 =?us-ascii?Q?NBFQIZlRcANCvSAYP6DLNcsbbdUNF62tWgJm2At6/jhphW5q6hpgCh33I0T6?=
 =?us-ascii?Q?B0WJmu4fxTZDCg/HJqmh5/eUcjvaNllhD7QDzXtBSc253Rwycx1/cVEdBg9g?=
 =?us-ascii?Q?AUJIhnJNwxx9Sr8PyX8/6T1OqrXLT0uyGkOkDnWYcFFHO8TwhERQmXzXG4xv?=
 =?us-ascii?Q?ZXPNnlixxp0yhOCbwMTIh00avprLpxO7U9S0X0rS9oV+f5WeHkIAJBYEV2ee?=
 =?us-ascii?Q?bYNIHro6AkxUxvnCwYXg0O3TJMSkPYavMC4VGFDKeSfLN1g/RVhI0UBEv+xp?=
 =?us-ascii?Q?N9wY6bscgcwuYznclCELk8jZfk+LTKmurW5PM8/VLmuarGGpAwbwdU4nl2JT?=
 =?us-ascii?Q?qQOr1LXEIiNJc2owAvY7QolxdQOCF0RygqVKBnkY9SRMWMoVu2mDlyfnxf+S?=
 =?us-ascii?Q?ufnEkBgeNZ728ttUpiAqBri+x+sRS5n4ue7eJ1ZrcImJNtjYWROXNu7bqTpj?=
 =?us-ascii?Q?ykzSr69FMUBiHOquneRWaVolBwVpjUrvCHXc7dipXm2ckaY1SRe2jposlUXs?=
 =?us-ascii?Q?URZsPbzph6OrMXcf7Xd2ekgXs1HEeG/qZCk8y3FHbHZM9EnzVD4jYyva57VI?=
 =?us-ascii?Q?R6eF/dc8PuaawNeVHBDbOiFM48wxl9ym0yr4++pEtCBha755nFTCmkJrWz9j?=
 =?us-ascii?Q?PoGZoWTzEdKhwV0M1uZM3FiBSm6/NbSWP69Q8S9vreoreCk9yQp1SkCCli4f?=
 =?us-ascii?Q?qbKUviXTwmWc7d7lgK5LM8u6EI1Fcl8OLKXUR9nTQwsHyFGzm779abMZ6Aih?=
 =?us-ascii?Q?myuVcOnE75ZKoDYtGrls5x9gb51yQwS2Oxd89Dwrb5g6o1uQB3mVmJ/YbxaG?=
 =?us-ascii?Q?9bFNvsTkxENlwUkkISKbin5HIY8x5U4cK//UKR2KJD08i3Dm71W/dgB56DbU?=
 =?us-ascii?Q?KyNktlR+R6XS6AapPnShKnv5phm0GG88PAKR9U2jgMCEbbtdc9KN167XyZ51?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf6a816-a645-41bd-4bce-08da9029ebe8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 17:04:55.4475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xK7B/i23gEmvjCUZ29TY+B8l64peVneu0SO44ThuYAqxalj7P+W9OHFrY3yQn3WaYXrJUfOVNrsMpm5cwsTuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=777
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060079
X-Proofpoint-ORIG-GUID: vyrxxKghx3dy3MBVR-sO2NnQWeklN3NP
X-Proofpoint-GUID: vyrxxKghx3dy3MBVR-sO2NnQWeklN3NP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/22 22:15, Matthew Wilcox wrote:
> On Sun, Sep 04, 2022 at 02:02:41PM +0000, Cheng Li wrote:
> > To handle discontiguity case, mem_map_next() has a parameter named
> > `offset`. As a function caller, one would be confused why "get
> > next entry" needs a parameter named "offset". The other drawback of
> > mem_map_next() is that the callers must take care of the map between
> > parameter "iter" and "offset", otherwise we may get an hole or
> > duplication during iteration. So we use mem_map_offset instead of
> > mem_map_next.
> 
> I think we should go further and get rid of mem_map_offset().
> nth_page() is now more efficient than mem_map_offset().

Agree.

However, IIUC nth_page() will 'almost' always be more efficient.  The
only exception is unlikely configuration where CONFIG_SPARSEMEM &&
!CONFIG_SPARSEMEM_VMEMMAP.  Correct?

Not arguing against replacement.  Just wanting to refresh my memory.
-- 
Mike Kravetz
