Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E571048D551
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiAMJ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:57:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47206 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiAMJ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642067857; x=1673603857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=urRCFWEjtgFv6Xss7zquz4uNW/tpq3LMbI3ulex74XM=;
  b=pqVeXiX6+WcPyAbCnneG1BW91lHhWRCUCT/6SpaGVEIaYywNr7LzPFyz
   z6cuL0UjQxcImIJq9pB+RmGEC5n5ODX66uLi6e/2AL+v6bsquZ6iiiEw9
   YEWef6wERKAChylrno+1XzACO9rt9IAdxFiTFCuoYBmBVPbUnVJqOTjoN
   rgMX2Jgl5pv5fRfS8TwKhxNGN9WKsFnTNI+NQH6MI8e1xzjH31Xf7BX55
   3O5ZMQIonhF6Zd0NqWgWLdWEQPr98gngPuEPCbkNXfjE/5ZJhywOMlPR4
   KnYLsU7lic7hufrwP+N8sjbRu3VIAskXYUWP/L4eR+S0rXiDj8zmydnLd
   g==;
IronPort-SDR: IEtqN3p8a6MKLzmO/CvcLncf9BV6f+I3Z8+Nm8odJtENnEgL396kl2Bi4SmBLWNQWchvOWdFbg
 ZYSsi9cmNCvAG6sL1fH7lp+xIaY8lkhviqnzNfLUJCDDvAd8ZoIvqx8uq9NZlcJkumxrNeRQQe
 UgtQIiSFjsvGpWoz4wkqd3xv66yaDan7sHICSD5e+BfiTsu9h7C2VBtXk+xTySivOvmN4pYirn
 raBBN2iLPmnq5tqaQxKU8lvmROvgWfS7r9ZZdRn++h4lYSFhxduXautZZz8lKjljkpkU7pC4iX
 do35hyD967xJFGcL9FObXT6F
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="149529401"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 02:57:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 02:57:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 02:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IesEIJ9TIxynPj4T5tMAEds7W53C9R7HhZ00Wu/E3wHnupt1bh13mpS8qYzfa9ogkQQHUrviO5S+CqbItsYrJfFqWPw36qcngq8e83F8YoCL9IUpO4meMfjfUz7hfUXPvhso07CwK3OdL/rGarCKNC8tt0tiv1wFG1p2GYFkwHY/15R1PovP1fl/+iG95J5tWsOyOWCG8xWDb/q9ZEeWg5jy9cU9U5d/9b0bHTG/hnYfg2pOqZakgVqNyWYR6OpIFHsvga/L77BcxJInbkji0wn+gkhwUOFd0n4quavK66ACi4i9NOZQamyxbLG7PlhUW5W0IfLgVckuCKA6ImWrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urRCFWEjtgFv6Xss7zquz4uNW/tpq3LMbI3ulex74XM=;
 b=ngJbhu+7lqqsKnj4NQltP8mBOWNSewvF+/8h4S2IUD3lOweGqdKiBenxwJxlsOqY/uLe1N438aZ4EQOEk3SXhp0hamba2+vDLahfeGAZX8+BaQ132ECnQMH8FzzqfmzEOlf7/XR3oJ9Lnioo0f5dMY9/o0e/Ve3HxbaglUiYE9RzAR0fYJAP1YEguot7NzYZ5k3EnNp+MBY/rPOxu8jO6xPNA4kRiQKZ26kOK97HyxtVoGpSI7nayvfCK87ZRrTNnytau3PgVwFzdWY4LPFbnKt7ZKWt7K2+vwNIVEQt+2rT/0Eo2mTFHWPVA1zqeuTmEw8K7M9g6YwOtvC2PUoFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urRCFWEjtgFv6Xss7zquz4uNW/tpq3LMbI3ulex74XM=;
 b=IaXV0j3eBw4yptUd0IM3iL88OLMeu7cpErOFrnkSoLZAnkGdiVIMqCDpGBRLxjsIpgnYnRSqZoWPGy1JgcvJzlqZx895fiQ7Es91LVvo9I/KAe5KRdfxz7I2hB5oTAOyZX4cedPQNcz0GZG86P6sTe8WFLeR7eJcHBN4ipa24zk=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4075.namprd11.prod.outlook.com (2603:10b6:5:198::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Thu, 13 Jan 2022 09:57:29 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::80da:5e93:d9db:ef04]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::80da:5e93:d9db:ef04%4]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 09:57:29 +0000
From:   <Christian.Gromm@microchip.com>
To:     <nikita.yoush@cogentembedded.com>, <geert@linux-m68k.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <linux-renesas-soc@vger.kernel.org>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3 v2] arm64: dts: renesas: add MOST device
Thread-Topic: [PATCH 3/3 v2] arm64: dts: renesas: add MOST device
Thread-Index: AQHX+m4WwZB5ISlMMUaYugoVL2oSOqxcgHgAgAKvWACAAaNFAA==
Date:   Thu, 13 Jan 2022 09:57:29 +0000
Message-ID: <21e00765c8ed36d5c46f6c676b985836e7a713d8.camel@microchip.com>
References: <20211226082530.2245198-4-nikita.yoush@cogentembedded.com>
         <20211226153349.2296024-1-nikita.yoush@cogentembedded.com>
         <CAMuHMdUJfq+nFFMoiPiTt1=Ny9zOm-O1EAmq3n56n4RJ6H8tdA@mail.gmail.com>
         <fccd00c9-ec44-9586-0df2-6e46568665c1@cogentembedded.com>
In-Reply-To: <fccd00c9-ec44-9586-0df2-6e46568665c1@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5-1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8405f782-f821-46b8-a572-08d9d67b1c5b
x-ms-traffictypediagnostic: DM6PR11MB4075:EE_
x-microsoft-antispam-prvs: <DM6PR11MB40757C420A5F9AE8C6365EB0F8539@DM6PR11MB4075.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JOlAyRAYCbi1wwSbxLp5asp53w18BgoN/grMYllDvUBkRQ1VI2L6PaSQylYnJPhXH+mX5P2DwD7VHZM8YcoInr3HgF9CeobGWD60HT/qbPTB2/fjxY0N6+gXrcgj2cn+wBLmPCIFjiFjB8VHGuxYBv+5dMSxwU0p+YLx2/rbpsIma7+HniZsxFdCziiVl8H5Qx3xOPJjUrWZGsHRYROiq1A+kuSxFocmw6yCqmUZ29tD6NKE/ooo8+AcykDJa7vX4uZAK9k4Q51pUh6pbktp+LApp2iLmgL8/COSEsqgtpacWYS6JGylU/NR5aYgGGe/0R9Z7uE36V0d3v+kh8Yef8e4WCpcvZ3lQ3gvSjln4JB9NhssHArUHS0IVhPZtS+phZxVNgkdo+xT2KvHRSciQhAM902JbrYBsqoQG4TXWdq7jefXeLVGFW57DF5HXUjIVyyOl6hiBNBjUiyUsfLl1dkoxjpw/+hoj/+rGHY3hmaKDqGYq92F+Hfr/GDViJTA1/pgKhuIug+YEhjZonf9YpIqz+Zu5jtnoVr6lPPYm3jq70w/EMnBCF51Z+FXC4BY1QZTZssNn5pB0S7YvbZIb1FkFxLXRU9/hzxo1Jx0U0gcUDHpDtcGd/RfSDTkmhBOhpvxvFxbTKCgC7HvS6BSAh+XlNq3Lx9gFrYlSg0AXHfVnkCivmQHYJHhFrYlr7SMzn8RzSW75cK00zkNT40mW7eXMoH3rDxM/CzQHMAF6Wk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(66946007)(110136005)(91956017)(8676002)(6506007)(8936002)(6512007)(76116006)(26005)(66446008)(508600001)(5660300002)(4326008)(86362001)(2906002)(54906003)(66476007)(36756003)(38070700005)(186003)(122000001)(38100700002)(71200400001)(2616005)(66556008)(64756008)(6486002)(83380400001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnVwYWlvUzJPaUgvMk02MEtqdWEydjZZcTlZVXBZdzBPWTAzOHFraDd3Rmpl?=
 =?utf-8?B?bUdCY1hTK0tiVXZ0Qm9SY0RrTDU2M0hSNVZ6Wnd4b0NnY1hTSjVneHA1RTM0?=
 =?utf-8?B?T29HMFMwQUhjRG95L05YYUhoYURPaERITThoTTFVakpZMStNR1FrOHdZWmY2?=
 =?utf-8?B?eGpMM3dBWENMU1c2RDJxNS94enlVZ0thM2ZCTmh2Q3JvakFoMmVEUWszSTNt?=
 =?utf-8?B?K2JsYThsaFl1VU9kR1NGSDNNRkRRN3BvY1M4Mzg3UnJ6QVpHczFHYVlpZmxa?=
 =?utf-8?B?Tmh5c2FCUmVuajQreDRLZUhwNUZtbCtlcEwxdk1jUkNYRXVwTG9UZEhRK3Jp?=
 =?utf-8?B?dmtLNnhzaExWNWppOWR4Tnc2aWdubythaEdjQXpxY3lSMjArMUZaU2pFMkFX?=
 =?utf-8?B?SjBBOTBqaWo0elk3R0pHNysvNk43eDVrMGp4SUIwU0RzVk5kNjVTSlZHWXpS?=
 =?utf-8?B?cHB4OUpRNldtNHJ1cHRTMHNnSVFkVEZhbm93TkRjVkdoK2lPTFlucU0xUVRm?=
 =?utf-8?B?WE96T1l6Z2UrNmFyYm02QkFrSjg0N1NrZ1U3UFl2QUhCdS90cXVyRUNYMnhL?=
 =?utf-8?B?T0dvUkRCb2p4N2MvcUhBWWNvWk1KZkRPcGsxakZXN0pxK0NOR0ZiSmJ0bGxZ?=
 =?utf-8?B?d3U4RGNvUnIvQXFacHdsWXd6Znlkd3NmZzJaSEhsMCtMeDVYQWNYcHVXL21l?=
 =?utf-8?B?VnBTR0c0RFo3N1V1RFlsRmNVbDB1NTlEWm0rVlZWcGxFYjF5RGloeXhseEgv?=
 =?utf-8?B?UEx3em5ZMXR4NXFOeEhmWHhtMFlBOGYrS1RRWGtFS01odmtLU21CYSsxMEdP?=
 =?utf-8?B?UHBIMFBqREt4V0RVeFgyc2V0UmRjYkhxS21mclpnTW11S0lXZUtrdXJiaTVp?=
 =?utf-8?B?MjRLQlJVNUJmTGVBT2VYeCsyU1hrOWtzSXRhNnNRdmFidW1seUNFVVdLTVg4?=
 =?utf-8?B?dUNUaENsRUs3WSs0TlJPd2p6dm1RTGlKRkxFT1dneGxuNWN3bVRxdElvREd1?=
 =?utf-8?B?TGhlcitUdHNwOWpMUFNGdWZrU1F2YmNaL1hiVTBveFhzMGJhci9qMjJ5dlA5?=
 =?utf-8?B?WTljN0czdHBsT3o4UmRYbzErRkRPSG0rUzJNMEg2MmlXbzJnVHJuejNWT0hV?=
 =?utf-8?B?b0lmZWQ2VXpCSnQ3cjQrcGRLaXRPOFhjYW1JWmxvS3VFeHluYmhEM2E4WXRI?=
 =?utf-8?B?L3N0SlRTbmNHeThJY21yTlM0VkFzdE9peXdTVG9FN1NCWjdWM3hiUE04NWE1?=
 =?utf-8?B?UkdpdSt4T1gzVnlvUGhaSmExU0xQWUw4N2N0czlPM0cxUXlOUlp5akxDU3lZ?=
 =?utf-8?B?cXdPV1pEQjN2bXgzQWJjdzVXSUorMGt0NXVHNHRPSmwxZTVPYzBVWEZPaDBO?=
 =?utf-8?B?ZXBDR0Q3R0VyUVJoam5TcXNLTlRwd0ovd1JLMkV5Qm1Fd0pqNW5lT2V0anc2?=
 =?utf-8?B?aisycm4wdnNCSjE0ZkNQNkpPVjl5OCs4K1VMTW9ENUwvQSs2YVZ5WW9DZExY?=
 =?utf-8?B?a2drRXBlcEJmbXp4UlZINTJYeW9XMTYrVUFneUErOEdtSlh6TWc4WlJOWkF3?=
 =?utf-8?B?T1lESDJ1Rit6RndMdzg3Q0Z1cTZMRzNLMW43R2lBRkdUMmN2eHlxOWJia0wy?=
 =?utf-8?B?SkFScU9oUnhJVW82NGxjMG05dUZ6VUk4Mjd0b1YzYXVERk9RZGJZdHpmYjkx?=
 =?utf-8?B?OU5paVVWNHROdGVYdThQVDFiaVQvbTVrMXIvVjJLYS9iSFhodDE2dUlTeEdt?=
 =?utf-8?B?TUpWb3pMN0xOenU4d3NYVTVtR1hLNG82SU44bkFBTkRDN1NRY1BTNk9Yd3hk?=
 =?utf-8?B?TmdDeTNYcEFNTHFCc2VkcitXTXJuVndQVG9EKzdXcmM5dUpWQ3N1eUlsZEZm?=
 =?utf-8?B?ajZULzFXNnhQUnNSczdzcEVCZFNQYWdLM2NmcXVwZlRxOWphcVpvTks2V1dI?=
 =?utf-8?B?WDZMVGpibFN6ZGs4NjVUeEF0R3FTRXJZaUZKTlhFUzRIMlNIVHpOSEZKbVNv?=
 =?utf-8?B?R21odDJuRTU1dHBwZUtyOGVaTjRGYWZhdGxMU05lVyswWDBoWDdaaXNLeUN5?=
 =?utf-8?B?MDkvNlBqUXNZQXQyMnp5Mjk2VFFsKzBBb1pPWGNraXgySm95ay8zUURidUFM?=
 =?utf-8?B?Y1I0aTdZY2JSNjlzUFY0YXpQUGQxZlQ3WHhvYW84VzQxL3o5Y1V3Rk9lRjA2?=
 =?utf-8?B?V3RsdmRGWlo5cGZkMXJITUJ4eWNRSjNzaUE3d0JYQmZDRDJwMkR2WWYwR1h1?=
 =?utf-8?Q?rEfA/tGfQ4iLuI0JfVeiriLcMyrxFbKZOQHXA5IIb0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2F5958F10C8074BA8E783E6012F0C7A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8405f782-f821-46b8-a572-08d9d67b1c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 09:57:29.3631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8xwnbUbMpCih9PNws3vkUfPaNpQkl5v5YBqUlYtE1uvxXx76LtlyNeF5KV7T1Yog37gb919WUSMCiVvHSWq83kWQ32ATWBciR+WajV94G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMjItMDEtMTIgYXQgMTE6NTYgKzAzMDAsIE5pa2l0YSBZdXNoY2hlbmtvIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICByZWcgPSA8MCAweGVjNTIwMDAwIDAgMHg4MDA+Ow0KPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDM4NCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPEdJ
Q19TUEkgMzg1IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA8R0lDX1NQSSAzODYgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDM4NyBJUlFfVFlQRV9MRVZF
TF9ISUdIPiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkg
Mzg4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+IA0KPiA+IFdoYXQgaXMgdGhlIHB1cnBvc2Ug
b2YgdGhlIHZhcmlvdXMgaW50ZXJydXB0cz8NCj4gPiBQZXJoYXBzIHlvdSBuZWVkIGludGVycnVw
dC1uYW1lcz8NCj4gPiBUaGUgZHJpdmVyIHNlZW1zIHRvIHVzZSBvbmx5IHRoZSBmaXJzdCB0d28s
IHdoaWNoIGlzIHN0cmFuZ2UsIGFzDQo+ID4gdGhlIHNlY29uZCBhbmQgdGhpcmQgaW50ZXJydXB0
IGhhbmRsZSBkaWZmZXJlbnQgY2hhbm5lbHMuDQo+IA0KPiBNYXliZSBDaHJpc3RpYW4gR3JvbW0g
KHRoZSBvcmlnaW5hbCBkcml2ZXIgYXV0aG9yKSBjYW4gY29tbWVudCBoZXJlPw0KDQpJIGFtIG5v
dCB0aGUgYXV0aG9yIG9mIHRoaXMgZHJpdmVyIG1vZHVsZSBhbmQgSSBkb24ndCBoYXZlDQpkZXRh
aWxlZCBrbm93bGVkZ2UgYWJvdXQgaXQuIEknbGwgZ2V0IGluIHRvdWNoIHdpdGggQW5kcmUNCkVk
aWNoIDxhbmRyZS5lZGljaEBtaWNyb2NoaXAuY29tPiBzbyBoZSBjYW4gY29tbWVudCBvbiB0aGlz
Lg0KDQp0aGFua3MsDQpDaHJpcw0KDQo+IA0KPiBBcyBmYXIgYXMgSSB1bmRlcnN0YW5kOg0KPiAt
IGludGVycnVwdHMgYXJlOiBtbGIsIGFoYjAsIGFoYjEsIGNoMHJ4LCBjaDFyeA0KPiAtIG9mIHRo
b3NlLCB0aGUgZmlyc3QgMyBhcmUgZnJvbSBkaW0yIGl0c2VsZiwgYW5kIHRoZSBsYXN0IHR3byBh
cmUgZnJvbSByZW5lc2FzLXNwZWNpZmljIGxvZ2ljIGFyb3VuZCBkaW0yDQo+IC0gaW4gdGhlIGlu
dGVycnVwdCBhc3NpZ25tZW50IHRhYmxlcyBmb3IgZ2VuMyBTb0NzLCByZW5lc2FzIGRvY3VtZW50
cyBhbGwgNSBpbnRlcnJ1cHRzLCBob3dldmVyIGluIHRoZQ0KPiBtbGIgc2VjdGlvbiwgcmVuZXNh
cyBtZW50aW9ucyBvbmx5IG1sYiwgYWhiMCBhbmQgY2gwcnggaW50ZXJydXB0cw0KPiAtIG1vcmVv
dmVyLCByZW5lc2FzIGV4cGxpY2l0bHkgZGVuaWVzIGFjY2VzcyBkaW0yIHJlZ2lzdGVycyByZXNw
b25zaWJsZSBmb3IgY2hhbm5lbHMgMzIuLjYzIC0gd2hpY2gNCj4gcmVuZGVycyBhaGIxIGludGVy
cnVwdCB1c2VsZXNzOyBhbmQgcmVuZXNhcyBkb2VzIG5vdCBkb2N1bWVudCBhbnkgcmVnaXN0ZXJz
IHJlbGF0ZWQgdG8gImFzeW5jIHJ4DQo+IHJlc3BvbnNlIiBvbiBjaGFubmVscyAzMi4uNjMgLSB3
aGljaCByZW5kZXJzIGNocngxIGludGVycnVwdCB1c2VsZXNzDQo+IC0gYW55d2F5LCBkaW0yIGRy
aXZlciByZWdpc3RlcnMgb25seSAzMiBjaGFubmVscyAoZm9yIGFsbCB1c2UgY2FzZXMsIG5vdCBv
bmx5IGZvciByZW5lc2FzKSwgYW5kIHRodXMNCj4gdXNlcyBvbmx5IGFoYjAgaW50ZXJydXB0DQo+
IC0gZGltMiBkcml2ZXIgZG9lcyBub3QgaW1wbGVtZW50IHJlbmVzYXMtc3BlY2lmaWMgcHJvY2Vz
c2luZyBsb2dpYyBhbmQgdGh1cyBkb2VzIG5vdCB1c2UgY2gwcnggaW50ZXJydXB0DQo+IA0KPiBJ
J20gbm90IHN1cmUgaG93IHRvIHByb2NlZWQgaGVyZS4NCj4gSXMgaXQgYmV0dGVyIHRvIGRlZmlu
ZSBvbmx5IHR3byBpbnRlcnJ1cHRzIChtbGIsIGFoYjApIGluIGRldmljZSB0cmVlcz8NCj4gDQo+
IFJlZ2FyZGluZyAnaW50ZXJydXB0LW5hbWVzJyAtIGRpbTIgZHJpdmVyIGN1cnJlbnRseSB1c2Vz
IHBsYXRmb3JtX2dldF9pcnEoKSBhbmQgdGh1cyBkZXBlbmRzIG9uIG51bWVyaWMNCj4gcG9zaXRp
b25zIChtbGIgaW50ZXJydXB0IGF0IGluZGV4IDAgYW5kIGFoYjAgaW50ZXJydXB0IGF0IGluZGV4
IDEpLiBJJ20gbm90IHN1cmUgYWJvdXQgY3VycmVudCB1c2UgY2FzZXMNCj4gb2YgdGhlIGRyaXZl
ciBvdGhlciB0aGFuIHdpdGggcmNhci1nZW4zLCBhbmQgaWYgaXQgaXMgb2sgdG8gdXNlIG9mX2dl
dF9pcnFfYnluYW1lKCkgaW5zdGVhZC4gQW5kIHdpdGhvdXQNCj4gdXNpbmcgb2ZfZ2V0X2lycV9i
eW5hbWUoKSwgaW50ZXJydXB0LW5hbWVzIGxvb2tzIHNvbWV3aGF0IHVzZWxlc3MuDQo+IA0KPiA+
IEJ1dCB3aXRob3V0IGFueSBEVCBiaW5kaW5nIGRvY3VtZW50YXRpb24NCj4gPiBmb3IgdGhpcyBo
YXJkd2FyZSBibG9jaywgdGhpcyBpcyBoYXJkIHRvIHZhbGlkYXRlLCBhbmQgbm90IHlldCByZWFk
eSBmb3INCj4gPiB1cHN0cmVhbSBpbnRlZ3JhdGlvbi4NCj4gDQo+IENocmlzdGlhbiwgYXJlIHlv
dSBnb2luZyB0byBwcm92aWRlIERUIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgZGltMj8NCj4g
DQo+IE5pa2l0YQ0K
