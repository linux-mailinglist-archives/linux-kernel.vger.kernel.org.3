Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6718B472060
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhLMFYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:24:41 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:27714
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229697AbhLMFYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy4B0yNAe1O0UdY91kXakVynpSclkpMeChc8RgkeBZE=;
 b=JMa0zyTCC5UypJhDcxwLcnLSLtwQY2gj+e17u47i7Drw7vdQaHmuOqIu5qtAVRrcr5yNaNzJ/vbk7g+lnW08q/TeWQRJiDu/wv/nfKddq3vYRbUGgah0UqyqhCtcpRl8gQdaL/YjKvQE4IyUPCc9uq+7FToJ2zTUJvq2qOwa/MM=
Received: from AS8PR04CA0109.eurprd04.prod.outlook.com (2603:10a6:20b:31e::24)
 by VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 05:24:35 +0000
Received: from AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:31e:cafe::24) by AS8PR04CA0109.outlook.office365.com
 (2603:10a6:20b:31e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Mon, 13 Dec 2021 05:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT046.mail.protection.outlook.com (10.152.16.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 05:24:35 +0000
Received: ("Tessian outbound c61f076cbd30:v110"); Mon, 13 Dec 2021 05:24:35 +0000
X-CR-MTA-TID: 64aa7808
Received: from b43339d91a52.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E83B700C-E02C-40B1-87E8-F28C7EDCC1C6.1;
        Mon, 13 Dec 2021 05:24:24 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b43339d91a52.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 13 Dec 2021 05:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cbi1lMn6VzRavlM7dQ3NPH+2zKuPdtRJSGMAypwd1f4mrR8q8UEhI0AbExexr2r1NAh8sDPbNGFPM4eueLZD5HicHY4WH/GUdOCMIXNRT8Pxwaaf5fh8N7DQU7G/7duNae+BH8yPONFH2o23cvb4/4DAOg5+/PsODoRJ+5JiJt4SFPdLAj85m7qtBozr2kaE/4f7D8wzwWKvVqqAiCYoMASKBf02SzTWJtNHLj3S7LopsxIdkK5AUwmdxEtB0bFbY/QD03ImyqetNV+eqx13EauEXDbcgWrCVtrOLelcNlM03ubjVSSYaUc3LZsNbNiGj+hqKTbe8gomM9zGzgBe3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy4B0yNAe1O0UdY91kXakVynpSclkpMeChc8RgkeBZE=;
 b=lRqKX2cVGAhSQoX06rPU9nQk9z2C2BmhpZZ1mxiP+2au+MIaClMRzBoodNBSspEtHWG1g0BN27yGVOyI1BMPGADt6rlVClLX21EAPLd+6l1Rto+t08IG/F033JH3Cpn3ZOk4GniaHer96xxOjUQ21VaOeR2Jq4XYs9lRKfFtEn8Vp6dX2CT9YpYIvXKQEVXgx5OR8Kl8MNc7cA4L0X9plJ2d4wcs5mGU8sSRmqECuhxCMpjCt4FxFODT97hK8Zmy+C2NHrrWNuTchD5OSty3exFcgzQ/tTgv5z6Myxq9+pNGvDfJ5TtMZ/Ws+UxCEwqlNFCjGy3QQEbaGUFnPmevRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy4B0yNAe1O0UdY91kXakVynpSclkpMeChc8RgkeBZE=;
 b=JMa0zyTCC5UypJhDcxwLcnLSLtwQY2gj+e17u47i7Drw7vdQaHmuOqIu5qtAVRrcr5yNaNzJ/vbk7g+lnW08q/TeWQRJiDu/wv/nfKddq3vYRbUGgah0UqyqhCtcpRl8gQdaL/YjKvQE4IyUPCc9uq+7FToJ2zTUJvq2qOwa/MM=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AS4PR08MB7432.eurprd08.prod.outlook.com (2603:10a6:20b:4e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Mon, 13 Dec
 2021 05:24:22 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14%3]) with mapi id 15.20.4755.024; Mon, 13 Dec 2021
 05:24:22 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: RE: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX7awGuMgrKU0nsEmmvzNEMV7iBKwrlP6AgAQxQ+A=
Date:   Mon, 13 Dec 2021 05:24:21 +0000
Message-ID: <AM9PR08MB72765F18BD1ABCB9A8BAB828F4749@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211210095432.51798-1-jianyong.wu@arm.com>
 <YbM4YTgXryp45ufk@arm.com>
In-Reply-To: <YbM4YTgXryp45ufk@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 368CF1AEECF79043AC979910E8D81ECC.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: ac31b31f-22fc-4db8-eda4-08d9bdf8d9ff
x-ms-traffictypediagnostic: AS4PR08MB7432:|AM5EUR03FT046:EE_|VE1PR08MB4765:EE_
X-Microsoft-Antispam-PRVS: <VE1PR08MB47653F483F15F727C1C6B556F4749@VE1PR08MB4765.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lm6GuBQG6ymFNjWJEJTc9VWHHqG9ggBT6OfMc3YJPOpWwWeXj7meylTJJS4V3FNAvXIjlWyO5LVcRtP39eJjPh41DwSNNlpdf0scLGmWWWLhnpvVe/kFhwezChK+yrAtYuA7jeq9VZASOYoNhScX0x7eSRPDWUXq9e8RMphs0/BMqdeD3uwWnvs/sqCZw4x2LCYUAdzYLWnHNA8UQRA+nY70MAdCaXL/y2lZeDp21IZFZqJmhpcEmKNwF7scyg6Dkm6FWDhErYeIFdXxqkH98TyqhTN2dMDIsu1JS26mlgaJ2d0IFggZDwGIXkqi1bYvpEWZXvUY4SsfBEL++G5cDiqrYrcuGrIepP04UDslBPp8SFDdH9gj2BX1ikcGL/Iibv9ChFY/j0zCpCqL5nNzRgkh8I1UsZUpuDX22WuZtDUYBUHK6zVuiyeo+TvIrWnI3HIonRijASesuG8oepX8CMCBq0YZKO7C7nCy9AL6wk5bSKzNifDc93pAPjydcZGfwg+70JxGzVyK82FX8AF6c+AKB0ZOEPD7JdJ5723gEjLHKjdjSxAwAIjiBlSyN1sQqidqxtqYYvUQYsCa6xANNXqeA5UAUIOu43M34fUvi6rU0lEwm9wsTHeB1mLtdzZCtKpZHmUMgWx0B3LCBlAZNv+9CJi6QDAxdQoFNmfTRKag0R4EFe88jwsw/f8JEyCkvOHaOilCJVhK4TNOCQ46jg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(8676002)(7696005)(76116006)(6636002)(5660300002)(66476007)(8936002)(316002)(186003)(83380400001)(26005)(66946007)(9686003)(55016003)(38100700002)(6506007)(64756008)(54906003)(122000001)(2906002)(38070700005)(66556008)(53546011)(71200400001)(6862004)(86362001)(4326008)(508600001)(66446008)(33656002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7432
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9ec4fdbe-e98d-483b-79d5-08d9bdf8d1e2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acn92EqSwWoByVDVrtvIBrkCbzM+pGcdjputdv02pX4/zzd7Qyn7qKKOh9rdv0bMP0AWpEgQgJTPzsdhJs1lSWOlUGc5PaxCznSDdGmTf/WK5C2e7vY7QKJL02m2kA/YW3sQZVn8ViyVrbEWEc/1YvaLjGGqvmL7v/OED1ZVOfrhzBapKZthKZLcCrqeb5g3Fk8AetysGVzVRqN6VrsMpuggi04A2Pbj/Hj6py+ZbNdl2uKdmdiicxkI/04dIUHOJvSac6+W14Yi6ZR9jhHp3KwwAP+C+QN//vcOOWolOCflBul+5cD+bAVyo7yt0WrxY1gTPWqB9qQ0PFmHXz+Zfu6PvKNwQ4zLPKL3Q4dt2DnDp0g4v47uOQ2ZDK/rpXHGKC5eZFuSSyRBnCPQrRJSSSMsyW1PMYh0RcJHJxRuExcYo2/HWMFlRpLLzBgGD4bXtF5oHncD5Qs11QOhRYxtT8tJUyoy1M96FFoObh5U/nBBFMW9bdHCezlfCJ0fZufkSl9ycHC03PS3S5VWWzrgsVu8itA3HmPMmYhGXt8VLabgPlQeevLd2D+z1gNuuWDa/MA+xkYElJCUOeeCMrv521yntwwHU3M3M3aMCP2HWaosBVvJ8Bv51beYFBBBeLIUmjY5/n+xlrunhlok7N36j+ve49IiqdixB6Gc3zJP7sVBS6UlbGnYZV43CvjsYAfA2hmfy7OW9GoNrtIYWZWamw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(70586007)(26005)(54906003)(81166007)(316002)(83380400001)(336012)(356005)(52536014)(86362001)(7696005)(9686003)(508600001)(4326008)(6506007)(70206006)(6636002)(33656002)(8936002)(186003)(8676002)(6862004)(36860700001)(5660300002)(2906002)(55016003)(53546011)(82310400004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 05:24:35.5978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac31b31f-22fc-4db8-eda4-08d9bdf8d9ff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4765
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

> -----Original Message-----
> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: Friday, December 10, 2021 7:22 PM
> To: Jianyong Wu <Jianyong.Wu@arm.com>
> Cc: will@kernel.org; Anshuman Khandual <Anshuman.Khandual@arm.com>;
> akpm@linux-foundation.org; ardb@kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> david@redhat.com; gshan@redhat.com; Justin He <Justin.He@arm.com>;
> nd <nd@arm.com>; Mark Rutland <Mark.Rutland@arm.com>
> Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create
> pud mapping
>=20
> On Fri, Dec 10, 2021 at 05:54:32PM +0800, Jianyong Wu wrote:
> > fixmap is a global resource and is used recursively in create pud mappi=
ng.
> > It may lead to race condition when alloc_init_pud is called concurrentl=
y.
> >
> > Fox example:
> > alloc_init_pud is called when kernel_init. If memory hotplug thread,
> > which will also call alloc_init_pud, happens during kernel_init, the
> > race for fixmap occurs.
> >
> > The race condition flow can be:
> >
> > *************** begin **************
> >
> > kerenl_init thread                          virtio-mem workqueue thread
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                 =
         =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > alloc_init_pud(...)
> >   pudp =3D pud_set_fixmap_offset(..)          alloc_init_pud(...)
> > ...                                         ...
> >     READ_ONCE(*pudp) //OK!                    pudp =3D pud_set_fixmap_o=
ffset(
> > ...                                         ...
> >   pud_clear_fixmap() //fixmap break
> >                                               READ_ONCE(*pudp) //CRASH!
> >
> > **************** end ***************
> >
> > Hence, a spin lock is introduced to protect the fixmap during create
> > pdg mapping.
> >
> > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
>=20
> It looks fine to me:
>=20
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>=20
> Do we need a cc stable? Fixmap was introduced in 4.6, so usually:
>=20
> Fixes: f4710445458c ("arm64: mm: use fixmap when creating page tables")
> Cc: <stable@vger.kernel.org> # 4.6.x
>=20

> but I haven't checked when memory hotplug was added to be able to trigger
> the race. It may not need to go back that far.
>
For now, I only find the memory hotplug can conflict with it. I see that me=
mory hotplug is enabled on arm64 in 4.20, thus what about changing "4.6" to=
 "4.20".
=20
Thanks
Jianyong
> --
> Catalin
