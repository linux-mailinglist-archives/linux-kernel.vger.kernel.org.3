Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF41492EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343860AbiARUBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:01:05 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:51980 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245377AbiARUA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:00:56 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 48C3140602;
        Tue, 18 Jan 2022 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1642536056; bh=PuqUVWg0ZHoWP0vAY2fZxF17iQvREpQX7EM0Omfb+OU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jiS0vIamtSX3lBse5YMaovol6bwgFnEiNOl56Xo7NKqC1+Rt0naQcRMM7Mh9BGddI
         LUKC2Y6wQMVdRNWAhNBYz/fDq85UPN/5DEBnDTdZRnhmyCrZUakwgf98sPDsfTo36l
         XzFgWtvljMVIlN/xOhGuHBQ8+mEDqsJp7DXQPyzYrSPB02FALYO8lDeT8igQkMvGzs
         L9Yrb0ITKnQgYTZb8lNIR5RMYxp1A6oM1F/2ntk3JC/X7bIxsf9IHatav5Mym9IJ8X
         oPLaoS2cu4UIa5IsAdJg2PQvcNpvK9hjLuTQrRewxHhaX7/UbVUDqpiedxo42WAXCZ
         Y0tsLZLoAEIwQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E3E21A005F;
        Tue, 18 Jan 2022 20:00:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5F64980203;
        Tue, 18 Jan 2022 20:00:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="aDNkugn+";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb0JkkGGKqB4J3wNO3ptJDzEWwKDLAfvU+ARp3J5hOGYkcU+NNwAeAj+qUhK1OG0tFZjmOzhtV3drUIzJX083JBpqXjls2kDFBRUtrPCu0j0AwLCbDsksVCE+d4wIZHnJWNHl7z4arxuTkOgBg1IbiNZOCKh3LciJuw5gm8SHM87rm5k2HqkDhKQyrlNw0Ke4XFR0VF3RjQ4vsI1iFG2pEJ1BAhwjAO7VIt6SQuPxhlygX06kwWnW36/gh0ncMMwaJHCMIFW0JBliMJ8Di8Qnjp8RpYlc0UAflDbkkdjZDWjQ9Lmvly+usLWHAAvuzFzysmyZr1GVh6SIPREo28lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuqUVWg0ZHoWP0vAY2fZxF17iQvREpQX7EM0Omfb+OU=;
 b=k61QiMCf9I6CwVZMxrSRdMmGvH0EQ5caWamAZwCq0TJdHc6NRHhSk5tSNq1j2XEaeUvVKvoIr8lsZ5AoAj4tuj1LKPa9ekcP0v1+zs2uddzDZcZSKaL5b0303rKisOlfs+/u50Ojan4/nJtSZx1tfQwyjj5KDrbpmWP8ccr4EyDKurwFkZgmFryKWyxmmuJZ/3bi/bJKbQ/tJW3t7qhuMS8PeQ819MvuRjD19fo4USWBpnwSzXMx5Sy0U8IJsBAkm59SnwKOL5TrwWvMDqMFwiwcDiTkjXj6IyNazuFlzsIh267fj0JGvOZQsJ4gbEugUKLvNsyaGZkX7W0u+5PX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuqUVWg0ZHoWP0vAY2fZxF17iQvREpQX7EM0Omfb+OU=;
 b=aDNkugn+xo3Yz9ZOY06AcALilEMc+QWF9k4tXuVSVIaHe+pC3Y4rXy9gQPexhmHzJ6xg3PI/gv0jr0LEM8AmsnuMatf4XCQyEzGNwNJ0R40/6r1b53i7b+CN+ZB6z3IFyceqyOiUtnLiHnnF6mRAvXrVF47JwJ7Koxf3/MJF1yA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN6PR1201MB2528.namprd12.prod.outlook.com (2603:10b6:404:ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 20:00:44 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8983:6493:8c38:d34a]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8983:6493:8c38:d34a%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 20:00:44 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Baruch Siach <baruch@tkos.co.il>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference
 clock
Thread-Topic: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
Thread-Index: AQHYCaAEN5xMDjPNv0iLO+Qwz2hVyaxnCOeAgAIr9wCAAAIIAIAAAf+A
Date:   Tue, 18 Jan 2022 20:00:44 +0000
Message-ID: <f53ba815-f2ee-a558-73f3-06c5a43f5c5e@synopsys.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
 <87iluifxy1.fsf@tarshish> <7831a4f7-7c3f-4a2a-be73-38f2c40a123c@synopsys.com>
 <f28052d9-5dea-a05b-8745-09e4d237b539@seco.com>
In-Reply-To: <f28052d9-5dea-a05b-8745-09e4d237b539@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a7bde9e-e562-4769-39e2-08d9dabd3643
x-ms-traffictypediagnostic: BN6PR1201MB2528:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB25280259635FAFBC697C4C43AA589@BN6PR1201MB2528.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ExEmFvWVKR3aI0qtLXt8YQaFILlVhLXw+3zRh+SXY963Q2YdfWs+jBZLctHBvZY3rdSKlivteFHWzfp+uwY+ZK7F4zYRGWc8nM7PL4eKxbzfZw7uloug4GjGAaoM8NlMI65N49xy8VI8pClOH/hQRUp6uOaEQDTG9SoY7U1UGrurrnhoEjHdH3NWBxysubaeaKSnNfTp5Ocuadk79fSWokYNPj3mPupv8FsIIs+iw/SfaBQ1rDO/yHD4SMMWRhhmrysuJqXiXohQRIp3jpW5u+TTiVLmb75QdPPrOdy1TvFxZcwfgsere2zdm8V0qih+uZTy6Y9dltK8yA9nsp3vghjN+TyD95KFSdNhx3IPG61daQscSA2xKDiRQYJxwLsFbtlCCw7UwgXV3kQts8UH+TM71OkM2dITrh4sWqFzOyYSW2EC857Dm5rAf7F20WpFQDk8wvz/W9xRTj2CKyYKvxEiEDxoJiCwaVCACQVrA/jjM7+5sZOO6KDxWwYv8qllT4xos2ffTUeWtDhofm7FqpRrkO53Jn82gUPknCLyr3lgASYbtq39d4VFiMHwOS8mP8X+KX1tihMQvzErXY2DzaVm3Xi5ouhxdURdfRI0vSuajXHAghfjUzOU1NIXW+4ihneyKmDJpC6+TpIg/WJXmMwYLIzBc0Q4DIwCPwRwVPPsbTn2ViLjVbZQWDXNUQJ4b5TJxJvlYYmCJT5hUwTIxErsIy7rW3WjKNgnZ4tjaR56deiECTjGDTKYMW8L7VVrshG8J+CLnQ2TClr9aFvqbrl8IxyAqJ2i6OCV7x1nB5xSlOnjsFyrQNw2EpCt8ySWL0L2gqL9j8QETnxicT8ebKRnnL1oBKKIZSqQFEtbvAY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(8676002)(122000001)(8936002)(38100700002)(6506007)(966005)(76116006)(66476007)(31686004)(66556008)(64756008)(86362001)(6486002)(53546011)(316002)(66946007)(508600001)(4326008)(83380400001)(110136005)(54906003)(31696002)(6512007)(71200400001)(186003)(36756003)(7416002)(2616005)(5660300002)(26005)(2906002)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk1MajVmaFZQVlZxc01IY09PYmVNSUMyY0Zxbzl4cmNqQWNDbVJ1aVBuS3da?=
 =?utf-8?B?aU9DQ0F0YlNnaWF1K1R3WjdFQ0pyQksyRTZlazd4NnNPeVU0N3orNHN1OWky?=
 =?utf-8?B?ZU51ODVPNWNVVnFlWXZDbGdrM3VJZG1tN0NPanJxeklpbk1hYURVZUwwVCs3?=
 =?utf-8?B?b2F0emRwekVWamJHVU1DQUs2ZmZMRzN2bFNHaHBoczZyVGdBclZaT2c1eXFF?=
 =?utf-8?B?YzhDUUQ5T2tQanIxYURJZlNlcUkwVHBJTHNXNG9MdjBhWkZRQTBPQkoycUxr?=
 =?utf-8?B?Q1UwczRIa0ZmMEowZ3FYM0VjU2g0NzIwUWEyRDdYbmU4UkRIdFJWN1Y0RTB4?=
 =?utf-8?B?U2ZpQnkxUmdrbFBGeDhPc0l0eHFtYldtdG9NTmNIOTA0NXJabGQzTmhsUHNm?=
 =?utf-8?B?V01DRFZWSmtPSFVPcHBmWDdMTUtsSTlmK2ZVNmFGU1dDaDFtRmttek1LTEhN?=
 =?utf-8?B?RS9rbWdxRFp0eG5tZmo1R1BvL1pxNWl5NFRJZ1BhdzJpZVNwZjJRSFVJTzEx?=
 =?utf-8?B?ZllOZEdLMVg4dU1ZWTJRd0dzRVM1SWdCdUl1U21LY0MxeFRFTjVka1JtSUI2?=
 =?utf-8?B?aXFKZlFvQ01XNnNKMFlDZURMUmcxanUwRVh5UVpjR21sT1NDeFpwaENUM1Bt?=
 =?utf-8?B?Q0Q1VVR2cHZtWTN3L2JpeTF6c3FIc0taTnRjVlAxZC92Y3VocXQzWVlyYWpZ?=
 =?utf-8?B?WHh3N25YeFowOWJnWmlMUUU1djNUeXV2RmRjUUE1S085WGpOREhDeEd6R3Bp?=
 =?utf-8?B?R25qTGtrOUFjMmtDY3dFZXlyMTZRT25MNEFWTmNSQlhKNUw4Y0dNTXUwdTdR?=
 =?utf-8?B?UkVIZmlES2hwNkNtSnJ0M3RGZDZkaVhZNWtHc3pabDA4K1VsRkJ0ZFRZYkxU?=
 =?utf-8?B?NVdSVGliYW4zVldnL2k1S0swYTRhbU5TT2xQenE5NHJPWDJjVGlmbHM2WXl5?=
 =?utf-8?B?eEZNb2pUSzNVR3ZhbHlPQXkrK2hRaS9vRTdXU0pLSnFvalhzYmxsR25meFc0?=
 =?utf-8?B?SzRMUWlSemY4M3BTakM4SFFCajZrcEQxdDViRlRQWUN2QnBQdDNmQUVMWkc0?=
 =?utf-8?B?akx2KzFPaHBUZVh6OW9jWEFMUHd4eWpKbnRNTWl6aGo2b0Nsc1p0RlpJR3lW?=
 =?utf-8?B?SGdZcWRyWmlHVmFJQ1ZJeEZwMUY3ckllSWpqRDBZbWtLR2ZZRjhxZjJ4b2VY?=
 =?utf-8?B?SkRZSTJWNktuL29HVWxVNndDajRERS9TeXk3ajA1Vml5bjNCWVB0cXNoM01E?=
 =?utf-8?B?RjdKazZmQ2c2elIwSXNLb2txV3h6RnNvejRrb1g0ZUg5L3ZyOGRpOEJSMC81?=
 =?utf-8?B?OERNeG41M3hKcHNmYkZBVVpzSXpBbmpjMjFhMUpET2dObnN6Ui9VZnhBcGtX?=
 =?utf-8?B?ZlhOVnJkd280c2FWWGdFcndCbDZ6UDlDNk1LSmRVS05RKzBJdkJmT2JGQmZi?=
 =?utf-8?B?R3NhUzliaWgva0o4WWE1UXd2NmhLYXJSSDZDZWdWb3B4ZHlqRUgrQUtMS3N2?=
 =?utf-8?B?NVhMVE51S283M2c3ZllkRkdPdWhWeEMzdTA3T2lZRXkwODRha01pNWVNZldO?=
 =?utf-8?B?SXdDb0ROeGh3ZnQxZ2JtRk85d2ZxVVVqdm1zYnZTZk1iWHNSSC9qSTJiVEpz?=
 =?utf-8?B?SHN0bUNDMkRCMFZLK0VzVDVtckNtUS9BU0d1N3hzZFVjQTQyeWwzWm51K0M2?=
 =?utf-8?B?bW04UVhkK2F6eWxjWmMrMTdQbkt6Tjc3Ykl5QlVhd1hiNFM1STl5dXhYa1dH?=
 =?utf-8?B?emtYUEFLRGY3NVZLNUdmaE1oSmE0T1hsQTVlcHdCd05HQXRkdUhvT3hWSHYx?=
 =?utf-8?B?ZzcyTzhkTlplRHE4YUl6a3JQQ2Y5YUlhUWNOb0ZCcGVkaWwrY3NOa0dqYkQ2?=
 =?utf-8?B?YXhmSXZ5MTB0MGpEcUFkUERwejExM2I0cHJWR1VERUdVSlFHU0FCT2xHNUJt?=
 =?utf-8?B?Nkw3dG9SdmtnSklyRk9yZjZTdXRjcGpUMHJ6V1Q0b1Q3Q0xjd05ZejgzUWlU?=
 =?utf-8?B?bkttVUJlL3Zkem1DQmhvWWV1eXlmd2k4SmkzcHFQM3d4QWozc29sTzg0QzNW?=
 =?utf-8?B?SHVxcS9NalZlVldmeDhEQXVxWjMxUTlURTlQRzNvcG0wMWg0ZkRRZWtPV2k4?=
 =?utf-8?B?UVpCTlM5YVlCVEUya3B3Y3dMWFRwTmlsOWRYQ1BBOUNYS1d6b3pFYXgwWWtN?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C262C72CBFCB924AAF2B0F8D5108F53F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7bde9e-e562-4769-39e2-08d9dabd3643
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 20:00:44.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilXwsuSyQQa1DbHMYbo5GZLlpvgzjXzHZWj7IV6Bvd4ivx9jXqzIKeAvjbFofFV3PpUwfmy9GIczixadIJ27iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2528
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gSGkgVGhpbmgsDQo+IA0KPiBPbiAxLzE4LzIyIDI6NDYg
UE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IEhpIFNlYW4sDQo+Pg0KPj4gQmFydWNoIFNpYWNo
IHdyb3RlOg0KPj4+IEhpIFNlYW4sIFRoaW5oLA0KPj4+DQo+Pj4gT24gRnJpLCBKYW4gMTQgMjAy
MiwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+Pj4gVGhpcyBpcyBhIHJld29yayBvZiBwYXRjaGVz
IDMtNSBvZiBbMV0uIEl0IGF0dGVtcHRzIHRvIGNvcnJlY3RseQ0KPj4+PiBwcm9ncmFtDQo+Pj4+
IFJFRkNMS1BFUiBhbmQgUkVGQ0xLX0ZMQURKIGJhc2VkIG9uIHRoZSByZWZlcmVuY2UgY2xvY2sg
ZnJlcXVlbmN5Lg0KPj4+PiBTaW5jZQ0KPj4+PiB3ZSBubyBsb25nZXIgbmVlZCBhIHNwZWNpYWwg
cHJvcGVydHkgZHVwbGljYXRpbmcgdGhpcyBjb25maWd1cmF0aW9uLA0KPj4+PiBzbnBzLHJlZi1j
bG9jay1wZXJpb2QtbnMgaXMgZGVwcmVjYXRlZC4NCj4+Pj4NCj4+Pj4gUGxlYXNlIHRlc3QgdGhp
cyEgUGF0Y2hlcyAzLzQgaW4gdGhpcyBzZXJpZXMgaGF2ZSB0aGUgZWZmZWN0IG9mDQo+Pj4+IHBy
b2dyYW1taW5nIFJFRkNMS1BFUiBhbmQgUkVGQ0xLX0ZMQURKIG9uIGJvYXJkcyB3aGljaCBhbHJl
YWR5DQo+Pj4+IGNvbmZpZ3VyZQ0KPj4+PiB0aGUgInJlZiIgY2xvY2suIEkgaGF2ZSBidWlsZCB0
ZXN0ZWQsIGJ1dCBub3QgbXVjaCBlbHNlLg0KPj4+Pg0KPj4+PiBbMV0NCj4+Pj4gaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDIy
MDExNDA0NDIzMC4yNjc3MjgzLTEtcm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbS9fXzshIUE0RjJS
OUdfcGchTTN6S3hEWkM5YV9ldHF6WG83R1NFTVRIUldmYzF3Ul84NHd3TTQtZlNoaUEzNUNzR2N4
Y1RFZmZIUGJwcmJkQzRkMlIkDQo+Pj4+DQo+Pj4NCj4+PiBUaGluaCwgeW91IHN1Z2dlc3RlZCB0
aGUgZGVkaWNhdGVkIERUIHByb3BlcnR5IGZvciB0aGUgcmVmZXJlbmNlIGNsb2NrOg0KPj4+DQo+
Pj4gwqANCj4+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL2Q1YWNiMTkyLTgwYjktMzZmNy00M2Y1LTgxZjIxYzRlNmJhMEBzeW5vcHN5cy5j
b20vX187ISFBNEYyUjlHX3BnIU0zekt4RFpDOWFfZXRxelhvN0dTRU1USFJXZmMxd1JfODR3d000
LWZTaGlBMzVDc0djeGNURWZmSFBicHJicE9GbXZYJA0KPj4+DQo+Pj4NCj4+PiBDYW4geW91IGNv
bW1lbnQgb24gdGhpcyBzZXJpZXM/DQo+Pj4NCj4+DQo+PiBVbmxlc3MgdGhlcmUncyBhIGdvb2Qg
d2F5IHRvIHBhc3MgdGhpcyBpbmZvcm1hdGlvbiBmb3IgUENJIGRldmljZXMsIG15DQo+PiBvcGlu
aW9uIGhhc24ndCBjaGFuZ2VkLiAoQnR3LCBJIGRvbid0IHRoaW5rIGNyZWF0aW5nIGEgZHVtbXkg
Y2xvY2sNCj4+IHByb3ZpZGVyIGFuZCBpdHMgZHVtbXkgb3BzIGlzIGEgZ29vZCBzb2x1dGlvbiBh
cyBzZWVtcyB0byBjb21wbGljYXRlIGFuZA0KPj4gYmxvYXQgdGhlIFBDSSBnbHVlIGRyaXZlcnMp
Lg0KPiANCj4gQ2FuIHlvdSBleHBsYWluIHlvdXIgc2l0dWF0aW9uIGEgYml0IG1vcmU/IEknbSBu
b3Qgc3VyZSBob3cgeW91IGNhbg0KPiBhY2Nlc3MgYSBkZXZpY2UgdHJlZSBwcm9wZXJ0eSBidXQg
bm90IGFkZCBhIGZpeGVkLXJhdGUgY2xvY2suDQo+IA0KPiAtLVNlYW4NCg0KQ3VycmVudGx5IGZv
ciBkd2MzIHBjaSBkZXZpY2VzLCB3ZSBoYXZlIGdsdWUgZHJpdmVycyB0aGF0IGNyZWF0ZSBhDQpw
bGF0Zm9ybV9kZXZpY2Ugd2l0aCBzcGVjaWZpYyBwcm9wZXJ0aWVzIHRvIHBhc3MgdG8gdGhlIGR3
YzMgY29yZQ0KZHJpdmVyLiBXaXRob3V0IGEgcmVmIGNsb2NrIHByb3BlcnR5LCB3ZSB3b3VsZCBu
ZWVkIGFub3RoZXIgd2F5IHRvIHBhc3MNCnRoaXMgaW5mb3JtYXRpb24gdG8gdGhlIGNvcmUgZHJp
dmVyIG9yIGFub3RoZXIgd2F5IGZvciB0aGUgZHdjMyBjb3JlDQpkcml2ZXIgdG8gY2hlY2sgZm9y
IHNwZWNpZmljIHBjaSBkZXZpY2UncyBwcm9wZXJ0aWVzIGFuZCBxdWlya3MuDQoNCkJSLA0KVGhp
bmgNCg==
