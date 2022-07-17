Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E4257764C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiGQNG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiGQNGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:06:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33CC12629
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 06:06:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26H94Lis011519;
        Sun, 17 Jul 2022 13:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vBy3toUDX3t1nOsoI90y+XFVvRFez5HjigXceXPd2fE=;
 b=RFZYkLt6x5xRLRphrpVciAayp6zP7d+wkt/Wc/rFP0C45NortEGSRAB075qjaPeMB7ed
 GIFHGLDgo/vK4R1TFJ+5+kV51YD2CSuzhsqx/aH8heKSNaBgbUqadg47bzyTcXH3V6ux
 4Dcv6nX4ky9sDlPsCYQKWISV35lBR2zOq+J0cllR/R2vVjCFWrOs69he5cTcjTf1iN1G
 H5b+J98ugOFuKlhOSsmUG5HNLwPLuRNDWtiOwFtJ2w+LBvfCEbGpeiX+M+79kjfWFWIb
 0m/jEJIHqXvxtCumZFQn0ARUg3CyvDWW9ttdgmd7gc2cLgU24AQGtZxYcYjyEb1Bl3/0 LA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0sjej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 13:06:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26H9Y7cp004192;
        Sun, 17 Jul 2022 13:06:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3635h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 13:06:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOBSxUBV1UIVCIxJVJDwRBYLu1c8oX3mfSh8BWc71mnQjfBzos0G+Jr6AJ5Yk1z0dqwVNQcTeUpMvwpUtoX4Znux0vcfVaOZul6kGs0EBoViLq0JBY6jIMG4o2al5b8WJcPDAQ+IZoF+2Y7o9jGdPJjV+Zx2RiUU8gTk9EQp4lO+VDqR730zQnlrVusMnNT/X39x19j4D91dNuAwA+x6o8WauhusV5LlDC6Xyy7IN5crqy2XLEMas5upwk7wbzf80VVA0OBTXJ6c76ccoCwoBoKOaADrdmrZHXx86DWOisAW9vUalXeibbqYcHwufSj3aceyVXEANXP1W3EbooRqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBy3toUDX3t1nOsoI90y+XFVvRFez5HjigXceXPd2fE=;
 b=Z1rokGesyza4EiaJMmweUta2vl7xL4a0q250Jd88XlI8BQmWOBllwVA3OaS++l4rK+l9BgFTq38gri0VWNaWcSiykOsxF0njYODVazHgolD/5sNhg1Gq7bnRFuNCOEH56vNMwwZaXvxsGpdfshL8zs4F6ZcTnk4f5/zuiI4oCxHQD8ZvGTxMLFkP2c4BCTdlZTIW55drVBSlebfx/v93xLB1Y+WkHrYV6sar12ho3HMb+I4i2slAr2uYo4RlnQ0jdQ3Xucs++twmBKzGT3rxZmX6wJ6uMcQFSlrnYF73DAWizXPB3pL0KyMyCZ+hmq/Cm484GboHxm6ubwrbGhqBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBy3toUDX3t1nOsoI90y+XFVvRFez5HjigXceXPd2fE=;
 b=fY0hqrfha+HQFoWshDWbqwibk29aY+AATXIkye+1J4cPpV/aE1GrQxe5GXWws6m2RYaWSRIgCq/iNrWBoJCk+p8wsjGQePU22fSQ7Xw07zC89LWhwqvutVUrIOmIXEeNyCY4Vj7OVnEDqSUzSZhy6se4kawVatgeSShmsPogF9o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5837.namprd10.prod.outlook.com (2603:10b6:303:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Sun, 17 Jul
 2022 13:06:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.023; Sun, 17 Jul 2022
 13:06:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v11 00/69] Introducing the Maple Tree
Thread-Topic: [PATCH v11 00/69] Introducing the Maple Tree
Thread-Index: AQHYmYdscyeMwVIPS0CbwXe7JFDqlq2B9iIAgAAa8wCAAHEsgIAABqAA
Date:   Sun, 17 Jul 2022 13:06:07 +0000
Message-ID: <20220717130604.twluuseaopnkifct@revolver>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
 <20220716212050.562604df2a48683dfbcc7e57@linux-foundation.org>
 <CAOUHufaxubu3_Ee-G8q3o02fkRoTf6M7-5=85_B_PUtsWbNa8Q@mail.gmail.com>
 <20220717124221.qwc4pvx6xsiwgefn@revolver>
In-Reply-To: <20220717124221.qwc4pvx6xsiwgefn@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d504d888-5dd6-4e5b-3d96-08da67f51ce2
x-ms-traffictypediagnostic: MW4PR10MB5837:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8MaHCUxHwCzmHVlJXxTGFPi9zMNW3p+luQQEwn7CnNEDVqnV9rDkrBWW/gVVHNrrFVeVNivPjZTnBNFicWjajhv6UZ98vYAFBwJEKoelkJDjreTxOReYOvLanTbZkIvAqU+fm753SafUFPJKn4fMQXR4oeYVELp9krvD2Pns0xoR2hir1QpZL2Gg6OfLHNy2K5Iu5gQvLrQMZGVFJ6F7vAl8xGpDblgfgBFTmm+zRY85dikCPCzB/EcqusQ+SZMR/8BSAN9Uk/cQjD7Uamyvd9Y+/oZjxlrwY0U4Y89b2Cb9mAF8FZBxURwWvXHu7cZ22oehsw6YRdOdZ0wE0ZEtTGKrMRWEwliyKhP4qECq/0mZXK+gXrbAYk8LOZpfYmsQR6AvbwgCalYr3z79jyMF/V8oSjMTB4TVliDxPwM8FcCV14LWAcldhZjn4n6udHetPPWE3/ldZcoI6XP+1jKIgbn6h1Ypa0F4lGlxtXCVYyeff7y9XzLkc3bEhoJocjRq/YJ5cqFuPjOzCgrR39ysHW33z5/AZnOMlbGFSX+VsG3PTonJeZJ1EgiwZSbI11beidFxigin7nZ0hVkNjHyzspdCEe0FIMTFNkob5pQmXUmOI6BWoAxlOZASPkSVpg2+gwyZkXaS41GILz23TOdH3hiveI2tbGo7LdDf/N5hUSKvuI+VfObEuc1bLPfqyb1IAf1FJKV9yHbsxfvr0WQjsJh8PB+nutbPr0ajkpoe2w6ou6tix5Eg/ZLaaIXZ4VNIsW7jDIvFEm3s8wt2zAVuWCUQBGpaZbIgjQR2i4cXhMFEuIeKgE8Tt6AMzwdqxo1B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(478600001)(76116006)(91956017)(8936002)(110136005)(66946007)(71200400001)(66556008)(66476007)(66446008)(64756008)(86362001)(6486002)(8676002)(316002)(33716001)(38070700005)(4744005)(44832011)(6512007)(41300700001)(2906002)(38100700002)(3716004)(6506007)(122000001)(26005)(9686003)(1076003)(186003)(53546011)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SIl4dvcX3FF4pQ9gHRoSSt7NCV2o5TIOklTkSBAKHphLRC6SbNswuWzM63kE?=
 =?us-ascii?Q?WvZEFX4oHnxquAQ08WZ3t6Yfn26cwiA1DRpEyeKb8lhBemrdeVdcAOSCW7v9?=
 =?us-ascii?Q?iKS43AQFrytpdGG7sGtMyvaAT3Ka2Rv9KmXW1qWvHJphF3TqeGz2URAC/oCS?=
 =?us-ascii?Q?cLNhm0ijmMtYMcgmP4RUnRLrhY1aeXeIKcZz5b7sEnCsQQqtWx4zQ09a6OiS?=
 =?us-ascii?Q?Px7USdtRcmfW1nGUvpE0imWfFGH8sv5x8V9OVUjNiV5mte/h7jR/CRjRwzE7?=
 =?us-ascii?Q?+vrPbTFtnqxmBCI/lxJwCWALXb5SQ9D9PEGxSs2jE1bpK2Chju7xTLxRhyfC?=
 =?us-ascii?Q?e4177vlBPRJxFlvqTzC5vi8xLl1+1yNcJkHH3iw+OOzep0vUP1tpbIB2lnvj?=
 =?us-ascii?Q?cz7Nd5zY1kOBHdUVxuBYcwfb6/yd1vF/Z0pOvaXUW5HBdUfd8/SSvPeOmaYn?=
 =?us-ascii?Q?QZoulAoeBWeX2FRoUbL9Pn5NP7Guka6sFyzC7otmNrb6yFQww3NjdQiU8g0h?=
 =?us-ascii?Q?b3LYXUNeeQfiqmltj5I72HyRK/okmsG3X3PAIdQiaattA0M9Kum69Kc9RV7W?=
 =?us-ascii?Q?0/ItvyYEqiHw/ZtOLsLezNvEYQp9RHDO0YGAUxhhjujwhG4M/ZEeiUiHcsvH?=
 =?us-ascii?Q?s8ujDWYkbsnvyrnNahWW5IU9TJO1azQhZnl0pQhmxLugn+3nv3I2uhHCQ8KM?=
 =?us-ascii?Q?DiyZotFRAahOMpVy9R1Hcz7XFWX4TtJ1YiX1c+3GsWWT5Qz8b2P/YTrJt7hg?=
 =?us-ascii?Q?VjVTM7Rf3fYCFEcMaJBE0od6hDWDiASFQwm1XkJek2imSf0IEMgkypDD+zVa?=
 =?us-ascii?Q?NPl9gMVlD70LZ9kV9LQQJrrtAV1/6wbtc4/jLwoogIbt+93c1EbDzbHgbvtr?=
 =?us-ascii?Q?bvLpDM62eqAI4/3xt0Y/04/tsvuCAJNP2dYYNyW8gzF2AkAfEskavfOLTwdy?=
 =?us-ascii?Q?18U5U5dacD+zZaSFIkwuMJ0aNKT6a5jHb0G49zo32Cc6/SPT/dmVaiomOTBm?=
 =?us-ascii?Q?Wpq9ah+d76bgrfni0+tZThGQ8z0X9qV39+hAxDsks3vg5txJmwu9eTx7DeGd?=
 =?us-ascii?Q?wtLTXn0WsNxSRSixiGbkpNUhwGUqE8fvSNC5z7unPVA2gwk8VTQN8GD4CkaO?=
 =?us-ascii?Q?FgeXLMK3aifd+IUR7FSpYIy9GgQcl/ohjgchfJK9y7FXch6Fh5IOKQ0NTgs6?=
 =?us-ascii?Q?HSNfQ9BEB04xzeZwHxhDfZpw9kqsA8QH0yJdqDEiNzO/73TzDb08l+/YsFZp?=
 =?us-ascii?Q?THLyiwY2uD+JqcLYLHMSO5znV3us4Tni/HhkiTga///knyczUQRSWS+XjXQV?=
 =?us-ascii?Q?hlryeNES7fMdKChzIMOCKLBaAfhJr4AvJsjicMh0SBaxwcCyPhGeqxsbDNLh?=
 =?us-ascii?Q?UlGoSZDQi5mglh9n5Bm7Wk1RNcFyFSgIns1346pxAxi+8Viq24clveJ9pIXa?=
 =?us-ascii?Q?6KJ0K/9QiI66pxhZBHaq5yb9JN0nl9Dsz7KHagD7oFfxXBAkjVLMz0JDSIsx?=
 =?us-ascii?Q?l0BHTpTtit5Pfk4RaftEuRDAAdVCuPTcgvATHtXlGoKBMEeBAK9VF+wYh4D4?=
 =?us-ascii?Q?tL9V8B0gZAxp9H/tvS6fO+GoE4JUHgyHuNTC2g2uL4wjM379VGxkF+ATxSbh?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9E354BB7EEDA94EB020DFA8525E4926@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d504d888-5dd6-4e5b-3d96-08da67f51ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 13:06:07.5271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nyBPncRI5xOD+FpcUqsNKED918fRaFsYJeQDY9kmnK5jVlAYjy77EThaFNykESTCWRF9LMbbaMSEeFzbmqW9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_06,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207170064
X-Proofpoint-GUID: -uYRu0FWWEOQfCVqRZ0gHfP1GF3JCqUm
X-Proofpoint-ORIG-GUID: -uYRu0FWWEOQfCVqRZ0gHfP1GF3JCqUm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220717 08:42]:
> * Yu Zhao <yuzhao@google.com> [220717 01:58]:
> > On Sat, Jul 16, 2022 at 10:20 PM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Sun, 17 Jul 2022 02:46:32 +0000 Liam Howlett <liam.howlett@oracle.=
com> wrote:
> > ...
> > >         gap =3D mas.index;
> > >         gap +=3D (info->align_offset - gap) & info->align_mask;
> > > -       VM_BUG_ON(gap + info->length > info->high_limit);
> > > -       VM_BUG_ON(gap + info->length > mas.last);
>=20
> What arch did you hit these on?  David asked for me to restore some of
> the BUG_ONs in these functions and I guess I got it wrong.

I think these should be removed until I better test them.

>=20
> >=20
> > These VM_BUG_ONs are new, and I hit the second one quickly:
> >=20
> >   kernel BUG at mm/mmap.c:1631!
> >   RIP: 0010:vm_unmapped_area+0xdb/0x1c0
> >   Call Trace:
> >    <TASK>
> >    arch_get_unmapped_area+0x1ee/0x220
> >    arch_get_unmapped_area_topdown+0x25a/0x290
> >    get_unmapped_area+0x92/0x100
> >    do_mmap+0x13f/0x560
> >    vm_mmap_pgoff+0xcd/0x170=
