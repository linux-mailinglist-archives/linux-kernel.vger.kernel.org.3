Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E81510F03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357287AbiD0Czu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbiD0Czr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:55:47 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Apr 2022 19:52:37 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD74511D21C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1651027958; x=1682563958;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=umFzBEynQLJeMxj7lTqFGkbCoCa5wul5jihy2/g5ri4=;
  b=wgS47iqsAvLhzRa+hJfH5vAVxO1bs9VupF9EruK8gpctycyMoxVb9wvp
   C1J5qU+2pcBpKCPwB2HIjs62knarL/8m15UosFeQb4pdV0pN8VgH4MuQo
   mdgMGWQ95kaKsbjjp+wu3hfLFIMruCj3OShw5lADasbvs1xYk6g9plI38
   NjuGZNnK7MQ5Oo21N0L8r3VmNtWqEjfj5zTQhfS0uh+wZAe53S37HAHpF
   j3gOq7sf9wZ+M6mPlZk4P+8gNj6XG1HPuyHrYENP1VQkQjA95dizXlbKg
   GBNu3RupNiQpJbOgNREp6WBd/jtW8AOmFSya+63891iy8E54WGhXITCaP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="54927529"
X-IronPort-AV: E=Sophos;i="5.90,292,1643641200"; 
   d="scan'208";a="54927529"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 11:51:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTDLnYOAtTUs+69RcR4x1fumpJvxZ5lakSLpYYfV9VzJ928K3Xcq+Nz544fm8vnE5Kg89THxWg8jrztSyWvuheOWKqkngo2+HJmdgd4qpNygLWguqvqpFW5bsDH2l1lT3Vv30iNZ1Ln2sSoEcq07JozcIPwrhbDga9vM06z9bE+9ql9RDAEeAnefKG1eecqigOLbKobU+SBG1tILRvbZQX2W8HCdr/kMm9YdLBN9slQaU8D+NhEpbodO58t+NP+FHTZA9SgKqxMuL7499YlOgDj3oVjmObhgr87YYCreSTyOFk8JyZGKb8gRYPcAwBZkDcbZ2+AGQZXYMGi5tfyBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umFzBEynQLJeMxj7lTqFGkbCoCa5wul5jihy2/g5ri4=;
 b=FZxva1cDqzSrPtZ5I8IIzRLtbB+iUnNegxJ8y9vACpveFLDTHG6hqzPFnqvs4NmFYyrrZU85JTfqxIbsfTiWxAlnrhC5SV3fYZoLPwG+yCFm+YKZHrV89Ku5hGEbLspvBKpqPHw/EFKV72WFlVquYsJcF5meNkeTUqvFesmkVCjz8ULTNrCRRjtb6u4ED0++5swnym1ITqlcPfj1O25I4WRlE4tv7wO0J0exRcOdcA8+069wJ5lnomXncC+JmG74TChcYH4dgeiJvLYJ/AZF+yyBiV5DMuZprJsk5BXgnPzN83EUe8m5FRFhyBrMT6i6KH7uw+/PV0Mu694bPmPaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umFzBEynQLJeMxj7lTqFGkbCoCa5wul5jihy2/g5ri4=;
 b=A6ZgSYiiWsTfi4KlzUwNz9OZyHXF8aw5rRyNDUt4w+h+L58Qtkexy8KjPxK4+b64ZLrqCG3zumKO/TSB1ZYlrBoVc01Jvu3L7X/Oq0N0hzQqt3KxbpvpIDmsNt5a7/C91hDOc4Vu0Ogc8lyZWpqZaEQTeTws5rORAQY981Hyly4=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYCPR01MB5981.jpnprd01.prod.outlook.com (2603:1096:400:61::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 02:51:27 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::382e:99b:f0f9:b18c]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::382e:99b:f0f9:b18c%6]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 02:51:27 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
Subject: RE: [PATCH v3 6/9] x86: resctrl: pseudo_lock: Fix to restore to
 original value when re-enabling hardware prefetch register
Thread-Topic: [PATCH v3 6/9] x86: resctrl: pseudo_lock: Fix to restore to
 original value when re-enabling hardware prefetch register
Thread-Index: AQHYVGMQTggD3SnyckyLsQJZXsnuz60BTJIAgAG4HbA=
Date:   Wed, 27 Apr 2022 02:51:27 +0000
Message-ID: <OSBPR01MB20375995F62C613F8D18825D80FA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-7-tarumizu.kohei@fujitsu.com>
 <d1998eb4-296f-f1ac-8deb-1b6d4fbdc1fa@intel.com>
In-Reply-To: <d1998eb4-296f-f1ac-8deb-1b6d4fbdc1fa@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2462dd3-a96b-46fc-970c-08da27f8d30d
x-ms-traffictypediagnostic: TYCPR01MB5981:EE_
x-microsoft-antispam-prvs: <TYCPR01MB598115BA91CE1B38A22FC0D180FA9@TYCPR01MB5981.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EnX48Y4LDSPCOf6XFutA06QD8SjSOyR5rZnprF4XaifGlwuY65QfGN1Pmp79hKt7LmN4yLh5ccY40HxnvqcH39oC83p02e5r8SkSj6hoPDslGveWETPxwisYuuFFlVFfdn9HWw4eNCq7BxXaTTPqMuAIbYchCKd9WULrbHvfltCmdq31E8v8206UssLg5Ttw4jhHy8J5V+c1FkHDjA3JmmXDOu2B2gkVEugp2htnuPium1sW4rU4K1kytEiJg1LVwdw1Toj8pIS32J1gazRn2XDBMi+Yobepu7lNMDJfff/ChEEpZvD864e1vta4sOEk+/t4QJd2FgNVs73d9C4oe8V7msSnxR+GGtvV0StNdBkQU+jEXs/W5T1mAyZCBja2WlXkkyFtAy73MUzYMORo43KjXwzgd/B0+bXOVh2zC0oaGfNf8yvJ5++YCLm/8kp5O/xItKPoyt0fqU2bjtzm66aY7WiAO5vNlouFVj5fkTWo5224u11viS7IA8qew2X5KbLxYuixU5QZpKL5ERrP+ujRE8NaM7ZaBbSS6gxTOsXsfLnPu0B5uzMYjkrh/03a/gxj4ybVsfod/7yzX/STFmgqf6ERccV4AvS5E/BhA6jJXsIP+gwaJTHVooPBNmO+Nu7MVxng0daZ31RZyZrtETjbiK1u6cdj5PGHfGSGmukYnVngIgxelP5Rfxsw9vX4hwNtLoqRuyh0v+5oAR0ptVYBRNOmu0iZkyNrbGfVaaHuXrEgNYW19rroNoFY23p+zaT8224iejLtumG7Rlh/p0pHVcNGP5u8N/qLyZeT/sRAXwRiysIhbJkhjJ/UkcXB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(86362001)(76116006)(66946007)(33656002)(8936002)(6506007)(921005)(66556008)(316002)(66446008)(71200400001)(52536014)(110136005)(7696005)(66476007)(508600001)(122000001)(966005)(7416002)(64756008)(8676002)(5660300002)(2906002)(38070700005)(186003)(55016003)(83380400001)(38100700002)(82960400001)(85182001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?USt3SDNKZ1dMN0VOUDR0VzhNMkt3bFVTdDgxN2p5WHBEbHoxMlozb2cvU1Bx?=
 =?utf-8?B?TmYrdTI2bEVJUGwyT3BOZGhzemF4TkxtZTRpdHpDRmNvRFc0b0RreTZhSjV0?=
 =?utf-8?B?NEZjMDRuUDZ0RkhaWmQvZGVURnpvQ3RwTkZYQjFZc1RuWUNPOWZjTzRNUjRh?=
 =?utf-8?B?REo0bjUyNWgwYk1MdU01eEV1M3k2MVRtcVBOdTlkZGlMQ0Vkd0NuZjV2SGg2?=
 =?utf-8?B?SFBqTXJ3cHJ2V0FWMUlSdU9ldHZEZUxTcUdMcmpESmR5TllONWV5NUsyNmVT?=
 =?utf-8?B?T2hDZUdwR29hSkpoSXBkSk5ibHJQV2wxbmtmeFVDWCtaeGRXWGEwTGVqaWIy?=
 =?utf-8?B?SDlFYmhYdm01MndNYjJMaldFMnppYWt1M1hxQkxkVUxJRmFDUm9abllRVVdF?=
 =?utf-8?B?VndzWHl2SVNEZi9meXhZVW9TNDRidy83WEt4ZVNIYXp4NnZOdHEzTXNUaGk0?=
 =?utf-8?B?SG1vWW45WkkzeDFBbitMQnhQODVMemljVmV4RTlxZytCNlF0ZTRDaGJQd0pL?=
 =?utf-8?B?MTZubFFieUNLM3RVM2pyVXpDMVVuUHNCakJ5TVllTWZjS2pwWlFXUFFmM2Mv?=
 =?utf-8?B?bkpEOG5yZHp0ODgwdk1JcDM3ZmVDTnZzaVczMW5zV1dHR0dNdFhLTmxUM1Iw?=
 =?utf-8?B?S3VndWJjUzdPa1NmQVV4RE1FQjF6NnN0RzBkNU5MRzRpd2c5L012SjZHMmYw?=
 =?utf-8?B?akJFZm5VRkx6bVR6WjlyYmtSSnVEVkZodEYxRjFQL0Rick5QNDdPUVY3UGUz?=
 =?utf-8?B?UHZwZFRUdVhPSFlYRnNnK05EMGxuNU4vZDJsOUo5WWhXNVE5bG1MU3VGS05p?=
 =?utf-8?B?bUJRS2VPcGNzQWtOVGZmZjNSNXJKSWlweWY4SE9VSDlnUkErZFQrWlRpdkgr?=
 =?utf-8?B?Zm1Gb29IbzZRMmtoOS9WS1M5aWtrSGJyZEc1aCtIR2lDU3l1QVR0V2tORmx1?=
 =?utf-8?B?N1VyMXJhZ1h3N251cmhwNVZ5NzhWTzdiQXlVdm1NaUs2ZXp4TmtNaTYwMkxO?=
 =?utf-8?B?WElFdVpNaVo0aTVxcCtmWnN0a3JudGhiVVFhcDVlWHlDalVTTVpWNWNnSXV3?=
 =?utf-8?B?czV6ZUVNWm12dk5Kbk1kcVlrU1lLNEUzeVFQSHE4N0twYVJlUkY0aGliM2RS?=
 =?utf-8?B?d2ZjZytyWnNBeVRUL2hYMUFOcm52a2lKclFiNWtpRFpyVng1emxNNURHT0ps?=
 =?utf-8?B?d3pUTUdVOUpWeGZlaGlhbHNBdTZoZTF1bVZhZVpuVmx1WUpneGtKNTBJaVVS?=
 =?utf-8?B?VjhwZ1BlYVdJbURMTitDZEhjUTNyOUlSdGZqWERac0RHK3lGdWVHajNldkZs?=
 =?utf-8?B?S1BLNjVjTStIUWRFOURxTnpWNGFrRGRTZVphRDJ0cktiYldDZzVqY2M4dlNy?=
 =?utf-8?B?Vm9WajNrUXZzQmRWU0FyampKTzFoYlJ5U2NxRE1kQ0M1aHJta0NYcit4aDl4?=
 =?utf-8?B?U3BDOEtuakxybFFMNDNiNDJzZ3J5bWl0dWZjNEZqOGc4M3V4cEUyWTNJaHBY?=
 =?utf-8?B?YW5Hc041empkZlYrbmx2YlhDSGZIdW9OVVF6d1VvVTJCcStGUDBSRG5GcjdE?=
 =?utf-8?B?dEgwVlRIN21kbWpqbFk2YVF5MERMNE9saTkzUHlQdURKSFk3VklaNVh0TTI5?=
 =?utf-8?B?aEZ6empZR1pDY3ZtditVaUEvWEh0TEo1MkU0YWVSVVZiSC9IVkV2YVJkYk9D?=
 =?utf-8?B?UVkxTTZoa1pkTCtTRlMwSFlqTGN1cXlBc0h4RTFCYW1Ia3lXQXBxU0JJM3pz?=
 =?utf-8?B?czFNdXVLUEJMT2l2YVNnL0NHMVNJTkxTRUJ6MUhRRXdwRjBSa0lRakFvTDhY?=
 =?utf-8?B?MDltQTE1dm5SQzRmU0hDU1F4eUlYRW13YnRGT2xJV3RySnMwamZPdDhWOTJJ?=
 =?utf-8?B?NFIrRFdnY2JVQWE3aGZUcGd1NmNzdC8yQkZjSVk3bzBKWjhjeFFxc0JNQVcw?=
 =?utf-8?B?VTJpNGw4Qm5UdXpEdFJ4ek1YYm9JVTB1c2pHcThHQ1RCWVpNRzR2ZDkzUUha?=
 =?utf-8?B?bWdJSlJxNHNwUFpYdDZyVFdjQnhCdFJ6SUxEanlHRHltVkFyVlNpV2hsdXhI?=
 =?utf-8?B?WnVpMnpJS2hleGRYNHlGTUtSTFkwVFMzanVkb3FxZlZNRzY1TDNWMkR6K01w?=
 =?utf-8?B?Qlgzemdjc0RodlhncW9rYnl3djM1ck9wVVlTaFh5VU1KTGgzaFBldVpxSitL?=
 =?utf-8?B?dHJRU0NFWHIzK0hGYlRWUkJ4cFJ3eGxjOVFrdU81ZHpkN3pqWVhGWWxiWVFZ?=
 =?utf-8?B?NUZocnhUZUNkZ3RCZUdDN3NrT3NjSkU5dzNSdVMwK1RIQi9YcWZzSExxQUZr?=
 =?utf-8?B?YW1oaHFnbnpWTTJKNzZFSFIvZVFjcGxsOW42WER3VWh3UCt2TnkxNW1oYnBP?=
 =?utf-8?Q?Ula68Gbm/Mhdo/xY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2462dd3-a96b-46fc-970c-08da27f8d30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 02:51:27.2446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZXYRfT9VxNJB37CY0IWEhR/7yychoVqwfOyO2zGLEArYesw0uX1wmMBs5LWwTxfPhDfgNds8u2DcPFUBDAN7QuvmAppCfT83pl7mcc015A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5981
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgY29tbWVudC4NCg0KPiBUaGFuayB5b3UgdmVyeSBtdWNoIGZvciBjYXRj
aGluZyB0aGlzIGlzc3VlLiBUaGlzIGZpeCBpcyBub3Qgc3BlY2lmaWMgdG8gb3IgcmVxdWlyZWQN
Cj4gYnkgdGhlIGRyaXZlciB5b3UgYXJlIGNyZWF0aW5nIGluIHRoaXMgc2VyaWVzIHNvIHlvdSBj
b3VsZCBhbHNvIGV4dHJhY3QgdGhpcyBwYXRjaCBhbmQNCj4gc3VibWl0IGl0IHNlcGFyYXRlbHkg
YXMgYSBmaXggdG8gcmVzY3RybC4NCg0KSSB3b3VsZCBsaWtlIHRvIHNlbmQgdGhpcyBwYXRjaCBz
ZXBhcmF0ZWQgZnJvbSB0aGlzIHNlcmllcyBuZXh0IHRpbWUuDQoNCj4gV2hlbiB5b3UgZG8gcmVz
dWJtaXQgdGhlcmUgYXJlIGEgZmV3IHN0eWxlIHJlbGF0ZWQgcG9pbnRzIHRoYXQgSSBoaWdobGln
aHQgaGVyZSwgdGhlDQo+IGZpeCBpdHNlbGYgbG9va3MgZ29vZC4NCj4gDQo+IEZvciB0aGUgc3Vi
amVjdCwgcGxlYXNlIHVzZSAieDg2L3Jlc2N0cmw6IiBwcmVmaXggaW4gdGhlIHN1YmplY3QuDQoN
Cj4gVGhpcyBuZWVkcyBhIEZpeGVzIHRhZy4gQSBmZXcgcGF0Y2hlcyBhcmUgaW1wYWN0ZWQgYnkg
dGhpcyBmaXg6DQo+IA0KPiBGaXhlczogMDE4OTYxYWU1NTc5ICgieDg2L2ludGVsX3JkdDogUHNl
dWRvLWxvY2sgcmVnaW9uIGNyZWF0aW9uL3JlbW92YWwNCj4gY29yZSIpDQo+IEZpeGVzOiA0NDM4
MTBmZTYxNjAgKCJ4ODYvaW50ZWxfcmR0OiBDcmVhdGUgZGVidWdmcyBmaWxlcyBmb3IgcHNldWRv
LWxvY2tpbmcNCj4gdGVzdGluZyIpDQo+IEZpeGVzOiA4YTJmYzBlMWJjMGMgKCJ4ODYvaW50ZWxf
cmR0OiBNb3JlIHByZWNpc2UgTDIgaGl0L21pc3MgbWVhc3VyZW1lbnRzIikNCg0KSSB3b3VsZCBs
aWtlIHRvIHVzZSB0aGlzIHByZWZpeCBhbmQgYWRkIEZpeGVzIHRhZyBmb3IgdGhlIG5leHQgcGF0
Y2guDQoNCj4gUGxlYXNlIGRvIGZvbGxvdyB0aGUgY3VycmVudCBzdHlsZSBvZiB1c2luZyAicmV2
ZXJzZSBmaXIgdHJlZSBvcmRlciIuDQo+IE1vcmUgaW5mb3JtYXRpb24gaW46DQo+IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC90cmVlL0RvY3VtZQ0KPiBudGF0aW9uL3Byb2Nlc3MvbWFpbnRhaW5lci10aXAucnN0I241ODcN
Cg0KPiBTYW1lIGFzIGFib3ZlLg0KDQpJIGNoZWNrIHRoZSBVUkwgdG8gZml4IHN0eWxlIHByb2Js
ZW0uDQo=
