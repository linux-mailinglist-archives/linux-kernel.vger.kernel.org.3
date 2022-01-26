Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A03249C788
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbiAZK2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:28:36 -0500
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:46756
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232627AbiAZK2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBEG4LX9aBJjVRqWk7ZBakK6xtZOiQgZsiNKor0msV0=;
 b=O5KGGJrQ+ZjiHPhCyF4N0Juxo8q7XXVkJ/dFPLvN8hEkAkbzTtDbPbE/QZ/j6jUDX08z1y+pXTuPTMhubHi6hriKaz4Xx8B1CSCCkgWP2OZxvsIpz0a7bN4DRxfE7zjm/BZMlkavT5I9uGrlw4yCGA5Vv5ceWqU+WCLyrRi94q4=
Received: from AS8PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:20b:311::6)
 by VI1PR08MB3230.eurprd08.prod.outlook.com (2603:10a6:803:3e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 10:28:30 +0000
Received: from AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::5d) by AS8PR05CA0001.outlook.office365.com
 (2603:10a6:20b:311::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 10:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT011.mail.protection.outlook.com (10.152.16.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 26 Jan 2022 10:28:30 +0000
Received: ("Tessian outbound 1f399c739551:v113"); Wed, 26 Jan 2022 10:28:30 +0000
X-CR-MTA-TID: 64aa7808
Received: from 83a69b78fd55.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0BC0ECFC-BCEB-433D-87FE-FCE44CB79EC5.1;
        Wed, 26 Jan 2022 10:28:24 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 83a69b78fd55.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 26 Jan 2022 10:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7EsCCn2iKTsmt3xXuNsgkecGQhXSzzNJ0bxMLjyA/1Z59N5fTaIIGtGnA64vIPN5BDAD4ht5JPl/8F23H6Tvo6LzVyqVtHVo27sekcKqY6fm+U5DbxyQNfZJ5p2vmtkuKFUsOGouBunmUbagFSw8CfTKisxRbpxUA3JG/D5Sxy9inzrAXNQAEtPPQ6g9EtOZZSX9DsZFp1qLmG+k+xcvnVxCm5wt7G+6J6ibKlt8mNjQuu2w9CKkz2XhjNqXrDdX/PDaTrSOvmsn45PB1X66JpUJN1Pz4NmBExl3km7gQihVrLpgvCXpvynaBqUwt0134tYedrKz0rohzNrM8fX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBEG4LX9aBJjVRqWk7ZBakK6xtZOiQgZsiNKor0msV0=;
 b=fk7tMYzPWA9dRe26eu6MBDKkQegGbUBeU1GnPPAOkMy5MOrQ35UozvPdlAr5eeYewH7+3tLIa/ptXMhobWiBW8aHErNiLSqzrfNoaM/slSE3cHe/mRDwC4gB5xylDcJjD7pxb53UDaa5uvXkQDjr8SPcTyS3O1WKUnevYtDVQ7IfW5KmgthnhSbmSgVM/8uN7Nawlf5avNjrNW2BjAZNlmXpMCz2bCjIU74fDjAZUZ00/QIdJ5NwtM4B0DLpPGs7Z0HTsEF0Hd0DV0cxJ0Gspq6FhmdYCbZE2HRZ4QEhJIEDYP1KwWd0PwutFEmK+eWdg7XEf3E4Hg5DlzKeQIJ4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBEG4LX9aBJjVRqWk7ZBakK6xtZOiQgZsiNKor0msV0=;
 b=O5KGGJrQ+ZjiHPhCyF4N0Juxo8q7XXVkJ/dFPLvN8hEkAkbzTtDbPbE/QZ/j6jUDX08z1y+pXTuPTMhubHi6hriKaz4Xx8B1CSCCkgWP2OZxvsIpz0a7bN4DRxfE7zjm/BZMlkavT5I9uGrlw4yCGA5Vv5ceWqU+WCLyrRi94q4=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AM0PR08MB4116.eurprd08.prod.outlook.com (2603:10a6:208:131::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 10:28:19 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e%7]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 10:28:18 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Justin He <Justin.He@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>, nd <nd@arm.com>
Subject: RE: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX8lbt013/nzm8RUa6mdFr92d9v6xU2ImAgAELwWCAAGL4AIABFwGwgAAjrYCAHXF+gIAAR6QAgAAGaOCAABRIgIAAAXgAgAABfiA=
Date:   Wed, 26 Jan 2022 10:28:17 +0000
Message-ID: <AM9PR08MB72764111B775352448D75CD9F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com>
 <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdgZJ/mBG+BCxmEv@arm.com>
 <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
 <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
 <AM9PR08MB72763D5DA0C5F22D2126ABF4F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <CAMj1kXGjAxd2xb0u1PLSLGAe8jJdhJm3wR+y=7qB4C1J6Ebgcw@mail.gmail.com>
 <3e6513f9-77ca-79e5-d185-7e9a11ec7689@redhat.com>
In-Reply-To: <3e6513f9-77ca-79e5-d185-7e9a11ec7689@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 0AEC76C99857DF4A9C65462C43DFB706.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 887b9231-6aca-4508-a2d9-08d9e0b698f1
x-ms-traffictypediagnostic: AM0PR08MB4116:EE_|AM5EUR03FT011:EE_|VI1PR08MB3230:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB3230C9F3BCDB1B261032B73AF4209@VI1PR08MB3230.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tF5J/XrOhS68Rt5zoWNkRdqbjOiBne093iDFxRvLxoXu0ACXuPNHbnN+9o3lGptPBE8JYnMoLPkKUAq7Xh8Z3qkPN7Qd314ycbKY/Kj16ex4STWOeKw5LYysntA+9sL5EDWCcSt9v5Z2lRXfOL/LlNKnN3N6Y0LGvTDABeb0BQd1w1fln9FMZCCHnXr1hIsj48jLwLkeNMw2D2cYQVM5J8e65ouSWE/CKW+Lbn6EtFTbBeQUF9BDndvlUMl7d/yBccWGwmnvxuReaB9nOB4jwxJH4f/Vbd0p0qjiTZQOU8ereza1QVo6z59nYewcrv1JxEoKFWeb5mhbI1TwkSt7kiaYr2oVi1MQy2IOgUM/qgyY3sRQlMmGzy05cKD3DAPP0VwhezkDoZ65uCMJsEg4nssADa85ipyUGRIxrPmCjzEE6cwYp5zdpE9bZAGfg+ffFBNXE/C6ZF2iMTX00nTGMUPMx9o0Q/336eUJtqDlYyTOGsCs6osVOKab2FahYe9lejSTyK8mU1B40pBUbeyN2c0XeMgHyS9yxPgQYPg0xhtKg3xCnwxo7hNNZAhkloZBV/u3Drx8kFFCRNxnyf3ME9LtNrX6DzfECt++QFBKja3XeKx0EGqaCRJqDOzHAZOOncz4G+p6UpR/J97Bc1rHDo/IwpMcP0OADFkuRsPUmuTMeJoUsMqVdDfmb7HhsqBotUT47xUXkqPoG4MlPqu/Ug==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(9686003)(53546011)(66556008)(2906002)(76116006)(66946007)(508600001)(6506007)(7696005)(5660300002)(71200400001)(55016003)(8936002)(8676002)(26005)(110136005)(54906003)(33656002)(38070700005)(83380400001)(66476007)(66446008)(64756008)(4326008)(316002)(186003)(38100700002)(122000001)(86362001)(20210929001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4116
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6923e778-2bd9-469b-7c73-08d9e0b691ce
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJPA7C53fjaAqaCItkc93WzIKyQTWmEDzhAADJQESw7lH524sGhkyV3+E1GakP84WcQN/8tEU6dI1HOhmKJrXHoi++HvkDCRFzWQOpcJropNT3ryeDR2cKiko7wACQykDcwIoYcqZmGowmB+9yr5uLu3pARhvbuxfBdK+Ya4Sscmy8mGF/8L7fHGlJawm+UlIVitGHnTu3mTbUK2bArvg2Fo/ho3uEtEYEvL6gZpcObQ1e2KnxaB422wK9vyVVDXcPEM0wez2OxUmDgN9TNMTcObVBwbig91leq4rZEAUeQLdZR95FEKoftHsOFwTHhzFDodS/Yt+26+T9kQu+JxKAk8T+Sm15S4ku0TxUR37Vh/Cu6DYhjQTyAwqnhHkaBNhiFN673E86R8ectY7aew26LenxevZ4p6XWaeKMCDCFpzAli6i9DczmkCb1/CnlDroKYXmKhhihteguwk3llUCb8wcvzV2IG4pH/VZkAonyaWZiDZVodYgnOnRtfMVPaFgSRC8lKUgsDKUCRyiTMiBFadAKUVo6mQuZIsGkmpaOjrSMMnt+9VpI70YtV8GR2PCeyZsv3QidGwJlt00Cn7LyQeYPYCxcPUPJFLkKRcnn+pRdNbJgwExzn6kCDGlJRFL+4EKzPntKHRbCA6/R1ggSQvU+oKst6xEgf/UQbs/iv3a5b9azPDLBPWrks86VoI
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(52536014)(26005)(336012)(186003)(5660300002)(8676002)(8936002)(47076005)(33656002)(508600001)(110136005)(316002)(86362001)(55016003)(54906003)(40460700003)(53546011)(356005)(6506007)(7696005)(82310400004)(81166007)(9686003)(36860700001)(2906002)(70206006)(70586007)(83380400001)(4326008)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 10:28:30.3497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887b9231-6aca-4508-a2d9-08d9e0b698f1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3230
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQg
SGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFy
eSAyNiwgMjAyMiA2OjE4IFBNDQo+IFRvOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3Jn
PjsgSmlhbnlvbmcgV3UNCj4gPEppYW55b25nLld1QGFybS5jb20+DQo+IENjOiBKdXN0aW4gSGUg
PEp1c3Rpbi5IZUBhcm0uY29tPjsgQ2F0YWxpbiBNYXJpbmFzDQo+IDxDYXRhbGluLk1hcmluYXNA
YXJtLmNvbT47IHdpbGxAa2VybmVsLm9yZzsgQW5zaHVtYW4gS2hhbmR1YWwNCj4gPEFuc2h1bWFu
LktoYW5kdWFsQGFybS5jb20+OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBxdWljX3Fp
YW5jYWlAcXVpY2luYy5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGdzaGFuQHJlZGhhdC5jb207IG5kIDxu
ZEBhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBhcm02NC9tbTogYXZvaWQgZml4
bWFwIHJhY2UgY29uZGl0aW9uIHdoZW4gY3JlYXRlDQo+IHB1ZCBtYXBwaW5nDQo+IA0KPiBPbiAy
Ni4wMS4yMiAxMToxMiwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+ID4gT24gV2VkLCAyNiBKYW4g
MjAyMiBhdCAxMTowOSwgSmlhbnlvbmcgV3UgPEppYW55b25nLld1QGFybS5jb20+DQo+IHdyb3Rl
Og0KPiA+Pg0KPiA+PiBIaSBBcmQsDQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+Pj4gRnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gPj4+
IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyNiwgMjAyMiA0OjM3IFBNDQo+ID4+PiBUbzogSnVz
dGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4gPj4+IENjOiBDYXRhbGluIE1hcmluYXMgPENh
dGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgSmlhbnlvbmcgV3UNCj4gPj4+IDxKaWFueW9uZy5XdUBh
cm0uY29tPjsgd2lsbEBrZXJuZWwub3JnOyBBbnNodW1hbiBLaGFuZHVhbA0KPiA+Pj4gPEFuc2h1
bWFuLktoYW5kdWFsQGFybS5jb20+OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiA+Pj4g
ZGF2aWRAcmVkaGF0LmNvbTsgcXVpY19xaWFuY2FpQHF1aWNpbmMuY29tOyBsaW51eC0NCj4gPj4+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gPj4+IGdzaGFuQHJlZGhhdC5jb207IG5kIDxuZEBhcm0uY29tPg0KPiA+Pj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2M10gYXJtNjQvbW06IGF2b2lkIGZpeG1hcCByYWNlIGNvbmRpdGlv
biB3aGVuDQo+ID4+PiBjcmVhdGUgcHVkIG1hcHBpbmcNCj4gPj4+DQo+ID4+PiBPbiBXZWQsIDI2
IEphbiAyMDIyIGF0IDA1OjIxLCBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPiB3cm90ZToN
Cj4gPj4+Pg0KPiA+Pj4+IEhpIENhdGFsaW4NCj4gPj4+Pg0KPiA+Pj4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+PiBGcm9tOiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFy
aW5hc0Bhcm0uY29tPg0KPiA+Pj4+PiBTZW50OiBGcmlkYXksIEphbnVhcnkgNywgMjAyMiA2OjQz
IFBNDQo+ID4+Pj4+IFRvOiBKaWFueW9uZyBXdSA8SmlhbnlvbmcuV3VAYXJtLmNvbT4NCj4gPj4+
Pj4gQ2M6IHdpbGxAa2VybmVsLm9yZzsgQW5zaHVtYW4gS2hhbmR1YWwNCj4gPj4+IDxBbnNodW1h
bi5LaGFuZHVhbEBhcm0uY29tPjsNCj4gPj4+Pj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsg
ZGF2aWRAcmVkaGF0LmNvbTsNCj4gPj4+Pj4gcXVpY19xaWFuY2FpQHF1aWNpbmMuY29tOyBhcmRi
QGtlcm5lbC5vcmc7DQo+ID4+Pj4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWFybS0NCj4gPj4+Pj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGdzaGFuQHJlZGhhdC5j
b207IEp1c3RpbiBIZQ0KPiA+Pj4+PiA8SnVzdGluLkhlQGFybS5jb20+OyBuZCA8bmRAYXJtLmNv
bT4NCj4gPj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gYXJtNjQvbW06IGF2b2lkIGZpeG1h
cCByYWNlIGNvbmRpdGlvbiB3aGVuDQo+ID4+Pj4+IGNyZWF0ZSBwdWQgbWFwcGluZw0KPiA+Pj4+
Pg0KPiA+Pj4+PiBPbiBGcmksIEphbiAwNywgMjAyMiBhdCAwOToxMDo1N0FNICswMDAwLCBKaWFu
eW9uZyBXdSB3cm90ZToNCj4gPj4+Pj4+IEhpIENhdGFsaW4sDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4g
SSByb3VnaGx5IGZpbmQgdGhlIHJvb3QgY2F1c2UuDQo+ID4+Pj4+PiAgYWxsb2NfaW5pdF9wdWQg
d2lsbCBiZSBjYWxsZWQgYXQgdGhlIHZlcnkgYmVnaW5uaW5nIG9mIGtlcm5lbA0KPiA+Pj4+Pj4g
Ym9vdCBpbg0KPiA+Pj4+PiBjcmVhdGVfbWFwcGluZ19ub2FsbG9jIHdoZXJlIG5vIG1lbW9yeSBh
bGxvY2F0b3IgaXMgaW5pdGlhbGl6ZWQuDQo+ID4+Pj4+IEJ1dCBsb2NrZGVwIGNoZWNrIG1heSBu
ZWVkIGFsbG9jYXRlIG1lbW9yeS4gU28sIGtlcm5lbCB0YWtlDQo+ID4+Pj4+IGV4Y2VwdGlvbiB3
aGVuIGFjcXVpcmUgbG9jay4oSSBoYXZlIG5vdCBmb3VuZCB0aGUgZXhhY3QgY29kZSB0aGF0DQo+
ID4+Pj4+IGNhdXNlIHRoaXMNCj4gPj4+Pj4gaXNzdWUpIHRoYXQncyBzYXkgd2UgbWF5IG5vdCBi
ZSBhYmxlIHRvIHVzZSBhIGxvY2sgc28gZWFybHkuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSSBjb21l
IHVwIHdpdGggMiBtZXRob2RzIHRvIGFkZHJlc3MgaXQuDQo+ID4+Pj4+PiAxKSBza2lwIGRlYWQg
bG9jayBjaGVjayBhdCB0aGUgdmVyeSBiZWdpbm5pbmcgb2Yga2VybmVsIGJvb3QgaW4NCj4gPj4+
Pj4+IGxvY2tkZXANCj4gPj4+Pj4gY29kZS4NCj4gPj4+Pj4+IDIpIHByb3ZpZGVkIDIgdHdvIHZl
cnNpb25zIG9mIF9fY3JlYXRlX3BnZF9tYXBwaW5nLCBvbmUgd2l0aCBsb2NrDQo+ID4+Pj4+PiBp
biBpdCBhbmQgdGhlIG90aGVyIHdpdGhvdXQuIFRoZXJlIG1heSBiZSBubyBwb3NzaWJsZSBvZiBy
YWNlIGZvcg0KPiA+Pj4+Pj4gbWVtb3J5IG1hcHBpbmcgYXQgdGhlIHZlcnkgYmVnaW5uaW5nIHRp
bWUgb2Yga2VybmVsIGJvb3QsIHRodXMgd2UNCj4gPj4+Pj4+IGNhbiB1c2UgdGhlIG5vIGxvY2sg
dmVyc2lvbiBvZiBfX2NyZWF0ZV9wZ2RfbWFwcGluZyBzYWZlbHkuDQo+ID4+Pj4+PiBJbiBteSB0
ZXN0LCB0aGlzIGlzc3VlIGlzIGdvbmUgaWYgdGhlcmUgaXMgbm8gbG9jayBoZWxkIGluDQo+ID4+
Pj4+PiBjcmVhdGVfbWFwcGluZ19ub2FsbG9jLiBJIHRoaW5rIGNyZWF0ZV9tYXBwaW5nX25vYWxs
b2MgaXMgY2FsbGVkDQo+ID4+Pj4+PiBlYXJseSBlbm91Z2ggdG8gYXZvaWQgdGhlIHJhY2UgY29u
ZGl0aW9ucyBvZiBtZW1vcnkgbWFwcGluZywNCj4gPj4+Pj4+IGhvd2V2ZXIsIEkgaGF2ZSBub3Qg
cHJvdmVkIGl0Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJIHRoaW5rIG1ldGhvZCAyIHdvdWxkIHdvcmsg
YmV0dGVyIGJ1dCByYXRoZXIgdGhhbiBpbXBsZW1lbnRpbmcNCj4gPj4+Pj4gbmV3IG5vbG9jayBm
dW5jdGlvbnMgSSdkIGFkZCBhIE5PX0xPQ0sgZmxhZyBhbmQgY2hlY2sgaXQgaW4NCj4gPj4+Pj4g
YWxsb2NfaW5pdF9wdWQoKSBiZWZvcmUgbXV0ZXhfbG9jay91bmxvY2suIEFsc28gYWRkIGEgY29t
bWVudA0KPiB3aGVuDQo+ID4+Pj4+IHBhc3NpbmcgdGhlIE5PX0xPQ0sgZmxhZyBvbiB3aHkgaXQn
cyBuZWVkZWQgYW5kIHdoeSB0aGVyZSB3b3VsZG4ndA0KPiA+Pj4+PiBiZSBhbnkgcmFjZXMgYXQg
dGhhdCBzdGFnZSAoZWFybHkgYm9vdCBldGMuKQ0KPiA+Pj4+Pg0KPiA+Pj4+IFRoZSBwcm9ibGVt
YXRpYyBjb2RlIHBhdGggaXM6DQo+ID4+Pj4gX19wcmltYXJ5X3N3aXRjaGVkDQo+ID4+Pj4gICAg
ICAgICBlYXJseV9mZHRfbWFwLT5maXhtYXBfcmVtYXBfZmR0DQo+ID4+Pj4gICAgICAgICAgICAg
ICAgIGNyZWF0ZV9tYXBwaW5nX25vYWxsb2MtPmFsbG9jX2luaXRfcHVkDQo+ID4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgbXV0ZXhfbG9jayAod2l0aCBKaWFueW9uZydzIHBhdGNoKQ0KPiA+
Pj4+DQo+ID4+Pj4gVGhlIHByb2JsZW0gc2VlbXMgdG8gYmUgdGhhdCB3ZSB3aWxsIGNsZWFyIEJT
UyBzZWdtZW50IHR3aWNlIGlmDQo+ID4+Pj4ga2FzbHIgaXMgZW5hYmxlZC4gSGVuY2UsIHNvbWUg
b2YgdGhlIHN0YXRpYyB2YXJpYWJsZXMgaW4gbG9ja2RlcA0KPiA+Pj4+IGluaXQgcHJvY2VzcyB3
ZXJlIG1lc3NlZCB1cC4gVGhhdCBpcyB0byBzYWlkLCB3aXRoIGthc2xyIGVuYWJsZWQgd2UNCj4g
Pj4+PiBtaWdodCBpbml0aWFsaXplIGxvY2tkZXAgdHdpY2UgaWYgd2UgYWRkIG11dGV4X2xvY2sv
dW5sb2NrIGluDQo+IGFsbG9jX2luaXRfcHVkKCkuDQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBUaGFu
a3MgZm9yIHRyYWNraW5nIHRoYXQgZG93bi4NCj4gPj4+DQo+ID4+PiBOb3RlIHRoYXQgY2xlYXJp
bmcgdGhlIEJTUyB0d2ljZSBpcyBub3QgdGhlIHJvb3QgcHJvYmxlbSBoZXJlLiBUaGUNCj4gPj4+
IHJvb3QgcHJvYmxlbSBpcyB0aGF0IHdlIHNldCBnbG9iYWwgc3RhdGUgd2hpbGUgdGhlIGtlcm5l
bCBydW5zIGF0DQo+ID4+PiB0aGUgZGVmYXVsdCBsaW5rIHRpbWUgYWRkcmVzcywgYW5kIHRoZW4g
cmVmZXIgdG8gaXQgYWdhaW4gYWZ0ZXIgdGhlDQo+ID4+PiBlbnRpcmUga2VybmVsIGhhcyBiZWVu
IHNoaWZ0ZWQgaW4gdGhlIGtlcm5lbCBWQSBzcGFjZS4gU3VjaCBnbG9iYWwNCj4gPj4+IHN0YXRl
IGNvdWxkIGNvbnNpc3Qgb2YgbXV0YWJsZSBwb2ludGVycyB0byBzdGF0aWNhbGx5IGFsbG9jYXRl
ZCBkYXRhDQo+ID4+PiAod2hpY2ggd291bGQgYmUgcmVzZXQgdG8gdGhlaXIgZGVmYXVsdCB2YWx1
ZXMgYWZ0ZXIgdGhlIHJlbG9jYXRpb24gY29kZQ0KPiBydW5zIGFnYWluKSwgb3IgZ2xvYmFsIHBv
aW50ZXIgdmFyaWFibGVzIGluIEJTUy4NCj4gPj4+IEluIGVpdGhlciBjYXNlLCByZWx5aW5nIG9u
IHN1Y2ggYSBnbG9iYWwgdmFyaWFibGUgYWZ0ZXIgdGhlIHNlY29uZA0KPiA+Pj4gcmVsb2NhdGlv
biBwZXJmb3JtZWQgYnkgS0FTTFIgd291bGQgYmUgcmlza3ksIGFuZCBzbyB3ZSBzaG91bGQgYXZv
aWQNCj4gPj4+IG1hbmlwdWxhdGluZyBnbG9iYWwgc3RhdGUgYXQgYWxsIGlmIGl0IG1pZ2h0IGlu
dm9sdmUgcG9pbnRlciB0bw0KPiA+Pj4gc3RhdGljYWxseSBhbGxvY2F0ZWQgZGF0YSBzdHJ1Y3R1
cmVzLg0KPiA+Pj4NCj4gPj4+PiBJbiBvdGhlciB3YXlzLCBpZiB3ZSBpbnZva2UgbXV0ZXhfbG9j
ay91bmxvY2sgaW4gc3VjaCBhIGVhcmx5IGJvb3RpbmcNCj4gc3RhZ2UuDQo+ID4+Pj4gSXQgbWln
aHQgYmUgdW5zYWZlIGJlY2F1c2UgbG9ja2RlcCBpbnNlcnRzIGxvY2tfYWNxdWlyZS9yZWxlYXNl
IGFzDQo+ID4+Pj4gdGhlIGNvbXBsZXggaG9va3MuDQo+ID4+Pj4NCj4gPj4+PiBJbiBzdW1tYXJ5
LCB3b3VsZCBpdCBiZXR0ZXIgaWYgSmlhbnlvbmcgc3BsaXRzIHRoZXNlIGVhcmx5IGJvb3QgYW5k
DQo+ID4+Pj4gbGF0ZSBib290IGNhc2U/IGUuZy4gaW50cm9kdWNlIGEgbm9sb2NrIHZlcnNpb24g
Zm9yDQo+ID4+PiBjcmVhdGVfbWFwcGluZ19ub2FsbG9jKCkuDQo+ID4+Pj4NCj4gPj4+PiBXaGF0
IGRvIHlvdSB0aGluayBvZiBpdD8NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IFRoZSBwcmUtS0FTTFIg
Y2FzZSBkZWZpbml0ZWx5IGRvZXNuJ3QgbmVlZCBhIGxvY2suIEJ1dCBnaXZlbiB0aGF0DQo+ID4+
PiBjcmVhdGVfbWFwcGluZ19ub2FsbG9jKCkgaXMgb25seSB1c2VkIHRvIG1hcCB0aGUgRkRULCB3
aGljaCBoYXBwZW5zDQo+ID4+PiB2ZXJ5IGVhcmx5IG9uZSB3YXkgb3IgdGhlIG90aGVyLCB3b3Vs
ZG4ndCBpdCBiZSBiZXR0ZXIgdG8gbW92ZSB0aGUNCj4gPj4+IGxvY2svdW5sb2NrIGludG8gb3Ro
ZXIgY2FsbGVycyBvZiBfX2NyZWF0ZV9wZ2RfbWFwcGluZygpPyAoYW5kIG1ha2UNCj4gPj4+IHN1
cmUgbm8gb3RoZXIgdXNlcnMgb2YgdGhlIGZpeG1hcCBzbG90cyBleGlzdCkNCj4gPj4NCj4gPj4g
VGhlcmUgYXJlIHNlcnZlciBjYWxsZXJzIG9mIF9fY3JlYXRlX3BnZF9tYXBwaW5nLiBJIHRoaW5r
IHNvbWUgb2YgdGhlbQ0KPiBuZWVkIG5vIGZpeG1hcCBsb2NrIGFzIHRoZXkgYXJlIGNhbGxlZCBz
byBlYXJseS4gSSBmaWd1cmUgb3V0IGFsbCBvZiB0aGVtIGhlcmU6DQo+ID4+IGNyZWF0ZV9tYXBw
aW5nX25vYWxsb2M6ICAgbm8gbG9jaw0KPiA+PiBjcmVhdGVfcGdkX21hcHBpbmc6ICAgbm8gbG9j
aw0KPiA+PiBfX21hcF9tZW1ibG9jazogICAgbm8gbG9jaw0KPiA+PiBtYXBfa2VybmVsX3NlZ21l
bnQ6ICBubyBsb2NrDQo+ID4+IG1hcF9lbnRyeV90cmFtcG9saW5lOiBubyBsb2NrDQo+ID4+IHVw
ZGF0ZV9tYXBwaW5nX3Byb3Q6ICAgIG5lZWQgbG9jaw0KPiA+PiBhcmNoX2FkZF9tZW1vcnk6ICBu
ZWVkIGxvY2sNCj4gPj4NCj4gPj4gV0RZVD8NCj4gPj4NCj4gPg0KPiA+IFRoYXQgc2VlbXMgcmVh
c29uYWJsZSwgYnV0IGl0IG5lZWRzIHRvIGJlIGRvY3VtZW50ZWQgY2xlYXJseSBpbiB0aGUgY29k
ZS4NCj4gPg0KPiANCj4gSnVzdCBhIHJhbmRvbSB0aG91Z2h0LCBjb3VsZCB3ZSByZWx5IG9uIHN5
c3RlbV9zdGF0ZSB0byBkbyB0aGUgbG9ja2luZw0KPiBjb25kaXRpb25hbGx5Pw0KDQpJIGNhbid0
IHNlZSB0aGUgcG9pbnQuIEF0IHRoZSBlYXJseSBzdGFnZXMgb2Yga2VybmVsIGJvb3QsIHdlIGRl
ZmluaXRlbHkgbmVlZCBubyBsb2NrLiBBbHNvLCBJIHRoaW5rIHdlIHNob3VsZCBrZWVwIGl0IHNp
bXBsZS4NCg0KVGhhbmtzDQpKaWFueW9uZw0KDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IA0KPiBE
YXZpZCAvIGRoaWxkZW5iDQoNCg==
