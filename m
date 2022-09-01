Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BBA5A8F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiIAHEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiIAHDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:03:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C167DB6012
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662015775; x=1693551775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vejpq8URBxUsuEEa4Soz01crgzd718yu4asR6Vg218Q=;
  b=LisdLlb8cdw/FMjiABn5b4TUlVOYsIWFCU4gfpGpDF5fjFuAsX9k1g6G
   G+VHwRxbpaXPjb74aoSvoMJFzD4d5QZucu/8o7WV4fbFWdsvGwLx6dshz
   +9BWg1B86XLBeWA8I+yVSndq/ZWpoKlb0N09hmh2bKGKOXdU3cfPRZ9SC
   yU3WOuOfMQ2VWIdZG5Z7UydRCvTvqsgkRd8G6tzNVhIUIyq/ogzFtUp0O
   wCWfQBXdOKTKlglPnJGGg1U22TK/j4ye4Ykd/oXfgqgRAjmui2ITa6Ba4
   M8zGk88+srfn9DCoRgohDSGI9HqoqCoMCEex1wRN90Y7qTVbMi8RVonXf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="295639990"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="295639990"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 00:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="589365484"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2022 00:02:54 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 00:02:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 00:02:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 00:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl7B6wkAWG5QoJe5eIdRyZ88xsJ9LVk3jvvo9yJC+nBIejxUpUg5dJ6FhW/zh/sSxbmHfdCmUGlAq+49PLeKrQb+lyImZVYn2Yo8CWT8fT2aNMoSIS0tR0QBwo6BsuMh3JT0gx2bxrgzY/Y/Njl0xYZ+ZmV7QotK2aDd0xp6lA4G4gK5nSZlLDXvQAVXllTTqHgrW5SYhmULJKr+Eoyswo+sUFOuXbyZ0o9giGcOjVISPf1Rty0amPSxqqETh23xqgPdzSrr7AB8JwSCHJujKaRm6xTSOifqRpQLPvxKoa4s8BGOxulYb4Cu5wJvKm67vALTUvAbZN6OP8jdEGH3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vejpq8URBxUsuEEa4Soz01crgzd718yu4asR6Vg218Q=;
 b=HvGpDGQX78XjqwCpDjcHAXHqxAl5tgveWAAG7T+dSbtQmppOcDAqlfNizZt36w+tH1vmwfxs3UhrNujFiJVohR0udy7X/vzlK/L4uv462YgmffDsBI93PuczjXTrw8umIghINRBKv26qaTEMAN9fvaDppjypuURibP/rdxdZNx+UDDHxOXiisX+C0oFa8LWSA7H6n9P++XAcVpkNF7ZRgVe/agf7DYTfmYAxb1lsK9PAF+kaoQIPFrg0Wqq7qbuoPpFt8xkNJvCDwRNHu76CfoEN5J6aMkkAaV4qAeDoM2CMcSrCNYvuWhMktAhJ5JbjW5Y1eyEq+qB5D+QUX0VRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by SN6PR11MB3487.namprd11.prod.outlook.com (2603:10b6:805:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Thu, 1 Sep
 2022 07:02:52 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::24b5:3a62:5a7b:5a3]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::24b5:3a62:5a7b:5a3%4]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 07:02:51 +0000
From:   "Li, Fei1" <fei1.li@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "Wang, Yu1" <yu1.wang@intel.com>,
        "Chen, Conghui" <conghui.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: RE: [PATCH] x86/acrn: Set up timekeeping
Thread-Topic: [PATCH] x86/acrn: Set up timekeeping
Thread-Index: AQHYp8ZyIVrLI/K8U06+/38RcAenna3JsYwAgACeRWA=
Date:   Thu, 1 Sep 2022 07:02:51 +0000
Message-ID: <SJ1PR11MB6153FFD6B1D6996EAAAE1F5BBF7B9@SJ1PR11MB6153.namprd11.prod.outlook.com>
References: <20220804055903.365211-1-fei1.li@intel.com>
 <0dc761fe-3d98-8c80-8ee3-01804843e8f9@intel.com>
In-Reply-To: <0dc761fe-3d98-8c80-8ee3-01804843e8f9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74994cc5-fa78-42e1-2cde-08da8be7fc7e
x-ms-traffictypediagnostic: SN6PR11MB3487:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cbBzDsEd0K89YQ8J0CCKWgRGQ5vCHtsjx7gFUbbNc6BwvLCN5UPfyb2fznJoqOp76jkpWd2kja2/CIcMzzUE4qZO3ujUN3hSySQ6JlVb75dX4L19znpi3UrQiyTgjzSsMEBs7CcaMVQgS/iVJj8v+BBqqv4TcJaD9z/3oQlZW/aE/kNT/qP38ZTVK/cTw8KmrNt2AlN9RTtnYozpl7zzbrsOYnkoV6S9mdIm9mOI8GJbzLwQqen/nxQZ9Bsqdz9Kxh199+/0OV+hu3buZZ5MLoNgCOYhJ8hXhUWHOjW6QyYPyFcbiNXWnjPqteNwNTXyDH2B97GL+k4PEn9vS56Tvdl7yCufgpRWBLuOWmFPspbb5sGeBCHoLNOoUhjymxBOReQgXKDUP1HeCJqHz+oCtQn/1nUvpibCButgO/j4w5gUl+pj5XvXAxsd9lYS9XRCcVHYEvnovvtFOkjw0Vz/G4a2pVugZCSDifXAEMvArDvEbzNDAZ/5VTiPTlKY8E90sGCsSH4IkGskcZMN6p93qCpw7Akw6xqFPFI3fDIpc4SEjC/0DbTDZva0JqjN1Q/AFrYt5zn5Knhcx9JCErVakMA4kyKJ0Vhi8Ib22+30LvdKoNbIgjbaPCwWuByy8Ccj2qjdIBlGHZvhXu9Wu8s9UBSHCMgYsq68OivIrrxbxDtwbasUN9UETuDZ6HWaiJ2n1ULz5zYHYmajuKWDEWo2MJ4mO8+vbuFu5pxbPZNxbBPBrH4gy9UgFTNx4Kn2RdHz7JhYfEtAZcOpad8dzNvrjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(366004)(346002)(396003)(2906002)(66446008)(9686003)(55016003)(76116006)(4326008)(66556008)(8676002)(64756008)(66476007)(66946007)(54906003)(7696005)(110136005)(33656002)(6506007)(316002)(478600001)(53546011)(41300700001)(71200400001)(26005)(8936002)(86362001)(38070700005)(186003)(122000001)(5660300002)(52536014)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXRKNEVpTHdLZmRsNFF3TUtKYjNMM0JsK3YxVFFEd1Qxak1TQ2dab0ZNN2ZW?=
 =?utf-8?B?eG1IM2hheGQ4eEdFQi9UK1NNYVgxclU4OHlZVDF3Z29FWjB2eEIvb0VrVXFD?=
 =?utf-8?B?RWszYWZtYjVZc3hXZWVGMG5oaktxUXV0ekVnVHZZTTk2TzcrbCt0emc1ek13?=
 =?utf-8?B?STZ5T1pNWmtLUHNQSnpJL2o5SktVOUJlZ1N4RXNjc3dtSmhQQnNMMUVYNTlh?=
 =?utf-8?B?TnplUSszSDUveSt6c3kxeWtTSVFvWk5BRXY5VmlnUXRoV2V1SHlRaW5YVTFG?=
 =?utf-8?B?ODhTZm1jNEpUQjJmSGoxNXFhMkMrMDVIZzVVTTZhU1U2QkFEU1hNRHkyUGFM?=
 =?utf-8?B?NjFBbTBiODBnMnQ1emU3eWNjK2dBREFHZ3JHZzd0eUNUUkpSRHFPWXNjc2ov?=
 =?utf-8?B?UytqM0ladmRqV0lLbkxJR1NWdVRkMU1EYUVrVG9QYW9UeFJKWXlSOTZhUGNr?=
 =?utf-8?B?UnVpOC8xc2huOEZaRzR6empuWUsxRHk4Q1ZoM2VONUJrZ1dGRWdBbUVIc2Vx?=
 =?utf-8?B?Y2o0V2lueis4elVObUpEVTczV29RMzY5ODJ6VDdoVzkreDVHaUF4b1VWRDly?=
 =?utf-8?B?Tm8vOE1IVjgwczJmYmdDMWk2VFdwTDg3OWxLU3pkWXhvUXEvL1MzeW1SMmlx?=
 =?utf-8?B?OFpOenloaDVzUG84OHR1a0xORy8xYnhxbERoZWlBZDRKMnRZTDJkdnY0UjJ1?=
 =?utf-8?B?eHR6TTlkUjVCTHZTTUFnK3liT09YYm1zT1I5amdxWFBZbzBGYk5sM3V2RXVM?=
 =?utf-8?B?ZjZPeFlBYURmNjlFczZHTWdtSUdQZ1pUMTZRWGhMa1JqQ2pxb0sxM1hkVGNK?=
 =?utf-8?B?L3U4VnpLMGtoR2xzaHU1YVp2Zm5OZ3BVSTh6aEpMaGRqQVg2SXY4ZTJaUWVW?=
 =?utf-8?B?aGVtM2pBQnJmTjZ4bjl3ZGZjNzZDb2MrcVlpMjlBNXVWd2gxSTdoMG9abWNn?=
 =?utf-8?B?MVdmVnRhSXhDUFJOV29vZWFPZkgybFVGM2lXV21rSVUxNjBOQ0pGRzZIVVFh?=
 =?utf-8?B?VjFmaU1GdmhCZHZ4YnBXTUNLdFV4bVlDVU5OdnhQcmFDaEVyNlFJVEpsazY0?=
 =?utf-8?B?T2FWL1E5bGF6bTQrd2srZ3FWTzAvWnhJNm9CczZiV01kMXcxOHR1ekp2M0Ez?=
 =?utf-8?B?Uzh0YTlwWkpYaUk1Ymo2UlEvWXV2c2w1Y2ZGVmJjYURNN0ZmVHRuTVh0MEl3?=
 =?utf-8?B?a29WbDFmRFg1VjVqMGhRaXRXNWE3OExua0w1dE5DaXRrSFZ5K0tINVRDaEYr?=
 =?utf-8?B?bCs3TDdwNzBjaGt0UXhmemhZTnc3Z1IwbldMMmh1bFo0eDBJTHBxVFM2NS9w?=
 =?utf-8?B?d1ZxcXV6dGp6ZVhZa1c3YkRjYVFJTFVySVBuckRlNGhjblc5THdJMndodjZu?=
 =?utf-8?B?Z1diRXduc1VaMGtQVHFaRHkvS2VXTVYyOEZ1YWpiLzNhUEtKb0cvOUtRSUN3?=
 =?utf-8?B?b0VwM2N2UFh1SG80WG10Mkt5MCs3MFkxblBzLzlrTUs5QjNORjhKRkVIT0xV?=
 =?utf-8?B?Z0FNODY2SSszRGFVTGlHbll4WjkrM1dIY3pjcnlYTld3TU1OdW4rdzZZNVo2?=
 =?utf-8?B?TTlaZStOTFM2WWdJZ1hmU29FNVlIZWF6Rnd1N1ZNNmozZVA2N2xMZ3hOcElt?=
 =?utf-8?B?T01wanAwUUZ1M1o3UDU2aTY5ZnZoODBQWDVTbTBKazVvZ2dFNXdmU2svd0ZB?=
 =?utf-8?B?S0oyd1hxZmdIdEVOc1gwSTB0Z2ZCTjZYYnllODVtY2kxTEthRlRLcjcycjR5?=
 =?utf-8?B?d2RiYU1uc2llZXdHbDl6ZHVpUXp2M2kxakpwUjQvK2IvSkZMWnB2RTRMQnlN?=
 =?utf-8?B?TStud2VneXQ2Qy83ZlJ3eWdjRjlUdjg1b2U3QjVobUQyYzNKZHoxYWlLc2gz?=
 =?utf-8?B?cnYvRDlNTCtidVRzdVNGNVRjU2JQczQ1V29xNXlWd0Zpa1Rzem5aWHkyVU53?=
 =?utf-8?B?ZkNyekFtOG1ST0hDU0VjQXFsWCtVaWtKRVNwOG1LRE4xa0JsQXFDRktWejdo?=
 =?utf-8?B?MzJuK1dXL1kwNXgrbnJjMHhESTFDRWdjbzNpdXhDOTVYZzRVbmg0bEtlbkZF?=
 =?utf-8?B?M0FhYjBGeEt0WFVDcWxWNHBrU2w3Mlpma1BOaG9pMXE5UVBrdWhXazg1WnhV?=
 =?utf-8?Q?DuFYsJhBIzFLx9FrMygjrCffV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74994cc5-fa78-42e1-2cde-08da8be7fc7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 07:02:51.6023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPm5KtymOYDF/D/xoj7jwOY/6SCEpQbb3ESnQ3+H3lblhRHScrzDniiOv95yuE8MH35l7slg7PYbnDR2dVMHEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3487
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

PiBPbiA4LzMvMjIgMjI6NTksIEZlaSBMaSB3cm90ZToNCj4gPiArc3RhdGljIGlubGluZSB1bnNp
Z25lZCBsb25nIGFjcm5fZ2V0X3RzY19raHoodm9pZCkgew0KPiA+ICsgICByZXR1cm4gY3B1aWRf
ZWF4KEFDUk5fQ1BVSURfVElNSU5HX0lORk8pOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAvKg0KPiA+
ICAgKiBIeXBlcmNhbGxzIGZvciBBQ1JODQo+ID4gICAqDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2tlcm5lbC9jcHUvYWNybi5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9hY3JuLmMNCj4gPiBp
bmRleCAyM2Y1ZjI3YjVhMDIuLjQ4NTQ0MWI3ZjAzMCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L2Fjcm4uYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvYWNybi5j
DQo+ID4gQEAgLTI4LDYgKzI4LDkgQEAgc3RhdGljIHZvaWQgX19pbml0IGFjcm5faW5pdF9wbGF0
Zm9ybSh2b2lkKSAgew0KPiA+ICAgICAvKiBTZXR1cCB0aGUgSURUIGZvciBBQ1JOIGh5cGVydmlz
b3IgY2FsbGJhY2sgKi8NCj4gPiAgICAgYWxsb2NfaW50cl9nYXRlKEhZUEVSVklTT1JfQ0FMTEJB
Q0tfVkVDVE9SLA0KPiA+IGFzbV9zeXN2ZWNfYWNybl9odl9jYWxsYmFjayk7DQo+ID4gKw0KPiA+
ICsgICB4ODZfcGxhdGZvcm0uY2FsaWJyYXRlX3RzYyA9IGFjcm5fZ2V0X3RzY19raHo7DQo+ID4g
KyAgIHg4Nl9wbGF0Zm9ybS5jYWxpYnJhdGVfY3B1ID0gYWNybl9nZXRfdHNjX2toejsNCj4gPiAg
fQ0KPg0KPiBDb3VsZCB5b3UgdGFrZSBhIHNlYyBhbmQgY29uc2lkZXIgd2hhdCAnc3RhdGljIGlu
bGluZScgZG9lcyBhbmQgbWVhbnMgYW5kIGFsc28gd2hhdCBzZXR0aW5nOg0KPg0KPiAgICAgICB4
ODZfcGxhdGZvcm0uY2FsaWJyYXRlX2NwdSA9IGFjcm5fZ2V0X3RzY19raHo7DQo+DQo+IGRvZXM/
DQo+DQo+IFVzaW5nICdzdGF0aWMgaW5saW5lJyBtaWdodCBjb21waWxlLCBidXQgaXQgZG9lc24n
dCBtYWtlIHNlbnNlLg0KPg0KSGkgRGF2ZQ0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQpZZXMs
ICdpbmxpbmUnIGRvZXNuJ3QgbWFrZSBzZW5zZSBoZXJlLg0KTm93IHRoaXMgY29tbWl0IGhhcyBi
ZWVuIG1lcmdlZCBpbnRvIHRoZSB4ODYvcGxhdGZvcm0gYnJhbmNoIG9mIHRpcCwNCkkgd2lsbCBz
ZW5kIGEgcGF0Y2ggdG8gcmVtb3ZlICdpbmxpbmUnIG9uY2UgdGhpcyBjb21taXQgaGFzIGJlZW4g
bWVyZ2VkDQppbnRvIHRoZSBtYXN0ZXIgYnJhbmNoLg0KDQpUaGFua3MgYWdhaW4uDQo=
