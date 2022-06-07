Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3334A53FE35
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbiFGMB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiFGMBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:01:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4531C9EC4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:01:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257BD9MW009064;
        Tue, 7 Jun 2022 12:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=awTV/DKnjv8QPAInRY2cryBJuChS1WXh7UFsTMWhR/U=;
 b=es4mENhWOHvzsp1nGA1UflJQWH6zc/0c6jKemQ2slgtiCqmLATs9GkrMBjzAmjCJE5pG
 N8TXJetZzbxszrxLhDQ/OjHIvx68o/PD+aLxHseXuMmrFcBl56qOXX6HLRsNAYK2k8pD
 CUbZOnKgucHFES3gyGkg7XLme7VdaHVKc9EGgIYDMW5ig/OYyY1owC78k9qfQwwEx6rh
 Pd8l0PNl4n/yYTRDSE472yCvDPSS/C+gfdsG+D4Ch1K8gmO/kRWwwwM3deGF+jLj7D7U
 a1hrGjLUl3Hn2pDBcKR7+cJ7H1gjftyM1Lcm8XKkqbidWoBUeQImWg1ZVnOXUJfS9F+q eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxsdpx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 12:01:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 257BuGAw003643;
        Tue, 7 Jun 2022 12:01:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu2ykf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 12:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjIHYUq96K2w5RiPSlUjxjg7FX65X1dbgAO0DP5jaai0/cHeCUa5KPPTW4dV+heP2cB8uEDwux66ZG7bJPs/cK7cCyUKGPQerGxIiHADdpevnfvyk6XCsoyrvPQydlDcDvg03rTtpVjl4NhAouvgJ/NZYL7t50qaX41/cvBXpP227DBM0WSdOhBxR+wMh9kZZWZq/rAx/AdrEKseX1gkMPsKVz9psC8jf+KXeAMUEAkPwSpQkXpXizGhMkOX6ztrd1WOuEaIOqzIVSOzQ34R79kzHAkmIGxRRjiIqLny1uRCMKTjUq0EIKBvJRT//8r2qpPhH6dFh0sDu0EeEx+xhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awTV/DKnjv8QPAInRY2cryBJuChS1WXh7UFsTMWhR/U=;
 b=cWKoNtq+Kx2FWd19hkucmiwuuh9SJyNcUdKTdoZkGwNvPjCxpHPbSHS5laMSs/vBh0uOpAks31vP/Ps4RRJ6z/YWoivfmMxNVq9JDT6p4sv/me0G3BzFJRneS9VH3La599gqBdGgOLQfMHMsYmbEw/U4Cjy68Urzu/+TfGmVcMMWM8j+GvuNqaLqld1ycNysXlKq4l+99VDhUeVQ9RkjL0+la1CHzds8NTyp67VplqfC6tGbk1YTGTg5y9Jo8U8OB34Se3rivWL6MZ3TZXD4wVj6UEYFuBcpIXJjigC4N9l+K+0WSf0Q4re877TcT4lTPFIxVYdWSVi3JZ62eRPQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awTV/DKnjv8QPAInRY2cryBJuChS1WXh7UFsTMWhR/U=;
 b=Kx3cUNxV9LjGyj1FnEQUTSaapn2pCc/DzmSCazmE7++pbGwlScGyI1wJfxnzJGrRliXFcs203gSnM+fFlO/3VSEbb/rRwUn5DP2gePj1LiMEWLrGBN0p5fc30cvntqC/Tom7sIfYVW78jdiBfuSAy1Fcin8ZwmtgnoHEqWjFaco=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 12:01:33 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::58f4:fd3b:a183:ae63]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::58f4:fd3b:a183:ae63%4]) with mapi id 15.20.5314.013; Tue, 7 Jun 2022
 12:01:32 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] mm/filemap.c: Always read one page in
 do_sync_mmap_readahead()
Thread-Topic: [PATCH] mm/filemap.c: Always read one page in
 do_sync_mmap_readahead()
Thread-Index: AQHYemZTwb0pvCG8ykyG9sxHdc8RDw==
Date:   Tue, 7 Jun 2022 12:01:32 +0000
Message-ID: <8EF5F030-FA56-4124-B3D1-D4B1A536DD7F@oracle.com>
References: <20220607083714.183788-1-apopple@nvidia.com>
In-Reply-To: <20220607083714.183788-1-apopple@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5729671-9302-4fb5-7009-08da487d76ae
x-ms-traffictypediagnostic: DS7PR10MB5039:EE_
x-microsoft-antispam-prvs: <DS7PR10MB503936B571A11C30DE8708F181A59@DS7PR10MB5039.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 41ytWzaoOgCNIZ9c4ekN1NmAzAq6YWdGmVOGKKu6zFHwZp08owLOltXtSPKZZ5pkg2gF3ASeeTNNmjtJkiWg5WryvTq+XzKPUpXsnrAdclEYzfNs3OiWCUZOdv27/GNDI7ClSWs86VU2qVhHfX+df3gv72Npomx05E+zoc4lLZv1e43q0mQDTs93A3ocmCmdJIQWhoxOdv+S6W6/7HEE+ZK3Ud2VBNaB0IgC/rlvKhCDfRr+Ra2KSOuOZvD8lSAKNuO4gbmPm2P+tXSD+MsmlR0yEcaQobxOHuwhOJLIDj4H8iEbxDYKbGvUVoxMkMLbDZgrZdbO7y86K7OMITXMAvetCEMul3Rfb/W6kJFSyRYct9l8hb16kOq1jVZsSVFmsc1u+X2j5TQgqaKtQaS26fezh9lcZMX1V6z2DLA8Jbt985btIZifiMLi6FY3d/+ZOegZu0lhS3yoZ5YEq5C1eNlDYZysDG0H1HD7jR1yNqpXzN1JS8v3K87moP9SbuXmnQp8Bcgk7eJxz/ehef3cR89a9YEykZlZmHTlV+5/MlZgNi+Zz4RPN54aEMtnsS2x3g8AcDCJjWPsV0REzDR5bBwNIIv0VjKQMMl/McmatwpZLsrPVGC24qXxsjvEJer+63PXt58DksYB56P6jmAQAHUlTX6kmYpbv8C+PkegDi0JKNcLcLu9SV9/P6B+xP8E6wiUuRwXkL/zhJ0mMFgSFaP7hyTMwIVsxyRfrCMHrr9T52i6mNSDeo/L0CXDLQtq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(316002)(53546011)(8936002)(508600001)(5660300002)(71200400001)(86362001)(186003)(54906003)(36756003)(38070700005)(122000001)(6486002)(2906002)(33656002)(6506007)(6916009)(44832011)(2616005)(4326008)(76116006)(66476007)(91956017)(66556008)(66946007)(8676002)(66446008)(83380400001)(64756008)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jlWz3jbRNFUVyg2QI/d+tGSGW0vvbQzKFiB4lbC1JYWU2qw/yWCdoRhdhgGb?=
 =?us-ascii?Q?R1pO/Yv9z4xADbRnDxFD2PzvF0nod22yq4XoJYvJtgwPSLlprZZ1v2gP+KnD?=
 =?us-ascii?Q?uKFyxGEQp8Gta0INermv5vVrVIzXq3Qe7jgU0mnVp6/EuBRntIJy73zYBODI?=
 =?us-ascii?Q?tzmWxAalfyHK8EF62xuxTt1Z529aV7ZdvI6x20HavTI70sYR63IlaHHAvrND?=
 =?us-ascii?Q?1xRLlqcf2esQmNfpwhyvwClguJiO4yyDET7ELO38fbJKObZJ3V1QUNPwCEzK?=
 =?us-ascii?Q?a1t71zMPE3GzZPE3VHQE3YPcf61w/sDeJb3s7EmZez/M0NaSS61YdyOPEyCN?=
 =?us-ascii?Q?epAfjxvRd5FFSjO+oKVZc3tx5pK25t9BBWtzSJOAq6vxLGZ5cS377zfLZR62?=
 =?us-ascii?Q?7C18Ut7ULOh8UhD/3R285fIUDoQ0ePXdQ7+dM+LRpziA3y48z8oAMXFrbGD5?=
 =?us-ascii?Q?2WgWqDeWBwd79N/WOUJoD+VR++s3Qmt4KBHweGFsgsNuSfaPS7fZTPAZt4o2?=
 =?us-ascii?Q?aUeQWuL3amhG4LZYinrXU8pOT6ywU19czJ1OCqASJJC7lICVJtOMrQAUxY43?=
 =?us-ascii?Q?oVG0U+00yZiOwaZiVPfljeQuMijaJbtZD0AOTTtvAvCvPlr9P3bpW2LVPNYA?=
 =?us-ascii?Q?NmTSAxdUW438SnDW/npxdxhx6E0YFXvw9X9zR+nMRn7f1MTII1tD6jfd0oTE?=
 =?us-ascii?Q?WQT/pSA+aNyHNa8OcnS/hIyk3YWKqlV/22MHF+e3RFS45hb03T2y9WMpNJ+3?=
 =?us-ascii?Q?RZ+Tq12+zxsG5q9y7ew2cFQK3N3vjl5vtUnrZSskxZSQscB8fwHTLK1rKGdK?=
 =?us-ascii?Q?4E/3vCTafQxEIKImwp84+gUXIM/klExgHgEPs7QMjjJu1ZbO6CNMRQJ5OPqY?=
 =?us-ascii?Q?DR25/oOa305AUEqY0PSNNkcP6YKIXlUEixmp6oMBe1sn+r6emWSNObYjyJtY?=
 =?us-ascii?Q?U1ujOr8Dwjs1OJDOzL/Kk5pr7JLrIYJvUXm4qF+OJRyoB9VtJhXtmEYSNvkm?=
 =?us-ascii?Q?JMrnwTQLgt+OSLtFpw9JRI9/6VSZXSGDXhPmj9MY3oDeHv5sqmhMybIc0dsr?=
 =?us-ascii?Q?gAUnVP0gs64jbpzjmuYtsoMsw5M1XrAOCGEljZJFx5XLtrd7vo4xmOkTsoqG?=
 =?us-ascii?Q?teLCQtMcM2vxF1XCCknLEEsJ1ZLUscwBUVZcrqDbCSfl/sytLTHrZ1l61Z0i?=
 =?us-ascii?Q?ZmG46IlPZdZxwg/wQr+sSNWV/kQyCRnoH7KaD9+zVfqJO7Cwd9MiLkP4xVdo?=
 =?us-ascii?Q?ISiHEXupr/KTfKAyzWveEctlN7RyrkjEzlQpbhjjGlDxD9LdzQ6YKsbIPlaD?=
 =?us-ascii?Q?0ZxZDD1oSsy+Dini/Jfk41Pfwuks9n/qbFq0P1be5fiJ7K9/0ENkV8cJe28x?=
 =?us-ascii?Q?MxHFsP7Fz2+qZkBgrPfTdRYtxJIvLuF6C/3e8Jskfygu1dMz6C05iQXLoPSe?=
 =?us-ascii?Q?SVv5p7SsD+blpvrLvaRuc2O27aO69K0uORXDykv5hLQ2aSBbj3Aq6NcJiwVS?=
 =?us-ascii?Q?765XxuAacYUizKYV/0/Fa7BPWOyQ0Uk1w5KJSZzKhe+kUkN87Ka03aGbBaQ9?=
 =?us-ascii?Q?IMh2Pz36XJylnrsyJIS0ux9htKu86SbYWWUTGtTvAOCR3i7i3ASUCA+17693?=
 =?us-ascii?Q?gWv1N6HTHPohhqmkoUEBur6TL8tZy25plkpWjkbN3am00xUEoV4ybzxnHgjM?=
 =?us-ascii?Q?UNCoe0VpK73Cox5N5A6CaYXteMC/cUQOpJ53JjMLos1pERhsDjU1ZHAlDozn?=
 =?us-ascii?Q?tcOi4JhKAefsq++st5AxlY/v+ckRZEssmn7QtXGxeSARbFV6muCMLvHyNQjq?=
x-ms-exchange-antispam-messagedata-1: wtJqOzvJpses2cK0BFYxOK+hkz1YMJOcycIcwHkGSEKNM40qJ4XooZYG
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CA8826C784E2C468B8FF61B8DB1DDDB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5729671-9302-4fb5-7009-08da487d76ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 12:01:32.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKIXVjsCIesvpPAnJGuptpuIorW7a5IC6AcKETZqGWM2ldFgUQ2wlIg/CZ1jwzMFRL672lwdjnJjG/NIm+cPmmrgwv+WJuu/a4F02zzyiAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_04:2022-06-07,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206070051
X-Proofpoint-ORIG-GUID: 8cSVb5X_DIbAKt8s01b2jZwFc-0HV4G2
X-Proofpoint-GUID: 8cSVb5X_DIbAKt8s01b2jZwFc-0HV4G2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good, a nice cleanup.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Jun 7, 2022, at 2:37 AM, Alistair Popple <apopple@nvidia.com> wrote:
>=20
> filemap_fault() calls do_sync_mmap_readahead() to read pages when no
> page is found in the page cache. However do_sync_mmap_readahead() will
> not actually read any pages if VM_RAND_READ is specified or if there
> have been a lot of page cache misses.
>=20
> This means filemap_fault() will see a folio that is not up-to-date which
> is treated as an IO error. The IO error handling path happens to make
> VM_RAND_READ work as expected though because it retries reading the
> page.
>=20
> However it would be cleaner if this was handled in
> do_sync_mmap_readahead() to match what is done for VM_HUGEPAGE. Also as
> do_sync_mmap_readahead() adds the newly allocated folio to the pagecache
> and unlocks it this clean-up also allows the FGP_FOR_MMAP flag to be
> removed.
>=20
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> ---
> include/linux/pagemap.h |  7 +++---
> mm/filemap.c            | 47 +++++++++++++----------------------------
> 2 files changed, 18 insertions(+), 36 deletions(-)
>=20
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 993994cd943a..e0e0f5e7d4a0 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -505,10 +505,9 @@ pgoff_t page_cache_prev_miss(struct address_space *m=
apping,
> #define FGP_WRITE		0x00000008
> #define FGP_NOFS		0x00000010
> #define FGP_NOWAIT		0x00000020
> -#define FGP_FOR_MMAP		0x00000040
> -#define FGP_HEAD		0x00000080
> -#define FGP_ENTRY		0x00000100
> -#define FGP_STABLE		0x00000200
> +#define FGP_HEAD		0x00000040
> +#define FGP_ENTRY		0x00000080
> +#define FGP_STABLE		0x00000100
>=20
> struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t =
index,
> 		int fgp_flags, gfp_t gfp);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 9a1eef6c5d35..15d7e0a0ad4b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1922,9 +1922,6 @@ static void *mapping_get_entry(struct address_space=
 *mapping, pgoff_t index)
>  * * %FGP_CREAT - If no page is present then a new page is allocated usin=
g
>  *   @gfp and added to the page cache and the VM's LRU list.
>  *   The page is returned locked and with an increased refcount.
> - * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
> - *   page is already in cache.  If the page was allocated, unlock it bef=
ore
> - *   returning so the caller can do the same dance.
>  * * %FGP_WRITE - The page will be written to by the caller.
>  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
>  * * %FGP_NOWAIT - Don't get blocked by page lock.
> @@ -1993,7 +1990,7 @@ struct folio *__filemap_get_folio(struct address_sp=
ace *mapping, pgoff_t index,
> 		if (!folio)
> 			return NULL;
>=20
> -		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
> +		if (WARN_ON_ONCE(!(fgp_flags & FGP_LOCK)))
> 			fgp_flags |=3D FGP_LOCK;
>=20
> 		/* Init accessed so avoid atomic mark_page_accessed later */
> @@ -2007,13 +2004,6 @@ struct folio *__filemap_get_folio(struct address_s=
pace *mapping, pgoff_t index,
> 			if (err =3D=3D -EEXIST)
> 				goto repeat;
> 		}
> -
> -		/*
> -		 * filemap_add_folio locks the page, and for mmap
> -		 * we expect an unlocked page.
> -		 */
> -		if (folio && (fgp_flags & FGP_FOR_MMAP))
> -			folio_unlock(folio);
> 	}
>=20
> 	return folio;
> @@ -3011,14 +3001,8 @@ static struct file *do_sync_mmap_readahead(struct =
vm_fault *vmf)
> 	}
> #endif
>=20
> -	/* If we don't want any read-ahead, don't bother */
> -	if (vmf->vma->vm_flags & VM_RAND_READ)
> -		return fpin;
> -	if (!ra->ra_pages)
> -		return fpin;
> -
> +	fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
> 	if (vmf->vma->vm_flags & VM_SEQ_READ) {
> -		fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
> 		page_cache_sync_ra(&ractl, ra->ra_pages);
> 		return fpin;
> 	}
> @@ -3029,19 +3013,20 @@ static struct file *do_sync_mmap_readahead(struct=
 vm_fault *vmf)
> 		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
>=20
> 	/*
> -	 * Do we miss much more than hit in this file? If so,
> -	 * stop bothering with read-ahead. It will only hurt.
> +	 * mmap read-around. If we don't want any read-ahead or if we miss more
> +	 * than we hit don't bother with read-ahead and just read a single page=
.
> 	 */
> -	if (mmap_miss > MMAP_LOTSAMISS)
> -		return fpin;
> +	if ((vmf->vma->vm_flags & VM_RAND_READ) ||
> +	    !ra->ra_pages || mmap_miss > MMAP_LOTSAMISS) {
> +		ra->start =3D vmf->pgoff;
> +		ra->size =3D 1;
> +		ra->async_size =3D 0;
> +	} else {
> +		ra->start =3D max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> +		ra->size =3D ra->ra_pages;
> +		ra->async_size =3D ra->ra_pages / 4;
> +	}
>=20
> -	/*
> -	 * mmap read-around
> -	 */
> -	fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
> -	ra->start =3D max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> -	ra->size =3D ra->ra_pages;
> -	ra->async_size =3D ra->ra_pages / 4;
> 	ractl._index =3D ra->start;
> 	page_cache_ra_order(&ractl, ra, 0);
> 	return fpin;
> @@ -3145,9 +3130,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> 			filemap_invalidate_lock_shared(mapping);
> 			mapping_locked =3D true;
> 		}
> -		folio =3D __filemap_get_folio(mapping, index,
> -					  FGP_CREAT|FGP_FOR_MMAP,
> -					  vmf->gfp_mask);
> +		folio =3D filemap_get_folio(mapping, index);
> 		if (!folio) {
> 			if (fpin)
> 				goto out_retry;
> --=20
> 2.35.1
>=20
>=20

