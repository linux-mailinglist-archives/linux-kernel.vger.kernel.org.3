Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58040546A30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346328AbiFJQQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbiFJQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:16:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D82731DF3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654877766; x=1686413766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MoCnpa5Eog9R8DG45kC2D86zSBmqjVHJekzRRT9wvh8=;
  b=Ad6qNE7OHYhnaa7pJAi+iZ4vPoEfmFXV7QX9AR0hxm9HWr+3afDw6WNL
   SrBhU4fbvNJfUC4TQitb/lI8sUIJmOneBffx8Fh+L8jP8MdFjGeCJt+iu
   Dc51u4uzSdwQ+SAWQ+L4VEsAiFy7H273E9r4W11d2cn+3qSams7D2tAMF
   ufDO4kWWd6H+HUNvhIudq+keUp8s4w/wJ+w13REHBFvzHLUg+T7ria2rN
   uG/l152L8kG2vde1vVxk6fqQbhi09Puiw0+u2CtkoamoGF++D7bieLXSP
   uYVaqRxn3yScwNJvpdHy+FI4Hz0qEaqUwRTiT/nkeLgubia9xnmc/2hrQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278470974"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="278470974"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 09:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="638199471"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2022 09:16:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 09:16:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 09:16:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 09:16:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkQ7mafOIFcsxYNpAE1Y6sIvDbrtvt/o6G1Pzvq8QAgINOwc97KDCpIp/jeL7nWV54CNXg16JEquLEH4pXMN6SV5NYFmVVCleOfZCoX7HNDg0Qkf/mNMZhzq4Wz3EBm1SQdXbOC1Dd0Vlv6q6/dGCRSm9wN4KkuJ5ZPirUh2i7ZVPjx4g6RMjfSnkg4VZARE3WalUVIbRk/bR/1IqJi5jQBxCBX9fVgSMpusQCKx4yyyPgrAWYTYtFPHJhi7Hd14v/bPYhpze0usQzJIoW7iMBudv8xJREYixWVOOCmDyiEgRXKZI6+2qexYCopMDbIhqt9jnFVWA0ZtEzdUkxlnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoCnpa5Eog9R8DG45kC2D86zSBmqjVHJekzRRT9wvh8=;
 b=LuXNrPpn6JiDwDSRnkhhp9JJ1944HsubNQ+JsFabGVVXod/Qu0AarmAlh5alhrG7euc3wSkRkw2ehuHkARIoh7oqy02figSdCKn7E+SPRkE8pPWkme8Ee/R1buNSYbq3IetXrbcx4DnOSWDFkCmt3TyXcCMSaiIIR5TBTqQnu1lu6WsoA4PKHMVsRHl7nEQ/Y8+kf0MvQHa2UwOJySDWu6rGeEbEKRhd4TKAhz1BeqVg8uGyrf65u77NGpG0FPBH9V3upu5Mqso9FQoEp5iqSnroMAD8Giue2eemkXC/NS9w7xDSVc5OM7fU7sjzY98v2npxtyoPKXMYp8dEwrJlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN0PR11MB6035.namprd11.prod.outlook.com (2603:10b6:208:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 16:16:01 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%11]) with mapi id 15.20.5314.019; Fri, 10 Jun
 2022 16:16:01 +0000
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
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Thread-Topic: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Thread-Index: AQHYfNjBqEEvHjFqM0aC2BTrZ5Vx5a1I0Q0A
Date:   Fri, 10 Jun 2022 16:16:01 +0000
Message-ID: <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b66c551-2b3b-4397-b5b4-08da4afc82c6
x-ms-traffictypediagnostic: MN0PR11MB6035:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN0PR11MB603568986D68E7E607D79326C9A69@MN0PR11MB6035.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XEvwhzG9TpDxpUSb/bU3W2J+a5mJu4rYcDnm3YOQqach4IonMeaQiFLMxvw6WoehDm/U2UjiTzNnnLdKuDIOndHA7Anddx7gjFReCi430xhojIe8fMsUGVkyd3sjD3JLAFUOnMkhtmiwQOCYzCcK/tFaQCrXTnsXo1eyE7/Tdq8EMtJoB/0/DCbn3WC9aDAEC8nHILw3nlfVjFX/67hxCioonv41ikCJSU2IQI609Wg72Qr66xK/DTbI5vdFo79zCD++nL4pdtvI1kdXDvpkk8U3DQQzXoB7CLIonhiHpI3gYbRHICyjgGEhmISIeJ9gYWQSDmJGPr3bn1jK7h4VVCxAOeP0xguOVtDbwtw07xqqw+aW/5a3PzE735BOgX9BPyhcZLayhymrxZOCDqWHcnEQ007OsRdrh4/bKK/lHFAFfeOjgkxWc+swMC5hlNuAWLcQwPtiEszxmyEdpDxZF4xZxSEZplH2wBUsPWisEaTAvtWYfKQcvx31U4e3U/rFnWR8FZJQXdLo+cfX54f5nOvpcbtKNssXfDSZC4GNdboH/DL5HaEzhkf+8rDmIJb0RHrleFB9k1sFMtP6Y7IXNd1v5EHQqRN7+qkBoiGoqZ1zaoakXL23OhE/KLkrO9gNO2zYMdb0Rnm7ZgFXVVrrchYwAl0zgeSe6eY+sUEFGdTMt53KXXBe3WTFNqW6x6BE2D5l2V/zsJBqhh3zjCIQQnSh/ecY28JleN+4c52gZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(26005)(82960400001)(6506007)(8676002)(66946007)(66446008)(66556008)(5660300002)(4744005)(4326008)(66476007)(64756008)(7416002)(38100700002)(186003)(8936002)(36756003)(2616005)(76116006)(71200400001)(508600001)(2906002)(316002)(6486002)(83380400001)(6512007)(38070700005)(86362001)(54906003)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWI4WEFnUHlYVk5RekFFSVJ2V1Y5MUVjNm1vZ3Iwb3NvV0NDN21uMHhmRjdt?=
 =?utf-8?B?VXJISDRsK29lbFhXUVVWb2p5YllmUURlMzJsYjFqcDhmdm9MOHNQVzVRNTRt?=
 =?utf-8?B?KzBNNXZpYkJVWDdXR3R0OHNXOE15ek1mSVhqSGpCUUlHSFY0bnhRdVBVY1Ay?=
 =?utf-8?B?R1lhbW1raVlleVRSeUFWT2g3aXN6SGFERlFlUmRvWVNOd0wyTTJQbXo2V0NB?=
 =?utf-8?B?L2ZSa1RpdEh6aXBEUlFyNnVsS3hrdzhHcjBwS3ZzZmhKdlJPNUNSWnN1enFP?=
 =?utf-8?B?cEQ4SzZpcjJnK1Y5S3BqSUdwZHQ4VExnQk0yYlZrRWZIZHNjNTZKN04rd1Rx?=
 =?utf-8?B?OEVqbWQ5NDl6bWZNREIrdzFjRVUwREZrZG1XcGZVZFUzTlpEQ0hKa09TWGJk?=
 =?utf-8?B?KzJwM2hOMXpwRkFLVVNiREVtZDE4Wk44bkhKTFk1c3RxdlJFaG5iUGxuQ3d4?=
 =?utf-8?B?bU4vMElaL3JPU0JxUEpuejQrL0tuajFTOGQrWktPN2JycUxIUmNmRUs2Z0tS?=
 =?utf-8?B?K1ZpK2FENEVhMFhpenBMbTZObldvMlMzV01PNjVUNjU0V3R4d01QNjkvQ3VM?=
 =?utf-8?B?OE1ieWRTZDViQ0tVNkprNHdrYTZvUTMrS1J5UTc5cDREcGNKNW5ZWDdPNS8y?=
 =?utf-8?B?TDFqaVpiTzVLMFZITHFaYnRtajQ3T0VjMVdsUEw2QXVlNjZodjZnTENHMW1R?=
 =?utf-8?B?dnhsTjJsNTRhczEwQTdQaU9Ra3EwYzlIM2hST1RSbURzdWVmY2hNendRYi83?=
 =?utf-8?B?Z2kwMUNJVHplMjhRZnUwUVg2N2Z3SUhBZTR0SVMxUVpvNWV4dEkwWG9WZUFG?=
 =?utf-8?B?UEtacEt2bjl2N3hLMW9Dc0hqUmlnYVg1V0xEVEZHUHZweGcvWVdEZ2J6ZzdW?=
 =?utf-8?B?TjlhWmFGdllERldWaSsxNGFrUzhSMW5hZW5GSWZIL3gybmhwbmcwZ3JkNklJ?=
 =?utf-8?B?VE05cENZUlFXaUtMdVdqemhCamNyaURjeFpXaG5oNmU4SGpmREdUNmRjUVBh?=
 =?utf-8?B?dkNoV0RwZEF4YnlZcWhudTFTVGpUSkxzL3FiU0Zra0hNYzk3STRWUTdGUEln?=
 =?utf-8?B?T3JMdEJLWTBUbG5IQWJXMGhNWXRHSHJnN0NlaHpralBoWkt6RGZoeElYZ1Fi?=
 =?utf-8?B?bW0vLzE4eCtCcDNJb2pKNG5TUEtxTmYzdnpZNUprcTNYbTBGbHVMK3lPTGtK?=
 =?utf-8?B?U3pMbTZUZEo1cGpXQkR4WG5LemxIZEVPTTlDODVtZFNTNHhkcXNOY0F2aVRD?=
 =?utf-8?B?NXcwMUR6WXZPR0M1SDAzRXVmVWVQZDh3dytCL0hoWFMxTjNvcFNnaU5rd0sr?=
 =?utf-8?B?SzA3elNnMEE1T3o5cDNpSHYzbDBtTVZVTEEzT1ZSQXRBbmc5N2xWKzdtVit6?=
 =?utf-8?B?c0ppL2Z5QVU5WjcvVGpOMGpZeUxwTnN6Z2NDUmJlSUdQRzd5MGphWThmd1JW?=
 =?utf-8?B?ZUdCRHFCQnVUWWQ3UjF4U1ZrTmtLb3YwYXZVSHBWVWZHTURGOVdnZEcvSTN4?=
 =?utf-8?B?Z0FTYXBxWnd4K2Mvd2JCWkhjUDYwZTBuZHhWT0p0QVBKd05PdkluczR0MVBB?=
 =?utf-8?B?bldtNWZZTE9TZkl5YmZiUkFteC8wMENaYUFBSDIzQzlGUWI5dWcxMWdtWE8z?=
 =?utf-8?B?a3Z6cFNQNnZhc0xtYWc5NzA1V2VodnZncWxDTGhUa0JpT3ZaTWY5MlVxOXJz?=
 =?utf-8?B?azhOYUY5bnpSTmtMZDZOWmZXS1NnOU13M1BJK0FwcE9VUzhIRXp5cEovSVlW?=
 =?utf-8?B?aFJBRFpTSHVGaTJ3UDU5NmJpMjVDZkkrWjR4bG5xeFd3TldaVHF0SWltNEE4?=
 =?utf-8?B?L1BLa2Q1Vmo0RjdPdSt1UVFQb2REbmc2bmNBenhIb3ZzZEtsTVZEd0gyYWhO?=
 =?utf-8?B?Tis1Y0lHQytndjIzZVlWdVhGWE5ublU2bU5SS2c2MEVpTFZPeEVlOVhPNlhF?=
 =?utf-8?B?TDYxOWhTSmZIeXdHbjZQTmVGQk5QNG5Kdk5VY3FNM1JNQmJGQWFGUjdVdXIy?=
 =?utf-8?B?eHozOXRFVHNIU0J6VEc5UVM4UllnZVhBWTFnWEdWN2xoMzJseENrLzFtZUxX?=
 =?utf-8?B?WlJpQndEbkJpTjZyWVNKa1FXeXFMK20yZGRLN0ZCZ0tlNHQvLzZlMTA5VnFx?=
 =?utf-8?B?SDdGYmJmeitsTXB5c2YxTlhQVmNXQjRHQXJPZ1JCUjhPdWFZNFovV1k1elRK?=
 =?utf-8?B?UXkwZ0s0NEZtN1JFN2tFZmhvdW4ybVVDZXRuZXM1ZlJYSUMxOThBOGQ1WFZx?=
 =?utf-8?B?bldjK0FqeExGdTZHQW1uSWRIdVVEUyt4d1d1WXF6Nk9BaDBQODdEeVpCbW80?=
 =?utf-8?B?YkVFSHJQamppd3ptYXl4RE4zc3NTbzFFc1N2ZjNZYU1PUGtubEtENWtOMUJY?=
 =?utf-8?Q?YwPgwEqJQkpSnmPiJ6kfjAfZN3/Y0OryumwO5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9566B821C66E1144B6DD65CFF4D8F77B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b66c551-2b3b-4397-b5b4-08da4afc82c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 16:16:01.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LoZdQ+jEMchpYnt1Ixx2fvWRhRMv88B4DuCrLmtwHEYDOr+1/GHtctFNllKxbf1vEGAWut3isQnH/V6axs2yPhKB5VPsIS55gL1fPOmHXck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6035
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
dGU6DQo+ICtzdGF0aWMgaW50IHByY3RsX2VuYWJsZV90YWdnZWRfYWRkcih1bnNpZ25lZCBsb25n
IG5yX2JpdHMpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50
LT5tbTsNCj4gKw0KPiArICAgICAgIC8qIEFscmVhZHkgZW5hYmxlZD8gKi8NCj4gKyAgICAgICBp
ZiAobW0tPmNvbnRleHQubGFtX2NyM19tYXNrKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1F
QlVTWTsNCj4gKw0KPiArICAgICAgIC8qIExBTSBoYXMgdG8gYmUgZW5hYmxlZCBiZWZvcmUgc3Bh
d25pbmcgdGhyZWFkcyAqLw0KPiArICAgICAgIGlmIChnZXRfbnJfdGhyZWFkcyhjdXJyZW50KSA+
IDEpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KDQpEb2VzIHRoaXMgd29yayBm
b3IgdmZvcmsoKT8gSSBndWVzcyB0aGUgaWRlYSBpcyB0aGF0IGxvY2tpbmcgaXMgbm90DQpuZWVk
ZWQgYmVsb3cgYmVjYXVzZSB0aGVyZSBpcyBvbmx5IG9uZSB0aHJlYWQgd2l0aCB0aGUgTU0sIGJ1
dCB3aXRoDQp2Zm9yaygpIGFub3RoZXIgdGFzayBjb3VsZCBvcGVyYXRlIG9uIHRoZSBNTSwgY2Fs
bCBmb3JrKCksIGV0Yy4gSSdtIG5vdA0Kc3VyZS4uLg0KDQo+ICsNCj4gKyAgICAgICBpZiAoIW5y
X2JpdHMpIHsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgIH0g
ZWxzZSBpZiAobnJfYml0cyA8PSA2KSB7DQo+ICsgICAgICAgICAgICAgICBtbS0+Y29udGV4dC5s
YW1fY3IzX21hc2sgPSBYODZfQ1IzX0xBTV9VNTc7DQo+ICsgICAgICAgICAgICAgICBtbS0+Y29u
dGV4dC51bnRhZ19tYXNrID0gIH5HRU5NQVNLKDYyLCA1Nyk7DQo+ICsgICAgICAgfSBlbHNlIHsN
Cj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgIH0NCj4gKw0KPiAr
ICAgICAgIC8qIFVwZGF0ZSBDUjMgdG8gZ2V0IExBTSBhY3RpdmUgKi8NCj4gKyAgICAgICBzd2l0
Y2hfbW0oY3VycmVudC0+bW0sIGN1cnJlbnQtPm1tLCBjdXJyZW50KTsNCj4gKyAgICAgICByZXR1
cm4gMDsNCj4gK30NCg==
