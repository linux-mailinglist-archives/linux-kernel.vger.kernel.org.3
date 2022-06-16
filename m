Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985A254EDA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378907AbiFPWwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378512AbiFPWwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:52:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB241A04C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655419960; x=1686955960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=82Oy0CEQsVeqYYYAofreddCXB2NdDKhBIELwX0MrIC8=;
  b=kk+xGrnZ2zMO+fKqdXpho0ASS5uURV3c/Fklq4QHOp6ZT30LW/ud8ULC
   kMKjckTHiAxJWvEauFL09i38LueJXI9kBn+S8M3fxaGuk6jVZ4mxNxjjE
   BXGq1BxOXo4OOquqy12jIr+u5Z4fiDDljO1JHjl1pHTHPG5iVgH3Jafxw
   xIYExMneoCKwuKWyBMt1wpE9lIPrdM0PTFJprhwxDn3UGlCN6LxS/W44g
   1ZRhUcdslK9+EFfbdGuExgeFQP6gpxRg5Bk4nhz1WFyYaEYBOex6SxceA
   v/5BYW7R4afVZ6JZIZ1Opewx3+DBh4vjInRHOXg9UUZZzvtNJd600kHD3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278166390"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278166390"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:52:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="675231909"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2022 15:52:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 15:52:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 16 Jun 2022 15:52:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 16 Jun 2022 15:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNkpucCRUOM/ozG8WApKgGa0RaSTqCZzxMIe1/qstp4jUi09Rlm8mozRW8MunUQzKt7BR9jXHa6nfyJSPcELtHQzL+0hNgP9CCeaqjNTYgtkTbzd7b4bDEwkoequizMMjsIB58JePLoa9PHMVTN6FBjanyCuEmT8XPZkPNzIjnL+MNZ8OALrVzsqtHb9yyXY8YQVQ4TYoceekg5oKir8w/Uf7bOZ/kydo6tgEOAOP3GO9Pc9+a/Vgn1eV09RSQAqeN0iCll1QF6CmdxEOt4FtUzoRnbeWpiRd8fcQgSPHulcCwRPUV8nJvkljnl3a5YmWG+0OVYDwnzByzY7tSlFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82Oy0CEQsVeqYYYAofreddCXB2NdDKhBIELwX0MrIC8=;
 b=FE2cy0wsP355X+d8YrrK7DAaDbhurryOdfdKdsKhxKKY0IaYZs6Vy5yTltLG96/KNGnw72Jt+fkiE1PM2OtlTKUmKNUD9oJaiFdGK40BlJ02HieXEVG0nZHfQkS9ELjmLUQBMK79NtYrz66+f9NT+pPJAwr+PU4CVHZpyz1qcGPoQ3yOKv3tPQigCzjy87DqL59P/tXJBkFHAW6uxPNZfv54GCDrS9nGNUnluyTOw/COKVRVnx3HLayNF4HuUtJ9uXAx7+0jYlP4TbDtUf+mrgyaLbIRxbJ94PZUT8nLSiTYNLS2YGCu9ZZZpXWGF+QB68U6mQRgueH1uX3ZycfqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1383.namprd11.prod.outlook.com (2603:10b6:903:2d::13)
 by MWHPR11MB0063.namprd11.prod.outlook.com (2603:10b6:301:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Thu, 16 Jun
 2022 22:52:14 +0000
Received: from CY4PR11MB1383.namprd11.prod.outlook.com
 ([fe80::4d77:ae24:577c:8157]) by CY4PR11MB1383.namprd11.prod.outlook.com
 ([fe80::4d77:ae24:577c:8157%11]) with mapi id 15.20.5332.020; Thu, 16 Jun
 2022 22:52:14 +0000
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
Subject: Re: [PATCHv3 0/8] Linear Address Masking enabling
Thread-Topic: [PATCHv3 0/8] Linear Address Masking enabling
Thread-Index: AQHYfNjFGdTdbAcQSUuXYNy1+ejGKq1Srb6A
Date:   Thu, 16 Jun 2022 22:52:14 +0000
Message-ID: <fdc44a96f0734682338930aec4884d9a2b39650d.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42600a66-83a1-480c-d1ca-08da4feadb1e
x-ms-traffictypediagnostic: MWHPR11MB0063:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB0063EE13CDA6B49C5E5EB68FC9AC9@MWHPR11MB0063.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFqIfw2O4YtSoZEqzxys/06DmOrVP1YUZNyhaRLsWd3XOOumIyxmA5J5+FBrM0304MW/+C8sUB/qVujwBhkxcpZYRObAGToBJNgKnIybg985d3c5Mai8biPNC3erUh2/CTe+ct9YMZ3UySagt60I2bu1nPab3/ET58H5tbhFstjSERLVJs2gtNyCin3w77BHusMLYt7N0wtK/b1otSVDKwy0jB9ZfUjq7U0K019HnfjCOP+oTMIGKFUnJh1/AZEEEpAL21Q9uQDQkKZjG+emoMrm3TZUKD0E/8mPMxpXBLvCrZ+ALkhMb26m2SdCemvrBszR7EgUwjnhwZyClFjEVICGMALZzGTV7S+g0xXU/PTO2AnD1Dup7Rf2vZUUHg5TBhNbF41Uqs7QbpP2/Xt5tocJ58ztVQwE5+JklTYbYKLidPbeaSUiMce+hLouQsr/HtG6B5oNB5+tO2jdXf8FQUNnTHkQy4vBqIgHl6/mFdm6TgDcEMIJkoHsTJtEKAdB/GS4K4tp+qJv+vwAHHNOPGLX5meh9/99pI94DyJitFMCKenhO1WwYgFSuuo9ojMNfRWhBdfjSRcNHhiIk/a9Ft3eDaHyt12j2LKpqVOAoQ+sApTdfR52AXOwppxWnFEy/xE54+91K/H7XjxuQzzn86mrGRAul+SMsehAjuoE6sgWUBpoJbGdc6B10mgIF1ZButru8VegAu//pp1OwurK6gcm8LUmILFajOqS63m9aTo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(82960400001)(316002)(186003)(6506007)(8936002)(38100700002)(91956017)(71200400001)(6512007)(26005)(2616005)(54906003)(122000001)(5660300002)(7416002)(36756003)(8676002)(86362001)(38070700005)(64756008)(66446008)(2906002)(66556008)(6486002)(4744005)(110136005)(66946007)(508600001)(4326008)(66476007)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SytMaFdvQndJOThzSitHWlAwKzR2VUI5Z1FENW9rYmh2R0oxZ1VSZGJEaUJp?=
 =?utf-8?B?cXNYMHpwVUdOSjl6VVh3MmVUNnpjWjZET3BHK1RHTVJKdGVHOTFXb0t5N2Vo?=
 =?utf-8?B?VDBsUmtPZDB6OGtmcnlWZ2FLbnlMeXo4dVo0djFQK0ZsbVFtM0c0T00rUzJ4?=
 =?utf-8?B?TmtyVnI4QmRjSCtWVFVJQjRNaVZVY1VFejhNZFJZOG1LV3NscXVQbTNtaDFO?=
 =?utf-8?B?V0ZpSUVxcmhLUEc2ZjE2WXlOU3pkRWdOaFI4d2VZSEt4Wms2QndyS2RIQ2d0?=
 =?utf-8?B?YnNZVFIvWVBMUmUva3JZRUVaYnVxa1NObEdEdkl4alVPQThoNkZzNHVIQ1Rj?=
 =?utf-8?B?cFMxTGE1T0x1cTlxMVpGVGJqc0M4R0pEV09yVjBSd1BTbVV4WDZ4OWcxSG5C?=
 =?utf-8?B?OG1TOUVVcVlvRHVLTWtWS0p2NjByditBOTZzYWE2OFdHM0xJemtsTGNmK2RH?=
 =?utf-8?B?QjdUQ0JCaWRpOE1PV0VMeEY0dXBpZGgyNXZtMURYSmNQdDd0SmRIbysrVW5w?=
 =?utf-8?B?a0xFdFlZN0t6anJxVTZaMkQzK21nZ0JQeExFcmNkUmpBazVmVkRmQXhwaWlx?=
 =?utf-8?B?bG95THVnZllCSXVJZExYY0RCdTd1QW8vZVI0YndUdEIxL3FFY1VhR1FoaFpu?=
 =?utf-8?B?Z2R5VDdaY1FZOFYyOURhd1M3TFdMSnJ4NStvWnRHNGw2REE2NUkyOVJQZ21U?=
 =?utf-8?B?RTRiNGQzeldBU1dBSmN5eXhBektQSmlQcjJvM0tOck1CNUlEZjZoQUZIeG9H?=
 =?utf-8?B?QWx4Y29uYnpXc2lSdzI5UUl2VkQvbFhNeVkzb01XajliN2hISnZkQ3RKSFRW?=
 =?utf-8?B?VjF3Mmxubm1sRHNsWHJrT0NzS3FpUTVCZ0FzY0tIeEtjbmpWVml1Zkw3RHBy?=
 =?utf-8?B?STJTdHZIWUJzZ0thV3hJMG1adWZHM2JsSWtvMHIxdzZWV0d5dSt6anA0dWxX?=
 =?utf-8?B?UUFINnVONHJRZ05Mb1ZmUklYK0lIckJCWU9wZHAxcEdCTkszVUxlMFgxNVVI?=
 =?utf-8?B?WkY3b2d1UW9vWm1uNGZJTmI4TGRSWWNsaDVXV0NPc2JzWDd3OWFiNEpneFd0?=
 =?utf-8?B?aXBPZjhQNzJnbUYyQ1BZbHZoRVBNd09OMjNMcDdjU1o1Nzc1WUJRVUQvc0VL?=
 =?utf-8?B?N1owR00vRkxXWllmOW1TZmpZQWdPaDVpUW83bC9zUzJtdnB4ODV0ZERRWHBa?=
 =?utf-8?B?VUl0V2NCaFR3bENTa213UktOQktvMysrTWNHdUw0MlNUd28yajBJa0ZERFln?=
 =?utf-8?B?R1hpc2NCNHpWbGVwUTJSbmFLd0NLMXAxNjdPMFlDTkc0a09RemtmOEh0VlAw?=
 =?utf-8?B?cjNtU1pVUk5wR3JjaGkxMllGbTVKQlZ4T1VQSy9pZEszT0QyQ2xxRnFKMWZS?=
 =?utf-8?B?dUJhbThmakptY2ZNSklxcmV6ZElzVTA4akF2WW93T1dXRG5tckRuR1prekJS?=
 =?utf-8?B?RFJXd04zQm9BOW8ySGVGNkNaMWJ5NkNUUmh2d2h4U3NYUVFYRjNjc2NXeWJv?=
 =?utf-8?B?VGdxUTBXQktmNlZMUGh1UUR4Vk03WVNQTE5sdXNld2pkMFZFQkt1RldFemVE?=
 =?utf-8?B?ajdGUDVUVlpuVXlFMHk2SzFvVzcwQm05MlQzTTdHMEdiZTF4MmFuVk9JdGNw?=
 =?utf-8?B?aGtFMkNtSFZhS1FWcTY2UXhSWUlRL0hoeTRoOFhSTXZpdTdkYmg0MGZid2F4?=
 =?utf-8?B?bVVVdE5salRVekV6Y0RpVmQ5MWJUaE9VcStnM29JQ2tUTWFMMUxBTHR6RkJn?=
 =?utf-8?B?YnUrcWJmNEdGYW9iVnJwSXFROHZ5d2Y1TTI5V2d3NUNCZHR4WkI3Y25NcEJm?=
 =?utf-8?B?LzhZcWd1S21HVDkrakJmbGoyT1JhUUsxSGdrdGZ2elJtZytIMi9ZRDY1bEZw?=
 =?utf-8?B?c09qSVFKbHpZZGxKL285YW9tdkV1QTBlUTFQSGFDeXFPaHNCN1Z5OEphcHdo?=
 =?utf-8?B?MkRXWnR2UW1sUFZRTzhOZ3BhNDJ4NHk0bFdwci8vZU9GQi9NanJ6amRPRTY1?=
 =?utf-8?B?NGlhZXY3Y2hURTVtS0lkd1JCYWhPZ2JVODBVZndzNUM0KzRqamFUS2tqR1dV?=
 =?utf-8?B?cGF4MkF6M2JYdzJOY3V0TmJrbEV3ZzhWWjBoY2NzTTE4a0xCL3NQcXRDR3py?=
 =?utf-8?B?bXUrZmFJYnRQT2djNmRBOWpreTFrQ2kyQ1RPcnl5c0pkZFFKenpDUC9RQy9S?=
 =?utf-8?B?UDdJQnhZQUtxYTFxd2sydTNiYnRNL3lDUkJWWGNSRWMvdmV0Sk55Nm12cXVO?=
 =?utf-8?B?Y2FZYmxhcHpIcDVZS2R5UmpwdWM4aEQrbktydDlVNFF3TFJSQjNOMjc3VXZj?=
 =?utf-8?B?UkxTYjlPRGMxbXlVSlVGNFpEcGpzSDM4cG5mZ0ZFajNraWdpVllLMUdGdFU1?=
 =?utf-8?Q?Ty/IVhOFjLLa5QV7GUDZtvlIi9Giocgauhyzr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <007DDAEC970984498CB1A5B390835271@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42600a66-83a1-480c-d1ca-08da4feadb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 22:52:14.3049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/6cVIyd6fL+4TLh1t82zu7FxWQMJFB5+zM9i+0CH0cXd8AG3XIeYyRJRwxWLtzYDOyzkxu3fK8RHKkRXOC5OLGgrkjPp2du9s5IfBDWof0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0063
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTEwIGF0IDE3OjM1ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IExpbmVhciBBZGRyZXNzIE1hc2tpbmdbMV0gKExBTSkgbW9kaWZpZXMgdGhlIGNoZWNr
aW5nIHRoYXQgaXMgYXBwbGllZA0KPiB0bw0KPiA2NC1iaXQgbGluZWFyIGFkZHJlc3NlcywgYWxs
b3dpbmcgc29mdHdhcmUgdG8gdXNlIG9mIHRoZSB1bnRyYW5zbGF0ZWQNCj4gYWRkcmVzcyBiaXRz
IGZvciBtZXRhZGF0YS4NCj4gDQo+IFRoZSBwYXRjaHNldCBicmluZ3Mgc3VwcG9ydCBmb3IgTEFN
IGZvciB1c2Vyc3BhY2UgYWRkcmVzc2VzLg0KDQpBcm0gaGFzIHRoaXMgZG9jdW1lbnRhdGlvbiBh
Ym91dCB3aGljaCBtZW1vcnkgb3BlcmF0aW9ucyBzdXBwb3J0IGJlaW5nDQpwYXNzZWQgdGFnZ2Vk
IHBvaW50ZXJzLCBhbmQgd2hpY2ggZG8gbm90Og0KRG9jdW1lbnRhdGlvbi9hcm02NC90YWdnZWQt
YWRkcmVzcy1hYmkucnN0DQoNCklzIHRoZSBpZGVhIHRoYXQgTEFNIHdvdWxkIGhhdmUgc29tZXRo
aW5nIHNpbWlsYXIsIG9yIGV4YWN0bHkgbWlycm9yDQp0aGUgYXJtIEFCST8gSXQgc2VlbXMgbGlr
ZSBpdCBpcyB0aGUgc2FtZSByaWdodCBub3cuIFNob3VsZCB0aGUgZG9jcyBiZQ0KZ2VuZXJhbGl6
ZWQ/DQoNCg==
