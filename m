Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9044B9FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbiBQMIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:08:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiBQMIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:08:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515EC6378;
        Thu, 17 Feb 2022 04:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645099697; x=1676635697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ySMXaJvzTbTkXGcLAzM5H/HaGIi/g4smIEZNhnPPD5s=;
  b=iNvpopOijXMRG8+BxR+m6H0fYhs2wMyrxKDHsWUyVhTgrxPKX1tGsa7P
   MRpi+/yyDbeN1BZ33KM/xD3JC/Px6YMar/c85KKYxJONGh58r3Mre86v7
   nKG6Y/hnB7gDYljeGqenhlo+3OiMGdsF5wK1X3nCxK5vuNP9F4sxdoocS
   phRPGzdPrtX2pCCadQRzJpMPuF1ZYiNi85d4ZY3Y+3RXCUWfnrSaHXJaG
   uaW+WDRnOd6E29b1kMo79t4KQ3HMceinS2qhjgng5CXt3V/jfdoowmplk
   MVWwrHKeGOlKzVQKnSDr8eejCfH/YrFKzgRToVNctEXkcroWMQNoI4AGq
   w==;
IronPort-SDR: RqmGCiIVydgYZAa+woPCM7d1plGiPM4AbxrR9v7T019vDqTrBT0fvoPTmWtfi/Pn0LfC/qPJuy
 g6FGLxmemAJM2rIfPHRKIgG7Ia1LVnzqEDJeSn0eBl8axYE9FLEu2rkVai5TKTGJ4LbbxLFmUc
 jVd5Pj6YWr4vS58yoRgzp1KBOEo3bCifFnN9UTucTcYyRzVFplH2QaoBJAzkutART8jCj+SHI6
 yUSgWSe9XAXc1oMkxbjlPlpVDl7O0E6WGKVM0+xw9uZhkwWID5XdwOjXITflafwYfO3CWRtStn
 OBGm7Wn08cSGCxFQEn82lwkY
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="149053650"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 05:08:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 05:08:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 05:08:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEoi5W+9qbxJDdeaILHXwMRaESXsHCT3w9Z4SyQVQX+G5oLYixG61d4/YgllmwbUXWARA7l8H/GYnP6veptW7W1tv6bFH538xVgb8g7AVwkjIU79OfgQqavP3gZWQBXYK56mMIc4oOc7dZfuaDvGNxMTnBQX2Ug15LZYr22j4yF8J1QY0iFuLNdvS6o6DPsTP0gJlK65LETOvImpvXTFise23BN8gFF/WcKkGe0a8ulDwM7QUSWm3fU9nFXEo4JXoApuvBjMoF01fnCplCcc0e9eciNC/+CIIWHCjWOWbz9C5HmYl4+DTxQyxfv35POTXYW7px2AgtQonZWKtNX+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySMXaJvzTbTkXGcLAzM5H/HaGIi/g4smIEZNhnPPD5s=;
 b=PHn0OMPloxVnGoDQJKB94AonAJx4xcyinmWt10+/uLmzmFVds3S6EofOvetwpiKT2NyMK2dz6Hz/QN0uWP+zfnj+p0wHLzu1uM8ZS1MqMo9kIQw6myoitPgYYGvI02we62uweVaD42K/ffqHR9Q6Esf43DWbV9Erk3qCl+v7zoxRWBHubw+i4BFjQYEq70degK1XRgGMgzWxLt204sIBwh72zevVF4/alcO2Klu84QbM3n/vscdqkjjZAtPXy4QuE+bhrjCnNLaUa4SstCzASF0iq/M3i0PAwkez5cId1Lr01xN8+SZNzMRdUeZzGkC464Udon7HRX0B5lZacSCYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySMXaJvzTbTkXGcLAzM5H/HaGIi/g4smIEZNhnPPD5s=;
 b=oIlSZiVX5j/+zYjmYyWsHghJD395kV0jblWC5BzaiaYJpN8WHheO1KVjtolus/Km+sm4QN6mKxbqqM61AFjfBMsSE8x/TIP0I5DPeFMsO6anW+rA0MM4UawQzeavgYXNMBdLcIcL6ougPYITF6KkA0VsKP2lvHFyuYUREW+Qkwo=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by CO1PR11MB5060.namprd11.prod.outlook.com (2603:10b6:303:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 12:08:10 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::28cc:a34a:d10d:bb99]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::28cc:a34a:d10d:bb99%3]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 12:08:10 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Ludovic.Desroches@microchip.com>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Thread-Topic: [PATCH] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Thread-Index: AQHYIntm1Pqq+yVd7kOEGEIGfPFGg6yWyp2AgADeeoA=
Date:   Thu, 17 Feb 2022 12:08:10 +0000
Message-ID: <98b816a8-fba6-a404-9e73-becb4f7d8632@microchip.com>
References: <20220215144649.14378-1-sergiu.moga@microchip.com>
 <1645051913.059197.1825830.nullmailer@robh.at.kernel.org>
In-Reply-To: <1645051913.059197.1825830.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 878101fd-320a-480e-9923-08d9f20e2a73
x-ms-traffictypediagnostic: CO1PR11MB5060:EE_
x-microsoft-antispam-prvs: <CO1PR11MB50602596713457D89244E642E8369@CO1PR11MB5060.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q24AzlXQ+n4MfFypFQHH/aNpnI/ccq7KdSRHCYWFaIPR0FhWEO/yxVZGW9C2ztp08ZM/YGuluwJ7LzHd2KjwOuG4xeoLydGLjFcYaQMkah0oC2YX0l56cyWkbCFGL3jkH6I8VMTAsgY0egAJyyorEkuEYn9TKV6VWqp2XP+9cix1TcT9A/ykJvnaEVy6Wh9meVCXTEPzsgO4C08wSDl2pmeO6b+aney7fIiy6cAxrDJ3eyvg7QP/+9+kiClXZ/FSDhER6ZbyC5OP43B2LnfVQxmJSurKzhDai17TLjZwKjcy7XtpOO3wUBH54FZ4eepadNUaekoMB8SCfc/3PGvaXXJIL/G/V6UXR0z+FmBnRfQTZGo25tOjDvOhNHELXfb/QeBcYxtz6xgDq/rnaxvwHPgrGmGNxyAt4P+c500bVn5G5NUY3P+yf8lcwo3jI/OJg7Gk9InvdEgKCux/NytDnYI/ipVv/JJHbIVqLN2fG3+qLkaIb9XfZcSBiHxRzUqG2Se2VemP+sE+H4+HCahpkkftHH8hZ+FRe6oTcGYbIPbDfRbzqFEX1dNHScTt3kD/q3ufQWYtawYBv3O9OQSrnVQF1rXuGQpSLcpfv0imxM+6r9TJfJSKvLdzomLdCIlsDkj9CdyjCZQ9hklgXAfHwfo/GilQGlXsJaeRVo5zHTf7xBoTtq3d9KJYHbrowehYbRJlXvZr/BKS0gbxYCoAy7mesQcumYcbVDxt3i11KSqKYrorPPv9D/N68Pw0XqCSYw20Wh5JxXH+/mHzcrlDQgfNTUZ2oQoqhRUjSaMWRtkCSVo4di+MbcGbJez6/9Cs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(2906002)(64756008)(4326008)(83380400001)(66556008)(31696002)(8936002)(26005)(91956017)(66946007)(54906003)(8676002)(316002)(31686004)(86362001)(6512007)(6916009)(71200400001)(53546011)(6506007)(36756003)(38070700005)(76116006)(38100700002)(122000001)(6486002)(5660300002)(508600001)(966005)(66476007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkJCakUrZ2JYNG9YRWFNdmluTTYwNzBHRXVnKytjczVWK1hMTG5OT2llUGtK?=
 =?utf-8?B?aGZxSTA2WlB5L2dIMFo5SXBuZ0tHZzhwNmdjT3FXR1dVRUNzQURTcTE1YW83?=
 =?utf-8?B?VUlyclQ4cENEancrWkgyY0I3cUtQZ2tteE13Rk9MUlBuUGw3MWs2ZWxneWh3?=
 =?utf-8?B?MzBEeTE1UkJnd3FGZ2xNSVl1d3lEYUNVdFk3MWVyajdQWUZlOHpvOXVCNHZk?=
 =?utf-8?B?NVpZS3I2anRYYUFxak9kYjhNVHlzNlEwcWZ4Uk5sNlRkMkZKTUpKam9rUi91?=
 =?utf-8?B?NnR0WWt4c1Z6T24rVEtzR3M3MHh2MEVUbm5JVlhjcGpVSUFKYnhqd3pUM3c3?=
 =?utf-8?B?NHVtcmVIR1F4Tm5DYVhBWmxtNmRDV3BhM3UxTWpSNVcva2Z0Tnh1NDM3TnNJ?=
 =?utf-8?B?bWJzOXN3NEUvaFJNWjRGbFRlU0JLMUxxMUV2NUFFK1h3YTJMMjQ2dVRJNVBN?=
 =?utf-8?B?WmZaU0p0ei8rRmdBMkQyTEhIeC81c0dyNldWaElGWTNsamxjejlRMVFpaUJ1?=
 =?utf-8?B?TnFoZ04vUUE1S2JDcmNlWkRaTXYzODdJMi9rMnVGSVl6b2tFbW5UZFNhRitT?=
 =?utf-8?B?eGV0UHNaNW42ZGk5NjNReDJZK2xjRE9yYjNtaUtpMjBTYXF1cjd2MmxOc0l1?=
 =?utf-8?B?a1YrWG53c09SRVZhWUErbVNCUTR4dW9Jb1ExMXZ6YWtaUTJFV3FFWHVpQVdN?=
 =?utf-8?B?T2h6Tk4rTmNnQjFBaVVLYUh4cG52UXU0MVRjazc5eXMzRTdHM0VwMGhMOG92?=
 =?utf-8?B?bnZ2d1RsOHUvU1p6aHd2VkVBU2xoclpqQmlvNzd6RHJxaXBDUUIrZllieHQy?=
 =?utf-8?B?L1ZEVm1NZXR3YURwRzdhTnd0MzBoR0cwZnVDR29yeWVvMDE4cFgxcDhTcjFV?=
 =?utf-8?B?YVhwQk44ZFlwZEQxczFRWE9TNHVmeml1cVllUzBydEwrMjVnVDMrQ0NmZ3My?=
 =?utf-8?B?dlpseFFjeSs0TnpUVUlYZkpQVU5wam9rSzQ0ZWxDcXhIbFc0MDhqeXZBajJ5?=
 =?utf-8?B?alYxZjVXMEhiTEpBazZzYWxqaTRLSzhoZDhpVW9vRTJCM084WFpEbmRTS2Iv?=
 =?utf-8?B?UWk1T0FOSmg5V0Y2dy9TS2FudHl4WmFXaXYvMWowWTBQMUM3NStJVkhvRXd5?=
 =?utf-8?B?blNRL2tYelhxUmZKTDZtNnhTM2RFNlA0Mkx1UWFYTEZUY2c2SDRUK0FQTG41?=
 =?utf-8?B?N0E2ckVCRStDYXp3a3o4Ni8zbGxEejlIQy8rQ2lVMXNDTzFuMUVMMFd1R21t?=
 =?utf-8?B?T0FTRWNvTHVQbEhQWG9vcjdlLzlucEwxNlhrVDZGOUVKZmx0K3o3RWczcGpX?=
 =?utf-8?B?YVAvOWh3OHZJL3RVQy9yeDZiVHJ6U0EzaHIvVktjVDFiZFB1cnBUcmlIbmNS?=
 =?utf-8?B?cDBZZG1neFlhR05BT2YxdmloQXRQNmQ4K1p3UHhjeitNcXVLcHBaRUhQTnFT?=
 =?utf-8?B?eTdWc3hCWHdNMjhuYW96QUVET1h2UlhrbEhNNEE5NzBXenViYjhVTWFwaVNT?=
 =?utf-8?B?U3R5a2pkZm5Cck1hTk1KTjVZMkY5MWNDRmprMGRCeUNUQm0yWklETmxzdnlF?=
 =?utf-8?B?cEw1bVZLVUdzL1ljc05nR043aXhuUDN2dFovNWNyQkxwazVIdGdIMjgvYVFn?=
 =?utf-8?B?UFBhVjZtYUNuUG55cldXekFJSzMwRHpqQ29mUmd6d2QyL1VITUxvSmg5eUxj?=
 =?utf-8?B?UUZDOGF3a1pMMW5RblI5N0VSYTRVL2ZrR2VVbW0zYlRPdUY2MnUwT002WFZj?=
 =?utf-8?B?MDhrZHV1eXN3ajNIOU45L2tXSTBSUGczcmtWVDNYTTdEaHpWUTlKME5oOHI5?=
 =?utf-8?B?Z1Z0MFpHcGcxa0RmU0dVOWxPc3hNbGlGMTNaY2lSSXplZzd5aDdmZVBya3Aw?=
 =?utf-8?B?SzZwc1RtNEZTM09RcFB6WE52TXd5bHZJUzN1cWNHZ0wwbllsLy9xRFJsOEZD?=
 =?utf-8?B?c0JxejNuRTh6QW03dHJKUGpuNGhmZ2JRRWIvekdmRzRZRit4RDJCOTM4UnMy?=
 =?utf-8?B?VUN5cDBla1B5SlJvUnR0UmU2K1pUc2pYTlRmYWpxQzdTaE1iUlFrNGRVbmt6?=
 =?utf-8?B?dWVuNUxERDRyMXJlM0tFcW1HMjVxQ2xWV0pLTDU2azVJUTg2eExFZVdSL0xF?=
 =?utf-8?B?a2xPRGswbFBkMngwMlNmYTgrakVNOUFWamM3QndkaUVnM0dtMDIzNThESzds?=
 =?utf-8?B?NW1rcCtJTDhoQU1xWDV2U0ZiclM3VDlwWWRFdkdSc3BBT3JMY3plVTV1SFpY?=
 =?utf-8?B?dlNRb01PWkxoOVgxK2dWMG8xMEdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A8CFA293806824ABF93365C3CD8AA11@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878101fd-320a-480e-9923-08d9f20e2a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 12:08:10.4537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6oSlukbLKORj0D3JWQ4i3oxmtq5GH77L08CWlkmxfF3nUjqaAFKYnAOMM6G0wJoud/xs/2QAHcPll3vbWyqvkSlcJ6JDcJ6jD3Jbp1/7C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCk9uIDE3LjAyLjIwMjIgMDA6NTEsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBU
dWUsIDE1IEZlYiAyMDIyIDE2OjQ2OjQ5ICswMjAwLCBTZXJnaXUgTW9nYSB3cm90ZToNCj4+IENv
bnZlcnQgUlRDIGJpbmRpbmcgZm9yIEF0bWVsL01pY3JvY2hpcCBTb0NzIHRvIERldmljZSBUcmVl
IFNjaGVtYQ0KPj4gZm9ybWF0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNlcmdpdSBNb2dhIDxz
ZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9iaW5kaW5ncy9ydGMv
YXRtZWwsYXQ5MXNhbTktcnRjLnR4dCAgICAgICB8IDI1IC0tLS0tLS0tDQo+PiAgIC4uLi9iaW5k
aW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnlhbWwgICAgICB8IDYxICsrKysrKysrKysrKysr
KysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlv
bnMoLSkNCj4+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnR4dA0KPj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hdG1lbCxhdDkxc2FtOS1y
dGMueWFtbA0KPj4NCj4gTXkgYm90IGZvdW5kIGVycm9ycyBydW5uaW5nICdtYWtlIERUX0NIRUNL
RVJfRkxBR1M9LW0gZHRfYmluZGluZ19jaGVjaycNCj4gb24geW91ciBwYXRjaCAoRFRfQ0hFQ0tF
Ul9GTEFHUyBpcyBuZXcgaW4gdjUuMTMpOg0KPg0KPiB5YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6
DQo+IC4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hdG1lbCxhdDkxc2Ft
OS1ydGMueWFtbDoyMDo5OiBbd2FybmluZ10gd3JvbmcgaW5kZW50YXRpb246IGV4cGVjdGVkIDEw
IGJ1dCBmb3VuZCA4IChpbmRlbnRhdGlvbikNCj4gLi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcnRjL2F0bWVsLGF0OTFzYW05LXJ0Yy55YW1sOjIyOjk6IFt3YXJuaW5nXSB3cm9u
ZyBpbmRlbnRhdGlvbjogZXhwZWN0ZWQgMTAgYnV0IGZvdW5kIDggKGluZGVudGF0aW9uKQ0KPg0K
PiBkdHNjaGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvbGlu
dXgtZHQtcmV2aWV3L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYXRtZWws
YXQ5MXNhbTktcnRjLmV4YW1wbGUuZHQueWFtbDogcnR0QGZmZmZmZDIwOiAkbm9kZW5hbWU6MDog
J3J0dEBmZmZmZmQyMCcgZG9lcyBub3QgbWF0Y2ggJ15ydGMoQC4qfC1bMC05YS1mXSkqJCcNCj4g
ICAgICAgICAgRnJvbSBzY2hlbWE6IC9idWlsZHMvcm9iaGVycmluZy9saW51eC1kdC1yZXZpZXcv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hdG1lbCxhdDkxc2FtOS1ydGMu
eWFtbA0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtcmV2aWV3L0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLmV4YW1wbGUuZHQueWFt
bDogcnR0QGZmZmZmZDIwOiBhdG1lbCxydHQtcnRjLXRpbWUtcmVnOjA6IFs0Mjk0OTY3Mjk1LCAw
XSBpcyB0b28gbG9uZw0KPiAgICAgICAgICBGcm9tIHNjaGVtYTogL2J1aWxkcy9yb2JoZXJyaW5n
L2xpbnV4LWR0LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2F0
bWVsLGF0OTFzYW05LXJ0Yy55YW1sDQo+DQo+IGRvYyByZWZlcmVuY2UgZXJyb3JzIChtYWtlIHJl
ZmNoZWNrZG9jcyk6DQo+DQo+IFNlZSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNo
LzE1OTMxMDYNCj4NCj4gVGhpcyBjaGVjayBjYW4gZmFpbCBpZiB0aGVyZSBhcmUgYW55IGRlcGVu
ZGVuY2llcy4gVGhlIGJhc2UgZm9yIGEgcGF0Y2gNCj4gc2VyaWVzIGlzIGdlbmVyYWxseSB0aGUg
bW9zdCByZWNlbnQgcmMxLg0KPg0KPiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGlu
Z19jaGVjaycgYW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlDQo+IGVycm9yKHMpLCB0aGVuIG1ha2Ug
c3VyZSAneWFtbGxpbnQnIGlzIGluc3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRh
dGU6DQo+DQo+IHBpcDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCj4NCj4gUGxlYXNlIGNo
ZWNrIGFuZCByZS1zdWJtaXQuDQo+DQpNeSBhcG9sb2dpZXMsIGl0IHNlZW1zIHRoYXQsIGJ5IG1p
c3Rha2UsIEkgdXNlZCB0aGUgd3JvbmcgZmlsZSBmb3IgDQpEVF9TQ0hFTUFfRklMRVMgYW5kIHRo
dXMgSSBkaWQgbm90IHNlZSBhbnkgd2FybmluZ3Mgb3IgZXJyb3JzLiBJIHdpbGwgDQpjb3JyZWN0
IHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2su
DQoNClNlcmdpdQ0KDQo=
