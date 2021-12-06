Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122EA4691DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbhLFJA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:00:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:10209 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhLFJA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638781049; x=1670317049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yWmKXu/Rr9xYFx8MkEfkrVQ4n+JkgfGKS416vJI9WL8=;
  b=2O1zl0tWwx1AtzPttLgaM6dbnSnlcuhgFvyfFUtM9l6IxZhPhehJqgxG
   g900MhM2mfXo+HCI19Pn8TdCwBwHEmWTKT+w0Wtj8bUZywJ1brmsInDwV
   jLsAaCQRAliXCqo7cGIEjfWTmXLoX/C7XkB3iCFjww9uQqiytCd9a5pwi
   HiUcb/G+qYb1Gyiyu2z9EwbvPVZ7ePm6sCCPQ2eMtnsjUchx921wnL0ix
   frae5jbCmLguWGvhMBKj9yP/wiWDo3oaQbLMifCJo9GjFmcGB6T/UN9KW
   YC5UmEUoCpxYtypW03EGuSQznsqdpEYmANYkYeu2tsIz5YKFmCbykoWxG
   g==;
IronPort-SDR: GZpNcPMPy8oBfZ38NEqg+6CI3bnLxnoaWoIOLoXiDaeWBNbjIu4ycRNNDZz1mtg24MLRmLeKQF
 6MSEkqJPxq5FxqkhJEfLYxa3Pj5Q8YV7ROjNuHVlUUEuDPzWPVmWRiHHfOI8DFPswrRYa9Dh5i
 n1My6v4cW9L2O+Ggu65Y/+AglSdvYGD5aG9WYJaI1RcYhm5gmzI/oX1hgjRJ3tvUqFivbVDlGO
 JbhPq6eBokCDJ3eojiIH0AW0SA48WVVghAdliQKpHXzLRSKWzXGyaJt/rTNnjBINRpWM8D6Zd4
 ZVWx0pSCjVjbdGa+QfCuwlmH
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="145617840"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Dec 2021 01:57:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 6 Dec 2021 01:57:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 6 Dec 2021 01:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO/gbNkaOmgctsjcOUBSpXBxspSscTjlKeg+4LDJlJKjqd+vrEYtGRu9B28mUHiQSlCt8L2vE52iSsaPFIxEq37N4EovZN1Q32Swm2Mb+ROnm6WlMVvPySX8i58TdyU3MCG8t4lymoRyT5Y0OeA5zQt+e31OaVhgHHmKUPFxVI0rvxkhT5OdvYVNWqr9KGPOfsjBYjmfRtIr6ZwAT1lgypbhIMNMx4zVPgpwnUMr+xcuc0Pcav4/FzDCSJRCT3jfuuQuHBJ7cVkM7jx80RzQ0tI9piWkHt4W6cCgaTlhZbqayoEOFirKGaqZ7xN+fBifFfEgd/ePyq0MsMyxyiWwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWmKXu/Rr9xYFx8MkEfkrVQ4n+JkgfGKS416vJI9WL8=;
 b=VrhoWctwYT9KUZLb2n1Aa8V78CliblZYkIEVLz1MN51iTHb5UYoo4DOxRFztEWN95BmntKGCFqS8vXoB/Lse741af4dpxVIC7WHIH4N+HCCOpYa/UmVNziqYn7lWKURr6H3A+IqKxfLg393OnDyJh2Tnfu6mO/wjtM1q/t4b+H4NF//FQ3z3JRSTG3nPETufA5YH8HzEOJzS2k9NWYNIIzeEsTtOuXxA+On5+nsGMXMjTvUNbfxMvw+pzF5tbP2NQQE3eZc4ixDyxtt7x24k6+DyfC1IYgCT7ej4Jfq7XyAuUI6rnZ7qumwjbNQcNEHQOH6+pSBENEp/wzwXkMJs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWmKXu/Rr9xYFx8MkEfkrVQ4n+JkgfGKS416vJI9WL8=;
 b=itfwJE+Hv2NnaaYxo5rI6J4bS1Jx57zDfHSnWFN5h2PMz1qAgVY7TWGrTwfLf6uyJqWZVvJiRjAn9c/MSzChxKOkGEK+hKiftdPPJIrtS1RSJ83RFuvFOvP0S/Arvj/Z3qlH/5KXbTeWlAdqqw3k/XiLCNkQtY1pY3VgBdrNF5Q=
Received: from PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22)
 by PH7PR11MB5887.namprd11.prod.outlook.com (2603:10b6:510:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 6 Dec
 2021 08:57:11 +0000
Received: from PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::1433:9dcf:4912:b8f]) by PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::1433:9dcf:4912:b8f%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 08:57:11 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <sakari.ailus@iki.fi>, <robh@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jacopo@jmondi.org>,
        <laurent.pinchart@ideasonboard.com>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 02/25] dt-bindings: media: atmel: csi2dc: add bindings
 for microchip csi2dc
Thread-Topic: [PATCH v2 02/25] dt-bindings: media: atmel: csi2dc: add bindings
 for microchip csi2dc
Thread-Index: AQHX19FHySsE7cTaeUuONulRCZesK6wbG2wAgAAHggCACivsAA==
Date:   Mon, 6 Dec 2021 08:57:11 +0000
Message-ID: <7b4a4062-c6ed-7de1-7275-be20568550e3@microchip.com>
References: <20211112142509.2230884-1-eugen.hristev@microchip.com>
 <20211112142509.2230884-3-eugen.hristev@microchip.com>
 <YaVBwjtEI3xcL551@robh.at.kernel.org>
 <YaVIDgn1d2BHv6XZ@valkosipuli.retiisi.eu>
In-Reply-To: <YaVIDgn1d2BHv6XZ@valkosipuli.retiisi.eu>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: iki.fi; dkim=none (message not signed)
 header.d=none;iki.fi; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e19cdddc-aa00-46a9-e872-08d9b8966403
x-ms-traffictypediagnostic: PH7PR11MB5887:
x-microsoft-antispam-prvs: <PH7PR11MB5887BE002FC60C8B9E643B59E86D9@PH7PR11MB5887.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bV4p3ap/klcCJ8gAeKMrhACQ2PufGezD6Jd7g/XubMD8Y/lEsWIaOeBbJvkpPHe0ZY0AtIkGdx1m1Sfsk3DKhTLa6+672t4rUwqw3n62hqhQAWnk+N1Z/Bee+70nl77nzeohy6LqufAeNzum3OhoeD9zvIS9RjCdbswmxgOJhUcsq3r8t/ZikMJraTN+Z8xt6cz4cAFS0WJnOI7CLWIr6gCe/TzOm2goHSZM5MmnEWzB7fOe2fMlvJaskCXs0qPm6akpzYw7oTZQMoYjuurhA7rK9BwtflbATa5VP15lg3gLzyOrryBVWxVUDobw7qDAUxtpJ1Vwl5iBn4jIuAb06mkg7rAGN0uLB6zu0O7jz6GN5Xc67gnT6lV/BY1Yh79tRNXknPmdm+sj0ZqBJgG2sD137f0aFkIbweZ2c2IrQ1o+7BDG6zsS+iF0m6g9+PqHHyPLoOUJIADvR/BJ2PchcZ/KcDvmywM4Mrzzf61Piiqh7G+zd9116PtJY4y4EblU83v6gVEHYED6rL6WqPIof3wG3OR1kNgvSjDvH6LSXMSlGwhJ5a+CUehsGk18EVl/dg9j9LAxaHtd4pdhSr3YCprdo8wmJI8qm64ywXIqirMakZNtpN0zisJeJrJVQMTcPpCVZClMcSJOMoDNFd1/vW5eZpK7MwNXRkXCzUL89Vz3zEleaQEl8K7YooTGN1j26r+X4XD2lQRoc1IbD/ZBkD5KaQYyz6EbWjBOOHLkIBWLfyadJNuGRB5Ny2Sexoq1LEKUqkYei/Jr9dT9TMPd/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(76116006)(36756003)(66476007)(91956017)(107886003)(54906003)(31696002)(2616005)(86362001)(110136005)(122000001)(66446008)(53546011)(8936002)(6506007)(31686004)(38100700002)(2906002)(71200400001)(64756008)(316002)(38070700005)(8676002)(26005)(66556008)(6486002)(6512007)(4326008)(508600001)(5660300002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUY4Q21ZOWRyQjFEMTl0YmZQVVVnNHBWejQxdWEraUFqRkRmNEdWL1BXd1pC?=
 =?utf-8?B?bWE5NjBQWk5QYysvTkVuNG1MTXI5dDhoU0RZMm9OU0FRZzNub2ZxbkN0dzR5?=
 =?utf-8?B?TStXazFjSjR3a2U4NFZEeWdkOEpRV2FhUzdpYVFraU5Fa0FIejlwdDEyVXRH?=
 =?utf-8?B?bUhENEpMclhvOG9VcnNFVEtTVWluN2k5ajQyci9kb2IwQlpYZlk5d3ZtSFJL?=
 =?utf-8?B?ZnBOTXVTdXFHR3lnK0dTTVVobmpkVGNmbTc1SnhCc3ZJUmY5NHcxTlhLWWF5?=
 =?utf-8?B?QVhmQ2xNRUlseWdBNkRGaEkzVEJuMFhscVBqK2htTnczL2pZRGFPRmJjT3lx?=
 =?utf-8?B?aS8vZDhCRjFtcWgvWDJWazI2RnFGbUc5eWc4NWJZeDJIUUZ6UFBoc1NGQUI3?=
 =?utf-8?B?SXNGNCt0cXNNaVk3eDRvZEIyYjE4QWtMQWZwMmNmai9jRjZ4SVdaTExiOHhM?=
 =?utf-8?B?OVJUaFZLd0ZKRDZMRVgwMHJFRXZvYjBMeVVjNEQxelozb3RUWWdUZEVFcDdX?=
 =?utf-8?B?TVdWZDM2V2hWcExXbGExK0MyQXJHVmpqVWtxVWRvRWdmY3d0cFFHNzhXV2kw?=
 =?utf-8?B?MzRwaVBiZTN1dzQ3bHMyRzlwSllDZ2ZOOHNobmdoRWp0QVMza25MNmxFSit4?=
 =?utf-8?B?NjVaUW9jOGxFMFpmY3lVMTJKQUNRcXREdytQTmJzdlpsMHNmM2YrTmpSNFMv?=
 =?utf-8?B?N2Y0Z3BXcXU3YmJlOWNQQmlkcWZ4TXVmTzNjQk5KWlZrcjh6d25yYUpGTWJV?=
 =?utf-8?B?VFRITEZ6OWlPZnhnQklHYmlwcjBqdVdNbzRiaHI4bjBLYUpoMWpva2UrNElp?=
 =?utf-8?B?ZnpBU3poV2NVNUl4ci9UcTl3RVllWGlHODZ4ckZhU1hOM2VSMUhnRWNJVzRw?=
 =?utf-8?B?anFVbzFuaW5qbWFMK2o2TGNZbXhNbG1aWFg2SERyS3JMRTRiYStaSlFPVHV4?=
 =?utf-8?B?U1RJUHFkWmNUbnUzWWNWTVRFM3ptSytSN2VIT1NaMmxVb3E0Z2hmWEdvSUt6?=
 =?utf-8?B?UGtvNnpyK1V1dXVNMHNnSjYwZ05vemhETWRqeVNjdk8velI1bXpNbVJEU3VX?=
 =?utf-8?B?ZzdtdkJUZG9obXpXRWlZRThHQVN4TXZwWHdobTRkWkdNcVBaVUVBdmdRSndZ?=
 =?utf-8?B?NHpLYnoveVQ5ZzhEaXVvNE95TWtoZ1lkV2dhbnEvNXpKMHB5V3EwVGJoaUcx?=
 =?utf-8?B?TmdNSDNNWWtIcGkxeGVnRWdjVERDbHJ2TnFwcDAzRGVBZkVqT01wVVZrL2oy?=
 =?utf-8?B?YVE4NkU3Z3MyMk9BWC9wMkk3L0s0ZEJFZ1Z5eHRHazdxOXhsV0h6ZjNtVlVx?=
 =?utf-8?B?Wk52MkVMOEgrbG5nS0l4VlV6Q3BGblBZMlVnbGRuU3Zmam9ZYk1CK2d4c0JD?=
 =?utf-8?B?U3hxbElKWG1aMDBBT2dobXViZmRZVXhZVGFoMkpKWWl5UjlEMyt1ZWlCS2sz?=
 =?utf-8?B?RmdZYWdYdGVEU3JTMENObmhTRlJHWVZhNkdyTzdlSDRvdEtxcVQvV0NrOGhv?=
 =?utf-8?B?QTJXeWgzY01peGdrUmNMM0MvVkZWZ0I2dWZnWDBoOERNSEFPeHNGK1FXR2dL?=
 =?utf-8?B?V1hMa1QxOXM4THhUVUlCOXdkcEJvWjJabFljblptd3ZTenA2dVAwSUoxcmhz?=
 =?utf-8?B?L0pidWQrN3lNRVNuUWFwZ3E3K1AzVlNjN0VjcmxJNVU2SWh4MHZxdEJjcTBr?=
 =?utf-8?B?U1NJQ2NwQUswdmF5UjdFcERNQmY3djdJeFhXQzBXUmJoNGNZYmR5eTRRYWgw?=
 =?utf-8?B?WndULzQ4S3h2L09KelRWcE5LalZadVlHYjJvUHRySHZrZ25ReGl0M3dEOFh1?=
 =?utf-8?B?R1E5SVpyMXlkREtib3FQL2lSelcxODhWSm13Rng3OWhQcWlOSUlTOHNQa0VB?=
 =?utf-8?B?R1lZVlg5eVRRTy9RdFl4TUhqdlJZTkpiUm04WGxacGdZQ21SNUJVdFVOREk0?=
 =?utf-8?B?RmdwdERNNHhMU3JuVVFOdnBTcHpwb25YNkp6dWRTV00yOThhM3pBZ21GRW0w?=
 =?utf-8?B?Q3I5enlvWVZjWW9CcHQ5T0pHeVh0djNMeUhCNFkxOHA4cnFqbVhpMTdUUHVp?=
 =?utf-8?B?eXlzRFpMWWk4K2hnNXhIeDJScmlHblpBem4wMFVib3ladi94Q3dQZFM3YWVS?=
 =?utf-8?B?SGcxc1I2Zkc2ZHp5ZXhwSVRHa2VscXRzbnJUQ3o2eERDK2RFYjY4cWVzU2ZD?=
 =?utf-8?B?eTNMN2NsUlJMOWlWVjBQUVJqMEs3Qm1BSjQxcnNzbStDeHZzY25YUmhIYzU3?=
 =?utf-8?B?U2JDMWl1NzdMVStLZG1rclptRmFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A480DABA294DC34088037CE0F03FD7A3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19cdddc-aa00-46a9-e872-08d9b8966403
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 08:57:11.1272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5oU2C5BiHAvq/BtdcuKttf8G9WgHsKI+24+yZr5/fT2D1iz0PV/laeI74Nu7vStbQUGl7c9gsqCj97+abBdlu9BYwO5fPQlLpnWS+JxxRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5887
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjkvMjEgMTE6MzcgUE0sIFNha2FyaSBBaWx1cyB3cm90ZToNCj4gSGkgUm9iLCBFdWdl
biwNCj4gDQo+IE9uIE1vbiwgTm92IDI5LCAyMDIxIGF0IDAzOjEwOjI2UE0gLTA2MDAsIFJvYiBI
ZXJyaW5nIHdyb3RlOg0KPj4+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+Pj4gKyAgICAgICAgICBl
bmRwb2ludDoNCj4+PiArICAgICAgICAgICAgJHJlZjogdmlkZW8taW50ZXJmYWNlcy55YW1sIw0K
Pj4NCj4+IEJ1dCB3aGF0IHByb3BlcnRpZXMgZnJvbSB0aGlzIGRvIHlvdSB1c2U/IEl0IGRvZXNu
J3QgbG9vayBsaWtlIHlvdSBuZWVkDQo+PiB0aGlzPw0KPiANCj4gSSdkIGV4cGVjdCB0byBzZWUg
ZGF0YS1sYW5lcyBhdCBsZWFzdCAtLS0gdW5sZXNzIHRoZSBudW1iZXIgb2YgbGFuZXMgaXMNCj4g
cmVhbGx5IGZpeGVkLg0KDQpIZWxsbyBTYWthcmksIFJvYiwNCg0KQWN0dWFsbHkgdGhlIGlucHV0
IHBvcnQgY2FuIGJlIGVpdGhlciB0aGUgU3lub3BzeXMgSURJIGludGVyZmFjZSwgb3IgDQpwYXJh
bGxlbC4NClNpbmNlIHRoZXJlIGlzIG5vIHN1Y2ggYnVzIHR5cGUgJ3N5bm9wc3lzIElESScgdGhp
cyBpbnB1dCBwb3J0IA0KY29ubmVjdGlvbiBjYW5ub3QgaGF2ZSBudW1iZXIgb2YgbGFuZXMsIGV0
Yy4gKGl0IGlzIGEgMzIgYml0IHByb3ByaWV0YXJ5IA0Kc3lub3BzeXMgaW50ZXJmYWNlIHdoaWNo
IGlzIGEgbXV4L3JlcGFja2FnZSBvZiB0aGUgQ1NJMiBidXMpDQoNCkFsc28sIHRoaXMgaW5wdXQg
cG9ydCBjb3VsZCBiZSBjb25uZWN0ZWQgdG8gYSBwYXJhbGxlbCBzZW5zb3IuIEluIHRoaXMgDQpj
YXNlIHRoZSBjc2kyZGMgYWN0cyBhcyBhIGJ5cGFzcyBiZXR3ZWVuIHRoZSBpbnB1dCBwb3J0IGFu
ZCB0aGUgb3V0cHV0IA0KcG9ydC4gSG93ZXZlciwgdGhlIGNzaTJkYyBzdGlsbCBuZWVkcyB0byBi
ZSBwcm9iZWQgYW5kIHN0aWxsIG5lZWRzIHRvIGJlIA0KY29uZmlndXJlZCwgdGh1cywgaXQgY2Fu
bm90IGJlIHJlbW92ZWQgZnJvbSB0aGUgcGlwZWxpbmUgKG90aGVyd2lzZSB0aGUgDQpoYXJkd2Fy
ZSBwaXBlbGluZSB3b24ndCB3b3JrKQ0KDQpTbyBteSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlz
IGxpa2UgdGhpcyA6IGlmIHRoZSBpbnB1dCBwb3J0IGlzIA0KcGFyYWxsZWwsIHVzZSBwYXJhbGxl
bCBtb2RlLCBidXQgaWYgdGhlIGJ1cyB0eXBlIGlzIHNldCB0byBDU0kyLURQSFkgKCANCmFjdHVh
bGx5IHRoaXMgaXMgdGhlIGJ1cyBpbnRlcmZhY2UgdXNlZCBieSB0aGUgc2Vuc29yICksIHVzZSB0
aGUgY3NpMmRjIA0KZGVtdXggdmlkZW8gcGlwZWxpbmUgdG8gZGVtdXggZnJvbSBJREkgdG8gcGFy
YWxsZWwgaW50ZXJmYWNlLg0KDQptYXliZSB0aGlzIHNjaGVtYXRpYyBpcyBtb3JlIGNsZWFyIHRo
YW4gbXkgd29yZHMgYWJvdmU6DQoNCg0KIA0KDQogICAgICAgICAgICAgICAgICAgICAgICArLS0t
LS0tLS0tLS0tLS0tLS0rICstLS0tLS0tLS0tLS0tKyANCg0KICAgICAgICAgICAgICAgICAgICAg
ICAgfHBvcnQgMCAgICAgICAgICAgfCB8ICBwb3J0IDEgICAgIHwgDQoNCiAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgIHwgfCAgICAgICAgICAgICB8IA0KDQogICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICB8IHwgICAgICAgICAgICAgfCANCg0K
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgfCB8ICAgICAgICAgICAg
IHwgDQoNCiAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgIHwgfCAgICAg
ICAgICAgICB8IA0KDQogICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICB8
IHwgICAgICAgICAgICAgfCANCg0KICAgKy0tLS0tLS0tLS0rICAgICAgICAgfCAgICAgICAgKy0t
LS0tLS0tfC18LS0tLS0tLSsgICAgIHwgDQoNCiAgIHwgICAgICAgICAgfCAgICAgICAgIHwgICAg
ICAgIHwrLS0tLS0tLS0tLS0tKyAgICB8ICAgICB8IA0KDQogICB8ICBwYXJhbGxlbHwtLS0tLS0t
LS18LS0tLS0tLS18fCBieXBhc3N8IHwgIHwgICAgLS0tLS0tfC0tLS0gDQoNCiAgIHwgIHNlbnNv
ciAgfCBwYXJhbGxlbHwgICAgICAgIHx8ICAgICAgIHwgfCAgfCAgICB8ICAgICB8IA0KDQogICB8
ICAgICAgICAgIHwgaW50ZiAgICB8ICAgICAgICB8fCAgICAgICB8IHwgIHwgICAgfCBwYXJhbGxl
bCANCg0KICAgKy0tLS0tLS0tLS0rICAgICAgICAgfCAgICAgICAgfCstLS0tLS0tLS0tLS0rICAg
IHwgb3V0cHV0IA0KDQogICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICB8ICAgICAgICB8
IHwgICAgICAgfCBpbnRmfCANCg0KICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfCBj
c2kyZGMgfCB8ICAgICAgIHwgICAgIHwgDQoNCiAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
ICAgIHwgICAgICAgIHwgfCAgICAgICB8ICAgICB8IA0KDQogICArLS0tLS0tLS0tLS0tLS0tKyAg
ICB8ICAgICAgICB8ICAgICAgICB8IHwgICAgICAgfCAgICAgfCANCg0KICAgfCAgICAgICAgICAg
ICAgIHxzeW5vcHN5cyAgICAgfCAgICAgICAgfCB8ICAgICAgIHwgICAgIHwgDQoNCiAgIHwgIHN5
bm9wc3lzIGhvc3R8SURJIHwgICAgICAgIHwgICAgICAgIHwgfCAgICAgICB8ICAgICB8IA0KDQog
ICB8ICBjb250cm9sbGVyICAgLS0tLS0tLS0tLS0tLS18ICAgICAgICB8IHwgICAgICAgfCAgICAg
fCANCg0KICAgfCAgICAgICAgICAgICAgIHwgICAgfCAgICAgICAgfCAgICAgICAgfCB8ICAgICAg
IHwgICAgIHwgDQoNCiAgIHwgICAgICAgICAgICAgICB8ICAgIHwgICAgICAgICstLS0tLS0tLXwt
fC0tLS0tLS0rICAgICB8IA0KDQogICArLS0tLS0tLS0tLS0tLS0tKyAgICB8ICAgICAgICAgICAg
ICAgICB8IHwgICAgICAgICAgICAgfCANCg0KICAgICAgICAgICBeICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgfCB8ICAgICAgICAgICAgIHwgDQoNCiAgY3NpMiBidXMgfCAgICAgICAgICAg
IHwgICAgICAgICAgICAgICAgIHwgfCAgICAgICAgICAgICB8IA0KDQogICAgKy0tLS0tLS0tLS0t
LSsgICAgICB8ICAgICAgICAgICAgICAgICB8IHwgICAgICAgICAgICAgfCANCg0KICAgIHwgICAg
ICAgICAgICB8ICAgICAgfCAgICAgICAgICAgICAgICAgfCB8ICAgICAgICAgICAgIHwgDQoNCiAg
ICB8IGNzaTIgc2Vuc29yfCAgICAgICstLS0tLS0tLS0tLS0tLS0tLSsgKy0tLS0tLS0tLS0tLS0r
IA0KDQogICAgfCAgICAgICAgICAgIHwgDQoNCiAgICB8ICAgICAgICAgICAgfCANCg0KICAgICst
LS0tLS0tLS0tLS0rIA0KDQogDQoNCg0KDQpJbiB0aGlzIGNhc2UsIHdoYXQgd291bGQgeW91IGFk
dmlzZSB0byB1c2UgZm9yIHRoZSBiaW5kaW5ncyBvZiB0aGUgY3NpMmRjID8NCg0KT25lIG9wdGlv
biBpcyB0byBhZGQgdGhlIFN5bm9wc3lzIElESSBpbnRlcmZhY2UgYW5kIGRvY3VtZW50IHRoaXMg
YXMgYSANCnBvc3NpYmxlIGJ1cyB0eXBlLiBJIHdvdWxkIHJhdGhlciBub3QgZG8gdGhpcywgc2lu
Y2UgaXQncyBTeW5vcHN5cyANCnByb3ByaWV0YXJ5IGFuZCBpdCB3b3VsZCBiZSBkaWZmaWN1bHQg
Zm9yIG1lIHRvIGRvY3VtZW50IGl0IGF0IHRoaXMgDQptb21lbnQgKHJhdGhlciBzb21lb25lIGZy
b20gU3lub3BzeXMgd2hvIGlzIG1vcmUgZmFtaWxpYXIgd2l0aCB0aGlzICkNCg0KU28sIEkgc2hv
dWxkIHN0aWxsIHJlZmVyIHZpZGVvIGludGVyZmFjZXMgaW4gdGhlIG5vZGUsIGFuZCB0aGVuIHNw
ZWNpZnkgDQp0aGF0IHRoaXMgYnVzIGNhbiBiZSBlaXRoZXIgcGFyYWxsZWwgb3IgY3NpMiBkcGh5
LCBidXQgd2l0aG91dCBudW1iZXIgb2YgDQpsYW5lcyBzaW5jZSBpdCBkb2VzIG5vdCBtYWtlIHNl
bnNlICh0aGlzIHdvdWxkIGJlIGJldHdlZW4gY3NpMiBzZW5zb3IgDQphbmQgc3lub3BzeXMgaG9z
dCBjb250cm9sbGVyKSwgYW5kIHNwZWNpZnkgb25seSBwYXJhbGxlbCBwcm9wZXJ0aWVzIGxpa2Ug
DQpidXMgd2lkdGggLCBldGMgPw0KDQpXaGljaCB3b3VsZCBiZSBhIGJldHRlciB3YXkgdG8gZ28g
Pw0KDQpUaGFua3MsDQpFdWdlbg0KIA0KDQoNCg0KDQo+IA0KPiAtLQ0KPiBTYWthcmkgQWlsdXMN
Cj4gDQoNCg==
