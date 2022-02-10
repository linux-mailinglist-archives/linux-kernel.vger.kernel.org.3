Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D834B03CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiBJDN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:13:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiBJDNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:13:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4E11EAEF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644462806; x=1675998806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G19YS/ACCrWGuRS9BHgoQEAr/N6gde/BBYQf93HzpIc=;
  b=dOfHb02jE8ewV3/E0X30emOkkyzhdED9KXEN6OG9gV/xLire2z6pt8SA
   lJcroPw5PabZDEWW3KzxBWvooi5NmXlOBZYYGNIutYG85XGNc9vwe45KM
   Bon8ZmzuQ+RFQpkFfdjoqrxVcq48fI+QumUXGcS5b3MW5ywRDJBoYeW2J
   lE1sVsK7sTGhLfH1lXjgiMMuatpfRWSX6mJJiUNjMxpi7Rh+RWSZ9ZJ5H
   SksKrpkVUrksPjZbdO0rDy0zRMqa3Z4O24HtNRXW0iAUZsCfFMVOLg1m8
   bQaR9cRbTyANm0HY+sKeBcGyAGsJFl1iAyxiOOSOieM2+5IY44naZwi0K
   w==;
IronPort-SDR: QZORQy7LMoblBKpjhjp+nHTo7Tkx/cSFtIZU+x3xJEW7jRsfgfwZHZN4sm2WcjLnh+wB4SKj98
 D3aiYZS5gp2SccCPVQz9GNVJq6bafTuWrnM5i3EB+cjoiWo8/BiwiffiGpfm/Kbhmf/eKAGnT3
 rhIPk/KHXvSMpME0DBno6GrbufJ9REPcXeUVdqCny+QHmQZHPCwg8LB+hKLggl1T9sgmlxfOIw
 5tE+NIg71toPOSghGz0mp5ogetCpPHzsjr2IF5Jd1n0Cl0W6e5FFxpvId6yrmgX3/RJzb7Qgfg
 DOqpPVLEyBd+h7Kb1OtcRSgn
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="145478636"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 20:13:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 20:13:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 20:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7EBRiJp3YxODRlj0JJLFgcXVWW5kbL6a+djjHyaFGeBfEzIA+OGplrVUYrrq45QaZLM8/ll3dJH+aiT9YudJjJEYQBqBdbwYnjKb9l7uyylNkOIV8HRtB/P/kaeLL+tkrZ74mNOzxsu9elQNKtzz6dRCZue+mNJlo8o1dO5huH+j5hfSwTjueoKGTtYon6tXLbtkf/55c7NvbsmrsneB0MZWBx2v53G05CQSS4BgxodpqhoamWa7ZuL85ydt9jRdFc1mfwbzT/Oh4qUUQSRHiCfLIGm8Ez3NiZR7yPRRWsAI1sn3mpiC8mDH7M/rCTpGIxxvAQZA97GpNB2n/djiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G19YS/ACCrWGuRS9BHgoQEAr/N6gde/BBYQf93HzpIc=;
 b=V/SjVbDqRiVCHlgn4SnI2PzjHViC7eSu8YDz+/gL6VliaqAuHf2isNCK2nxpwWeg45O4R7tA43uJ8QvaydPxvxAl7r0K4USNPjUz+R8mS4eId7ig81SZHhuIk7ofnRifUa4E0JykHmpoMXq7nj8nBjpuu582WMYYee/kpe5jVDjMaTFgkEHQKmiK0ZtRGgGB/e4blnN+TGR6N+wmQ0N7J93VEvfZjRvAdmbmqpB+cp5FgYa532Ar71iAUmk+bsWtSLYu3CN1SazD2w9DqApuAq+aO3pqjQtEFLXis8SCLO5DCHGlBlyyzNMDkZhMenxag9vSl6IRHCkywhgf4FFqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G19YS/ACCrWGuRS9BHgoQEAr/N6gde/BBYQf93HzpIc=;
 b=l0YxesIfCbI36t5qH1pjYYu7QVT9L3i1C0bnt4BkKdhXwU4TOtzZYaDbpqzuvYMBVqY+BPZH4DuwkAn6Cp3C23SOFsiMX9QOW0e89hGiUixdp5S7j2SLXbJuRg62Lbr3vaCLP4kLEFbIxoVRGPKiC9RVs/9jGZYWw4b9J3exehM=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2896.namprd11.prod.outlook.com (2603:10b6:805:d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 03:13:21 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:13:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 01/14] mtd: spi-nor: export more function to be used in
 vendor modules
Thread-Topic: [PATCH v1 01/14] mtd: spi-nor: export more function to be used
 in vendor modules
Thread-Index: AQHYHiwonZ596/xtb0qSZFGQwAhfPQ==
Date:   Thu, 10 Feb 2022 03:13:21 +0000
Message-ID: <6551933c-9283-8fba-c918-fa9acc4660bc@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-2-michael@walle.cc>
In-Reply-To: <20220202145853.4187726-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 754ec60d-3bdc-49a2-8cff-08d9ec434aca
x-ms-traffictypediagnostic: SN6PR11MB2896:EE_
x-microsoft-antispam-prvs: <SN6PR11MB289687F4C44E421B5D0B7522F02F9@SN6PR11MB2896.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aiNBsJsoETZtO3sQHDl3X1Id4eOONCA8Q8ounzcnqzCpdomSXUqKN9XdlyKXLa0eMzOWkAEZFGG3GH9aaBOWvLztbqyKYGRvshwDzQyvNqtE3J6nUPEf6653AY6OFaWoR6sLc45t2lawl1RgX9C20hekmcb4L/k/poN2yvQhVV7QwKzznWlqXk0gxxl9hOQhzvvEvsMnGoaZ1YPFF7zYVjpMWzF414jLJOAAUhW/ULh0LgPdMvmXV1Pn2szENwzjwWktMK2OjF2XyIwWCaZ6YfuZYNJd0rpHZzlKRUOaEgPp1MqHcrz06YgKPREAw1X3sTP4ZJOVHtZoHVClNY3yRxzMAmNZeEDNOtz9AOxReG8hyFeUj+WYVJltek572lQQUIGot4c47ZMEQYCHRGEaYgDRFEY6dJloy+93Twpv99Fkgqizv/0rU/SvKbprx/hicLVmWFMAJQ2145k36OIKzGWr5zR7hh+L1yS6rEF3/216QmXOIRt+FrYTyFhp3bLo6iLBmzNWvbvMJHXLKXGZgL5aWWLjgaJOi3JDIv5o0YIKbhau/6065Q6ZV4BW2hl2UQKA0RZkglkLECxAeHF3gTN7tZE3XQMWGrR6mpIuBYQh4/DstdMWytOvR0wKRhWIQcPfGxrce2THLM0cwT+rc8SjGDK3v6zZvnJXzDpZIyo8EB/yVXoWw7b9EXteoIsDTiSr4oNxwFLsH2F9sdrVEOYskWAaQW7+xPV7IIb4qdxPnzDltKcgHjjqf+Xbud0o9y7ympwjDnhhLvk498zgBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(83380400001)(6486002)(2616005)(66946007)(66446008)(36756003)(4326008)(38100700002)(122000001)(31696002)(76116006)(54906003)(110136005)(86362001)(5660300002)(91956017)(8936002)(6506007)(71200400001)(6512007)(2906002)(53546011)(8676002)(66476007)(38070700005)(31686004)(66556008)(508600001)(316002)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkoyZUZFSjVMTXFFTjhkelMxVk94VExwc3pSemhMdVJFMklKdVBwYzlWbVpK?=
 =?utf-8?B?TjNzOVNPZVZsdjgyRFB1YXN4aVp0eG44WmVRWFZDTEQ2MGlQYWpSN29XZ2Mx?=
 =?utf-8?B?WEV5V0h1Yk1KR05ndzB5WXFqRm15KzBmdDVQNWZBZCtnUGdGbThaZm95alpW?=
 =?utf-8?B?THRyUXk5RkdZOUZFaDN0WjM3dGtTWDF5Y29rUjE4L0M5eEhVSFlORTNEV1lw?=
 =?utf-8?B?K2xxN0lLZTM5MXBYdGNVdWtiK2t4M2RVektyV2wra0lpbzBYcXQ3SG9oSC95?=
 =?utf-8?B?QmZFMVlQRTFoaDczamp3eWU4bmIxNUp0dkpTRGw5Vm1YYUpjQlpCYVk1K2Nr?=
 =?utf-8?B?WDhoUVpsRzdTaEhzWStnTzNFY0ppeW05bHc5cXFwUmdTYkx5eDY1em1Pd2xD?=
 =?utf-8?B?NXhCc2FZRzNjQ2NRc0ZhTCtDUlg3YVJmalMwNzZrWVVZelBnNVc2WE1rSlVs?=
 =?utf-8?B?Vi80bFN5dE83cUh0K0t0SW1DdVp2TWFCVHlIV3BXNjFKU3FQL0hBMUROK0Np?=
 =?utf-8?B?NWZrc3Q1L2l6YlRGYWVKc283SVRBZWhpV2hoblVhKzE2SUpCOUtOOXNZVE5X?=
 =?utf-8?B?UE8vdzVJOXdremRzdC9DZGh0SmpaeDZPSVloVi84Yklwc0M4bTNCNEx6UDZV?=
 =?utf-8?B?QVFST0lKdTluS3NrZ2ZadE5wWFhWSEJvOWNINmt1TTVhWDAvWW8zTzhEYk5R?=
 =?utf-8?B?Zi81NTllaHZjbVkxS29EM292YW5pNDlTZWY2K1crS2czaE5aM0krMXVqR1Qw?=
 =?utf-8?B?cDY3VlM5UUZwRFpVVEtueWZyNHdIek5KR0JWNWJuYjBsYkYwbWdIUW1qYkxq?=
 =?utf-8?B?dnFqQTdVOTVrWmVURVhNRHV3WVhWdUduWnBqRW1OaXVLYWR3QW8wNUp6YjdK?=
 =?utf-8?B?cStCRHhFT1NSMW5FR1RuSUNkZktwdlczczdkTERUaTFteXBDMFhuekk5SzVR?=
 =?utf-8?B?QkN6eFZtVkE5SkJtb0xkVG1hNm44ZFFPWDRycmFyc0NWRXBYNzF5Yk1HM1FS?=
 =?utf-8?B?NiszZnBDeGJTUnNPU0k2MGo3Q3ZnSHFiN0JUc0oxakl0Qml2K3h5SW1pTFFr?=
 =?utf-8?B?NDY3MjlVOUJ6aDI3S3UzYmtldlNsT01QWWRYYXZSTlRoVDRFM0crSTl1VlZL?=
 =?utf-8?B?MEhRUzlCSEtoRmFOVllrdkNVcm5rK2w3U1l5d3ZlVTVzT2Zua1hFVlA2a3pQ?=
 =?utf-8?B?alZTNmg5WmJLb0RQZS9veS9FSnpzMTVYbG8yd0hsanYyT1dpYUFPcUdmMFlw?=
 =?utf-8?B?VW9uaEI0ODNhSmpSaTE1ZXQvTnFDYU00VUlpMGE0aE1PUnhnY2FwK0h4NEFt?=
 =?utf-8?B?ZkJwL3l5WVdIeGVrb2Y4cDc2Ny9SeE9KNnBUMGExY1FzcFNhdkN0a1c2aTZ4?=
 =?utf-8?B?QVFUU21hUzZpU3BIZ0tCeDJzWEdaSzdjUHpEWG1QcFY1YWRhQ2owWGJpSmlv?=
 =?utf-8?B?bWdtNnlNc3FJN0JzQ3BDa0tFYW1tTXdYdmJ2R1ZTN3lnYWl3Q0dJSDBKQ25T?=
 =?utf-8?B?TzJ0QTVwcnRuVTdhMGpMTjYxbXA3c09pK1h5MGV0OEpuL1RuZFJyVjJLTXc5?=
 =?utf-8?B?VGpnSzZvd3d5cE9taStrUzlBTGtZRHVUYTh1OS9rMTU4WldOQ3paTUJZdklH?=
 =?utf-8?B?WktSZ3VBYjdDcXlPTnNWNlYrSnZqY0Mzdno2K0pzaWh0SytIalluTkgrYTBi?=
 =?utf-8?B?N29YbGJ0MnJrN2JnWHNJakk2ZHFTK0N6emtiZVJTS0RzZ216emNKaVJaajVC?=
 =?utf-8?B?NVlLb1BGQ2NDU2hUcDFDVm0xYS9NaThsSTRvQTFBWUFqelFvc0lIM2k5K1p0?=
 =?utf-8?B?VnhWVFBsbHFRUWNnUzZqQm9JU0ZnTWhrU0hkRFRmSE9wVHNxZG5Ob1lGMHpZ?=
 =?utf-8?B?a09QcTI2OStXay9mOUJ6TTh6VVNKS2k5MkR5UXVwRnhJdUl6cEhtT1FFVno2?=
 =?utf-8?B?US83SGRQYVV1VWg0SElzS3E2OFZLTGNXQTlnWkNoVFRvdkZpY2pjbkM0Y0NL?=
 =?utf-8?B?UC9HM2VLRVJvOEw5cVlteFVOWk9sMWhSSU1rNmN3aG5qY1E3aXZXblRxZmNh?=
 =?utf-8?B?NTg4a1JVV3JRSU1ZY3BYajBiSnB5dVlHUzhiR2VyZEJha25IU1FVN28zM241?=
 =?utf-8?B?QWJQN1ZmMVR5Skx0RGNBdzA3aVl5NzJtNjJJY29mN3dvM2dWN0lrLyswSHFV?=
 =?utf-8?B?MitGNFFZeWVzaGwwMW05OXVxZTFXUEV5L2tBUGdhQTE4ZW9Kc0VQU2l2Umox?=
 =?utf-8?B?czhUZjdIWFk0dkJlUXNpbHN3dHhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <119B8319F44C8F4FB6E6C6438A0DBEC9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754ec60d-3bdc-49a2-8cff-08d9ec434aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:13:21.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsC0nBFPLL2C0YnH/Ak7NYf8iaa6Gafi6AoqfywwwfWrL7o+0M7jIFPXmQvfuT54C3PMrcrK2Z7Vff7kxz76Jk/964qiunL5fZJP1zas3iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2896
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yLzIyIDE2OjU4LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFdlIHdpbGwgbW92ZSB2ZW5kb3Igc3BlY2lmaWMgY29k
ZSBpbnRvIHRoZSB2ZW5kb3IgbW9kdWxlcyBhbmQgdGh1cyB3ZQ0KPiB3aWxsIGhhdmUgdG8gZXhw
b3J0IHRoZXNlIGZ1bmN0aW9ucyBzbyB0aGV5IGNhbiBiZSBjYWxsZWQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KDQpwbGVhc2UgbW92ZSB0
aGlzIHBhdGNoIGNsb3NlciB0byB3aGVyZSB0aGUgdmVuZG9ycyBhY3R1YWxseSB1c2UgdGhlIG1l
dGhvZHMuDQpXaXRoIHRoYXQ6DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5h
bWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2Nv
cmUuYyB8IDEwICsrKysrLS0tLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oIHwgIDYg
KysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBpbmRleCAwNGVhMTgwMTE4ZTMuLmYwNWVjZTYwMThk
YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gKysrIGIvZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gQEAgLTE1Nyw4ICsxNTcsOCBAQCBzdGF0aWMgaW50
IHNwaV9ub3Jfc3BpbWVtX2V4ZWNfb3Aoc3RydWN0IHNwaV9ub3IgKm5vciwgc3RydWN0IHNwaV9t
ZW1fb3AgKm9wKQ0KPiAgICAgICAgIHJldHVybiBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGltZW0s
IG9wKTsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgaW50IHNwaV9ub3JfY29udHJvbGxlcl9vcHNfcmVh
ZF9yZWcoc3RydWN0IHNwaV9ub3IgKm5vciwgdTggb3Bjb2RlLA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdTggKmJ1Ziwgc2l6ZV90IGxlbikNCj4gK2ludCBz
cGlfbm9yX2NvbnRyb2xsZXJfb3BzX3JlYWRfcmVnKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4IG9w
Y29kZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTggKmJ1Ziwgc2l6
ZV90IGxlbikNCj4gIHsNCj4gICAgICAgICBpZiAoc3BpX25vcl9wcm90b2NvbF9pc19kdHIobm9y
LT5yZWdfcHJvdG8pKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiBA
QCAtMTY2LDggKzE2Niw4IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9jb250cm9sbGVyX29wc19yZWFk
X3JlZyhzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCBvcGNvZGUsDQo+ICAgICAgICAgcmV0dXJuIG5v
ci0+Y29udHJvbGxlcl9vcHMtPnJlYWRfcmVnKG5vciwgb3Bjb2RlLCBidWYsIGxlbik7DQo+ICB9
DQo+IA0KPiAtc3RhdGljIGludCBzcGlfbm9yX2NvbnRyb2xsZXJfb3BzX3dyaXRlX3JlZyhzdHJ1
Y3Qgc3BpX25vciAqbm9yLCB1OCBvcGNvZGUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY29uc3QgdTggKmJ1Ziwgc2l6ZV90IGxlbikNCj4gK2ludCBzcGlf
bm9yX2NvbnRyb2xsZXJfb3BzX3dyaXRlX3JlZyhzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCBvcGNv
ZGUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB1OCAqYnVm
LCBzaXplX3QgbGVuKQ0KPiAgew0KPiAgICAgICAgIGlmIChzcGlfbm9yX3Byb3RvY29sX2lzX2R0
cihub3ItPnJlZ19wcm90bykpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7
DQo+IEBAIC02ODMsNyArNjgzLDcgQEAgc3RhdGljIHZvaWQgc3BpX25vcl9jbGVhcl9zcihzdHJ1
Y3Qgc3BpX25vciAqbm9yKQ0KPiAgICoNCj4gICAqIFJldHVybjogMSBpZiByZWFkeSwgMCBpZiBu
b3QgcmVhZHksIC1lcnJubyBvbiBlcnJvcnMuDQo+ICAgKi8NCj4gLXN0YXRpYyBpbnQgc3BpX25v
cl9zcl9yZWFkeShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAraW50IHNwaV9ub3Jfc3JfcmVhZHko
c3RydWN0IHNwaV9ub3IgKm5vcikNCj4gIHsNCj4gICAgICAgICBpbnQgcmV0ID0gc3BpX25vcl9y
ZWFkX3NyKG5vciwgbm9yLT5ib3VuY2VidWYpOw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5oIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gaW5kZXgg
MmFmYjYxMDg1M2E5Li5jNjU3OGQzZjU5OGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IEBAIC01
NTQsNiArNTU0LDcgQEAgaW50IHNwaV9ub3Jfc3IxX2JpdDZfcXVhZF9lbmFibGUoc3RydWN0IHNw
aV9ub3IgKm5vcik7DQo+ICBpbnQgc3BpX25vcl9zcjJfYml0MV9xdWFkX2VuYWJsZShzdHJ1Y3Qg
c3BpX25vciAqbm9yKTsNCj4gIGludCBzcGlfbm9yX3NyMl9iaXQ3X3F1YWRfZW5hYmxlKHN0cnVj
dCBzcGlfbm9yICpub3IpOw0KPiAgaW50IHNwaV9ub3JfcmVhZF9zcihzdHJ1Y3Qgc3BpX25vciAq
bm9yLCB1OCAqc3IpOw0KPiAraW50IHNwaV9ub3Jfc3JfcmVhZHkoc3RydWN0IHNwaV9ub3IgKm5v
cik7DQo+ICBpbnQgc3BpX25vcl9yZWFkX2NyKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4ICpjcik7
DQo+ICBpbnQgc3BpX25vcl93cml0ZV9zcihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBjb25zdCB1OCAq
c3IsIHNpemVfdCBsZW4pOw0KPiAgaW50IHNwaV9ub3Jfd3JpdGVfc3JfYW5kX2NoZWNrKHN0cnVj
dCBzcGlfbm9yICpub3IsIHU4IHNyMSk7DQo+IEBAIC01OTksNiArNjAwLDExIEBAIHZvaWQgc3Bp
X25vcl90cnlfdW5sb2NrX2FsbChzdHJ1Y3Qgc3BpX25vciAqbm9yKTsNCj4gIHZvaWQgc3BpX25v
cl9zZXRfbXRkX2xvY2tpbmdfb3BzKHN0cnVjdCBzcGlfbm9yICpub3IpOw0KPiAgdm9pZCBzcGlf
bm9yX3NldF9tdGRfb3RwX29wcyhzdHJ1Y3Qgc3BpX25vciAqbm9yKTsNCj4gDQo+ICtpbnQgc3Bp
X25vcl9jb250cm9sbGVyX29wc19yZWFkX3JlZyhzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCBvcGNv
ZGUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4ICpidWYsIHNpemVf
dCBsZW4pOw0KPiAraW50IHNwaV9ub3JfY29udHJvbGxlcl9vcHNfd3JpdGVfcmVnKHN0cnVjdCBz
cGlfbm9yICpub3IsIHU4IG9wY29kZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnN0IHU4ICpidWYsIHNpemVfdCBsZW4pOw0KPiArDQo+ICBzdGF0aWMgaW5saW5l
IHN0cnVjdCBzcGlfbm9yICptdGRfdG9fc3BpX25vcihzdHJ1Y3QgbXRkX2luZm8gKm10ZCkNCj4g
IHsNCj4gICAgICAgICByZXR1cm4gY29udGFpbmVyX29mKG10ZCwgc3RydWN0IHNwaV9ub3IsIG10
ZCk7DQo+IC0tDQo+IDIuMzAuMg0KPiANCg0K
