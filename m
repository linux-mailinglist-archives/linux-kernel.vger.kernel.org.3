Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3299F5A742D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiHaC4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiHaCz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:55:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D5BA061D;
        Tue, 30 Aug 2022 19:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661914555; x=1693450555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=APXCjmidsUGN5mnRHTFzzmwbi7xSGSLVwuR0pfVJJ60=;
  b=RLwJrjNbOcIHuFdHXQiXcd4tyKP8CHjop68Do45Sil/T069CvnzsmkNx
   RM3l0/OoI4jgsrx0Ct+FE9fCCBp5ZpG5fZBkf9FKyXmA1Ccj/IMzw0Cri
   vXYzYgNwIbJXMuXtzowYVSNwIbjYNT4xeJIvR+jPdEzuWsxsvR0cXxnS9
   DBrQcySHkQ0w7mIkYQ09nk36fE1e50+s4xvBdI08TmcfgDmThmzaaeJtI
   An7Yfgv1U887FED01x6AOpWvsTpvYbBKW//mGQIunNJOW/9j79XIa95Eh
   CNCfjAGIlUW8du30I5LGrTHIiqW3Wwo5h73DWHCu0qXQsoEIsUgdTbyQj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296143454"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="296143454"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:55:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="588880220"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2022 19:55:54 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 19:55:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 19:55:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 19:55:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI/bxg7SETrFCllxK61Sz9PVtgQ5W+X5GCpS/5rTwyWW4wDUIrIHDCDuRFDNmWPIC8FEgGOUycNbiz+JMYfs1vq1GCt6OGPb+dkLhlqtQvRRku+CrK5I0nZTT/CP3JfRaPV5r3DmgncuVWB+pe2AJdCUSlRoTiTasdz8JLNrXNoMPPIl3Lw1gTKA+ttYXZMOHgZP58sxKrZr7JQZzL5dM/iL7HZFgmXxfw5/zGbJbvOw2aHJsCtDT/KzUHcR8pB3pPZ8qYkTAIl7N46kE8Io1nJxWPKpQYDYAMOnWtBN9N+HMcDUjpVGHUvMeuur6YO1Kw3esV4msl1hRHFbsLAsUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APXCjmidsUGN5mnRHTFzzmwbi7xSGSLVwuR0pfVJJ60=;
 b=AsGTX/MkCDdKE3lADx7VV3nL8Zvk2N03E08DJRYtjlEhL0IgphdT6xtwe7hiFJxKopDkcEFIBHZ7gMq1WYaa+ztBAVbyEhEAxeiQ6zICzc3/5AttzQPOHIqJJeVGqpaduVPdJH3Ta2gysHF9QBPwPTMMgZovFShvExSIqWbGXXQSTtAkjfB/G4vwl3Koj83dhAiFwhiflAresvqY1pZB4ikvJihjRWLUL8qaaNAFggAG+rRG8qeMQfLTl96xZZu3aXEH1eD3vzDmSCWFdNuv+dcA+SysS276GKOTrXabHIAlVRcH93rstPTgk8/miaymo/Y4A9jO8qH1TiyHoPqtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN0PR11MB6181.namprd11.prod.outlook.com (2603:10b6:208:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 02:55:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 02:55:52 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Topic: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Index: AQHYvB5Zhte1gFzwtkKh12BdFyDkBa3IDqyAgAAq44CAAA1sgIAABY4AgAAChYCAAAMQgA==
Date:   Wed, 31 Aug 2022 02:55:52 +0000
Message-ID: <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
References: <20220830031206.13449-1-jarkko@kernel.org>
         <20220830031206.13449-2-jarkko@kernel.org>
         <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
         <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
         <Yw7EX5GCrEaLzpHV@kernel.org>
         <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
         <Yw7LJa7eRG+WZ0wv@kernel.org>
In-Reply-To: <Yw7LJa7eRG+WZ0wv@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f947163-2932-4019-dcb4-08da8afc5102
x-ms-traffictypediagnostic: MN0PR11MB6181:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LsehdTkE3JB7bgiqhEbjY63jDJGp25nj6bgZFvZc0w97MoqErnTC5mLcUnaiNd8Xu6va6RfojjQnsg4/zrOlRIhwuwkH9sq2KdiGNwASjMG9lY4lgFsG1FWSvtXqv7/9dSMvqg7OIepBgvlc4lbGajxTdHqTIt4qSRFzjHJDUkMhSB/W2vDhuZ9gnefC+fYyHFEcjFWCiG1uacJUkWfbEr4ivOuD0H8ziIwkheaMztAWLyOjZhaWBkXRzV8rxyvYImBrhBqhLgM8IyLUsDnfvLUo1AA9gpKSmevYWMz2FP+FF680ojYbuXjR/xXhX29PP5zTR5V0oOZrw+chVxbI7XzTRG2AUvayNse9cE2HlAy6olxZmmDpk5sS9an1ZLP5Z41HFeMWusRZXv8ZsJUme53lKJ4/+ObEwRg75RsFP1CUt+rFD1bta3v2pciZFB0csckSJPHbF4XsiqRDESfPnVTD/DKbBW4fY9H47whn2di69DsSQCvenSXkKgm+nMG9kPFrO6GwIORhwgpN4jSQd6Ln4FpgyCsj+cBFh3ffX2WtxCsPMU3X20IZV05PdspvqEMpym+AFwtzRi5vR5HY50Aw1Tywv/1DeX8VG3z8wtsXfn81ZQh3fKCTBVRlvAJv8VaLLMYOhpBzCkDhvkgaCmLjhQ105/7x3oJpH7hiviRqgBhtsmCOWVJqq6qVVUkAl4GKr9B4ul5fCr1kZ2KLOPnvHlBunVJH6GpST1iNRLGWyZLZxIO+k5DnOXJAwXc7Ei1t6ydIWQMHNiCQaKfjiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(38100700002)(5660300002)(83380400001)(76116006)(186003)(2616005)(66556008)(2906002)(8936002)(54906003)(316002)(6916009)(91956017)(64756008)(36756003)(8676002)(66446008)(66946007)(7416002)(66476007)(4326008)(71200400001)(478600001)(6486002)(86362001)(38070700005)(6512007)(82960400001)(26005)(53546011)(6506007)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHltQ1liUTJ1OHpKaFh3MVVDODFxYUxLQk4wVmJPM01GelJLMEZBaUtnREha?=
 =?utf-8?B?dVNvai8vZXZ0NFRDakdNdUZ3LzRaUnVoM0NmUGlNS1pKbDk0SnAvek1qdDJz?=
 =?utf-8?B?anZCeE9OaDVFNHJGRG5tUDd2cmJTa3JBQ2NLU1Y5ckFmRC9YYUJZNUZTaEhX?=
 =?utf-8?B?bkRKUTlkTGY3bGlBTm8wY1Y5eFAvQlhoSUhqQ3RwbU53VTBSY1Blck50Ym4r?=
 =?utf-8?B?eGZJNWVJQS8wUXZHM2t5bmVoQmZrbktMdEYyaC9IWFhwdVlwSVdZUllCK2wy?=
 =?utf-8?B?ZjROeXpnSFZMUmZSMk5zeHc4dW5GbFJ5dEcrb1pRcDhvSXdqbUw5bjNzWG1Z?=
 =?utf-8?B?SW82bWFCZmYxaGtBRERFc1dhS1RlcXVDR2pXUUYxK0lQemdrUXZGUWJRMTlw?=
 =?utf-8?B?QWdVdi9TaER3UzhCUXBxZWcwaUJZeUpRQXhuWmwxb1NXdVFEZlZRSzFKQ2xr?=
 =?utf-8?B?dEI2czBFUlFySnhkNHFZNW5xa0FVOWRiTlFSVmMycCtjSUk5bUlOa29wRkZ4?=
 =?utf-8?B?djM4VWdySWlWdjBvNWtPdjdFUzByMVZLUmRxbEZkNmFrKzdTTzRGdHFjNVov?=
 =?utf-8?B?TVpObDJiTno5SHRPUkQ4UTFIQk92c3hpRU84MVFmSGNNWGFJSEdoNnNkKzR5?=
 =?utf-8?B?OGEwcXZjc3ExaXB3UENLMFdFNCt0ZnR0cTIvcmdkYWhveXA2NjhlSlY4VTk2?=
 =?utf-8?B?ZUY2eTI3TlpSRGttL1crREtEeTAva2N2Wi9ZRnhESXJiUjcwUlBkOUNmNXd4?=
 =?utf-8?B?Y0o3dXNOelFueEw4MHU3amJaaTB0azVOZHZETUo3bjRRZEFLU0l6eUVPclBK?=
 =?utf-8?B?L3krWW5DVWgrNFhqY1BNNmQwQ0hXQXJkOFE3OGxhbW83Zjdib2dmcDFxMXhQ?=
 =?utf-8?B?MDEyS2t6L2xrQ0xKQXIrVEJreisyVWRxRGh3b1F4K25MM05EQ3dDYmc4enZz?=
 =?utf-8?B?N0xBS01jdXJuZ2t1TDk2OVcvQ2FIN3REQ1JOd0NCOEtEdjVWdktGdmhZMkNM?=
 =?utf-8?B?MVZCTWpSNzFKSDd2cE1jTndNR1ZpNmZoMVdDbFhpVm01MFA0QW5ERmVlRm9k?=
 =?utf-8?B?N2lQRWRFRVY2VzZsVDlmNGZUd0hlNXZKbWNlWTBaWktNakZYZ3BDbnhTa3pM?=
 =?utf-8?B?WWVUemRmUTVUc2daMmFCOHZwWDNSdWI4RmxrbFlHdnM3OXhDcGNFWW1BVUZX?=
 =?utf-8?B?aGxUS2E5bkNwL1I3c21mZytTaVlpMVdOUGU5MXdYRkRSL0FiMTdJeW9BNXFw?=
 =?utf-8?B?QVJQM0xIMDBjT09SclhGR0szUHRMSWhHQk4rdUM0RGlMQStROURiZm91Y2lB?=
 =?utf-8?B?bHAvbVY3K1N6Y1kyVndHa2V2Y1M1SmFLZjVROXFBdzNnMTRkbnBVQy9raGR1?=
 =?utf-8?B?VkpuMCs1cEpENmEzbU8rQ1dPQnlSeXl0OFRHUUY4UDNXNVNyTVA2ejNNbXlD?=
 =?utf-8?B?VStUVTlCQTdmeE1USVc0U3FDekd1azRLUDl2Q1NxajIzSnNhQWxXTmptMEdZ?=
 =?utf-8?B?VmRjVGxPdU5WYVZTazE4cFBnZFRCaDlTOE54NE1QVEwvRXd1d3phUEJ1aW9B?=
 =?utf-8?B?QUx3Zjlxa0psZHBrb29VbUhwUThLaXBOY085R05RV1g3MjhtQlFSRDNXZTJr?=
 =?utf-8?B?Uk9JVEJ1UWZCbXJDTDcrMy96ejhHL1NFbWNVODBsWG1oektxQjZQOWg4VnRU?=
 =?utf-8?B?Tm9iZmdyUVZiVitHWHJTMWpxTXNTSDFud3FpQzZMZmhXYWVkdUFxZ2lYa1ZX?=
 =?utf-8?B?djFNODlXU2hnTXpGMDhqbjlLZm90K3Z3MHVTQkhDdmRWdlozcmw0N3RZcktv?=
 =?utf-8?B?UmROYS9yaGRDZTFKNDVwZEVtY01Kd2JZTSs5R3NPdE5iMHVaYTBhYUJlcWQ5?=
 =?utf-8?B?eUR6S2hZUCttNGE1NFRld3pUMUlHVGtsZ09vVGwrZ1ZQUkZaS3ZtMmNBSUtJ?=
 =?utf-8?B?Vm9uTmZwZmFCN2ZiRmpVMFNGZ3NJRUpOZkVIbjBhZW1oVnNEb29ETWRBU21T?=
 =?utf-8?B?U0praVBLVnZSQi9DRmdXaFZzRVg4bStwS0RLQU9SMmlHdGNoNTYxbWtCbkxJ?=
 =?utf-8?B?SDUrREN2cGJmU0NucVFiaUJzVGV4TWVsb3IwSXB3Uk1NakQ1RlpnZW9RVWFJ?=
 =?utf-8?B?ZnJUOVJxWUl3ZHJOL0dyeEhzZHMyZUFaMm1sMkQ4eTB0dXRFY2tMREZka21K?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5254A23EE2EC8A4AA5B467E4EAFDB342@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f947163-2932-4019-dcb4-08da8afc5102
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 02:55:52.1723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fZQf4t95DDPAmYZiH3QpmZ25IC244SHpjiupkt4e/zZbXUiPlcXxDs1uf3rnpwvVxfjjOVZ1F31QKJ9g+xIpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6181
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTMxIGF0IDA1OjQ0ICswMzAwLCBqYXJra29Aa2VybmVsLm9yZyB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMzEsIDIwMjIgYXQgMDI6MzU6NTNBTSArMDAwMCwgSHVhbmcsIEth
aSB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjItMDgtMzEgYXQgMDU6MTUgKzAzMDAsIGphcmtrb0Br
ZXJuZWwub3JnIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBBdWcgMzEsIDIwMjIgYXQgMDE6Mjc6NThB
TSArMDAwMCwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIyLTA4LTMwIGF0
IDE1OjU0IC0wNzAwLCBSZWluZXR0ZSBDaGF0cmUgd3JvdGU6DQo+ID4gPiA+ID4gSGkgSmFya2tv
LA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIDgvMjkvMjAyMiA4OjEyIFBNLCBKYXJra28gU2Fr
a2luZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBJbiBzZ3hfaW5pdCgpLCBpZiBtaXNjX3JlZ2lzdGVy
KCkgZm9yIHRoZSBwcm92aXNpb24gZGV2aWNlIGZhaWxzLCBhbmQNCj4gPiA+ID4gPiA+IG5laXRo
ZXIgc2d4X2Rydl9pbml0KCkgbm9yIHNneF92ZXBjX2luaXQoKSBzdWNjZWVkcywgdGhlbiBrc2d4
ZCB3aWxsIGJlDQo+ID4gPiA+ID4gPiBwcmVtYXR1cmVseSBzdG9wcGVkLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEkgZG8gbm90IHRoaW5rIG1pc2NfcmVnaXN0ZXIoKSBpcyByZXF1aXJlZCB0byBm
YWlsIGZvciB0aGUgc2NlbmFyaW8gdG8NCj4gPiA+ID4gPiBiZSB0cmlnZ2VyZWQgKHJhdGhlciB1
c2UgIm9yIiB0aGFuICJhbmQiPykuIFBlcmhhcHMganVzdA0KPiA+ID4gPiA+ICJJbiBzZ3hfaW5p
dCgpLCBpZiBhIGZhaWx1cmUgaXMgZW5jb3VudGVyZWQgYWZ0ZXIga3NneGQgaXMgc3RhcnRlZA0K
PiA+ID4gPiA+ICh2aWEgc2d4X3BhZ2VfcmVjbGFpbWVyX2luaXQoKSkgLi4uIi4NCj4gPiA+ID4g
DQo+ID4gPiA+IElNSE8gImEgZmFpbHVyZSIgbWlnaHQgYmUgdG9vIHZhZ3VlLiAgRm9yIGluc3Rh
bmNlLCBmYWlsdXJlIHRvIHNneF9kcnZfaW5pdCgpDQo+ID4gPiA+IHdvbid0IGltbWVkaWF0ZWx5
IHJlc3VsdCBpbiBrc2d4ZCB0byBzdG9wIHByZW1hdHVyYWxseS4gIEFzIGxvbmcgYXMgS1ZNIFNH
WCBjYW4NCj4gPiA+ID4gYmUgaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5LCBzZ3hfaW5pdCgpIHN0
aWxsIHJldHVybnMgMC4NCj4gPiA+ID4gDQo+ID4gPiA+IEJ0dyBJIHdhcyB0aGlua2luZyB3aGV0
aGVyIHdlIHNob3VsZCBtb3ZlIHNneF9wYWdlX3JlY2xhaW1lcl9pbml0KCkgdG8gdGhlIGVuZA0K
PiA+ID4gPiBvZiBzZ3hfaW5pdCgpLCBhZnRlciB3ZSBtYWtlIHN1cmUgYXQgbGVhc3Qgb25lIG9m
IHRoZSBkcml2ZXIgYW5kIHRoZSBLVk0gU0dYIGlzDQo+ID4gPiA+IGluaXRpYWxpemVkIHN1Y2Nl
c3NmdWxseS4gIFRoZW4gdGhlIGNvZGUgY2hhbmdlIGluIHRoaXMgcGF0Y2ggd29uJ3QgYmUgbmVj
ZXNzYXJ5DQo+ID4gPiA+IGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkuICBBRkFJQ1QgdGhlcmUn
cyBubyBnb29kIHJlYXNvbiB0byBzdGFydCB0aGUga3NneGQgYXQNCj4gPiA+ID4gZWFybHkgc3Rh
Z2UgYmVmb3JlIHdlIGFyZSBzdXJlIGVpdGhlciB0aGUgZHJpdmVyIG9yIEtWTSBTR1ggd2lsbCB3
b3JrLg0KPiA+ID4gDQo+ID4gPiBJIHdvdWxkIGZvY3VzIGZpeGluZyB0aGUgZXhpc3RpbmcgZmxv
dyByYXRoZXIgdGhhbiByZWludmVudGluZyB0aGUgZmxvdy4NCj4gPiA+IA0KPiA+ID4gSXQgY2Fu
IGJlIG1hZGUgdG8gd29yaywgYW5kIHRoZXJlZm9yZSBpdCBpcyBJTUhPIGNvcnJlY3QgYWN0aW9u
IHRvIHRha2UuDQo+ID4gDQo+ID4gRnJvbSBhbm90aGVyIHBlcnNwZWN0aXZlLCB0aGUgKmV4aXN0
aW5nIGZsb3cqIGlzIHRoZSByZWFzb24gd2hpY2ggY2F1c2VzIHRoaXMNCj4gPiBidWcuICBBIHJl
YWwgZml4IGlzIHRvIGZpeCB0aGUgZmxvdyBpdHNlbGYuDQo+IA0KPiBBbnkgZXhpc3RpbmcgZmxv
dyBpbiBwYXJ0IG9mIHRoZSBrZXJuZWwgY2FuIGhhdmUgYSBidWcuIFRoYXQNCj4gZG9lcyBub3Qg
bWVhbiB0aGF0IHN3aXRjaGluZyBmbG93IHdvdWxkIGJlIHByb3BlciB3YXkgdG8gZml4DQo+IGEg
YnVnLg0KPiANCj4gQlIsIEphcmtrbw0KDQpZZXMgYnV0IEkgdGhpbmsgdGhpcyBpcyBvbmx5IHRy
dWUgd2hlbiB0aGUgZmxvdyBpcyByZWFzb25hYmxlLiAgSWYgdGhlIGZsb3cNCml0c2VsZiBpc24n
dCByZWFzb25hYmxlLCB3ZSBzaG91bGQgZml4IHRoZSBmbG93IChnaXZlbiBpdCdzIGVhc3kgdG8g
Zml4IEFGQUlDVCkuDQoNCkFueXdheSwgbGV0IHVzIGFsc28gaGVhciBmcm9tIG90aGVycy4NCg0K
LS0gDQpUaGFua3MsDQotS2FpDQoNCg0K
