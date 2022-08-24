Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA359FD87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbiHXOrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiHXOrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:47:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BBF70E5F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:47:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OCsLBP017028;
        Wed, 24 Aug 2022 14:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ilct1w5RjRWMRtEDhqYealU2VuAOL/ctghqDYhoycBs=;
 b=Me7jNKCCH5NHfNKs3dcbKEQf1ZDBgUBCOCwQxJDpJhX2NbjAk4URdMacqzhbbxsDBaqG
 i6CCkiNdM3t3HLlzN3fUXqsOhTXUc6pA2W7JlMOQ+pf7GH4+gGyYenXLfjA214ypTXau
 pHajxRsRn/tUIVXeM1xmZyHnrk2xf4JXIblopFdKe0mOsYzKvy06P671HpEIj9J+p7lO
 NwLmeC7T9Xp79khaqL+JcYfMP/12VHPHABydUXkxE+CWG/iI9oQdp8dq1+pDqt6DRDMr
 1fNBBoUmNiNQjoDlY3K4Jcu1pb6/cYbudadwQggW0MuiMQirjPUicWcbQ2gOQXlc3k6b vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5awvhhju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 14:47:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ODk3NA004297;
        Wed, 24 Aug 2022 14:47:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5n2mbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 14:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVDAf1R6O+4pV/7n6zrrkbLo1i8J7IccMazzlEeFspcgVCmbiu0I8LUFugGH+VwgRHAjDBJDlotcX6prYKSU4LKt0ckPorrQTPElA9rX6KLwRuH6NkYh3kZV4NRMxQ8rJRLm87sc3Guc5HUAPUyGvTTjWje55A7AvY8QCuR01YkdYmIha+Igo2F96wjUm7AnSG1hEKml4HvJ30JzXocO3TTrYadqb2XdNLV2qICsZh4R4usOdNZ5WDJtHew94W/LLBWE1LTW0ay+FYyiiNui1euD2pbudS4uvKk7b1Z9RkGgP/FIs2YRqX2ijGiLmbtOHuow3018mtFUNRf/zbcAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilct1w5RjRWMRtEDhqYealU2VuAOL/ctghqDYhoycBs=;
 b=VrvetIc1mfvb59rYMxYhn+8GJcD0k7RQKFlsHj0WE0aXyT68ZfnJ0Csgsc6zX3DONYq7G+q0N48yQV1Fkqq2TaZawMMaAQ9Wf84yLFyvQuWOUar3vHrUCTk0MppE5yxpFJyHxXcTQUWapyXgwIds70OB4jKKwQyuVmICUSqvdzs205aaMxkFixivBj+Ix8zJQGPoxAvEYBKGOKqofEwn/FgGh8eeUhP2GhM1fX+olLipyHY8fb3PzF+5LoSWcgvPRDAKGl5sUFitF6U2hkyzlOHBp1y9VprbUnimvRZ6FBNTUiCkophnigx6t/yV5ttJPnUR/VhSPL0Vnm2prFGnBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilct1w5RjRWMRtEDhqYealU2VuAOL/ctghqDYhoycBs=;
 b=T9AC7wCJmkcX6oo7QemcK1t7k4JJvk7SwOQbE+JJ3A3V0xhCJzsqueqEJ/I0YCgErsLI54F9JfCDaqnZUiqIDoVJs6gg5RP8/CE1d2MgsecYwxoofSFWgVyKIXHrT5wKEOFjcbAym+BQx8zWHNouy9BQR7MILtxcHMokIHN9znw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5444.namprd10.prod.outlook.com (2603:10b6:303:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 14:47:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 14:47:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: [PATCH -next] mm/nommu: fix error handling in split_vma()
Thread-Topic: [PATCH -next] mm/nommu: fix error handling in split_vma()
Thread-Index: AQHYt3BPl7qhCPjxzkKdaGa40G9f6q2+Id6A
Date:   Wed, 24 Aug 2022 14:47:11 +0000
Message-ID: <20220824144703.gwr45mmdk6xl73my@revolver>
References: <20220824042424.2031508-1-yangyingliang@huawei.com>
In-Reply-To: <20220824042424.2031508-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afda32bf-ec97-4793-0fa1-08da85df872a
x-ms-traffictypediagnostic: CO6PR10MB5444:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tUHbrNmnc12NLmSmP0sAu+UVlSX2FEuLt/w+Ead/oRkSx2AYU2iNmk0DPRRY8GG/WDHg7Q10z0plU5O5JBFeGP9hUS79QDzlwt/oBfA23+wpKOMiBAedhFQ63cRe2+qoI4iz0WLhc1aKnzKG/366Daj+Yr8+TbFFWnLHH6eAg1Av3qIlASql+RZYN0c4ib4oJYlUTkEPqBw5eXpZypnVfaJ22XCZsGTTaiH9M7wgtHpjDcMenFvxXU6PzSu+ZdbIZbeLvS543249jeFP66HBsiREEW5Kcxh3Tw2zFA36d23rCFTq72XsZFOrfdtCV4BpVa23J1IFYRL/rwsLpaCDAOCn+suRR6P+TtQwJjmqSA8RZ3GPd877nq0sn1MYDWSzXA80wTWoW1hstelexy6TlMhCpDag1d29cafjJI1KfaFBuE6AHNR+YajJpsqS+foQ8+ejPFPkJYrX9R5h15uMjCSs5Tl/JYk+Lg5fNQAmzeN9/A9ZCxSmGvuNpRHxo4S88yRfAIxyRaht8S04s946J657bNsq2+Tze+BYB2HepzDkW9t3WMhUYQpoumeH6kzRklSxM36a9rbDODvP9nvKGalBmvWMj6mbG1+qqNsFopZuL70no6djxjpmgCCGNUFY0iwHQMeEQU9SCH6vKUz68SHn3qvVWzq8z4BwHsX34/gpCIMw3NyBnEDXCIbBIahNG4J0nKMNRZTJumLE2GRzVAPdKy9Ch5aDSoyIzvuhM8WdENJYlQ8c7HGcHwLz64iLga1djWHTTJ9oN9dt7kLGeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(346002)(376002)(39860400002)(136003)(44832011)(6916009)(316002)(54906003)(2906002)(76116006)(8676002)(66946007)(64756008)(4326008)(66556008)(66476007)(91956017)(8936002)(66446008)(5660300002)(478600001)(41300700001)(38070700005)(71200400001)(33716001)(6486002)(1076003)(26005)(6506007)(6512007)(9686003)(86362001)(83380400001)(186003)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9wrt8OMSUixn+DisM5718zhd0qId19Fk9j2HYZeFwKdslKlZa06PAqeYEtrY?=
 =?us-ascii?Q?zPKFqg4yaS6kjDsZ2M6iwepWLOJkXUPOrbauZ1uoxSzIbnCSeTLkHh5DyoBP?=
 =?us-ascii?Q?CxhzgeyV84lPXtUcVSzhDTb60xoTCC5p3/h+2txVUUw6bmwcFRmaVGz9qMuc?=
 =?us-ascii?Q?uuUuS3IVuSMfA8KYVi5E4kZFggxsDI5tlwUUcpKr5h0hakI9MOf1XvbNSBGs?=
 =?us-ascii?Q?UWVYk9P5cLKdCgIMbyWWSo0BEWK6cdtvM8Pol8NKZL0K9RIR6DxED01P9JC4?=
 =?us-ascii?Q?47edXShaNcIjfvIz2+qDGEMt5PFopSFo2u6cyoL9ZjocGle6YckN0IGcgdlb?=
 =?us-ascii?Q?vk5ttFQEJa7JltlUWUE/pT9W1U7a9g9noKS6QYxOdIxTWB4mAqtMGuQkr4R2?=
 =?us-ascii?Q?11+r3qe5lIyugyjMxGcUXaFtS6hhGuzuRRNawZPwMITeoXYNPBnj8ogksDc+?=
 =?us-ascii?Q?wOFtMUXei7l9vhg5jfkyblXI/UHG7BoavVTSvofYNIBJDJgC6YN7zAD5sFJD?=
 =?us-ascii?Q?7jzDZmZAQQV4f3rTlkIbXoNHh1oE/WwrXBXPB9rHb2TIN/ZMm4m13CFwfsZb?=
 =?us-ascii?Q?/rSuBJNrP1cWP9laDSKDhLZ4UIUvGpilYZpc5U+Ec0QXNyMc6agKGr3uLqZa?=
 =?us-ascii?Q?buPy4VJNRNLErYK0QGg0N1HTKOTD8aeRBiW9iKfGb0tZvQjhOzW8jS9T5mCq?=
 =?us-ascii?Q?xOPqDgcSUJqimROTha6hGfSTZy4uPuVLoZVDw7SL936GKR7DAQlnFvV4EpDU?=
 =?us-ascii?Q?SAF6cfSGDb6X/78E7uHK17TYFKik7UwYQuHH45pfxiDIgnn7ITpqpFBL/rJw?=
 =?us-ascii?Q?CDLsk3vAtxrsj92ezj3rC2m9agwMtbvxP99xHddR93Sv5k0cQk/+1tTVI0jK?=
 =?us-ascii?Q?Ivy2okBmvIeZVjWqAPGmdx3shtZzoCHGwSMOmZ9UFlqXGMG7pOfv4/HCk0vj?=
 =?us-ascii?Q?CxIPIs5T9sQQDmpmfjkKcxOkF+gF2VI+ObODo/JSRmuk5OLQFEKD0ii9jJAl?=
 =?us-ascii?Q?Uxsn0hQKvUnOlgMGrLKcZU1MMm5/ttKBiG+XaumIm/xOZTljbJeS9IamYnkf?=
 =?us-ascii?Q?1M2eA5Ikp1tP5T8wOVFpJ+nbXTwD2x79K0NKi6cWlBbhFgGk0no39IHNfmTr?=
 =?us-ascii?Q?v+PtBRPGsoZI47Smhh1TpewrA1Xt73/gKOgfJcmz00vVl3llyVq50DL72l0z?=
 =?us-ascii?Q?CLDxxXq8Bp2En3SHf3eIlC7GSGOpEzgJCKLRvmais4IE6w7h+3cuqiXFJmNd?=
 =?us-ascii?Q?0rWkZyKLXQfACYkLVcwhD2VFWTM605SPfCrnl8aEMeC5RtCjAiyNZXtPP5qL?=
 =?us-ascii?Q?UoBpOHCOxKtn1HuX9bwkd0WW0Eds+b9vo2VSb4jqR/dsMa4gwW+csIPzvHNQ?=
 =?us-ascii?Q?3Uyf0Mj0r30ifL9J7o+o3LzBy6iIXphzHgG6ilbwsqbTFkUFeqltWi07nz5W?=
 =?us-ascii?Q?ljUWsDzKnawngb9m4cWttIPkgD1eT7imfvKrvzvpcWuVaybo5izz5TmS0BxD?=
 =?us-ascii?Q?9IBeAwrvKklnST7frduK170vQ4NrRdcSdYhdtTE0N0yo2hGYU6JB6ysIL5E7?=
 =?us-ascii?Q?ZTiI/BJSf9JHewdr65IOZ+WYNVqookz+3YG0d8DQh+E4inS8fShylzd7dUHm?=
 =?us-ascii?Q?Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3DCD80C402DB7B489D74B2476AF90EA3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afda32bf-ec97-4793-0fa1-08da85df872a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 14:47:11.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5MPmnPqmxHs5b5sJ7ICKpGKGpIN2qopZaoyiw1zqmvdt5Nt5zDD/NZJs0RHTuncy5Ednwo7wretfMZhB7VAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240056
X-Proofpoint-ORIG-GUID: ioKedOfz_8tOoIk0j-MTaahI4MgC6EsA
X-Proofpoint-GUID: ioKedOfz_8tOoIk0j-MTaahI4MgC6EsA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  This is a valid issue and a good fix.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

* Yang Yingliang <yangyingliang@huawei.com> [220824 00:16]:
> The memory allocated before calling mas_preallocate() is leaked if it fai=
ls.
> 'mas' won't be modify until calling mas_preallocate(), so move it up and
> add error label for free the memory.
>=20
> Fixes: 8aff7dbeaeb1 ("nommu: remove uses of VMA linked list")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  mm/nommu.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 6c611a689ec0..214c70e1d059 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1355,9 +1355,13 @@ int split_vma(struct mm_struct *mm, struct vm_area=
_struct *vma,
>  		return -ENOMEM;
> =20
>  	new =3D vm_area_dup(vma);
> -	if (!new) {
> -		kmem_cache_free(vm_region_jar, region);
> -		return -ENOMEM;
> +	if (!new)
> +		goto err_vma_dup;
> +
> +	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +		pr_warn("Allocation of vma tree for process %d failed\n",
> +			current->pid);
> +		goto err_mas_preallocate;
>  	}
> =20
>  	/* most fields are the same, copy all, and then fixup */
> @@ -1388,11 +1392,6 @@ int split_vma(struct mm_struct *mm, struct vm_area=
_struct *vma,
>  	add_nommu_region(vma->vm_region);
>  	add_nommu_region(new->vm_region);
>  	up_write(&nommu_region_sem);
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> -		pr_warn("Allocation of vma tree for process %d failed\n",
> -		       current->pid);
> -		return -ENOMEM;
> -	}
> =20
>  	setup_vma_to_mm(vma, mm);
>  	setup_vma_to_mm(new, mm);
> @@ -1400,6 +1399,12 @@ int split_vma(struct mm_struct *mm, struct vm_area=
_struct *vma,
>  	mas_store(&mas, vma);
>  	vma_mas_store(new, &mas);
>  	return 0;
> +
> +err_mas_preallocate:
> +	vm_area_free(new);
> +err_vma_dup:
> +	kmem_cache_free(vm_region_jar, region);
> +	return -ENOMEM;
>  }
> =20
>  /*
> --=20
> 2.25.1
> =
