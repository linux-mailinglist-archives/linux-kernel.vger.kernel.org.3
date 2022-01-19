Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1F5493D64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355832AbiASPk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:40:59 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:51500 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348843AbiASPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642606848; x=1674142848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WpbquxOv2hKLFft1q9cVSl59bXBHEQ9QesFmOnN23mI=;
  b=zYj+i7QN096GvpLu4WJo2pyLAgMouLOVwb2HCYio0wiXPKU5RiHD520y
   RQWL3pAJnvbtbTiIeUxIpp84Mxp9ZI/snc1gaT5kjmaWuYLSQmf03DuYy
   CPej3LbGXoG3pVlgff2GtDHd46TXzRdtUSWLHwPa0HrVZAjTIu9sBqdpA
   rclS8JhjG78r9xWUwKk9dUBou3yWhUne6wVYVkJTwR6kYC6GVvC48S8vG
   xNXlwYhT+G/4BL7C9S1hLpoCyyUFg7fY7k27Jn2KHRtiPCpFQJ1AR+52W
   x5ipEZ88LPE3Geu+rTCo32SaOB5PkP5nt1HbKdelOubl/EN0G3+i7nOYJ
   w==;
IronPort-SDR: I8aFEN/6UYCU4CGRezvyyr2x7JeSsk5UNqwMjEeLUsoMHzXEO5hqcropkzGBOaSqCRY1HKfOK4
 8f+u11x8DzCd1ZIuLCz4ySC6eMy05sanEOW7n3VxDvaKoqM9kcd+Ti4+dIRU7sSB1sp1igLlku
 EjQa5sceKlvXNKSR9hnA0rJzCmfAMRfWCLcounB3DRneNfFAA7LZzxQBBiUPVO4szCEtWClqcK
 soQrd3b8sKKEOWwZ5Gkzx3KC3gM5s20Y2JixNM4I+57T+LVnEU0xSf/yFekJ4r9RGJDbPZOvwx
 08gqJc4kMfo0XM27e6s2HR8r
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="143210706"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jan 2022 08:40:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 19 Jan 2022 08:40:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 19 Jan 2022 08:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehn9/DvYxOKLHM9jFPs2o65kBZSvRr2Nr3MU1r53GFQmcxH0KD0rvEcQDG79LgfSnJyoGaldnE0ifsAlEMd/JdUkoUx/t9azDeJ7QyTWLkDnfFMrmA1OhGWPa8HPdtS2q2UCQASP56j7Qc4jgeqiZ0Tf0E3sFnH6vOh7amfK8i1bI8O9xWANR4DIdqeTssFwadmi7YglB6LdCbkCHoSVnjnWs3gm3cwNbRouFsbqzy1RfqEwZBtjXN015XxfyVR6Q9h65W7J0UagnuM8j+jwQhAcJveQvQpaB7SarwkH1ere/+pGgnq36wg/dj5YYRHh4a7LlHePN4k/ZD0dkterLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpbquxOv2hKLFft1q9cVSl59bXBHEQ9QesFmOnN23mI=;
 b=cdSgkvvdIrAFU9p5I7nLmCsFhZIQZhccw9Ypdi1ENO5U6yqlbRbEoUCEkzoUzNPV7Qi/7Mrax8vr/tZUs9Np8fWvN9KmFg/5KofRfCIcYe18nsYbgvK0bUfGcOqDfDwsXvEMlY7r6QiCQxqd8N8SLXfDyS/qFbVrA/uLY5URJXcZQs6DmpxrnLHxKXAc9qkft7Lv3epYm6pldWXydSwE8gJgYpnU+UBmv57AqIbP23k+d/TZ57f6QGXGIQMLpEBjVGHC5vEmZilu6Zb38zdRmLyI4wvaHm8ieugjPtElWoEbfk3tGxETh7UhrsGhpFb7WLgBSyxJL/Fi/g/OLMYyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpbquxOv2hKLFft1q9cVSl59bXBHEQ9QesFmOnN23mI=;
 b=gdFtDphH8vLTXomFWfYivCHR+jQJ5qhPju32DN3j9LO/EvRynzbTHf3XHCuX/nvfEz3MAoctMe7l56eo170RCLeIlvS8/Ej88RAY9wYAK9GTcRokmd5OxB0lAlWrpn8rlJsph5y7erYauSPSiiwieeyRPlZXNufUnmEXwX+vc5U=
Received: from PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22)
 by DM6PR11MB4673.namprd11.prod.outlook.com (2603:10b6:5:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 15:40:38 +0000
Received: from PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::d7c:834f:4591:3c0c]) by PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::d7c:834f:4591:3c0c%8]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 15:40:38 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jacopo@jmondi.org>
CC:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <laurent.pinchart@ideasonboard.com>, <sakari.ailus@iki.fi>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v3 17/23] media: atmel: atmel-isc-base: use mutex to lock
 awb workqueue from streaming
Thread-Topic: [PATCH v3 17/23] media: atmel: atmel-isc-base: use mutex to lock
 awb workqueue from streaming
Thread-Index: AQHX8CkFHNpo7YqX4EySeyV1oTOVzaxfRNeAgAtwpAA=
Date:   Wed, 19 Jan 2022 15:40:38 +0000
Message-ID: <f994c64d-b6cf-4302-d734-e422561db0b9@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-18-eugen.hristev@microchip.com>
 <20220112085835.twjhxjnigl3uhgqj@uno.localdomain>
In-Reply-To: <20220112085835.twjhxjnigl3uhgqj@uno.localdomain>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cae5c42-7971-4c9e-8bc2-08d9db620ad4
x-ms-traffictypediagnostic: DM6PR11MB4673:EE_
x-microsoft-antispam-prvs: <DM6PR11MB4673F662C78CADD07CC8443CE8599@DM6PR11MB4673.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uK3GSbzi/2AwbHogXqaWvzndoMQsU1wNJRIyJ5iWuid++cgkOaNCV2X2sGQXyfsGpIyKBYPIp4qmBSR1oc+w7HS6BLh8e8cnkXG1rJOQknH+v77q/xKvgeRij0BeBwSv6Z/TPkYHJbAJnH1s7n4Sj4KtGj9IF2GPiUPKuCuhBBPbXZHpz5YrnjCPmqI/Wo0mUYDzg0oadc7Bgr+l2twUdH1hUIWa6VnjDX6aCeKJfUhBiFLpyii1wRcF847wJ0Nk2XFdSYNFbjAYB6PpDjs5vsSeRn1YF5hLFVtBFp3TnEo5rFVKLmPgN+N3Tv33+NFvO9TrunEEoKkgVeJFgg4f278a+maomWixmVBbXet1bSxyd3ojCQmDSeQ6kZt5y6MYG7LsLLwYWFjoHAn9Xp1CNaW54bdRBSd8mmvP/4kXPToJjhvDdRrMjueCmE83EApm76mVJd9+FZpOKISSE5kVSHdzzi5d+nzBl0gVuzPTpPJE6wbi6/BnOtw4PohBu6k3EMcealgSZc9E7ExygTUPNINiGhtwh4aIN4IQxjC3aZns2VwbVUI+FGCfe9ZSdQbcSda+xhn+KplDEK8c9mTLgMJRdRa6A5n2r7t3B3FtiW2kldVyRa2KNmtonzBS/eA3WMhKFPDlsVHjkMOQfVkv7ApSpWThQJEsihQ0VA2MKxrhJDd6WJoudmo4dlCE1UX1uirM06F98AikvLkoSA8NfQlKRAKznKOqxGdTpa/bxmejiiXapJmJyclcrNUMKr91lmU5L2tomg4IgMY68cMuuXd6x0NQwrG9HNgC3Q+1/SRBCHlQa2+t/0z3ywVBfIaKa7msTXvK7UyglMDvNJqO/zYL+GL7BJfE5ybPqNP+Q4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(38100700002)(6512007)(122000001)(966005)(186003)(66946007)(31686004)(26005)(86362001)(36756003)(91956017)(76116006)(53546011)(6506007)(508600001)(31696002)(6916009)(316002)(5660300002)(66446008)(64756008)(66556008)(66476007)(83380400001)(6486002)(107886003)(2616005)(8676002)(54906003)(8936002)(4326008)(38070700005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2N3WHNWS3NOTWVCaWZsWFhHN2w5Zzc4WjV5empEMWtOYzNYWFBOVGJmV0tU?=
 =?utf-8?B?WGdHanM1RndIa2Ziajh0Q1YzbGNpNkZ3R2hGNkJtbk54VnFuRmFOQXhFbUNr?=
 =?utf-8?B?L2JhVTFWYXBOZndBaGU1ZTF2RUtUeEc3d0VmWTZjY3ltbjB1bjlvdG43ZEFs?=
 =?utf-8?B?S2JIaUJBVzAxOEphejJUblQ0eWhDNjVhenZRSUtOVU9HSzVOUm9FSTNDaDNn?=
 =?utf-8?B?RFRBMUxkMkFXY0FFdzZUdFplS1VSZ2s5bkI5cGJpL2VQOGUvNS96b29nUUdN?=
 =?utf-8?B?QlRWeDJZTHQxNUJzYnRrZjA2MlAySXVubGhiQStrZjdrSjBiODNjWHdZMVc5?=
 =?utf-8?B?WEM0TU5RK3hXdHU3Yyt6cVRFRHZyMjU1aVEzZkxKZDZET28vdDdDZGF4THdZ?=
 =?utf-8?B?UjN3T29nZGVtdmVxZS9OTzZ6TlQxUUlOb05WLzVNdGpXOW4ydVBORGJvejhS?=
 =?utf-8?B?OGlsbUdHNjRrRmV5emQ2NWJ4RjhDWWdnZ09HcER3SlRLMGowR0RqSnRzdmFW?=
 =?utf-8?B?b1pOOUdFT2xkY0pnT1FtVDEraVl3ZGFYVkVzSFJ0RzRhMWlYOTBIZTZiZU42?=
 =?utf-8?B?YnJhT2Jxc3B0b0NBcWZROGtxaHFQWG5vNmRXb1ExcStSOWhLdGtCVDJMcDBR?=
 =?utf-8?B?Z1VYRDlUVVQvUXp1WWQxRnBOSU1DNEFTQThBVlFialMvVzE4bUd0MkJzWlpV?=
 =?utf-8?B?N2lPd1k2eTU1cWt3bXhSay9Oa0R3UWpFRkFkTmoyTWVkNzduTnZPeDVKOHpT?=
 =?utf-8?B?SG9YT2JwOEpHNElkeWlKTnpGYXZnTE1yNXpOZlBPY2w3RjZpdi9FU1NKYWZM?=
 =?utf-8?B?MnBDb1dTQ05nUm0zcHlCVGswMjRFb2Q0c003d1hyQktGa09BZlJYZElHaCta?=
 =?utf-8?B?bW80OGR0YlVFOG5CZXdOTTJjaU94cDMzcDFoWndBdVcrOEo5cDdXVUZtZ014?=
 =?utf-8?B?dGVLdmNiT1k1dzlCd2hDelVyUFFiVzhJR1RUMkJuSWpLRGpyUmc5TWlPZ24x?=
 =?utf-8?B?eXdXSVVSZG13QnpBQmVFRlpUd0R6Qms1T0p4V0VOMHgrZ1I5UnBHREtobFZ3?=
 =?utf-8?B?bm0wdDg2NHpPMzRud1dBSkdYVnp0ZnJzU0tpOHU1UmRXaFZmekJ3Vkczc1JM?=
 =?utf-8?B?U1RTODd3TnBhaUllLzFvcGxDRWg2ajFYSEI5cUF6RmFaYWpoL0FJZEs2Vis1?=
 =?utf-8?B?a0g4UzU2WEt3K2p4Nk8zdHY2Z09pemlOSElxbkprY1hnVHpBNno4dFBickxX?=
 =?utf-8?B?UnVqRzh6MEZWOWJVcVNvMTJmWGQvSy9pbEJFMS9vb1JCRVlra2MvWGVUSW1s?=
 =?utf-8?B?NWhnNkE5cnZyOHhNNGR1V1JFWFZBdjc0ZHJEaHhCbko4eVVRV1FCYjhidzlM?=
 =?utf-8?B?ODk2NVV2M3lCRkZnSTBaOUllUjZLb0NoYzNmME5BZmlid1JHQ0pWTEtmK3Zq?=
 =?utf-8?B?eElMNSsxM25pOFNaZGtMRGs5aHJYT0lsT3k0ZEt1RUF5UkswNlZacUZ4QkxM?=
 =?utf-8?B?bTVLOTVvQXlGUlE3U1Z4alVIM0VDODQvaXB1OXIydnRjMHRGZXg2UU9MKzRk?=
 =?utf-8?B?R2ZDTUJXZWhaRVJOV2hlN0VpSGhDcktBVGRxQjQzc3Zkemt6V1JobFJ1MGtV?=
 =?utf-8?B?TFg4YnZNNjlJVE4xSFZVNUtweENqaFNDVU53T29QUHVBOXk1SnlhQVkvYTN3?=
 =?utf-8?B?cWcxS0VzUnRsVE1KZjV6RW5sSzRKOWYvN1NheHNtMnBBbW1FeG9USmVPa1NK?=
 =?utf-8?B?MTFtMmxibHFkZHB5R1R3WmlBYVQxRzh5azNSTk1vMEtEdit1aTdRZjlja3JT?=
 =?utf-8?B?SnVEZjZUMmdMaGhHYkpMWlFWSTBoNjlIa2VMZGtsTFU0Q1IzUEs4TmhPYWdh?=
 =?utf-8?B?TjM4b0sxbkdNdzFVRlByYjlCODcvNEpwaE1teUl5dWdsaFUxdm1UL05icTNv?=
 =?utf-8?B?cVVuQTF0TklsM0FXYjk5TW52UFVBZUJ2NE52YWF3U2ZYakRHTVFnZGlXUE52?=
 =?utf-8?B?N0ZVRCt6eDVQN0FTRmNsdStzL1ZCcEtZUEhzRmVFY0VxUmM3d09UcUFIQTRK?=
 =?utf-8?B?VXZobWtCcWszRy95d3MzZUF1U0pxUE9ORXVLU0tuNDMzcWxJeU5nOGZ1RTQ0?=
 =?utf-8?B?YWNHc3hxbzIweUxnQzNFN0dVV2p3M0dCOEYxRlF5S1ZVdUFWQmppUHNWSnNM?=
 =?utf-8?B?U2RFeEkyUjlKdnpMdXZaeVpNbEhJbUhzcmpwT1BxUlRsenhwVFQ3eWIyTmVC?=
 =?utf-8?B?bnRNT3Ryb2swNmhqQ2oyNXF5ZHNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BCD9C5A714FF94AB7323C0E29DBB0DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cae5c42-7971-4c9e-8bc2-08d9db620ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 15:40:38.3834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqRNs4Pp2QJqP5qEUVCok0jb1/f80PSDmx0ujYGZK/Jj5OtpESxIEkhswUTrvPS2hed5XzWQOxg07nnpUMehaZ6o60f7E3Md6NvJ31JbTg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4673
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xMi8yMiAxMDo1OCBBTSwgSmFjb3BvIE1vbmRpIHdyb3RlOg0KPiBIaSBFdWdlbg0KPiAN
Cj4gT24gTW9uLCBEZWMgMTMsIDIwMjEgYXQgMDM6NDk6MzRQTSArMDIwMCwgRXVnZW4gSHJpc3Rl
diB3cm90ZToNCj4+IFRoZSBBV0Igd29ya3F1ZXVlIHJ1bnMgaW4gYSBrZXJuZWwgdGhyZWFkIGFu
ZCBuZWVkcyB0byBiZSBzeW5jaHJvbml6ZWQNCj4+IHcuci50LiB0aGUgc3RyZWFtaW5nIHN0YXR1
cy4NCj4+IEl0IGlzIHBvc3NpYmxlIHRoYXQgc3RyZWFtaW5nIGlzIHN0b3BwZWQgd2hpbGUgdGhl
IEFXQiB3b3JrcSBpcyBydW5uaW5nLg0KPj4gSW4gdGhpcyBjYXNlIGl0IGlzIGxpa2VseSB0aGF0
IHRoZSBjaGVjayBmb3IgaXNjLT5zdG9wIGlzIGRvbmUgYXQgb25lIHBvaW50DQo+PiBpbiB0aW1l
LCBidXQgdGhlIEFXQiBjb21wdXRhdGlvbnMgYXJlIGRvbmUgbGF0ZXIsIGluY2x1ZGluZyBhIGNh
bGwgdG8NCj4+IGlzY191cGRhdGVfcHJvZmlsZSwgd2hpY2ggcmVxdWlyZXMgc3RyZWFtaW5nIHRv
IGJlIHN0YXJ0ZWQuDQo+PiBUaHVzICwgaXNjX3VwZGF0ZV9wcm9maWxlIHdpbGwgZmFpbCBpZiBk
dXJpbmcgdGhpcyBvcGVyYXRpb24gc2VxdWVuY2UgdGhlDQo+PiBzdHJlYW1pbmcgd2FzIHN0b3Bw
ZWQuDQo+PiBUbyBzb2x2ZSB0aGlzIGlzc3VlLCBhIG11dGV4IGlzIGFkZGVkLCB0aGF0IHdpbGwg
c2VyaWFsaXplIHRoZSBhd2Igd29yayBhbmQNCj4+IHN0cmVhbWluZyBzdG9wcGluZywgd2l0aCB0
aGUgbWVudGlvbiB0aGF0IGVpdGhlciBzdHJlYW1pbmcgaXMgc3RvcHBlZA0KPj4gY29tcGxldGVs
eSBpbmNsdWRpbmcgdGVybWluYXRpb24gb2YgdGhlIGxhc3QgZnJhbWUgaXMgZG9uZSwgYW5kIGFm
dGVyIHRoYXQNCj4+IHRoZSBBV0Igd29yayBjYW4gY2hlY2sgc3RyZWFtIHN0YXR1cyBhbmQgc3Rv
cDsgZWl0aGVyIGZpcnN0IEFXQiB3b3JrIGlzDQo+PiBjb21wbGV0ZWQgYW5kIGFmdGVyIHRoYXQg
dGhlIHN0cmVhbWluZyBjYW4gc3RvcCBjb3JyZWN0bHkuDQo+PiBUaGUgYXdiIHNwaW4gbG9jayBj
YW5ub3QgYmUgdXNlZCBzaW5jZSB0aGlzIHNwaW5sb2NrIGlzIHRha2VuIGluIHRoZSBzYW1lDQo+
PiBjb250ZXh0IGFuZCB1c2luZyBpdCBpbiB0aGUgc3RvcCBzdHJlYW1pbmcgd2lsbCByZXN1bHQg
aW4gYSByZWN1cnNpb24gQlVHLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0ZXYg
PGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1iYXNlLmMgfCAzMSArKysrKysrKysrKysrKysrLS0t
DQo+PiAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmggICAgICB8ICAx
ICsNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVs
LWlzYy1iYXNlLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1iYXNl
LmMNCj4+IGluZGV4IGIwYzNlZDIxZjM3Mi4uNTNjYWMxYWFjMGZkIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MtYmFzZS5jDQo+PiArKysgYi9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1iYXNlLmMNCj4+IEBAIC00MDEs
NiArNDAxLDcgQEAgc3RhdGljIHZvaWQgaXNjX3N0b3Bfc3RyZWFtaW5nKHN0cnVjdCB2YjJfcXVl
dWUgKnZxKQ0KPj4gICAgICAgIHN0cnVjdCBpc2NfYnVmZmVyICpidWY7DQo+PiAgICAgICAgaW50
IHJldDsNCj4+DQo+PiArICAgICBtdXRleF9sb2NrKCZpc2MtPmF3Yl9tdXRleCk7DQo+PiAgICAg
ICAgdjRsMl9jdHJsX2FjdGl2YXRlKGlzYy0+ZG9fd2JfY3RybCwgZmFsc2UpOw0KPj4NCj4+ICAg
ICAgICBpc2MtPnN0b3AgPSB0cnVlOw0KPj4gQEAgLTQxMCw2ICs0MTEsOCBAQCBzdGF0aWMgdm9p
ZCBpc2Nfc3RvcF9zdHJlYW1pbmcoc3RydWN0IHZiMl9xdWV1ZSAqdnEpDQo+PiAgICAgICAgICAg
ICAgICB2NGwyX2VycigmaXNjLT52NGwyX2RldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICJUaW1lb3V0IHdhaXRpbmcgZm9yIGVuZCBvZiB0aGUgY2FwdHVyZVxuIik7DQo+Pg0KPj4gKyAg
ICAgbXV0ZXhfdW5sb2NrKCZpc2MtPmF3Yl9tdXRleCk7DQo+PiArDQo+PiAgICAgICAgLyogRGlz
YWJsZSBETUEgaW50ZXJydXB0ICovDQo+PiAgICAgICAgcmVnbWFwX3dyaXRlKGlzYy0+cmVnbWFw
LCBJU0NfSU5URElTLCBJU0NfSU5UX0RET05FKTsNCj4+DQo+PiBAQCAtMTQxNiwxMCArMTQxOSw2
IEBAIHN0YXRpYyB2b2lkIGlzY19hd2Jfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncpDQo+PiAg
ICAgICAgdTMyIG1pbiwgbWF4Ow0KPj4gICAgICAgIGludCByZXQ7DQo+Pg0KPj4gLSAgICAgLyog
c3RyZWFtaW5nIGlzIG5vdCBhY3RpdmUgYW55bW9yZSAqLw0KPj4gLSAgICAgaWYgKGlzYy0+c3Rv
cCkNCj4+IC0gICAgICAgICAgICAgcmV0dXJuOw0KPj4gLQ0KPj4gICAgICAgIGlmIChjdHJscy0+
aGlzdF9zdGF0ICE9IEhJU1RfRU5BQkxFRCkNCj4+ICAgICAgICAgICAgICAgIHJldHVybjsNCj4+
DQo+PiBAQCAtMTQ3MCw3ICsxNDY5LDI0IEBAIHN0YXRpYyB2b2lkIGlzY19hd2Jfd29yayhzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKncpDQo+PiAgICAgICAgfQ0KPj4gICAgICAgIHJlZ21hcF93cml0ZShy
ZWdtYXAsIElTQ19ISVNfQ0ZHICsgaXNjLT5vZmZzZXRzLmhpcywNCj4+ICAgICAgICAgICAgICAg
ICAgICAgaGlzdF9pZCB8IGJheXNlbCB8IElTQ19ISVNfQ0ZHX1JBUik7DQo+IA0KPiBpc2Nfc3Rv
cF9zdHJlYW1pbmcoKSBjYWxscyBydW50aW1lX3B1dCBhbmQgaGVyZSB5b3UgYWNjZXNzIHRoZSBo
dy4NCg0KSGkgSmFjb3BvLA0KDQpUaGF0IGlzIGNvcnJlY3QuIEhvd2V2ZXIgdGhlIGF3YiByb3V0
aW5lIHdpbGwgY2FsbCByZXN1bWUgYW5kIGdldCBoZXJlIA0KKGJlZm9yZSBhY2Nlc3NpbmcgdGhl
IGhhcmR3YXJlKSA6DQoNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9z
b3VyY2UvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MtYmFzZS5jI0wxNzIy
DQoNClNvIEkgdGhpbmsgdGhhdCB3ZSBhcmUgZ29vZCBhcyB3ZSBhcmUgbm93DQoNCj4gDQo+IEZl
ZWxzIGxpa2UgaXQncyBzYWZlciB0byBob2xkIHRoZSBtdXRleCBmb3IgdGhlIHdob2xlIGR1cmF0
aW9uIG9mIHRoZQ0KPiBBV0Igcm91dGluZSA/DQo+IA0KDQpJIHByZWZlciB0byBoYXZlIHRoZSBj
cml0aWNhbCBzZWN0aW9uIGFzIGxpdHRsZSBhcyBwb3NzaWJsZS4gQXMgd2UgYXJlIA0Kb25seSBz
eW5jaHJvbml6aW5nIHRoZSAnc3RyZWFtaW5nIHN0YXR1cycgLCBvbmx5IHRoaXMgc2hvdWxkIGJl
IHVuZGVyIA0KdGhlIGxvY2suDQoNCklmIHlvdSBoYXZlIGEgZGlmZmVyZW50IG9waW5pb24sIGxl
dCBtZSBrbm93Lg0KDQpFdWdlbg0KDQo+PiArDQo+PiArICAgICAvKg0KPj4gKyAgICAgICogV2Ug
aGF2ZSB0byBtYWtlIHN1cmUgdGhlIHN0cmVhbWluZyBoYXMgbm90IHN0b3BwZWQgbWVhbndoaWxl
Lg0KPj4gKyAgICAgICogSVNDIHJlcXVpcmVzIGEgZnJhbWUgdG8gY2xvY2sgdGhlIGludGVybmFs
IHByb2ZpbGUgdXBkYXRlLg0KPj4gKyAgICAgICogVG8gYXZvaWQgaXNzdWVzLCBsb2NrIHRoZSBz
ZXF1ZW5jZSB3aXRoIGEgbXV0ZXgNCj4+ICsgICAgICAqLw0KPj4gKyAgICAgbXV0ZXhfbG9jaygm
aXNjLT5hd2JfbXV0ZXgpOw0KPj4gKw0KPj4gKyAgICAgLyogc3RyZWFtaW5nIGlzIG5vdCBhY3Rp
dmUgYW55bW9yZSAqLw0KPj4gKyAgICAgaWYgKGlzYy0+c3RvcCkgew0KPj4gKyAgICAgICAgICAg
ICBtdXRleF91bmxvY2soJmlzYy0+YXdiX211dGV4KTsNCj4+ICsgICAgICAgICAgICAgcmV0dXJu
Ow0KPj4gKyAgICAgfTsNCj4+ICsNCj4+ICAgICAgICBpc2NfdXBkYXRlX3Byb2ZpbGUoaXNjKTsN
Cj4+ICsNCj4+ICsgICAgIG11dGV4X3VubG9jaygmaXNjLT5hd2JfbXV0ZXgpOw0KPj4gKw0KPj4g
ICAgICAgIC8qIGlmIGF3YiBoYXMgYmVlbiBkaXNhYmxlZCwgd2UgZG9uJ3QgbmVlZCB0byBzdGFy
dCBhbm90aGVyIGhpc3RvZ3JhbSAqLw0KPj4gICAgICAgIGlmIChjdHJscy0+YXdiKQ0KPj4gICAg
ICAgICAgICAgICAgcmVnbWFwX3dyaXRlKHJlZ21hcCwgSVNDX0NUUkxFTiwgSVNDX0NUUkxfSElT
UkVRKTsNCj4+IEBAIC0xNTQ5LDYgKzE1NjUsOCBAQCBzdGF0aWMgaW50IGlzY19zX2F3Yl9jdHJs
KHN0cnVjdCB2NGwyX2N0cmwgKmN0cmwpDQo+Pg0KPj4gICAgICAgICAgICAgICAgaXNjX3VwZGF0
ZV9hd2JfY3RybHMoaXNjKTsNCj4+DQo+PiArICAgICAgICAgICAgIG11dGV4X2xvY2soJmlzYy0+
YXdiX211dGV4KTsNCj4+ICsNCj4+ICAgICAgICAgICAgICAgIGlmICghaXNjLT5zdG9wKSB7DQo+
PiAgICAgICAgICAgICAgICAgICAgICAgIC8qDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAq
IElmIHdlIGFyZSBzdHJlYW1pbmcsIHdlIGNhbiB1cGRhdGUgcHJvZmlsZSB0bw0KPj4gQEAgLTE1
NjMsNiArMTU4MSw3IEBAIHN0YXRpYyBpbnQgaXNjX3NfYXdiX2N0cmwoc3RydWN0IHY0bDJfY3Ry
bCAqY3RybCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgIHY0bDJfY3RybF9hY3RpdmF0ZShpc2MtPmRvX3diX2N0cmwsIGZhbHNlKTsNCj4+
ICAgICAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZpc2MtPmF3
Yl9tdXRleCk7DQo+Pg0KPj4gICAgICAgICAgICAgICAgLyogaWYgd2UgaGF2ZSBhdXRvd2hpdGVi
YWxhbmNlIG9uLCBzdGFydCBoaXN0b2dyYW0gcHJvY2VkdXJlICovDQo+PiAgICAgICAgICAgICAg
ICBpZiAoY3RybHMtPmF3YiA9PSBJU0NfV0JfQVVUTyAmJiAhaXNjLT5zdG9wICYmDQo+PiBAQCAt
MTc1NCw2ICsxNzczLDcgQEAgc3RhdGljIHZvaWQgaXNjX2FzeW5jX3VuYmluZChzdHJ1Y3QgdjRs
Ml9hc3luY19ub3RpZmllciAqbm90aWZpZXIsDQo+PiAgIHsNCj4+ICAgICAgICBzdHJ1Y3QgaXNj
X2RldmljZSAqaXNjID0gY29udGFpbmVyX29mKG5vdGlmaWVyLT52NGwyX2RldiwNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpc2NfZGV2aWNl
LCB2NGwyX2Rldik7DQo+PiArICAgICBtdXRleF9kZXN0cm95KCZpc2MtPmF3Yl9tdXRleCk7DQo+
PiAgICAgICAgY2FuY2VsX3dvcmtfc3luYygmaXNjLT5hd2Jfd29yayk7DQo+PiAgICAgICAgdmlk
ZW9fdW5yZWdpc3Rlcl9kZXZpY2UoJmlzYy0+dmlkZW9fZGV2KTsNCj4+ICAgICAgICB2NGwyX2N0
cmxfaGFuZGxlcl9mcmVlKCZpc2MtPmN0cmxzLmhhbmRsZXIpOw0KPj4gQEAgLTE4NjYsNiArMTg4
Niw4IEBAIHN0YXRpYyBpbnQgaXNjX2FzeW5jX2NvbXBsZXRlKHN0cnVjdCB2NGwyX2FzeW5jX25v
dGlmaWVyICpub3RpZmllcikNCj4+ICAgICAgICBpc2MtPmN1cnJlbnRfc3ViZGV2ID0gY29udGFp
bmVyX29mKG5vdGlmaWVyLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGlzY19zdWJkZXZfZW50aXR5LCBub3RpZmllcik7DQo+PiAgICAgICAgbXV0
ZXhfaW5pdCgmaXNjLT5sb2NrKTsNCj4+ICsgICAgIG11dGV4X2luaXQoJmlzYy0+YXdiX211dGV4
KTsNCj4+ICsNCj4+ICAgICAgICBpbml0X2NvbXBsZXRpb24oJmlzYy0+Y29tcCk7DQo+Pg0KPj4g
ICAgICAgIC8qIEluaXRpYWxpemUgdmlkZW9idWYyIHF1ZXVlICovDQo+PiBAQCAtMTk0MSw2ICsx
OTYzLDcgQEAgc3RhdGljIGludCBpc2NfYXN5bmNfY29tcGxldGUoc3RydWN0IHY0bDJfYXN5bmNf
bm90aWZpZXIgKm5vdGlmaWVyKQ0KPj4gICAgICAgIHZpZGVvX3VucmVnaXN0ZXJfZGV2aWNlKHZk
ZXYpOw0KPj4NCj4+ICAgaXNjX2FzeW5jX2NvbXBsZXRlX2VycjoNCj4+ICsgICAgIG11dGV4X2Rl
c3Ryb3koJmlzYy0+YXdiX211dGV4KTsNCj4+ICAgICAgICBtdXRleF9kZXN0cm95KCZpc2MtPmxv
Y2spOw0KPj4gICAgICAgIHJldHVybiByZXQ7DQo+PiAgIH0NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5oIGIvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9hdG1lbC9hdG1lbC1pc2MuaA0KPj4gaW5kZXggMGI2MzcwZDc3NzVmLi5jMmNiODA1ZmFm
ZjMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlz
Yy5oDQo+PiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5oDQo+
PiBAQCAtMzA3LDYgKzMwNyw3IEBAIHN0cnVjdCBpc2NfZGV2aWNlIHsNCj4+ICAgICAgICBzdHJ1
Y3Qgd29ya19zdHJ1Y3QgICAgICBhd2Jfd29yazsNCj4+DQo+PiAgICAgICAgc3RydWN0IG11dGV4
ICAgICAgICAgICAgbG9jazsgLyogc2VyaWFsaXplIGFjY2VzcyB0byBmaWxlIG9wZXJhdGlvbnMg
Ki8NCj4+ICsgICAgIHN0cnVjdCBtdXRleCAgICAgICAgICAgIGF3Yl9tdXRleDsgLyogc2VyaWFs
aXplIGFjY2VzcyB0byBzdHJlYW1pbmcgc3RhdHVzIGZyb20gYXdiIHdvcmsgcXVldWUgKi8NCj4+
ICAgICAgICBzcGlubG9ja190ICAgICAgICAgICAgICBhd2JfbG9jazsgLyogc2VyaWFsaXplIGFj
Y2VzcyB0byBETUEgYnVmZmVycyBmcm9tIGF3YiB3b3JrIHF1ZXVlICovDQo+Pg0KPj4gICAgICAg
IHN0cnVjdCByZWdtYXBfZmllbGQgICAgICpwaXBlbGluZVtJU0NfUElQRV9MSU5FX05PREVfTlVN
XTsNCj4+IC0tDQo+PiAyLjI1LjENCj4+DQoNCg==
