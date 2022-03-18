Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1E44DD46B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 06:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiCRFfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 01:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiCRFfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:35:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB02F16F05C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 22:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647581635; x=1679117635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ezl1SmnvInuTOORoRSbLzF81mVA8V4pJ593lhHVCMqU=;
  b=MR5d5kDVyFYSHZmlEkRzkVl2S1pYBb+qSPpXiC15ahM/i5Ny6bFQFvuo
   3ieOTto5snzZS9fg621qx8bG7rGECui1rb/Yl7CsXJuP9Iv2/yB1Mxv5x
   TmgneEleAyD0AXt1zETaox54ulc98Jb8HG6ajFrGcUiZheODwfIIPJo1c
   BCf7kK2/V6mWimNv88Jt1yxzi/PmQGOCuzMR8AF6wN9qo4zrJbfVdajYN
   h4PCOyDguxey1zprLJt8Lv7O551rCoKHOh7D2bX80KyLYL0z/nw4ADAg3
   7/QE+nK49+ge3+UEYl4EpVWKGmJu+mKA5M8UkzlznBbPf7NN4tUmtetNz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281859426"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="281859426"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 22:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="784101095"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 17 Mar 2022 22:33:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 22:33:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 22:33:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 22:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRoEkdrb5LXbJ3uRVmu9+nFC2qvBk3iVJpLJr0b1gPtDl4CTDhVH5rhJQuKF7oBbHcd43EgHgdPDFDWht0KQb0qEE1zeN+hSt9tZxet30bRjMjSgjLUv1VMBT5Gl90MCikpiLWrlGgasxb98LtcYNvwVKXoMkRffIIr1HWIIG8LrSUFirsA300vLJnrJkIIZVI5WRs9e53icb09W8w9hHEL0p+FxEmFBivHPAcVZ7YhMgtwlycDH9yTtqxqBWjKpOL05yzL5JT4rsulySET+57ZCnp4SJk2K2Gk8zKwhop0cup8l2Xsxb47LZV5dCl0xqmxqMxxi5RdnVMCqSwnodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ezl1SmnvInuTOORoRSbLzF81mVA8V4pJ593lhHVCMqU=;
 b=hU5m51CkcjFWp5cFhqOGsQL2iFaW0lTcMfqSqvK/UN+BnEwd2OHsfdP3R4KTX3bcMt6vbQ/TipLGa0yCkUMhbHEwLz5pYbU/XY5Nt5QHqrRMlbBGrdsNpKXNmOjq5ZhvJ2gLYHlh8kubHYneQYvC8eIJcRQ0oFi3CvdpW6uEqEG6yHyFOJgMlxmURQM1sFnBfvYFY2jM0VE155aPDscoYgnckntqBomdsGrojXVbLgDi4+DeTO3HMjp0l4hqnWZsH9BPHhyLs2lGNfZIx5o9s5PM6vmms8sjFg58FfLPhZdWKhMYWIdUy+UPQdMYJqVew9YVUVeyjRANWFKnUjT0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB3574.namprd11.prod.outlook.com (2603:10b6:a03:b1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 05:33:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 05:33:38 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: RE: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Topic: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Index: AQHYOCoddoPAbs8qR0GMuSnaaH7P9KzAguoAgAEeqfCAAOApAIACIOCw
Date:   Fri, 18 Mar 2022 05:33:38 +0000
Message-ID: <BN9PR11MB5276FF347A54098F469936978C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
 <BN9PR11MB5276E98AE37EA912B01EB0B68C119@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220316140140.76bb24c6@jacob-builder>
In-Reply-To: <20220316140140.76bb24c6@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c40dc9c-763c-4dbb-77e1-08da08a0dac1
x-ms-traffictypediagnostic: BYAPR11MB3574:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BYAPR11MB3574D80380FCFB4B6B0C26438C139@BYAPR11MB3574.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FNRaidmq4FnQUM4LE9CHSxMZVOfd0UFX9ocFbX7KjIcqmDiNkGtHWSgqXViN6xrJYu1HERgEHp87e+NKF0SPH4/Oad4x0iX8TzPyxT/FjQDMupjX/SYGR1Mi5oQULcXTmLHlWEBMjTH/TIEwJEe2jFq3Vh16ekrKHc4rbRvVZQvNf8HCStlUTEATpv1dINRB9De+RPyh8Tud6jgNoqH8WDeqmXdU801RrbK6547VWHexyY+iS1OrNRcw75XcRsiCcXTEb/RSdtlj9M9FsZxor6vwRC9C/22+FPJaPoJAbFyDM71vsKFQW6+3531Rd9a7MtkL1VYwcoWxUVRLoG/98gHro6shNpuCMeVgPYveJzJLlJesLMIbhxCIqa3JsIhRRR8FrEox1L0GPsASbJIb5+v4yPaUFQJsfx5nwpZFYuKjmcH2Zt4dY4VPZ1EZ6qST2E7IDK+0hlTITvlc4i2K7VzAK92dhVKfzKLB1yuA/VP31zSLoY9wCXGiuwky+Czo8HBVisWvwx5QC1VHKNhZqTlRIAn0b6FiJF+8M90wM5ezoZi9CylEIIH2FlhxTcfi0knyKDk3aL8rpn7c6gFPo0OH1mALVxZLSi1gFLQwEQeg7zEoqRvQFm4EAfwpjwaJHe8ACxcoCOeiQiU2pqHk240pDiV58U21vIhKch4cGRlcB4icSrMubpy5F5epjVWis6YLSKZBIKLmyUZ2SlOqVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(71200400001)(33656002)(122000001)(54906003)(6916009)(55016003)(9686003)(66446008)(7696005)(508600001)(4326008)(8676002)(76116006)(82960400001)(66556008)(66476007)(66946007)(186003)(2906002)(5660300002)(8936002)(86362001)(52536014)(64756008)(6506007)(26005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTBUOFNIRFJPdWZQMmU2V2p3WHVET3VnVUhQVTVQdWpBQkNFd0s3Vlp4V0Rv?=
 =?utf-8?B?SHBBc2I3eGdGVDVRaDM4Y0FGOWc5Mm9rMVZFdks5dW1hZVE5cTc2MFZLMUw5?=
 =?utf-8?B?aWRoMEI5REEwN3pNT0lOc2ZHeEJ6cUtWZTNOQzBXUWRLcGlhSW9mZzJSVi9I?=
 =?utf-8?B?SXViT1BudDJSejNqdTJxeGtEQ2JaTGd1WnQweThESkZPQ3NQMXdka014eEdr?=
 =?utf-8?B?Z2hhbTk4clRuR0duQnA1YzVOWGRyZHEycWd0Qlo1eDh3SWJTbC9SeCtxU0Jw?=
 =?utf-8?B?dWVFVTM1YkZhMldFU25MekZOclpjY0dobHl5aEhDaFZBZ2h6UFArclFQeWFs?=
 =?utf-8?B?MDRvUm5yWWwvdHZTRHVFTEJDTm42ZjY1cnN2SE9oOFVZS0hkVkhOazdFbWs3?=
 =?utf-8?B?bHlYa3RzMG5HS0dlMTNhdXZZZjVWWEpyR0JmVTU4S05mOE9hbis0Q1NQblRa?=
 =?utf-8?B?R1NRSHltQld0WWNwZWNyRW1SaTFCenU0R2RMc3dWOGNFSEk1WC9nWjF1a00v?=
 =?utf-8?B?Q3JIR2h5OUtuSUlVLzZ4M0ZHYVEwYWpqVTdLQTJZNVJQdlExZUp1MFJOZmNz?=
 =?utf-8?B?eTcxYUtuK2tMR2xVNTJ1SjBmTGQyKzg4WS9oSDBaRUpieHdEV3B4alZhVVEy?=
 =?utf-8?B?RWh1M2IrWHpKN3lnSEE1cWZ1UVRTR3JEbnhmcWl6MEowd1U0QUdXeE9yend3?=
 =?utf-8?B?c2pzalpHSlNpUE82ZWtCVUxmNFg3TjhybjNwMVZ1aUY3MG1XVERRaTYrUk0x?=
 =?utf-8?B?emRocFkrL3RuUTJ5KzJlMjNrVFZMQ0Y5cGtrUldPMWJDZ1JuLzZkcUxwNGVD?=
 =?utf-8?B?Vm1ka2MyWDlOMjlWT2xVTUFUaUw5NDU1V0V3RExKWHZ2Z1cxM1lEcTIxck5o?=
 =?utf-8?B?QWlDTml5MEVGUy9qNkkzSWlXR2I5bnFwcWJRWlgrcHNZV1FPL1VSRmtNc1Jl?=
 =?utf-8?B?WDNXTGFNODNPZHlscWpWVjlMS0hVRzhEN0g5OUZXaGo1bDlkMStvVnFmbWpw?=
 =?utf-8?B?THcxc1lWc0tFWU4yL29aVldjblcwaDIwRVg5R2ZQb2VSb0ZXYXE1UmszTmNU?=
 =?utf-8?B?VTk3eGRHdTJkRjdreGdmZnA1aW1RUWlUVGIxTGRFOGlOa2I4OEFUWVhoQ1RC?=
 =?utf-8?B?cURJL3YwTEJpN1dnSVVqYWFGanFSUlJrTjNFMUg2VG9SRm1UZWh3b2E2SEky?=
 =?utf-8?B?SjkzSkN1Y1A0dlNzZ0xXVXRJYVRGMytWM0pJRlE0OTcxd2ttMzNsRmJ2Wjgz?=
 =?utf-8?B?UmVVUkNNdXVRRjZwQm40Y1ViMHM5U01vSHdhNmVkc1NBbEdqMExBZzM1SHh2?=
 =?utf-8?B?SkRhTXFWRW00ejUvMlVZK3cxajd6Z0V0N0JHb1RzeGJOZzZxSDd1Uy9Mb0tn?=
 =?utf-8?B?ZEJIampXY1RLVXhYeUV3c05oKzFlMGFST0NSTTV1NndsYlB1ZzBiemlGVDRu?=
 =?utf-8?B?T200WVJnc0c0ZFVSdnd3Qi9HOEdFNUtvS3U3VVI1ODJoTVNsMmo2cWorMk5P?=
 =?utf-8?B?cTcrekhqVGxVSWdZTHRvWUhjWnkzYmE1TjBMTzVHYjYrQUNwd1psVDVaanJw?=
 =?utf-8?B?Y3huaHVpUExsRGtodm9CS0hBN2YvVlh1K0lvU2FRc0NHVjlqZSt0WEFmaGt6?=
 =?utf-8?B?STZqZ296Q1RoUTFzN0h4dXlyclpXbStDQ1U4SUtQVlpzckJhSU0wVVBrNCtY?=
 =?utf-8?B?MWV4L3l5R3k4M2ZRNlRmSDVlZnl3Z2QzMHdCZFlVOERLOXE1VGRpL1JQYjBL?=
 =?utf-8?B?WHFPNXA3ZkM1Z3BzWDlvUGxxYnBrWnBEYUhzNWNSaG9xT2UxaXdHeW1ydmZ6?=
 =?utf-8?B?UC9NaTFuVCtZY2pvR29oRldwajJ4clVXYjNLbEhvMHBFdmxOYmlsTHMwdzM2?=
 =?utf-8?B?UllXUndFUjNnbkFOZ3owcHE2SnJEKzc4UFhtTjVWWjVUL25uTGRnaUhQc2RH?=
 =?utf-8?Q?Wf4zDii4TxZ087UF8Jxl8LF4GSDreoVE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c40dc9c-763c-4dbb-77e1-08da08a0dac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 05:33:38.2842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAHNoVvDfvPkbWYGWnBNKgqV7vIB6snbPM5NUogROwN17Y2/mfU22ll1/ALvikqH/cHvAItgISPU3lECSagtoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYWNvYiBQYW4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE3LCAyMDIyIDU6MDIg
QU0NCj4gDQo+IEhpIEtldmluLA0KPiANCj4gT24gV2VkLCAxNiBNYXIgMjAyMiAwNzo0MTozNCAr
MDAwMCwgIlRpYW4sIEtldmluIiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiAN
Cj4gPiA+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+ID4gPiBTZW50
OiBUdWVzZGF5LCBNYXJjaCAxNSwgMjAyMiAxMDozMyBQTQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwg
TWFyIDE0LCAyMDIyIGF0IDEwOjA3OjA3UE0gLTA3MDAsIEphY29iIFBhbiB3cm90ZToNCj4gPiA+
ID4gKwkvKg0KPiA+ID4gPiArCSAqIEVhY2ggZG9tYWluIGNvdWxkIGhhdmUgbXVsdGlwbGUgZGV2
aWNlcyBhdHRhY2hlZCB3aXRoDQo+ID4gPiA+IHNoYXJlZCBvcg0KPiA+ID4gcGVyDQo+ID4gPiA+
ICsJICogZGV2aWNlIFBBU0lEcy4gQXQgdGhlIGRvbWFpbiBsZXZlbCwgd2Uga2VlcCB0cmFjayBv
Zg0KPiA+ID4gPiB1bmlxdWUgUEFTSURzDQo+ID4gPiBhbmQNCj4gPiA+ID4gKwkgKiBkZXZpY2Ug
dXNlciBjb3VudC4NCj4gPiA+ID4gKwkgKiBFLmcuIElmIGEgZG9tYWluIGhhcyB0d28gZGV2aWNl
cyBhdHRhY2hlZCwgZGV2aWNlIEEgaGFzDQo+ID4gPiA+IFBBU0lEIDAsIDE7DQo+ID4gPiA+ICsJ
ICogZGV2aWNlIEIgaGFzIFBBU0lEIDAsIDIuIFRoZW4gdGhlIGRvbWFpbiB3b3VsZCBoYXZlIFBB
U0lEDQo+ID4gPiA+IDAsIDEsIDIuDQo+ID4gPiA+ICsJICovDQo+ID4gPg0KPiA+ID4gQSAyZCBh
cnJheSBvZiB4YXJyYXkncyBzZWVtcyBsaWtlIGEgcG9vciBkYXRhIHN0cnVjdHVyZSBmb3IgdGhp
cyB0YXNrLg0KPiA+DQo+IFBlcmhhcHMgaSBtaXMtcHJlc2VudGVkIGhlcmUsIEkgYW0gbm90IHVz
aW5nIDJEIGFycmF5LiBJdCBpcyBhbiAxRCB4YXJyYXkNCj4gZm9yIGRvbWFpbiBQQVNJRHMgb25s
eS4gVGhlbiBJIHVzZSB0aGUgZXhpc3RpbmcgZGV2aWNlIGxpc3QgaW4gZWFjaCBkb21haW4sDQo+
IGFkZGluZyBhbm90aGVyIHhhIHRvIHRyYWNrIHBlci1kZXZpY2UtZG9tYWluIFBBU0lEcy4NCj4g
PiBiZXNpZGVzIHRoYXQgaXQgYWxzbyBkb2Vzbid0IHdvcmsgd2hlbiB3ZSBzdXBwb3J0IHBlci1k
ZXZpY2UgUEFTSUQNCj4gPiBhbGxvY2F0aW9uIGluIHRoZSBmdXR1cmUuIEluIHRoYXQgY2FzZSBt
ZXJnaW5nIGRldmljZSBQQVNJRHMgdG9nZXRoZXIgaXMNCj4gPiBjb25jZXB0dWFsbHkgd3Jvbmcu
DQo+ID4NCj4gU29ycnksIGNvdWxkIHlvdSBlbGFib3JhdGU/IElmIHdlIGRvIHBlci1kZXYgUEFT
SUQgYWxsb2NhdGlvbiwgd2UgY291bGQgdXNlDQo+IHRoZSBpb2FzaWRfc2V0IGZvciBlYWNoIHBk
ZXYsIHJpZ2h0Pw0KDQpNeSBwb2ludCBpcyBzaW1wbHkgYWJvdXQgdGhlIGNvbW1lbnQgYWJvdmUg
d2hpY2ggc2F5cyB0aGUgZG9tYWluDQp3aWxsIGhhdmUgUEFTSUQgMCwgMSwgMiB3aGVuIHRoZXJl
IGlzIFtkZXZBLCBQQVNJRDBdIGFuZCBbZGV2QiwgUEFTSUQwXS4NCllvdSBjYW4gbWFpbnRhaW4g
YSBzaW5nbGUgIFBBU0lEIGxpc3Qgb25seSB3aGVuIGl0J3MgZ2xvYmFsbHkgYWxsb2NhdGVkIGNy
b3NzDQpkZXZpY2VzLiBvdGhlcndpc2UgdGhpcyBoYXMgdG8gYmUgYSB0dXBsZSBpbmNsdWRpbmcg
ZGV2aWNlIGFuZCBQQVNJRC4NCg0KVGhhbmtzDQpLZXZpbg0K
