Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7B1478B97
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbhLQMjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:39:01 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:56485 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhLQMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639744739; x=1671280739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T7RmckshB059a2g4k2kQ9q9knzjMl2o0sY0Yxvpn/Sc=;
  b=uAbZ1esTLXHLzWaSG2wJdJZxdSH6rV0pFaW1hWliP6E6wgd837ndqk16
   tvX3fFMTOCaE1qrVF2UW0pT8Dndqr2V9i729pgOyDMWG3pb4G/A+KEVfe
   qb8rnrbJpxtZAv0/HfNMs1Toc2249ZqeyNdWcNn3LQUZthDStGTen9HCc
   RAAKzkZLiDlPsSVpRHmhjYf1BRGMt7mEV/oyGgKSzRqBC56wMu4Bj310k
   uHOiAa84QY8cbieOJMIdCWzmy9O3NeUo9nTmbUUdUQMDx1gp9k/cXooy9
   cay4Sb+dl9ZVfuBHe3tBzeVNDq56NTzvbyVcMTbhn5bmCIsUn4Bq96DUp
   g==;
IronPort-SDR: GWOtd0AXRVhNBgj/UcfcFkSchGvaOIrxd1VyNzKpQ+Kxbe9rxZnQVqKxK2p76dyjb3wzOs9p0s
 9yt6smwj0/EToyxbs0sxT6TmN+UdTZtovigMv8ewzSXqGQLY2kSXcZOjo/axjoQUpd4W42IJEt
 WPNCNjbWZq63J3YQq0tkt6Wbaf/pG6ve4CInqmthO82npjiq5yDCWQaqDNYGcUg2yQLEamENGc
 AnmNv6LFvhoFMvGEBaI19M4oVnZGFBiorQ3Ap6THlfysjYIB8CDGPO4idHS/lfKvj5cfZ+KD0J
 w7GlTkbUIimHtG0AEr/sTuu/
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="147584686"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 05:38:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 05:38:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Dec 2021 05:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWyybUfJE6MWTXISDNTXGrfwrSw6elH3tjaOq3OC4s0DMHVBn7BxE7qGIBVoq5fvfgItl0WWPOXwoUWDOWMCOuvXECgrXTMA5sGNbIgqyZFdCD2EM2rOhOslDW0bEiQbKEAemt/NRzchLuge8/59s6NkaH65BHQSu3fPYCEth8euD6V7MtHH/L8Z5+Y1+3L5PznBiTw9XoGe9m02hh7bQqRoK/OWXpjSIhGIRuUinzKsQZxdg9x7xjTiVPhOg0SZhr9GrCWSCm/gp5NSIpMyc0oqjAvyk6pRZdtvqP1n4MN/cBQ3pP+eH7OrHHPfgrCRmC+W15v4v8u7MfScr69MRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7RmckshB059a2g4k2kQ9q9knzjMl2o0sY0Yxvpn/Sc=;
 b=OyN10l1obEJ2bhOVuaz7vWaolvrt3gEZFRIjf03ZYHyI8nloe+RrWm4ZD2fZDamytI+AWYht1hiakDfIMxerNhzFBuJy0Bx3syrZYuxqtVPlQUK+AiD77XHa/YRKOa8UxfEtc4E2UDrxI5ZhZTBnFgGvpbwcuHkeIc99wv/Dfo2vXRrajsbIWgEL0hguXWaRgxtlbZKEO4Wpe4+7lwFk/xTv7633SFroIEJYavuXEyuB2oaMSN8CKkSdS9lIWfPmYQwsvQ7u/iENhN8CAmko48xJ4iZCm1l2iq/6wpwegYuyMY8Zr7ynA0WfVZszqSz/QV7uPdYlbS9MjlO8SYdUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7RmckshB059a2g4k2kQ9q9knzjMl2o0sY0Yxvpn/Sc=;
 b=vWrliljXqhTa6EnPGn9PT6MfRFrVXDRAhzWfwh4iJn+HnkJVGSEl3JVqXHxqsaG8efzOszITwU6036Ai5c86Bwrxi0cT5jCZ8xzhb6PbNch+zjIuIO+9y27ktAbTKn6cpQSAc24iqojoMtvx8QgZ/CbnNI46ft1BCABgRuCtz60=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3391.namprd11.prod.outlook.com (2603:10b6:805:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 12:38:52 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 12:38:52 +0000
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
Date:   Fri, 17 Dec 2021 12:38:52 +0000
Message-ID: <c94a306d-a71f-6465-bb3d-d9e6ae55148b@microchip.com>
References: <20211209190436.401946-1-tudor.ambarus@microchip.com>
 <20211209190436.401946-2-tudor.ambarus@microchip.com>
 <20211217113810.mzqrwf6vxfniggn3@ti.com>
In-Reply-To: <20211217113810.mzqrwf6vxfniggn3@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d226b1d-0b5b-4d2a-d9f4-08d9c15a2efe
x-ms-traffictypediagnostic: SN6PR11MB3391:EE_
x-microsoft-antispam-prvs: <SN6PR11MB339196EF64EAA36F76421AD8F0789@SN6PR11MB3391.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /qTAjEj7lMAqvdkWDuClvmVG3NDK6shcGN+s4e+4vSUIK+VWthgLVeBu4d2wESRn9l+aXiTaXmLZ19I2yuFvEt2PRbCjl5cH4lXh4Y1VJcRpIz5XyeINqgjpzk3PqRUvAo/NiYnKsxrX3lUCSjxbvet4Uw34sKuPakP304fbv1gyFmBSdrhA49Wqorv75yT85+AaDRp/zACU2dqgd4r3ds/ptVT8L6r5AdD9KMiq0CQ7+iKD2nM4npYcKY/EFol5ApUmi6KuGxC/ilhVtZG5EnqEjEo+nFzd/brWUElgvYys1+BkHXmhhSxcts7zN1zJ6RU8R3EJnoomnSR9ChDOnpokmKvV4OM6I3wdnukXD84tnnwhgwhTBNpJe6YZ0EDfE4/Q/YujdSni0osmfGqpOq1pVeUXMbKOtrV3W5yznFfjaTIpsF91vgRvs4LwSjWZIrg9T6b8acPSf8DN43WeC7UM7lvm95AYgCePrMmpmACoa3Ho8a9Hj1xWoPlro6c5mYHDGQCUaB3Dh+4Sq+IcC5Ec9EhRTrdMCESmI7CloOQ3MKMadzktTz8v5RIBrSpOOljAdTztIfrhBsB+IfDbj2fM+Fd6yN+fbxmbd/HpBjoVn0znaQMwn13peWY2pMCGPIXNHMx7F4tH3Sd+7RtdMdBnCFjPWC/BSXfkQR06TNLfUXWnaBj0kGZPr6Ws6ta+rtNJbIKG5C7u3GI6CYzRTYdBzeh6jt+NwmDN43SzVEJ65L4A2bJ2iJwQ5zpDE/ssqkGf7nFECmGO0dDvzWcY7hzAJllglf4/tHpT6elNqUDuzse0X9iojoPpkux+E0tgE04f3YmTBtCpS5S+iwjVVmC/z+0ypD3GIXROGwpX4It8r2m5uEX/gD6dvBD3jvO4if4a4/Gx7MbgC6f5MgYzKF8SNgokAWHRtFkXI9CN+qA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(2906002)(31696002)(86362001)(6512007)(5660300002)(6486002)(31686004)(83380400001)(54906003)(8676002)(186003)(316002)(4326008)(64756008)(66446008)(66556008)(8936002)(66476007)(6506007)(38070700005)(53546011)(966005)(66946007)(2616005)(76116006)(6916009)(36756003)(122000001)(38100700002)(508600001)(71200400001)(91956017)(138113003)(98903001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFpwazFaU3BNTkJzS3Y3bko4OEsyNU5GVEtCNEZ1eWtvR0NaVEgraUZEREly?=
 =?utf-8?B?S3M1cjVYQno1Mk1ES2RFSzh0UWwzcGU2RWFsd0lhUjdid1oyV2gvdm9Jd3RT?=
 =?utf-8?B?bWFkellyNllUQzRVSS9WRzFZdGxaaDVlY0VoQXI3YjBXbjlKNUZwblM5RlhG?=
 =?utf-8?B?Um9ORDROVTNKSThlV2FPVFM5bjJsU2s4NXA1Rm1ub2RCeTBsZ0h2Q05nOURj?=
 =?utf-8?B?aW54TnVTTjdHa3g4M0tWYTU0bjhOOG84K0dWWC8vQ3p1S2VlcUNSSzNvUjhN?=
 =?utf-8?B?cDNrVlNwZ0lDaTlOWWNiZ203eFpPaXBRRnZreTBzZ0FwczNZUmhLb2NmKzFi?=
 =?utf-8?B?MU5XZ0JxdjgrYnBlVzh2ZVVWcmp4UjVDQ0NOVytqRFBHTkNmcW5sZ2IyeTY1?=
 =?utf-8?B?d29XOHFuelB5bXZzWUZWcmljVWMra3dVcFR6c3JIS2FNVFBhR3BrQ1hpR2Ra?=
 =?utf-8?B?c1F6WUZXbU84V3VKa3NzSHF5ckVncUd5azZPellVYmRjZ1lRbzF1cEM5aWpG?=
 =?utf-8?B?RitUTndLaFRMTk5ZWEV4RzFUaVdwVnErbWV1SDREVXk2WllnOVJoL0kybXBj?=
 =?utf-8?B?ZjJEaS92d2ZiaFgvWFZpQ1RjdGpCZTVGSFNzdzBNY21nUmplVHljT2RMOWZw?=
 =?utf-8?B?MjVPMlRMQmgzY2U0cG5aWkhFUmIwRUVrYTZucU1aMVMyRDJmVmJLZmpmeHUz?=
 =?utf-8?B?RUVPbXllak56aUtXR2V2SE8yRDdINFA5Wm5nSCtTU0VjdjBYeVNjZFVxUnhr?=
 =?utf-8?B?TWxMVFRzU0MrMkdLZmExSGdIUVZpUXJkQ3F4akVRUW45U2NjY0JMamxmbSs4?=
 =?utf-8?B?cGd5eU1HMlRVMmJ4dm50K1pjV3VVTTQ0UncwK2hRamg2c0FqVmNsbG55M043?=
 =?utf-8?B?bG9Vak0yblE2ZytPaGhrVGNEQzRxOWpHc1gya3BsbXhmeVcrU29nMEtpQ1FC?=
 =?utf-8?B?N0JYYVFSRG9CbDdRczFnQkp5TnpZR0NUQUcxRklYMWJoNHQxS0V3QjczNGhL?=
 =?utf-8?B?cFJyM0EwQUZwRk5ndTMvN28rTFZtbUZ6ZDJ0VU4xODgzVXJUdmhnZWNtekdt?=
 =?utf-8?B?V05LOHRvd2pjcXFaUFlEKzJGbmxoV1MxNWYyVWo3NC9XdFN5dncwVzVZcXVs?=
 =?utf-8?B?WTh2ckRjWG9ZL0NTemRIMU92VlRLbnd6d0VueEQ3emlsaks4c05WdXJQVFk4?=
 =?utf-8?B?VFROUHN6MUM1SjcxWUJJUlZwcDVqV3VmZGt5SklIVlJsb0RlYnJTQmVzU1hx?=
 =?utf-8?B?cVIxYmQwb1RLLzZpOFRxcmpzOUg4bTZTeGs4cnZQWGdWQWZQdm1WSzVIY2FE?=
 =?utf-8?B?cXFBdVRVSlFoeGZ0NHoxQVBoN0hvdGVrMVdIS1ZIMi9jdCtVUFp6VHFHYTJz?=
 =?utf-8?B?OUthWXhPaDNMMkp1ZUVIRkIwNXpsSWFJMHNTSmNlclBoWEp4WkwvSk9KS3Jt?=
 =?utf-8?B?cEl5VEtkWitRa2VrRHVGTWVlNmd0bHVVaEJnek5STWRBOFpFWXJhaGRnK0ZF?=
 =?utf-8?B?V05HWUlYY1lZN2puZmlpTlNRVnlpd2hDcVdvYTRYNklSTmFFcFAzTnl2SjNM?=
 =?utf-8?B?VGhwQ3Y3cDdoQXc5OHQzc3dKQnNZVGJGd2R3bE5rTmhBWHFodmpEb0JGSmJB?=
 =?utf-8?B?OGxQVjJlcXFudjRVNzRrSFhPd0FENzh3VWY3MWhlMTVxTmdXajVIZEhVWS9X?=
 =?utf-8?B?UUdqRFlaUGpIUC9ZNTcrcU5ZRTh4NFA2TDk1cXF0bGw0d1J4TUpnM2N5NGJ5?=
 =?utf-8?B?Zm1rUE5Td3pFTUlmazljalIxV011Q3NoeThPYnlLNU91bGJsUUo1RmZXNHZi?=
 =?utf-8?B?VjhNWFV0WWxnbDZna0JubUQzQ01zYTVvS1FxVGZNWGd4TWkxVDF6VmxSREt6?=
 =?utf-8?B?ckNkMGZ3VlVHV3lJTSt6V0lwbURFRXgyZlh3R1p2ZndiT1hoeWZpaHN4MHlT?=
 =?utf-8?B?TDMzQ3NBMThxYVZhN1pxaEgwR2xCZHp3eW1YVWlpbi9yYzdJOWR2aHNQcUNi?=
 =?utf-8?B?aC9id2pLcVBOdGd5Mm4vUXZ5d1k3V1BvMjdPUE94YnhjRHZ1dkZTWGVlQTFG?=
 =?utf-8?B?cHhUSk82QmVmaVB5dWtZMTVZc2VUMXFadmFrZ1FFbHE0MkJRbXpPQ2JKdUlx?=
 =?utf-8?B?cnFNL29VQXJHZE5aL2h1a0VtRW4ydjA0NkIvSzBLNkViTG4rQ09OMFJoMG9Z?=
 =?utf-8?B?SnBybm5GbUtzaHdpS3pVbXRZUU5ESFFkb2kyRWRTYXRmTWxudW85czJMaW5N?=
 =?utf-8?B?ZHc1TW16ckhuS3dUOG5vWjhaUWl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2754CEF33E724742889450FC0B293F8E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d226b1d-0b5b-4d2a-d9f4-08d9c15a2efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 12:38:52.8172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDZGG4DXUnwjZlJh20fCzhz2IifJxpLG+juzQII5Wggb9dCBUANUYoCKbqoiD4yQGnJ9b0DQmC4GoDxhkYizW3hz41t0RimBfBlb8Jn5W8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3391
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTcvMjEgMTozOCBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMDkvMTIvMjEgMDk6MDRQTSwgVHVkb3Ig
QW1iYXJ1cyB3cm90ZToNCj4+IG14NjZsbTFnNDVnIHN1cHBvcnRzIGp1c3QgMS0xLTEsIDgtOC04
IGFuZCA4ZC04ZC04ZCBtb2Rlcy4gVGhlcmUgYXJlDQo+PiB2ZXJzaW9ucyBvZiBteDY2bG0xZzQ1
ZyB3aGljaCBkbyBub3Qgc3VwcG9ydCBTRkRQLCB0aHVzIHVzZQ0KPj4gU1BJX05PUl9TS0lQX1NG
RFAuIFRoZSBSRElEIGNvbW1hbmQgaXNzdWVkIHRocm91Z2ggdGhlIG9jdGFsIHBlcmlwaGVyYWwN
Cj4+IGludGVyZmFjZSBvdXRwdXRzIGRhdGEgYWx3YXlzIGluIFNUUiBtb2RlIGZvciB3aGF0ZXZl
ciByZWFzb24uIFNpbmNlDQo+IA0KPiBIdWghIEkgaG9wZSB0aGlzIGlzIGEgbWlzdGFrZSBmcm9t
IHRoZSBjaGlwIGRlc2lnbmVycywgYmVjYXVzZSBpZiBpdA0KPiBpc24ndCB0aGV5IG5lZWQgYSBz
dGVybiB0YWxraW5nLXRvIDstKQ0KPiANCj4+IDhkLThkLThzIGlzIG5vdCBjb21tb24sIGF2b2lk
IHJlYWRpbmcgdGhlIElEIHdoZW4gZW5hYmxpbmcgdGhlIG9jdGFsIGR0cg0KPj4gbW9kZS4gSW5z
dGVhZCwgcmVhZCBiYWNrIHRoZSBDUjIgdG8gY2hlY2sgaWYgdGhlIHN3aXRjaCB3YXMgc3VjY2Vz
c2Z1bC4NCj4+IFRlc3RlZCBpbiAxLTEtMSBhbmQgOGQtOGQtOGQgbW9kZXMgdXNpbmcgc2FtYTdn
NSBRU1BJIElQLg0KPiANCj4gRGF0YXNoZWV0Pw0KDQpNWDY2TE0xRzQ1RyBkYXRhc2hlZXQ6DQpo
dHRwczovL3d3dy5tYWNyb25peC5jb20vTGlzdHMvRGF0YXNoZWV0L0F0dGFjaG1lbnRzLzc5Mjkv
TVg2NkxNMUc0NUcsJTIwM1YsJTIwMUdiLCUyMHYxLjEucGRmDQoNCklmIHlvdSBtZWFudCB0aGUg
Y29udHJvbGxlcidzIGRhdGFzaGVldCwgaXQncyBub3QgcHVibGljbHkgYXZhaWxhYmxlIHlldC4N
Cj4gDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0Bt
aWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiB2MjogU1BJX05PUl9TT0ZUX1JFU0VUIGFzIGEgRklY
VVBfRkxBRw0KPj4NCj4+ICMgY2F0IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9zb2MvZTA4MGMwMDAu
c3BpL3NwaV9tYXN0ZXIvc3BpMS9zcGkxLjAvc3BpLW5vci9qZWRlY19pZA0KPj4gYzI4NTNiDQo+
PiAjIGNhdCAvc3lzL2RldmljZXMvcGxhdGZvcm0vc29jL2UwODBjMDAwLnNwaS9zcGlfbWFzdGVy
L3NwaTEvc3BpMS4wL3NwaS1ub3IvbWFudWZhY3R1cmVyDQo+PiBtYWNyb25peA0KPj4gIyBjYXQg
L3N5cy9kZXZpY2VzL3BsYXRmb3JtL3NvYy9lMDgwYzAwMC5zcGkvc3BpX21hc3Rlci9zcGkxL3Nw
aTEuMC9zcGktbm9yL3BhcnRuYW1lDQo+PiBteDY2bG0xZzQ1Zw0KPj4gIyBjYXQgL3N5cy9kZXZp
Y2VzL3BsYXRmb3JtL3NvYy9lMDgwYzAwMC5zcGkvc3BpX21hc3Rlci9zcGkxL3NwaTEuMC9zcGkt
bm9yL3NmZHANCj4+IGNhdDogY2FuJ3Qgb3BlbiAnL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3NvYy9l
MDgwYzAwMC5zcGkvc3BpX21hc3Rlci9zcGkxL3NwaTEuMC9zcGktbm9yL3NmZHAnOiBObyBzdWNo
IGZpbGUgb3IgZGlyZWN0b3J5DQo+Pg0KPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvbWFjcm9uaXgu
YyB8IDExMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMTEzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQv
c3BpLW5vci9tYWNyb25peC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9tYWNyb25peC5jDQo+PiBp
bmRleCA2N2FhYTgzMDM4YjYuLjlkNzExNDkyMzNlMyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
bXRkL3NwaS1ub3IvbWFjcm9uaXguYw0KPj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9tYWNy
b25peC5jDQo+PiBAQCAtMzIsNiArMzIsMTEyIEBAIHN0YXRpYyBzdHJ1Y3Qgc3BpX25vcl9maXh1
cHMgbXgyNWwyNTYzNV9maXh1cHMgPSB7DQo+PiAgICAgICAucG9zdF9iZnB0ID0gbXgyNWwyNTYz
NV9wb3N0X2JmcHRfZml4dXBzLA0KPj4gIH07DQo+Pg0KPj4gKyNkZWZpbmUgU1BJTk9SX09QX1JF
QURfQ1IyICAgICAgICAgICAweDcxDQo+PiArI2RlZmluZSBTUElOT1JfT1BfV1JJVEVfQ1IyICAg
ICAgICAgIDB4NzINCj4+ICsjZGVmaW5lIFNQSU5PUl9PUF9NWF9EVFJfUkQgICAgICAgICAgMHhl
ZQ0KPj4gKw0KPj4gKyNkZWZpbmUgU1BJTk9SX1JFR19DUjJfTU9ERV9BRERSICAgICAwDQo+PiAr
I2RlZmluZSBTUElOT1JfUkVHX0NSMl9EVFJfT1BJX0VOQUJMRSAgICAgICAgQklUKDEpDQo+PiAr
I2RlZmluZSBTUElOT1JfUkVHX0NSMl9TUEkgICAgICAgICAgIDANCj4+ICsNCj4+ICsjZGVmaW5l
IFNQSU5PUl9SRUdfQ1IyX0RVTU1ZX0FERFIgICAgMHgzMDANCj4+ICsjZGVmaW5lIFNQSU5PUl9S
RUdfQ1IyX0RVTU1ZXzIwICAgICAgICAgICAgICAwDQo+PiArDQo+PiArc3RhdGljIGludCBzcGlf
bm9yX21hY3Jvbml4X29jdGFsX2R0cl9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9vbCBl
bmFibGUpDQo+PiArew0KPj4gKyAgICAgc3RydWN0IHNwaV9tZW1fb3Agb3A7DQo+PiArICAgICBp
bnQgcmV0Ow0KPj4gKw0KPj4gKyAgICAgLyogVXNlIDIwIGR1bW15IGN5Y2xlcyBmb3IgbWVtb3J5
IGFycmF5IHJlYWRzLiAqLw0KPiANCj4gSSBqdXN0IHdhbnQgdG8gcG9pbnQgb3V0IHRoYXQgaWYg
dGhlIGRlZmF1bHQgZHVtbXkgY3ljbGUgdmFsdWUgY2FuIHdvcmsNCj4gYXQgdGhlIG1heGltdW0g
ZnJlcXVlbmN5IHRoZSBmbGFzaCBzdXBwb3J0cywgeW91IGRvbid0IG5lZWQgdG8gZG8gdGhpcy4N
Cj4gSSBkaWQgaXQgZm9yIFMyOCBhbmQgTVQzNSBiZWNhdXNlIHRoaXMgd2Fzbid0IHRoZSBjYXNl
IGJ1dCBJIHJlbWVtYmVyDQo+IHNvbWUgZmxhc2hlcyBoYXZpbmcgc2FuZSBkZWZhdWx0cyBhbmQg
bm90IG5lZWRpbmcgdGhpcy4NCg0KVGhpcyBpcyBhIHZvbGF0aWxlIGJpdCBmaWVsZCB3aXRoIHRo
ZSBkZWZhdWx0IHZhbHVlIG9mIDIwIGR1bW15IGN5Y2xlcw0KaW5kZWVkLCBzbyBpdCBzaG91bGQg
YmUgZmluZSBpZiB0aGUgYm9vdGxvYWRlcnMgZG8gbm90IHRvdWNoIGl0LiBBbnl3YXksDQppdCdz
IHByb2JhYmx5IGEgZ29vZCBpZGVhIHRvIHJlc2V0IHRoZSBmbGFzaCBhdCBrZXJuZWwgbGV2ZWwg
YmVmb3JlDQpzdGFydGluZyBjb25maWd1cmluZyBpdCwgc28gd2UgY2FuIGNvbnNpZGVyIHRoZSBk
ZWZhdWx0IHZhbHVlcyBhcyBzYW5lLg0KSSdsbCBkcm9wIHRoaXMgY29uZmlnLCBzdXJlLg0KDQo+
IA0KPj4gKyAgICAgaWYgKGVuYWJsZSkgew0KPj4gKyAgICAgICAgICAgICBub3ItPmJvdW5jZWJ1
ZlswXSA9IFNQSU5PUl9SRUdfQ1IyX0RVTU1ZXzIwOw0KPj4gKyAgICAgICAgICAgICBvcCA9IChz
dHJ1Y3Qgc3BpX21lbV9vcCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QKFNQ
SV9NRU1fT1BfQ01EKFNQSU5PUl9PUF9XUklURV9DUjIsIDEpLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9BRERSKDQsIFNQSU5PUl9SRUdfQ1IyX0RVTU1Z
X0FERFIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMSksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05P
X0RVTU1ZLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9E
QVRBX09VVCgxLCBub3ItPmJvdW5jZWJ1ZiwgMSkpOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICBy
ZXQgPSBzcGlfbm9yX3dyaXRlX2VuYWJsZShub3IpOw0KPj4gKyAgICAgICAgICAgICBpZiAocmV0
KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArDQo+PiArICAgICAg
ICAgICAgIHJldCA9IHNwaV9tZW1fZXhlY19vcChub3ItPnNwaW1lbSwgJm9wKTsNCj4+ICsgICAg
ICAgICAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0K
Pj4gKw0KPj4gKyAgICAgICAgICAgICByZXQgPSBzcGlfbm9yX3dhaXRfdGlsbF9yZWFkeShub3Ip
Ow0KPj4gKyAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQo+PiArICAgICB9DQo+PiArDQo+PiArICAgICAvKiBTZXQvdW5zZXQgdGhlIG9j
dGFsIGFuZCBEVFIgZW5hYmxlIGJpdHMuICovDQo+PiArICAgICBpZiAoZW5hYmxlKQ0KPj4gKyAg
ICAgICAgICAgICBub3ItPmJvdW5jZWJ1ZlswXSA9IFNQSU5PUl9SRUdfQ1IyX0RUUl9PUElfRU5B
QkxFOw0KPj4gKyAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICBub3ItPmJvdW5jZWJ1ZlswXSA9
IFNQSU5PUl9SRUdfQ1IyX1NQSTsNCj4+ICsNCj4+ICsgICAgIG9wID0gKHN0cnVjdCBzcGlfbWVt
X29wKQ0KPj4gKyAgICAgICAgICAgICBTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKFNQSU5PUl9P
UF9XUklURV9DUjIsIDEpLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1Bf
QUREUig0LCBTUElOT1JfUkVHX0NSMl9NT0RFX0FERFIsIDEpLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgIFNQSV9NRU1fT1BfTk9fRFVNTVksDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgU1BJX01FTV9PUF9EQVRBX09VVCgxLCBub3ItPmJvdW5jZWJ1ZiwgMSkpOw0KPiANCj4gVGhp
cyBpcyBub3QgcXVpdGUgcmlnaHQuIFlvdSBjYW4ndCBoYXZlIGEgMS1ieXRlIGRhdGEgcGhhc2Ug
aW4gOEQgbW9kZQ0KPiBzaW5jZSB0aGVuIHlvdXIgZGF0YSBwaGFzZSBpcyBvbmx5IGhhbGYgYSBj
eWNsZS4gV2hhdCBoYXBwZW5zIHRvIHRoZQ0KPiBvdGhlciBoYWxmIGN5Y2xlIHdvdWxkIGJlIHVu
ZGVmaW5lZCBiZWhhdmlvciBmb3IgbW9zdCBjb250cm9sbGVycy4gSQ0KPiBzZW50IHNvbWUgcGF0
Y2hlcyBhZGRyZXNzaW5nIHRoaXMgc29tZSB0aW1lIGJhY2sgWzBdLiBVbmZvcnR1bmF0ZWx5IHRo
ZXkNCj4gZmVsbCBvZmYgbXkgcmFkYXIuDQoNCnJpZ2h0LCB3aWxsIHVwZGF0ZS4gUGxlYXNlIHJl
c2VuZCB0aGUgc2VyaWVzIHdoZW4geW91IGZpbmQgdGltZS4NCg0KPiANCj4+ICsgICAgIGlmICgh
ZW5hYmxlKQ0KPj4gKyAgICAgICAgICAgICBzcGlfbm9yX3NwaW1lbV9zZXR1cF9vcChub3IsICZv
cCwgU05PUl9QUk9UT184XzhfOF9EVFIpOw0KPj4gKw0KPj4gKyAgICAgcmV0ID0gc3BpX25vcl93
cml0ZV9lbmFibGUobm9yKTsNCj4+ICsgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQo+PiArDQo+PiArICAgICByZXQgPSBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGlt
ZW0sICZvcCk7DQo+PiArICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPj4gKw0KPj4gKyAgICAgLyogUmVhZCBiYWNrIENSMiB0byBtYWtlIHN1cmUgdGhlIHN3aXRj
aCB3YXMgc3VjY2Vzc2Z1bC4gKi8NCj4+ICsgICAgIG9wID0gKHN0cnVjdCBzcGlfbWVtX29wKQ0K
Pj4gKyAgICAgICAgICAgICBTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKFNQSU5PUl9PUF9SRUFE
X0NSMiwgMSksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9BRERSKDQs
IFNQSU5PUl9SRUdfQ1IyX01PREVfQUREUiwgMSksDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgU1BJX01FTV9PUF9EVU1NWShlbmFibGUgPyA0IDogMCwgMSksDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgU1BJX01FTV9PUF9EQVRBX0lOKDEsIG5vci0+Ym91bmNlYnVmLCAxKSk7DQo+
IA0KPiBTYW1lIGFzIGFib3ZlLg0KDQpvaw0KDQo+IA0KPj4gKyAgICAgaWYgKGVuYWJsZSkNCj4+
ICsgICAgICAgICAgICAgc3BpX25vcl9zcGltZW1fc2V0dXBfb3Aobm9yLCAmb3AsIFNOT1JfUFJP
VE9fOF84XzhfRFRSKTsNCj4+ICsNCj4+ICsgICAgIHJldCA9IHNwaV9tZW1fZXhlY19vcChub3It
PnNwaW1lbSwgJm9wKTsNCj4+ICsgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+PiArDQo+PiArICAgICBpZiAoZW5hYmxlKSB7DQo+PiArICAgICAgICAgICAgIGlm
IChub3ItPmJvdW5jZWJ1ZlswXSAhPSBTUElOT1JfUkVHX0NSMl9EVFJfT1BJX0VOQUJMRSkgew0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgIGRldl9kYmcobm9yLT5kZXYsICJGYWlsZWQgdG8gZW5h
YmxlIDhkLThkLThkIG1vZGUuXG4iKTsNCj4gDQo+IE5pdHBpY2s6IHMvOGQtOGQtOGQvOEQtOEQt
OEQvDQoNCnN1cmUNCg0KPiANCj4+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKyAgICAgfSBlbHNlIGlmIChub3ItPmJvdW5jZWJ1
ZlswXSAhPSBTUElOT1JfUkVHX0NSMl9TUEkpIHsNCj4+ICsgICAgICAgICAgICAgZGV2X2RiZyhu
b3ItPmRldiwgIkZhaWxlZCB0byBkaXNhYmxlIDhkLThkLThkIG1vZGUuXG4iKTsNCj4gDQo+IE5p
dHBpY2s6IHMvOGQtOGQtOGQvOEQtOEQtOEQvDQoNCm9rLiBUaGFua3MhDQp0YQ0K
