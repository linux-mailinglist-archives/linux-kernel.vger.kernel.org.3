Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A178492EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348686AbiARTqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:46:36 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:51190 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244781AbiARTqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:46:35 -0500
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C9904406E5;
        Tue, 18 Jan 2022 19:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1642535195; bh=jhLv+DTrVQvlZhKh5ZExpPTsyC/Xvx41qFci0ClRfO4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XOeYushp3obWDw78ILFUFxditfzsoZdQ1k2PDHemvsWIqgCSLfce3YiRnhWNQG9fz
         zCmkWCwlhEV5caiy4MVind8tD1Azs7Ji7r+HEU0ZfIyTo6TNqS9YMQv1yAG/Bmqs/x
         /UTcfXD+1qALibvOBLV9/u+JiuQQP14vCTbKJA/JHGpVI0U8qPbkmbfRjb9vAyiL3G
         ydpJXF47qV7eVWJt3YPIsCHRCyo421nGZ+J5b2kAYtPvzXtYT5REy0SQ2LrkPUYwYD
         4MzwPpSiUQUXIJ198u54/Van72wMMPd8w8cBwbhvHqwkNA9rQMSzEHpFhOTSwWcqaP
         trLZ4QbcEEMFA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C061BA005F;
        Tue, 18 Jan 2022 19:46:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 70BAE4009D;
        Tue, 18 Jan 2022 19:46:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="a0fUgB/I";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJXb6nQRpWxS5fIym5oRJTscDjnASoZ1rVmElUWimGI9pw/5jIVzcXdJH4BkKpZpCrRCiKizh3YKFWVrRgTiAGYZ8Wch3iU7u8ZZx95AxLlyslEcXxfNJmjWHgjAEf8opI+VW5l14GVO05GaqfJypSrHPq3h+9v74trmfbia76efwRbyuGbD6aZovoOmN6hFKBF10G9tYSfAfygYI+Y/QRTASOG4qGlRvlmB19My8JfqApvLIWh2DoA2+GUttVO6hyGNGRuphO/Z7+sv1AbB7OBxEcS2RGzW9Fx5oSptLpj4MerPnqYO1DlfxOcoyGOqTXagUjbaZk5ruhzO6QkAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhLv+DTrVQvlZhKh5ZExpPTsyC/Xvx41qFci0ClRfO4=;
 b=ii7mDV9OLybZ2dArgdFpCud1bEaKronBnZzHtzpZ32RgTACsA3t0cXg8EsA9qj5H1XceJobDT6oLKo22smBsa4doRB9FNbKRBeozPgM1UDlB68hFHHvVprXgWvu2dfNknxmmwbJZFlVkoKUg24X0iblqTkdmZdkz8bQ7boDP4K38u5tm4aHoQnQhasKgSdEdnQZsi7/V2Cy25NpPtB9hzGKCnmJoBRl+RwHW99ZWpPi4J5p3jBjeeg7iYtnwgxKBEC0tqhECBlrYj3N2JGq2pJ+4BzsC3oZhP8rb50Z4GXGj4Szs4b0kWQLegrvmwbBw0SaXpiV5itwr8aFE+GnUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhLv+DTrVQvlZhKh5ZExpPTsyC/Xvx41qFci0ClRfO4=;
 b=a0fUgB/IAen8W+8m6sR6Ej8zPD3f50BnrSytGodrn2YhdjwtgQpiKxtT7g3YbmDEmFpATY83dHka/+Ku9rAvVlYOYRfLiizK3hE/1kwTLFhra3+kCFe1kIBvdfA02QmM5IjKbAEIHJ8Hpuk3yKlvv92eWEjQ/MvJRu+aPQm1TcU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 19:46:19 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8983:6493:8c38:d34a]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8983:6493:8c38:d34a%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 19:46:19 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Baruch Siach <baruch@tkos.co.il>,
        Sean Anderson <sean.anderson@seco.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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
Thread-Index: AQHYCaAEN5xMDjPNv0iLO+Qwz2hVyaxnCOeAgAIr9wA=
Date:   Tue, 18 Jan 2022 19:46:19 +0000
Message-ID: <7831a4f7-7c3f-4a2a-be73-38f2c40a123c@synopsys.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
 <87iluifxy1.fsf@tarshish>
In-Reply-To: <87iluifxy1.fsf@tarshish>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15c7f0a8-6a8f-471f-7c85-08d9dabb32b7
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4258BC054D5A700DF3556026AA589@BY5PR12MB4258.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xgrw4opKcwvAer02Qsb4OD6eCTY4Hzb4E6iBRfs2YWXYlp4LzhVBZTYAfRcXNMWH4pjvghk4uVxcH2slfv1vnAce6xmhL5d6exh+1A2g9my+x7JMQg4JIKTbX2UjKu0ZgbtauXScIHnKmQPpni4WTUX/ld+4/uU8WvQrdPJ7ux5hZ9ChF/ZkaHAGkffOZdnueQXb96gozNv/EliYnKYlUnrBPXjiNjaD+fapVOcTmjjy8enElVt1qd58fAejEOsX+xLf41bj+Tt/PeQxhhHlZRSriQRdonj8HNVczFypfCbycGm44EPuXgjWeWHrGh2g2EfqZT/PtSiHzN65qnoEiycKfjpB/V/aNASe1GNgkveKyI9mI/cRMqqNXZUsSTa2JZYu1evAvn/7iQ1CIe626F54EzyKFbtFtaDrv+1yW1lysX5AcgcruVRf7ZXbSiuqLgjCYoNj540OUjHQP08/6TwqF68ozXHHF/oWKuqvgam4JVrZMOSCwMt4ghwr9q+Zn/tdUqfwOZEhtmvQQZ00tEqkj377UIygwWc6S8FbMGDbaCx+1F0xQf58SdbT9nNij2X/NuMFJRRloXrtqaiqvazQlnQcZ5OeM04xi3shI9O4r09/T6Ve75wLsM+PawlDEb3GYJK0PVuvnq9EKCIzI00a5qysUuNzumqLEfrWzcXOuALwpVIbvf+ZzcyK8HfK6soSoGzeeJs+F3gUw9zhqOyjW2T8LAkO3oD50QqZqKuIpfw3vu/d3tEo3UR+z6doWziRG9J9phfATDDNfBPieBklXAh4h7uPfMLnQWScHl5M5K17vknqNA60pHtRNLJKGjbh5fz4Qb9ONs5zLS9ihzhEF9ie99Hda12z2JPE0/c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(38100700002)(36756003)(8936002)(71200400001)(8676002)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(31686004)(54906003)(508600001)(316002)(186003)(86362001)(6506007)(6486002)(26005)(83380400001)(4326008)(110136005)(2906002)(5660300002)(38070700005)(2616005)(7416002)(31696002)(6512007)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YThmRCs4MUh1QmFJSWxDakxVQ00rWjN0NDdOL2tCWXorQVNrOWliTFNQYkE0?=
 =?utf-8?B?QkFWcUFtS1lGV0dtUjZBZ08wUU1Xb3hua3RtUlhQZEE4T2hLOExZRFE5M0tB?=
 =?utf-8?B?VzlFdzhGQ2lZVHZIOFNxbEFTNzEzeUIvQlFuR0sveGZQaGpranlzeTJvcDYy?=
 =?utf-8?B?YUMraU8rR28vK2FtWTlxd0p3aGFSMXNJcUtoMmNVL09rell2SHNRR1JmQ3Bj?=
 =?utf-8?B?OFllSktQUkJ0REtkdGdtcHQ5QWFMM2UwTW96YTVBeUZvWW1DVVFXd3kvU0pV?=
 =?utf-8?B?Zis5YTI4eDh6YytXR1F6Z3BuK3VQVWZqYm1BRmo4M3lzZjBrd0VrYnBzZk1m?=
 =?utf-8?B?SzNPcU9vbG4yd3phZ29DU25jRUpscUllVEo0TDdua0ppb3hjb280eW94YUk4?=
 =?utf-8?B?dTBPd29lTFh1bGVMWk5mRnIwZ3QxdFNuYnpDUlNaVXZzMWh5VDYwN1QxbVZ3?=
 =?utf-8?B?c1AwWFhJNTFBVk5sSjN0dk9PY3BGOU5XZC9FT0FScDFjODMzcEo4eDRQV1gy?=
 =?utf-8?B?V3hHaTN5cWV5SjRoMGhNeHR3S1E5dW1hTnMrM3YrUGVDN3psdVk1SGR3cUVk?=
 =?utf-8?B?U3VrK1MxOTJJRFpMVk1sQitQT3J3ejNuVnEvbVd6U3BBVEpnM01CL2VBS3Uz?=
 =?utf-8?B?Vk9STm1FTmVBOUxHUmxIWU1vTFRydjFFYWFvUGNjNW1FaE10TmF5cjE5WXR4?=
 =?utf-8?B?d0h1dy9oaDI2dUVsTmxjRUdPWEJVSWNMK0pDc002SmRZc0hPL1VFdmxGMVBz?=
 =?utf-8?B?Y1N3Y1diT1UzUkR6djlVTlRPRzhoQTVaai9YV3REM3phdmdHbXVNQ3FHVE1j?=
 =?utf-8?B?WmtjUVpmNng0c1R2aHNpM2N6QXFST0QyTzNtTXI5Um0rb0hxSjBkNDlkakFU?=
 =?utf-8?B?ZHVsWjhIZHlCUGQyYmoyMUJ3TVpDeFA2UnBIc3JzMWlJODE0Tnh3LzFLM01G?=
 =?utf-8?B?aDI5NXF2bDU0RllFdWhoM2MvZWYvdWpEMnU4MGVrMVlIYVBvR2JNYTdnN2Fi?=
 =?utf-8?B?TWwzZHpQR3lIVHBWWGtwaGtodFhuTXM0SkZFMUZNTncwZkM4YloyelBEOU9Q?=
 =?utf-8?B?VE9NeVp4bTJhOUhNdTQvZ2pNM3JoY2ovOHhsMnVaTWRwU0oyYjc2T2U2ODk1?=
 =?utf-8?B?OEoyZHVHbWMrbHpRcVMzci9KTDJ3TW1hdVZlRnVad0NkTnRyWHNlK2dMbFIw?=
 =?utf-8?B?c0FUZ2gwakhaWmwyaUdweC81VVRBaDluLzM3WVFjY3lRWFFtYnQrNmNlTmhy?=
 =?utf-8?B?bUFPM1hpVTBBTzQvYWJXUnd6Wm13RDViUzdkVEN1NS9iMk5yeDVDNm8wekdn?=
 =?utf-8?B?a2h1bkp2SGk5dWVnbUl0M21Tem9ZTXZoTHQzR1dsWmY5ekMxWitvRDRvRU5w?=
 =?utf-8?B?Rm5nME81cTlpTDk4aWtEMDk1dzZJdFlJcFBBeWcrQlBjbDlsZ1JhdEVGREZ3?=
 =?utf-8?B?eWMxNFBCUTJSdXNPWUMxcWt0NVIvS0pZcUtudlNpZkNJTmdUQnpaVXc3cW1u?=
 =?utf-8?B?bVAyOFRrM3pLaUMxUXFrVjZYQnNGZTdwV245dVQ0d2p4VTZlZkJlbFdzSWlt?=
 =?utf-8?B?RGdHZFZ3OHNiMFYvV0hPQ3h2eVZjRnI0ZXhjTEw2WmxtektuekFJUFlkS2hR?=
 =?utf-8?B?MnV4LzV0MTNHRG96THhUN3RYbUdreTVxRTVuYWN6YmFhczlEYVJwZ0pVemRk?=
 =?utf-8?B?a0EwM21jdWl0U2luZFUxd2pOd3FQaWdCVG1qM1pZOC9adnpxQzM2T1pObDlm?=
 =?utf-8?B?UkczemZFWGdqamF0UDVhRHNQbVNCankvL3JybWh2Q1ZTYTcrRll6T1lqdGEy?=
 =?utf-8?B?WGJud3Blc0FMQXErS0dJamJIZ3h0TFJiaXlkUGxUcU9QcW8vOG40Y091MzdS?=
 =?utf-8?B?MUZGVytUVEJVWG9GQzMzQWxNaWVmcCt6UTlXMWwrUTNaOVovaGhtQ3krQlpm?=
 =?utf-8?B?dkhFTlNla0RTVmszN2JIRkE2cFp6dHdoRE5KODJaOUNOMm1Ya3h0OS9NV2o1?=
 =?utf-8?B?ZnVxakU0cVRENG5RaXF4eHY4MEFkK0lFRWwxZUo0TG02VDRaSjFjTFFBUnV0?=
 =?utf-8?B?SzZoNGpKMXlVZFFNVWlKVlFWY3E5MUwxQ1Y1ZDl3NDhGMmoxczY1aDR3TXNa?=
 =?utf-8?B?OWVUaVZiN0J2WWU1QTdmSzlMc1YxODdLYW16WGlrWEtERWQzWnNwdG5PVjZ1?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F418766768F2B43B4B654F60ACB6858@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c7f0a8-6a8f-471f-7c85-08d9dabb32b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 19:46:19.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHIYjiB5xzCDr3F9t8lp4YDc/izVBH6e5Q4JcZaiTYX7v5N4EOFlz5jiTzYsCEoNlu+GJyjm/yplLcrnRNPHIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VhbiwNCg0KQmFydWNoIFNpYWNoIHdyb3RlOg0KPiBIaSBTZWFuLCBUaGluaCwNCj4gDQo+
IE9uIEZyaSwgSmFuIDE0IDIwMjIsIFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+PiBUaGlzIGlzIGEg
cmV3b3JrIG9mIHBhdGNoZXMgMy01IG9mIFsxXS4gSXQgYXR0ZW1wdHMgdG8gY29ycmVjdGx5IHBy
b2dyYW0NCj4+IFJFRkNMS1BFUiBhbmQgUkVGQ0xLX0ZMQURKIGJhc2VkIG9uIHRoZSByZWZlcmVu
Y2UgY2xvY2sgZnJlcXVlbmN5LiBTaW5jZQ0KPj4gd2Ugbm8gbG9uZ2VyIG5lZWQgYSBzcGVjaWFs
IHByb3BlcnR5IGR1cGxpY2F0aW5nIHRoaXMgY29uZmlndXJhdGlvbiwNCj4+IHNucHMscmVmLWNs
b2NrLXBlcmlvZC1ucyBpcyBkZXByZWNhdGVkLg0KPj4NCj4+IFBsZWFzZSB0ZXN0IHRoaXMhIFBh
dGNoZXMgMy80IGluIHRoaXMgc2VyaWVzIGhhdmUgdGhlIGVmZmVjdCBvZg0KPj4gcHJvZ3JhbW1p
bmcgUkVGQ0xLUEVSIGFuZCBSRUZDTEtfRkxBREogb24gYm9hcmRzIHdoaWNoIGFscmVhZHkgY29u
ZmlndXJlDQo+PiB0aGUgInJlZiIgY2xvY2suIEkgaGF2ZSBidWlsZCB0ZXN0ZWQsIGJ1dCBub3Qg
bXVjaCBlbHNlLg0KPj4NCj4+IFsxXSBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjIwMTE0MDQ0MjMwLjI2NzcyODMtMS1yb2Jl
cnQuaGFuY29ja0BjYWxpYW4uY29tL19fOyEhQTRGMlI5R19wZyFNM3pLeERaQzlhX2V0cXpYbzdH
U0VNVEhSV2ZjMXdSXzg0d3dNNC1mU2hpQTM1Q3NHY3hjVEVmZkhQYnByYmRDNGQyUiQgDQo+IA0K
PiBUaGluaCwgeW91IHN1Z2dlc3RlZCB0aGUgZGVkaWNhdGVkIERUIHByb3BlcnR5IGZvciB0aGUg
cmVmZXJlbmNlIGNsb2NrOg0KPiANCj4gICBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2Q1YWNiMTkyLTgwYjktMzZmNy00M2Y1LTgxZjIxYzRl
NmJhMEBzeW5vcHN5cy5jb20vX187ISFBNEYyUjlHX3BnIU0zekt4RFpDOWFfZXRxelhvN0dTRU1U
SFJXZmMxd1JfODR3d000LWZTaGlBMzVDc0djeGNURWZmSFBicHJicE9GbXZYJCANCj4gDQo+IENh
biB5b3UgY29tbWVudCBvbiB0aGlzIHNlcmllcz8NCj4gDQoNClVubGVzcyB0aGVyZSdzIGEgZ29v
ZCB3YXkgdG8gcGFzcyB0aGlzIGluZm9ybWF0aW9uIGZvciBQQ0kgZGV2aWNlcywgbXkNCm9waW5p
b24gaGFzbid0IGNoYW5nZWQuIChCdHcsIEkgZG9uJ3QgdGhpbmsgY3JlYXRpbmcgYSBkdW1teSBj
bG9jaw0KcHJvdmlkZXIgYW5kIGl0cyBkdW1teSBvcHMgaXMgYSBnb29kIHNvbHV0aW9uIGFzIHNl
ZW1zIHRvIGNvbXBsaWNhdGUgYW5kDQpibG9hdCB0aGUgUENJIGdsdWUgZHJpdmVycykuDQoNClBs
ZWFzZSBoZWxwIGNvbWUgdXAgd2l0aCBhIHNvbHV0aW9uIGJlZm9yZSBkZXByZWNhdGluZyB0aGUg
cmVmIGNsb2NrDQpwcm9wZXJ0eS4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiANCj4+IFNlYW4gQW5k
ZXJzb24gKDYpOg0KPj4gICBkdC1iaW5kaW5nczogdXNiOiBkd2MzOiBEZXByZWNhdGUgc25wcyxy
ZWYtY2xvY2stcGVyaW9kLW5zDQo+PiAgIHVzYjogZHdjMzogR2V0IGNsb2NrcyBpbmRpdmlkdWFs
bHkNCj4+ICAgdXNiOiBkd2MzOiBDYWxjdWxhdGUgUkVGQ0xLUEVSIGJhc2VkIG9uIHJlZmVyZW5j
ZSBjbG9jaw0KPj4gICB1c2I6IGR3YzM6IEhhbmRsZSBmcmFjdGlvbmFsIHJlZmVyZW5jZSBjbG9j
a3MNCj4+ICAgYXJtNjQ6IGR0czogenlucW1wOiBNb3ZlIFVTQiBjbG9ja3MgdG8gZHdjMyBub2Rl
DQo+PiAgIGFybTY0OiBkdHM6IGlwcTYwMTg6IFVzZSByZWZlcmVuY2UgY2xvY2sgdG8gc2V0IGR3
YzMgcGVyaW9kDQo+Pg0KPj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMu
eWFtbCAgICB8ICA3ICstDQo+PiAgYXJjaC9hcm02NC9ib290L2R0cy9xY29tL2lwcTYwMTguZHRz
aSAgICAgICAgIHwgIDMgKy0NCj4+ICAuLi4vYXJtNjQvYm9vdC9kdHMveGlsaW54L3p5bnFtcC1j
bGstY2NmLmR0c2kgfCAgNCArLQ0KPj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMveGlsaW54L3p5bnFt
cC5kdHNpICAgICAgICB8ICA0ICstDQo+PiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgICAgICAg
ICAgICAgICAgICAgICAgIHwgOTggKysrKysrKysrKysrKysrKy0tLQ0KPj4gIGRyaXZlcnMvdXNi
L2R3YzMvY29yZS5oICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICstDQo+PiAgNiBmaWxlcyBj
aGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IA0KDQo=
