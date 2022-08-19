Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A393F5991B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiHSAWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiHSAWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:22:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B8BCE330
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660868562; x=1692404562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C14+d+vpRHL6YzramHQ/Ro6METZWFZlQLu3VW3klMk0=;
  b=aSX+zT7kzkH13DiZgSGehGN0JdpIIQ8Cmc2RCBabWTqMOSJUiderLB9W
   4vSlWSAjUICLRstusos/K2RQCxgo7ouSa0ClN7BIxQky8GDV2H9JpKf4D
   0stmPqgDDDTIH2o/QEI/wqV90q55nWAzf6xnpYkdXCnObjuXcjyV6X03r
   vnkecglvvRxjsxZCBRKQEazgU7Nw0W89McOg5mU35CiaAKttzbp5b4RtE
   HUqbk0XcON+WDaR6+NKyL1/Fiuq1SqwJN5LvPG9bdAZ8EA6cVH7WENuTg
   MzVZyxjoGC1ByLE7cjKR5zM0vJlKKgXF/UFLE7lr3gDiBt5pHSjiv7PlU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="379195744"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="379195744"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 17:22:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="853598799"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2022 17:22:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 17:22:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 17:22:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 17:22:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEDZaBJP7gt5cWWWqEw3B2L5WdDIvsKD927kmx9BCFt+lOioElTU6oDjtuHaCici7eRTJ/cdW09KMOrrvpchniHw19jMrL4Nq0L68sepgDz1mUMfhVDtdvW8CCrrtuKKCvQuJcddhlvc1a4WsZ+LHeDyAc5OMrEdp6XwHn76eimJyOFPA4lkG2YIowXXhgefF0iPlewJvWtei+ZyuIIL1fEQOcW5gWpTWTCId4be3QK+uK6G6amP6bH3GWFomzYj5ZtWU8AoNw3NXcemXOamQ3ImwfO3PYZULikJ0dxIgK2N/5tBSbwDvJmDeimo2cSzGNjQjt8auFl5Ro6bBqO+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C14+d+vpRHL6YzramHQ/Ro6METZWFZlQLu3VW3klMk0=;
 b=CJdRxHzIwQSwFJrnp/D9dbqeulgpepx41uio54UtWNBAgFulBThxfIymXC4JgsltyTlyrTL0tLjZ0O9yLuMLqJeEkzUr8FjYiA9vAHeLWoFmpkBQa2mFSjeuGKwkDeP0t1a7xcFD5He/L2D51xjeUgRQsVoBiZjfBe/RhYPMJXFEUfyY0y+39v65vpP+Xw/AXIXKGuJK3lYRXM7h6oUsxw/5MEBcVyyMp9yOdhERM87soTwaBO+zE0+FYJmfdIvjQILcWNMqLQeBRIQK42NxgYOybFmSnFSk8vk2AlBEb6rThpXV4x/ess+JFBPGf/FHigSIe//7RfRO1nfwxY5RQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 00:22:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee%4]) with mapi id 15.20.5525.010; Fri, 19 Aug 2022
 00:22:39 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Thread-Topic: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Thread-Index: AQHYojRY+En7hOPydEe7EqRHOAymzK201mCAgAAjm4CAAIUvAA==
Date:   Fri, 19 Aug 2022 00:22:39 +0000
Message-ID: <033ee694b6e9706dca86fb88d27d7f4e0b078f03.camel@intel.com>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <Yv5KNyX992ddvVtD@zn.tnic> <7b246fd0-d54e-2419-26b6-8c7088a280d0@intel.com>
In-Reply-To: <7b246fd0-d54e-2419-26b6-8c7088a280d0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef205aa4-f9fe-4a88-d190-08da8178eca6
x-ms-traffictypediagnostic: CO1PR11MB4931:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FsCiMPS4fxqfniaabsvPp+E+tOfmXS1T9a+SJdhepeKmwjmVkzhIfxp8dr+cwZeytc/w6L3VQUUrsMCXTNp7aByLBYirrXNSsEXTW3C9qvRgUwctzIuJm2Zrky+ez4yiPLGzJ95tsXJkDyVy7VR8pk2d5LYK+oi3PP7vVZb3mv2OPVJ7QMc1AALYSxDmO69G9M4B6HWqfk43Pp7jsl+HGn51DiqB1SbKHssRKN7QJdNsrONri7fjjTup7I/MNoptT5eGm6X6sB/sG9kcGrdoc43HtbjtBvTFjzHvP+smysVR3je+KinejMLA5u5EsCqJwbKAD9wrBVtwIYIUVcsj95SN/g1zBU/8Mf7NiAkphGDCsHeln9ORbyi2uI+l1ddDFt6SDT+2rIOmsbMwkmjCTiTasG9rBOXTrWLHrYz2y3fU0n8U8SAwRIOQFA98jlyGaYN3iiJj/mBQ4hlAcCVAf0O2v5AyHhvohUmyjNW9IggOHibMCSqIiXfudFhJU1lQNPLH9Y1H2PA38jjY2Pxfs5qVOmURT9R+f/Tt3xp7YDwlgbrJT9dRt+CFqoEsWgMH38iKx0Exf8W9oJeQ0llGsbrmMJhyYdPunUHv8ejFk3dqcz53mE4ZZPD/MRDLANaFRcE5zILPpNcXQXijw7OKL9tpIEFkbwydUAUD5+9PzwYbBshIEyk85pOrlbWnSqG2bkOpHPMzYg5NgIq8LcwYYzYK0RjvOZsyEYH3O9AncexoZzXcpuzAdcByyyDEn39UIreRq0jeuwmJ10E6lEzXMTIn5uARJYKSHJlL0GQLqJE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(346002)(396003)(136003)(41300700001)(2906002)(66446008)(66556008)(64756008)(966005)(6486002)(76116006)(66946007)(66476007)(91956017)(8936002)(5660300002)(7416002)(86362001)(4326008)(186003)(478600001)(71200400001)(83380400001)(2616005)(6512007)(53546011)(82960400001)(6506007)(26005)(38070700005)(38100700002)(122000001)(8676002)(316002)(110136005)(54906003)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk5pSWUxVXNKZFI2WEZ2WUFLNVVRcGVTVGxkS1Z2aUhIankxdlY3S0ErU2Vi?=
 =?utf-8?B?Z1N6VTJvZ20xbGJKK0xFYWFSYnc1MEVNUWVqQS80SnhKT1JvN0Z4Y2krTGFh?=
 =?utf-8?B?N0tYQVlwM1hSMDJvcWhuRmYwbEliamIyQjVQdGJ3Tks4TXUzWTlldGEzdFpL?=
 =?utf-8?B?c2ptWFQ3OTM3UmlqaVBTd3dkUURIODdJQTRsVWhjMWNFK1ArWllCcktNUmE1?=
 =?utf-8?B?bW4vOGJpeEQyZ2lVVjhSQWdoL1I0QzJjZ21hSmZzRW1Xd1UrRFBPR2pweXZp?=
 =?utf-8?B?ekVBdi9uRWFPQ0t2WWthZUhrSkQwbnU1cmlsTm12UjZwRnNSWktBYVlmUGZw?=
 =?utf-8?B?OFJ3NnVDUjJ3TW4rSjgrQmZIbWdOYTB5VW0zRXUrUmRZYUZKQ2ZwRnFTckJa?=
 =?utf-8?B?eHNZMGxFU3BEUktqQk16dXBXY3JEblZpY2V3UENQYkhFVW9EZmJzcmNINDJx?=
 =?utf-8?B?RkpRdlhtVlBOdG5QUGtSa0xBQWFTcUx1aWtSaVQ1RnNFOThKcEh1UkJwdlBi?=
 =?utf-8?B?ZEZaU0J1RmphQ0RVdHlpeHJPRVVBaEtnODRZcjJ6SGNiWHY5SFRqS0d3MUR3?=
 =?utf-8?B?cWFqdncwbmtXdGtuYWUyMEtaQ3hmakNtb2xPUVhGa0tSSmpZNklVdjNxbm1Q?=
 =?utf-8?B?ZTVmVHJNMUM4UGx2emsyREhIS0J6Q1F5Wlp3RHQ4Zzl5OElLYSt0MUx2TVNo?=
 =?utf-8?B?c3MyRGRrVXBrb0xSSmpGNk56YjR3K3RDdnhxbHFMTmNDSnBaaFNyWS9WMnlr?=
 =?utf-8?B?YUdBeWVsT0tXdE5ZSVVENkV5QWpWNVY1UDdTbjQ5cWJ6MmRXYlhDVWV3MkIx?=
 =?utf-8?B?R201Z2JabGZQS1lubWlxdGRNVXR3bHNXSTZEZWtkRkIrd0hyVk5ibi9yc0Fy?=
 =?utf-8?B?Z3BZY1NoYW5lbEU5R3R0bDBqYU5jeEVWSjc2ZlZ4WEtlM1crTllPaG5CQVFP?=
 =?utf-8?B?d0pOZ2k0bkRzWGtnTCsyNG5rbldUQzRKUUU4WXV1eEhmRmRPUklOZkhjYnYv?=
 =?utf-8?B?ZXd4b3dnSUZQZ29YRU9nUzArc3pDcDJySHh4b0I5V053Tmk2MHVqWjlGWnhH?=
 =?utf-8?B?Tng3Vm1LVFllMWY4bTZLYzBlQ1NkNzhaWWNWa1g2UkpQYVAzK1pDRHhqcFh6?=
 =?utf-8?B?Tkttc2hzNTVnaTZ0K3kvN2xrblA4M2ZwRkhxS0pKSHFuUDlQUlNwNzFpSHV1?=
 =?utf-8?B?aThsUENTWmhTMk5CU3hpUFJFL3hMcldId1BhdFBRNDBVd0JoZDBCTnhxKy9J?=
 =?utf-8?B?VFB2ZmU0VFJzd1U5aC9INkZ5bUtWWklsTkhGWWM3amVBeEtTRGZRNS9XNDhK?=
 =?utf-8?B?MWtubWxKOHNYT1RucHUvR2JDWTNOVDRSMGJTNjJRbk1RNklYM01RazkvU2U3?=
 =?utf-8?B?NEJYY3h1bHlVVThXNFZmZXJTR1hlVFNqeUM1L3QzQS9oV3pOWkY3T3RFdXlr?=
 =?utf-8?B?WDJoclloMkN0RnpaM0M3QzI1MEpMcXdjTDFadUhqWktUOUwrSkticndTa3lT?=
 =?utf-8?B?bTVBK3lLdGl0V2dNRUJjQVhCOHM1YU9sOTc5bXVZT3BaK2QzYkxIZ005OXVL?=
 =?utf-8?B?RFZmNUpLUkFsZ2xITzlqVG11b1RURmNLS01UTGp0MUpQbGRQcUZHSkc3d1My?=
 =?utf-8?B?c1BCTm0yYXJxZE5sUFJwU1ZKOCtpZmE3TkZqQ21SaVB0K3VxU1MxSlVlSCtP?=
 =?utf-8?B?MTBDdkNOV0F2eVduYldnMUkyTG5EZWdXQU1MZFhBVWl1SE1yckhRcWdZUmk5?=
 =?utf-8?B?NTk3MDk0Z01OQjk1Ymk5WllJQXRSdkQvS0dZUjlDazVFRkk3Um1iV1dlQ1BW?=
 =?utf-8?B?Y2RjdVhQTDJTalNoYzVkWlVNRnc5TGd4SW1FaitLbEZ2MThDcTBkaWFma0FJ?=
 =?utf-8?B?cWwyRUUwTE94R29kWlhocmsvMlIyMFBZSkd0ZHRWSHJud0ZLbHR2anhLMDNt?=
 =?utf-8?B?ekkxUlRpcENkUDQzMkV3aGR5Z3AyZUdCRjhMS1NzNXFWTXlEbUxRVkgvd1N2?=
 =?utf-8?B?NHBaTVoyOUdCREdCT1NkbnFYd3NNTmVYQ3Jpb1J1ZjZtNStVQzBRMFlSNEN6?=
 =?utf-8?B?d2dDZzRoWjhHVVd2c094TWtuRS90MDJvS09rS0dRTUpTM1ViZmJhSXRwVGts?=
 =?utf-8?B?SE5XZzh5OXdRYXJQVEFJSDZ4ZEpRc0tkQTFyZXZZZkpRdGJCcEhLVGRvYmVl?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E0E1F272C52F342BD61254FCC9E00C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef205aa4-f9fe-4a88-d190-08da8178eca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 00:22:39.2135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgAmf+Ifq3HeIARgV3Gupn7kg8Cgh2/p6E076KFpZHO5QPiyX1rRIccNqZKAwzzWczBD5U4Tq2YHTtST4JJcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
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

T24gVGh1LCAyMDIyLTA4LTE4IGF0IDA5OjI1IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOC8xOC8yMiAwNzoxOCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiA+ID4gKwkvKg0KPiA+
ID4gKwkgKiBHZW5lcmF0ZSBURFJFUE9SVCB1c2luZyAiVERHLk1SLlJFUE9SVCIgVERDQUxMLg0K
PiA+ID4gKwkgKg0KPiA+ID4gKwkgKiBHZXQgdGhlIFREUkVQT1JUIHVzaW5nIFJFUE9SVERBVEEg
YXMgaW5wdXQuIFJlZmVyIHRvDQo+ID4gPiArCSAqIHNlY3Rpb24gMjIuMy4zIFRERy5NUi5SRVBP
UlQgbGVhZiBpbiB0aGUgVERYIE1vZHVsZSAxLjANCj4gPiA+ICsJICogU3BlY2lmaWNhdGlvbiBm
b3IgZGV0YWlsZWQgaW5mb3JtYXRpb24uDQo+ID4gPiArCSAqLw0KPiA+ID4gKwlyZXQgPSBfX3Rk
eF9tb2R1bGVfY2FsbChURFhfR0VUX1JFUE9SVCwgdmlydF90b19waHlzKHRkcmVwb3J0KSwNCj4g
PiA+ICsJCQkJdmlydF90b19waHlzKHJlcG9ydGRhdGEpLCByZXEuc3VidHlwZSwNCj4gPiBUaGF0
IHN1YnR5cGUgeW91J3JlIG5vdCBjaGVja2luZyBlaXRoZXIuDQo+IA0KPiBJJ2xsIGNoaW1lIGlu
IGhlcmUgYSBiaXQgc2luY2UgeW91J3JlIHRvdWNoaW5nIG9uIHNvbWV0aGluZyB0aGF0IGJ1Z2dl
ZA0KPiBtZSB0b28uICBUaGlzIHdob2xlIG1lY2hhbmlzbSBpcyBiZWNhdXNlIG9mIHR3byBURFgg
c2hvcnRjdXRzLiAgKGNhbGxpbmcNCj4gdGhlbSBzaG9ydGN1dHMgaXMgZ2VuZXJvdXMsIGJ1dCBJ
IGRpZ3Jlc3MuLi4pDQo+IA0KPiAgICAgIDEuIFREWCBndWVzdCBhdHRlc3RhdGlvbiByZWxpZXMg
b24gU0dYLiAgVERYIGRvZXMgbm90IGhhdmUgaXRzIG93bg0KPiAJYXR0ZXN0YXRpb24gbWVjaGFu
aXNtLg0KPiAgICAgIDIuIFREWCBndWVzdHMgY2FuIG5vdCBydW4gU0dYIGVuY2xhdmVzLiAgT25s
eSBURFggaG9zdHMgY2FuLg0KPiANCj4gQXMgYSByZXN1bHQsIGFueSBURFggZ3Vlc3QgdGhhdCB3
YW50cyB0byBkbyB0aGUgYXR0ZXN0YXRpb24gZGFuY2UgaGFzIHRvDQo+IHRhbGsgdG8gdGhlIGhv
c3QsIHdobyB0aGVtIHRhbGtzIHRvIHRoZSBTR1ggZW5jbGF2ZS4gIFRoZXJlJ3MgYWN0dWFsbHkg
YQ0KPiBuaWNlIGRpYWdyYW0gb2YgaXQgaW4gaGVyZSAoRmlndXJlIDUuOCk6DQo+IA0KPiA+IGh0
dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L2RhbS9kZXZlbG9wL2V4dGVybmFsL3VzL2VuL2Rv
Y3VtZW50cy90ZHgtd2hpdGVwYXBlci12NC5wZGYNCj4gDQo+IFRoaXMgInRhbGtpbmciIGNhbiBi
ZSBkb25lIHZpYSBhbnkgb2xkIGNvbW11bmljYXRpb24gbWVjaGFuaXNtLiAgU2hhcmVkDQo+IG1l
bW9yeSwgdmlydGlvLCBtb3JzZSBjb2RlLCB3aGF0ZXZlci4gIFREWF9HRVRfUkVQT1JUIGp1c3Qg
aGFwcGVucyB0byBiZQ0KPiB5ZXQgYW5vdGhlciBjb21tdW5pY2F0aW9uIG1lY2hhbmlzbSBkZWRp
Y2F0ZWQgKm9ubHkqIHRvIHRoZXNlDQo+IGF0dGVzdGF0aW9uIHJlcG9ydHMuDQoNCkhpIERhdmUs
DQoNCkp1c3Qgd2FudCB0byBjbGFyaWZ5LCB0aGUgKnlldCBhbm90aGVyIGNvbW11bmljYXRpb24g
IG1lY2hhbmlzbSIgeW91IG1lbnRpb25lZA0KaXMgYWN0dWFsbHkgVERYX0dFVF9RVU9URSwgYnV0
IG5vdCBURFhfR0VUX1JFUE9SVC4NCg0KVGhlIFREUkVQT1JUICh3aGljaCB0aGlzIFREWF9HRVRf
UkVQT1JUIEFCSSB3aWxsIHJlcG9ydCB0byB1c2Vyc3BhY2UpIGlzIHRoZQ0KZGF0YSBibG9iIHRo
YXQgbmVlZHMgdG8gYmUgc2VudCB0byBTR1ggcXVvdGluZyBlbmNsYXZlIHRvIGdlbmVyYXRlIGEg
UXVvdGUNCih3aGljaCBjYW4gYmUgcmVtb3RlbHkgdmVyaWZpZWQpLiAgSXQncyB0aGUgZmlyc3Qg
c3RlcCBvZiBzdXBwb3J0aW5nIFREWCANCmF0dGVzdGF0aW9uLCBubyBtYXR0ZXIgd2hhdGV2ZXIg
Y29tbXVuaWNhdGlvbiBjaGFubmVsIGlzIGdvaW5nIHRvIGJlIHVzZWQgdG8NCnRhbGsgdG8gcXVv
dGluZyBlbmNsYXZlICh2c29jaywgdGNwLCBvciBHZXRRdW90ZSkuIA0KDQo+IA0KPiBTbywgdGhp
cyBpcyBub3QgYSAqU1RSSUNUTFkqIHJlcXVpcmVkIEFCSS4gIEd1ZXN0cyBfY2FuXyB1c2Ugb3Ro
ZXINCj4gbWVjaGFuaXNtcyB0byB0YWxrIHRvIGFuIFNHWCBhdHRlc3RhdGlvbiAocXVvdGluZykg
ZW5jbGF2ZS4gIFNlY29uZCwNCj4gdGhpcyBBQkkgKmlzKiBURFgtc3BlY2lmaWMgYmVjYXVzZSBu
byBvdGhlciBoYXJkd2FyZSBhcmNoaXRlY3R1cmVzIGhhdmUNCj4gbWFkZSB0aGUgc2FtZSBkZXNp
Z24gImNob2ljZXMiLg0KPiANCj4gVGhhdCdzIHdoeSB0aGlzIHdhcyBqZXR0aXNvbmVkIGZvciB2
MTAuICBJdCBtaWdodCByZWFwcGVhciBsYXRlciwgdGhvdWdoLg0KDQpBZ3JlZWQgKGFzc3VtaW5n
IHlvdSBtZWFuIFREWF9HRVRfUVVPVEUgQUJJKS4NCg0KQnR3LCBteSB0aGlua2luZyBpcyBwZXJo
YXBzIHdlIGNhbiBqdXN0IG1ha2UgR2V0UXVvdGUgc3VwcG9ydCBhcyBhIEludGVsLQ0Kc3BlY2lm
aWMgZHJpdmVyLCB3aGljaCBjYW4gYmUgYSBtb2R1bGUsIGNhbiBoYXZlIGEgc2VwYXJhdGUgS2Nv
bmZpZywgZXRjLiAgSXQNCmRvZXNuJ3QgaGF2ZSB0byBiZSBhIGNvcmUgZnVuY3Rpb25hbGl0eS4N
Cg0KLS0gDQpUaGFua3MsDQotS2FpDQo=
