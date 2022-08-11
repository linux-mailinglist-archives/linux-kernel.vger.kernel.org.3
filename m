Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C3B58F899
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiHKHuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiHKHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:50:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05638D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660204229; x=1691740229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vQHHv1jHnVOI7nupGGn8iP1v7buS34ApHSz8UhcKNRE=;
  b=CguhYZVXbh56WHYIkUpYsrI2tJVpTD/qoSfHJAsv4mdRFjNrRJIE/PRY
   /QbO9qcXqPJBSBooAkC7YQ1vDr5Twi0DMsVPhDlzDfoqqGdsWU9gCC65w
   YsS1hE+pgAptVa7Dmmk5fliI0xZLAJ2ISUOzoZkqHxlfDtGjKHQ3WLmHv
   x8CCK0ZKqSJYS/DzJ1E12PG0Ncoqwos8whDc1VyX3j0dbGIMxu0dLP4is
   cKtKDq1fezWiuBRHMmKN5JuXeZf6VJZ/7TN2I6pkEnojza3A+Kpp8co1G
   39Lxr4IkPw1rSUwNNWi0aIDQ9vhBRijnfhdmZ/zZIC9bsP11w+daFs4u+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="377576322"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="377576322"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 00:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="673603551"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2022 00:50:17 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 00:50:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 00:50:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 00:50:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7g0fkdPz/SarjVIdUNxFGUGEPPV/H4pgf5rqa3rkEJMrMahX1bO1kLyRudIwwiOJlHPrN0ULi18pxpMcnWOScMwLhX0s/hIMJSVm1jQ870YhsZExRPI7Xx16wcNdQwFvNhBqsDbwZ6miuN5HPge0HmoOrzHlEJHMRdKZ0XmXCQFUcmB+acnsUhY49MY+e5tPTzLHn0IjeODO0rkmCAHapPjkzSFEp4RejMMI6HLFJYUTARuGwU0S7PELA1/jjPSQofrp9P+KJ/srfoNpYmnvdaKKw/jP+dNJIYb088ehiwOp5k//I2uvbQKKXn2+CKI0/zXCvhAfjCZw/Rt+Vgw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQHHv1jHnVOI7nupGGn8iP1v7buS34ApHSz8UhcKNRE=;
 b=KrH1GXj1HOsGG9OdVKevyjlvODAWy6m1TSkfenGei5HLRLEGIryKsFLMRmcGBoZ7fa4v9H8X+E/ykEXKWApZTWfbVfAtBk2dKCoXpJfoTaDKZ4XnsNOc/44PjA0cnTji72e6Jx/yHEPxneHZaBjoKP41x6c7L4BZQYD8EJVDvViyEzrGgw/dsFnLsk+ANyO9nJbNdCsbsz+3v66F+K4U8OA1xl3icT66cC+mR7iTJhj0nLU/+Rx4R3a0HBKIbnNMlaYZRw1MFrjOpoX/KuTWYqs+lXJ+5zj/napKHn6KkL316r5J16HetzKd9JksQmy0g7/sX6jiqzE1Uh3O3IRxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:232::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 07:50:02 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda%5]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 07:50:02 +0000
From:   "Lu, Aaron" <aaron.lu@intel.com>
To:     "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "song@kernel.org" <song@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>
Subject: Re: [RFC PATCH 0/4] x86/mm/cpa: merge small mappings whenever
 possible
Thread-Topic: [RFC PATCH 0/4] x86/mm/cpa: merge small mappings whenever
 possible
Thread-Index: AQHYrT3ql/LYeyXCRkm8iRt2VbEQZa2pU1eA
Date:   Thu, 11 Aug 2022 07:50:02 +0000
Message-ID: <2958cdf206cf1f2dd650f817eee14716d2fd701e.camel@intel.com>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
         <YvSKpCWhAz+2Y220@ip-172-31-24-42.ap-northeast-1.compute.internal>
In-Reply-To: <YvSKpCWhAz+2Y220@ip-172-31-24-42.ap-northeast-1.compute.internal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6401129-5ac2-4cb5-9b69-08da7b6e1918
x-ms-traffictypediagnostic: SA1PR11MB5779:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hohs5dyDNQup37/kG1x6J0w7sTHNIaXZcHHrjhqcD+XTk/vjurPziXPQ2LWncYtzhoqqx+NFQ6RLJKEmwQyF0i+wLiWDxNGzXfr3CvliX1C1q/3P1bPa0ngF+eL81XCAGaOiqozi6ChqjtTnLn+BZKcQDnZTA76d2OW05aOh0RBl5iTKTtfgKU4raHpp+VPH9e43TZE5QdKQDkhTi91553Ou+mUvvCYy01wpreeGcTKLENncXwJ8kZws/mVbEvIjsK/5tTSyAAEl+2sDe7BaadvjJOv7qvgVJUD7hCLNayH5DqGyynNhTvIJozYB8iP5L7LSGbomqHHaTXOXQKCRlkq9VVm6Anpj975STB6qKhmrSOIpVvzEEZ0W7phzNB9v37FMN0X5pr799AEealY67sylP5unpTpJlmLQcyJzIojI9lUVjA2g+kDgdrHBbQk/IwV1K/Qr/Jdhwvm2m/3weF3pSbOOy+WvjbSZG0AnZp439x3wjgaqB/sJRfFjONozelaAatsFfogojpjIB6lXDIuq4/d109cRHCMp1Ta3fbpxvko8Migo4fstW3D4AOT6YTQ7ldOxECcszMYVezivxj/B9e6kkWRJQyZHvP2IMMCv+oY0DKYzXaLFsqTYHWgas947HLovHvwsuVpMYYmYB70sQoEioQtjZ/6GBGiwPgb7jaUJ+UVHvA9vvCW//NmZsMnhIsd2ZVHp3AZyt9DdNHi1y6wiVWZ5e50bwZMCEy+llXYMMrEkQHGIc/yoPEl3UsrOI8VUMRB1FGY/kBgIjs7c62eILVFNb4sjUZaFS/hZd0C7qWFvbawoc+9EqKgS2VnWa3ZTouCVpbkb1+fxOS0uspHRVnOWVL7HP/1IAtM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(346002)(39860400002)(136003)(84040400005)(186003)(2616005)(83380400001)(82960400001)(38070700005)(122000001)(38100700002)(966005)(6486002)(478600001)(71200400001)(41300700001)(91956017)(316002)(76116006)(54906003)(6916009)(5660300002)(2906002)(8936002)(66446008)(26005)(6512007)(64756008)(8676002)(66946007)(66556008)(66476007)(4326008)(6506007)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjlQTEk4dDZVUDBJUEx3aDFEUEtxVmYrU0Fsa3Nkalg1ZHF3WWRaQWhyZzR4?=
 =?utf-8?B?Wnk2SjVXVFZwdjNtbVRTN1BVQ21EVGNxVmlKaXJoTlNSeGJYR3BGOWFEa3cw?=
 =?utf-8?B?TlJoWGJnSUpIYWY4SXF2cWI0Y2k2QnVvNzNKZ1RHNG9qYytIUEZaejd2VjI2?=
 =?utf-8?B?b2hhaFViZWx3NjlVOEpoakRlcXhrN0t2cXdFdUlxbUhKZ1ZYOVlBQlJhY3J1?=
 =?utf-8?B?RHBLbW1HbzJ1b0d4L0FOME9rYWxkQkhzbGJ6RlN5OUtKbVR3Y3ZMK0JYRmlj?=
 =?utf-8?B?R2QrNytLcDJWbkJBcE5ONysvS29tZXp3cERUZE9JNGY4TmJSZUN6aDlUVm96?=
 =?utf-8?B?cUZXazlucEpwMjZSeUREZHgvQUpzVzJIM2xncWd1bndwVjNvOXpEMDZDbXBn?=
 =?utf-8?B?bmM4cytJUEtJdlRGSmt0VWtJYmZGWThlVXNOL2J3WEp5YThIN1BlTkNSRVNP?=
 =?utf-8?B?ZEl3OWJTY3lQOWxVSU1oNmRFVU4xMi9UOCs0UWR1VlRkd2J0ZHY2ZkJiL1B2?=
 =?utf-8?B?Y3FOWlpKY2krc1R5UHIxRHpoQ1pmY3E5V05KTXdxQkpsdkY0MVYxVzZTd2F5?=
 =?utf-8?B?U3NVak83MWMxanJKQS83bTBXV1pjNzJMYWNhZTBxN3B3bEhOMUdudGZIRzYw?=
 =?utf-8?B?YmJUaVFPcmV1RzRNZzJwNDJJMHp0TGwyUEpyTzA1SGdNZktvdlhoTGI4NDhO?=
 =?utf-8?B?WlpRVnVFRXUzS1hubEV0dFZ1Si9uL2JTQzJoRlFOWTlVci9NanY0enNkdHdX?=
 =?utf-8?B?SHVmZ1l0TnA3SkovbFZ1dmxPSW96bEVxbWRrWXUvc1hRL1dFWkU5Y3hSeGZY?=
 =?utf-8?B?SStaYkJNZWJtcUFCQ0ZheVFIa2FSc0t2TFNYenB6ZkNxUSsxQ29qbFFlZU9m?=
 =?utf-8?B?eXhjeWtBWFB1cW9pL2xaa1RPdWE5SThuUTFNVmFEKzU3RDVBSGVVejdhUWVx?=
 =?utf-8?B?SlpMMHgvMFRUVzBZbWFueEs0WUYzNTBETmtNRTc0anhTOEFDNW10emczWXU5?=
 =?utf-8?B?KzZvOWJBZU15VGhGRko4M2lTWmxNeFc4NHR4Q1RXeEU3Zkx0dW9Nbzh4aWhP?=
 =?utf-8?B?SDRlTEVIeFJ3dmVGbXlxWEtjZkREcFdvNUpsYWFXdnhXeGZjZkVCMlpaeENI?=
 =?utf-8?B?eDEzQTNBRStyemNZUGJYZm1abVhGdkYweU5sOVRGSlpXWVZQd3lUNEljMUlm?=
 =?utf-8?B?b2xHTWs0N1RDRFNpOTFXcEhYeEVETy9XUXJOTStvTlJYdnkzMHFrNTMzRmxk?=
 =?utf-8?B?OEJ1TmJvRUs0VVJmcmZ3Tml4S1R6dThtWTNUMGpUd3ZIKy9saG1zMWFDcVp6?=
 =?utf-8?B?bzQ1UzVTOExIWEYxQUo1UlNScGVjdDhDTXNQRWttaWgxWEpqQ2NadWNNanAr?=
 =?utf-8?B?Q3p1QjFyaTc1WGdmd0l6aENwNDhWKy91cW85WEZCVmcyU0VsS1NNdVdnVUxG?=
 =?utf-8?B?SnUybUp0eVh2RzRmb0p5VWNlS2NDNUxZMnp3OGRHUE5xT2JRcElTSEtXYlIr?=
 =?utf-8?B?cGI2b25sK2Nwd1R4U21MTFZmaEtWT2kyV0x0a05ZbU91L01OQWFMcWxocjdB?=
 =?utf-8?B?aWVqbWlUZ3hUQkZIdjBxTFFBRCtxam45OWQ5RTZ6TStNdHNJbTJNMSt4UmRN?=
 =?utf-8?B?dUZqRWN5ZE1vVW9MUlNBS0k0Q0lGQWtIanJyTmpHaTEwYmh5ZjN4eXRPbkNL?=
 =?utf-8?B?bWcvN0YxV2tQYk1sNFJURVdyNDdJSzlmOG9KZGNsY1dVd0NqWGhqckR1QmR4?=
 =?utf-8?B?TVFtWGpvMXdNdDNYbWpWeGVPV1lNSUoxTXhYWFMzb2RXZWl0YUltRFV1dFdS?=
 =?utf-8?B?U05CcjIra29nR2NMRmRmcktHTGl6anU1RTV6dG9CbExScTIvMml3WTBLQlNp?=
 =?utf-8?B?Lzh4YjVKaFNlL0JvWlNpQ1NadHJmeURkOWYzVkNCS0RvcVdPZG5TY1hxVUM1?=
 =?utf-8?B?eC9scXBwelFZTm80VUxsdHQxNXZBK0EvSGVmdWhHbVNmamRqc0dZZ21RT3ZY?=
 =?utf-8?B?MHkya2Q1OFRJTFlvdi9NOXVjT2xreU5zb3A2ZFREanJXdWkvRG9SSEJ6ZDZP?=
 =?utf-8?B?UUtEMXhoZWVWcXRWamFSbWVtMFVaeXRSczNOWllWT3N0bGxycmNsYThlY0Fm?=
 =?utf-8?Q?wamrg+9DeYj+DfHxeRhh6YMGW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D19B698DB27E524A81A775827ACB0736@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6401129-5ac2-4cb5-9b69-08da7b6e1918
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 07:50:02.3696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DyEOH7edcHdYO0fI+2kjB2Iwmz5+UDmtVflhFEt170xIGzX0AyVH0tzeSrpOTFzRkdRD4I4V61Y20GkIl8kvnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
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

T24gVGh1LCAyMDIyLTA4LTExIGF0IDA0OjUwICswMDAwLCBIeWVvbmdnb24gWW9vIHdyb3RlOg0K
PiBPbiBNb24sIEF1ZyAwOCwgMjAyMiBhdCAxMDo1Njo0NVBNICswODAwLCBBYXJvbiBMdSB3cm90
ZToNCj4gPiBUaGlzIGlzIGFuIGVhcmx5IFJGQy4gV2hpbGUgYWxsIHJldmlld3MgYXJlIHdlbGNv
bWUsIHJldmlld2luZyB0aGlzIGNvZGUNCj4gPiBub3cgd2lsbCBiZSBhIHdhc3RlIG9mIHRpbWUg
Zm9yIHRoZSB4ODYgc3Vic3lzdGVtIG1haW50YWluZXJzLiBJIHdvdWxkLA0KPiA+IGhvd2V2ZXIs
IGFwcHJlY2lhdGUgYSBwcmVsaW1pbmFyeSByZXZpZXcgZnJvbSB0aGUgZm9sa3Mgb24gdGhlIHRv
IGFuZCBjYw0KPiA+IGxpc3QuIEknbSBwb3N0aW5nIGl0IHRvIHRoZSBsaXN0IGluIGNhc2UgYW55
b25lIGVsc2UgaXMgaW50ZXJlc3RlZCBpbg0KPiA+IHNlZWluZyB0aGlzIGVhcmx5IHZlcnNpb24u
DQo+ID4gDQo+IA0KPiBIZWxsbyBBYXJvbiENCj4gDQoNCkhpIEh5ZW9uZ2dvbiwNCg0KPiArQ2Mg
TWlrZSBSYXBvcG9ydCwgd2hvIGhhcyBiZWVuIHNhbWUgcHJvYmxlbS4gWzFdDQo+IA0KPiBUaGVy
ZSBpcyBhbHNvIExQQyBkaXNjdXNzaW9uICh3aXRoIGRpZmZlcmVudCBhcHByb2FjaCBvbiB0aGlz
IHByb2JsZW0pDQo+IFsyXSwgWzRdDQo+IA0KPiBhbmQgcGVyZm9ybWFuY2UgbWVhc3VyZW1lbnQg
d2hlbiBhbGwgcGFnZXMgYXJlIDRLLzJNLiBbM10NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1tbS8yMDIyMDEyNzA4NTYwOC4zMDYzMDYtMS1ycHB0QGtlcm5lbC5vcmcv
DQo+IFsyXSBodHRwczovL3d3dy55b3V0dWJlLmNvbS93YXRjaD92PWVnQzdaSzRwY25RDQo+IFsz
XSBodHRwczovL2xwYy5ldmVudHMvZXZlbnQvMTEvY29udHJpYnV0aW9ucy8xMTI3L2F0dGFjaG1l
bnRzLzkyMi8xNzkyL0xQQzIxJTIwRGlyZWN0JTIwbWFwJTIwbWFuYWdlbWVudCUyMC5wZGYNCj4g
WzRdIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy84OTQ1NTcvDQo+IA0KDQpUaGFua3MgYSBsb3Qg
Zm9yIHRoZXNlIGluZm8uDQoNCj4gPiBEYXZlIEhhbnNlbjogSSBuZWVkIHlvdXIgYWNrIGJlZm9y
ZSB0aGlzIGdvZXMgdG8gdGhlIG1haW50YWluZXJzLg0KPiA+IA0KPiA+IEhlcmUgaXQgZ29lczoN
Cj4gPiANCj4gPiBPbiB4ODZfNjQsIExpbnV4IGhhcyBkaXJlY3QgbWFwcGluZyBvZiBhbG1vc3Qg
YWxsIHBoeXNpY2FsIG1lbW9yeS4gRm9yDQo+ID4gcGVyZm9ybWFuY2UgcmVhc29ucywgdGhpcyBt
YXBwaW5nIGlzIHVzdWFsbHkgc2V0IGFzIGxhcmdlIHBhZ2UgbGlrZSAyTQ0KPiA+IG9yIDFHIHBl
ciBoYXJkd2FyZSdzIGNhcGFiaWxpdHkgd2l0aCByZWFkLCB3cml0ZSBhbmQgbm9uLWV4ZWN1dGUN
Cj4gPiBwcm90ZWN0aW9uLg0KPiA+IA0KPiA+IFRoZXJlIGFyZSBjYXNlcyB3aGVyZSBzb21lIHBh
Z2VzIGhhdmUgdG8gY2hhbmdlIHRoZWlyIHByb3RlY3Rpb24gdG8gUk8NCj4gPiBhbmQgZVhlY3V0
YWJsZSwgbGlrZSBwYWdlcyB0aGF0IGhvc3QgbW9kdWxlIGNvZGUgb3IgYnBmIHByb2cuIFdoZW4g
dGhlc2UNCj4gPiBwYWdlcycgcHJvdGVjdGlvbiBhcmUgY2hhbmdlZCwgdGhlIGNvcnJlc3BvbmRp
bmcgbGFyZ2UgbWFwcGluZyB0aGF0DQo+ID4gY292ZXIgdGhlc2UgcGFnZXMgd2lsbCBoYXZlIHRv
IGJlIHNwbGl0dGVkIGludG8gNEsgZmlyc3QgYW5kIHRoZW4NCj4gPiBpbmRpdmlkdWFsIDRrIHBh
Z2UncyBwcm90ZWN0aW9uIGNoYW5nZWQgYWNjb3JkaW5nbHksIGkuZS4gdW5hZmZlY3RlZA0KPiA+
IHBhZ2VzIGtlZXAgdGhlaXIgb3JpZ2luYWwgcHJvdGVjdGlvbiBhcyBSVyBhbmQgTlggd2hpbGUg
YWZmZWN0ZWQgcGFnZXMnDQo+ID4gcHJvdGVjdGlvbiBjaGFuZ2VkIHRvIFJPIGFuZCBYLg0KPiA+
IA0KPiA+IFRoZXJlIGlzIGEgcHJvYmxlbSBkdWUgdG8gdGhpcyBzcGxpdDogdGhlIGxhcmdlIG1h
cHBpbmcgd2lsbCByZW1haW4NCj4gPiBzcGxpdHRlZCBldmVuIGFmdGVyIHRoZSBhZmZlY3RlZCBw
YWdlcycgcHJvdGVjdGlvbiBhcmUgY2hhbmdlZCBiYWNrIHRvDQo+ID4gUlcgYW5kIE5YLCBsaWtl
IHdoZW4gdGhlIG1vZHVsZSBpcyB1bmxvYWRlZCBvciBicGYgcHJvZ3MgYXJlIGZyZWVkLg0KPiA+
IEFmdGVyIHN5c3RlbSBydW5zIGEgbG9uZyB0aW1lLCB0aGVyZSBjYW4gYmUgbW9yZSBhbmQgbW9y
ZSBsYXJnZSBtYXBwaW5nDQo+ID4gYmVpbmcgc3BsaXR0ZWQsIGNhdXNpbmcgbW9yZSBhbmQgbW9y
ZSBkVExCIG1pc3NlcyBhbmQgb3ZlcmFsbCBzeXN0ZW0NCj4gPiBwZXJmb3JtYW5jZSBnZXR0aW5n
IGh1cnRbMV0uDQo+ID4gDQo+ID4gRm9yIHRoaXMgcmVhc29uLCBwZW9wbGUgdHJpZWQgc29tZSB0
ZWNobmlxdWVzIHRvIHJlZHVjZSB0aGUgaGFybSBvZg0KPiA+IGxhcmdlIG1hcHBpbmcgYmVsaW5n
IHNwbGl0dGVkLCBsaWtlIGJwZl9wcm9nX3BhY2tbMl0gd2hpY2ggcGFja3MNCj4gPiBtdWx0aXBs
ZSBicGYgcHJvZ3MgaW50byBhIHNpbmdsZSBwYWdlIGluc3RlYWQgb2YgYWxsb2NhdGluZyBhbmQg
Y2hhbmdpbmcNCj4gPiBvbmUgcGFnZSdzIHByb3RlY3Rpb24gZm9yIGVhY2ggYnBmIHByb2cuIFRo
aXMgYXBwcm9hY2ggbWFkZSBsYXJnZQ0KPiA+IG1hcHBpbmcgc3BsaXQgaGFwcGVuIG11Y2ggZmV3
ZXIuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBhZGRyZXNzZXMgdGhpcyBwcm9ibGVtIGluIGFu
b3RoZXIgd2F5OiBpdCBtZXJnZXMNCj4gPiBzcGxpdHRlZCBtYXBwaW5ncyBiYWNrIHRvIGEgbGFy
Z2UgbWFwcGluZyB3aGVuIHByb3RlY3Rpb25zIG9mIGFsbCBlbnRyaWVzDQo+ID4gb2YgdGhlIHNw
bGl0dGVkIHNtYWxsIG1hcHBpbmcgcGFnZSB0YWJsZSBiZWNvbWUgc2FtZSBhZ2FpbiwgZS5nLiB3
aGVuIHRoZQ0KPiA+IHBhZ2Ugd2hvc2UgcHJvdGVjdGlvbiB3YXMgY2hhbmdlZCB0byBSTytYIG5v
dyBoYXMgaXRzIHByb3RlY3Rpb24gY2hhbmdlZA0KPiA+IGJhY2sgdG8gUlcrTlggZHVlIHRvIHJl
YXNvbnMgbGlrZSBtb2R1bGUgdW5sb2FkLCBicGYgcHJvZyBmcmVlLCBldGMuIGFuZA0KPiA+IGFs
bCBvdGhlciBlbnRyaWVzJyBwcm90ZWN0aW9uIGFyZSBhbHNvIFJXK05YLg0KPiA+IA0KPiANCj4g
SSB0cmllZCB2ZXJ5IHNpbWlsYXIgYXBwcm9hY2ggZmV3IG1vbnRocyBhZ28gKGZvciB0b3kgaW1w
bGVtZW50YXRpb24pIFs1XSwNCg0KQ29vbCwgZ2xhZCB3ZSBoYXZlIHRyaWVkIHNpbWlsYXIgYXBw
cm9hY2ggOi0pDQoNCj4gYW5kIHRoZSBiaWdnZXN0IG9ic3RhY2xlIHRvIHRoaXMgYXBwcm9hY2gg
d2FzOiB5b3UgbmVlZCB0byBiZSBleHRyZW1lbHkgc3VyZQ0KPiB0aGF0IHRoZSBwYWdlLT5ucl9z
YW1lX3Byb3QgaXMgQUxXQVlTIGNvcnJlY3QuDQo+IA0KDQpZZXMgaW5kZWVkLg0KDQo+IEZvciBl
eGFtcGxlLCBpbiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rZmVuY2UuaCBbNl0sIGl0IGNsZWFycyBh
bmQgc2V0DQo+IF9QQUdFX1BSRVNFTlQgd2l0aG91dCBnb2luZyB0aHJvdWdoIENQQSwgd2hpY2gg
Y2FuIHNpbXBseSBicmVhayB0aGUgY291bnQuDQo+IA0KPiBbNV0gaHR0cHM6Ly9naXRodWIuY29t
L2h5Z29uaS9saW51eC90cmVlL21lcmdlLW1hcHBpbmctdjFyMw0KPiBbNl0gaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9r
ZmVuY2UuaCNMNTYNCj4gDQoNCkZvciB0aGlzIHNwZWNpZmljIGNhc2UsIGl0IHByb2JhYmx5IGRv
ZXNuJ3QgbWF0dGVyIGJlY2F1c2Uga2ZlbmNlDQppbnRlbnRpb25hbGx5IHVzZXMgc2V0X21lbW9y
eV80aygpIGZvciB0aGVzZSBwYWdlcyBhbmQgbm8gbWVyZ2Ugc2hhbGwNCmV2ZXIgYmUgZG9uZSBm
b3IgdGhlbSBhY2NvcmRpbmcgdG8gY29tbWl0IDFkYzBkYTZlOWVjMCgieDg2LCBrZmVuY2U6DQpl
bmFibGUgS0ZFTkNFIGZvciB4ODYiKS4NCihLaXJpbGwgcG9pbnRlZCBvdXQgbXkgY3VycmVudCB2
ZXJzaW9uIGhhcyBwcm9ibGVtIGRlYWxpbmcgd2l0aA0Kc2V0X21lbW9yeV80aygpIGJ1dCB0aGF0
IGlzIGZpeGFibGUpLg0KDQo+IEkgdGhpbmsgd2UgbWF5IG5lZWQgdG8gaG9vayBzZXRfcHRlL3Nl
dF9wbWQvZXRjIGFuZCB1c2UgcHJvcGVyDQo+IHN5bmNocm9uaXphdGlvbiBwcmltaXRpdmVzIHdo
ZW4gY2hhbmdpbmcgaW5pdF9tbSdzIHBhZ2UgdGFibGUgdG8gZ28NCj4gZnVydGhlciBvbiB0aGlz
IGFwcHJvYWNoLg0KDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBJJ2xsIGNoZWNrIGhvdyBt
YW55IGNhbGxzaXRlcyB0aGVyZSBhcmUgdGhhdA0KbWFuaXB1bGF0ZSBpbml0X21tJ3MgcGFnZSB0
YWJsZSBvdXRzaWRlIG9mIGNwYSgpIGFuZCB0aGVuIGRlY2lkZXMgaWYgaXQNCmlzIHBvc3NpYmxl
IHRvIGRvIHRoZSBob29rIGFuZCBzeW5jIGZvciBzZXRfcHRlL2V0Yy4NCg0KPiANCj4gPiBPbmUg
ZmluYWwgbm90ZSBpcywgd2l0aCBmZWF0dXJlcyBsaWtlIGJwZl9wcm9nX3BhY2sgZXRjLiwgdGhl
cmUgY2FuIGJlDQo+ID4gbXVjaCBmZXdlciBsYXJnZSBtYXBwaW5nIHNwbGl0IElJVUM7IGFsc28s
IHRoaXMgcGF0Y2hzZXQgY2FuIG5vdCBoZWxwDQo+ID4gd2hlbiB0aGUgcGFnZSB3aGljaCBoYXMg
aXRzIHByb3RlY3Rpb24gY2hhbmdlZCBrZWVwcyBpbiB1c2UuIFNvIG15IHRha2UNCj4gPiBvbiB0
aGlzIGxhcmdlIG1hcHBpbmcgc3BsaXQgcHJvYmxlbSBpczogdG8gZ2V0IHRoZSBtb3N0IHZhbHVl
IG9mIGtlZXBpbmcNCj4gPiBsYXJnZSBtYXBwaW5nIGludGFjdCwgZmVhdHVyZXMgbGlrZSBicGZf
cHJvZ19wYWNrIGlzIGltcG9ydGFudC4gVGhpcw0KPiA+IHBhdGNoc2V0IGNhbiBoZWxwIHRvIGZ1
cnRoZXIgcmVkdWNlIGxhcmdlIG1hcHBpbmcgc3BsaXQgd2hlbiBpbiB1c2UgcGFnZQ0KPiA+IHRo
YXQgaGFzIHNwZWNpYWwgcHJvdGVjdGlvbiBzZXQgZmluYWxseSBnZXRzIHJlbGVhc2VkLg0KPiA+
IA0KPiA+IFsxXTogaHR0cDovL2xrbWwua2VybmVsLm9yZy9yL0NBUGhzdVc0ZUFtOVFyQXhoWk1K
dS1ibXZIbmpXanV3ODZnRlp6VEhSYU1FYWVGaEF4d0BtYWlsLmdtYWlsLmNvbQ0KPiA+IFsyXTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDIwNDE4NTc0Mi4yNzEwMzAtMS1zb25n
QGtlcm5lbC5vcmcvDQo+ID4gDQo+ID4gQWFyb24gTHUgKDQpOg0KPiA+ICAgeDg2L21tL2NwYTog
cmVzdG9yZSBnbG9iYWwgYml0IHdoZW4gcGFnZSBpcyBwcmVzZW50DQo+ID4gICB4ODYvbW0vY3Bh
OiBtZXJnZSBzcGxpdHRlZCBkaXJlY3QgbWFwcGluZyB3aGVuIHBvc3NpYmxlDQo+ID4gICB4ODYv
bW0vY3BhOiBhZGQgbWVyZ2UgZXZlbnQgY291bnRlcg0KPiA+ICAgeDg2L21tL2NwYTogYWRkIGEg
dGVzdCBpbnRlcmZhY2UgdG8gc3BsaXQgZGlyZWN0IG1hcA0KPiA+IA0KPiA+ICBhcmNoL3g4Ni9t
bS9wYXQvc2V0X21lbW9yeS5jICB8IDQxMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+ID4gIGluY2x1ZGUvbGludXgvbW1fdHlwZXMuaCAgICAgIHwgICA2ICsNCj4gPiAgaW5j
bHVkZS9saW51eC9wYWdlLWZsYWdzLmggICAgfCAgIDYgKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3Zt
X2V2ZW50X2l0ZW0uaCB8ICAgMiArDQo+ID4gIG1tL3Ztc3RhdC5jICAgICAgICAgICAgICAgICAg
IHwgICAyICsNCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCA0MjAgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiAtLSANCj4gPiAyLjM3LjENCj4gPiANCj4gPiANCg0K
