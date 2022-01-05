Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EB2484EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbiAEHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:39:41 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13368 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiAEHjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641368375; x=1672904375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p+F+HfDYY6nOqi9Q6EahOsTHNMzwEqqiqG3L+z/1M4E=;
  b=ob8EXE1i9Z/3bSl5IaPz0aogoQN0Vt5j5+DvJBP3gUpnE1E5Hm8M9N1e
   fvD7x/j+fBztIvl167/yoNtCiiaWnWV7r+zYCLewyEE3OOY/Agyfmm2ZC
   UC5SZyI9oEV0FKVin/BoiATyLLjc+EtXjVPYbsQKwr5tS2nSkvGGOSliI
   hEIsylmdvDAzsod/PK0dIOzzWEdkWkcJk72ML+RXtbTGF5ch8LAcy5BGx
   ZUKq381ZkPN8+r9eq4+k75ximjDM8D72yn+ETN7DJIqXRHYRJjw00q0Wc
   jBer4vkEENvjAcq4gtZFiKuTnwgPqo99cpIZzyP/WoakRn1xOIVko8rQz
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,262,1635177600"; 
   d="scan'208";a="189726873"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2022 15:39:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btzfGY7MLfOUcztSn7k8SQt5MJyuUmpHDxeCRUGUUkHddunFOcXd2pUlY+WaG7WeLqsxxL5HWJFnil1N1sDIMo+fLz6lyDoeYu2i4/nzBthvl452xepm7eJ6KCU1wAeDLw/EEwjBWNVs58y8ExVt5N0s5PCD1sLMO7yKfFJ6aGMKU6OU+Xq2MXAgjcGjagcFMMbS+PQhNF7piK9TdQeZZojBevsiAngci8MnrIcuvHDXzKMFT9da25Kp99+VbQ77UzwwHXw71AcR1zcgpQtAtjEjbXr9W8SqU0LUdx3wqZD62IB30ah3xhNqbt6/znG5IcIt4bULgtQIuXr+aotZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+F+HfDYY6nOqi9Q6EahOsTHNMzwEqqiqG3L+z/1M4E=;
 b=oU2u4oC0jaFN78GDFsN5D0QCDIrCPjnFdIvfOHtWFOZ+TF635fboiIKVU4zZMAx4w6/FFmIQeJfeT1/bW0HmiwgkLE2axJxf9S0bNGA2eSQiYNH6SJXrLjt08xuqWaULbku/ilDmyXxZnZhwTeTiv2447vrrznmHzLue00DXw918bfG1S+nlQzAXViVBg1CBi0+gyC4YGQdhjooDRRtyF47XY7nlu+siNCh+m7y2u+9xXVGxOmRNDpYWUF1ggvsP/TWzJL0CRDhIu/FoUU213jNPabp35bJZPZtZFRBGJUT6z0tq36aGorponNBzKrZ7C3ADuqAidHOVQlKrNNpazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+F+HfDYY6nOqi9Q6EahOsTHNMzwEqqiqG3L+z/1M4E=;
 b=TDHHB2bJrOoVKmnpRZ2yb4cn5IM0I9jTRtef/3dfBkkDDkL9lwBtTbrmUDAVJ3O9hRFwJf4o/WwqwBNVMipoZhNdYflDZLr8xe5xd/drFE3XzmWvwfXEXOZRSgH0VWwmlF7idgokyrz09J4S7Db8+x2vXt52PaoY6Pbb6UhQXYI=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB7083.namprd04.prod.outlook.com (2603:10b6:5:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 07:39:34 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e58a:8ae5:2f73:35ea]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e58a:8ae5:2f73:35ea%9]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 07:39:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "haowenchao@huawei.com" <haowenchao@huawei.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
CC:     "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH v2] ata: libata-scsi: Make __ata_scsi_queuecmd()
 parameters check more clearly
Thread-Topic: [PATCH v2] ata: libata-scsi: Make __ata_scsi_queuecmd()
 parameters check more clearly
Thread-Index: AQHYAgR/hoAs4ZCHBku2P6cyw6EIKaxUCrgA
Date:   Wed, 5 Jan 2022 07:39:33 +0000
Message-ID: <ff55e8d2037fa1f11812329fb8da39e746abe878.camel@wdc.com>
References: <20220105202747.1963919-1-haowenchao@huawei.com>
In-Reply-To: <20220105202747.1963919-1-haowenchao@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2 (3.42.2-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd4cd455-65f5-4331-d511-08d9d01e8491
x-ms-traffictypediagnostic: DM6PR04MB7083:EE_
x-microsoft-antispam-prvs: <DM6PR04MB7083A68ED537D2B3D23A9090E74B9@DM6PR04MB7083.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0wgnv4vm3tDhOk6b0rA3R6ZisT1kWKJRPDJkGyI9AkS2AGU0wkL/wxPPE28dQTHzJ7rH9urXKPd09kXzJ2djCobvAtCdtXaDeKz+vgdVWFDb3tJ1rPAV5pN++RzSnFL9Cr366qciSvFo3F+FYmu9EqpzAF3PqrbiH29Om/rRFkMTlRwLeRtsDBkR3i/VBsvfWWeDOsfAdhBMlH0E24ovcmXxUSg8c2ZTJ2yDt9+1+rXFDJVi8V8olsXVDzXT7QLZkaqgIV92ey3zZUTWI7mbSRKYsiN4DecZtF5Nbt+2Kd0Ez7rmfzpqX+oGxaFhCdyM2X079/DQwEyIeVcuSW7Mcc6+bsYGywFlKHFYEp1Z8xUJsQNLrq+j0Xl90oH9A63NCK4TNLQGOO5r6QmDxaPI74EbW5XeRPR/5acZl5MmZBlWLKnqvVw7zBj3EdNCZMSLKHqibKF2MPkqLaRJPHb6f6bbPOHdkYEUKWr4uFXTfCTCAwagLokkzRJc/3ydo2BBKRp4JB//BtjXNFsSRyeKvzyeh9NE4igA5WWg6lMb7AEqDIzC/899/o2oe4QJt3o7JkUCFt/2hI+LBGfbObm6JB6ZuanZgdqNPDX6pWeiPU3308axGAU3gP8BEP8FpLNe1Fh5+1HicKloMl+26v8MVUZLwNAlVHcpNYayXe1M7zKsByBMwYFJzYTzCERhbzyJ/3UHLRLV2IanWFFvRCidA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(4326008)(91956017)(66946007)(76116006)(110136005)(83380400001)(2616005)(66446008)(64756008)(66476007)(6512007)(5660300002)(66556008)(82960400001)(122000001)(8676002)(508600001)(38070700005)(186003)(36756003)(26005)(38100700002)(316002)(71200400001)(86362001)(8936002)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW0xcG02blhEeUdoUlh5YnZEK2VMVng4WWRlOVR0WGRTVXA4OGxoRzJSUWhM?=
 =?utf-8?B?WkJhRW1abTBFditkei8xMmlOMzYxbWczRFNRWkd3Z3psazE4dTd5THZQU1I0?=
 =?utf-8?B?QUx5bnhGU0tyQ2pjR2hXckhRd0cyejZDU0l3UGpBQ3dmdnh1RXc1WjAxYWEr?=
 =?utf-8?B?TmVNRjRUblpObWdMS3lKNThLRE1xWFN1c2ZrY1RUaTUyZCt2Vmg2WEgrRVNN?=
 =?utf-8?B?NllmMm52VnF6d2xKKzhXeVZWNlZoVWxDQXd6bEtaTnRkbFV3T05WQUpVWHl6?=
 =?utf-8?B?MWJCYURmWFRhdkl3bGVaR1M2SXJXNnJuOHd3cU5QN0oxcHFDZEFSdmxmNmJD?=
 =?utf-8?B?YTU0a2krMnl4TkxIYmc2WGhIT1pUTEN2VE03VGdKblRVNnloOTBsdUQyN080?=
 =?utf-8?B?Sm5zTW1jUlpNV25CcWMvRFVLcjFFMVpJd29TeDh4ajBZd1lwc3VUZEJ1aGF4?=
 =?utf-8?B?VWQ5bU1pbSswdHJpdy90amp0QlJxRmt1NDBLNzlqNUpZK2IrTEhVNFp2OGxi?=
 =?utf-8?B?c3doT00welR0UXI0QW0wYlFVTHlxdXZydUZQRHljYkRmUlJaei93bGFlL0k2?=
 =?utf-8?B?VUpvME5wM1ovU0l4U3ZEWnBuSE90YzI3b3lUR2dVQURPeWl6Z3NBOHB4TE94?=
 =?utf-8?B?UTRPR2FLVEdqVkJROWJocGNqQ1ArSDhXL2RFQ3VITXBiYktQVmVFbHpCa0N5?=
 =?utf-8?B?djV4N3dEMGR0ZXpLVlZRdjBFaWE1cGJOWnBWUWVEQ0YvSG9YTVBSYXlkSThE?=
 =?utf-8?B?Sm5yS0NqWVoxZ0NWQm9ZS3FWRFIrZ2dPOEMrK3dsbkdnaFFHZDE5RWd2VElr?=
 =?utf-8?B?RlhrV2VUeE93bEp5TFE3bitqcWZHZkhmalN0T3VDdjJ5eXIzb0t0V3U3YW1P?=
 =?utf-8?B?NHMvL0NXMk01emVGRW5SdlZ5K0xVaFpJcnFycmlvaWZQQWZSSG9sSDFWNkJX?=
 =?utf-8?B?bnZHdFR1TGd3bDVQay9kL0dtTk1qNVZuOGh2V09LUGpWU2RiSDU4Mi9CU1FM?=
 =?utf-8?B?Q2l0VDJSY2hFQmlrRHB5OGhaWklDVmlBcUZOM3VWd2ZDc09tL3k1WVZ2bVFN?=
 =?utf-8?B?ZEtjUGh5NHhnbFFqNHJkRjJteExDTWtwaUdTT0wwVEFpWWpKSUZVQ202VDBI?=
 =?utf-8?B?Mi9QQVVWeFdJNDBKYUlVUXZiVXY5Ky92SC80QjNRQ2JPY2pMYzFLYUNsTHh4?=
 =?utf-8?B?d3lWeXQ1MXdYdklkRit1dkNNeGZCWko5bnY1Z01WVHF6UEpRc2dndk9iaVB2?=
 =?utf-8?B?dU1idGYrL3Z0RWhoakJUb2h3dmIvSVVYYTdVWHJQdUhORU5Db1RNOEhmOFR5?=
 =?utf-8?B?TWlWMmVPWXFrTy9EajNyQ2Ira3RyTTBXZkY3cGwvVFR3eEdHZVZuSVJHZk1G?=
 =?utf-8?B?V1kxNHJsaFpDdXZsNVhtaUN1NFZLQTg2YVlCUTFhVmNSaUNOLzdMYzFyclFG?=
 =?utf-8?B?ZDFqWEVScGIvb0k3Smw4bkREWnI3RHU4RzE2TmpETWZSeXRvS2lrTHY1NFAz?=
 =?utf-8?B?TXlzQ1BVSFBidm1pZ0NodXExY0RvNGE5dlNDMWpFaXhjQnhxMVpIY3NqclBu?=
 =?utf-8?B?WSs3dnl3OHdjVDF2YkQyeEF2enNJNWNYN3pJUDUrem5XR1pTMnFWd1FOVGZo?=
 =?utf-8?B?MjlYekk1RHRrUHhLT0IwSHBHNVZxRjFscW9TSHVIRTcwTThhQktqZnFveHpu?=
 =?utf-8?B?NTNKcXRMckRxeEhsb0lwMEhINUsvZWFMNm03WDBSeHN2aUszVmhkM2dZT3VZ?=
 =?utf-8?B?UkRNUFRNeEgrUWlOMDQrRnJlSk1oNkQ5MDBkY0IxRzBWVzNWSXZwSjdFZUNR?=
 =?utf-8?B?L1pIRmFZdGtTb1AyMG9IdWpHRi83MTkwTWpsc05sL09IdXZCUDZtUkd2RDNZ?=
 =?utf-8?B?TlorRjBjeXBwYUFHdk1RVlFlS2FUM3dxMXdtMk1ScDRBQVFWQXAvZ1RKdGkr?=
 =?utf-8?B?ZzBsYlhJQ1JrOGpxZy93Y2l4MjBjUnU0Zlh6enpKRjFoUURBYlNDdWxKeDh1?=
 =?utf-8?B?NVRJc2gzU2JTWEJidklCTEYvRll4emJBMHhMTWI2YnQ2cit4SWlxaDd4VSsr?=
 =?utf-8?B?UW0xSmkzNU5mdEVvRE5HSG4velFiaGdiUGhuVXpTOVdRZndGM1MvTFd3S2Iw?=
 =?utf-8?B?cjQ4RTRuVU1FUmFmZlVTUncyUDhHeXNWNEVHRXpUUWZKSFBJNUtDcVFMNXNr?=
 =?utf-8?Q?L4QEORZdkYU8rwU28JFNb6fsq+6mgth0TNljmvyIlP1Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA0C39921E56454081CAFEB02B293CFC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4cd455-65f5-4331-d511-08d9d01e8491
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 07:39:33.8726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPMVxYhh8u7QCg6Z3UnoGK4WVEv76kJWnT8FXJv0UuKyNc5Fo2LfkiqzsXk87Z2kC+EqHNjV7XEpgW1vdrlZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTA1IGF0IDE1OjI3IC0wNTAwLCBXZW5jaGFvIEhhbyB3cm90ZToNCj4g
VGhpcyBpcyBqdXN0IGEgY2xlYW4gY29kZS4gU2luY2UgZWFjaCBicmFuY2ggb2YgImlmIiBzdGF0
ZSB3b3VsZCBjaGVjaw0KPiBzY21kLT5jbWRfbGVuLCBzbyBtb3ZlIHRoZSBjaGVjayBvZiBzY21k
LT5jbWRfbGVuIG91dCBvZiAiaWYiIHN0YXRlIHRvDQo+IHNpbXBsaWZ5IGlucHV0IHBhcmFtZXRl
cnMgY2hlY2suDQo+IA0KPiBBbmQgcmVtb3ZlIHJlZHVuZGFudCBpbml0IG9mIHhsYXRfZnVuYyBh
dCBoYW5kDQo+IA0KPiBUaGUgcGF0Y2ggZG8gbm90IGNoYW5nZSBvcmlnaW4gZnVuY3Rpb24gbG9n
aWMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXZW5jaGFvIEhhbyA8aGFvd2VuY2hhb0BodWF3ZWku
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvYXRhL2xpYmF0YS1zY3NpLmMgfCA5ICsrKystLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9saWJhdGEtc2NzaS5jIGIvZHJpdmVycy9hdGEvbGli
YXRhLXNjc2kuYw0KPiBpbmRleCAzMTNlOTQ3NTUwN2IuLmFiOGEyODMzZGZlYyAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9hdGEvbGliYXRhLXNjc2kuYw0KPiArKysgYi9kcml2ZXJzL2F0YS9saWJh
dGEtc2NzaS5jDQo+IEBAIC00MDIzLDE2ICs0MDIzLDE1IEBAIGludCBfX2F0YV9zY3NpX3F1ZXVl
Y21kKHN0cnVjdCBzY3NpX2NtbmQgKnNjbWQsIHN0cnVjdCBhdGFfZGV2aWNlICpkZXYpDQo+ICAJ
YXRhX3hsYXRfZnVuY190IHhsYXRfZnVuYzsNCj4gIAlpbnQgcmMgPSAwOw0KPiAgDQo+ICsJaWYg
KHVubGlrZWx5KCFzY21kLT5jbWRfbGVuKSkNCj4gKwkJZ290byBiYWRfY2RiX2xlbjsNCj4gKw0K
PiAgCWlmIChkZXYtPmNsYXNzID09IEFUQV9ERVZfQVRBIHx8IGRldi0+Y2xhc3MgPT0gQVRBX0RF
Vl9aQUMpIHsNCj4gLQkJaWYgKHVubGlrZWx5KCFzY21kLT5jbWRfbGVuIHx8IHNjbWQtPmNtZF9s
ZW4gPiBkZXYtPmNkYl9sZW4pKQ0KPiArCQlpZiAodW5saWtlbHkoc2NtZC0+Y21kX2xlbiA+IGRl
di0+Y2RiX2xlbikpDQo+ICAJCQlnb3RvIGJhZF9jZGJfbGVuOw0KPiAgDQo+ICAJCXhsYXRfZnVu
YyA9IGF0YV9nZXRfeGxhdF9mdW5jKGRldiwgc2NzaV9vcCk7DQo+ICAJfSBlbHNlIHsNCj4gLQkJ
aWYgKHVubGlrZWx5KCFzY21kLT5jbWRfbGVuKSkNCj4gLQkJCWdvdG8gYmFkX2NkYl9sZW47DQo+
IC0NCj4gLQkJeGxhdF9mdW5jID0gTlVMTDsNCj4gIAkJaWYgKGxpa2VseSgoc2NzaV9vcCAhPSBB
VEFfMTYpIHx8ICFhdGFwaV9wYXNzdGhydTE2KSkgew0KPiAgCQkJLyogcmVsYXkgU0NTSSBjb21t
YW5kIHRvIEFUQVBJIGRldmljZSAqLw0KPiAgCQkJaW50IGxlbiA9IENPTU1BTkRfU0laRShzY3Np
X29wKTsNCg0KRGlkIHlvdSBtaXNzIG15IHJlcGx5ID8NClRoaXMgY2hhbmdlIGlzIE9LLCBidXQg
d2hpbGUgYXQgaXQsIGxldCdzIGNsZWFudXAgdGhpcyBmdW5jdGlvbiBmdXJ0aGVyLg0KSSBzdWdn
ZXN0ZWQgc29tZXRoaW5nIGxpa2UgdGhpcywgd2hpY2ggaW5jbHVkZXMgeW91ciBjaGFuZ2VzLg0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvbGliYXRhLXNjc2kuYyBiL2RyaXZlcnMvYXRhL2xp
YmF0YS1zY3NpLmMNCmluZGV4IGExNmVmMDAzMDY2Ny4uZWQ4YmU1ODVhOThmIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9hdGEvbGliYXRhLXNjc2kuYw0KKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLXNj
c2kuYw0KQEAgLTM5NTgsNDIgKzM5NTgsMzkgQEAgaW50IF9fYXRhX3Njc2lfcXVldWVjbWQoc3Ry
dWN0IHNjc2lfY21uZCAqc2NtZCwNCnN0cnVjdCBhdGFfZGV2aWNlICpkZXYpDQogew0KIAl1OCBz
Y3NpX29wID0gc2NtZC0+Y21uZFswXTsNCiAJYXRhX3hsYXRfZnVuY190IHhsYXRfZnVuYzsNCi0J
aW50IHJjID0gMDsNCisNCisJaWYgKHVubGlrZWx5KCFzY21kLT5jbWRfbGVuKSkNCisJCWdvdG8g
YmFkX2NkYl9sZW47DQoNCiAJaWYgKGRldi0+Y2xhc3MgPT0gQVRBX0RFVl9BVEEgfHwgZGV2LT5j
bGFzcyA9PSBBVEFfREVWX1pBQykgew0KLQkJaWYgKHVubGlrZWx5KCFzY21kLT5jbWRfbGVuIHx8
IHNjbWQtPmNtZF9sZW4gPiBkZXYtPmNkYl9sZW4pKQ0KKwkJaWYgKHVubGlrZWx5KHNjbWQtPmNt
ZF9sZW4gPiBkZXYtPmNkYl9sZW4pKQ0KIAkJCWdvdG8gYmFkX2NkYl9sZW47DQoNCiAJCXhsYXRf
ZnVuYyA9IGF0YV9nZXRfeGxhdF9mdW5jKGRldiwgc2NzaV9vcCk7DQotCX0gZWxzZSB7DQotCQlp
ZiAodW5saWtlbHkoIXNjbWQtPmNtZF9sZW4pKQ0KLQkJCWdvdG8gYmFkX2NkYl9sZW47DQorCX0g
ZWxzZSBpZiAoc2NzaV9vcCAhPSBBVEFfMTYgfHwgIWF0YXBpX3Bhc3N0aHJ1MTYpIHsNCisJCS8q
IHJlbGF5IFNDU0kgY29tbWFuZCB0byBBVEFQSSBkZXZpY2UgKi8NCisJCWludCBsZW4gPSBDT01N
QU5EX1NJWkUoc2NzaV9vcCk7DQoNCi0JCXhsYXRfZnVuYyA9IE5VTEw7DQotCQlpZiAobGlrZWx5
KChzY3NpX29wICE9IEFUQV8xNikgfHwgIWF0YXBpX3Bhc3N0aHJ1MTYpKSB7DQotCQkJLyogcmVs
YXkgU0NTSSBjb21tYW5kIHRvIEFUQVBJIGRldmljZSAqLw0KLQkJCWludCBsZW4gPSBDT01NQU5E
X1NJWkUoc2NzaV9vcCk7DQotCQkJaWYgKHVubGlrZWx5KGxlbiA+IHNjbWQtPmNtZF9sZW4gfHwN
Ci0JCQkJICAgICBsZW4gPiBkZXYtPmNkYl9sZW4gfHwNCi0JCQkJICAgICBzY21kLT5jbWRfbGVu
ID4gQVRBUElfQ0RCX0xFTikpDQotCQkJCWdvdG8gYmFkX2NkYl9sZW47DQorCQlpZiAodW5saWtl
bHkobGVuID4gc2NtZC0+Y21kX2xlbiB8fA0KKwkJCSAgICAgbGVuID4gZGV2LT5jZGJfbGVuIHx8
DQorCQkJICAgICBzY21kLT5jbWRfbGVuID4gQVRBUElfQ0RCX0xFTikpDQorCQkJZ290byBiYWRf
Y2RiX2xlbjsNCg0KLQkJCXhsYXRfZnVuYyA9IGF0YXBpX3hsYXQ7DQotCQl9IGVsc2Ugew0KLQkJ
CS8qIEFUQV8xNiBwYXNzdGhydSwgdHJlYXQgYXMgYW4gQVRBIGNvbW1hbmQgKi8NCi0JCQlpZiAo
dW5saWtlbHkoc2NtZC0+Y21kX2xlbiA+IDE2KSkNCi0JCQkJZ290byBiYWRfY2RiX2xlbjsNCisJ
CXhsYXRfZnVuYyA9IGF0YXBpX3hsYXQ7DQorCX0gZWxzZSB7DQorCQkvKiBBVEFfMTYgcGFzc3Ro
cnUsIHRyZWF0IGFzIGFuIEFUQSBjb21tYW5kICovDQorCQlpZiAodW5saWtlbHkoc2NtZC0+Y21k
X2xlbiA+IDE2KSkNCisJCQlnb3RvIGJhZF9jZGJfbGVuOw0KDQotCQkJeGxhdF9mdW5jID0gYXRh
X2dldF94bGF0X2Z1bmMoZGV2LCBzY3NpX29wKTsNCi0JCX0NCisJCXhsYXRfZnVuYyA9IGF0YV9n
ZXRfeGxhdF9mdW5jKGRldiwgc2NzaV9vcCk7DQogCX0NCg0KIAlpZiAoeGxhdF9mdW5jKQ0KLQkJ
cmMgPSBhdGFfc2NzaV90cmFuc2xhdGUoZGV2LCBzY21kLCB4bGF0X2Z1bmMpOw0KLQllbHNlDQot
CQlhdGFfc2NzaV9zaW11bGF0ZShkZXYsIHNjbWQpOw0KKwkJcmV0dXJuIGF0YV9zY3NpX3RyYW5z
bGF0ZShkZXYsIHNjbWQsIHhsYXRfZnVuYyk7DQoNCi0JcmV0dXJuIHJjOw0KKwlhdGFfc2NzaV9z
aW11bGF0ZShkZXYsIHNjbWQpOw0KKw0KKwlyZXR1cm4gMDsNCg0KICBiYWRfY2RiX2xlbjoNCiAJ
c2NtZC0+cmVzdWx0ID0gRElEX0VSUk9SIDw8IDE2Ow0KDQpEbyB5b3Ugc2VlIGFueSBwcm9ibGVt
IHdpdGggdGhpcyBjaGFuZ2UgPw0KDQotLSANCkRhbWllbiBMZSBNb2FsDQpXZXN0ZXJuIERpZ2l0
YWwgUmVzZWFyY2gNCg0K
