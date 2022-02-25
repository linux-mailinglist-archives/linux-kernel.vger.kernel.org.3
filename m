Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC93A4C4F36
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiBYUAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiBYUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:00:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2DD186B96
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645819172; x=1677355172;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5cyZh7smv/ziN+Vpz+JbL/gmNERl/2kblMCzN6pzK5o=;
  b=W8k2PEfIoXZF1WGPLwz0g5N0kZPwaDT7OZXTsEj6bjhkpGEcIlSnhYH9
   4tDubz+c48hyhR/ySnKk0u/AsXlrUMF8ulNHaAqDyATiTj4UkGPN+6B0w
   gFOnkOv38+l9ziBmPMEOxwI9ODFArNVzFrsXo7HczIIWv8xufzZYbOR3U
   vTWWFFZW+OIKxeOF/oMYhI26m9hJs2QExcxlDdImX1luI/GJat5ngl1l1
   clFq7A+z93sPVB7waEFYWvgYxG9yaro1tMsUrS9VtOLG0LlNlGiiJPH3P
   6svQ2Hvm9HTcvw4TN71y/WURufhc3RRqsti+KWRvkOZIZnunaPxTGDWqH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252765405"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="252765405"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 11:59:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="549399749"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2022 11:59:20 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 11:59:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 25 Feb 2022 11:59:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 25 Feb 2022 11:59:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8ag1uwKCsWNm6l8wojCzu4Y2t0SiCioH8A3DLjsbjzWZl8tFLr5m2rVykTHpsSEzTmk/rVtMc0ni873aAmYr3KiiT9RjMj7AlLWcMeGaNGvtptxf+NCcvc7r8TE69bvLZVnqaspZR3FbHvaUDzqjsSfP1zliwy3KNJV6AkhlfN/gWwy5XygPmG8X7NkF6itDBNI/sqWtmMMoHhncZlRW9ly10o0Y0ZOlLhwhT9G1RarFeJw8GljFF1fpClozwVhApMJOGGJsWaAq5iVxFgWcPa3D3FqDOXFhBdLruEfYXOq+8yiABwfTJ6re6RmrhOqlFp0ke5ZclOj6aZzmd1IxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cyZh7smv/ziN+Vpz+JbL/gmNERl/2kblMCzN6pzK5o=;
 b=FUTkhmG5dzu0V1aU5wiQz/9UPTvqSYxSsFY03F5V4ArtjaGKKgopTNO9r4SpRadkMVWlnQCs1jLDxtoa/QdAYDcrXq7o+aHyU4lX/Y7x0thuuNcXxOLd7xm5hhUYi3UopCMHeqcq1cjpF4R0dXJHgrND81frnAy/hLcV0VOCZ3FhburhgTMcnrF3UB5OmzwMnj6aBA7PT2oCruq4C7kb3QobiI4JXeqDYOMFbQZyIyC/Tc55BK5fG3zYAb38DknT8i3HFnJ3rQbwlqGmtPPIf+ZGkjY22Dc2yGc3mNv+GM0WhGV9HbNSvzDm0yZNC+pAhX8V0vJIoJgaP/mlIAlUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM5PR11MB0041.namprd11.prod.outlook.com (2603:10b6:4:61::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 19:59:16 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4995.027; Fri, 25 Feb 2022
 19:59:16 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Topic: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Index: AQHYKm/X8z1QhyAgRU236IJfVj3evaykr3KA
Date:   Fri, 25 Feb 2022 19:59:15 +0000
Message-ID: <eed8902f21ba9e5f93562432f6b5920137860a98.camel@intel.com>
References: <20220224145138.952963315@infradead.org>
         <20220224151323.069205370@infradead.org>
In-Reply-To: <20220224151323.069205370@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a5fd55e-b604-4912-bd27-08d9f8994d5c
x-ms-traffictypediagnostic: DM5PR11MB0041:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB00415694FE6A5E03500AD39CC93E9@DM5PR11MB0041.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8quyQu3L/JVB9ZCFIA8B/hEThaCHQlQheZtM5FlRhy1q1xLJWLiJ1VjQ6BEOKvzj4dYMcKLYpsizcfyT9gHosHWLVkx2Y4y6nmgBH7uJCK6pXADG34z19rKz/r4RaQZbOex/2DMWKd0Azw5lCMECOT4CDK9Hp5Q4KzYov0HfjXh2FvR5yXHNIY3eM0N9HE4FtmPrj8z6sayGsc6SPsA8RA0lCPLMoFUzpnFtGoVgwUiNVodglJPsxaqiDk4gwbdxQcbaeluuJOk1I5JkjfEnixVN8lN06s+z3zh+ZaAb+14LI9mtVzvfsVFE1Lzz+lD3kXsfKI4luMreQIlex24mTQQ8hwzfjYfP+mj6D1/r8HKhcrWczx5itDnN6M5p50V7bBssFztJoI62KKOpKCiEZTPsj0tGSomudpG6v7wiuJLnSKILgwuC/s33Q4ymu55XuMaEquVtiD66C0HFkmA8IMqDbjtz81PtSyFAfgqAa43qr/qrp/+O01afC1nKysMl4K0IDC4X/vSaXh7kmJj62DSpMlPgPdrhtcwNYpvPrDxxtnFPSxa4FlGDVvQJzwzpXsfZWHr2QuyltGUGLY3zgd7P8flSL7RyKz319Ood8omK5FANMcRqbntI0jgRO1UDXHnhSljCgY14LSOGmPmTNtWlrF6IyhOBLb/t63r5/9VnvgPD4QPbRS6y4kSMl6I7XfajE6YUwvfhZpaylSoOPpeUUiYHhBx23SqLdqNG4/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66446008)(82960400001)(66556008)(66946007)(76116006)(38100700002)(186003)(26005)(2616005)(83380400001)(36756003)(5660300002)(316002)(71200400001)(2906002)(38070700005)(8936002)(4326008)(6506007)(7416002)(64756008)(6486002)(122000001)(54906003)(110136005)(508600001)(86362001)(6512007)(8676002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzNDSWJiMjlJbEFVMzkxcTh2MmpEUFQ2SGdsUmdwQjh3bDU4Q3ViUXBnd1RP?=
 =?utf-8?B?eElTcTEyMmp5enZVUXZsay8rMEJEcHpzOCtaQk84dnNMTGRmMFdZY3dRRUFp?=
 =?utf-8?B?azZTRjQ0aStRWWVzT241NlcrSE5WcXhROTk1aGIzQVAvZzVMbWx5M3FsUTdn?=
 =?utf-8?B?ZEFMR2lMVDIwakZZbXVBak5GTVdVdEVJSlV6ZmhQaGc5RHVZTUQ2N2p4a2h6?=
 =?utf-8?B?WHI3N0NQL25hc1FQamtKTEJ0elJlcGFqcnFQZmUxdlo4UWpYbGg1R1hhVVN5?=
 =?utf-8?B?aFBSRXV5K3JBcy9lQVZhUzAySjJTUi90ZmZ2RnJKblMyN2dMUkcrVTFzbDhW?=
 =?utf-8?B?eDhydUVVSGF6NWEycmFubFJYcTRPeWQwK1VNc2FYUnZiMG9id3NPRVZnNDVm?=
 =?utf-8?B?aTd6UlU3OHoweXNHbEdDTHpZVnAyTTBtekFIeEpVS3BYRUc5ZXQwcVZYbmlK?=
 =?utf-8?B?OHlwcVhZNlorQ3hjUElRSytqcG5vTHVXN2NnOWJTVS9ySUtoY1NlclpHQnd5?=
 =?utf-8?B?N2JkWWE1aW9EdVh4T0JNd2JuSlZJQ0dZMnlLb21YUUFoWUNiQVhEdFpHbzN3?=
 =?utf-8?B?czZnQjl4UEZrNnJQRGJEOE9yRWhzaGlDaytkTFZteVVDTXpXRU9JYTBnSy9U?=
 =?utf-8?B?MjVsVlpkbXhEemdQNmc4Vi96di9VOGFHQnQ1MHFCWkFrY3NsMnVIMFRNRUxn?=
 =?utf-8?B?QUZFUlFubnYzckFGb09uclJXKzFQazB5ZHZESWNVcXRiQ2hMQnd4NzVmSEZl?=
 =?utf-8?B?WU5qMmNGS0FRYktuSkowb01uUCtuSWlnTWRQaWh3aUJZdlNicjFWOTEzRkNY?=
 =?utf-8?B?aCtzdmlYbE1HU0dBbkZQejE3ZUtDTFRqWmJTZ2pJUitzc2FMN2NtcHprL1Zz?=
 =?utf-8?B?VDZlTjBwREhLRElHUkhVQmpTNUdLRWJWTEw4QWdHMWppMHNObmtyY1JhN1Yx?=
 =?utf-8?B?WmFXanhOclJyRGhWWE9MNmVndS8rQldYOHh2cDV0ejBTUHpYdWlramttazZW?=
 =?utf-8?B?S3VwRXQ3c2dsS3c5OGtiZnU4RWdlbXc3WGhTVVJoMGdkekVuWXlyTDJBNVJQ?=
 =?utf-8?B?VG1rZ1RJZXdBaHRQUStMRTlVaVAvcTZQcVFrOXQrNndPL1Z6aUg0VmthdUZ2?=
 =?utf-8?B?L21xa2dVVFpZakFGV05UUm50Mi9Zc09oU3ExNG5TZVcyZWNPak9uUTNXZHJC?=
 =?utf-8?B?dExGN0RDSGlWMEVobzROTUhSQmw4d2FEc1k5RkV2MUJ6VU5RMUxTZG0ySEFD?=
 =?utf-8?B?R0t5dThyTUhiZ1lScFptYVFjTldqRVNPZ1lIS1B4K0pzNHVTYmdkTDVxWE1a?=
 =?utf-8?B?am5lRjRoVVhQNlhDV0QrYmk2TVpJQ29zaFFQRGpKc0x1RHdsQmVydUlBNUE0?=
 =?utf-8?B?eURpQUpUMzREdVhlOTVtUW1rNGZDWk9YUFpsQ2FadjEyclBEbk9LdVV5eGdp?=
 =?utf-8?B?dnYwem1XR001T2ZmYnJIcGhxTXdPM0h6U1V1Uno0QUFoRVpPVUlwaWhSdGVG?=
 =?utf-8?B?dlU2cW1zQ0RLdmE4cGlXYWhpR2x3RGZFZDJrTGFrdVBISFczWXZnNjVkeEkw?=
 =?utf-8?B?RmlEMnFaRGNhQzE1cmc4UUNTTmpmV2pUdWZKb2plQjdmQ1U2LzZsU2NmQzJW?=
 =?utf-8?B?Q2dRdFAvU0JDT0pKRDdaTzM5SmdhWjFlYlNRSUtSUVJEL1E4TEtWQzVXVnM1?=
 =?utf-8?B?anpBejVubXU3WjVrTzFhdXNjN0ppdm1ZVWkvVDdNRkRsR1dicEFPMjdKamdH?=
 =?utf-8?B?VFJ4Z0pyN2RXejBiblYraU9IcE91N2VZVjJJVHVDNGNBUThnWE0rOGh3REFI?=
 =?utf-8?B?c1FWNERtWFpDZnZyN1dtem53MDAveU0ycCtoYjZWSytCYTRJTm1uRXRtTEg1?=
 =?utf-8?B?bFVmRkVkK3lrYUZmOG1ScFhtUFdrREZ6b0JYNW9DRjdqbEtVby9GMmZaTnBN?=
 =?utf-8?B?R05qb0JFT3lXd08wZjZzcTJHNHlIdGNnVk9DSnhuaGIwQ0xXcHFjcXFKN3pZ?=
 =?utf-8?B?aGFiZEgrVWtaTlQ4VnVZNEpBSWhOQ3hWVW0vY3VVSFRiZVdBRFRLQWNkemNC?=
 =?utf-8?B?RENWLytnYXhJeEs2UnNDQ0ZHaFlmNlhrZ0ZwZERFT21Ud3RJMS82bmVOdyt5?=
 =?utf-8?B?Z1JyWUJiMHdVeldkQ0pmTXk5ZU51Y3ozckNlaEhxRDU0SUhKUEY2RlpndXp0?=
 =?utf-8?B?YXY3UXZTRUFUcEdzbVhlaVBBRUVNK0RTWm1MYnhZWXY3WStsRjRwVGE2VHN0?=
 =?utf-8?Q?KUvu4Byc1KwgK4GQuoRpTJo6b3eNP9wiBaUSo/4JcM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E294C07019359545A4516626EC2A7C14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5fd55e-b604-4912-bd27-08d9f8994d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 19:59:16.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ImyhGA60TYxzB2Ueh26pPPZU4J0VeNgRzS4yRwNzEyKAUzSs/cyoYAJjkwGjpXbOU/U6EwW9ABKuFW0Ioek3YQwA6KS8gN6neGShGzGuWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0041
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTI0IGF0IDE1OjUxICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gK19fbm9lbmRiciB2b2lkIGNldF9kaXNhYmxlKHZvaWQpDQo+ICt7DQo+ICsgICAgICAgaWYg
KGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSUJUKSkNCj4gKyAgICAgICAgICAgICAg
IHdybXNybChNU1JfSUEzMl9TX0NFVCwgMCk7DQo+ICt9DQo+ICsNCg0KRGlkIHRoaXMgYWN0dWFs
bHkgd29yaz8gVGhlcmUgYXJlIGFjdHVhbGx5IHR3byBwcm9ibGVtcyB3aXRoIGtleGVjaW5nDQp3
aGVuIENFVCBpcyBlbmFibGVkLiBPbmUgaXMgbGVhdmluZyB0aGUgZW5mb3JjZW1lbnQgZW5hYmxl
ZCB3aGVuIHRoZQ0KbmV3IGtlcm5lbCBjYW4ndCBoYW5kbGUgaXQuIFRoZSBvdGhlciBpcyB0aGF0
IENSNC5DRVQgYW5kIENSMC5XUCBhcmUNCnRpZWQgdG9nZXRoZXIgc3VjaCB0aGF0IGlmIHlvdSB0
cnkgdG8gZGlzYWJsZSBDUjAuV1Agd2hpbGUgQ1I0LkNFVCBpcw0Kc3RpbGwgc2V0LCBpdCB3aWxs
ICNHUC4gQ1IwLldQIGdldHMgdW5zZXQgZHVyaW5nIGtleGVjL2Jvb3QgaW4gdGhlIG5ldw0Ka2Vy
bmVsLCBzbyBpdCBibG93cyB1cCBpZiB5b3UganVzdCBkaXNhYmxlIElCVCB3aXRoIHRoZSBNU1Ig
YW5kIGxlYXZlDQp0aGUgQ1I0IGJpdCBzZXQuDQoNCkkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9u
IHRoYXQgdGhpcyBoYWQgYmVlbiB0ZXN0ZWQgaW4gdGhlIHVzZXJzcGFjZQ0Kc2VyaWVzLCBidXQg
YXBwYXJlbnRseSBub3QgYXMgSSd2ZSBqdXN0IHByb2R1Y2VkIHRoZSBDUjAuV1AgaXNzdWUuIFNv
DQppdCBuZWVkcyB0byBiZSBmaXhlZCBpbiB0aGF0IHNlcmllcyB0b28uIFVzZXJzcGFjZSBkb2Vz
bid0IHJlYWxseSBuZWVkDQppdCBwaW5uZWQsIHNvIGl0IHNob3VsZCBiZSBlYXN5Lg0KDQpGb3Ig
a2VybmVsIElCVCwgdG8gZW51bWVyYXRlIGEgZmV3IG9wdGlvbnMgZm9yIGtleGVjL3Bpbm5pbmc6
DQoNCjEuIEp1c3QgcmVtb3ZlIENSNC5DRVQgZnJvbSB0aGUgcGlubmluZyBtYXNrLCBhbmQgdW5z
ZXQgaXQgbm9ybWFsbHkuDQoyLiBMZWF2ZSBpdCBpbiB0aGUgcGlubmluZyBtYXNrIGFuZCBhZGQg
c2VwYXJhdGUgbm9uLXBpbi1jaGVja2luZyANCiAgIGlubGluZWQgQ1I0IHdyaXRlIGxhdGUgaW4g
dGhlIGtleGVjIHBhdGggdG8gdW5zZXQgQ1I0LkNFVC4NCjMuIFJlbW92ZSB0aGUgdW5zZXR0aW5n
IG9mIENSMC5XUCBpbiB0aGUgYm9vdCBwYXRoLiBUaGlzIHdvdWxkIA0KICAgb25seSBzdXBwb3J0
IGtleGVjaW5nIHRvIG5ldyBrZXJuZWxzICh0aGVyZSB3ZXJlIGFjdHVhbGx5IHBhdGNoZXMgDQog
ICBmb3IgdGhpcyBmcm9tIHRoZSBLVk0gQ1IgcGlubmluZyBzdHVmZiB0aGF0IGRldGVjdGVkIHdo
ZXRoZXIgdGhlIA0KICAgbmV3IGtlcm5lbCB3YXMgYm9vdGFibGUgYW5kIGZhaWxlZCBncmFjZWZ1
bGx5IElJUkMpLiBJdCdzIA0KICAgcG90ZW50aWFsbHkgZnJhdWdodCBhbmQgbm90IGdyZWF0IHRv
IGxvc2Uga2V4ZWNpbmcgdG8gb2xkIGtlcm5lbHMuDQo0LiBEbyAoMSkgZm9yIG5vdyBhbmQgdGhl
biBmb2xsb3cgdGhpcyBzZXJpZXMgd2l0aCBhIGxhcmdlciBzb2x1dGlvbiANCiAgIHRoYXQgZG9l
cyAoMikgYW5kIGFsc28gYWRkcyBzb21lIGxldmVsIG9mIE1TUiBwaW5uaW5nLg0K
