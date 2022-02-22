Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0DD4BF192
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiBVFlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:41:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiBVFk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:40:59 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7499D079
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645508434; x=1677044434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5hsgZzy3lB0WIW8eWncPXII1s9XbXylNIj2zWIn6aLM=;
  b=jukHAOE7dDzW5Cb76p24/dp2HbrR3kUY4LAnDG0vz90owm3Amgg2XLup
   k9pfLqI3BRRsPN5+agINmqOHrXHRw4PnXlzvsTJYMmKEDgOxD7Xwc4wD/
   IYoHeOQ1xq2EMhEGcICuaxhlP+I6mE6roS7pHI1Tgfb6fBY+1LlDx+9pI
   y61CHluCWihqCdsFloZfWSnDSUy7bbaDBNeizKkEbGeR0sClEfolYGWjc
   O6gw7zAfLhvDFlKzVKyCsXHWPc4oqgg+lZMikhLV47a3xIOhIlgwfRy34
   YXs8Ss5yAMJnDmJ39g8G7tEt5FYYniu7ffOo+PP4l1EUxGRpo/ZRY2XyW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="231577769"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="231577769"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 20:38:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="778866839"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2022 20:38:26 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 21 Feb 2022 20:38:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 21 Feb 2022 20:38:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 21 Feb 2022 20:38:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/+SZWRbBse5Q36+GiIr20EwqjSNbCHzy7zEOJkVcCWqgPOo+sc1t0tNWiqBFBQ7rHU1p8/fkhRHPoGxF6vFHV4GgCoDjru86lJqoHmNtj05MxeOP1PGxPUv2r02zJlMA9M8XV/PsjEd5fKLfIPuN1h+0SjNx2RYyDYwAqXhbqCv+iSsNJD13AITL0FGSDmhRY7JyHqQ3JAYbEduDRWUVslUs3czoWkjcANuofI1nGgXdrEsxWKrYIppwhI3ZYlG7QJbmb17pG+r+39leKfhZg8xABDQ8kns05h9NuesqrL5KHW8LwyVMLWqWM+VoQj5D4CwEqro3Mfxztt5JP55Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hsgZzy3lB0WIW8eWncPXII1s9XbXylNIj2zWIn6aLM=;
 b=J2AbFDfG+BD3mQZ47aAManfDvhj5W0rhEoIKoRtEjFvxkudHRsDDkYZgm6bpWHVKkwJwiTb7sX5JJsclToAoen+oow9fW36xaa0r+e3aZxiwB1Qhmaynmh8jypuO32uRcKsVY75qMZKhBFlsin3ZkM6YhVorG/vOwOGGIP8eEdkDDe4Dml3+sK9mj89RrGL+Xj/sc1crp8OyNHiE1Th1s60a+nzd2QakzL3rMmG+aMcVmq4cY82DaRIDK7DNgKZQx9QHXCvQuASHvuKsQRTlFK6HXFzonEhxZXCyZf8J8dt8moz3/QnpYTRwiVKu4SZPl+GmnHHYkFEXOTJoXKvODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 22 Feb
 2022 04:38:22 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 04:38:22 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Topic: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Index: AQHYJSo1enFjW+ybRU+dZ/yIhjqUVayfAbWA
Date:   Tue, 22 Feb 2022 04:38:22 +0000
Message-ID: <6874fd181ad46cd48f12da6ff5c955a64e193564.camel@intel.com>
References: <20220218164902.008644515@infradead.org>
         <20220218171409.395399333@infradead.org>
In-Reply-To: <20220218171409.395399333@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb3d6a8d-cfc2-4755-39c1-08d9f5bd2835
x-ms-traffictypediagnostic: DM6PR11MB4705:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB4705AB3FCC3BD38EE4E7EF5CC93B9@DM6PR11MB4705.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gBmJiqhwitejHGB/ZKiXD/gOOw8/mY6dZLoYHZmTut2w2Rq5YWhpo7+J+4TwziiJ+3ePgNpVkAv0s/X4Smv/3XMGv6t0xmOiPctNIsDQSUVm0Ep7Iam4to9sJuBa+vmYa7XTUzGXMzCJt1+GyiT6XCF7P3W8Q/VwKSVvm2P3PMIbjesQYXO41jICFHY5I/qLW2iPWoSse9rSSsAj2QatwxpL7yNrQ9WdbEoLF4Wo4lEIK4j7++fDJ//YZcdZXr3IKzhF4onJLUaYAwBU+TELUCF6WKig8/EuEC0Lc2+zyXqpZbr+nMeorlYss42adeOsfY3P0hjMxv6HSH4kqsckTp0N4OUwqzfupred+6aKDZPymDD7CX6wUUkjvltJ8jnzTMnRyry+Jbq9QBzhAyExQQqhKvJTpEQi3/LkiQlOGJ5HoZEtdFhikPlM99X1Atfqc1JWs4w9F3aHhyCZ7lSnwpkw/t7kBirYp09FcWM9pTApDjpNlxi0IBKp9C6u7uan4bGPZtFRHrg5yq9vGuFiHqQh8XzmZjXeqFfbquIMYe8kaX0Vb1Wh+ejjh/T/PU3Jvnm1HHJ/Qms6KJbh7IT3lg2SagiEmSFgrRvNwjFxxhiC997+K6AZOP1CIyIRUEAyIWUWfGFLYDJJi1QwPVPgl429zWmzLOs9xjtOmR1BGL6FerxWHOFLEFLYjCv4ewYchq9oh1va3YW+KPs2unK9k7bsPIh2wyqpYUzSTswWJmg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(66556008)(38100700002)(66446008)(6486002)(64756008)(38070700005)(82960400001)(122000001)(66476007)(8676002)(66946007)(5660300002)(4326008)(316002)(110136005)(54906003)(76116006)(2906002)(8936002)(4744005)(7416002)(36756003)(2616005)(107886003)(26005)(71200400001)(186003)(508600001)(6512007)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UExTNDdyK3BURkNlYVRPQnNYQlpUbkVHMUVmbWYvWjJVR0tuMytpOERlRUhS?=
 =?utf-8?B?U2xzR2JGeFQrZWx4NmRXTTNVSktIUGRXL0R0Nm5ZS2prUTY2eXE4QVE3MzBG?=
 =?utf-8?B?NVFhRjRZOVFDNytFMkhYeWRzbVVuVkJNb3AvNlBXaUFnZEM2WDRZOVZJR0ND?=
 =?utf-8?B?bityUmxYd0NDZHdpOXhUVGw3UU9wMzJhTGFjMk92Q0g4b3VCeHJBR1pKckJl?=
 =?utf-8?B?SWFUVTRHdWxhMmI4WjJ5YnUrOUZHY1k4b1Bka0YxRkUxY1pXSWxUdk1qancv?=
 =?utf-8?B?S1JLK0JQOW5VUUFTbWU2NVBpQ08vcDFJMTl6YjhpTkI0ZEErZXRubjZoVjVQ?=
 =?utf-8?B?Uk84S3hCRkxlZVpvT0VHdTVKMU1TdGJZR0RqdFdjOWxSNnNQa3hINllPL2VC?=
 =?utf-8?B?YXRFdHJsdWowejBiRktBZ1N4V1BDUjlwUkVDdkZGaDNRaWlUZnFHL1RHdGww?=
 =?utf-8?B?ZjlDUi9iRE9xMzhTWllnM2V5QlRBeUNjZitob25BcTBMeEFHbGNjdzNDallD?=
 =?utf-8?B?WnMwSEdUYXRoVmZDTHpIMjZpcjFJZzlNQVZld3VoMUU2T3Bkdk12aXh1NGdu?=
 =?utf-8?B?d2dIeTIxQ3krMDJnYS81NzdpOHFDWUhnNXhrbEFua3d1YlFTVjNoYnlUN2ZW?=
 =?utf-8?B?N0pKbFZPNnhsZCtlT3JEaVN5bUJDc09tOUFqN0R6bGNmOExOeW8yV2FpaGJD?=
 =?utf-8?B?dmZ5b3RTc1lIbnAvM09iRG1ZZTJUbytCQWRLMmorYVkzUnVBenJpbWNya1JZ?=
 =?utf-8?B?N0pXMENBdU9KYVQyZGtXQ09mNWRRb0U2L0M3ZllZMDVNWE52WmxNdXc1dFNG?=
 =?utf-8?B?VDArRGhqKzVRQTNiNndYZzFLaTF5c2w3dEg2bWpCZEt4YVA5dlUxSXVmcXNG?=
 =?utf-8?B?ZXdQclZkY3dTcjRXODRTTzI4YVBDQ0U3YUd5R2FEaG1SQlR3TytIRHFaQVJ5?=
 =?utf-8?B?YjNtTXkzSUZqR2o3VExUOURXQ3l4MU45dnJDWUFHekNpdVFmNC9YbGw5STJ3?=
 =?utf-8?B?R09WdkxvVEdLU3pCZVZORURwRmhqTWhmTFFwMEJQT3VydDBvVE5uTnR2ZkNQ?=
 =?utf-8?B?S3JjZ2tOSmMyQkRsQm53YW9vL1hISzJOOEpybCtNYVNia2RDaDBsNzVtV1Iw?=
 =?utf-8?B?SHlIWUVXRTY1MTREenhkVDRvSDd6UEhhby9peXVFcUhBTE1BVFBJLys1a0FW?=
 =?utf-8?B?TERXMTRPNFlDZkRTQ2MvUjFNcXp2cjhRZDB5ZnU0UVdjR1NkWWFISXZhcUw4?=
 =?utf-8?B?WWl1M3Bma0JZeGg4L1A4dDhUdE9BWFVDVElsV2YvQ1ZvSTFOSkNqK1F0RFZ1?=
 =?utf-8?B?M001WE5DVG8zbndzWnhLVmdEMHNDZE9LSy9saWtmTmlEMVh3dEZMQ0FTWUxY?=
 =?utf-8?B?Y25wbi95b09aLzBicExvUHpVckUrdzE2VDdsRWRWU0M4OWNDOWFFQmZ6bVZ5?=
 =?utf-8?B?VzFzV1NNUjhITnhtbWN6UEtWMGV5ZCtrSUZMRE1aMHJwbnhqUm1xMVBpVGlX?=
 =?utf-8?B?UVgvMklnYzVJYVNycWZOQzIzR2pSWEJmSEJLRHc0ajNVWEZaUmJydEI4QmJ5?=
 =?utf-8?B?RmpBcnM0Wm5MT2IyOER5SDVjbzlwMUtzZFB3TzRVNi95WUN3TFo1TXdGQ3ZK?=
 =?utf-8?B?Qy9XcUx2TkE2M2M2WWhVU0dVU0xPLy9PeDd3MHE2aWF0Z2w4emVtZGk1elVG?=
 =?utf-8?B?dTlJdW44NlUzc2tUNk9SVHp1Q3NhV21jK050RTRXRnl3Yit0TGt1ZG9YVW55?=
 =?utf-8?B?c1RTbkUvYklCSVZqYWNwOEFyNmd5UndST2oyL3NSaGFBcGxUeENTbmwzVkto?=
 =?utf-8?B?MDRudllLa09KdjNQa1phWDBOek5aYzQxVjVZeElZLytDMStGdW9xWWttaEpk?=
 =?utf-8?B?cktybG80RHgxRjFlN3hmWUpHU3ZYVkx4KzNjYkJQZXd4U0JtQU1qTnFkUUZR?=
 =?utf-8?B?Tk9QNUk2dWJiYXI2bnFReXR5OWhKbUkyYnFwZ2hTWWhDc1Jta1k5TEhNK0U0?=
 =?utf-8?B?NTNNR3gzTmtJc1VYWTkzQnRJNU1ZZWp4M2RkYXRYUnpaZjBMWXRMU25QWTda?=
 =?utf-8?B?cGhKcVhteG9KRlpBKytxejFhY2pFdklMUExVZnZyYVJZYnlPYVBMc3hNV1Nx?=
 =?utf-8?B?dE03M1VUZzAybHhTYm1VU1JYVktmUGlvY3R3ZTFoVUdNTXA1TG9JVnNRSmZ0?=
 =?utf-8?B?c0hCS1JVRCtlVy9wYStsU29Pcll4VkJOTmRLZnFlRGpVempwOHo4YzhqekNs?=
 =?utf-8?Q?TOZh/XP/5WXVTGndNroVA5vqDu6BJHnVOBkWNrHuE8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55CEE0757C9BD64F8202E007D9D0071A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3d6a8d-cfc2-4755-39c1-08d9f5bd2835
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 04:38:22.0743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvNw5wP2OjqYxTNXWGpK5vb4vQLjWpkYfqSiNyd88iWh9+0S7hSjITTAJXnCdbX7lW0jjeezXiwFI329UvjqA9kWsc+6pioPNQ6mytUsqfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTE4IGF0IDE3OjQ5ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gKyAgICAgICBjcjRfc2V0X2JpdHMoWDg2X0NSNF9DRVQpOw0KPiArDQo+ICsgICAgICAgcmRt
c3JsKE1TUl9JQTMyX1NfQ0VULCBtc3IpOw0KPiArICAgICAgIGlmIChjcHVfZmVhdHVyZV9lbmFi
bGVkKFg4Nl9GRUFUVVJFX0lCVCkpDQo+ICsgICAgICAgICAgICAgICBtc3IgfD0gQ0VUX0VOREJS
X0VOOw0KPiArICAgICAgIHdybXNybChNU1JfSUEzMl9TX0NFVCwgbXNyKTsNCg0KU28gSSBndWVz
cyBpbXBsaWNpdCBpbiBhbGwgb2YgdGhpcyBpcyB0aGF0IE1TUl9JQTMyX1NfQ0VUIHdpbGwgbm90
IGJlDQptYW5hZ2VkIGJ5IHhzYXZlcyAobWFrZXMgc2Vuc2UpLg0KDQpCdXQgaXQgc3RpbGwgbWln
aHQgYmUgZ29vZCB0byBhZGQgdGhlIHN1cGVydmlzb3IgY2V0IHhmZWF0dXJlIG51bWJlciB0bw0K
WEZFQVRVUkVfTUFTS19TVVBFUlZJU09SX1VOU1VQUE9SVEVELCB3aXRoIGFuYWxvZ291cyByZWFz
b25pbmcgdG8NClhGRUFUVVJFX01BU0tfUFQuDQoNCg==
