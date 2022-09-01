Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9B45AA0E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiIAU3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiIAU3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:29:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A593A3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:29:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281KRRvl029033;
        Thu, 1 Sep 2022 20:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=jMDHFMu0wYq/wiezvvBfZCh5GofgfTn0N0uqXoIfCfM=;
 b=nqCksdxolQ7hiZyqssLFDlGfhBLyMW/cR6S5OgZ/DicHpvJM+6/NADuqco/heS7WvXSz
 kQv8b1vqQn8ez/oDfI4sr1humK9Yp2iJ15X4Bg0iDF+rz+vIeqGQNXFwPkOljpAxd3fU
 ZTwWCONYQUM349Xq6tltuMn/0jy5dHENow5+9s0MFFTvXUJ7syK4jWnQeCTapvD+1mlB
 eCaGPw/p0P6se9Rqa3dPqQzOtNAqFq8OFY736CyEQREg6BQgjlcGF0lVHgrqTUK4AqA0
 JQdm+/x45LNeWMtjeXIxlJl/Sm7YrmrA2P2unsrvTpSzEEt2VTnIYZnoP4W2I/ZLAMHr 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0we0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 20:29:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 281IuUKV002253;
        Thu, 1 Sep 2022 20:29:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q6xfjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 20:29:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKds5QFQDlHW9XvTTA6ZZzNa6q0t6cqIL+KrHbj9Ch57dvILymwWzVCq3Yha6QnN/3vcjLDKu3ct42ZLKjnVRciEo+BDJWSyo2BnixrLXvLzXyYmlB8J+IYdVZO16JwObkwoRpwQL2R1tTCSPJtFR4hX0EzB6NQMcb3qMoyTvrTb2MmryuwWsRU5BTibQCTfnaYkNqgZxwp/Rg9hA+EAx2dLBhTyKjaHv1MURT6+zSGg77Igfm2DDSSxKVCcD9S1FfYgLJuBe2bk25qXELqf+a46jizxWGwsymr06JjHuKkqE3+d2fgchMG4tpYjh6iM+GGNKehH2rvYlmZwNm1ang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMDHFMu0wYq/wiezvvBfZCh5GofgfTn0N0uqXoIfCfM=;
 b=Sp4NERtNbnNDiGXbRsnyeclybEsIX9oidspuDcobKYZniBtFuk0t7BM0TqY8DDRX4Xhjti4R8HaosDvno5z3PV9IDTUlj1UJKp8yJaQg7PURdCKfggYGIyhnCU9drp/CMwJcJg1g3uE/F0IcPYbweIcBxF8w9YoOMbI1dEKFXV2Ac3yUUACvGvKeT0dnjza+dS0sCTCOvRQW7Gl2ukhHZ8+YkSpHWjGCHeA/IcAtHswQ3GjUcvKRMh5pGHf0jXKB17Oo5ioRyYc0Wckr9CHxjrLRN/n+H+pMUVkjb91POzwaYhuONPhp1ky3U5jiaF+3fyhS9DxhJA+ioIOMClQzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMDHFMu0wYq/wiezvvBfZCh5GofgfTn0N0uqXoIfCfM=;
 b=Ig18Qg5X92Br1h62m2hsVE+Fs++MpoYBqgYZyZKgbSpmCsW7nYnLzVdmzR7Y2FYKBsRk1ZGAahCNBNf0MRL2/S/RjBbirZV4vKTZOiR1hZzcySxtyycBs4BUtkaWQ0syJE8G8dX/vEtUq5hfG0YfJduwo/cnWF2Awbz7JbQmBrs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5577.namprd10.prod.outlook.com (2603:10b6:510:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 1 Sep
 2022 20:29:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 20:29:23 +0000
Date:   Thu, 1 Sep 2022 13:29:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        vbabka@suse.cz, william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH 2/7] mm: add private field of first tail to struct page
 and struct folio
Message-ID: <YxEWH9P26bzuSK1U@monkey>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
 <20220829230014.384722-3-sidhartha.kumar@oracle.com>
 <YxDsu8Ol/yOg7sMV@monkey>
 <YxD6215MS+L+tGLc@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxD6215MS+L+tGLc@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36fee558-dc32-457b-9ad4-08da8c58a79f
X-MS-TrafficTypeDiagnostic: PH0PR10MB5577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSn+KTu7TMwEFxcpn1DcgLFj/7uT2r7I4zUVhsnD6TnciZblbcVMbhfYIYcAPr7SYvcNPG5yCkHXZH04J7vdI5s092hwlOeiAmDuFbXmU2k8ViwNkHOYxzxOFL0PDMzDTb2v6it6MI7HC9eo8qdoXHQoxypvCXj+cQVQ8mY8TUafaRgafQk8QTpuzeW/A1hLaESEm4CX+qD14dSg5z2b0sGlcaLN8/zvoHI+ExeEPD1KdVEyXrZ+wkJS6a8vxeKEU+/1KUyd8tULqpqubu/pO7VTCU3Li+eAA1AYAtiNLaJUWLgmOhsY2zWuV+TvQz3B2r70FM1Ulge7rRXReQMp/1zrDrpe7WUYQxzQhZ/Ptuhoin78riOEBsi7gmjIhLOWPTLE50Z2utHQgXRHULyoQs1MMrENS6GiSef3KzcKv2FzlOIW/yDiw84xv6bMri/oeqYQQeUlINw10l7U0npc9bSkZ4Gn32INVNRIyCsMuTlmXqWB2/fPp35AqO098aXiWhCoP/9h3tlgpMW/ywaXLJYbYIgUnCPSe5BWbsxH89ZpJoU/c6mY06yFSCcslNiaQj0pBV1tmFeX+6TX6PY2LrGvGD+tgtkOqdZFDsPqmYxjOyvDe/TOYIh4oSbIncfNxbjT6SRTD7MPR7A4r3mz5x7/bVp8JB95378eHvk5RIwsGeEz1/Y3eg5bABwzzJ+HPnllW+Dx77qH1eu+iHybqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(366004)(396003)(136003)(376002)(316002)(44832011)(5660300002)(6916009)(7416002)(8676002)(66476007)(4326008)(66946007)(66556008)(26005)(6666004)(9686003)(6512007)(33716001)(2906002)(6506007)(8936002)(53546011)(478600001)(6486002)(41300700001)(186003)(86362001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzak+CNYokVi7ppNWY3S++HLCiOo8isvYfnLt5zJV92MJrQAKpEc4xCX6GU8?=
 =?us-ascii?Q?EzIQKArilgT+fHMoNWoNx0qpG0x+KAP0O7JUafTvma56Iyy6UHYYsnFI0Hq6?=
 =?us-ascii?Q?HAgyLvSARLhh2r2bdSHdbk06qFX1zsS6rb850TCcHHFawf9AYrFawtLJ2Biw?=
 =?us-ascii?Q?RLxGZOAMoUfERaJVKVge/3RfW4nIcES5z3x/zCfJVm+oOfusOULnMftUfvA+?=
 =?us-ascii?Q?aux7nvQDXqZ5LRX4F+c0s6A7HPZzSp/k78BI07Z9wCPXis0+aA8LmXPdzsJV?=
 =?us-ascii?Q?nH3mLtrGwV+ba6Hyc2SJk8qWKRYW2EcFotOVojQ5OOjSLoxeefeeMsA1rzQx?=
 =?us-ascii?Q?+Zwjaq2cbU9F7ggciH0WYc3CyMITBu2VPeFXbIzthNdl59iWjtijvmJSXapr?=
 =?us-ascii?Q?s8ofA50/Exkzw26ssh8G/75Q1hyKMTMwxg+LyIh7e/p+b/nDf/p92slYUOuh?=
 =?us-ascii?Q?LEZFEc0yYCp8B258VI6Z2iKbXm4mCa3y7C8/ywLHDlIW6PkqRL+Lu5hUfsWl?=
 =?us-ascii?Q?JZVG6kn4ogavf14QGZSrVEM8RkZgybzoZqnzMQlrvsSmwwgoWNILGp1C0JYV?=
 =?us-ascii?Q?fmQNcbkjTgoMvRpkyqB4hUwUWIASknzztKTnxGd4LCF/GOluZub21CwLUgIE?=
 =?us-ascii?Q?WWK+VcEQfuEq0Vimci7bwtcScTvYmyAziKMMk5NMAQeOEZ3/5u3NbSKaVFV9?=
 =?us-ascii?Q?VZ6aZsm48CIMnKpL3MQq2oBcNw5QHItaW/JRuzMFLEXC+Ne0JvhBSxxd7iNr?=
 =?us-ascii?Q?R/1/qfRn+4xbGTKnGmmM1lQmpiB9dfaYrlPwaXEnMKbzXatpP9NjGiqaUVDq?=
 =?us-ascii?Q?mQfIAD+zh5+12XQlBJnDSDevFqPISOme64qrouslWd2cBCDeumEv2c5XwFEh?=
 =?us-ascii?Q?/m8sS7b/zmx7bXFXIAGkvVfV4jFh6GpylJfGtscsICSUszbxA16ACE9rUFze?=
 =?us-ascii?Q?moDVhlJ6wPvQlI3vampMJVqwStIyqadoftrnI5kK2+HMU3coRD+AfEL1nc6T?=
 =?us-ascii?Q?Ftl3ClpCIBljZBRVZTBUxFJyyPm0NdWyuaOau4JUc8MiToKrDU5PE/H09fKR?=
 =?us-ascii?Q?dPdoqZwCsFxVEGm3dyp6IjGopCujl/InxiKfE8GcKDBH251lk7Ni1su0Wret?=
 =?us-ascii?Q?G+kL7fl38Aj1Vjx6xbe/CoYX7XEXniK2XG9nME0gA2erpDzk1BtNH5zBkQWo?=
 =?us-ascii?Q?schr7+/TqIMs9xEPlpsegUFuOjovNy0rUdUmNHmEKeeUBi6ocg9FpAd4GZJK?=
 =?us-ascii?Q?frsRaiybmRAx+eki6a36j+JhT/UP6aC66HQ6E7AzDIdWc5TSLEsBFoJ1CXld?=
 =?us-ascii?Q?nh+FqLw5de4PLJ2j7/WkXYJuxnaeqlo0jH4Lkej1Knx2VVN8id27J+6ZgEgn?=
 =?us-ascii?Q?dZZVV86tGuzES0vKHHbsOrpxmsEN+f5s/jJXFN44zIeRIPy2bYY/xV5mTgOR?=
 =?us-ascii?Q?5dUhY63PP338FdJ/rHxdImZBETGXKtDYZwxqikrkNCxisX3FVtTrjJY1Ot/y?=
 =?us-ascii?Q?yEYKigOg3wE36Amp+TtfEXKaSrhgdliy04PnhaDfEoFn+jKHEjoBPFnHN9K4?=
 =?us-ascii?Q?343VizaNiRbB4XUfsdAlDa/Mnn3t7DFH4i9Gol934XhS0GPIfPnraXP4W/ci?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fee558-dc32-457b-9ad4-08da8c58a79f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 20:29:23.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/rETroie5TKqAmzER/sfmu59aZhWmKaijvv22oT9vnX0Orkszglz/0q8/qdUjjDhUddSmFgyg+AioJ1S6SGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010088
X-Proofpoint-GUID: FyClZldPnqK3b-e-w98T0lbRSDmjgNyi
X-Proofpoint-ORIG-GUID: FyClZldPnqK3b-e-w98T0lbRSDmjgNyi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/22 19:32, Matthew Wilcox wrote:
> On Thu, Sep 01, 2022 at 10:32:43AM -0700, Mike Kravetz wrote:
> > Not really an issue with this patch, but it made me read more of this
> > comment about folios.  It goes on to say ...
> > 
> >  * same power-of-two.  It is at least as large as %PAGE_SIZE.  If it is
> >  * in the page cache, it is at a file offset which is a multiple of that
> >  * power-of-two.  It may be mapped into userspace at an address which is
> >  * at an arbitrary page offset, but its kernel virtual address is aligned
> >  * to its size.
> >  */
> > 
> > This series is to begin converting hugetlb code to folios.  Just want to
> > note that 'hugetlb folios' have specific user space alignment restrictions.
> > So, I do not think the comment about arbitrary page offset would apply to
> > hugetlb.
> > 
> > Matthew, should we note that hugetlb is special in the comment?  Or, is it
> > not worth updating?
> 
> I'm open to updating it if we can find good wording.  What I'm trying
> to get across there is that when dealing with folios, you can assume
> that they're naturally aligned physically, logically (in the file) and
> virtually (kernel address), but not necessarily virtually (user
> address).  Hugetlb folios are special in that they are guaranteed to
> be virtually aligned in user space, but I don't know if here is the
> right place to document that.  It's an additional restriction, so code
> which handles generic folios doesn't need to know it.

Fair enough.  No need to change.  It just caught my eye.

> > Also, folio_get_private_1 will be used for the hugetlb subpool pointer
> > which resides in page[1].private.  This is used in the next patch of
> > this series.  I'm sure you are aware that hugetlb also uses page private
> > in sub pages 2 and 3.  Can/will/should this method of accessing private
> > in sub pages be expanded to cover these as well?  Expansion can happen
> > later, but if this can not be expanded perhaps we should come up with
> > another scheme.
> 
> There's a few ways of tackling this.  What I'm currently thinking is
> that we change how hugetlbfs uses struct page to store its extra data.
> It would end up looking something like this (in struct page):
> 
> +++ b/include/linux/mm_types.h
> @@ -147,9 +147,10 @@ struct page {
>                 };
>                 struct {        /* Second tail page of compound page */
>                         unsigned long _compound_pad_1;  /* compound_head */
> -                       unsigned long _compound_pad_2;
>                         /* For both global and memcg */
>                         struct list_head deferred_list;
> +                       unsigned long hugetlbfs_private_2;
> +                       unsigned long hugetlbfs_private_3;
>                 };
>                 struct {        /* Page table pages */
>                         unsigned long _pt_pad_1;        /* compound_head */
> 
> although we could use better names and/or types?  I haven't looked to
> see what you're storing here yet.  And then we can make the
> corresponding change to struct folio to add these elements at the
> right place.

I am terrible at names.  hugetlb is storing pointers in the private fields.
FWICT, something like this would work.

> 
> Does that sound sensible?

-- 
Mike Kravetz
