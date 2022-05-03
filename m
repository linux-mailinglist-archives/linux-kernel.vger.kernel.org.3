Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7BA5190F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiECV7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiECV7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:59:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E0941FB2
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:55:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KjZZU013502;
        Tue, 3 May 2022 21:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WBDK5Vqf0NuYBSrVCfO5X2zKAZC2Tq4AOJ13AIYaOTQ=;
 b=ofkVb5BVzjM0ORA7UclMBjB4iB5hKTEkQk092JBXVjSCigomGvgPgBNp53ULVVYepZqu
 Qmn/dJQQmMgw730MTGDwR9VvWlUblUGasxPMFK1L0mJSdiDAWvCluR2RDiVI3+bxotUl
 JhD+AduWv0MEYqspH6TVlsddLRGGmOgdhpKtTLNIQMLQVhKR3EEnrRpdhQpzt1LVu9Wg
 2iYi6PJWd6AG2IRTN9vydZ3mrQwvM3i2zN+Hdf4zzf+NqWqRMtZZbUR1W1WAuDuGvjuz
 ew6123/hyr0ib408QoCKzurlE8DJg4levRlPnb0lzWOTEeTnUM63jrml69fvO5YePjfo Zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsexv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 21:55:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 243LkSfi008881;
        Tue, 3 May 2022 21:55:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9cs7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 21:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvY0Pc4/iZUGRYX8bXi+xppcUmPBjaKgyhRy5CatJuBX/TIEjTkyFutMVyHWL3sgCz5Ya04I4GlO0o9nCW24iG+CsOxkHg0mohG/GmYhkAVq4iazLZvxilUuWa3CjTFKDHoETDwKFCajYLwJ7k21aqYVdSvTg5Zhok9OmW7z7z6tLRW2jsB9jQmG1Vum0/uJEGDmMtbDviR7zJJUPKevhawtG3jDJpV51wzRQQE7saoh+wd17CzywNy+TrwP1XLzABpmv+lZgxyk1H3EEh9NYjbnoc4mHruGIc6cnGb+5RoEw+e3E09pmI6wSR6sV2MX5nmBkWAEYxymmXX54uc/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBDK5Vqf0NuYBSrVCfO5X2zKAZC2Tq4AOJ13AIYaOTQ=;
 b=Aj1THPX3gSH5C8F8QsKyI0xeQ0uLc2l19GSn1zoslPgKBenTLytNU3Y4JUqE/HxiwghYg+g5kWm52iYxO8p2n30rfc6Atv9yPt8kCrBgtVFyB5i8gatgchGWnsKg/31aIogSar+q3TDKGvMy+UDt+xkH10PvbUcObTOGikKicmIxo6SLEqGUgYaoLzR/DlbJKk+8Pk3290nLqrD3Lps94WZ/xJgZkhoeSWVZvK4MT3uRGgHLyTmNVGsCipTHfnLLlmQdh26um58ozGYcmW+b81rL+GubaQ2OJaK7wgMSuuOq6B4s431W5jeBqtJd+ylZlHLfkkmGchq8Fzn5TRZsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBDK5Vqf0NuYBSrVCfO5X2zKAZC2Tq4AOJ13AIYaOTQ=;
 b=CGurFel/+YOSog9/VmwCB4teo4zOREbCbGVYVCDjP7t4MVwKGWB5IsHPOizJN09ouu4iImFe8yPBa0ig45rgRpjiNZ3hrFfF2FKbVBiGO43COku8owOEni6r2Ez4GedQHBs6fnM6r7jHDsAfxedZBLC10mjc7phJRsmx/00peQQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR1001MB2333.namprd10.prod.outlook.com (2603:10b6:301:2f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 21:55:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 21:55:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Heiko Carstens <hca@linux.ibm.com>
CC:     Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Topic: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYWX84+45146fpu0iPsmgBhR+6Va0Fx52AgABIVoCAAAqGgIAEpZEAgAAC3ACAAKX0AIAANdQAgABZMgCAAaLGgIAAI1IA
Date:   Tue, 3 May 2022 21:55:26 +0000
Message-ID: <20220503215520.qpaukvjq55o7qwu3@revolver>
References: <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428201947.GA1912192@roeck-us.net>
 <20220429003841.cx7uenepca22qbdl@revolver>
 <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
 <20220502001358.s2azy37zcc27vgdb@revolver>
 <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
 <Ym+v4lfU5IyxkGc4@osiris> <20220502133050.kuy2kjkzv6msokeb@revolver>
 <YnAn3FI9aVCi/xKd@osiris> <YnGHJ7oroqF+v1u+@osiris>
In-Reply-To: <YnGHJ7oroqF+v1u+@osiris>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10d2970f-314e-4192-f8b7-08da2d4fa195
x-ms-traffictypediagnostic: MWHPR1001MB2333:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB2333BA2123E9D367FDC1A078FDC09@MWHPR1001MB2333.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BXyd3qIKwG3KIHuZz9iQM0bW/YXbSpAzrQF85QCV5j9D0FwE6VU2sedAIRVTLQGU+o/47R9vwjuLeggGAV1cKLuWUUkOjg61NE9chtwuvjC2r+7udf5Z6kavt+UPT3J4n4uBayUorpZAS97x05q717JcIyKEO9VC3wR696AOLiB8HTnnPsbxjVaW3dQqIsaQ0JDCN8Dts4gHaKPXc3kUAE4I2tKRXw4tPqNAu5fPCFKAa/YA5AQjVLI1TsYYjSXhtKZMvNaEk1djeYn8OTkSI8YO1kxXp84N3zYwfNWm/IeYPiZ/djMqtYRh7G4R59/0iAMA2dl8pwvjjaSwkbl+w0+FbyZsuCkULcJvkMaWnxj3e0wHafXXK5kEq1RrFv6XuZ9PrgnhthQ8p1Xpx9NxUtUXCnvNOrfhfjwOG6SlvD7SyipntR6L+8RmE7FEJYQxM1RcDjVHPYlqkbPjEIp0g0LmKRUe7s4F/4Fyz8CkLxfWxYsHjg3gYgSueohgVUzgsPbiVEBWPdtuutsxPLLWHfLdZQMnt3ZZQk/ISIH6m7kCb1smkYC9fopyfiE8bXsqROXEtc+M4/mDWuaY07jzQI8k+/6nSsdMcvy+augpFjQWzvjfWsEsjTh8lCZMdTJYjjUU3Q1rFbiuW4x3lZzM4a90l/C1O9CtgtHmLCt+vt+DHMWVV6/s9z2ghnfZrVYcJYwepmcWayXBRZIsl/s54w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(83380400001)(186003)(66556008)(44832011)(2906002)(33716001)(122000001)(64756008)(6486002)(5660300002)(71200400001)(508600001)(38100700002)(66476007)(8936002)(38070700005)(7416002)(66446008)(316002)(54906003)(6916009)(86362001)(4326008)(6512007)(9686003)(66946007)(8676002)(76116006)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?76aO+BlWvx+8q7+LNzaXfx6XmO/w6MczlV//58+zBo6REE6ygjDIeBVph9tD?=
 =?us-ascii?Q?2B5divL8PJUqDC0IjohMkpX1OuLXQUP9xR1sW3KuYr7URYeoi/TRoj5Wc6rA?=
 =?us-ascii?Q?zNO9vX4gSuQGHVlsFqu10M+naSVyD9EbTdyJ2SB46ya10njROvo8+w0Iu3tr?=
 =?us-ascii?Q?FfsaLtTBcaZRUcBISknp3qij6oyDzvrOQHrqzFBXqqgj/3hdMT7jlrBgdpxP?=
 =?us-ascii?Q?690oOhqUcR22zGC4ETsYKgAmpZ7r0D5bbRd63F4K/b+RGfJLk29KYJEbKRD/?=
 =?us-ascii?Q?zw6RFQcbpXnfhvETckB8C6e6NZphEGlzu5evRXWhtEK39Z/NJnF18q3mtETb?=
 =?us-ascii?Q?J8xH8caE4Wd6xHnVqtHAT43OG+4HU/JeZJeH3gJlLJSIVl7eVq+7uB2HKdQj?=
 =?us-ascii?Q?3l85P8iZeLCMYChtD9mxPHBLtbCmMT1LGmNVV7FaX6VejQBC7yRvEO6dZcLj?=
 =?us-ascii?Q?goF1gWGVqoTSZx0JGbNDXOVbD9gH60ZKwYwiJybJlP5Sh3OFmja+2UVW1Is0?=
 =?us-ascii?Q?xVY52ZY/Nly3IYVKF6EQzB3vh4Vu0SkufBIZd8rhIdjTQ7nhqKZ406lDvE7R?=
 =?us-ascii?Q?0mwl6T2SLER/bmOEyYBOdLxdbU/U7QTdrvJ4JxV394TbsfmRukZaUx4T6VXL?=
 =?us-ascii?Q?mEXLy8dd8VHSi9d06BLyY0wZjS5uYIK2pv3e4hWTfQF4OSd6oeagOjsHwimr?=
 =?us-ascii?Q?DdTfG144e6hx8x8ZRaTXjkVfimVjvYwymsaxxPTjQTgnNdMrHxtetaOCRZYt?=
 =?us-ascii?Q?2nKT91MNvBkratD0LllY4JtW5r/pwkblVzdIM/muLxHvxNu/X4PmxPqc82qs?=
 =?us-ascii?Q?a96SUIEQ7ORUfnboiwSV2/i7J48v1z91VJVFh4UKOy6TZ1pAMa8CdtHy9lAV?=
 =?us-ascii?Q?jGKbTL0jlOV/TsAMmnmSnWXMPStpn880M1Td3unZzeWUM2fWUM6zngGgA65x?=
 =?us-ascii?Q?x1gjxht8/R1t7ZZ2YDUtgDYFOxCPLzzHtDp/mzo+xDc3afQGrSh2oOsie9+D?=
 =?us-ascii?Q?4t5fmrGGWsrPhaceedaITACc3HqiGhnsZ55gapRJYiQPzVRnUbC7s+CIGSUe?=
 =?us-ascii?Q?qqPScSRS4/BRIqJVlmKYE5SpmaqUpCp3RaA0HznWrzNHpMB9QKnR1g1vD3dm?=
 =?us-ascii?Q?DazAekaVpBmdxoXopGljTcumSdXwk12zRCd7DDmBXW27OEP6oo7x8/PXbzUP?=
 =?us-ascii?Q?+eBrdNgyOsC5UOjJJX+g4JjN7prfkmwuuPWbpeRypaaAwJ44lZIBbIfgljLX?=
 =?us-ascii?Q?1WaNXUAO0dgBDp31GGvUDUxd53mxSA5b5q6uzQWXRBITyCHyFuQHikpFy0WW?=
 =?us-ascii?Q?b3KVj2aYCe+aaJQAJXjBP9RUSoaLc0p6Yh4B6dmB6+2Lfk+E01oI61l8dN1t?=
 =?us-ascii?Q?Y9QFHqFwJUjBCuTmUzDQjqgtQkMTTan/ib0xCi0fJ1fGWUB1Cw90Fdy5SONc?=
 =?us-ascii?Q?qe7fdDOIRop8Cyl2xuUsETnzlINdUVTf0jiGV38c7TxHgsFJXaxTqf2AWAYV?=
 =?us-ascii?Q?JDEThHT7BhCp645oSYcDRVva5V/hh2yc+KDNTdvE0rUSyqrZkedEGL3XOv2A?=
 =?us-ascii?Q?qzKlB1t1wmzEYvTymgMEzd/sNaWdhZsI/tFnRtQiY8FSjVp/80HKbAlE+5mT?=
 =?us-ascii?Q?gPowcaPVkRerHWQrJhj8D+P2VLoY1vVDVW9umhv+l9ChtFegqY+OwXVWjc/N?=
 =?us-ascii?Q?GHPxitIcmIuFhjb5rizgpY0u4f3UrzwO+P5HewExbwPWx5P46ZyEbVxnfizn?=
 =?us-ascii?Q?6nwbwj9USKh03ZQ68V5EqJk6lT7lFZQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32ED45042DD8CC4DB4BB65C55EDB86D0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d2970f-314e-4192-f8b7-08da2d4fa195
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 21:55:26.2816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8z3Fw/EvzYIYE9NfxtPlYKrTVE5agSHVEceHK63+/sHuwaobjgLN4GK/FvZKO3Rski8MUP20G69uhb0B8kftGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2333
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_09:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=950 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030132
X-Proofpoint-GUID: Jyf7JqwdPgwLU4vlq2kxcbFkct1ezKRS
X-Proofpoint-ORIG-GUID: Jyf7JqwdPgwLU4vlq2kxcbFkct1ezKRS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Heiko Carstens <hca@linux.ibm.com> [220503 15:49]:
> On Mon, May 02, 2022 at 08:50:04PM +0200, Heiko Carstens wrote:
> > On Mon, May 02, 2022 at 01:31:00PM +0000, Liam Howlett wrote:
> > > * Heiko Carstens <hca@linux.ibm.com> [220502 06:18]:
> > > > On Sun, May 01, 2022 at 05:24:12PM -0700, Andrew Morton wrote:
> > > > > (cc S390 maintainers)
> > > > > (cc stable & Greg)
> ...
> > > > > > booting.  The last thing I see is:
> > > > > >=20
> > > > > > "[    4.668916] Spectre V2 mitigation: execute trampolines"
> > > > > >=20
> > > > > > I've bisected back to commit e553f62f10d9 (mm, page_alloc: fix
> > > > > > build_zonerefs_node())
> > > > > >=20
> > > > > > With the this commit, I am unable to boot one out of three time=
s.  When
> > > > > > using the previous commit I was not able to get it to hang afte=
r trying
> > > > > > 10+ times.  This is a qemu s390 install with KASAN on and I see=
 no error
> > > > > > messages.  I think it's likely it is this patch, but no guarant=
eed.
> ...
> > > > Liam, could you share your kernel config?
> > >=20
> > > Sure thing.  See attached.
> >=20
> > So, I can reproduce the hanging system now. However this looks like a
> > qemu problem on s390, since I can reproduce this only with Qemu+TCG.
> > Qemu with kvm works without any problems (same if I use z/VM as
> > hypervisor).
> >=20
> > Janosch, Claudio, can you have a look at this please?
>=20
> So, at least for me this problem also exists with plain v5.17.
> Switching off KASAN, or alternatively switching to KASAN_INLINE
> "fixes" it for me with Qemu+TCG.
>=20
> Liam, could you please also try to disable KASAN in your config? With
> that I think we can be almost sure this could be some bug in Qemu.

With KASAN, my tree fails 100% of the time (mm-stable + my maple tree
patches)

Without KASAN, it boots 100% of the time.

I think this verifies with you say above?

Thanks,
Liam
