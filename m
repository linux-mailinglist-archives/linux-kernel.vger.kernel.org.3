Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9095A7457
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiHaDR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiHaDRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:17:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5A944567;
        Tue, 30 Aug 2022 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661915832; x=1693451832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GYA4qRXw4SnF2MroXP7kehwfr7sqSYanaxDSbE7Uif0=;
  b=T+bN+RvLN4q0KiPbyqWrWAq9/LG6D6BodTXkZxYpEXLMStv49zu07IIe
   DsZDJU0X1z+vhyFpc6j4bx0WlEBQhuNyyj23HVs6tCFdwnnkw58yfOzG5
   T5Z1+Cr91CcKyDZiwZkQXtAu4nXONI4//H6e/4AvefrmqRwFxrYTG2CRh
   5pODlgqy2ZdtovV3frdi/HiCfRKvRFkTNI5rWea3GUZCl942ZybZR9jf9
   GJpTcyETUNlHWlHUn2Jy/rkRu9FFUyPjGiEz99AuWKCNk5CtRXzAB3WAt
   ocP7BAVRjCEWp+8QF7QTE4CMUkWBPoA9gBJZ7ajZ+O6WYaOjyEj0YjwHe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275109672"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="275109672"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 20:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="701229407"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2022 20:17:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 20:17:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 20:17:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 20:17:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUB9Vh3Bo//GUHmJvM2OQfwU2q18FTKXC3LpYGKT26Fqt2cMtmoqiKXC8IkTuiR4SDWQ/rkJvxFFSgYL8Vlrx/3B74mtKDm3hG6JsL3X1bVLz7yfQ4kUhd/2gteBdVYLuVYO4H6mjaUFjuAwgcunFvPekTv9laUBpDXPAaQ07evB/Yn6flN5if8dpncxGPWPsuVnVJOJvEQJMCoIXPs2XKeTsgHUbV4AWRP0q080YRS3A/RCx61HFsfUJoKBvpWwC0bSNZ244stISXSg/S+JCWknF9Yj2sTu3GocRYMXVwLJ0ZK32dlvFSSvSHuuoK/n3uqelJXy5JlQ1LkZzvAuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYA4qRXw4SnF2MroXP7kehwfr7sqSYanaxDSbE7Uif0=;
 b=dyI3G5vJbp1W9XAlm707HWm6z2PYYUTAIXsm04V8WZXK/ZVC6abdv0b/6q9lU9zxtu77LvTqwp8YQvS8NaYFR4P3f9iDPme2LOmmKNb7y84d7031e7C5vut9iccBM07RTEY3nfVW21DCB7n11r9BMPgvBTQuzG/i4GVlEF92g1ubho7GfiJ7KqvxuUsapT0W19PtRQsJ+XiP9xtfjYa0g/x2CBGkqk9S27dai5QgEV5EbKDKfZDUVfAo/Ynr99I2h36YXW/DXUbS7CryNQu08XAVLv/BpSXDIyCUnmMuA+no+Z6WXZLBF8ysFpFevDusukZpHkhCb7CGok4axJiDcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MWHPR11MB0030.namprd11.prod.outlook.com (2603:10b6:301:65::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 31 Aug
 2022 03:17:09 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 03:17:08 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Topic: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Index: AQHYvB5Zhte1gFzwtkKh12BdFyDkBa3IDqyAgAAq44CAAA1sgIAABY4AgAAChYCAAAMQgIAAAG0AgAAFhYA=
Date:   Wed, 31 Aug 2022 03:17:08 +0000
Message-ID: <a91f65ad5c392b6e34f07bc6d3f35c89a76a98db.camel@intel.com>
References: <20220830031206.13449-1-jarkko@kernel.org>
         <20220830031206.13449-2-jarkko@kernel.org>
         <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
         <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
         <Yw7EX5GCrEaLzpHV@kernel.org>
         <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
         <Yw7LJa7eRG+WZ0wv@kernel.org>
         <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
         <Yw7OEh7QP8tb7BR1@kernel.org>
In-Reply-To: <Yw7OEh7QP8tb7BR1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7580fa1-2459-4a7e-a04a-08da8aff49fa
x-ms-traffictypediagnostic: MWHPR11MB0030:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yR73xy84Yljm0poKz5nN4+M2E3jPWphMQLIzJy3rfHNCo3293Mxw1Qt1hm2vL6zOt5ddelaArKGvN8ZXaWZTCkM9ywQdSv5ZW/sEdS+1GkD0f75HIsj4MpKaFAJ0TYxfs7kTIk6xHev0aO1lmLzqiekPZLkihlUe4RhU1AN/2uO5+IgG4ArkurtQV+PGzb5EF/J1mIE0xuq4WZfsXpQdhvWACcSt3/+sBDnMF0Lr8zxYNS0sAtbrX+zjNHxyIKwpt6nSQuzNQefO9XjRIOgz1BNsy5zSSbtA1OPWNEFiZtJ4ASuWjQxR4UrqBhF2kzr/g9S/tBu+lCoMlKcM01GaVFw7nMZGQWeCuLAY3I6YvEIP8z0DYnprZR/uNfleZMDdHO6OWSpTaN7F2KLZcdX3mMCiLM/xLaUO5zzvWTXqKDVgRLtHA0dVpekkh89nDUTSgQYUHxI0PaFPJ86uL3gwQckaScrm81r5CkRD+xxOvAwa3EtVFBjHBGQl8wcIpgQkoyZhLScvH54/Occ2SPaVW2ouOarnNGvWc+QICFnzTpEA2gLKLDqmG9l7oJ1tXloaOl7MaKpXWMVcDsO0m4d0NaHIeL9jVURo0bwjN+dpVJYMFFmnwfau4fhhhBQ0v9JjhOiHfxB9Jh51XCfU5hy9miVRXAsl6EITnWfmSCzpH8bgoRuANZfnQFPo4Vi2Xav4ZZRXxckOYhwNZiN/dzTtSx+YE0NlOwlc91XwvSAxEBOsnOuu+ieTN+75BMEwtHJHW7NxfI6iZw4IwQkYXHYfjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(136003)(376002)(396003)(82960400001)(38070700005)(6506007)(53546011)(26005)(6512007)(316002)(478600001)(54906003)(6916009)(71200400001)(41300700001)(6486002)(38100700002)(122000001)(86362001)(2616005)(186003)(83380400001)(7416002)(8936002)(2906002)(66556008)(4326008)(66446008)(66946007)(76116006)(64756008)(36756003)(8676002)(91956017)(5660300002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWF5elBWTi9MVkdsV1BteXc4MTNxUjFsU1JXcE9xTWFBTWsrTnB2enY1SDZn?=
 =?utf-8?B?ai9HUUl0Y2xRSDkvZTNUaitYRVIwOGRXRUFYTThpQ0FJMmZTMkpUazNHZUtQ?=
 =?utf-8?B?a21GZ0lBVFJibWNYVlUxZUFXTEQ0NVczbWlsa2hSUlJiNytQcnE5NjhKZWRp?=
 =?utf-8?B?QlBnQWtaSjh6cnBYYmlJZHMzaWp6SWErV0RNeWlBTm9tTlBEVW1FbXNKcWdu?=
 =?utf-8?B?QVl5KytObE5ZdkhMaWdWQTVOOExhQlYzWkViSHY5MDVHT09TUnNxaFhBMkxi?=
 =?utf-8?B?K2s4ODI4VVoyWEltOVdyNUxSV2FaMmtKM1lySmN3dTR3K00rMGFTa1ZKOXZI?=
 =?utf-8?B?T291UEpOY2pGOGRJbVBQQkg0YUJ0L0g4dmtNQW9Dc1BMNXBUb0QvMCtZd1gw?=
 =?utf-8?B?L09OaHU0R0FWV0dXUW1OUjgzOTVSVEpMTnVsQ0E1ODk5T0dVUVU5R0xlaVhR?=
 =?utf-8?B?Y1JHZ3FNbEYxYnZ3T1FNQ3l2dlhIVmhFTU1HZHUrZmZFYmVvckV6cVk5K1E4?=
 =?utf-8?B?d3dGWlRDVUpkNmZHdkE5dW5mOEN4MlNGbjl6WjRwTjFQWFppTGd5QmlDMmxE?=
 =?utf-8?B?MWE0dnRXd3hiRGs0RjlxUlRxUzVtMWFnZkhIZmE0eUxaS0Q1bTFuVWJDdUxz?=
 =?utf-8?B?Vnl5cjlwSzhmRHRiRXdCdTVYMXJWV0ZCMlROSTBoT3lpMi9OanpKakEwMGhZ?=
 =?utf-8?B?S2hia21mYlEwQWl6Z1VJOXNWRXRWaXJaN3lCRlh2UFF1RWpJQitDL1hzbGw1?=
 =?utf-8?B?cFYrbGhsRUxRZkxhRkkxWW5CcS8xK1pjYmVkb2xEaGV6bjc5R3orTmlNWFVP?=
 =?utf-8?B?OVFBZ05yU1pyYjVBcURwK3JlT2lNRFFUV3E1RmowUlJ3dml5SzlCWDlEUE10?=
 =?utf-8?B?NWhrbEhkTDJaNzNtTVMvQlJkZDAzWWVDdGdyL3dFVmR4b3d2OUtqWXZkMXVB?=
 =?utf-8?B?WjU2bWo5bElRRUhDUGRaaFQ4eUtZTjJJNHZTRVQ5dnVPam0wZkZGcGNPRjBs?=
 =?utf-8?B?VnJYUVp1KzNEcWlOQ0ZzS240RFFTQ3doZlQ4cmI0MGZNQ2Zqa0QxbDFIS1VD?=
 =?utf-8?B?QWg4aEU1QW82cWI2bElyZHg1Ti9Ybml1UXlDU3BRT3M0MFAwaXdrMEJ0SVBm?=
 =?utf-8?B?cGdTUWRkV0VlL0RocG9qTnBNeVNxRXBlMS9Rc1cxTFcvRko0b0xIQ3FWeUky?=
 =?utf-8?B?ejFWb29SU1luNWIyOGMrZkFLckJ1WlJmeUJ0aWZBUFhBQmQvMHBsRU1uOEh1?=
 =?utf-8?B?Sno5RUUySDc0ei9YNFJCK2t3OXg3M2JvRzNORi9mUTFoOFZhY2pVRGFKcGZv?=
 =?utf-8?B?bXRzeHo4NUJsMnM5a09qa3d5R3p6YlJVdlZ0QnNlQmdFYmRObHRoSFp1V0dq?=
 =?utf-8?B?dTRmOFlsUm1uU00vamYyVTdzbGtJcnp4WTUyRU1teHZUOVFFRzFRZEZRbWtF?=
 =?utf-8?B?VXBwZTlmQzgxWlR3RkdrSGpWMk4zODhzeEkzWTFqUG1pbE82V2JzVzFVekhQ?=
 =?utf-8?B?dVM3NENNdVovS0lqckM4T2EvVEgrcElTenZhdTVURnVEMVVETDV0R3VaYWw5?=
 =?utf-8?B?NEp0ZU1XdENjeVM1K2htY1RkRGg1THpTOTNGNGw0VFFTNDdYV3MrclZOdk56?=
 =?utf-8?B?THZBVDltOVlubWJwWFg0WUxpa0tIWmszOVFiQXpMUHRHbUtmbzFzdUtsOVZl?=
 =?utf-8?B?ZGppMW1sSDFWTmZyMXR0ak5UNnpHQ1J2ODYwRTFaQU1Nb0FVamZmUHQzRERV?=
 =?utf-8?B?SCtoTXp1ZVAyNy9PWVdlMzU5bUJuWmJvOFVIMWJJaGxoOFYyeWg5M2xaTUlZ?=
 =?utf-8?B?dkRGQjlTTERVN1FFSzY0R29lMW5tRnJPQ1RMNlZVZ2NTeWoxNWJIT1NqVXYr?=
 =?utf-8?B?dkpBQmkwTGRNcytpN3hPVjRzTXpXK3U3SDBibHo5ZldoWVA1N0tMSlJKSHlS?=
 =?utf-8?B?UlpXYThVeGNQdURTZm94ekFna09kcGFNVVFSWXQ2bXpnU2VtTnZOVmNWWDRL?=
 =?utf-8?B?S1JiTzRwcVhNSFM4aFBmQU1PMlV4MzkxSkJnNEpvTGoxSEVxeUwzSngwYzIr?=
 =?utf-8?B?ZGd0dTY2eG02VjVQSXFwMk5INTR0dys0Z3hzWStyM3VYdDRPUEQ5TmtJdTdP?=
 =?utf-8?B?ZytZVFJSOTlzSU1WQWVyckJpL1FWYkdmU3V5aFhmS2JwUUVzQWhuc2NFcnBG?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8903A7E21BD20F4C8D2E2E9D61E3A6E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7580fa1-2459-4a7e-a04a-08da8aff49fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 03:17:08.8333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLB30C850+AoxSDyroLRmLiBq6PGfGobDQ4PVU6lf6NoyHVSWxmQ31nvQ9tziTfIz7dU14UhtGKTtLbamsBSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0030
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

T24gV2VkLCAyMDIyLTA4LTMxIGF0IDA1OjU3ICswMzAwLCBqYXJra29Aa2VybmVsLm9yZyB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMzEsIDIwMjIgYXQgMDI6NTU6NTJBTSArMDAwMCwgSHVhbmcsIEth
aSB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjItMDgtMzEgYXQgMDU6NDQgKzAzMDAsIGphcmtrb0Br
ZXJuZWwub3JnIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBBdWcgMzEsIDIwMjIgYXQgMDI6MzU6NTNB
TSArMDAwMCwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCAyMDIyLTA4LTMxIGF0
IDA1OjE1ICswMzAwLCBqYXJra29Aa2VybmVsLm9yZyB3cm90ZToNCj4gPiA+ID4gPiBPbiBXZWQs
IEF1ZyAzMSwgMjAyMiBhdCAwMToyNzo1OEFNICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
ID4gPiA+ID4gT24gVHVlLCAyMDIyLTA4LTMwIGF0IDE1OjU0IC0wNzAwLCBSZWluZXR0ZSBDaGF0
cmUgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEhpIEphcmtrbywNCj4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+IE9uIDgvMjkvMjAyMiA4OjEyIFBNLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+
ID4gPiA+ID4gPiA+ID4gSW4gc2d4X2luaXQoKSwgaWYgbWlzY19yZWdpc3RlcigpIGZvciB0aGUg
cHJvdmlzaW9uIGRldmljZSBmYWlscywgYW5kDQo+ID4gPiA+ID4gPiA+ID4gbmVpdGhlciBzZ3hf
ZHJ2X2luaXQoKSBub3Igc2d4X3ZlcGNfaW5pdCgpIHN1Y2NlZWRzLCB0aGVuIGtzZ3hkIHdpbGwg
YmUNCj4gPiA+ID4gPiA+ID4gPiBwcmVtYXR1cmVseSBzdG9wcGVkLg0KPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gSSBkbyBub3QgdGhpbmsgbWlzY19yZWdpc3RlcigpIGlzIHJlcXVpcmVk
IHRvIGZhaWwgZm9yIHRoZSBzY2VuYXJpbyB0bw0KPiA+ID4gPiA+ID4gPiBiZSB0cmlnZ2VyZWQg
KHJhdGhlciB1c2UgIm9yIiB0aGFuICJhbmQiPykuIFBlcmhhcHMganVzdA0KPiA+ID4gPiA+ID4g
PiAiSW4gc2d4X2luaXQoKSwgaWYgYSBmYWlsdXJlIGlzIGVuY291bnRlcmVkIGFmdGVyIGtzZ3hk
IGlzIHN0YXJ0ZWQNCj4gPiA+ID4gPiA+ID4gKHZpYSBzZ3hfcGFnZV9yZWNsYWltZXJfaW5pdCgp
KSAuLi4iLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJTUhPICJhIGZhaWx1cmUiIG1pZ2h0
IGJlIHRvbyB2YWd1ZS4gIEZvciBpbnN0YW5jZSwgZmFpbHVyZSB0byBzZ3hfZHJ2X2luaXQoKQ0K
PiA+ID4gPiA+ID4gd29uJ3QgaW1tZWRpYXRlbHkgcmVzdWx0IGluIGtzZ3hkIHRvIHN0b3AgcHJl
bWF0dXJhbGx5LiAgQXMgbG9uZyBhcyBLVk0gU0dYIGNhbg0KPiA+ID4gPiA+ID4gYmUgaW5pdGlh
bGl6ZWQgc3VjY2Vzc2Z1bGx5LCBzZ3hfaW5pdCgpIHN0aWxsIHJldHVybnMgMC4NCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gQnR3IEkgd2FzIHRoaW5raW5nIHdoZXRoZXIgd2Ugc2hvdWxkIG1v
dmUgc2d4X3BhZ2VfcmVjbGFpbWVyX2luaXQoKSB0byB0aGUgZW5kDQo+ID4gPiA+ID4gPiBvZiBz
Z3hfaW5pdCgpLCBhZnRlciB3ZSBtYWtlIHN1cmUgYXQgbGVhc3Qgb25lIG9mIHRoZSBkcml2ZXIg
YW5kIHRoZSBLVk0gU0dYIGlzDQo+ID4gPiA+ID4gPiBpbml0aWFsaXplZCBzdWNjZXNzZnVsbHku
ICBUaGVuIHRoZSBjb2RlIGNoYW5nZSBpbiB0aGlzIHBhdGNoIHdvbid0IGJlIG5lY2Vzc2FyeQ0K
PiA+ID4gPiA+ID4gaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseS4gIEFGQUlDVCB0aGVyZSdzIG5v
IGdvb2QgcmVhc29uIHRvIHN0YXJ0IHRoZSBrc2d4ZCBhdA0KPiA+ID4gPiA+ID4gZWFybHkgc3Rh
Z2UgYmVmb3JlIHdlIGFyZSBzdXJlIGVpdGhlciB0aGUgZHJpdmVyIG9yIEtWTSBTR1ggd2lsbCB3
b3JrLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgd291bGQgZm9jdXMgZml4aW5nIHRoZSBleGlz
dGluZyBmbG93IHJhdGhlciB0aGFuIHJlaW52ZW50aW5nIHRoZSBmbG93Lg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEl0IGNhbiBiZSBtYWRlIHRvIHdvcmssIGFuZCB0aGVyZWZvcmUgaXQgaXMgSU1I
TyBjb3JyZWN0IGFjdGlvbiB0byB0YWtlLg0KPiA+ID4gPiANCj4gPiA+ID4gRnJvbSBhbm90aGVy
IHBlcnNwZWN0aXZlLCB0aGUgKmV4aXN0aW5nIGZsb3cqIGlzIHRoZSByZWFzb24gd2hpY2ggY2F1
c2VzIHRoaXMNCj4gPiA+ID4gYnVnLiAgQSByZWFsIGZpeCBpcyB0byBmaXggdGhlIGZsb3cgaXRz
ZWxmLg0KPiA+ID4gDQo+ID4gPiBBbnkgZXhpc3RpbmcgZmxvdyBpbiBwYXJ0IG9mIHRoZSBrZXJu
ZWwgY2FuIGhhdmUgYSBidWcuIFRoYXQNCj4gPiA+IGRvZXMgbm90IG1lYW4gdGhhdCBzd2l0Y2hp
bmcgZmxvdyB3b3VsZCBiZSBwcm9wZXIgd2F5IHRvIGZpeA0KPiA+ID4gYSBidWcuDQo+ID4gPiAN
Cj4gPiA+IEJSLCBKYXJra28NCj4gPiANCj4gPiBZZXMgYnV0IEkgdGhpbmsgdGhpcyBpcyBvbmx5
IHRydWUgd2hlbiB0aGUgZmxvdyBpcyByZWFzb25hYmxlLiAgSWYgdGhlIGZsb3cNCj4gPiBpdHNl
bGYgaXNuJ3QgcmVhc29uYWJsZSwgd2Ugc2hvdWxkIGZpeCB0aGUgZmxvdyAoZ2l2ZW4gaXQncyBl
YXN5IHRvIGZpeCBBRkFJQ1QpLg0KPiA+IA0KPiA+IEFueXdheSwgbGV0IHVzIGFsc28gaGVhciBm
cm9tIG90aGVycy4NCj4gDQo+IFRoZSBmbG93IGNhbiBiZSBtYWRlIHRvIHdvcmsgd2l0aG91dCBp
c3N1ZXMsIHdoaWNoIGluIHRoZQ0KPiBjb250ZXh0IG9mIGEgYnVnIGZpeCBpcyBleGFjdGx5IHdo
YXQgYSBidWcgZml4IHNob3VsZCBkby4NCj4gTm90IG1vcmUgb3IgbGVzcy4NCg0KTm8uIFRvIG1l
IHRoZSBmbG93IGl0c2VsZiBpcyBidWdneS4gIFRoZXJlJ3Mgbm8gcmVhc29uIHRvIHN0YXJ0IGtz
Z3hkKCkgYmVmb3JlDQphdCBsZWFzdCBTR1ggZHJpdmVyIGlzIGluaXRpYWxpemVkIHRvIHdvcmsu
DQoNClBhdGNoaW5nIHRoZSBidWdneSBmbG93IGlzIG1vcmUgbGlrZSBhIHdvcmthcm91bmQsIGJ1
dCBpc24ndCBhIHJlYWwgZml4Lg0KDQo+IA0KPiBZb3UgZG9uJ3QgZ2FpbiBhbnkgbWVhc3VyYWJs
ZSB2YWx1ZSBmb3IgdGhlIHVzZXIgd2l0aCB0aGlzDQo+IHN3aXRjaCBpZGVhLg0KDQpUaGVyZSBp
cyBhY3R1YWwgZ2FpbiBieSBtb3Zpbmcgc2d4X3BhZ2VfcmVjbGFpbWVyX2luaXQoKSB0byBzZ3hf
ZHJ2X2luaXQoKSwgb3INCm9ubHkgY2FsbGluZyBzZ3hfcGFnZV9yZWNsYWltZXJfaW5pdCgpIHdo
ZW4gc2d4X2Rydl9pbml0KCkgcmV0dXJucyBzdWNjZXNzOg0KDQpJZiBzb21laG93IHNneF9kcnZf
aW5pdCgpIGZhaWxzIHRvIGluaXRpYWxpemUsIGtzZ3hkKCkgd29uJ3QgcnVuLg0KDQpDdXJyZW50
bHksIGlmIFNHWCBkcml2ZXIgZmFpbHMgdG8gaW5pdGlhbGl6ZSBidXQgdmlydHVhbCBFUEMgaW5p
dGlhbGl6ZXMNCnN1Y2Nlc3NmdWxseSwga3NneGQoKSBzdGlsbCBydW5zLiBIb3dldmVyIGl0IGFj
aGlldmVzIG5vdGhpbmcgYnV0IG9ubHkgd2FzdGVzDQpDUFUgY3ljbGVzLg0KDQoNCi0tIA0KVGhh
bmtzLA0KLUthaQ0KDQoNCg==
