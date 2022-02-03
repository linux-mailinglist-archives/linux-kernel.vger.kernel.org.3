Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7724A7E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349175AbiBCDLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:11:32 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:50226 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234912AbiBCDLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:11:31 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2C3554013E;
        Thu,  3 Feb 2022 03:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643857891; bh=wHxyspwI4CSTtD29KGT9EBL88PkyOzShGKx7vUcm7N0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZRWe6/0Q95RuPnV7YWwhJTXttPANz9GVjdkTIDkPMix1qFWUtF/5j3UQEOC1NStqG
         K2Xafczcy/mFbGosg71UNL7NPBbkdwGQrM4hFZGJaVJ7VFqrTD2oDG4ddROffrgceL
         OMdtjJX44YIWAv8+d6dDN9Xm/jS/fE69DQkorHHlCxx0NAxDOpHYOZgqvL+hl/X4QP
         FCFMft76Qk36aYUaAAwmEZi4ZOkDbqN740trQWyIscNsO7B1kVq7PissnW8nenSiKO
         CVzExZIcxc+ZnvRM6zChwlnCsZPjTZxjCvGhZhQnqMVKk6kgljjBxnB+FElar3YyvL
         aziqO5qsyzRug==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D67E9A0068;
        Thu,  3 Feb 2022 03:11:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EBAF7400AD;
        Thu,  3 Feb 2022 03:11:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="vkIwBgB/";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoWydkJbsj4O+/PBwggcYF+49wVZEJaIASH7EvvkYCTo7Y51Yqv2R3lCIa9jXi1BA7FxDn6BonMOKmef8JJtl3ghnhGcs842E5ntIoL8IK/DvneLCq0j2MBk0eOUe/GncfdqiX6DlcQmi7yR27aNlXvZTCBy7d6Agxymiktk9xUGGp2BbkxN6QL72CE2RnHwMZ/aMNQm1sV2cAl3gpYO+S2fIyzsNu1NdrnJqowv9Y9HKL7y4ZK5+G26mGZQ8ZKuS7JXzIGOaRNivaK250nicBoIauMwNKkPXHifVEMJD3EWXeGmcfe/aWPgHOBZh85Mgj1XZwv08iYXgujrwvE9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHxyspwI4CSTtD29KGT9EBL88PkyOzShGKx7vUcm7N0=;
 b=eJkGXcl8vf1HdlHaB8ukYlhJZtyrbcSY8VlS/3barLb2ZYqE6ePagdLCH4qmC2XSwtEPCvGz5aZ7cevARjsR/Fm0Q7dMe/+xwMemP7tQvU1W6qSTsxjqD7wXFHKmWwcRSspSMffPbUv972uwzMt87xrYvkam3dY6GGProtsiBicJOjmQH6ZbYYHJ3JrYAMa5pbvUKFommGplFpVQZhvU7ZikIJ3T3rGLdtuUFUATCnJbRREtt+oQk1pYKHG+vnz5eyBsp7qUdSaD5J8Vavz2liXZVwNFGn3KH1sOgT0OLnA03WuM7flq+mY8VjFOX18W5dtCbYhozhIL2Al2IoESQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHxyspwI4CSTtD29KGT9EBL88PkyOzShGKx7vUcm7N0=;
 b=vkIwBgB/wDX9n0DCmmfOGQU2IjYJatb4NUYHC0fxxVBSwy6N26wiU//75cUJKgVsw0TlmaLjU+n3fvFQB8fqVSxG8F+8/LP2KBnUGww8381unO9qhvPvfsIMI7prLcEM+hdU9TpDy6LKZAAyn2VzxWgUOFbUe4X/bO4g47so4QU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 03:11:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 03:11:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>
Subject: Re: [PATCH v3 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
Thread-Topic: [PATCH v3 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
Thread-Index: AQHYE7lzRHLH1x/0rkWz9NRo9ztUMKyBL/0A
Date:   Thu, 3 Feb 2022 03:11:22 +0000
Message-ID: <af1d373b-1701-4572-da60-cbafe7876543@synopsys.com>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
 <20220127200636.1456175-6-sean.anderson@seco.com>
In-Reply-To: <20220127200636.1456175-6-sean.anderson@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec74ab5d-7337-4807-5297-08d9e6c2db54
x-ms-traffictypediagnostic: CH0PR12MB5137:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5137D1DF239D81A5369C8101AA289@CH0PR12MB5137.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PxOjo3x4cLY2/C2YALu/kH7kwg7b6c3NkXvpogFMAoiFbk3bSG3KMmPzOZsBw2IXASq00IWZMgWJ9WlUcy+FMot3ugor/EY+sjhK+W5NVw1k3ApiV9M14+nx20kvOLE80v2bmDvgI2ItfENaIAvU6kAGplRGHmvolEqZnmhlU4R+eks+EygqjzBJ0VUP6m+9DDDnWQwnSzQyfHWCKko7lT3Aze5fMgBvtr+HwBQxIy8tu6Fdp92B4j7bEq+cS2mL0u0GCj6OSqfc3IzcdvJCfLKEFfPB7NfVstb+crh+bq2Y+s7fys2fGDn2IwgGQ8+51/iEOADbYdg+1rVkSz+7IXK5sTA0ezLKAcvaLgo7iBzqRyQXh+AlPaNUnYS+lemXcRHI8F09gN39AUgtFdhcjIT4NTnWOIVxvnT7KDRm8N8Fge/nE6GiE2je+WjkoGNyn9oMR5h4RuhOT1InHu5HihERdmkLgtdPWbFrO0HVHQtcE2mFYB7iZz5cuLEXs7s46Oj22Mxw7cYUrwGuBubjCGKF/3cO2arK0WFnkSD4cqLnNVupyF8d0PaBZHMo2iehmd3vbrtoGkfIaAEbkj3yBnTvfqpyxol7j1yjKpwMKiyGFUfw+JgRwzaLaPFa9Qo13BY2C1HOkxz/FUnJBv2h4rr52TWGicAI8loltJhL0CW73CbutSfVSlCPtjW4My7RdiLHGaaccXI40FPsBNtL6R6ACT8ksWGB7QltK0HJ/mUNo0p2BDll0+fgOiIRaDjHVNhBJMEAoHw2LQnPELA6Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(26005)(186003)(71200400001)(31696002)(2616005)(6506007)(86362001)(6512007)(122000001)(38100700002)(83380400001)(38070700005)(316002)(31686004)(54906003)(36756003)(110136005)(5660300002)(8936002)(64756008)(66946007)(4326008)(8676002)(66446008)(66556008)(66476007)(76116006)(508600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEVDdWZQQ2dSc0lSWGdOaDhSbzdray9yY2lsMTFtbE5KWlk4TVdzSVB2eDBK?=
 =?utf-8?B?dEo0UDgzMWZrNGhsb0NDRWkrd1kvc1FwSHlTZCs1a0pCeFZ1YUY2WS9HcVhO?=
 =?utf-8?B?cGlQdFk0S1B6TlR5UjRKOVBvV3pLNDZXL0lJc3FEa3VIOFR3WWRqWkt0S2FJ?=
 =?utf-8?B?bFEyaEQ0dDlHVW42RWlSMFBWVGlyaFRkVVkwNFNlb2VXWDh3M090ZEpMQUZ3?=
 =?utf-8?B?RnVmc01pYlU1YXB2WTdCSG03ZVlYa09zaWJTWmh1TkdUY0RnamhTVnhSUExt?=
 =?utf-8?B?RE1SYW8xeEs0d2MvVk5KOWcrRG1wS1JRNlF0YWhrU1E3K2pTSFV2dUhKd2NM?=
 =?utf-8?B?Y3VMdnJwS2RFL0tXUFVvU1UvZmEzZUU0YjJFUm4zTHoxaHBBS2lwN0pjV0No?=
 =?utf-8?B?d0tYbzhia3hMUEptcnVLWUVKNjNObzZqZ0dQbkVBRExXbjR6Wmk5SElVV1k5?=
 =?utf-8?B?WUJLc2c2alkrNFV2bjhma1pFTDJtT2Z2WmJlNDBFOXc3aHR1TVBzcHU3U3ZM?=
 =?utf-8?B?cU9QbnJST0RzVWNKemt6YStNQUJzWlNhYnNORTYwNjhtRlNraVNGbFAxTDR3?=
 =?utf-8?B?R1J6eStvUXJlMWdEQWVEeThudjBpamhkb0F3d0tSb21sT2FFQkdqR01TRGtp?=
 =?utf-8?B?NUVZRHFFN2J2KzdJQktMSjJ4VExtRzJoS2JoOHhDVk1reFU5M1NKZktsbzUy?=
 =?utf-8?B?RHd4c3lTTGdvYldrTHZxSFRaMHRZMFFEU0tFVWgrU1lWaFoxOUNDZVltVWth?=
 =?utf-8?B?V0lkVTF0c1JVd1FhUnRIbmRoQUxxWFhGd1NCaEpmVlljOFhSenBzMEdOeGRY?=
 =?utf-8?B?K1NCZ3ZNVnM4c2lRVkxmSTAzdFpCV1ZVMVpTNW9OUWN2c2VWUW5FODA3SnRU?=
 =?utf-8?B?bWR3V3dPQkpKYnRGVUwzYjQ2bUd1YWZGcXVibDR4NmlxbXo2YU1sa0Zuc0w1?=
 =?utf-8?B?ejNZRzA1eGJ6V0V0ZExPT0FvM3NjYS9IL3Fydnk1OE9vQmhlSjZNb09PWGRY?=
 =?utf-8?B?c1JIMS8wbjRWVmUyeXQ1V1F3S3ZndHpiQk5FUHlJZ1FSbFNQM2RQNkwxRmJ1?=
 =?utf-8?B?NnAzRGhnSmNUR2tHQWhja3kxckIzdXErRHRzWGhqNUVCTlpjc1lTVTdXRWVI?=
 =?utf-8?B?aVA1cll4MFdydFlweCtBdTRqay9YNWR1KzdFN3BEUm83RytDZ3VtVnQ4eG9w?=
 =?utf-8?B?aHNyWU43OUQ4VmhFYTh4QWFqWlR6ajRVekJCTk0rdWk2Y3QvRHhJaXQ2N2p3?=
 =?utf-8?B?SzEwd1ZsR2RRMDlpQit3NzJENFIwaG9aM0RZbVd4UFJac3JDVEc0ZyttSytq?=
 =?utf-8?B?dDFUY3hDNTRNWUJIY2hXMS9DK2lrdStCSDNyMzVRRlhwU1NsL0JQT05hTXYz?=
 =?utf-8?B?NVI5N0RkNTBYVWVvT2N5UGlSU3BWR3RENXJZeWN3Wnozck8reUpZOHV0N3dm?=
 =?utf-8?B?aEliTzFQWkhqQ3liYzZOQ0U0MGhteEE3Q3JpeFFMQWU3S1MydWxHVDQ0aWlW?=
 =?utf-8?B?WGhyRnc1aVhqTDJQTWh5RWs3d1dac2tVM014Z0N3Qmg0SjVLOXlTby94T1RR?=
 =?utf-8?B?b0VZcnpmSkFVczIxa2JRZHp5RHBheEZ0VzY2aUNjcE84eTR4eXhiNjBlRHpm?=
 =?utf-8?B?bjluSUptQmNseFZyREF3alNzQTkxdFFKcTlmTHZIdTJoZFJKUFJORmF0aHZQ?=
 =?utf-8?B?ZWphRE1zb3RwUEVLSDhYcGMxZEcrOVB4dXdyMDMwRC92SDJBNG40b1Qzb3l5?=
 =?utf-8?B?SFM4aDJOTm13ODl5RG5WWDJNNlVPNldnem9HN2ZhaHhveS91WVhjUmpTSm9m?=
 =?utf-8?B?ZXNnR1U1YWJPR3ZNV3hDYWFqcXhwdDhEWW5IY2JPK1F6SjNPUjZJK254QWFp?=
 =?utf-8?B?Umh6MEVMc244MGVILzZOTElHK1hiUHFpTlFnUjNXZ3hEbFF1UDFqdDJkWVlv?=
 =?utf-8?B?WTM3b0lldTFMNkZuQmdpeC9IbTNwalg3bVBIT0tCQmhZT2dpTm1uZHowRkVN?=
 =?utf-8?B?U1F2TjVpZXdlM2dFR08rSTZZMWhCREVtWGtWbS95TlJ2ZUNPMllIQTZpM0J2?=
 =?utf-8?B?Y3B3cGFFTHpUOHFzeGtkY2x6K3Z5dVVETi9VZHZYUCtTSlhnSU9acURVODFQ?=
 =?utf-8?B?MHhMemtRNkVOd2tSSE5QTWZpbXp1Ty9FeWJmSmZ0VlVYcE9ac2k1V2dvRjBF?=
 =?utf-8?Q?qRWrJGvG3IXN1B8MnnhCPUI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A05F65AED64BE347B22FA7CBAF65C16C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec74ab5d-7337-4807-5297-08d9e6c2db54
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 03:11:22.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzL8ttLyAQhHSQz52N5bv0fD6Wp83E686tMgP2Shk8daIOy0NmmKIOx++r77ArMnZNzQpaiGtZoxUKfnFIgWyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gVGhpcyBwcm9wZXJ0eSBhbGxvd3Mgc2V0dGluZyB0aGUg
cmVmZXJlbmNlIGNsb2NrIGZyZXF1ZW5jeSBwcm9wZXJseSBmb3INCj4gQUNQSS1iYXNlZCBzeXN0
ZW1zLiBJdCBpcyBub3QgZG9jdW1lbnRlZCB1bmRlciBkdC1iaW5kaW5ncywgc2luY2UgaXQgaXMN
Cj4gbm90IGludGVuZGVkIGZvciB1c2Ugb24gRFQtYmFzZWQgc3lzdGVtcy4gRFQtYmFzZWQgc3lz
dGVtcyBzaG91bGQgdXNlDQo+IHRoZSBjbG9ja3MgcHJvcGVydHkgaW5zdGVhZC4NCj4gDQo+IEZy
ZXF1ZW5jeSBpcyBwcmVmZXJyZWQgb3ZlciBwZXJpb2Qgc2luY2UgaXQgaGFzIGdyZWF0ZXIgcHJl
Y2lzaW9uIHdoZW4NCj4gdXNlZCBpbiBjYWxjdWxhdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQHNlY28uY29tPg0KPiAtLS0NCj4gDQo+IChu
byBjaGFuZ2VzIHNpbmNlIHYyKQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBOZXcNCj4gDQo+
ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDYgKysrKy0tDQo+ICBkcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuaCB8IDQgKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCAxOGFkZGRmYmEzZGEuLmMxYjA0NTEy
MTY3MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTM1Myw4ICszNTMsOCBAQCBzdGF0aWMgdm9pZCBk
d2MzX3JlZl9jbGtfcGVyaW9kKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJdW5zaWduZWQgbG9uZyBy
YXRlOw0KPiAgCXUzMiByZWc7DQo+ICANCj4gLQlpZiAoZHdjLT5yZWZfY2xrKSB7DQo+IC0JCXJh
dGUgPSBjbGtfZ2V0X3JhdGUoZHdjLT5yZWZfY2xrKTsNCj4gKwlpZiAoZHdjLT5yZWZfY2xrIHx8
IGR3Yy0+cmVmX2Nsa19mcmVxKSB7DQo+ICsJCXJhdGUgPSBjbGtfZ2V0X3JhdGUoZHdjLT5yZWZf
Y2xrKSA/OiBkd2MtPnJlZl9jbGtfZnJlcTsNCj4gIAkJaWYgKCFyYXRlKQ0KPiAgCQkJcmV0dXJu
Ow0KPiAgCQlwZXJpb2QgPSBOU0VDX1BFUl9TRUMgLyByYXRlOw0KPiBAQCAtMTQ5Nyw2ICsxNDk3
LDggQEAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0K
PiAgCQkJCSAmZHdjLT5mbGFkaik7DQo+ICAJZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwg
InNucHMscmVmLWNsb2NrLXBlcmlvZC1ucyIsDQo+ICAJCQkJICZkd2MtPnJlZl9jbGtfcGVyKTsN
Cj4gKwlkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAic25wcyxyZWYtY2xvY2stZnJlcXVl
bmN5LWh6IiwNCj4gKwkJCQkgJmR3Yy0+cmVmX2Nsa19mcmVxKTsNCj4gIA0KPiAgCWR3Yy0+ZGlz
X21ldGFzdGFiaWxpdHlfcXVpcmsgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwNCj4g
IAkJCQkic25wcyxkaXNfbWV0YXN0YWJpbGl0eV9xdWlyayIpOw0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBl
YjljMWVmY2VkMDUuLjAwYTc5MjQ1OWZlYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTk4OCw3ICs5
ODgsOCBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsNCj4gICAqIEByZWdzOiBiYXNl
IGFkZHJlc3MgZm9yIG91ciByZWdpc3RlcnMNCj4gICAqIEByZWdzX3NpemU6IGFkZHJlc3Mgc3Bh
Y2Ugc2l6ZQ0KPiAgICogQGZsYWRqOiBmcmFtZSBsZW5ndGggYWRqdXN0bWVudA0KPiAtICogQHJl
Zl9jbGtfcGVyOiByZWZlcmVuY2UgY2xvY2sgcGVyaW9kIGNvbmZpZ3VyYXRpb24NCj4gKyAqIEBy
ZWZfY2xrX3BlcjogcmVmZXJlbmNlIGNsb2NrIHBlcmlvZDsgZGVwcmVjYXRlZCBpbiBmYXZvciBv
ZiBAcmVmX2Nsa19mcmVxDQo+ICsgKiBAcmVmX2Nsa19mcmVxOiByZWZlcmVuY2UgY2xvY2sgZnJl
cXVlbmN5IHRvIHVzZSBpZiBAcmVmX2NsayBpcyBtaXNzaW5nDQo+ICAgKiBAaXJxX2dhZGdldDog
cGVyaXBoZXJhbCBjb250cm9sbGVyJ3MgSVJRIG51bWJlcg0KPiAgICogQG90Z19pcnE6IElSUSBu
dW1iZXIgZm9yIE9URyBJUlFzDQo+ICAgKiBAY3VycmVudF9vdGdfcm9sZTogY3VycmVudCByb2xl
IG9mIG9wZXJhdGlvbiB3aGlsZSB1c2luZyB0aGUgT1RHIGJsb2NrDQo+IEBAIC0xMTcxLDYgKzEx
NzIsNyBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICANCj4gIAl1MzIJCQlmbGFkajsNCj4gIAl1MzIJCQly
ZWZfY2xrX3BlcjsNCj4gKwl1MzIJCQlyZWZfY2xrX2ZyZXE7DQo+ICAJdTMyCQkJaXJxX2dhZGdl
dDsNCj4gIAl1MzIJCQlvdGdfaXJxOw0KPiAgCXUzMgkJCWN1cnJlbnRfb3RnX3JvbGU7DQoNClJl
dmlld2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRo
YW5rcywNClRoaW5oDQo=
