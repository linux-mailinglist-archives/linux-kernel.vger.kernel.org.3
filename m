Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE61A5A9D93
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiIAQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiIAQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:55:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE1920BC1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:55:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281GgSsR016301;
        Thu, 1 Sep 2022 16:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Tz4mBssSQna6WO9ZhnRNidI60wFbvLOCb8LHujEAoAc=;
 b=H2EXsi7oOg0Zo0PV5n9J8G11gcF/Yij9+P0VdnYbXS3IfJI9N4K0J+cST9FSSNr/N/vk
 zcfKU28lzBeEqLLq5KSURJNmIiI4x+SWp4+2U1ZXfs9lAQPJMdW4gEcFnWy3PXXWgnPH
 zRUhBTSk2kjjNauZk47D5JXdUikAbaHmV10lu/yiL9cDErexZbmYFjXVrc0vgIHjCt64
 iUoCl0Rt/KmmY91udBPPAPkTULd/V9lsDN9hrD9c04M8TnrdIyjocMp2kgFHC2u8uDki
 Cayd/u5N0EsSoCdZNQ1KSOVWKFa0sMOaoe9P0TeLEdcJDv5yT2kqJhgdtBM/pgX98B5g tQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a22cxw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 16:55:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281GK4If019724;
        Thu, 1 Sep 2022 16:55:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q6p0h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 16:55:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoWnve5REjI76cPglcZ3QFEa9OlYEovjZ2JdYgIrd2FDraNjsBkXYATT7UepZSGCkoreoh7xpz2TlgZ2OfFdW+ydcuI9EOqmMPP9bAzKiEvyed6qutgsutvNdLyl5p2folOPNYhj9VFoEAbcerXUz0Qb6LTy/ZXvjTKv/6baMrXkk7OKtH/8osu/SPOqu1kh1wdwmBsmPVsu5kyWXqZ+yHetujiD/wGIW6lZSXhGvkOv60boQGPeUiRAgrCwHbcRr2AOS8l0wKbFgnYostyW61xBE7xqwMHG0qJVaSqJPMZmWrIt8noNf1xgO0CNFcSR9zfdh9R6Sx3SBm0x+yBvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz4mBssSQna6WO9ZhnRNidI60wFbvLOCb8LHujEAoAc=;
 b=J2EoTR1igo7YCv7bDg7DVrpyOOkWHGos3gvjLgmrbGSjKcMtVeCdE312DbzpYOeL+X6yr/yLbKq7TL5CC8+izJeg+SU87IWpXd4u2TCt0GPMIZ0eaaL758lNyvG2gztZWZbGKsWcprckdew9OKntEQp3CmE6ySkz7AFr+gql0n82MDiuLC4cQhORF393nkBo/kmKXJZXYqdqDAKr39amlT4fxt+jRsVxXdRZ8i88OdP67Nj9L5nqEwAymQksTe4EqLNya7CD44vhwYUMYMTD3t3zhsxZlxZsgYj6A5NFEn25fgPHMgwdpqCLRqJb7tD1UIe4ai2gU71g/TOezalvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz4mBssSQna6WO9ZhnRNidI60wFbvLOCb8LHujEAoAc=;
 b=UMf8dafzR9iNlt3soVnCAgYNqqgyE2Jp/4g9cf0QT1ae1iN9YxrMvazeqWAGgQ2QrbTDqcndY3/8oQMWrD/PGB+Y9JOHUHVEVDgyEqciryPmGGin+/6CDeUhxOC8fYIvsASFmDAhsA0fxPEzCjNW7l9scvQsrR4jKvhyCD3wnqw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 16:55:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 16:55:24 +0000
Date:   Thu, 1 Sep 2022 09:55:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        songmuchun@bytedance.com, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH 1/7] mm/hugetlb: add folio support to hugetlb specific
 flag macros
Message-ID: <YxDj+ZCKx3fpHQvI@monkey>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
 <20220829230014.384722-2-sidhartha.kumar@oracle.com>
 <Yw2E937l+GARR3Vb@casper.infradead.org>
 <12303882-dd84-485a-28cb-cefbaac4d960@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12303882-dd84-485a-28cb-cefbaac4d960@oracle.com>
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c36dae4-c3c3-474e-54ad-08da8c3ac38b
X-MS-TrafficTypeDiagnostic: BY5PR10MB4131:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qo66sdbkhjl4Q/T/peOlY5RZ9jdBRO2zyyNPkgKSVUWsKa2KxQOLTSu6AZqTOPFWdYHJi8VM0Ojh8jZZzUB/HQBa3eahW/UCldsRZBMJ1DawTMvLwl2E/TC98pVBBDiUx++CyP7KGh+IsRk+GCZz/P6An5mP3g+3/4SoiehWpUOb3wHdX20V8wdBmZZYRQC2IzNjU4vcUyPM9aWO4quq5wwVIb5nli8ojFVPPGTelzEpyRm5fRhpyhHDpWc5cvDVFv9y+kU2HQNomIq+IsLIqjjKr7dXS1vNu0wwzlqhAwMEZR68DT2+ynoZrg738C/de8RHRcHfgP0xRy9q9V1tEvQsCrIt6M4/9ydlP8gmbH/k+qy5jDgHxv/gMauwCTi4RuJtWVaoAnEwF75NEjdCWy3WfpShqFKCIONPU2M5Clg96cQtwSaGxOtJ22dmYAa/GdF31oxxlK8Zvi7WhfjvHLXqScPGjWHOV8KKDqhs48m2bfQKr0fDzs5ShXaL0mJ5Bn30MXWyDqOahhi5h4RjhsgZG+pN5QmjNeqmwEEe1HDtgMukNVddLSCcxAt/aCjIcjcIniP1Cw6y67Zfed7ii1msoa9ZptkRnXkGBC+ZV0kjg9/YshmBpJ14pfu+G3miOrzHrBoK744nsZZFA6wqhznHEdLpIt1N2ihQzVKotcoHrVUtwA9pi3N3PMJtagChOh9cPXTh7Znqn6j1pgxelsiyonvXic4wVKv4ldT7Y69/MKpupEmVQQcggq08eRsO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(376002)(136003)(396003)(39860400002)(66556008)(33716001)(478600001)(8676002)(86362001)(6486002)(4326008)(66946007)(41300700001)(38100700002)(8936002)(6862004)(5660300002)(7416002)(6636002)(316002)(186003)(6666004)(53546011)(6506007)(66476007)(6512007)(9686003)(44832011)(2906002)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KMnaYFkw3is7hiGX+m9Kbh7fR9bTY5de55yuHPVfYqo8d+akE9nkRS7m4p/E?=
 =?us-ascii?Q?duPA+i+0w2PrxYrBzPInjuaYW7NdO778NEdbHg8iteQJwIzjULvL3KCSwoWE?=
 =?us-ascii?Q?6DuDwvda8umn4KceBKkT0oPkn/NY/rCIDTnh6zb/aBa93bUnEfJANSz0abnd?=
 =?us-ascii?Q?E0aWZsJzChqnRhVoXCFPwwcHuyFxj1vTKAAoyj69D1qVQ7PTLc0w4nQdrE2Y?=
 =?us-ascii?Q?Cn04Y1YlS2Fk5lBWkiBKwZ74Y3WjEPv/9HaTeSatbF2PwMq7JEFQf0+xR1JV?=
 =?us-ascii?Q?wqA8GiY1GKv6OLjp6JeihzwQ/cMQfUrgT+2UZW34NKAR9wurTRzYawhHtmVk?=
 =?us-ascii?Q?HvFwN80p+kBMtEcSCivY5w5pY+BAtsgYukeukq+ShZp82Cw+FyG+rarPGCOp?=
 =?us-ascii?Q?ygVYhsAl7++fCzkWos4fZNB8ywvAxk74UQ8naKHdOWlYZZV1TZLYEustZPbZ?=
 =?us-ascii?Q?DfoSKlIgjcb5JwqrRd/TtB43vU5k3EruEla3OZNddi3sxxnVCMFHO/SDQRwI?=
 =?us-ascii?Q?nzWrk24cM9JkvjafedsfJxD6h2Gnz1Kjyz/GuNSGwUXWyKq56vxN2X2+F7u4?=
 =?us-ascii?Q?5xjp7sM0iUlMZ6noDR25IAAGDh8Ka7y6jTJu/CTRDt7J93dRtvoj/hC7P00o?=
 =?us-ascii?Q?TiXVWBKqsvloRCCrvJp6uP2GzhWPy6bIdbj7pAlGqXlf8e8aDCjlDJWiPtJz?=
 =?us-ascii?Q?tlxC/Vu5jyCEfKL6g+fUcetaiu44XgmA3CIOee69OBGffBIpM9U4y5eZfzSL?=
 =?us-ascii?Q?hFf0bC6UtA+d4fD7MBigX5N6rXWfj9MTa05batdaGVeairvD7JYK1P1AKeBM?=
 =?us-ascii?Q?HijKYvto7g0lOl20RS+ubLkJrunE0OdoIwMgGgpuZoua0Ep0PHA5LI+lfW4t?=
 =?us-ascii?Q?C8c1pr/GhvaoiPF3mXilUUmrPYRhUSjzCj7l3rXpJ2LPxcgcRxgfULaHVny8?=
 =?us-ascii?Q?VAbQJ39L49v4HOZibznvjyHDP2/I+noXoAH6RaxP0hcRqRlwuD6bk/BxI8iq?=
 =?us-ascii?Q?T4lyrnzLa3PeltHVsyaEzN0QwIMkAvifAL+u9FqifIy1Q2MtKWNBV+v/C+ay?=
 =?us-ascii?Q?eQ4+l9Q0z7qJNB9hWD2NSZmCSJLUv8hKpwfwZlvMmyLtZYGbNrCEA5MV38Hq?=
 =?us-ascii?Q?tcBfkTagofYIKZZYnpEO4tyV7VUd+cu3BtYJEEhxyew3zyLf7nXkYGMbaMs4?=
 =?us-ascii?Q?E8owLMcEgbmJ0kyTqBXWyuChgZX1WGIcCCyXmPbRxV5215yycm/IU5zv+mSY?=
 =?us-ascii?Q?rdHBUvHeV3uBCHsOKcZbsJSETfwoS7eTrW9+lZwyW7ZqMTbfljj9S3NMMAxU?=
 =?us-ascii?Q?d9ZwplEFyBTTo6pWQn6UHf2fkwe+vZvX3dxb9Laq75Q9MNh77LrxRVH1njKp?=
 =?us-ascii?Q?pvka3xW1e6jLci22CYZmRKTrcSTqzIhXA/X36COZLMCXnvsBmPE4cLmRaJOz?=
 =?us-ascii?Q?Hdr/MW7VALKVXalaecjUjByeSCisEXb9hJhKEV/xZgjlKmLNIM2uRWAd+sl1?=
 =?us-ascii?Q?/qRFGAopH+XJS9oMeaso1bPttnz2F8yvcpN8U+TGwxLynkDSNqGaMLp2bTqQ?=
 =?us-ascii?Q?XIYx99ha4EPn1DxXfFu2Rcae+46HiXfTgO8svElR/rmveHEw8MJs683qXXsy?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c36dae4-c3c3-474e-54ad-08da8c3ac38b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 16:55:24.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsytpslLccu/OTq5GyFUGz/SQ9UkZyL8HCEnElckkgL8QgKSuplHhQ9eTGmxr+bXxh9gP+o+9zY8FRTDmhJBaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_10,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010074
X-Proofpoint-GUID: nTjkDiGGwga5cRQlDUvmufYcV1-pzHCO
X-Proofpoint-ORIG-GUID: nTjkDiGGwga5cRQlDUvmufYcV1-pzHCO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/22 11:09, Sidhartha Kumar wrote:
> 
> 
> On 8/29/22 8:33 PM, Matthew Wilcox wrote:
> > On Mon, Aug 29, 2022 at 04:00:08PM -0700, Sidhartha Kumar wrote:
> > >   #define TESTHPAGEFLAG(uname, flname)				\
> > > +static __always_inline								\
> > > +int folio_test_hugetlb_##flname(struct folio *folio)		\
> > One change I made was to have folio_test_foo() return bool instead of
> > int.  It helps the compiler really understand what's going on.  Maybe
> > some humans too ;-)
> > 
> 
> I went with returning an int to stay consistent with the page version
> of the macros which return an int. I'm fine with changing it to return
> a bool.

I believe the page test macros returned an int when I added the hugetlb
specific versions.  So, I just did the same.  Since they are now bool,
it makes sense to have these be consistent.
-- 
Mike Kravetz

> 
> > > +	{	void **private = &folio->private;		\
> > > +		return test_bit(HPG_##flname, (void *)((unsigned long)private));	\
> > I've made this tricky for you by making folio->private a void * instead
> > of the unsigned long in page.  Would this look better as ...
> > 
> > 	{							\
> > 		void *private = &folio->private;		\
> > 		return test_bit(HPG_##flname, private);		\
> > 
> > perhaps?
> 
> Ya this looks much better and passes the tests, will add to v2.
> 
> 
> 
