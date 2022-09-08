Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4228C5B2522
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiIHRt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiIHRtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:49:24 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D87BF44
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:49:18 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2042.outbound.protection.outlook.com [104.47.22.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-44-MKN8-T89NI2exZx_EhRJbg-1; Thu, 08 Sep 2022 19:49:15 +0200
X-MC-Unique: MKN8-T89NI2exZx_EhRJbg-1
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::14)
 by GVAP278MB0006.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:21::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 17:49:14 +0000
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ec07:64ae:a4df:d320]) by ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ec07:64ae:a4df:d320%5]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 17:49:14 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "niklas.soderlund@corigine.com" <niklas.soderlund@corigine.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "apw@canonical.com" <apw@canonical.com>
CC:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "louis.peens@corigine.com" <louis.peens@corigine.com>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "oss-drivers@corigine.com" <oss-drivers@corigine.com>
Subject: Re: [PATCH v4] checkpatch: warn for non-standard fixes tag style
Thread-Topic: [PATCH v4] checkpatch: warn for non-standard fixes tag style
Thread-Index: AQHYw6J36XbPp0cJM0ex5Lib68XRDK3Vz1eA
Date:   Thu, 8 Sep 2022 17:49:14 +0000
Message-ID: <3275d886491dc934e3277cde9cc766b0ce0886ea.camel@toradex.com>
References: <20220908164434.122106-1-niklas.soderlund@corigine.com>
In-Reply-To: <20220908164434.122106-1-niklas.soderlund@corigine.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0377:EE_|GVAP278MB0006:EE_
x-ms-office365-filtering-correlation-id: 688279da-67c3-4bd0-6383-08da91c271aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: j8COMWrqqoLDsLUzZLtoZ2U7FmTky00LbgV2S2oUzUgQ2Vp7fjYT4HnC2rYbW/Gsug+7zgXVqjdhEVsQVnFKhnNNNfAObT3UE2ewmQzobNpWoQmy3gaK4v2BygVWtr28ylkg/esMlExs4eHsXl8tjUp6yHxg8QtGKq8yxlkqnwp52PFQhUl2EAdUiow+3RXb1gxls6Yc08farU3gWfc+0TnGbDQAHQ9anY9DAK7yflEh2twHyl0RI11ZabYzZ+mpFki3VoVRqqsDaz0byo3uSMz8WdawT4Y1GSsmZiMwXQuP7XC5k4J0uZuY3dc/1TIErWfnZONciohLuq/wP/ZNUNrBpB7CBxtBsyTvuPjvzYyBuhnsQMH7KfLU/rQ2L2gBz3KEDcB+yFSCO+jDPfsDnG+WJE9hDvfDSWFyhynLfEJeoOp6lKx2LDC5faxTGZJDM0JSc9Bl9WiOVr7Hx7Ken7GiYgcBj16nX0aT9+2jG23MmzfYZNf/8/eY0WAPW35G/DUaglwWybxhcghhEKJFWsqIMuTucag/eCrewEa9Xt68ujSgUZy42P0MVbLKJdAjSgxtTqON7D9ujAJBrHslHnK949fysDTrgRivjgw+1T2+6I9rYjqiWO8kcA2aqGIpA42+tZFALXdAjs7HeHK1dg9K8PLcJf+yfD2sdUmpjRGt+4+hugaaU5YAaj0sHJHW+GAWu9KbV5QzhnSa4cQKXp37O+VjfOmYZ+wxxqMPWOwAtfFa3SivY5N8lKJjlAE2Ff73ktJtPg9iEUhypC8OMv7QoRLtrvLux1uegm6kJ4U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(8936002)(2616005)(7416002)(186003)(5660300002)(44832011)(2906002)(6512007)(26005)(6506007)(66574015)(36756003)(86362001)(71200400001)(41300700001)(83380400001)(966005)(6486002)(478600001)(38100700002)(38070700005)(4326008)(8676002)(66446008)(66476007)(66556008)(66946007)(54906003)(76116006)(64756008)(110136005)(316002)(122000001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW5GbW9yOEVOcXFVUVJCc1VuRTg2VWV1KzhDUnhhMmlRelFNYXVHZVdOa3du?=
 =?utf-8?B?NHFTK0NSQjJOb1R1T3FEYWRVRWhqOTBvMGozZkt2TlNleTJpYThENlRISkV3?=
 =?utf-8?B?QW53WEJHTEZRakVTR0dUMXdJRHloaEhKMCtqUFJPZHFNRTUvRkgxblJYRXgw?=
 =?utf-8?B?eit1TDBZd2JuZnpuWEVRbFhZUmVHT3QrUGdTN0JVZlFma3ZwTkVPS0FCM21w?=
 =?utf-8?B?NDNNa0FSYytJREEyKzJGSVFzRm9FK1IwZTFpcFVHMm5tK0RGOG5mUDNPRUxZ?=
 =?utf-8?B?NnV1d2NGTG0xVUlqU1NSVkVQdFBWR2hhOXFRdDJMMkpLak55UVRKVFhQa2d2?=
 =?utf-8?B?WnBFUE5tdTBwMDVXdkUwaTFBL2JDV2RmckNwb1RBUjF2MHJjTWdvYm5CRjNl?=
 =?utf-8?B?d0JCTWkzanVvUDRuWGxaOGFkd3NxUEcrcU5nRmhkYVo3dTdFNEQyU0tJakxK?=
 =?utf-8?B?NzJsSjdSTzB3d2JueGk5RE0zemFqbTdRa0QwZEpIbHQ2V01xblRkV3FPTklo?=
 =?utf-8?B?eFVlTnZXRSt6NG1Jb2hmWGFwZ0RvVnZmYndzdTZaUmJMZy9aTmpSVUYrZkQ0?=
 =?utf-8?B?ME1weEF6dDFITlBnUElnbFpvUjhDRE5Jbm11cnhYRUZvbUtvL3N3c2NXK2E0?=
 =?utf-8?B?Z1dEVXZUYW4vemIrOXF3aWRmS25JN05FTy9GdUpuc0NCZk50MGE3TDVtSGZm?=
 =?utf-8?B?emwzd0g3MjdVeURKVVIydS9BWG56VDhNb1IzRGxoN0NpakFnTUFMZjM0QXdC?=
 =?utf-8?B?QVZKbmgyMlUxRCtTSUNBdVhyY01qUW8vVUlGVVl2U0pOaVJTYVdoL2VsYnhr?=
 =?utf-8?B?Zzh4NkFHT1B3WU43YVRrOEhLRTdvdDROYWhWczE1VElXM3BOR1RPREl0VmxI?=
 =?utf-8?B?ZVlSVy96MklTNkhJcVpZSjcxYnRMZzRHQitkUnRIUjNzVGltSGxONWFJdlEr?=
 =?utf-8?B?eDNsVlJUVy9Ub0dqVzE4aFBKK2o3RDVIQktCdE5DaS93RzBteWJuc0tsalBu?=
 =?utf-8?B?eFBaRzhNOEllLzRBYzJFcXRjM2hKMjc0WThYRmNUN3RPVjAraGNaWlpDNGVu?=
 =?utf-8?B?bU9BeWllV3JIYVZ3N2YvNG9INEV5T1NQS2VkTnRkS3VZVU5WYjhCcjVzNUNF?=
 =?utf-8?B?cGVtSSsyVDh2VCtTMHNGcUZMejM2dGNuZ0tIdTNWOFB5Y3ppMzExMENvN1JJ?=
 =?utf-8?B?RUlMajVMaFlQaGZ2V1FzbFI2aHpQbklHcGhtTEZQOVB1clJPME1kUkg2VTVs?=
 =?utf-8?B?bXkzUHdhSEdHMkt0UmM1cjNrSXU1bVhESEMyZU53cFFYOFhtbGtld2FFWE82?=
 =?utf-8?B?MWpRUXNCYzMrcUs5c3pyam4rdGJ6WFprZnlqS0xTQ1ZzaFN3VlJqSitPbXZN?=
 =?utf-8?B?bGV0Ujh0MWRTaDN4RWtaV1dFSTBEaFBkRW9mQ0JuRE4yY0dtNE1HZlpDYWxU?=
 =?utf-8?B?ZWxlZkFwTVFPOWRNcmtGdHJiWlIva0xXcTVaUUMxbTFTWjNTazlZUFN2aitW?=
 =?utf-8?B?ZGtIVzR2bHE0SW5iZWdEeTE2ZzJwd3ZXU0h6Q2x1Rk43YWoyVVZuVTdVaFc3?=
 =?utf-8?B?QWFsZ3dpcWRYKzB6enFTcHNZWkpPajkxT2dSYlprL2VXK3R6djFHTm45T08y?=
 =?utf-8?B?VGpaakVWRDJwRGUwR21QUXQrSjJ2cWxGWHlPcEdLSnVpajJJaUxHU3Q4Tmhh?=
 =?utf-8?B?OXYrTGNVNmtjRmkrRDBPRDZUOS9RdElEMkJXWTVmNzBneEhoWlVWWjFPNkk4?=
 =?utf-8?B?SU1qTW5PZ2gycjFNNTk0Mzk4L2trV1NBUEh4bGRSU2pOMW5HMkRBRGhVY0xK?=
 =?utf-8?B?VFMyRmRWbE1PZTFXaTdjaklHL0ZGZXpmeVZRK0Y2TFllenE0c0FyNWg4MjdY?=
 =?utf-8?B?TzNRNHRBYlROV3RBZTRHb2JNRlU2eFBnSjVLS092bXh2dEpsbE50QUJGdXcx?=
 =?utf-8?B?VXZqckNQZTZud2hKZG8wWnNYMENNVXZCZTV5eng2NGVrSk5jSkdnVmZ2Q1JY?=
 =?utf-8?B?aGJ3MjRMQlVBRTcvY1V4VXFiZTJHaHEvWXQ4M3QwbjVMTWdYcDVoN2E1bUl0?=
 =?utf-8?B?a0dnMitUcXpMN3VadGVPUndoK3F5ZmFRZzFTbFZQalE2QUNlQVUxaU1FVzZV?=
 =?utf-8?B?YTdYaHpkb1VaY0RLRnd6SGRlQzdxcFI3YlgzRS9aNWJKQ0dkclZjUTFvVm9q?=
 =?utf-8?Q?dhKxUEt2R12c2j6cucqtT9c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 688279da-67c3-4bd0-6383-08da91c271aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 17:49:14.2865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfUgvx64Pfg4FBF73mU/r//Ew+KKbxEUcTgyz8mBQa/FVZDqPn85bzqOOqH2KUB8x2E5LwnYhXxwwahVh7G3pe2iJsdEGB6e19XDkjMV9T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0006
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <90E0C9ACBBF20445995BBFD4DBFAB11F@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmlrbGFzLCAKClRoYW5rcyBmb3IgYWRkaW5nIG1lIHRvIGNjLiBJIHdpbGwgYWxzbyBhZGQg
U3RlcGhlbiwgYXMgaGUgYWxzbyBzZW50CnNvbWUgY29tbWVudHMgb24gbXkgc3VibWlzc2lvbiB0
aGUgZXhhY3Qgc2FtZSBwcm9ibGVtLiBJJ20gc3VwcG9ydGl2ZSBvZgp5b3VyIGNvZGUgYXMgaXQg
aGFzIHRoZSBuaWNlIGFkdmFudGFnZSBvZiBzdWdnZXN0aW5nIHRoZSByaWdodCBmb3JtYXQgb2YK
dGhlIHRhZyBpZiBpdCBtaWdodCBiZSB3cm9uZy4gSG93ZXZlciBpdCBzZWVtcyBsb3Qgb2Ygc3R1
ZmYgaXMgc2xpZ2h0bHkKZHVwbGljYXRlZCBhbmQgbG90cyBvZiBsaW5lcyBjb3VsZCBiZSBsZWZ0
IGF3YXkgc2ltcGxpZnlpbmcgaXQgZ3JlYXRseS4KSSBkb24ndCB3YW50IHRvIGhvbGQgYW55dGhp
bmcgdXAgYW55d2F5IHNvIEknbSBmaW5lIHdpdGggaXQsIGJ1dCB3aWxsCnN0aWxsbGVhdmUgc29t
ZSBjb21tZW50cyBvZiB0aGluZ3MgSSB0aGluayBzaG91bGQgYmUgaW1wcm92ZWQuCgpQbGVhc2Ug
c2VlIG15IGNvbW1lbnRzIGlubGluZS4KCgpPbiBUaHUsIDIwMjItMDktMDggYXQgMTg6NDQgKzAy
MDAsIE5pa2xhcyBTw7ZkZXJsdW5kIHdyb3RlOgo+IEFkZCBhIHdhcm5pbmcgZm9yIGZpeGVzIHRh
Z3MgdGhhdCBkb2VzIG5vdCBmYWxsIGluIGxpbmUgd2l0aCB0aGUKPiBzdGFuZGFyZHMgc3BlY2lm
aWVkIGJ5IHRoZSBjb21tdW5pdHkuCj4gCj4gU2lnbmVkLW9mZi1ieTogTmlrbGFzIFPDtmRlcmx1
bmQgPG5pa2xhcy5zb2Rlcmx1bmRAY29yaWdpbmUuY29tPgo+IFJldmlld2VkLWJ5OiBTaW1vbiBI
b3JtYW4gPHNpbW9uLmhvcm1hbkBjb3JpZ2luZS5jb20+Cj4gUmV2aWV3ZWQtYnk6IExvdWlzIFBl
ZW5zIDxsb3Vpcy5wZWVuc0Bjb3JpZ2luZS5jb20+Cj4gLS0tCj4gKiBDaGFuZ2VzIHNpbmNlIHYz
Cj4gLSBBZGQgdGVzdCB0aGF0IHRpdGxlIGluIHRhZyBtYXRjaCB0aXRsZSBvZiBjb21taXQgcmVm
ZXJlbmNlZCBieSBzaGExLgo+IAo+ICogQ2hhbmdlcyBzaW5jZSB2Mgo+IC0gQ2hhbmdlIHRoZSBw
YXR0ZXJuIHRvIG1hdGNoIG9uICdmaXhlczo/JyB0byBjYXRjaCBtb3JlIG1hbGZvcm1lZAo+IMKg
IGZpeGVzIHRhZ3MuCj4gCj4gKiBDaGFuZ2VzIHNpbmNlIHYxCj4gLSBVcGRhdGUgdGhlIGRvY3Vt
ZW50YXRpb24gd29yZGluZyBhbmQgYWRkIG1lbnRpb24gb25lIGNhdXNlIG9mIHRoZQo+IMKgIG1l
c3NhZ2UgY2FuIGJlIHRoYXQgZW1haWwgcHJvZ3JhbSBzcGxpdHMgdGhlIHRhZyBvdmVyIG11bHRp
cGxlCj4gbGluZXMuCj4gLS0tCj4gwqBEb2N1bWVudGF0aW9uL2Rldi10b29scy9jaGVja3BhdGNo
LnJzdCB8wqAgOCArKysrKwo+IMKgc2NyaXB0cy9jaGVja3BhdGNoLnBswqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQxCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysKPiDC
oDIgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2Rldi10b29scy9jaGVja3BhdGNoLnJzdAo+IGIvRG9jdW1lbnRhdGlvbi9kZXYt
dG9vbHMvY2hlY2twYXRjaC5yc3QKPiBpbmRleCBiNTI0NTJiYzI5NjMuLjhjODQ1NmEzYmQxOCAx
MDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9jaGVja3BhdGNoLnJzdAo+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2NoZWNrcGF0Y2gucnN0Cj4gQEAgLTYxMiw2ICs2
MTIsMTQgQEAgQ29tbWl0IG1lc3NhZ2UKPiDCoAo+IMKgwqDCoMKgIFNlZToKPiBodHRwczovL3d3
dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5o
dG1sI2Rlc2NyaWJlLXlvdXItY2hhbmdlcwo+IMKgCj4gK8KgICoqQkFEX0ZJWEVTX1RBRyoqCj4g
K8KgwqDCoCBUaGUgRml4ZXM6IHRhZyBpcyBtYWxmb3JtZWQgb3IgZG9lcyBub3QgZmFsbCBpbiBs
aW5lIHdpdGggdGhlCj4gc3RhbmRhcmRzCj4gK8KgwqDCoCBzcGVjaWZpZWQgYnkgdGhlIGNvbW11
bml0eS4gVGhpcyBjYW4gb2NjdXIgaWYgdGhlIHRhZyBoYXZlIGJlZW4KPiBzcGxpdCBpbnRvCj4g
K8KgwqDCoCBtdWx0aXBsZSBsaW5lcyAoZS5nLiwgd2hlbiBwYXN0ZWQgaW4gZW1haWwgcHJvZ3Jh
bSB3aXRoIHdvcmQKPiB3cmFwcGluZwo+ICvCoMKgwqAgZW5hYmxlZCkuCj4gKwo+ICvCoMKgwqAg
U2VlOgo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3Vi
bWl0dGluZy1wYXRjaGVzLmh0bWwjZGVzY3JpYmUteW91ci1jaGFuZ2VzCj4gKwo+IMKgCj4gwqBD
b21wYXJpc29uIHN0eWxlCj4gwqAtLS0tLS0tLS0tLS0tLS0tCj4gZGlmZiAtLWdpdCBhL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCBiL3NjcmlwdHMvY2hlY2twYXRjaC5wbAo+IGluZGV4IDc5ZTc1OWFh
YzU0My4uYWM3YWUyZTRhMWQ4IDEwMDc1NQo+IC0tLSBhL3NjcmlwdHMvY2hlY2twYXRjaC5wbAo+
ICsrKyBiL3NjcmlwdHMvY2hlY2twYXRjaC5wbAo+IEBAIC0zMTQwLDYgKzMxNDAsNDcgQEAgc3Vi
IHByb2Nlc3Mgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoH0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+ICsjIENoZWNr
IEZpeGVzOiBzdHlsZXMgaXMgY29ycmVjdAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpZiAoISRpbl9oZWFkZXJfbGluZXMgJiYgJGxpbmUgPX4gL15maXhlczo/L2kpIHsKCkkgd291
bGQgY2hlY2sgYWxsIGxpbmVzIHRoYXQgc3RhcnQgd2l0aCBmaXhlcywgZXZlbiBpZiB0aGVyZSBp
cwp3aGl0ZXNwYWNlIGluIGZyb250IChhbmQgdGhlbiBmYWlsaW5nIGxhdGVyIG9uLi4uKQoKaWYg
KCEkaW5faGVhZGVyX2xpbmVzICYmICRsaW5lID1+IC9eXHMqZml4ZXM6Py9pKSB7CgoKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG15ICRvcmlnX2NvbW1p
dCA9ICIiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
bXkgJGlkID0gIjAxMjM0NTY3ODlhYiI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBteSAkdGl0bGUgPSAiY29tbWl0IHRpdGxlIjsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG15ICR0YWdfY2FzZSA9IDE7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBteSAkdGFnX3Nw
YWNlID0gMTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG15ICRpZF9sZW5ndGggPSAxOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgbXkgJGlkX2Nhc2UgPSAxOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgbXkgJHRpdGxlX2hhc19xdW90ZXMgPSAwOwo+ICsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgkbGluZSA9fiAv
KGZpeGVzOj8pXHMrKFswLTlhLQo+IGZdezUsfSlccysoJGJhbGFuY2VkX3BhcmVucykvaSkgewoK
SWYgd2UgY2hlY2sgYWxzbyB0aGUgZml4ZXM6IGxpbmVzIHRoYXQgYmVnaW4gd2l0aCB3aGl0ZXNw
YWNlIHRoaXMgd291bGQKYmUgYSBnb29kIHNwYWNlIHRvIGNoZWNrIHRoYXQgd2UgZG8gbm90IHdh
bnQgYW55IHdoaXRlc3BhY2UgaW4gZnJvbnQgb2YKRml4ZXM6IHRhZy4KCi8oXHMqZml4ZXM6Pylc
cysoWzAtOWEtZl17NSx9KVxzKygkYmFsYW5jZWRfcGFyZW5zKS9pKSB7Cgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG15ICR0
YWcgPSAkMTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAkb3JpZ19jb21taXQgPSAkMjsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAkdGl0bGUgPSAkMzsK
PiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgJHRhZ19jYXNlID0gMCBpZiAkdGFnIGVxICJGaXhlczoiOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCR0
YWdfc3BhY2UgPSAwIGlmICgkbGluZSA9fiAvXmZpeGVzOj8KPiBbMC05YS1mXXs1LH0gKCRiYWxh
bmNlZF9wYXJlbnMpL2kpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAkaWRfbGVuZ3RoID0gMCBpZiAoJG9yaWdfY29t
bWl0ID1+Cj4gL15bMC05YS1mXXsxMn0kL2kpOwoKSSBzdWdnZXN0IHdlIGJvcnJvdyB0aGUgcGF0
dGVyIHRoYXQgaXMgYWxzbyB1c2VkIGluICJDaGVjayBmb3IgZ2l0IGlkCmNvbW1pdCBsZW5ndGgg
YW5kIGltcHJvcGVybHkgZm9ybWVkIGNvbW1pdCBkZXNjcmlwdGlvbnMiLiBUaGlzIGhhcyB0aGUK
cmVhc29uIGFzIGNoZWNraW5nIHN0cmljdGx5IGZvciAxMiBjaGFycyBpcyBhdCB0aGUgbW9tZW50
IHJpZ2h0IGJ1dCBhcwpsaW51eCBncm93cyAxMyBjaGFycyB3aWxsIGV2ZW50dWFsbHkgY29tZS4K
CiRpZF9sZW5ndGggPSAwIGlmICgkb3JpZ19jb21taXQgPX4gL15bMC05YS1mXXsxMiw0MH0kL2kp
OwogCgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCRpZF9jYXNlID0gMCBpZiAoJG9yaWdfY29tbWl0ICF+IC9bQS0KPiBGXS8p
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAjIEFsd2F5cyBzdHJpcCBsZWFkaW5nL3RyYWlsaW5nIHBhcmVucwo+IHRo
ZW4gZG91YmxlIHF1b3RlcyBpZiBleGlzdGluZwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCR0aXRsZSA9IHN1YnN0cigkdGl0
bGUsIDEsIC0xKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoJHRpdGxlID1+IC9eIi4qIiQvKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCR0aXRsZSA9IHN1YnN0cigkdGl0bGUsIDEsIC0KPiAxKTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgJHRpdGxlX2hhc19xdW90ZXMgPSAxOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBteSAoJGNpZCwgJGN0aXRsZSkg
PQo+IGdpdF9jb21taXRfaW5mbygkb3JpZ19jb21taXQsICRpZCwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAkdGl0bGUpOwo+
ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgk
Y3RpdGxlIG5lICR0aXRsZSB8fCAkdGFnX2Nhc2UgfHwKPiAkdGFnX3NwYWNlIHx8Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJGlkX2xlbmd0
aCB8fCAkaWRfY2FzZSB8fAo+ICEkdGl0bGVfaGFzX3F1b3Rlcykgewo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFdBUk4oIkJB
RF9GSVhFU19UQUciLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJQbGVhc2UgdXNlIGNvcnJlY3QgRml4ZXM6
IHN0eWxlCj4gJ0ZpeGVzOiA8MTIgY2hhcnMgb2Ygc2hhMT4gKFwiPHRpdGxlIGxpbmU+XCIpJyAt
IGllOiAnRml4ZXM6ICRjaWQKPiAoXCIkY3RpdGxlXCIpJ1xuIiAuICRoZXJlY3Vycik7Cj4gKwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gKwo+IMKgIyBDaGVjayBlbWFpbCBzdWJqZWN0
IGZvciBjb21tb24gdG9vbHMgdGhhdCBkb24ndCBuZWVkIHRvIGJlCj4gbWVudGlvbmVkCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoJGluX2hlYWRlcl9saW5lcyAmJgo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICRsaW5lID1+Cj4gL15TdWJqZWN0
Oi4qXGIoPzpjaGVja3BhdGNofHNwYXJzZXxzbWF0Y2gpXGJbXjpdL2kpIHsKCg==

