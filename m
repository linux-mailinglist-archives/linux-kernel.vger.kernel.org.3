Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981EB5A11DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbiHYNV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiHYNVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:21:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C0A50D1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:21:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PD8c6J000947;
        Thu, 25 Aug 2022 13:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aF3rJJYnzg7C/ocD1zqdmUZA1NTzRD7pQWzxeZHHsIc=;
 b=V3HEvasnGZgot0NYBwhKYJvfMevT0Mcd/96AdvbKrxWsomJ8HWObkXkQE86km/lQzrMy
 y5vlnl9ckP36bU2MyUZBBd8eneNh1xXL0LhqKBD9XQGiB2Bmg53gGyExTjMaNZeKarv+
 XbR4ey4fSGnI6Mh6CMq2bnho/rOM/6i86WHKyP3uRes0nfsRy88OEqNkqUpJoeFkDmhM
 2S158NLE8hRZWcrlZuRnGlviJO8FH7kgh6W/tJViC6fqyTrlOvy7QU1WfEjR3GKLQgN6
 ztWcfAQ0nZesQfsxw1gbxSgviCOI7vKybZGgcocF3b3EtRof9Ts/jSTx4KhJVWwT9Des 8g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5awvm76b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 13:21:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PCxBUV028378;
        Thu, 25 Aug 2022 13:21:04 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n4maf76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 13:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzdVLpTi4ocdQWFn4IjoV1awHmURtMOSujX/EjkgsO7Ys3AqJZythQFoliehOcu85zMCFY2p7Fuo9r3JQazWJYGmMeNm6FRcoNXGShU2aVRMEnBiF8JKnqxFJxirIgDm+p2vOwsUYIsiqagVd5akqqw6hwijWIzyusOi5PPptNwKD7WlMtffg0aSurZ8FBqCffsX7tLP60ZzevcV6Cz8vX+nmcBVWFN6dhQIPkQvqxk4eWJqRzURB3BcREMFY0phdZY+AXG88HrBZNMO3i6TQVwPLnPJ9GKqO8GG3RFZlGUrSBdhjdsL6jKcThrGCUzZi3GVM+reljszkXiZmNG0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF3rJJYnzg7C/ocD1zqdmUZA1NTzRD7pQWzxeZHHsIc=;
 b=N7sDXUwH3ZnxOi1JZwFgndh3gg9ljudP1z8PjHCh2ahEc1bGELASo5k2bgC1ddgHusuY6xlep2uRZNYnym/j4yrsmPH3eZZ+P8FwhFghdLhJ3o+PG7Ld+DUSBEtXe1Co+j11WUquS6Ls7O/luHOy2Jcdj8D9IQCcOcxZ9RQ07NpxQi62i+iErEEsw7jD0HEopi683fkqTuNS2RrglhfyNPtFHYZ5KkDe6V6iWNQVaG5jwFiY60NGAebLZlCMff0zJPgShtTGsYn/Br3dk+EdAfFEOkkxKDR9WV+Kshw5CmLGrQjCtoidMDc/sLsB8zqwqRHF/Z8kijKUgk8g7n8nyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF3rJJYnzg7C/ocD1zqdmUZA1NTzRD7pQWzxeZHHsIc=;
 b=U7YawLcGwyMOO7sPucYMp9lE/nAhHJH+JHwHK0HkxROmyXqUyWsMcVYVZ+PzKFMXzQhtsdLRnh8aq+3kXpv0Iyxc/zhAccCVzw3wQ0ETTNJDu4KRy3R1eFj0n2qDZZKX/QWX9oSJfosk5z5OFa8gRW9OfUE4fnP6ZyVJCJ/IZhY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB4966.namprd10.prod.outlook.com (2603:10b6:408:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 13:21:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.025; Thu, 25 Aug 2022
 13:21:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v13 57/70] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Thread-Topic: [PATCH v13 57/70] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Thread-Index: AQHYtjjC5w5a5sxoDUK1UuyGlVOoOa2+yHEAgADWHwA=
Date:   Thu, 25 Aug 2022 13:21:01 +0000
Message-ID: <20220825132054.ymenz4cewiemsxw7@revolver>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-58-Liam.Howlett@oracle.com>
 <YwbDmKyQxWHfRg97@sirena.org.uk>
In-Reply-To: <YwbDmKyQxWHfRg97@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7250025-8c30-4dbd-80a0-08da869ca865
x-ms-traffictypediagnostic: BN0PR10MB4966:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P+yTFW86QyGh5pNTWlyrmh3F68L895b7ikZ8Fzz/Bo6IsgHyTlw/APaWaVJOgaKAlIap576t8NGvdQwjsG/Duhsw1q9GTsXiOH7Qo77cWCcqN6KHHOPTFdMN2OoQw689SHiGdx72MImthu6fdIlunjt1H+lf8P8482YDkQmsMV+hR6KWE47ouz3cVzgzhnEtt8/I+y24NEx2GSXIy5lCMXk66ThImKiRuSsWI+TJ636fir5PtpPwBN++x1+3HmYhThtZvXGcPSEx0jUFEqLeTy9xc3BhuINVl1VVHVzJBs1bIziZAt/X2hgS5TsmRQH4UkdwF8KBmRKtzbBah7CzqYpt1H66og5kAoxI2BlkrGr7rEX168iLe0lBMnvYBRoBSBY8HLGCjIFzRdbg8/iJczF7fobdUkGShAB6mIb7AOwjtiRuWRnT2qswMAsM++Vc4q8OMicAwpDLv793SRHH7iz2Kfxg6Orj1QZDFhcD99nVKMqjKQIZExjtWo/kvgvzqm1m4R0CYEwzJkVTEDGkZfa7vAapMpE1UwPDxzy8UYuy4o7kiyTjsAAeywbw+rZGyG+drkSamgGkzT6t5v+mjCUAPqIrtsRdFq3B2rAO2J9+rIPxYbbyR+zQS+eOKQDL8eCZBckpo7pXeNrD3UBXT/cb4+0WNgvQ9xdavoI+MaM10VVLeNNcfxPkQMVobHrxRJCFSw8p3tClIUiuUxdrAFb4fgL0P/uqfKdxnSZboUFEoMqWh6qtd4JBMjlzUXDoqvBRv2wc9v9PHUN+65BcKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(39860400002)(396003)(376002)(346002)(83380400001)(66946007)(76116006)(64756008)(26005)(6486002)(5660300002)(4326008)(66446008)(6916009)(66476007)(91956017)(44832011)(8676002)(6512007)(71200400001)(316002)(54906003)(2906002)(478600001)(1076003)(186003)(41300700001)(9686003)(66556008)(86362001)(6506007)(38070700005)(33716001)(8936002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?meOcNjs73XzFjviaYzdCJQfICgJT9TEMP+0+Cpt8OVSMsyfivs13Qk1U8tlv?=
 =?us-ascii?Q?b2qoH88oRR+g1EVZxNTUew+nPbEILOxZvNJ3xNFinwdJNUza1fLktpPp9fVz?=
 =?us-ascii?Q?7y8eCMyfXCaqQN7TI1dV7AIADCNUc3C8+4XWEYRELd7WC2sbWQvZ9H6RpzA7?=
 =?us-ascii?Q?LMUAfPXngfJjPY96stlPOVX+G1Y1xs6+pavPk8NbaFCouCD0v2bu0hDvjuzf?=
 =?us-ascii?Q?OLRNyIq3TeJ74F0F4V/saguQVr7nCvLR2tcr0MPy2eu1xz2MUH6Kix1pugCC?=
 =?us-ascii?Q?RqYxoXSIOhSf3Xze/ENnzRYNVwj11cl1HRXZM5rojVQ7be/KmccG6JyhWLMl?=
 =?us-ascii?Q?op8mv7v1yYkzoyYuznVrmdC/9A1eFZGc9Xk5SmQrN8JQO7J2kpkZBYTTIdqp?=
 =?us-ascii?Q?v9hCrNEqYqO0S5+r2ClaP4Aj4r1SqySK3PWScnnIPuX+a6JsMCoHkYPdsNg3?=
 =?us-ascii?Q?wVly8aIRxpvE2TlnTorlKFg8sJjCkm5My9Ddqy0Hw8kniE/nhq7me26uc2Fu?=
 =?us-ascii?Q?F2siPCqyMG1nmhbqopFfTBAr78MjOjcgsZc7JgyBhRX625S+pWeOeitbJZd2?=
 =?us-ascii?Q?EfxwT6Vh7PPtJQk6fZEJLdro1Qy6Vs3jpwnCOCgK2EYl5jsyPKo+QIlVsAjJ?=
 =?us-ascii?Q?m+sHCqF7gLSgh8iDhe7Px8nXyC98+qDwixogaKYQ7rqBB1Q91YjQZ7JdIWfR?=
 =?us-ascii?Q?vbWXabMXEXvXB/brQxMfvo+ep28XSN7OYuNFkizmTiPzLTb+lYYsqQrqBZdU?=
 =?us-ascii?Q?96i0BCU3ZdjZHF6JSoC3oofpu3gQVN8Rm04KEixudo8WTDHAVYH8nf2eCOjC?=
 =?us-ascii?Q?EdmlhSrJizuhZGhJU0jKLYa4Rfv6rMOC2FIoKgV/eGpisWBUqsi4oDMIN+Ff?=
 =?us-ascii?Q?pIg9aJBnlhvy30Ccpj3GgBwPGQPc0WqpHNOdPkY73GebMH6HEMICIYH7JpMt?=
 =?us-ascii?Q?HZo/CPyILOOfMeYuZymV3ajNilwsdMUNvie6JuHt2k9IFqTiev6W4PnohBE4?=
 =?us-ascii?Q?5FxGYmWIGXwKB7ufGDGXmRIOU1IlhAb3+pPYA/1O5nVPQuKTncKd+fRGSUsC?=
 =?us-ascii?Q?lyxDMi2zq+0PXBEmi9fXONjrkROBUaAz+cOxxMwldUrtdczwQAsHeqnPNf8D?=
 =?us-ascii?Q?x4q6nYTTm0R4OpM1di65KkDCWd5Q28NmJlrcu/2wY4BS3vSK28sLFnFXkxK8?=
 =?us-ascii?Q?vc/u8Yn13gDN8e5uUbWPf53lULbm4nMDHShkSHiEAATNoSeYlUI5GS8ngAYO?=
 =?us-ascii?Q?ezVE4rR0BOd9mrckYsFPUKdjuHVsWRzbc7EDfwwXH0uhipMCAW9fgoVBFiqA?=
 =?us-ascii?Q?8gaA805uKzK5UxZkpAcTlPEnbPvGhP4gb2thapmaYwX/ycl2FrdfcMdgpfRu?=
 =?us-ascii?Q?EPkLUvHyHNE51iS6gc3xAAYzYTwlskD1ZMPTBWkOjxqpDgVnm2oKKbtGMajR?=
 =?us-ascii?Q?SFZaOUtluF/YTWhkq98wzbUY+RfMe+vhCEvg3iqD/3HNBlQVc5PuMNCBGzoc?=
 =?us-ascii?Q?ZkVKGZ6xjt2b+Ff4g5bB02UgEC9owzY/bvpcX6zM/TVZFeoF40OkMrjMshl+?=
 =?us-ascii?Q?XZal9W2xeduHSt3l+MndO6kBZSli5dJsQqW0PQElhL6JC6gXl8cP1SHN+BBy?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F6D6A06183C924B9948589C3B2EF33C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7250025-8c30-4dbd-80a0-08da869ca865
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 13:21:02.3966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruvymTb1yrNOGqmwsFegJmTaZp9aKlDW8X/CLcieA9NZGKCFHkvV7qp1pwWgidMlHu98DEy6ea1zbnde3I1eOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=863 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250051
X-Proofpoint-ORIG-GUID: gtejXBfS23gC1aypFIh2iuJCcc-NkYAD
X-Proofpoint-GUID: gtejXBfS23gC1aypFIh2iuJCcc-NkYAD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [220824 20:34]:
> On Mon, Aug 22, 2022 at 03:06:30PM +0000, Liam Howlett wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >=20
> > Handle overflow checking in count_mm_mlocked_page_nr() differently.
>=20
> Our QA team found that since next-20220823 we're seeing a couple of test
> failures in the check_mmap_options kselftest on arm64 platforms with MTE
> that aren't present in mainline:
>=20
> # # FAIL: mprotect not ignoring clear PROT_MTE property
> # not ok 21 Check clear PROT_MTE flags with private mapping, sync error m=
ode and mmap memory
> # # FAIL: mprotect not ignoring clear PROT_MTE property
> # not ok 22 Check clear PROT_MTE flags with private mapping and sync erro=
r mode and mmap/mprotect memory

Thanks.

>=20
> I bisected this using qemu[1] which landed on 4ceb4bca479d41a
> ("mm/mprotect: use maple tree navigation instead of vma linked list"),
> though I'm not 100% sure I trust the specific identification of the
> commit I'm pretty confident it's at the very least in this series.  I've
> not done any analysis of the failure beyond getting this bisect result.
>=20
> [1] qemu -smp cpus=3D4 -cpu max -machine virt,gic-version=3D3,mte=3Don

This helps a lot.  I think your bisect is accurate:

...
        struct mmu_gather tlb;
+       MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
        start =3D untagged_addr(start);
...

It looks like I search against the tagged address.  I should initialize
the state to 0 and mas_set(&mas, start) after untagging the address.

I'll send out a patch once I have recreated and verified this is the
issue.

Cheers,
Liam=
