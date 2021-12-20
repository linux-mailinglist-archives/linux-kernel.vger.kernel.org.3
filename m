Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90C447A833
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhLTLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:06:00 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:46150 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhLTLF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639998359; x=1671534359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/dkBK00CHDWc7Ho1tZFqTIuxmccHeJC77O9hZb012eI=;
  b=glodXKYDypNjngq3R+owLMiq4ZLGQ6b7csLKwElytQLxGfNb9IT9jOGs
   9lICwH+YG9KPwJd55grvTBL/CGKIg+tZiOKRvjr9zcbe+FoKWf4V7bS5E
   a5Zs31efWcP0M6IOgaG8DPYg4UM3oAAx5ZQe0ne7A179OJbJaRqQzT1ym
   xYzphVtHLrTJg/nSPIMUitxU4yiijUcibbQNAmPNeygVyFH8WyLEjx78V
   Lnz1KaCTgm8ndFcpcNZUnk3qbLkTR9SFT4nHb+cjJcjwqShdGfql5IPEa
   1OBZzIjQzoqImxc95y36pQuBNM/eeBXfUbg0Rep9asx9dWcL37lJeb+Iu
   Q==;
IronPort-SDR: Rezeg8UEL5dT6Jr3MgCbevbJ1wQdkwWUyU4Fa485/I6m8VkuYFyj2dA7Ax9SgMCv0lBCqkilCs
 zWy0ER96f2NSyIMJukhYheRV02i22VWYF0rEBwJS4TImlFuiALsXLKmIDk0e0eNEfxNiwgJmoZ
 ZjfGBaJdEEQMl9ZwaaQNF0FQA3+s4UgJ+J9U7WQNHQZ8RYcwqYuqOMMCxwy+IRsKXXcnMra+MY
 zBiMQ4xSSVk4MXu+aTDQy0B3BXJUZpUHKpU5i45JkPhGPwgBecPqC4uvjgiv6MDtODsWB0+QeA
 pvWHCoo0dBf9IRsItDRHVzXn
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="142964290"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2021 04:05:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 04:05:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 20 Dec 2021 04:05:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eawtJH0uFozxrnXHNqHFiDQGFb1E0zHp+GjSg30b7H5Pt0AJ8CD+XmGNWjVFGxG/PBNH0mdVww3lwbyyHAwxwmgY9EfIxrYofBGh+pe6m7Kgx0NMTBcWa4pXaJKqDDfb34RY7ciOYc5vh47f+XdlK8xvthmeKf3cEjoZ6AsMHw51fu+6V9itGV0IXh4DSLxFsJwFZXAMIqvFAxt9W/SHAVlmknPUIZWxPM+B0e028tOo9b9sEpDYc4sftoEyOPfo0k6cUTdtt+Qn+foK7e4Al9ibkZAs5/54BuvQUt9QuzjMnU98x/AzKmCtgrlNKWLk4KGZ7YFpY32b5CrveLZOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dkBK00CHDWc7Ho1tZFqTIuxmccHeJC77O9hZb012eI=;
 b=BMFvQx/3xEFHJgvslVAZZDH7rQtgVDwMQAn4E6CFn61N80XXVHqlMOfKTt9oS4SOFNzWUb4LD7Y4OLTdkvK3rLg7Lw4tQ40bVPp25kUheDgb+nfDoUxzr+vxECF4UHVP/ttLzitVXZ6qWqrjNpa74N/44epc3dlRMv2zpLcl3uAN6e8kvr70t35nhGg1/E+YfBxEC6Ax14YFzIVav/vdYrz0aLgNpMj3IBEgtjB28fPUDNkfN7qmtoX/QDVweNGYQ+5XyehaY6pAbFzo7kfaGFzO0C2nmpFc61SkCLni7/7v9rvFfWEiIl3Hj+U7YKPBhXlegn8KfkjsiDKsvODBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dkBK00CHDWc7Ho1tZFqTIuxmccHeJC77O9hZb012eI=;
 b=h/cda6d22Azv57H5IhAQscYduLpqvnWZV9DHkTg1caUdXC4RYzeLrpLh4TODWO7qJX5G0V9b8JYnkSwDSZN7jsMBDdUROMRR5J0VuaMSlMlaspAGYflrEKyCqP5103KH1D71jFsbi+6yUyjIaRy8sThn/m+aZGE8HeblOckwAr8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 11:05:47 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 11:05:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <vigneshr@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: macronix: Add support for
 mx66lm1g45g
Thread-Topic: [PATCH v2 2/2] mtd: spi-nor: macronix: Add support for
 mx66lm1g45g
Thread-Index: AQHX80ML08Rm+S6s0UW0k/rjmom+8Q==
Date:   Mon, 20 Dec 2021 11:05:47 +0000
Message-ID: <dac4db71-1f4b-13df-da9b-bedc2c0c2d4a@microchip.com>
References: <20211209190436.401946-1-tudor.ambarus@microchip.com>
 <20211209190436.401946-2-tudor.ambarus@microchip.com>
 <20211217113810.mzqrwf6vxfniggn3@ti.com>
 <c94a306d-a71f-6465-bb3d-d9e6ae55148b@microchip.com>
 <20211220101639.ycdz4twnhhp5bvlj@ti.com>
In-Reply-To: <20211220101639.ycdz4twnhhp5bvlj@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d119e2de-9af9-4240-e4f1-08d9c3a8acfe
x-ms-traffictypediagnostic: SA2PR11MB4907:EE_
x-microsoft-antispam-prvs: <SA2PR11MB49074C1BD544EECBEDD3F85FF07B9@SA2PR11MB4907.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2YI/4wCyHcwktqJNqipiN4jfiseCYbDU0GjxPpdvz7Qh1edstHXbccBFCzigc+eluYBhnenYWjQxd2ZV9L76l4RnGxgN7QF+fdb57EhT6Cio+BoDiqL0zUwM/R1vAA1leOHE4u/t/jIh2paO5GGSE3CQUDdhuVKxsMwMwIXVuMAFQZ9G3n4t49XjxcHJoP33RiPyGFp+Suln9QEPUpJ5G9A89W0L0bDowIq1b3wr9NW8g/1e+/GaiupHxAadQT9tJJlrqTr6HCGOHWeAToaZ4ZsKqxH0i/WK/N+XoPKdENDuk1Lu0JtBY4JfyQKXZfA0bZA6/VzvkfMonLnJjTbLs+xS341Eb/a0qgnTy3NkO/tX06dnekgbKb3ncSth9Z8cSlM7I133VrAQ2W3LLEX2FjUc3lYADpLpsthc/F5dDuULB4lq/CQ0elfzYcmaaF7xHTJbnOxMCTfSUqdVOqqaFKfz7z57ultk3klt09PA5mhW/CTIK6m15CCjfPIlKty4vS8fN8Yc9SXLNkO4WtpxjgRST2R+cIGPg4ApV9H8yFOdun45g1SqABVGeZqW1pBL9oVCeKBySzgrD6TENNA+tWJXf3Bj/TVU6TRvvMdffYmb1eM7zDdTvdSR0DNVSqlOvb83OGLnOWLRxx4FNQr/OtIm+tO7QNMF41Ih7XVz2rOoAZimA60sT4QVL27enSWRK8Jq+cHpmpaWQfvtpq+XjlyjzP12SGHkFzZdlx5FnU8K3Jym5u71e0O40dlLZoL9bdF7upI1kVQFxxCu7ZpPkMOLJJuGm1D+pL+6MZvawLMDfp5q7aBZxWgKjTpBb58k8U+Qvy8uVhvePzS/4e7Jrehle/M9BITrcRXBKdB6sO3KA1/vQsvvsiCiMqu4OBMJylpATwMhoXfm/tLAmwtieqN95fkRDkgnmAswaLP3zhI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(6506007)(186003)(6512007)(508600001)(966005)(4326008)(31696002)(316002)(26005)(53546011)(2906002)(54906003)(6486002)(8676002)(8936002)(71200400001)(2616005)(6916009)(5660300002)(122000001)(86362001)(36756003)(38100700002)(66476007)(66446008)(66556008)(64756008)(66946007)(38070700005)(83380400001)(76116006)(91956017)(138113003)(98903001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OC85WGpNYkVwSlpIeDZmM2h1S29SK1E3aG8yV0xGYU9uNExUN3llWDI1aHo3?=
 =?utf-8?B?cE5RNEsxOHRQbk81YlN0SGE2ZWFlOTFsUXhsOUJyOGRPL0oyODVoeWFKbStE?=
 =?utf-8?B?Y2U1VFRmQVJESzRsWnc3Z1ZZcTY2TTBMMElYN3lycjcxTlZjMW9NSkk0dmxK?=
 =?utf-8?B?YUdqUThZL2YvVUxMcjl2WDE0aWRqVVIxdFVZVUNFV0M1MmdIamIzVTBHRDd6?=
 =?utf-8?B?L1FpanhjUmEyc0QwNTRIaGpRRTNvRGQydHhOYWxncGpzZ28wZmxmVlpGMXAr?=
 =?utf-8?B?MXBvSjZhSHFqZi9oaUNRenJkT0NjRWRSR1NDK1hDMDl5Snl0MG1kc3k0U0s2?=
 =?utf-8?B?Y3dkSXhEZk1RRDNtYzBEMHNxT0g3OWFjY3pLbWFFK0d3ZjNFeEZiYzBrOUU2?=
 =?utf-8?B?RnIrSWlDaWVXcVdiWE1ZZzNFUDQ1Z3FDTWlrNHlQUDJEK0V6UmNVZFZKU0JV?=
 =?utf-8?B?ZERRMkQ4OVRPUTNFaktvVm9DQ1N3Zm1kaGM1UXcya1cyZ3lLelRSZG1MZFg0?=
 =?utf-8?B?MXZ5dW4xMHo0d3lDME1MODNsT04wdkx3eTg0S2VCdVQxTnBFR1RKY1FhRmZH?=
 =?utf-8?B?bW9RVEVIeE56VGhpd3FJS0N3TThQcE5BMEFqV3V5TTlLaWNFWXlZV2puaHFh?=
 =?utf-8?B?QkZ4VUFlTTYxQXhBR3RpZEFxZEhBN1A0NTc3OVF3TStWSkhtdG8xMlZJOHUv?=
 =?utf-8?B?azJwbUpUc0p1dTlBTExIMUtndXlOYjN6TU1UUEVPa3RYMGk0Q3NDR2tPaHll?=
 =?utf-8?B?dHV0NG52ZDRjeGE4WHIyUXk1c3pqSUdoZUFEZU9KYWpqdHV2WWwwUHlmbTJH?=
 =?utf-8?B?aU15K3pGNm5YSUlOWWdBMlQ3NFF3cGFKU0VtclZObm55bkNDOW1yaHlNZUxo?=
 =?utf-8?B?RmMyRnR4aGZ2dVFwMjRMTTUrb1ZFcXJ2Y0YvT0xBVzdqcVQ4dlhNbklySU5y?=
 =?utf-8?B?RU11NXNNRW93N3R2RUZLcG5Rd3BOZWI1ZzlveHcxZmF5Y0gycU96YU44bVlv?=
 =?utf-8?B?cTB6THJRVW9vNFdUY1FFblkybm00TEtselF5KzBVNmFmSEhlYWJ3WWZhK0s5?=
 =?utf-8?B?OXFKSzMzUVdodDhDTFRCOVVNSVRIREFYYmVSVU1PQ1pVaDA1eUJyL0FDaUh6?=
 =?utf-8?B?NGlaVDVWcHpwM0s5TzNhclY0cDRiT3VCRXdHaE9UUmpBZlo4ZExwaXJic3dp?=
 =?utf-8?B?R2pMYTN5M2lWdW9rcWxOeDBJcmk4N1JtY1V6QTFGTnQzVnRjYmlncW9xNUZw?=
 =?utf-8?B?cFY2bWtOSnZKQWl6dGlLbDYxQm5VMHh4ZEdZN2J1OVNYVGdtbW1GYXBRUE84?=
 =?utf-8?B?MTk1eUw5RW1EWDAwNXh3ZGV6cklaNzJ2bUtvbmNKeElRb0s1ekNGUEhrVCto?=
 =?utf-8?B?c3hzaHF6R29seit6RFdaNUdnaXJTdFpVUzVKRHpWeWFqc3hGclpxWEVkek5i?=
 =?utf-8?B?QjA4QnU2Y0NMbW1tc2hvWGxwTEtpV0JSdFdGNGFwTE1RL3JtQ0JSREZHa1Jk?=
 =?utf-8?B?QnNDMFA3REtDQkZpN2xNT1Jmd2g4VzJsenVSRm8wc1B1N2s5NUJ4UDV3TTQw?=
 =?utf-8?B?bkdWTkZINjVkbkZYMnJ2SUdvbm14WU1ucXhZYlNXTmRNb1IyUHFpTjYvVmpp?=
 =?utf-8?B?NjFORFY4ZGJiWVFzb1A2dEhsMUFMb3F5MXV6MkxjS1A3MEx2M3AzY2trMk1q?=
 =?utf-8?B?Zzl6QzMwcG5ZYnNQcWJnR3ZzNm1FSnRJMmR2YWhEMTJrUWJYcUtQM3hYM0dL?=
 =?utf-8?B?OHlXQWRDUUFHR3M5dVBhOG1GM25adHhRaXBBMkE2dkczSkdWSFlBMHNkay9N?=
 =?utf-8?B?YnBHVkpzdldvNHpJZFNJSGZyaDdmUzJXMk5aTHFLZXZvRTE4WEFQK2Z2WWln?=
 =?utf-8?B?dkJTNGZIRFI5TkNnUEwzc09qeExkVlQxd3A3QXVMWjFHNEduRzZiMEwrbnE5?=
 =?utf-8?B?V1ZkUHV0UnlKbFo5cjhZWXpkMWVTbzZqVmdyMTJaMHd4THhFUTZmYm9DVzNQ?=
 =?utf-8?B?aURYNjcrODJxQVhNd1ZCMks1andHaWFZdkUrNTRSTiswSnNkemxqdTI2aEZO?=
 =?utf-8?B?NkdSNE0wN1VhZktpTERVYzNORnFNdHgvemFFVG5XQlZRS1U1czVjeWdEYzF6?=
 =?utf-8?B?Sk5TVHBjWjArUWV3RDhPVFFUN0RvYkVoYlkzZGtETWNWQmVVUlA3MVVNWVpt?=
 =?utf-8?B?UEUzaUpRUVc1NXd2dDZsZXh1K2JHNXJhOUsrbEx5ek52TkkxeTJRVCtWSTRQ?=
 =?utf-8?B?SnhtYkxJNjliRG8vbUczSHJ5SDZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B822C4C10942845A59BB759A628D35D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d119e2de-9af9-4240-e4f1-08d9c3a8acfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 11:05:47.3246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1ENeqF3t/Fj9uD8tz8qlMTIEIpRABzWexUEPLZvAI1ZqFI0yRBr9moc1igJMEY4+7CwY9VuLFgwreDOBom4cPC0CtdAx9cODfpxfPI4Lic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjAvMjEgMTI6MTYgUE0sIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIFR1ZG9yLA0KPiANCj4gT24gMTcvMTIv
MjEgMTI6MzhQTSwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMTIv
MTcvMjEgMTozOCBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiAwOS8xMi8yMSAwOTowNFBNLCBUdWRvciBB
bWJhcnVzIHdyb3RlOg0KPj4+PiBteDY2bG0xZzQ1ZyBzdXBwb3J0cyBqdXN0IDEtMS0xLCA4LTgt
OCBhbmQgOGQtOGQtOGQgbW9kZXMuIFRoZXJlIGFyZQ0KPj4+PiB2ZXJzaW9ucyBvZiBteDY2bG0x
ZzQ1ZyB3aGljaCBkbyBub3Qgc3VwcG9ydCBTRkRQLCB0aHVzIHVzZQ0KPj4+PiBTUElfTk9SX1NL
SVBfU0ZEUC4gVGhlIFJESUQgY29tbWFuZCBpc3N1ZWQgdGhyb3VnaCB0aGUgb2N0YWwgcGVyaXBo
ZXJhbA0KPj4+PiBpbnRlcmZhY2Ugb3V0cHV0cyBkYXRhIGFsd2F5cyBpbiBTVFIgbW9kZSBmb3Ig
d2hhdGV2ZXIgcmVhc29uLiBTaW5jZQ0KPj4+DQo+Pj4gSHVoISBJIGhvcGUgdGhpcyBpcyBhIG1p
c3Rha2UgZnJvbSB0aGUgY2hpcCBkZXNpZ25lcnMsIGJlY2F1c2UgaWYgaXQNCj4+PiBpc24ndCB0
aGV5IG5lZWQgYSBzdGVybiB0YWxraW5nLXRvIDstKQ0KPj4+DQo+Pj4+IDhkLThkLThzIGlzIG5v
dCBjb21tb24sIGF2b2lkIHJlYWRpbmcgdGhlIElEIHdoZW4gZW5hYmxpbmcgdGhlIG9jdGFsIGR0
cg0KPj4+PiBtb2RlLiBJbnN0ZWFkLCByZWFkIGJhY2sgdGhlIENSMiB0byBjaGVjayBpZiB0aGUg
c3dpdGNoIHdhcyBzdWNjZXNzZnVsLg0KPj4+PiBUZXN0ZWQgaW4gMS0xLTEgYW5kIDhkLThkLThk
IG1vZGVzIHVzaW5nIHNhbWE3ZzUgUVNQSSBJUC4NCj4+Pg0KPj4+IERhdGFzaGVldD8NCj4+DQo+
PiBNWDY2TE0xRzQ1RyBkYXRhc2hlZXQ6DQo+PiBodHRwczovL3d3dy5tYWNyb25peC5jb20vTGlz
dHMvRGF0YXNoZWV0L0F0dGFjaG1lbnRzLzc5MjkvTVg2NkxNMUc0NUcsJTIwM1YsJTIwMUdiLCUy
MHYxLjEucGRmDQo+IA0KPiBUaGFua3MuDQo+IA0KPiBJIHNlZSB0aGF0IHRoZSBSRElEIHdhdmVm
b3JtIGhvbGRzIGVhY2ggYnl0ZSBvZiB0aGUgSUQgZm9yIGEgd2hvbGUgY2xvY2sNCj4gY3ljbGUu
IFNvIHlvdSB3b3VsZCByZWFkIGFiIGFiIGNkIGNkIGVmIGVmLiBJJ3ZlIHNlZW4gdGhpcyBiZWZv
cmUNCj4gc29tZXdoZXJlLCBhbmQgc3VyZSBlbm91Z2gsIGRpZ2dpbmcgdGhyb3VnaCBteSBpbmJv
eCBJJ3ZlIGZvdW5kIHRoaXMNCj4gcGF0Y2ggWzBdLiBJbiB0aGlzIHJlYWQgSUQgaXMgcGVyZm9y
bWVkIGJ1dCBvbmx5IGFsdGVybmF0ZSBieXRlcyBhcmUNCj4gY29tcGFyZWQgc2luY2UgdGhleSBh
cmUgcmVwZWF0ZWQuIEkgdGhpbmsgeW91IHNob3VsZCBkbyB0aGUgc2FtZS4gSSBmZWVsDQo+IGxp
a2UgcmVhZGluZy9jb21wYXJpbmcgMyBieXRlcyBpcyBtb3JlICJyb2J1c3QiLg0KDQpJIGRpZG4n
dCB3YW50IHRvIGRvIHRoZSA4RC04RC04UyByZWFkSUQgYmVjYXVzZSBJJ20gbm90IHN1cmUgaWYg
bWFjcm9uaXgNCmdlbmVyYWxpemVzIDhELThELThTIGZvciBhbGwgaXRzIG9jdGFsIGZsYXNoZXMu
IFNpbmNlIDhELThELThTIGlzIG9kZCwNCkkgZmVsdCB0aGF0IHJlYWRpbmcgQ1IyIGlzIHNhZmVy
LiBCdXQgbWF5YmUgd2UnbGwgZm9sbG93IHRoZSByZWFkIENSMg0KYXBwcm9hY2ggd2hlbiB0aGUg
bmVlZCBhcmlzZXMsIHNvIEknbGwgZm9sbG93IFpoZW5neHVuJ3MgcHJvcG9zYWwuDQo+IA0KPiBC
VFcsIHRoaXMgcGF0Y2ggc2VyaWVzIGFsc28gYWRkcyBzdXBwb3J0IGZvciBteDY2bG0xZzQ1Zy4g
WW91IG1pZ2h0IHdhbnQNCj4gdG8gdXNlIHRoaXMgYXMgcmVmZXJlbmNlLg0KPiANCj4gWzBdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIxMDgxMjE1MDEzNS40MDA1LTItemhlbmd4dW5s
aS5teGljQGdtYWlsLmNvbS8NCj4gDQoNClJpZ2h0LiBJIHdpbGwgcmV3b3JrIGl0J3MgMDEvMTUg
cGF0Y2ggYW5kIGtlZXAgWmhlbmd4dW5saSBhcyBhdXRob3IsIEkgYXNzdW1lDQpaaGVuZ3h1bmxp
IHNlbnQgdGhlIHByb3Bvc2FsIGJlZm9yZSBtZS4NCg0KdGENCg==
