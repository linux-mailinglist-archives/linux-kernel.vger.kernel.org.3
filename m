Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967D84CB2D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 00:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiCBXru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCBXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:47:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DBD1704D8;
        Wed,  2 Mar 2022 15:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646264783; x=1677800783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=08bNSFM+VCDbY0b8Q5JrsIw/oVQyzMN3MuY4VXZP2jA=;
  b=h4nGHJNjkh4J9VYfEPY1EVaRo3eAkXNdyGFW052EZhOvOLiK6Apb+9Td
   9/Yi3QixeY43o1gN6Drma33qy/mi91BaZP1ZaLQz9XX7SHk/nFu1Fs+mQ
   ZNjm4EvHTMG3ljP9Ty/PI0oUtttkAayylut+RMV07MH14Q4yPRlLdu6Ie
   EkWX197fmbVNdC2RVNUTIjIL7zHsdIxCKMko9Rk2XVi5K9nhgoIc+GIJZ
   +tDgR1aPxtODmL15lSeRD9vm5jpi1Q1YNa99atZbnjvnvhXV4qG0yy43g
   kh+tXSdE/9ee4RO/9RVr4ZwcjmhNicFt8ksYap7bf/ZtRWjRnpusvK5KH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316742082"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="316742082"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:11:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="641878438"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2022 15:11:35 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 15:11:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 15:11:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 2 Mar 2022 15:11:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGQSrhQNng+oqGzMloNBC8dDIatTtFL2f1fFidTdPvcWMG1kZOYWLywYP2lj+3tceSYtrFpIP6bYaJWo1KHaF5ckn1aJaujpLRYfqnnKtphuoa7LwdO5jxHzXhxTW/C9ED7pL2SFjg6Aw755VDyNfM5y+m/uxX6TqZ441PxBgG20Fj5kAf28Hfm2aMlsozTZzdMgRvfsf6szMI6N//HraSEDz5SEzgVpMULYD2437tk8MHlDnJd9qYbC+uPDjsF9FhAswXQpw/FMhoO7otN8ivPAuI9NUxttv/4W9gd7T4iqYjGdVmyfhv7jENt52VeXzTJvoUgXSjIffid9Qli0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08bNSFM+VCDbY0b8Q5JrsIw/oVQyzMN3MuY4VXZP2jA=;
 b=BiK/+rfu+jjiIVBRn+ejJIxE/V13niJ74+d7vKqNHzU60Y7c4tMur/kSbgH49lbDm6WXyasr6jjWhokW05sW25u7EGJxyBqibB0s/qHWNXchpZOoATEIvY8G3K/lSlWubRjIEHsoIDDoOwloxMGNl1s/QIH/6xJ3Aihxyd+nO8EaJZUy4E3AlumapYgAvp+GejtKBzceV1wixgyjABnhBl2WxG1Zneb5Jn7y3m1GBZrTM/3feLU8TaAJ48BuvfrnoXT1Ahc5LgKs6Fsa5EjS7J+F1Re7xRAYtSI5o00Y0UMzdvHgaJhDnY6TykkSthVGe1LZIz+hSgmk40HDJxOTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN7PR11MB2739.namprd11.prod.outlook.com
 (2603:10b6:406:a9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 23:11:32 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5%6]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 23:11:32 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 00/10] Introduce In Field Scan driver
Thread-Topic: [RFC 00/10] Introduce In Field Scan driver
Thread-Index: AQHYLoraRFgdRwULeUWC6Weg1C32XA==
Date:   Wed, 2 Mar 2022 23:11:32 +0000
Message-ID: <a508dc24cd79022f47275504d6ec9b4bd99d2d95.camel@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
In-Reply-To: <20220301195457.21152-1-jithu.joseph@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-3.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb9736ad-e26e-4673-82a4-08d9fca1fd9d
x-ms-traffictypediagnostic: BN7PR11MB2739:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR11MB2739F8CC67CFE5E318AF5002C6039@BN7PR11MB2739.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B1FnpdSW2KMRClf6+GDZd0kknKdjOewOLj+Z5XyM1bzZsqcrsTVY/+5DAcCVwlJbf8aEZCI5KxIhkcJlRKCFPmkxwFis/eD4D8Ts/gr4Ag62gk6xvXx8NdIO5lyO4uIOUfX4sGY0PQGqKiqan3vgBJn/5iFjetVGlVQ1AHPCsdfshqbMkY+Nir+1QQKPoVuCW8wdG0t3Qt7iISNUy3ioICsyepwRg6x3YD4UnM4NgOoLGtlFDNvGDzAkyaXS2ATT4706yZQoThfOdkAYgJ39KqBldyNEG5560QpscA1J0UnUsLjeMOTaSIGES81N6C18demzBhxe6dvmfKTMOVHFeHwa4hJx+cuQStEpX3UXy8v8taOdvLM7sw5WaV1N740aoRhPQNub7b1xYqBuPksltZYJ9SmqDLHljHrLBmKNLnkc4WwnNUDegyq19hdJOcgvHClYCrylyARBESHwK9Cnot9oX8sVO9F3OOPml3qfEFePZTt8YDrV4a6J7kjyjzAInDDLy1GeFdRaNeo9HvtFo23WXgOThu0QhOfC/7bNUVw8O3xg4Lq8moUgWyAvQQYjnI+tNPgp0tGo9AoyNtd6FLe8DwCnL2AjR1/DSxpfpXB4oum2YrGCqqABFkrzlvQ8Sybl4Mv4EgVDWfFpd6uiDamPU6cU0xODlj8H/PTo6OfodxSnA0wi6pd3Jw78Bh6PJ8OKfi6M0Rnk/vJsqdqMpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(86362001)(66476007)(8676002)(64756008)(4326008)(8936002)(66946007)(66446008)(71200400001)(76116006)(66556008)(2906002)(6486002)(508600001)(5660300002)(7416002)(38070700005)(6636002)(110136005)(38100700002)(316002)(82960400001)(122000001)(6506007)(83380400001)(6512007)(54906003)(26005)(2616005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d05od09kZU5OZ0VSMWxWNG1iRXRyWUJaY0taeGhVWWFPSHJPQXpCUlVYZWpN?=
 =?utf-8?B?Mjh4SFg5WWt5ZFlLYzJXS3ViK3p1bks3amVvSXMrT0Q5OE1BVFFjRmpmeHJz?=
 =?utf-8?B?Qyt1UnVsME5tSEhlQTdteW9xSVFydGNTdlY1dEVoNkN0MnhWcFVTV3pMMU5h?=
 =?utf-8?B?NC81bFJELyt4YnZyNE5LNlpQaEZ1S2JyL3dXbjRWNFErTS9BQ0p2TGVxZU5u?=
 =?utf-8?B?NHc4Y28rU1FtVmtMMGZaV0w1eURVVmRoTVFrR0RNNVdGeEtHVmc3ZXJXdnRM?=
 =?utf-8?B?ZjA4cEJ6M2ZQYlkxaTJYQ1lKYXJGaE5DSTRhMVBBdUYxNFJzY3ZCOXZ3eTdq?=
 =?utf-8?B?d0NzamlGOVhLM2UzekpIdlhZTFhxeWkyRnpKbXlxcTdQTmJES0RlejU5b29K?=
 =?utf-8?B?c2lCZWZUU2t5dThJRTQxMllzYldKaHpQQ1hTWWg2RFh5aVhjYUFHSCtHdXBj?=
 =?utf-8?B?NkdFNzdqWXBIa2RoOHJoYkRsUUcwSjNzbmhCL3RMSGZpYVYwYXQ0UVdWcVNP?=
 =?utf-8?B?bTdieU1hWDQ1L3pxSS9VMTNwdWlpNzhXaFU5NnUyZTFBSU80alppZVJXUnBz?=
 =?utf-8?B?R1A4UUhPRVFGd256QTdrNTAxdm9FTG5kMGE3bGd5L2I1Vm1ac1VKUEpKQ1oy?=
 =?utf-8?B?OStDekNnM0l1MGxHSnRYV3VrTytVck42Zk9aMFJuVUdwanU4UDdrejBaYUov?=
 =?utf-8?B?SnNBRTRUb01aRC9DNUFzbVNNZk5SWXJRRk9YWFJvL21POTBSZWg3SGlwRFZW?=
 =?utf-8?B?TEJIUjhJcEJZWWlWeWVDRVl0VDhnZjJ6Z05yNFZOZXZBSmRkRnJ2NWc3N1Zt?=
 =?utf-8?B?bEpvQWNBRGFWMmRKeGdmb0VWeEp4Z3c2VHVyQndaaWdhdzlBN0p3TU5CQ0ty?=
 =?utf-8?B?L0NKVTdIN2xteGZlWUdTaC9wR1ZNeEFmTDZaaExCcjNyb2cyOWNHK2d0ZmQ3?=
 =?utf-8?B?T1cvNDR3TlpJd0JOVm9rTmpid0ZQTWx0Yld4WXB1c2ROUjF4aHM1VXlremxv?=
 =?utf-8?B?azVzbTdEM1ltaVJGOEE4YklrMkVWcGNPQTJYVnNNY2V6VTZ4Uk9KVUdxMWg2?=
 =?utf-8?B?T3dDcFhVNDR0ZU1KTU5pckdka2gvTGdiSStsOGxLUDkwVldsRmRWZ3ZId0ZI?=
 =?utf-8?B?dTdjWG5FVFBvNTRQZnByRWJSRzJyN0VjU3JLT3libW42TnpsYnhDZ0hGQkg1?=
 =?utf-8?B?UEkyaERBdkhNMnlvV0dRQUE2OW9Ia3FjS1ZNTi8xaG1tc0RkSElEeUxtSXgv?=
 =?utf-8?B?NkVGQzNvWWFCOEFKQUl0SVpuK01ENU16TktZTHNMWTFRMzFzdnR2Sm43U3pD?=
 =?utf-8?B?anFvN0N1NmowT2N2RllPblA4UUVrUUhYbzI1OC94dEM2ZXlPaTdIaCtpUVFY?=
 =?utf-8?B?YWwrZlFRTzlzVERZTCtOMnBka3paWjdxWTJRb2RjVlV6TkdKeTgvWmtqWEow?=
 =?utf-8?B?blBWNDY0TVFjcThPSXQxL28xeFp4R0VzWWc3WHZLSEIzaGorTFA0eFpxaXEy?=
 =?utf-8?B?S1lmajduS3dmbk1zeThERVRERmIrRCt1aFlaUk5SNHVNUTF0Z3dDTVdaYzNp?=
 =?utf-8?B?WmVBVm1XaUVxcnFQSyswb3BteEEzQ0dNU1BaMHFqbGNzYjZ0ZTl4bzVZK1d6?=
 =?utf-8?B?Vmk0Sm9DdzRNR2dzcWlUTkFsNUdBaTdjRGtlREk0TzZwaU5nc0UwaHdEZ0JR?=
 =?utf-8?B?bmwwZUdBQWlpemlLSlVvTkQ1bVNRa3JVVHp4QVErVHhzbWtDQWtWaWtiNWFI?=
 =?utf-8?B?eDduNzVvUDVsUHJieEtMZ0l6dHcybnpXZ1I0SFloMlduMS9FTUo0RGdGME1p?=
 =?utf-8?B?aVNKajR2ek9PVFJTVHRMa0Y3aTZWejZXQkZkMzl2cmkrTE1xUTVNL0o5a3pE?=
 =?utf-8?B?WFRJMHVTMFV3OVQwdHhZN1pwbVM3aE94U0lIM1NzMzlIVWlQTFFNOEtVV0tF?=
 =?utf-8?B?TWsyaWZUYlYxc3pvNzQ4NEViWDIwRk9sTnBLMFVmYzFVOEdBQVV0OEZMVFBm?=
 =?utf-8?B?azlvOUNZU3Z2dUt2aFI5MkJrVnRHbE1CUVIvbVJmYUZPcVkyRkhyaVc3VGIx?=
 =?utf-8?B?TVlJWTh6T3pMT3RhdHdpOWZuRlJGNlpEVlJ6dUJrUENTMXVPeFFMbDZuTEZZ?=
 =?utf-8?B?R3loMThKWGk4aFNRUGdQc2RsTWNrQ1dDQzQwRzlqTG1RWG1KWHZkK2hEb1Vy?=
 =?utf-8?B?cTJFQkkzRzVnNkova0wrT3d2RWF2SWZvbzhOSTgzUFVXOHZGeWFiamh4bVFW?=
 =?utf-8?Q?dcpTZigXva+ajntlfrNoQZt6XiJoh8MJemIAcE3xE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E57675D31959444EA6E282DA24497B93@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9736ad-e26e-4673-82a4-08d9fca1fd9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 23:11:32.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/+pBarhE338H9rQyScopX54TltGSVOr8r29hZTINzvrE8E/xLUMsbmm0DqRQexGq9zhTq0wj30H4FYXCvh4F9wDNiKB2Hjs901uvxlE/bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2739
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTAxIGF0IDExOjU0IC0wODAwLCBKaXRodSBKb3NlcGggd3JvdGU6DQo+
IE5vdGUgdG8gTWFpbnRhaW5lcnM6DQo+IFJlcXVlc3RpbmcgeDg2IE1haW50YWluZXJzIHRvIHRh
a2UgYSBsb29rIGF0IHBhdGNoMDEgYXMgaXQNCj4gdG91Y2hlcyBhcmNoL3g4NiBwb3J0aW9uIG9m
IHRoZSBrZXJuZWwuIEFsc28gd291bGQgbGlrZSB0byBndWlkZSB0aGVtDQo+IHRvIHBhdGNoMDcg
d2hpY2ggc2V0cyB1cCBob3RwbHVnIG5vdGlmaWVycyBhbmQgY3JlYXRlcyBrdGhyZWFkcy4NCj4g
DQo+IFBhdGNoIDIvMTAgLSBBZGRzIERvY3VtZW50YXRpb24uIFJlcXVlc3RpbmcgRG9jdW1lbnRh
dGlvbiBtYWludGFpbmVyIHRvIHJldmlldyBpdC4NCj4gDQo+IFJlcXVlc3RpbmcgR3JlZyBLSCB0
byByZXZpZXcgdGhlIHN5c2ZzIGNoYW5nZXMgYWRkZWQgYnkgcGF0Y2gwOC4NCj4gDQo+IFBhdGNo
MTAgYWRkcyB0cmFjaW5nIHN1cHBvcnQsIHJlcXVlc3RpbmcgU3RldmVuIFJvc3RlZHQgdG8gcmV2
aWV3IHRoYXQuDQo+IA0KPiBSZXN0IG9mIHRoZSBwYXRjaGVzIGFkZHMgdGhlIElGUyBwbGF0Zm9y
bSBkcml2ZXIsIHJlcXVlc3RpbmcgUGxhdGZvcm0gZHJpdmVyIG1haW50YWluZXJzDQo+IHRvIHJl
dmlldyB0aGVtLg0KPiANCj4gDQo+IEluIEZpZWxkIFNjYW4gKElGUykgaXMgYSBoYXJkd2FyZSBm
ZWF0dXJlIHRvIHJ1biBjaXJjdWl0IGxldmVsIHRlc3RzIG9uDQo+IGEgQ1BVIGNvcmUgdG8gZGV0
ZWN0IHByb2JsZW1zIHRoYXQgYXJlIG5vdCBjYXVnaHQgYnkgcGFyaXR5IG9yIEVDQyBjaGVja3Mu
DQo+IA0KPiBJbnRlbCB3aWxsIHByb3ZpZGUgYSBmaXJtd2FyZSBmaWxlIGNvbnRhaW5pbmcgdGhl
IHNjYW4gdGVzdHMuwqAgU2ltaWxhciB0bw0KPiBtaWNyb2NvZGUgdGhlcmUgaXMgYSBzZXBhcmF0
ZSBmaWxlIGZvciBlYWNoIGZhbWlseS1tb2RlbC1zdGVwcGluZy4gVGhlDQo+IHRlc3RzIGluIHRo
ZSBmaWxlIGFyZSBkaXZpZGVkIGludG8gc29tZSBudW1iZXIgb2YgImNodW5rcyIgdGhhdCBjYW4g
YmUNCj4gcnVuIGluZGl2aWR1YWxseS4NCj4gDQo+IFRoZSBkcml2ZXIgbG9hZHMgdGhlIHRlc3Rz
IGludG8gbWVtb3J5IHJlc2VydmVkIEJJT1MgbG9jYWwgdG8gZWFjaCBDUFUNCj4gc29ja2V0IGlu
IGEgdHdvIHN0ZXAgcHJvY2VzcyB1c2luZyB3cml0ZXMgdG8gTVNScyB0byBmaXJzdCBsb2FkIHRo
ZQ0KPiBTSEEgaGFzaGVzIGZvciB0aGUgdGVzdC4gVGhlbiB0aGUgdGVzdHMgdGhlbXNlbHZlcy4g
U3RhdHVzIE1TUnMgcHJvdmlkZQ0KPiBmZWVkYmFjayBvbiB0aGUgc3VjY2Vzcy9mYWlsdXJlIG9m
IHRoZXNlIHN0ZXBzLg0KPiANCj4gVGVzdHMgYXJlIHJ1biBieSBzeW5jaHJvbml6aW5nIGV4ZWN1
dGlvbiBvZiBhbGwgdGhyZWFkcyBvbiBhIGNvcmUgYW5kDQo+IHRoZW4gd3JpdGluZyB0byB0aGUg
QUNUSVZBVEVfU0NBTiBNU1Igb24gYWxsIHRocmVhZHMuIEluc3RydWN0aW9uDQo+IGV4ZWN1dGlv
biBjb250aW51ZXMgd2hlbjoNCj4gDQo+IDEpIGFsbCB0ZXN0cyBoYXZlIGNvbXBsZXRlZA0KPiAy
KSBleGVjdXRpb24gd2FzIGludGVycnVwdGVkDQo+IDMpIGEgdGVzdCBkZXRlY3RlZCBhIHByb2Js
ZW0NCj4gDQo+IEluIGFsbCBjYXNlcyByZWFkaW5nIHRoZSBTQ0FOX1NUQVRVUyBNU1IgcHJvdmlk
ZXMgZGV0YWlscyBvbiB3aGF0DQo+IGhhcHBlbmVkLiBJbnRlcnJ1cHRlZCB0ZXN0cyBtYXkgYmUg
cmVzdGFydGVkLg0KDQpDYW4geW91IHNheSBhIGJpdCBhYm91dCB3aGF0IG1vdGl2YXRlcyB1cHN0
cmVhbSB0byB3YW50IHRvIGNhcnJ5IHRoaXMNCnN1cHBvcnQ/IEZvciBleGFtcGxlLCBpZiB0aGUg
dGVzdCBjb250ZW50IGNvbWVzIGZyb20gb3V0IG9mIHRyZWUgKGkuZS4NCnRoZXJlIGlzIG5vIHNv
dXJjZSBmb3IgdGVzdHMgb3RoZXIgdGhlbiBhIGxvY2F0aW9uIHVuZGVyIGEgVVJMIG9uDQpnaXRo
dWIuY29tL2ludGVsKSwgYW5kIG5vdGhpbmcgaW4gdGhlIGtlcm5lbCBjb25zdW1lcyB0aGUgcmVz
dWx0cywgdGhlbg0Kd2hhdCBicmVha3MgaWYgdGhhdCBibG9iIGZyb20gdGhlIHRlc3QgVVJMIGFs
c28gaGFzIGEgYSBmZXcgc291cmNlDQpmaWxlcyBhbmQgYSBLYnVpbGQgZmlsZSB0byBwcm9kdWNl
IGEgLmtvIGFsb25nc2lkZSB0aGUgLnNjYW4gZmlsZT8gVGhpcw0KaXMgbW9yZSBhIGNvbW1lbnQg
b24gdGhlIGNvdmVyIGxldHRlciBiYXNpY3MgdGhhbiBhbiBhY3R1YWwgcHJvcG9zYWwgdG8NCmNo
YW5nZSB0aGUgZGlzdHJpYnV0aW9uIG1vZGVsLiBKdXN0LCBpbiBnZW5lcmFsLCB0aGUgY292ZXIg
bGV0dGVyDQpjbGFyaWZpZXMgd2h5IHVwc3RyZWFtIHNob3VsZCBjYXJlIGFib3V0IHRoZSBwYXRj
aGVzLg0KDQoNCg0K
