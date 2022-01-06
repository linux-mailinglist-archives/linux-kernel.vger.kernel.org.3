Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78AF4864E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiAFND4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:03:56 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23491 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbiAFNDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641474235; x=1673010235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WzWOWBDZDGB4wVw1EeEuiEOwxldqwJP4rlvhyHdPydQ=;
  b=eWSwRbPE8nCZBpLCZUqBEgqzkRc9WB7B79VmGjCV3GhtaGhpn39TqLOF
   ehVOmCBJ4aDKQluFzrBkTQIeoSlctTdw0TKXVoTAzLw8VOGVjY2QuJvcM
   fb1/6Kv3rgEH3Vr4ocu5rZEzYKWI+RuK9wEwahGKJEMB9gjoiikejrITU
   cMAWpjbhgHT12ZdKoUl0pNJJuflldDgtw7OvkTBxJUlK0moZ2d2H6VbQA
   WTrML3uXGjjFGj2AEie4nZcJpZFVu5EoWkJyij0bmMsJlGSJ+zGKt5db2
   zd3EEIUqYVwiV8hZ9CQLVP0LUEBd+5AVsMrEqAsoQ6q9jT74nnNLELpnP
   w==;
IronPort-SDR: S6iZtbgo2e8+sdR5sbbSy8WBDAcxry7wOJ/5rYdaT2hQfcJSqDp8lRyWdkXpx9WkcQr9SUJFAg
 jXDjcnaluv9/45RaLYM3u4uEQafiOekD3Pzwef2TGcRwP1kZbafDglk0spZHdAfeXmtComhB1T
 t9FOjNJdxlBN2fcKvPcewow55xhe8n9kYTSh9Ea6qVtqNzlruv8CPjCKGRkyKr1KBGLhXwNv1y
 sIksO1dah9hAC2y9k3z2+xuW9DUnqwcZM0ha/T/8BmoKr+9ltAQsgkz+a6POHJB7qb0IK/wnCa
 l58xCpAHG4tqlxVwP4t1XlDV
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="144552399"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jan 2022 06:03:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 6 Jan 2022 06:03:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 6 Jan 2022 06:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic1QUE2RVsOzALwWAsdlskY6Q0Cj3DS+Vg6Hm6NIiLm5otDaVCirpJuY94yLkfo9N2Mv8cwWDIF9XM17qTHvhvYbcZBfnFAOQn6E6iVWyxUhL25n745qPHrlzdGk4uJ1OUYWfFCAnR5Yfbzq7/rfZri1nRQhUjPeIHphFiBVDtAHwXVShWmIOA0kBI/InzRQ2g5X6D28fJ5NvyO7bLf6lUSCzXxDPCg+5L2a617F12UmmJj4mqFNaNUfPHP3gGUCiVj4PjpMETmVPl8uWCQr1gU50uGracfkJYuc2vdoH43D6OlcHc7hlIBqNiiI3KSrHzGbKRWG0tISANCx+rbQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzWOWBDZDGB4wVw1EeEuiEOwxldqwJP4rlvhyHdPydQ=;
 b=LySES+0EpDEn6i3L4BN4eYtyuNq+JO8yu34SStEayTupM9dRxG77ogoQsKp++6ZOcxTIhi0rGsLbOtplriV+FEEu3hWOuytKP+NYfRLJLazGG1/DetqoGFZ4Y2XuyUMxmPVFYAf8/eKEiS9g0+J6+wxrUwxxSd3fJ3oZqdljmpHgUshCrjhwxUiyQnlP2oA0qNI/+cNSGp8ODfgmr+eWfxuvsD/Ro0HnDm3Nuj/rOmfoquEShq66Co4V5VkNtwkgjWYw6vXwY8Cp0XmbQzFlvi8WUlFuWrDr/Gr+lpkSJjTwKzLJjsIFJDLkYIoL9LB0KruSTE/iXDTd8Rd7x2LdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzWOWBDZDGB4wVw1EeEuiEOwxldqwJP4rlvhyHdPydQ=;
 b=ryGKEvteciJ9x4dzc3QNVh7pnUI+U5b+0AzW6A/iaMKegvexKvBmsm/h4GeTQ2P2U4TiVC0P8WgUtFN6v1maLOtx1XMOnpF/83oDUdmePEAVWzuQFXlBoadpdi6sJSb4L/zUizR4LpMSS60E0jDXpicQOORrZgxYuOiwkGx5Q4M=
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 13:03:49 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0%5]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 13:03:49 +0000
From:   <Ajish.Koshy@microchip.com>
To:     <john.garry@huawei.com>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <Viswas.G@microchip.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishakhavc@google.com>, <ipylypiv@google.com>,
        <Ruksar.devadi@microchip.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
Subject: RE: [PATCH RFT] scsi: pm8001: Fix FW crash for maxcpus=1
Thread-Topic: [PATCH RFT] scsi: pm8001: Fix FW crash for maxcpus=1
Thread-Index: AQHYAZlqeHDSesDCREuHsBTTpgV6WaxTz00AgAB8JwCAAah/EA==
Date:   Thu, 6 Jan 2022 13:03:49 +0000
Message-ID: <PH0PR11MB5112F9E9BB9F029DB9A67739EC4C9@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <1641320780-81620-1-git-send-email-john.garry@huawei.com>
 <d2d3c903-fb91-e218-9e0a-aeb2ff9e401a@opensource.wdc.com>
 <2746563e-28ce-b328-3494-f91ace1599f1@huawei.com>
In-Reply-To: <2746563e-28ce-b328-3494-f91ace1599f1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f54a818-4368-448c-e85e-08d9d114fb3d
x-ms-traffictypediagnostic: PH0PR11MB5032:EE_
x-microsoft-antispam-prvs: <PH0PR11MB5032348CA9D0862E91B7E777EC4C9@PH0PR11MB5032.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkYRMqI1DivlSrRqqm/DH3pANhq17u4ijAsYLA2CKb8SDHPt8FVkZ7mKBlLf7hzM0SW/6xMgx5Mxia9t1PKgWm7hrqyVHH61kqJXyHEVK9hy3gSTynVy4wybgF/e8GTeGVqzTrE42lJDavu6etXXeZofPYUeEVgmpeRGGBtByrZv6E++8AlBTIgM3pMaQYPnsmLxtHJm6Xq8Uf0YVmQEIlv2a/8EK+0FjfuYcmYz1CZZ7wBUjYFl9Hjh8IFZYsUXPaAPPQksg/Sx9mJHYAZbOEgsocUkfjTFW1g2/sLJQPosjRFXKhaesrfJSM5WCXP2E1NDDRwQrRDSf54iXc+oYcs+bcpVfOuO7vuFNvHcCA0pdMZ2FlSceSaUEa3NxirJNhdkQ0HVEHUuewELnAjVn6Unes8ba4DAPJQB5y+HooXfg9bgpVSFx01NeksTRsxlxfuPHSLHLpGhBa55N4P4AqxtrUv2VDEZ8shK2JXxNRz9R+1euFVBMUUcYTERH8NEBarwR2AsKROZH8wTMLqGujJHUR8tZ3nMl4a5tAsKoD35ZcC8hwunMlo/rTRwqXvn4fRshpd5SkVQ4KrvLRVPE2alNgXhq9ilfr5S6vCtC70/vPrH3enihNTm+P9MBqjkbxT2mLuj5yMy4dzF9OXm7YaasOCj8bO3+/AfIm61TwUBk1qAaQLN3AM7Y6Qr0WxU42PP2Ss5gT1K0HmKcFFv4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(508600001)(186003)(71200400001)(55236004)(8676002)(26005)(53546011)(2906002)(6506007)(7696005)(38070700005)(9686003)(4326008)(107886003)(52536014)(76116006)(5660300002)(6636002)(66556008)(64756008)(316002)(66446008)(86362001)(66946007)(66476007)(122000001)(38100700002)(33656002)(83380400001)(110136005)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWdxcmdZV0VrR2xVQlkxai9zTFpjSkE2OEFPYTlqTkM3aDNGWGZrZWRPaTZy?=
 =?utf-8?B?RHZEV0xyY0ZWL21Fbks4RnpkUnIwYlZoOU1KYWRxM3krOVo2SDhSU05KNzF1?=
 =?utf-8?B?NlpZT3N6eEhEMThKQkxJOUNZdVN6NjNoVGxFVzExNEFaNDN0V1dQQnRmQlNV?=
 =?utf-8?B?M2NuUE9nSUFhK2dPaTdsNittVks1OGlEVmliUWVhUVU2eGdDRnpTbVAzRXBp?=
 =?utf-8?B?MndESWN6SU9DZDB1bWg5YTNJSnM2WVJwa2Y3UWQwSEdpanovUnJ2TkZOVTEx?=
 =?utf-8?B?bGZFUXc4Y3VYMCtoVzJCNUdIZDNVMjJBQ3YrY0xTd2JoNDMvTE56ZktrZ2pN?=
 =?utf-8?B?RzR1MFZ2YkY4blN6cmlWOTRONW9UamgxaG41SE9YOEZTT25QeFBaY2N1ZVRz?=
 =?utf-8?B?OHNZdytXVUxadFExcUliL2M4UitrMjdDQUttOGExOFRKaDJYRlpPS3lPUXNx?=
 =?utf-8?B?ZW9tcjd3cy9QNEtFaXlqbThQbEZESkN6Y1FKcHA3TWU2U2hVc1oxeHFoT3ZU?=
 =?utf-8?B?d21XcHY1dkJSS2M2eTFCSHhVM0VqQzBOeW1PWHhjdjluY3ArNnpnbEY5cGY2?=
 =?utf-8?B?cm41TFhJam1RUUVIRUdzeVZWTm16RU5vRGdyZU5tTXB6THhRV0lpODZWYjlO?=
 =?utf-8?B?dDZpY2k2L3BPdFpzNjFUdmxMRXhvNXVpa1JNSjM2dU10SWhhc1ZSa09IRTJr?=
 =?utf-8?B?bGtkb2RPN2krRWk0ckZpT3cxQ1c1RDV3MEMrSml0VHQwSHRlMUlObHZWTHVC?=
 =?utf-8?B?bWxtTU9pS0JjTHVZNjZwNFNNRWZHb2laZHk3NmR2RW9iVmRyeTFlOWdKb2RH?=
 =?utf-8?B?NGhndFd0eUJXVzQrVjVJQ3RXbUw4bVVPV3ZDSWNlUkxSM0wrMVcwaVNSRkVs?=
 =?utf-8?B?cUJJUE1YdDRBd0l5bG4vall1VUVLV002SWJXMW4xaG1QM3BuaFdmVE5vdjFU?=
 =?utf-8?B?MHZ1VDFJYXpJWjkvNnZPbElHQmFjUjJTSk1HUmVzOEtuNDBEcHBBL3NzYk56?=
 =?utf-8?B?cXByZDdJRFg0QkhyZnkvNnBRd0VwSHlTWlloZDZnc2hOaWczR20vVDBVdUlU?=
 =?utf-8?B?c08vSGppM0lJdUZlTkFUTUZPdG1VbkhQa1VLdnc0dzMzRm15S054Q2RUOHNo?=
 =?utf-8?B?bmludGQ1SjFmMXpEbUVIWjlVQWlKS3RORmRqWWhyYU4vbXRMYlQ2KzRSL09J?=
 =?utf-8?B?dWIzT004dXBJWUFRaU16YldBRDcydkY0OTRjQlllZk5wKzFRNEE4ZjJ3TFNM?=
 =?utf-8?B?ZkYyNnVBREJ1cjFhbUtWQ2ZtRkI5VVdWTXhzTDllNGkzMWtFa3NvaDBPSDRD?=
 =?utf-8?B?L3VMQnhYSEtjeDVkNEF4VkxOR0FUY2ErQklRSllHa3F3Vjl4Rzd0bHd6SDRJ?=
 =?utf-8?B?TXJvM2l2WGp2Nmx2QmorM3k2K3ZUc1hPdGxpOXF5aks5NGZwMWgvVnZGSEdi?=
 =?utf-8?B?L1FtVUxHM25UWXlEM0ZFNUVvTVlaQzBBNnZneXA2RnFGK2wzU0gwUFBLYTNu?=
 =?utf-8?B?Z3hZNjErN0YrakVwMXA4QjAwNWpGWkhFRWhuTnZUTG5IWG82VS9mbHVqWGZG?=
 =?utf-8?B?V2g5d0FwZnpwMVlZdC9zcGJpRjdiUzVPQ2xNK01TRkEwZktoZDlMdEx0QnZO?=
 =?utf-8?B?MlQ1VG95SE5oRXZweGJia0I1a3pVb3FoU0RXTjlQTEkvbXNva3p6VHJWdGRQ?=
 =?utf-8?B?cE80ODQzSEkrTWQzYmY3Ny9nTnp6SVdqSzBPcjI5VlR5VGRtNXRoMVdRclAx?=
 =?utf-8?B?ODZmTjdIbGhFcjRyb3R5MHFrSUdoUlNDREkvYmxrb2VyYVJRM09aeUozejRP?=
 =?utf-8?B?MEM2MEhnUVhUQ09IZEdhUnNZcjVoWmlhMVoxRjRuV3ZFWm94MWpoUTlXUFNJ?=
 =?utf-8?B?RE9yMGFSdGIydkRLcnozcXAwTmE2ZEJzYnRvcTBhRzNyT1pWN3N2NVJPNDNE?=
 =?utf-8?B?V05CTlY0SVR4UWIrY0VUZ3BUVEtxZ2JOc2psTHJMSTR1RkhTbUttZjdlWUJm?=
 =?utf-8?B?bHhBMnJVOEhBY2VabCt3NjJETS9CY0l1Yy9vcGpxU1BNc0pQYnJUR1ArRVpk?=
 =?utf-8?B?WWhZMEdzK0g0b3JKRDBQa2dXSktmU2JScWtEM2pWQVU2MHRVRjNEVUZMZ05S?=
 =?utf-8?B?aS9ZYUR0Sk1TT3JxTXFuS0lmTm5uRkJVNjlzQjFHR3B1R0JUNjRPc2JZQVgy?=
 =?utf-8?B?b0ErSzlROHlsNlQ3U3dQTGlZdkVvMDRZY0dEY1lJemVzUW56OWJZMThNanVL?=
 =?utf-8?B?ZEZqeW9KYkp4Y05UUjA5YTBJdVJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f54a818-4368-448c-e85e-08d9d114fb3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 13:03:49.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: er+6ZJF4KwumTRCfVysenKtslGmwVE8fJxE0VyvoXOBWb0qgn3VCF+WrcgNLMQqid0+cE8XJPi1x1sdocLWdMAXBOarpXHSgVjUuPX284nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAwNS8wMS8yMDIyIDA0OjAzLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gPiBPbiAxLzUv
MjIgMDM6MjYsIEpvaG4gR2Fycnkgd3JvdGU6DQo+ID4+IEFjY29yZGluZyB0byB0aGUgY29tbWVu
dCBpbiBjaGVja19md19yZWFkeSgpIHdlIHNob3VsZCBub3QgY2hlY2sgdGhlDQo+ID4+IElPUDFf
UkVBRFkgZmllbGQgaW4gcmVnaXN0ZXIgU0NSQVRDSF9QQURfMSBmb3IgODAwOCBvciA4MDA5DQo+
IGNvbnRyb2xsZXJzLg0KPiA+Pg0KPiA+PiBIb3dldmVyIHdlIGNoZWNrIHRoaXMgdmVyeSBmaWVs
ZCBpbiBwcm9jZXNzX29xKCkgZm9yIHByb2Nlc3NpbmcgdGhlDQo+ID4+IGhpZ2hlc3QgaW5kZXgg
aW50ZXJydXB0IHZlY3Rvci4gQ2hhbmdlIHRoYXQgZnVuY3Rpb24gdG8gbm90IGNoZWNrDQo+ID4+
IElPUDFfUkVBRFkgZm9yIHRob3NlIG1lbnRpb25lZCBjb250cm9sbGVycywgYnV0IGRvIGNoZWNr
IElMQV9SRUFEWSBpbg0KPiBib3RoIGNhc2VzLg0KPiA+Pg0KPiA+PiBUaGUgcmVhc29uIEkgYXNz
dW1lIHRoYXQgdGhpcyB3YXMgbm90IGhpdCBlYXJsaWVyIHdhcyBiZWNhdXNlIHdlDQo+ID4+IGFs
d2F5cyBhbGxvY2F0ZWQgNjQgTVNJKFgpLCBhbmQganVzdCBkaWQgbm90IHBhc3MgdGhlIHZlY3Rv
ciBpbmRleA0KPiA+PiBjaGVjayBpbiBwcm9jZXNzX29xKCksIGkuZS4gIHRoZSBoYW5kbGVyIG5l
dmVyIHJhbiBmb3IgdmVjdG9yIGluZGV4IDYzLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBK
b2huIEdhcnJ5PGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4NCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc2NzaS9wbTgwMDEvcG04MHh4X2h3aS5jDQo+ID4+IGIvZHJpdmVycy9zY3NpL3Bt
ODAwMS9wbTgweHhfaHdpLmMNCj4gPj4gaW5kZXggMjEwMWZjNTc2MWMzLi43N2I4YmIzMDYxNWIg
MTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvc2NzaS9wbTgwMDEvcG04MHh4X2h3aS5jDQo+ID4+
ICsrKyBiL2RyaXZlcnMvc2NzaS9wbTgwMDEvcG04MHh4X2h3aS5jDQo+ID4+IEBAIC00MTYyLDkg
KzQxNjIsMTYgQEAgc3RhdGljIGludCBwcm9jZXNzX29xKHN0cnVjdCBwbTgwMDFfaGJhX2luZm8N
Cj4gKnBtODAwMV9oYSwgdTggdmVjKQ0KPiA+PiAgICAgIHUzMiByZWd2YWw7DQo+ID4+DQo+ID4+
ICAgICAgaWYgKHZlYyA9PSAocG04MDAxX2hhLT5tYXhfcV9udW0gLSAxKSkgew0KPiA+PiArICAg
ICAgICAgICAgdTMyIG1pcHNhbGxfcmVhZHk7DQo+ID4+ICsNCj4gPj4gKyAgICAgICAgICAgIGlm
ICgocG04MDAxX2hhLT5jaGlwX2lkID09IGNoaXBfODAwOCkgfHwNCj4gPj4gKyAgICAgICAgICAg
ICAgICAocG04MDAxX2hhLT5jaGlwX2lkID09IGNoaXBfODAwOSkpDQo+ID4gbml0OiBubyBuZWVk
IGZvciB0aGUgaW5uZXIgYnJhY2tldHMgaGVyZS4NCj4gDQo+IG9rLCBJIGNhbiBmaXggdGhhdC4N
Cj4gDQo+IEJ1dCBJIHdvdWxkIGFsc28gbGlrZSBvcGluaW9uIGZyb20gbWljcm9jaGlwIGd1eXMv
bWFpbnRhaW5lciBvbiB3aHkgdGhpcw0KPiBjb2RlIGlzIGhlcmUgYXQgYWxsLiBTZWVtcyBzdHJh
bmdlIGluIHRoZSB3YXkgd2UgY2hlY2sgaW4gdGhpcyByZWdpc3RlciBpbiB0aGUNCj4gaW50ZXJy
dXB0IGhhbmRsZXIgZm9yIG9ubHkgYSBzcGVjaWZpYyB2ZWN0b3IgYW5kLCBhbHNvLCB3aHkgd2Ug
Y2hlY2sgYXQgYWxsIGluDQo+IGFuIGludGVycnVwdCBoYW5kbGVyLg0KDQpIZXJlIGlzIG15IGlu
aXRpYWwgdW5kZXJzdGFuZGluZyBzbyBmYXIgYmFzZWQgb24gdGhlIGNvZGUNCmFuZCBkYXRhIHNo
ZWV0DQoNCjEuIENvbnRyb2xsZXIgaGFzIHRoZSBjYXBhYmlsaXR5IHRvIGNvbW11bmljYXRlDQp0
byB0aGUgaG9zdCBhYm91dCBmYXRhbCBlcnJvciBjb25kaXRpb24gdmlhIGNvbmZpZ3VyZWQNCmlu
dGVycnVwdCB2ZWN0b3IgTVNJL01TSS1YLg0KMi4gVGhpcyBjYXBhYmlsaXR5IGlzIGFjaGlldmVk
IGJ5IHNldHRpbmcgdHdvIGZpZWxkcw0KIGEuIEVuYWJsZSBDb250cm9sbGVyIEZhdGFsIGVycm9y
IG5vdGlmaWNhdGlvbiANCiAgICBEb3dyZCAweDFDLCBCaXRbMF0uDQogICAgMSAtIEVuYWJsZTsg
MCAtIERpc2FibGUNCiAgICBDb2RlOiBwbTgwMDFfaGEtPm1haW5fY2ZnX3RibC5wbTgweHhfdGJs
Lg0KICAgIGZhdGFsX2Vycl9pbnRlcnJ1cHQgPSAweDAxOw0KIGIuIEZhdGFsIEVycm9yIEludGVy
cnVwdCBWZWN0b3IgRHdvcmQgMHgxQywgYml0WzE1OjhdDQogICAgVGhpcyBwYXJhbWV0ZXIgY29u
ZmlndXJlcyB3aGljaCBpbnRlcnJ1cHQgdmVjdG9yDQogICAgaXMgdXNlZCB0byBub3RpZnkgdGhl
IGhvc3Qgb2YgdGhlIGZhdGFsIGVycm9yLg0KICAgIENvZGU6IC8qIFVwZGF0ZSBGYXRhbCBlcnJv
ciBpbnRlcnJ1cHQgdmVjdG9yICovDQogICAgcG04MDAxX2hhLT5tYWluX2NmZ190YmwucG04MHh4
X3RibC4NCiAgICBmYXRhbF9lcnJfaW50ZXJydXB0IHw9DQogICAgKChwbTgwMDFfaGEtPm1heF9x
X251bSAtIDEpIDw8IDgpOw0KDQpQcm9iYWJseSB0aGlzIHdpbGwgYmUgdGhlIHJlYXNvbiB3aHkg
d2UgY2hlY2sNCnRoZSB2ZWN0b3IgaW4gcHJvY2Vzc19vcSgpIGZvciBwcm9jZXNzaW5nDQpjb250
cm9sbGVyIGZhdGFsIGVycm9yIA0KDQppZiAodmVjID09IChwbTgwMDFfaGEtPm1heF9xX251bSAt
IDEpKSB7DQogDQpQbGVhc2UgZG8gbGV0IG1lIGtub3cgaWYgaXQgaGVscGVkIGluIGNsYXJpZmlj
YXRpb24uDQoNCj4gPg0KPiA+PiArICAgICAgICAgICAgICAgICAgICBtaXBzYWxsX3JlYWR5ID0g
U0NSQVRDSF9QQURfTUlQU0FMTF9SRUFEWV84UE9SVDsNCj4gPj4gKyAgICAgICAgICAgIGVsc2UN
Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAgbWlwc2FsbF9yZWFkeSA9DQo+ID4+ICsgU0NSQVRD
SF9QQURfTUlQU0FMTF9SRUFEWV8xNlBPUlQ7DQo+ID4+ICsNCj4gPj4gICAgICAgICAgICAgIHJl
Z3ZhbCA9IHBtODAwMV9jcjMyKHBtODAwMV9oYSwgMCwgTVNHVV9TQ1JBVENIX1BBRF8xKTsNCj4g
Pj4gLSAgICAgICAgICAgIGlmICgocmVndmFsICYgU0NSQVRDSF9QQURfTUlQU0FMTF9SRUFEWSkg
IT0NCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNDUkFUQ0hfUEFE
X01JUFNBTExfUkVBRFkpIHsNCj4gPj4gKyAgICAgICAgICAgIGlmICgocmVndmFsICYgbWlwc2Fs
bF9yZWFkeSkgIT0gbWlwc2FsbF9yZWFkeSkgew0KPiA+PiAgICAgICAgICAgICAgICAgICAgICBw
bTgwMDFfaGEtPmNvbnRyb2xsZXJfZmF0YWxfZXJyb3IgPSB0cnVlOw0KPiA+PiAgICAgICAgICAg
ICAgICAgICAgICBwbTgwMDFfZGJnKHBtODAwMV9oYSwgRkFJTCwNCj4gPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiRmlybXdhcmUgRmF0YWwgZXJyb3IhDQo+ID4+IFJlZ3ZhbDow
eCV4XG4iLCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3BtODAwMS9wbTgweHhfaHdpLmgNCj4g
Pj4gYi9kcml2ZXJzL3Njc2kvcG04MDAxL3BtODB4eF9od2kuaA0KPiA+PiBpbmRleCBjN2U1ZDkz
YmVhOTIuLmM0MWVkMDM5YzkyYSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9zY3NpL3BtODAw
MS9wbTgweHhfaHdpLmgNCj4gPj4gKysrIGIvZHJpdmVycy9zY3NpL3BtODAwMS9wbTgweHhfaHdp
LmgNCj4gPj4gQEAgLTE0MDUsOCArMTQwNSwxMiBAQCB0eXBlZGVmIHN0cnVjdCBTQVNQcm90b2Nv
bFRpbWVyQ29uZmlnDQo+IFNBU1Byb3RvY29sVGltZXJDb25maWdfdDsNCj4gPj4gICAjZGVmaW5l
IFNDUkFUQ0hfUEFEX0JPT1RfTE9BRF9TVUNDRVNTICAgICAgMHgwDQo+ID4+ICAgI2RlZmluZSBT
Q1JBVENIX1BBRF9JT1AwX1JFQURZICAgICAgICAgICAgIDB4QzAwDQo+ID4+ICAgI2RlZmluZSBT
Q1JBVENIX1BBRF9JT1AxX1JFQURZICAgICAgICAgICAgIDB4MzAwMA0KPiA+PiAtI2RlZmluZSBT
Q1JBVENIX1BBRF9NSVBTQUxMX1JFQURZICAgKFNDUkFUQ0hfUEFEX0lPUDFfUkVBRFkgfA0KPiBc
DQo+ID4+ICsjZGVmaW5lIFNDUkFUQ0hfUEFEX01JUFNBTExfUkVBRFlfMTZQT1JUDQo+IChTQ1JB
VENIX1BBRF9JT1AxX1JFQURZIHwgXA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgU0NSQVRDSF9QQURfSU9QMF9SRUFEWSB8IFwNCj4gPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFNDUkFUQ0hfUEFEX0lMQV9SRUFEWSB8IFwNCj4gPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNDUkFUQ0hfUEFEX1JBQUVfUkVBRFkp
DQo+ID4+ICsjZGVmaW5lIFNDUkFUQ0hfUEFEX01JUFNBTExfUkVBRFlfOFBPUlQNCj4gKFNDUkFU
Q0hfUEFEX0lPUDBfUkVBRFkgfCBcDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBTQ1JBVENIX1BBRF9JTEFfUkVBRFkgfCBcDQo+ID4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBTQ1JBVENIX1BBRF9SQUFFX1JFQURZKQ0KPiA+Pg0KPiA+PiAg
IC8qIGJvb3QgbG9hZGVyIHN0YXRlICovDQo+ID4gT3RoZXJ3aXNlLCBsb29rcyBPSyB0byBtZS4N
Cj4gPiBJIHRlc3RlZCB3aXRoIGFuZCB3aXRob3V0IG1heF9jcHVzPTEgd2l0aCBhIEFUVE8gVGVj
aG5vbG9neSwgSW5jLg0KPiA+IEV4cHJlc3NTQVMgMTJHYi9zIFNBUy9TQVRBIEhCQSAocmV2IDA2
KSBhZGFwdGVyIGFuZCBldmVyeXRoaW5nIGlzIE9LLg0KPiA+IFRoYXQgYWRhcHRlciB1c2VzIGNo
aXBfODA3MiB0aG91Z2gsIG5vdCA4MDA4IG9yIDgwMDkuDQo+ID4NCj4gPiBGZWVsIGZyZWUgdG8g
YWRkOg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IERhbWllbiBMZSBNb2FsPGRhbWllbi5sZW1vYWxA
b3BlbnNvdXJjZS53ZGMuY29tPg0KPiA+IFRlc3RlZC1ieTogRGFtaWVuIExlIE1vYWw8ZGFtaWVu
LmxlbW9hbEBvcGVuc291cmNlLndkYy5jb20+DQo+IA0KPiBUaGFua3MhDQo+IA0KPiBqb2huDQoN
ClRoYW5rcywNCg0KQWppc2gNCg==
