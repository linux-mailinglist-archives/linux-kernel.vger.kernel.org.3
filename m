Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EFC58F8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiHKIRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiHKIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:17:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDEB61B25
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660205819; x=1691741819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OnRiGypbh3eP3I5btI89kOXB1nj0uHwk1N21rgGCzXQ=;
  b=AyOvH1jLtUyJXpd8jeS/phmlMzvg/GAEoPA/p1sNU9lgjcrdU2HR8sxE
   U9B78Au+TAM7NRD/66JYlZoUSKUwjzXshErmETa8F5YKPTUcXGrk6cKLA
   hWkiwjBQrSsVyMi0cmzXkYAGYKEPBHzGzL0K+Vj4BeQ4oNPodqM+uT2qT
   vuPkdlUKPmXPDuaCxXMx7PZbMzPEipxo5KaFeytLCKeN/HqygRbKiunY3
   gCwhxDqtUS/pCiDiqOlfAG0YZQ2k6TyOMINc0Zgny03xsriA9nMx7GX2Y
   +XB3yDXhIZpzDY67cWw3WZllYWvHkQcMz/Xc34Zi6B2siO0FWPazt93qn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="292549326"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="292549326"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 01:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="851127869"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2022 01:16:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 01:16:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 01:16:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 01:16:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTK8SFs27uXRtAAQAjrGhigYCSMHJ0dTHfjH5dt4/+G8FSVeFvC2s+Yoz/krPayDdEWhSYSxeNF02MRl/G4DskgXjnCIZheme5Dv0+8riD9H2LCw7HM+HcF+cy+Gb+ElTpeyEVlET/e0YbPTdCblEE5VsOxF4fCDiCY4dLWPMKv7OXvvAyXb+nbq2qsiccGcrvSxFocv5iyZFBGQAATFGPZ4bEOyj+MdaVcZXwXiX+KNLh0wUqyQEhxj6X1JMcfUFYPzgk4xtZrYj/tokUrEhwIhzTOxGnc8AosEBzs64ehNPQ0D+zEnvCg7ArwfwYX5MR7NtVU4/+XvpDW2RmjHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnRiGypbh3eP3I5btI89kOXB1nj0uHwk1N21rgGCzXQ=;
 b=dEQY+xK2Rp8JiRqcw9lk0wJBXrMrmI8m7LK/V7TiA4pHDRsI/Gttb3Zao3yJUBxz9y5YR6kCJsmv+6cQWuqUgzlI/qPvWZVRXydL48Ipjk7yBC8timjL/+o03T4Sy6sTI7KNybx+MVY7JbZC0HGFlBEJoZ32tMTmRvTu+8+lMdsOeXCcvmZ8snjJ3Jgr9Kc33Q94af64VxOqQ6I60yEamROdDAaDdewyyJrclH4xr+HRgwmBm29yVvO95Vl0m4lZbEPTHJzaYspW5aQjQUTZI7Qak6IrMnvMY33Na8V2Rz7adm1o7AK28Ica1ehTIh+DHBoJkvOFd8pXL6eimQTpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MW3PR11MB4585.namprd11.prod.outlook.com (2603:10b6:303:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 08:16:08 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda%5]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 08:16:08 +0000
From:   "Lu, Aaron" <aaron.lu@intel.com>
To:     "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "song@kernel.org" <song@kernel.org>
Subject: Re: [RFC PATCH 1/4] x86/mm/cpa: restore global bit when page is
 present
Thread-Topic: [RFC PATCH 1/4] x86/mm/cpa: restore global bit when page is
 present
Thread-Index: AQHYrUI1xwv3uv7AJUiaDBJIKJAKla2pWqAA
Date:   Thu, 11 Aug 2022 08:16:08 +0000
Message-ID: <df4f40ff3e4c408931ed21ab4e8968bdb1871f79.camel@intel.com>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
         <20220808145649.2261258-2-aaron.lu@intel.com>
         <YvSRyjDsrbB7v2JT@ip-172-31-24-42.ap-northeast-1.compute.internal>
In-Reply-To: <YvSRyjDsrbB7v2JT@ip-172-31-24-42.ap-northeast-1.compute.internal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f5b1395-6ac1-4bad-221e-08da7b71be5d
x-ms-traffictypediagnostic: MW3PR11MB4585:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: stQC+gOmrlylX3qwmo+eh1bXxt4imKfIzepee1Qs9lzUdIhbawg7NRZultFeFj3MWs0aFkF99dokDWSyLZt/z15NGsD8hAzy8NQnC6eIh/yPDV2JFHGFusCEb2J5Pk4plm1JE3U7bNO9VdqMzHAd0S0X8uUrVA70ryhGBUwMCIjYgEMPRuwqxWSC5s+4kBJLLGEjreISabve8n3WEkFym0tuyleNK47c2fD1wmR2csLdHpD7PcFuCJnCFiu83RNqpLfGyL/rx7R8AQJybVAS5NE8+CRqaRhLMZ0V2kaISlRqno4roGXLImAhuchmIEHeijOzLPXq+HKF+mc9Fd7KOGJZPo+V8V+mv1XgefHD6lctJl8V4GZRivMN/0sH/1Ry/JzMHAZbG2sTfqeaLjupvk5SgOskFh9k5BUfRulRyHrbxo6WfPJZBYdTpiSgMK1nuTiXjgVrllk/n9SyXmFrscXEuCHH9eVFDel2oqPeeXbPNIya1CECS1NaAWI1hSrksv6XI3O7yOlIMzCJOhOaDchWSUB9D2f+Q9QumRJkoc8isECq2mLtxH848GUQvJcvf+v7kyd37GbGpiUQem7enH7I7dKKUWyiTqccWPwLi7w0sTGwq7vk7Pa5MJ8l6ZjGx1RSjjblrCKZlDgjGOSDb2bjVMXugDdNKVOu9x+ie5Vjj0mR0wK81PjmPc7dM7SyrZoMytb2UR5ere+W6jseKoIuVTNDmdEru3z/5mgad5hqaTfCQgCXrwAdqtDNsDNZ0sgF0D7dHrZacTYiIjbEzQGRQNrGTBpTpKdmgMkVZutFvtm315rYwIzli1QA0gA3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(376002)(136003)(366004)(316002)(122000001)(71200400001)(41300700001)(38070700005)(82960400001)(66946007)(66556008)(66476007)(2906002)(66446008)(64756008)(8676002)(91956017)(4326008)(6506007)(26005)(38100700002)(76116006)(6512007)(5660300002)(186003)(36756003)(478600001)(86362001)(83380400001)(8936002)(6916009)(54906003)(6486002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkpuM2dDcUk1N3dMTkxkMVBqOUJzUCtZQ2dyK2RsN1JOQlBCNWJKQlpxd0ZG?=
 =?utf-8?B?S1RsV2kvenZEdURHRlE1dTdiMVh3dytSY0F3SnN2SHZycE0wVW1xNjFKenpy?=
 =?utf-8?B?dVFLblFGTTlyRnFNVWFaMzNxdkxJRDJ1WHFVVzI2ckl4WHRLcnpaWGJqQnNl?=
 =?utf-8?B?K0NoVXM4VFdLV3JjS3NTd2IrbzBpZkdya3dYbVJvSHV6V0RtWWcwTEcvMzFL?=
 =?utf-8?B?RDVUdFpaMU5nSElTRkVEZy9OeE1iRHFQb2NOREpuUkF0bTBaTkZ2b1VZR3dC?=
 =?utf-8?B?cWpDajk0NkNUaDU4Ujl2MHJMbnprQnkveS9NTWVBbkRTbjNBdHlZd09mbDlj?=
 =?utf-8?B?bWh4NjlWREpJa0JCOURlWkFVSFNwYy9EVUxZZm5ybHozUEJUcWlnT3JBLzJW?=
 =?utf-8?B?RDRmOWhkQ2xNMTRTY3RJZkR3QnNVYmF3VnpSc0FOaXlReWJScUlnYXViT2FR?=
 =?utf-8?B?V2daU0RFalpMNUtJSnpxcTFmdTljRGxKYzgxbmMybTM0bmVOYk9XNERxb3B2?=
 =?utf-8?B?Y0lINW5YSGF2dnBzYm1kUEdJOGRyNktJMXZTNUdKMVppOHVRQnd6LytSN1li?=
 =?utf-8?B?SUV4NVY3SmF1eFFoV05xd0c5d0FaeTFZSlEzNG5Tcjh0TWVobVpiR3o0OXZv?=
 =?utf-8?B?NEYyUHd2aDVCOUhORHg4YkhyaW9YTUZoRGhJMXNIT2VXd0VkWENwRjNLay9X?=
 =?utf-8?B?VlMyUjNJMHo1eDFlZzhVWVR2Q3NiTHRja0R4WHlJbDVCL0FRRGtNWmhwUzNX?=
 =?utf-8?B?aFF6djY5ZnU0SEg3M2NRK0hWT2ZsZi9XU1ZZWEM0N0pXOTM0a0FWYjJpWk5k?=
 =?utf-8?B?SFk0UmhnZnZZNkpMRUhjSUdEY0NFUmFWOEd0dHkrbnU1SUhnaG9uaGhJU2Iy?=
 =?utf-8?B?Rk5HVytNek9xdU1kZktncFJCbXNQMDBFZjJNSVFDRUoxdkVTMFlPazlWaTFw?=
 =?utf-8?B?TXVvUjJYbFpUQzJMQ0U1NDVtOStQa3lHa0dhMG9abmdEa0RHMWpEY3BWWW16?=
 =?utf-8?B?Y0g3RC9nQ21yNHUxYXB3VzE5WU0zM0NjN1FYRkp2VlpITUhmT0dvN0FIeW52?=
 =?utf-8?B?U3hpbG9BZnFBaHVucjBiV29lSHNZd1N0U1QzNmE0Wkd6d1B0QlBEY1NlbmhE?=
 =?utf-8?B?dGhDeFBjbDAvaEYrUFNmVWFVLy91M0M1elpCRG03UDd1OEM1QTlLQ1pJS1lP?=
 =?utf-8?B?dzdzTUJmaGh2elRRSkpldk5neFEyRkFMU2pEUEV0UTFGdWl6ZlQvWFV2bTJP?=
 =?utf-8?B?MHpldS82eFVIWXVNZnBZQzJwMHlCY0pQZUZqa3MvZ3pyVmNkRUMxZFh0cWtT?=
 =?utf-8?B?VGNkOER4NlFJQldScE8ySS92bFFXTEE3U1I5YmZRSGhucG1KWS96V0JZckgy?=
 =?utf-8?B?Z0dJelpURnZucW9oeHZGdVd2SFQ4UGd5ZXRtSWZrcjhEaHIxczdqOWlrTEpl?=
 =?utf-8?B?R0VURW8wd3RVYWJiK01OQXNtWTJsU01kdmM0RmdFRFpmajVjY1FuNVJ5UlhF?=
 =?utf-8?B?NXNQYlNyTW1tZFZsaFJBN1gzWnMyM25DVWg5clRXUmsyeHN5cDJ3M2dMT1M2?=
 =?utf-8?B?Q1lGaEEza3dXZTFoSURqdFhkSS9GZ3dHSlBTYzQ4b2Z6T0Z1MXdMS2JkOG5H?=
 =?utf-8?B?Q0dyeTF3UkJXZmRSbkM4K1llNXRKVC83c0lzZzFlUEw2UmV2cEZtNG5RNTJI?=
 =?utf-8?B?MEd0dVRxSnRJVTVqLzQ0VnUyaTltWDV2WWplUkF0REhlbkc1aHg4WE9JME5x?=
 =?utf-8?B?TDVEa1VDQlJucEgvS2tRdVliRGZXbTBSU1hsTHlDZklXTWxXYThQVTBiRURy?=
 =?utf-8?B?cHFvcVpYck40Qk42d3NodENvR0NvR2xveFV6TE5ETFdlUDRaeWFNaWQydGlE?=
 =?utf-8?B?ZHhLQTJmRkpYdmJpVHlJdUozbE5NUUtLalRDaWYzZDJ3bFpPK2VSM2VERmxu?=
 =?utf-8?B?YUpkYTl5Zmp2cTRjWWtMNSt6UGxlWHIyRVdHS3N5L3B3QkpFbDkrS2ExeGx0?=
 =?utf-8?B?cXYrUG5INEJwVUxobFlnRGcvT3ptLzQ5ZjNzNnV2cXFoTjQza1oybnRINDlW?=
 =?utf-8?B?RzBkZkFvS0djWGxvWkhJd1NRbTVKWGZvYW1vNlg4REUxdHo0TEFuL0tnUEZ6?=
 =?utf-8?B?MGZ1M1ZsZklFY1BuNkdMV1F1bG1sRmp1Z0hCRm1HdFh2TGxhQ3M5eXN0N2k0?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8BE8960384DE2488D195195EF1AC46F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5b1395-6ac1-4bad-221e-08da7b71be5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 08:16:08.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 678l3x6qwHmMpi2E/0g+Vz5OK3+OkssOWPcI5mO5MOx5vJiHf5Pm2fePZXVMtZHoXRinBOUt8evko6bFFa4QWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4585
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA4LTExIGF0IDA1OjIxICswMDAwLCBIeWVvbmdnb24gWW9vIHdyb3RlOg0K
PiBPbiBNb24sIEF1ZyAwOCwgMjAyMiBhdCAxMDo1Njo0NlBNICswODAwLCBBYXJvbiBMdSB3cm90
ZToNCj4gPiBGb3IgY29uZmlncyB0aGF0IGRvbid0IGhhdmUgUFRJIGVuYWJsZWQgb3IgY3B1cyB0
aGF0IGRvbid0IG5lZWQNCj4gPiBtZWx0ZG93biBtaXRpZ2F0aW9uLCBjdXJyZW50IGtlcm5lbCBj
YW4gbG9zZSBHTE9CQUwgYml0IGFmdGVyIGEgcGFnZQ0KPiA+IGdvZXMgdGhyb3VnaCBhIGN5Y2xl
IG9mIHByZXNlbnQgLT4gbm90IHByZXNlbnQgLT4gcHJlc2VudC4NCj4gPiANCj4gPiBJdCBoYXBw
ZW5lZCBsaWtlIHRoaXMoX192dW5tYXAoKSBkb2VzIHRoaXMgaW4gdm1fcmVtb3ZlX21hcHBpbmdz
KCkpOg0KPiA+IG9yaWdpbmFsIHBhZ2UgcHJvdGVjdGlvbjogMHg4MDAwMDAwMDAwMDAwMTYzIChO
WC9HL0QvQS9SVy9QKQ0KPiA+IHNldF9tZW1vcnlfbnAocGFnZSwgMSk6ICAgMHg4MDAwMDAwMDAw
MDAwMDYyIChOWC9EL0EvUlcpIGxvc2UgRyBhbmQgUA0KPiA+IHNldF9tZW1vcnlfcChwYWdlbSAx
KTogICAgMHg4MDAwMDAwMDAwMDAwMDYzIChOWC9EL0EvUlcvUCkgcmVzdG9yZWQgUA0KPiA+IA0K
PiA+IEluIHRoZSBlbmQsIHRoaXMgcGFnZSdzIHByb3RlY3Rpb24gbm8gbG9uZ2VyIGhhcyBHbG9i
YWwgYml0IHNldCBhbmQgdGhpcw0KPiA+IHdvdWxkIGNyZWF0ZSBwcm9ibGVtIGZvciB0aGlzIG1l
cmdlIHNtYWxsIG1hcHBpbmcgZmVhdHVyZS4NCj4gPiANCj4gPiBGb3IgdGhpcyByZWFzb24sIHJl
c3RvcmUgR2xvYmFsIGJpdCBmb3Igc3lzdGVtcyB0aGF0IGRvIG5vdCBoYXZlIFBUSQ0KPiA+IGVu
YWJsZWQgaWYgcGFnZSBpcyBwcmVzZW50Lg0KPiA+IA0KPiA+IChwZ3Byb3RfY2xlYXJfcHJvdG5v
bmVfYml0cygpIGRlc2VydmVzIGEgYmV0dGVyIG5hbWUgaWYgdGhpcyBwYXRjaCBpcw0KPiA+IGFj
Y2VwdGlibGUgYnV0IGZpcnN0LCBJIHdvdWxkIGxpa2UgdG8gZ2V0IHNvbWUgZmVlZGJhY2sgaWYg
dGhpcyBpcyB0aGUNCj4gPiByaWdodCB3YXkgdG8gc29sdmUgdGhpcyBzbyBJIGRpZG4ndCBib3Ro
ZXIgd2l0aCB0aGUgbmFtZSB5ZXQpDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWFyb24gTHUg
PGFhcm9uLmx1QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYvbW0vcGF0L3NldF9t
ZW1vcnkuYyB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jIGIvYXJjaC94
ODYvbW0vcGF0L3NldF9tZW1vcnkuYw0KPiA+IGluZGV4IDFhYmQ1NDM4ZjEyNi4uMzM2NTdhNTQ2
NzBhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMNCj4gPiAr
KysgYi9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jDQo+ID4gQEAgLTc1OCw2ICs3NTgsOCBA
QCBzdGF0aWMgcGdwcm90X3QgcGdwcm90X2NsZWFyX3Byb3Rub25lX2JpdHMocGdwcm90X3QgcHJv
dCkNCj4gPiAgCSAqLw0KPiA+ICAJaWYgKCEocGdwcm90X3ZhbChwcm90KSAmIF9QQUdFX1BSRVNF
TlQpKQ0KPiA+ICAJCXBncHJvdF92YWwocHJvdCkgJj0gfl9QQUdFX0dMT0JBTDsNCj4gPiArCWVs
c2UNCj4gPiArCQlwZ3Byb3RfdmFsKHByb3QpIHw9IF9QQUdFX0dMT0JBTCAmIF9fZGVmYXVsdF9r
ZXJuZWxfcHRlX21hc2s7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIHByb3Q7DQo+ID4gIH0NCj4gDQo+
IElJVUMgSXQgbWFrZXMgaXQgdW5hYmxlIHRvIHNldCBfUEFHRV9HTE9CTCB3aGVuIFBUSSBpcyBv
bi4NCj4gDQoNClllcy4gSXMgdGhpcyBhIHByb2JsZW0/DQpJIHRoaW5rIHRoYXQgaXMgdGhlIGlu
dGVuZGVkIGJlaGF2aW91ciB3aGVuIFBUSSBpcyBvbjogbm90IHRvIGVuYWJsZQ0KR2xvYWJsIGJp
dCBvbiBrZXJuZWwgbWFwcGluZ3MuDQoNCj4gTWF5YmUgaXQgd291bGQgYmUgbGVzcyBpbnRydXNp
dmUgdG8gbWFrZQ0KPiBzZXRfZGlyZWN0X21hcF9kZWZhdWx0X25vZmx1c2goKSByZXBsYWNlIHBy
b3RlY3Rpb24gYml0cw0KPiB3aXRoIFBBR0VfS0VOUkVMIGFzIGl0J3Mgb25seSBjYWxsZWQgZm9y
IGRpcmVjdCBtYXAsIGFuZCB0aGUgZnVuY3Rpb24NCj4gaXMgdG8gcmVzZXQgcGVybWlzc2lvbiB0
byBkZWZhdWx0Og0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5
LmMgYi9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jDQo+IGluZGV4IDFhYmQ1NDM4ZjEyNi4u
MGRkNDQzM2MxMzgyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5j
DQo+ICsrKyBiL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMNCj4gQEAgLTIyNTAsNyArMjI1
MCwxNiBAQCBpbnQgc2V0X2RpcmVjdF9tYXBfaW52YWxpZF9ub2ZsdXNoKHN0cnVjdCBwYWdlICpw
YWdlKQ0KPiANCj4gIGludCBzZXRfZGlyZWN0X21hcF9kZWZhdWx0X25vZmx1c2goc3RydWN0IHBh
Z2UgKnBhZ2UpDQo+ICB7DQo+IC0gICAgICAgcmV0dXJuIF9fc2V0X3BhZ2VzX3AocGFnZSwgMSk7
DQo+ICsgICAgICAgdW5zaWduZWQgbG9uZyB0ZW1wYWRkciA9ICh1bnNpZ25lZCBsb25nKSBwYWdl
X2FkZHJlc3MocGFnZSk7DQo+ICsgICAgICAgc3RydWN0IGNwYV9kYXRhIGNwYSA9IHsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgLnZhZGRyID0gJnRlbXBhZGRyLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAucGdkID0gTlVMTCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgLm51bXBh
Z2VzID0gMSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgLm1hc2tfc2V0ID0gUEFHRV9LRVJO
RUwsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIC5tYXNrX2NsciA9IF9fcGdwcm90KH4wKSwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgLmZsYWdzID0gMH07DQo+ICsNCj4gKyAgICAgICBy
ZXR1cm4gX19jaGFuZ2VfcGFnZV9hdHRyX3NldF9jbHIoJmNwYSwgMCk7DQo+ICB9DQoNCkxvb2tz
IHJlYXNvbmFibGUgdG8gbWUgYW5kIGl0IGlzIGluZGVlZCBsZXNzIGludHJ1c2l2ZS4gSSdtIG9u
bHkNCmNvbmNlcm5lZCB0aGVyZSBtaWdodCBiZSBvdGhlciBwYXRocyB0aGF0IGFsc28gZ28gdGhy
b3VnaCBwcmVzZW50IC0+DQpub3QgcHJlc2VudCAtPiBwcmVzZW50IGFuZCB0aGlzIGNoYW5nZSBj
YW4gbm90IGNvdmVyIHRoZW0uDQoNCj4gDQo+IHNldF9kaXJlY3RfbWFwX3tpbnZhbGlkLGRlZmF1
bHR9X25vZmx1c2goKSBpcyB0aGUgZXhhY3QgcmVhc29uDQo+IHdoeSBkaXJlY3QgbWFwIGJlY29t
ZSBzcGxpdCBhZnRlciB2bWFsbG9jL3ZmcmVlIHdpdGggc3BlY2lhbA0KPiBwZXJtaXNzaW9ucy4N
Cg0KWWVzIEkgYWdyZWUsIGJlY2F1c2UgaXQgY2FuIGxvc2UgRyBiaXQgYWZ0ZXIgdGhlIHdob2xl
IGN5Y2xlIHdoZW4gUFRJDQppcyBub3Qgb24uIFdoZW4gUFRJIGlzIG9uLCB0aGVyZSBpcyBubyBz
dWNoIHByb2JsZW0gYmVjYXVzZSBHIGJpdCBpcw0Kbm90IHRoZXJlIGluaXRpYWxseS4NCg0KVGhh
bmtzLA0KQWFyb24NCg==
