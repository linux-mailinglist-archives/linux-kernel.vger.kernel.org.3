Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2887A54D777
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349989AbiFPBud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347666AbiFPBuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:50:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73381580D5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:50:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FLZwSL009842;
        Thu, 16 Jun 2022 01:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WZOrws4LpUBAHy4Jgesx3GDSNDTUmUG7vkh6MpDT/40=;
 b=BSit45TeybTz4Ak1MZN+YxwQM54zY1l1ZOXSgIkRnpUh3MJ59kTubqRS+Fe86+rjMGVO
 gkWvxjdGMDxzxp2m0InRe5/NPLlebGiExLpl2MbbCzvhNjVRH2j84JsgVdK6zExBHegB
 +Qq0/lBSqZoxdZMotF+zr9f7mmpB43sXflZRKzoaPzcAPUPz1MouLA5wH6Db0okF8DMj
 v1747JFWBitY7rrfDhkyOYYOeKIoiPptdOwU/oxWMnwEnW+WOCMx7GbHg8NTLmtBLe3f
 FxpDvxYnRm2uT5R5ouxVd328lk/4caDi4XnLtPHdP50VaZdepd/KEk2eaes6YLzAw0W3 cA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkkthysx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 01:50:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25G1jlp0022127;
        Thu, 16 Jun 2022 01:50:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpqwbjj1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 01:50:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR928ZdljZpHq95Fxf/0jfF1Qn6iu+kgBlkVlPcUm3InYwqQfz5h0O0uwpaUo2ZaTlpvMkvc+Xt5T+545smH3a3TPZSbCsXeHZSGyOCTxPWGW9yHmdI5ThMhc0lE2Tk15a6x/RkGYk87/1EOTrO+TpJbWgA457iiNuuFOXSk+QtmykFw32klkF3N0RypvePJq1SFm7tAvTaJLg8f0U8Kmf7891XOLP38wjeHH+i7tkh50jwqNmH9NeQCuLpmZWaWwCdteA8rNlui496AMIb/D5IszZsvDQCygT3b5pN8wJ++1K6v8mnY31jfl+2jcfsASyyFHPlunn8tkiwXowu2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZOrws4LpUBAHy4Jgesx3GDSNDTUmUG7vkh6MpDT/40=;
 b=E2Ze4BdPfwt//lUGsAsjkKr9lPfqNShBisFHmjJGLixb2jEN7JOKU4saBczBqv0QmNIrz2hHli4Fgv9EsZBtCceKQrxLN1JwbrIyDmTxvxXe0rM9RiH1nJL+EWKFSNZ2EdAIy/kVTwrdNlcN6JnWsnR5vGevoIUZ2DCQCqnK9yLMOdw47592Sor8JGc0aygApWeg2IHoG9WX8mP4MlKePZK6sdr/id39uk3W3eWCf43Y7cHHcw+9PP2/ZGn/PEzvh6+e8iaRGeHNJ9/G6gJh/7d0vM6x5SX7Gk9BISs0uLUscZmc7bDE1Hmca9V9/0+r0AobTSPq7nrUyLIYtjsOAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZOrws4LpUBAHy4Jgesx3GDSNDTUmUG7vkh6MpDT/40=;
 b=QDJitYuWfk4z2BeNQw0pJ/b4Ef7YaGy0WQDxty8DQms2+Vp/FDIamUC+Uh8DncQfBymulilG5t0D33WFO1mYwfzLed5xCmkTC8OgI4o52oZooz4seQzSjCt0oXjhdscVCbTxRmTYjweVK+e9N9LlGq9TCCMxvuEKppTciOugCAc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6018.namprd10.prod.outlook.com (2603:10b6:208:3b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 01:50:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 01:50:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYX1Q4yL8DgAmWa0qTBFcC80Rd+q1Cfd0AgABF+YCAAAXagIAIFpmAgAAbWQCABc0jAIAAPjyAgAANPQCAAALVAIAAJMOAgABMQwA=
Date:   Thu, 16 Jun 2022 01:50:04 +0000
Message-ID: <20220616014956.6jgxvbzh4ld3c32q@revolver>
References: <Yp3udPy0vuDK8khc@qian> <20220606161940.fh5edq5nyz4jru2u@revolver>
 <Yp4uD8uWB3rit/Ee@qian>
 <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
 <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
 <20220615142508.mtp65w6tdiurtvcn@revolver>
 <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
 <20220615185500.i5bzt7srzm6q72na@revolver>
 <CAOUHufY5dBrNc81oDnmKSyRY2d3=e0CZJiXaOUBs=LFoUBDJUg@mail.gmail.com>
 <CAOUHufZa9G2VDHLPsNmp3yRyXqYCE-3-nT6P7+uf-gbgyOHXYQ@mail.gmail.com>
In-Reply-To: <CAOUHufZa9G2VDHLPsNmp3yRyXqYCE-3-nT6P7+uf-gbgyOHXYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e413478e-153e-484c-fbe3-08da4f3a88d1
x-ms-traffictypediagnostic: BL3PR10MB6018:EE_
x-microsoft-antispam-prvs: <BL3PR10MB60180EB46B07A74838D32DA2FDAC9@BL3PR10MB6018.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7eCEowqky+h/yLgOu8kgeEeNZT9GPkg1JtlDaZ4sjrdyoCICbaoDWweIEbHFCb4W02ehbZ0LCOGcnHLY5ukLVbURA9KRS+Lu+RlVIqw/F2bflEysV7X0CoTUbPTKF1XnkCi22MePIShxrS7ogaH29cy4GhwcvpajE4FOeGa1npVMRpuKrQZywMBvEVNhhWw+jgFtHlfJecNUOYdud43ccKNyy6aNxZZMDyNUwMI7pOg+KIK4w5K46RjSqbjB5zjcVjCdZ+jxLllpBKcLcD9Hu97r/sFgz7ybME9vOs0HQNgSS8Jv3ILZJAXKW24d4KRcH5f3WzEabSNjzmjtvSqW0O3NHJH2b3bdegOsD7vnEWYFoL8EnO8Ol5nnIL5B0NJVxFouXOCy0xF7ngnRT9bm0IPEjc+HbSHLh1cFiruunEGlR2p5g/pgIkPRwYFPa5aTJQ2GUiCueXpeStCgMzBtHLQjsnZfj2U87Trqhk0tPBE2Fdwhn5JzhwoZJ3TmVf50zLgq1PFHIJVrBSMP2COg1PPW5A6MqEadICyXUsBextQfVuy0maDWt2BO8K17/0UvOUsw2bkP2ie+dhBt4gZE/yrBXiNIRxMqccaK5uG/Ed4I4V5TLN0N8534XVpKNJn42u+u9J5hmGgA6EUMukAtwNNb0UKsj86oxsavLdm/ONfHamQPWk0P/9+5fB8RA1sZWbHzPxLM/BZfESNTXUou1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(38100700002)(2906002)(26005)(86362001)(9686003)(6512007)(6506007)(508600001)(6486002)(8936002)(83380400001)(5660300002)(44832011)(38070700005)(64756008)(66446008)(1076003)(186003)(122000001)(33716001)(66556008)(66476007)(4326008)(8676002)(91956017)(54906003)(66946007)(6916009)(316002)(76116006)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qz+sR2PH4PMc31EdwyKJEt4lmH+GRlamwv24UK5uiLFreboOr0FO1D7KfIqh?=
 =?us-ascii?Q?2f36BYS/AbsA+GlUXBETBUrKHydE4GRpQKxC2XVLPWyIduT0/xbS08DoTlsT?=
 =?us-ascii?Q?fP557a06l1NGXvuUg6ceC7rAKsKe+daqCe4g2y703SuosJCK7Q4F8kDifCvo?=
 =?us-ascii?Q?fH/CpzIoAAZFLxo6fOcpxykkj9O9cRJ+ydfzC9yrpOOCDkHfsS1SyLKePMWi?=
 =?us-ascii?Q?MKKY1FERWhXxM0e7/M0Hkli69LVQaHneEgpwVQ8IelmMCpY7yTuyXzuBd1Of?=
 =?us-ascii?Q?vqymPv6PrhdzOsvWVTp6mKVS/Zvbk/l+Ot4iTpt2Q7vyddwn+EP+B9jXD6ZE?=
 =?us-ascii?Q?ES+jeknx7qDA5yvcRH2gkV2b5Lf7/Si0jz23cd9skM8PTgQ62o8gqcKyBznC?=
 =?us-ascii?Q?l4v6RyMm73D/cBJTzyzVRl5L0xe5k/HAi7OqIr9IyCQMe4AjGkfaTkiQJaLY?=
 =?us-ascii?Q?tJz04brRwNLEs53FQQ0sRSgkWflU2wgpiokRPUteOoEOGt8CIilrbnn2HaHq?=
 =?us-ascii?Q?e1tHtJUy+RTfJ4Ljw1HP8dsujI6q4wSCSB9nrthpfxad5jFSNTegOTeOlcVH?=
 =?us-ascii?Q?g/txrFa6WkD9KEwoMeJoQcFGyTp9kxoBA/iCVohE84uAOPl5qwqcVKBaTnZ9?=
 =?us-ascii?Q?RXUNPXMa2UYiY+olhYiTCWv9QRu7exXDtCUpizZvAiwysvSyJTmK2SpfZuY2?=
 =?us-ascii?Q?SbP4VMNd41mgohMwHSMeHBKkZHcgbh4uhRzDD24mm7qDLEKyDzu91LSn77Ti?=
 =?us-ascii?Q?S/zBfp00oQZgPwfPgJ3xvBBvHLt1iH3qx9YOycQiw8Uj5I0DEJWL6O9LlBlb?=
 =?us-ascii?Q?1ZOe1a9q+5PYjD+ESupovEueuylYa75Bn+EYVVwabmIN1/EnrmbRyW31IXvv?=
 =?us-ascii?Q?XjFqsrfBFAbiSgGCR89ZctpJwtzOKRcClIgSqS/3gEi/LJuQkzuMOgXhGmZX?=
 =?us-ascii?Q?KAWVJEVDBvuC+/UtbgzBbbHwtd+lbmCnwIl57SEftge9J1hi5FxjALPPhPT3?=
 =?us-ascii?Q?73ArmG0myYTUFrciK2P3EOcd61Y65C+B35Y9XPkYQvAqvWQafK64SlJUEPiS?=
 =?us-ascii?Q?7lc4I26PH7Zzh4x+LGniCOGIeapNIjrlOVO9xXhURlKg/hPA8+VSBefeAWuY?=
 =?us-ascii?Q?VPdrA+sD5a0oUJLBPuWlXChteny4HzIZJBv2sz7iFsPmT4AxfeKtE6e8+8A9?=
 =?us-ascii?Q?ejQ7cP6PTmAwmhWrfCo2nBiZYZy5Sc/pdKcOatItBuuk8skBljBW2JIGnDYt?=
 =?us-ascii?Q?yFPKPge5sAUQWdj0l4HF9UjtypeKLEOSOnqXWceGp9hO319WkQqBdkqsEcpP?=
 =?us-ascii?Q?XzNiYYODxO60ls6w99SqjWfyGivcyiSBSIONlVuZo2BAEopzeYF9+cmGM7bd?=
 =?us-ascii?Q?uFP72p64S7WOoizodNgOBTAO8j9zlsUQg/ubGsZFN3RuhYQCcNMbT51/Obv+?=
 =?us-ascii?Q?7kMleH/zdxWVDBjLjSenuhjOw06BF6qAudvMeiioUFDkHOTmW935CyQEQC5B?=
 =?us-ascii?Q?eLEhr5Xr+0TAJScvymP+TvOAQ1tuGP6oFm9FjddQy5dsqLF/CqZ0MtmwwSHI?=
 =?us-ascii?Q?dMbVyj0UHnmLGO3FTUaRPataX4k83ooCeu4oH3nygaANK+JkMvV1EgwJ6j3k?=
 =?us-ascii?Q?sBhFGoT4hw5pThjfE5IoQTsOIstZy2PwqGUnBrbEepf3GxI9xAGjggxsmZ4U?=
 =?us-ascii?Q?Bc2a+HsgmK0PCou9eE9YCO+FBQerBrrHSQ8IFMp88+4K02NyTOXG/vjZuzHG?=
 =?us-ascii?Q?M4LbcadDE3UihF4E4/wN0CDBCLWOVbk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3DC21D5780A17E4280A6B16A63E62D68@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e413478e-153e-484c-fbe3-08da4f3a88d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 01:50:04.7881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2N20lslTQ828WuWhVijhoCsVaoWcfYGfYTupf4SqOETgKaNnJuwmwscY+uNCdhRTrSzb8RFaocf8fwhTYDsdyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6018
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_08:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=470 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160005
X-Proofpoint-GUID: QtpG2GCTqiFCBTFga_zKcfdVSJaSjNrJ
X-Proofpoint-ORIG-GUID: QtpG2GCTqiFCBTFga_zKcfdVSJaSjNrJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220615 17:17]:

...

> > Yes, I used the same parameters with 512GB of RAM, and the kernel with
> > KASAN and other debug options.
>=20
> Sorry, Liam. I got the same crash :(

Thanks for running this promptly.  I am trying to get my own server
setup now.

>=20
> 9d27f2f1487a (tag: mm-everything-2022-06-14-19-05, akpm/mm-everything)
> 00d4d7b519d6 fs/userfaultfd: Fix vma iteration in mas_for_each() loop
> 55140693394d maple_tree: Make mas_prealloc() error checking more generic
> 2d7e7c2fcf16 maple_tree: Fix mt_destroy_walk() on full non-leaf non-alloc=
 nodes
> 4d4472148ccd maple_tree: Change spanning store to work on larger trees
> ea36bcc14c00 test_maple_tree: Add tests for preallocations and large
> spanning writes
> 0d2aa86ead4f mm/mlock: Drop dead code in count_mm_mlocked_page_nr()
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> Write of size 136 at addr ffff88c35a3b9e80 by task stress-ng/19303
>=20
> CPU: 66 PID: 19303 Comm: stress-ng Tainted: G S        I       5.19.0-smp=
-DEV #1
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xc5/0xf4
>  print_address_description+0x7f/0x460
>  print_report+0x10b/0x240
>  ? mab_mas_cp+0x2d9/0x6c0
>  kasan_report+0xe6/0x110
>  ? mast_spanning_rebalance+0x2634/0x29b0
>  ? mab_mas_cp+0x2d9/0x6c0
>  kasan_check_range+0x2ef/0x310
>  ? mab_mas_cp+0x2d9/0x6c0
>  ? mab_mas_cp+0x2d9/0x6c0
>  memcpy+0x44/0x70
>  mab_mas_cp+0x2d9/0x6c0
>  mas_spanning_rebalance+0x1a3e/0x4f90

Does this translate to an inline around line 2997?
And then probably around 2808?

>  ? stack_trace_save+0xca/0x160
>  ? stack_trace_save+0xca/0x160
>  mas_wr_spanning_store+0x16c5/0x1b80
>  mas_wr_store_entry+0xbf9/0x12e0
>  mas_store_prealloc+0x205/0x3c0
>  do_mas_align_munmap+0x6cf/0xd10
>  do_mas_munmap+0x1bb/0x210
>  ? down_write_killable+0xa6/0x110
>  __vm_munmap+0x1c4/0x270

Looks like a NULL entry being written.

>  __x64_sys_munmap+0x60/0x70
>  do_syscall_64+0x44/0xa0
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x589827


Thanks,
Liam=
