Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05784B03E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiBJDXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:23:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiBJDXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:23:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1011163
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644463388; x=1675999388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E0G1CpK+4eqnRYuSNXMsB5walBx8JIflCWZsHQQDVos=;
  b=uTrA94nAMZu9c4lNWQhkNDFdZx8psKFKFpOtd/iaSMChVgGrnBLqnQ0/
   quyeOLZ3TtwYB8/cqsRMRP/9IFMmd5Lx5heW+JLGpDQpw1UZSaLRCjMLu
   WxUZo488a0aErsybFgGKm78un42P5PZnAFLa2hehgzQAOU5u8SdDFx+8/
   Bk06D/REzwguKN+OBSjrlCV/E9i/un8ioZrucjkP2sVKZ4i1BaXBg7AF+
   98dTplMUm0XWAko3IrRU4pbX9gZG7Ddnpiam5hOlNh6XPHIszJ8K4AXx1
   p3/TnQgpe2K6g4J0GfgqIA9r0z3er1kJhS5ixiMU4J7jcQmN0wCYKqQny
   g==;
IronPort-SDR: 1Qsq8pcOeehGNk0CZHNssd76xfjs1uwaeambn6gPcs5J75icvtBOinjS9sLFxfdXS4X1jsqT7f
 IC32ndYMlX3ROe8MPzVjycmbglVp3nh4tU0DWsfnxu4ZYk6/i3nZYg+kSRZrIkikd9yR0G0a2P
 uapVckEAWAcVs0EgogU2/thfKbriO1CvY21HqIKyEzwYPnaGZ2h6H1ApR8SCa9pmWC7vziJ72K
 Ca4H7ZhMXJ2q5c3PtEvN4cGlISQqrgGq17oMZKwHYe2yf5v82qouoxz+1A59pg8UpyA5ExpAq2
 byZYWMCdXR/HYLPyTXUW+lVj
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="85253516"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 20:23:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 20:23:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 20:23:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4BVTKSxRaA/mXHSMwyVnfP4kFwrHeXfmd+PS8TOtddOxaDhkTxcgCp/F28vHeefSSDqADY6NlDoNqLJsry4Z0/iiPEXcuwiMm9/Mso33UtWrSAHUq/DHzDOSJXOmGl4gMJ1NijUbLl/im8IyLuGc9s06YJmy/achGIonp1EG+CMotFq3KVuowHo3AfTeEqqcgIfa+qrTXMuS7rYWc2Zv18wun6sioE7Jh8r+8t/y1avKQmOr0TxveEqzbM5kHd0OYAFkLnbnmEws8vsNHYr4BPjszB/aBDuvfZVgaMdIa9jZIhuD1XzLjyK+3ei2zsz5jg7Rg+ZqEjnlanelFwrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0G1CpK+4eqnRYuSNXMsB5walBx8JIflCWZsHQQDVos=;
 b=bGlvg/hEUQzCaFwI3czP2C1/LNbUVK3hbSUtYI8vlRFQfdCPq4GivSZOVslKeghtmlHNcpsSzulH4X2wdrHbE0xRXQSWJ9maNkNZpSCw81RcB+wJRUpfUa+jWkjJjhhYu/oTU8qK4yRFtqTdDLf7/tVGVZVOeyIyN9hGMams3Vm/9kKLFyBu+QtAJC3lLifqf5vGgzH6EXB1bKGqshPYefzqijv4YBDfGveEEaNhLFNCgpvZXH9l3h7rgELKW7/pcMHhFbiUwZnZd7fcjI23Dbr4b1S+BIER6nvCQKLqfb5w71W7IiTJmVO0j3NnCVJmnCc51fDjUXdcvonxlcekyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0G1CpK+4eqnRYuSNXMsB5walBx8JIflCWZsHQQDVos=;
 b=k92xVWNlZ1I1CP/UYYPrebUofVovFJYc4VSzCNRrxUNQOfPEPYZgvaCoFOaImSJTwK2JnhUtEmrp4GFeHZ2/J0y1zHfAt17u3+2EaVm3P504uWOYM6YGK0plE//lecLuFZEMvVjJIQBIz8QGTtcJJ9aY/+qkfMaRCH9FIwEFjkc=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM6PR11MB4315.namprd11.prod.outlook.com (2603:10b6:5:201::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 03:23:02 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:23:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 09/14] mtd: spi-nor: micron-st: fix micron_st prefix
Thread-Topic: [PATCH v1 09/14] mtd: spi-nor: micron-st: fix micron_st prefix
Thread-Index: AQHYHi2C39iYsoYWv0SEThxRHGhL9w==
Date:   Thu, 10 Feb 2022 03:23:02 +0000
Message-ID: <5519abc7-c3a6-fbf6-12ff-bbcb239d0c5e@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-10-michael@walle.cc>
In-Reply-To: <20220202145853.4187726-10-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27d64eb1-b9be-4abf-1a14-08d9ec44a53e
x-ms-traffictypediagnostic: DM6PR11MB4315:EE_
x-microsoft-antispam-prvs: <DM6PR11MB43151D5312E921CCF5058C48F02F9@DM6PR11MB4315.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QLf2QVgGTYV1YjZehfYv/BnNBkJ6c/Cy8BEEL85BJjhfcqq0v+15veSRprk0qDnbtn4N536hw43y7vGOJCHh3HQhCeCOjuH9t1TnhBqjOA8Gc4I2/SFO64Ppdh6+d++zvFY7OqTCoV5hWWav0um01WNaPEBQ8jfcpjuCxkftDZb6BH/9gz+ANBjVLoOM7WkYrvzSGOLqxnJXOVT6rxCmizPX32VaqKKz0/jEcq6KQF2IEct1i6WmsYNyDSUYA5O8zXF36nuU8m8hFKB7I0G4KpTcfaTQMgSEJt4Cd26/OfGFZaArfd5l64P7mbmrva+WKFRavf9up9DnO+xFL1GaKBPXgLDBaSi9/QexnozQIEBICP5bkTdcOgEJeKZC2Ip3UbFutbHyC6f+jFmmpKG5DDiL7kAhe0LSN0w9n3jRRz4AqjUHGzhRns0dG53oPLNNNViezWVx21yruiVM3407vhgpMWMYWfMia2mBSXc50n4J5pNNqzPWtnuMIWWVGuClgqgoaSAC8MaEISN8EWAJ2621xxclsNFsVTMWII8iFC92apMVcN1OzgWnXvhjvq0kKJoBpgqOBPWZRXYMj53qL22hjkJlf9jFhdgG4s8OgwjD2PZ3hw6NFYgR2C2GIs2e40VHsMQ/TxQEDXncKrZ8btVZw18Tvzr2wbivyd4P5C/xkoKGG2cWgGUhrFVTGu96T1M7S2y5IgaQmlu4kiSSykvmRZZk95XHL13Nz1Spf7biCBOJsVLSD9N0EwWUWLOLY+p1nvt/CL/O+gAFP7yMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8676002)(31696002)(4326008)(38070700005)(36756003)(71200400001)(508600001)(2906002)(8936002)(66556008)(66476007)(66446008)(64756008)(186003)(2616005)(26005)(6506007)(66946007)(76116006)(86362001)(31686004)(6486002)(54906003)(5660300002)(110136005)(6512007)(83380400001)(53546011)(316002)(122000001)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czNyRnhSOG5saG10RHpKb3pFSGxGc09zUlpLTVorczkvN2pjRWgrMmZRRUt4?=
 =?utf-8?B?SW9JeEV2MUZMQSs2cWdHMWFpSXk5ZXE5bHVZdG9tWmNHakpsMXlQRThLZWpa?=
 =?utf-8?B?dFBTOU1YUDcxMm5Yc3llVzB4TTRFSnlSRDU1RHFWSkRLVlpINTN5aHJUOHBq?=
 =?utf-8?B?bjljN25IM1IxUlk0V2J3RklNMzgxQmZDVkRuK0FYRnFpTmRtUHpVRTRIRUIx?=
 =?utf-8?B?M2Y2L2REQ3FYZTB2OXVMTldOcEtMKy9tN2VyaStRS2F2WkhQOHhKOUtpK0Qw?=
 =?utf-8?B?TXYvc0s3U3g5UlZhQS85QnNKVG1qc0l6WWkyUmNYR2ovWGdrVnhEVDFaOFNr?=
 =?utf-8?B?VFlaWnZ0cUlNUzFOeVNTeVBGb2VqcEVkUHF2NDBZWGgxYm1pNzVHNDJCdENm?=
 =?utf-8?B?eG45dVVlUGtwZGhjSEo2UVlLNE41dG4vZy9udVBwaWgraDhDK0ZLb1Q0WndI?=
 =?utf-8?B?b3R1eUh3TVB1VDk4MWVIekljV1RSQllVQzU0cTBibUxyVUVCejJ1SFAzMWxZ?=
 =?utf-8?B?UUY4dUd0enlKSWlvNFltQ0JUUVM0ZWFiYmduZVVkdjEzNVZuVGRhMnA1a2JU?=
 =?utf-8?B?dnRWY3JmL2haUUx1QjZCQVZuSzhPYnZ2WVpSUHZoRnB0bFdrcUg3QUt0Mis5?=
 =?utf-8?B?NUIvcW9kTTc2eE04YVJwOTRVMnhjRDdSS1hza1FIV09ucWJHeC9QRjBpelpN?=
 =?utf-8?B?VSt6bWFYR01ZSllPaFJSbXEvcFhmTHhaRFMzWjcyOVE4eXNMQ3FmWm56TEZZ?=
 =?utf-8?B?UmpyaFBnUSs1eTVoY2hjQ056WVE3bFRjTGlQMk56M3pNdDRZcjdKclhXbm9s?=
 =?utf-8?B?SVdoMXNuTHdlK21BR2plbTZrWXdOUzNWaTJZcUdyVWVJUHRMWUNZRFBQK3l4?=
 =?utf-8?B?ZlFqNDRPOEk0dlNSMkJ5YmZtZUtZVWhOcWNXUHFqUVFmSWFPeGVxMTFiQU00?=
 =?utf-8?B?emlOcThDRUhldTNmZ3dvbFVtaHk0QlpYUnNKbHFJL0VyWFZodVk2UjM3Vkpk?=
 =?utf-8?B?SEpZS3RNNWhSajAzMGtNMG1zdW9DSnNjcVp1S2JXMWpad21YL2NCd1hGenJw?=
 =?utf-8?B?amtlTk0wb1l6ditvSXBvTmFlcWpZTlhadU9WQ1NmZll0ZGFTK3JDczlIVE5t?=
 =?utf-8?B?WFlYK1lNbkdZMzE2U0tTQUl5SldRR1hDa3J0OWZCdlNKNmFMRVhZUlhVYmJR?=
 =?utf-8?B?OEFGVDdJaStYamVFeUhFekl0anlnRlFRbWNCNWM4OEw0Smw0OHRTSENJNmlh?=
 =?utf-8?B?TldwOXZLNXk0dTFZQ0tPSWh3ZEtod2R1bFg3VUhjc2Nnbm5BVUVNRnlPVnJ2?=
 =?utf-8?B?Vy9QWjczcmlQSURLWWN0Tm5tVThjQmFiWVdsMEhBYzVWcG1Ya1VKck1NYytj?=
 =?utf-8?B?MkpVQnZqeDlPbHR6WExPNG0xSFkyaHVrMDUzMEJHYVJUVHJ1bUhZRWxMT0w1?=
 =?utf-8?B?YU02Zk1KaWg3bXdweXFFR1ZVVWlYRW83TXZ3S0V2QkNXODVBaDFmUFdvMWVD?=
 =?utf-8?B?M09ueTRtMVVwY2lQUWQ2MTVKOVkzUnZuOThwaEc2UXR2dzRyOEc4VDdxd1A4?=
 =?utf-8?B?U3RLaDdTRzIrQlVlYjJDWXFoMUl5NzNmUDFhN2haYzVUSlhocnFDMmN3UThw?=
 =?utf-8?B?Z1g2TmlyZmxJcFZUdEduQTM2SFo5N2VsbStDN2hkVlMyR3FnckluUkJZNU1V?=
 =?utf-8?B?aUxuWHhHQkJudU1nQmYzd01GS0VJdVB5MGIzYXZWRk1ReGl0VWhZbjN6T2FW?=
 =?utf-8?B?QlhkUUFDQ1JTWlhydnllMWtDMVcxemdRRlgrMlJtZjBhY1NsSnRienRqcyt2?=
 =?utf-8?B?enNjWCs5aVJrWlVYS0lMZVl4dVlqRUNtL04wT05IWVQxTFR6OVl2TjhweVVq?=
 =?utf-8?B?OWRKa1FZZDVuMjBWMEhjemphTllySjhsZzB0dXlsVUVMK2hyMFpXVEY3V1dL?=
 =?utf-8?B?OXRMUWoydjdmcUpKMTR6T1hma2RiRUpzTHBiTUxYMVQ1dVBhSGNHWjI5YlN2?=
 =?utf-8?B?aFE5VnN1dVZ6WThqZ2NUSjczbTN3WTAzSncyb0trbDFwM0RJU2RnRnE4SGFz?=
 =?utf-8?B?Tm0zZ3Jrc0RHN2VuZjg5aC94Y2J4ZThaNmJxdUdZb2JYeG90NmlvNWNmenlw?=
 =?utf-8?B?R0ZqRFVsczhHWnR0ck9JaC9BVEs1OHovV1RtVGNLbG9pRmt6dllLdFZBRHV1?=
 =?utf-8?B?cUZJemk2WkhaWnhZUWt6cVFBQlZmN0R1MVViNWozY21uVW9peGQ5TGs5bHdx?=
 =?utf-8?B?R0VvNzlPSjN0ZXh3RkpoRDFiYjJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F6EA965CA56874789800C15B6EA9BA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d64eb1-b9be-4abf-1a14-08d9ec44a53e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:23:02.3252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KdXbAL3G1ZhjmvPzVWKcOIwaD23NG2NBW3uBhzRbIXX6nbOQ+0DzIP2FMnq/2AEf2k4kZzvVzDSQmTJ6DmyCtrcVzdau0z6fY84aDeI/sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4315
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
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSB1c3VhbCBwcmVmaXggaXMgbWljcm9uX3N0LCBz
byB1c2UgdGhhdCBpbnN0ZWFkIG9mIHN0X21pY3Jvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1p
Y2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJh
cnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL210
ZC9zcGktbm9yL21pY3Jvbi1zdC5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
dGQvc3BpLW5vci9taWNyb24tc3QuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMN
Cj4gaW5kZXggMzM1MzFjMTAxY2NiLi5jYTM2OGI0OGJjYjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9t
aWNyb24tc3QuYw0KPiBAQCAtMjg0LDcgKzI4NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxh
c2hfaW5mbyBzdF9wYXJ0c1tdID0gew0KPiAgfTsNCj4gDQo+ICAvKioNCj4gLSAqIHN0X21pY3Jv
bl9zZXRfNGJ5dGVfYWRkcl9tb2RlKCkgLSBTZXQgNC1ieXRlIGFkZHJlc3MgbW9kZSBmb3IgU1Qg
YW5kIE1pY3Jvbg0KPiArICogbWljcm9uX3N0X3NldF80Ynl0ZV9hZGRyX21vZGUoKSAtIFNldCA0
LWJ5dGUgYWRkcmVzcyBtb2RlIGZvciBTVCBhbmQgTWljcm9uDQo+ICAgKiBmbGFzaGVzLg0KPiAg
ICogQG5vcjogICAgICAgcG9pbnRlciB0byAnc3RydWN0IHNwaV9ub3InLg0KPiAgICogQGVuYWJs
ZTogICAgdHJ1ZSB0byBlbnRlciB0aGUgNC1ieXRlIGFkZHJlc3MgbW9kZSwgZmFsc2UgdG8gZXhp
dCB0aGUgNC1ieXRlDQo+IEBAIC0yOTIsNyArMjkyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBm
bGFzaF9pbmZvIHN0X3BhcnRzW10gPSB7DQo+ICAgKg0KPiAgICogUmV0dXJuOiAwIG9uIHN1Y2Nl
c3MsIC1lcnJubyBvdGhlcndpc2UuDQo+ICAgKi8NCj4gLXN0YXRpYyBpbnQgc3RfbWljcm9uX3Nl
dF80Ynl0ZV9hZGRyX21vZGUoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9vbCBlbmFibGUpDQo+ICtz
dGF0aWMgaW50IG1pY3Jvbl9zdF9zZXRfNGJ5dGVfYWRkcl9tb2RlKHN0cnVjdCBzcGlfbm9yICpu
b3IsIGJvb2wgZW5hYmxlKQ0KPiAgew0KPiAgICAgICAgIGludCByZXQ7DQo+IA0KPiBAQCAtNDMw
LDcgKzQzMCw3IEBAIHN0YXRpYyB2b2lkIG1pY3Jvbl9zdF9kZWZhdWx0X2luaXQoc3RydWN0IHNw
aV9ub3IgKm5vcikNCj4gICAgICAgICBub3ItPmZsYWdzIHw9IFNOT1JfRl9IQVNfTE9DSzsNCj4g
ICAgICAgICBub3ItPmZsYWdzICY9IH5TTk9SX0ZfSEFTXzE2QklUX1NSOw0KPiAgICAgICAgIG5v
ci0+cGFyYW1zLT5xdWFkX2VuYWJsZSA9IE5VTEw7DQo+IC0gICAgICAgbm9yLT5wYXJhbXMtPnNl
dF80Ynl0ZV9hZGRyX21vZGUgPSBzdF9taWNyb25fc2V0XzRieXRlX2FkZHJfbW9kZTsNCj4gKyAg
ICAgICBub3ItPnBhcmFtcy0+c2V0XzRieXRlX2FkZHJfbW9kZSA9IG1pY3Jvbl9zdF9zZXRfNGJ5
dGVfYWRkcl9tb2RlOw0KPiANCj4gICAgICAgICBpZiAobm9yLT5pbmZvLT5tZnJfZmxhZ3MgJiBV
U0VfRlNSKQ0KPiAgICAgICAgICAgICAgICAgbm9yLT5wYXJhbXMtPnJlYWR5ID0gc3BpX25vcl9m
c3JfcmVhZHk7DQo+IC0tDQo+IDIuMzAuMg0KPiANCg0K
