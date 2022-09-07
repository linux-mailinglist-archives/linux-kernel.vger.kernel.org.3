Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672A55AF8EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 02:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIGAZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 20:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGAZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:25:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A889240AB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 17:25:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Ld8DQ014578;
        Wed, 7 Sep 2022 00:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tVQWTuW31/SQ9tuEeJ9OEB5BIICGShvctYeSP7SUE4o=;
 b=RJSYNhldpFH8jh4u5IIcOhMsGl33i8d33j9Iy3RG3Ua/xKSykrjDVNOQm2y8Ank4Q+th
 m388dMiazZxKIwdS48OZbUDmqb6PS3FWKFj/9ql7x6B8i5tAY+PyMSn7usBVBpAm2wur
 E/XugpBt0ACFS9Ue0IqYCEMdoscbu1dbvrkLHpDa2ze4dluaZGImW3qsrHpRlwP8c+sZ
 eDfUxqD+j3r1KpvEURcv9JLA5WWADsQCFR5R+JO0Sr8YNJsv+SopG0ndNrZjR4OkkFEN
 xJzHmiwmpufO0bHT0jdlb0Ii0II/W7FaxEreIcPJnNEiuX6O65FcJwc5c29obMeMmG/W 4Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1fdwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 00:24:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2870D7CZ027555;
        Wed, 7 Sep 2022 00:24:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9vf1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 00:24:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXbrPoPI4mKypdD38j3ri0GNKsDuSMN3cf/d/r3bBWwSxYgHbdTNGqJthb/dAqi6JM9XYyvpGIVcMaq9gWsCNEWu7ueQy9844TafM8DuPl7Kb1N3/lv0TEghHT45ifTExaFI+6GEBC5EO0Gvo6nThFNlLKaDh4ko1Zhwr/Jt+4EFWONEU+NmvuZ0PPgTQGgWL0G+Npe3Z5z19WpJNf3ncIZolR/xlYPMfKnoDjaPRGgR/rl8m3pd0xmd77lWq2AFnk3UIvGxOeFlfzrPU6ZCBxqdpISaba4nI9Pe43pCksYOZqtq3tY9Ae9nad1wofpZwDdKBEVNV99mCCUUEQbPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVQWTuW31/SQ9tuEeJ9OEB5BIICGShvctYeSP7SUE4o=;
 b=dnZJTTfwsmUytgANrpqnULeq+DrBNa56f+JUn7MzEkV/8ntE6ExDnBrZq8lc3ZRe521qE60gmB97H3onUlg42drGkrByLJU5y9TImc4WIyi5OdY+7ohzutGbs+1SF/Y0GHYejnlNo6Pf7vSGZuGjl9oeUcNTrsuEokTAhZVhJH3icy+ajqXqjtI0CxIr89LlIjssL+vEiPWxcLbsBJ3KwD2msiCSaig8+oJVnwX3gmoHWofCIhCxiv+AUY/aGcbA/QA3THeh5Yoijy9PbttbOZjIvRuPRUlfphuz1ZhfWMCaZvfiQtXzswwvRA+xcBoWiN3+ChGn7oG9yEE/6Mf8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVQWTuW31/SQ9tuEeJ9OEB5BIICGShvctYeSP7SUE4o=;
 b=pWE2NhaVv2e4kdO6vr2NOQnOHKWfECGqfGBPdE7OqNYMWwYmypx1IWFvey5nl80NLKGuFhysL60zuRpfuxsor2pl2jl9dE+9RpLWJQnb6hlvEl+xtGajWDh8pFDR6Nao3gvOMIEa1BR13dmC8mC+8W1p7LtDxLTBxDFE7AV3llg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Wed, 7 Sep
 2022 00:24:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 00:24:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v14 00/70] Introducing the Maple Tree
Thread-Index: AQHYwimon9+qH6EC0EalpC37Vnej1K3TEsAAgAAJXYA=
Date:   Wed, 7 Sep 2022 00:24:52 +0000
Message-ID: <20220907002441.55okdnja4jnshazp@revolver>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906165110.07cad9a730c630af4425ca33@linux-foundation.org>
In-Reply-To: <20220906165110.07cad9a730c630af4425ca33@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f68a79a7-db16-4040-7c34-08da906761fc
x-ms-traffictypediagnostic: DS7PR10MB4926:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZHTn9Ke/wXVNGXWT0cJ32ZjRf6JbDsoULY8NJoUiZ4mErj+byd4U6aKGvfDMEOnTPpjwCfLf9GMFIveG571hw33m1NPYFEDrXbSusIV/Kwl4fafJWUwNxhf7c5sD4i0opUk7C+b6ocmgMSfvDIblbjOaDDZpNz4NMSYeid/XsrmMJdUUBBwphKEBxCrY/am/LdEuPEfh8eQgiU+ESez1ti6zPp15uCY9cTicNIKFdnfADnXVoFY+v4WQ7D/RS8rabE3ps2dAuMYO8fRAf6EPLS7VnUPGmyEMOhi+rSMWgx7Xja+lnUDe1HXkddBN6kPf7h+tpNvGqLfcStvwiTfMgvQU6/IxuGZirsJhBzuHsQ3IOP+oBXInkbk8rbNZIPmG0WIZLaXl+0lXjJG3OjkIcY7u1o6ZwST0aXY8fvwOXSuS85P9bmRKFG1+et6OPB1nv4crHGGZsxvx6yP1IdJNA06BavDcsOzPLZLGERLVyEU6zWSC5Q0pkTnKr3L7M9uS0mHk6t3pQr3qjuIEHOFuq0jpg7fEa051VIjV+zzksKPV04R3iQnjG8emTluBsOjgh5/X+0WelS+PtN+3xPSUi0F+mV+tSuI7yAaYZfP0DOYzV2Ndlo+vB6Yhc1/CzUVOxq54ZsopM1z+tywTBEcS604Hy5KYJFvHaApEtG0ZfB4dfUfLi299h+0yRchwqUkYEA8aZ+ju2jMf+il4tzSAT5YQ9iGH+vaJaeO8Pbuoz9MLPVXe9rgbVVYDYq8JwncsCBYJo91WuHscdY47g6AyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(136003)(366004)(346002)(39860400002)(91956017)(478600001)(6916009)(66946007)(54906003)(66476007)(6486002)(66556008)(2906002)(66446008)(122000001)(86362001)(316002)(38070700005)(38100700002)(76116006)(6506007)(41300700001)(1076003)(71200400001)(6512007)(26005)(9686003)(5660300002)(8676002)(4326008)(64756008)(186003)(33716001)(4744005)(44832011)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wos8+h69SfR3dgGlFS1qeLrdCvJP1tjK7Vs+kWxqv5AHWe+ilYe1tGlEjUQ0?=
 =?us-ascii?Q?dA5lBjj55rveabIbvyVbODzazN7AGb7ynJC7y7iwiIgZgLU7V6cCNPod6edl?=
 =?us-ascii?Q?6Aq+2YUnVUUSSEDEJgfA6Egm8azmTBlFrtzRrSezuhsb/QoB+LQkK/x2HEiy?=
 =?us-ascii?Q?lQvXOg9a7B9MNCElx7HBwCngfny/YHXqdjTHBb68MJEUHd8uYEwvDb3di099?=
 =?us-ascii?Q?mTWQVq5yep6gUqdMYFYYZdQevkX7moZChyhaTBSPVzv8hkCO3XTrWdhvtLpp?=
 =?us-ascii?Q?pdiN5/Jj+QiMj6ab1/TvFJFuqOrKefdouXlMf6FUu6AyK3IE0e/DtEeZQ9IK?=
 =?us-ascii?Q?C8nyuNC/nbnczryYLuqQjkbCA9p48nh/QG1MU9AUzTWW7I31YD2s2XsnvR5A?=
 =?us-ascii?Q?8d0gvpWFUxDQJgNKC7Ljv28rrd4QJ67Pg6AHP8UdtAHM8duQemgROgeDGgEE?=
 =?us-ascii?Q?3xGtZ0o8GU3nrb4p8mcteP2CjqHZsv4/SrMIF9bgxHyVyrWn23Q1xI+DHoy2?=
 =?us-ascii?Q?NxKbgDhuZa+COV5MisJZH4uJ11XU7k6Wi7s0DSyotmUKSdS3HjittpEii0Kk?=
 =?us-ascii?Q?3NYpmdPAJnRpSwkkM0yUYdTdbrDfOUhPeZ59G/7+GxU8lTbegsrTRndF1qEz?=
 =?us-ascii?Q?OP4CezHezFs53eSIcll1BVoTOtbolrbi3Cli36Mh+2Gzl4UQOTnpCx/pBIWJ?=
 =?us-ascii?Q?bMBsE7ywZv6Y8fSY0RcDOmyA6PDKBW3o5PFhklabwe/URA8s4Vx9uh0HSBG9?=
 =?us-ascii?Q?HQdFFnBmlOgx4eEHmxwsNUFAaXeYmPVDqPSfB8Qasa5iGEW4nqfssFU6MMei?=
 =?us-ascii?Q?gScY7RUQO7uG1TdbfmJjsZV7UfZlUcdzyClDLFHKqVeunKvuEy6R6/iAExOt?=
 =?us-ascii?Q?JKvu8MkDiNnc1CiVj6zUYJrs5EcS2TyKqFPNXXqZPnPDdt6rwkdEROQBIbtU?=
 =?us-ascii?Q?hSAVwOkFtlxy8VyXbU3MvJjlnro1iMGCP7VzfcnFaO1elaKeWOA+YxgQVOyS?=
 =?us-ascii?Q?I/IMMK/+Q2A8CUzIACdTamohn4SiLvnjeGYzSQzH9IhWOX7axC8NTpPnB9Jj?=
 =?us-ascii?Q?Rx51KLoE3lcQRZgB0J9MorHLDJx0gf5eZgRrcpKbHbw9pTUN2Mz0Hxalqvmf?=
 =?us-ascii?Q?aNBfN41tdGHjXsrloQEocuxsZw+vnqmf++owCZ327wYEz4wu3dKw/qXVLppX?=
 =?us-ascii?Q?o8ESR5YFtIUQdOBuV4N7pU2nUl81DC9WCRl61LnbYycJWfDyOGTVcktSMMHU?=
 =?us-ascii?Q?+OtuK6CVUVNop17W7kn7dlkgAzOvB5ndslYPSoXMieYEgoe77JTogXSkW6qX?=
 =?us-ascii?Q?BriBxg9kPQqtyBGf7pPwFjuiEJOI+nhpinmmlKUW4LQn3Wm0x5445gnaQei4?=
 =?us-ascii?Q?97xF6Cs7ueY56rYAjN0s+k1X3WcbOWoAgt8lsWPHtoLgmL8zYB/1cwS6D/YN?=
 =?us-ascii?Q?F9Z2JAowoLUfq34LUNmJVtwd9QGBDYpMOQSCyE3z0mELMCyirU0OYTGWqlPg?=
 =?us-ascii?Q?6mBvD0RSWLb6zsber20/859cNcDhxY6kbt/qdAfVICL/Wdg6N9R5UTtrxfDO?=
 =?us-ascii?Q?7/0rV5tUnT2C4E2zJlSUwx/SU6kSUOhQDBjlOLGhJgZh4aNcfM+r1HyA+V+3?=
 =?us-ascii?Q?TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12CB6910A35FC24486EA6CF395239BDA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68a79a7-db16-4040-7c34-08da906761fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 00:24:52.5845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6HhWhz4X2nZapnjsHu+mXNWhIX9hTQ3WuSqvZjdQle+ZwmYSaHn4NMJAvqAaaUcFhlvKgmYNUxdXC3dj5Oc9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070000
X-Proofpoint-GUID: hS7rFloncZmfY5chIZrylcvXuHTz1_Jg
X-Proofpoint-ORIG-GUID: hS7rFloncZmfY5chIZrylcvXuHTz1_Jg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220906 19:51]:
> On Tue, 6 Sep 2022 19:48:38 +0000 Liam Howlett <liam.howlett@oracle.com> =
wrote:
>=20
> > This is the v13 + fixes and still based against mm-unstable
> > v6.0-rc1-140-geb22a5b1b495
>=20
> I merged up this version, thanks.
>=20
> One fix was missed:
>=20
> --- a/mm/memory.c~mm-remove-the-vma-linked-list-fix
> +++ a/mm/memory.c
> @@ -1697,6 +1697,7 @@ static void unmap_single_vma(struct mmu_
>  /**
>   * unmap_vmas - unmap a range of memory covered by a list of vma's
>   * @tlb: address of the caller's struct mmu_gather
> + * @mt: the maple tree
>   * @vma: the starting vma
>   * @start_addr: virtual address at which to start unmapping
>   * @end_addr: virtual address at which to end unmapping
> _
>=20
> OK, tiny, but worrisome.  This is one of the reasons why I dislike
> replacing patch series like this.  Hopefully we can get to the finish
> line just with little fixups from now on?

Yes.  I only wanted to respin for the changelog delta, ironically.
Thanks for catching this.
