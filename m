Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8365076EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356120AbiDSSAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356112AbiDSSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:00:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E54812630
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:57:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JFjFtY024754;
        Tue, 19 Apr 2022 17:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rbPqrni4DNo1YIg8wLLtCTb5kl93MrQZpiQ5aCC4qF4=;
 b=l5oOes+WVdU6rREfQxr1b2sLGS9rdPIK9Z8hE7cQtT/dsSrnXaxspRYHMvipw5/cCWuy
 g/vXx+5WAfsZTw+I4ATGsynL9if52tYO8RghNgzdR0QbSis5DFrAQvviGAYFyPIMdxT3
 48g0GeuzCL3y/cv5POl9uWoWOOhRG8YHkhqye448D68Q5zuGJWjm7A45u3ZEvNjBFbOD
 yKdm5Q2J1ep5oXQxGgKbBh8EKUb/YhOazzTNtPWcRu12//JNmkVOy4tBfVTVUT4QLTW5
 9eChyimFvXSIn54T5EJeG5bxyOOfWZpOanahUnp774EDNy7MlxME2SnT8RSY1YK7HcSd OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffnp9ep7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 17:57:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JHpe03029829;
        Tue, 19 Apr 2022 17:57:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88q762-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 17:57:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1z6FFv0XCK8aUMu4Z2s1V4KoTbeUCY56JvjpIY+Fnk9KmDoRkWAkzvchRM91j+JcgoydacmfoWOZqEFsRsBvWnT/fFI3jBm6v9NJJ6v5bnnRGGT0qe0BYLG8qrrSJDgKVamF6imnPA0IjuchaYN6ht221SmGs/Kl5P5PBtLHlave3LaOjZJhKFiBXw+nMQ475WIbqj/vEAD9fzCye3OI98pFYR/xGyi93T+R2M5NgJSu8W8Hvpvu0BfOZnv1lB/mpGnY8PX8WrW+qGTu1+tecdzlxQclz+25uTQQbD5jlWHn9FoYgyD9kIxXybpQ52Z00+gDgvOvv0WWUSplpn+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbPqrni4DNo1YIg8wLLtCTb5kl93MrQZpiQ5aCC4qF4=;
 b=SSKdBfvxLM12Qmq/qRSUHAKuHn0ECa0g5FIxnlnquNhBrX/zLjUM0WGhSAOzl24C6z8SUu7toks/J02MqewhMLN7VwXo4nVvV3b/m2cbaHLkHeUYETBfV9MpKAE3+vGwB7gRvXscEEXszo9PWKo/VIm4ISxDncJOwbBZd94GLWNXrihtPd7Ogbqpayz9RIs3JCDBXsn1cutLA/oEckHwEwDrC5VnMzM73Zm4UaNNgYHNaqFFJp6qGhjKnBe8vx3ehPnDshlJubxK8ZeNKttj3bBDh1KapZc+ZB2tc8dkIRKbppYsJvcf//A2Y67Cdk3TNf+KxAKM/fhbOX71x826qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbPqrni4DNo1YIg8wLLtCTb5kl93MrQZpiQ5aCC4qF4=;
 b=cXptwHC2L8KQ9hfLY9tPOuTpSRd1JvmbUgsvfBQBpCQ6XXZanxiq/baxMR+VOk+CMRy5ULMpG7Nchv/+NnCvUUuwrpMk2ahChGoRVLGzMgIts/Kwh3biHLh0HI178OHDchGOYkc4Q/firQaQh8m1Mq6vRwVn1iLriPBm5hRvKK8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3172.namprd10.prod.outlook.com (2603:10b6:408:cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 17:57:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 17:57:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Yang Shi <shy828301@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 26/70] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v7 26/70] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Index: AQHYSDFDzZid47DekUecu9wIMdQJOKzvB6iAgAiV5gA=
Date:   Tue, 19 Apr 2022 17:57:46 +0000
Message-ID: <20220419175735.5737a3z4owx3wyzx@revolver>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220404143501.2016403-27-Liam.Howlett@oracle.com>
 <20220413235109.132da02b3c2a883332ada39c@linux-foundation.org>
In-Reply-To: <20220413235109.132da02b3c2a883332ada39c@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81342985-0c1f-40c6-5e99-08da222e1c57
x-ms-traffictypediagnostic: BN8PR10MB3172:EE_
x-microsoft-antispam-prvs: <BN8PR10MB31728750412842D98801D126FDF29@BN8PR10MB3172.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEz1Q6C9OIEUOd2JLBTsZ9Lvsf+6mR5Ny6Fph6arDcZzeDciXv4Sa1wVKV1IJ6adboBrwL7e1aoutqt7fNtGhUid9FNJ5eDMpWSVCjAF8dxhZhEDxSktFBUUdpkCfZZlsSE23plxCfg0HPOJS92Wmt03IHgU6/WU/TiuEI7RJN5vp6le79txOg0AaoH+Ygh0lfsibebPBa0tPJapu00boKybUz6O1lx3VgSPVdO1Lnipd3bZNwDTxMsl2jHz0vOhiBZnTfweZSuTAw8TpMYKU2IEzoulZlrQulEpeDf6DZd19KFddcz6+LjmFSi1QifE5n7rFmGpirfU5ZzW3G8a6Qb12WLlZgEM+P+vUZpbK9HYSKHD4xOJkKVmSKBU2I8CBkoGrxgocCLoltAd5wkEtW3GZ/dKnLVvITSE/U8Yud8AGeV+c0Z0h1Lmqg/SVc6Sw7/i5jX1ewH6rBzvFV2c9DctchvU1QAdNMiGugtzUWW2eMRB80vLsZO+5smupVUWBVtl8+4LOzX63/kcWCnT9Qg6NT2hKb24iR7D4fEU/fswwTTnwTP4yaygGtIfxiVaPEFkgDMKu9fPT6c+FRKEVaTeNddOsjnsJQ9lgZCXrM/9BxZOQG9numi7Mdci1zwDVPu3Q+37wAE4ujJ69G/aNnSD4ZNv8jMmMjMEIq1SAblpvpQ6xAJzq8utBJe4aaxfsIuJ5LTiRB39Msn4ULOgb+AjUPelrgzOcIcV8qZPicgHLp1WXUjvsbNup/rZV5HOaG4Gmw6T0Bu7u3e9NZuchtH18k6Ep0PgfV6meaHfhLU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(1076003)(2906002)(6512007)(66446008)(508600001)(316002)(38100700002)(38070700005)(122000001)(6916009)(186003)(54906003)(5660300002)(6486002)(86362001)(71200400001)(44832011)(6506007)(8936002)(26005)(66476007)(66556008)(64756008)(66946007)(33716001)(8676002)(4326008)(76116006)(91956017)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nHcCw4iVO5XLBxtyFZAW+XlOKI29PuA2rUPWmmGtmvPRsljU+Gx6k91mbIH+?=
 =?us-ascii?Q?nLkZHtjFKDOUvQUFjhwunBfm7iBVjWLPuQ8kZrnUGsqUVJGpjZwGR1EX0FsZ?=
 =?us-ascii?Q?oGFEyuQ//Ijmvn3CbzoXMlwCW2XwBCMvLsOPNqiOeWTECiEIAeA3io2hUOrr?=
 =?us-ascii?Q?mmUwtCBovgemaYLo0yM0yL9qyCNZHLPhNncimpKEAPm2xHnUFVZoKZyBq00U?=
 =?us-ascii?Q?+vYzdPePlFpgWiLj4AEbrSU9iNANRaAVXFeMCz3VROoJCUGfk96S5xyOgM/E?=
 =?us-ascii?Q?N8/VBGtQQDY2KHZ306zpFcyYaqBfaP3ARD1/FE4kNj4vnz5bhSvCbw3lKvuw?=
 =?us-ascii?Q?h/U/slG7Ol2x2o3eqTWNi6o+HcE3CgJhwEXF9vccVFfTqp4FgKn5WG1q0lev?=
 =?us-ascii?Q?eC58GSL3bGJjpmBiUTwYmIccYhJRus95t3451Cg6pxtS5FWxGcK1cW7U5j+n?=
 =?us-ascii?Q?yjtaJBnk7MARc5sLu2/nffXbVJgME7NIyuQGi99A+Qu7OrO238wKRESbONVa?=
 =?us-ascii?Q?yu5Kv6FT8R1er3r/CVUvx+aJ8yUo71ZlVIEBsp5wcRZ6UdQ7ewAYn6djYNy7?=
 =?us-ascii?Q?DuQ2iQVL41+GjWVSpij0Mzj1pujUnlX6FXIkQzA7MdJFWHJAv9nAJfeZTK3X?=
 =?us-ascii?Q?iovKTRQ4x2Oep/Fm8EgqXK2MP2eh5/QyCMs79QjfNIpa60ShnNP4L+oBhyPJ?=
 =?us-ascii?Q?4jhE83GrT9PC+8w/5+FwBDp2O+70KrN6OUfd/MCgtYHvKLe1sREDuQPEKAT8?=
 =?us-ascii?Q?jNi7QyWdMGNrK61C/v76F18uNTnCASZ872VF/LJEJAdsV2lDiiCvPW06ypfb?=
 =?us-ascii?Q?v3v5R6ztnWwidYXgSomloIapjShtp7Aagbu4uaMvPun79yaM8H+H/Mzu0xPl?=
 =?us-ascii?Q?rCqi5dk9jVGLigH+NefNqNarZ4nBVS4y5nLp+6unGVmcVjs2MTjNxvQet8FP?=
 =?us-ascii?Q?DVjfH7CDE5dEZMgqa83IXc0JGRAeFXJqSQV6ac3mxnfoOlJ19yH/uBwirc2H?=
 =?us-ascii?Q?FBZ6FjdE+TAMQ5uTnq/9Nugi2NHYE0coJyVZcEpIn5ef0HAae71LY1Q1qzME?=
 =?us-ascii?Q?10+I8qbuohx83hCFpgKscm1AdKuBPoROMt5o2JqiqI+IZuEK3GcSo4R7SMJS?=
 =?us-ascii?Q?q7rR9GCit0O2oojVYMVp192UchgAp5MmoEw6E8qzz3iLHhmkroMwgK8SQO2W?=
 =?us-ascii?Q?ocB9lYpXyVYR2zyAvdhDHT+2Q63HKP3RwKJyWOIOlboA8RVcuG380VFp2R+C?=
 =?us-ascii?Q?lUFBsBzmKOcbgyDkeqTH85+pQ1JQH8rD7FWP9LqNnU+Zu1hrGmzPlvRU3MVn?=
 =?us-ascii?Q?g8zhWPhGbbaU5YtS+PLmAuXQmZ3o5UohQbeu/zKSlSuc/zNFQAnmmGO7PYdM?=
 =?us-ascii?Q?2Em0Cd9vnEV2RFoTrWLlzqugO3GXXL79iZe9wmwc13hbEJA4j4yatjbyUnLZ?=
 =?us-ascii?Q?UQ9kcvt6q+GczbbyTlQOWv+/zzvjIpMmjMGMIjOHjPRh9WRl74zqLCZ3Z1O0?=
 =?us-ascii?Q?+DbnnLSsiuC2gsf3zXUAzozo8M2v9BdZ/Tq4UnuHJ+Rxi/SispMGqd5Wkb6Q?=
 =?us-ascii?Q?YVUQUZwc+RLLmTK7+k6E1bBkvJOrLftAxAn8KrSUQqu/lY3JIsykihlDYquT?=
 =?us-ascii?Q?NjcV/kluXCAChIVqO0LwkuwCzk3hKEYDlgphsCQ95m0BLNo6QjyKS87WBjDw?=
 =?us-ascii?Q?l4QNQKBt2ioKcwIqCBEDWPf4ZSyoZWy54VgPqg9m+kKlhbEDFB0nliHGnV6R?=
 =?us-ascii?Q?5GYGD2n4jkB+cG+MX/xoks2z8LPE0qQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0178A9A272D46744BE2F0362EB5FB499@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81342985-0c1f-40c6-5e99-08da222e1c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 17:57:46.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxUvhoO/tnylAEVuk5ALrHW7YkVe/8+1iPMnpRySxwQ7o3dk3YUPJKE+x4arbWo6mzQDEVE6iPZv34cf/Ie+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3172
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_06:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=412 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190102
X-Proofpoint-ORIG-GUID: It6DC4JSmmf3t97kehbFdmNFQdB7XIN-
X-Proofpoint-GUID: It6DC4JSmmf3t97kehbFdmNFQdB7XIN-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220414 02:51]:
> On Mon, 4 Apr 2022 14:35:43 +0000 Liam Howlett <liam.howlett@oracle.com> =
wrote:
>=20
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Changing mmap_region() to use the maple tree state and the advanced
> > maple tree interface allows for a lot less tree walking.
> >=20
> > This change removes the last caller of munmap_vma_range(), so drop this
> > unused function.
> >=20
> > Add vma_expand() to expand a VMA if possible by doing the necessary
> > hugepage check, uprobe_munmap of files, dcache flush, modifications the=
n
> > undoing the detaches, etc.
> >=20
>=20
> Merging this with Yang Shi's "mm: mmap: register suitable readonly file
> vmas for khugepaged"
> (https://lkml.kernel.org/r/20220404200250.321455-9-shy828301@gmail.com)
>=20
> > ...
> >
> > @@ -1741,13 +1868,28 @@ unsigned long mmap_region(struct file *file, un=
signed long addr,
> >  			goto free_vma;
> >  	}
> > =20
> > -	vma_link(mm, vma, prev);
> > +	if (vma->vm_file)
> > +		i_mmap_lock_write(vma->vm_file->f_mapping);
> > +
> > +	vma_mas_store(vma, &mas);
> > +	__vma_link_list(mm, vma, prev);
> > +	mm->map_count++;
> > +	if (vma->vm_file) {
> > +		if (vma->vm_flags & VM_SHARED)
> > +			mapping_allow_writable(vma->vm_file->f_mapping);
> > +
> > +		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
> > +		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
> > +		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
> > +		i_mmap_unlock_write(vma->vm_file->f_mapping);
> > +	}
> > +
> >  	/* Once vma denies write, undo our temporary denial count */
> >  unmap_writable:
> >  	if (file && vm_flags & VM_SHARED)
> >  		mapping_unmap_writable(file->f_mapping);
>=20
> I'm unsure whether this hunk should be inside or outside the call to
> the cheerfully undocumented khugepaged_enter_vma()?

Below.  I've replaced the vma_link() with a write to the tree and
inlined the handling of vm_file.  At least, it will keep with what Yang
Shi wrote in the patch you are merging.

>=20
>=20
> Code snippet as I presently have it:
>=20
> 	if (vma->vm_file)
> 		i_mmap_lock_write(vma->vm_file->f_mapping);
>=20
> 	vma_mas_store(vma, &mas);
> 	mm->map_count++;
> 	if (vma->vm_file) {
> 		if (vma->vm_flags & VM_SHARED)
> 			mapping_allow_writable(vma->vm_file->f_mapping);
>=20
> 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
> 		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
> 		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
> 		i_mmap_unlock_write(vma->vm_file->f_mapping);
> 	}
>=20
> 	/*
> 	 * vma_merge() calls khugepaged_enter_vma() either, the below
> 	 * call covers the non-merge case.
> 	 */
> 	khugepaged_enter_vma(vma, vma->vm_flags);
>=20
> 	/* Once vma denies write, undo our temporary denial count */
> unmap_writable:
> 	if (file && vm_flags & VM_SHARED)
> 		mapping_unmap_writable(file->f_mapping);
>=20
> btw, "vma_merge() calls khugepaged_enter_vma() either" isn't
> understandable.  Should that be "also"?

It looks like it should be "also" to me.. Yang Shi?
