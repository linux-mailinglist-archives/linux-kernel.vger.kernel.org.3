Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C612547034
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348513AbiFJXcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiFJXcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:32:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93094289731
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654903969; x=1686439969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qAJWEmKe5x3lmJiWlYUv6vX1ci5cQVQcVaCr1f6zYU4=;
  b=djmOJ5b2ZpZHPEzPkIuT02ZnLPUJBs3cZJJzm0Qkpl8s1cUmtGHP5dQt
   nap4rRakKfHkiQz7a/JZQ+6FHZ8IywWkGaL+G/WqDE/JvS6bRWvbAublG
   +V5Xb7SA/mdB7GBSOI0SUzQkRj+EO98nQh9ruAlNN/IA2kKHO/MmZcPBN
   dz6ije+orBmLsPkVc4KGikIuC3zUHR3y4DOPeBtqwdSKi9QNauIkW2/gY
   1ovdlP2TIIXGcrv+QL++28O35ymNciCHDF74u3iEwmtp6H4DAInQOdlh+
   qHafyr5MnSEDHHA5NVoduwdb3vQVuG+nrXgDsdMFcg6ztZJi3UIDeLWNu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278578620"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="278578620"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="638383249"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2022 16:32:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 16:32:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 16:32:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 16:32:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HleYiPGJ1AKLMWA8Po3Fx4mk8buIdKCbuD77+sXly8dniYb8Qhm/h/33Y9RZQEHdeiyv6Se2TyJv3fHXHoJ57e1TyTi9ccxtnLS9f+PZ5Uc3E99jMHDv36uNbbQXZUruqLgnmM7IvcADTxFHuLVkxhASaNVm8/fAEQfRG9qM33Ro/QUDdu23Hkq59VL0Rh2vpo0hsQVtTJ9m9PTX2Z0aZNfr5Su6/Ztvaa8yhsTLFLpXfV08z+G7I6YYBl6CjGGv9G1vSohb7I7rTEoNgFOQMYDMFYgZPD9CCyXUXIdmCqIx3lcUXKQrpY1uNfQ2cHPuD7ncXbFv86dXsi1FvJ6hUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAJWEmKe5x3lmJiWlYUv6vX1ci5cQVQcVaCr1f6zYU4=;
 b=XjvueX1aXXQciC7B/AL5GmpykWoqBhJOF25oDhgQmT+EawOS2aUBsSbGuNw23wwagczb2RehzXYwSO4fL37bEUfW6ncsEvbexn4pzgvf2a7ZfKAuxsFZ6/lcTc0USAo5l9qC8edrBcUD2wJh8uHH2xTae13u7a1QA1WRuSJu9EtyhmERD0/9QcflqaOIuFT9KBn6vsf5eF0aNI+ugReNKUSoEYur/dAsLGs2fsWm0Ta+DEHmpkcu45ZUZo+X8oqmSZO7V8/J0g45LEOAzgTtHiAN7XbjQfIm3EQKY5j77hkRxaBcJ4xwAdcdoASv/FW0aLNEooiaZQyKAc/C+7JJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BYAPR11MB3766.namprd11.prod.outlook.com (2603:10b6:a03:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 23:32:45 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%11]) with mapi id 15.20.5314.019; Fri, 10 Jun
 2022 23:32:45 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 1/8] x86/mm: Fix CR3_ADDR_MASK
Thread-Topic: [PATCHv3 1/8] x86/mm: Fix CR3_ADDR_MASK
Thread-Index: AQHYfNdbuBWYlRzhn0OCWkfXdcT4xK1JSxeA
Date:   Fri, 10 Jun 2022 23:32:45 +0000
Message-ID: <bf0e81ff59a73e6a2f56a04287cb3f62d8d7aa60.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <20220610143527.22974-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220610143527.22974-2-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a06d49c-6bcf-4bd3-a582-08da4b3985c0
x-ms-traffictypediagnostic: BYAPR11MB3766:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB37665A1DD0DC705AD9C8A9E6C9A69@BYAPR11MB3766.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZwNVIX9ZkFZ4Z9UCe8t3fUuM1yKJxEMRQD1qt+oy+HDOjEWP8mCDI/nA4QuaCJdDOPf8h3fkbXiAT2zbPYvqOX8tKHRUK0jMfiB9t0LJA9Xoh7i3lIhDQKL7A3aMhwnFYZ5e8Ba5tp/4MroZv/RfqzHWLPJstg5fbvkFvkGTfsqIcE7FNR6QNRNmIOUc76Bard7o789eZZSjA0zn4+sw+fDqQLwMwIPWPma9Q9VU1saH1An/A/P0qQ3cuetDc+5CVrDhQwDsDIW3uR6jzXTl6yB/Xf3bahnfyTl0h2ey4X5+a8Ob7fEds2zSlIEF1mbhbJkSNS20hmYM0F0IstiTdF0Cq3rGUc/UoUI03ZoJyPGWCZ+SXDahnLT7AVUEl2EyL7bL5eZdzXeenLuSkktYwwGsWZd3sRgNivKqoW0PbIf2tSvx1MrTzjZReIYSbqNhg5V01IOAn2St8eTMs9uz1k9ZNp2i3sbFahJAcSHsGmoXuu53D9H3Vnw4sqCsABhEjoZ4bnJSWOUuoHyuB17I1DPPaxGR9pEtjY9mxoVav2gJclfdjl5YG/iB+D5jkAyOCH/L88j0/xe+xL3CR5M4lEbSB/PcUi+Ah5Z+qfdmoNNj8s6FhknRgRMZA72lOdMG4JNZs8JClayU66UC2udq1e9FcKTIilUqDawAqcpuAlgjdkjMrCaA/Qh+suT2s6HxMLyDyckUxLDvEmu1drfAwDpUmrFBEm1D+TtqjERkvBk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(508600001)(4744005)(64756008)(71200400001)(6506007)(4326008)(110136005)(36756003)(66946007)(5660300002)(186003)(54906003)(66476007)(8936002)(2906002)(66556008)(8676002)(38100700002)(66446008)(26005)(82960400001)(316002)(38070700005)(122000001)(2616005)(76116006)(6512007)(86362001)(6486002)(7416002)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFpFRjNqNDZCUThRNkh3WVFta01QTXBJeCtlSzRrbk1FUkJid3ZLWUhvS1Ra?=
 =?utf-8?B?WURMNGNOTjJuWHRXaHhkKzI3YmRWUjcwUDcwdDNTRTNNSDlQNGZaU3JsSDhH?=
 =?utf-8?B?TUlPM0U4S2tZT2xVeXJhcUdOVmlOWHh5NXI1KytjOVR5UjU2WXduYTd3RTZ1?=
 =?utf-8?B?SHdkVlpzdmgzVlpkWWhpVVRpS29Sc01QNWhqR1c1cVlLM2FVNEgxMVl5YjFu?=
 =?utf-8?B?bGg1WGgyMjMrdlZXTWNjQ25LY29Nckt3YXZOZjBvcHFUQ0s4YndzZTR5NkxS?=
 =?utf-8?B?N28vU0NUdGJ2VlR3NmFRNHNRMnh4UktUN1htYmUyV0s2R3E1U0dITlNpcUJJ?=
 =?utf-8?B?VmRnN3kxM2tiVHhrdmt4U1Z0dnJXaDg0b2gzeVRvMzZyVUxzSzlxOVJ6NXRV?=
 =?utf-8?B?N0E5cDVyUVkzOS9oVmZvR2Fjb0xXSjZUZEh5bXo5eGpjaUNrc1ZhRHFuS0pu?=
 =?utf-8?B?OUhqYWxTa3YxMmc4dW53MlllUTV1WlZMMVRVQVhzWkMxUndFVW9UZGdKeU9q?=
 =?utf-8?B?K2NXUGhzWlJ0TnpVRFdiUVRBRXVqQUpOUSt4VDhRRGE4Qm55Wkx5OUoyTWlY?=
 =?utf-8?B?SFFYNGdzSkNQb3Z3K1FKMSsrUFZnRUJYY0YxSlRNRGFOaW1KWk5NYmc0MW4y?=
 =?utf-8?B?SVVBUmlLSmhwUGhoeWQrVkRpd0w4dUpUbGsyY2o0VEw0SmhDeVdQblgrTS9H?=
 =?utf-8?B?dzQ4d25EUDdmdy9kMXpqNUpaMWRlcXRkRzRrdW1pV0FycHc3RUI3QU03b2Er?=
 =?utf-8?B?YjFhSk52V3l0ckppZ2VmeVZJRTU3OGE5M2J3bkxZamh4NlZvVndOQWU1cFA2?=
 =?utf-8?B?bDRucnJmVU1WcldSUkFEYXQ0M0I4c3FiSEEvR0ZRVmMzeFBuaUNQYXhkWFJZ?=
 =?utf-8?B?bkxpcmMvMmY3U2lsSElhczhrSWZJMy8ycEFNSTROWFNBM1hnNE13ZlE5eUVv?=
 =?utf-8?B?NlREM1k5VjVZL1l0NUJiYnZuS0FoZTBiZklrMXJLc0wyYnJnaUp4eVpMWDNp?=
 =?utf-8?B?R0V1aGVWV1cyenF5YXFuRzRmT3NLTC90RE5sTE9oMCtSTmpLQ1hDOS9ocytw?=
 =?utf-8?B?SXZQVlRlTFpCeWtBTGJrRzFwa0g4Uk8wa2Fad2kwRmdycXNWTVk0SktpWko1?=
 =?utf-8?B?a0phVEtlbVRGVngzOHF3Z1lwRWZLUWRaRnlNU2JSMW8xY2FkamZ4Z1NkcEd2?=
 =?utf-8?B?c0h5M0ZUZ2gwSkp6dFpKQ09ibVJpdjJHU3lUcGlFaFlIL1JOVytQaDNXS3VC?=
 =?utf-8?B?VlM1amdnMWpkSlZiZWphd0E2Q2Jzb0pjNmxyd1I4M1Q0MHZmQjlNLzFCZmJm?=
 =?utf-8?B?TEJIOEwyRFBOTzZGdTh3NC9JbzVrcS9UdVBvSFFzSzRtRnZnNTFHSWlqWTZI?=
 =?utf-8?B?OGRnUTlhTDVxRjArMUZjTVVGc1Q0QWl4UXZES0xrcU5EU1RLQ1l3dGJIUHlO?=
 =?utf-8?B?bytjTVV0SzhrZXVtMFRVbEExUzhKNzFjcDFJazAybXZCN2xJL0s4RzNTQ3Jv?=
 =?utf-8?B?ekx6SlE0UlFScEE0ZE5iZ1k1cFNXQmhaRXdySHZjSXdlVE1kb2Y3cElmeW5V?=
 =?utf-8?B?ZjNZZ1NjTm1LTXIvN3prd1psUm9XUkk1M0YzZEg5NDJheStqdU9WR1NWOGd6?=
 =?utf-8?B?SFV6Tzg5TlZhMEpDakovVzF6b2RLbjVkTzQ3c1VmZThhK2owY2xhVEJqeDk4?=
 =?utf-8?B?cGUrUWJJazVwZ2hKcEEvWjk3NEdUdEp4ZmdqUzJlOHhRbjRyQXdObC9VNVVq?=
 =?utf-8?B?Nnlwc0toZ0l5REF1VWxNb0ZkTjZWbkRoM2VYVlh6TjFMV1hVK3BOdFI0WHdW?=
 =?utf-8?B?dzJFNnlKTlZZQnJnTXNJeHEzREVYbmtNTUFZWENKY0xpZXVJVnMxOWw5UnFj?=
 =?utf-8?B?ckRGOUdyN2lGQjV1dGI0azhRQnBTT3BLVjU3eFlyQmFhV0cvRTJmb0tGVWl6?=
 =?utf-8?B?NGgwY2hwdzBaTlgzWnFPS2MwcWIraU5lZFUwc1BER2hCZG9RcnhxazlqMDdr?=
 =?utf-8?B?K1Jicnk5N3lCWVQrR0I2cHhwYnlQZnNHWDJ6TmVaaThJdVV4Q2VNWEJsajk4?=
 =?utf-8?B?eUxDY0xHaVZHZU9YNEVuSzZFRXlJUWsrWjN5a01jOTByTDI3Wk0xT0hacDkr?=
 =?utf-8?B?Tm5yVTR4MnFVQjhqemxyME1hcm44MGkwbFNycnlYZ3YvUStEdmxsQTVtOGZh?=
 =?utf-8?B?L2JtdDZuekZ4Y24valRtZjN4UlpzbDkyTlByQUwvOE5qZ29NQktwOTVPTmRD?=
 =?utf-8?B?Z3dlWmZ0WXd3RGZmWGZ5RVQzWjQ1eTIxTms2eHpHMDVZSzhDQzhZVkprWVN3?=
 =?utf-8?B?aFk3d3JKTyticzZNTk4wYTFlQStsOXdtRlgvclY0M0N1VHFValh6RmMwV0pL?=
 =?utf-8?Q?gah7qIQblaSI7QKdNLsN5qMWPQ7+oLokdzOn3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55F2A9642E301541B6D90790AC9B099F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a06d49c-6bcf-4bd3-a582-08da4b3985c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 23:32:45.5091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCFlRtfzK9CudG9i34aPCsNIa02yO5phRLQtSOr+gminqhegBdjVb5AbuvlSsisnvefvckjV9jwBsqOkUZqszKTkB1VfR/mlldPMFkU9ixI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3766
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTEwIGF0IDE3OjM1ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFRoZSBtYXNrIG11c3Qgbm90IGluY2x1ZGUgYml0cyBhYm92ZSBwaHlzaWNhbCBhZGRy
ZXNzIG1hc2suIFRoZXNlDQo+IGJpdHMNCj4gYXJlIHJlc2VydmVkIGFuZCBjYW4gYmUgdXNlZCBm
b3Igb3RoZXIgdGhpbmdzLiBCaXRzIDYxIGFuZCA2MiBhcmUNCj4gdXNlZA0KPiBmb3IgTGluZWFy
IEFkZHJlc3MgTWFza2luZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1v
diA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS9wcm9jZXNzb3ItZmxhZ3MuaCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci1mbGFncy5oDQo+IGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
cHJvY2Vzc29yLWZsYWdzLmgNCj4gaW5kZXggMDJjMmNiZGE0YTc0Li5hN2YzZDkxMDBhZGIgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci1mbGFncy5oDQo+ICsr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci1mbGFncy5oDQo+IEBAIC0zNSw3ICsz
NSw3IEBADQo+ICAgKi8NCj4gICNpZmRlZiBDT05GSUdfWDg2XzY0DQo+ICAvKiBNYXNrIG9mZiB0
aGUgYWRkcmVzcyBzcGFjZSBJRCBhbmQgU01FIGVuY3J5cHRpb24gYml0cy4gKi8NCj4gLSNkZWZp
bmUgQ1IzX0FERFJfTUFTSwlfX3NtZV9jbHIoMHg3RkZGRkZGRkZGRkZGMDAwdWxsKQ0KPiArI2Rl
ZmluZSBDUjNfQUREUl9NQVNLCV9fc21lX2NscihQSFlTSUNBTF9QQUdFX01BU0spDQo+ICAjZGVm
aW5lIENSM19QQ0lEX01BU0sJMHhGRkZ1bGwNCj4gICNkZWZpbmUgQ1IzX05PRkxVU0gJQklUX1VM
TCg2MykNCj4gIA0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29t
YmVAaW50ZWwuY29tPg0K
