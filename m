Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D739A4A62DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiBARrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:47:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:40354 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbiBARri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643737658; x=1675273658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ScF5UKZbsu+7/Zh1ap8KxmjLMNX9uAXyXnKwdSlU/Js=;
  b=dxojGxCvhHyYFYKbfH4tTxVweq8csUM4HxNFxjFvTfxQaVX7LpYl0S/s
   CKanWtocRpnhCKyyuf45yT5IRsCpWrj9AhuwYgOW+mSDE7APRI7DtJNjs
   eN2Hs4uc5Dlibi6dCaw4WtRXSzgnsA9gajTJpg4M6uXnUJcxBR5iUMnc/
   dcYqkXv4x1qmY734GBBACtt6vMCfMV3ugz1InEeEVicqDJfb12UhorMF1
   7c32KWiy5cX0sfZgMNHw82+sk6V2XS+S+2XmqHy+uvzx6Bq6C20lrDImD
   Ks1iePEDjNkRAKXFX8OtEpkwHviO4b8nhFXrV+zrj8v6jMkgPh8w58YtP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="246581033"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="246581033"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 09:47:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="619881614"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2022 09:47:18 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 09:47:17 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 09:47:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 09:47:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 09:47:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBuiqB4xqSSKtIGj2XPd4HG6xs5Y87/7r0a55X00PT0NiWewImSv9EM5Oj4VW2K6/BFa/xSRbNPk6nvbKcoPpDnMssN+q5XTWiBzZn2vdb50MtgKvqNB2NM+Sj80k0fiLvVAjQogDsawll2w55atpxaMbVrRGytiFnQCxBaKeA5nyfMFOY/6ebxJMthO7MC2wHuSu2WYBq2zFb4kaBUPs9zzoYu3OSkHU1LCV63J+knMal9Gaw3U1ApUC+1k9XARhtHRVmHUdTEYrrGeT5LqCksF0JFKCY6DTiQH5AvXRjRAALXZ/YBpmXeFxuhKeWACUGeiAF/77Obo6UcXnzX6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScF5UKZbsu+7/Zh1ap8KxmjLMNX9uAXyXnKwdSlU/Js=;
 b=QpFsiVisOUU5q6jqNyKSYAuloxUjg97Nyi8KBjQRvWbQ/tSnLY2EyAfO/tlHCmW6ST8TOdBmc0EOpAwqDmyu1metEeJP/SVMDylJmEltCvS6CEjHLqRnEwoNMyvi6GUMxN9TbEg5xJGdg7pFWwIykIN4pP8B88Bsv/PnrPkHQAQXI02JB2ScuRbsJAlIDVL2+OsbM6hdryZ9vpZ9PIWnh6eP/fbYaAuF9XKYhnnjIN7bkzry0XPi97Qd/l/09uys6xhiGjelniLnwPSn/2oJVsB00Vez39fv28/8Uu6529xzTFWD+71vj3hnx6PU9xgGoWk9VX2cHXH6r2owCsC/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY4PR11MB2038.namprd11.prod.outlook.com (2603:10b6:903:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Tue, 1 Feb
 2022 17:47:14 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 17:47:14 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 20/44] mm/pkeys: Add PKS test for context switching
Thread-Topic: [PATCH V8 20/44] mm/pkeys: Add PKS test for context switching
Thread-Index: AQHYE6cS1JgGONNff02sCQH7fdYxhqx/AC6A
Date:   Tue, 1 Feb 2022 17:47:14 +0000
Message-ID: <da79f69a41925f26d810f42f34dd149f5ea69d5c.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-21-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-21-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c324f3db-6b8b-4d2c-2e26-08d9e5aae1aa
x-ms-traffictypediagnostic: CY4PR11MB2038:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <CY4PR11MB2038174E8785F00A56D9A4B6C9269@CY4PR11MB2038.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5R3T1XCD+KN28N/Ly4TBd4lKNPB30nki4CCME2rbMrv3GgyRmXHvvEK6hC5Jq08sCnhS5eYWPRp5k7Pue9CjdWR1RfqVi64vJfv6TVSB1omNjk499ur/0aRx3NsKrJ9fOKQ2Zt9j0XHLeEG5EaFAZhC5O7bgSR4dsNAh3Rm0is+5xQtf7d5b504hZqSbwL6a9dAjFnqJyq/iK6Fwen/QGBZ8IldSlXU1TFmvo2z1MWQ1CoEUHSAY2xy0EPwnzb8bbwJfrd3vbbhJsCr01ygU7Rx/52NOxReivRr0xwll1XpPjw2fZK+TxolhdUJJlSVcS1BPUaf1VSzTFBQ62t/FkHXKQXlwS06/qz5+QmxVBNNXFs2eExWh2Ee9+HuAyt4jSokSVCek5lvDa9kXC+FiM8Z0w97mFR+woyIs/ZTE24pRuEHlCYKk3Uc30T52lpDphm0NC41FUEHJ79+gsFQWoWAq7AWP4cYIPMEbHYK3ITL42TN/mTYsPbqXmc64FMrb+4tJNE12DRWawyqF5/13NyNV34QYhBuodwiXr3cSeLpR8Iy4f/UH6jLZsYSbnrNHSCA5MJDvIMPuX0dUYHCJJ/3LEHQuw2hfCeuUob1YbVBp0U9/CBL5jcasN5djAXW+W9Gnga376lJnT9m7T+zlVVmE6gBWI2GtTj/pDXpZnwlOGXf5lfJeJdRHcWOcB+f+mG5d+YFUnQYODDvt00kY5WPtJoYn04+O2FGHc5hkNX4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(82960400001)(36756003)(2906002)(26005)(122000001)(6506007)(54906003)(316002)(110136005)(86362001)(2616005)(186003)(8936002)(66446008)(64756008)(76116006)(8676002)(4326008)(66476007)(66946007)(71200400001)(6486002)(38100700002)(5660300002)(38070700005)(508600001)(558084003)(66556008)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWcraGxQNUdDajRWcEdhSDdmVHBtMENsSkdrMUN3L2szV0FYbnJtMkhpREp6?=
 =?utf-8?B?UW5UWFRtaGF2b1lVZVlNTFR2cEdOUFFkeEVydUZMczVXRU14UzI2c3pHVWt3?=
 =?utf-8?B?Sk5zVWJMZVF6REc3b0RQQlpMOGMveXZCZmRhc0hqOEVaWGp3SW1vMkw3Zk1s?=
 =?utf-8?B?a0syWmlJUmgrUTV4Z1NNSUFwTHZGTUFXY1NtdlR2LzBpRkFWZ0RXY3VLeFp0?=
 =?utf-8?B?d0o2ODZoSytjaXl6NnFmaTdsZ3hpdHNVTDRpMS90cnlJUHdNbGJlVEdJV2ox?=
 =?utf-8?B?R2drOHMvMmQ3TzJMS1FnMUVGbHdoek9meTJGRGsvd2RiM2FNTXZzVytPVXMr?=
 =?utf-8?B?L0h6eVJ0ZFp1cWFrdm1ZWEhVRGZHeFVNdS8vTmlXN1FHZlJ3Y0VvRnh4MjQ3?=
 =?utf-8?B?Y2hESFBSNnhwSU5PcmliN1ZRblFQTjgwVEp5WkJzK0wwWG9BSlVEMHMxTHhU?=
 =?utf-8?B?M1lKM3REd2dZR1RFVHZZNVpNbmxLWmFDZmx0SGJRWlNRMXZlRnhZUitab2Fp?=
 =?utf-8?B?T2tZZEdtNWp5d3FjUEtQUTQwZjlBSXlua1MzOVN4TW8wcmZkRll5NENNT1Vz?=
 =?utf-8?B?RlRDWkplMUJqSXRpYWRSY3ZhNkM5RVRrWlBkYXBYa3RpOWN1akpDNWNNbFFi?=
 =?utf-8?B?bjZwSExEVmEweHVvdkc1ck0xdzNucmZYUmEvM2RQa1E1NWpTWGhSS2Qzd2ZM?=
 =?utf-8?B?VTdzdHRlRlBqNGEvOHRVZnpGb2dkVkJFVm1ycmtJSXFOaVJLYmgzQllhUDc0?=
 =?utf-8?B?VEtqZW5KbUh3NnRVeitsejJPR0JsZlFVYVl3Y1ZNVXNlbm1TSmJzenRqWVJS?=
 =?utf-8?B?VlVQUDhEMFFmMjlJVXhJSkE3b1h1NjhBZzZCeHZId1BrbnBDM1ErQm80SzNa?=
 =?utf-8?B?dUhBVVdzMXFIV1duc3c5bFlpa0h6NVQ0Z05PODNabmEzdGpHM3dWZ2JBcDJT?=
 =?utf-8?B?M1RneVVza3hYeVpxVUFOVzZOTVN4M3ZFdUxPNEN2ME9aOGZtbVE0RlByUml5?=
 =?utf-8?B?YndGSGRMb3pWeHd0Rk5zM0VqNXh1MitYYWIzZUd6eUNoSys1dWpqY1UyL1pa?=
 =?utf-8?B?NzZCSm9nejdlVEhGWnBCc214NFRMNlhqU3p6THczTzB5eWFVK21lVSt1M05o?=
 =?utf-8?B?eklNbnhDZUpWdjdOcENVTithQlY5WkdtS0hoaUZ5TGtQZlR4bjJkYXBMK3RQ?=
 =?utf-8?B?Y21yd3pIaG1KWlM2TWFUOUtlK2RvakdqNkhBK0g1RUk5Z1dBS1VHbXV5YkNU?=
 =?utf-8?B?Mkt1WXJVSVU5ODMyS1VteXhud3VIV25ub1FPamJDOEFVRjg5Qzk2bGNhMmFN?=
 =?utf-8?B?NjFKN3VhN0FjZEQyRm9MR3gzOVhFTm5tVkpZLzh6d2JqQndZNXRYYXlwdmJ5?=
 =?utf-8?B?TlJXdm16NlZyVmxVRHg0ZzEvNTdxdGI3QVJETnZxOVJ3bmZuUVR4UFNqYjMy?=
 =?utf-8?B?ZVJuSk5wTGVSR1NmMURUM1g4N1BqOWp0U2tNOUJEcFNHTTVRR0UzU0Nma2wr?=
 =?utf-8?B?UHljRzJYUm9JazV6bDdGVVg1U3R4RXloWjM1QldLcnNHV2x3bG53OTllQ0hG?=
 =?utf-8?B?NTllQVBNRldoeWpEc3VGWGt0Mzk0M1VudHdEL1c1TDFkV2N4VTErWXZFTGRC?=
 =?utf-8?B?TXBieER2ZXdlc2V2RG1wZjU0OXhsYVkvRlV3S2RZZllUdjdXNnIyVVVlR1or?=
 =?utf-8?B?RTgrcHd0MG5NeldsYVM0RE05MC9NZjFoYTRiZUpKN1c3bEJ5RlRNODF5K1Jq?=
 =?utf-8?B?Wmw3YlArSG1KZE5uL1JKRFpGaUR4aVQwTkJpM3dKRHNLMGhEelJsWGMwWFpu?=
 =?utf-8?B?Rm4vN1E5OS9wYitGWlVUSzRwcTFkM0gwYUFlY1I2L2xwMEthUmVzQkFnZkxl?=
 =?utf-8?B?dW5ET3ZxeUlBMlFIcWIxR2VTMURpNVJlTWMyNUUybk04cmgzL1F1cXozNzRa?=
 =?utf-8?B?RExKSUFkVGM4dk1peW5aRHJiTkpvbEc4a2JubFUvVU1HMTZxME5SYnhsUW0v?=
 =?utf-8?B?RXBJZUk0RmthYnNpUUVTZStJQ3VzTFp6QklCNDdzeEFsM1dDWjJxYlVJZmdB?=
 =?utf-8?B?YlNlRGRXSGVZSy92YzVHMGVaMFlSTjBGVnR4ZVpMRnBtc0hLMkd2TE5oRldU?=
 =?utf-8?B?Z1hFMGExcWRvV3pmQmw1aDIramQ0WkFZZFpjUHJnaUtuTUFzc2FoV0NFamFI?=
 =?utf-8?B?cFA1ZmJCSlptVEE5UHp4TVBkV0cyc2ExRlA1SFBPR0pWaXFiSHAvWldFbVQ4?=
 =?utf-8?Q?lCaNDalUoEnJqLsTigDPxueQN/7FP69k7YjhYxrQ0Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D10CA9431AE41488749902741A34788@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c324f3db-6b8b-4d2c-2e26-08d9e5aae1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 17:47:14.2238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8xru5DpvoZaNyhs9dg0H/2wbAZYm++l94XFe8s+Vq/WDVGVF3i79d7UG042IoqByFBfCGnxyZFCnIfsTmDN9Vsi0FjWiDA2GJfNA/4iL/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2038
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU0IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiAgbGliL3Brcy9wa3NfdGVzdC5jICAgICAgICAgICAgICAgICAgICAgfCAgNzQgKysr
KysrKysrKysNCg0KU2luY2UgdGhpcyBvbmx5IHRlc3RzIGEgc3BlY2lmaWMgb3BlcmF0aW9uIG9m
IHBrcywgc2hvdWxkIGl0IGJlIG5hbWVkDQptb3JlIHNwZWNpZmljYWxseT8gT3IgaXQgbWlnaHQg
YmUgaGFuZHkgaWYgaXQgcmFuIGFsbCB0aGUgUEtTIHRlc3RzLA0KZXZlbiB0aG91Z2ggdGhlIG90
aGVycyBjYW4gYmUgcnVuIGRpcmVjdGx5Lg0K
