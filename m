Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163B14862BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbiAFKNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:13:33 -0500
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:13409
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236733AbiAFKNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyjgEEkZnx0QQ4YS1o9FE70OD8/sz1yU5oQsg1M3lKo=;
 b=Gw5w+UE4Cli77oSw5444SX7DjnPgtgSN539yHBeF3xowDnNxFD0vh3LH1Rph/BgDPt9kJkWIEWuxNCdQPmEIQtzLwuamg56U9vX9EI0lIljUGGat7cYdu5t6yQqOwSXddNkTv+NL1WiRWJnT5bhtYwS58nf4L1utBQ+0NpvmKWQ=
Received: from AM6PR10CA0029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::42)
 by VI1PR0802MB2432.eurprd08.prod.outlook.com (2603:10a6:800:bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 10:13:14 +0000
Received: from VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:89:cafe::49) by AM6PR10CA0029.outlook.office365.com
 (2603:10a6:209:89::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 10:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT051.mail.protection.outlook.com (10.152.19.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9 via Frontend Transport; Thu, 6 Jan 2022 10:13:14 +0000
Received: ("Tessian outbound 157533e214a9:v110"); Thu, 06 Jan 2022 10:13:13 +0000
X-CR-MTA-TID: 64aa7808
Received: from f696d2a42ab5.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 40CF8FB9-BF1B-4BD9-ABD5-DAD3A1D904D3.1;
        Thu, 06 Jan 2022 10:13:08 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f696d2a42ab5.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 06 Jan 2022 10:13:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elaaMQAVglVBGHHYHAU17RwZduJEmX3Q7RTz7GSL4jJ3E8tueNJUsb7blqb9LjWhnbqP0q+jNar4cCFVWNWyDTrpmIqnrniXZyGU3tpBleV7y55ExKtN63pMYCtRXQjLIm40Af+6HBzuaT/fdei7H5R5pWG9fUCp08SYDW0iIE9g49pcPiVJr36xCet62cpMxhJgJ895+GQ4doQBgZM96Rj3tgqe/ioqtrovC5RBffgjJmEC5Phex6ojYo8JTpFJur2N0JVnRxqOHIJbm2Pqf+RGsECV8iVTJkSQ3d83bX0OeIG8llDOAGLnLbJC8urGv5RMuoEgsN91HZqxlw+gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyjgEEkZnx0QQ4YS1o9FE70OD8/sz1yU5oQsg1M3lKo=;
 b=g0Euklqk3DDIJH2fpKL0Xy/F4pxaAzaZYagqHRlO2y2Gv0Tx1y9qPCPyq4g3a/5KXrV0Qrxz/3vePMtreZQNaWPIT/y3OiTgoEYlofsdqM9tblpPPjsHn4aornagOfkC/LmLH3PTqqK0to+Qa6cBi/PbMHNBWKhtcRyJAvQDsWmyU7ALATNnoa1uKleRTl2Wh/FHtCiBeTNB3/bH5SLekNmCy/2dmU7y4cJADohgkN9zaOiIzca0sbAjRuFBao8DtIdntq+ghCIOmbDoVK5n2mNXrzcCisKevFSfZdj4NspkAnHgO3OQxkspMMDaA7Id3jd8BjARmusccG6PNnAP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyjgEEkZnx0QQ4YS1o9FE70OD8/sz1yU5oQsg1M3lKo=;
 b=Gw5w+UE4Cli77oSw5444SX7DjnPgtgSN539yHBeF3xowDnNxFD0vh3LH1Rph/BgDPt9kJkWIEWuxNCdQPmEIQtzLwuamg56U9vX9EI0lIljUGGat7cYdu5t6yQqOwSXddNkTv+NL1WiRWJnT5bhtYwS58nf4L1utBQ+0NpvmKWQ=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AS4PR08MB7405.eurprd08.prod.outlook.com (2603:10a6:20b:4e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 6 Jan
 2022 10:13:06 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e%8]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 10:13:06 +0000
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
Thread-Index: AQHX8lbt013/nzm8RUa6mdFr92d9v6xU2ImAgAELwWA=
Date:   Thu, 6 Jan 2022 10:13:06 +0000
Message-ID: <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
In-Reply-To: <YdXdjcJ7jbnkFsqp@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 9366C9EDA486DD4B8DD441B95A2213E3.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: a385695f-8fc2-4c39-bebc-08d9d0fd269d
x-ms-traffictypediagnostic: AS4PR08MB7405:EE_|VE1EUR03FT051:EE_|VI1PR0802MB2432:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2432D39445C3BF6D0406B696F44C9@VI1PR0802MB2432.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: x9hhW+635ZRIEcquHvp/QW+/tmaWfd7qticHcxoRNDbVLSx/FFVumI4bjZHcYnepB91/St4/3+rv61ZRTaoxfxFkduNcSqACHz0+XK3f0iEs82TNvjtIciKyXT5QqyRuQwYLv4YT070I4BTmB7JRO18tc+//eKn/Oth71QmgazIDmmRwq7CCemmbD/5fjMvj5jYx/6GN9NPsVVzs4310KI7lm5IHiJ+Uak1cWsN8UmJcR+EDwB8M0xE1FF6Kg8lsmT7zs9bXi/6/X/AxJUIM5kylI9/5i7ZXkEe+xVAye8vVkrjAf/70/re0LIl2NXn8ARe9xapZXgogmqiOIPXl6ghOHTLchVobs64vr2ca1BSRtcnXqBsX+cU/jLVnAhS0TPukG8hueoCOeccRygSVXRUCaQnFHX86c974VmYq9iYBWHqTs8UuwukBcgsF/pekGaL1UP4ZM/X7b/C7R94QZ7ZLGZ5sHyGVzi+XEP3Y+K7L9bEGMONJiLUfM28NUgoeLlmp5ziEN7rhE7/mZVZtqV4Xd40eO0j3vcMIq69hfEIYAc8GkjOJNyOe7jpuNSz0CKBj7r+Bc8VoA+X1e4KZ7CaC61YslcEHE0s0m6+7lV/mY8iSOHiTLIBZDcsbNnqMn0x9XVuYSasiYD+LA1/N7+PteqY3aE+SEAirAO54287GGxOQMtdtErFpuGIcSELBVtoYF4OypehVgk1QzEDoVA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(71200400001)(6636002)(53546011)(6506007)(66946007)(52536014)(86362001)(9686003)(26005)(66556008)(38070700005)(508600001)(8676002)(7696005)(38100700002)(4326008)(83380400001)(5660300002)(186003)(76116006)(33656002)(316002)(54906003)(122000001)(66476007)(8936002)(66446008)(55016003)(2906002)(6862004);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7405
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2f0a0e6c-bff6-4b98-48d0-08d9d0fd21e8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ff9HAsHiseHpfYDWmFh37qcRU5I6RzjkKAZGIy7ItcovOn1uPz93W6XJe6pthsiRpsgR+EXGHT/4a5upgDl8jWpi9eeA7fjrsIB9FV2in3RQ/2UWrIb97ZQSh/XE92WMyXoB2ykCHUv4xO88gTPljVBNelACuEm5sz/x6+acMOkLWi0R6ygx1Qrh25bIyJwPcXqiQxIwtCl/CMvoK0oCYHyWySrAJAdYI3U96CCNoHbXUXtTAk9vutE0oDTAvTyGFVted5BJFXGdcOmSSBNhje4xnCFgJ/MkHD16dtjuuq3tfaFFn6wKDSjT7DUUqyF56u+cbfIjGjstVb2nmpqgjYVJ4cvx2FWliYDAfyLrrIbasgfKLm+sn49yGpKjC/raiROb5D2fHUfNrw0LMfWncq1Iul+dFykigLC7T+c24ZfBJts1t3AUtDTt1++qFarL2NWq57LM51c9JP9FaZiwvAsVnsjNywkc4ymD9WrGLJabOoEMpLOFnTwhyvsJZW3/fq0VkqOylN1LaVFJ6B28CNvZ8CoRRcFauJz4VoaNLQzjfqi3Ms49/Y4dWrpmP3z9JWBEg4TW8gUnQWu1w/Sc0BkOvJLdTv4HOBkMNPzz8SCVCb6j7jzCYe1zLayXABj5ukQAqhHJrjsVWdL9Ee/kxMsAezGxVY/3UE8LB3BeM9niw1Sr5socx7c7t0pF10cyZM1EDIJc9s64W/CQirVro05HKKjztgTut4NWjOyAAVedNdlK90qTZvrHvc3YRrnK+CJTpa/yv2oFVyl7ynZfPw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(6506007)(316002)(186003)(53546011)(52536014)(8936002)(336012)(70586007)(54906003)(8676002)(70206006)(6636002)(33656002)(9686003)(2906002)(26005)(5660300002)(82310400004)(7696005)(6862004)(86362001)(36860700001)(83380400001)(55016003)(40460700001)(47076005)(4326008)(508600001)(81166007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 10:13:14.1738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a385695f-8fc2-4c39-bebc-08d9d0fd269d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2432
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

I test this patch in your way using both EDK2 V2.6 and EDK2 v2.7. it's pecu=
liar that this issue shows up on v2.6 but not on v2.7.
For now, I only find that if "CONFIG_DEBUG_LOCK_ALLOC" is enabled, the kern=
el boot will hang. However, I can't debug it by printk as this issue happen=
s before pl11 is ready.
I will go on debugging, but very appreciated if someone can give some hints=
 on it.

Thanks
Jianyong

> -----Original Message-----
> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: Thursday, January 6, 2022 2:04 AM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: will@kernel.org; Anshuman Khandual <Anshuman.Khandual@arm.com>;
> akpm@linux-foundation.org; david@redhat.com; quic_qiancai@quicinc.com;
> ardb@kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; gshan@redhat.com; Justin He
> <Justin.He@arm.com>; nd <nd@arm.com>
> Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create
> pud mapping
>=20
> On Thu, Dec 16, 2021 at 04:28:12PM +0800, Jianyong Wu wrote:
> > The 'fixmap' is a global resource and is used recursively by create
> > pud mapping(), leading to a potential race condition in the presence
> > of a concurrent call to alloc_init_pud():
> >
> > kernel_init thread                          virtio-mem workqueue thread
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                 =
         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> >   alloc_init_pud(...)                       alloc_init_pud(...)
> >   pudp =3D pud_set_fixmap_offset(...)         pudp =3D pud_set_fixmap_o=
ffset(...)
> >   READ_ONCE(*pudp)
> >   pud_clear_fixmap(...)
> >                                             READ_ONCE(*pudp) // CRASH!
> >
> > As kernel may sleep during creating pud mapping, introduce a mutex
> > lock to serialise use of the fixmap entries by alloc_init_pud().
> >
> > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
>=20
> I tried to queue this patch but with certain configurations it doesn't bo=
ot
> under Qemu. Starting from defconfig, update .config with (I had this in o=
ne
> of my build scripts):
>=20
> $ ./scripts/config \
> 		-e DEBUG_KERNEL \
> 		-e DEBUG_PAGEALLOC \
> 		-e DEBUG_PAGEALLOC_ENABLE_DEFAULT \
> 		-e DEBUG_WX \
> 		-e DEBUG_SET_MODULE_RONX \
> 		-e DEBUG_ALIGN_RODATA \
> 		-e ARM64_PTDUMP_DEBUGFS \
> 		-e DEBUG_OBJECTS \
> 		-e DEBUG_OBJECTS_FREE \
> 		-e DEBUG_OBJECTS_TIMERS \
> 		-e DEBUG_KOBJECT_RELEASE \
> 		-e DEBUG_LOCKING_API_SELFTESTS \
> 		-e DEBUG_PREEMPT \
> 		-e DEBUG_TIMEKEEPING \
> 		-e DEBUG_VM \
> 		-e DEBUG_VM_VMACACHE \
> 		-e DEBUG_VM_RB \
> 		-e DEBUG_VM_PGFLAGS \
> 		-e DEBUG_VIRTUAL \
> 		-e DEBUG_LIST \
> 		-e DEBUG_PI_LIST \
> 		-e DEBUG_SG \
> 		-e PROVE_LOCKING \
> 		-e DEBUG_RT_MUTEXES \
> 		-e DEBUG_ATOMIC_SLEEP \
> 		-e ATOMIC64_SELFTEST
>=20
> It stop after exiting the EFI boot services. I did not have time to debug=
.
>=20
> --
> Catalin
