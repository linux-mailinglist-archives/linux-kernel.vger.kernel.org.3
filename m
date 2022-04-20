Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16170507FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359295AbiDTDmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349095AbiDTDmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:42:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2682F111E;
        Tue, 19 Apr 2022 20:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650426006; x=1681962006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NsJ9PYv8qIHidqFAvFUveajyWeLCRc11CN8BaXUlmiw=;
  b=JgUZWhOQ8Qg15daBTDiP2gXcT0dozyQ5IuXLy2QHVfa57RxBQoadIg3G
   gLJBEjx6pRv/UDIeInj61eAg3xDIVhTSzui6W9IC4Ds8D/R7NlM/CQQM4
   ZvEPtMG9oskSifR2Scjgm22JWgjuPOHPIZfBwNMeqhWRF+Z7u9rLcYs3z
   +3+7HuEpZPCz5ahz2jbu5P4RlUOTNidewlFJljBUF6kbETKnRXvvOq1g2
   zEaUGK17Yhpb+rh04mbyXLJ6ip+KBxUj1YFVt+ijJpRF93/r62UMDSYn2
   +3JEcXOPmxtki42vRRyCsirv0qjwDkTjVs73cidNfYVvlDQgQQRGIkCUT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245823096"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="245823096"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 20:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="531178539"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2022 20:40:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 20:40:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 20:40:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 20:40:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngHPXiwg+8OJycEh/zZ7BKK3E2k8hyx/ddllZjVC4iDdLOvjvpAHNe8R2/i9WX5Y8n8mmcNG7boHVXXWnOv4GEhIjekFBR/sFw7n9o3ToTZmZYONXfkgHxyC+NfxGoZ3Ff7Jt/a6L7RF0Jrs6Kp2WluRINf5o7WzP1maMKrciU71P/JbS62jlaSwUG38qQS3WgRlpd+AVM+qaBCIVV4tm/rjgrypawyo1N2BTj+0B9me5CmwaU4QP/d/auXZpIL0SspnSLh2RQN6T9e64VNxdavG/FDC5GLqT9XqIBevOMJaA5a0+eaPn1ovhFgOVfE+V4AqmGNxnepyfLnPoZKyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsJ9PYv8qIHidqFAvFUveajyWeLCRc11CN8BaXUlmiw=;
 b=K6XzOzMhlUEHrXe5csm3ai237YE99we7qoQWVDp/qBuVBDVWwakVzLbiDvgJnEcizvgQLVvyk/taNEPDjrXfIqp3JMFm/yYuiedoQNEk7oFwi4B8WtjHxhPUeGkoyn2sog8pG6piCGF3EjOvIAocuIRWJcrfge7oFhu5i5HEbeJinsFdjona2nTCf/Pvx9IvQfZo2YpAZF3g5YjlU1e82ozv7gekD/qiDMZY9Ndq6yGZlCy6+zWWCs407Mu33Xtjj7a8XCQu1wlU+TweJIEe8gzH7mGvfvmY3x/zuMu0I87bhBIFjQJRwF2Cye9x825DqAx7436S+qrrQAlwxERMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA0PR11MB4622.namprd11.prod.outlook.com
 (2603:10b6:806:9c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 03:40:03 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5%6]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 03:40:03 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH RESEND] blk-mq: fix possible creation failure for
 'debugfs_dir'
Thread-Topic: [PATCH RESEND] blk-mq: fix possible creation failure for
 'debugfs_dir'
Thread-Index: AQHYVGhRDRXwVlyXjEuH8PI6ymwRjQ==
Date:   Wed, 20 Apr 2022 03:40:02 +0000
Message-ID: <97c78b6cbb95c2e63e2ef70a8901360f4ed23dc3.camel@intel.com>
References: <20220415035607.1836495-1-yukuai3@huawei.com>
In-Reply-To: <20220415035607.1836495-1-yukuai3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-3.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3f1dc55-11db-411e-1931-08da227f742f
x-ms-traffictypediagnostic: SA0PR11MB4622:EE_
x-microsoft-antispam-prvs: <SA0PR11MB4622FCB93736122B47EB1A33C6F59@SA0PR11MB4622.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUAbe3RIwJ1HnhKXEdTGP1qHPHhm4qSKABYHD+0JwimQW1tMkQDhq6gFKgwqdE0yBJTihSYekXmzUEz7M9zI62cHPiooNe/MB/F6rApHHP0ACygWEJc8MVUd2ZFBHAffe1rMDJBt4fyfVRPqZhdh65y7E2DzJzeLaVQ3JogqCgNTwquBJJONDBUzA79k9VqcUyeJ94Mv6HPQHjMnwe76nTIHkvoA4ieKDTrduyTNKQLz1wgCMVER/o9doW2IxAbIwR7/09NHjLPR4Ro8IgEdfwTsNqZPuxeN2Tvh+2viw90k66v674fRJm8fROaFAMB5XxgSyVDPXQPpJkirzknGFZMUXe88NVAN55eegNdkNNi/OA3ous47ele7T2uyLuRWRNswl2hFWXAecvjrrLTG2ZGYjwMvxGw9ErCnHW8F+B4NJU8UMeNpu1sjNUrGS8jJDCEbCaSA3TfY65HBEpgEN5m96LMcNJ/BvEIF6FelWkB2sLb6oJ+oMLRiPdjinxEusbEV3iSY4krcQHROoZ9AbJyaj0Ssxwp4Ivy6eFX2+0N3/FSQjbBWBxK9DG/MyhFpV1NjXxkEhmrINQHjT2I+sNdeYTAqSF790agVLIu1rBwDlIrmpvLL1jw7rHodNijPO6wsyyPoTY2s1KHEa4wo8eZ0yiZnVC6KbZbDQk1AFvhG+WgCM4i56vFNHHD8ylheRVleyvQEvJu3/5CgUSEzAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(4744005)(86362001)(64756008)(6512007)(26005)(8676002)(66476007)(122000001)(2906002)(2616005)(66446008)(38100700002)(6506007)(8936002)(71200400001)(6486002)(38070700005)(110136005)(54906003)(508600001)(66556008)(36756003)(76116006)(66946007)(186003)(82960400001)(83380400001)(316002)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTdyNmV0MnVjcExNUVRWQnJESVZLU2ZLeUQrQnZJcEtERnU5SmlJdGxIYUZh?=
 =?utf-8?B?Wk1LTlpVY0s0eG5mclhGT3pCcTd6UkU2SEU4M3dMRjFPd015UFFucFh2Z1c3?=
 =?utf-8?B?N3RKNlo2RUNCOEdIdFNNRVJ6dEJoeW13RHJlZ20wNzFES09ZdVUvWHdQRUly?=
 =?utf-8?B?bXlmY2R3cW44c1dYRE16MXd3Yk9XSWo1NlRhcmxJZzhNVWx0QklMdm9KK2o1?=
 =?utf-8?B?U3FRMFQ1TCtkU1FQRkV2SDlBbTlVWEYrK25JOEx0bzFPWkkvK21mWEtUdHdq?=
 =?utf-8?B?bXQ1aENIbTlsUWdiTlFvcmw3clRWdFdSV25JbjhFZ053aGxxM0JUWGlZVXpG?=
 =?utf-8?B?TjRtbW1TWUMrZHRWUU9pMDdkbitHWVVwWEdMVmszUElaNW5BamM3M0tIWTZr?=
 =?utf-8?B?Yitzb1BwbHVMSGc1NmdhdnF0NVVNaXVpdmxwTjlrb2VkcFBRTytTWHA0emsv?=
 =?utf-8?B?ZzB3dTdUNEFRQ2R0QmdleVNHTjV0TWxLeVBPem1GaFc4K3VNQmhybjR4NDBI?=
 =?utf-8?B?WDZyS3NJTlJCWGZGZVA3d0EwUjByS1ZtWVhoMW8xdSt5RHE3WWVQOHM1d0J4?=
 =?utf-8?B?Wlc3cWtjUGg2SUZ6aHBGQ1d5OFgrQzd1S0hqVkhDVmJKYVdiRzJsWWhXWDls?=
 =?utf-8?B?dkNmWFp3NWNQVHJrbUxSdW5IUG96YlB3SWhWSC9BT2ZwbE9ZS1lXbmRjMU84?=
 =?utf-8?B?ZTgzNlhLZUhEN3QzeVZKUHhzdlJick9LQWlpTVJ6OTZvd2U3YmJucThibWxS?=
 =?utf-8?B?MWJnMmR5TnIzckxDc0xOakNEOHlncWZBSjA4RDRwMlJYemk3dFZQclFiaEpD?=
 =?utf-8?B?L1dBZG01N201eFF2Z1lGQkpYTUcweUN2c2hETEtrY3JiQUNtUFdaNWFtenA1?=
 =?utf-8?B?VUt4cXVYWXFvOFArVkhabkhiQ0RYVjVZOUxRUW50R0hqSmNkVzhZRnV2eFl0?=
 =?utf-8?B?Ukd2MHlPZDZQVHlhditwUHJ0am9rODRLcGVpeWVQL09IQi9XZG9HSmpGZUd0?=
 =?utf-8?B?aFcxdDZhOEtJamZjVDZWRGdnVHRCaU13K2l1Y1VLdjZwQ0hnY0xIQVRUZ0h3?=
 =?utf-8?B?L3lGeXJtSUtUVnpiNS9RMXRuRUNIZE9rTHFVNDE2eGZJeTF2R291aDhpRjZO?=
 =?utf-8?B?S0pIMEs4ZWhueDdiYWc1L3BVNTVUS0Z1b3hleGw3VW81cDBrY242ejU5UnBs?=
 =?utf-8?B?UlFGbjNoekowTFRRdXY2amx5TDdETDFHaHJycWVlYzg3SEcxakV2RXNSRWVV?=
 =?utf-8?B?ZTNVamlpUnkvWitQeGY5eGFIMzQ1d29aTUJONGF5OVI4RWxBMXNJL2k5SmFE?=
 =?utf-8?B?Yk9GVzNQZ2xjSFdYMXFHY1l0aWtnaVpMYW00ak1mQ294Z01DNnF2SzVGcDFW?=
 =?utf-8?B?UExUcnZHcXVPa2NkcHBwc1hLZWNJclNHdWp1a3hvVDI0SXlQbXV1U1NBUlVL?=
 =?utf-8?B?bDNnUXN0V3VRaDhsNlVJZzhqNGFlbGJLam0ySDA0NjZVSzR4WC9pN085UkxT?=
 =?utf-8?B?NzByVU1ybnlTQTNoaGZxZ3poOGhrSk43U1FmaFA0enllS3M1bCtBdnJubSs5?=
 =?utf-8?B?STdVdzdCTVZod1M4cVpQUXBTMjd4MFRxaXYvVEVjcHlCT2V6QTNtdW9lUW4w?=
 =?utf-8?B?VlVsUm5lSDR1ZjFUY2k0cmoydmxOTTR4eEdZdWhXbTFxeFhFK0JGQzU5WFRo?=
 =?utf-8?B?RFhkZHJId1NBc3JVbjJIL0tSdDhnMHdDTU50cEYzMWZNMmNWdER1b0dFZjBa?=
 =?utf-8?B?R01YcndCL3hiLzE5V2VBVGFqa3N5NkxDMTVNelJwMkV3VC9hQnVNaWcyUE9q?=
 =?utf-8?B?YzljaWttcjdkZ054WXNrLzdPOG10SzZ3SFBVZDNwRnI2WTVVYWt3aG05WHAx?=
 =?utf-8?B?R1Ftbm1hSmdabzBhU2F1WXBHdGtVVUovUTNBMW5MQXU3WUplL2tSN1lSYlFY?=
 =?utf-8?B?Q1JyT2c4eHlCaFpuRlpGcVJENldHUE1zcnNITXBJdGtnVE85VUtlaTJBTnVQ?=
 =?utf-8?B?U01UMDJDZ1UzSTBwWnN1TlJYY0IzdllLZmo5UlplN0xZYTRlWk1IRVMwVTBD?=
 =?utf-8?B?UnhpY0RwME5GdE82OUloZkpFN0VmR2EweXpDa0Ruc1ZDUTZxUEhWL1pneEpM?=
 =?utf-8?B?S3ZwcFFrTkZnYzhqYmJKbWdaRFFIcTNNcTczdTdpckpONVVQL0ptdmV3c24z?=
 =?utf-8?B?RW9ZMzhjMWFuYlhGN09vQmJLbXJwUjNaZStJU1kvU1Z6WFZTVVpFUm8reUNp?=
 =?utf-8?B?TVlyaGJsTWg1QllPM1h1b08wREJCRmU3dElTajc5QnZFYUloUzdxajMzZWY5?=
 =?utf-8?B?MkFrV29ZM0JrMThzSllTQ2ZObWZJckVIWldzblQ3d3JPbmlwZy9CdmZ5NGpI?=
 =?utf-8?Q?HS+aUSP6jpvqQruDoA4YvDZDuHrqCDmgHlMU/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69235B828C40F54FA3235356541055F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f1dc55-11db-411e-1931-08da227f742f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 03:40:03.0375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVuJmzWJHE4jsZnGxHxZbnO7sJ7II9wr7HcsTCtFKaddZgfCy8S25dxvjXyibgat6JexigX2I5qmkDtv6OK3vTF9qRvixKGSJRne10qd2wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4622
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA0LTE1IGF0IDExOjU2ICswODAwLCBZdSBLdWFpIHdyb3RlOg0KPiAncS0+
ZGVidWdmc19kaXInIGlzIGNyZWF0ZWQgaW4gYmxrX3JlZ2lzdGVyX3F1ZXVlKCksIGhvd2V2ZXIs
IGl0J3Mgbm90DQo+IHJlbW92ZWQgaW4gYmxrX3VucmVnaXN0ZXJfcXVldWUoKSBhbmQgaXMgZGVs
YXllZCB0byBibGtfcmVsZWFzZV9xdWV1ZSgpLg0KPiBUaHVzIGl0J3MgcG9zc2libGUgdGhhdCBk
ZWxfZ2VuZGlzaygpIGlzIGRvbmUgYW5kIGJsa19yZWxlYXNlX3F1ZXVlKCkNCj4gaXMgbm90IGNh
bGxlZCB5ZXQsIGFuZCBpbiB0aGUgbWVhbiB0aW1lIGJsa19yZWdpc3Rlcl9xdWV1ZSgpIGlzIGNh
bGxlZA0KPiBmb3IgdGhlIG5ldyBkZXZpY2Ugd2l0aCB0aGUgc2FtZSBuYW1lLiBJbiB0aGlzIGNh
c2UsIGtlcm5lbCB3aWxsDQo+IGNvbXBhbGluIGFib3V0IGNyZWF0aW9uIGZhaWx1cmUgZm9yICdk
ZWJ1Z2ZzX2RpcicgbGlrZSBmb2xsb3dpbmc6DQo+IA0KPiBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ251
bGxiMScgd2l0aCBwYXJlbnQgJ2Jsb2NrJyBhbHJlYWR5IHByZXNlbnQhDQo+IA0KPiBGaXggdGhl
IHByb2JsZW0gYnkgbW92aW5nIGZvcndhcmQgdGhlIHJlbW92YWwgb2YgJ2RlYmdmc19kaXInIHRv
DQo+IGJsa191bnJlZ2lzdGVyX3F1ZXVlKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdSBLdWFp
IDx5dWt1YWkzQGh1YXdlaS5jb20+DQoNCkxvb2tzIGxpa2UgSSdtIGxhdGUgdG8gdGhlIHBhcnR5
LCBidXQgZm9yIHdoYXQgaXRzIHdvcnRoOg0KDQpUZXN0ZWQtYnk6IERhbiBXaWxsaWFtcyA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPg0KDQpUaGFua3MhDQoNCg==
