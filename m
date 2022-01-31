Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2F4A4F75
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376536AbiAaTaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:30:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:39877 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376540AbiAaTaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643657419; x=1675193419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JCiNGu5I6ICc6AilYsFohrBAlGO8VIzfGPa59SmdJx4=;
  b=jTVLdjA9pvFrcmas6h5PByXJm0WNuQdwTYCWJ9HJW/IVxvGDY02Qey4T
   +iItqhy3XLRXfh5g8TuYcQKTYmhkn8bij2R7GyPNRBZThBronFttQAJ4H
   khy/crP1SA3vFP1zlTxJ4KQ7HG1I3f4a8zJdL0Or5FYXCGMmpzLt/HLxB
   iZ21AdgKIv3zfP7SJLZEBjejATheUfvUBsoK5Ls4Q3Nuhc/kBKbH+zlfp
   p9dfTnybKdEwdKV3H9/dnVm6Z/U5UUUwEbq8vF9jqxVGqfHscqq/cB9Nn
   NUt4F1IYv3oInTONc7m0RpoixDgvDgIJrbhbx3M30JWATuQjrQC8GfbCd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="228196606"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="228196606"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 11:30:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="497058789"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2022 11:30:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 11:30:16 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 11:30:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 11:30:16 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 11:30:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFycW4ubMg3ecMcItW0sABGYi40jtGUCo8HyF530NxmbzAB1gsqUyme7In+lfcx0KxA5m8daxLY2LWNSokzYQDlYlav1YnuucJrYhClWdSby8mIrwsHyFlnI86pckH8JZDZE4ecjpwhZrEi1VuLsWoaaVjkXSwnosI5hFAReWP6HucKczS2VD43xFghoJDK0Z3RsEvVF4H/BxTywiScKFx7wiLgMHnhy5wf1yInQEtuQz3FZW0BTucVzwex5ngkxca8TXX1yfosh6wu0VRPFHMw64KlIwgKN4f/PhlNfVc1I3JEdImX24ewPNzZRQstNuoaU+YnSLxQIv+iatNRU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCiNGu5I6ICc6AilYsFohrBAlGO8VIzfGPa59SmdJx4=;
 b=Crr5tUtT1kjxXpUdQI161sb9zGsI4Ks32grqR1xQwpm7MElDkpI4ql4gXt5vedsIh+twqbweSivlm8O4HESVN55OpOFJG/txBYmjlmMvsVI8JLA8cShlxA0jjV7QbJ2ALVUS1W9341Dhqw+pTTqOOmInSPdmoq5Ps1+I86yxPXYI9p0ympkrtLXzn9IZWq0H3x7wwax6F9kaz3AqyXdS8wU3Ev8N7F4Ri2Na89igYq8x1XBetaAppKVYABhO3L485XFcNYT8KjapbObSaCHaTAIOe6nOHcNn+1j1TZySzb7nJgjmY2UP6Q13I4rf+WxraznDrD1mM7yfPRI+K4kY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM5PR11MB1625.namprd11.prod.outlook.com (2603:10b6:4:b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.18; Mon, 31 Jan 2022 19:30:14 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 19:30:14 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 13/44] mm/pkeys: Add initial PKS Test code
Thread-Topic: [PATCH V8 13/44] mm/pkeys: Add initial PKS Test code
Thread-Index: AQHYE6cQNBANmmiLLkuYMiv7rcmlxqx9iqGA
Date:   Mon, 31 Jan 2022 19:30:14 +0000
Message-ID: <1ac1daf90285869ddfdf52daa8d39bc462253883.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-14-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-14-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf8fdd81-c5aa-4f26-0d0b-08d9e4f01adb
x-ms-traffictypediagnostic: DM5PR11MB1625:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <DM5PR11MB1625F2A032CC129DED0694A0C9259@DM5PR11MB1625.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrWlzqFFMYZJo/fzDnQ/eQM3cok0BC+wz83Z7HyLP8/GbZ8GIRXHuCfS1oWq3mCCHUCsshBeMwYaYIyynvRDkmtRIKKMg3SVZDsyRyyyHzIfi5FsNM8D+nFE+s1EhXn8npu0hMdUdNIvaDMmOip2bjuooFdM81UeFhbckon/xiEzr1TOm8njpv6NI1PNscPF+vB+RbCIUcAWvNf3YrhbSKYC46P7DfRb39Tu78yDNZAAbmXOTWB2TT8xw+B7OIr7YfbZLqMEICcQartR7ly9o4JVe3gTK0jwDgAZE/BRoZToziuv2J06rI81E9B6pwf3+HjjD8cYpxjUWkqBufP/n96ZCSsQCLlL2nWrxrYlm0xBTfjQmlIbd56bHGwmpuvf8DJQ1kO12kOnAHoBoq7cPwfIk25zmEV5VC2OcBAeW9uaYZalwMocXdESf41wPRhZbACe1zr9ulnqS14mi8cZ0Ut4cxCaaSLgc9vRL/2ACJ/7ha5wNuAZTIEDg0Z52ZKWiZmRqdtbbwrkC7IirwXgWT7frn2efLhQaBcOYozT6vjaB3OsmmBpoBI+m/9672ahlS+pVm5MVfGn/OY0X/3Pj+o5DyrArYFP+E43/jpAM5TcU3qjm7n9BpaJHISKy0vluYHgEHe18Qll5oXNbmlIuWQ8nEbf2hgAKP3CsJyYL+oi/0cEC8BXpQtHPrcpGssJM6uZNzAJsqGZhyW0xJxF4sY2GxmPeIrk1uVgGUIo8Jw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(186003)(26005)(4744005)(82960400001)(122000001)(38070700005)(76116006)(38100700002)(36756003)(316002)(6506007)(71200400001)(86362001)(66946007)(4326008)(8676002)(8936002)(66556008)(64756008)(66446008)(66476007)(6512007)(110136005)(54906003)(508600001)(6486002)(5660300002)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXNsL2o2UnB4T3JpaGpXV1VCVmFBcm1JMGlScVlOTDdtTkpIYlJIaUVVVGJI?=
 =?utf-8?B?NkViK1habzVpUHhCTDRUUHJVVzhkcVlFVS94WElra2VLM3JZZWRQS3dVRUVX?=
 =?utf-8?B?Q3o0cGt2c1B3Si95Q0JhOGkxK2JUdUtORTF2ZHRuYXlZeFUvWlhQdUN5N3FD?=
 =?utf-8?B?UXNXeVFXZ3N6emRHT0dJalN2Z1JQMjdFYmJqM0MzT0dqb1RzRUlxcUJkanJL?=
 =?utf-8?B?QjFiMVVMeHg0Z0J0b2lMRFFSM05iR21qOUVwcnFLTVZ6dlB3Uk1tQXJaQkNj?=
 =?utf-8?B?ekF2QVprdk9sMm91UWI0ZElrMGxXSmtZVk5sZG5Sb0JXeTBpbXNJR3JkN2N4?=
 =?utf-8?B?a2NZaXdJQmpPMkN0TVJHSTJaS2ZFakpMaFZ6YnZaOW1LNC9zSDRxZkpWcGtD?=
 =?utf-8?B?emlPak5qdGdFZ2hhejRrZ25hL3c0OVU5SlpSZGxlKzRDMk1OOHFBbTZ4R3Jt?=
 =?utf-8?B?ZkFMWkRub2NvNnp2MWV2SEFyYVhZRi9nREtobXNjM0t6OUoyZG1yYmJISVFC?=
 =?utf-8?B?aXBLbXE3YkY0Y0NaVWdmcnlNMjFEQkxTOU5WNjMwOHZKa2thM2p2Qkcxb2l6?=
 =?utf-8?B?T201dm14aERpU3hSbWI2eTA4SEtEaHMrcHJtRkhPRjgyRUdiZ00zS2lzd2lU?=
 =?utf-8?B?NkpJcEt1SlpDQXoxZ1ZlbU5pV3lUWlYrU2ZOeC9LeDRNTVlxL0VhaE4xWEJw?=
 =?utf-8?B?QmRwSXc0c1RxcHR0dG85VzZYZXRnZ3IwUXJTRExMV0dQak9kcjE3Vyt6aVc2?=
 =?utf-8?B?SlFvSzdmRnE0NS9jZ3JreEhFWkpQYkFNdVhSMmRLaUpZS3hveWNRMmpSdWVv?=
 =?utf-8?B?aVd6UGJOb3M4UUNyN1FONHBrRkZYTDNXZDNQUWZXc205dUpFWERJZTFwTit3?=
 =?utf-8?B?T293dkpKTkp1K0JLWlltYVRSWXBoc3FuQ3lpMUZ3ZmdUNFdNQzhscGFNdHRp?=
 =?utf-8?B?aFdnWHZQdlRpYlJzMjE0QUgyN2dwSXJqMzZydlo4dVVrNFluQWNyRzEwdmpN?=
 =?utf-8?B?OVdYa0pGNWFSbWJGNldpckVkTVMwK2M4eEtxNFZCNEtmQUNmTytEazRmWTda?=
 =?utf-8?B?cFZUVTVUcFZMUjY0NlA0SnBPSE9zWFpDMWV3UTduWmlES0J0YStuRis3cisv?=
 =?utf-8?B?RmNsWjNKeXdHQ0t4YXUzWVk3aW1XT2xsZGlFYUlNNlQrb1hkd0NWWUd3REpu?=
 =?utf-8?B?TEpmVUNjSUJBVEdWNXR1aWg0M2JaWU5LdlJwWm1SNVB5K2ptVDE3VzRKMUpm?=
 =?utf-8?B?MmJsNDZ1Zkp2b2RpdGRmS3NzTkRMeS9jNWFyVkxjTmJycXd1U05OWEtqd3Zl?=
 =?utf-8?B?N0ZPWHlaeFBSU240eDREYXU0SjRhc1UwMW4zRGRvV1lXTUx3NGliTlMxSFJI?=
 =?utf-8?B?R0ZmbHdXaS96bm8xampzVDM1L2ZZT3F2ZGptQ0lPVjEvTi9lUS9hTTVzN0R6?=
 =?utf-8?B?ZXRySzZ5aWt1V3hvc1UxTzlROGpFWW4xN2U5T1Y0eWI5dm1ncFlqbWVCZ052?=
 =?utf-8?B?amY2by91S1M1TGUwaTQvMXBRT2dwV2FhTW9iV0NGTzZVdkdPWFJBb3cxeHZR?=
 =?utf-8?B?WU5NM2VTS0NsbjVucXpPdnBwUFdoUk1hUmgyMzAvZEpLRFdRR2lhZU1BVElr?=
 =?utf-8?B?ZXRaQ0FRVVpWUUF0eEFRNUI1NXpLRTNJRVpES1BaMnc0dlhzbXJLTGsxQ040?=
 =?utf-8?B?QmpqUlFRaExobXRMNkxoUlVCUXhZRlVtWkJnZCtCWW9IZ29CUHJjQkJOTTli?=
 =?utf-8?B?bWpOV1ZCZEpKTlZxSTI3MjMwaGUxS3B5RjRwU2czNlFtNDBmcjNBMUNRbmlE?=
 =?utf-8?B?NU44Mjk2VnhtWmlLUjhBaHp4OEpSR0xPaXY0bWZvYzNFdnRIdGEwVFNGYkx6?=
 =?utf-8?B?aTBlZ3JwbExKbWd0OWN1YnNHbnJQRHgxYjRWK3h6aXNGeUYrdzFmZlhDWnNz?=
 =?utf-8?B?YlJ5WWRWbFUrWmxMcGVweENwc1E2a2hYMDJ3VGdaWWJiYWx6Vm5GdHZNbjhy?=
 =?utf-8?B?K3RxZnVsMWlxYVA4d1lWTWpwRlVZZUZMcHVIUE9vNWU5MjBPdVd6Z29XQ1Fx?=
 =?utf-8?B?Mk91RzhjL2p4K2xZTHBRVitIRjd5ekZIZDRPekhFeTJib2JqbUJUVXQyc2ZE?=
 =?utf-8?B?Q0RPMnVPazJySE1JZnNSYlJPSm11NGJONkMvZ2F4OFpuYTh1VWwvZm15MEN1?=
 =?utf-8?B?bFRObXJaTjNQNmhVVVBRdVZvMEpXaldWdFM3VVl0ckZHZlFpNTZYZHAxclla?=
 =?utf-8?Q?fbnS8hVtS5jMOSs8yoZq9hHY0zKYe+Q986MKjYVeco=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1734703695F2414D9CA2047AA1C5D4BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8fdd81-c5aa-4f26-0d0b-08d9e4f01adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 19:30:14.0514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: locEoDwSfI/raQALrMuqWaxT0G1JBqWMp9gAVWgquVCK7rtIsXWM9Z6wr56XxWAQfygzV8KHd2WEk7Ys3FyNFKhWYLdRhUYgVZGwdH+BYMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1625
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU0IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiArc3RhdGljIHZvaWQgY3Jhc2hfaXQodm9pZCkNCj4gK3sNCj4gKyAgICAgICBzdHJ1
Y3QgcGtzX3Rlc3RfY3R4ICpjdHg7DQo+ICsgICAgICAgdm9pZCAqcHRyOw0KPiArDQo+ICsgICAg
ICAgcHJfd2FybigiICAgICAqKioqKiBCRUdJTjogVW5oYW5kbGVkIGZhdWx0IHRlc3QgKioqKipc
biIpOw0KPiArDQo+ICsgICAgICAgY3R4ID0gYWxsb2NfY3R4KFBLU19LRVlfVEVTVCk7DQo+ICsg
ICAgICAgaWYgKElTX0VSUihjdHgpKSB7DQo+ICsgICAgICAgICAgICAgICBwcl9lcnIoIkZhaWxl
ZCB0byBhbGxvY2F0ZSBjb250ZXh0Pz8/XG4iKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsN
Cj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBwdHIgPSBhbGxvY190ZXN0X3BhZ2UoY3R4LT5w
a2V5KTsNCj4gKyAgICAgICBpZiAoIXB0cikgew0KPiArICAgICAgICAgICAgICAgcHJfZXJyKCJG
YWlsZWQgdG8gdm1hbGxvYyBwYWdlPz8/XG4iKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsN
Cj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICAvKiBUaGlzIHB1cnBvc2VseSBmYXVsdHMgKi8N
Cj4gKyAgICAgICBtZW1jcHkocHRyLCBjdHgtPmRhdGEsIDgpOw0KPiArDQo+ICsgICAgICAgLyog
U2hvdWxkIG5ldmVyIGdldCBoZXJlIGlmIHNvIHRoZSB0ZXN0IGZhaWxlZCAqLw0KPiArICAgICAg
IGxhc3RfdGVzdF9wYXNzID0gZmFsc2U7DQo+ICsNCj4gKyAgICAgICB2ZnJlZShwdHIpOw0KPiAr
ICAgICAgIGZyZWVfY3R4KGN0eCk7DQoNClNvIHRoZXNlIG9ubHkgZ2V0cyBjbGVhbmVkIHVwIGlm
IHRoZSB0ZXN0IGZhaWxzPyBDb3VsZCB5b3UgY2xlYW4gdGhlbQ0KdXAgaW4gcGtzX3JlbGVhc2Vf
ZmlsZSgpIGxpa2UgdGhlIGxhdGVyIHRlc3QgcGF0Y2g/DQoNCj4gK30NCg0Kc25pcA0KDQo+ICsN
Cj4gK3N0YXRpYyB2b2lkIF9fZXhpdCBwa3NfdGVzdF9leGl0KHZvaWQpDQo+ICt7DQo+ICsgICAg
ICAgZGVidWdmc19yZW1vdmUocGtzX3Rlc3RfZGVudHJ5KTsNCj4gKyAgICAgICBwcl9pbmZvKCJ0
ZXN0IGV4aXRcbiIpOw0KPiArfQ0KDQpIb3cgZG9lcyB0aGlzIGdldCBjYWxsZWQ/DQo=
