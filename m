Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6909150CF02
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiDXDk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiDXDkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:40:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C43626DD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650771476; x=1682307476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ruj3fvSvjriGcIzjWLywfajfgVHM7ajCOFN9hKFTDNQ=;
  b=ew9EQAwhT0e+5cvhl3zkblStx4br2bBMIYZlvDt1x0vEFvQSIppJrf/r
   bpZqldJgk0JJ130LMwmB7/n/P1XBhbCJRku+xU3qAAMkJnzVqm2+9OONj
   vKzxcIyO/v3Bha5ctQqaPjzRQ1ozsAZOX4lhCrfvwlvDdttZqXuZ2BfYJ
   ky3/In61hlzrR/94SXjUgxfF9f5OdpbEMCE4DbG1CX9NBXpr4PDiv78NV
   71DG35ymiQJtVaYC4XXNzDf+Y4sWJkGn7JwDoLYTXH4prN0sI9spLDjse
   amH63C3ylJ+Gk3hXL8qT933oxoDrnvpxKtODqDhowV17UJ2TbQM1yfb8a
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="262582861"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="262582861"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 20:37:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="649192494"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Apr 2022 20:37:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 23 Apr 2022 20:37:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 23 Apr 2022 20:37:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 23 Apr 2022 20:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCJJk2u2Dxlcz+0s5RUhj9xqzUs/91PO/B1CIkSR8N51hspXdjStciJd79ilsmLwUp9iQKL3niaNGpMKKHXSORn4uAaaiChW+7gNMP03PrDcdUxwbouN2EHS1w1MV1OoPCDKBTcBhNeZSwj275gw6PJcNquupyRBZQWlHNQFPmNbTfg0Sq0NrM/0Wr4jIiDBOuPohcRcMlWP+eodeZh/CdvegQpN6Q6J3FhCfNYsfBwZRthaIeiIDnB21cTHndvoRVYuFZr1QElxSkaYD0KyYpImB/sFqa9Mq/sRHSJSvoWrkxfLuY/JSinzkBOU4nzwhBIsgvfSMJ4RJCoqT+tukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ruj3fvSvjriGcIzjWLywfajfgVHM7ajCOFN9hKFTDNQ=;
 b=SCe2xWFOPoh4+wvHYJBnikB6+O0XbZj0uWes0Tr3RH2BwX2mjIQX9Piy86dScHFc4mlzMIdw82Mvyg698GCAX18f/QkhOdlz16Q1+XYZkicUE7vYXsby29Y9bfwB/SMxj3LqhaKLszMmJ1V6dHawF+5nZMd2zrZPkGBRxO2KiPuciekj1atYd/1/uTy4IERT6Hh1OZ91wRB/P9GnNN90vob+uORmphRP4omzBs71aaq8NnRWGI2piqB5L98cHnNDVBHkBkcPeDkivwMH1hGzpvuG5xBIPISKrz2FRlq0dxkgF9BqvxqfjZ549zXCSx3OH+PyD7CO0AE/WSfyD0iISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO6PR11MB5652.namprd11.prod.outlook.com (2603:10b6:5:35e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sun, 24 Apr
 2022 03:37:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 03:37:48 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Thread-Topic: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Thread-Index: AQHYVXRiJweT3/DMakGQhv0qzMieEqz7Od6wgACuJICAAoO6kA==
Date:   Sun, 24 Apr 2022 03:37:48 +0000
Message-ID: <BN9PR11MB52766E90CF544C2B00F364008CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
In-Reply-To: <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 277e81e8-db98-4f7c-fd2b-08da25a3cd85
x-ms-traffictypediagnostic: CO6PR11MB5652:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO6PR11MB5652FEACFC8DD220FF654D208CF99@CO6PR11MB5652.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2wd5QIvh7Rk+ZlYoRSAOoke26MUUSel4nHH9UaA3vG6oN+NMF8D4Im/d90mVi5g44O+PuqEsQSHKDtrSIii0mRdZT4c0O2RQJr/0uaey5qfpUw+UXo72J0v8HyxD8Xfn3S7qY/2UHSNAKb6l7c+YEf16bapZGg6EC0Awz5QqaesqbQNBRF/Rm+eMBwHihIuct7IKT2C0inA1iAEXjZOjrLzu03tyMJYRMtMAXLcdc67Ftc5/qPYgagOpBbtUwMEm1DbECUmhyYR24g82Uvb5YGecyZa2c3fTd+BrB6nyJrAURfMKgJJYT9Y/o/183U28ErXYKR4hBekWIRelexkW5HZ0SnekjfIrIBOkzfs77RjWZySnRasvU/GvmmkORErcI78lqL5iF06Nk0/3g+EgyZSioGtWfeIxNA9phWS7WZNL3EfmND7Bcwgz649vSTj0aEqI81xaI7IKIWiCuLFNFm4b2X2uHv0RAfVleDstVf/Ss64svKgs32UCYCOI+ub22nMxxd2FLa7IVsemHFNLs9o0gQ1d0gJZCqvPPhtT1iVdwPTa4KxBLf4RH5JqHp3W+jv8VsqbGUUPUnx10xJX0y41wQ+yt2ijPhUVM+8Sk2aljLuAu4yLSSuvYMZ5KiBLDtgf2l00SbrVWHKZUdmWDpEgxnQ7BJZ82WJQ26NWKWfaQxmbKLdbyhixzs6G7DKhno7zNyL6v1ZhEddX3i57saSKT1rLuzIKfXZQB0B9AN8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(52536014)(38070700005)(83380400001)(76116006)(122000001)(55016003)(82960400001)(4326008)(8676002)(5660300002)(186003)(64756008)(66946007)(8936002)(66556008)(66446008)(26005)(66476007)(6636002)(7696005)(316002)(54906003)(110136005)(9686003)(53546011)(2906002)(33656002)(508600001)(6506007)(71200400001)(38100700002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHpHd0xENWlDVU1hdFZpWFhYSTNjbXFtaXNLVi90aUpLQ2drNFp1K3V2RnpH?=
 =?utf-8?B?V1o1WjhyZVFIeDViVTNzTWt2VTNhM3loR04yOVdQNERvenlwRlVCZGkyK1d1?=
 =?utf-8?B?RzZUeDNCYlZUYkQxWSt3UldvVGpwcUVubVVjekdNNVQrN1JpSWx0N1lmSEJ5?=
 =?utf-8?B?ZXU2QVVqZ0h4ZXArOTJVdmZmWkJmQko2SWpFOWRYZks0dUR2M1oxSGhtbFZS?=
 =?utf-8?B?Vy9uY3F6WUNudHl6dmVkeFRxcysvVFEvd2NqUFZCTFY3WU95NjdEZmRyZmhD?=
 =?utf-8?B?Ny92ZzB1em9zTHQ2RkZzeENmdzhHR3VXaTRtdDhMbnZQMVdxY3FySVhFWFhI?=
 =?utf-8?B?UkNGQ1BpbHcwcHVlTk90bjJ5dllGYm9sZy9RYS91V1NKaHNsc0gwOUNCRVox?=
 =?utf-8?B?clJuZGtEZDVxaFZWUlVUTWFkWTRVVEpKVFNVaVlia1kwdmRpUmNpbEFFRmsx?=
 =?utf-8?B?WTNzMlpTZjZRV1RqYzFnY1ZBaGkwRm9jK2hDL1NwUUhER3BQQUlFQjVLZGU0?=
 =?utf-8?B?L2dYWnRVWHp6SWllV081VE9UT0d6VTBuNTIyTmdjc2hkWTBHWDJYVDFiamRj?=
 =?utf-8?B?aDRObUloK29BRDBxVVkrUjFGZCt1UW9LdndkanJvakh6RGFoUzVOeDRpQjhr?=
 =?utf-8?B?TC9uWnl5MWVqdFJ3M3pabnVCNUtaNlRQTnZRZWdqbEZPcGNSRXlkelFkSUFk?=
 =?utf-8?B?RWtmd0Z2TWZEZC8xbWI2YmQ5T2RVcnprNVhXbUNockRTOU1LY1pBQ09XV2Iy?=
 =?utf-8?B?NWtKTjkwSUpuYjA0MW5EUEJRdzZhaGFTSHFHRjlXUStXOW9rVklDcms3T2c3?=
 =?utf-8?B?YmxhU2VpaXNuYURxVFY4VHRMMk1ocENCVC9xd1plcDRKYTZFNDVldnROM0xC?=
 =?utf-8?B?eWQyZlBnWFJjdjhxSWREaHl6MGdVOXJhMkJyU0wwMGFJL0JCVUVPQ01Rck5z?=
 =?utf-8?B?MGJiakJIdW9UdUFaTm1EdzM0M2FNbVpZaTdNM2NhSWd3NlR6eUlLM28wK3Ja?=
 =?utf-8?B?alVucWUzNmNZQ0VkOExMNm9lL2QrU2xLeEkxaTJxVnhZellJYVhwWHphT1Y4?=
 =?utf-8?B?cmFuTm5sbW1DbnRHTDEwV3Z1RTRtNFQ3bE9GYVpNSlFsL2F0aEVwMWlyTGFR?=
 =?utf-8?B?eXIwWFp5cE43LzJQOHlzQ0dadTNCTGRnZ24wUTBrTFhiWW9haGFFc1AwQ2pt?=
 =?utf-8?B?SEdoZXhMWjZiTndiQnFOTkhkdElZUDhiQmRTUFB2UThzanNzcU8zWHU5Wjd1?=
 =?utf-8?B?YldHcWRlTjNGN1ZlSHZVaG1JeEY1NFNoeUVESmNEVzYweVhQY3N3U20zcmN0?=
 =?utf-8?B?K0cvTG9BRlhQdmFZVWxWRnNtQis5N1ppR3Z1Y0czeDhEZ3gzelJzM0FHYjdJ?=
 =?utf-8?B?TkF3ZlY2RmF0SVFCL1FJblZBN2dzdlNBQ3EzRjRISUlIekljTWtMaHA2WVlx?=
 =?utf-8?B?WjZtQXVSb3puRXJ3R3l4cjVrdS8zNktHMDZCWTl1Qzh5OWFOcTJCTWgvWXZt?=
 =?utf-8?B?NFRUZWdWRU12eWw2RnkxbHpiT3doQW5qSlovVXZ1OWV1TTA4UVB3U1hlZEJp?=
 =?utf-8?B?R21wVHZIL2F2Z0FZRlNRendNeUxtTERRSGNWNG9kbkJaK0lENVgwT3ZLL3ZT?=
 =?utf-8?B?L2tqVkExaURVbmZEOHBJY1ZkeWZrNDVrNFh6WTdhQm5QR1VvL0tORmZneUxO?=
 =?utf-8?B?VHpUMjNSZjZ3bVZYcUVKQkNBT3pZRm0zcS9IeDFoM2YweFpObWdzY3BOTmJr?=
 =?utf-8?B?TXpXSjh0aUNONEk2UHpNYXJlMDRFQVN0elpJM21KZ0IycTNoSHNLdlJ6NlhX?=
 =?utf-8?B?c1NremNRVDdiM2ZMZE96THVwYUtNRmFtL1ozY1NVN3lHR1VrTEpjUlRucDlX?=
 =?utf-8?B?RVUzVGxJUWZrSmNzNXZUMXZKVUE1SGtUQW1kTUVCVHh2OVh5dVU0SjRYQVk4?=
 =?utf-8?B?WDZ1emJGSjNtakZLY3J1QjgvYm9GTkVGUGJyM3pPbGkzdVJOUEhzbTdtZUpF?=
 =?utf-8?B?YlplSmN4U3RrQVptSzhoRUt2UWNkWERHSzM3bEdGQ0JpZmYrcnIwVEprWlFI?=
 =?utf-8?B?M0pTWTZDUU10VXQ0Z2UzVC84NDRvVmVWcGJTMXk1VFZFZ1BTK0dseGhJVXJm?=
 =?utf-8?B?TjkwRWw2N1VqODg4b3RJbE80SG5GNXB5RzJ1MnBaUUNuWWZUYmxwUWhGV0Vp?=
 =?utf-8?B?SmQ4dTFUdjkrUWdPSDBpY1RHYTJVSG92aXRaL1R0N2ZqNWl6VGZyOHNBRlE4?=
 =?utf-8?B?eVAvZTJnVlp3NGc3MmFKTVZNN3JOUDZqb3h0RVdERXArL28xSkd1ZFFreHJF?=
 =?utf-8?B?dWZySUZDOEVGU3lYOU4wYlFqSFhONlBkclY3WS9lTlN4NDEvcUZzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277e81e8-db98-4f7c-fd2b-08da25a3cd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 03:37:48.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMhbpkngVy73d9xd22g8ovM8ceGd8sqErZRyImn6U4q11G5GRmaTGEZckYfZ+mqZtyeiHcMSywYYM/P2pKXsKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5652
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEFwcmlsIDIyLCAyMDIyIDk6MDQgUE0NCj4gDQo+IE9uIDIwMjIvNC8yMiAxMDo0NywgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1DQo+ID4+IFNlbnQ6IFRodXJzZGF5
LCBBcHJpbCAyMSwgMjAyMiA3OjM2IFBNDQo+ID4+DQo+ID4+IFRoZSBsYXRlc3QgVlQtZCBzcGVj
aWZpY2F0aW9uIHN0YXRlcyB0aGF0IHRoZSBQR1NOUCBmaWVsZCBpbiB0aGUgcGFzaWQNCj4gPj4g
dGFibGUgZW50cnkgc2hvdWxkIGJlIHRyZWF0ZWQgYXMgUmVzZXJ2ZWQoMCkgZm9yIGltcGxlbWVu
dGF0aW9ucyBub3QNCj4gPj4gc3VwcG9ydGluZyBTbm9vcCBDb250cm9sIChTQz0wIGluIHRoZSBF
eHRlbmRlZCBDYXBhYmlsaXR5IFJlZ2lzdGVyKS4NCj4gPj4gVGhpcyBhZGRzIGEgY2hlY2sgYmVm
b3JlIHNldHRpbmcgdGhlIGZpZWxkLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9s
dTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvaW9t
bXUvaW50ZWwvcGFzaWQuYyB8IDEzICsrKysrKysrKystLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFz
aWQuYw0KPiA+PiBpbmRleCBmOGQyMTVkODU2OTUuLjVjYjJkYWEyYjhjYiAxMDA2NDQNCj4gPj4g
LS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvaW9t
bXUvaW50ZWwvcGFzaWQuYw0KPiA+PiBAQCAtNjI1LDggKzYyNSwxNCBAQCBpbnQgaW50ZWxfcGFz
aWRfc2V0dXBfZmlyc3RfbGV2ZWwoc3RydWN0DQo+IGludGVsX2lvbW11DQo+ID4+ICppb21tdSwN
Cj4gPj4gICAJCX0NCj4gPj4gICAJfQ0KPiA+Pg0KPiA+PiAtCWlmIChmbGFncyAmIFBBU0lEX0ZM
QUdfUEFHRV9TTk9PUCkNCj4gPj4gLQkJcGFzaWRfc2V0X3Bnc25wKHB0ZSk7DQo+ID4+ICsJaWYg
KGZsYWdzICYgUEFTSURfRkxBR19QQUdFX1NOT09QKSB7DQo+ID4+ICsJCWlmIChlY2FwX3NjX3N1
cHBvcnQoaW9tbXUtPmVjYXApKSB7DQo+ID4+ICsJCQlwYXNpZF9zZXRfcGdzbnAocHRlKTsNCj4g
Pj4gKwkJfSBlbHNlIHsNCj4gPj4gKwkJCXBhc2lkX2NsZWFyX2VudHJ5KHB0ZSk7DQo+ID4+ICsJ
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPj4gKwkJfQ0KPiA+PiArCX0NCj4gPj4NCj4gPj4gICAJcGFz
aWRfc2V0X2RvbWFpbl9pZChwdGUsIGRpZCk7DQo+ID4+ICAgCXBhc2lkX3NldF9hZGRyZXNzX3dp
ZHRoKHB0ZSwgaW9tbXUtPmFnYXcpOw0KPiA+PiBAQCAtNzEwLDcgKzcxNiw4IEBAIGludCBpbnRl
bF9wYXNpZF9zZXR1cF9zZWNvbmRfbGV2ZWwoc3RydWN0DQo+ID4+IGludGVsX2lvbW11ICppb21t
dSwNCj4gPj4gICAJcGFzaWRfc2V0X2ZhdWx0X2VuYWJsZShwdGUpOw0KPiA+PiAgIAlwYXNpZF9z
ZXRfcGFnZV9zbm9vcChwdGUsICEhZWNhcF9zbXB3Yyhpb21tdS0+ZWNhcCkpOw0KPiA+Pg0KPiA+
PiAtCWlmIChkb21haW4tPmRvbWFpbi50eXBlID09IElPTU1VX0RPTUFJTl9VTk1BTkFHRUQpDQo+
ID4+ICsJaWYgKGVjYXBfc2Nfc3VwcG9ydChpb21tdS0+ZWNhcCkgJiYNCj4gPj4gKwkgICAgZG9t
YWluLT5kb21haW4udHlwZSA9PSBJT01NVV9ET01BSU5fVU5NQU5BR0VEKQ0KPiA+PiAgIAkJcGFz
aWRfc2V0X3Bnc25wKHB0ZSk7DQo+ID4+DQo+ID4gVGhpcyBzaG91bGQgYmUgcmViYXNlZCBvbiB0
b3Agb2YgSmFzb24ncyBlbmZvcmNlIGNvaGVyZW5jeSBzZXJpZXMNCj4gPiBpbnN0ZWFkIG9mIGJs
aW5kbHkgc2V0dGluZyBpdC4gTm8gbWF0dGVyIHdoZXRoZXIgaXQncyBsZWdhY3kgbW9kZQ0KPiA+
IHdoZXJlIHdlIHNldCBTTlAgaW4gUFRFIG9yIHNjYWxhYmxlIG1vZGUgd2hlcmUgd2Ugc2V0IFBH
U05QDQo+ID4gaW4gUEFTSUQgZW50cnkgZm9yIGVudGlyZSBwYWdlIHRhYmxlLCB0aGUgdHJpZ2dl
ciBwb2ludCBzaG91bGQgYmUNCj4gPiBzYW1lIGkuZS4gd2hlbiBzb21lb25lIGNhbGxzIGVuZm9y
Y2VfY2FjaGVfY29oZXJlbmN5KCkuDQo+IA0KPiBXaXRoIEphc29uJ3MgZW5mb3JjZSBjb2hlcmVu
Y3kgc2VyaWVzIG1lcmdlZCwgd2UgZXZlbiBkb24ndCBuZWVkIHRvIHNldA0KPiBQR1NOUCBiaXQg
b2YgYSBwYXNpZCBlbnRyeSBmb3Igc2Vjb25kIGxldmVsIHRyYW5zbGF0aW9uLiAybmQgbGV2ZWwN
Cj4gYWx3YXlzIHN1cHBvcnRzIFNOUCBpbiBQVEVzLCBzbyBzZXQgUEdTTlAgaW4gcGFzaWQgdGFi
bGUgZW50cnkgaXMNCj4gdW5uZWNlc3NhcnkuDQo+IA0KDQpZZXMsIHRoaXMgc291bmRzIGNvcnJl
Y3QgZm9yIDJuZC1sZXZlbC4NCg0KYnV0IHNldHRpbmcgUEdTTlAgb2YgMXN0IGxldmVsIHRyYW5z
bGF0aW9uIGlzIGFsc28gcmVsZXZhbnQgdG8gdGhhdA0KY2hhbmdlIHdoZW4gdGFsa2luZyBhYm91
dCBlbmZvcmNpbmcgY29oZXJlbmN5IGluIHRoZSBndWVzdC4gSW4NCnRoaXMgY2FzZSBQQVNJRF9G
TEFHX1BBR0VfU05PT1Agc2hvdWxkIGJlIHNldCBhbHNvIGFmdGVyDQplbmZvcmNlX2NhY2hlX2Nv
aGVyZW5jeSgpIGlzIGNhbGxlZC4NCg0KQ3VycmVudGx5IGl0J3MgYWx3YXlzIHNldCBmb3IgdW5t
YW5hZ2VkIGRvbWFpbiBpbg0KZG9tYWluX3NldHVwX2ZpcnN0X2xldmVsKCk6DQoNCglpZiAoZG9t
YWluLT5kb21haW4udHlwZSA9PSBJT01NVV9ET01BSU5fVU5NQU5BR0VEKQ0KCQlmbGFncyB8PSBQ
QVNJRF9GTEFHX1BBR0VfU05PT1A7DQoNClN1cHBvc2Ugd2UgbmVlZCBhIHNlcGFyYXRlIGludGVy
ZmFjZSB0byB1cGRhdGUgUEdTTlAgYWZ0ZXIgcGFzaWQNCmVudHJ5IGlzIHNldCB1cC4NCg0KVGhh
bmtzDQpLZXZpbg0K
