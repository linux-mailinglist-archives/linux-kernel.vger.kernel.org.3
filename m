Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713EC5A2F85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344379AbiHZTBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbiHZTBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:01:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BACC3E76C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661540500; x=1693076500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lO7u4LHEXE9+7T2jeDpMfyEd5e5HtNL+oiJF6vvHMz0=;
  b=c/8W2mERx4QYYmb3z8uiHYVYbYcR73DyDrKpTRd6EL016MpBLPFiiriH
   Fq5CB3vHQugRu4Gwp+8J/8iuVwHmpHRcycLHz27E+nlUvTXwNN9mzIdmS
   EB3gOeUgVRQC5NcXHGr1Y4msybzYDV11v8d6yra0MMHU08bvXWJQlL408
   VaHrGXDS6hztM01ZNhyFKE1m2LjDrEuVNOLble5VGtYT/uLUNAS/EyAK5
   BUBVGURUEBnJpJARXWK61pm/PsXltzpJtRggSjPIV6IjFd5sg+rWm2fCC
   gJXCi8O68rGoR/lR9B37ykPRtZKmAIpcjjbQxUlHoj7mpol6mgQRHfVMm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="293317732"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="293317732"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 12:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="587402236"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2022 12:01:39 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 12:01:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 26 Aug 2022 12:01:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 26 Aug 2022 12:01:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2T0bVirBKwwYGjXpEhCGXB40yGXEPv0rzwUdVrBtqkzRAQXopjc5R1AZ1965OzrEh/7FNce0x4UThp9mi2E7vLVoC4jDDC75PaHyETk6El2z9+jZt5ivb3V4rqZX5wMZ8Es6TDQdm+nKN0mH+DP/YvjNKjVOqfLkWaTEGQAp4QrKdgFNuEW6TCn5g0iNiXrpiBBx6wVPjkfi+xhLuSgUPyxmmu2ESj2xcAAFevTJBKqLlgraofdGLxbmQTVsD1WeAsRxPa5svd2sG/v04+mzY11vAJ1fIQBVRSTn3VM3AIfJWxz4A4RXbo1agxPidnOhDJOQQ2af8R5362E5xk9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO7u4LHEXE9+7T2jeDpMfyEd5e5HtNL+oiJF6vvHMz0=;
 b=jxXAU71SAs6w1vwxEydZka1k1XdpV/z2vRPWgNUwFwuObu/5dyLKhQjRI7sQwMMLc6Qd5SWz5KNUjhlW74npQUNxHTvwQ9GYkjn2P8smdv3saf6h6y+aiMsNVgeWBCz5TYpaRYhh/nUWj5PC+kAmmg192Qu74N/6NQZudnP5rO0+KvUfgMIjnUbIr6VQ4xJKPWvvfL9GspEmYQYTQlNobfjgMmKBq0A5uYvq1OrgJej0rQXJdvSCO80TizfKjubO1abMvXFVgROiPlFCdqsV5y8bpJudnoi7ShqhwclMnHFBnCAKBhveEwh5Lg4fFE2Mj9smz3cGV8EhCNgV6UEcKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3113.namprd11.prod.outlook.com (2603:10b6:5:69::19) by
 CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Fri, 26 Aug 2022 19:01:37 +0000
Received: from DM6PR11MB3113.namprd11.prod.outlook.com
 ([fe80::7100:8281:521b:ff31]) by DM6PR11MB3113.namprd11.prod.outlook.com
 ([fe80::7100:8281:521b:ff31%5]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 19:01:37 +0000
From:   "Laba, SlawomirX" <slawomirx.laba@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "alex.sierra@amd.com" <alex.sierra@amd.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mm: re-allow pinning of zero pfns (again)
Thread-Topic: [PATCH v2] mm: re-allow pinning of zero pfns (again)
Thread-Index: AQHYuX3KImcszxofFEG8ZAbLC/IJ3K3BiPQw
Date:   Fri, 26 Aug 2022 19:01:37 +0000
Message-ID: <DM6PR11MB31137D5CBE5B38FA4BED564587759@DM6PR11MB3113.namprd11.prod.outlook.com>
References: <166015037385.760108.16881097713975517242.stgit@omen>
In-Reply-To: <166015037385.760108.16881097713975517242.stgit@omen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de3d47bf-2c79-4e07-1e7d-08da8795670f
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jj05Fa3k35Ebprf1GJ9EYZzJrQCfxBHJU4FfFWvYKan94uAL7E/pKXd/QkWr3x1XppPhwRx10zUmYVV81X1FhWEb3TGYfyHMkuueZXbcGTAoEnOlE14mWzs9Mgp24IDLdOTRp5MS+FbzdvVJSVCVFbxv7xfq5N72ruJtOCoXXyuy/IeyAji7oAn5innemJgDVqCAm8yjhOIyZ10EC50F5xOceXOoIFRF68hwXjAgWpJ+Y95INlGDDgac+ARK08+OySbX3zZk/KwLLFEeFfscy6eqVXyyQyaDIIyPQYJEe4i/fDCeyP45oBG+dGqmUvvvUNmjzCuV4eTinN0UGIuSZ92W6Urnbd1WrpPB0KDAbXsMj37+UM6hIF4XtDcM3feYsYP4xzeD8zRAjz+z9tp5aEyU4EeXtCmRFGD2gCLphsLkBD9MWEDcRObquLkNkYxhw+Ea8jFlthqeXhSjvGyQZIx8DQKNtL9aTRE0qsv1yaiwZnwOoWoucmigWBnUMgEPwwmu6dFi5/rUXCKJw8N3ENsFqZJwp5naw5dVKjkXL5nvfnUvOiUPkytIfsUtZvQcnG9wBW/1GUYqa6pAi0g4GWzs9Y9FbPAC/iq2wPzyV17+mDcXzhbncSzucf99nHafyTT7rzHOOEB91gKoYZ04xjiDLg/zA1o80ZkViWDTEZH8JSsI9BmGk8m3bodxwCwxMBLJk6al7Palrg93TDfzdhWkSNT/rybQzksnPhUCPqVXsSHHMzbEyk+nLoErIlS03k1KZSDiUq2cLWRqpEyiiH1ImuTaLY8HIJL8QPyepbg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3113.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(376002)(346002)(366004)(7416002)(478600001)(33656002)(55016003)(41300700001)(8936002)(52536014)(5660300002)(186003)(86362001)(4744005)(7696005)(6506007)(9686003)(26005)(2906002)(110136005)(122000001)(71200400001)(316002)(54906003)(64756008)(38100700002)(66446008)(8676002)(4326008)(66946007)(66556008)(66476007)(76116006)(82960400001)(966005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHVEMDAwUEdSNDF5WnRLbEJaV3MyUG4rNkpPbEVobnkzNTFxc0I5TWo4NTlY?=
 =?utf-8?B?SHE3alNFVVhwdnBST0lZTjlZVkRZUVFPczVQdU0vdW1CNC8zUWNIZ3VIZzZB?=
 =?utf-8?B?b3lMV0c1WndwM3dXc3ZuYUhvUHVKWGx0R1FWc3JjaHZjUGJMdzJ1WW01TlBV?=
 =?utf-8?B?QmhWbnF3Wkg0ZEhkNmhtaVFjK3NYZ0FSb1ZhWWp4b25raFJZa2JpQURrVjBJ?=
 =?utf-8?B?cU85czJIaGJadWZ4UjhkZUlVVWVUNiswOFIvY2pBNndwdDl4UThTUVltalBv?=
 =?utf-8?B?WWpIWlR0RFpFWSsxSnpEOW8xRmZvZ0VMTlB1enVNSTVJQmZRdUM4ZWJwZzBj?=
 =?utf-8?B?TG5PYkRhcmVrNlF5ci9CSWs5MnJGaG5VdXkxQTdTaWlGRnl4RFJMSnBvbzNB?=
 =?utf-8?B?cXNtY1NTRkdzM0dBdTk3Z0MydHpZR3ppWUJsV1V1bTZNdkVrajNpOEc3RUJ2?=
 =?utf-8?B?TGJVRkNoN1JUUzRhYjBxVG5aekgvZTlIODVQK0tEY1JPWVdRandCdFdhZFhu?=
 =?utf-8?B?NHZ5ckw4Y245anE5N3RlVEh5S04xUXRTUG9tcDhIV0xROUFaZ2hENnNmbW43?=
 =?utf-8?B?SjNuMk12dGhtS0JYTHBBcGZmOExCZ0poOXcxT2cyUDNveWplTDI3TklnWnhL?=
 =?utf-8?B?U3d1Z0VCV3ZjVFgveXpwMnZJVS81ZldTenlzOXk2WTlkdENUZFRqZnhLTUsy?=
 =?utf-8?B?RWZsMmJ3c05iYWdZUHpNcXJLeFc1SjBpc2kvWG9Ld2g2QnZ2bktPeWtuQkx1?=
 =?utf-8?B?cTJEcGpKOVFIcGlpaGt0Tlo0TU1lS0FTWG1RMnNkYzRSY3FnS2dnRzBGZ1hQ?=
 =?utf-8?B?aG0rRk45OXlKRjE4azdPT2c2eVBRRWlqdDBnU0diZ3BzWE1YdS9Ka0RGTVFU?=
 =?utf-8?B?LzhYR01WQWJzMjJrR0hNOEpCakFLQmZEeURkb2xXRnkyMlZHeDdLMGlHSHM1?=
 =?utf-8?B?dHM1bVdPdndsc3lWd3FYUmdLdHVFS0owRDU2QXN1T1NOVFl4NHRTRnNNRFFY?=
 =?utf-8?B?NlNQYXBSbXZGSU5aRXBuSzlvam9OL3N5enpkK09zaUFMRWowbVhXYllnK1h6?=
 =?utf-8?B?N3RmU24wclI2UnVuYklEMWI2bDZpakw4VlV4eVV3ZlRuRk8wSXdWejByU0pR?=
 =?utf-8?B?ZWZQcTM4eGp3YTl5SmFRNlRvWTBoZDZoMVpXUUc5QXZHSnFObEF1S0Q0eS9a?=
 =?utf-8?B?Qy9MZ1hwamg4VVlNVGZCN25jc3F0L0o1UE45cjZIWUVMVUJ5WHNld2lKeGx5?=
 =?utf-8?B?bFJkSVVGeFd2WTI3NHlpSTRjTDYwbGZyenNtM3pjS0xVNTZzUUp5NTBTUTBn?=
 =?utf-8?B?N1lhVDRHV015dXp6cmhVSGdFbGphR1RSVGVLTHpVbUl5eFdWVGlhZlVLMS9v?=
 =?utf-8?B?ZEtWVm95dEROUGJiTVdZaTJRdXgvNmMrM084U2ZTSE9BU1prOENkYUhUK0Jr?=
 =?utf-8?B?UnNoTUJZeHBzb3l6WDR1TWM0TW1yTDNKVndQTGdpL2o1Um9WKzdFZWw5Y3kv?=
 =?utf-8?B?VmRqZ0hEaVJpaXhxRWRzRFVOZGRmODJLTU9vR1J5Y2FzMmxDUXZkZVpVWjJ3?=
 =?utf-8?B?RmNlcWJIbUorTkVZcmF3cXR0TXFkQlExbmlkTWdNTTRGOUcxSi9hbzBuZlhM?=
 =?utf-8?B?Z2N5bTlYSnJWVHNxS2QyVmE3MWRrbDlqTFM2VlZqWFBSVUFnM05XVVRrR0JJ?=
 =?utf-8?B?a0FXMVBxeC9QaTg4ZHVHUHViSTNFU3A4UXZnRUdxRklPNFN5eWc4Zjk1NTd2?=
 =?utf-8?B?YnZDaFFXRVU3R00weFNFUlJVUTR0bW1CbU04OUxnaGk3NFB0N2dnLy9pL20y?=
 =?utf-8?B?ejRPQWhCVTI2eDRkQ21EWExDVlZSMVppS2JYUXBjcFl1THEveUQ4WXZOaXRX?=
 =?utf-8?B?ZVRYbTZhYVBUakRWbHRXeEFGV0M3YWNqTWF4dmZOZW9XWEFrbWs1Mzh5UDBP?=
 =?utf-8?B?NzNPMjFrMGczeEUxYU5wUzAzRGR2eXpUME9rNFBnMmNsMGhuN09nNWswdUdh?=
 =?utf-8?B?V29jUnVUUjQvZ1BjWlZzaUxaVmZ5ZmlacTRqcXIyMzJoUVlaam0xKzJPWWNk?=
 =?utf-8?B?MjJRQU9EM0xuSHp4MnRQRzBWbEszVDg4ZFV2RE1NRVhjWktYMGRtYjd5aERS?=
 =?utf-8?Q?XNN9faNrhuQHZP1J2OMjoppTL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3113.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3d47bf-2c79-4e07-1e7d-08da8795670f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 19:01:37.4798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYIgpRfVVkLPfqcqdT1FDJG8K+HhYRsZcGl/sMgCQH7ftUeIGZActe8zHcpUoG2iqagCsOf8ziPeIpC/HczWClX9c6NrEfazpdbx/3ZRrms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIG1tOiByZS1hbGxvdyBwaW5uaW5nIG9mIHplcm8gcGZucyAo
YWdhaW4pDQo+IA0KPiBUaGUgYmVsb3cgcmVmZXJlbmNlZCBjb21taXQgbWFrZXMgdGhlIHNhbWUg
ZXJyb3IgYXMgMWM1NjM0MzI1ODhkICgibW06DQo+IGZpeCBpc19waW5uYWJsZV9wYWdlIGFnYWlu
c3QgYSBjbWEgcGFnZSIpLCByZS1pbnRlcnByZXRpbmcgdGhlIGxvZ2ljIHRvDQo+IGV4Y2x1ZGUg
cGlubmluZyBvZiB0aGUgemVybyBwYWdlLCB3aGljaCBicmVha3MgZGV2aWNlIGFzc2lnbm1lbnQg
d2l0aCB2ZmlvLg0KPiANCj4gVG8gYXZvaWQgZnVydGhlciBzdWJ0bGUgbWlzdGFrZXMsIHNwbGl0
IHRoZSBsb2dpYyBpbnRvIGRpc2NyZXRlIHRlc3RzLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBNYXR0
aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gU3VnZ2VzdGVkLWJ5OiBGZWxpeCBL
dWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4NCj4gTGluazoNCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzE2NTQ5MDAzOTQzMS45NDQwNTIuMTI0NTg2MjQxMzkyMjU3ODU5NjQu
c3RnaXQNCj4gQG9tZW4NCj4gRml4ZXM6IGYyNWNiYjdhOTVhMiAoIm1tOiBhZGQgem9uZSBkZXZp
Y2UgY29oZXJlbnQgdHlwZSBtZW1vcnkNCj4gc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+IC0tLQ0KDQpUZXN0
ZWQtYnk6IFNsYXdvbWlyIExhYmEgPHNsYXdvbWlyeC5sYWJhQGludGVsLmNvbT4NCg==
