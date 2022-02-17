Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7D34B9FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbiBQMFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:05:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiBQMFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:05:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2FD6578;
        Thu, 17 Feb 2022 04:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645099518; x=1676635518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xQ6o5N1aRUv85IQFAYa/Oqc6swhw0wbWlaVoZB88T2M=;
  b=I3fS3q2jkqgaOlmJ4Sba07E7Nqh4KlpUv8VpofJ2u2/avRr8bZ3CFwvr
   ld7yeLD//XXNN70LwbfDuRlkyjgTerIMWZORnXCdQq9+Z+7RCB6h8cXLk
   B1Qn1i2iMBi4Ar649nkAyuB+/l16FTqoP4DHSesbPZvgoZc9rhbi2RLjF
   xHzpxzDK6Y52UT3lNgnlLxeaF7qDsl37cXPhfj+TDIOwj4173SjWF28f/
   XQ5Z5TgStUtY5AxDjZzM/9o4DWa35zTx4W9YMvdW2FyfGm8V3Yzkqxkjp
   CcegzkgiKIqkAwYHrZTE9lt4JgMatyQlkxJN1Tu4Jt9oVEVFYiI7SVvAT
   Q==;
IronPort-SDR: XvRN2Qx+teH4aNOR+ZCb5mlTWF/fOyRDwvRH/YJ0WRTLD5vS7PNzqzxqcKvJTpdL23WoXJjqwM
 m3ufv+/iCGKqexNhLzu3WaTxSAuSNi4pz2BOo7X0IW35zeaYpkRWLVCex2fAeFPXqRcnUVSdEo
 WTplh4Xaq8968SH0rvUcAgTCDvZKXs8loJmV3Orj1/IrFonfvcRubkuPKf88O/GY8vBLA2Xief
 UMq/QXbjvip6WciXmYbBJwDeuqSHxzY97gaOTTuqtArhmBn05y3JUYQjOo0sJsesbg+9yW1rEE
 ktQPdLE2+B47/5v9ghF/u1S+
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="162620634"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 05:05:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 05:05:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 17 Feb 2022 05:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz1A7gh4z7unDYO+C82tjbt/tOFi/B+OyBA4t1AGxqkpF17yi7iVF8h90tKp2vPDf3XCCZveDJEEkw51Sp2E7Tric39e2vZp5Tj8/S6jOJ1PMls6mZ5sPNaKf+VYPO4nJJF7um/oB/wH3h3J8oHDiTRrfW2Hvp0MWL0/i5OZjJ3Z7erNHOiepjOE/AhL7JfLUgcNGyl4JdbRHfBJKzpqEiVFetS6SR1QAZfIHPiyUOvmQgv7vm1s7HEKNlBCI+7Mgjcs2SzC1p+sNz9IyumSv1JVvegEmimpscolBt84lguXwOSxkj9/IHuDDb9bK+f2TNUxr0j47rWjGLwjEkr21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ6o5N1aRUv85IQFAYa/Oqc6swhw0wbWlaVoZB88T2M=;
 b=j5rOwM0+qfbfr68sYAfO+1pmvp0kftEHsjewXy415dpMjLlR+eJydKjMNAIZ9naAD3f8r98xR5GNKjX+0HwgPPv53LtcGyOz8U+6lVI/K+DdiglaPcxr/+Bj1/MJ1C/172/EYNo97JzNVSWUrMT/Gqs3YSH5GCYcDe7ClMPq5SddFUSLzL0NXtobI2N98Th63KVPYx5MDmE40ZNbvBt3RJZX+VDfifreU9fls+MGvrjDDfI9oLVf5zgc5qrtClzrJWu0k0ijrZH0xKV0GBl+8m0dsI2B3dedyZUthKEt74xRr/atncQuJfhJyzDsDtcGLfTFe9F3csEexDdJtcuE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ6o5N1aRUv85IQFAYa/Oqc6swhw0wbWlaVoZB88T2M=;
 b=AiGLCXfrXTnGqi6673HlFfXD1IeBFQ8EaJ84+yYcAuUqzE86eI1HH6NvlxuB/YF/JEym8goVnXLX24s2OcKgSlYh2n3OfF/3Utk4dCDqgsP6aEq69u7A5c2HsksMk7NlgizgMz6ho4JOsSh8u7HNQdfMm/7EO5uO0kNTzY/492s=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by SA2PR11MB5066.namprd11.prod.outlook.com (2603:10b6:806:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 12:05:15 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::28cc:a34a:d10d:bb99]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::28cc:a34a:d10d:bb99%3]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 12:05:15 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Thread-Topic: [PATCH] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Thread-Index: AQHYIntm1Pqq+yVd7kOEGEIGfPFGg6yU3G2AgALL2QA=
Date:   Thu, 17 Feb 2022 12:05:15 +0000
Message-ID: <ab656974-4262-0f7c-4aa1-e00b8008f888@microchip.com>
References: <20220215144649.14378-1-sergiu.moga@microchip.com>
 <21ce5bf5-1e69-4112-8322-e65c8bccb353@canonical.com>
In-Reply-To: <21ce5bf5-1e69-4112-8322-e65c8bccb353@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20c9e4c6-f330-4dfa-d851-08d9f20dc221
x-ms-traffictypediagnostic: SA2PR11MB5066:EE_
x-microsoft-antispam-prvs: <SA2PR11MB50667CA620D1288EEBF83BDAE8369@SA2PR11MB5066.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZN9wCM+BzDuHWBkMdDq3KPbFmmQsw5raIPf1KpFQ0FYVhEJaDxGnmfXoV1TCHMBhB4sayDQXjNrCBIdYUFLvmuK8cR2a/zPiCd0OsOkHB95/RjHyxZmRt72td3urmu8T7feR/AT3NeLBzc40sW7Sp+Y5dYftKXLFoMRc0OuC2zBw1P9z2a0hVxdMBRQTux1/z5QfTcw7cEOFZ+xl4K+UHlGW1cdphlF+PcpmXKsUCI0X+/37ZSmDWHCo4NsVd/36XRWiKNZhx4JY/wqa0J1r2YKPWB/5k46LPrQ0t5lzYnJGN8PLuBhw5JV744dDLyKQKRmMGL92BjW9HGWnktGV3X6Z/qzXe04NsAoPhZUTjF7MIDjMPO0NWOqCejV1vPTta2n9WKFvRSnacXeDU66rn4I9cZl33D1xQoNYH6P+gcKO8Um/eQZMc/hhE3q8rd9QvnpFk4gvBl6vlgdNtr1IQe3jrX5cZzgDitLZkCw+2PPpVdB/rjs/6wFAOuByWLKmsmrTqhgxGuYK5E8HNjRfPDwrUgkQbFZvT8OXaCqwuZvDoehgIgbOONYKb5Dav2MXKM46YIEL1ID7qNcnFv4zXuWDBhLY6mZL+BHEO7rPoboiC5eqvBQYQXSM/xVbwusFFPUTrQ/3aF8QXfTTEp1cycIHiNBJyqPY6idhEv37p8pE2NScVghFdSMzDxHNdkdjP6lDhFTDPP9t9sAiqsdHuXPNBRSOFB/vUOcrj9Zdol/xiF64gAdTPepyi2HhZad2hiOp+P9eoY5mgu5dmn3x65Je8A+WEagsmp+pjAKXMJDcqsXAIbGHdzEwiUumGraPzRWEnVwfEFGrBCtnRhZ3LLz+poEcXIjcxZndyhL0vMM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(4326008)(76116006)(66476007)(66556008)(122000001)(66446008)(26005)(66946007)(8676002)(64756008)(38100700002)(110136005)(6506007)(54906003)(316002)(71200400001)(6636002)(53546011)(6486002)(966005)(86362001)(38070700005)(31696002)(8936002)(508600001)(83380400001)(31686004)(2906002)(2616005)(5660300002)(186003)(6512007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTR1NnFzQkZYL2hTVUJubGFGWWNBUEFTSldkNUJhU0k1UmFTTXhaT2xzdUNH?=
 =?utf-8?B?aXUvT0FhUWRHTWJkSWNva2huVEpDb0pVYklZMytveGVWdjViazM0RnUwZWtT?=
 =?utf-8?B?RGpSSndURmpQQzN1REZuMitwdEIvVUZwcE5Ja2lXODZOU0xpZmd5QThyT3F3?=
 =?utf-8?B?K3ArUFRMVW1aUHZUdFNUKy9YTHluK2kvUnpMTGNXVFZtanRSL1gwL2xid0ZG?=
 =?utf-8?B?RytiVE5iT3FPbXNqTENBZU1CSHJOZnZTSHM3YWhYNnQvTW1kTWs0V2tpcTZ4?=
 =?utf-8?B?ZnZEU25qL0ZXVVpZZWRlbFJNNmdySlVQM0hzRVpYMFhteGNqdEhBMU5TQ1JQ?=
 =?utf-8?B?dXpiTlVEZ0I2cTBjNmJkUFJERkg3RzIxRS82bUdmNU9iU05vZmg5b0JYTzJG?=
 =?utf-8?B?WWJtekpvdk9DVFJ0NzNIOFRCdVg1dWFtYkV4QnUyaWl5b3lXMU9YWWt3NGEx?=
 =?utf-8?B?bDhMWFVPTzdCVEw5QUdUSmdXUlFiM0RDOStSUDdoTmRKTlIydStiN0ZSdUZP?=
 =?utf-8?B?NVVBTEEvUUNmMEh1eTFuYjh0RUZGZkNzazluOVJPL054UWM3YUFKUi82ZG94?=
 =?utf-8?B?S2pja2d3cTgwVEtZUnVYemhva0YyMTVURXRmUUs4ckxVRFV6QXFidEozTEJ0?=
 =?utf-8?B?VlFzWDk5STZhejBmcFFrS0owbXRpMFZLN0xub3lTMGRhQUlpcytoWmhaWExj?=
 =?utf-8?B?NTNZWlZvYmswY0FQZ0g4OHhuWnpXbE9MQVpVMGxIam1ZM01SbG5rS3R5Ritj?=
 =?utf-8?B?THNpTGpSY29oWGhpb2dXaHExenlhb1dGamtXOXZYWWFtekc3ejZxNUtkRkpl?=
 =?utf-8?B?RzB0b0lSMzhrNE0weERuNkM4MVpRaDFSaUVkaXo3dURETlJsRTltR3F2RGxE?=
 =?utf-8?B?cXhMTGRkQklxcElzZnQvbkpTTElLUlNsZlREWjZndU1KUmp3L2x1NVlJNjlt?=
 =?utf-8?B?Nld4Mi9udk5UWGZJZm0vNitlRlBjUzVkZTZiZHFXWDRYQ0RQaWtqUmliYXVF?=
 =?utf-8?B?QjJZeTltNDVVWExRSmNKajdtQkJpSFBTVDJqTFNRRUU1Y01FRDhZc1Rua0VX?=
 =?utf-8?B?Yk5nbEUraVM2RGhJS0dwdktLcFZyZ3NoTHc5Z0RmZ2J5SEZMN0dhY3BENy92?=
 =?utf-8?B?UkFDdEs0SnZLZGVFL3hQZnBUV0tkNmdOOWRQM09CRFpadnNZM2dSTlZKSjJM?=
 =?utf-8?B?RHdSYzV6bmozR2pCQ2l2c2k5TnhSOFVoL1dIYUZhOFhpdlZNd3lrU21ud01V?=
 =?utf-8?B?WGRlcWVNVkJDWG5YQTFjNW8vRWQvRzVUSFJXU2VCSmFjeDRWOWZnYy8xMmdZ?=
 =?utf-8?B?ZzExNk5KWEZTRnNlMS9XajFEcG5yTHdrNmxTZ0IxTW15Ym8xTk1YU0tjR1V3?=
 =?utf-8?B?S1ZaMHJvOHZBQ1M5MXovVDFMNEV5MFVJN0ZYVm42QzZ2TkdKQmJIc1Zrdisr?=
 =?utf-8?B?d1F5Q0haYVIzZzF0RUREN3dJM2dmc1VCeTh4RFdsUVM2TVluMDFJa2FjWFRH?=
 =?utf-8?B?T1pNUzBISGpHUzJTSlV4c1o1eUlPQk4vN0ZTMGpnNUxrUTl6R3VUb2NZS0Fw?=
 =?utf-8?B?VFBFTkNJYnU4aC9yb3E2cytvUldNdUF3YlprNXJzOHBjUmIvMGtjcGNhL3dY?=
 =?utf-8?B?VzcrWEpNOTdSd2RuaWdtK3I5cng0ZHJyVTZYak81bEoxbVlIYkh1VjJBMTZm?=
 =?utf-8?B?alB2ZE05WlZZek9vam85cWgwM09FbVZNSWIyZ0R0Z2JxUTIrQ0VVWm1UN2Nu?=
 =?utf-8?B?M09xTnFkZUZtOVZuOWdCL2FIbHVaY0lnaFU5TjhqYkdieHpDSTRkYlNIMkZy?=
 =?utf-8?B?SHBma0Npc0N5TXBPQStrU29ITU1ObDc3MjFvRG9ER1VXNnZQdWZBbWV1ZEM3?=
 =?utf-8?B?TjdIN0dyRmFyYm1oS0hoNnhPelJNRVE0MXhsYXpCZXVONmNjWUtJcDJNaW12?=
 =?utf-8?B?d2hJYUFLdkFXdUZUazJJaVdTa2ExNmlKcWh5YXc1WmMvNk03Y0xEK0dhN3Z1?=
 =?utf-8?B?anc5R29KcE9KV09LWHJlVUZnNDc3NitHb1hmbWl1Q2FaNXZMZzVGQjNVM3JQ?=
 =?utf-8?B?Q2p4SUJUWE9FMTFXb0tPL0FYMk9yUDdYbUFtcnhMUnlRZVVuMGlvQmpCanQr?=
 =?utf-8?B?WEhRYkc4Y2IwemExNHRHZVpHcmkxbEZnbnUwTHIxU0R6WlFDMUd0MmwwRTl1?=
 =?utf-8?B?Mzg3NWFiS3VlSWc2c0kyNVIvcGc0bHZzVlVYMVlZODgzVmV5bXJxVU4ybTgz?=
 =?utf-8?B?WW5zaVZjSkMyODZxNHc0N1RZRmFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87F9987AFB5F5740A9ED85F769D57B6C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c9e4c6-f330-4dfa-d851-08d9f20dc221
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 12:05:15.4036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3Fm9Os9+89Z4V/8vxIAM0kC3rqd/wZ1VnyhHcmnPHuaaUxmEsUgmJgL6XM8M+9tfWSYcdVdXBiMjwLP8xfjudpkSdM7nkdyPiwTjG01ZBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCk9uIDE1LjAyLjIwMjIgMTk6MjMsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6
DQo+IE9uIDE1LzAyLzIwMjIgMTU6NDYsIFNlcmdpdSBNb2dhIHdyb3RlOg0KPj4gQ29udmVydCBS
VEMgYmluZGluZyBmb3IgQXRtZWwvTWljcm9jaGlwIFNvQ3MgdG8gRGV2aWNlIFRyZWUgU2NoZW1h
DQo+PiBmb3JtYXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5t
b2dhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgLi4uL2JpbmRpbmdzL3J0Yy9hdG1lbCxh
dDkxc2FtOS1ydGMudHh0ICAgICAgIHwgMjUgLS0tLS0tLS0NCj4+ICAgLi4uL2JpbmRpbmdzL3J0
Yy9hdG1lbCxhdDkxc2FtOS1ydGMueWFtbCAgICAgIHwgNjEgKysrKysrKysrKysrKysrKysrKw0K
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0K
Pj4gICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3J0Yy9hdG1lbCxhdDkxc2FtOS1ydGMudHh0DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2F0bWVsLGF0OTFzYW05LXJ0Yy55YW1s
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9y
dGMvYXRtZWwsYXQ5MXNhbTktcnRjLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnR4dA0KPj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAw
NjQ0DQo+PiBpbmRleCAzZjBlMmE1OTUwZWIuLjAwMDAwMDAwMDAwMA0KPj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hdG1lbCxhdDkxc2FtOS1ydGMudHh0DQo+
PiArKysgL2Rldi9udWxsDQo+PiBAQCAtMSwyNSArMCwwIEBADQo+PiAtQXRtZWwgQVQ5MVNBTTky
NjAgUmVhbCBUaW1lIFRpbWVyDQo+PiAtDQo+PiAtUmVxdWlyZWQgcHJvcGVydGllczoNCj4+IC0t
IGNvbXBhdGlibGU6IHNob3VsZCBiZSBvbmUgb2YgdGhlIGZvbGxvd2luZzoNCj4+IC0gICAgIC0g
ImF0bWVsLGF0OTFzYW05MjYwLXJ0dCINCj4+IC0gICAgIC0gIm1pY3JvY2hpcCxzYW05eDYwLXJ0
dCIsICJhdG1lbCxhdDkxc2FtOTI2MC1ydHQiDQo+PiAtLSByZWc6IHNob3VsZCBlbmNvZGUgdGhl
IG1lbW9yeSByZWdpb24gb2YgdGhlIFJUVCBjb250cm9sbGVyDQo+PiAtLSBpbnRlcnJ1cHRzOiBy
dHQgYWxhcm0vZXZlbnQgaW50ZXJydXB0DQo+PiAtLSBjbG9ja3M6IHNob3VsZCBjb250YWluIHRo
ZSAzMiBLSHogc2xvdyBjbGsgdGhhdCB3aWxsIGRyaXZlIHRoZSBSVFQgYmxvY2suDQo+PiAtLSBh
dG1lbCxydHQtcnRjLXRpbWUtcmVnOiBzaG91bGQgZW5jb2RlIHRoZSBHUEJSIHJlZ2lzdGVyIHVz
ZWQgdG8gc3RvcmUNCj4+IC0gICAgIHRoZSB0aW1lIGJhc2Ugd2hlbiB0aGUgUlRUIGlzIHVzZWQg
YXMgYW4gUlRDLg0KPj4gLSAgICAgVGhlIGZpcnN0IGNlbGwgc2hvdWxkIHBvaW50IHRvIHRoZSBH
UEJSIG5vZGUgYW5kIHRoZSBzZWNvbmQgb25lDQo+PiAtICAgICBlbmNvZGUgdGhlIG9mZnNldCB3
aXRoaW4gdGhlIEdQQlIgYmxvY2sgKG9yIGluIG90aGVyIHdvcmRzLCB0aGUNCj4+IC0gICAgIEdQ
QlIgcmVnaXN0ZXIgdXNlZCB0byBzdG9yZSB0aGUgdGltZSBiYXNlKS4NCj4+IC0NCj4+IC0NCj4+
IC1FeGFtcGxlOg0KPj4gLQ0KPj4gLXJ0dEBmZmZmZmQyMCB7DQo+PiAtICAgICBjb21wYXRpYmxl
ID0gImF0bWVsLGF0OTFzYW05MjYwLXJ0dCI7DQo+PiAtICAgICByZWcgPSA8MHhmZmZmZmQyMCAw
eDEwPjsNCj4+IC0gICAgIGludGVycnVwdHMgPSA8MSA0IDc+Ow0KPj4gLSAgICAgY2xvY2tzID0g
PCZjbGszMms+Ow0KPj4gLSAgICAgYXRtZWwscnR0LXJ0Yy10aW1lLXJlZyA9IDwmZ3BiciAweDA+
Ow0KPj4gLX07DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3J0Yy9hdG1lbCxhdDkxc2FtOS1ydGMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmM3OGE4YzFjOTMxNA0KPj4gLS0tIC9kZXYv
bnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hdG1l
bCxhdDkxc2FtOS1ydGMueWFtbA0KPj4gQEAgLTAsMCArMSw2MSBAQA0KPj4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyMgQ29w
eXJpZ2h0IChDKSAyMDIyIE1pY3JvY2hpcCBUZWNobm9sb2d5LCBJbmMuIGFuZCBpdHMgc3Vic2lk
aWFyaWVzDQo+PiArJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvc2NoZW1hcy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnlhbWwjDQo+PiArJHNjaGVtYTog
aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiAr
dGl0bGU6IEF0bWVsIEFUOTEgUlRUIERldmljZSBUcmVlIEJpbmRpbmdzDQo+PiArDQo+PiArYWxs
T2Y6DQo+PiArICAtICRyZWY6ICJydGMueWFtbCMiDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+
PiArICAtIEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4N
Cj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgb25lT2Y6
DQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05
MjYwLXJ0dA0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAtIGNvbnN0OiBtaWNyb2No
aXAsc2FtOXg2MC1ydHQNCj4+ICsgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05MjYwLXJ0
dA0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50
ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGNsb2NrczoNCj4+ICsg
ICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGF0bWVsLHJ0dC1ydGMtdGltZS1yZWc6DQo+PiAr
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMi1hcnJheQ0K
Pj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPj4gKyAgICAgIFNob3VsZCBlbmNvZGUgdGhlIEdQQlIg
cmVnaXN0ZXIgdXNlZCB0byBzdG9yZSB0aGUgdGltZSBiYXNlIHdoZW4gdGhlDQo+PiArICAgICAg
UlRUIGlzIHVzZWQgYXMgYW4gUlRDLiBUaGUgZmlyc3QgY2VsbCBzaG91bGQgcG9pbnQgdG8gdGhl
IEdQQlIgbm9kZQ0KPj4gKyAgICAgIGFuZCB0aGUgc2Vjb25kIG9uZSBlbmNvZGVzIHRoZSBvZmZz
ZXQgd2l0aGluIHRoZSBHUEJSIGJsb2NrIChvciBpbg0KPj4gKyAgICAgIG90aGVyIHdvcmRzLCB0
aGUgR1BCUiByZWdpc3RlciB1c2VkIHRvIHN0b3JlIHRoZSB0aW1lIGJhc2UpLg0KPiBUaGUgZmly
c3QgY2VsbCBwb2ludHMgdG8gYSBwaGFuZGxlLCBzbyB0aGlzIGRvZXMgbm90IGxvb2sgbGlrZQ0K
PiB1aW50MzItYXJyYXkuIEkgdGhpbmsgdGhpcyBtYXRjaGVzIHNvbWV0aGluZyBsaWtlIHN5c2Nv
bi4gTG9vayBmb3INCj4gZXhhbXBsZSBhdCBzYW1zdW5nLHN5c3JlZzoNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9zYW1zdW5nL2V4eW5vcy11c2kueWFtbA0KPg0KVGhh
bmsgeW91LiBJIHdpbGwgY29ycmVjdCB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBh
dGNoLg0KDQo+PiArICAgIGl0ZW1zOg0KPj4gKyAgICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiAr
cmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+PiArICAtIGludGVy
cnVwdHMNCj4+ICsgIC0gY2xvY2tzDQo+PiArICAtIGF0bWVsLHJ0dC1ydGMtdGltZS1yZWcNCj4+
ICsNCj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4+ICsNCj4+ICtleGFtcGxlczoN
Cj4+ICsgIC0gfA0KPj4gKyAgICBydHRAZmZmZmZkMjAgew0KPiBJcyBpdCBhIHRpbWVyIG9yIGEg
Y2xvY2s/IElmIG1vcmUgbGlrZSBhIFJUQywgdGhlbiB0aGUgbm9kZSBuYW1lIHNob3VsZA0KPiBi
ZSAicnRjIi4NCj4NCj4gcnRjLnlhbWwgcmVxdWlyZXMgdGhpcywgc28gaXQgbG9va3MgbGlrZSB5
b3UgZGlkIG5vdCB0ZXN0IHRoZSBiaW5kaW5ncw0KPiBhdCBhbGw/DQo+DQpNeSBhcG9sb2dpZXMs
IGl0IHNlZW1zIHRoYXQsIGJ5IG1pc3Rha2UsIEkgdXNlZCB0aGUgd3JvbmcgZmlsZSBmb3IgRFRf
U0NIRU1BX0ZJTEVTIHdoZW4gdGVzdGluZyBhbmQgdGh1cyBJIGRpZCBub3Qgc2VlIGFueSB3YXJu
aW5ncyBvciBlcnJvcnMuIEkgd2lsbCBjb3JyZWN0IHRoaXMgaW4gdGhlIG5leHQgcGF0Y2guDQpJ
biBvcmRlciBmb3IgdGhpcyB0byB3b3JrIGNvcnJlY3RseSwgdGhlIG5leHQgcGF0Y2ggc2VyaWVz
IHdpbGwgYWxzbyBpbmNsdWRlIHNvbWUgY2hhbmdlcyB0byBvdGhlciAiZHRzaSIgZmlsZXMgKHN1
Y2ggYXMgImFyY2gvYXJtL2Jvb3QvZHRzL3NhbWE3ZzUuZHRzaSIgYW5kICJhcmNoL2FybS9ib290
L2R0cy9zYW05eDYwLmR0c2kiKSB0aGF0IHVzZSAicnR0IiBpbnN0ZWFkIG9mICJydGMiIGZvciB0
aGVpciBub2RlIG5hbWVzLg0KDQo+PiArICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFz
YW05MjYwLXJ0dCI7DQo+PiArICAgICAgICByZWcgPSA8MHhmZmZmZmQyMCAweDEwPjsNCj4+ICsg
ICAgICAgIGludGVycnVwdHMgPSA8MSA0IDc+Ow0KPj4gKyAgICAgICAgY2xvY2tzID0gPCZjbGsz
Mms+Ow0KPj4gKyAgICAgICAgYXRtZWwscnR0LXJ0Yy10aW1lLXJlZyA9IDwmZ3BiciAweDA+Ow0K
Pj4gKyAgICB9Ow0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQoNClRoYW5rIHlv
dSBmb3IgdGhlIGZlZWRiYWNrLg0KDQpTZXJnaXUNCg0K
