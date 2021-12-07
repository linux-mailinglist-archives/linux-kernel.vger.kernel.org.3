Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29A446B498
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhLGHzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:55:45 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:60497 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhLGHzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638863531; x=1670399531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=COlaPMyfWpBEHM+KDjn/H9Y3MRdIcJwoLjlDykGRJIY=;
  b=IeuKsvi+c8AV7pxHAgzWqbdn2zGf3OQkMAalrh8M4ESK7ZrQtjGYcBoG
   /3kualjAqgA1Dqnjr0j6GcyGqcTMIP9+omVf+4yC/JMgBBv6S733yeI1T
   ihxWaJoE9tXLb+AJGkmnGX0SLFNti13moe8vK9Sk2B0SvSZymMAebqEM6
   SP8QUfbfBw50j2QoZCRJRzOhQCBt9oxUXGKmoPbQPvzu0qhBmlQt9I9ct
   iSSo8Zv+8D3XjSyt3Mgc0ROty7jc8h9SLzQ+PRPJV9jTMC90p2LkusnMF
   /D1NMbsDQzl+KQcHKAQiUtFjA4ZTcwIhuOzD6DfVzZIkW41ZHJJZh3OIw
   Q==;
IronPort-SDR: PAX3J5hvCfWITHfh5xdnJfY+k8f7AzJzRSZmrV4O4wdC0HZV1sEkgj0wjhNcyUSBk1KxTiJTOs
 PZSskv8PPWGDTFrfof/u3qE30ssCja8IFJIPBeli4FpTD73/6VJ/HLiy4DCtVvkcWyv543GM1E
 QhVgtsd6viJxMfs7KxOfGbyOmA2w+Rh5HUiTalBWSbsgxv/e8j/6xjfGe2qXe+ejA4p+gxdtQO
 VD39DUqnu5+5HNSwISlO3PvIYqirgmmpLIPhoC1WVdn5JVB6zEAEUOclgJ8EibSbCslgs+qNb+
 5yoSjYhr/HjN+eQRglckcOHr
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="78729752"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2021 00:52:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 00:52:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 7 Dec 2021 00:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6EQ7Y4f29r6ToOTmfg/cC+x7MWGSULtiu2TUE9+1sNS0M8sm+2DTtRQwniiWoF3p0j/A/EK3sslvxCUoJH/77WAQl0jH5ddF0BsfVs+cPPyZxgGcMEPNCSRoun7DZnLZIY1kZrIluFczO3BQqPTy+pjnkPhaecVXeTcD/HC1rRGKyJPZdFaFWfPDWE/fC22vs2B0TaY3LzyRC8fy/sVRE74CEDmH/A8NYo2mPx8U3WY4OmMiQEZUkazh/tiy3djCJdM0bvXDyYGH79S571qnTYmBFcBWIHhtUeuNdaepg2BLI/RjxBBQQClHjN4oyUU75WIepLcWt0wFo/rbS5ILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COlaPMyfWpBEHM+KDjn/H9Y3MRdIcJwoLjlDykGRJIY=;
 b=LdF6xW13uRDdBGh5g8piT8V83CrVWLpNiwYZz6PIL41BsomEModE4bMVMjT18MP4gRwlJO77pimqQXxix/s3ztDcFS9uavpnWp7dOg3JlYip9WdyGju0Vla+rJUJhR4FHF/zoXAuLzvdYk/7r9IAR7xFsUP+UIGmNGs7iA/AMmqaKMIXJwITZcaxLMrPObB0/xzkqQIaZriE/feF3rNI3Voyv7y3tFbxmC270OZdY9nRm6REQrv39npV75e6X+er1XLMaD4RALpJZPlSu8PMY/6wPicqNuptRCHYbOCvEEi6EJFRLR10O3I0sNhEfNYODSSHI6DSocF9FT2nY2HzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COlaPMyfWpBEHM+KDjn/H9Y3MRdIcJwoLjlDykGRJIY=;
 b=R7x+uVtiiEdMblHe/ZLdRhVh90V0Tkmrywww5+JPdddqYKtEbf+A3HXt7MuCTuphq6gHeUTZVggS41ZmpAPZ/5bFn9EmcteXNqAE0ChGkRN7plGr4g69glYzNDsIMIgVdyUOUeJ2ydN9aXEdR3hwSFW1U7o2KOZSB0vtXMuJEM8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 07:52:06 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 07:52:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <dan.carpenter@oracle.com>, <kbuild@lists.01.org>
CC:     <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [ambarus:spi-nor/next-clean-v5 20/25]
 drivers/mtd/spi-nor/core.c:2720 spi_nor_init_params_deprecated() warn: should
 this be a bitwise op?
Thread-Topic: [ambarus:spi-nor/next-clean-v5 20/25]
 drivers/mtd/spi-nor/core.c:2720 spi_nor_init_params_deprecated() warn: should
 this be a bitwise op?
Thread-Index: AQHX6z6wAVNm+aMkYka7HlZojGDgPawmqCmA
Date:   Tue, 7 Dec 2021 07:52:05 +0000
Message-ID: <620ec5c9-16c1-e29b-fb19-3006fc543151@microchip.com>
References: <202112062341.u7kBv9Hp-lkp@intel.com>
In-Reply-To: <202112062341.u7kBv9Hp-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6f15bf4-9c6d-45db-816e-08d9b95676cd
x-ms-traffictypediagnostic: SA2PR11MB5161:EE_
x-microsoft-antispam-prvs: <SA2PR11MB5161FAFF6DE29FDE25E8667EF06E9@SA2PR11MB5161.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:165;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sIB68eUJ/gNyd8XBllL0IDBlaLEx8W3Pa8pw4dgmyt+ePk45o+/hKWGSJxtPk3pwXu5Cf02xMBdEEg0b4t8wq12IlVjPBP57eB5lrB8lD9Bvt5FCYO/Rsuigd5PyU2D81ZOBnisSifN/PZobn1kV4aFT4RBHs21VseSRl/4xOP3iSdbBgChPxxW4IPlCR/QC6k6u3WLrul2u82RgyclrFcB0eG+v2NM6/2BKOMcnhMFOh7isO2p7oI3vDnSI5JC0qh1EC58/97ageZ9m3oVHjAlB2hem2vcnbBFOgrNJ1zf/l4n2SLLUwcujwb5hSseFGJyl5hDC+NpuKsEbmMVL8LfWKwJXhBbKD4n6eTL6OHkoHvb2EFb9usjx+bQI4xxGbQN6DX2Xh4zvb9JqdUZzz1T4l/meP24w1n6kZIIuP19nt1lKQu8tWibTyQ4zMykdK3sO7jdYoqfuG7HVw1HoJdVEaz0EmPTZQjoWcKNbunpAl+K/5RPvCrUkxECWNH80Z7D4mFhgbPxA8M5OTO14ItDNshPieTx1HU0Rt/pe1cw7IymmslJk/7zBJTAbyOFZ/U29zTtxmG8IqkvPBRyxBEBuUkD6mv6aIvEVMmhkSR2E+bWkKa4f6eI3d1v0LsFDZhdhR6df3FY1CAsroxohk9JDoOYkCp8bDd0e/sk+B0gEOCVlJWqkqpcunBmJF/Q90uAj/RR7HKicCt1sdRGqa6F/TWLXA/y6tQCyYVXlTw5ja2VicfA4EwKo9Ou+E5w9iiU8cBs6A2fTSpcDUyFXPUF4usBvlW2cjlP5mADooNN62qByYIGCeITniJMzXEX381LtO1Vaiehd6JGaaynQggjjeBH4alRTSC2hRiaJyL0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(66946007)(110136005)(966005)(91956017)(71200400001)(54906003)(5660300002)(31696002)(86362001)(6486002)(64756008)(38100700002)(66446008)(508600001)(186003)(66476007)(76116006)(316002)(83380400001)(26005)(66556008)(4326008)(4001150100001)(2616005)(36756003)(2906002)(53546011)(6512007)(6506007)(38070700005)(122000001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2N2cUk4TDVGSjVqYk4rNnpLdnFZY0VDbGMyYXpYNy9hQTBEd0J4cDZoampm?=
 =?utf-8?B?TFN5em91YVR3VldOK2pCTEtzYS9ZdWo1R2FBVWtUNnpZMHRVVTBJM2habURs?=
 =?utf-8?B?VC9JQ29YY3RTUkNEQk02d0IwWXRYcXRWMlNVOUE1bzZqZDFlSEVMbXZ0Z2Nt?=
 =?utf-8?B?MHl0LzZ5WXQ1N3NFckh0bkdTaExTemZ1Z3pVSkx6bHFqNTVOck12MGhUQlBC?=
 =?utf-8?B?V0RXeGpQT2ZWYjVtcDc4Nm84RlNFdS9tVHhOTWRpd21kLzZqVnZoTHhMQS9r?=
 =?utf-8?B?Q0IzVVVkY0E5QUlYVnVoMUoyL09HYk9aN1JOTFBiM1VOVjVGNEtBSVlIVmtZ?=
 =?utf-8?B?Uk1DbUVzdVJkMnFXbm9EVGlod1R1Rm50eEFoT3A3S0VJMWlaUmtYOHZJcHFI?=
 =?utf-8?B?TjJnMzlId01GWklPNlNleWlHOFJ6dVEvVWxGWUgxUVhaUFYyelc2MTloSmxO?=
 =?utf-8?B?OWV2UW03cS9hUXBvZmJpNzh0MlhHbUFIMXFNQThtUlpFVmZZMnNnWDEvWnB6?=
 =?utf-8?B?QTNxS0pBYUZqWERwZDd0T0xwZTZKRlNHM0pkd0tPQ0tEak1TaUpvT3lCck1i?=
 =?utf-8?B?TmFQY3hPVjFSaWViYUFiODZmMENGZlVHdHExOWdkbncxT0wxZWRsZ09ZTDFm?=
 =?utf-8?B?VS91S2t6RTh2c01STnVHWmVXTVFMa2RUalBUeFJ1dk1NeW13U1RQZWNyUThM?=
 =?utf-8?B?aVBLRXlwYkVHcGxaV0xIOE1jeFgxL2g1OXRWUzlEZE4vRjhpamYwNTYxeFNo?=
 =?utf-8?B?dG5VNkJpZ3NJU1grWnRHMFRFWnlpaFJsR1BxM0pzbUt3Zm1JL0MrV0tzRHVD?=
 =?utf-8?B?aUhRem5iNjRzK0RXRmlQelpKZ05BNmtkenc1ZnhXWFVjYm1ZVXdpSjZUUmlQ?=
 =?utf-8?B?SnNvSjM4SXRMQmJUTGt6TVBtY1h4czFlWTk0dGROOEZLZ2JSMmhwQ2tYMUk2?=
 =?utf-8?B?L09zR2JYWVJrcVQxQzhMVXlEOUJ1WGFMTXF5RjFGN2lURytUbTRxYXZCaGJW?=
 =?utf-8?B?WXJXTllaRUZJWDlHdjcvWE5WRUxkajVObTBIRWtZbzJidzhnczZLT2VVaDNy?=
 =?utf-8?B?N3ZoRC8zdnFJMlQ4YmJVWEt5NGNYb3dzRHpTVkNITUNxcWZFTDRRUmFhcFNi?=
 =?utf-8?B?OGYvZ0xlZVBEM3FsQ0R1M0JpK2ZVVVlOVHBjVXRBMTNZMWlMeGJmWkJkdDRN?=
 =?utf-8?B?YTZ2bHR6RUF2Mnd4b0NreTFhVmdMb2xDMldGZEZTUFRSMHNjUzExZnh4MEtS?=
 =?utf-8?B?K1RCU0pvZitvSWphaEp0MTVpVGJONUxRTnFsbWQ1SEtaMzhvWFpkWTd2SVk2?=
 =?utf-8?B?VkhoK3B6ZHpTaGJRZUN5TExYb3JDOHFFNWF3cGlxdDVpdXJKekNBZCtHMWdC?=
 =?utf-8?B?d3VqNFNpbDl4dDlrRld6NUY5eE1DV2l1Yk5Uc3YyZHNKRE1wWnRkL0hjZTBx?=
 =?utf-8?B?Y2tEaFF0RnB4M09OVFVsNjRGbkdGakdOZ0xGYjBYWEZQU3Rzc2ZoRWNMU0lk?=
 =?utf-8?B?Vk9KVHpnRGh0bGFGY080dHhLMnN1VmRuZXFtUkc5VWxCVEs2NjdjVzNLMmFU?=
 =?utf-8?B?OUZXMmxSU1VEMUVDWm1JTXV0UTJNMzBlUHNtbFh0VUYvckF3SWxaRmxacnFl?=
 =?utf-8?B?QmMyRFZVUjlWaVFFZXlnRU5EZmJYZXUvNk1xWm5mSHFSdHZXUkxMMnpockhW?=
 =?utf-8?B?QUk2ZHJiMy9LNWVpS1JCaXNkS0NTSVVKYXRNM043SHppOGlsMlltdHFVNEps?=
 =?utf-8?B?bG9Ba2xtbTFaUnJqcnZsMVdEekt1R0VVeFdlZkxKVUdmQUtIUTdCYkZHbXk1?=
 =?utf-8?B?dEJtbXRGMi9DTDdUdUZQVGpXK012ejgzeUc0TW43a2VBbU5ENFlkMVYvam5X?=
 =?utf-8?B?bGN4Lzk2UUdzbmltRFZSMlJoRmFEaHQ4bWh1VHlUem0rVXpVT0lvbXRNaEsz?=
 =?utf-8?B?QlZhUEZzZHF0RHJTUmVXU3lSaW90YjhtbE9vdzYrY3NlVGI4K2xGZ1VNR2t1?=
 =?utf-8?B?RVhtN1lDc1ZHeWhsR1poMU5HMDZxaGpCblRvM3JjUk00clhjSU5obkdNS0FK?=
 =?utf-8?B?dFhGNW5ocy9oL0VuWmd5NXRQTzg1TlVoVWRXMEdqS29XbEFWUjdmSk1kTkpH?=
 =?utf-8?B?Qm5KTWIxQjdzOWxZRHNYc0ZnMXpXeDZtYkFFV21ML2w0ODl5WlJteXhzblZL?=
 =?utf-8?B?bGNPYlYvNG1ic2lodE9GVXIvdEF2cks4OTNwSlRNc0hqTnE5T2dJRHpXVTRk?=
 =?utf-8?B?YUs0eXMwMmpNRzR4NmZDN2g5VUNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <754348C3F347BF47B15F3AC64E65E716@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f15bf4-9c6d-45db-816e-08d9b95676cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 07:52:05.9996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+uJ1f+KZ3LdN1G07imL2ZrUvuYEeefb3UcIk6rRlaivS15ViIKacgrqQb+cNwML7aESbcEGb9Dcc3wfZ4jy8I3TxrfGYgURqu+r/AQqZiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvNy8yMSA5OjQ2IEFNLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IHRyZWU6ICAgaHR0cHM6Ly9naXRodWIuY29tL2Ft
YmFydXMvbGludXgtMGRheSBzcGktbm9yL25leHQtY2xlYW4tdjUNCj4gaGVhZDogICBkNjQzZTBm
N2RlNTI3ZjRjY2Y5MDkwMjU0Nzg5NDlhOTYxNDQwYWM4DQo+IGNvbW1pdDogZDNjOTcyNThkZTg3
NzdmZDY5ZTk4MmZmODA0Yjk3YTRmYzMzNzJhOSBbMjAvMjVdIG10ZDogc3BpLW5vcjogY29yZTog
SW5pdCBhbGwgZmxhc2ggcGFyYW1ldGVycyBiYXNlZCBvbiBTRkRQIHdoZXJlIHBvc3NpYmxlDQo+
IGNvbmZpZzogaTM4Ni1yYW5kY29uZmlnLW0wMjEtMjAyMTEyMDYgKGh0dHBzOi8vZG93bmxvYWQu
MDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIxMTIwNi8yMDIxMTIwNjIzNDEudTdrQnY5SHAtbGtw
QGludGVsLmNvbS9jb25maWcpDQo+IGNvbXBpbGVyOiBnY2MtOSAoRGViaWFuIDkuMy4wLTIyKSA5
LjMuMA0KPiANCj4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQgZm9sbG93aW5nIHRh
ZyBhcyBhcHByb3ByaWF0ZQ0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBp
bnRlbC5jb20+DQo+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9y
YWNsZS5jb20+DQo+IA0KPiBOZXcgc21hdGNoIHdhcm5pbmdzOg0KPiBkcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuYzoyNzIwIHNwaV9ub3JfaW5pdF9wYXJhbXNfZGVwcmVjYXRlZCgpIHdhcm46IHNo
b3VsZCB0aGlzIGJlIGEgYml0d2lzZSBvcD8NCj4gDQo+IHZpbSArMjcyMCBkcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPiANCj4gZDNjOTcyNThkZTg3NzcgVHVkb3IgQW1iYXJ1cyAyMDIxLTEx
LTIyICAyNzE0ICBzdGF0aWMgdm9pZCBzcGlfbm9yX2luaXRfcGFyYW1zX2RlcHJlY2F0ZWQoc3Ry
dWN0IHNwaV9ub3IgKm5vcikNCj4gZDNjOTcyNThkZTg3NzcgVHVkb3IgQW1iYXJ1cyAyMDIxLTEx
LTIyICAyNzE1ICB7DQo+IGQzYzk3MjU4ZGU4Nzc3IFR1ZG9yIEFtYmFydXMgMjAyMS0xMS0yMiAg
MjcxNiAgIHNwaV9ub3Jfbm9fc2ZkcF9pbml0X3BhcmFtcyhub3IpOw0KPiBkM2M5NzI1OGRlODc3
NyBUdWRvciBBbWJhcnVzIDIwMjEtMTEtMjIgIDI3MTcNCj4gZDNjOTcyNThkZTg3NzcgVHVkb3Ig
QW1iYXJ1cyAyMDIxLTExLTIyICAyNzE4ICAgc3BpX25vcl9tYW51ZmFjdHVyZXJfaW5pdF9wYXJh
bXMobm9yKTsNCj4gZDNjOTcyNThkZTg3NzcgVHVkb3IgQW1iYXJ1cyAyMDIxLTExLTIyICAyNzE5
DQo+IGQzYzk3MjU4ZGU4Nzc3IFR1ZG9yIEFtYmFydXMgMjAyMS0xMS0yMiBAMjcyMCAgIGlmICgo
U1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCB8IFNQSV9OT1JfT0NUQUxfUkVB
RCB8DQo+IGQzYzk3MjU4ZGU4Nzc3IFR1ZG9yIEFtYmFydXMgMjAyMS0xMS0yMiAgMjcyMSAgICAg
ICAgU1BJX05PUl9PQ1RBTF9EVFJfUkVBRCkgJiYNCj4gDQo+IE1pc3NpbmcgdmFyaWFibGU/DQoN
CnllcywgaW5kZWVkLCB0aGFua3MhDQoNClRoaXMgYnJhbmNoIGlzIG9uIG15IHBlcnNvbmFsIGRl
dmVsb3BpbmcgcmVwbywgaXQgaGFzIG5vdCB5ZXQgcmVhY2hlZA0KbGludXgtbmV4dC4gV2lsbCBm
aXggaXQgbG9jYWxseS4NCg0KQ2hlZXJzIQ0KdGENCj4gDQo+IGQzYzk3MjU4ZGU4Nzc3IFR1ZG9y
IEFtYmFydXMgMjAyMS0xMS0yMiAgMjcyMiAgICAgICAhKG5vci0+aW5mby0+bm9fc2ZkcF9mbGFn
cyAmIFNQSV9OT1JfU0tJUF9TRkRQKSkNCj4gZDNjOTcyNThkZTg3NzcgVHVkb3IgQW1iYXJ1cyAy
MDIxLTExLTIyICAyNzIzICAgICAgICAgICBzcGlfbm9yX3NmZHBfaW5pdF9wYXJhbXNfZGVwcmVj
YXRlZChub3IpOw0KPiBkM2M5NzI1OGRlODc3NyBUdWRvciBBbWJhcnVzIDIwMjEtMTEtMjIgIDI3
MjQgIH0NCj4gDQo+IC0tLQ0KPiAwLURBWSBDSSBLZXJuZWwgVGVzdCBTZXJ2aWNlLCBJbnRlbCBD
b3Jwb3JhdGlvbg0KPiBodHRwczovL2xpc3RzLjAxLm9yZy9oeXBlcmtpdHR5L2xpc3Qva2J1aWxk
LWFsbEBsaXN0cy4wMS5vcmcNCj4gDQoNCg==
