Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D11649C722
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbiAZKJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:09:53 -0500
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:10336
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239644AbiAZKJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7kdhF9uAeE1gANzJ29oJv3qqQ26wOmqszYkPZ6kdJ0=;
 b=Bn5QcEyrYOWhq97qwyJ1n79ubi2R3qFiJQqLKvZPbaWnWTvRBRSvCYfRk0C/Gfh/HzenYdHasrDW+wucwGiFkjGkKoSiym7PBloOFxTyJfiv/P41TKdQmbZV+Fi7QElw837BVcVHPUKfjZW33CrSowV7cOfIZIrwhfgQGq3zfGs=
Received: from AS8P189CA0011.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::24)
 by DBBPR08MB4806.eurprd08.prod.outlook.com (2603:10a6:10:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 10:09:49 +0000
Received: from AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:31f:cafe::31) by AS8P189CA0011.outlook.office365.com
 (2603:10a6:20b:31f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 10:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT011.mail.protection.outlook.com (10.152.16.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 26 Jan 2022 10:09:49 +0000
Received: ("Tessian outbound 1f399c739551:v113"); Wed, 26 Jan 2022 10:09:48 +0000
X-CR-MTA-TID: 64aa7808
Received: from f1d5797b811c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EBC397AE-2C3C-4E5F-82DC-A6C104D18CC8.1;
        Wed, 26 Jan 2022 10:09:43 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f1d5797b811c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 26 Jan 2022 10:09:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8lMyosFumLElLEUrHs1UzX/zb3yzpcQ9loy2Ez56c3WzNvyO2S49RFSJiIdhBv1zljHjv80Rucq2dEURNIERRU93+tdvf+b/N0/P3bVF1r5jPAbY3nQKxecndKfPqsKtZSvr3s8ZjVtsuyTB+4wo8Ju7/PFFd1OPYWSb9aYT4ejLbhcHApw+Ed/oVlxTJW8+2t2aYvcHJMYiM6k5XvGBJpnh9Cr2oC3WEy0en6iBY/od9VeYW4h4CKVbj4/Uwfta2N1Wl23FiRDUNuLGl1ANwSavirGOLNYVtCIbw4OzKkR3q8cVl9A1s8Ku7dWI8LL1SP11Ly6NA9sLLykooCltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7kdhF9uAeE1gANzJ29oJv3qqQ26wOmqszYkPZ6kdJ0=;
 b=kv6oORRrXs3QhUv9ohnx92BOK2IBPO8bvgBmHeMFmg+DPc2PlHMeAk31w33hHTItyeo5dZN7eyduHTE6JMPLV9XMqVNr2fq6wBUCr32+kksgrUhPmHfiE9V4mWrFe/Y6mNENT2XuOONOGu+fFaoWlrSJp+Q1kygyMlxB5sY5QSz8YVMAdb2aWNw1YRjhN01ix8VlXhSc2z6slO9v70a8R3inp6Q8mjlYG0C9wTC4ZEbCxRTm3Zt3QfvuZP4i7ejjW8MlkMW4hb3UAPrcpCOE+5j/deEg9PX1cQe4+XVxF94xw48G1cHL7oMo2mwh4Oa3lUKkFfIGOXbAy/tR7WQ02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7kdhF9uAeE1gANzJ29oJv3qqQ26wOmqszYkPZ6kdJ0=;
 b=Bn5QcEyrYOWhq97qwyJ1n79ubi2R3qFiJQqLKvZPbaWnWTvRBRSvCYfRk0C/Gfh/HzenYdHasrDW+wucwGiFkjGkKoSiym7PBloOFxTyJfiv/P41TKdQmbZV+Fi7QElw837BVcVHPUKfjZW33CrSowV7cOfIZIrwhfgQGq3zfGs=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AM6PR08MB4213.eurprd08.prod.outlook.com (2603:10a6:20b:8e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 10:09:41 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e%7]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 10:09:40 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Justin He <Justin.He@arm.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>, nd <nd@arm.com>
Subject: RE: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX8lbt013/nzm8RUa6mdFr92d9v6xU2ImAgAELwWCAAGL4AIABFwGwgAAjrYCAHXF+gIAAR6QAgAAGaOA=
Date:   Wed, 26 Jan 2022 10:09:40 +0000
Message-ID: <AM9PR08MB72763D5DA0C5F22D2126ABF4F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com>
 <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdgZJ/mBG+BCxmEv@arm.com>
 <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
 <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
In-Reply-To: <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 11D54A36FA6DB946A84FA66016CCAA61.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 5b96505d-4ab0-4819-42f4-08d9e0b3fca5
x-ms-traffictypediagnostic: AM6PR08MB4213:EE_|AM5EUR03FT011:EE_|DBBPR08MB4806:EE_
X-Microsoft-Antispam-PRVS: <DBBPR08MB4806347C424FB0FBBBAD27D4F4209@DBBPR08MB4806.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8WpYZytM/P8bA9/m0E8RIgEqL1IbNpV237FTmAa/49aifQ1ffcbepQ5OAiLfSC9cwa+YVQxLgt2RTyW5V6+8p14dva1Z8sOcmqH0sGQihwIH1MGHY974pg4deoiZdVUr06f0tCrFEErjRk+/cHY0wpxDOWpOGX24YXCeAr8JZaXIT9XPoEZpbogUyBRcenBPzRpF02R2/HWulGOma7yNeyyP8hKtFGW0VOrFmW/5pQBkXo/1fd2/Zd1N29LldatzZtAPmS+xNCkP6RtY4A4hz5sn7T+l7acMb3pgyHZ3pDbuMD8ds4wMTFUtYs3wEHOCxRrQbqRtyN4bDhvGemBL/NyPi77Xb1Y9i6ffRA9P3mFyaeb5EFPSCyJHIAZN92NjhE82do++Accnwo2/UPyLJaFvUyt1+HAvlfDzsKj8QRJbVps+Lm1brpkYTrTgmUVbKm989BGg9V8pxFLaUL9d/ILMJUwFy9vPJQpy12xK259II8RaL4N2iAulKUAuOvrYp/XdiuVs3Gquou/D2eIpDoqIMbJH65PGHpfRtdAy3DLAQE3Mzzx3yKvJfj79+7TVUsuTwbXMSFVGn4W+QOvc9Fw6qtnw6xZqjARmB96BUf5SBhR9NpRRojzXQBKhNvNp/GYDtJFyVgpd8XKhQQHQDUruES/HKeeU+bP7HnKly8BdSI/4DNWtd+ijhBrRDQbh66ZVny14W8mjPZAsZKAcVA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(508600001)(83380400001)(26005)(86362001)(186003)(2906002)(53546011)(33656002)(8676002)(66446008)(5660300002)(4326008)(8936002)(110136005)(52536014)(122000001)(38100700002)(38070700005)(71200400001)(55016003)(6636002)(6506007)(66946007)(66476007)(66556008)(7696005)(54906003)(64756008)(76116006)(316002)(20210929001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4213
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0182d4c7-737d-4f84-b6ef-08d9e0b3f7bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwVMFC8JgslpM7IKvz+LUJpvEepBmiUsNdSmshLLYF1nsMv5j7E1HL7DvrDf10Gmef9DpUomD8hd/vFIZ/u59MOtAV85pWOzL2bPPAKLhPI9XlgOXmihHQi79Mz0T/zGxC/3o7P3H+OW8ZOVhoDxHlwWWcy6W7A9P+RQdc6cehoOju8m5Ze0G+DH/AEbSfPpdzSRJ/P5RsxGjqEbwG+6uKaR1viTQRq6eeodDIPrSzvN/N1TbqKXPHYXA8vLav5PB1C2mPryGhgjB5Sv0vJ79JSrgvhhyPg4xPD46Up0QW86LfLLHkbMOiLnxfzwhvdwFvdUqRzEFqs/WhepyhHLaeUEMu8hIOubS62b0RUhdvu90vMznILGB/FWTwiKkg0Mv9/IUF4HrkC7ILk9MsoBwq0r8yC1VNqbiPdFKp+ZAx3JhpucQQA/I7yorFsqxrsNn5s9MaOKEahvw6MmJGZLfUqOvvoiibxyait7ZbA0NkaWFeqidRf9hY5ZNhJM3xi9GR5rwAk71imRCviaJ2rk4SXxE2A2h79EvtVjw/pH4CJmho5oNAMZs8qxWsSB8QH0+vTm4rwASqhHkhREuP/yX/AupWjKM0NeEBGs06BBVpQ1AJCoOymJVTRk77Ttx2hnG29eKY5X6X9aJ+DJ3ycQTnCGIrYMpP4T2KuhqgON/icWVP9qTJpyp6Pco36EVtEPUZX83YDW8JXyOWOYtlfO2IpWT/EXxr11DLQKcbiMs/n2CZDgoFVy73dA6qGpzno0Obio1lLWdRRVBo+RMbjqlldQfWngz5jaOyDhgY3CZV2t0bFsxcScCPA8pVYE1Flp
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(40470700004)(46966006)(36840700001)(508600001)(316002)(186003)(7696005)(6506007)(70586007)(53546011)(52536014)(70206006)(356005)(33656002)(54906003)(5660300002)(83380400001)(40460700003)(81166007)(6636002)(36860700001)(26005)(8676002)(9686003)(336012)(55016003)(82310400004)(86362001)(2906002)(47076005)(4326008)(110136005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 10:09:49.1311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b96505d-4ab0-4819-42f4-08d9e0b3fca5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4806
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJkLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFyZCBCaWVz
aGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyNiwg
MjAyMiA0OjM3IFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBDYzog
Q2F0YWxpbiBNYXJpbmFzIDxDYXRhbGluLk1hcmluYXNAYXJtLmNvbT47IEppYW55b25nIFd1DQo+
IDxKaWFueW9uZy5XdUBhcm0uY29tPjsgd2lsbEBrZXJuZWwub3JnOyBBbnNodW1hbiBLaGFuZHVh
bA0KPiA8QW5zaHVtYW4uS2hhbmR1YWxAYXJtLmNvbT47IGFrcG1AbGludXgtZm91bmRhdGlvbi5v
cmc7DQo+IGRhdmlkQHJlZGhhdC5jb207IHF1aWNfcWlhbmNhaUBxdWljaW5jLmNvbTsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gZ3NoYW5AcmVkaGF0LmNvbTsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjNdIGFybTY0L21tOiBhdm9pZCBmaXhtYXAgcmFjZSBjb25kaXRpb24gd2hl
biBjcmVhdGUNCj4gcHVkIG1hcHBpbmcNCj4gDQo+IE9uIFdlZCwgMjYgSmFuIDIwMjIgYXQgMDU6
MjEsIEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgQ2F0
YWxpbg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
Q2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4NCj4gPiA+IFNlbnQ6IEZy
aWRheSwgSmFudWFyeSA3LCAyMDIyIDY6NDMgUE0NCj4gPiA+IFRvOiBKaWFueW9uZyBXdSA8Smlh
bnlvbmcuV3VAYXJtLmNvbT4NCj4gPiA+IENjOiB3aWxsQGtlcm5lbC5vcmc7IEFuc2h1bWFuIEto
YW5kdWFsDQo+IDxBbnNodW1hbi5LaGFuZHVhbEBhcm0uY29tPjsNCj4gPiA+IGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc7IGRhdmlkQHJlZGhhdC5jb207DQo+ID4gPiBxdWljX3FpYW5jYWlAcXVp
Y2luYy5jb207IGFyZGJAa2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS0ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBnc2hh
bkByZWRoYXQuY29tOyBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPjsgbmQgPG5kQGFybS5j
b20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBhcm02NC9tbTogYXZvaWQgZml4bWFw
IHJhY2UgY29uZGl0aW9uIHdoZW4NCj4gPiA+IGNyZWF0ZSBwdWQgbWFwcGluZw0KPiA+ID4NCj4g
PiA+IE9uIEZyaSwgSmFuIDA3LCAyMDIyIGF0IDA5OjEwOjU3QU0gKzAwMDAsIEppYW55b25nIFd1
IHdyb3RlOg0KPiA+ID4gPiBIaSBDYXRhbGluLA0KPiA+ID4gPg0KPiA+ID4gPiBJIHJvdWdobHkg
ZmluZCB0aGUgcm9vdCBjYXVzZS4NCj4gPiA+ID4gIGFsbG9jX2luaXRfcHVkIHdpbGwgYmUgY2Fs
bGVkIGF0IHRoZSB2ZXJ5IGJlZ2lubmluZyBvZiBrZXJuZWwNCj4gPiA+ID4gYm9vdCBpbg0KPiA+
ID4gY3JlYXRlX21hcHBpbmdfbm9hbGxvYyB3aGVyZSBubyBtZW1vcnkgYWxsb2NhdG9yIGlzIGlu
aXRpYWxpemVkLiBCdXQNCj4gPiA+IGxvY2tkZXAgY2hlY2sgbWF5IG5lZWQgYWxsb2NhdGUgbWVt
b3J5LiBTbywga2VybmVsIHRha2UgZXhjZXB0aW9uDQo+ID4gPiB3aGVuIGFjcXVpcmUgbG9jay4o
SSBoYXZlIG5vdCBmb3VuZCB0aGUgZXhhY3QgY29kZSB0aGF0IGNhdXNlIHRoaXMNCj4gPiA+IGlz
c3VlKSB0aGF0J3Mgc2F5IHdlIG1heSBub3QgYmUgYWJsZSB0byB1c2UgYSBsb2NrIHNvIGVhcmx5
Lg0KPiA+ID4gPg0KPiA+ID4gPiBJIGNvbWUgdXAgd2l0aCAyIG1ldGhvZHMgdG8gYWRkcmVzcyBp
dC4NCj4gPiA+ID4gMSkgc2tpcCBkZWFkIGxvY2sgY2hlY2sgYXQgdGhlIHZlcnkgYmVnaW5uaW5n
IG9mIGtlcm5lbCBib290IGluDQo+ID4gPiA+IGxvY2tkZXANCj4gPiA+IGNvZGUuDQo+ID4gPiA+
IDIpIHByb3ZpZGVkIDIgdHdvIHZlcnNpb25zIG9mIF9fY3JlYXRlX3BnZF9tYXBwaW5nLCBvbmUg
d2l0aCBsb2NrDQo+ID4gPiA+IGluIGl0IGFuZCB0aGUgb3RoZXIgd2l0aG91dC4gVGhlcmUgbWF5
IGJlIG5vIHBvc3NpYmxlIG9mIHJhY2UgZm9yDQo+ID4gPiA+IG1lbW9yeSBtYXBwaW5nIGF0IHRo
ZSB2ZXJ5IGJlZ2lubmluZyB0aW1lIG9mIGtlcm5lbCBib290LCB0aHVzIHdlDQo+ID4gPiA+IGNh
biB1c2UgdGhlIG5vIGxvY2sgdmVyc2lvbiBvZiBfX2NyZWF0ZV9wZ2RfbWFwcGluZyBzYWZlbHku
DQo+ID4gPiA+IEluIG15IHRlc3QsIHRoaXMgaXNzdWUgaXMgZ29uZSBpZiB0aGVyZSBpcyBubyBs
b2NrIGhlbGQgaW4NCj4gPiA+ID4gY3JlYXRlX21hcHBpbmdfbm9hbGxvYy4gSSB0aGluayBjcmVh
dGVfbWFwcGluZ19ub2FsbG9jIGlzIGNhbGxlZA0KPiA+ID4gPiBlYXJseSBlbm91Z2ggdG8gYXZv
aWQgdGhlIHJhY2UgY29uZGl0aW9ucyBvZiBtZW1vcnkgbWFwcGluZywNCj4gPiA+ID4gaG93ZXZl
ciwgSSBoYXZlIG5vdCBwcm92ZWQgaXQuDQo+ID4gPg0KPiA+ID4gSSB0aGluayBtZXRob2QgMiB3
b3VsZCB3b3JrIGJldHRlciBidXQgcmF0aGVyIHRoYW4gaW1wbGVtZW50aW5nIG5ldw0KPiA+ID4g
bm9sb2NrIGZ1bmN0aW9ucyBJJ2QgYWRkIGEgTk9fTE9DSyBmbGFnIGFuZCBjaGVjayBpdCBpbg0K
PiA+ID4gYWxsb2NfaW5pdF9wdWQoKSBiZWZvcmUgbXV0ZXhfbG9jay91bmxvY2suIEFsc28gYWRk
IGEgY29tbWVudCB3aGVuDQo+ID4gPiBwYXNzaW5nIHRoZSBOT19MT0NLIGZsYWcgb24gd2h5IGl0
J3MgbmVlZGVkIGFuZCB3aHkgdGhlcmUgd291bGRuJ3QNCj4gPiA+IGJlIGFueSByYWNlcyBhdCB0
aGF0IHN0YWdlIChlYXJseSBib290IGV0Yy4pDQo+ID4gPg0KPiA+IFRoZSBwcm9ibGVtYXRpYyBj
b2RlIHBhdGggaXM6DQo+ID4gX19wcmltYXJ5X3N3aXRjaGVkDQo+ID4gICAgICAgICBlYXJseV9m
ZHRfbWFwLT5maXhtYXBfcmVtYXBfZmR0DQo+ID4gICAgICAgICAgICAgICAgIGNyZWF0ZV9tYXBw
aW5nX25vYWxsb2MtPmFsbG9jX2luaXRfcHVkDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
bXV0ZXhfbG9jayAod2l0aCBKaWFueW9uZydzIHBhdGNoKQ0KPiA+DQo+ID4gVGhlIHByb2JsZW0g
c2VlbXMgdG8gYmUgdGhhdCB3ZSB3aWxsIGNsZWFyIEJTUyBzZWdtZW50IHR3aWNlIGlmIGthc2xy
DQo+ID4gaXMgZW5hYmxlZC4gSGVuY2UsIHNvbWUgb2YgdGhlIHN0YXRpYyB2YXJpYWJsZXMgaW4g
bG9ja2RlcCBpbml0DQo+ID4gcHJvY2VzcyB3ZXJlIG1lc3NlZCB1cC4gVGhhdCBpcyB0byBzYWlk
LCB3aXRoIGthc2xyIGVuYWJsZWQgd2UgbWlnaHQNCj4gPiBpbml0aWFsaXplIGxvY2tkZXAgdHdp
Y2UgaWYgd2UgYWRkIG11dGV4X2xvY2svdW5sb2NrIGluIGFsbG9jX2luaXRfcHVkKCkuDQo+ID4N
Cj4gDQo+IFRoYW5rcyBmb3IgdHJhY2tpbmcgdGhhdCBkb3duLg0KPiANCj4gTm90ZSB0aGF0IGNs
ZWFyaW5nIHRoZSBCU1MgdHdpY2UgaXMgbm90IHRoZSByb290IHByb2JsZW0gaGVyZS4gVGhlIHJv
b3QNCj4gcHJvYmxlbSBpcyB0aGF0IHdlIHNldCBnbG9iYWwgc3RhdGUgd2hpbGUgdGhlIGtlcm5l
bCBydW5zIGF0IHRoZSBkZWZhdWx0IGxpbmsNCj4gdGltZSBhZGRyZXNzLCBhbmQgdGhlbiByZWZl
ciB0byBpdCBhZ2FpbiBhZnRlciB0aGUgZW50aXJlIGtlcm5lbCBoYXMgYmVlbg0KPiBzaGlmdGVk
IGluIHRoZSBrZXJuZWwgVkEgc3BhY2UuIFN1Y2ggZ2xvYmFsIHN0YXRlIGNvdWxkIGNvbnNpc3Qg
b2YgbXV0YWJsZQ0KPiBwb2ludGVycyB0byBzdGF0aWNhbGx5IGFsbG9jYXRlZCBkYXRhICh3aGlj
aCB3b3VsZCBiZSByZXNldCB0byB0aGVpciBkZWZhdWx0DQo+IHZhbHVlcyBhZnRlciB0aGUgcmVs
b2NhdGlvbiBjb2RlIHJ1bnMgYWdhaW4pLCBvciBnbG9iYWwgcG9pbnRlciB2YXJpYWJsZXMgaW4g
QlNTLg0KPiBJbiBlaXRoZXIgY2FzZSwgcmVseWluZyBvbiBzdWNoIGEgZ2xvYmFsIHZhcmlhYmxl
IGFmdGVyIHRoZSBzZWNvbmQgcmVsb2NhdGlvbg0KPiBwZXJmb3JtZWQgYnkgS0FTTFIgd291bGQg
YmUgcmlza3ksIGFuZCBzbyB3ZSBzaG91bGQgYXZvaWQgbWFuaXB1bGF0aW5nDQo+IGdsb2JhbCBz
dGF0ZSBhdCBhbGwgaWYgaXQgbWlnaHQgaW52b2x2ZSBwb2ludGVyIHRvIHN0YXRpY2FsbHkgYWxs
b2NhdGVkIGRhdGENCj4gc3RydWN0dXJlcy4NCj4gDQo+ID4gSW4gb3RoZXIgd2F5cywgaWYgd2Ug
aW52b2tlIG11dGV4X2xvY2svdW5sb2NrIGluIHN1Y2ggYSBlYXJseSBib290aW5nIHN0YWdlLg0K
PiA+IEl0IG1pZ2h0IGJlIHVuc2FmZSBiZWNhdXNlIGxvY2tkZXAgaW5zZXJ0cyBsb2NrX2FjcXVp
cmUvcmVsZWFzZSBhcyB0aGUNCj4gPiBjb21wbGV4IGhvb2tzLg0KPiA+DQo+ID4gSW4gc3VtbWFy
eSwgd291bGQgaXQgYmV0dGVyIGlmIEppYW55b25nIHNwbGl0cyB0aGVzZSBlYXJseSBib290IGFu
ZA0KPiA+IGxhdGUgYm9vdCBjYXNlPyBlLmcuIGludHJvZHVjZSBhIG5vbG9jayB2ZXJzaW9uIGZv
cg0KPiBjcmVhdGVfbWFwcGluZ19ub2FsbG9jKCkuDQo+ID4NCj4gPiBXaGF0IGRvIHlvdSB0aGlu
ayBvZiBpdD8NCj4gPg0KPiANCj4gVGhlIHByZS1LQVNMUiBjYXNlIGRlZmluaXRlbHkgZG9lc24n
dCBuZWVkIGEgbG9jay4gQnV0IGdpdmVuIHRoYXQNCj4gY3JlYXRlX21hcHBpbmdfbm9hbGxvYygp
IGlzIG9ubHkgdXNlZCB0byBtYXAgdGhlIEZEVCwgd2hpY2ggaGFwcGVucyB2ZXJ5DQo+IGVhcmx5
IG9uZSB3YXkgb3IgdGhlIG90aGVyLCB3b3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gbW92ZSB0aGUg
bG9jay91bmxvY2sNCj4gaW50byBvdGhlciBjYWxsZXJzIG9mIF9fY3JlYXRlX3BnZF9tYXBwaW5n
KCk/IChhbmQgbWFrZSBzdXJlIG5vIG90aGVyDQo+IHVzZXJzIG9mIHRoZSBmaXhtYXAgc2xvdHMg
ZXhpc3QpDQoNClRoZXJlIGFyZSBzZXJ2ZXIgY2FsbGVycyBvZiBfX2NyZWF0ZV9wZ2RfbWFwcGlu
Zy4gSSB0aGluayBzb21lIG9mIHRoZW0gbmVlZCBubyBmaXhtYXAgbG9jayBhcyB0aGV5IGFyZSBj
YWxsZWQgc28gZWFybHkuIEkgZmlndXJlIG91dCBhbGwgb2YgdGhlbSBoZXJlOg0KY3JlYXRlX21h
cHBpbmdfbm9hbGxvYzogICBubyBsb2NrDQpjcmVhdGVfcGdkX21hcHBpbmc6ICAgbm8gbG9jaw0K
X19tYXBfbWVtYmxvY2s6ICAgIG5vIGxvY2sNCm1hcF9rZXJuZWxfc2VnbWVudDogIG5vIGxvY2sN
Cm1hcF9lbnRyeV90cmFtcG9saW5lOiBubyBsb2NrDQp1cGRhdGVfbWFwcGluZ19wcm90OiAgICBu
ZWVkIGxvY2sNCmFyY2hfYWRkX21lbW9yeTogIG5lZWQgbG9jaw0KDQpXRFlUPw0KDQpUaGFua3MN
CkppYW55b25nDQo=
