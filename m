Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75309487482
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbiAGJLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:11:17 -0500
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:5766
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236732AbiAGJLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+Ba42UFbePlzeQlkkzhEBDw+7rD5pAoO/2yP9LP/1g=;
 b=4SjNJ46HqDU70KXPW4+xSbXhT6NoTras34Q0RwvQxxetMbuoZQ139wHCa6A+LVoeQXDFL/Yma2N3VGpg6j1Rt/gIi833Jq+t7gzP+r1LILeZabCvo3AXlsOJsxi1G7yJ2jp8FWWbkfHBr+AUhwg4o3+xk2bPPhKMAEZPIqmoKmo=
Received: from AS8P251CA0015.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::14)
 by VI1PR0802MB2509.eurprd08.prod.outlook.com (2603:10a6:800:b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Fri, 7 Jan
 2022 09:11:11 +0000
Received: from AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2f2:cafe::d1) by AS8P251CA0015.outlook.office365.com
 (2603:10a6:20b:2f2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Fri, 7 Jan 2022 09:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT058.mail.protection.outlook.com (10.152.17.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.10 via Frontend Transport; Fri, 7 Jan 2022 09:11:11 +0000
Received: ("Tessian outbound 1cd1a01725a6:v110"); Fri, 07 Jan 2022 09:11:11 +0000
X-CR-MTA-TID: 64aa7808
Received: from ad9f2489b204.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 61C27148-57FA-4DEA-8A33-84AC7976C19D.1;
        Fri, 07 Jan 2022 09:11:01 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ad9f2489b204.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 07 Jan 2022 09:11:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJIrPvrGXcwmzgfVCGIwgqdfdYN2ko8YbNi7dksXR0BZ8qaWgKNtBJplEMjah1SUp4W/oOGXggxxNjl2KCPeUpvSSpTOGH5rkf4Weg0Txm71gAvofyPteGGY1sVmutM9HyGEDtUGhZ0pdnkpf+WIGp7yLFudytV8OWYg5mn/2GmSwMFa5uF13vp35X309rsqaeIVVzYIy+cpQUfHaTvQtnKrJ7a675UjAqzKsP8OVlJArvWceTHb49poc35XqnuwdrJkMJCuvt4+g0Pb//jww03mzJaZypm4Vxuni0gLisYUV52bffD3VgiS7WxUdufWkKIDrL+DOc50xspYFO9pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+Ba42UFbePlzeQlkkzhEBDw+7rD5pAoO/2yP9LP/1g=;
 b=aMdxJ4/TJc08DJl3K2raAhbhnrJqpPIw6rWDzLr9vU4uZ9UAdTXKXzCMcr8CMJXJxTaa5Bs9ESSJ+pYjptLAdz4dRMRyNukjgeFLg/ezXqNB1Crv4zfY26Ov4joh9Ac5SKO1yyIzJxtbyLO8+tm1mQdP4gvyEKbAM3VprfjIu/NHKU1fY07bJ0AU818q8R22KTANRs4C5FLej/IHQnZAEeW/fuPnyedaTUPxqnrelZVJclP9CKEvrSc8e/jJyC1lhEzmQqHPZpmBVK2zhGuoqTxffYnblUOajWdyRxR1D2gqcrfOFKSuQVIZ7nvF48uVkM0z4OvbeEcrOrvKF1M+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+Ba42UFbePlzeQlkkzhEBDw+7rD5pAoO/2yP9LP/1g=;
 b=4SjNJ46HqDU70KXPW4+xSbXhT6NoTras34Q0RwvQxxetMbuoZQ139wHCa6A+LVoeQXDFL/Yma2N3VGpg6j1Rt/gIi833Jq+t7gzP+r1LILeZabCvo3AXlsOJsxi1G7yJ2jp8FWWbkfHBr+AUhwg4o3+xk2bPPhKMAEZPIqmoKmo=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AS4PR08MB7407.eurprd08.prod.outlook.com (2603:10a6:20b:4e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 7 Jan
 2022 09:10:58 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e%8]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 09:10:58 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX8lbt013/nzm8RUa6mdFr92d9v6xU2ImAgAELwWCAAGL4AIABFwGw
Date:   Fri, 7 Jan 2022 09:10:57 +0000
Message-ID: <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com>
In-Reply-To: <YdcRLohx777jzWah@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: E7FCBE87EC7B7E46ACF658863E7CE48E.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: ac0edf93-67d2-4fd8-1f4f-08d9d1bda5fd
x-ms-traffictypediagnostic: AS4PR08MB7407:EE_|AM5EUR03FT058:EE_|VI1PR0802MB2509:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0802MB25093A53806F68089557EC35F44D9@VI1PR0802MB2509.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 79w9rkagme0db+Hvpa2WBfJufrjSzmHWHEG7oUeYJU1oamdo6oejFPUYyAzX19YxYTvJpYzwvZtPBMv3AtI/AS8d3WEFS/Jwj/gTb8pbrImatE3gJLg1XqAK5xULEmP8DXU0Z4Js4X8aWzcWQ0HogPz3/5ixyAhjt/DS7FmNsVOVvy1vOam5Bxye5A25x5uB2mQEaFHXASN4GCIcNIW4IbukhBtmLdzGsfcXe2RMhVzl7tgz2TRp2BT73NoWOwsOFO3E2AERLBAmcm9ueo3ZFbEGyXL6kQIHvALmaAgKw+UpX7fuWVnkJfaZn89r5usf2Q4Uj/oL6lU2wTn9zliDaBTdsnkmL6SlfDKOegOEPWJEEXsDOcKjrGYlEiHUZ1PQOwxfzp9UuoedT7eg4mE150o6O+zbSUBF+INJuiUX4Xn05rznB/TErrzkCi3CMSetv/ZDb9e9z9qz30j3vJn8MWmlgzAM5NZkC1kMSuRdKDWO2dl1bKEhiXj6j4Xix9GG6j8vyVdYV0pnj+EZGw3O8qEf5FrW+EJu7UePnEplLDxkFbX24iQUofERro7hd37SFCSlhe/apTd8cFypAektBMnqnq43xzHHNzSe8OiX2amcNYdLk2BuKYlgSj7V0c8xxztcbN7Wd6Nsp2awb+S11kxxdNKObZunMCo9kWKbNbj/cZ7HyoAqyii71GQ27suGd2izAjicstxnNgcgH5zAZg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(4326008)(66476007)(8936002)(55016003)(33656002)(38100700002)(71200400001)(76116006)(53546011)(9686003)(52536014)(186003)(86362001)(8676002)(6862004)(508600001)(6506007)(66446008)(66946007)(2906002)(54906003)(6636002)(83380400001)(5660300002)(38070700005)(316002)(64756008)(122000001)(66556008)(26005);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7407
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1a938ed9-1919-4b16-a670-08d9d1bd9e40
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UeG/Q3IzkoyzWT7dXgkr5S8wJy1CrYU86KZqTmhNA5hS6BOZjCRjtFLyOVS6hVC/vK62hi0gPzH6g+iTgfVmA9G9VJkVQYW9Ry0oiXJIrOdx1xqeB/ZeOFj69n8gu1lM7fFq2ZLZ0daqDuN9YYMMowG18wCJONGwx6AwrZaSPvx/70DPTZrrWmKLm8sdBkW0sDMmQCVFVxcBvV3h1BsQMa0hAF7w3t500HTdD6djDPfuhVL2lNUxDZY6gVTt/DMyELqw3df3VGo1z1Qy7RwvheflaaQBkNG2IggMWKLDrr3dtvOnHGLuCi9BRsiKKPA0E1ZZr71H9KCfmBAhlSAlON+X7EVd00qtO6dP4uL+eja37kOKGqdFIqDu5Ltxt8NABeKljHPZ0QRjjqnQwU0o7NvWbRIDjlZETHdoofZmVnfXrwtX2lEFKVlMVh68yr6fiSRWKwBI2hqIFuGIzHCs/ZSilh9XFfO59c9EaFcVWnOjVzp+axOhYlQZ3Uc0/WGVXTCZIyGtYYNXQV9aRjeB7A6C+HdN7gwNWeuu34EGlUuV6q63O4rEbVVhuIs6Pf1LiDZelT7PMPbUUhJjKnocKq6m1iBBluEQPYlOgsOD9OyOqreoYh04uBvbCZNW/BClR6ikU5Cd57+yJES7ib4mxjZVcRHhAj9miO66GqqD2q3eyf1h5VCBaoWk0yx44BQ9JM4j3Ykeh6V0pnEJ62e/g==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(82310400004)(47076005)(6862004)(55016003)(7696005)(186003)(4326008)(81166007)(2906002)(33656002)(86362001)(9686003)(83380400001)(336012)(8936002)(5660300002)(356005)(36860700001)(53546011)(54906003)(26005)(6506007)(6636002)(70586007)(70206006)(8676002)(52536014)(316002)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 09:11:11.2707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0edf93-67d2-4fd8-1f4f-08d9d1bda5fd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2509
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

I roughly find the root cause.
 alloc_init_pud will be called at the very beginning of kernel boot in crea=
te_mapping_noalloc where no memory allocator is initialized. But lockdep ch=
eck may need allocate memory. So, kernel take exception when acquire lock.(=
I have not found the exact code that cause this issue) that's say we may no=
t be able to use a lock so early.

I come up with 2 methods to address it.=20
1) skip dead lock check at the very beginning of kernel boot in lockdep cod=
e.
2) provided 2 two versions of __create_pgd_mapping, one with lock in it and=
 the other without. There may be no possible of race for memory mapping at =
the very beginning time of kernel boot, thus we can use the no lock version=
 of __create_pgd_mapping safely.
In my test, this issue is gone if there is no lock held in create_mapping_n=
oalloc. I think create_mapping_noalloc is called early enough to avoid the =
race conditions of memory mapping, however, I have not proved it.

For now, I prefer 2).
The rough change for method 2:
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index acfae9b41cc8..3d3c910f446b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __ma=
ybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;

 static DEFINE_SPINLOCK(swapper_pgdir_lock);
+static DEFINE_MUTEX(fixmap_lock);

 void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 {
@@ -381,6 +382,41 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_ad=
dr_t phys,
        addr =3D virt & PAGE_MASK;
        end =3D PAGE_ALIGN(virt + size);

+       do {
+               next =3D pgd_addr_end(addr, end);
+               /*
+                * fixmap is used inside of alloc_init_pud, but we only hav=
e
+                * one fixmap entry per page-table level, so take the fixma=
p
+                * lock until we're done.
+                */
+               mutex_lock(&fixmap_lock);
+               alloc_init_pud(pgdp, addr, next, phys, prot, pgtable_alloc,
+                              flags);
+               mutex_unlock(&fixmap_lock);
+               phys +=3D next - addr;
+       } while (pgdp++, addr =3D next, addr !=3D end);
+}
+
+static void __create_pgd_mapping_nolock(pgd_t *pgdir, phys_addr_t phys,
+                                unsigned long virt, phys_addr_t size,
+                                pgprot_t prot,
+                                phys_addr_t (*pgtable_alloc)(int),
+                                int flags)
+{
+       unsigned long addr, end, next;
+       pgd_t *pgdp =3D pgd_offset_pgd(pgdir, virt);
+
+       /*
+        * If the virtual and physical address don't have the same offset
+        * within a page, we cannot map the region as the caller expects.
+        */
+       if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
+               return;
+
+       phys &=3D PAGE_MASK;
+       addr =3D virt & PAGE_MASK;
+       end =3D PAGE_ALIGN(virt + size);
+
        do {
                next =3D pgd_addr_end(addr, end);
                alloc_init_pud(pgdp, addr, next, phys, prot, pgtable_alloc,
@@ -432,7 +468,10 @@ static void __init create_mapping_noalloc(phys_addr_t =
phys, unsigned long virt,
                        &phys, virt);
                return;
        }
-       __create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
+       /*
+        * We have no need to hold a lock at this very beginning.
+        */
+       __create_pgd_mapping_nolock(init_mm.pgd, phys, virt, size, prot, NU=
LL,
                             NO_CONT_MAPPINGS);
 }

WDYT?

Thanks
Jianyong

> -----Original Message-----
> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: Thursday, January 6, 2022 11:57 PM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: will@kernel.org; Anshuman Khandual <Anshuman.Khandual@arm.com>;
> akpm@linux-foundation.org; david@redhat.com; quic_qiancai@quicinc.com;
> ardb@kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; gshan@redhat.com; Justin He
> <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create
> pud mapping
>=20
> On Thu, Jan 06, 2022 at 10:13:06AM +0000, Jianyong Wu wrote:
> > I test this patch in your way using both EDK2 V2.6 and EDK2 v2.7. it's
> > peculiar that this issue shows up on v2.6 but not on v2.7.
> > For now, I only find that if "CONFIG_DEBUG_LOCK_ALLOC" is enabled, the
> > kernel boot will hang. However, I can't debug it by printk as this
> > issue happens before pl11 is ready.
>=20
> I tried earlycon but that doesn't help either.
>=20
> > I will go on debugging, but very appreciated if someone can give some
> > hints on it.
>=20
> FWIW, passing "nokaslr" on the kernel command line makes it boot (and thi=
s
> makes debugging harder). That's as far as I've gone.
>=20
> --
> Catalin
