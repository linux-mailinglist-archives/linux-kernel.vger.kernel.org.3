Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5A4A85D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351021AbiBCOKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:10:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:26783 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243066AbiBCOKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643897411; x=1675433411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wJGXDOS6aEThtLJQ4zhXJJTQucXjprva5s0FKsxtnds=;
  b=KzVvV/YE+Yn4iK6sPJaK/i9uuELlV4nSVaO9WnvZnZTA15T1FU9F7iF1
   N7aOkNHnpD5ZPKJks1UsDH02UCsSeeHFe8I6rMSGIFfHvkk4bVhHB4InJ
   b1lIEmVgJlH7hLU4E/HvR3JdOLS32+8ow2kxEjqZTXvRtyXZ4zU/cfxur
   cLdrD8M/6LF+o/dZEaV9OSvxyvXHdIfTgWPOWs/PRdSoLgoPyR6vCa0n4
   zy2/ObU3wu3sZ6gyHytWMb5AaeGok/JMuu4oiSwn+G6qNOWMPMKaA21ro
   nUKS+dQ0/PfWxTxB4Z3j2i2u7Uv+8m8nPHB6ZqY58uhFkXiWIDAuGys7R
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228800553"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="228800553"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="620507671"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Feb 2022 06:10:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 06:10:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 06:10:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 3 Feb 2022 06:10:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 3 Feb 2022 06:10:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD0Zh/tk8ieJvJ5wZFxAahl9oM8maC1aY8Gc179ZIQmsqcjBD3wSgVRWxAQkLRpNMuFx2ZLOsOaKwhX2UGCHbEWH0EDlUxxDJH5eiEQxRWhYCNgeYLtxsBXkLpaN1fJly4iT34anT4T6jMBHooEPu+lt2j+tSruydkFT8fhi+k2dsXhfpzBmvIQJVeYhOy2VEvAL7mojG8ODJtQX4EOlY9ioIYak1Im3iU0QwCnEFBps2GW62wGmyfzQdI6MkGJsXczNupwPyYc5XGoMFLtR/Qpg+chw8XS1x4OzGhjmPmtybwIKpuMMvbIb7fSKe4KsnqZfjQBBfgltcY2tOG23zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJGXDOS6aEThtLJQ4zhXJJTQucXjprva5s0FKsxtnds=;
 b=EWAV+5y6S+uQUoLwgXTTuvWDT38jHWjDiG+rjP5mv5r9y/oe2/yMDGbyDe01ji97L7HhBGmKAYrRve8nEmruPoAhJ4SQYr+mNLS1QhvC5IIvaeaZjIlgYGYb+mJe7RBHj37vGp/ouKIxoaOx7AeeB1xE3+WDw7ZPW4gweqb2mbqzTBJZrtkqhMHvFhfq1+1HRxAiMUmRGtk1CQr8PbF/xXh3poZ4miKs30Gi0Iic86xtCYVOBVzq+nKeey/iAy1Z1lqlhR12ePwqz+Nvq1YHHnfqhMyk4cOl+1v7YJrSXWtPen37RCWo9F616aubu5Ct7/goxV8X9+9+wzz/cEfx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by BN8PR11MB3665.namprd11.prod.outlook.com (2603:10b6:408:91::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 3 Feb
 2022 14:10:06 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::ed09:2a87:f2d:4d05]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::ed09:2a87:f2d:4d05%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 14:10:06 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>
Subject: RE: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if
 it reads IPC_STATUS_ERR
Thread-Topic: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if
 it reads IPC_STATUS_ERR
Thread-Index: AQHX/VdVI9fbyn2ZKUGZmpjZsx6tm6xKtDaAgBxgGACAGv+RgA==
Date:   Thu, 3 Feb 2022 14:10:06 +0000
Message-ID: <CO1PR11MB483572AC606C04CBD061AC0896289@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20211230082353.2585-1-rajat.khandelwal@intel.com>
 <CO1PR11MB48359C6EC7DAC17F7FDD91D896459@CO1PR11MB4835.namprd11.prod.outlook.com>
 <e49ac79d-eca1-e404-922b-48129f8a7e54@redhat.com>
In-Reply-To: <e49ac79d-eca1-e404-922b-48129f8a7e54@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: hdegoede@redhat.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a5231ea-5c75-445d-a6be-08d9e71ee15e
x-ms-traffictypediagnostic: BN8PR11MB3665:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB3665C781B3E6F7C3425AA62296289@BN8PR11MB3665.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXPWkoj7Pn0MQKV8+X87lCLz6DMGr/duW2gABimb4zjC0bClX+ge0a3FNTZrGanWA/U41CSRCBKIun4Dw6IhzDXSFs6MT5MWB7T/WyrXp/rjrEjMzbgl+cbHZCU/IgDrN1Zah5oe9tLYWV13MX89GMQ0HR/uvS6V5vu4EXkqH2bz03jA/WT6oSuL+QNS1j8KKQb5sTHcUfXschY82e8l2j7zhfZKTAhCmdixwwk3n4ol+WoioeMdU6giKmr/9W/46VsIKM5eh+y2TsOWe2FCcxSFm4aDjIIdYZEUecuspLtPPEjFXi49HRVdqgShWisaUqBAWZqRwbYvuIHUaR/vGSe9YmGkSByW8pSnh+HMn/85dqGv3unlL0/yXJsX5RDDkxm9TDNk9noX8COGSs/8GQUtG6oN7Ts4ku4JKbqPDY99I4DitFiGqK4HRRKkAIiC6OwmPwGjqGGMIpK2jo00+GNc5Xldy9iXh3Y28dyhsIDSat153/Knux7Et5bNXD/yCcu7qbVfx4SBTkH1DFbQ54vqSucv7lzg1bxPY09ydSMjHgQrTyVXT9zdEfd7XYIe8hdxtelQR2G6A0tSVabDSU5EkoKauvfoUmlXkJEk4mW7KVH00EozACpopBFQx4zhKikcKG9J2fBCZhN7aVeMsAX9F3VMgI7TUnB/JXnqBQOb2UHaE54vlnmppH7cmyG+DQi7jULrwIQxkfo6+VcOgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(4326008)(122000001)(508600001)(8676002)(8936002)(2906002)(86362001)(71200400001)(83380400001)(9686003)(55016003)(33656002)(6506007)(7696005)(186003)(26005)(316002)(5660300002)(52536014)(54906003)(38070700005)(110136005)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekdIWm4zOXhkSDFLLytLNnJ3K3JsOG95MTRsZWhtNHUyeHNFdC9rRW9UNUFh?=
 =?utf-8?B?Q3JyV3VhcmN2WWw2bXY2RnVDSXpLUjhKcGxjL3p5MS8yZnl1OWIvUGFYWG1R?=
 =?utf-8?B?eEJlc1NUQjhlZ25OTzlKWnU3QWQ3STYybHM1L25BMWhINXRSajI0a3kyRUVZ?=
 =?utf-8?B?NFMreTJ5c1RWMy9iUGpEUEY5S3JEQ3JsSkE4dW9hUks5MkQ5YVhDVDN4Rm40?=
 =?utf-8?B?eWYydnEyNTVkUGxNMzlOTXptODBQYnZmR2M5T2g0d2UyQ0hIRlF0bjIwZXF5?=
 =?utf-8?B?N3ZKK01GQnlHNWRXdTJwai9IODAxZlNPTHpCODN1TXZnQzBtQ1o2WTZQZGs1?=
 =?utf-8?B?eFRFTU5nQTFxRWVmZ0c1K0dHOXFZNXREMkJwY0ZQT0dlTjV2YmI2UE5NeTFG?=
 =?utf-8?B?bTVlRlBBQVpRejluT1QvQjNya3liZ3FqM2V4VTB0MFVpem1ja2RVL3ZseXpz?=
 =?utf-8?B?RXUybE1JdWtIUStSRVRrRURvRDV4Z3JIek9YRjZjSGozTUFvMFhjaXpSSThS?=
 =?utf-8?B?Zlc5THU5ZzJUZk5MTmFFRXhSR2cwRkNnblhwQnZaTk9FaHNrR0ZmbVJNM3VK?=
 =?utf-8?B?U1BvUkxqUitBRUtpWmhTSEwxZHIzcXRXb0tCVHF2NE0wcHZIMmk2WGpTYXR4?=
 =?utf-8?B?UldhU1cvUTdHUUtsQjRoQnIvam15R0g3akxUcGJtV0htK0Q2ZCtPUjBXYU55?=
 =?utf-8?B?d0tCTXpZa1Q4UG9rTmIrOUxjMFFoNjMxNTRwYnE5OVYreGlDdnk4UWtTSHlQ?=
 =?utf-8?B?TGZIS3orNDJZSGRVb0xPMDdWU0sydERCZjFwZFFlV3k2bVg2SFRFZTh1bFBy?=
 =?utf-8?B?MzRwWlZHMmE3MmU5U3dhU051dXBaMUFkNXVncy9GTWxscnE3SDJvUXlRalJ3?=
 =?utf-8?B?NXJSTzd1SXBMM3hKVjcyTWdYakRMdkdIRWhxaXFQOU05R21xd0RlL2dobEdC?=
 =?utf-8?B?bkFWcGhqMG9jL1gvMTRROXU3OW4wdHQ2ZkpROE54TVBPVk5IeUozSmNUOUpP?=
 =?utf-8?B?Q0U2aHVRNnptK0NpUGl1TXdkTlI2R3JUZWUrRUJnQmhPaTdINWY1OU12S3Vs?=
 =?utf-8?B?YmRoYmt0b1RXV0w4OXBRcm1ZaWNZdExOZGpqd0RKTlJYelI2RTdxcmtVU3hj?=
 =?utf-8?B?dnhsZkV0bHk3SkdkMGZVWXhtZVV2ZmJyam5VcU9Lc0ZxQVZ0Q2w0MGFTMW0w?=
 =?utf-8?B?STVCR09VaUw2Y1ZvNEdPV05mWGVzRnBBdkZEY2FRY1N0MDNlVWVyVy8yQk5Z?=
 =?utf-8?B?bHVIWFYyRklJQ1hKWlRQaExVVmhCdVA5SVJjOTU2VTVoczErZmpwdnBCNmVR?=
 =?utf-8?B?K0kvOWo5YTJOS3FjTElNbzdjV05lU2J3UHZvRnhUWGQ5aG9YUVNyUWc0RFM4?=
 =?utf-8?B?YytneHdHY2dyc3dvUC8xNkREZmVjNjFabWZyTGtUaEdNc2ovRjRBdW14d1BB?=
 =?utf-8?B?TUFWU1VZV0o4OUkxdGpqQVg3NGMvTERqQ1NOeTRxSHFJSE9COXN3MlZTanY1?=
 =?utf-8?B?cVd6UzJ3dTczMitZcHRVaXExdDFxU3NZZWVlUjFWbXRWMy9VcW9DVXFnWGFw?=
 =?utf-8?B?cHdtWWRUN3VyWG5PSmNKRi9qY2dlY1dVaWdwS0I4OUdoMEI2VjJtRUorVitm?=
 =?utf-8?B?WWp5Y1FXME9DUXNQOE1GNGtaL29FaUV2VEl2VXhlcWphTFZ6bFB4NU1KWTI3?=
 =?utf-8?B?UlBLZE5uZDRpd1JMaXdFeW5qaVQ2VmJIaGNrcWRqelNPN0p4bVpvekFKMnFs?=
 =?utf-8?B?aXFRN1ZQUjlidzVhd3VVSmN0RFBTWDFNc05leFdDanZ1UHpOY0NxMmNVSFhR?=
 =?utf-8?B?L25oS0R3d1RIRXQyRnVBNzZpUlYzYmJHbTFaYVNGT3Fhd293RmNPbWFLVGVY?=
 =?utf-8?B?NXczM2U5NnpsWnNxL2U2K3VTU0I4Q2pGc1oxYVRKQmp3NnRpa2FZSlFJeWp5?=
 =?utf-8?B?NG9NUzEwUkp4ZStmUmZSc3pnaWxnOWY0WWduWVhZdlRXRS9ueithcVlXaCtX?=
 =?utf-8?B?K0FWb1lNNzI1cVdlNVNVNG9mYVlhdlNTL1djaWk4OGN5cmpUYnJXRjlHQ3lD?=
 =?utf-8?B?TENTcEhxM0I0SlFmL3M2ZGtmMnQySVB4Z0s3UWppbDBsWkRNajBKb3M5Y2tN?=
 =?utf-8?B?WVgvZngycDl3WlJZNERmc3ZFUURYVE9GeTRtakpXeUFtb09PVXorWXZ6WStT?=
 =?utf-8?B?NEVVV0lQZFkwYlVVbXB0Yzd2Ynd1Q2JkbnIrWllqWUdTREx3empMSzNmNzhl?=
 =?utf-8?B?S1RFb3JNZjhLcXlTMzQxb2pZa0ZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5231ea-5c75-445d-a6be-08d9e71ee15e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 14:10:06.4810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RK9Loi23k+Mj4XZxXI4j15bwYnmNRrGIoORASzVe5530r2TT4anJYrxhrX0sWy8DBDtSd5eY2bd1jRsuhw7UcwZN2tcGggTYi/3ygmsOrm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3665
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQEhhbnMgZGUgR29lZGUNClllcywgd2hlbiB0aGUgRVJSIGJpdCBpcyBzZXQsIGl0IHN0aWxs
IHBvbGxzIHVudGlsIHRpbWVvdXQgZXhwaXJlcy4gDQpBbHNvLCBJUEMgZG9lc27igJl0IGNsZWFy
IHRoZSBiaXQgYWZ0ZXIgbXNlYyBhcyBJIGhhdmUgbWFudWFsbHkgdGVzdGVkIGl0IGFuZCB2ZXJp
ZmllZC4NCkJ1dCBhbHNvLCBpbiB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiwgaXQgcmV0dXJu
cyBFVElNRURPVVQgZXZlbiB3aGVuIHRoZSBzdGF0dXMgcmVmbGVjdHMgQlVTWS4gVGhpcyBsZWFk
cyB0byBkZXZlbG9wZXJzIHRoaW5raW5nIHRoYXQgdGhlIGNvbW11bmljYXRpb24gZGlkbuKAmXQg
Z28gdGhyb3VnaCBiZWNhdXNlIHRpbWVvdXQgb2NjdXJyZWQgbm90IGJlY2F1c2UgdGhlIFNDVSB3
YXMgYnVzeS4gV2UgaGFkIHRvIHdyaXRlIG1hbnVhbCBkZWJ1ZyBwcmludHMgdG8gZGlmZmVyZW50
aWF0ZSBiZXR3ZWVuIHRoZXNlIHR3by4gDQoNCkxpbnV4IDUuMTcgaGFzIGFsc28gY29tZS4gQ2Fu
IHlvdSBkcml2ZSBhIGNsb3N1cmUgdG8gdGhpcyBwYXRjaD8NCg0KVGhhbmtzDQpSYWphdA0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVA
cmVkaGF0LmNvbT4gDQpTZW50OiBNb25kYXksIEphbnVhcnkgMTcsIDIwMjIgMzoxOSBQTQ0KVG86
IEtoYW5kZWx3YWwsIFJhamF0IDxyYWphdC5raGFuZGVsd2FsQGludGVsLmNvbT47IG1pa2Eud2Vz
dGVyYmVyZ0BsaW51eC5pbnRlbC5jb20NCkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsgV2VzdGVyYmVyZywgTWlrYSA8
bWlrYS53ZXN0ZXJiZXJnQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBsYXRmb3Jt
L3g4NjogaW50ZWxfc2N1X2lwYzogS2VlcCBwb2xsaW5nIElQQyBzdGF0dXMgaWYgaXQgcmVhZHMg
SVBDX1NUQVRVU19FUlINCg0KSGksDQoNCk9uIDEyLzMwLzIxIDA5OjMwLCBLaGFuZGVsd2FsLCBS
YWphdCB3cm90ZToNCj4gSGkgTWlrYQ0KPiBJIGhvcGUgdGhpcyBhbm5vdGF0aW9uIGlzIGNvcnJl
Y3Q/IFNvcnJ5IGZvciB0aGUgbXVsdGlwbGUgZXJyb3JzISANCj4gDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEtoYW5kZWx3YWwsIFJhamF0IDxyYWphdC5raGFuZGVsd2Fs
QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDMwLCAyMDIxIDE6NTQgUE0N
Cj4gVG86IG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20NCj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyAN
Cj4gS2hhbmRlbHdhbCwgUmFqYXQgPHJhamF0LmtoYW5kZWx3YWxAaW50ZWwuY29tPjsgV2VzdGVy
YmVyZywgTWlrYSANCj4gPG1pa2Eud2VzdGVyYmVyZ0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSF0gcGxhdGZvcm0veDg2OiBpbnRlbF9zY3VfaXBjOiBLZWVwIHBvbGxpbmcgSVBDIHN0YXR1
cyANCj4gaWYgaXQgcmVhZHMgSVBDX1NUQVRVU19FUlINCj4gDQo+IFRoZSBjdXJyZW50IGltcGxl
bWVudGF0aW9uIHJldHVybnMgLUVJTyBpZiBhbmQgd2hlbiBJUENfU1RBVFVTX0VSUiBpcyByZXR1
cm5lZCBhbmQgcmV0dXJucyAtRVRJTUVET1VUIGV2ZW4gaWYgdGhlIHN0YXR1cyBpcyBidXN5Lg0K
PiBUaGlzIHBhdGNoIHBvbGxzIHRoZSBJUEMgc3RhdHVzIGV2ZW4gaWYgSVBDX1NUQVRVU19FUlIg
aXMgcmV0dXJuZWQgdW50aWwgdGltZW91dCBleHBpcmVzIGFuZCByZXR1cm5zIC1FQlVTWSBpZiB0
aGUgc3RhdHVzIHNob3dzIGJ1c3kuDQo+IE9ic2VydmVkIGluIG11bHRpcGxlIHNjZW5hcmlvcywg
dHJ5aW5nIHRvIGZldGNoIHRoZSBzdGF0dXMgb2YgSVBDIGFmdGVyIGl0IHNob3dzIEVSUiBzb21l
dGltZXMgZXJhZGljYXRlcyB0aGUgRVJSIHN0YXR1cy4NCg0KU28gd2hhdCB0aGlzIGlzIGRvaW5n
IGlzIGNvbnRpbnVlIHRvIHBvbGwsIGV2ZW4gdGhvdWdoIHRoZSBTQ1Ugc2F5cyBpdCBpcyByZWFk
eSwgd2hlbiB0aGUgRVJSIGJpdCBpcyBzZXQgPw0KDQpBcmUgd2Ugc3VyZSB0aGUgSVBDIGRvZXMg
bm90IGp1c3Qgc2ltcGx5IGNsZWFyIHRoZSBlcnIgYml0IGFmdGVyIHNvbWUgdGltZSBiZWN1c2Ug
aXQgZXhwZWN0cyBpdCB0byBiZSAiY29uc3VtZWQiIHdpdGhpbiBYIG1zZWMgYWZ0ZXIgZHJvcHBp
bmcgYnVzeSBsb3c/DQoNCklPVyB3aGF0IGd1YXJhbnRlZXMgYXJlIHRoZXJlIHRoYXQgdGhpcyBu
ZXcgYmVoYXZpb3Igb2YgaXBjX2RhdGFfcmVhZGwoKSBpcyBub3QgYWN0dWFsbHkgY2F1c2luZyB1
cyB0byBpZ25vcmUgYWN0dWFsIGVycm9ycyA/DQoNClJlZ2FyZHMsDQoNCkhhbnMNCg0KDQoNCg0K
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWphdC1LaGFuZGVsd2FsIDxyYWphdC5raGFuZGVsd2Fs
QGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9zY3VfaXBj
LmMgfCAxNCArKysrKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94
ODYvaW50ZWxfc2N1X2lwYy5jIA0KPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX3NjdV9p
cGMuYw0KPiBpbmRleCA3Y2M5MDg5ZDFlMTQuLjFmOTBhY2FhNzIxMiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfc2N1X2lwYy5jDQo+ICsrKyBiL2RyaXZlcnMvcGxh
dGZvcm0veDg2L2ludGVsX3NjdV9pcGMuYw0KPiBAQCAtMjMzLDE3ICsyMzMsMjMgQEAgc3RhdGlj
IGlubGluZSB1MzIgaXBjX2RhdGFfcmVhZGwoc3RydWN0IGludGVsX3NjdV9pcGNfZGV2ICpzY3Us
IHUzMiBvZmZzZXQpICBzdGF0aWMgaW5saW5lIGludCBidXN5X2xvb3Aoc3RydWN0IGludGVsX3Nj
dV9pcGNfZGV2ICpzY3UpICB7DQo+ICAJdW5zaWduZWQgbG9uZyBlbmQgPSBqaWZmaWVzICsgSVBD
X1RJTUVPVVQ7DQo+ICsJdTMyIHN0YXR1czsNCj4gIA0KPiAgCWRvIHsNCj4gLQkJdTMyIHN0YXR1
czsNCj4gLQ0KPiAgCQlzdGF0dXMgPSBpcGNfcmVhZF9zdGF0dXMoc2N1KTsNCj4gLQkJaWYgKCEo
c3RhdHVzICYgSVBDX1NUQVRVU19CVVNZKSkNCj4gLQkJCXJldHVybiAoc3RhdHVzICYgSVBDX1NU
QVRVU19FUlIpID8gLUVJTyA6IDA7DQo+ICsJCWlmICghKHN0YXR1cyAmIElQQ19TVEFUVVNfQlVT
WSkpIHsNCj4gKwkJCWlmICghKHN0YXR1cyAmIElQQ19TVEFUVVNfRVJSKSkNCj4gKwkJCQlyZXR1
cm4gMDsNCj4gKwkJfQ0KPiAgDQo+ICAJCXVzbGVlcF9yYW5nZSg1MCwgMTAwKTsNCj4gIAl9IHdo
aWxlICh0aW1lX2JlZm9yZShqaWZmaWVzLCBlbmQpKTsNCj4gIA0KPiArCWlmIChzdGF0dXMgJiBJ
UENfU1RBVFVTX0JVU1kpDQo+ICsJCXJldHVybiAtRUJVU1k7DQo+ICsJaWYgKHN0YXR1cyAmIElQ
Q19TVEFUVVNfRVJSKQ0KPiArCQlyZXR1cm4gLUVJTzsNCj4gKw0KPiAgCXJldHVybiAtRVRJTUVE
T1VUOw0KPiAgfQ0KPiAgDQo+IC0tDQo+IDIuMTcuMQ0KPiANCg0K
