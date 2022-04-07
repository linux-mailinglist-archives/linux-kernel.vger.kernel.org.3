Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A17C4F84A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbiDGQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiDGQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:14:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3271612C6EF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649347923; x=1680883923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GBjVkQkRpGdK3XvUa2t+36CBqOIJQYavkryWF4Mr++M=;
  b=S0veRIs+5Aeh1ljJWUqe/y8pRWYuX0XnFw9bBe7pAWr7yTEVc22Ir74u
   Bdm9IuB5AsE26Q/BIFu+4FzR0yg9oqDn8VEg1n9zCDZTJ9QXtfjAgGihD
   fYf6NRhzM81pQgpGeQJbnCq17Tgs9FO+fIu8QTaKPfDF8el5XgHpUs+Ft
   mbJjkSyF+mLTCb6wMlH/A44bM6UB73sAYB19Xv7/lRMOY/zS3wWQk2vlm
   AG1s2hlTZ6lgF6woJSQVnTj4zYuD0dOxNcwFNHga8A8wGWlSLjexUBu+K
   wXk8ETx4DoEk2VSzBsJuzj4hd7/5TSnycQPMpOZ9UA3kojeK7D8BSfrgr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241301377"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="241301377"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 09:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="621296929"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2022 09:11:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 09:11:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Apr 2022 09:11:44 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Apr 2022 09:11:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTS+lqz82vEBBbaEDG62hcKgSMGvCdLSFUvgyrqVsTla0qg70UDUhuPYduUL0FelLDgryQztiVIpN2LqtZGtm5Ahr0mFY5C6hIJWsaAInEIRf5qWp2YeuaTvC1DsJnNlS7X7jfYqSHL4i3/YOmKcBU+DMDD++JnQV9JKL3q5qRcj7sJ0GO8E9O9QAcEqs86Wq9Rcby7hnLXZPF+zSLpCpevLz3znt5jarCFGTpj2o1yx0/ijlzeQA1nPvpH+n6jt79hHUSnYXGrAxPcrEYwuas0fh3N6uT8SffHG/5DychWZ3SDu11lrxw1VNd9gmb4UdSeqCa7RTVX9MHWs6H5pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBjVkQkRpGdK3XvUa2t+36CBqOIJQYavkryWF4Mr++M=;
 b=cd2JHXb1u+LRwFhCC7S5edssyQckvU8wZiWUgQ/CwPobUWIaBnPszODCiNux7SewV1zgnce2esmYMloO5M2lXscw0+50/HVZ+9o9ke1LPkbcSEot1Flfmong+ll4ZQ1lluHYEAbxB9RDmou6AS9j8glD5qVH31riXPEHKTmx/OBMtwKbolO1xRGmrIpxf3/y/anWoSHOZCkwH7z7HQSakdDuPlSD9NOfrxK4WkvTFEI8DPW6gAbKDLd+iBlDTScKt0Hz11zONiKjtqkkU6xgg7ZghRUMnk/SCl19nJpJM9gxigh0Fq7i2l5kUgTKDcu+4LhBntyOnlW9VtP0XXD91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN8PR11MB3745.namprd11.prod.outlook.com (2603:10b6:408:88::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 16:11:41 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b%3]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 16:11:41 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: IBT related objtool warnings
Thread-Topic: IBT related objtool warnings
Thread-Index: AQHYSge+yAgGuYjLVESuJPg8GBiYNqzkmoUAgAAEg4CAAAE8AA==
Date:   Thu, 7 Apr 2022 16:11:41 +0000
Message-ID: <77bba8d6aca596f7d5edc576c74ab9326b061bb7.camel@intel.com>
References: <314eeced310b07b50b500384741378e59168c36c.camel@intel.com>
         <20220407155106.GL2731@worktop.programming.kicks-ass.net>
         <20220407160715.GB2762@worktop.programming.kicks-ass.net>
In-Reply-To: <20220407160715.GB2762@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df63d94b-b53a-4ad4-c591-08da18b14dae
x-ms-traffictypediagnostic: BN8PR11MB3745:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB3745DCD9537E5E49F391D106C9E69@BN8PR11MB3745.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8asqPg7MWCKcPc58zZwuHow3GWvwHB410myQHb0eQz2PWfoNivIVr/dMPKoDiA6uFf0FWke5DLFbmmVVRmAdqhmIPWZGrWX6hipoGrtV+Zz6w6gJKNKQ7OAaUxmBJk/HrBvyLAuqzZOIGrwoL9T19Q6Zha6/jh7SIv8MWxIAHamhp5ciDAh86yYtzW491+HQlixAFVJV98tgCAsUttL/8m0cVqqgPUSfKU6Pzfp+U+C1/f8zoZwRtZzTYQIsYJVyU6zNve8z6xL28XyADUyTue7TBYtGsaapwK4mW8m05luxh2HQPhP/jPumxjvtLFQIn9r7BDiw3/TF9o4uWUAj4ZjEsY9txQQpyHlYq1CdxglFN+A+TtetAa2F92Tfqf1kYmpLMLGGHs/QpCkGyGNFjt31ywr3G2r+8EmdWPFQodXrqj1DlbkL6mCa2YotspG06F/FLiZYhY2YU2GlHIwjv+TjlHgEwwt8Ly6AYb4ngfXAtnSn2b3D5k4zZE6Q4YuyxGVAZLEEEhla5tWUvbDPvaw3Yr9pU5SEytIDqxyzwRumN/7/E/F4rD6+anp8jZl2eGOSBUyRUWqY3GxlFUeprjWtnA66BmCeHw3LYl0cF4W82PZH5ZPyiUJyt9BZw5rNBx4casRwfhnlub2X9fXR2xNWLJ8C/EIlkNY17mSrk7iy+fsiyYaTg7+rt+12Se6t8z8zVWWxt3pMY6FPPIevZg0WPBIOXbURqOIj4dIU7Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6916009)(4326008)(26005)(54906003)(71200400001)(8936002)(38100700002)(122000001)(558084003)(66446008)(64756008)(66946007)(8676002)(76116006)(316002)(38070700005)(3480700007)(2906002)(508600001)(86362001)(66556008)(66476007)(6506007)(36756003)(6486002)(2616005)(82960400001)(5660300002)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2ZGek13WlNvMldUQ2xGdGhBYmdDeWNJOVFWM3FGNk1DZmdwK0NmMyt1b3Nu?=
 =?utf-8?B?b2x0TWxwUlk0aTRLYW1lV1Jnb0gvdi9hQ0xpVFpDeTZ3RkRsMFdLOXRlZXk1?=
 =?utf-8?B?anc1UDNWa3Z4QnFKUWNZbnd5bG4rUDltSm9qSURKOWR6REFiYWdOaDdzQ0gy?=
 =?utf-8?B?b1g2a0cxK1Nwb2ZBRnEwNkxZL0czNGdHdDhsWTJkSnlnV3R4aWNjSDI3dmly?=
 =?utf-8?B?QTZFdXFYN0lSbmEvTFhWdjE3WS9HazIrL09oY3hMMytvbE40Zll5QTgwZDBX?=
 =?utf-8?B?SHlwekI5Mm1DU0NNWnBLM09lVzN1YzN6U2VITTVYU3ZEWjZBMDdNNDZENHNG?=
 =?utf-8?B?aStuWlN1OGViTEh6OEhFRng4aHk5bkxnWEZWNzhjQ2tuTTVJWlAwOVM5KzZS?=
 =?utf-8?B?Wlc0cDFZZVNsUHlZWTRKVFBsVGQ3NHQ1OWhUb25TK1R0ZHlIVG9jTE1ETzBl?=
 =?utf-8?B?TG92MFY2ekttY0xDaXJ5Z2poT1VyVnlYemY0Vi9jem10Z0ZSQVhQalNyRm9V?=
 =?utf-8?B?TCtHQ3JuRk8ya0NydEY0OTUzVENkZTBlRlduL2JHQlFlWjVMVk9iSFZWL0I1?=
 =?utf-8?B?Y3N6Z0V2OHBob2NYb2VIL1lGWlYyckI3Si8xaHdWR2RIeWl2QU1yeVpqTHJN?=
 =?utf-8?B?Nm1XQ2gxVFR0RDMvWjVIeTdzMVdmZVJ5enNqazJReWxXcnowbWJaYjhneCtn?=
 =?utf-8?B?ekYyNUZlNDR3dkFKa2cvQjA5T2xYRzIzNFFUN3JyQTNzZElwNFhoOXQ3L2hj?=
 =?utf-8?B?cmQxbWk0MWxCcGZnTDY0Rk9oK08zZ0dTc1lzSDlBaEdxaituZ1YwajNtWTVT?=
 =?utf-8?B?T1piemJIbnJVSjRCUDBnaXR1U2VlMytZaURPUXA3dlV4VHc2TloxNWRUbkVK?=
 =?utf-8?B?TEpES0VvOVhmSTUxa1cyYVRDdnlMWlVjZ0FoYlVES0xQNXVqSHhzTEx6ZUIw?=
 =?utf-8?B?RXlNM0tsUG41QjRqUTFxOCtBNjJmemNDQ2pjNkprbnM4ZFhsRzd5Nm9GbzJV?=
 =?utf-8?B?ajFMZFlpVnZFeWJqSmphN3FOcnlqaHExNDRUYjc2aERvTnBqelpEWDhlS0R5?=
 =?utf-8?B?bXFjZjdoZnE4dlVvckFqZFoyNTJadkFYV1kyM3BjUElXRXNuSUtLcjFWaUJ3?=
 =?utf-8?B?eklJeXNLY1U0cGlySnlGOFIyUlZINEQ5YW9qbXZJQmtpUVQ2NVVUY2hxNFJI?=
 =?utf-8?B?dkEzaExGWTVaQTZrVVJQS1FBRXlqRUcyVUtCdjk5a2pYdUFyMUhrT2E0YzRF?=
 =?utf-8?B?SEVUV3haT2tFVkFTeFlJcEVLSVpUZWN3WjNuWTdKL2V1ZjJxdzdUZzlJRk9U?=
 =?utf-8?B?ZVl4a2p5MkhrclczRVhGTS92M1NWRjFzL1ZjZUFocm9qTmMrdGFZaEdralNm?=
 =?utf-8?B?bkh6TnJGVTFzcVZXU1M2RURFOU1wMlcxazRleUVlcGpyQ0xGOTI4Uy9NQkpP?=
 =?utf-8?B?cCtBVzcvRG5WekRjM3lWdXNHeDJlTWc5MXl6REZmaURoS0VpRWZ4NVpMYjQw?=
 =?utf-8?B?SlYzeFdTQ0Q0NnBOQ3crWDZ5QnljUXIyN1J3UEVOSm5CYTFHSS9wdG9EMlVW?=
 =?utf-8?B?RWR5LzJDYzdhVlRZQlozWjEzdk95VTVvVndoUlRzUFgzcmRWVGdaUVNFdG5l?=
 =?utf-8?B?TDhuR2pHaTlvQnhIR21NUjc3MVBwWHVzQ2xWUlBvQ2V2ZGgvc1FGTU1zc3lS?=
 =?utf-8?B?YjdlSXcxd1o5NW0vVHg3RE1UT25PNVp2YjRNdHJNSmhPcVVFZmhsM0h5Q25V?=
 =?utf-8?B?ZW1SclE5OURBSWN6N2JWQ25FTHk2alpLbG9LVEszQm9SVjgvSW1vanNRcHNs?=
 =?utf-8?B?VGh3MlFNUTIrYlFvUkowNzB4R1ZieUVIQm5XSFRDSmwraWY2c0tkMlhzRWZD?=
 =?utf-8?B?UldselVZdUx1OEM4V2Vid3FETU9JWk1VZmEvKzlaYmVMaktiY29VSWJTdm5n?=
 =?utf-8?B?NmJudDhDd2RLNXkxdFRqR0dLWDJNSktuVUtwYi9ic3ArWTN2M05ldHp3SDh1?=
 =?utf-8?B?cDRVOEh6ZEJSMlUwMDhERkNONVRVdFVJb0ZBZEx4YjhBUENKeGVRTE9rWTNn?=
 =?utf-8?B?MlpnczNXZjFQZUZ5dURWc0lTWjJJSGRiaFh5c2ZKWVdIN2hlTXZqcmVhSE9w?=
 =?utf-8?B?anNyWWFlaGcxUmd4cW5rQzltV2ZJMGlESCthRksxYVlqc2tqcXEwQUxkVzVB?=
 =?utf-8?B?MXpzL0JvUkNvU0kwbHFadmEzTE1YekgvbCtRcDIvamNQOHVLQVFETzJaUjJp?=
 =?utf-8?B?ZWlncVRuSkxmME02aHprNUUrU2dRWVFYUFBDa1BINkNESXJGeG5UM2pidGMy?=
 =?utf-8?B?RjZackY5UVJaT3R3NWJ3MTNYNWRVa1V5Ky80YWh3ek04bnlhMzFIbktDTXBY?=
 =?utf-8?Q?HE4cEEBh6hNkUFfNwc2Cu8gKkcz5h+hXOSWvc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81E323B114C9524B86159912795220CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df63d94b-b53a-4ad4-c591-08da18b14dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 16:11:41.6830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0wKhH3ukRpKOkliQbsyG6oRdKGRa0jkm+gdCMvtuNoJnPNf80c/hzDsaMPQbUcJNCpckVT9AU/q2WPbimbRtarVi2HaLcRppU1MMcZdD+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3745
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTA3IGF0IDE4OjA3ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gQW5kIHRoaXMgZm9yIGdjYy04LjQNCg0KSXQncyBmaXhlZC4NCg0KVGhhbmtzLA0KDQpSaWNr
DQo=
