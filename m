Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269D44CB536
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiCCC7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiCCC7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:59:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CB018C;
        Wed,  2 Mar 2022 18:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646276305; x=1677812305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/c0UOPZFl6dFXejKoqgCsjyFpg44LUFYAaUe8A5jHZQ=;
  b=De7Z0aFoEjLHQQkfLBbAwGAnMkmXLs8pq7JIox3oLUKiIR5BjbxB9NoB
   n7qARaTgO/MKuRsGXQ6uS9D4CBh+NrqbXkX6+3/lNW2VhQ2rhCTgjqFyp
   2fwxfR1cbvQ+FeEGtsJntAqRMgndPnfNKip3lmmesQeJ56D/KAd057YbT
   T9IoP23Q+JrN8TUeW5yLdVrmGUEMDT/GV/ENHxKNxFI5bypW15YabzaPl
   ZEJXtURXk9YBWCDgSZeSGy+nSlNCOTna6zSHW5h2D25Dqy6iCBDur0vM1
   Ea7qWn9ctJ0Mk/Wzh0C34rxTSdxWsNsw4vd2h3S9LMoW6CUygMX+z/TdI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="339994047"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="339994047"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 18:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="808640895"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2022 18:58:23 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 18:58:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 18:58:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 2 Mar 2022 18:58:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae+pHsiAX9V43K5QmI+Mas/RSlTQ2JG7+ONG4mLvc9HAyZZJPI+4mzD7f+02Ok7hOj3zt0+9z3zVrA8WX+sISDH3TO0ue+UmBFsVG5ZW7Lz4adMyERSzgMkBH15bU+eizBHMCbJPJpMPrfn3rWe/o7xDTPzEzl6KrIufj1N6MuBWSSeeUn6r2pW6Rauejcoau3FvpDPCEt1FYKe7aHQ/EMLedk3DiP3rtHE+3dWpOIXu/hIXDqMDTnxv3+u97vhgM0nlu65ybT7Gi99KBEyetPOmmTsB61PZZtlmgbKldwI7Hkryc1zLpYtjNrYe+9JOHjttrymHnrR4W6EkZX+Ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c0UOPZFl6dFXejKoqgCsjyFpg44LUFYAaUe8A5jHZQ=;
 b=Os/aFl4jL7R7Vqk5HDzQVKNrfnHvgU/NCWqyBhSYm7si7hHAf2g/Lv5LB8WKvlxkxP4UP3ILI1plZFiCNJUaNigRf0/7BvfN69US32g4puq/APM7NYv6yf2CAwyWZmNhtxE0fxbXvesAByW2GP9gUgL2xOmCslIKvoMcK6P0pYLwdZGpYbYLqN9mAsPBnjuN/Uywapwv84bZt3qs21Nr1mCcpSsPNt+V5fRVRbtze2ULvrOYuxEqA+XRz9fxZ9VMRAa8fnJbuNkk0y/6ssla9TtAvXk/kDFta+8qUZtdyZ4yJ4eeWhxA9aLMZBnF7dyQXS4aS+CtO+5d7tRNc0V5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB3195.namprd11.prod.outlook.com
 (2603:10b6:5:5d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 02:58:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5%6]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 02:58:21 +0000
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
Subject: Re: [RFC 04/10] platform/x86/intel/ifs: Load IFS Image
Thread-Topic: [RFC 04/10] platform/x86/intel/ifs: Load IFS Image
Thread-Index: AQHYLqqK1Ewk7AhuukyJhKvkqYeybw==
Date:   Thu, 3 Mar 2022 02:58:21 +0000
Message-ID: <6550946b1c7aafedf0525766deb96710938e85b8.camel@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
         <20220301195457.21152-5-jithu.joseph@intel.com>
In-Reply-To: <20220301195457.21152-5-jithu.joseph@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-3.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4b9c63b-9928-40f4-76c9-08d9fcc1ad11
x-ms-traffictypediagnostic: DM6PR11MB3195:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB31955E3590F6088B97C4AE8FC6049@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MythHQIhchpTRIudEhMyGsAhSEbd5CFJ5F1HKYQRUqDqENrW4uzo27ZVeeSAZxFLFw5ooSwKN/EvyhP6x8GfbVXhNHaSyF+s9yKV//U7+zOkjMA/2mZCOxFB2sYirhfUMN9z+dAWyyfKeIbm8VeVIwpNiabKDcxQbF/UZqsrhIEbYYP2riym/95mtnp8zKJJ+4KGSQW2AbbGhkyJyCAbxfQlvszf1XHwAUZetvX+rI62Uy39q4eSyOsuLasWqZEAnnGSfC1p1/sBczvnxyHT9/P6MTlAnwr/QzUVIkszydo/ReEEmpoL4b54FWENXZ6ZwWybW+QtyrmwHPavjz7CV7KhIGBZrALNIhCih5WVIXY8KknlCgsSzByOn7uzi2I1p330Bsc1io3ktowoYRk2zUs9X8RVjdjjjgmyZRiP2MfUee6AnLc7N5j0cotiLnwQvf+33ofDgBTTKh3My2zULya3YtdidhNOU84b/+/uSXmyh4Zbxlyws51PC1c7SxaCYhjJCV2Kjavvn++VWPEA0QTSrhmMVu/iyPbLz3Uwqvd8TJQWYsOackhJOkZqxG6VG4DuRpq2FyKwWAw3MduP6KPz2eh990j6xLrSWa0zjTddX2BwCAQr34cK9qm4tnIH5o8oSAtxoitiCojg3XZzjQi7FvlVj5rWjP0b26PKn7Dmv3eRjwkEU2S7hmsCuDxO/FRa4Zwt2yHYxzP0wWy2CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(110136005)(2616005)(66446008)(36756003)(8676002)(4326008)(186003)(66946007)(76116006)(26005)(66556008)(66476007)(82960400001)(6506007)(316002)(64756008)(6512007)(122000001)(83380400001)(38100700002)(508600001)(71200400001)(8936002)(54906003)(38070700005)(6636002)(7416002)(5660300002)(6486002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUp2YVdycDlieDZYaHI1am1lTThESHlGdlBGdEF5L250ZUErd0d2WFNaNy9T?=
 =?utf-8?B?dzNNeUxWQUhLMkhMb1FJdTBySElnKzQvaEtPZTdrL2Z2QWREMjBvdU16a2xR?=
 =?utf-8?B?KzBDZTNjVllMWGQvVXpFSGUrZHlwdGplOUlNaXkvM1MvNEJpV01hRXlveVdL?=
 =?utf-8?B?c2JYVnlCYWhpc3k2VGM4V05IZUlha29Kem1VYmQ2TU4xUlVTbEFyTlZJdi9t?=
 =?utf-8?B?bVdxRG4rLzJVYzBDVzExVWRHT1pwOENyYjdMd0RXWmVWYmFldWlkbFg0ODVZ?=
 =?utf-8?B?Y2lmQk9RbloydVppUEN0d0pOQURSQU52ZG8rL01qQjRhbjVNQkhTWGt3WVhk?=
 =?utf-8?B?UzdhcmlIY0pSZ29BMmNlNGJ0UGZHS0ZzWEZUNDNVYlFEMndNbmdnZHp2RDlY?=
 =?utf-8?B?aEdHWDRML3dKZmZ5VWlyY3ZwUFRmZklqMzlxNmI3WENLRHI0K252anl0UXJI?=
 =?utf-8?B?ZXhtcXNVZWlUZEJGakNzTmJiMXhpL3RpdXVENmJ4anFlQ0lObGxiWnlnLzNM?=
 =?utf-8?B?RHBzS2d6OVBrWlVOeHNidUdzdGpaaHp1OGlJRWhoS1J5a2lzbHVZaVJQMVZT?=
 =?utf-8?B?K2c2TXVCVDlKalh3SWNsYkpnMmRRUmJ4YWZGUUVON0lPUWt1dnhzRy9ZWGw0?=
 =?utf-8?B?VnZndW50aXZ1RXJnTzhQVXY2UG1Qck11TXJibE1oY0JSTnkyUHVlNnBZYXpH?=
 =?utf-8?B?SUFMclg3eHBQeS9LQ0VMUS9UNmRBYktFWGI0aFBWa1IyQW0wS0lUUzFXUHlU?=
 =?utf-8?B?c1FubndienpUNE0va1BKRkdvT2pXUzdlalpEUTlsTmh6czQzc3B4YjhtVkR2?=
 =?utf-8?B?YXJYbXBiNXFOa1VxbHhibzBNbm5xb2g3aUpyV1VubitLU0RUS0hHOCt2U3BS?=
 =?utf-8?B?T2VnMDBybW5KMFo0UElsUGlueSs0OThpUHQ2bW43dDZpMGxacEtRdVBzWEFF?=
 =?utf-8?B?alNmZW5oWmZOcHVaMTZoZXdORmlGRkQ4dWtBem4rdEd3MXZwTkF2Sm9teS9t?=
 =?utf-8?B?UVg4c3pwK1pIbkhwSU05cW5xTk5LOTY0TitnNUxpZExQbDhwZStlTElhMCtE?=
 =?utf-8?B?RkkxVi9id1BYZ3lnZ1gzRkx0dzYzTUZtR1I4RkRzdmloa2lUS21nUkgrNGlC?=
 =?utf-8?B?NEZKUzJEa3ozRDhjaGdXK3JUSWJ2QVJQYUN2YnBwMlF5d1hMekxhTWJ2eVBN?=
 =?utf-8?B?Y2Y4Ylk3bFBvRkgvc3pPSG9ndlRUcmMraTR2K29EYkc0Z0lWY3N4QWgxSFRO?=
 =?utf-8?B?OTYwM2RFNjhybHBPRkhoMENGM3ptSkdKSjYzRXZ5THIrb3AxRWw5dWRnOFBn?=
 =?utf-8?B?LzhSOUNZc2NBWmR0NlZ5UDdORHZrMmxJTHgvdklESkUxbXNmMGRyZEc3c0w2?=
 =?utf-8?B?cXBhVFFmOUFvRThGWGNZd1F6OW5ROWkwMGFpQ1Q4VFRVUUlUZmRoeXBOZmd4?=
 =?utf-8?B?S3pBcVF5c3RSR3lRYnJyZElkRmpCc0ZKTUhxcFduUVV0bEs1N3FUZGFoSGp3?=
 =?utf-8?B?RGNZK3RYUWUzM245aWhKQUhBd3VCZGhPeW4wdHFVd1plOG9Sc3hHaWExYVhD?=
 =?utf-8?B?LzBFQjd6UlkzSHlHM1c0dTRxNDh1QnBnd2pKd1FZdWdtYnZDMmREVDd0ek0x?=
 =?utf-8?B?ZmtlYXNWdG4wMEovbCtaUGlXRlRyK0IzMjI3OXRVYXQxYTNjS1F6emZ2S09M?=
 =?utf-8?B?c3U3WU9teUY0N1VsYTEwQ0RFazhNR01Fa1Rmdk0zbm5Bcmk3UlNTeGRpMHF3?=
 =?utf-8?B?Z0xLZEZhU1QwVGRFZitNVkk1QXJPUDBHN0JrdHlGTzV1R1NrRzFseE03ZHlv?=
 =?utf-8?B?WDNLRzUxNUN1a3F0ZVlqbmtvSVBqTGVPVWNnK1VHMUM1R3FtMHlTT21WNUlK?=
 =?utf-8?B?cElDNzFwaHhiLzA3bE9YbGNJWEUvUnlMTjAvcU9XVWVoUWZ6YWN3QkJzeUNi?=
 =?utf-8?B?QzZoZkcxTU15eVBpelpTL0NSU3EvRy90QkNBZkYvdWErajViSktmZjhEVnAw?=
 =?utf-8?B?TjBXZWhZYVRvZStkd2VmbEhYNUFDV2FNTHRra21WdHlpczVOTzBiSWQ4TjB2?=
 =?utf-8?B?cU1iMnNBVjI5amdDYVBZZWNzVytyZmI2bGtIS2kvTERsTDYvdjVqUGRKUmtv?=
 =?utf-8?B?VkNlc0p4T0hzWjBGellwWmhLWjl4SFU0ckNnUDJUOFUzVVlzMXBpUE5ob2RY?=
 =?utf-8?B?cEVVNW5pTGlYQkUrU1d5OFlpUGZNZWpCNmJVVjlTRE9ERFpZMzRrUEJjbFpL?=
 =?utf-8?Q?VW0NcagUnr4CJeuJo98qtINcVLjToGTUdRAGPpJD+o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02005DEAD6C21046AFD3F67B692FE4D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b9c63b-9928-40f4-76c9-08d9fcc1ad11
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 02:58:21.0720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/Y9SzU2hgT7eMgOJ67XnAkAlyCZSKwSvL2SSr366F56i3FZH3SjXzn2W3vutoIyZTVyIk+LHTgtDGOmorsBp+xLO07CDWB5XoZ+X9pmUlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
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
IElGUyB1c2VzIGEgdGVzdCBpbWFnZSB0aGF0IGNhbiBiZSByZWdhcmRlZCBhcyBmaXJtd2FyZS4g
VGhlIGltYWdlIGlzDQo+IHNwZWNpZmljIHRvIGEgcHJvY2Vzc29yIGZhbWlseSwgbW9kZWwgYW5k
IHN0ZXBwaW5nLiBJRlMgcmVxdWlyZXMgdGhhdCBhDQo+IHRlc3QgaW1hZ2UgYmUgbG9hZGVkIGJl
Zm9yZSBhbnkgaWZzIHRlc3QgaXMgaW5pdGlhdGVkLiBMb2FkIHRoZSBpbWFnZQ0KPiB0aGF0IG1h
dGNoZXMgcHJvY2Vzc29yIHNpZ25hdHVyZS4gVGhlIElGUyBpbWFnZSBpcyBzaWduZWQgYnkgSW50
ZWwuDQo+IA0KPiBUaGUgSUZTIGltYWdlIGZpbGUgZm9sbG93cyBhIHNpbWlsYXIgbmFtaW5nIGNv
bnZlbnRpb24gYXMgdXNlZCBmb3INCj4gSW50ZWwgQ1BVIG1pY3JvY29kZSBmaWxlcy4gVGhlIGZp
bGUgbXVzdCBiZSBsb2NhdGVkIGluIHRoZSBmaXJtd2FyZQ0KPiBkaXJlY3Rvcnkgd2hlcmUgdGhl
IG1pY3JvY29kZSBmaWxlcyBhcmUgcGxhY2VkIGFuZCBuYW1lZCBhcyB7ZmFtaWx5L21vZGVsDQo+
IC9zdGVwcGluZ30uc2NhbiBhcyBiZWxvdzoNCj4gDQo+IC9saWIvZmlybXdhcmUvaW50ZWwvaWZz
L3tmZi1tbS1zc30uc2Nhbg0KPiANCj4gT3JpZ2luYWxseS1ieTogS3l1bmcgTWluIFBhcmsgPGt5
dW5nLm1pbi5wYXJrQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSml0aHUgSm9zZXBoIDxq
aXRodS5qb3NlcGhAaW50ZWwuY29tPg0KDQpTZW5kZXIgc2lnbm9mZiBsYXN0LCBwbGVhc2UuDQoN
Cj4gUmV2aWV3ZWQtYnk6IEFzaG9rIFJhaiA8YXNob2sucmFqQGludGVsLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVy
cy9wbGF0Zm9ybS94ODYvaW50ZWwvaWZzL01ha2VmaWxlIHzCoCAyICstDQo+IMKgZHJpdmVycy9w
bGF0Zm9ybS94ODYvaW50ZWwvaWZzL2NvcmUuY8KgwqAgfMKgIDggKysrDQo+IMKgZHJpdmVycy9w
bGF0Zm9ybS94ODYvaW50ZWwvaWZzL2lmcy5owqDCoMKgIHwgMTMgKysrKw0KPiDCoGRyaXZlcnMv
cGxhdGZvcm0veDg2L2ludGVsL2lmcy9sb2FkLmPCoMKgIHwgOTUgKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgMTE3IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwv
aWZzL2xvYWQuYw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVs
L2lmcy9NYWtlZmlsZSBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9NYWtlZmlsZQ0K
PiBpbmRleCAwNWI0OTI1NDAyYjQuLjEwNWIzNzdkZTQxMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvaW50ZWwvaWZzL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZv
cm0veDg2L2ludGVsL2lmcy9NYWtlZmlsZQ0KPiBAQCAtNCw0ICs0LDQgQEANCj4gwqANCj4gwqBv
YmotJChDT05GSUdfSU5URUxfSUZTKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCs9IGludGVsX2lmcy5vDQo+IMKgDQo+IC1pbnRlbF9pZnMtb2Jqc8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgOj0gY29yZS5vDQo+
ICtpbnRlbF9pZnMtb2Jqc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgOj0gY29yZS5vIGxvYWQubw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9y
bS94ODYvaW50ZWwvaWZzL2NvcmUuYyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9j
b3JlLmMNCj4gaW5kZXggZmIzYzg2NGQzMDg1Li43NjVkOWEyYzQ2ODMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9w
bGF0Zm9ybS94ODYvaW50ZWwvaWZzL2NvcmUuYw0KPiBAQCAtOCw2ICs4LDcgQEANCj4gwqAjaW5j
bHVkZSA8YXNtL2NwdV9kZXZpY2VfaWQuaD4NCj4gwqANCj4gwqAjaW5jbHVkZSAiaWZzLmgiDQo+
ICtzdHJ1Y3QgaWZzX3BhcmFtcyBpZnNfcGFyYW1zOw0KPiDCoA0KPiDCoCNkZWZpbmUgWDg2X01B
VENIKG1vZGVsKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwNCj4gwqDCoMKgwqDCoMKgwqDCoFg4Nl9N
QVRDSF9WRU5ET1JfRkFNX01PREVMX0ZFQVRVUkUoSU5URUwsIDYswqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgXA0KPiBAQCAtMjQsNiArMjUsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBpZnNfaW5pdCh2
b2lkKQ0KPiDCoHsNCj4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkICpt
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgdTY0IGlhMzJfY29yZV9jYXBzOw0KPiArwqDCoMKgwqDCoMKg
wqBpbnQgcmV0Ow0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgLyogaWZzIGNhcGFiaWxpdHkgY2hl
Y2sgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoG0gPSB4ODZfbWF0Y2hfY3B1KGlmc19jcHVfaWRzKTsN
Cj4gQEAgLTM0LDYgKzM2LDEyIEBAIHN0YXRpYyBpbnQgX19pbml0IGlmc19pbml0KHZvaWQpDQo+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoIShpYTMyX2NvcmVfY2FwcyAmIE1TUl9JQTMyX0NPUkVfQ0FQ
U19JTlRFR1JJVFkpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAt
RU5PREVWOw0KPiDCoA0KPiArwqDCoMKgwqDCoMKgwqByZXQgPSBsb2FkX2lmc19iaW5hcnkoKTsN
Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcHJfZXJyKCJsb2FkaW5nIGlmcyBiaW5hcmllcyBmYWlsZWRcbiIpOw0KDQpXaGF0J3Mg
d3JvbmcgdGhlIGVycm9yIGNvZGUgcmV0dXJuZWQgdG8gZWNobywgd2h5IHNwYW0gdGhlIGxvZz8N
Cg0KU2ltaWxhciBjb21tZW50IEkgZm9yZ290IHRvIGFkZCBvbiB0aGUgcHJfaW5mbygpIHVwb24g
dW5sb2FkaW5nIHRoZQ0KbW9kdWxlIGluIHRoZSBwcmV2aW91cyBwYXRjaC4gV2hhdCdzIHdyb25n
IHdpdGggdGhlIGVycm9yIGNvZGUgcmV0dXJuZWQNCnRvICJtb2Rwcm9iZSAtciI/DQoNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo+ICvCoMKgwqDCoMKgwqDC
oH0NCj4gKw0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+IMKgfQ0KPiDCoA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvaWZzL2lmcy5oIGIvZHJpdmVycy9w
bGF0Zm9ybS94ODYvaW50ZWwvaWZzL2lmcy5oDQo+IGluZGV4IGYzZjkyNGZjZWQwNi4uZjJkYWYy
Y2ZkM2U2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pZnMvaWZz
LmgNCj4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvaWZzL2lmcy5oDQo+IEBAIC03
LDggKzcsMjEgQEANCj4gwqAjaWZuZGVmIF9JRlNfSF8NCj4gwqAjZGVmaW5lIF9JRlNfSF8NCj4g
wqANCj4gKyN1bmRlZiBwcl9mbXQNCj4gKyNkZWZpbmUgcHJfZm10KGZtdCkgImlmczogIiBmbXQN
Cg0KSXQncyB1bmZvcnR1bmF0ZSB0aGF0IHRoaXMgaXMgbmVlZGVkIHdoZW4gZGV2X3tlcnIsaW5m
byxkYmd9IGZhbWlseSBvZg0KZnVuY3Rpb25zIHdvdWxkIHNjb3BlIHRoZSBtZXNzYWdlcyBhcHBy
b3ByaWF0ZWx5IGF1dG9tYXRpY2FsbHkuIElmIG9ubHkNCnRoZXJlIHdhcyBhICdzdHJ1Y3QgZGV2
aWNlJyB0aGlzIGRyaXZlciBjb3VsZCByZWZlcmVuY2UuIE1vcmUgb24gdGhpcw0KYmVsb3cuLi4N
Cg0KPiArDQo+IMKgLyogVGhlc2UgYml0cyBhcmUgaW4gdGhlIElBMzJfQ09SRV9DQVBBQklMSVRJ
RVMgTVNSICovDQo+IMKgI2RlZmluZSBNU1JfSUEzMl9DT1JFX0NBUFNfSU5URUdSSVRZX0JJVMKg
wqDCoMKgwqDCoMKgMg0KPiDCoCNkZWZpbmUgTVNSX0lBMzJfQ09SRV9DQVBTX0lOVEVHUklUWcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBCSVQoTVNSX0lBMzJfQ09SRV9DQVBTX0lOVEVHUklUWV9CSVQp
DQo+IMKgDQo+ICsvKioNCj4gKyAqIHN0cnVjdCBpZnNfcGFyYW1zIC0gZ2xvYmFsIGlmcyBwYXJh
bWV0ZXIgZm9yIGFsbCBjcHVzLg0KPiArICogQGxvYWRlZF92ZXJzaW9uOiBzdG9yZXMgdGhlIGN1
cnJlbnRseSBsb2FkZWQgaWZzIGltYWdlIHZlcnNpb24uDQo+ICsgKi8NCj4gK3N0cnVjdCBpZnNf
cGFyYW1zIHsNCj4gK8KgwqDCoMKgwqDCoMKgaW50IGxvYWRlZF92ZXJzaW9uOw0KPiArfTsNCj4g
Kw0KPiAraW50IGxvYWRfaWZzX2JpbmFyeSh2b2lkKTsNCj4gK2V4dGVybiBzdHJ1Y3QgaWZzX3Bh
cmFtcyBpZnNfcGFyYW1zOw0KPiDCoCNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0
Zm9ybS94ODYvaW50ZWwvaWZzL2xvYWQuYyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lm
cy9sb2FkLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi4x
YTVlOTA2YzUxYWYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4
Ni9pbnRlbC9pZnMvbG9hZC5jDQo+IEBAIC0wLDAgKzEsOTUgQEANCj4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gKy8qIENvcHlyaWdodChjKSAyMDIxIEludGVs
IENvcnBvcmF0aW9uLg0KPiArICoNCj4gKyAqIEF1dGhvcjogSml0aHUgSm9zZXBoIDxqaXRodS5q
b3NlcGhAaW50ZWwuY29tPg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9maXJtd2Fy
ZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiArDQo+ICsjaW5j
bHVkZSAiaWZzLmgiDQo+ICtzdGF0aWMgY29uc3QgY2hhciAqaWZzX3BhdGggPSAiaW50ZWwvaWZz
LyI7DQo+ICsNCj4gK3N0cnVjdCBpZnNfaGVhZGVyIHsNCj4gK8KgwqDCoMKgwqDCoMKgdTMyIGhl
YWRlcl92ZXI7DQo+ICvCoMKgwqDCoMKgwqDCoHUzMiBibG9iX3JldmlzaW9uOw0KPiArwqDCoMKg
wqDCoMKgwqB1MzIgZGF0ZTsNCj4gK8KgwqDCoMKgwqDCoMKgdTMyIHByb2Nlc3Nvcl9zaWc7DQo+
ICvCoMKgwqDCoMKgwqDCoHUzMiBjaGVja19zdW07DQo+ICvCoMKgwqDCoMKgwqDCoHUzMiBsb2Fk
ZXJfcmV2Ow0KPiArwqDCoMKgwqDCoMKgwqB1MzIgcHJvY2Vzc29yX2ZsYWdzOw0KPiArwqDCoMKg
wqDCoMKgwqB1MzIgbWV0YWRhdGFfc2l6ZTsNCj4gK8KgwqDCoMKgwqDCoMKgdTMyIHRvdGFsX3Np
emU7DQo+ICvCoMKgwqDCoMKgwqDCoHUzMiBmdXNhX2luZm87DQo+ICvCoMKgwqDCoMKgwqDCoHU2
NCByZXNlcnZlZDsNCj4gK307DQo+ICsNCj4gKyNkZWZpbmUgSUZTX0hFQURFUl9TSVpFwqDCoMKg
wqDCoMKgwqDCoChzaXplb2Yoc3RydWN0IGlmc19oZWFkZXIpKQ0KPiArc3RhdGljIHN0cnVjdCBp
ZnNfaGVhZGVyICppZnNfaGVhZGVyX3B0cjvCoMKgwqDCoMKgwqAvKiBwb2ludGVyIHRvIHRoZSBp
ZnMgaW1hZ2UgaGVhZGVyICovDQo+ICtzdGF0aWMgdTY0IGlmc19oYXNoX3B0cjvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogQWRkcmVzcyBvZiBpZnMgbWV0
YWRhdGEgKGhhc2gpICovDQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZmlybXdhcmUgKmxv
YWRfYmluYXJ5KGNvbnN0IGNoYXIgKnBhdGgpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKmlmc19wZGV2Ow0KPiArwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1
Y3QgZmlybXdhcmUgKmZ3Ow0KPiArwqDCoMKgwqDCoMKgwqBpbnQgZXJyOw0KPiArDQo+ICvCoMKg
wqDCoMKgwqDCoGlmc19wZGV2ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX3NpbXBsZSgiaWZz
IiwgLTEsIE5VTEwsIDApOw0KDQpUaGlzIGxvb2tzIGxpa2UgYW4gYWJ1c2Ugb2YgdGhlIHBsYXRm
b3JtX2RldmljZV9yZWdpc3Rlcl9zaW1wbGUoKSBBUEkNCnRvIG1lLCBpLmUuIHRvIHJlZ2lzdGVy
IGFuZCB0ZWFyIGRvd24gYSBkZXZpY2UgZXZlcnkgdGltZSBzb21lb25lDQplY2hvZXMgYSB2YWx1
ZSB0byBhIHN5c2ZzIGZpbGUuIFRoaXMgcmVnaXN0cmF0aW9uIHByb2Nlc3MgZmlyZXMgb2ZmIGEN
CktPQkpfQUREIGV2ZW50IHRvIHRlbGwgdWRldiBhIG5ldyBkZXZpY2UgaGFzIGFwcGVhcmVkLCBh
bmQgYmVmb3JlIHVkZXYNCnNjcmlwdHMgaGF2ZSBhIGNoYW5jZSB0byBkbyBhbnl0aGluZyB1c2Vm
dWwgdGhpcyBkZXZpY2UgaXMgZ29uZSBhZ2Fpbi4NCklmIEkgd2VyZSBzb21lb25lIHRoYXQgd2Fu
dGVkIHRvIGF1dG9tYXRlIHRlc3RpbmcgbXkgQ1BVcyBhcyB1ZXZlbnQNCm5vdGlmeWluZyBtZSB3
aGVuIHRoZSAiaWZzIiBkZXZpY2UgaGFzIGFycml2ZWQgd291bGQgYmUgdXNlZnVsLg0KDQpJZiBp
ZnNfaW5pdCgpIHJlZ2lzdGVyZWQgYSBwbGF0Zm9ybSBkZXZpY2UgdG8gcmVwcmVzZW50IHRoZSBp
ZnMNCmludGVyZmFjZSBpdCB3b3VsZCBhbHNvIHByb3ZpZGUgYSBwcml2YXRlIHBsYWNlIHRvIGhh
bmcgdGhlIGlmcyBzeXNmcw0KaW50ZXJmYWNlIHJhdGhlciB0aGFuIGdsb21taW5nIG9udG8gdGhl
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1IGNvcmUNCkFCSS4gSSBwZXJzb25hbGx5IGRvbid0IHRo
aW5rIGlmcyBmdW5jdGlvbmFsaXR5IGJlbG9uZ3MgdW5kZXINCi9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1LiBBbHNvLCB3aXRoIHN0YXRpY2FsbHkgZGVmaW5lZCBzeXNmcyBhdHRyaWJ1dGVzDQphdXRv
bWF0aW9uIHNjcmlwdHMgd291bGQgYmUgYWJsZSB0byBzYWZlbHkgYXNzdW1lIHRoYXQgdGhlIHN5
c2ZzDQppbnRlcmZhY2UgaXMgcmVhZHkgY29pbmNpZGVudCB3aXRoIHRoZSBLT0JKX0FERCBldmVu
dC4NCg0KDQoNCg==
