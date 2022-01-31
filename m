Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58ABA4A3E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243445AbiAaILF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:11:05 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:23606
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230124AbiAaILD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SomcsPK8lIRQc0ywaslb+fpQ5OxBCdNO+Wpo47Ch6Bw=;
 b=lg8gB7YZrUoHSnq2KEL8t0d37W3kyg8qqAKbqjVoFSEepT7lTbNDv6xZRgGRLasdT7IH8dFBCBTziOhAai8t6wTnNovDBHHZC4MeRe/WPzyL+fMRA3YNh4DYt6WXnzBoJRQlWFHe4gvXZgDHmVGDOEr0y8ngN2nGmGI52LDQxXk=
Received: from DB6PR0301CA0033.eurprd03.prod.outlook.com (2603:10a6:4:3e::43)
 by AM5PR0802MB2545.eurprd08.prod.outlook.com (2603:10a6:203:a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 08:10:59 +0000
Received: from DB5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::57) by DB6PR0301CA0033.outlook.office365.com
 (2603:10a6:4:3e::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21 via Frontend
 Transport; Mon, 31 Jan 2022 08:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT015.mail.protection.outlook.com (10.152.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15 via Frontend Transport; Mon, 31 Jan 2022 08:10:59 +0000
Received: ("Tessian outbound 31aeb3346a45:v113"); Mon, 31 Jan 2022 08:10:59 +0000
X-CR-MTA-TID: 64aa7808
Received: from 8b8996ea6eb4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7EC790E1-42A3-444D-8733-D9C6E76C6505.1;
        Mon, 31 Jan 2022 08:10:49 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8b8996ea6eb4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 31 Jan 2022 08:10:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQncBIljdUGXWJjw4Csqply906ixY/MKZTEMK1aMqc6fbjF2qla4qc3VgQEuy9UBIWaS7zwAjr6RZxBdg5UV5c7ETfRI8VP7HBk9Z2LH0PptfOMVoYULYYCxYdG2Jz7r9YZn+a/YVKpPVB3BwbnI0ZIJUq0uZt100OypWcMQq8R10lOdiSyZYDcGTZ4PXwDVATTPGVUqedCK6Y8/TK0TodTNsCb4MRmslbEm7B+lomRNqWjFZbLURtp6jrfVAGk0EB0DWBNIQK3/RsyXfm0OQWsb7s+IFaNAL8f6r9brA6d642iwqXLYLVAVJDC1Hfc/MozAU1GSaZ1rtYq2gw3H1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SomcsPK8lIRQc0ywaslb+fpQ5OxBCdNO+Wpo47Ch6Bw=;
 b=AiUOempirVs72U19fJ5T+PUpKu3NK7x1UeZprOAQ+NLNH2pozo+8LVfansk+UweYG7zS4o9+Npb6QQA+2SCfLDqFS8/oluUNGTkGGqZNR/omZN0M36gJeaCIQgpQ3YSuSkecnfXnxwMeNrdLvIrsQMTtad3yvY6XVw+yeErurX4yotPcU4wXH1R8xfcuRm4U7kumc7mf8+9vh0UYZPmpVs2nHKUzVGAsJwCiDr2wwKITiq3DTmSCROowIoeY0UMoEnfHpc01KQQGJC6MSnIvOrXlS81ZOfL+KVIwzOXpwxRDL19Xa3oFOxQB8jmOlt+dB5gbsBbRTXDS11fV7BS/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SomcsPK8lIRQc0ywaslb+fpQ5OxBCdNO+Wpo47Ch6Bw=;
 b=lg8gB7YZrUoHSnq2KEL8t0d37W3kyg8qqAKbqjVoFSEepT7lTbNDv6xZRgGRLasdT7IH8dFBCBTziOhAai8t6wTnNovDBHHZC4MeRe/WPzyL+fMRA3YNh4DYt6WXnzBoJRQlWFHe4gvXZgDHmVGDOEr0y8ngN2nGmGI52LDQxXk=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AM9PR08MB6866.eurprd08.prod.outlook.com (2603:10a6:20b:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 08:10:46 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e%7]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 08:10:45 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
CC:     Justin He <Justin.He@arm.com>, "will@kernel.org" <will@kernel.org>,
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
Thread-Index: AQHX8lbt013/nzm8RUa6mdFr92d9v6xU2ImAgAELwWCAAGL4AIABFwGwgAAjrYCAHXF+gIAAR6QAgAAGaOCAABRIgIAAAXgAgAABfiCAAAIvAIAAAEEAgAFJh/CAAGfSgIAGAnDw
Date:   Mon, 31 Jan 2022 08:10:44 +0000
Message-ID: <AM9PR08MB72760F336E9D198FB4A1E6D5F4259@AM9PR08MB7276.eurprd08.prod.outlook.com>
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
 <AM9PR08MB72764111B775352448D75CD9F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <65fdd873-1f93-56e3-c7a5-98d621c5dbd8@redhat.com>
 <7eb4bc77-c1db-99c4-4c77-ae9ddd159abb@redhat.com>
 <AM9PR08MB7276062BC7B474174FFFA11BF4219@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <ca62449b-7ab0-0e18-ee5a-b46b3f527385@redhat.com>
In-Reply-To: <ca62449b-7ab0-0e18-ee5a-b46b3f527385@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 4040AE2493AEEA438DC8C695A07B358C.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: e5d6454e-a412-4b96-3510-08d9e4913702
x-ms-traffictypediagnostic: AM9PR08MB6866:EE_|DB5EUR03FT015:EE_|AM5PR0802MB2545:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2545D608DE9530365FDB4EA7F4259@AM5PR0802MB2545.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: j75N6bIlRB39RJ4vfdNIVBwAVEHD+TeN8p72kxEpiVOxrnbQXMDJytH8hUdpCCqHwKXnGtj2Z6pDl5Fkdt3nd9Ht8haCvHp7ACs/SLXBLdAW5TwY48WZZzpXQqiav6prAN9yn+4KXnbFz9tquJL5oieRKa8Lkh6KThpxw1wnDF+rkZ3dBlCL+pWZXyMO9gBH3yWfRxKbrskfXLKH3fmpUjHyWYDPCH7fAVpYES99N/y0gXAS3tQ0jNLm737e1PmqWb0EnNZBhFjDSL253zEPCVrez3mM2sng5GiAOzin05TDYW3FV06Aw21ixQmuu0UNBFTpNqhXc3NG4kcIK4hi69fVaY/84DkzpcD/R7hIGDZFJtI5RwvmI0bMCWI/hl+2J84XG1nFDEWtYZGI7juoPkAYtyxxN1fp+8s7W2NfkIlchgr57zdV4llq8DoBnHPXIBKbw5UpOzyyzB+OqJWhjA+iFrbjQSfI7iPjZr0Z3p7tl6TuJkw2AMikYS00EQnU3RsGmAWvGxHA2fEloq3aJUtO6Am0T2LRYiBxL6N0I395cG7O81zIs2lpTrsKLwdIT6x96rOZ2N/nEPLDmflLhyzbdoNsh9DWmoAK93pwjyrFMAx+IzAMa3cw8inxo7Ccl5eXtZhCw5T0DRrgUOXXlwMI1JbB0+rR+Vtyt1tL005uuU32zBr37tSlOghfFQisOWbiBD6yx3pRvHPpkLLKVg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(508600001)(71200400001)(83380400001)(66476007)(8676002)(76116006)(8936002)(64756008)(66946007)(38100700002)(66556008)(66446008)(7696005)(316002)(9686003)(4326008)(6506007)(122000001)(33656002)(54906003)(2906002)(38070700005)(6636002)(110136005)(52536014)(5660300002)(86362001)(26005)(53546011)(186003)(20210929001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6866
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 54788f6e-92cb-4a6b-4068-08d9e4912ea3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYlOFxXtN9qI99iz8+JQ7NjcmiAnN8rC3nIRFzWWU3b/5Ms2PZfJOXlpWw9B1FoS2p7FW4PJj1H8dW8cey1BDeYCsKlBM19hy+sV9aFIIo315AOOg/luSzFyXcRIc8Lefs8nHFGMKXcd39+lKCkM+BaHlwA5NR1FLN5a9WpqHibfI83Pbcl5m74dBwLmtLO43t524x4rNFlRHlqbYc7Fc8eaV05BHzPUqXtHAAfc2R/O/U7ssHrLTQ4CwMtJr80pQGaNMK5Mo65x/dHaMcdeXtIU+BHAFJvg97Ob7aPSwkoA8B4neHUWJKX8MSw/Kdlyh28m4IlkfjU1bKfF+UTlWGhBum0sUdqrtDfk6gbvl/dD40cuf7xwGXYUnBMUROejt8BKMOC2Ity2g/5CzoO0eK/fM+P/W1/a85gV32VPx84PMSFFvM3krSyeFGLjIcdX9lz4Y0/H5GqZtcQNAeE/QYzTJthAAztUl1db2TOrZGSt1LLhvnGiR9i2jD2yqVTdLylNc90ao5lD86xAOlYE+twQO6pjJNbp/gwAxfne/CHTGcL9+tZXyEyIQK1qJTFw5q2ajSLSrF5ilUWSrpFRbiKiYYzx2Kt0lBhwhzAuMwuJfJijvDbkSxpujszhWmyAwLzpE8GMXeC5T2N+GMrz+I0cy+EVlg1xOSQcYppiemqyBUQ8isONKKSqwpyrVeDY
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(9686003)(52536014)(6506007)(5660300002)(7696005)(70586007)(70206006)(53546011)(8936002)(8676002)(4326008)(55016003)(83380400001)(36860700001)(86362001)(47076005)(40460700003)(82310400004)(33656002)(336012)(186003)(356005)(54906003)(26005)(6636002)(316002)(508600001)(81166007)(110136005)(2906002)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 08:10:59.3838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d6454e-a412-4b96-3510-08d9e4913702
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2545
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQg
SGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5
IDI3LCAyMDIyIDg6MjMgUE0NCj4gVG86IEppYW55b25nIFd1IDxKaWFueW9uZy5XdUBhcm0uY29t
PjsgQXJkIEJpZXNoZXV2ZWwNCj4gPGFyZGJAa2VybmVsLm9yZz47IENhdGFsaW4gTWFyaW5hcyA8
Q2F0YWxpbi5NYXJpbmFzQGFybS5jb20+DQo+IENjOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0u
Y29tPjsgd2lsbEBrZXJuZWwub3JnOyBBbnNodW1hbiBLaGFuZHVhbA0KPiA8QW5zaHVtYW4uS2hh
bmR1YWxAYXJtLmNvbT47IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IHF1aWNfcWlhbmNh
aUBxdWljaW5jLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0K
PiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZ3NoYW5AcmVkaGF0LmNvbTsgbmQgPG5kQGFy
bS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGFybTY0L21tOiBhdm9pZCBmaXhtYXAg
cmFjZSBjb25kaXRpb24gd2hlbiBjcmVhdGUNCj4gcHVkIG1hcHBpbmcNCj4gDQo+ID4NCj4gPiBZ
ZXMsIHN5c3RlbV9zdGF0ZSBjYW4gcm91Z2hseSBzZXBhcmF0ZSB0aGVzZSBjYWxsZXJzIG9mDQo+
IF9fY3JlYXRlX3BnZF9tYXBwaW5nLiBXaGVuIHN5c3RlbV9zdGF0ZSA+IFNZU1RFTV9CT09USU5H
IHdlIGNhbg0KPiBhZGQgdGhlIGxvY2suDQo+ID4gVGh1cywgSSBoYXZlIHRoZSBmb2xsb3dpbmcg
Y2hhbmdlOg0KPiA+DQo+ID4gc3RhdGljIERFRklORV9TUElOTE9DSyhzd2FwcGVyX3BnZGlyX2xv
Y2spOw0KPiA+ICtzdGF0aWMgREVGSU5FX01VVEVYKGZpeG1hcF9sb2NrKTsNCj4gPg0KPiA+ICB2
b2lkIHNldF9zd2FwcGVyX3BnZChwZ2RfdCAqcGdkcCwgcGdkX3QgcGdkKSAgeyBAQCAtMzI5LDYg
KzMzMCw4IEBADQo+ID4gc3RhdGljIHZvaWQgYWxsb2NfaW5pdF9wdWQocGdkX3QgKnBnZHAsIHVu
c2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZw0KPiBlbmQsDQo+ID4gICAgICAgICB9DQo+
ID4gICAgICAgICBCVUdfT04ocDRkX2JhZChwNGQpKTsNCj4gPg0KPiA+ICsgICAgICAgaWYgKHN5
c3RlbV9zdGF0ZSA+IFNZU1RFTV9CT09USU5HKQ0KPiANCj4gQXMgdGhlcmUgaXMgbm90aGluZyBz
bWFsbGVyIHRoYW4gU1lTVEVNX0JPT1RJTkcsIHlvdSBjYW4gdXNlDQo+IAlpZiAoc3lzdGVtX3N0
YXRlICE9IFNZU1RFTV9CT09USU5HKQ0KPiANCj4gLi4uDQpPSywNCg0KPiANCj4gPg0KPiA+IEl0
IHNlZW1zIHdvcmsgYW5kIHNvbWVob3cgc2ltcGVyLiBCdXQgSSBkb24ndCBrbm93IGlmIGl0IGlz
IHJlYXNvbmFibGUNCj4gPiB0byBkbyB0aGlzLiBTbywgYW55IGlkZWE/IEBBcmQgQmllc2hldXZl
bCAgQENhdGFsaW4gTWFyaW5hcw0KPiANCj4gSXQncyB3b3J0aCBsb29raW5nIGF0IGtlcm5lbC9u
b3RpZmllci5jLCBlLmcuLA0KPiBibG9ja2luZ19ub3RpZmllcl9jaGFpbl9yZWdpc3RlcigpDQo+
IA0KPiBpZiAodW5saWtlbHkoc3lzdGVtX3N0YXRlID09IFNZU1RFTV9CT09USU5HKSkNCj4gCXJl
dHVybiBub3RpZmllcl9jaGFpbl9yZWdpc3RlcigmbmgtPmhlYWQsIG4pOw0KPiANCj4gZG93bl93
cml0ZSgmbmgtPnJ3c2VtKTsNCj4gcmV0ID0gbm90aWZpZXJfY2hhaW5fcmVnaXN0ZXIoJm5oLT5o
ZWFkLCBuKTsgdXBfd3JpdGUoJm5oLT5yd3NlbSk7DQo+IA0KPiANCj4gDQo+IElmIHdlIGRlY2lk
ZSB0byBnbyBkb3duIHRoYXQgcGF0aCwgd2Ugc2hvdWxkIG1ha2Ugc3VyZSB0byBhZGQgYSBjb21t
ZW50DQo+IGxpa2UNCj4gDQo+IC8qDQo+ICAqIE5vIG5lZWQgZm9yIGxvY2tpbmcgZHVyaW5nIGVh
cmx5IGJvb3QuIEFuZCBpdCBkb2Vzbid0IHdvcmsgYXMNCj4gICogZXhwZWN0ZWQgd2l0aCBLQVNM
UiBlbmFibGVkIHdoZXJlIHdlIG1pZ2h0IGNsZWFyIEJTUyB0d2ljZS4NCj4gICovDQo+IA0KDQpU
aGFua3MgRGF2aWQsIGl0J3MgdmVyeSBoZWxwZnVsLg0KDQpUaGFua3MNCkppYW55b25nDQoNCj4g
LS0NCj4gVGhhbmtzLA0KPiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KDQo=
