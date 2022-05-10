Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046315221E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347766AbiEJRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347749AbiEJRCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:02:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F4C2A4A16
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:58:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFEAdv023623;
        Tue, 10 May 2022 16:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QhbFTsSTYocstSQ2FI2SHnc5LkA0ciVPInZsj7Hihqk=;
 b=NFswB4Mud9WqAe2nN+gF+KuKXcLnBSSE+5lsjspZX2w/ggYFwJT6tWoI0kuSC+soxIg8
 bmJkfeL+gMC185Luc/gE6WDBmfsn290WC554kdW8lZkBDD2kdY5HyJsF4eTofArIzJCr
 8OYKLKBOdM2tgZpp7zSoqu10rde9LazKgh8s3BC2V42eZvTPVmT11JZ3IgR19hhf9WPp
 79BYxH2zlcrA1F/XLmtoeL+5D8ZWpDA3Fo82cioyfcm58/zr0cgf3XDUNB9T3BUHijpD
 Ju5LQ2PGxJ/P9VQfH8crwGZVlrocY5aqoXraO+ee/xs9V6iZo24OJCuIE7nEH6w2NPTW yA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsqf00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:58:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AGtdos040529;
        Tue, 10 May 2022 16:58:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf739b6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qa5qpHazSIXXcAcdso8RsHcsrC18QzTM65icSvogLcvTfNMf0lExh9P4Rei0GrG4mMTBTzGgr1K67yueB3vO3lm4F0JM/5nsFDS3+N6gViy1TEySwLVwnaJtVlBNvCIihkl2ezqIqnjRx6CzxWehJ1ZRnvheIL7Y5I9AjOf6O5mc18C0eDN5TPbU/gGybFS3UXagA4hSixUaI3fjSZG1yqSR/+s12VRVbrEAn0R0tHaU4/NrNv8xZOE7iOA04bE2J9lJEFIXXDkEipRCc/obHGN0T2CrpEIkZDNGINkd91IvNKsJHDGo4IwmJiV0kTVt3rahoBCfdSn23GLZaXcpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhbFTsSTYocstSQ2FI2SHnc5LkA0ciVPInZsj7Hihqk=;
 b=jKzVZxY8dtMDDBDPBDeh1MeoooUYNz70aDCAnyIVUW1R9aiWw3soiOdMXbau+6txZLcDFY7HW+Xwoflal8aT/MjR6b5dFP8ZcXDOURlZcf/ToAD5pnJkut2FaKwYNFYN2leEirfveUVmpyMbZOF06iCmGWvWBQQ/qBmiGbNps612PLzEdhZllJL9vuyEKVeZYpZmQoiDqCSHP+TOERN3K3kJ2lxEkTbYw4RC14MfDRRqxzGHdk7pliTduQam5VANF1DPid6IeFlfpfWAaQgz1UyhC+XcJvRx6uh7EH4Z4Q1IDv0KqjZOvK1/+8/bN9jEclT9Pyo9ZrTlkQYt3VCYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhbFTsSTYocstSQ2FI2SHnc5LkA0ciVPInZsj7Hihqk=;
 b=CXdhpGCW4pY/YUYPwOkz4IQT7CyxP/G1nxoHyg+g7ryq3m+2+s1DeZsvPccbo9fhMA2a+6nzdtTmHyx8aIGPgOgTBOzNLhDwC/XSzXC8B92TTW4SYfZzaHTc/THz4Y6sUra/C9wnspNQX7UokaXMeN7r//5g3bOHgFJVRYyHeNk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM8PR10MB5432.namprd10.prod.outlook.com (2603:10b6:8:3b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 16:58:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 16:58:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     SeongJae Park <sj@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Thread-Topic: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Thread-Index: AQHYX1NhZKDMPG7C/keyeY6aTlfpJ60X9VOAgABXgoCAABK3AA==
Date:   Tue, 10 May 2022 16:58:09 +0000
Message-ID: <20220510165758.3ahwumv77adq6jzc@revolver>
References: <20220504010716.661115-10-Liam.Howlett@oracle.com>
 <20220510103747.151886-1-sj@kernel.org>
 <20220510155059.yaxjjxjwnbmzoyux@revolver>
In-Reply-To: <20220510155059.yaxjjxjwnbmzoyux@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 914ea64d-fbac-484e-0f55-08da32a642e6
x-ms-traffictypediagnostic: DM8PR10MB5432:EE_
x-microsoft-antispam-prvs: <DM8PR10MB543203998DAFABA08BC035A4FDC99@DM8PR10MB5432.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zuHMwORJ4gqTbbpW3MZleQ+UDTFCS/WQTLsdgF/loDLVVGAvW7FVrV8IRy/HMdDpryRhJ1TQ76Et2HNx5qKKuLONVoNbu/0rFoWfSBKK94uiwiwCNfG2BDoVzOBr4d3Bn7v+IHQAntRYI3/CuiMpG89NrO/yBsh1cqYXYsR/3+OCJaFG78rR2j2uXpy/aj2tyzA779kgHxE9yqQJcaxrixng4FPZ/oXzAxH//FC/hsQXI5zi5T95MXKnrGtc0E4u05sBTlrjpC9I+1WyHPsPUysBmHzUFczfMXxVMUCq5rXjoClpA2Cx4xVPVJS7VDC3L8PakP2k5WksoAfU19H96D67yvBjUV/Z7m/VLNtAQ/YZFsg2w3hy71MJN1CGpRUx62fgWezVaHRTygsZaSIVPdY9g1DAqFX+XCpFhIALGNWlyKpNWoqNm50vVauIJ8nnKidDsl39fVRgtMVkkdvHCgQaQQkY8+xAPuDZMtGJlaXTncmMMqmwHqsUeI1I+vZQ9AdcZiCVpEKL4UIPCO4JGItdzYDbEk1lSLB8aP6xRJpm8vonCo3BOoTBGZGJgOxBvYGsiuEdowq/9TUCdRVsU7TfX/46dKdxk1OxfwyyIc9qJMUPszAGJXqM8SBR62fEH0bhcWUXWh4f4CQNTcjZitH444QSengQI39hyAVPQ8m1pQpZR9/dB26DNmpYJQCjMms0sriPsUD4zyP6v3nxXo8XnUvHgxRliIdt9zNxpP+2c7qNAOqeArafKJOG3fRquIIwzalQkvQgwvUBTN1pkb2zvko3e0qN8g8Er8ceuSs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(122000001)(9686003)(6512007)(6486002)(6506007)(33716001)(186003)(26005)(508600001)(71200400001)(110136005)(966005)(38070700005)(38100700002)(66446008)(64756008)(83380400001)(1076003)(5660300002)(8936002)(66946007)(66556008)(76116006)(66476007)(2906002)(44832011)(91956017)(316002)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yG9+oz9j+tMuYRTfdu6noqEX6YMY01+yYwS3lK3VVMKZgS7qsVjgKUCUl/hu?=
 =?us-ascii?Q?8fIpMSZBRsWL3KipPHnP1dI7fNzDs5GmA82ARGOTcjNohTFSIv4jmKCRjNHr?=
 =?us-ascii?Q?j4lUlGeISdclnQyXNP+5Cx6QZ6bzFageQ02VMWt1d4sunNwUk1+RtOg+Vzng?=
 =?us-ascii?Q?or/9isrhFRllrT3ZdOd+uJYbzIe+vszpN8Y0E070dbG+Vq5S0qwNzjSg8MDv?=
 =?us-ascii?Q?yfL82lIjGkIta4Qya6z2fhuqm2EbLrZevHjw/fZkXzVG6PoFNjqiBibfX6Xz?=
 =?us-ascii?Q?dk5cP3V+Vj1OL10rk6jcLAhjCw12c5Oac5Vb7QJfYQhsaf8b4nTrZAY8bZTl?=
 =?us-ascii?Q?67191fV18uoVAh6qGWwp0k0ngHRkQtGhexxehG6peyGVxZ6z/c2rT9W572vu?=
 =?us-ascii?Q?DkVEEk71xL7zMGGTehp42RJhWTo8GXtYaN0WFZttc9owTDMusKVtIu0ZdnFn?=
 =?us-ascii?Q?PBiVQ7Yj4/XlMyMjIIcxrAJ9Xp05nr6FcfrcVC7jXP8o7NbIREshwQl0E2bJ?=
 =?us-ascii?Q?Q79FxGKMw5YTG7dHA3OaySF3WSWPg1XsfWIEYRsySHFF/6SZExmo2Hjb9LfR?=
 =?us-ascii?Q?TbZrBtEIkzwH5/n5LFW4/S4GKddVU6ttIdDfZfBusNs4f1oiWQ21+t3HkvF0?=
 =?us-ascii?Q?H27FDpcE5yJHeFCrt4TQDxkqbXOzGFxa1OktGq7psIWbqHoms3s40FnZqHHC?=
 =?us-ascii?Q?DpMm73nROrLEFpE4VjdPqrKiuwdC6Xis1WGAXglWxa/x0fMGamFpJ+t23V8+?=
 =?us-ascii?Q?iNRHaLaeLd7jlr4btY8iC6R4/Dq3MpSkOneuntxLPCftaNNSjkTb21m3QoDG?=
 =?us-ascii?Q?8/s7S0Hcu0d/AlABLJu23Rneuhx/zDnry9xpLK2PMxZ1LL0lTVnhUBG0E6G0?=
 =?us-ascii?Q?YrVTJY+QiXXhNnLO/thknNHGuNTxv6XAESzS7zZ1zguWbRw9u3+xOmGZaMYN?=
 =?us-ascii?Q?+DsgEFkwIIOcUTmi59Nv1DSA10rwqFBIUBtTnKeY9xUiMX2UYiGbuUGGxNt9?=
 =?us-ascii?Q?ngEYGAHipjsbEo7n8edu4DLCMMu6I+8YgaKYt+p5n/sO9Y8rZQ5NxQ4SYA1V?=
 =?us-ascii?Q?gVPkrzOrepMRgikIz6s3zfpe3gGyws9SzXNEHh3c/IEYn/wzoHH/tVuYvvS7?=
 =?us-ascii?Q?MDqBjiYFUhVnzeOMFCnDIDY6lCkINxl+11ZSZ8TN/IeCNcnzTX6dMPRdwNQn?=
 =?us-ascii?Q?gRl+35S5yKl2JDwVba2o3oPBBxlCxuGG55gFbLRj60KlY5tHy8T74SaBsEO7?=
 =?us-ascii?Q?5ah+SKNyC/mbcHO4y4y18rjRn0lZT5s5q8B3cDxYKITEEYYSD8TraSI7NuIz?=
 =?us-ascii?Q?35pBD08SIg/7eaN2wOpDjsV9KpItPdzlWZmcE6j7rKhQRU4FKaoNHqikDyld?=
 =?us-ascii?Q?qYZa/u2AK4CPm8AmIckuL/SiAJvvY0CWVm5C0s7uJE9kNQU6ucKm3schyBWL?=
 =?us-ascii?Q?Ncy3f9J4JGxKaNOKPLHBVk7voV7dgFLSeXsTErYE+1WnbGbF06S29YeLOF5f?=
 =?us-ascii?Q?3vWB1dnQ33fDS+q9r6qV/W+toiZfHXDp3g3Mb+Csu3xCyt0m7WPRzUhDStQA?=
 =?us-ascii?Q?612vjzp2ITyqXVMf46W35BKdie9nT13o0NKSdqfc1a6oJBlOiPCI118FV8N0?=
 =?us-ascii?Q?DbqJvpdKTmbDQfLevRNQ+lr8mI46fzOpTKq4N1FszWF8qB2RfiwbTWfCtJ0X?=
 =?us-ascii?Q?eL2CgEJTwMb/QcuwbxqH0LP/MXtu5EuQ76AAjmGc4V1Fy+XOxEQczH3Pci0n?=
 =?us-ascii?Q?XCMDIawrkXVf0FruaZLI5hMYgceI0Co=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2E1B544CA2A1C48870317B89C526B2C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914ea64d-fbac-484e-0f55-08da32a642e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 16:58:09.4367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRyHq90jSSRRMlPOp3kgrf3BLQT6NSH0zkdIZ6B73UEadSG5QiAuETLDETLTWHpYbLFAIbqaIfSayvc0gXPK+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5432
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_04:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100073
X-Proofpoint-GUID: 9FB0vjQKS6K8JnxpUHguu79NzTBW2vqP
X-Proofpoint-ORIG-GUID: 9FB0vjQKS6K8JnxpUHguu79NzTBW2vqP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220510 08:50]:
> * SeongJae Park <sj@kernel.org> [220510 03:37]:
> > Hi Liam,
> >=20
> > On Wed, 4 May 2022 01:07:52 +0000 Liam Howlett <liam.howlett@oracle.com=
> wrote:
> >=20
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > >=20
> > > Start tracking the VMAs with the new maple tree structure in parallel=
 with
> > > the rb_tree.  Add debug and trace events for maple tree operations an=
d
> > > duplicate the rb_tree that is created on forks into the maple tree.
> > >=20
> > > The maple tree is added to the mm_struct including the mm_init struct=
,
> > > added support in required mm/mmap functions, added tracking in kernel=
/fork
> > > for process forking, and used to find the unmapped_area and checked
> > > against what the rbtree finds.
> > >=20
> > > This also moves the mmap_lock() in exit_mmap() since the oom reaper c=
all
> > > does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens=
.
> > >=20
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  arch/x86/kernel/tboot.c     |   1 +
> > >  drivers/firmware/efi/efi.c  |   1 +
> > >  include/linux/mm.h          |   2 +
> > >  include/linux/mm_types.h    |   3 +
> > >  include/trace/events/mmap.h |  73 ++++++++
> > >  kernel/fork.c               |  20 ++-
> > >  mm/init-mm.c                |   2 +
> > >  mm/mmap.c                   | 323 +++++++++++++++++++++++++++++++++-=
--
> > >  8 files changed, 396 insertions(+), 29 deletions(-)
> > >=20
> > [...]
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index d7e120ad5825..e777da0132f6 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > [...]
> > > @@ -680,6 +744,56 @@ static void __vma_link_file(struct vm_area_struc=
t *vma)
> > >  	}
> > >  }
> > > =20
> > > +/*
> > > + * vma_mas_store() - Store a VMA in the maple tree.
> > > + * @vma: The vm_area_struct
> > > + * @mas: The maple state
> > > + *
> > > + * Efficient way to store a VMA in the maple tree when the @mas has =
already
> > > + * walked to the correct location.
> > > + *
> > > + * Note: the end address is inclusive in the maple tree.
> > > + */
> > > +inline void vma_mas_store(struct vm_area_struct *vma, struct ma_stat=
e *mas)
> > > +{
> > > +	trace_vma_store(mas->tree, vma);
> > > +	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
> > > +	mas_store_prealloc(mas, vma);
> > > +}
> > > +
> > > +/*
> > > + * vma_mas_remove() - Remove a VMA from the maple tree.
> > > + * @vma: The vm_area_struct
> > > + * @mas: The maple state
> > > + *
> > > + * Efficient way to remove a VMA from the maple tree when the @mas h=
as already
> > > + * been established and points to the correct location.
> > > + * Note: the end address is inclusive in the maple tree.
> > > + */
> > > +static inline void vma_mas_remove(struct vm_area_struct *vma, struct=
 ma_state *mas)
> > > +{
> > > +	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
> > > +	mas->index =3D vma->vm_start;
> > > +	mas->last =3D vma->vm_end - 1;
> > > +	mas_store_prealloc(mas, NULL);
> > > +}
> >=20
> > Above two functions were defined in internal.h in v8[1], but moved to m=
map.c in
> > this version.  As mmap.c is compiled when CONFIG_MMU, build fails when =
the
> > config is not set as below:
> >=20
> >     .../mm/nommu.c: In function 'add_vma_to_mm':
> >     .../mm/nommu.c:575:2: error: implicit declaration of function 'vma_=
mas_store'; did you mean 'mas_store'? [-Werror=3Dimplicit-function-declarat=
ion]
> >       575 |  vma_mas_store(vma, &mas);
> >           |  ^~~~~~~~~~~~~
> >           |  mas_store
> >     .../mm/nommu.c: In function 'delete_vma_from_mm':
> >     .../mm/nommu.c:599:2: error: implicit declaration of function 'vma_=
mas_remove' [-Werror=3Dimplicit-function-declaration]
> >       599 |  vma_mas_remove(vma, &mas);
> >           |  ^~~~~~~~~~~~~~
> >=20
> > Was there a reason to move these definitions?  I confirmed moving the
> > definition back to internal.h fixes this issue, but I'm unsure if that'=
s the
> > right solution.
> >=20
> > [1] https://lore.kernel.org/linux-mm/20220426150616.3937571-10-Liam.How=
lett@oracle.com/
> >=20
>=20
> I moved the functions as they were dropped elsewhere for cleanup.  I did
> check my m68k buildroot, but the buildroot seems to have not pulled the
> new code - it clones the repo externally.  I just changed the branch to
> use mm-unstable and that is indeed failing as you see above.  Your fix
> is correct - and I believe it also means I need to leave the damon
> change the way it is now.
>=20

I recall now that I wanted to have the function traced.  Moving it to
the c file allowed me to add tracepoints pretty easily.  Having it in
the header does not work as it will redefine the tracepoints many times
and cause a bit of a mess.  I don't love putting the tracepoint as is in
another function but I think I will have to move to this method.  On the
plus side, the open-coded modifications to the maple tree may be able to
use the tracepoints then.
