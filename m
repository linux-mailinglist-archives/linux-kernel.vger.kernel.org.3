Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78E47686C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhLPDAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:00:30 -0500
Received: from mail-eopbgr10078.outbound.protection.outlook.com ([40.107.1.78]:10564
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230176AbhLPDA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIDfGjeW3s3c3XplrcZfJMqT2NBzPbr6ukgDO/ghw4s=;
 b=sqMir2w2eV23afQ0YycRu3MriaDuSboDiF/pSSAw4sHF4DiaSrNlh/eT3GXrKRDxFYBOT1/Mwws8MImYpAEDE00JPTzg9MU/SjwGXSeMXjm3QMVOfHwiZ7DjxDhevP6WvHEJ8twnvEeNmjXhIIAoDVEsYn2t8wp9gQnY56svrnU=
Received: from AM5PR0301CA0005.eurprd03.prod.outlook.com
 (2603:10a6:206:14::18) by DB9PR08MB6796.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 16 Dec
 2021 03:00:26 +0000
Received: from AM5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:14:cafe::fc) by AM5PR0301CA0005.outlook.office365.com
 (2603:10a6:206:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 03:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT044.mail.protection.outlook.com (10.152.17.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Thu, 16 Dec 2021 03:00:26 +0000
Received: ("Tessian outbound 157533e214a9:v110"); Thu, 16 Dec 2021 03:00:25 +0000
X-CR-MTA-TID: 64aa7808
Received: from b62dbb760ac3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 879F0808-7E6D-4457-9762-5151C2D23BFB.1;
        Thu, 16 Dec 2021 03:00:20 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b62dbb760ac3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 16 Dec 2021 03:00:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aChYb7+DG1MYETZdfLZVB+plC4puEqyrzAC5vZng08h20ujiUwbi4bpxojHrcWqwPXnKcaAfUYqyQ7PpFNMIVyoQlQa8uZTOXRk9LP93auZWvThlzjKAHibWKBZLkJBnvkwTFc5cQ4Qsl1wGV1TdVodpSF27nyvAzNUpoqi635Rbb6quGGU40BbwFpkT0C5i0TXwLVwaqtHEdeFpEWGq6acG6OyYO2iO2IW3ANssPnfwz3snYkPdSFzoFOwYw72Sc7vAVd5pZnCAnwH8UIy/8qFF+wcwqDWv6RtYbwaAZGgDJMW+caYmZSX+wTgX2YP35EEj4uXcedV1B2TiF1yAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIDfGjeW3s3c3XplrcZfJMqT2NBzPbr6ukgDO/ghw4s=;
 b=FKG/4Jf1JZPNXTwZpQh0XOCV3oGkubnQmIlqGV3NpDU6Bgnj+i3chLRiRiioJ5RZwW4ooDc2qF+2LgNmENnCuQNb44xNqdTpZYXl+/3dtZROZKYlJbp0uV8vEaoaDJuhEszEN+dzdyIKxQ1rr7QxFrkL2yHyvnK1jhCXiVHyNSUKmv6hW86VxCuGXKednOQ7Z9oK5ENy8yCORpltu6obc9Wpj82wPyL83CGIdKzg3Qedvj8H6BhDb2PAF1Pyo7mt0qjl5UOYAXKQTx9S1GySpld33GjdHKDQC0BYZPjpEunZS5JogubK2voOBGEUAv7opJ91DnVkPgqcB/h83hsmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIDfGjeW3s3c3XplrcZfJMqT2NBzPbr6ukgDO/ghw4s=;
 b=sqMir2w2eV23afQ0YycRu3MriaDuSboDiF/pSSAw4sHF4DiaSrNlh/eT3GXrKRDxFYBOT1/Mwws8MImYpAEDE00JPTzg9MU/SjwGXSeMXjm3QMVOfHwiZ7DjxDhevP6WvHEJ8twnvEeNmjXhIIAoDVEsYn2t8wp9gQnY56svrnU=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AM9PR08MB7273.eurprd08.prod.outlook.com (2603:10a6:20b:434::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 03:00:19 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14%3]) with mapi id 15.20.4755.028; Thu, 16 Dec 2021
 03:00:18 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX7awGuMgrKU0nsEmmvzNEMV7iBKwzoI+AgAAeioCAAABiAIAAtj0g
Date:   Thu, 16 Dec 2021 03:00:17 +0000
Message-ID: <AM9PR08MB727631828232036FA6461AEAF4779@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211210095432.51798-1-jianyong.wu@arm.com>
 <Ybn4EfweLqKtyW0+@fixkernel.com> <YboRr0BCgjAbYdHe@arm.com>
 <ccbb3a1f-856c-5879-acbc-fbaff9eb61de@redhat.com>
In-Reply-To: <ccbb3a1f-856c-5879-acbc-fbaff9eb61de@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 09149359E6FB5F40BCE6C9740ED48C20.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 9c4c7a3b-e936-43e1-b8f9-08d9c04035bd
x-ms-traffictypediagnostic: AM9PR08MB7273:EE_|AM5EUR03FT044:EE_|DB9PR08MB6796:
X-Microsoft-Antispam-PRVS: <DB9PR08MB6796B56B22B81BC9C9CFEBFAF4779@DB9PR08MB6796.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ul+BldYw+l9HTbt1FhRhFaL9goC/GN2P62WBQsonJikqiKziR/XtfP3JvgpCXJyINnHUnrm+zmFPEv7QlwlyF2qsLzxfT1ft4X4LJL1Lt6/kpLg3cuoWDBCXCAunwrbptlol/3utzzp5ek12e2cyOY5Q4EYglj4B/CZPtjIhp26SXgyVfZ0RKxhX3BUvTmRcdtceKKBllgwzxMmfNs41hoA7AveN6Y7bWjh0FKpY9d1obkZQ4uAuFqs+iV3fc0U7HpvngfiAvgKO4lrMIaDvxuCciJhodD8tp36fQejtxj8HrgYAoOIdhsRZH6wUm26uXXU+zV5yxEM4RiDv/Z1PkeX73wt2bel1tCuIZWPATBivA8FV9d0WP4W4GfORtpeBpc5FDfqz1ppzuJHeBA1uVBLPOf0kl0mW48iXYaHijxkD8dcznxgSiT7cCaSCxX6wQ9BruYn6zpSkMJS4EH0AjEzD7LN6aQF/ryTxDCozWxDCuYPuxk1V1BQZl+OVmAu9OXfHMbFi45H7FjMyVXpxnGOgQI6HTXl8JD7L6t+QvphlgB89bAc/fYUtZtRZNlWIkm1XtvXR7YKCFmPijfSdoH6UhkZoVktcDDRhs1pqaXqDM6GeUZY7RoJULusfW3/xI5aa2IP/SdMa0vEITuH3bD70k8UoAXUUCgK+Q3woUE0/TO9mpBrHUvtYXCwtmtNmqnX5BFHnfUBbBT5LxCHgWA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(9686003)(7696005)(110136005)(55016003)(33656002)(122000001)(86362001)(38100700002)(5660300002)(6506007)(8676002)(83380400001)(52536014)(53546011)(316002)(2906002)(4326008)(8936002)(508600001)(66946007)(64756008)(71200400001)(186003)(66446008)(26005)(66476007)(76116006)(66556008)(38070700005);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7273
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 15db0a17-487c-40b8-0ab5-08d9c0403105
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnlEwSp5aFE0X3jsI6MpK9hwOJNyuuSj2V8mW2dUEpqA2LivA8PsQENO6A1NCS56wdRTHjKb/ZLgyYk/IFcVIFQixljs4O8CWk1sZoztwSz7AmZaZ6fti3hIiZglWrIge4bFlOlk/kD/aD+Ai2y4TRQGNmjSe3i/EqEyA/ftNu+a2IvFv+gmneCloj3ujheMaTp3G+SDeELbNnW2ihIKm2FDj9qg0csFGW4IBh4aYhO8FQcxZnn/Cf7kEd8cMtww6IW3ysjxEi2B0xbY+NaxbNLpjaj4bb5WyQIghrY5DhOa/ybEDFIsBcZbuZX6eefHIh8YofdJ3+xEt/VqotmZ6JcTfNVL/rt55DBpdMt0t2hfpkA2k6Zv1pimZd289r6FUeXf1Cel48vb0V4hRrhIW4/MLluV+3rKA1YU/twr3qPTaC+Xirsi2C1rRGJ5VqfLnZjAa0aIs29fDafDsWzW1ISgwbnappSB54/l8dsMvLQdujFViFvk1kRTXYIf0jaYzVsEP96aZtuF31PQtbH2ZgVCqGW+FwR/Co4ydFHFE3YynApBADUJkObEB4tWYI2DzphqN0dzbytWPFzeyXdxt/1NPE7ftZVh4t8qWk079vTYpYgJppe+Fr8IihpGZMAQFjH5rSg9gaf9mJLarw9DTjNWGxrgJVLSLeWwh+I8GI6a0sMkuFrUvvZ6EybmTUWGJ7ZqrI47HxJ2kXy4tAesRGqoj0+Sn/Nn0PtkOfNWn+jP+1+H6jNuKIo8Na1QeLSoSsIUpRUxieqnCNzrua5bdA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(54906003)(40460700001)(7696005)(4326008)(110136005)(52536014)(55016003)(86362001)(336012)(36860700001)(316002)(5660300002)(53546011)(82310400004)(8936002)(6506007)(186003)(356005)(83380400001)(81166007)(9686003)(26005)(8676002)(70586007)(70206006)(2906002)(33656002)(47076005)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 03:00:26.1076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4c7a3b-e936-43e1-b8f9-08d9c04035bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6796
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIFFpYW4gdG8gcmVwb3J0IHRoaXMuDQpJIHdpbGwgY2hhbmdlIHRvIG11dGV4IGxvY2sg
YW5kIHJlc2VuZCBpdCBsYXRlci4NCg0KVGhhbmtzDQpKaWFueW9uZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQu
Y29tPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMTYsIDIwMjEgMTI6MDQgQU0NCj4gVG86
IENhdGFsaW4gTWFyaW5hcyA8Q2F0YWxpbi5NYXJpbmFzQGFybS5jb20+OyBRaWFuIENhaQ0KPiA8
cXVpY19xaWFuY2FpQHF1aWNpbmMuY29tPg0KPiBDYzogSmlhbnlvbmcgV3UgPEppYW55b25nLld1
QGFybS5jb20+OyB3aWxsQGtlcm5lbC5vcmc7IEFuc2h1bWFuDQo+IEtoYW5kdWFsIDxBbnNodW1h
bi5LaGFuZHVhbEBhcm0uY29tPjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gYXJkYkBr
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBnc2hhbkByZWRoYXQuY29tOyBKdXN0aW4gSGUNCj4g
PEp1c3Rpbi5IZUBhcm0uY29tPjsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjJdIGFybTY0L21tOiBhdm9pZCBmaXhtYXAgcmFjZSBjb25kaXRpb24gd2hlbiBjcmVhdGUN
Cj4gcHVkIG1hcHBpbmcNCj4gDQo+IE9uIDE1LjEyLjIxIDE3OjAyLCBDYXRhbGluIE1hcmluYXMg
d3JvdGU6DQo+ID4gT24gV2VkLCBEZWMgMTUsIDIwMjEgYXQgMDk6MTM6MzdBTSAtMDUwMCwgUWlh
biBDYWkgd3JvdGU6DQo+ID4+IE9uIEZyaSwgRGVjIDEwLCAyMDIxIGF0IDA1OjU0OjMyUE0gKzA4
MDAsIEppYW55b25nIFd1IHdyb3RlOg0KPiA+Pj4gZml4bWFwIGlzIGEgZ2xvYmFsIHJlc291cmNl
IGFuZCBpcyB1c2VkIHJlY3Vyc2l2ZWx5IGluIGNyZWF0ZSBwdWQgbWFwcGluZy4NCj4gPj4+IEl0
IG1heSBsZWFkIHRvIHJhY2UgY29uZGl0aW9uIHdoZW4gYWxsb2NfaW5pdF9wdWQgaXMgY2FsbGVk
IGNvbmN1cnJlbnRseS4NCj4gPj4+DQo+ID4+PiBGb3ggZXhhbXBsZToNCj4gPj4+IGFsbG9jX2lu
aXRfcHVkIGlzIGNhbGxlZCB3aGVuIGtlcm5lbF9pbml0LiBJZiBtZW1vcnkgaG90cGx1ZyB0aHJl
YWQsDQo+ID4+PiB3aGljaCB3aWxsIGFsc28gY2FsbCBhbGxvY19pbml0X3B1ZCwgaGFwcGVucyBk
dXJpbmcga2VybmVsX2luaXQsIHRoZQ0KPiA+Pj4gcmFjZSBmb3IgZml4bWFwIG9jY3Vycy4NCj4g
Pj4+DQo+ID4+PiBUaGUgcmFjZSBjb25kaXRpb24gZmxvdyBjYW4gYmU6DQo+ID4+Pg0KPiA+Pj4g
KioqKioqKioqKioqKioqIGJlZ2luICoqKioqKioqKioqKioqDQo+ID4+Pg0KPiA+Pj4ga2VyZW5s
X2luaXQgdGhyZWFkICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0aW8tbWVtIHdvcmtxdWV1
ZSB0aHJlYWQNCj4gPj4+ID09PT09PT09PT09PT09PT09PSAgICAgICAgICAgICAgICAgICAgICAg
ICAgPT09PT09PT0gPT09PT09PT09PT09PT09PT09DQo+ID4+PiBhbGxvY19pbml0X3B1ZCguLi4p
DQo+ID4+PiAgIHB1ZHAgPSBwdWRfc2V0X2ZpeG1hcF9vZmZzZXQoLi4pICAgICAgICAgIGFsbG9j
X2luaXRfcHVkKC4uLikNCj4gPj4+IC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLi4uDQo+ID4+PiAgICAgUkVBRF9PTkNFKCpwdWRwKSAvL09LISAgICAgICAgICAg
ICAgICAgICAgcHVkcCA9IHB1ZF9zZXRfZml4bWFwX29mZnNldCgNCj4gPj4+IC4uLiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQo+ID4+PiAgIHB1ZF9jbGVhcl9m
aXhtYXAoKSAvL2ZpeG1hcCBicmVhaw0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFJFQURfT05DRSgqcHVkcCkgLy9DUkFTSCENCj4gPj4+DQo+ID4+
PiAqKioqKioqKioqKioqKioqIGVuZCAqKioqKioqKioqKioqKioNCj4gPj4+DQo+ID4+PiBIZW5j
ZSwgYSBzcGluIGxvY2sgaXMgaW50cm9kdWNlZCB0byBwcm90ZWN0IHRoZSBmaXhtYXAgZHVyaW5n
IGNyZWF0ZQ0KPiA+Pj4gcGRnIG1hcHBpbmcuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTog
SmlhbnlvbmcgV3UgPGppYW55b25nLnd1QGFybS5jb20+DQo+ID4+DQo+ID4+IEkgYW0gYWZyYWlk
IHRoZXJlIGlzIGEgcHJvYmxlbSB0byB0YWtlIGEgc3BpbmxvY2sgdGhlcmUuDQo+ID4+DQo+ID4+
IG5vZGUgMCBkZWZlcnJlZCBwYWdlcyBpbml0aWFsaXNlZCBpbiAyNzQwbXMNCj4gPj4gIHBnZGF0
aW5pdDAgKDE3NikgdXNlZCBncmVhdGVzdCBzdGFjayBkZXB0aDogNTkxODQgYnl0ZXMgbGVmdA0K
PiA+PiAgZGV2dG1wZnM6IGluaXRpYWxpemVkDQo+ID4+ICBLQVNMUiBkaXNhYmxlZCBkdWUgdG8g
bGFjayBvZiBzZWVkDQo+ID4+ICBCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxlZCBmcm9tIGlu
dmFsaWQgY29udGV4dCBhdA0KPiA+PiBtbS9wYWdlX2FsbG9jLmM6NTE1MQ0KPiA+DQo+ID4gVGhh
bmtzIGZvciB0aGUgcmVwb3J0LiBEZWZpbml0ZWx5IGEgYnVnLCBHRlBfS0VSTkVMX0FDQ09VTlQg
YWxsb3dzIGZvcg0KPiA+IHRoZSBwYWdlIGFsbG9jYXRvciB0byBzbGVlcC4gSSdsbCBkcm9wIHRo
ZSBwYXRjaCBmcm9tIHRoZSBhcm02NA0KPiA+IGZvci1uZXh0L2ZpeGVzIGJyYW5jaCBmb3Igbm93
IGFuZCBzb3J0IGl0IG91dCBsYXRlci4NCj4gPg0KPiANCj4gU291bmRzIGxpa2Ugd2UgbmVlZCBh
IG11dGV4IHRoZW4uDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IA0KPiBEYXZpZCAvIGRoaWxkZW5i
DQoNCg==
