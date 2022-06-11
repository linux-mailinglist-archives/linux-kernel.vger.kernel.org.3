Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740F954716C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 04:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349000AbiFKCgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 22:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbiFKCgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 22:36:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883ED23797D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 19:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654915009; x=1686451009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QuZ6ykwGODYxd5jZcdwQi2ZISesaZLe6qFOm6EMxoz4=;
  b=FN2WdTmeddjCsM9JbGmpsUBVaeoGBj44qU0nCl1YFnh1IpQ4eJNWy2Cg
   P8lgNsTRPGrZvELIzdFvT64O33K5uHga4Dtb11BKOTdUfAxQ4YWmwGV1K
   BRfVBpbZiiqSkcCyZh/H6SzxBEJ2+tt3mAEa7f3EPxgx3RwY3tDLCK/rq
   tVGyRfANgk+mwpXM7G9w+zCpJo8GJ8zMDOl/r/2pj0GTqNpm0yGvyUe4n
   ddgyAlBWwAc8rgLdjvUWV+AS0DurJ4jAunE3IFG11942z5QVzESmsyKb6
   lsR/abgLn9OtbnOd3sDS7c2XiXT8DWxTgxspnDvtka6Pi5DymtEr/tU+1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="260923535"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="260923535"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 19:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="581377632"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 10 Jun 2022 19:36:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 19:36:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 19:36:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 19:36:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEqVNjx2BNdxZZQYETDwnfrycr8TTlyoyPpZj45yJIfgbWuFYMFiJ0QoSIYwWHbni1s3sHwJhE8DXVIOUw3Q1yrWT/tIefFXHRnk5a34h56TC4U3eoZ618W56d4c059atR3nhhhE3H+0I/MMcWgvRD6SaLVJ7Ipcfx+g5BXZjq/c3awRMhM5zpNUz2DRhWPgNJHRAZSLT8P0+woFvQgwNF1KZH8DmwfNnQmgP860V3MajG6b0qeH+W9rCObYGw674sSAwsSY9jfuMxX63zCmDSanwEviF+7eRXH2jGLU9hI0SoOmpQ1x2StdNraNE5QpsPLRVAZM8vinVOtszbPDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuZ6ykwGODYxd5jZcdwQi2ZISesaZLe6qFOm6EMxoz4=;
 b=klXlvAYjZR2Ak/prrtThZaXhHGsgoctjtzmRyaHZMPGylCQKCcAth5y8IHx0o4/rlBnHEEio26jfvLl15d3gMbeQ2Kj53Pn++k0ZamVpbajKDp01Dcmoowu0spJ6YHTPM+2jXARcJp6bzMg/t1UdaGeZ+3EA0lgqfmPatVYjdcwo5apDiw80vw31HQVZDPoFEjOzYdg1gT/Tzad7CjtSYFnxV22z/OX/8yUgh6pGRhCs4gRyz02QLB6tJjbA+fFX9fKdgt5+Xy39I/ADJZbIvB9hlgMkDnHne8qrJhV9L5Fz+aeYWcLSWF1XQGTyUdpqj7JSS1smbJBIlfveOQoeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB3754.namprd11.prod.outlook.com (2603:10b6:5:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Sat, 11 Jun
 2022 02:36:46 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%12]) with mapi id 15.20.5332.015; Sat, 11 Jun
 2022 02:36:46 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
Thread-Index: AQHYfNjBqEEvHjFqM0aC2BTrZ5Vx5a1I0Q0AgAAe5oCAAABwgIAARekAgAAwkQCAABeeAA==
Date:   Sat, 11 Jun 2022 02:36:45 +0000
Message-ID: <f83cada24f0989a6943534fbbfb52fddbf17fa59.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
         <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
         <20220610180635.l44opq2votd3gxpl@black.fi.intel.com>
         <5b56c88e477d879e5a0e3c15627cb05901a812f4.camel@intel.com>
         <dda083610d4c8b8d8d0b09021345e9cc0cb35bbe.camel@intel.com>
         <20220611011212.ockffkv4h3fiwfdl@black.fi.intel.com>
In-Reply-To: <20220611011212.ockffkv4h3fiwfdl@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4c2915b-1fdd-4000-6fb4-08da4b533a53
x-ms-traffictypediagnostic: DM6PR11MB3754:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB37547003A2EC2895502BBAE8C9A99@DM6PR11MB3754.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HPbgsj/iVNXoMCeUTcyZIhax4x0uYUukO3elFAbKEJkHWUjFk15ufwfav464LQ5NtMYLnj2dcZlr8YxzfkDOISKnMbcRrstKqucmRZ03npAPMl4axp5ZrMUcQklpK9qFcCNpl2fPziB5pAdA9V4gZtxMYAV6K8kbC5e0WFxWCQHvwZHKVJ3CE1qq33d81rFdizVWh2hv+zo798qhW9xJZph/xywGnvckZOARmv0zCNQReMQx0eHI0ZIWUrX9FUWWO2iNtTvi+BKefG0reaUgwnGP4jxuBxVbCH9vEx9lGj9H+9K0lyWgXo5dLWVSRJkX7DN1hgrFZFErn3S+sicySwWd8yjBoMNQa5hsxX/8YRtzm7QG2lpHO3fMCUIQwhAY0ilmjlHaiUourlIXqEcUFCvgVQ1UL8AEQ+vAzaWe5nV4OPPdD6QafyQTZY6oSHsMjFQanizL+R5dZ9Aee52YuQJcsEknml6uwbWLO7lRdOU1CMJOHvetN1FZLIz6SGR6v6Na4TmxYbhTreaMcICPQIz2io3GJofJOO7Fn11bf72aLPI/iq/0f3s1bdK3+Zn6LPcfDtA7gnXu1OlFumr9XmGUaUmD5t6IkQqJdu/oMBtv86ZoQfP60Ab8I8xTSLtQmiK/ojHb1ERzhNd7SorAUh3w0burYdH+MVzlmY30wkjySIQ5hMXnMLDGqm80hKUQxmHATxlLJD7zXgFw1+uMcHpdQ7V7DkLI40R/h8ca4iM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(76116006)(38070700005)(6506007)(83380400001)(82960400001)(186003)(6486002)(316002)(122000001)(508600001)(26005)(2616005)(6512007)(2906002)(36756003)(71200400001)(38100700002)(5660300002)(8936002)(4326008)(66946007)(64756008)(8676002)(66556008)(66476007)(66446008)(86362001)(54906003)(6916009)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmRSV1c4cTZVUitac0R5dUdqb0JQZExieWV3akxWQTlWNllGcXF1N2dzOHlk?=
 =?utf-8?B?QlF6cjI1R0pqZ25vM21ySFZHWTVCZVJiem1zcmtmUUJFaXVCMlZUZE5ZeElV?=
 =?utf-8?B?eDlwVGFlelh3aXdCU2tYOEt3bUpvb3E3Z2E3dDNTdW1iamdIRzhGVGc3SVhI?=
 =?utf-8?B?ZUsxaWdFa21rSGJMN0JwMWpXRjMvS0J5bnFHK3Y5Q1VWTGxPRjhqQlBFcjJu?=
 =?utf-8?B?eDRwSTNZeGd2R1VuK3FNblBucmZnQjI3R0pmby9WK09URnQ0WXJ4eVBuQS9V?=
 =?utf-8?B?aHFwbzVmQlVxdkpicHRLVzBqdEtHcjVYSnY0MjJYSFFBeWFiNEY4TW1qV2Zp?=
 =?utf-8?B?cTE2YmQ3SlJlNXVhSnhWTU1aSUF3Qy9MZWtqU29Xa1hVRlRuQWh0SWdKdC9D?=
 =?utf-8?B?RDd4WGRhYmI0c09JTnRsNXV5ejBoWXQrZk1kNk1SZElGZUlBU05Bc1lOamFH?=
 =?utf-8?B?NDNVTGIxeEprS2JQWGdOV0RSSUR0UWhFRVJKWWliRDhPRTN0WXQ5WXd1cU9a?=
 =?utf-8?B?N3hjTFQ3bENJa2Z0aUtoSk5tVERrZjBuZ1M2S0NrWTNWR0dVTjhtd24vUzcv?=
 =?utf-8?B?dnQzWEZ1a3RVT0pRL0JLeWhSZ3dCdE5scnNIOVJ5VmIwNkN3b1NlSHRxWGo2?=
 =?utf-8?B?NVI3dktWVEJFUlJ0YTRjZGl5bmhwTVZSeWJjMStJSG1HUmxVUVBIK3pDM2hs?=
 =?utf-8?B?clNqZDd5L0dKOFAxdnhiaVV6Qm1WSzFUZ3lqL3YvT3JEMlVZc0Y0UUxOSWtP?=
 =?utf-8?B?TlFIOUpBT2ZEWEY2Z0owUERQQlVTeUczUGdoNWxQRDZacnNTYVliMGp4VUV3?=
 =?utf-8?B?R0dyQ0ljV3orbjh0YzNWN05JMjRMNVgvZ0hQd0xSUlhzM2pJcmovaXlzWlY2?=
 =?utf-8?B?ak55b1hTaWRJY0h6emszeVZ6V3ZVbW5jL002enJZc0dpTG13dWk1eFovU0Vv?=
 =?utf-8?B?dHlPZG1Ed1luVnNLMjQ0WFE3ZjJQUUVtNEF3QitaQ3d1QW1NQURkcEVQR1dk?=
 =?utf-8?B?WGY3WWFuc0tianh5SW9QeGlBYTZkTmdmVU5hcUR6anVGaGFzcUk4bExnZkd1?=
 =?utf-8?B?VDNza0dzMFRCR0VOQzZnc1U2di92YVVoS3ZERzhncXhNSEhHa0lZL2JWYWJR?=
 =?utf-8?B?UWkxZFJvM0FUV2MwekR6WmtDaDJYa2thVUxEdjhKYTRDdnJsL2piaXNuNWpC?=
 =?utf-8?B?KzA1MzkzQjFyRnI0S2JmMWY0QStHNTFRbkFYMENtMWx6T3VTenRadjU2a1Bs?=
 =?utf-8?B?TWdQd3hQL1RrdlNFdE8wZWlycndsRUxGL3pIYVVwVW5DaExyd2tsNEZSdnlH?=
 =?utf-8?B?a3lDWnh4R29Zc3NVVi9FeHFGaTJaWC9DYzJVa1dKMjBmdVhqT3VaWm1MdURr?=
 =?utf-8?B?TmVsdlpXdXoxSHNOSytEWXlqNmY2OWFuUmt2SVFrVW4vWTYrUXByUnByNm5w?=
 =?utf-8?B?VXo0QzBoNkVCalN3NXJBcTh1RnpWVjk1UGUyeCtWRG4zZk5QUHRkMzJBdUs2?=
 =?utf-8?B?cGZwMFNqeE53Z0ZnbCtJWmwvUXhscTI0c2RZZG5xellNRTRZemlWaTA0b3pt?=
 =?utf-8?B?TzlHU2VWNkt0VUlBRko3VU10WlBCK3dNeXk3NzNtZzdMNzlnbmtvemcxUVZ6?=
 =?utf-8?B?cm9mZmNFelhJUjJHc1kxT01iUUY0bzQzVkxzQjh3bHFFaHZGdzhXRis0YnF2?=
 =?utf-8?B?dWxhYXRFa2JJWGdmUnBBeXFUd3RaVkZjanp3UUVTNjhDSXpXalVla2pueU9a?=
 =?utf-8?B?UWVUSERubkFLMXNENU12QTVSZ2V0M2wvNGZiQmFIcklmRWxvV3VpOWRwU21E?=
 =?utf-8?B?MCsxdVJxOE9xMWszUDdYS3poR2FEOTZwNTFLVFpYVktIUy9Qa1d5c3BPNFAw?=
 =?utf-8?B?ejlGam9pV3ZjbWNRTVl4aWdmR1hpQUErNVpZOG5QN3F0eE5SeDBNbDMxdVp0?=
 =?utf-8?B?d3hMaForbFZOZ1h1VXhSNUZBY2JYV0FTMmpEV2VYQzZBZW1IRnRPcGRFamt6?=
 =?utf-8?B?UUQyRFpkNlJQSzF4RnNJZi9IdVBDY3VUUEc5a3JYNEliQ1NrUXdkRkxJTjNn?=
 =?utf-8?B?QmRsSUoxVFRiNHVyeXNLMFZqUTE4L1k1QjRnK1pPWFlKUGtUeGhsamw3bGwv?=
 =?utf-8?B?dWQ1MFNWMVcrWEpCZ0ZMR0ZpZk1jZHlUUjlaaEVCVUVNd3orM1l3RmE0UUJ3?=
 =?utf-8?B?VEh2aktLcnVBckQ2U0IzdFkxbGs5TXk3RTJuU0syd0o2Skk4S3hhM2ZrTWtW?=
 =?utf-8?B?ZnNvYzhOMDVLN3lac2pxejdBQmJqSDdBU25YRkZiV2RkZHA5ajRUSklsaDd2?=
 =?utf-8?B?ZEFqSWNJMWNxb09DMDFzTU0rR1JremxNMDFUZUlMd2NWT29zZ0pjTlV2aTJm?=
 =?utf-8?Q?3uK+S67pDKFWdP8dYTkmLjPPx9nicQ69Je92w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <822F6D9C50F701489296F1FF3111B303@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c2915b-1fdd-4000-6fb4-08da4b533a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 02:36:45.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUemWVvDkoFHuaxb0pqM9cZC+ORbdAbvtLoQxHMTxTPhCXWjaI4pvfHLbathFJmXYJVehEUWnA8cCGktzDYq/RXWpKZJErQ4t1XJdf9REvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3754
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIyLTA2LTExIGF0IDA0OjEyICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIEZyaSwgSnVuIDEwLCAyMDIyIGF0IDEwOjE4OjIzUE0gKzAwMDAsIEVkZ2Vjb21i
ZSwgUmljayBQIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMi0wNi0xMCBhdCAxMTowOCAtMDcwMCwg
RWRnZWNvbWJlLCBSaWNoYXJkIFAgd3JvdGU6DQo+ID4gPiBPbiBGcmksIDIwMjItMDYtMTAgYXQg
MjE6MDYgKzAzMDAsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCBK
dW4gMTAsIDIwMjIgYXQgMDQ6MTY6MDFQTSArMDAwMCwgRWRnZWNvbWJlLCBSaWNrIFANCj4gPiA+
ID4gd3JvdGU6DQo+ID4gPiA+ID4gT24gRnJpLCAyMDIyLTA2LTEwIGF0IDE3OjM1ICswMzAwLCBL
aXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+ID4gPiA+ID4gPiArc3RhdGljIGludCBwcmN0bF9l
bmFibGVfdGFnZ2VkX2FkZHIodW5zaWduZWQgbG9uZyBucl9iaXRzKQ0KPiA+ID4gPiA+ID4gK3sN
Cj4gPiA+ID4gPiA+ICsgICAgICAgc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50LT5tbTsN
Cj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgICAgICAgLyogQWxyZWFkeSBlbmFibGVkPyAq
Lw0KPiA+ID4gPiA+ID4gKyAgICAgICBpZiAobW0tPmNvbnRleHQubGFtX2NyM19tYXNrKQ0KPiA+
ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+ID4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gPiArICAgICAgIC8qIExBTSBoYXMgdG8gYmUgZW5hYmxlZCBiZWZvcmUgc3Bhd25p
bmcgdGhyZWFkcyAqLw0KPiA+ID4gPiA+ID4gKyAgICAgICBpZiAoZ2V0X25yX3RocmVhZHMoY3Vy
cmVudCkgPiAxKQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gRG9lcyB0aGlzIHdvcmsgZm9yIHZmb3JrKCk/IEkgZ3Vlc3Mg
dGhlIGlkZWEgaXMgdGhhdCBsb2NraW5nDQo+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiBub3QNCj4g
PiA+ID4gPiBuZWVkZWQgYmVsb3cgYmVjYXVzZSB0aGVyZSBpcyBvbmx5IG9uZSB0aHJlYWQgd2l0
aCB0aGUgTU0sDQo+ID4gPiA+ID4gYnV0DQo+ID4gPiA+ID4gd2l0aA0KPiA+ID4gPiA+IHZmb3Jr
KCkgYW5vdGhlciB0YXNrIGNvdWxkIG9wZXJhdGUgb24gdGhlIE1NLCBjYWxsIGZvcmsoKSwNCj4g
PiA+ID4gPiBldGMuDQo+ID4gPiA+ID4gSSdtDQo+ID4gPiA+ID4gbm90DQo+ID4gPiA+ID4gc3Vy
ZS4uLg0KPiA+ID4gPiANCj4gPiA+ID4gSSdtIG5vdCBzdXJlIEkgZm9sbG93LiB2Zm9yaygpIGJs
b2NrcyBwYXJlbnQgcHJvY2VzcyB1bnRpbA0KPiA+ID4gPiBjaGlsZA0KPiA+ID4gPiBleGl0DQo+
ID4gPiA+IG9yDQo+ID4gPiA+IGV4ZWN2ZSgpLiBJIGRvbid0IHNlZSBob3cgaXQgaXMgYSBwcm9i
bGVtLg0KPiA+ID4gDQo+ID4gPiBPaCB5ZWEsIHlvdSdyZSByaWdodC4NCj4gPiANCj4gPiBBY3R1
YWxseSwgSSBndWVzcyB2Zm9yaygpIG9ubHkgc3VzcGVuZHMgdGhlIGNhbGxpbmcgdGhyZWFkLiBT
byB3aGF0DQo+ID4gaWYNCj4gPiB5b3UgaGFkOg0KPiA+IDEuIFBhcmVudCBzcGF3bnMgYSBidW5j
aCBvZiB0aHJlYWRzDQo+ID4gMi4gdmZvcmtzKCkNCj4gPiAzLiBDaGlsZCBlbmFibGVzIExBTSAo
aXQgb25seSBoYXMgb25lIHRocmVhZCwgc28gc3VjY2VlZHMpDQo+ID4gNC4gQ2hpbGQgZXhpdHMo
KQ0KPiA+IDUuIFBhcmVudCBoYXMgc29tZSB0aHJlYWRzIHdpdGggTEFNLCBhbmQgc29tZSBub3QN
Cj4gDQo+IEkgdGhpbmsgaXQgaXMgaW4gIkRvbid0IGRvIHRoYXQiIHRlcnJpdG9yeS4gSXQgaXMg
dmVyeSBzaW1pbGFyIHRvDQo+IGNhc2VzDQo+IGRlc2NyaWJlZCBpbiAiQ2F2ZWF0cyIgc2VjdGlv
biBvZiB0aGUgdmZvcmsoMikgbWFuLXBhZ2UuDQo+IA0KPiA+IEl0J3Mgc29tZSB3ZWlyZCB1c2Vy
c3BhY2UgdGhhdCBkb2Vzbid0IGRlc2VydmUgdG8gaGF2ZSB0aGluZ3Mgd29yaw0KPiA+IGZvcg0K
PiA+IGl0LCBidXQgSSB3b25kZXIgaWYgaXQgY291bGQgb3BlbiB1cCBsaXR0bGUgcmFjZXMgYXJv
dW5kIHVudGFnZ2luZy4NCj4gPiBBcw0KPiA+IGFuIGV4YW1wbGUsIEtWTSBtaWdodCBoYXZlIGEg
c3VwZXIgbmFycm93IHJhY2Ugd2hlcmUgaXQgY2hlY2tzIGZvcg0KPiA+IHRhZ3MNCj4gPiBpbiBt
ZW1zbG90cyB1c2luZyBhZGRyICE9IHVudGFnZ2VkX2FkZHIoYWRkcikgYmVmb3JlIGNoZWNraW5n
DQo+ID4gYWNjZXNzX29rKGFkZHIsIC4uLikuIFNlZSBfX2t2bV9zZXRfbWVtb3J5X3JlZ2lvbigp
LiBJZiBtbS0NCj4gPiA+IGNvbnRleHQudW50YWdfbWFzayBnb3Qgc2V0IGluIHRoZSBtaWRkbGUs
IHRhZ2dlZCBtZW1zbG90cyBjb3VsZA0KPiA+ID4gYmUNCj4gPiANCj4gPiBhZGRlZC4NCj4gDQo+
IFVsdGltYXRlbHksIGEgcHJvY2VzcyB3aGljaCBjYWxscyB2Zm9yaygyKSBpcyBpbiBjb250cm9s
IG9mIHdoYXQNCj4gaGFwcGVucw0KPiB0byB0aGUgbmV3IHByb2Nlc3MgdW50aWwgZXhlY3ZlKDIp
IG9yIGV4aXQoMikuIFNvLCB5ZXMgaXQgaXMgdmVyeQ0KPiBjcmVhdGl2ZQ0KPiB3YXkgdG8gc2hv
b3QgeW91cnNlbGYgaW50byBsZWcsIGJ1dCBJIGRvbid0IHRoaW5rIGl0IHdvcnRoDQo+IHByZXZl
bnRpbmcuDQo+IA0KPiBBbmQgSSdtIG5vdCBzdXJlIGhvdyB0aGUgZml4IHdvdWxkIGxvb2sgbGlr
ZS4NCg0KWWVhLCB1c2Vyc3BhY2Ugc2hvb3RpbmcgaXRzZWxmIGluIHRoZSBmb290IGlzIGZpbmUu
IFlvdSB3b3VsZCByZWFsbHkNCmhhdmUgdG8gZ28gb3V0IG9mIHlvdXIgd2F5IHRvIGRvIHRoYXQu
IEJ1dCBteSBjb25jZXJuIGlzIHRoYXQgaXQgd2lsbA0KZXhwb3NlIHRoZSBrZXJuZWwuIFRoZSBL
Vk0gc2NlbmFyaW8gSSBvdXRsaW5lZCBpcyBhIG5hcnJvdyByYWNlLCBidXQgaXQNCmxldHMgZ3Vl
c3RzIHdyaXRlIHRvIGZyZWVkIHBhZ2VzLiBTbyB0aGUgIm5vdCBmaXJzdCB0aHJlYWQgZW5hYmxp
bmciDQpzZWVtcyBsaWtlIGEgZ2VuZXJhbGx5IGZyYWdpbGUgdGhpbmcuDQoNCkkgZG9uJ3Qga25v
dyBob3cgdG8gZml4IGl0LCBidXQgSSB0aGluayBlbmFibGluZyBMQU0gc2VlbXMgZnJhdWdodCBh
bmQNCnNob3VsZCBiZSBjb250YWluZWQgc3RyaWN0bHkgdG8gTU1zIHdpdGggb25lIHRocmVhZC4N
Cg0KSSdtIG5vdCBzdXJlLCBidXQgd2hhdCBhYm91dCB1c2luZyBpbl92Zm9yaygpPw0K
