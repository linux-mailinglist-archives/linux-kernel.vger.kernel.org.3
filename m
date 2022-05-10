Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B0F52207E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346855AbiEJQDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347958AbiEJP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:58:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A834C8BE1A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:51:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFUTjA024470;
        Tue, 10 May 2022 15:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oRQvYx1MkVxp3p+YQxATQDftVQoPNodIifqbJ1Z4tH4=;
 b=Si9FGecQ1UmmUZ3vAETA7CVFnemwpv+yTTJ6dDO/WV2PrK+jYvXq3T+XZP+gyj96SLmm
 ErJfZPhceOb6KiyMfu6RR6BTdpR93/CN3VCFObO+SXRXphTF3v1hWTjHF4dTodXyQSt3
 c+V7TS7lOh+8XWMirKZ0ClhWXZqtaxSLgoPjvVHUYi/nbPuuDUIVlcyZADO9jDvfnqTb
 C17soUCqVjF7ROCr5BT4nusbiPMDF31fdbVIrPn4mT5tey+LNxmqpuHLEcVp9ipI9Ytf
 gdpP34bzqAR+BufwfKg/TU1Ik6EVrqhQBRmqXtr1qxzlxmQpL9LnzyIXtJOSYGgKzEka Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0q6gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 15:51:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AFV1dZ033648;
        Tue, 10 May 2022 15:51:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6dpeut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 15:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu6UWrDL0VrecNHJqNfAl0wNKVwzo2ikJA0hx4vnaQcm+o6q51Il9ycVcWKlBS1+ns4KfPn6j6GlncHvbj36SI7JDKgSv4A6mpI4KRCQhQQL1cgHdN1WtS2u81ZJK5MiF5ZdbUkB0Uvhxp2kXUCISJvf4QPiFTt3A6OlOdLK2rEpNtWye7VmywOEsnCCMmfCIbDt0/xFd9nZsS2ou6YpeUDduoS7Dx5W3g8Pr9CgSWWGq9X5PYlYWqlnLkXf2dCTlv6bk+JG4mE7yczYN+1/4cgP8hH5CLUvB964Uno06f/uD5hiKZuqLa+Ouu3vYVF5Jopxl26+msyiArMiBn5fSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRQvYx1MkVxp3p+YQxATQDftVQoPNodIifqbJ1Z4tH4=;
 b=c/c2md7sifnA0dRwitsPTLs071cBSVHbODrEIju4281Bnha7vuKak8nBCpyAVfyLID5K39BN4uMc6q5M6HUsvrRexkUSH1oL+ZdkHyP5qutE9V4DAyE01btuRBayhDSEt4Ry3ie/eM7+l7aTXRi6Av/nC/XakJxD0O+VMdz+zKHSktSYFIbhZJRUWrQnxfcgU+fTb1hYSw1Me6iOrtdmgP7vrDRrjhYTIdY8zEIJbXeuJfeQ5H1ffF0APN2Au9zAP3B2qo5cScf+C4m9f5QpNnkYu4EbAIhASW5b0uiWWhg+2euSp0EdqGnWMcFmKgvU8yvurulub9gJXRdxuEYt6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRQvYx1MkVxp3p+YQxATQDftVQoPNodIifqbJ1Z4tH4=;
 b=ypxa1a51u8N5BR+dDQMSVBI6LdAJRK2RKXJz6ixPRAvVWGpiejOJcmF6EQf2WDR4jVoMxjH+VDbgUB7o/1kI3Ta6/laV+pc9f327BYaZzjUxvblW49M+9iZdUQAR/nfz7GAd7XissH3P7KN2S6JDhGxIJvPRNrs3+DHFNWIve7k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB4102.namprd10.prod.outlook.com (2603:10b6:a03:129::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 15:51:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:51:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     SeongJae Park <sj@kernel.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Thread-Topic: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Thread-Index: AQHYX1NhZKDMPG7C/keyeY6aTlfpJ60X9VOAgABXgoA=
Date:   Tue, 10 May 2022 15:51:06 +0000
Message-ID: <20220510155059.yaxjjxjwnbmzoyux@revolver>
References: <20220504010716.661115-10-Liam.Howlett@oracle.com>
 <20220510103747.151886-1-sj@kernel.org>
In-Reply-To: <20220510103747.151886-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1a4385-843d-4619-86a4-08da329ce53d
x-ms-traffictypediagnostic: BYAPR10MB4102:EE_
x-microsoft-antispam-prvs: <BYAPR10MB4102DD0BD24897429B593D6DFDC99@BYAPR10MB4102.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FGQGvqbiUYtoSI2yGmZk6HwB+J2WjlhT8YmGUpJIk6+vyH8u0sQcQNU4S4oC2/Huif7kYQTNOAwUgv7HuMhaB67CS8SKZkG8MQVCN49KLCbmvxmdbHYVZVr7IY5o6aa1uniQ9r3jyMECW1o6XZoadpqmcp6+x4VDI3Et8+6YXQgWDcJs1NP5e/wWfUfQJgNrYUVmeh+o4+cEjV0o+t73M0t5qWnWXFkfODNUgvHdDPbfkkRHShzO4GtU5T2paKJFvhGVtHmyqS0RJxRYr0mXOZj/EpXnUfmGvh/Q93yY3CbWd67BAlw6JXUrcPO9CVawfWp8s62Eok8VshKnQGLCCez6mV/fK9xD2UvYIvic9uWdtJ9ohiZNRDdAmEqUynlOO0SbOIpivOUlFspqbBInLbPr3nTSkHjwI716qy8jiYqxI+3kUwbJsSKOBQSOzlvYA5AOAK4jsxce5lAYn1fEMBFSU8Pj8smO8VPLxYmenVpLyN4lDlldv+uceKsMIafQTrkDl3RJ+/VU2JoeQOlXOHbZMFKcn0ogQsHdzWbBrdeiaQiOsxmuR32WwEFlbNR1HhZ81ONKUC9g49MfozQjoqfRhwbgUfOsPdu7mIz20xLPH0UjqU2mk8+356QMHrI/I0yLKbMBNGM+ya2DFSD6nzSFj0howv7gcg5tzHDlTrWns7b2XD/otA0TCrUj0b92GOEqzQR4W3SnZ2h8HW2jNwVm0+LGCBLdXn5DOEu5dAIgJFA2E4pxSSTEk7JpBGJadeK4FOLhaHbvIcGFXKUcNR3KdEHw/d4s2VHu1RI3wLI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(186003)(66946007)(91956017)(66476007)(76116006)(66556008)(8676002)(64756008)(66446008)(508600001)(1076003)(4326008)(83380400001)(86362001)(71200400001)(6512007)(966005)(9686003)(6486002)(26005)(316002)(54906003)(6916009)(6506007)(8936002)(3716004)(122000001)(44832011)(2906002)(5660300002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5y+cgeEcpZs/XO8krtpVPkIRwNBC+NBAEp6yvewdnfb89eBN1L9v5yJIuHVk?=
 =?us-ascii?Q?vjAtgZM9XjGjJalM3c3iAi//e3ptDtMN7AVjlwff8bYhF4roZe3K8CDX2Ud/?=
 =?us-ascii?Q?euig851MmL7GLMU6auIr4L6NDlZ4NbDZvUKQljWQPyko3eC+1jzwhNdfd9cw?=
 =?us-ascii?Q?RCdT3pGXoSpfEepfcf+dx/JmzrepM40zCz7Mk11GlTNsT1sOzXk6GnOKH//y?=
 =?us-ascii?Q?5GBHNfRp4TLPJ/OtnQS5JVP4q12ujNB5mSc/V2sRwOR33ApfbXtosA3keWvb?=
 =?us-ascii?Q?41F2O048JLWwXU4xET8e5+e16VhK+wtHh9POBbEe9L2Nj6xM/+vy7Z9QR9hc?=
 =?us-ascii?Q?vdiWndAi9TIULZCzjPee6qroifmoYomgEFzEaIIFh1OOrK9NrLvy5HAz7miG?=
 =?us-ascii?Q?pqtlOmV8AluK/fpZ8gUCS5LBUqZQT7YW7mriQA/ge8cn00vL66OJbdjnpGpk?=
 =?us-ascii?Q?hkJfx6ujqKCSFrNMBXVlLfii466LUcj2qirxIRxwr64Qrb58PVYRNgIkOnwx?=
 =?us-ascii?Q?NNADzARUeT5VeyhsC4HTpunBl3S6CCEHqcbyEY0IQSKbZFMXXPswi2eQO1Wl?=
 =?us-ascii?Q?cl0KSWqNuvtWks7A9/TQhGI11+0y2GE3vTn2ryGX8Ug9oWE9duA+sGyIjhTZ?=
 =?us-ascii?Q?lEP6NpNZH1OM3ajXaAa9NvNTsyzHlOAD5SCBzwGkiskICpRn0X0QaKxzA3JX?=
 =?us-ascii?Q?ltS9RXhE8/VuXPWgKI5IWJXlikBPfLfB1UGmtcyxN79/vV9xXR5OyERVbEbv?=
 =?us-ascii?Q?B1ImK0igZJXDpJZ0R7iRSVbHFgpbS+ib5jywISYocE7Xc9WFWjOFzonwtMQ3?=
 =?us-ascii?Q?pUo3QCkamW0pVnvWIfI57y53xly79H8JWlt1DUeUQQ+L81SkR5e4DOVGZk8n?=
 =?us-ascii?Q?EbNojPwlSywAvkPNV19HAYL2XcQGaWclxr2BqP9DZJy9b56Xni4lCV0YIKbf?=
 =?us-ascii?Q?iva6ZKMNxHzqeDAjM61FEUC6pomnDcJQIvXb2hSGF5kckPfCAX1+qqxMqb0n?=
 =?us-ascii?Q?gMnAsdchfjIy5EVhKF3c0KqJ5B0+Mznqd40zR/ncA74uAovLGyru/kGwaMCp?=
 =?us-ascii?Q?yaXBJUYaENE/X/zoZCxYgZJVgPE6RFtrjRoodpzfGPZ97DpLpn3/A6Lu4jo+?=
 =?us-ascii?Q?OQIEeBBi2dW1BqvJEpbbiL8xVQgnBzS/03gHlWm+6mvdfIxWNxEjv4kj1FUI?=
 =?us-ascii?Q?IShb17EuAeGA0UbdOMe00chyapdvyqx1OQSPQ3suWw2AaU7ZyzBY8Bit/y6u?=
 =?us-ascii?Q?B5JB3sALBKHqI1m2uxpfQtkvh7nrCFA3vkUXwimleqYo/6sSLOaQ1v8H5BpQ?=
 =?us-ascii?Q?IPMlvjmaoTpaYjBWThCVqVMcwwc5ubaLZKmD7X3/DLxKp1LM/jQnCZUwWTrp?=
 =?us-ascii?Q?0S9HfWk4D+HvwClE/wGL7zggyVg4LPXnTuwRp9bAIqSl56xImCWd4fRoO+zN?=
 =?us-ascii?Q?9sduF1NQSQeNyF2Rr0iJ49LMu5Tb0fj/9sQ+/nQnagNZDj7nmAGvW4Mh7r2c?=
 =?us-ascii?Q?tM0DXTKKH+8ptlJ/Lb8T4kezCd7K065luk2LkSUprozLa2yzT9qaxuwl9LVJ?=
 =?us-ascii?Q?phOn1hYHdrDOn0PFDFu7LJkDjTfqD6yEcBnKcGElp6QXeOzDmXQPj8Cdvrvs?=
 =?us-ascii?Q?4iy++ddMJ4+MvEiwYr48Wy/Lulubo09ACqvBvfis8VOajkBiM2000m1s02dt?=
 =?us-ascii?Q?eh/3rd6ZADKDbigMEVh3H7LQ4JsTrHlh8tnjBYcBHrjWjCotvWlj5KRud1Ug?=
 =?us-ascii?Q?F8h8NE1H3n4swd/gyad9vzjCUZybhh0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EF619579EBC8A4099FD60C13B01BF3D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1a4385-843d-4619-86a4-08da329ce53d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 15:51:06.8335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vTyEbDtNOq4fvujg8QGx6J9TkOb+NBbCCMZc4z2emWTflVwrf47aG3EPSABTdS9FxjmDNZwEBSmaTvdpdk6MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4102
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_04:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100070
X-Proofpoint-ORIG-GUID: U_-pXSpnjJiUt-uYIfjqoAuHdZZ6uCXB
X-Proofpoint-GUID: U_-pXSpnjJiUt-uYIfjqoAuHdZZ6uCXB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* SeongJae Park <sj@kernel.org> [220510 03:37]:
> Hi Liam,
>=20
> On Wed, 4 May 2022 01:07:52 +0000 Liam Howlett <liam.howlett@oracle.com> =
wrote:
>=20
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Start tracking the VMAs with the new maple tree structure in parallel w=
ith
> > the rb_tree.  Add debug and trace events for maple tree operations and
> > duplicate the rb_tree that is created on forks into the maple tree.
> >=20
> > The maple tree is added to the mm_struct including the mm_init struct,
> > added support in required mm/mmap functions, added tracking in kernel/f=
ork
> > for process forking, and used to find the unmapped_area and checked
> > against what the rbtree finds.
> >=20
> > This also moves the mmap_lock() in exit_mmap() since the oom reaper cal=
l
> > does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  arch/x86/kernel/tboot.c     |   1 +
> >  drivers/firmware/efi/efi.c  |   1 +
> >  include/linux/mm.h          |   2 +
> >  include/linux/mm_types.h    |   3 +
> >  include/trace/events/mmap.h |  73 ++++++++
> >  kernel/fork.c               |  20 ++-
> >  mm/init-mm.c                |   2 +
> >  mm/mmap.c                   | 323 +++++++++++++++++++++++++++++++++---
> >  8 files changed, 396 insertions(+), 29 deletions(-)
> >=20
> [...]
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index d7e120ad5825..e777da0132f6 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> [...]
> > @@ -680,6 +744,56 @@ static void __vma_link_file(struct vm_area_struct =
*vma)
> >  	}
> >  }
> > =20
> > +/*
> > + * vma_mas_store() - Store a VMA in the maple tree.
> > + * @vma: The vm_area_struct
> > + * @mas: The maple state
> > + *
> > + * Efficient way to store a VMA in the maple tree when the @mas has al=
ready
> > + * walked to the correct location.
> > + *
> > + * Note: the end address is inclusive in the maple tree.
> > + */
> > +inline void vma_mas_store(struct vm_area_struct *vma, struct ma_state =
*mas)
> > +{
> > +	trace_vma_store(mas->tree, vma);
> > +	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
> > +	mas_store_prealloc(mas, vma);
> > +}
> > +
> > +/*
> > + * vma_mas_remove() - Remove a VMA from the maple tree.
> > + * @vma: The vm_area_struct
> > + * @mas: The maple state
> > + *
> > + * Efficient way to remove a VMA from the maple tree when the @mas has=
 already
> > + * been established and points to the correct location.
> > + * Note: the end address is inclusive in the maple tree.
> > + */
> > +static inline void vma_mas_remove(struct vm_area_struct *vma, struct m=
a_state *mas)
> > +{
> > +	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
> > +	mas->index =3D vma->vm_start;
> > +	mas->last =3D vma->vm_end - 1;
> > +	mas_store_prealloc(mas, NULL);
> > +}
>=20
> Above two functions were defined in internal.h in v8[1], but moved to mma=
p.c in
> this version.  As mmap.c is compiled when CONFIG_MMU, build fails when th=
e
> config is not set as below:
>=20
>     .../mm/nommu.c: In function 'add_vma_to_mm':
>     .../mm/nommu.c:575:2: error: implicit declaration of function 'vma_ma=
s_store'; did you mean 'mas_store'? [-Werror=3Dimplicit-function-declaratio=
n]
>       575 |  vma_mas_store(vma, &mas);
>           |  ^~~~~~~~~~~~~
>           |  mas_store
>     .../mm/nommu.c: In function 'delete_vma_from_mm':
>     .../mm/nommu.c:599:2: error: implicit declaration of function 'vma_ma=
s_remove' [-Werror=3Dimplicit-function-declaration]
>       599 |  vma_mas_remove(vma, &mas);
>           |  ^~~~~~~~~~~~~~
>=20
> Was there a reason to move these definitions?  I confirmed moving the
> definition back to internal.h fixes this issue, but I'm unsure if that's =
the
> right solution.
>=20
> [1] https://lore.kernel.org/linux-mm/20220426150616.3937571-10-Liam.Howle=
tt@oracle.com/
>=20

I moved the functions as they were dropped elsewhere for cleanup.  I did
check my m68k buildroot, but the buildroot seems to have not pulled the
new code - it clones the repo externally.  I just changed the branch to
use mm-unstable and that is indeed failing as you see above.  Your fix
is correct - and I believe it also means I need to leave the damon
change the way it is now.

Thanks for catching this.  I will send a fix to change this back after
testing.

Liam=
