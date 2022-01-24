Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6449A245
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 02:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2361439AbiAXXkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:40:05 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34928 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1842487AbiAXXB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:01:57 -0500
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 610D040A17;
        Mon, 24 Jan 2022 23:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643065317; bh=/i8M7fhsFYi2KUKGg2rHoyApuN3vIDmVj8OJqBLoBA8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aF3goWaoNMjZOBaLsGl+5nt91jbvwAuR+c9hMOi+rNjzd2MFpe9fSQKm+1ot5mfuN
         BqTxYsCRW1LBzqEqrVq6z0mzviK5sV9beRAeC3Ii8UOBKIh4JtJcCn7GhQMS2P3hdw
         4sr0bqDm5NUC5q+ke1PqIUmyDhAdFb9+FzDVYvNPCUWXc9EKHnMVxDc/m8mA7UZkUC
         BlJjdZvs27vxm3IG0yEo1JP75xvspH6odPVBLOJ4zVSa6YvFOTSoQbETcdgIgfKXbZ
         kjSaaJPl0l/s/biUSRHHlQ9zd9vxB74cT3O/oJO+7VX3AEg2fKpaLvbd6fhQYFUjP8
         35IOIy2/Dta7A==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 953B0A005C;
        Mon, 24 Jan 2022 23:01:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D6395400CD;
        Mon, 24 Jan 2022 23:01:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="vGttF5d0";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWq2HaiWYZSzukHvx6eTAM9tASjSf5A5OM+p5xrND/pGMmhlwYo6N220yc3upCUcrdT335aJQZIk9wosKzbxepO+eOgNmbuXWL7MdmLjHgwJUhNL3CSQeiTF7AymEYFMRScjTnVxNZGxHc4hxxdYIJI2ZlEhy18QB+DpognqcA2pmXUodW5jdTUdk0UhOxG5f9mRjODz8oLN4snGSjazi4flf8WiYDimWfBJ37QgqmollfVnYg504pTnjiB5GwIZHCyqndU7vGO2mlvL8bGVUCVzpwcEQ/zSiwtoiCWbHlb8SA962tAOGrfWDa6Vr/gDL+c8dTZ5WFhWi2ulaAWlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i8M7fhsFYi2KUKGg2rHoyApuN3vIDmVj8OJqBLoBA8=;
 b=bdq/ffvilgenv1Sh2LRhLRcxpm9eRv1b5gTDTHVPwQ6JkG1RVziW2R5YzQ2UcqYm36ItV9T1GuapXYw7+yLbusgr5Sqlv1hiaY5IoJKA/3Gv2Tmgnp2ZFwuCG23aA8iCieUtMlbtyVJ+yJkfplf55fLkeSAVfBk5nHUNx9TvHbCxVolAQ9uldLVINLBlmr7tptlhvT085yJuvmXg6dl4bXeZyMQxU0nPX+3YnHEt/VJg06WUC6pAWZJlsZxhoVU2Tw8fLhqjlk6H7FWu1xspN0mOPCl6gAZPuu2Q6j3+axu0krw/aDRYgC64sQ9sEpEsgvg1pg+VakPg0MjPeKIFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i8M7fhsFYi2KUKGg2rHoyApuN3vIDmVj8OJqBLoBA8=;
 b=vGttF5d0PUODQWL17k7/+luIw9VaMiQGPuuaoicTc1o2xV4YcUI1Gsco/TqI7aA14XgXDJC/AK4QvFYeO/4NvkeUFqAj5247hi7Kt0M71Z4Ao9Jir7m7r2mCN6AAEUZ7MKbJNnEAEGRuGYozcgtJGoqyBlLWPVmT3X18H5lsSqI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB4728.namprd12.prod.outlook.com (2603:10b6:a03:a3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 23:01:44 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 23:01:44 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Kathiravan T <kathirav@codeaurora.org>
CC:     Sean Anderson <sean.anderson@seco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
Thread-Topic: [PATCH v2 0/7] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
Thread-Index: AQHYDMr/ULJkWl9vekiuZLnGIG7Dm6xqpxoAgAC7FYCAAFV0AIAGmBYAgACDZoA=
Date:   Mon, 24 Jan 2022 23:01:44 +0000
Message-ID: <f4b22ec2-b3b5-21dd-bc21-f5292d5b138a@synopsys.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <87ee53fv01.fsf@tarshish> <1965fc315525b8ab26cf9f71f939c24d@codeaurora.org>
 <871r12g0j2.fsf@tarshish> <e1309c23-530b-c698-b7ba-4f1a5226fe8c@quicinc.com>
In-Reply-To: <e1309c23-530b-c698-b7ba-4f1a5226fe8c@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83d84df2-e5b4-4b9b-fbbb-08d9df8d7dae
x-ms-traffictypediagnostic: BYAPR12MB4728:EE_
x-microsoft-antispam-prvs: <BYAPR12MB4728BB6D34102C4B85A469DCAA5E9@BYAPR12MB4728.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6lcY5gPd5T3lpEcHY6GiELL927HQukOuaDb9dQf04xg7hHtigZ14FUv/NTm+Gi39g2wVBkhxOc6JowcrD9c+F1Kll12aoaSs7+vOoP9kcwRkWjdF+N8MuATJi6IclIfOgvj4E5p2cHeBn4eShUZ2BYR+CBw89yLDLG5iqTb2SyEiDjalwhLrmhN6fw5UeAHpTfOQpwxUR9IcDJIBw2vVhLlpN2AHi+gXYsaS7wIRoIGDCrxVXffM630bdpFc7Fo5HdwBL/1AH4l8KZbk2OmK0U0EYNWSiZ5XMr42OtqbXtBjbxxZgyU2v529AnWCxzWA/NeefJq6GJqch3VSW+6IoAj8ryavIHo/AxCHnV72HHf5UzfvMtdzLStq8AIoVCy+l6BdvapAUKnqitkB0Z0yBtms8aL4gH0xEVT8ZWxm+WL9TZC/fDfcFvHpumD8X8IoYqasyf+/c702ekRg5/C5JZ8DmZyDkzB7wecpB9s7OT/pMmXFFTbO5jfDKH/o6SCRLeZV84cMfM8BelKKyOOqwFDArAVowMx66MGZKwDu3kqnoUVykozMNfgH+/Ben3FcG3nbty2DAxs7sr78icbmivaJxLEiS/8Yob12EFVYzEClbixv+Sq30EUBdSsFzOiZJRBQoeXHhQqZTOV3zNThUVMnZdppOJLRVX5ZARHDcoQrTBsEADTfwNHer0q+uvOyH7Nt+MH6VkuUkNBVoCp2himQ0zUWDcmUeMmSn/U3Rgib44G35Dm+IrTu1VNiunBRk/U5VVvjRucMHKIo1c8n3TmIEZ0y9K1oP0Pmr7z7LnAzrO+IBdjmm+Fr52zXuuMhXpyAPTX43zjTOThqFTB4rl0uod0BR9MJTOqnNFtKy8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(76116006)(7416002)(64756008)(66446008)(38070700005)(186003)(316002)(4326008)(53546011)(31686004)(6512007)(966005)(38100700002)(8936002)(71200400001)(54906003)(110136005)(36756003)(66556008)(2616005)(31696002)(66946007)(508600001)(6486002)(122000001)(2906002)(83380400001)(8676002)(5660300002)(66476007)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFBBcGxRMVJUTVNlQzZ0VG8zVHpzYlVIeGlTdXhEME1IMVFucEE4a3owb2pj?=
 =?utf-8?B?QTVya05KL3o1MlNqK2VGcTdFL0oyNlZ6YVVWQTRxWEVMNjRuam5zTmlYaC9T?=
 =?utf-8?B?K0lOTW5uWlhxYkk0dG9uMjlwUlQwVGNHR3BOYTVDRmhKZDkwZmQvc055aUlD?=
 =?utf-8?B?R2U4Z0NVMmRUQTRVd3pVeUNNLzhPOXZCWldKYlRNL1FsMGlnV2w2TWhWMCtL?=
 =?utf-8?B?UTFadmVzbEgxeFhQd3R2RXZkanJJNmVHa0FCL0VkL1cxY0V5TlpLbm5JVG9n?=
 =?utf-8?B?Q0I2ejVuK2FTN3pqUUlLTzVIRGJlbW0rTG52ekRHTG41ZTc5cVUzSWpGUDVm?=
 =?utf-8?B?Q3R2WGxYaWxMTXZpMUluWTdGUFRoZjVEWVNtaCtrODVRS05jbkZJUzRaTGJ6?=
 =?utf-8?B?c3VDMnl0SXVnSFVWY1JSSzBnNnJpZlZyUVZjZ1NROXU0RXB4a2VXTmRtanFy?=
 =?utf-8?B?Z1NNbjZtSjZCYjBLK2MvTFVQdnBwV3NZTlJkUWd5Y1pza3k5MVhoR3gxNDBF?=
 =?utf-8?B?WWFXSE1mZzdDNjV6R3NZQU1mOG9wcUp6eEZIdDVIVEpJLytxZjFScXMrUmRh?=
 =?utf-8?B?OWxKNi9Ca3M1ZDlVcVJzRXYvNlppVCtHSlRTR1VtNjRrT0xCd2lUTWwySXdU?=
 =?utf-8?B?cDlLUVVnbmVHK3RZUkowOUI3RjA3TndLakgvdkxuUUNmN0ZRTStzU0Y3clp0?=
 =?utf-8?B?VnV0ay9PK2hXb0J4RHJmdVQvbTBobkM5ditRVklQMW1mZ0R0NTE2YVJydzBj?=
 =?utf-8?B?ZG9sS1VlblpYWUZBczFnK2dFLzNINlNNTUd0Y25jWHVyNWhicTMrNzhDL1RQ?=
 =?utf-8?B?RVY0cjlMNi9kc2ozbEZwRlY4UEw3VXBUa3U5SHk2OUV5OFNQZUFvamlEOCtN?=
 =?utf-8?B?ZHlsVThYeFdaWGJKNVpDK1dXZnFudm9CT05zdWsxVFc3akhUS2JCTTlNSXF4?=
 =?utf-8?B?Q0FDRm1rc2QxZ0Y1N2tjSllkbFVXMW1XWDRsejhIYnVTV2xvekdicUlBWkFV?=
 =?utf-8?B?TEFHdjlmbmhDQkhNamVGMFJKR3Z2c0FjQnBWSk5NZlNNRExhRTFqNHVwVXlv?=
 =?utf-8?B?ODBkSVFJc1Zzcm5sVWE1ZFpHSmFNN1U2RjNXcjFnemk4K2lPK1paUy9LRTdZ?=
 =?utf-8?B?VHl0WnZ1cTEvWUthSnpEeVhTYjJYWk5BOXFKcHBYQklWdUtqUkJuZjM1eHJP?=
 =?utf-8?B?Y2xveWRHZGI5K21WTTBGamw5eWhoUmZoSGNvcjN5SVNsbXJpQm5tMXNqVCs4?=
 =?utf-8?B?a1EvNHU2dnVGVmZ3ZnRDNDFIWW1LU0hnUE54RWtXUS9LbnUzdGk5UFdlVDRt?=
 =?utf-8?B?L1kvK0JVQURESFhqVkhQU0FMN0haeWRXbG9uYVNyWXZzMkJLT3d6UXBpRWZw?=
 =?utf-8?B?eU1RVVBvL3pBRU9lOTkzbTR2b2IwYWV0Nml2VGVvZzVvaFJtaFJzRkJzYU1n?=
 =?utf-8?B?MDhVb0pRb1FIeGhpQ0pCM2MyZTlvNHFLTlh4c2JocFR4NWNyUVZuNytGUkZ0?=
 =?utf-8?B?c1MrL0VxM3U2YWx3dGtFMnNQdTdPUXk4QXNHS3NoYTk0b3RwdTFncFBSbW5H?=
 =?utf-8?B?WjlPenJpV21WVTB3amsvSzlnelJtYWdjT2hlR2dQOE1XT0FQTnNhM0VFVHZi?=
 =?utf-8?B?OUhyMHBsbXlwKzF0UERjQUdLYUdmOGk1UmU3TGljdXpNRExKRmZDWHV1M2FC?=
 =?utf-8?B?Y2tvRVpoajVGVGhHTU41dU9Qb21vYzQrNUFYcEN3MGRlY1dCUHBjTVlVUTFN?=
 =?utf-8?B?di9ITUhlWDU0cm1obTBKNUlxV1NZVjR3bkRIR3hCUFpReEx3eVQ4aE1MKzdi?=
 =?utf-8?B?b1VZeHhhN0xQYTFzWlY1eDFUclhkN0swc0pIUzZ5ZlE1aEs3Y1hoVEg1cFdS?=
 =?utf-8?B?MmJDSVpNUXY5RzdIVkpFaFRheFVJRTNsSVV3Nk9Kejl4bGRDSFQrRXM5ZnNv?=
 =?utf-8?B?Qjc2bDJNclNzMUtrUnFWeWxQSDdiNmNDZlRhNFpnVURBT3I3ODliK0ZyMGF5?=
 =?utf-8?B?eFFWOGJUVTdsbU1BU1hkcThtdmQ2cVBMZHo2UFhhc3VRNFk0ZkQ1UUN3YWs3?=
 =?utf-8?B?a2ZSVnloWDlYT2NGazRmTlFMWkRxZWJZblFPdmlhaHRLSlZWTzdIOVFmZzhu?=
 =?utf-8?B?L1ljRDk2VlRLeWxpNGNuQVNURDZqdUFmZEg1Qjh5dG9HWGcxZHlCMkxIb1ZN?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29028F79CEE9DA4A9C9BDFD2187267CF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d84df2-e5b4-4b9b-fbbb-08d9df8d7dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 23:01:44.0232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMWUCfmpu0zyXVXXDaGgLo7QArLMh51So6rGulalLOKTlv+A1So6RQwsaP2d+VBMWXKQu2In/Jg78iMMA2uf/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4728
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S2F0aGlyYXZhbiBUaGlydW1vb3J0aHkgd3JvdGU6DQo+IEhpIEJhcnVjaCwNCj4gDQo+IE9uIDEv
MjAvMjAyMiAzOjU5IFBNLCBCYXJ1Y2ggU2lhY2ggd3JvdGU6DQo+PiBIaSBLYXRoaXJhdmFuLA0K
Pj4NCj4+IE9uIFRodSwgSmFuIDIwIDIwMjIsIEthdGhpcmF2YW4gVCB3cm90ZToNCj4+PiBPbiAy
MDIyLTAxLTE5IDIzOjQ0LCBCYXJ1Y2ggU2lhY2ggd3JvdGU6DQo+Pj4+IEhpIFNlYW4sDQo+Pj4+
IE9uIFR1ZSwgSmFuIDE4IDIwMjIsIFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+Pj4+PiBUaGlzIGlz
IGEgcmV3b3JrIG9mIHBhdGNoZXMgMy01IG9mIFsxXS4gSXQgYXR0ZW1wdHMgdG8gY29ycmVjdGx5
DQo+Pj4+PiBwcm9ncmFtDQo+Pj4+PiBSRUZDTEtQRVIgYW5kIFJFRkNMS19GTEFESiBiYXNlZCBv
biB0aGUgcmVmZXJlbmNlIGNsb2NrIGZyZXF1ZW5jeS4NCj4+Pj4+IFNpbmNlDQo+Pj4+PiB3ZSBu
byBsb25nZXIgbmVlZCBhIHNwZWNpYWwgcHJvcGVydHkgZHVwbGljYXRpbmcgdGhpcyBjb25maWd1
cmF0aW9uLA0KPj4+Pj4gc25wcyxyZWYtY2xvY2stcGVyaW9kLW5zIGlzIGRlcHJlY2F0ZWQuDQo+
Pj4+PiBQbGVhc2UgdGVzdCB0aGlzISBQYXRjaGVzIDMvNCBpbiB0aGlzIHNlcmllcyBoYXZlIHRo
ZSBlZmZlY3Qgb2YNCj4+Pj4+IHByb2dyYW1taW5nIFJFRkNMS1BFUiBhbmQgUkVGQ0xLX0ZMQURK
IG9uIGJvYXJkcyB3aGljaCBhbHJlYWR5DQo+Pj4+PiBjb25maWd1cmUNCj4+Pj4+IHRoZSAicmVm
IiBjbG9jay4gSSBoYXZlIGJ1aWxkIHRlc3RlZCwgYnV0IG5vdCBtdWNoIGVsc2UuDQo+Pj4+IFRl
c3RlZCBoZXJlIG9uIElQUTYwMTAgYmFzZWQgc3lzdGVtLiBVU0Igc3RpbGwgd29ya3MuIEJ1dCB0
aGUgd2l0aA0KPj4+PiAicmVmIg0KPj4+PiBjbG9jayBhdCAyNE1IeiwgcGVyaW9kIGlzIGNhbGN1
bGF0ZWQgYXMgMHgyOS4gUHJldmlvdXMNCj4+Pj4gc25wcyxyZWYtY2xvY2stcGVyaW9kLW5zIHZh
bHVlIHVzZWQgdG8gYmUgMHgzMi4NCj4+Pj4gSXMgdGhhdCBleHBlY3RlZD8NCj4+PiBZZXMsIGl0
IGlzIDB4MjkgZm9yIElQUTYweHggYmFzZWQgU29Dcy4gSW4gZG93bnN0cmVhbSBpdCB3YXMgd3Jv
bmdseQ0KPj4+IG1lbnRpb25lZA0KPj4+IGFzIDB4MzIsIHdoaWNoIHdhcyBjb3JyZWN0ZWQgcmVj
ZW50bHkuDQo+PiBUaGFua3MgZm9yIHRoZSB1cGRhdGUuIFRoaXMgbmVlZHMgZml4aW5nIGluIHVw
c3RyZWFtIGtlcm5lbC4gSSdsbCBzZW5kIGENCj4+IHBhdGNoLg0KPj4NCj4+IEZvciBzb21lIHJl
YXNvbiBVU0IgYXBwZWFycyB0byB3b3JrIGhlcmUgd2l0aCBib3RoIHZhbHVlcy4gSXMgaXQgYmVj
YXVzZQ0KPj4gSSBvbmx5IHVzZSBVU0IyIHNpZ25hbHM/IElmIHRoaXMgaXMgdGhlIGNhc2UgdGhl
bSBJIGNhbiBub3QgYWN0dWFsbHkNCj4+IHRlc3QgdGhpcyBzZXJpZXMgb24gbXkgc3lzdGVtLg0K
DQpUaGUgY29udHJvbGxlciB1c2VzIHRoZSBHVUNUTC5SRUZDTEtQRVIgdW5kZXIgc3BlY2lmaWMg
Y29uZGl0aW9ucyBhbmQNCnNldHRpbmdzLCBhbmQgdGhlIGNvbmRpdGlvbnMgYXJlIGRpZmZlcmVu
dCBiZXR3ZWVuIGhvc3QgbW9kZSBhbmQgZGV2aWNlDQptb2RlLiBGb3IgZXhhbXBsZSwgaWYgeW91
J3JlIHJ1bm5pbmcgYXMgZGV2aWNlLW1vZGUgYW5kIG5vdCBvcGVyYXRpbmcgaW4NCmxvdyBwb3dl
ciwgYW5kIG9yIG5vdCB1c2luZyBwZXJpb2RpYyBlbmRwb2ludHMsIHlvdSdyZSBub3QgcHJvYmFi
bHkNCnRlc3RpbmcgdGhpcy4NCg0KQlIsDQpUaGluaA0KDQoNCj4gDQo+IEkgY291bGQgcmVjb2xs
ZWN0IHdlIGRpZCBzZWUgc29tZSBpc3N1ZSBvbiBVU0IyLjAgcG9ydCBhcyB3ZWxsLCBidXQgaXQN
Cj4gd2Fzbid0IGZhdGFsIG9uZS4gQW55d2F5cyBpdCBpcyBiZXR0ZXIgdG8gdGVzdCBpdC4NCj4g
DQo+IFRoYW5rcywNCj4gDQo+IEthdGhpcmF2YW4gVC4NCj4gDQo+Pg0KPj4gVGhhbmtzLA0KPj4g
YmFydWNoDQo+Pg0KPj4+Pj4gWzFdDQo+Pj4+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjIwMTE0MDQ0MjMwLjI2NzcyODMt
MS1yb2JlcnQuaGFuY29ja0BjYWxpYW4uY29tL19fOyEhQTRGMlI5R19wZyFNQ3FxVEdZVFI0Mi00
X0xVSGhyU0pqa1VPa0RaS2I3OTVJOGxCM1BZNGRCLWtWQ0JuUjlZS3VjZ3pyd2hsajB0WlptNSQN
Cj4+Pj4+IENoYW5nZXMgaW4gdjI6DQo+Pj4+PiAtIERvY3VtZW50IGNsb2NrIG1lbWJlcnMNCj4+
Pj4+IC0gQWxzbyBwcm9ncmFtIEdGTEFESi4yNDBNSFpERUNSDQo+Pj4+PiAtIERvbid0IHByb2dy
YW0gR0ZMQURKIGlmIHRoZSB2ZXJzaW9uIGlzIDwgMi41MGENCj4+Pj4+IC0gQWRkIHNucHMscmVm
LWNsb2NrLWZyZXF1ZW5jeS1oeiBwcm9wZXJ0eSBmb3IgQUNQSQ0KPj4+Pj4gU2VhbiBBbmRlcnNv
biAoNyk6DQo+Pj4+PiDCoMKgIGR0LWJpbmRpbmdzOiB1c2I6IGR3YzM6IERlcHJlY2F0ZSBzbnBz
LHJlZi1jbG9jay1wZXJpb2QtbnMNCj4+Pj4+IMKgwqAgdXNiOiBkd2MzOiBHZXQgY2xvY2tzIGlu
ZGl2aWR1YWxseQ0KPj4+Pj4gwqDCoCB1c2I6IGR3YzM6IENhbGN1bGF0ZSBSRUZDTEtQRVIgYmFz
ZWQgb24gcmVmZXJlbmNlIGNsb2NrDQo+Pj4+PiDCoMKgIHVzYjogZHdjMzogUHJvZ3JhbSBHRkxB
REoNCj4+Pj4+IMKgwqAgdXNiOiBkd2MzOiBBZGQgc25wcyxyZWYtY2xvY2stZnJlcXVlbmN5LWh6
IHByb3BlcnR5IGZvciBBQ1BJDQo+Pj4+PiDCoMKgIGFybTY0OiBkdHM6IHp5bnFtcDogTW92ZSBV
U0IgY2xvY2tzIHRvIGR3YzMgbm9kZQ0KPj4+Pj4gwqDCoCBhcm02NDogZHRzOiBpcHE2MDE4OiBV
c2UgcmVmZXJlbmNlIGNsb2NrIHRvIHNldCBkd2MzIHBlcmlvZA0KPj4+Pj4gwqAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1swqDCoMKgIHzCoMKgIDcgKy0NCj4+Pj4+
IMKgIGFyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9pcHE2MDE4LmR0c2nCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDMgKy0NCj4+Pj4+IMKgIC4uLi9hcm02NC9ib290L2R0cy94aWxpbngvenlucW1wLWNs
ay1jY2YuZHRzaSB8wqDCoCA0ICstDQo+Pj4+PiDCoCBhcmNoL2FybTY0L2Jvb3QvZHRzL3hpbGlu
eC96eW5xbXAuZHRzacKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKy0NCj4+Pj4+IMKgIGRyaXZlcnMv
dXNiL2R3YzMvY29yZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAxMTINCj4+Pj4+ICsrKysrKysrKysrKysrKy0tLQ0KPj4+Pj4gwqAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMTcgKystDQo+Pj4+PiDCoCA2IGZpbGVzIGNoYW5nZWQsIDEyMCBpbnNlcnRpb25zKCspLCAy
NyBkZWxldGlvbnMoLSkNCj4+DQoNCg==
