Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54998559A16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiFXNFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:05:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB751AD8D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:05:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OD4Eac025148;
        Fri, 24 Jun 2022 13:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1czdpQDFV8GUgS972jl2N9rv7RDFc1GokIPyPBOO674=;
 b=LpVlQqSypAtHdLQ6W5+wHCKCbf56WwXaeMfh3ou0Yu7tBppXUX6ZwYHGWT0K6mD2lFRt
 6OA/lcpGRKomlKurwgHmhi+wI0w89UyAyYVEFcxN5pxGTqA6KSStJP6iephxbj7/855+
 At3Zxs4QMgo+qIuBtqXbY6Je91U1pxP8oSjeiDWSEOHBP7j13NObqf2orGI7+cJs95Uc
 tcl0o89k4KlaWSYqXOsmJ47dH3O3n9Nu74aXWBfLczQGwFwB1kTbEmj43zYCx+yGHgMl
 zQMHQA++X8tk+LiaXMYA/KorLUzOSypJiHuR+qNnzuOB7+1P9okSw+jGCfnXS4c3jEe4 cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g25veh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 13:05:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OCeddN027170;
        Fri, 24 Jun 2022 13:05:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth90gb6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 13:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyGflANZjDjl+oJQP2pfpaNCMh0/frP5O72arhUp1LLRwBxQOGiGRKP3EfWLYAXlF2G7iGWQWeAHzj+iTMPnTIm66pCtGYYipTN4I+xxVCHo/avsg16nABrDCfi+3YkMniwNVQD4ibHWK7uj4ImMXMeuPQ1P7Ia6w+jDQPY5mNnqFljnmgVwrqpdNTIhH5nJEq6iLtovNOs7hFwyfYLs0IYduH3d5oWLWy6g+BF2IQNCtjrxVE0dBG2cyvjVNOA0EF500O/Ls5X4v5gcugYCNdB2bmUBn+/gBZJjMB0aM0JHpxKEVa7E9CZlqi6Csk7d2NZ2ryT+N1tPbviRvTA+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1czdpQDFV8GUgS972jl2N9rv7RDFc1GokIPyPBOO674=;
 b=BrMXbdqKl+d9011qFTt8CIZ7fOe3faJO0b30tTGX/4NFw/y6M+cNgqRDoFcfVL0KDVsO3iTIThhFw3+hTzgM6rXrq19pYVL+rDYihGsEnDhW7h6WU9yuskhuErzCGdyLQuftaASu6S3MkfYm9oAnPnrC45S2rJIf/pkJOiaD1TxYx35XdjNMwaGE6N9xocYkI2JJ13qcJufj7TXTYA1XxitgIx7ezznAlNZlrwBAGs5GELYYlQc3wPf72DkqFK1JA+S7gUqZW2MOdjCPLXZj0ggVdriiCW0NvQRDsI5FXKqaqX00LMCe2YoGt3Fxs7U7WKyVHlNKBjtI7bgaph46Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1czdpQDFV8GUgS972jl2N9rv7RDFc1GokIPyPBOO674=;
 b=X2PMbIy+5UaEqIAjFeYsTj8ju9Gi8Io/OPq+iGDpTVZqTABH4vfVSjSO7XvNrOhVki0rhXHPcHNB4hfQIO8gsiBThkABvPHLgu7/IH3OXxsixNhlt2fNF+ZK/L9uiKlZfKXqgbP/o015BBNhw4pod+bUSUz25Ut6D/ZcNwpXBEM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 13:05:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 13:05:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v10 11/69] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
Thread-Topic: [PATCH v10 11/69] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYhbAKYtUZH3yiyEOkqYpCzl27TK1aWZAAgAQxD4A=
Date:   Fri, 24 Jun 2022 13:05:02 +0000
Message-ID: <20220624130455.ygd6sihcaf3okovd@revolver>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-12-Liam.Howlett@oracle.com>
 <e25cb58c-464c-8bd4-c7da-9ab80b49f3bb@redhat.com>
In-Reply-To: <e25cb58c-464c-8bd4-c7da-9ab80b49f3bb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9973489-1b4c-4a2e-1322-08da55e226e8
x-ms-traffictypediagnostic: BL3PR10MB6017:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i/IGAY05yY7lUy8QCPxPtNZrgXVK3YVLnUQ3a5JqccEyUOn6y/tRfh0We2MGwlCRU5MbB19+rthQRKLYbqehtxyfdG7tSb80gwQT57vfdAjqtwEhlqughtHMI5O19jt7ppFTFlfE/VCHoGdZms5/ylxrYaIWS5cnZMYOArcdUU+GIglSpoxVulHcGgpS3mOHx0D9woVTZ/Rz+UylmbeCNXsFzoV8EzpOy4kcutvuXA7u2WguFvtE2xVYHj8lLxjlTEL4higRlo4u5i2KlwIFTu8sCQPPuvdCjQeiCrokE1MSSAvYXH6MJApDxo19/NlCfuTRRYfsIAIgb7mGL0lM5byoQ96VdxkBwzqZhIWtWa9eveNVni2HTUaCxrJd4DS7DQGHX2hCai+xUubR/Ceclo4TZS30x2S3g5lA2MkyCjJ3/2ndVFrKbWVfC4JZgiAU0NsUqAb+RzxW7lg1aeRyxn605tIyZMfRuDwt5mzg3UQmdFr4Kirrhsf8C7H5UpJH8D9kYubq0K774OSxJpLt23i11xZ3vSfgmCu9TSeZWpUGPK9nCG8P4WDRI7aD+TsimU1rv1XpteINfqCM9za++2G6l9YHm2hkVFom8iprQx6xueNf9WMBWbMe+WFVEymtv2HXhwKsPgf0gMwNuGicMwwgwjGQn0MW7vuYvfu3QN9VLvkuaxrtTViSgFeqQO0cSYAID5jIpa3xIVMXbAmBw7wFVQikWrqN7DFQCtk9nMPxg/Z2WHJosOXClByVrq5HwXSZSPjH7CB7DtJ27YBu9D00QOjS7s58YBGW9ZZ+S5tj2cNRZ9yNeXPibK5jJR3dP8abphHFtcpnYHG5Uvth4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(396003)(39860400002)(346002)(376002)(44832011)(41300700001)(9686003)(38100700002)(26005)(6512007)(54906003)(6916009)(478600001)(6486002)(86362001)(2906002)(53546011)(122000001)(316002)(6506007)(38070700005)(966005)(66556008)(66476007)(66446008)(33716001)(76116006)(66946007)(8936002)(4326008)(8676002)(64756008)(1076003)(186003)(83380400001)(5660300002)(71200400001)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CBMvVyXJn0Znkr4wjEBGZuQOuiWqXoVRvrDmNIPyrExqwr/x+3mH+7OsfZDU?=
 =?us-ascii?Q?ZNuPR6JFYr6baJdftyKFb29GfWvtCqigE7JmT5jXObgguUbQRG1SIUJ0JCXg?=
 =?us-ascii?Q?cIFD0rzNazAuhExqfeyMZigPAyDy9AsFudmn3xKqINM9sgeP7+mW0fH+TnQM?=
 =?us-ascii?Q?BdhGKlkB/Japx9rQf7IxCVPYCzTu9TXC0Cs0J5uEl1f9mUCyUnox/oU+XspI?=
 =?us-ascii?Q?4xKchXVInPExQ+7ySuLHV45kU934BK6+69GTFW1FyGMbn6OgZlCDVDQIqa5c?=
 =?us-ascii?Q?cx7F3BjNZ1X/n+m79V5HIslM2ZY5obsRAvBIqXkZ96PQr/ixy6HjpjesOd6j?=
 =?us-ascii?Q?ZxI2+4d7H6INfd3YtDFYTT3FHxeaDU8Elj41WmPJs50WbGoJVVmVOkBhZBa4?=
 =?us-ascii?Q?PLV0Mh9bTvTHRC/wxWs9hYrRrFenyspXOT7MAzc8RwNkX8VZLb1Cu0nIH+AO?=
 =?us-ascii?Q?/yfz5vB+MDzCi5n2FPH3C3j6n4ZFlEl/BbZr5OHLp6HVluOU0FIqhUg7aCTp?=
 =?us-ascii?Q?Lq9pyRKcSsOWPpFxFfQs8fHOVlRwJ8yU7Bgh3I4Lq+TfNvElp965RZxGzja+?=
 =?us-ascii?Q?K6MwSlpplaS+AOoINNjIUWcz1TJ4TsZdl/SPEV/yCNVyArcI7HPsu1gwnqHI?=
 =?us-ascii?Q?zmqMmNbED/rzebvFJ6xhK3grFb3tRHiaI74DJsWrUvE97RcyZqxBlTMwTbxy?=
 =?us-ascii?Q?3UJvafeAgySjSyv8MOpSw03JvhZqk6zCi5BFYuCVz+xaTYAxJQtINQq2CZWE?=
 =?us-ascii?Q?t9opmlANYW572f6ZeHfsVyceFQMDvK3/BUtNVvRc/Zm1ipwBtl9teSzIDkeb?=
 =?us-ascii?Q?DOXRcFBUQDdFO0GhYQXM3SiMuQNqI3g42yhWUAPEEyrsXBoiwuVVW6VWHFaf?=
 =?us-ascii?Q?HrT55h3d9rEEIlWWiS+sIJPEQeXVEs7BMtpH0wqJ9ah7PK5CiCvQTo+dtsLW?=
 =?us-ascii?Q?prc1g7ymLv79gr3JM+017+Xdf60BBM+iU8COl4KBaRLxZNstnurTWkdfCYjt?=
 =?us-ascii?Q?H/zP9iaE8ulqh6CdlJNpqRbt4z4MFGRY127O6YgweLFjQ/cOyd/V1ppBk4yi?=
 =?us-ascii?Q?qajRpG3UKTTQEld+965YL4bLkueRNYTANsRUJCvK+ITdRMoEgIRLm8Z+wJSb?=
 =?us-ascii?Q?3SoNgOkqkwKNMUHgLq7pF4w/b0gFjkxXanw35bw4/Yir2od0l7PNsQEMM2+Z?=
 =?us-ascii?Q?Fxg9pdWJpfvP1xNDz5+iL1blEvorflSrL4J3CqGXarFfv/6yArSdd9kckk0Y?=
 =?us-ascii?Q?MFadTpA16O1ZwSG6elzn7vuh42+znN2qctTnv11oHEPK/2ETnr8r5PWbNqxQ?=
 =?us-ascii?Q?QfRRMaPx5RYceIrbXuHrdXuRp0FyclvZIqt5wZv0NUggfeobgxrJy9jJ/8Y6?=
 =?us-ascii?Q?gI5Hvn86y066alk1s5yYW7HDOcYJczNbseSzt04uqJt6/AiTQ0sO2McnPLut?=
 =?us-ascii?Q?CDGW3h/UGL0ZLvhwEEalXw8CEKF3H2oO1jy1qe3FJKMIwptUeyPEzLKY9NLd?=
 =?us-ascii?Q?72W530Lp9AdwtMf0olM70Qj4BBxM+mXjD5Jw9pszz/ylKdjQjlvhEictV9Pp?=
 =?us-ascii?Q?uhUL+9N7r/kjrKYHPvio3HKTAgrqOc4pIREyh7sFROyTyxBIrkcoyJOwNr+e?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E0D9B670913C644A1DD4692840EFB90@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9973489-1b4c-4a2e-1322-08da55e226e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 13:05:02.9591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxxZsxtspSx5iqj9542zUFh2BlQp9fFbdGeZ03HnhpckUyCsPO81r6xKG+AvIRQpk+2YYoH49mFbnirPDHM4VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_07:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=946 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206240050
X-Proofpoint-GUID: D14-5GW5bRsD9yv1jdLQuwhD3E0tIwTs
X-Proofpoint-ORIG-GUID: D14-5GW5bRsD9yv1jdLQuwhD3E0tIwTs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [220621 17:04]:
> On 21.06.22 22:46, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Using the maple tree interface mt_find() will handle the RCU locking an=
d
> > will start searching at the address up to the limit, ULONG_MAX in this
> > case.
> >=20
> > Add kernel documentation to this API.
> >=20
> > Link: https://lkml.kernel.org/r/20220504010716.661115-13-Liam.Howlett@o=
racle.com
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/mmap.c | 28 ++++++++++------------------
> >  1 file changed, 10 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index d7e6baa2f40f..fdb61252448f 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2486,11 +2486,18 @@ get_unmapped_area(struct file *file, unsigned l=
ong addr, unsigned long len,
> > =20
> >  EXPORT_SYMBOL(get_unmapped_area);
> > =20
> > -/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none=
. */
> > +/**
> > + * find_vma() - Find the VMA for a given address, or the next vma.
> > + * @mm: The mm_struct to check
> > + * @addr: The address
> > + *
> > + * Returns: The VMA associated with addr, or the next vma.
> > + * May return %NULL in the case of no vma at addr or above.
>=20
> Nit: inconsistent use of VMA vs. vma.

I'll update the comment.

>=20
> > + */
> >  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long ad=
dr)
> >  {
> > -	struct rb_node *rb_node;
> >  	struct vm_area_struct *vma;
> > +	unsigned long index =3D addr;
> > =20
> >  	mmap_assert_locked(mm);
> >  	/* Check the cache first. */
> > @@ -2498,22 +2505,7 @@ struct vm_area_struct *find_vma(struct mm_struct=
 *mm, unsigned long addr)
> >  	if (likely(vma))
> >  		return vma;
> > =20
> > -	rb_node =3D mm->mm_rb.rb_node;
> > -
> > -	while (rb_node) {
> > -		struct vm_area_struct *tmp;
> > -
> > -		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
> > -
> > -		if (tmp->vm_end > addr) {
> > -			vma =3D tmp;
> > -			if (tmp->vm_start <=3D addr)
> > -				break;
> > -			rb_node =3D rb_node->rb_left;
> > -		} else
> > -			rb_node =3D rb_node->rb_right;
> > -	}
> > -
> > +	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
>=20
> I guess it would be handy to have a mt_find() variant that simply
> consumes an address, because for example here, we don't actually care
> about the output semantics? Does anything speak against such a utility
> function or is this here really just a corner case?
>=20
> That would make that code *even easier* to read.

That makes sense.  I just don't want to have a whole lot of APIs that
do the same thing.  I'll add it to my list and see how often we see the
pattern though.

>=20
> >  	if (vma)
> >  		vmacache_update(addr, vma);
> >  	return vma;
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
> =
