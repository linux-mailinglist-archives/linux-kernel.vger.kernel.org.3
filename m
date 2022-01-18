Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D78492FED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349302AbiARVKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:10:41 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40496 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229669AbiARVKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:10:40 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 99072C0101;
        Tue, 18 Jan 2022 21:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1642540240; bh=h1mfmx/6qRA+QUaqpxjk6M3h2U1gPGIRmgHnrcULWrQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BSz4KgMFkX9nngVvzrk1JTkMBPJvBnfxpixMmw1JtMiBNnJvsUoevoO4/bWEdyObO
         Dj493JWVyabOaZFKwrsYFOJ0/fO5QIeyJ+8dAp2F43O/4w7eTi7bc4x+JuB2rzjRgP
         +RMunKbTL+fWL5Uyp2Jyel9BLyrjakIPSpK+vSPg4e+mxjoPeefk84GurmbCMHQ6CE
         QPWiCFZht9/xKLLvSI189+hFT7yLLAC2STUvGCuW20DwI3sNmjUgi07oTqg1KSRglm
         oIAXEskNZlrdlsOV6w3EXXu3b/yaB/TeW9CNjMk2rVnEfdFPUzTf9VrjRE20jz9exo
         BizfXq9UCAnCQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D537BA0084;
        Tue, 18 Jan 2022 21:10:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5A635400CD;
        Tue, 18 Jan 2022 21:10:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ASBJdlgJ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0+IzM+m0Ku4ybHD+gtISRcN9xMIIMvKkDR4aJYWwFEoM3zn36N+h1OrgFcTelETp7ojZOgnQ5FDt9CDOgqd/z/wGkRMSDeaxQZYyldT7wF3qLHQPxvMtcTqqK/gE4U9AENpi3841Y5us2a+16ojSXAB4AJH1sfQWmiEQVNL1yEyfK+LlGYY5ENUl5ltcw9trzPVEWWbx6z/LSKTozX0/XAtypq/dDw2h4W3Fs2lpYdvVKtNXN8xOMRYILH4APLG39WlOvqr7GGNg67qd/VbBoAafmzG6u6rThHaalHugEwsClKF64m2BIoA//C5kDygnfLUV5V0F+mcae6zCAVjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1mfmx/6qRA+QUaqpxjk6M3h2U1gPGIRmgHnrcULWrQ=;
 b=SjdhhR7Vf/nsNJF5Q25YhqPL6ovpD1iCiZLHMfXH9xz/16BNigzMOMIPaeHpbyswVooAp7QIFQj+sf/ls+n8CRJTCEHN6RTPyYkSw99VejJAjTQuNlF8bjKhcG7dVksf/WagVDHhh9QB3xUhuxXr+91Mmvmr4syuu1xisj4McIw9XmZyg+GpYoWPWfIf0DgeVMCpuNzrqzYlcaR7O1kHOf5r8UHeYLi14VA9ADk2L5KodKy1LNo+8NsZLd5iEOj4W8uzMNemjE0nC5qcY1h+jYWRl7rBO+3r3Cy5tK8UK5wkuBbNDq+MtzQZW0mXgkU5plKHlhMFLy5poixOGCgqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1mfmx/6qRA+QUaqpxjk6M3h2U1gPGIRmgHnrcULWrQ=;
 b=ASBJdlgJ9y2bBI5wmi/x4FpgLu/icAgenQ1bCCJjXyzhSI1l555Uze3y28hiRCcpLU3mNzcXXOedALocVpVU2mdqJGp7c8yx/C/KvDLspnnyobWuofIPsnT0hDMS0lbiCeRlBg1lk2uDL/r5mDsiorUkjMm50drdHUJPzJrn6Ls=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 21:10:25 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8983:6493:8c38:d34a]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8983:6493:8c38:d34a%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:10:24 +0000
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
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference
 clock
Thread-Topic: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
Thread-Index: AQHYCaAEN5xMDjPNv0iLO+Qwz2hVyaxnCOeAgAIr9wCAAAIIAIAAAf+AgAAQXACAAAMbgA==
Date:   Tue, 18 Jan 2022 21:10:24 +0000
Message-ID: <9b4f6122-a044-fac6-c5ba-e786cb1fc584@synopsys.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
 <87iluifxy1.fsf@tarshish> <7831a4f7-7c3f-4a2a-be73-38f2c40a123c@synopsys.com>
 <f28052d9-5dea-a05b-8745-09e4d237b539@seco.com>
 <f53ba815-f2ee-a558-73f3-06c5a43f5c5e@synopsys.com>
 <0aaeb0e3-1e10-df41-0b61-c10249ea5faa@seco.com>
In-Reply-To: <0aaeb0e3-1e10-df41-0b61-c10249ea5faa@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68f57141-0695-4d91-7233-08d9dac6f1de
x-ms-traffictypediagnostic: BYAPR12MB2808:EE_
x-microsoft-antispam-prvs: <BYAPR12MB280891D56EA1BA21B7728E10AA589@BYAPR12MB2808.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/0xwyr6LJrcUR2LjBVfXdckF/1e5Uk4WnZi93FddogJjwnpv9140fHYQPXSiz+dqyv2GRQ7zHsY7TT9UtpsusgLiNco45CVK0me9G8MTa+bmZ+LxRct9O3XGLRVz0HocJlNHjZj0myQPT78Id75SHq7kCqDgkpxVQ7nPl6Kt1puLjxbo0yocdax3U1VHfVkxKbDeiJh8jbY5HaO0+q2wKnqlQmmVPz4Fn/HYtVJRIOW+CJczEiXXfFCKndQTUimyFy9L+d4gYZRCluVoGpfofhLBROhvgRp2Bv5Z03Hj4wi9ZH2zuUNAs/LkKKGgvODLFi/iMY3YIMmFSsDAiuj0349uCFfC0x7tDX0201ZOShwZCo2DksGT4baYtejGcsYoYwwvwJ9DhH0OMlX06ueYxVdgo2y6qzmMT5fAteHudDNVlzVRU++tWj06j69ItB43UyifAYIwsviwZEWQZFWi4uDFwX4sLrelNFOY1laVGwYw5qO4TGZzg945AiUdk2z6E5M98Ittmx+1WLoxC8kjNbRcie81W4ckLO2jCc+d1Mkfz4iqLdKLgvdb0DyaHF03vrHT3dmkJbQMnCJTpBQnYjFhrhq1TirPEHX2BDiDUcQvcz6g3XhgDB1POzGBMMfa6xh5xofesSEI+ViZnK4YCIqf4bLhNxQdx2R83dFHqKA/QDTnZZ9RDmQ5XHZShM/8ZNKN1nql1EesytfrVA8GIA06KIQCXWIs1u2KFa605HbXBhbXNP5IQ57vY7WSnrd6tsO0c9++b3kH8flDK87Ak5YI2m4ERj97UM+1XZVxi17uNf0pLfWHRLi1QMH5uSWsqysom5aWlxj6vNEbhUg+PiHKci7sHtCFDKDfxY9ADA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(38070700005)(8936002)(86362001)(6506007)(76116006)(31696002)(7416002)(110136005)(5660300002)(2906002)(8676002)(2616005)(26005)(4326008)(186003)(508600001)(71200400001)(38100700002)(64756008)(66446008)(66946007)(83380400001)(31686004)(36756003)(66556008)(316002)(54906003)(6512007)(122000001)(66476007)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDE3dk5iUzJ0ckFPVkszNXV2Rm9KVGtWSHF6Tm5zL3RpQnQ5Wmx3YTdoVUYr?=
 =?utf-8?B?UzQrT3hXemZDMWw3cVlKZ29wTElpREZBQUxka01nYmlaZ1RuUHpCVit2UHp5?=
 =?utf-8?B?YzdnWmR6R0RLSUNDTFo3SHg4RmJPZm0rbHRCbjZtT0lsMXNaNXdJekFHZ0l5?=
 =?utf-8?B?Mk5SL1VBQitscXFMVVNqWUlJdkdjWFVKWEVNaWlQSHFQSldEL0RyZ0R4ODJ3?=
 =?utf-8?B?NUpWdHNQZVVUME4yeUUrcUV0Qk5LVzJaZWRMZXJYbWtqanFSU1ZOSHJDcUNH?=
 =?utf-8?B?MzJiTGxFVGh4NnVEVDk4MFVQWmdpRmVuUjZZbTZMeXJvb1VMbEVBZURKQzRx?=
 =?utf-8?B?TCtOWHpCSS9SdlRHbnpSdVJHN1p0R0I2U2tseWp2L1JaQjJFcm1vL3VTNGl5?=
 =?utf-8?B?dkcvb01OclUzZ2gyNEhTZHhBanZWY3lLK005VE9iRkFJMW1IMEJ2ZVVmeDE1?=
 =?utf-8?B?STVuMFRtaFcvQU9qaFJLcC8wK3E4TmozRjNValNqNVlVNitFZjEzVnRkdG8x?=
 =?utf-8?B?WE94OHdiK1V0bHVEOEdCdzRlMER4WlAxMkdVMWd2UTlTNUQybzdhRWtRWHRn?=
 =?utf-8?B?eE1neUpyR3R0cXU1V3hOSklmdzQxTWhFYkVOWGQ1ZnN6MVQwZlVsNXNUc1RR?=
 =?utf-8?B?a0JJWjRLWkJ0K1FRL1hwYytUS2NZZUZTci8xeUZhOGRuT3pBWkpJeTNONHBF?=
 =?utf-8?B?VHhTNFVpdEVwODUrT3Q5eXd3dDRVYnRmakFVaTQ2U1hHRFR0cXV5bDlhMXF1?=
 =?utf-8?B?SmJVWEZOVExtVnRhM1Zmcjc4SVlZb0s5ajY3R2J0ZkRlQ0lzN05ZYi9HSXRt?=
 =?utf-8?B?cmd4NDdhV09uVjBPMnNkd0gxRjBRMzNZTnRZc1pKamw1R2E0VmNPSWtsc01L?=
 =?utf-8?B?azBwc1ZxMmMwSXhVMit4bm85ZTFqc3VHcFAyRHBtdldHTThwdE5jMmNZN3VF?=
 =?utf-8?B?UmlIQklocmh5YnBQZ0xKV2VDZVZlYWR2NXJwRHJDY3grV2Z2dmU0RjlDMVli?=
 =?utf-8?B?Q3RYYm1VemNXQWpxb0hyREYrSWV2TVpkTURweGR1YVpKZlpwcnFQTSswcTFY?=
 =?utf-8?B?TVRiUzJPalQyWXFSTkNybmh2MHNQQ3lBOWZkZkJncHVNbU5YL3ZUQ091T2N2?=
 =?utf-8?B?T2pVbDNYZzRyZEtVd1UxU2F6R0cycCtLNy9idGxZSlBRRkkwaWxmWEZTSkxq?=
 =?utf-8?B?bDN6VTdzVDE1bWNaUFByMGdzRWNQWTRHcjMxcHlIbWpvcWUvQVR6R083WGNm?=
 =?utf-8?B?anZaV3l3YTFrVWhhRlVHVWR5U2VFRnFDZUllWmlycEJRb3RsQVRnOG1kZ3BG?=
 =?utf-8?B?MmV1YXJ1QS9SU0FOZ0RBclhUdG1qR3VWMHVNRE9hS1ljWVBHdDU3UTZUZ0pB?=
 =?utf-8?B?M0dGd0NWdWFVTG9Oa3pzRjRHdEoxTDA0dnJTb1dReU9QWUJDOEYxNUQ2U0lG?=
 =?utf-8?B?U0dtOEsxUE0xOVVyVG9odWxFYkc1alh1enF1OFB0UDZHZWMwbkZJYmxuMnZ2?=
 =?utf-8?B?TExHV29INHdXTTdmZDVkb054M0s3S2xtZmNUUm9DL2tBVTA2dWc5VXhzdXM1?=
 =?utf-8?B?bzdWa2dVaHJTS1FvTk5mb0RSbDRpYklvZ1M1UkhSZ29BdHFFQVJaZm1UU3BW?=
 =?utf-8?B?S0Nyczk5bmV3Q0pVUzlsYytZc3RuRVVoeUNUTjltV3pXdGdDbHZGTS8rLzJp?=
 =?utf-8?B?QS9vdXZucnpXTUJYc21NOFdjQjFrOTJ6Q1QxOHJzdk1Pc0NqT1E1Ly9YOU9T?=
 =?utf-8?B?WlpucWd5VTIwcEVSbld4OHdSMGdqbnB3ck0vTzhRcHFDaTArMndIMDdwYmhY?=
 =?utf-8?B?MFo3amMwSHlDRnVRQlY5REFQckRuTmJlWnJoL2E2OW1pWFlUQzZ1QXBvNHNp?=
 =?utf-8?B?L3FoWDNiVnhEQjNrRzRlMHltVDVQUjB4SmVHdlhrYXU5d21RbFF2TXo2S3R5?=
 =?utf-8?B?N2hkenZGdXNockZoa25GMFc1ZXc3ZnlFdjMrUFZkL0toWmlBMFZXNHRrVkRG?=
 =?utf-8?B?VEQ3YlRFNWJ0YklxeEo3MHo5OXY0RGRKS2R2Tk1QNUUxWkNpYzJiRFJSdWM3?=
 =?utf-8?B?WlJocVVOcWtJdHV5RUo1b3NUNkgvY0lIV3ZMTEpHMU4zUnlrWVBPbGhIdEU3?=
 =?utf-8?B?MHlXTEcwanJsVnlQSi9zaSsvK0ErNUpvc3ZEbGxrWHowZjRNZCtxWXVybmUv?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62E5EC72C63A774EA70C16BC7C74550B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f57141-0695-4d91-7233-08d9dac6f1de
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 21:10:24.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2hIfMebtTAcjTcvhIZ62U2yotgIjpYPsAZlh0GxxARehIlYNKtuvXyt+VYpBvWO1/W2/COls5B+rAg3Gj8l1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VhbiwNCg0KU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gSGkgVGhpbmgsDQo+IA0KPiBPbiAx
LzE4LzIyIDM6MDAgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IFNlYW4gQW5kZXJzb24gd3Jv
dGU6DQo+Pj4gSGkgVGhpbmgsDQo+Pj4NCj4+PiBPbiAxLzE4LzIyIDI6NDYgUE0sIFRoaW5oIE5n
dXllbiB3cm90ZToNCj4+Pj4gSGkgU2VhbiwNCj4+Pj4NCj4+Pj4gQmFydWNoIFNpYWNoIHdyb3Rl
Og0KPj4+Pj4gSGkgU2VhbiwgVGhpbmgsDQo+Pj4+Pg0KPj4+Pj4gT24gRnJpLCBKYW4gMTQgMjAy
MiwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+Pj4+PiBUaGlzIGlzIGEgcmV3b3JrIG9mIHBhdGNo
ZXMgMy01IG9mIFsxXS4gSXQgYXR0ZW1wdHMgdG8gY29ycmVjdGx5DQo+Pj4+Pj4gcHJvZ3JhbQ0K
Pj4+Pj4+IFJFRkNMS1BFUiBhbmQgUkVGQ0xLX0ZMQURKIGJhc2VkIG9uIHRoZSByZWZlcmVuY2Ug
Y2xvY2sgZnJlcXVlbmN5Lg0KPj4+Pj4+IFNpbmNlDQo+Pj4+Pj4gd2Ugbm8gbG9uZ2VyIG5lZWQg
YSBzcGVjaWFsIHByb3BlcnR5IGR1cGxpY2F0aW5nIHRoaXMgY29uZmlndXJhdGlvbiwNCj4+Pj4+
PiBzbnBzLHJlZi1jbG9jay1wZXJpb2QtbnMgaXMgZGVwcmVjYXRlZC4NCj4+Pj4+Pg0KPj4+Pj4+
IFBsZWFzZSB0ZXN0IHRoaXMhIFBhdGNoZXMgMy80IGluIHRoaXMgc2VyaWVzIGhhdmUgdGhlIGVm
ZmVjdCBvZg0KPj4+Pj4+IHByb2dyYW1taW5nIFJFRkNMS1BFUiBhbmQgUkVGQ0xLX0ZMQURKIG9u
IGJvYXJkcyB3aGljaCBhbHJlYWR5DQo+Pj4+Pj4gY29uZmlndXJlDQo+Pj4+Pj4gdGhlICJyZWYi
IGNsb2NrLiBJIGhhdmUgYnVpbGQgdGVzdGVkLCBidXQgbm90IG11Y2ggZWxzZS4NCj4+Pj4+Pg0K
Pj4+Pj4+IFsxXQ0KPj4+Pj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyMjAxMTQwNDQyMzAuMjY3NzI4My0xLXJvYmVydC5o
YW5jb2NrQGNhbGlhbi5jb20vX187ISFBNEYyUjlHX3BnIU0zekt4RFpDOWFfZXRxelhvN0dTRU1U
SFJXZmMxd1JfODR3d000LWZTaGlBMzVDc0djeGNURWZmSFBicHJiZEM0ZDJSJA0KPj4+Pj4+DQo+
Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBUaGluaCwgeW91IHN1Z2dlc3RlZCB0aGUgZGVkaWNhdGVkIERU
IHByb3BlcnR5IGZvciB0aGUgcmVmZXJlbmNlDQo+Pj4+PiBjbG9jazoNCj4+Pj4+DQo+Pj4+Pg0K
Pj4+Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9kNWFjYjE5Mi04MGI5LTM2ZjctNDNmNS04MWYyMWM0ZTZiYTBAc3lub3BzeXMuY29tL19f
OyEhQTRGMlI5R19wZyFNM3pLeERaQzlhX2V0cXpYbzdHU0VNVEhSV2ZjMXdSXzg0d3dNNC1mU2hp
QTM1Q3NHY3hjVEVmZkhQYnByYnBPRm12WCQNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IENh
biB5b3UgY29tbWVudCBvbiB0aGlzIHNlcmllcz8NCj4+Pj4+DQo+Pj4+DQo+Pj4+IFVubGVzcyB0
aGVyZSdzIGEgZ29vZCB3YXkgdG8gcGFzcyB0aGlzIGluZm9ybWF0aW9uIGZvciBQQ0kgZGV2aWNl
cywgbXkNCj4+Pj4gb3BpbmlvbiBoYXNuJ3QgY2hhbmdlZC4gKEJ0dywgSSBkb24ndCB0aGluayBj
cmVhdGluZyBhIGR1bW15IGNsb2NrDQo+Pj4+IHByb3ZpZGVyIGFuZCBpdHMgZHVtbXkgb3BzIGlz
IGEgZ29vZCBzb2x1dGlvbiBhcyBzZWVtcyB0byBjb21wbGljYXRlDQo+Pj4+IGFuZA0KPj4+PiBi
bG9hdCB0aGUgUENJIGdsdWUgZHJpdmVycykuDQo+Pj4NCj4+PiBDYW4geW91IGV4cGxhaW4geW91
ciBzaXR1YXRpb24gYSBiaXQgbW9yZT8gSSdtIG5vdCBzdXJlIGhvdyB5b3UgY2FuDQo+Pj4gYWNj
ZXNzIGEgZGV2aWNlIHRyZWUgcHJvcGVydHkgYnV0IG5vdCBhZGQgYSBmaXhlZC1yYXRlIGNsb2Nr
Lg0KPj4+DQo+Pj4gLS1TZWFuDQo+Pg0KPj4gQ3VycmVudGx5IGZvciBkd2MzIHBjaSBkZXZpY2Vz
LCB3ZSBoYXZlIGdsdWUgZHJpdmVycyB0aGF0IGNyZWF0ZSBhDQo+PiBwbGF0Zm9ybV9kZXZpY2Ug
d2l0aCBzcGVjaWZpYyBwcm9wZXJ0aWVzIHRvIHBhc3MgdG8gdGhlIGR3YzMgY29yZQ0KPj4gZHJp
dmVyLiBXaXRob3V0IGEgcmVmIGNsb2NrIHByb3BlcnR5LCB3ZSB3b3VsZCBuZWVkIGFub3RoZXIg
d2F5IHRvIHBhc3MNCj4+IHRoaXMgaW5mb3JtYXRpb24gdG8gdGhlIGNvcmUgZHJpdmVyIG9yIGFu
b3RoZXIgd2F5IGZvciB0aGUgZHdjMyBjb3JlDQo+PiBkcml2ZXIgdG8gY2hlY2sgZm9yIHNwZWNp
ZmljIHBjaSBkZXZpY2UncyBwcm9wZXJ0aWVzIGFuZCBxdWlya3MuDQo+IA0KPiBUaGUgcHJpbWFy
eSBwcm9ibGVtIHdpdGggdGhlIGV4aXN0aW5nIGJpbmRpbmcgaXMgdGhhdCBpdCBkb2VzIG5vdA0K
PiBjb250YWluIGVub3VnaCBpbmZvcm1hdGlvbiB0byBjYWxjdWxhdGUgdGhlIGZyYWN0aW9uYWwg
cGVyaW9kLiBXaXRoIHRoZQ0KPiBmcmVxdWVuY3ksIHdlIGNhbiBjYWxjdWxhdGUgdGhlIGNvcnJl
Y3QgdmFsdWVzIGZvciB0aGUgcmVnaXN0ZXJzIHdpdGhvdXQNCj4gbmVlZGluZyBhbiBhZGRpdGlv
bmFsIGJpbmRpbmcuIFNvIHdlIG5lZWQgdG8gdHJhbnNpdGlvbiB0byBzb21lIGtpbmQgb2YNCj4g
ZnJlcXVlbmN5LWJhc2VkIHN5c3RlbS4gU28gcGVyaGFwcyB3ZSBzaG91bGQgYWRkIGEgInJlZi1j
bG9jay1mcmVxdWVuY3kiDQo+IHByb3BlcnR5IGFuZCB1c2UgdGhhdCBhcyBhIGRlZmF1bHQgZm9y
IHdoZW4gdGhlIGNsb2NrIGlzIG1pc3NpbmcuDQo+IA0KDQpOb3Qgc3VyZSBhYm91dCBvdGhlcnMs
IGJ1dCB0aGF0J3MgZmluZSB3aXRoIG1lLiBUaGUgb3RoZXIgc29sdXRpb24gaXMgdG8NCnJld29y
ayB0aGUgZHdjMyBkcml2ZXJzIGFzIFJvYmVydCBub3RlZCwgYnV0IHRoYXQgcmVxdWlyZXMgc29t
ZSB3b3JrLg0KDQpUaGFua3MsDQpUaGluaA0KDQo=
