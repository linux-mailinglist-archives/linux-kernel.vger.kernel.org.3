Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4E473A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhLNBkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:40:06 -0500
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:42051
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235724AbhLNBkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3dvVzX/R0mzQ7IJ2S89aXiaZyZmhb9hcJzpvA1jp08=;
 b=TIc6+mpZY8miZSvjn6JmK3ja2FVDwZsjv6nT2MMDv+zTla0RVeeEpqMYEjUQFBZYi9W5VGgzbrdjZ3aGXIamMvEs1ijCYE/q9W3brOo0jZi9VX+YfaVO7Lr9lgn/S0QwDlnpWSaZhTnBHJMec8mjVWD3W1ufQ4wuoJKFRDkGZK0=
Received: from AS9PR06CA0062.eurprd06.prod.outlook.com (2603:10a6:20b:464::12)
 by AM6PR08MB3639.eurprd08.prod.outlook.com (2603:10a6:20b:51::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 01:40:02 +0000
Received: from AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:464:cafe::8e) by AS9PR06CA0062.outlook.office365.com
 (2603:10a6:20b:464::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Tue, 14 Dec 2021 01:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT057.mail.protection.outlook.com (10.152.17.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Tue, 14 Dec 2021 01:40:01 +0000
Received: ("Tessian outbound a33f292be81b:v110"); Tue, 14 Dec 2021 01:40:01 +0000
X-CR-MTA-TID: 64aa7808
Received: from b025f1106b90.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 204AB67B-3575-419C-B9DB-94BE7674C084.1;
        Tue, 14 Dec 2021 01:39:52 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b025f1106b90.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 14 Dec 2021 01:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIgbhPeeekenI9NuotNygi6JzovAuGhKSEoLOUsvj7o5ukDdlValrKEJk9F8lgnmbNhrbsx7WdLi3x80IMsA2lZZAPTQFc4dITY9At5RySX/2fL+len/gkO6p5jm7li6dRucxsYKWGeyS3mk/wFuv2gSaP9hiei4rN2ytUHV1eWy//HvG0oN0InhkdKHjWfagMfTL4l4xYWz54AyO4bTM02vqtcxCTdxMTCwjMVBVvnhz5F9QgDsQblpxJUiQmoJoJ+RgaM0XTq7P17Q0k3y8W9pM9zZWw+Czk1GR1wdIImRknoY8bGDTA6Fz3oWNDdSiJtUVonMa9EJ3A9iVUBCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3dvVzX/R0mzQ7IJ2S89aXiaZyZmhb9hcJzpvA1jp08=;
 b=Xo8RBYzRZKBRygWFNkzY/HMeK3qKrEfXhQ3dI3OvWGx/cPijbeOOlkFLEAN8RnY0KCo4VeFNOfutIvDwELIZoPHfZB4nYrC5H21/YJyidIP9+5b81hGXrjxNEAyhixXEGlICaCk6A80EKwu2r6T2dfg1oumycoqodwgH3n9O1inB9h27oHBYcGDFZA/fS1BqAmN0HfWI0ks4TNIbBuKP4a/NQuZf5Npb0tkTz3ZAdotHndqTim6qaKwaa72GwgQV98E4m7eLzBo4XQR7Vg8rtmg6zVWgf3v9WPZPQCwkuTRh9gjTaRGwrndep+v8agq+Cs/W1ZcUpxKbf0QCD2z2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3dvVzX/R0mzQ7IJ2S89aXiaZyZmhb9hcJzpvA1jp08=;
 b=TIc6+mpZY8miZSvjn6JmK3ja2FVDwZsjv6nT2MMDv+zTla0RVeeEpqMYEjUQFBZYi9W5VGgzbrdjZ3aGXIamMvEs1ijCYE/q9W3brOo0jZi9VX+YfaVO7Lr9lgn/S0QwDlnpWSaZhTnBHJMec8mjVWD3W1ufQ4wuoJKFRDkGZK0=
Received: from PA4PR08MB6016.eurprd08.prod.outlook.com (2603:10a6:102:e3::9)
 by PR2PR08MB4697.eurprd08.prod.outlook.com (2603:10a6:101:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 01:39:48 +0000
Received: from PA4PR08MB6016.eurprd08.prod.outlook.com
 ([fe80::c87d:602c:e192:66b]) by PA4PR08MB6016.eurprd08.prod.outlook.com
 ([fe80::c87d:602c:e192:66b%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 01:39:48 +0000
From:   Xiaokang Qian <Xiaokang.Qian@arm.com>
To:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
CC:     Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] crypto: arm64/gcm-ce - unroll factors to 4-way interleave
 of aes and ghash
Thread-Topic: [PATCH] crypto: arm64/gcm-ce - unroll factors to 4-way
 interleave of aes and ghash
Thread-Index: AQHXsESW0x0OVrc26UKxttoWchWUMKu5Ay+AgAD1A4CAd0XzgIAAd6Kw
Date:   Tue, 14 Dec 2021 01:39:48 +0000
Message-ID: <PA4PR08MB60161CA378726A4D77F39216EE759@PA4PR08MB6016.eurprd08.prod.outlook.com>
References: <20210923063027.166247-1-xiaokang.qian@arm.com>
 <YVK1u4BgVAa84fMa@sol.localdomain>
 <CAMj1kXHeJBUAzcLHRNYDbbUDe5vRS7Bxy_LKF5gdRLJca7TNRQ@mail.gmail.com>
 <20211213182918.GC12405@willie-the-truck>
In-Reply-To: <20211213182918.GC12405@willie-the-truck>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: E15F156C62295E4F9E3201D2C75BC8A2.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 45325b5c-6c27-47e7-13c6-08d9bea2a579
x-ms-traffictypediagnostic: PR2PR08MB4697:EE_|AM5EUR03FT057:EE_|AM6PR08MB3639:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB36392B510265C30996CEFDF0EE759@AM6PR08MB3639.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JdNdQfjmy9ry0dEsII73ah0c8td+Wuq/SCCmZvYgbyU+0YbLB0PRbNya07wJXzs/8rGFJjCQiVOlG5WDwcTwiDL26LzV2T7cZoYCHqJIaQQL/fR8LYI/fJR+r6W9AP9/BnDpJpSTu0KWU1maHaL03AJmBw5dPEMq0irr9IS0BJX7cFLNpUbkpgep4mK2GyXFOFgdu7L7y5XaMwVn6WU3qm79448idfJ1PNyGGgYnlSibeAr4i3Ab7hOb8IsaqvZM+np12/IK8PcBIRc9TOsCrrOuC5Ndh1FVTx+pUDCcXYdcQ8TMiTdJ327FYlLMz6UERHxT0d5TdwNXKFqBgS9Xyixi6z3e4cIJETV/EdWX3jbj3kkt5oujxBDg0cZXl8aBJzPPc77mztTBC/L96iihVWmZWUN0x2gnisXKVV2YXf6PiRZEP8h6wZ89oco0e3MAMGjLlCkILCYIfgsfleCiTTCBBCzAfm3lnx+w3fYBTssSBmIZGJ8daR4apYDo0Zcz3M2fg9vqrlx3H4sPlAcdPtEitOklVCq60tKf+2b0lKeVgbETkHtWSx20LTqGOJa1V9xfUnSPL/5eDLicPePCLn6N+1rZxFnG0L55TXJlNDvb/5DqhaaJR7fa1dhPEg3f9RHeRDJ/WMMLG+OvWmsuRALhmxumUBwYpFSjhCCgW53xs+KCYF8lIRV1euisv7HFBhla7YZqKTjhYBERQkocyA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB6016.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(52536014)(55016003)(26005)(33656002)(71200400001)(53546011)(76116006)(6506007)(122000001)(86362001)(9686003)(186003)(4326008)(110136005)(2906002)(66556008)(316002)(83380400001)(38070700005)(66476007)(54906003)(508600001)(7696005)(66446008)(5660300002)(66946007)(64756008)(8936002)(8676002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4697
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 431de033-d00a-4437-1a21-08d9bea29d70
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZY3BID4WQP16L3uoW4ML16e1GEVBZFMFVIXZ8G34HCLitNx9Tu5b9+85HEjBZBwuq6ZqOcx1qToOIna/PWTeczZz8nC+m2J9fDB+HUo589lpCnbFaMbk0EMAoGi5RNHlJ8RdSoZdXzQ3U6RuGW6CRxTgiLSGRn4LkoIJ4RteQZ1mSGicvQcB4YczbM+o2UcFbmywhnj2EPTTcBqPBmF7Jal3ef+EoVo0LheK8Ie0MqlRXyxm7kUPwPSVdjuDS8cfPw4lc2FHJvCYjKzykNmGBQcPAAL7teIRWnA0aI0f/f+rn457ZyOqwcs8dDccnCrOoE3dIBmJ+t5LQIttqv6xaoLDNHXkMeK2utbSwaos1KU7wp8OINh7HYhmq9zc7XM7ZoH8rqbnjsMGzoMtXSJz99JcCeMCn43jKAgDnAjIkC5kyUuriQpQ9wXpV8FuAvEpU/zK7OGBYvqp8V37vT+0WZh5eNXSOGa3h7CO0niW+rW/PQWZEFHwBNPVelwXfhfhV91xZL8isRfDqP0KK9a/Gbzi5FdOhJopln8OxJoy4JHXMtblc1C9zPMaXpYZmDzF7gShaRLv0Gb4/2LnhzzVWfQG2MiggYxas5pxW9cLVVIrqgDr220RDP4Z6talKKBTYzetgr1QHgrt8KxHgLNze4EKg95Xyd84Et24HxcM6sWIDwWqyO6lbRfHj5MWN8fnOeOK/LDMn6QX6chltMb2tZAy2uupuEetDUVVINu7JhA2Ne0Xk62IJDWvj8P1ltBA2mGz0h9z2EZd8/VDyjS0w==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(26005)(2906002)(83380400001)(86362001)(5660300002)(52536014)(55016003)(82310400004)(33656002)(8936002)(508600001)(186003)(356005)(7696005)(450100002)(54906003)(47076005)(70206006)(6506007)(110136005)(316002)(36860700001)(40460700001)(81166007)(53546011)(70586007)(336012)(9686003)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:40:01.9009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45325b5c-6c27-47e7-13c6-08d9bea2a579
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3639
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will:
I will post the update version 2 of this patch today or tomorrow.
Sorry for the delay.

> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Tuesday, December 14, 2021 2:29 AM
> To: Ard Biesheuvel <ardb@kernel.org>
> Cc: Eric Biggers <ebiggers@kernel.org>; Xiaokang Qian
> <Xiaokang.Qian@arm.com>; Herbert Xu <herbert@gondor.apana.org.au>;
> David S. Miller <davem@davemloft.net>; Catalin Marinas
> <Catalin.Marinas@arm.com>; nd <nd@arm.com>; Linux Crypto Mailing List
> <linux-crypto@vger.kernel.org>; Linux ARM <linux-arm-
> kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH] crypto: arm64/gcm-ce - unroll factors to 4-way
> interleave of aes and ghash
>=20
> On Tue, Sep 28, 2021 at 11:04:03PM +0200, Ard Biesheuvel wrote:
> > On Tue, 28 Sept 2021 at 08:27, Eric Biggers <ebiggers@kernel.org> wrote=
:
> > >
> > > On Thu, Sep 23, 2021 at 06:30:25AM +0000, XiaokangQian wrote:
> > > > To improve performance on cores with deep piplines such as A72,N1,
> > > > implement gcm(aes) using a 4-way interleave of aes and ghash
> > > > (totally
> > > > 8 blocks in parallel), which can make full utilize of pipelines
> > > > rather than the 4-way interleave we used currently. It can gain
> > > > about 20% for big data sizes such that 8k.
> > > >
> > > > This is a complete new version of the GCM part of the combined
> > > > GCM/GHASH driver, it will co-exist with the old driver, only serve
> > > > for big data sizes. Instead of interleaving four invocations of
> > > > AES where each chunk of 64 bytes is encrypted first and then
> > > > ghashed, the new version uses a more coarse grained approach where
> > > > a chunk of 64 bytes is encrypted and at the same time, one chunk
> > > > of 64 bytes is ghashed (or ghashed and decrypted in the converse ca=
se).
> > > >
> > > > The table below compares the performance of the old driver and the
> > > > new one on various micro-architectures and running in various
> > > > modes with various data sizes.
> > > >
> > > >             |     AES-128       |     AES-192       |     AES-256  =
     |
> > > >      #bytes | 1024 | 1420 |  8k | 1024 | 1420 |  8k | 1024 | 1420 |=
  8k |
> > > >      -------+------+------+-----+------+------+-----+------+------+=
-----+
> > > >         A72 | 5.5% |  12% | 25% | 2.2% |  9.5%|  23%| -1%  |  6.7%|=
 19% |
> > > >         A57 |-0.5% |  9.3%| 32% | -3%  |  6.3%|  26%| -6%  |  3.3%|=
 21% |
> > > >         N1  | 0.4% |  7.6%|24.5%| -2%  |  5%  |  22%| -4%  |
> > > > 2.7%| 20% |
> > > >
> > > > Signed-off-by: XiaokangQian <xiaokang.qian@arm.com>
> > >
> > > Does this pass the self-tests, including the fuzz tests which are
> > > enabled by CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy?
> > >
> >
> > Please test both little-endian and big-endian. (Note that you don't
> > need a big-endian user space for this - the self tests are executed
> > before the rootfs is mounted)
> >
> > Also, you will have to rebase this onto the latest cryptodev tree,
> > which carries some changes I made recently to this driver.
>=20
> XiaokangQian -- did you post an updated version of this? It would end up
> going via Herbert, but I was keeping half an eye on it and it all seems t=
o have
> gone quiet.
>=20
> Thanks,
>=20
> Will
