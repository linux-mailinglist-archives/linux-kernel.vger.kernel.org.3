Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948F349A878
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318943AbiAYDHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:07:31 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39052 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S3417838AbiAYCLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:11:43 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AA979C08EB;
        Tue, 25 Jan 2022 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643076694; bh=gqt/T234sCOILUz/DJVsTVJupsjrQoNzlqlXGR6YQi0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=O8OCnc2aHgpS8ZGrCcPYa0zEhHZx/rLVnkgmT4os77fMiJAzfWAoGENA+d7wE/Ket
         RIqpkbxjj6wruk5U1WpZnL/LLt0/dOEEy4fiG/6q32AGU1wgLCW5UD0qVsbZIqZver
         S964sqSDo9YT2gZbxXU4PSxacszQTKlbTyT6zSXo6ULU+EFUYPmwzT/8KEFagJvZOI
         njPmnugfMa1tRat4Qv33Ahn4oEvmBYDs+ZtGJQYijs/54V9m5SUkOtkxnypcpBR83a
         5KggD+ojj4eJOWJkmqljv5XZAl52myIlDAMNyGia5QqOXEhplFxsYIacW7hVgwWfFV
         aejbrWTZM3mGw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 96016A0070;
        Tue, 25 Jan 2022 02:11:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D1AED80071;
        Tue, 25 Jan 2022 02:11:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="UdjcVWUX";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0/Tlk1GMrYxds/Gm9aFJ8ARBKjW+HlLn/w90u2XMZn4MZZ3NdserA16t0Y21+r+z4j2TFOsBBu9V1WVSIm6hKlDFaVxjazUOXpdEBLNOk/n583AZ71UepZ9m/nI6EaaOHtVq2zyAIoizdtt3g5Mowh0vwP9Oc+xHPApeXnYDFrFHIC0nBJYrtan7Pk8zcw9vjQRaLWUAlpkA/ETDX4VmfJEinHHQDwXC+InIsYeuQZaZvq9sj519+9jBZZSI/beQ3QQbUBiBTjgpb4CYQA3/esBZK+49cLozxLfp6cY29SqJwFTf/az7NrflHiZ/IvlBi1Qi6KdqIAvGAWdBiSGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqt/T234sCOILUz/DJVsTVJupsjrQoNzlqlXGR6YQi0=;
 b=D4g6LsTdEqVMueN8ngrBCMjJSh1sy8dtv0TtV9fmrVW+dCA0Y6Hu2BoTFERVRtyH6D7vf0oMuT81DZU5idmSv1+90Wl/onMghDAwrMpEf5ja1Wl77ja69YVtQgtdHL9Cty9Psoe8ocWNAs1E6lXIE/N9ZUM/hpxa/FyTKQlr3feFSCGCwHsa1VAVeTAYOnGS0yRzSPudwCisGS+uIRAOXRuSLW45oTucmVinQB3ITlLgBXR6Bf0jZKd3Iq+wivLgYlWdCJ/RqpME0hX6PixRktzeJjBJ7iskoS8YZtesn7StBrH9/dk5mr275FK9fxbZMlR1qcIzjKVudszjt3kK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqt/T234sCOILUz/DJVsTVJupsjrQoNzlqlXGR6YQi0=;
 b=UdjcVWUXvJpXBf7zLKVEieKl1GNHi07tkCA60V11hjoLH0jxLcPBeci+gpy6wzI9+TpqzkiOF0ra0kwSYSNpqDPWnV83txpNHvcJrELX5sY5IBwYYiQyPixtuSGA8mvdTLpBOxPqKWsgYAvSeM+06FR2jq2ulqEfjXxDJNbLKII=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 02:11:23 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 02:11:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Thread-Topic: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Thread-Index: AQHYDMsCIy0SvjCLEk29RiHsv2qI76xyzwGAgAAFUACAADPKAA==
Date:   Tue, 25 Jan 2022 02:11:23 +0000
Message-ID: <3ca6fb9e-94cf-6483-26a6-ae2682d1f55e@synopsys.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-5-sean.anderson@seco.com>
 <4696c5a4-5921-f7cb-196c-5ad956e696f9@synopsys.com>
 <f528aeb5-6155-a75e-9d35-9bf473e0bbc7@seco.com>
In-Reply-To: <f528aeb5-6155-a75e-9d35-9bf473e0bbc7@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e504078f-2c32-4a2f-0363-08d9dfa7fc5c
x-ms-traffictypediagnostic: SA0PR12MB4560:EE_
x-microsoft-antispam-prvs: <SA0PR12MB4560C6D4B046D9A0A98E9B43AA5F9@SA0PR12MB4560.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOhRSAujs1ciO05VX/yj6MQEIDjLjl1Amh8gb++XuuyyX0zUjXvK9kktZI7CxgD1EUvvOJvht+YYkZCZCuX9OavxYN8AheVTOnAg7B5az0J0KIUlpZKzVp8TAuBZA+gzxJrWPfQ9AaVqbv/HAVlf3cPbYW2z0yS3DgRiE+JyF/mrwLZbWSaCbbFuGd48+w5eUI+eQjwjH0tEVVe8kIgATdS5sI5oMCWsPdd3wKUC0G28PVFjqHgvkinhmrn/QHNWSyU51H3yFvYbB7BSWjXZlTDFjMC0TSWtWo7PfOHSzV9j1Uw4U2FfocNeqRvt9HLgn7XOkJWayAFD8g0J8MnSfe4mse80/8ED+hmECQE2chAmRXTI4B82eaTLGte4fjaRQzEYdmbbEUjjZvDKiCb1FDlTexNekaBvjYEg9/8wIilHtMN1Q+PSXzRfMvLbPhhJq1CpYWNsnIhTWz1BPRbPPWc/p2NYwGaoIr2Xyh+BoE+bZr777h+cCWB66pF0coTAKTvv78z0lLDSv8Zs8gzBN4cmaVBAT2bP26pWzsOOqAyqKzGbeqyrhOhyKafU6hZ5pwKw9btIEI7Y7XSKrqfFdpBG2Se50BOLHRYzeO1h1ArwUNb5NaM/MGcLE7tgGIly72sbXqrzpA2SsAF4D/LdvI0kOIG60fjE4XvTt33GjbziWZRO+58ky3+OnkVlR5dig8Vs41ovtmR5bpLSBLR4GWO+smvVVKRk7cnDdiDreKf6gyvg23GqlQrYrAzawcbJPSK78D/LczIj62693xuDSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(38100700002)(8936002)(316002)(8676002)(86362001)(53546011)(508600001)(36756003)(186003)(26005)(122000001)(66446008)(54906003)(5660300002)(6506007)(31686004)(2616005)(6486002)(66476007)(83380400001)(64756008)(2906002)(38070700005)(31696002)(66556008)(66946007)(4326008)(6512007)(76116006)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blI5RUFBbjNYOEdma0d3TlNhd3V1TmpsWFJtWDhnZGRwcUxQSExtUi9vaU03?=
 =?utf-8?B?N3k0Z0Z2akgrdmZHS3RSMm5OUTUyU2hDS09HaVdmRmttdm50QU9sU2hhc08v?=
 =?utf-8?B?dzhvMGhVOGpEMnJhWStSdWVIeFVra2tvdmpqZGlPNWdvVEp5NWJnaHBNajdm?=
 =?utf-8?B?RVJieHBRQ2IzU2RGRmpvT3l5SjhyZnloME9Kb1hrQTdEUFRBdk9mbWVLdE5x?=
 =?utf-8?B?dHZGcDlMMW9DN01jd0tyNndUUm9UNVNmaE5IaERxSytIT0VLS3VEZEhWWHFT?=
 =?utf-8?B?ZktFMGhIWmF2bFRPbWVCbTlUV2x5dFhSZlZPbjdxZ1NuZzhoSExPNFV5ZWJu?=
 =?utf-8?B?aXAyMEhKdWlSQ3RDTThoYWE3MkdlOHIyOWtvYkhPbkJjQTc4VWVKdS9kZnJ5?=
 =?utf-8?B?QkdwQ1VsWDZWRlV6NmU5Njc0SGw3WVBKMkxyRXV2QjBpWlhIWDI0a044MXQx?=
 =?utf-8?B?djVZVW1ndTAzbWNSUmg0SkFEa1BNaldIYmIrNSs5VTQ1RTVTYm9IUHdCWlNj?=
 =?utf-8?B?UGtRY3paNVc4ajdqcGNuVFNNNm9BSDFBNklRazVERDZVTytDdkNtNm9NZW0z?=
 =?utf-8?B?T0RCdVAwQVdJVkFORndHYks3MTVSemhuUlcrOE52dUVTOUhEWU9GTUJSMXZM?=
 =?utf-8?B?ZW5FREpiQXBFcnFxYTlTWml5b1pOUmh1SGcwa0swZGVVUGZXbDdCNTUxS0hJ?=
 =?utf-8?B?RDF5K3RxM0hDbDNSV3J6WnpWL1k2SEp2V2V3OUlkRy8wamthSFRxdkw2SkFM?=
 =?utf-8?B?ZGV0bmdKNHpVTFFiVjJTdU5wUkdMVjZVaTJmUS96UnFOeUs5RDg1cmREcVpr?=
 =?utf-8?B?YWsyQnVjUitGVHJ4Q1lJT1k1Z2cvc0tzS2YwaStSSkZYb3pJU0JmekR0cUVB?=
 =?utf-8?B?UnhzRzRJQ2kwZzF5TlVORndlWjF6S2ZrS0xKNU00djY2d0F5RS9vYldOeTFn?=
 =?utf-8?B?K2Z6RnphQUlIbmVJNG9IMG1aaTN4M2Z4MDY2QzhoMUZ1Ri9UTHQ2MHd0MXNj?=
 =?utf-8?B?VnNWWERVZ28zK2d0OHZpbXFuczZyWjJNbjI2UkpLWlhBN2J5UGVvdlhBcSts?=
 =?utf-8?B?cGNld0hDQjhiM1FXYnp3dXM4WWJrWGJrREU4T0lTYXF0eStndzl2MHlVWjhS?=
 =?utf-8?B?RzMwb0luRVhBYSt0YnRUYjNzT0J4R1hNS3VxUWErOVNwZStmZis0RjZGdzh5?=
 =?utf-8?B?dkJ6Nnhrc2RiRjd2YWk3bWxWUWJpWmExR05mY0wzNUNGcThXNVFGWVIxQUVW?=
 =?utf-8?B?dHh3ZFY4K21ONXFVREJyK1NXY09XNUxxb3ptUG9VYTdDZWQrNXN1MjRWRDA0?=
 =?utf-8?B?dUcySFNRNDd4azZENU5EM1JrNG1rMTU1Mlp5UC9yd211ZEdEeEFiYy83MVQ3?=
 =?utf-8?B?c1J4QThSeE1qZk1kRkxvVWptd2NaYUM2U3p5VG9zS28ydzJURExDQ0ZWOW1w?=
 =?utf-8?B?dHZuTTlwSGN2cGo4RE1yNjNhU3JDOFg0SGRNU3hrcHY1U0R3Mm5GZzVFQ2s5?=
 =?utf-8?B?MitlRTFGZXVnSEhUeEZwT2FWbDZ2aFd6YjdwYlZ5ZGRKOVRySm5FTmNockNE?=
 =?utf-8?B?NnNMZ2hqTU1xREp3ZWgrUU9hWnlDbWN4RTVXSUpwWFl0Mkk3WVIyUWVXVk82?=
 =?utf-8?B?dnBKR0RvRjVpZVZvanZIQ1hTUkNVNnkweWZRWWx1a2JobHBpcldCVTNNUTBK?=
 =?utf-8?B?WDVKcEYza2oxWlhuZjFDd1Z0dzhTY01CSHMreEtYNi9venRVWXJVL0pMMXVi?=
 =?utf-8?B?a2FIV3JtaHhjMlY3TGtERkFrVFkwaEg2UkV4MUpCUWV2UjBjbVFiS3E1YjVN?=
 =?utf-8?B?WHRiYjZaMXQzdjZHUmc1UEZMRjFUNjRkRzZ2b25DNDBBQzJPdDBWS2tuUHJu?=
 =?utf-8?B?NVdqaUNsS2NvZ0tDbjhVNDgxbW9DcHdIM1Y0cVh2Wm1hR0NyTlIyV291Y2NS?=
 =?utf-8?B?RU83eVNkbmMxNXVtYU1scUU0WVF5Qmp5ZGpNK3pBeENmZTJ3TWpKU1VIVDhX?=
 =?utf-8?B?NllsSW9sSU1WOGt4NC84bWlKTnIraDg1Mi9qZlNUYklOdEpZTDZrd2drMlFC?=
 =?utf-8?B?NzRlSXgreFhpcUxDcnVwN29NSmFjVlYrV05ZNjJWbHdCMk96dkpoYmI3RW1a?=
 =?utf-8?B?aEFaQ3NRZ0lVMHhXNzZ0bDNTMHd6c2ZMTUlVSWRORHA5cUYyUDZwSk1BOG9V?=
 =?utf-8?Q?+4P/b0N0YUW6zNT51pl3xOs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4347504DD6777348807F0BD3D0D2553D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e504078f-2c32-4a2f-0363-08d9dfa7fc5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 02:11:23.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oaXXMvkeO2KKkb/GzWeFeD2scIPGbaacHD4/iUoeiG9ZQlvhTRpdcrVYQiBnbOUTQ7szKWNo+q3cC+DD8hN6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gDQo+IA0KPiBPbiAxLzI0LzIyIDU6NDYgUE0sIFRoaW5o
IE5ndXllbiB3cm90ZToNCj4+IFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+Pj4gR1VDVEwuUkVGQ0xL
UEVSIGNhbiBvbmx5IGFjY291bnQgZm9yIGNsb2NrIGZyZXF1ZW5jaWVzIHdpdGggaW50ZWdlcg0K
Pj4+IHBlcmlvZHMuIFRvIGFkZHJlc3MgdGhpcywgcHJvZ3JhbSBSRUZDTEtfRkxBREogd2l0aCB0
aGUgcmVsYXRpdmUgZXJyb3INCj4+PiBjYXVzZWQgYnkgcGVyaW9kIHRydW5jYXRpb24uIFRoZSBm
b3JtdWxhIGdpdmVuIGluIHRoZSByZWdpc3RlciByZWZlcmVuY2UNCj4+PiBoYXMgYmVlbiByZWFy
cmFuZ2VkIHRvIGFsbG93IGNhbGN1bGF0aW9uIGJhc2VkIG9uIHJhdGUgKGluc3RlYWQgb2YNCj4+
PiBwZXJpb2QpLCBhbmQgdG8gYWxsb3cgZm9yIGZpeGVkLXBvaW50IGFyaXRobWV0aWMuDQo+Pj4N
Cj4+PiBBZGRpdGlvbmFsbHksIGNhbGN1bGF0ZSBhIHZhbHVlIGZvciAyNDBNSFpERUNSLiBUaGlz
IGNvbmZpZ3VyZXMgYQ0KPj4+IHNpbXVsYXRlZCAyNDBNaHogY2xvY2sgdXNpbmcgYSBjb3VudGVy
IHdpdGggb25lIGZyYWN0aW9uYWwgYml0IChQTFMxKS4NCj4+Pg0KPj4+IFRoaXMgcmVnaXN0ZXIg
aXMgcHJvZ3JhbW1lZCBvbmx5IGZvciB2ZXJzaW9ucyA+PSAyLjUwYSwgc2luY2UgdGhpcyBpcw0K
Pj4+IHRoZSBjaGVjayBhbHNvIHVzZWQgYnkgY29tbWl0IGRiMmJlNGU5ZTMwYyAoInVzYjogZHdj
MzogQWRkIGZyYW1lIGxlbmd0aA0KPj4+IGFkanVzdG1lbnQgcXVpcmsiKS4NCj4+Pg0KPj4+IFNp
Z25lZC1vZmYtYnk6IFNlYW4gQW5kZXJzb24gPHNlYW4uYW5kZXJzb25Ac2Vjby5jb20+DQo+Pj4g
LS0tDQo+Pj4NCj4+PiBDaGFuZ2VzIGluIHYyOg0KPj4+IC0gQWxzbyBwcm9ncmFtIEdGTEFESi4y
NDBNSFpERUNSDQo+Pj4gLSBEb24ndCBwcm9ncmFtIEdGTEFESiBpZiB0aGUgdmVyc2lvbiBpcyA8
IDIuNTBhDQo+Pj4NCj4+PiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAzNyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5o
IHwgIDMgKysrDQo+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+Pj4gaW5kZXggNTIxNGRhY2VkYTg2Li44ODNlMTE5
Mzc3ZjAgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4+PiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPj4+IEBAIC0zNDgsNyArMzQ4LDcgQEAgc3RhdGlj
IHZvaWQgZHdjM19mcmFtZV9sZW5ndGhfYWRqdXN0bWVudChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4+
ICBzdGF0aWMgdm9pZCBkd2MzX3JlZl9jbGtfcGVyaW9kKHN0cnVjdCBkd2MzICpkd2MpDQo+Pj4g
IHsNCj4+PiAgCXUzMiByZWc7DQo+Pj4gLQl1bnNpZ25lZCBsb25nIHJhdGUsIHBlcmlvZDsNCj4+
PiArCXVuc2lnbmVkIGxvbmcgZGVjciwgZmxhZGosIHJhdGUsIHBlcmlvZDsNCj4+DQo+PiBNaW5v
ciBzdHlsZSBuaXQ6IEZlbGlwZSBwcmVmZXJzIHRvIGtlZXAgdGhlIGRlY2xhcmF0aW9uIG9uIHNl
cGFyYXRlDQo+PiBsaW5lcywgbGV0J3Mga2VlcCBpdCBjb25zaXN0ZW50IHdpdGggdGhlIHJlc3Qg
aW4gdGhpcyBkcml2ZXIuDQo+IA0KPiBTbyANCj4gDQo+IHVuc2lnbmVkIGludCBkZWNyOw0KPiB1
bnNpZ25lZCBpbnQgZmxhZGo7DQo+IHVuc2lnbmVkIGludCByYXRlOw0KPiB1bnNpZ25lZCBpbnQg
cGVyaW9kOw0KPiANCj4gPw0KPiANCj4gRnJhbmtseSB0aGF0IHNlZW1zIHJhdGhlciB2ZXJib3Nl
Lg0KDQpBIGNvdXBsZSBvZiB0aGUgYmVuZWZpdHMgb2YgaGF2aW5nIGl0IGxpa2UgdGhpcyBpcyB0
byBoZWxwIHdpdGggdmlld2luZw0KZ2l0LWJsYW1lIGlmIHdlIGludHJvZHVjZSBuZXcgdmFyaWFi
bGVzIGFuZCBoZWxwIHdpdGggYmFja3BvcnRpbmcgZml4DQpwYXRjaCBhIGJpdCBzaW1wbGVyLiBN
YWlubHkgSSdtIGp1c3QgZm9sbG93aW5nIEZlbGlwZSdzIHN0eWxlIGFuZCBrZWVwDQppdCBjb25z
aXN0ZW50IGluIHRoaXMgZHJpdmVyLCBidXQgSSBkb24ndCB0aGluayBpdCdzIGEgYmlnIGRlYWwu
DQoNCj4gDQo+Pj4gIA0KPj4+ICAJaWYgKGR3Yy0+cmVmX2Nsaykgew0KPj4+ICAJCXJhdGUgPSBj
bGtfZ2V0X3JhdGUoZHdjLT5yZWZfY2xrKTsNCj4+PiBAQCAtMzU3LDYgKzM1Nyw3IEBAIHN0YXRp
YyB2b2lkIGR3YzNfcmVmX2Nsa19wZXJpb2Qoc3RydWN0IGR3YzMgKmR3YykNCj4+PiAgCQlwZXJp
b2QgPSBOU0VDX1BFUl9TRUMgLyByYXRlOw0KPj4+ICAJfSBlbHNlIGlmIChkd2MtPnJlZl9jbGtf
cGVyKSB7DQo+Pj4gIAkJcGVyaW9kID0gZHdjLT5yZWZfY2xrX3BlcjsNCj4+PiArCQlyYXRlID0g
TlNFQ19QRVJfU0VDIC8gcGVyaW9kOw0KPj4+ICAJfSBlbHNlIHsNCj4+PiAgCQlyZXR1cm47DQo+
Pj4gIAl9DQo+Pj4gQEAgLTM2NSw5ICszNjYsNDEgQEAgc3RhdGljIHZvaWQgZHdjM19yZWZfY2xr
X3BlcmlvZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4+ICAJcmVnICY9IH5EV0MzX0dVQ1RMX1JFRkNM
S1BFUl9NQVNLOw0KPj4+ICAJcmVnIHw9ICBGSUVMRF9QUkVQKERXQzNfR1VDVExfUkVGQ0xLUEVS
X01BU0ssIHBlcmlvZCk7DQo+Pj4gIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VDVEws
IHJlZyk7DQo+Pj4gKw0KPj4+ICsJaWYgKERXQzNfVkVSX0lTX1BSSU9SKERXQzMsIDI1MEEpKQ0K
Pj4+ICsJCXJldHVybjsNCj4+PiArDQo+Pj4gKwkvKg0KPj4+ICsJICogVGhlIGNhbGN1bGF0aW9u
IGJlbG93IGlzDQo+Pj4gKwkgKg0KPj4+ICsJICogMTI1MDAwICogKE5TRUNfUEVSX1NFQyAvIChy
YXRlICogcGVyaW9kKSAtIDEpDQo+Pj4gKwkgKg0KPj4+ICsJICogYnV0IHJlYXJyYW5nZWQgZm9y
IGZpeGVkLXBvaW50IGFyaXRobWV0aWMuDQo+Pj4gKwkgKg0KPj4+ICsJICogTm90ZSB0aGF0IHJh
dGUgKiBwZXJpb2Qgfj0gTlNFQ19QRVJfU0VDT05ELCBtaW51cyB0aGUgbnVtYmVyIG9mDQo+Pj4g
KwkgKiBuYW5vc2Vjb25kcyBvZiBlcnJvciBjYXVzZWQgYnkgdGhlIHRydW5jYXRpb24gd2hpY2gg
aGFwcGVuZWQgZHVyaW5nDQo+Pj4gKwkgKiB0aGUgZGl2aXNpb24gd2hlbiBjYWxjdWxhdGluZyBy
YXRlIG9yIHBlcmlvZCAod2hpY2hldmVyIG9uZSB3YXMNCj4+PiArCSAqIGRlcml2ZWQgZnJvbSB0
aGUgb3RoZXIpLiBXZSBmaXJzdCBjYWxjdWxhdGUgdGhlIHJlbGF0aXZlIGVycm9yLCB0aGVuDQo+
Pj4gKwkgKiBzY2FsZSBpdCB0byB1bml0cyBvZiAwLjA4JS4NCj4+PiArCSAqLw0KPj4+ICsJZmxh
ZGogPSBkaXY2NF91NjQoMTI1MDAwVUxMICogTlNFQ19QRVJfU0VDLCAodTY0KXJhdGUgKiBwZXJp
b2QpOw0KPj4NCj4+IENhbiB3ZSByZWFycmFuZ2UgdGhlIG1hdGggc28gd2UgZG9uJ3QgaGF2ZSB0
byBvcGVyYXRlIG9uIGRpZmZlcmVudCBkYXRhDQo+PiB0eXBlIGFuZCBkZWFsIHdpdGggY29udmVy
c2lvbi90cnVuY2F0aW9uPw0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgZGF0YSB0eXBl
cyB5b3UgYXJlIHJlZmVycmluZyB0by4NCj4gDQo+IFRoZSB0cnVuY2F0aW9uIGFib3ZlIChpbiB0
aGUgY2FsY3VsYWlvbiBmb3IgcmF0ZS9wZXJpb2QpIGlzIGludGVudGlvbmFsLA0KPiBzbyB3ZSBj
YW4gZGV0ZXJtaW5lIHRoZSBlcnJvciBpbnRyb2R1Y2VkIGJ5IHJlcHJlc2VudGluZyBwZXJpb2Qg
dXNpbmcNCj4gb25seSBucy4NCg0KSSB3YXMgd29uZGVyaW5nIGlmIHdlIHJlYXJyYW5nZSB0aGUg
bWF0aCBzbyB3ZSBkb24ndCBuZWVkIHRvIGNhc3QgYW5kDQp1c2UgNjQtYml0IGhlcmUsIGJ1dCB0
aGF0IG1heSBub3QgYmUgcG9zc2libGUuIEp1c3QgY29tcHV0aW5nL3Jldmlld2luZw0KaW4gbXkg
aGVhZCB3aGlsZSBhY2NvdW50aW5nIGZvciB0cnVuY2F0aW9uIGZyb20gNjQtYml0IHRvIDMyLWJp
dCB2YWx1ZQ0KaXMgdGF4aW5nLg0KDQo+IA0KPj4+ICsJZmxhZGogLT0gMTI1MDAwOw0KPj4+ICsN
Cj4+PiArCS8qDQo+Pj4gKwkgKiBUaGUgZG9jdW1lbnRlZCAyNDBNSHogY29uc3RhbnQgaXMgc2Nh
bGVkIGJ5IDIgdG8gZ2V0IFBMUzEgYXMgd2VsbC4NCj4+PiArCSAqLw0KPj4+ICsJZGVjciA9IDQ4
MDAwMDAwMCAvIHJhdGU7DQo+Pj4gKw0KPj4+ICsJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3Ms
IERXQzNfR0ZMQURKKTsNCj4+PiArCXJlZyAmPSB+RFdDM19HRkxBREpfUkVGQ0xLX0ZMQURKX01B
U0sNCj4+PiArCSAgICAmICB+RFdDM19HRkxBREpfMjQwTUhaREVDUg0KPj4+ICsJICAgICYgIH5E
V0MzX0dGTEFESl8yNDBNSFpERUNSX1BMUzE7DQo+Pj4gKwlyZWcgfD0gRklFTERfUFJFUChEV0Mz
X0dGTEFESl9SRUZDTEtfRkxBREpfTUFTSywgZmxhZGopDQo+Pj4gKwkgICAgfCAgRklFTERfUFJF
UChEV0MzX0dGTEFESl8yNDBNSFpERUNSLCBkZWNyID4+IDEpDQo+Pj4gKwkgICAgfCAgRklFTERf
UFJFUChEV0MzX0dGTEFESl8yNDBNSFpERUNSX1BMUzEsIGRlY3IgJiAxKTsNCj4+DQo+PiBEb2Vz
IHRoaXMgcGFzcyBjaGVja3BhdGNoPw0KPiANCj4gWWVzLg0KPiANCj4gLS1TZWFuDQo+IA0KPj4+
ICsJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dGTEFESiwgcmVnKTsNCj4+PiAgfQ0KPj4+
ICANCj4+PiAtDQo+Pj4gIC8qKg0KPj4+ICAgKiBkd2MzX2ZyZWVfb25lX2V2ZW50X2J1ZmZlciAt
IEZyZWVzIG9uZSBldmVudCBidWZmZXINCj4+PiAgICogQGR3YzogUG9pbnRlciB0byBvdXIgY29u
dHJvbGxlciBjb250ZXh0IHN0cnVjdHVyZQ0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+Pj4gaW5kZXggNDVjZmE3ZDlm
MjdhLi5lYjljMWVmY2VkMDUgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmgNCj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPj4+IEBAIC0zODgsNiArMzg4
LDkgQEANCj4+PiAgLyogR2xvYmFsIEZyYW1lIExlbmd0aCBBZGp1c3RtZW50IFJlZ2lzdGVyICov
DQo+Pj4gICNkZWZpbmUgRFdDM19HRkxBREpfMzBNSFpfU0RCTkRfU0VMCQlCSVQoNykNCj4+PiAg
I2RlZmluZSBEV0MzX0dGTEFESl8zME1IWl9NQVNLCQkJMHgzZg0KPj4+ICsjZGVmaW5lIERXQzNf
R0ZMQURKX1JFRkNMS19GTEFESl9NQVNLCQlHRU5NQVNLKDIxLCA4KQ0KPj4+ICsjZGVmaW5lIERX
QzNfR0ZMQURKXzI0ME1IWkRFQ1IJCQlHRU5NQVNLKDMwLCAyNCkNCj4+PiArI2RlZmluZSBEV0Mz
X0dGTEFESl8yNDBNSFpERUNSX1BMUzEJCUJJVCgzMSkNCj4+PiAgDQo+Pj4gIC8qIEdsb2JhbCBV
c2VyIENvbnRyb2wgUmVnaXN0ZXIqLw0KPj4+ICAjZGVmaW5lIERXQzNfR1VDVExfUkVGQ0xLUEVS
X01BU0sJCTB4ZmZjMDAwMDANCg0KDQpUaGFua3MsDQpUaGluaA0K
