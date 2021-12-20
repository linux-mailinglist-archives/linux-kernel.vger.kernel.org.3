Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63247AA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhLTNXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:23:07 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:20267 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhLTNXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640006586; x=1671542586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KV9UyJWGvTeGp8WSlFAg4k0LolWd6DahPykGswiywog=;
  b=ps5SH6MOWeyvaZIdaA4zMvYRmC8iFvwpoTOBjLfKEXukfdNmQ7F2AjXy
   jtSiWH3BN+jbiIFs4OEqG1ECk703KvfNXW33aVo9ZgwKtjzwVHGTpCPkz
   aNfgXysoMCSy0Yw9I3qT/RJpkmugmm3lEtEuOlm7ooWtnOxt143WkfjCV
   tASnpoLuM7XDAS+uueSBMyyVpIcvZDpijydudhd2w0eZUgRejRtjecH+7
   kCpHEIcbmZc0BNS+/gxqxCnTUhIJrIHhOgyAl4oZx5MLEGub/eyCZnU5b
   thfwCJ5Zj2qUVNWGgmoWWEIS9+8K3PvKFLwyTBv/xoMTsSTMp1895lMAP
   Q==;
IronPort-SDR: /hr+1eik5yALDQ5R2PiUwyC8k6QVWrjTJbNAk9zzrm2JaWW/hDlDenYhG4axgGmIQv+W6hXN4R
 4lLT8WO4zYHlw0o7IRLSnAQGEPParvfaPPaxIwxc8in8xvmYIRp99X6vypUVyZkahmtoC9Cm2p
 42rhUsW7H5mwxnTrxLvxjlUQjiAq1XOJqG1EZ8LtMOiGNiR0hFYQ2psF5JUPpa2SBLBgY3v0Ly
 4/m3SR6raqXZC3PoNTnCAHW4fQPJJRu4QC5auHR0eq2Ch9Xs704MT55chrV5aY4/AjMgf8bLaQ
 s2gxpDG11/xPFqMbP/SqTiqX
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="156102752"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2021 06:23:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 06:23:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 20 Dec 2021 06:23:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN+UIlehER2HfDeyAMPOx5PDbJbsv2IYSriZWC6BTo2g0wh1OWSqKnbw29TFFvOoa1hCQGf/d0d59RXNm7aQTGbEm6BXRPg1NYJPeiiUm4c8n6Cw/BaIpwIPO9xbwr+hxEg9wCY5N7NH+04GI+UC2OnYGZ3BK5yX2ru/BnGgMGcmfmaz55N1PpCCLb1mi/6PS6qpytDV5gouO7YRRT5yWHbGmqh0kJLQot/TMfSTapjzfREz+6lfN55MMZnbmwxFoc1ZWalcfT6DWXbmq2FjAu1rdd/isv1rY7QLRhn6BrOdlhztcyzmTvQlnDprgcpzuPfwA1Ji5A0sh1M0UGsxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV9UyJWGvTeGp8WSlFAg4k0LolWd6DahPykGswiywog=;
 b=O8GcGDa43CO09RBYWLL35pBN5sGCjsujQttHixlaUhdk8sFNUoyshj+YItIVno+0Be1kXQ3TmnzS0ea9cgmaum8SxZTuOABOVki2YMxQvmeYO1m5viFI0pyxNEecFOtEtIkH30tTyeQZubUGqf13jzTaQOPHvulZx3brHyLZZDjUhhlJByyWTn4OMvyeBZrQz/lLWga953eXNPnyceUA6hXg1OvbMSd5Br1ALzzCwycQVD3Yqe3fvRjjD3zjXcG1KyaoUgFt8TQ83Es7SWSSKVbuWfde5+hI2SJtEMl1rS+9Tbwyq0oQign2Ltv1MZPKtbGZAjgUpuAbIctlEyO1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV9UyJWGvTeGp8WSlFAg4k0LolWd6DahPykGswiywog=;
 b=fCruElRrDDTbpjYJVXAwZXD56saWm2bHrq4Y9AOSNfDHhSjL7mffJ3aBi6giMNoEOfPvwyFSOV4yYVbHjMk46+cR0tDnTjLNvqS0TqNOrmVApaYy6/8AHpfJfypKnIl1n0ep5kOAqsYbbViNWFwByDxzUeHz5u0u6+DTOKVga+k=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3104.namprd11.prod.outlook.com (2603:10b6:805:cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 13:23:00 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 13:23:00 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <zhuohao@chromium.org>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: core: Remove partid and partname debugfs files
Thread-Topic: [PATCH 2/2] mtd: core: Remove partid and partname debugfs files
Thread-Index: AQHX9aS1k6kqqdQxpESqT7d3Zxxaog==
Date:   Mon, 20 Dec 2021 13:23:00 +0000
Message-ID: <25999218-8985-03fc-c53d-21bd2a25d365@microchip.com>
References: <20211217122636.474976-1-tudor.ambarus@microchip.com>
 <20211217122636.474976-3-tudor.ambarus@microchip.com>
 <20211220130743.jil62qbyb5lgds6p@ti.com>
In-Reply-To: <20211220130743.jil62qbyb5lgds6p@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43f3d2b8-bb33-4ad5-d460-08d9c3bbd81b
x-ms-traffictypediagnostic: SN6PR11MB3104:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3104B33A08F29B6DF0FEBCA6F07B9@SN6PR11MB3104.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0f9rIXbsv8O9IlFWgYJ6qSuRCh7Th60Eqj6IspmFVgD2n4zdgdSC3bo8HEBeQyUBJFTFz4E79ECVR1Xr2fIt6iQN8xQ5S4a2w5M6FNLqEghJcS0HDH9nSxUlCAl3C4Jku4J/uPUovuFb+WJ/kgxUeym9YGrT139VZpEIqxK5N0/UGeSntOpZ+pfde/5wDnYvuARqnsYObL2x1EbAgJ9Mae3JHY8MYwmJdtdwAaACYyIgB182Ir5a/1pafZ6DWXFnGe7OiwKi9o99gBpNDAvvw0/QYLpt2GWa0Jm0etYnnwL5qOGbQfMb3FFpYzKELkeLPZMhpX81mg9buwHre/+U2YcDmTGtsATZK2lLZqLHQk6/kG3zgIeQaTaZ0ozMDf7rYP9HU5lKC9z05LNLKIPbr4QHDk08BFQXiq3QoyT2MwbHO+QvI2byvaa1kDN5JGAtiaJuD8DJ3YSTQknLJCuyK7yw4OLEciaFqBIBGA2Nfbu3tfDkEBUKqoaAC6DYYJC2tUL5LIcjRO1+8AhzKVI/ogC7y8pIHwhwYT+K5EXQCz9qC/qQdKC6dPepaKCpM1MnGRZaMx6GaZm0IHXrPLMdd2q4vF2atAo14c5Iz2uXSAetV+aWhZTbbomZAQdaM/8pFm+xTf3jRgnu2jlTzDjgENOpmXB49KdHsy/kmkYElKEMDWiN11q+wlYhd3ZCmDlqkBD2fU365nVoi9P4melx64zVmkqzXUyY97Lsu+qnBALgAllATywVjue6NvqfMhadOvx+oCo8XXW+br8FbIJOvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(122000001)(83380400001)(8936002)(31696002)(316002)(6486002)(53546011)(5660300002)(6916009)(38100700002)(2616005)(186003)(8676002)(508600001)(4326008)(38070700005)(26005)(36756003)(31686004)(6512007)(6506007)(91956017)(54906003)(76116006)(2906002)(66946007)(66476007)(66446008)(64756008)(86362001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ykt0dTlQNDVWREJQZzQvOUM4SWh1S2NuTTUxY3prcWkvWW54LzBOam53a2Iw?=
 =?utf-8?B?OE9iVUlyZ0VBTm1NNDB1MzBsRUluUlJaY1BEK2JsTDBTL2p1NUVIL0hpZkgv?=
 =?utf-8?B?MjYrWVVPUUIyUStZek9pc3ozT0NITXQrZzhxakZ1NVdzdkhvWk1DQlJnNG9r?=
 =?utf-8?B?eW9PS3JKTFBxWVQyT3lpTjhjNGVHUXJWRGZzWW9GOW1CMG9PMjFpNGlPS3Fp?=
 =?utf-8?B?ZEhyb083ekQzQzFtbWpRT0M1UGNPdXhETUJUR0pPY0kyN21IczFEeG9zdUpC?=
 =?utf-8?B?WWRueFVKcVFIQzVpU2NqQ3JDR0FHclR4cUs3Wmhlbk80aHNrWHRXNkxvSGYz?=
 =?utf-8?B?UlBUcjFoUGdjK2M1WWxOVUdPbmd5TCtzaTRuRDBucjhCRHJxcFhiS1V1dnhE?=
 =?utf-8?B?aC9KZ3dGZzFhK1dHL3N5UXV4aE56ODJzMjNzZjZPVnJaUEhTL2hVVGV3bUgw?=
 =?utf-8?B?VzVGenB4VVhJL0hLeWdNUmhlVnk1c0lybnFXMnN3ank1bzBRMFkwbzAvUjA0?=
 =?utf-8?B?NTRVN0phYndSb2JSUjVaaUNyeTV3WE50ak5XenMycXFCWXdxZDdBSUZnQkRq?=
 =?utf-8?B?ZGxTcjlxV01jUjR2RUlpRnVESEVBMTFUcDRhRDkzZTJHUk1rMlFDZlNlS2t6?=
 =?utf-8?B?MHJ4NWJOdmZoSGZTZDNtbGFnWWFUaHRYdjV2eEVoVCtDVDd2ZzZ0NFVHaVBH?=
 =?utf-8?B?VlRYeXlPTjUwT0R3eGhYTkFBZlZ6b0dvMWpYR1Q0ZTVURDBXUU9mYjRKaGV0?=
 =?utf-8?B?VVlCN0hzZnJiOUtwWGZiVE5ZclVObFdDR082MTdQcmliNmQxVThNUFJhYVBT?=
 =?utf-8?B?Yk4zVGk2TXhhUGx4TlNTMzdwM3hMNjZuaExJTkZzZTd1TWVQSWJMbFowblNT?=
 =?utf-8?B?TzFUK3UrS1RpRFdWTmZwTXJjVXRzTHpRYTA5RkJXNEloaDBURFNEUk4yTkRw?=
 =?utf-8?B?SnA1T1RPRWFCMGlvc043c1VlSXFqWXF4M2ljVGxqa0FMZHVkSW93K09JdzFt?=
 =?utf-8?B?OEp6QXc3WDZHR0ZnNkxZOEhuREx5cWo2WmpqcGpDVUFYYnI1SEtCc0s2L1RP?=
 =?utf-8?B?SmlaM0J4VjFlNU9McUFaaVFwb3JkY1dDR2M3QjFXUlkvQUJVRW9MRUhhdURm?=
 =?utf-8?B?ZTc4SjZMN1lkb2p0MDZXMmVjT3UxVEJLNWRrUXhsNzUxZ3EyNzNzWEpRWm16?=
 =?utf-8?B?QmZuaWdzd212eGFUODhGMEM1a1YvMUo5STQ4Nis3d09INEY5aExKNFp6azF5?=
 =?utf-8?B?OCtVWmRLSXVKRUFKZjRJY2t6cW80UjZBSmRocWpOV0ZGNktoQWQ5ZTZCaDNF?=
 =?utf-8?B?bGhLYTZSVFdkcVVhc3VqVDhqQnVmclcvdHRzS1B1ekNja25BM3ZDbVJCK0ZF?=
 =?utf-8?B?b3htRlpZT1FJRGVHbkJqUUNoWURDR2JOcEFVam5tTGREY0NwQzNxemcwT2x5?=
 =?utf-8?B?NUpKbDNnYlBIK1V0ZFJJYkZ2UmJNK0hyOTlLc0VjbzQwQm1kdzdVc1A4T0gx?=
 =?utf-8?B?Y1VqT0EwcG5Bb3ZYVUpMekhJMzZYSTFDREpsbVhENU5LMWFoY0RIWGFURHFt?=
 =?utf-8?B?TXF2S2VSRVlabXJCcnpKdzhXZnQ0NjVVMzFaMHlseE9NcC91ZDlCYTZOcENv?=
 =?utf-8?B?MEltK0tiOWxyRWNtNkxXVnY3cWxFUUZhaVJWczMvcG9kb2VvemQ4MUFhWjdL?=
 =?utf-8?B?bjFVanB5bStkemZDZFdYQWtDOEVaaVZVeVFuZS9qUCtVZFRzZVFsSlRXRnBs?=
 =?utf-8?B?Ti9YeDdsUzRLYk5KRnFKUDJKN05nTWl3Z2Ywa3ltOTdqWE1vdlVQZ3RoYWI3?=
 =?utf-8?B?NVJNbnZSR3JlTk53c1FTYVdaV2R2LytyMkV3MkVncExrSGdZd2FORGJJNFQx?=
 =?utf-8?B?N0RQY3BYUXR4aEdGYSs5TlZXSk9DeVd6WGUvdkZ3WXRaY2ZBUXhjL2psRExZ?=
 =?utf-8?B?TVdoV0pUM0dha0xHTWs2ZWkxSUZjZGZiNEtIeHgxcU9IbHEvOGxxc2xyYlpR?=
 =?utf-8?B?K0NNUS91cDNFdEQ5TnJQcGl6MmFEK2VGbHdjS0N5Qi8vUVA2L0xpYkx2OXFj?=
 =?utf-8?B?ZHoxdlgrN2pUK3drYVJyRlVIQkV6NjBQUjJLaDY3akFkT2dlQjZMK2d6VGhH?=
 =?utf-8?B?OHo4VFIzbHF3YUZJOUt6U3hBc3hJV1kxcGhDQzZkSmdtTU9pRHFRRjFEMDlN?=
 =?utf-8?B?QWg2b1ZpUWNKdnBZTmNIbUZzamNwQkQyMW5naEk2OXdVMWc4eEFrbmpPT3Fq?=
 =?utf-8?B?ektVekNvV25hSTdvanNYY3lwck1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CA07E9FC629EE4A91F72212317EBCA9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f3d2b8-bb33-4ad5-d460-08d9c3bbd81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 13:23:00.1061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbca9dex3e8kWOcwPsLE9lfJHV2mHRLwYqO3eULBibCj3SdS8nOapDoaeYS1pb4ae8tMLSAGM9ka6DpnI5VgUzZp1j3YiAjo7IySd9FK7zY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjAvMjEgMzowNyBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTcvMTIvMjEgMDI6MjZQTSwgVHVkb3Ig
QW1iYXJ1cyB3cm90ZToNCj4+IHBhcnRpZCBhbmQgcGFydG5hbWUgZGVidWdmcyBmaWxlIGFyZSBu
byBsb25nZXIgdXNlZCBpbiBtdGQsIHJlbW92ZQ0KDQpzL2ZpbGUvZmlsZXMNCg0KPj4gZGVhZCBj
b2RlLg0KPiANCj4gSG1tLCBzcGktbm9yIHdhcyB0aGUgb25seSB1c2VyPyBRdWljayBncmVwcGlu
ZyBkb2VzIGNvbmZpcm0gdGhhdC4NCg0KWWVzLg0KDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4g
IGRyaXZlcnMvbXRkL210ZGNvcmUuYyAgIHwgMzUgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4+ICBpbmNsdWRlL2xpbnV4L210ZC9tdGQuaCB8ICAzIC0tLQ0KPj4gIDIgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDM3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL210ZC9tdGRjb3JlLmMgYi9kcml2ZXJzL210ZC9tdGRjb3JlLmMNCj4+
IGluZGV4IDkxODYyNjhkMzYxYi4uMTk3Nzc1NWZjOTU1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9tdGQvbXRkY29yZS5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9tdGRjb3JlLmMNCj4+IEBAIC0z
MzYsNDkgKzMzNiwxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRldmljZV90eXBlIG10ZF9kZXZ0
eXBlID0gew0KPj4gICAgICAgLnJlbGVhc2UgICAgICAgID0gbXRkX3JlbGVhc2UsDQo+PiAgfTsN
Cj4+DQo+PiAtc3RhdGljIGludCBtdGRfcGFydGlkX2RlYnVnX3Nob3coc3RydWN0IHNlcV9maWxl
ICpzLCB2b2lkICpwKQ0KPj4gLXsNCj4+IC0gICAgIHN0cnVjdCBtdGRfaW5mbyAqbXRkID0gcy0+
cHJpdmF0ZTsNCj4+IC0NCj4+IC0gICAgIHNlcV9wcmludGYocywgIiVzXG4iLCBtdGQtPmRiZy5w
YXJ0aWQpOw0KPj4gLQ0KPj4gLSAgICAgcmV0dXJuIDA7DQo+PiAtfQ0KPj4gLQ0KPj4gLURFRklO
RV9TSE9XX0FUVFJJQlVURShtdGRfcGFydGlkX2RlYnVnKTsNCj4+IC0NCj4+IC1zdGF0aWMgaW50
IG10ZF9wYXJ0bmFtZV9kZWJ1Z19zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqcCkNCj4+
IC17DQo+PiAtICAgICBzdHJ1Y3QgbXRkX2luZm8gKm10ZCA9IHMtPnByaXZhdGU7DQo+PiAtDQo+
PiAtICAgICBzZXFfcHJpbnRmKHMsICIlc1xuIiwgbXRkLT5kYmcucGFydG5hbWUpOw0KPj4gLQ0K
Pj4gLSAgICAgcmV0dXJuIDA7DQo+PiAtfQ0KPj4gLQ0KPj4gLURFRklORV9TSE9XX0FUVFJJQlVU
RShtdGRfcGFydG5hbWVfZGVidWcpOw0KPj4gLQ0KPj4gIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpk
ZnNfZGlyX210ZDsNCj4+DQo+PiAgc3RhdGljIHZvaWQgbXRkX2RlYnVnZnNfcG9wdWxhdGUoc3Ry
dWN0IG10ZF9pbmZvICptdGQpDQo+PiAgew0KPj4gLSAgICAgc3RydWN0IG10ZF9pbmZvICptYXN0
ZXIgPSBtdGRfZ2V0X21hc3RlcihtdGQpOw0KPj4gICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0g
Jm10ZC0+ZGV2Ow0KPj4gLSAgICAgc3RydWN0IGRlbnRyeSAqcm9vdDsNCj4+DQo+PiAgICAgICBp
ZiAoSVNfRVJSX09SX05VTEwoZGZzX2Rpcl9tdGQpKQ0KPj4gICAgICAgICAgICAgICByZXR1cm47
DQo+Pg0KPj4gLSAgICAgcm9vdCA9IGRlYnVnZnNfY3JlYXRlX2RpcihkZXZfbmFtZShkZXYpLCBk
ZnNfZGlyX210ZCk7DQo+PiAtICAgICBtdGQtPmRiZy5kZnNfZGlyID0gcm9vdDsNCj4+IC0NCj4+
IC0gICAgIGlmIChtYXN0ZXItPmRiZy5wYXJ0aWQpDQo+PiAtICAgICAgICAgICAgIGRlYnVnZnNf
Y3JlYXRlX2ZpbGUoInBhcnRpZCIsIDA0MDAsIHJvb3QsIG1hc3RlciwNCj4+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmbXRkX3BhcnRpZF9kZWJ1Z19mb3BzKTsNCj4+IC0NCj4+
IC0gICAgIGlmIChtYXN0ZXItPmRiZy5wYXJ0bmFtZSkNCj4+IC0gICAgICAgICAgICAgZGVidWdm
c19jcmVhdGVfZmlsZSgicGFydG5hbWUiLCAwNDAwLCByb290LCBtYXN0ZXIsDQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJm10ZF9wYXJ0bmFtZV9kZWJ1Z19mb3BzKTsNCj4+
ICsgICAgIG10ZC0+ZGJnLmRmc19kaXIgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoZGV2X25hbWUoZGV2
KSwgZGZzX2Rpcl9tdGQpOw0KPiANCj4gV2hhdCBpcyB0aGUgcG9pbnQgb2YgaGF2aW5nIGNyZWF0
aW5nIHRoZSBkaXJlY3RvcnkgaWYgdGhlcmUgaXMgbm90IGdvaW5nDQo+IHRvIGJlIGFueXRoaW5n
IGluIGl0IGF0IGFsbD8gSSB0aGluayB3ZSBzaG91bGQgZHJvcCB0aGUgZW50aXJlIHRoaW5nIGlm
DQpUaGVyZSB3aWxsIGJlIGZpbGVzIGluIGl0OiBtdGRzd2FwX3N0YXRzLCBuYW5kc2ltX3dlYXJf
cmVwb3J0LCBkb2NnMyBmaWxlcy4NCg0KJCBnaXQgZ3JlcCBkYmcuZGZzX2RpciBkcml2ZXJzL210
ZC8NCmRyaXZlcnMvbXRkL2RldmljZXMvZG9jZzMuYzogICAgc3RydWN0IGRlbnRyeSAqcm9vdCA9
IGZsb29yLT5kYmcuZGZzX2RpcjsNCmRyaXZlcnMvbXRkL210ZGNvcmUuYzogIG10ZC0+ZGJnLmRm
c19kaXIgPSByb290Ow0KZHJpdmVycy9tdGQvbXRkY29yZS5jOiAgICAgICAgICBkZWJ1Z2ZzX3Jl
bW92ZV9yZWN1cnNpdmUobXRkLT5kYmcuZGZzX2Rpcik7DQpkcml2ZXJzL210ZC9tdGRzd2FwLmM6
ICBzdHJ1Y3QgZGVudHJ5ICpyb290ID0gZC0+bXRkLT5kYmcuZGZzX2RpcjsNCmRyaXZlcnMvbXRk
L25hbmQvcmF3L25hbmRzaW0uYzogc3RydWN0IGRlbnRyeSAqcm9vdCA9IG5zbXRkLT5kYmcuZGZz
X2RpcjsNCmRyaXZlcnMvbXRkL3ViaS9kZWJ1Zy5jOiAgICAgICAgICAgICAgICBkZWJ1Z2ZzX3Jl
bW92ZV9yZWN1cnNpdmUodWJpLT5kYmcuZGZzX2Rpcik7DQo=
