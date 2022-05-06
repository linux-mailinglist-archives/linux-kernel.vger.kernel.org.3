Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC1C51D1C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386739AbiEFHCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiEFHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:02:47 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120074.outbound.protection.outlook.com [40.107.12.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC1F326FF
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSYmZRmKiO6FTJNxmJqdMRihqdKFFs6GqRXvUCD5LQRBv+HVEcxpHSDqmtAmORZfePQ6yD9n04QSm3LIzO4h2OZYdlOs7fXMXHE6oUJ0m9ee+YN8NaR0X8YdyVo4t+xdi4IOhvJBkGsMqc/RfTsyx4bz9bCtW7YYs724iAkqee6qTg2lYLM1wsEL1IRN49S/TyhhYyAfts4KWmX69F+pbaY+Rnd0A8o9m/NfPPkM9SArchK3B173wVMkpq2z9xDSRp3NZHI4shm2FuGCygIeUE+LOyMUUhjYepJuBSr7AXqX3DDfd2PneRzQaLlx+vFi6FL3YjxICKgTEYV1QI7m5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1nJUgI/SP6CyU1NPtgN1TElxQMc1M8nti+T5p7iMeQ=;
 b=ez45pd8q9MLapyxAnaMoK7Eo37wkqwloT155vgjUm47VKOizzbbBcUEdqVA2Fk3GMc0HMm7kUpXTym4m0qfINEH+1ENEQ/ARko30MQmwl8GwsS9Lhuc3RS6PrVgadpaQIYLaxJjijXyDNRswR+E2GIZOCceKmhr9ir6hUnVnbehIlFCmrqQ6U7WSX18pLSVsKXvELMRGwF/HcpptzjuNjHTzq6R2bZZIqEmJ9E+7zucojF/3WlklER215geQxUZ5kWliia5RL09I5977awKXKCmAT2sYcy/2IOk7wFUr1tLhUiyweAr4SHtbBIgnYnKO9omdoukw3bdEerpMV2niVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1623.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Fri, 6 May 2022 06:59:02 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ad4e:c157:e9ac:385d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ad4e:c157:e9ac:385d%6]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 06:59:02 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [linuxppc:next-test 75/91] arch/powerpc/kernel/prom_parse.c:10:6:
 warning: no previous prototype for 'of_parse_dma_window'
Thread-Topic: [linuxppc:next-test 75/91]
 arch/powerpc/kernel/prom_parse.c:10:6: warning: no previous prototype for
 'of_parse_dma_window'
Thread-Index: AQHYYPv07VffW+9xgE6xa+TrxMo06a0Ra4+A
Date:   Fri, 6 May 2022 06:59:02 +0000
Message-ID: <1e373bfc-44ec-0e3b-e667-0e56f1e91709@csgroup.eu>
References: <202205061138.zH9VucCL-lkp@intel.com>
In-Reply-To: <202205061138.zH9VucCL-lkp@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ffea9a8-2a8b-42d0-18a0-08da2f2de75c
x-ms-traffictypediagnostic: MRZP264MB1623:EE_
x-microsoft-antispam-prvs: <MRZP264MB1623F74986E3F13CE9BB2BD0EDC59@MRZP264MB1623.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LACn4LB5Bxa+hliyHJ+0W60qNmowVo13Bh2uY+ltbz3RfxPzwCV9ZJ70cp8fW+lB92zEhJVDrd4dlZjDYzKffdFeyCHHUX8K6guYpIEGeCdrdiqd9WYLlMXlfmizOrHDsLYJXuBMRiDoy6Dqna5pzDEFhGcE7AVQpSJYKLU8lHumZw3VvdhrFTogDnWwAstrI3ULGxKOn+HiaoChYBXvBQZTGhbITvuBl/KBauUfSDpdbcdxjA4TgSOBUNarh9jdkaCho7e4w0YsLlBUxrV/QF/5uyU+7L2Hrvz9v1cPepuGalRh5dR76ehNu91oZjcv0pxWq0i2P7ZCPD2hHXOCNZiDE1ldR+djgCCTBtoIxMiTQTLgEw+h01ENx6evva0CeqV/pqBh0jVq8etQtH8arhXhETPF6OqB361/fyFX1wiJhMHOf3txaG6iW+XdGpK9umm80Y2Rsv4RcP5b3HlfVlNzzyFW1spkbwzfwS6kU8WYBYMBMYb6oHh+ZujW6bG0w4JTmdXPwYiUHorxd7xSQM/cTUyJWxJqCTFarTzVGnXVSZPdfiLpRWR9j3KXrt8OwiFf8V27slCCZQv+0hrEpZNF5z9qDOyRtP0lMtUxuJLOCzl0dxVSB40F63XNc+MrNHEzV8SUO0wyKdBPQJeSgvMgUyXClaA73Tmfmr7beeedhHS27/srtMuLWX2VDxyDFoQs0R+H6sTaJtL+Hmldy+SFbt/5e7JHZF126FtA+AZYoiCQS23eXac2mw03wxPLRNIvWbcrPZzDmuPogUwJysfsDc1F2rRUSsXGCfz2ADT0GkPuAbbT1ZLU/4dGeMtNubFIr2X0x4s/mIu8pfW1eliBkzUH/7x+U23LgFA8DaLJ6SeDkIu8w15qpKFEI+iju46ZB4Nm7r72Uvu74+wWEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6486002)(966005)(5660300002)(38070700005)(38100700002)(2906002)(31686004)(316002)(83380400001)(8936002)(508600001)(36756003)(2616005)(31696002)(86362001)(71200400001)(6512007)(66574015)(186003)(26005)(54906003)(6916009)(122000001)(4326008)(66556008)(66476007)(66446008)(64756008)(66946007)(8676002)(76116006)(44832011)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2F6NlczWDVOblhodVhKdnBGdUtXTDZhbU5sZkRMOERoSUdnR2lKYVcrdkxS?=
 =?utf-8?B?ZUVQSjdueUVieVovazloZ3JxV0JxRTVPSm8zdUxTTEs1WHduOWZMWGFlL1Yx?=
 =?utf-8?B?ZWdTR0FKNlNTOVFMRVluMHRzVDVwL0JJeFBtODRuRzloOXF0aXlPMm5YYXB1?=
 =?utf-8?B?YWh1clNGYkkycktMRUt5cUtIbGI4cm5DbENIM2d2cDMveW1JY3FRcmRzdE9m?=
 =?utf-8?B?ZmNPdzR5eCtpK2hsbFp2YTVCL2lLN1UyYm5hckpLN3o1WWNjTGd5dEtVeWRm?=
 =?utf-8?B?RlNVcUlja2Z2OUNxVDFmM09ua3lRTGVMRzdTZmoyZlVLUkVuMWNhemRwb2pP?=
 =?utf-8?B?YUhESkhCZW9rYXR4ajg0ZlBra1BkV3AvY3FHaG1xWi9NMzM0djlWY25PNmxH?=
 =?utf-8?B?UEtWcDQxNmhtU21xWmJGNk1CbElRQWtPUjZBVjhNZURPaUJncGlMWnhJd2ZX?=
 =?utf-8?B?R1d2T2ZlYzJSdGV6RkJhdXE2dGZzTThpZjU2MzNLeE5ENkdjbUZTL3VZRDF4?=
 =?utf-8?B?ODlEbzBlZEFzbGowL1VnMTZnU05nYlJzNTQzMm9DTW9DZTNlc2tmdllsZW5F?=
 =?utf-8?B?eXcvMnBPbGpSbTlDekdsb1BqMUh1T3JIOTBFVjV4eThJSGE0djk0Tk5Ea0Ny?=
 =?utf-8?B?QWREN29DY1pGUkFVY3VXNDNoQS9VUWZLODBBSUV0bk4wem8xeVQ0RmlGcDNu?=
 =?utf-8?B?SWdKLzJwZm1HUGJqL05jSnFHM3Yva09ObkNKdlBkVEZoajBQaitqdWpYa2Mr?=
 =?utf-8?B?ZXBBWXlyUFFyTnU0MjRBbjcrSmZJcnJOSjRLWEF6SW00MksvMm5qZW1HNGlr?=
 =?utf-8?B?eVFodGk0YXJmZ1lTczRaYWhqeHFhQWNrUWlDMVhOT256WTFlMVNqMHJaZktZ?=
 =?utf-8?B?SjNzVzNZNG9uTVd5KzZnNGZwYlRQSjF5bFk0VHBhZ3FRTGNZWXBhT3B6azdQ?=
 =?utf-8?B?cDQ5REdmZFNJYTllWm43N09rN1VWTUVKd0hadnVrM0lhOTFtZlRVV1NMNFNj?=
 =?utf-8?B?b1U5RXRKTmlGZmNKZi8vR2hEMUNDTlZlVVpLc0xTMWpFODFXK1YxQ2NzazNJ?=
 =?utf-8?B?Y0M4cUI2bVl3OVpXRm9jeitRWDYwcDVMQWVkNXVtWjRlMld1WGtjVVNzait3?=
 =?utf-8?B?MEhIZ29DZkxGWTZqd29tbmhoUXVzUVozVDd6cmgxUjlkaEYyb2ttWDlkRi8w?=
 =?utf-8?B?RVFCV3BMak80MTlXWVBNNTgvTlNMOFUzSjFQaDBnR2RUUkFaTkl0ME53ZURH?=
 =?utf-8?B?NXFHR0ZqQXpJVE9YOGMrSVZsSDh4bXQ2eXNtR3pGM0R4ZmNEQU15Q0xlQzI2?=
 =?utf-8?B?eVUvUjJHUGNxMmRDNU02SzlLMkVTRElQdnRFY0oxRzNVTGR5L3I5a1oyL2pw?=
 =?utf-8?B?NEVDMC81dlFGSUdMTTZDeWc1ZlB0dGZRUDk0M1dheWFOVnIzQ2hZYWhhNjAx?=
 =?utf-8?B?aXgvTVpGYzhJOGxyajJaOFlQdndhQTRkTkJXSUFFU1MreHROMm8vRy9ES3Mr?=
 =?utf-8?B?ZE1RdEI1NmFManhmZEJKa3NXWDdiM0Y5TXBmcWR0dlQrZDVFcFFGMkQxNjBl?=
 =?utf-8?B?VTJHVDBJd2dqQkQxeDlsQXE4dWYwdnhOTG9nN1pqaU9HcXdPYVdvYnZ1OUZs?=
 =?utf-8?B?K1c2YVo0SUN1ZFJ5ZlduUXRMb01ZZWdEdTEwYVpxRnViVFI2T2ZjMEVzc2FS?=
 =?utf-8?B?OEhZeGxnN0pVZmVKR3A4Y29FOWNRQy9xc09TV0d6VVFKWlhWWmNpOE5Jak5U?=
 =?utf-8?B?YThYWjk3bk9NczJkNmpjL1R1NDArdUc3ZUxCNkZQdXVna0dKYy96eDZCNkRq?=
 =?utf-8?B?WUFCZHFGdytySUIycWw2V0o4K3JoK25ycndTVlhWd0lrMXlLWlhpTmZPY2pm?=
 =?utf-8?B?eXFBd1gzbWI5R1hkQ3h4d3EyK29pSGJEYXBVQXJHQjFPaWVsN3R0enJMbVlo?=
 =?utf-8?B?UmtZeDJEYmZBb1FTOE1NZlhxd0tBT250UVlqbWVwc1Z3ME9HUkJzMjFCRTJB?=
 =?utf-8?B?aEk3eFB1ZTZFc3d4Z0FqQVV6LzVpZU5ydzM1NXFTMnJPSDFmRk1mNXNkUmdS?=
 =?utf-8?B?ZnhhQUlMekNvWXpFQUU3VmFWUC94OUlOSUg0OE84MmpncEdIWm1YM2dybGd5?=
 =?utf-8?B?Q29ZVVNvUk9TOXNSdVlVWlNDV0syNmJtOGc0SXJFQlFSUnJ6SnpMQ1E0T0xO?=
 =?utf-8?B?Q1B6UDA5eDIrdlFBaGZXN2RyWHhtTmVmSDEyS3IrR0tZclhpNDQzUDVoYSt5?=
 =?utf-8?B?RmVzV1BWN2s2WnA4TmliSC9UMENydUI5VEFtcFF1WkxXeGQrL2F6eGpIdjdJ?=
 =?utf-8?B?cXo4aUl4K3UzUW1HU2MyeHdwa2d1ZVlTS0dNTTd3K2krdjRwUkJRZW12RE91?=
 =?utf-8?Q?bnOj75hzrXC3uRxlK0Ge40Tugqv5DhCK890ro?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4085B1803B4BF74CBD8F03F654CAD808@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffea9a8-2a8b-42d0-18a0-08da2f2de75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 06:59:02.7640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UZOJan/3yaccm9H/lRVLlTvqsQG3sOorX9JjNFHobdzWkAJxchaPI6CYZVhDiTYPRufyr+W66X+9sReKJJKZCTQJs4KUQkDJBgLOrECQK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1623
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA2LzA1LzIwMjIgw6AgMDU6NDYsIGtlcm5lbCB0ZXN0IHJvYm90IGEgw6ljcml0wqA6
DQo+IHRyZWU6ICAgaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4cHBjL2xpbnV4IG5leHQtdGVzdA0K
PiBoZWFkOiAgIDFkOGFiZmZjMTRhZWY4OGJmZTFhZDAzNjA4NDA3MGFmNjJmMzBjMDMNCj4gY29t
bWl0OiAzNGZhNTJlZWMyMDZkYjM4Mzk5ZGM5YjU0ZjJkYTJlZWQ0ZmRhZDVlIFs3NS85MV0gcG93
ZXJwYzogUmVtb3ZlIGFzbS9wcm9tLmggZnJvbSBhbGwgZmlsZXMgdGhhdCBkb24ndCBuZWVkIGl0
DQo+IGNvbmZpZzogcG93ZXJwYy1hbGxtb2Rjb25maWcgKGh0dHBzOi8vZG93bmxvYWQuMDEub3Jn
LzBkYXktY2kvYXJjaGl2ZS8yMDIyMDUwNi8yMDIyMDUwNjExMzguekg5VnVjQ0wtbGtwQGludGVs
LmNvbS9jb25maWcpDQo+IGNvbXBpbGVyOiBwb3dlcnBjLWxpbnV4LWdjYyAoR0NDKSAxMS4zLjAN
Cj4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKToNCj4gICAgICAgICAgd2dldCBodHRw
czovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vaW50ZWwvbGtwLXRlc3RzL21hc3Rlci9zYmlu
L21ha2UuY3Jvc3MgLU8gfi9iaW4vbWFrZS5jcm9zcw0KPiAgICAgICAgICBjaG1vZCAreCB+L2Jp
bi9tYWtlLmNyb3NzDQo+ICAgICAgICAgICMgaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4cHBjL2xp
bnV4L2NvbW1pdC8zNGZhNTJlZWMyMDZkYjM4Mzk5ZGM5YjU0ZjJkYTJlZWQ0ZmRhZDVlDQo+ICAg
ICAgICAgIGdpdCByZW1vdGUgYWRkIGxpbnV4cHBjIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eHBw
Yy9saW51eA0KPiAgICAgICAgICBnaXQgZmV0Y2ggLS1uby10YWdzIGxpbnV4cHBjIG5leHQtdGVz
dA0KPiAgICAgICAgICBnaXQgY2hlY2tvdXQgMzRmYTUyZWVjMjA2ZGIzODM5OWRjOWI1NGYyZGEy
ZWVkNGZkYWQ1ZQ0KPiAgICAgICAgICAjIHNhdmUgdGhlIGNvbmZpZyBmaWxlDQo+ICAgICAgICAg
IG1rZGlyIGJ1aWxkX2RpciAmJiBjcCBjb25maWcgYnVpbGRfZGlyLy5jb25maWcNCj4gICAgICAg
ICAgQ09NUElMRVJfSU5TVEFMTF9QQVRIPSRIT01FLzBkYXkgQ09NUElMRVI9Z2NjLTExLjMuMCBt
YWtlLmNyb3NzIFc9MSBPPWJ1aWxkX2RpciBBUkNIPXBvd2VycGMgU0hFTEw9L2Jpbi9iYXNoIGFy
Y2gvcG93ZXJwYy9rZXJuZWwvDQo+IA0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFk
ZCBmb2xsb3dpbmcgdGFnIGFzIGFwcHJvcHJpYXRlDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVz
dCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+IEFsbCB3YXJuaW5ncyAobmV3IG9uZXMgcHJl
Zml4ZWQgYnkgPj4pOg0KPiANCj4+PiBhcmNoL3Bvd2VycGMva2VybmVsL3Byb21fcGFyc2UuYzox
MDo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yICdvZl9wYXJzZV9kbWFfd2lu
ZG93JyBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQo+ICAgICAgICAxMCB8IHZvaWQgb2ZfcGFyc2Vf
ZG1hX3dpbmRvdyhzdHJ1Y3QgZGV2aWNlX25vZGUgKmRuLCBjb25zdCBfX2JlMzIgKmRtYV93aW5k
b3csDQo+ICAgICAgICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fg0KPiANCj4gDQoNCk9r
LCBzbyBhc20vcHJvbS5oIG11c3QgcmVtYWluIGluIGFyY2gvcG93ZXJwYy9rZXJuZWwvcHJvbV9w
YXJzZS5jIHRvIGdldCANCm9mX3BhcnNlX2RtYV93aW5kb3coKSBwcm90b3R5cGUuDQoNCk1pY2hh
ZWwsIGNhbiB5b3UgZHJvcCB0aGUgaHVuayB3aGVuIGFwcGx5aW5nID8NCg0KVGhhbmtzDQpDaHJp
c3RvcGhl
