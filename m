Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F74E5A5963
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiH3CZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiH3CZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:25:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430CE4599F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661826324; x=1693362324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1KWWn4wwktyjx+bXBweXEBcwf5D2p7eNo02oLxC8Erg=;
  b=Y4BWCc1u79pz2VD6Ax4XpeYvOL1nY4pzJPbP/LuYvnCm5oZCceZ0AXZX
   iTd7WJIRA6PTKuCn6rn2oEG1zLgEVWLde+AmRCWrYfDPBhOdI893DGVvZ
   9VUfHT9f+yUgC7ZAAMKGoirLRDjOZOXOR/CxmGcOLzY7dHrp3lQnCaLcT
   EgBycXorn8tcmWl4a8vbyrqYzs5he90V44v9jK5WJU2T8Erjp0pB+/cTn
   AMwq6ySUe3ZVCjq3jCjfioOVXOxR5hM4HwSS6NVLdlDxrJaTxcaVXTOyd
   Xmk/9pY4yjM7QujyZMGINbL9+2PweFgdgroNxjpIJRufN+mq37WBNpC+g
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="359021227"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="359021227"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 19:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="939826016"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2022 19:25:22 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 19:25:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 29 Aug 2022 19:25:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 29 Aug 2022 19:25:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOkobSLCpO/9dC/n4GzCGJDXvdIyOgkauItVI6l44iXaHhABvPh164XqmFEKRMdXPln6tocPYfVxiD2goQTJXhWsehLSfu/u8btj9B+5EQiuFmIGdGZ2exUGWOnf+QwGRsM1v2Pflj3lwbBQKMdsPL3dJVn/U8uW46xY3RVGD8tJ3Y+QaUONKXNwLTb99Uurs6exi/fuv7tdUKuu6vwgeXNUatRW7ES+9sqLS3ljvcZLyzFB00T0UMsDsyz9dzPmZPkOKvsP9F3sAYRMK/ZrnUYJTTgsSegVGSwqQF0TVqtMIVodR86LKL6YYKtawKCpsl/iqwCLRPBH6w8tdz+xNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KWWn4wwktyjx+bXBweXEBcwf5D2p7eNo02oLxC8Erg=;
 b=d15xqlCYvxdK7bDyNr7CZVEVVUCuO7Dg+muOfMCz67BOHbshK8nFtlRkGPj3fWrEZ5dJGkAt/EMGcpuUupbR9MDg6TxQ6uLA//G26eylUwUwi9/oEm/e0xD5evPxSwtOfvhDhlXgdFlBVuzwKlH9cmfHYUn9Qb8v0hm6JgKfUn7LIV6ThcbrSokiGYy6EIDR59GEy4mos6jeM6naODHMAApFrGqI/+TcHM6H7wU5pQUB64YnoQqEoG6xCFe4QUFHRk39Y1zzt5hiGKQgutbciZpiDKlhagZVyiySUdTOSf62vZTmYdvwhaGk09dNJZhcsSUpAV3M+5eNvQYpaOmGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB3275.namprd11.prod.outlook.com (2603:10b6:5:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 02:25:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 02:25:19 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC:     "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wander@redhat.com" <wander@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Thread-Topic: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Thread-Index: AQHYojRY+En7hOPydEe7EqRHOAymzK201mCAgAa/AwCAAATBgIAAAh2AgAnKRQCAABSnYIABb+AA
Date:   Tue, 30 Aug 2022 02:25:19 +0000
Message-ID: <c6c9edcecfed16577a93a591b54d0d39a99c5a27.camel@intel.com>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <Yv5KNyX992ddvVtD@zn.tnic> <20abfa00-b70c-f151-9ee4-5668f09f4ace@intel.com>
         <YwP27a6/9Yq8LBM3@zn.tnic> <be080a46-e6c2-995b-9064-a8506c38bef8@intel.com>
         <493a956374bb64bc5608db73452182b2c1177c6b.camel@intel.com>
         <CY5PR11MB636536E6CAAACC28F9593117DC769@CY5PR11MB6365.namprd11.prod.outlook.com>
In-Reply-To: <CY5PR11MB636536E6CAAACC28F9593117DC769@CY5PR11MB6365.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 906eb436-6a03-444d-1764-08da8a2ee211
x-ms-traffictypediagnostic: DM6PR11MB3275:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgENrfey6HZaHiaedQ65dVGW9Z2f6y9otMFtICLCZ9riFh4M5PT8zWXMaB2blZcxdX1yLJGFm2fDKzKhiW6hD4FK+r2MXO9A6ew+qmnZn3iTfeOj7lXNUFnCYIAxArbLtV70X/RdqgqIQMg1DVVenpEypusRz19mvIA4aUcxNOeDw7VMLnZ9wJlZvycWE1spinbv3MKGNwb7giqYS4QIYhvDPT7C3De//Q9hDEsqj+Xv2blsy7dmsRO+E1ka3/YqA7vo7KxbJsQdzAvDZxdyO4Eopmey3M5WiPjhZ2j1i/Xu9LQ5pR4jj9IM9FxyZ1yIvKh9bZ0DJk9lsWwBSlq8n1vSS3ERMRpqoqaBccAXiTXSw1Sp0eXGPpfj3BNsoqWCF6HMMAqnXtjXWZ84d/gZvgI81MehIovD7vArSa5H+EdySyvU9FgatV5U5pacxNFDK20AKZ5wZ9VF70my/VBz7hBAkVG9Q7Ymr9Vx+2vulq+Q2RsUmXFI7Fit0cbo79qyyX6ttsZoZLhJUFD/J/0ZFP8WMBXyzo+o7uk+deGP3pDuPN3fWn9ePdwjx8vJqmypnFQaM+fYwVTjFlH3EFm9QfnCEi4KikjcZbOBMv1nXCOoQlZG0433a0/Aryreu9VUoODBAZF2bneqCdXrseWGyEY+RJM2Dyl4EK6LpI3oIg14QGMkNQV761D+wvd4OP4bOSAQJQfGomKvKi92+WnOpx65b+mXw2FOFbKWbTgkkOUoa9ig1yv5AHJFGRNgjlg/OLAZziXtXE41qrGGCg9Hfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(39860400002)(376002)(396003)(38070700005)(6512007)(122000001)(26005)(82960400001)(36756003)(54906003)(316002)(110136005)(38100700002)(86362001)(6486002)(8936002)(6506007)(8676002)(7416002)(91956017)(76116006)(66446008)(71200400001)(64756008)(53546011)(66476007)(66556008)(4744005)(2906002)(41300700001)(83380400001)(4326008)(186003)(478600001)(5660300002)(66946007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnNoSUgxdlIrcEZNMmhnUXFHK0ZVY3RuK1BxSUZ2TEhkTVpNLzR3bGtDL1FF?=
 =?utf-8?B?aW5uelN3TDBZVHhHZnFhb09RMDYvU2d2ekZCRFNiMWpvYUdETDcwVVFuTmNm?=
 =?utf-8?B?bFNURm9YQVBUTEU4c1VKNTNDdUl5bEJoTXdKeWVpaEZoTjlxbUQzL0xSbDZF?=
 =?utf-8?B?RzZLd2JFWGRheUdMYmFjRHNaQWJOcHAxM25rSG9RNXNGYytkM1Y2OUhHZDMz?=
 =?utf-8?B?VmMyS0d1YnVlY3p2Qk5yRnI3MnVEc2VVK0lVbnNsdlBDK1NXYnpOT25RSy9x?=
 =?utf-8?B?NVJVY1IrTEpkbE1rNVQ5YnpHQkVlbkkzUmJoM3ZIeHlYM3NJdklkU1RUSUR3?=
 =?utf-8?B?d3Nva0ZGNEN3T1ZmRTBkeHpMTlZEdlA2M2w5SWh6U0NEdExvcVdxRE1WRWhr?=
 =?utf-8?B?YkE5SlpMd0s2WnlrSkdRbHlpSDRUaHpMVlFVTGorTnNoMUJSOGFkT3NyRkVS?=
 =?utf-8?B?dFB2ak12TDBpVlZrYmtoc09ORHFicHFmYk9PaE5lRzZBRzA2bjB4U1BVajc4?=
 =?utf-8?B?cTFkU1V2MlI0TXZjbEtJSXFuUXU2dGRhYm04ekx0R2pDTjdFNENwQ1pZd1Y2?=
 =?utf-8?B?YW5yRU9zRVdqK3JtY3JXRVV0cVMwUUJYSnprenZjV1c3bUtsK2plcS9DSFFL?=
 =?utf-8?B?eURuV1ZONmRhYkZrOEFFdWxUQUN0Q3dkQndnRHRpV08xRnlodjNsUmtVd3Fr?=
 =?utf-8?B?ZE4zdWl6UEIvWnVYdnplN2VEZC90N25sODg1cW9nOW00LzRyVW4xUi95MDFj?=
 =?utf-8?B?TXlINGd4a0ljZ1JSNUtYVHc1SC9XNU5jY3ZkKzFpWmZNMktKWWhaSStvSDVq?=
 =?utf-8?B?OFhvd0ZGcmhQUVM3aXVQNUFDTkVBOExmV0xFSE0zZjNiQ1FhQ2QyamtWcUVr?=
 =?utf-8?B?aUkrTU9rY3RZVUM5WnZzek1MM2o0MlgwMWZkd3RUTG5HTkM0MG9RMnF0Q01z?=
 =?utf-8?B?NTdTbmF1eWJpWHNCVjBKNEdaVXJIZ3QyQzAxOGIveDgzYkxNMnZ1R3lZeE54?=
 =?utf-8?B?cy84UkM2M2RjU0FaeXJWSzJxWDJ5bU1mK0NkNFB1cDYvZStrOGt1NVkxeHJ0?=
 =?utf-8?B?L0dybS8yQWxpQXRBSHhpT3BtdHFHYmV3RGdhWDZUeGFKbUZCQ3VIQU9jWTdy?=
 =?utf-8?B?VVFlRXBjbjVFblI4Nm9qMGFJak41RGwxSWk2NUZoM1J1RWF4bGhLRWhFckdn?=
 =?utf-8?B?bnJod3FiSDhEcytaS25GeXFNekhhVGRoaTByQkg4MTYvQWNzcmVGYmkvaXNX?=
 =?utf-8?B?dU9QUitRUk82emNRdE9yMDJjRzAxbUtaNkJtaTlsNUdTMHlwZk1HQUNuTWJ0?=
 =?utf-8?B?WFdoNzBYTXl0bjQ4TW9SaDZYUkJNTitNUzhiVG13cTl5QUgra2JHYzBXZUxT?=
 =?utf-8?B?dHdRWVBJUXAwUzJHNkxRTm84bnVvWWdWOStPbnh1R3VmUUZKZjNtejNsL29m?=
 =?utf-8?B?K1hYaUFRSVBpK0tBSytNSmwwSHZhaW5Ca2xOM2ZXQlVWOGdPVnF0MkF6dUE5?=
 =?utf-8?B?Yk84NFo0dFI4b0FqL2pCTFVlY1RBbnpYZk96MFEvUHM3UUtWOU5oc0RkVERH?=
 =?utf-8?B?NUdOaUtPczJZditOdHJVM3VhNktmc2Ywd25OeFQyVzlGZTlkTGI4enRPWkNs?=
 =?utf-8?B?elF0VUcxeUQrK1RaZHhCbElWRHV0SnhZQmUwUjgvbjZjRndHZHNDOFpuV2V3?=
 =?utf-8?B?NFBLZ2p2RHdOZnFWeTZPZ0RBMkJSU1lSbnlmRk5UUFNoU1lNZUVVRFJJeGVz?=
 =?utf-8?B?U0xnN0Z1bkRsdjRReHdUTWxvUGxNK1QweFBKUHAzcnJQK3Q5UHllUjAzdHM0?=
 =?utf-8?B?dmREVXQwVDRreEJaVDNWMFBLOVFLUXpkWExuNHVVU3REMXZ5QTFjYUhlU3Bz?=
 =?utf-8?B?OUc5cjJRYk1YOG54cjRBcmxLYkZHeUlHZ3VPYllDWUx5aElyWFI3a3ZFaU9Q?=
 =?utf-8?B?SzRyblhlNDVMaXJDU1l0UmVrU3AzZS8yUzhXV3EvVE1iSHF1VEFmRm5tcUVy?=
 =?utf-8?B?NGoxa3ZJUkNQUFQvQzEvQUhGTWpLcGk2RkhZSFVXY2t2eU96RkN4NTJDQksw?=
 =?utf-8?B?TjVUaXJYSkFST0ZBSjR5MDFieS9lNFc0YW11dFo0THVIQjY3TkhsU1FMYkZD?=
 =?utf-8?B?YkZDV09LbVpSaVFiZWZTVFREUHRkRmtBdHprUW1ZT3BMeFZRWjJBRHBDM2NR?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7798BEDC269EA343A6F13BA2C5BC6738@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906eb436-6a03-444d-1764-08da8a2ee211
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 02:25:19.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GwG/G0OXsGxT0/QO6cXwbCEZ3fVI1hAYvvY9wVbFsq/IJMChBZBZ2VTcG6C614bgqJZTRs6bmxH6aTPL+BMFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3275
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

T24gTW9uLCAyMDIyLTA4LTI5IGF0IDA4OjA1ICswMDAwLCBXYW5nLCBXZWkgVyB3cm90ZToNCj4g
T24gTW9uZGF5LCBBdWd1c3QgMjksIDIwMjIgMTE6MTUgQU0sIEh1YW5nLCBLYWkgd3JvdGU6DQo+
ID4gT24gTW9uLCAyMDIyLTA4LTIyIGF0IDE0OjQ0IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToN
Cj4gPiA+IFdoYXQgaW9jdGwoKXMgYXJlIGluIHRoZSBwaXBlbGluZSBmb3IgdGhlIGhvc3Qgc2lk
ZT/CoCBBcmUgdGhleSBhbGwNCj4gPiA+IHBhcnQgb2YgL2Rldi9rdm0sIG9yIGFyZSB0aGVyZSBh
bnkgVERYLXNwZWNpZmljICJkcml2ZXJzIiBmb3IgdGhlIGhvc3Q/DQo+ID4gDQo+ID4gU29ycnkg
Zm9yIGxhdGUgcmVwbHkuICBXYXMgb24gdmFjYXRpb24gbGFzdCB3ZWVrLg0KPiA+IA0KPiA+IEFG
QUlDVCBubyBpb2N0bCgpIGlzIGluIHRoZSBwaXBlbGluZSBmb3IgdGhlIGhvc3Qgc2lkZSwgZXhj
ZXB0IHRob3NlIGJlbG9uZyB0bw0KPiA+IC9kZXYva3ZtLg0KPiA+IA0KPiA+IEkgYW0gbm90IDEw
MCUgc3VyZSBhYm91dCBURFggbGl2ZSBtaWdyYXRpb24gc3VwcG9ydCAoVERYIDEuNSksIHRob3Vn
aC4NCj4gPiBTdXBwb3NlZGx5IGV2ZW4gdGhlcmUgYXJlIHRoZXkgc2hvdWxkIGJlbG9uZyB0byAv
ZGV2L2t2bSB0b28uICArIFdhbmcsIHdlaQ0KPiA+IHRvIGNvbmZpcm0uDQo+IA0KPiBOb3QgL2Rl
di9rdm0uDQo+IFREWCBtaWdyYXRpb24gdXNlcyBrdm0gZGV2aWNlIGZkIGFuZCBpbXBsZW1lbnRz
IGEgdGR4LW1pZyBzcGVjaWZpYyBkcml2ZXIgb24gaXQuDQoNCk9LIGFueXdheSBzbyB0aGUgInRk
eC1taWcgc3BlY2lmaWMgZHJpdmVyIiB3aWxsIHN0aWxsIGJlIG9uIHRvcCBvZiBLVk0sIGFuZCB3
ZQ0KZG9uJ3QgbmVlZCBhIG5ldyBkZXZpY2Ugbm9kZSBhdCBob3N0IGZvciBpdC4NCg0KLS0gDQpU
aGFua3MsDQotS2FpDQoNCg0K
