Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F854AA45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354248AbiFNHOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354125AbiFNHNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:13:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668823B54C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655190824; x=1686726824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WRNmI1CxcN7z8HQuIbygiHzYGfAEnTfk7dN9+2LkR5k=;
  b=Hu8YM/1Lj8g6H20scHbftZWkBLEZCmMQ6H5Ga7uBheJ7nncq3dCqAoG6
   W4A8XhOba3UdqOmoWiJziz0FezVc7drDg4LGHBPsRHkQJhTyeBnXXF8sf
   NS0rQkWsV/DlCp11qK+YW/AVBqrt/pc3pj1EsXUqabK9qleDoHT4pBYdo
   dtQODhdY09uVpN8mirFY6UEK+9x0v9gWgGWzB/US8E+AkDUvctkaLXHtH
   nZkAjahL1SLlOBIeuOYqiLv0Sdl5bvGiX+SP/QnDrufLxNi9xpxlfcVW0
   FYDPTnMw9uenuwas0OSZ7CxR0THW7GbmX8nT81AVDu4Yd/g/8ip6sxuBQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364867951"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="364867951"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="673732936"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2022 00:13:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 00:13:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 00:13:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 00:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbgVI5HgBvFYHkd7j6b/7JaVdFEv4gVMloVeDw3PrSTk4CvS+hU9fGLk8d3w/ogHvSDfsm6AkP41e0uTFH1MuzsPU8mSsAEJ8vyPgW7lE5kz20fbCv2MsCRUWiWvksN0A538sdjWwRz/tAqrvzhngKF+dJUxL3J4yQED41MXwNe2Lbte/9SF/LxJpOHTRZXJRAiKraFBnhiEyz62ubsaEBVPL2vrqaAcPA5Su4UgcT4mgA+RbWvMVtn1+x2hcB6BzpnseAO4IX2uImLn/2AQfg3nwOhGPg99EOiS3yn3yZY2e8LqsWGwr17LMhunGk2qTXpPEaMjetxoWAWOCg5OUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRNmI1CxcN7z8HQuIbygiHzYGfAEnTfk7dN9+2LkR5k=;
 b=XKt+Sfdsutr2I95B6sijE9kH1BuEGbDNTlY0MvbAWW+/B5Lv1U539ewOeYEJ4m0U1lqD6HFtql8SAq/IE7OTnAbW8CRbP5MyZQdeTZKvkCYkYw1sH1xI8vczeBW9XnXA65VlJtaDN0ouHEiofcysIW/0ue3pWDdvsosPyJJDtRMQQlTh07Jn9qertC1+lgi2UesiAF47huAyC7xHUMkKk/KteBeES7qyCWLULq0h/TW7qq8Rm2hyRNwFSL1ZgT4oXwcI3hLDAnZJI3s0deLbSJbyvSSQyrc+Fn4KVFDWVNXBKcjppWnP83n3bQ3O8N0/6dr7mJuWGa3uDLdKRhbY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 SN6PR11MB3519.namprd11.prod.outlook.com (2603:10b6:805:d0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Tue, 14 Jun 2022 07:13:42 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::9da6:c84c:3112:7c3b]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::9da6:c84c:3112:7c3b%6]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 07:13:42 +0000
From:   "Liao, Bard" <bard.liao@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>
Subject: RE: [PATCH 2/2] soundwire: Intel: add trigger callback
Thread-Topic: [PATCH 2/2] soundwire: Intel: add trigger callback
Thread-Index: AQHYfHLSKQ+GFe91u0OO8MTtkw8Vx61IHEUAgACep4CABcfRwA==
Date:   Tue, 14 Jun 2022 07:13:42 +0000
Message-ID: <DM6PR11MB4074603AEBAEE96F84A75976FFAA9@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
 <20220610023537.27223-3-yung-chuan.liao@linux.intel.com>
 <YqLV7qexsdhCI7ZZ@kroah.com>
 <0c493f72-de7f-4c57-f1d5-47f982abc3c8@linux.intel.com>
In-Reply-To: <0c493f72-de7f-4c57-f1d5-47f982abc3c8@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d408c0d-b5df-4a82-1f25-08da4dd5698f
x-ms-traffictypediagnostic: SN6PR11MB3519:EE_
x-microsoft-antispam-prvs: <SN6PR11MB35193DE5D42E7E500868212BFFAA9@SN6PR11MB3519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8fpEIiDURTWBirbALcaLl5aOGlZjFn3/B5OndBswhpIQmGgR81LCKj6HyadoZTmMNXaO4VjWHmjr71WJf89cDrABXPKVpNi+YffuKGRXu4H0TooiV9C1KNXosSktqohXaRbDwoE9IXKHww6929T2yYk7pMsMXQFkAq9I+7Qw4Ntb/BEvQA1mEfSJ1Lj/OIiAGRDkmJsjZ+5GaZXdGkssjui2WEy0oHVEdIYFS1Nk7MB0HJ7QrsXOeC9M9ITvUbLNn5qU/A6aohA3KKx/NfWlOtAbRU2cajlhO2l8/+0k7sFZ0qFzBFHjktBujA599GMU6a+Jcplhuu2Un5/4OqAqoOQjbbu4TB1d4qlF3uQ36JGl/omdM2ak2XIFcjlkT500kHzsfWBcxUCw+JU7ondY56undmptpVnV3I9d1M5pWK1I/ZJsx/wPG7NhAOejQ1LKOfIXwqyI0A3I1QE1dYupAx45nNDNTkQvnngC0P18e7ZHZZISu+BGgrja6gNVWhKVizA/aDoZzbmIsMSgIaMuK8mCmS8E+eJskHJZRTCt2Mq4l8ldWUXxC5bghuYAw0pqmu3cjmhKIW3C46iuhPFIWvcuR/vOmCykdeb2HvDtKcu1iE2cyie1yl6hEktiepR7eC8GfWuVHN5Uazenye4NVAgu5pdtyIFT8OlWdhh2hWiSRDu17rl+j01aHpxIRjtKJoNcifnziGMx3gbonzECwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(82960400001)(55016003)(110136005)(122000001)(54906003)(8936002)(33656002)(508600001)(66446008)(52536014)(4326008)(8676002)(38100700002)(64756008)(66946007)(76116006)(86362001)(66556008)(53546011)(6506007)(7696005)(4744005)(38070700005)(186003)(26005)(316002)(83380400001)(2906002)(71200400001)(9686003)(7416002)(5660300002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2xFbm02dUNNR3Y0VzlxaGI1ZGFvQVNUYXZ5Mlp5QktkVDNBSTU4TndjZ3Rh?=
 =?utf-8?B?Lzk0cVZwcXU5bWNCNWxlZ2swWTNTcjQ1QzNSUDRtT3cvR21PVWg4TE5jMlFF?=
 =?utf-8?B?SVgyNEp4VDlPSEh0UUx2Qm5EbGJJUHN1c21OT2VXbVYvaEYrYnNHSVdGcnI5?=
 =?utf-8?B?LzIyOGd1M05FZGdaVkp6RGdrcnVwdXdkcnJSekY1dzdpNjdFSkZtMzU0cWVj?=
 =?utf-8?B?S0tJdmtEbjVFLzh0M3F0WDR6amxBZmJvamRUZDg3R2RNb1J1aFNkOWsrMVo2?=
 =?utf-8?B?UkZMS3JyRzJkdnFhbEJaYzkxaTRtT0lQNjRHT3lqc0pYRnZXcEw3K1RjbEhS?=
 =?utf-8?B?NlVvN1lJelZ3YWk4b204TGpSRWloTFpZQ2lWVEVFclZhUUNpaS9oSzhrUDBu?=
 =?utf-8?B?aHNpMHpnK1dwUElpWkFabVdUeHlXWnlRMUxNUVlpM3A2ZUs5My9HN2lLSEw1?=
 =?utf-8?B?VWdvSkRsN0JGTGFZMmpFT2tkajF3VTVrZ0FFWTVkeDNGWG4zTDlzbG0zT2lB?=
 =?utf-8?B?NTl1QTdvVjMyU2hlN1R0eWtWUDVSWWdjNEZ2ZWZxY2E2RzNqWnVZbFVuK3h3?=
 =?utf-8?B?bW1ONFJPWTF1UDNzNC9nbTRCNmtVQnAvR29BUmV4WGQySUtOYWFVSFBvbTZJ?=
 =?utf-8?B?UkhNcERmWnJiblFNTzVydy9QWFI3bldTbUVsbjNBbVhDVk5GdFV0TFlNSzBT?=
 =?utf-8?B?eDUrc29IL0dpN0hBNlRBd2Z3NlBmMXdnM3AraENJSjBFanpHb2N2L3pmRTlH?=
 =?utf-8?B?L2hRT0lTc1hLWVBnb1p2NFZjcHJTY3FkU2d6MlQrYzcyVmxVUnJWVWlDd1A2?=
 =?utf-8?B?R09aY0V0WE4rZytDMW1aVkRjNlR6TVl6aUN6Qmo5aFk0Ly9oK0RGUkxaMXNz?=
 =?utf-8?B?R0tyRUhlRnIwMU9saEtiaXVoVUx4a0w1OFdmYWROV2liR0RaNmlURE9pbmFR?=
 =?utf-8?B?eDY3UFp4RFJ2MWRBUjhxNVdSL1J1L1dkV0JVOGFZV2lFZnZpamZhSjh0VWtm?=
 =?utf-8?B?b2hYVHVHL2IzK1QzZVRwaXJmZk9udXcwRVZCMjk1dTNueGNLdzlWK0lpMnFM?=
 =?utf-8?B?RlZyb0xNbzdKWjEvbmE2N1p6cnJjMHV6bDFoMUQrL0JqVjc3cVQ4TWk5Vk8r?=
 =?utf-8?B?Zk5RSXl1SFUxTU4zK3N4enE5NnZtZmdWRk5ZaVpqL3R4Skt5aXJjL1QxTjFk?=
 =?utf-8?B?NTQ0NHJvY2k0QXQ2anVxV2NGWlJiRlRBWjNKSjh5aHJtVW1nWkwzZlE4aHFV?=
 =?utf-8?B?U2dBRlpPUXgySkRpeUZIY0ZuaDNiN1lyOThMTWF0UUlCeWcyQVAwa3RNc1pp?=
 =?utf-8?B?VUV4cTNjaENySkFwbWU0MTRicC9mOXBnOWlJa0JZSTkzVHgwUmhETTMrWG1m?=
 =?utf-8?B?VEh5a28wZlVZeTdDa3k0cjNTUjNBZVNXZklsMk5OM293TE1hZUpsTTdDalhu?=
 =?utf-8?B?UnBSVG9qMUthRVhOZkV5WVZkc0xZbTdERXhmVzRFZU5UbDYrQkN0d0pqZi9U?=
 =?utf-8?B?dytNSXJXZGlBVm12UFdObHBMdm1vbEQ3a2V5N1BxOEFUb3Z1WncyS0hRYWpZ?=
 =?utf-8?B?S0RVa2x6M1NvWFkrdElVZHlhbS8yVDhQbGVQZE5PaUVSdmdlYnZUd0ZhVkRv?=
 =?utf-8?B?MWF6K3NrUGwxREEyZGJTYmtvSmU5NTVzRUVQVjlZYlNIOHdTV05NTVArU01C?=
 =?utf-8?B?dVhWenFnUzRZODhrdm85elIrYVhkVkdrc0Z5UUxVV1BwQXBmY1pyVm9GUHhV?=
 =?utf-8?B?YVpqUkJMNnA0UHhRYldVWjlEOUxtSWJVdVRBTGNnMkdJWnVlVFlTbE13bzFr?=
 =?utf-8?B?dEdNeGR4em9yN2xManl2Zmt1Q3VWbi8yYnJCNFE1dzZCNXl0endYSlErU2Vi?=
 =?utf-8?B?a0NzQTFiWDJHeVVSUVQ4aWgrM3g1UC9zbHFrREJhRUNpODR1OTNML3Z5Q2Jn?=
 =?utf-8?B?cDJwL0JuN1lHSDdzeHVnSXNHcE9SOGJoQ2FPTDVzT2lOU1JZcFdZMXdXSHJE?=
 =?utf-8?B?REFSUit4bnRtZmQ4R3AybmxmbjNvTmkydGl0TGhuKy94Ymd4Sy9FZFJMcWZ0?=
 =?utf-8?B?M092QTFaSU5UZTl0Z09WZzJlV3NoRHQ3UklOWkdOcmk3VEExUitYeXpENlRU?=
 =?utf-8?B?VmsxbDRBalpBWng4eTVheUpqRTk1cWJBSkJoN2JmL0VRU3dka1FOS1UzZWJ0?=
 =?utf-8?B?dHVaU2c5S0Y1cWFjeTIycnkvU2RFTkFWVW5OUFFPeHNuNlFYQUtrZGkrWHNM?=
 =?utf-8?B?TDJPZmxUNWViMkZNODRxc3VjcU14UlMyY2x0UHdwMEZxYlJ0aEd1ZlFKUzBM?=
 =?utf-8?B?THFNdUEyWXVnaDJIaVppQ1FJNzNrSmVvZ0txTnZpVkowYjArV1dBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d408c0d-b5df-4a82-1f25-08da4dd5698f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 07:13:42.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/z1airP8rdzHRr7yJ3ZR+bF9c117LrFeVF11slkzexgVRm7YoTG8gSuUupXcXTkkOJ8HhcicCt5GMFGbdyJsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3519
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaWVycmUtTG91aXMgQm9zc2Fy
dCA8cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXks
IEp1bmUgMTAsIDIwMjIgMTA6NTQgUE0NCj4gVG86IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPjsgQmFyZCBMaWFvIDx5dW5nLQ0KPiBjaHVhbi5saWFvQGxpbnV4LmludGVsLmNv
bT4NCj4gQ2M6IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgdmlub2Qua291bEBsaW5hcm8u
b3JnOyB0aXdhaUBzdXNlLmRlOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB2a291
bEBrZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7DQo+IHNyaW5pdmFzLmthbmRhZ2F0bGFA
bGluYXJvLm9yZzsgS2FsZSwgU2FueW9nIFIgPHNhbnlvZy5yLmthbGVAaW50ZWwuY29tPjsNCj4g
TGlhbywgQmFyZCA8YmFyZC5saWFvQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAy
LzJdIHNvdW5kd2lyZTogSW50ZWw6IGFkZCB0cmlnZ2VyIGNhbGxiYWNrDQo+IA0KPiANCj4gPiBX
aGVyZSBpcyB0aGUgaW4ta2VybmVsIHVzZXIgb2YgdGhpcyBuZXcgY2FsbGJhY2s/ICBXaXRob3V0
IHRoYXQsIHRoZXJlDQo+ID4gaXMgbm8gbmVlZCBmb3IgdGhpcywgTk9SIGlzIHRoZXJlIGEgd2F5
IHRvIHByb3Blcmx5IHJldmlldyB0aGlzIGNvbW1pdC4NCj4gPg0KPiA+IHNvcnJ5LA0KPiANCj4g
QVNvQy9TT0Ygd2lsbCBiZSB0aGUgdXNlciwgdGhpcyBpcyBhIGRlcGVuZGVuY3kgYmVmb3JlIE1h
cmsgQnJvd24gY2FuDQo+IHRha2UgYWRkaXRpb25hbCBjb2RlIGluIGhpcyB0cmVlLiBJdCB3YXMg
c3BlbGxlZCBvdXQgaW4gdGhlIGNvdmVyIGxldHRlci4NCj4gDQo+IFRvIGJlIGNsZWFyZXIsIHRo
ZSBPTkxZIHVzZXIgb2YgYWxsIHRoZSBzb3VuZHdpcmU6aW50ZWwgY29kZSBpcw0KPiBwcmVjaXNl
bHkgdGhlIEFTb0MvU09GIGRyaXZlci4NCg0KSSByZXNlbnQgdGhlIHBhdGNoIHdpdGggdGhlIHBh
dGNoIHRoYXQgdXNlcyB0aGUgY2FsbGJhY2suIPCfmIoNCg0K
