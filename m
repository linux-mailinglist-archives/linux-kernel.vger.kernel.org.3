Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B39546F94
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 00:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348249AbiFJWSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 18:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343938AbiFJWSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 18:18:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9E631220
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654899512; x=1686435512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FMZqyscwaEV4g1xP6/sD+1TtoS6MR/jYDrLK+cYVtuk=;
  b=EYwaXVAPyG3HIplD3g45a8LVbbJmMWb1kf8VtzPxsnwZgNN+fLCxWeay
   8V756AGNbmzR+6JCc9xa5gE19GcS7+DDVgVlZwNaWWzwORhN0UEqx7kBN
   SVI9qdI05bpy93T5KThIqsOikmP4GhBecFPzwOMThpKk+wIj2wpRPU53H
   ZY1yAjFqLBEEwcCKcEZ2YXjzl7QAC1L515sIaVJFuH5MaeyYDJmvqm4z/
   oA5S+kc2AS0Ai/L5QHW5pc2V+s/cxADpq2F5Nt6OzMfzMzCMwZc9JrKXy
   MgQ1l7sNZbQMZM06Zvm5/0eTweCSf8cgZ459qtumcJaKCXZbP2k8PgpFx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="339515308"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="339515308"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 15:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="684791945"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jun 2022 15:18:32 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 15:18:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 15:18:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 15:18:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNwMgZSdGDT73SMyyIoNtMTfsPkyVAFq5sUFle+VKpkKjeVci1dNcEpjCBxJuLZlYfh9Fht8AeAcsSUOuj3nVHNAKgj2WOiCS0atz90075YZEgm47a2PSDM6YC8x+BCyTwVlHfvWQpbbaiF8MWdBT3GnSuSzc48j/YlHu5ifYHxteSzB399TYQ/qWTCdRMQ8iJcanhTf9QYKVIZ8QljTACU0rvsRuzZMx313M9wxNc0lnXdqJhWcC4bo3dzFVDS0glQNsgkk5eBxJUE/c359lJmjR8lRdsPNe/lQcY4nuGLC7IjG6X78TC5HgoF6pYI49MC8wTudl7zx8WPgNkyApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMZqyscwaEV4g1xP6/sD+1TtoS6MR/jYDrLK+cYVtuk=;
 b=HdS5jxV/FSjwp0FYp3ARYGNmwJ9USJjyoS4UCIO8ZCGSJSYE/oWlqd9zkwr0ASt5l49Ve5ZylAEHqHtvTkbd9m5ob7Fk23A2t6ZKHiVt8Vx2pUUfVXttAJpB9hOCwZvdsZOGZEhH1HLVAaWfZ6W0GeLYt3qJEZMfDF4oAghAeaHGsZr2z18IK3QkFjDWO67BeSAxPlJBoMc1b9Nv/E7mxeSuoOo91RI5ZYmReCbT/y+a8dvME/yB0Enu2wCdBdY2aOeGLoRTkFLcPPnfwevXnlu0Ka8MR8buDuDwY2Z04w5THHAsHsQqbWYj5pDu3aNWPt+TtjhaxeHRHK/1PU1swA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (10.169.234.14) by
 SJ0PR11MB5215.namprd11.prod.outlook.com (20.182.114.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Fri, 10 Jun 2022 22:18:24 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%11]) with mapi id 15.20.5314.019; Fri, 10 Jun
 2022 22:18:23 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Thread-Topic: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Thread-Index: AQHYfNjBqEEvHjFqM0aC2BTrZ5Vx5a1I0Q0AgAAe5oCAAABwgIAARekA
Date:   Fri, 10 Jun 2022 22:18:23 +0000
Message-ID: <dda083610d4c8b8d8d0b09021345e9cc0cb35bbe.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
         <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
         <20220610180635.l44opq2votd3gxpl@black.fi.intel.com>
         <5b56c88e477d879e5a0e3c15627cb05901a812f4.camel@intel.com>
In-Reply-To: <5b56c88e477d879e5a0e3c15627cb05901a812f4.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72eade73-4dbb-4733-a330-08da4b2f2261
x-ms-traffictypediagnostic: SJ0PR11MB5215:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB521569AEDF7CF7509E2C32CFC9A69@SJ0PR11MB5215.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BrY+7uMqNukAY42XTCeGi+WtAqLJ5IbMXT37vnTUPLFHGd4ytZb+QF0vimWrJbv9ZY7tbi/UQWSH1nYo3QyjqjGRiFrz/HgDT9kwGiMJy73HILThCfS7JNhCe5IhJ/6spsMXdmPUS3iX/7v+XnEyvNJHzpoaOPyNZCOT550r5MODYSwyiIrWEjL74rbC5ycxk+QY3r3dWQI0rUH1QJgyzGyD0u8d24rOt/KgK0Z2/aD7LxDDj6qt2R/KVS6LeZH87xteEzOVd/7JgdYy1rBOzKyEUMy2m1PmXlRmPgoj76myY5Ld4fxTfenRcDe3FhC+FnFIc4RT+DtXrVki/p/EjPpw0mfAV4kLe8BJn4x4W26EsGWJM+gp9w1WnlvBgil0pxDq03eoj3CdmWTL+/93lDAeE1QeE+RYowr3o9gyz/5QrhmqXio+ItKRXhx9mxpq/8olXZtSnqyKpWpB5w5eb1c2QF1RAG+ElHQtAHTOAXP8qBbaWqM23+J2T3cIAb5hXy5A3KCyVf8OpzQAc9S2bek1Ul3petnXPUAhfkLCrX7e23efBPhtRHlBGQawoWE28J+fREyTmmzrrJe5l6NK1DaQ65dEf0FPFxIMWfTSJJpyWDmQ+OTQFOvwqKCIRj4N2sC4U6m9RqFG8qqm/xf0ZZs+BLx74zHQB7d431kG/ooJkWCHCbrWunPZLICb/0eYmBa4+jbgOAtRConZKT8acwKhOJrjqDBtmUlpdvXo18U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(86362001)(38100700002)(82960400001)(38070700005)(122000001)(508600001)(7416002)(5660300002)(2906002)(6486002)(316002)(36756003)(8676002)(66556008)(64756008)(76116006)(71200400001)(54906003)(186003)(6916009)(66446008)(66946007)(4326008)(83380400001)(66476007)(6506007)(2616005)(6512007)(8936002)(26005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlR1dzVaeWVDVGNOcm96SHk3ZzlGaVJocVNqVzVxdzdNcVdjSkgwbktzOGNo?=
 =?utf-8?B?MGFzSkc3NVQ0SWhDbzdZZi9yaHgzQXNSR2lycWlVMXpoTGpLSDlxRXFFODRw?=
 =?utf-8?B?QVVGaE1PQXR4cHE0VHRCYTFxQmpPT3pXSE1HdWsxaFNKbkozS1RmaUVQZi8r?=
 =?utf-8?B?MGpvSGd5UC8zTWExQjZRaGptQng3UTJuL3c5QjdTbzc2cThOWnZObGYwTWJq?=
 =?utf-8?B?RXArQW13b2UvczZkMVFUbUI0YlA1M1BGYm1yaUdCZEFaVDFnbCtJTlJXeWVK?=
 =?utf-8?B?c0pNUVliVzlTWW01UU9QZFJ1Z0ZFUUVqbjdMcmE4cXVXRi9rR3lwa3RKWjFz?=
 =?utf-8?B?QTFiSWNMTzl1bUlGOStWTkV1WVNpTVN3aUhIVVhoOHl1bzBCWi9DdXBhUEVU?=
 =?utf-8?B?VDFKUU04d25GSFBlRWFyUno5Z09xbEp1WHllOHkwNjVUeFhRNWl1dzlJWUlB?=
 =?utf-8?B?eTNYaHFKRmZ4YytjK2grdXFpRXlrVjAyRmFyNnJIazY2bG1qYSs3UHdyM3lO?=
 =?utf-8?B?aE05Y21ON1BmaWl1VmtVOWZBVTNIY3Z3SzRqYVVSZC94Ync1dEkyMnl5Mzl0?=
 =?utf-8?B?ejIwbU9Ka0FWQ3BscW1iWFQ4Tk9ON0lQeEgxaXp3b2wwVXd2YVVINEFNSjVP?=
 =?utf-8?B?c2ZJaHg2YSs1c2wvQXN6MTFuTkxBOS8yYmg4RlNjMGM0WGVzWE5yWkhSaXly?=
 =?utf-8?B?ZzQ2VmNzRFhiYnBPSWlGOXRxZ2FmZzZnMFhnV3NOS2ZXY0FkVnBIYXplTjZP?=
 =?utf-8?B?QUlIQTdKS3RURWI5QWpZMzhjQktJUklac01pSklJWXFod2FmVllCRWJBeWx0?=
 =?utf-8?B?ZGNQV1diL1pabmRoVGlxNWVJWk4rNHdOUU9LbzJPQ2QvenVveGhLdUdDL0lJ?=
 =?utf-8?B?YzVoNjB3cTdTOGpmK25NdCsxdDNraVBBTGlnL3JWNm9NSEl4VUt0ZDB0bmpi?=
 =?utf-8?B?cUZpdkllNXIwdzNMSDQyQWNWbFRZbDVLUTR4VFpUNGxSeWdJdzBrMWRvblZI?=
 =?utf-8?B?Q3RvYzdNQ0U5NG9Tc3hLS2d0eEVFNWltcGZxaUVhSC9sZ08yaWhpN0MrYU4y?=
 =?utf-8?B?SWtxVFU3cnV3NEUrL3lXYzROWHVuaXhDU2lVa2lJL2tPblVPbDMvNHJrRHRo?=
 =?utf-8?B?aWRvY3c4K0JMMW1QcU5Yd3lxSHRpVUVrUUY3eHEyOXVSbkRieUh3ZG9udDhn?=
 =?utf-8?B?RnNLZS9OcE5kSHNRVHQ4ekVCUmVaKzExb3RSeGlrYmtrajJwdUdhdURYdVR6?=
 =?utf-8?B?cWNlbmxVVUtaYk9SWHRhL2RqazFoNEtMYlNvQ2VRZVZTNWwrYXIwS29oaXU5?=
 =?utf-8?B?a1FQT0xOekVzY016TVlDNDMvdEJBY2ZrZHZpbVA1S2k5L1EwZlA0K2J3Uk5t?=
 =?utf-8?B?RTRCeWMzNFlmTXUybEFWak5KOWNxQWNMQ3JJV2lBTDE3MjRKZjdreEpRaGJJ?=
 =?utf-8?B?bDVLcE5KVlBHbHZxQUFqWi9idklLNHR0Z2twaHZjSVRZY0dyemZKSFpTMTBa?=
 =?utf-8?B?alk4blpCNXp6WlRkVm1qaTR0RjdURnJwWGxwUlpIODhUL2FrandnSlVGa0la?=
 =?utf-8?B?ZkhoZlhpeWJLMWdadFVwZFEwMGFtNzI2UlRLSksrNzIyQjQzQS9XQitBdlR2?=
 =?utf-8?B?cGRrTTVSV1NrbjRiZDNyR0VuYXYrbllIc0xqZUo5eG5mS0I0ajNLZUpNVG82?=
 =?utf-8?B?WENVLzJRWU9ZZ1pGNlhCNUNKU2xtSDZ0a0pTS3M1Um03Snh4MFNzdjkwZDRk?=
 =?utf-8?B?OVV0T0ovMVNSd3hEZXd2TC8rWEoyMHdyRGd2dzZKMVllOEQvY3ZPUFl0elFR?=
 =?utf-8?B?cmNWRjh2MnZsQlhkUjBLOEk4VXFMSUtRUld1WUlvOVBsMVRLblduYU93SkY1?=
 =?utf-8?B?U1FqR1BYOTVvRmtqTVdNS01hckUvWms3MlRwMUZYRC9MaGduVDJ5MDBTOFVX?=
 =?utf-8?B?VkF2UWdHZmRndkVzWlRLNUxwTktxQnRqVVZGcitNTHdmUFZLTEdhWTNPMDdq?=
 =?utf-8?B?SDg3UHBmT1JKVnRYdVVsQ2dRUXVMbW54Q2ZzVlowdnYyOGJ2V0xVSmtsQUtD?=
 =?utf-8?B?dUhXRGhwMVlGSXpWSm96enFZUEpzWlZtTXAzOWFwc1pzSHE0WEN3YnEzcDg1?=
 =?utf-8?B?Qm1xNFpuejFSUW5NMVdkNW1FT0t2ZVlvZnR2WThmT245MitWbzdNbkI1Yi9l?=
 =?utf-8?B?ckdtdDdVT1M2MG1jcTNDR2NkMWh5RWR2WUNwV2V3cmlvemxzZGhSMWI4YU5I?=
 =?utf-8?B?NFV1RkwxYUhXQy9KODA2WEdJeE9ESWRlR1Q4eUZTaW9id1ZwL2xTVWtwZlNL?=
 =?utf-8?B?S09IZDF1R2xiVHl2aGVlTENqU1BoMHd3eDY0alRvMEVhSXRqdmpudzV1YnFM?=
 =?utf-8?Q?/Mi0K3I+yhS4yjNOeReNHo2SBhW1Vbx5HTKem?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9B307BBCADE0E4C84F8428137466470@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72eade73-4dbb-4733-a330-08da4b2f2261
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 22:18:23.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /iqdDSnP3alYUrlhLc800GE00NMKniQesdt5NHDU/GK8q+QrhUXs8Eoncw1EykB4AIuJrJ+gzFDyC2nbrVqnNSe/GFmULePW9plepsjT8YQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTEwIGF0IDExOjA4IC0wNzAwLCBFZGdlY29tYmUsIFJpY2hhcmQgUCB3
cm90ZToNCj4gT24gRnJpLCAyMDIyLTA2LTEwIGF0IDIxOjA2ICswMzAwLCBLaXJpbGwgQS4gU2h1
dGVtb3Ygd3JvdGU6DQo+ID4gT24gRnJpLCBKdW4gMTAsIDIwMjIgYXQgMDQ6MTY6MDFQTSArMDAw
MCwgRWRnZWNvbWJlLCBSaWNrIFAgd3JvdGU6DQo+ID4gPiBPbiBGcmksIDIwMjItMDYtMTAgYXQg
MTc6MzUgKzAzMDAsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gPiA+ID4gK3N0YXRpYyBp
bnQgcHJjdGxfZW5hYmxlX3RhZ2dlZF9hZGRyKHVuc2lnbmVkIGxvbmcgbnJfYml0cykNCj4gPiA+
ID4gK3sNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbSA9IGN1cnJlbnQtPm1t
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgLyogQWxyZWFkeSBlbmFibGVkPyAqLw0KPiA+
ID4gPiArICAgICAgIGlmIChtbS0+Y29udGV4dC5sYW1fY3IzX21hc2spDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgLyog
TEFNIGhhcyB0byBiZSBlbmFibGVkIGJlZm9yZSBzcGF3bmluZyB0aHJlYWRzICovDQo+ID4gPiA+
ICsgICAgICAgaWYgKGdldF9ucl90aHJlYWRzKGN1cnJlbnQpID4gMSkNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+ID4gPiANCj4gPiA+IERvZXMgdGhpcyB3b3JrIGZv
ciB2Zm9yaygpPyBJIGd1ZXNzIHRoZSBpZGVhIGlzIHRoYXQgbG9ja2luZyBpcw0KPiA+ID4gbm90
DQo+ID4gPiBuZWVkZWQgYmVsb3cgYmVjYXVzZSB0aGVyZSBpcyBvbmx5IG9uZSB0aHJlYWQgd2l0
aCB0aGUgTU0sIGJ1dA0KPiA+ID4gd2l0aA0KPiA+ID4gdmZvcmsoKSBhbm90aGVyIHRhc2sgY291
bGQgb3BlcmF0ZSBvbiB0aGUgTU0sIGNhbGwgZm9yaygpLCBldGMuDQo+ID4gPiBJJ20NCj4gPiA+
IG5vdA0KPiA+ID4gc3VyZS4uLg0KPiA+IA0KPiA+IEknbSBub3Qgc3VyZSBJIGZvbGxvdy4gdmZv
cmsoKSBibG9ja3MgcGFyZW50IHByb2Nlc3MgdW50aWwgY2hpbGQNCj4gPiBleGl0DQo+ID4gb3IN
Cj4gPiBleGVjdmUoKS4gSSBkb24ndCBzZWUgaG93IGl0IGlzIGEgcHJvYmxlbS4NCj4gDQo+IE9o
IHllYSwgeW91J3JlIHJpZ2h0Lg0KDQpBY3R1YWxseSwgSSBndWVzcyB2Zm9yaygpIG9ubHkgc3Vz
cGVuZHMgdGhlIGNhbGxpbmcgdGhyZWFkLiBTbyB3aGF0IGlmDQp5b3UgaGFkOg0KMS4gUGFyZW50
IHNwYXducyBhIGJ1bmNoIG9mIHRocmVhZHMNCjIuIHZmb3JrcygpDQozLiBDaGlsZCBlbmFibGVz
IExBTSAoaXQgb25seSBoYXMgb25lIHRocmVhZCwgc28gc3VjY2VlZHMpDQo0LiBDaGlsZCBleGl0
cygpDQo1LiBQYXJlbnQgaGFzIHNvbWUgdGhyZWFkcyB3aXRoIExBTSwgYW5kIHNvbWUgbm90DQoN
Ckl0J3Mgc29tZSB3ZWlyZCB1c2Vyc3BhY2UgdGhhdCBkb2Vzbid0IGRlc2VydmUgdG8gaGF2ZSB0
aGluZ3Mgd29yayBmb3INCml0LCBidXQgSSB3b25kZXIgaWYgaXQgY291bGQgb3BlbiB1cCBsaXR0
bGUgcmFjZXMgYXJvdW5kIHVudGFnZ2luZy4gQXMNCmFuIGV4YW1wbGUsIEtWTSBtaWdodCBoYXZl
IGEgc3VwZXIgbmFycm93IHJhY2Ugd2hlcmUgaXQgY2hlY2tzIGZvciB0YWdzDQppbiBtZW1zbG90
cyB1c2luZyBhZGRyICE9IHVudGFnZ2VkX2FkZHIoYWRkcikgYmVmb3JlIGNoZWNraW5nDQphY2Nl
c3Nfb2soYWRkciwgLi4uKS4gU2VlIF9fa3ZtX3NldF9tZW1vcnlfcmVnaW9uKCkuIElmIG1tLQ0K
PmNvbnRleHQudW50YWdfbWFzayBnb3Qgc2V0IGluIHRoZSBtaWRkbGUsIHRhZ2dlZCBtZW1zbG90
cyBjb3VsZCBiZQ0KYWRkZWQuDQoNCg==
