Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A309C559A24
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiFXNKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiFXNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:10:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA433E9B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:10:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OD4kvB025803;
        Fri, 24 Jun 2022 13:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5EUsxKF75nb373H5i4w5hZ4JUmxePLVjeCKmGuxaqvQ=;
 b=ca+yVVjL6tUedB5H9B3cIm7n25/VkYZF2HJicQSFYu7fHzg3ZxvdkKRNMqDUGLh63CgB
 rIzcLefyEDmFHIzAQh374whTNJrcoIT7tGIGbBCL+R7MdMrCNZqjNvm240NEsFeUqyUB
 JjdwUoCHDg7KMcidegbLjG3CalRbQgNtST8T9FhzRllE6Om95KnXmw0FF6PweLWEuw+q
 AmKcFMTlIaPTJBaPTHZ9I/JwdEuzSGHPiKdjN+zvESp7Kv5jHlT5eOw9cQowS58k6SI2
 I9+eeYp8bGs9EI0QnL3Zq2BI7fJR2gc4ved0RwP6YgI6s20U7YT85kOtS2gvc4TgtvPo 5A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g25vy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 13:10:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OD6jWO017027;
        Fri, 24 Jun 2022 13:10:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3yc1sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 13:10:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm1JKzqgIQB8nQ8uUHY3djTtnpqyw3sbmHhAatcUtHjf22oYSym8F/vM7feG3VPjt0BTFDKWKBwukonTqswqr1t9qHB8V22InX+vJBBpI3gZaUy3O3ZlamWeaU+HVQNBiRYmKzmowxKNRdy6Aw9wr623fm33ozhYs+XLPgMeZCk8sWHIrt6T72z43+3A6Tcx+scunFsnq8Cx//0wQ3BP2mrhnHn/Gb/Car+5C82RkwHkvFPGnqRA+CZqJ1m3dHdRrn3VL13hCfiQPs4cRX/MhIqXF5py4ZU3nraIcA1fSK0lZxV+NV3r5U82tHZGd/8cXSlRiIiq8TccUXetx6SvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EUsxKF75nb373H5i4w5hZ4JUmxePLVjeCKmGuxaqvQ=;
 b=WctOXGgq/rtaH1zrdfQSu8LqWXO+gRB6TX2ekijfZf0hyR4sK6rDdzwfAolajmKIGh6jmRQ1/OFtcmwl/Vm8/F1QOlEtVwuUH7+wkdq8vvBPxY9uHkjvbnVDR22TwwGHC8ybhxFTSt06GK3iiDj/qiEMZYv4AlAcfms7v5mumzhCEEqxx/FwwK7unAXWu9loWuvq2KDQwDOoNbYF2MsFtmx/Hnt0DOpGDSoeygeaZx6x4EtJoX+u8b/CfqQoyfnjgRBK3kNe+6IfWQENVpU6+rvRy0phpTRqGzqT9qxi3j8tQwCz1BqjLYcvoLUq3ExHyp9OH74dqa2pnSl2Lzt0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EUsxKF75nb373H5i4w5hZ4JUmxePLVjeCKmGuxaqvQ=;
 b=wN11HLf6mwT0tB6ztFWBktL+snZV6RqJ6LhPphDiA8xxZjrw3KUraYbniCA17A+OsZiO6fngigYHeaektMEJWSibKsYY6J1rSXYUizWp3BEDbMDuQW+s1dYbtxmQ+mRfONdWIVFiH0g6TW8h1fPsNqWgUkJBY4Tyzt/kAxq3GVQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4826.namprd10.prod.outlook.com (2603:10b6:610:c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 13:10:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 13:10:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v10 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v10 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYhbAKPwckVgdT3kiIP9lsHoyywa1aXCSAgAQv6oA=
Date:   Fri, 24 Jun 2022 13:10:10 +0000
Message-ID: <20220624131003.zydflhstzhx4clty@revolver>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-11-Liam.Howlett@oracle.com>
 <5d3bf51b-3bba-3bd4-db1f-1c0a3930a1e4@redhat.com>
In-Reply-To: <5d3bf51b-3bba-3bd4-db1f-1c0a3930a1e4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e00d607-62a2-4a78-e6a1-08da55e2de47
x-ms-traffictypediagnostic: CH0PR10MB4826:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcKbi5OG07AmsD/23DOv/nPL73jWI27d5xfkBZtbRgwD5G5NHEJcTP3/5qR/oZ8BcMkOsSoY/btp/OqDdGnCd8AvYe7rQKVtsjdITxBdspB9poq0eCtPkeS27po6jM7RWHJaGEDNWMIdurzNa9cvEWbTy/StzW0wV5T2lQaxzKdFzmofEkLZywEviac+BlQ/b1MZ//uwRysNerp7n9/AUZJ1WEl52IvB/xLrFd1nf49YLIzxxtgGZnWgeKWTsn5DDf+9WcY6EVTdk3LUTmIosvKbv1z8AN9B8zkAgaDY6nKSgmp4H66qwyzAraTc1u0wXiM/aDGoLwN1QAfpep+6siUargosI9MZne87BMhDw4HhE1dL4Perr8EBIF3JrhT5iEPEqxppScUFvOFM/nXqdCUPVOJGYnd/LaZIExOXaPrEKnZ7I4HHWw20RSRvovZud9WASuAklHODp6V8EXKIA9tMg4bMNOYRhPosunCIHYndeew5rTqcaGc5ahrnFmvK+6x8AB/fHOO14zDZ0USCuunYxow6rSxofCTT2kYlZiWkhLqhR11b+DPIo/7swHnbAG/hN+AptBUty7Wju/Vw7XCeE7IgL5jJ+b4JVfahtF/2Ft2aNGP33AjMoC2vdKBCIwFZ6MhDjvEdEZFNuGUZQUi8Zd08Q/7Kj/AdRT0F5i2x+H2IJAw/I9VRfRR9Qy0ILNhQ6sbUB4Q69kkZRfEPuzSK735a3OVQ34ybzpZEXQS4pPRv1c9FFU0wtDPsPxmN9V2l6EhsK5or6izs/Al7VIN1ngurKJTgJTlWdp2KkVXF36EbYhtWcs9TFNbaQhAto1BzkCWnI1XDFJlYtwZgTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(396003)(39860400002)(366004)(346002)(5660300002)(53546011)(1076003)(54906003)(8936002)(122000001)(186003)(966005)(478600001)(44832011)(38070700005)(6916009)(2906002)(6506007)(316002)(4326008)(9686003)(6486002)(33716001)(86362001)(41300700001)(71200400001)(6512007)(66946007)(26005)(38100700002)(76116006)(66446008)(91956017)(8676002)(83380400001)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l2lShuprGykUth8jG6ltJ+V+6uPoYBJQH6lMe8OjDhG4P5Bq0bi8p25ScovD?=
 =?us-ascii?Q?RiOvP/fS4WABBAzeb2BwyMUDioXWjfNDY9zPUZVzbWdVdLhMmHfACYW05uve?=
 =?us-ascii?Q?hHS0Y60ErXcdCMWsG5aKSGjPRIjFMlxz52U+UIf+RhOOApeqTk6H9KoA0CLJ?=
 =?us-ascii?Q?//lspAOxuqIlVd+ztb7GMsK3WoFMF3yyNqyXbufYQOl7c0jHtD9bpE8GpIZu?=
 =?us-ascii?Q?T7VUJSxzC5pBEqVqN5UtDUvDsdo/04cwlZwFtE/Y0ALTww3XvdkeBB1/Q2Hz?=
 =?us-ascii?Q?Dsh1JdNOJlHoQ7KoxlWNC07zJY0I5WgbmPeiqqgKNEtyGjrbkC6ZIY6InOlt?=
 =?us-ascii?Q?z+SR7m/0QS2DLWsvTaJ7AowV8N4w4U9ts7oJaLkS/xf7PrMkFpitEmkD1KAp?=
 =?us-ascii?Q?hlj/njY1RlmolPdSmJcgq7Y4E+28/8bipvElLZHf4HPOYuJPuzLZXJ50w/G6?=
 =?us-ascii?Q?C5esAun5WVSnbVIRN5dK7rPxlQJvZIiy2F4orV7JNMfv36PKiARZckchLaeJ?=
 =?us-ascii?Q?iBESj+TMf9HtgwISChSoe5nxcIM+KLKr2A7k66N5UQpdowAbSpVs7gbmPeA9?=
 =?us-ascii?Q?oy5899LzA3Z1jep7KUSDGi+X183InNAJOvKJL5byDv46sQc09oJPRmY/l+Ic?=
 =?us-ascii?Q?GRCWLnPW2a49TKaVUoRpSW4LKCaO7AQQCLLATIsKgBDFXWhuFKMcfHXkpqxF?=
 =?us-ascii?Q?bYRroJMVnyQuR22al1ejcpFd+aXO5TJix9pfWBNe3hzpyvXsqpJ3VimYNByE?=
 =?us-ascii?Q?Ywgt6uMC8Jsw2YmgaiBjPwv/myRB7gfPFGkTbHcPJMwGLH1VFUDhmZqFJfX/?=
 =?us-ascii?Q?yVhW2uKUtxYKnGUUKW5X36aeODLyNoieoHBPr1ln1qLjyVwYmkAAOIOrHv7M?=
 =?us-ascii?Q?pnDmoTyk60Na2P+JPsc17sKwVZwP2POhMgiF62I5E3mCoOvtXb/xuxdzD041?=
 =?us-ascii?Q?KZuN0phJJk2sSNlOAWgmmecN6agHKNHUu9FceRuSIbS6FYcfZ1Vdnj8RmaVT?=
 =?us-ascii?Q?3+zlLTC217haqtet1glKN1p6MWPHTC7+hO2CyEWcszqF59s+W6FyL3f+5OrE?=
 =?us-ascii?Q?M5HxsCLvdtqN1pRtVFDa/n8Sn1lLs9a8EJ5XaIiPV3RnMTLQvd7qkQKuMqZ/?=
 =?us-ascii?Q?+ICi1z0s4E09Ik4LMQKi9My3UgfW9JrWpiHuxAGhCTm3VUutKCRH18s3UuXZ?=
 =?us-ascii?Q?g/0JI6NCjVEd9JXc6yCLcN5dfc7BRTgPEcntKXR1wh+V6v8IwmckhfniuXob?=
 =?us-ascii?Q?9U6Qdf0LzfU8LoMqAjGBKT0alMEf7f4urODPbpIrwXnxPF8Bzgi7xZr+Ld2U?=
 =?us-ascii?Q?xbqw+aBbUUTEJdC3cyQPboBkZ3D0InpkcB1aZJnY4xX5FnPo4Uf05thQUFpT?=
 =?us-ascii?Q?PKAEhnJD3RjkaarQw0ByLVIXtuYAAvRKEyrzbbo6MMFHwGm0roANGCGLJZxN?=
 =?us-ascii?Q?LlJb+H3ltsjZjGCdP1l6AAboMD/tgFCownTvL/kUtBvCkC6Vf5VUkaFtY0oX?=
 =?us-ascii?Q?763CxNgOEpb61WiqfpZ0OGNzYkJLsMhawIGNNMFRMx33s39XSEOlQItymu8D?=
 =?us-ascii?Q?39CZXDft4vYG5PQon+k6X1M8QQMW5ahy4FdTV6oaYFQB90F1RMVPnuzsVUFI?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9D495ED8A27674E90A967CD1C9A8B0E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e00d607-62a2-4a78-e6a1-08da55e2de47
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 13:10:10.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bbFXqYHVs2E3yPcIneWMcDEozGjK6BIymtBHOclYNlY6Emp38IaIZBgMhZ2tw0AgJSgG7RizXzNcH2XgxPJKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4826
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_07:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240051
X-Proofpoint-GUID: 49OxhX8UAQ1mKEVc4DG1a14ZJw9Kkqf9
X-Proofpoint-ORIG-GUID: 49OxhX8UAQ1mKEVc4DG1a14ZJw9Kkqf9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [220621 17:13]:
> On 21.06.22 22:46, Liam Howlett wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >=20
> > This simplifies the implementation and is faster than using the linked
> > list.
> >=20
> > Link: https://lkml.kernel.org/r/20220504010716.661115-12-Liam.Howlett@o=
racle.com
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/mmap.c | 24 +++++++-----------------
> >  1 file changed, 7 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 6be7833c781b..d7e6baa2f40f 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -675,29 +675,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned l=
ong start, unsigned long len,
> > =20
> >  	return 0;
> >  }
> > +
> >  static unsigned long count_vma_pages_range(struct mm_struct *mm,
> >  		unsigned long addr, unsigned long end)
> >  {
> > -	unsigned long nr_pages =3D 0;
> > +	VMA_ITERATOR(vmi, mm, addr);
> >  	struct vm_area_struct *vma;
> > +	unsigned long nr_pages =3D 0;
> > =20
> > -	/* Find first overlapping mapping */
> > -	vma =3D find_vma_intersection(mm, addr, end);
> > -	if (!vma)
> > -		return 0;
> > -
> > -	nr_pages =3D (min(end, vma->vm_end) -
> > -		max(addr, vma->vm_start)) >> PAGE_SHIFT;
> > -
> > -	/* Iterate over the rest of the overlaps */
> > -	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
> > -		unsigned long overlap_len;
> > -
> > -		if (vma->vm_start > end)
> > -			break;
> > +	for_each_vma_range(vmi, vma, end) {
> > +		unsigned long vm_start =3D max(addr, vma->vm_start);
> > +		unsigned long vm_end =3D min(end, vma->vm_end);
>=20
> I thought using max_t and min_t was the latest advisory. I might be
> wrong and simply kept doing it that way ;)

They are the same type so I think this is okay.

>=20
> > =20
> > -		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
> > -		nr_pages +=3D overlap_len >> PAGE_SHIFT;
> > +		nr_pages +=3D (vm_end - vm_start) / PAGE_SIZE;
>=20
> PHYS_PFN(vm_end - vm_start)
>=20
> >  	}
> > =20
> >  	return nr_pages;
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
> =
