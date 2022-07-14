Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B05740A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiGNArf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNArc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:47:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C693
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:47:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DNFnwp023352;
        Thu, 14 Jul 2022 00:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qEXsZq/n/Z+8jE/58zTgK8nwj9Mwj0twEhfuydnE4Os=;
 b=zYkqRpQR0X74JwAVPfCAgpWE0pJqilac4UZOgV01e57NlwDY63lcTk+6KN/c7E1z0IoN
 4a1BUnwuRJLayWGTtPrD/yo0nS2D9iCvlcd3SuyBHz4LStuRWS9NQQCFSv0t3iJT4Q24
 lOlt+JPL13uo7Ni75Uz63b97g/aD1m5BqQVWTNHP4AiFeyzuyXeS7sq/4braq2GLkE5e
 PMS979n7p6fOhadiG1dKC44kaSUU10OOKvhsqLfWsEokwtDzGSyIKtWVitCLuetuVWP6
 bO65hjSJAsyyUUZ5yw13MXnpeoAlO3/VxbIm8Sq9aZ/LP/shGFfjHtN0skkZaDIwcaSV FQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scbtgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:47:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E0epeK033710;
        Thu, 14 Jul 2022 00:47:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70457qg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nk4W9yxwi3JGOS8tB+YQ5JCi9knEjVsz3gJXVGn/MXFgw4C7It0uS08yCXPz6thpKMB3mwRrixg0PmQQ5iXDQU6ZvWupkAPscCU6rtQNGVOBPKewqkUr9UGV1ya3I0zrr2t5pGYs3MCPXW/FAcLH5AyhSmu3ym9epvDhHwOf/slx9ufNfQ1SG2YwRSU6E+4Rl537pY6l6OZW/Lt+pvppqHpYWSb5u3Z3npwMZc2ZCeg8wH0o89igm56K+SquAyQZe4QgYG+09NsRjXnEXrP/7xh22m1VDKJHocP2PYK327YMJg4GVE0icMFbYiz89kxkEt4iCWEFJnsLCfvHE5dWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEXsZq/n/Z+8jE/58zTgK8nwj9Mwj0twEhfuydnE4Os=;
 b=JtzEY7h3OT4+YcvCHEpURwxm2CGsEWe0f0yzCRoHQKReqA21rGcG2tqGVsmZX3JbJ+3+x4L8CeBfDGEHZJijcG21OMxS5cdECgELFHfPJ1q2QleuXP5omEfNXX2kBlUmtEIYpknB1x8XA/OzcF5sibBVlX1DeoBBXKKSdtE5bhhg93AIFqO7ziCoAD9PIpjWSe2kADxflawupETlGbYv7GLm7QU3DQTvF1gJWe7A/nMppdarhrtRuRnCUFipYUIQ+698FBhtOGxjNvVZRLKgDSBR7GW7KVVkjnhEdmWN5f0skdO6qcySK15ckn0qWp5vq1UKm0YpH1ZzXuJdLKVfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEXsZq/n/Z+8jE/58zTgK8nwj9Mwj0twEhfuydnE4Os=;
 b=iU1uBt+dlV/7x4yteu7I6loyKbJCVDznVLo/dUSbWUKG0re+3R6jjHeuCBFaCZEfPe0KgtgWP0AniUmVz0uuI4VRYJu699V2Zg/WfuZ9KdOXw78t51wEX1jNmTLFogECYgPLExsz0bM6scdWE8IbEnWoIU6y4lc4SXA1mD90ngc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6070.namprd10.prod.outlook.com (2603:10b6:930:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Thu, 14 Jul
 2022 00:47:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 00:47:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v10 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Topic: [PATCH v10 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYhbALqTBpFGf5+k+LdWHoM0UZLa1dQTSAgB/p5YA=
Date:   Thu, 14 Jul 2022 00:47:12 +0000
Message-ID: <20220714004705.wqw3a5wff7c7cmbo@revolver>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-14-Liam.Howlett@oracle.com>
 <5972b785-a98a-ca3d-8c21-8156dd981749@redhat.com>
In-Reply-To: <5972b785-a98a-ca3d-8c21-8156dd981749@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b935d150-bf53-4f5e-a4e1-08da65326404
x-ms-traffictypediagnostic: CY5PR10MB6070:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YceLCECjAmd+q3/c9rlh9gfDy7ufTM0RcA7aKCHlryggIZA3pW+bGQW9ZOR6KtsKm7fEACp8HCbNitsMdNrvydPbDDz8XH7fP4EPhZA8C8zjekpQJRqShUVjEjbovdI95U98dD0WkEr/lctBHcRm1TQgfxFeGhp4f104OADgNfmJkdZs1TfXIOW1mdTX8frT6/edwZkpfTPqDQSDsOgiOVQOf8dY0NgO13rrIMHRcO7dN602FwM4Qipotd3pIkpmc78Vkhn/qfBo4C5tgB3NxKCGkLYwpPH5s5fNnsFb5Qezbs3iIWEvWTBGB30GWbmDpgsCVxhNw5kLMdo7OArn85TdH1wT5auAxXY226LUlE9t6eGN6vI8G37wjMsDwqkxDGp6/wPk3S/076GRmRn2DVazYLJSXRXk6Nn2TvldgkkRA/qXtWWdk0hy3yfT5cnzJSUaBSbMy6D2dqOBCC5orWp3GW2LuGPoFJ6wEySwS8aBlQJWEDtjIBsugcEr+AaVumoqI5gFjosJbhATHDs0oXzxb9dnjTu29stLsr0apvq1UwAL1tLbtUvxdblP28Yp5sKzCuPWvS3o/0DIuboRQGNW0aOUXSJUfA83Lj0r5LAodMBvefjCezTmN3QriCEimNxvZB+AzXsSwdIl48dr/KlmZHUl2C2uWII8MKeSFpUNkrhqxz29AKC3k+C1BxqvybMVqaJhQCEMfpGQmDpl3FyXC+dSjfhZgLX9IREz127z0xfQGBVkthDLg9qevcICsmYfgF0yufdAOM3l/xKGoourmk11YQeraQVwQJzp08sqqCXo4P/yYk702q+wXjMedG37Bx+OkkVWTJV7Uqj0Jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(376002)(396003)(136003)(39860400002)(1076003)(38100700002)(83380400001)(6486002)(44832011)(122000001)(186003)(86362001)(38070700005)(53546011)(6512007)(966005)(8936002)(66446008)(66556008)(41300700001)(6506007)(316002)(6916009)(26005)(71200400001)(76116006)(66476007)(2906002)(478600001)(54906003)(91956017)(9686003)(4326008)(33716001)(5660300002)(64756008)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9P0sTDIBv/UluWBEaWFJAUSXjr8g+FSKELjU9vRNU50G3o0JM96KdncoT0Py?=
 =?us-ascii?Q?nH2VImsfl6TuB5F6LQjVm5fN1bvmpF/I4AXnGFxxx3Y6Imm1edEAYgOVyM8k?=
 =?us-ascii?Q?0VNzf9oQN43oghR+s5W9C/qfSHGPj5nYEwJrh76GxEC8xnRqpBL1fKCr2jbB?=
 =?us-ascii?Q?95wDUBbWzuRc7DvXQluRf15kFO4pUCI6FmZqugEVfWZFMYL0P+rxsDxu+Phl?=
 =?us-ascii?Q?jL4oGWNWQ9syAUGWcBcrgSI7UdmBVxx0WQ7XcSDb0GwCRHwyQr2Q7Owbnjdq?=
 =?us-ascii?Q?9HJNicAc09oW7q2sSZ/JMko5fcPjSmeEPrT2oD/1niSJ7+LNqV8vW+feSJ9w?=
 =?us-ascii?Q?C3NCFnt8Cv2yPC2BiayiM5GVTGwB770rOGKVKUxqk+ry9R+E9CollFy1A345?=
 =?us-ascii?Q?Gj41KUIc+rsDr/noyyKjtDw6PQFGyEOO/vKRbhjDQGVFJnV5OxuiJpvMs8cM?=
 =?us-ascii?Q?1q7hibYkdcbKh3wnlG10EBV/iG0Ph5p34mj71mDvR3uhkrwMa1/qkGXobg4J?=
 =?us-ascii?Q?kzbU43VOCZ+RtIlbciFS6d6Kht+QoQ/AHxN11FDOmrr07XnigduP23VYHaVl?=
 =?us-ascii?Q?oeErsYVvf5iwrllYEc6tGcVwDE8H7N1QVdFZJyOayVcF8N7fl2BfK0owIlAu?=
 =?us-ascii?Q?KW1fDRU0e9kCDahsb4RIqrYl4Uqj4xVysA3ww41Zee1rm1HcSYFXjK3+PS0m?=
 =?us-ascii?Q?J7a+6BqHCRtDfZg984aeP3Lla6Uw4vAceRj/q0K8JT+WsLZ4XsbEH/gwHrJx?=
 =?us-ascii?Q?KNfg8li8go7+mEQcZ8EQCet5qfZRJywvQIfyliwgXOy22OVR8LKhIo593bWo?=
 =?us-ascii?Q?2tXR/GLKF5+BMzhnI+zVAazdOLeQIJozHfVdKjASu3HcJx1raJ+Jk3N/Yl9J?=
 =?us-ascii?Q?wi69NMvCSl6g0cG2o9xwQws9Aceix2+bdqJ/CnlQP6Onl9Qd0JFqz3nMz3hM?=
 =?us-ascii?Q?zJtjw2ZaPNRT7MIihdNKtlSbKJwBKRm1bUNFij2ADUJqJ6G5ogia6hfSc18d?=
 =?us-ascii?Q?nvBMFqEsW4fUcTMxFNgsxkzGYJszCiSKzvcxTtfi7/WN5ZOuiexAVZgOEYfE?=
 =?us-ascii?Q?US1p7RMI98+NDrGutqnT0+v2x48JviUu2PgwnGCN9PZKMkL5/9e9jLH0ASDX?=
 =?us-ascii?Q?5n+3Z3h+eMyzpOtyPDh9n+OD+vhiudQMXCRDCS6+cNo9bdLkonX3TK0JFFvY?=
 =?us-ascii?Q?GqqJT/HMVMsz1A33oiUE0rOv7C7SXZdhFMIy7AmlK2Wa0QbrOfT2imnWtp9b?=
 =?us-ascii?Q?K3JYxGmJXMrGpQp3T/kflltxvZ2ZEbwT4xUvU0/HW/ljNBIF6NOFC9UCSbp3?=
 =?us-ascii?Q?/2IDFqTnaYdG3v/rQcrSQ+Xc6ox+bSrrkVJeuWNGCJdBVTEWgFxGaU7yAQA7?=
 =?us-ascii?Q?WyP8Z8lfczKuYfvf3INq183qYBG28vi0sPM8yq1MspCuOOeAlHy5I8HF01/3?=
 =?us-ascii?Q?4+Q/qkiKB89jwY60Vn+Ewfx2Te8VgBDyz551Wi0nFE8xlWyZLolH0PZL03v6?=
 =?us-ascii?Q?AGwW1Z0gsG4NwLjqxG1utwFiWFQp3CHGJ2lo/WFjjIOAeUpNYecOlXYTywY8?=
 =?us-ascii?Q?RkGF91MxRg1IVHQAy6Bw1599cUWKgBYcmYkzmQA2OD8yoLTRQoMPRIFyCrKp?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD87F37D0F48C3438EB126D244F9CA8E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b935d150-bf53-4f5e-a4e1-08da65326404
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 00:47:12.6517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nROS3+7ZS6ougJp01p3eUgglS66UHDOpkk61M7eh8Z57389ufR+E3QdXlF0C4GempXZxrh1EI6Hrrlpm5wCTcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_13:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140001
X-Proofpoint-GUID: scej1p2R3JfUgGpqcMMyRi4H_LFbcwUY
X-Proofpoint-ORIG-GUID: scej1p2R3JfUgGpqcMMyRi4H_LFbcwUY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [220623 13:26]:
> On 21.06.22 22:46, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > The maple tree code was added to find the unmapped area in a previous
> > commit and was checked against what the rbtree returned, but the actual
> > result was never used.  Start using the maple tree implementation and
> > remove the rbtree code.
> >=20
> > Add kernel documentation comment for these functions.
> >=20
> > Link: https://lkml.kernel.org/r/20220504010716.661115-15-Liam.Howlett@o=
racle.com
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/mmap.c | 253 +++++++-----------------------------------------------
> >  1 file changed, 32 insertions(+), 221 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 08845a0317bf..b91d22329418 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2053,250 +2053,61 @@ unsigned long mmap_region(struct file *file, u=
nsigned long addr,
> >  	return error;
> >  }
> > =20
> > +/* unmapped_area() Find an area between the low_limit and the high_lim=
it with
>=20
> /**
>  * unmapped_area() - ...

ack.

>=20
> > + * the correct alignment and offset, all from @info. Note: current->mm=
 is used
> > + * for the search.
> > + *
> > + * @info: The unmapped area information including the range (low_limit=
 -
> > + * hight_limit), the alignment offset and mask.
> > + *
> > + * Return: A memory address or -ENOMEM.
> > + */
> >  static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
> >  {
>=20
> ...
>=20
> > =20
> > +/* unmapped_area_topdown() Find an area between the low_limit and the
>=20
> \Dito

ack.

>=20
> > + * high_limit with * the correct alignment and offset at the highest a=
vailable
> > + * address, all from * @info. Note: current->mm is used for the search=
.
>=20
> I'm confused about the "*" in the text, but maybe I'm just tired :)

So was my auto-formatting, I guess.  I'll fix this.

>=20
> > + *
> > + * @info: The unmapped area information including the range (low_limit=
 -
> > + * hight_limit), the alignment offset and mask.
> > + *
> > + * Return: A memory address or -ENOMEM.
> > + */
> >  static unsigned long unmapped_area_topdown(struct vm_unmapped_area_inf=
o *info)
> >  {
>=20
> [...]
>=20
> > -found:
> > -	/* We found a suitable gap. Clip it with the original high_limit. */
> > -	if (gap_end > info->high_limit)
> > -		gap_end =3D info->high_limit;
> > -
> > -found_highest:
> > -	/* Compute highest gap address at the desired alignment */
> > -	gap_end -=3D info->length;
> > -	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
> > -
> > -	VM_BUG_ON(gap_end < info->low_limit);
> > -	VM_BUG_ON(gap_end < gap_start);
>=20
> Can we leave some of these in, please? (same applies to other function)
>=20
> I keep getting confused by align_offset. vs align_mask. I *think* this
> is correct, but some checks that we stay in limits and actually have
> proper alignment would be reasonable.

Right, so in the version that existed with both rbtree and maple tree
had a BUG_ON if my calculation wasn't the same as the rbtree
calculation.  I'll re-add the VM_BUG_ON() statements as you suggest for
good measure.

Thanks,
Liam

>=20
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
> =
