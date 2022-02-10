Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59034B03B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiBJDFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:05:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiBJDFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:05:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2708A20F56
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644462305; x=1675998305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4ZGNYedXDuh5ygjARy2iIIDHtCo+4fIqqXocjQzm3z8=;
  b=tMRAcAk60/Uy3bsd2VLFKUYaRVPGlscgLthdgpz/3oYWn+NmS+c/WzlP
   vDHdHoNfdkCpkLBon/1uc10tUlllPoOd1egjIUY0Rpw0EZ1DUCYrqdxml
   E48GWzx0ytTcZ4Q9XjNH2VRpNR8QjVQHKihDkdrH+lZNP070bIscoqHN8
   McGV1eY4f6U1eXHt2fvh9yfquDEMiEthhIkVtLzT9d9nJJcgCqBpG82d/
   PszLqCXPvif3MKwZe6iQbXRNqLr/ImgkIZsWdtpEA656AQPfJc3czW6Ap
   Q2+3WpKRam/T0ZJTD5ZgnFdBK02q6NeF0GlCk8YSp7Iypqm+DMRkSKjJ6
   g==;
IronPort-SDR: I0MDZoAVgsJPryH2bdij/v31WGnfzGxkoyKyqc8T+Wf9FZowZe8Wij/PQW70T9PLFj/G7NRggO
 /3Uuii8TRsnIZg4qAusISa3+qLTKcQLlHPObPmH2rYl8wXZczFDEtEL4kFJZMKyk/lt7oSSC/o
 mRE6kV8L+6gKsgNZSUPrpeSBLa+3blwFC1ba1HUyQhlY8P78enrRkF3titVXKGYjOinE+inYYM
 d38MwjUjAM2fExz3TWvNOZl8U0oW6SOhnIFgaDClPb5iFiXVl/3E9xF1fWviMEzuwhcX9bCcFD
 2c/PMYT7KuphYkE+JIZMlDqG
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="152556320"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 20:05:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 20:05:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 20:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBakgPz6jA+pg1ksbyqfDQlfzkRIObMQRWu64/Hz7mnNxBe90sR/83uNBvHiNaHIV+u/wUweMftzck/psn/gfTiUv2yWxpjMR8dmGohtjARgyFtDH3N2eT8lqf/+EE8r7EwinhjbzO/Fbqp8qRGbqlfJNxcaJLaLmVVvmQUUH6kIQb2quFOOpqND+SMQyrpVUh9A+8Gc4x++AFNWpqptR6qT3gXrRnW3PCowGbjDK/us4xFn5l3Irrg/wYcXt22o5KEBDAHcY5f3bD7I4Uf7lmAhdmlOUuFldZBTMNz3EhNX9YlY2f8Ecc090X9h/oWgwEbmNPbwLJszIhmmlC5aRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZGNYedXDuh5ygjARy2iIIDHtCo+4fIqqXocjQzm3z8=;
 b=D9GD7AV3OVyaTki8Ra22lQHu8k0qjHW4KiMYMOybnv+PSj+d6AkhhPPjmoc1YTn3chlCvkNC4QoEnccSBlLPmLCQDMk3/QM+X6cSWEU1eIwjHThOylk0tJuSPxI2muOcTYs/LYBM89YsR7risVRT5eP/kOKNWpxB8aD93hinfFsFQYuns8dyLvD/1vmusfnok8QCR7Afe/jNbWEkOEQczePaS0kyFQf1U5YCQyP/SryOf1e34wPtTKKx6b/667M/rAJBKzw5nmiNHWAy2nQwvtamsp5X2vRvwbMQjs7OM963mu9tsB5Lvr+fdPO47IdsEq9vZffksvTALB4XCjlFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZGNYedXDuh5ygjARy2iIIDHtCo+4fIqqXocjQzm3z8=;
 b=myjNSPfGh4UHAECz+Ff2ttgV9Efuf4BYlVU21e+SBBVtr5LcrJKqlsyFe88+bWuNUeW7ZKwnem9muXGmR3i58Wzco367aG4RfLcj30/RlNUj13DSA/soIvdZqYf2Utd5WOzIIfN8v/o0UU6BORyMRD48QDzvQZnAuwhQVU6iWfs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BY5PR11MB4022.namprd11.prod.outlook.com (2603:10b6:a03:18a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 03:05:01 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:05:01 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 03/14] mtd: spi-nor: allow a flash to define its own
 ready() function
Thread-Topic: [PATCH v1 03/14] mtd: spi-nor: allow a flash to define its own
 ready() function
Thread-Index: AQHYHir+a0BBmuf00UOaCqv+u0rxVg==
Date:   Thu, 10 Feb 2022 03:05:01 +0000
Message-ID: <399c8ea5-e534-9da4-43c0-199e1b88bfae@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-4-michael@walle.cc>
In-Reply-To: <20220202145853.4187726-4-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e710eeac-9172-43d0-e08a-08d9ec42210b
x-ms-traffictypediagnostic: BY5PR11MB4022:EE_
x-microsoft-antispam-prvs: <BY5PR11MB4022A8F52F5D63B1583A9335F02F9@BY5PR11MB4022.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bm3g2h7yCUI8xmudorrswf4ftajkzTxXRjziVatZbbndTwviQWLvBSkwau0OmlxrxrPj2P9/pU00RA+onEHKMHyKZKTBKQ55pL8M0sXmgfFnX43lDQq+nOFmLh0erXtcDUpjcywi8FRNdpCg07RelrAc0uORSjiB9dt7Olda0qkt2j6nU18UTEbaGMLDeJ1RYxKQAYuFlazlN4zRiuoiNDJhn7q7n3p8PJmbA0Z5a1EAR0swV6vvZUwpO2AmzGXq1EaeDT5rqXSXxKXl0ZOxVzUsO+ng6ZWiO8rz5bEeeVYHLFL2E7DT77lhRF5t/wzyKAbUUd4RD1kzSEgoxLSC2LK9cgkzGsRPbgwhroLRpbtkrxXIyUl0J002Y08xFydgdwBDY7fRNnm84Po0IM8EEhEbQ+yq+77z7Z+PRj83PtDM3qX15F0v0EWHyPZaxM23rRzWU92vu33M4IbR4KGv8Uw9SQ0bd8DUIHK7Irq5TOrp7d41jRh9J3iuGSrUpYq/csOgpCm6kTPX9+u1F4vIG+YRoZDMZkF9RNMIw71m0CoLxfMwKRZXYmOjlf9n46hAIA32A9hX6qgULYbsiFI4wOyrVrSFvEI0JkEI4lpUX0gGBN/HdWIKms4orbSSeauyIcNNzZxlv88l8onRbJX1wM5pcCTX3D7cZXUYikgiodak4fdAzNh/UQDAktbTXN48va0QGU1MnmxN9b6mQlc/GTrueg95/QBYylddBPWHaVinIBqcqK70kvAe8pcLqsXnUoxket13iPylFf2P0ECe5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(8676002)(110136005)(4326008)(54906003)(38070700005)(64756008)(66946007)(31696002)(2906002)(66556008)(66476007)(66446008)(2616005)(6506007)(6512007)(71200400001)(31686004)(91956017)(186003)(53546011)(316002)(38100700002)(36756003)(122000001)(508600001)(6486002)(86362001)(26005)(83380400001)(76116006)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnhBVDBxQTl2ellQZ2RmZXFGc0V5b1ZOMmUzVW9DZ1lTMSs1M3NnYnlMQ3A2?=
 =?utf-8?B?YTBkM1pERDlOVk9YME9TdnRmUlJ5YUdCUWhLNDBFM2dnYnFWWnVTL2Q2OW84?=
 =?utf-8?B?L3ZNUklpSEdpV2h1emZ4dlg4c0ozNmNGUlBsWi91YzdxRTFVMlY1YWJ0UjVq?=
 =?utf-8?B?dVVwUUlRTDBGbkYyZE1GUll5SU5Oa0F5L3JHTFJnY2ZoR1I2Z1dIdGZmcUlH?=
 =?utf-8?B?azZWR3I0ckxieHJPQnJ4VEJNbTh1TDVlNzBsb3hvMStGdDFFTGhPNkR4MlM0?=
 =?utf-8?B?M0lBUktLQmNBV2N0bzE1ZmNRcHZ5YVoyYWVHYnhSckxJc3VjRVRlM0Z0K3BG?=
 =?utf-8?B?RFFtS2xnM1pYYUhOUG91d0gzUGRJdFhieStKQU9IZ1dGcC8zZTZ6ck1sSlRW?=
 =?utf-8?B?bmpQNW1IbTVWcy8xQ1pKYVhzb1licllKNEZDaDRNbFczVFpWVjBQYjNJbW9s?=
 =?utf-8?B?TjNqUVVoSlhQZkMxQ3liUEd5cTREZEtibEF3UkMzeld4WEhMaUpmaGV1RW9E?=
 =?utf-8?B?anVEODN2UjJLVjRQTXE5eCtFNmVsUzZWV1NLaVo3M2pWL0FJOVJNb2l5d2p6?=
 =?utf-8?B?V0g0WWJsTWZxTDFTZmk4UFFsK3pWM2pkYlN0cnQ0bDZSVEQ3MHZxbjg5OE8w?=
 =?utf-8?B?LzVKRUcwTnNMTmg3OE1iSHhVUHdtd3YwVmJjWlUwQlBKSkZVZGordHNBb1Jy?=
 =?utf-8?B?dVFIQnBuNDBsSVhkRndPSWI2TVVKeW5iNUo1MmtCYmJPUVVGVnVNdkV0aHhu?=
 =?utf-8?B?VVF0UW1KWW9KUzFYenl1YktGK1k3ZFd4RmxxUW90cjBKZzZhSE03TnVTUUNU?=
 =?utf-8?B?b3NIQ2MyYUtqckNua0NkV1BZcnpyRnFkNWlNeEhOZitsYzhjZ2g3ZjNCUytx?=
 =?utf-8?B?QnNpN2QwSUpicFI3TERZL3JMRGxkY3V3SGN2SHRDdHhwRDVOY01PQkZiL0h6?=
 =?utf-8?B?QWVDVjV1ZWU0amFmZ205MWxBdyswSUtmVEIxM1ZDL3pJZmdYZ2FCdkNaUVRH?=
 =?utf-8?B?K3lYK2p0OXhveTZ0Wnljb1R2NFA5UXp5aVlJalRVUlhmMHg3M3hEcDRMTGtH?=
 =?utf-8?B?c1Z0aTdKcWtwQ1NGYjB4WVhXa2NQcHNVek1ta2xUbS9OQThweFMxTGVRbTQx?=
 =?utf-8?B?amtOQmN2S051Ym5GNWptSEZDemg3eU5oSjc5V0NHeENjTnAwL1FaanVhK2tX?=
 =?utf-8?B?OURLcGJiOUlIZ2dSTzlOY1Znd29nWXFSbG8vcG9mUjliekRvQ0Z5TGNRUXBM?=
 =?utf-8?B?alNiOWl6MkRiYUl6T21oN3B5SVJUQm52NGhxYU53UVpLNHRBaXBRSGQ5VDQz?=
 =?utf-8?B?Z2p0d3AxN0ZYR3lxSVdBRDBMMDkzSW9iSWwwc05MViswRklpa2wwbjF1KzJa?=
 =?utf-8?B?ZzY2Q2NpRXJXc3NnYlBBZ21Zb3NoQWZhUHFTVktsR21QZXpiTHY4RmcwRExU?=
 =?utf-8?B?MmxmbGVaaTF1VTBLTmdGMGdLQWpQQ0RaM0s0bGxoTXhybW1RSi9pU0FHUHc3?=
 =?utf-8?B?Zjk1QVFzdC9BVk5yNk92L09lRjlnaDh4alpYV0MxdmUwaUR3eG1NVUhjSUtB?=
 =?utf-8?B?dGxISDdUNWFYV1NBbEUwb1BxbHBtODJDNTM5VmxvYWZwTUcreituVzF3SldQ?=
 =?utf-8?B?UmFvREZzYTJ0eTBSN1NqSlpRVjNldVl6eVdCeStmYVpqekphd2syVi9sREFR?=
 =?utf-8?B?Qmc4OElwSkZhWUxBcVZORjZ1WDllbzdYVlg1OEY4aDBIcVZRcEpzMjYyS0V5?=
 =?utf-8?B?U28vRFRiS3ozbzNZTFlPbWEyMXVXdlhBSzVJaXlLcEJybHRUcG9ieDhCaXNx?=
 =?utf-8?B?bklhVloxL3g4Z2JKK0JVcy9IT1E3SGJTUDMybWFzTlNCN0I5SVB0QWd1OVRX?=
 =?utf-8?B?b3MxS3NnL1lqaTBWNlU5WTVpN2VGM3Q3bDBmdFFROVl1VE5BNnpZUWpka1cw?=
 =?utf-8?B?MmlLSHQvSzJucTMxOENNTlNmRGpoZnlMVld6SkNwcmM3QmlsSEhHbmVRczNv?=
 =?utf-8?B?SVl0eEt2SU1iL0drdzJac1I4TUYwL0tzNHFuVGlrbUJXMGliUGpmN0ZyNmdx?=
 =?utf-8?B?em1hNS91ZWwzby9hUlBrYzE5b2lPeUZSZkJpQUtrOVpnRE9OMHFxc3ZPazd6?=
 =?utf-8?B?QXEyWmdvV252T011NWJoWCtsZDh2dUQvRmVja3luSWJ3bnliVGN6UVkvWUpm?=
 =?utf-8?B?TlIxK2J5cmJFNEZEV0lHN0htSkZ4TXNBbDQwMXNZSjI3dVJ2bzU0ek1UWUVI?=
 =?utf-8?B?QjVDcTJHWDlDN2tQek94bXVFRGF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DDF98CF8024DE43B708B5D0765CA751@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e710eeac-9172-43d0-e08a-08d9ec42210b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:05:01.5277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/ZAdUKcQf+hlA3gMuxrpmv7AgdI+wFFkS6png5OPVTlrQtcFYz3isl+tw76eudTDQqVm+3owEs9l646+1FihDG57Z17Md5ANYdT5+Tg64c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4022
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
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFhpbGlueCBhbmQgTWljcm9uIGZsYXNoZXMgaGF2ZSB0
aGVpciBvd24gaW1wbGVtZW50YXRpb24gb2YgdGhlDQo+IHNwaV9ub3JfcmVhZHkoKSBmdW5jdGlv
bi4gQXQgdGhlIG1vbWVudCwgdGhlIGNvcmUgd2lsbCBmaWd1cmUgb3V0DQo+IHdoaWNoIG9uZSB0
byBjYWxsIGFjY29yZGluZyB0byBzb21lIGZsYWdzLiBMYXkgdGhlIGZvdW5kYXRpb24gdG8NCj4g
bWFrZSBpdCBwb3NzaWJsZSB0aGF0IGEgZmxhc2ggY2FuIHJlZ2lzdGVyIGl0cyBvd24gcmVhZHko
KQ0KPiBmdW5jdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hh
ZWxAd2FsbGUuY2M+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCA0ICsr
KysNCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oIHwgNCArKysrDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gaW5kZXggYzhjYzkw
NmNmNzcxLi5jMTgxZjI2ODBkZjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IEBAIC03OTQsNiAr
Nzk0LDEwIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkeShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0K
PiAgew0KPiAgICAgICAgIGludCBzciwgZnNyOw0KPiANCj4gKyAgICAgICAvKiBmbGFzaGVzIG1p
Z2h0IG92ZXJyaWRlIG91ciBzdGFuZGFyZCByb3V0aW5lICovDQoNCmxldCdzIHN0YXJ0IGNvbW1l
bnRzIHdpdGggY2FwaXRhbCBsZXR0ZXIgYW5kIHB1dCBhIGRvdCBhdCB0aGUgZW5kIG9mDQp0aGUg
c2VudGVuY2UuIHMvb3VyL3RoZQ0KDQpSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3Iu
YW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPiArICAgICAgIGlmIChub3ItPnBhcmFtcy0+cmVhZHkp
DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gbm9yLT5wYXJhbXMtPnJlYWR5KG5vcik7DQo+ICsN
Cj4gICAgICAgICBpZiAobm9yLT5mbGFncyAmIFNOT1JfRl9SRUFEWV9YU1JfUkRZKQ0KPiAgICAg
ICAgICAgICAgICAgc3IgPSBzcGlfbm9yX3hzcl9yZWFkeShub3IpOw0KPiAgICAgICAgIGVsc2UN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9jb3JlLmgNCj4gaW5kZXggMTBmNDc4NTQ3ZGMyLi40NDYyMThiMGUwMTcgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5oDQo+IEBAIC0yNjEsNiArMjYxLDkgQEAgc3RydWN0IHNwaV9ub3Jfb3Rw
IHsNCj4gICAqICAgICAgICAgICAgICAgICAgICAgU1BJIE5PUiBmbGFzaGVzIHRoYXQgaGF2ZSBw
ZWN1bGlhcml0aWVzIHRvIHRoZSBTUEkgTk9SDQo+ICAgKiAgICAgICAgICAgICAgICAgICAgIHN0
YW5kYXJkIGUuZy4gZGlmZmVyZW50IG9wY29kZXMsIHNwZWNpZmljIGFkZHJlc3MNCj4gICAqICAg
ICAgICAgICAgICAgICAgICAgY2FsY3VsYXRpb24sIHBhZ2Ugc2l6ZSwgZXRjLg0KPiArICogQHJl
YWR5OiAgICAgICAgICAgICAob3B0aW9uYWwpIGZsYXNoZXMgbWlnaHQgdXNlIGEgZGlmZmVyZW50
IG1lY2hhbmlzbQ0KPiArICogICAgICAgICAgICAgICAgICAgICB0aGFuIHJlYWRpbmcgdGhlIHN0
YXR1cyByZWdpc3RlciB0byBpbmRpY2F0ZSB0aGV5DQo+ICsgKiAgICAgICAgICAgICAgICAgICAg
IGFyZSByZWFkeSBmb3IgYSBuZXcgY29tbWFuZA0KPiAgICogQGxvY2tpbmdfb3BzOiAgICAgICBT
UEkgTk9SIGxvY2tpbmcgbWV0aG9kcy4NCj4gICAqLw0KPiAgc3RydWN0IHNwaV9ub3JfZmxhc2hf
cGFyYW1ldGVyIHsNCj4gQEAgLTI4Miw2ICsyODUsNyBAQCBzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9w
YXJhbWV0ZXIgew0KPiAgICAgICAgIGludCAoKnNldF80Ynl0ZV9hZGRyX21vZGUpKHN0cnVjdCBz
cGlfbm9yICpub3IsIGJvb2wgZW5hYmxlKTsNCj4gICAgICAgICB1MzIgKCpjb252ZXJ0X2FkZHIp
KHN0cnVjdCBzcGlfbm9yICpub3IsIHUzMiBhZGRyKTsNCj4gICAgICAgICBpbnQgKCpzZXR1cCko
c3RydWN0IHNwaV9ub3IgKm5vciwgY29uc3Qgc3RydWN0IHNwaV9ub3JfaHdjYXBzICpod2NhcHMp
Ow0KPiArICAgICAgIGludCAoKnJlYWR5KShzdHJ1Y3Qgc3BpX25vciAqbm9yKTsNCj4gDQo+ICAg
ICAgICAgY29uc3Qgc3RydWN0IHNwaV9ub3JfbG9ja2luZ19vcHMgKmxvY2tpbmdfb3BzOw0KPiAg
fTsNCj4gLS0NCj4gMi4zMC4yDQo+IA0KDQo=
