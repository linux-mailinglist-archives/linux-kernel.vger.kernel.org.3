Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3688583606
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiG1Aea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiG1Ae1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:34:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49A254CAF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:34:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RNOHL7020281;
        Thu, 28 Jul 2022 00:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IePH+k/8BlH+hyPp/WwhNvlcNM3NseJV+6bI9h2ndKk=;
 b=F970cIozXYjx1sozkw+g57w6mD0Vg6w8D3L4eQtbqc6KhV9bD16HUXoHUQe6/nnrkx3C
 GMirfBuvRzXx5t/FbJ3Y/l2M5GFW8CxUF7i2aZvBUdKroAsFEp19wS/jJX8xvL+RTOj/
 3gRgJqaRYDT3H8bxZlJ6FPj7zxZp96CnASC0yGo7AApt77Q9ZJ54hHpyk8BiN4h0EhnH
 3Lj+ibehXE9JiovrAT6QO4sg33NaLctMkPk2xL8wJmRChjpGonlhQzLUSg8xqSbWessQ
 EY5Gwn+vKPfUXSDipfOS5CPoNbR8joomzhr6D5BnopS2dgdlfEFRmQ9i4Mcnv4F26vD5 iQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsuj7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 00:34:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RL5u2o023003;
        Thu, 28 Jul 2022 00:34:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5ywxetm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 00:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxuM3xP0eyUbyWlgy1jBp9E6KZnVijR7Osex24SkI5OR9dDgeRBNwqT+ZxmIF/09ewyaldyf8WBhmmC80V38XsFnLNbmOaxYmteDQAXF9HG4dnUoKzCkYcPUt7ajk4YgI1u+7F1bLnGH9f5BA4xSbGcNn18jUrQeskpbhYrh/ZtuZ7VsdZXF3FQN5t6tBtZJ3mpOzQ124QJ/dIYqmCsHCsfW0uR7S7GyeeFzp2ctcCR78wnw5L+g4QpeGS2sK6sM9udK5siAxDn8VneqP+4jOI1vaCZwHx7oorx5QwArRDk1kFLkok29XzxjWF/0lARmOr9b4mN5Qey4sJBkIIs4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IePH+k/8BlH+hyPp/WwhNvlcNM3NseJV+6bI9h2ndKk=;
 b=ZnhA/+pnj2gqFYjV7CTfeV74DTNAl9AGQWsEwnSDlsJBgx+/ZhnzZ17W5cQdV/7Yqj8wyOks5XJkvr4pSlHBGavTwqbXk7iyc8LYAxplBG0mKBrwArXvDWtC/FLPc0rDmXPX8xjzFrzJf84iLCtfdNGf00acN7VHyP0IVpi6D7X6xMDrP23nCWaFT/24v/ZaEnGQFpth76QHcA7hB0aYxMjtt38TlzKiJpLQDbCYuAfr5Mo5JE49DbDkjutA1CFT3npY6yOu9xnAA61XakUTcwuy8m7m7rt71x/jeB+feiRBG+rh5srye0BCW+vgfb+bCJAyBTJlYH3qkHB8ckyojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IePH+k/8BlH+hyPp/WwhNvlcNM3NseJV+6bI9h2ndKk=;
 b=kRm4W1+OyDwsgAoJfMcR7+R5t3IM/n/S0G/W1XvCvQVkkdRW5VVIyXv0kxkGsLnvr3eb4oGxH0qpD02GnSPHva+JxKC9aKQf8ymx/AWa8sQQXBOUW318pXHumdK1ZdVuVXRetVF73IenSiDRe4IDJUFiK4t7lMNVeQu1N9hsYDo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4354.namprd10.prod.outlook.com (2603:10b6:a03:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 00:34:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 00:34:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v12 08/69] mm: start tracking VMAs with maple tree
Thread-Topic: [PATCH v12 08/69] mm: start tracking VMAs with maple tree
Thread-Index: AQHYm97mkLAkGOHngEOceAlHl5MTva2RZ8gAgAGT8YA=
Date:   Thu, 28 Jul 2022 00:34:07 +0000
Message-ID: <20220728003401.7fmppx5kbfqmzyjb@revolver>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
 <20220720021727.17018-9-Liam.Howlett@oracle.com>
 <YuCGoB3Ackadj5up@dev-arch.thelio-3990X>
In-Reply-To: <YuCGoB3Ackadj5up@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15a0d3f3-22ef-4610-1331-08da7030e1d8
x-ms-traffictypediagnostic: BY5PR10MB4354:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OF7/xt+Q0/1ZeZJQZYe6fMiYfhMQBpqg69LZv7s+PeFGSVBvT641IjVwWNDu+vaZFC63CcMTEm4r9ySGdkC5BFoWyAWAPGhclTiLO+Iv1ifqaW1qsBl2EgkEd1j92RHb7/5tLhLx0mQsEpEP5Tj4Kju2jB4UIFM4DThEsi0XpQ6kTo0MbIcgp+aAK9PVSnKjv9pmIUgAyKPXWho5P75i7A173vuedOGBfz5fE4IoKRAUKabgcsmvtG9WenIwppl5UzJH8lRn535k4/Ft/WzyUZGk6KNZJlLpG5e0VNrdEJ3MjsLegcsLfACQA0IMnpT0gvybWB5HjbfsIz8LnQatjAXmR/npzea6WjG+cyp79ZuM9yvLX4IBaW8bbh4haQ2qwwGyDr2Od5XMifg+CiUf5ed9sfDojBchnumvz6Ir1maqcl5r72/QqxOs5REfgUwMc8Bh1P5SzaX2N05G1CROJmFbZarHfLGr6YaTLRD9Y+5r82ww3nXjoIdiFgMaqDlySr2PHz/sZcDpy88qspAJJHTfLKEBpA0SgPxgrsbN+asSHtYJUEj6dChQ61gtTVFfhxS4LVnHFnFaYPesh/kXs+4XHX2KQYZsNfovFyATKCtmxbR50PlpjywJBliPtl5nD6+Q+JGfjEstTZnluuDLW+YFfFlCv+aM9/aZ77Xj8UTdcKGtnUHgjYQGzZpJjWO2KpToMlJ5hzuj438BAmLMOD8GW20LgpG2j2y+Tc1tFQevs+DMoKWdrnCOpq2Y3FAXh7YsjsjkibXR+18R3muj5F6ioB5/T5untbn2VtnX1GnUi9BOiqeeSFQwVAcCTzR0S22V4O1yy2ARgaOvRXO4Ak/Go5egRMBN8zneny/7IT5u7CBAAW7T6ubQOkHL68yV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(39860400002)(136003)(366004)(346002)(54906003)(4326008)(71200400001)(44832011)(316002)(6506007)(6916009)(45080400002)(6512007)(8936002)(41300700001)(26005)(9686003)(64756008)(478600001)(2906002)(6486002)(5660300002)(966005)(66556008)(33716001)(66476007)(76116006)(91956017)(66946007)(83380400001)(86362001)(122000001)(66446008)(38070700005)(1076003)(8676002)(38100700002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XPO/GeoEiAXFzj/wPN28pPBBly+8FFMZghEQRNor1+RT1QCYJI4SpoPTlWx0?=
 =?us-ascii?Q?PN9t1rjHGa58bxowAT0LCZcQdzRmL9wfagnD1BfYf24dEa5I1jajM4J1Zy3z?=
 =?us-ascii?Q?ckqMTp5CYlSnBUhsFfCoZVKFFMU7xC7Dw9+sH/zMEt34cwu7L3y/JG3/yL6r?=
 =?us-ascii?Q?10jstDw8sDMhFZCNsgz0UJCRXTBWfTKftFjmIL3JxbYaewuukvyyb0Qe0jc+?=
 =?us-ascii?Q?YxceNM2Ht+ywZJgmc0CqgX0Gcc9Gzc3R7BbdG82UDXBP/Dqtx6P3VQZwjkCC?=
 =?us-ascii?Q?HagDrBegzP3J8KsrYYad4kOeNCiCTMnCK+8KRIGgGKrWZyLaVzwJpRQRFmuO?=
 =?us-ascii?Q?2sgSun4L70L/r158SzvhlsqjZTH2KjSJL57iqVtjhq/nqIbfpnDbG1f/V8G5?=
 =?us-ascii?Q?e7og6DGfJv26fo6aUW5aRmcOVX3DM4j6rTqVoemhs8wnvkwQ0q3gjz4/1ilk?=
 =?us-ascii?Q?pTAPgzaXCG0FHIs576jT0nXcz4mvIxt8HQ+PUMtilrKfXYDrS5KxSF8Bvnv7?=
 =?us-ascii?Q?16201oKCOdc4SvGJ8L9ypkvllGEp1JLwbJ2dmnGeJ9NCz82OUPqdYNxja/p4?=
 =?us-ascii?Q?fWQH6wqAJaDNJDNcjKlbKTrRO3mPUW0B5jhvBtZuPsLImXtZbwigQsMt6HEy?=
 =?us-ascii?Q?l7DX2b3gaDG9MbaqnG349XHjvOEUA2NeeyO0ekKMC9R/zRhlI/PYxWpcV79a?=
 =?us-ascii?Q?1iZJXJGUHeOsc1AXx1lgR98ZGbaqn7kWZ2WVyg60RDvU/jsC7bhj6AOVE3Ss?=
 =?us-ascii?Q?PPkbcIGOs+bYAxNpx+lOxZ/E5DGaXai1wYL3ks5PyhhTh9tRq6C48A0Z1W7k?=
 =?us-ascii?Q?g15yGQVOIRSbqY7/Gxzqcg0PXLr0PBkl8vSRg3p3xokrRFbsBXDxMxFrE/oW?=
 =?us-ascii?Q?SeWtQWv3VTwoXCCBTyiWpjbmU1i208loktZhCFO75kCPGTgheozaca7syyQz?=
 =?us-ascii?Q?e2docJwm/DhNoBjIrrv1Br+NBYcA+msMUMthnQe+aSygdNE1ZBRumVyIimh5?=
 =?us-ascii?Q?F6o9wkJMyz3KZtWuVQDFNANCw4u+Ndod7kyX6jxz/kwhUg/Ysqbswt+UmIVk?=
 =?us-ascii?Q?loOBIVAmucCH/vDd/szUhD/vYYI119Vth3s8nBp4espJEcwaDke2PAARNV9C?=
 =?us-ascii?Q?pZKzSWZ3p2LJUpuALvk4XZ4e0MoXCOrD1uTazM0oZn7aSUTk5SFWX1uAtnkq?=
 =?us-ascii?Q?XnlDy3jWSpYKj0DDhbJMVpA4GpM3cGpHwDG/uSh+e8lD/j1GB2CoWfMGpVz+?=
 =?us-ascii?Q?BUtIFMXSsAx5wgEf5cRVEfyyrw76dnQor00RAMnZCCm6WyZ6k6he/dVxYVU8?=
 =?us-ascii?Q?lC7PCvtsxsYFn/dzHPz9d3lCGQDPKX/gqrKeHftqGqx92FMQeznDgT/Ae+yt?=
 =?us-ascii?Q?mLDU0x2qHTLxd2GJSGzEaJCASrK+Lxohe7405bEST9BQQeM53y/fLtVP5fqj?=
 =?us-ascii?Q?0pzLBuGZB9AAo6YLSAHX4f6VghEA6DqfycAVEXRiECHUCOdDtD1IWNGxvXdk?=
 =?us-ascii?Q?llrWzFkys4smZNia91gW0+5I+Vt7EvXK0FhhNxOvPEwjbQKaZEeD9/xjFsWf?=
 =?us-ascii?Q?Cv2OIbJSgZ/aLXtFhNoHaItM+/zkSp02ScxkLNNkgGfRDqmD/k43zqLdDz0I?=
 =?us-ascii?Q?1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE13A66BA8EEEC4D8AAE78FD25022C19@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a0d3f3-22ef-4610-1331-08da7030e1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 00:34:07.5496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gqi0lo9Wu/s3KN4NtAZXcfvYycVQCVhsH8Dx4WCsUbofxsgYgVytK52Q6zjMPbJphBBsdoVfi5SjLl5UR4+GwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280000
X-Proofpoint-ORIG-GUID: 1DONAyVfuoI8ctutbIErB3YAMOFsti7Z
X-Proofpoint-GUID: 1DONAyVfuoI8ctutbIErB3YAMOFsti7Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Chancellor <nathan@kernel.org> [220726 20:28]:
> Hi Liam,
>=20
> On Wed, Jul 20, 2022 at 02:17:45AM +0000, Liam Howlett wrote:
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
> > When splitting a vma fails due to allocations of the maple tree nodes,
> > the error path in __split_vma() calls new->vm_ops->close(new).  The pag=
e
> > accounting for hugetlb is actually in the close() operation,  so it
> > accounts for the removal of 1/2 of the VMA which was not adjusted.  Thi=
s
> > results in a negative exit value.  To avoid the negative charge, set
> > vm_start =3D vm_end and vm_pgoff =3D 0.
> >=20
> > There is also a potential accounting issue in special mappings from
> > insert_vm_struct() failing to allocate, so reverse the charge there in
> > the failure scenario.
> >=20
> > Link: https://lkml.kernel.org/r/20220504010716.661115-10-Liam.Howlett@o=
racle.com
> > Link: https://lkml.kernel.org/r/20220621204632.3370049-9-Liam.Howlett@o=
racle.com
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>=20
> Apologies if this has been reported already, I tried searching the
> mailing lists but I did not really find anything.
>=20
> I bisected my arm64 test system failing to boot to this change as commit
> fdfbd22f37db ("mm: start tracking VMAs with maple tree") in
> next-20220726 (bisect log at the end).
>=20
> [    4.295886] Unable to handle kernel access to user memory outside uacc=
ess routines at virtual address 0000000000000000
> [    4.306595] Mem abort info:
> [    4.309381]   ESR =3D 0x0000000096000044
> [    4.313118]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    4.318422]   SET =3D 0, FnV =3D 0
> [    4.321464]   EA =3D 0, S1PTW =3D 0
> [    4.324592]   FSC =3D 0x04: level 0 translation fault
> [    4.329461] Data abort info:
> [    4.332329]   ISV =3D 0, ISS =3D 0x00000044
> [    4.336152]   CM =3D 0, WnR =3D 1
> [    4.339110] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000020a971200=
0
> [    4.345539] [0000000000000000] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [    4.352321] Internal error: Oops: 96000044 [#1] SMP
> [    4.357188] Modules linked in:
> [    4.360232] CPU: 6 PID: 264 Comm: dracut-rootfs-g Not tainted 5.19.0-r=
c4-00288-gfdfbd22f37db #1
> [    4.368918] Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS =
EDK II Jun 21 2022
> [    4.376994] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    4.383943] pc : mas_split.isra.0+0x50c/0x784
> [    4.388295] lr : mas_split.isra.0+0x204/0x784
> [    4.392640] sp : ffff8000094a3510
> [    4.395942] x29: ffff8000094a3510 x28: ffff08dd66c0c000 x27: ffff80000=
94a3610
> [    4.403067] x26: ffff8000094a35d0 x25: ffff8000094a3578 x24: ffffd823c=
b5448b8
> [    4.410192] x23: ffff8000094a3650 x22: ffff8000094a3690 x21: ffff80000=
94a3738
> [    4.417316] x20: 0000000000000002 x19: ffff8000094a3af0 x18: 000000000=
0000002
> [    4.424441] x17: 0000000000000000 x16: ffff08dd66c45450 x15: 000000000=
0000000
> [    4.431565] x14: ffff08dd66c459c8 x13: ffff8000094a3748 x12: 000000000=
0000001
> [    4.438689] x11: ffff8000094a3610 x10: 0000000000000003 x9 : ffff08dd6=
6c47300
> [    4.445813] x8 : 000000000000001c x7 : 0000000000000003 x6 : 000000000=
0000006
> [    4.452937] x5 : ffff08dd68a44409 x4 : 0000000000000001 x3 : ffff80000=
94a35d0
> [    4.460061] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff80000=
94a3738
> [    4.467186] Call trace:
> [    4.469620]  mas_split.isra.0+0x50c/0x784
> [    4.473618]  mas_commit_b_node.isra.0+0x1e0/0x274
> [    4.478311]  mas_wr_modify+0x10c/0x28c
> [    4.482048]  mas_wr_store_entry.isra.0+0x10c/0x4a0
> [    4.486827]  mas_store+0x48/0x110
> [    4.490131]  dup_mmap+0x268/0x514
> [    4.493436]  dup_mm+0x68/0xfc
> [    4.496391]  copy_process+0x864/0x10b4
> [    4.500129]  kernel_clone+0x88/0x494
> [    4.503692]  __do_sys_clone+0x60/0x80
> [    4.507342]  __arm64_sys_clone+0x2c/0x40
> [    4.511254]  invoke_syscall+0x78/0x100
> [    4.514991]  el0_svc_common.constprop.0+0x4c/0xf4
> [    4.519683]  do_el0_svc+0x38/0x4c
> [    4.522985]  el0_svc+0x34/0x100
> [    4.526115]  el0t_64_sync_handler+0x11c/0x150
> [    4.530460]  el0t_64_sync+0x190/0x194
> [    4.534112] Code: f9000125 f9400e65 9278dca5 f94000a5 (f9000045)
> [    4.540193] ---[ end trace 0000000000000000 ]---
>=20
> I was also able to reproduce the same crash in a Fedora virtual machine
> using QEMU with Fedora's rawhide configuration [1]:
>=20
> [    5.913992] Unable to handle kernel access to user memory outside uacc=
ess routines at virtual address 0000000000000000
> [    5.914510] Mem abort info:
> [    5.914581]   ESR =3D 0x0000000096000044
> [    5.914705]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    5.914858]   SET =3D 0, FnV =3D 0
> [    5.914951]   EA =3D 0, S1PTW =3D 0
> [    5.915065]   FSC =3D 0x04: level 0 translation fault
> [    5.915215] Data abort info:
> [    5.915321]   ISV =3D 0, ISS =3D 0x00000044
> [    5.915465]   CM =3D 0, WnR =3D 1
> [    5.915624] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000010305100=
0
> [    5.915799] [0000000000000000] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [    5.916196] Internal error: Oops: 96000044 [#1] SMP
> [    5.916504] Modules linked in:
> [    5.916771] CPU: 2 PID: 202 Comm: dracut-rootfs-g Not tainted 5.19.0-r=
c4+ #1
> [    5.917003] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06=
/2015
> [    5.917339] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    5.917584] pc : mas_split.isra.0+0x50c/0x784
> [    5.917794] lr : mas_split.isra.0+0x204/0x784
> [    5.917949] sp : ffff8000086334a0
> [    5.918038] x29: ffff8000086334a0 x28: ffff5b65c095a258 x27: ffff80000=
86335a0
> [    5.918289] x26: ffff800008633560 x25: ffff800008633508 x24: ffffdb30c=
80d9778
> [    5.918844] x23: ffff8000086335e0 x22: ffff800008633620 x21: ffff80000=
86336c8
> [    5.919277] x20: 0000000000000002 x19: ffff800008633a80 x18: 000000000=
0000002
> [    5.919533] x17: 0000000000000000 x16: ffff5b65c095a4b0 x15: 000000000=
0000000
> [    5.919747] x14: ffff5b65c095a898 x13: ffff8000086336d8 x12: 000000000=
0000001
> [    5.919971] x11: ffff8000086335a0 x10: 0000000000000003 x9 : ffff5b66f=
42e2a00
> [    5.920214] x8 : 000000000000001c x7 : 0000000000000003 x6 : 000000000=
0000006
> [    5.920493] x5 : ffff5b65c3077309 x4 : 0000000000000001 x3 : ffff80000=
8633560
> [    5.920739] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff80000=
86336c8
> [    5.921051] Call trace:
> [    5.921152]  mas_split.isra.0+0x50c/0x784
> [    5.921303]  mas_commit_b_node.isra.0+0x1e0/0x274
> [    5.921459]  mas_wr_modify+0x10c/0x28c
> [    5.921565]  mas_wr_store_entry.isra.0+0x10c/0x4a0
> [    5.921725]  mas_store+0x48/0x110
> [    5.921864]  dup_mmap+0x268/0x514
> [    5.921993]  dup_mm+0x68/0xfc
> [    5.922074]  copy_process+0x864/0x10b4
> [    5.922213]  kernel_clone+0x88/0x494
> [    5.922315]  __do_sys_clone+0x60/0x80
> [    5.922444]  __arm64_sys_clone+0x2c/0x40
> [    5.922576]  invoke_syscall+0x78/0x100
> [    5.922686]  el0_svc_common.constprop.0+0x4c/0xf4
> [    5.922847]  do_el0_svc+0x38/0x4c
> [    5.922947]  el0_svc+0x34/0x100
> [    5.923056]  el0t_64_sync_handler+0x11c/0x150
> [    5.923179]  el0t_64_sync+0x190/0x194
> [    5.923365] Code: f9000125 f9400e65 9278dca5 f94000a5 (f9000045)
> [    5.923833] ---[ end trace 0000000000000000 ]---
>=20
> If there is any additional information I can provide or patches I can
> test, please let me know!
>=20

Hello Nathan,

Thanks for testing this and your report.  You are the first and only
report of this failure so I very much appreciate it.

I run a number of tests on arm64 so I will have to try your kernel
config.  Thanks for including the link.

Regards,
Liam=
