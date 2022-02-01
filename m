Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AB4A5450
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiBAAz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:55:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:1455 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbiBAAz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643676958; x=1675212958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sGHYwJ7q/yBQWa+YYyfLkG5RjRgPov6ktpfCn/AAoTY=;
  b=Uoc0Ejjbg/iVSam0mHErE2/kgWu9mmPMdh9dqld04t1gFk+CDbNmxbji
   jgGgiuXq4r8yqPJXNMdpfk3LjdRG6cAD22h9l4N34LS1jiYaptML2CzaE
   Y3D6GnBfvz2F01sGY7yuhPP96dQsnW1DjXc7HUWgal01zA2f/sbpqDwyu
   x+fZKbBP3hE7F4WQqYKIojlqib7VNocVuqjabCuSkm0hU6W2Blgzb01iY
   dELciLf4Z13hoHCYSD4weQvtiH1FG6Zb6HChOFpg808vFgpnSAB15dMPV
   pORdyCA4Ab9rDmOgCrIqKqzWlufFDVFC9nrsPhDHrbiCtcDhdCYaADlyB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="228256054"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="228256054"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 16:55:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="630218595"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2022 16:55:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 16:55:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 16:55:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 16:55:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1bYyGAukhTjJy9Dh932TCrMB6P4U2B2xBER/IlyFnOCh6bNjIvDPEec2rVh+sTYpf58ePx0FYwOb9eLPTYFOC9litZ9DeYrs1CxxcljIQOV0cgcMhdwSXumUgRAqzjWtPywFBXANuvDdYXTnKS8763RNdhtHWeaeDTAomPTOVXTLq76NaNpbm9O33WqrGD2FrS3BDn6RfTGcJ0hIfl4qohJYW9uZFZKmjExpcS07kDYRMoiHG4rfHV8b52JetGQyfNgckF6ySN1JgCPGhJIJnBozhWiHbL1cLB8U53uRp7mRi74f07x/+s9cFyfNLBUXED6SUoaLgvtI+qAiA+/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGHYwJ7q/yBQWa+YYyfLkG5RjRgPov6ktpfCn/AAoTY=;
 b=L1ny7q81k7dwRgRZGdjg3PpGZUpp0etbU0ewLWdLBQ3SgNAjUqmCjKrL5kdgDqHm9n6FLIlig2JhhKiCIb6l7K7B/zqfPf3L+VAuGlLvqh9sL/YSk4u4ettxX+vb/KWUxLwVlY68mX3iyMvu0N+ldpMoe9CKzWdWvgNgDy1UQ0OONhWZOPSvDlY1Tcv6RBcZ/miwedbMhHI6wNnqmRHNHqM4jjoqFcxmAIhrXtB+xjEGSXT2jrEWdTZwiuviaR6VhPrzFX85PZxJ4qn7SU+StAvw3VbnvyWBC4MTiN/CTDFnwc8JrgmIKhdfmb2JCE9+5X9SvqpHFi/ik1UiO9fwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY4PR11MB1624.namprd11.prod.outlook.com (2603:10b6:910:8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 00:55:47 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 00:55:47 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 30/44] mm/pkeys: Test setting a PKS key in a custom
 fault callback
Thread-Topic: [PATCH V8 30/44] mm/pkeys: Test setting a PKS key in a custom
 fault callback
Thread-Index: AQHYE6cS6O+hTjNVIUi6bZpYZjBtFax95ZYA
Date:   Tue, 1 Feb 2022 00:55:47 +0000
Message-ID: <20abc6a0b79e4fe9f60b16a1f3371f0676e77b82.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-31-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-31-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb5a3e6b-44ba-42bb-dbb2-08d9e51d9586
x-ms-traffictypediagnostic: CY4PR11MB1624:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <CY4PR11MB162484E5651B04C59F78575CC9269@CY4PR11MB1624.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7iPlAcJ5yEJ+G+EsxQx1zbVEVABQ+12E3tRtX7L8PEzhValvnDiLUeflV8JKeaORM9/L23OzHiFgWDgHPCNb3bGDjEtw5VQeKaC8vKi4HCOmU890kcpo9tSVEGgHDgM9Yqepb5t4OvHjSZgKgDE1O/zZqZbBXDO6RcvsnavL1r0Y1rU4T8NugXbv4z1DQbfvazKD1v18YoTK+a9pij2H65FrpE+QIxmi5Y+jJARf+QH0AUNnYya8oXFjcYLyvdWywcpuAuy74CHSop4XBPS89PuudwYSbToLB+UzyQdCexBGY9UaT9vwKp21NVIzgGX9rrrIbKrkO7qnSItJwpVwFz2lOKFy9YzdFBRMrgbuoxQWw3HTsFgYzBcKsPZNVdjgOycjRHJUcGJssWFZLA1wUYvktC7MuigPFXSEDrPSgzjFabFmbFa9QJ3vdc29GnbJ4TBTgZCViwASqOCr2hqtk9o7u6DVXNy6yL9a7VxmZwEvwtuqxwvY70CG6TeiJ8mzAj6Ccscth+IqqAqoCtlT7QOI/kHlo6XJk+YmA+dDhQ2t1RMVL2pixE5rTCpen5ByG2WcxxnSjnGck5Dn8wfXrPCsBjkrpvudhI5DdWCVcnG1zctX0PSKGogmwuV/uJX4HdCttOfbux/NWXdJ0WzUI8ckv/tYq2XSHYa5gLloqY5/LnR60udh/qzOxcxDWxga70mc36aM94X6lU/AM5FhrqKlMPnJcbWTcdqp3Y7r0cs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(26005)(186003)(6512007)(6506007)(2616005)(2906002)(86362001)(316002)(66556008)(122000001)(38100700002)(38070700005)(6486002)(66476007)(54906003)(110136005)(71200400001)(508600001)(82960400001)(4326008)(8676002)(66446008)(36756003)(8936002)(76116006)(66946007)(64756008)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUlZbDN1SEt1K1IwbkUzanVoeWZEQmpMNExwVWltTWgrU3RGdE55Tyt6NWJr?=
 =?utf-8?B?T3liNzJFT1dRQmRVdEE0MFEzM1AyV3FBYVM1YlV1ZGpsTld6d0haQlByd0p5?=
 =?utf-8?B?c1NyMFJDK3Ric1lpandhN1h1S2hqblJWbDNIQWVvZEFLczlUWVcxbTdYTTNq?=
 =?utf-8?B?TTErTjBrNzJJeUV4eFpONU9nQVVBRTRtZ0pOOFd0YkZrWVVQb2FhZVJla3ZX?=
 =?utf-8?B?bUxGY2psY01obFc5U28wTm1qbmVZU1J0TEYrZXc0WGlZMUQyNlVlR2lnQ3pp?=
 =?utf-8?B?bE1sdnpERjRoSHFjby9Lc2VUTmlXV1dtNlVOcjZqOWFGLzJjL3pNV2tDQW0x?=
 =?utf-8?B?VEdYL0lIOC8wcllLQXlXZGt5TWJJU0R4M0hnMkdVUCtLaFBlTFJISXViOHZ4?=
 =?utf-8?B?V0tnOUJNQjhWSTdXL1lwZjAwL2pFajRqZHJQamMzaHYxclBUWXNtTjRQZ0FO?=
 =?utf-8?B?cW8rdklrMEtwaHNJRy9qNGp2WDNwMmdZYVNiK284YjliSzgvSEppMXpCb2Fy?=
 =?utf-8?B?RnpHdzVBK3ZSOTM4VjB0OGZoaFJUQnJ1NXMxM0l5ZmM4N3J4VXZiRDlKUSto?=
 =?utf-8?B?S2hKa3NaN3owWngyampQaDIraVJlV3pLN0FJNmNsWmplYVh1eHlTS09GL2tB?=
 =?utf-8?B?UXF4L2hieW5iRHBBOTRITHp4alRIMVFqYzdHZDJndHk5Q0Z1clo3OFcycGgw?=
 =?utf-8?B?aHlKMFM5V0kxcUp1NVlvZUc4YjFJMldNQlJvZGRsY2ZxYW9iVllTMlFOY1B0?=
 =?utf-8?B?UGl0UmJ3OGd2K3k5L0dsdUo5MW1MdUwxa0oxTXVMOG90N3hGcnNweEovUlpj?=
 =?utf-8?B?bS9ZQjZDUmd0a0FCTEVIano4ZW41Tm8rTVNrZENHV3VKWHBLdGZpUEZIdncy?=
 =?utf-8?B?MXp3Q251bjV2OXRXdmdZdXhBNjdzNVNPL0kzRkQ0d1I1eE94emQyWWdLSTlt?=
 =?utf-8?B?czdMVHo2Qmw5WDB1Tzc2OGhRRkJtYnc4L0cxYWtpRng5L0luSitmM212U2k3?=
 =?utf-8?B?cEFYV3BRRGRaVVY5UlY5WUdGVm4xSnd3ZUVOdk9HRHcvczNRb1ZmQ2V4QTNw?=
 =?utf-8?B?cHpFOFBoYmwzQTIyV1JnOHkyNllaZFRQS2svbm9KRzFidGRnWWJpNjk3UURl?=
 =?utf-8?B?U3FpM2V5Y3J3WDZkMCtFbFNJQ0Q3Z3ZIM05MM3ZvODdQVWIxQ0RqTTVLb21S?=
 =?utf-8?B?U2ZVY3Y1WEpyRkw5aHAxODVJUWJYeGpwQ2xXMXl4NGhNQTBVWFgzWkRELzQ4?=
 =?utf-8?B?TGZJdmFBWEhuRTc2VVpKUmFpQURKbTc3SlhWcW8yR0dlUXh5VFljaFI2T1h4?=
 =?utf-8?B?VVF3NmltOGJQOGFuckdCdjNzZkJpVzJMMEVTSEZuazI3WTNEeEx1dktYcDZC?=
 =?utf-8?B?THRoUS84N1I2RzB4OEdaTkVoT0pacDJXQ1lSU1hZTEFHZDBFSm5qTmhQYmF4?=
 =?utf-8?B?cmVjWGhCeGhjM1pGUklxN3gxd3RmcnJFenM5MTBGOU5HWTdjN2tXWkhWZVQ0?=
 =?utf-8?B?MUtZZnBlRWM4eHM5bzVOaFBkT2x0cTJWQ2ZrbGpnbnZydmJTN01PdU5CSEVm?=
 =?utf-8?B?ZUFsZVU3SE84L0ptSGlTRzcxZlJOTTl3eEovT2FSc0pFbnppenJHQ2FmZVdU?=
 =?utf-8?B?ZGRGTXNCZHJaS3ZSaVJSOXM1K0ZpNC9QTnBZUEx4MlN2Um03R2N1d0c2dDVX?=
 =?utf-8?B?RktsZVJuNXVROFIrRy9vQTJsOUx5QWlJSjJBemVucmtqY1RGaE1TRGNYWjE1?=
 =?utf-8?B?MzVpMnl6dHU3T2MvanpYOGhTR1NKZUZ3Y2swL0wvNC94Vzg3QWNhYzJsSFZV?=
 =?utf-8?B?T2pKRXJQMERFMHFBbGEzTU1DNUoyaG5MOWJUaml1VndGSzF4Z0VQazdpd1JE?=
 =?utf-8?B?NmZacWVTb2hNYVJEMTRicXQvbmFQT0hXK01tN3R1dTFmOFJrcm9tYzRpNmtR?=
 =?utf-8?B?UDY0T2JjR0FwTDdrRnpWNjd5M2x6UGJaSVAyL0lteS9hRVlLbVhkZGhjYTQw?=
 =?utf-8?B?d21LV0xZdzhRS1dWQ1l5ZkM0akFtRURZMnptcGpUVHorN1FOeVg2bExLS1BE?=
 =?utf-8?B?aThDOG1yMmFmYW1GaEMyNU5PVHg4OVBYUkltQzZyTnpLVXV4UGdXbFg1Yzdu?=
 =?utf-8?B?dkRaTEh3OStBZnRCMHp4UlN0aWdkMGsxbWNuVlJqWitmU0VpcEpYQUZNUUpQ?=
 =?utf-8?B?N2hCK3Z5NjJNQTNGbUlHanZEKzBtZ21NY3BZd2oxTXdqZ25nYXV3YVhUdWhO?=
 =?utf-8?Q?wqPOiW0sKXXwdCM7VVzHmjRn2G6KQzCF89YNEfwGdU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52A35EED7F83D54A9736185E3C2E3008@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5a3e6b-44ba-42bb-dbb2-08d9e51d9586
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 00:55:47.3997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eU9hPx3RZKqpZ3XXnyxz6/OIWee+3V8AJRA0uY52kcSx142167PMcVz7TcNn2coXEUcEHZshnoAKk0Y8NTNj3st6IDhqjvywCw0+xwntgtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU0IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiBBZGQgYSB0ZXN0IHdoaWNoIGRvZXMgdGhpcy4NCj4gDQo+ICAgICAgICAgJCBlY2hv
IDUgPiAvc3lzL2tlcm5lbC9kZWJ1Zy94ODYvcnVuX3Brcw0KPiAgICAgICAgICQgY2F0IC9zeXMv
a2VybmVsL2RlYnVnL3g4Ni9ydW5fcGtzDQo+ICAgICAgICAgUEFTUw0KDQpIbW0sIHdoZW4gSSBy
dW4gdGhpcyBvbiBxZW11IFRDRywgSSBnZXQ6DQoNCnJvb3RAKG5vbmUpOi8jIGVjaG8gNSA+IC9z
eXMva2VybmVsL2RlYnVnL3g4Ni9ydW5fcGtzDQpbICAgMjkuNDM4MTU5XSBwa3NfdGVzdDogRmFp
bGVkIHRvIHNlZSB0aGUgY2FsbGJhY2sNCnJvb3RAKG5vbmUpOi8jIGNhdCAvc3lzL2tlcm5lbC9k
ZWJ1Zy94ODYvcnVuX3Brcw0KRkFJTA0KDQpJIHRoaW5rIGl0J3MgYSBwcm9ibGVtIHdpdGggdGhl
IHRlc3QgdGhvdWdoLiBUaGUgZ2VuZXJhdGVkIGNvZGUgaXMgbm90DQpleHBlY3RpbmcgZmF1bHRf
Y2FsbGJhY2tfY3R4LmNhbGxiYWNrX3NlZW4gdG8gZ2V0IGNoYW5nZWQgaW4gdGhlDQpleGNlcHRp
b24uIFRoZSBmb2xsb3dpbmcgZml4ZWQgaXQgZm9yIG1lOg0KDQpkaWZmIC0tZ2l0IGEvbGliL3Br
cy9wa3NfdGVzdC5jIGIvbGliL3Brcy9wa3NfdGVzdC5jDQppbmRleCAxNTI4ZGYwYmIyODMuLmQ5
NzlkMmFmZTkyMSAxMDA2NDQNCi0tLSBhL2xpYi9wa3MvcGtzX3Rlc3QuYw0KKysrIGIvbGliL3Br
cy9wa3NfdGVzdC5jDQpAQCAtNTcwLDYgKzU3MCw3IEBAIHN0YXRpYyBib29sIHJ1bl9mYXVsdF9j
bGVhcl90ZXN0KHZvaWQpDQogICAgICAgIC8qIGZhdWx0ICovDQogICAgICAgIG1lbWNweSh0ZXN0
X3BhZ2UsIGN0eC0+ZGF0YSwgOCk7DQogDQorICAgICAgIGJhcnJpZXIoKTsNCiAgICAgICAgaWYg
KCFmYXVsdF9jYWxsYmFja19jdHguY2FsbGJhY2tfc2Vlbikgew0KICAgICAgICAgICAgICAgIHBy
X2VycigiRmFpbGVkIHRvIHNlZSB0aGUgY2FsbGJhY2tcbiIpOw0KICAgICAgICAgICAgICAgIHJj
ID0gZmFsc2U7DQoNCkJ1dCwgSSB3b25kZXIgaWYgdm9sYXRpbGUgaXMgYWxzbyBuZWVkZWQgb24g
dGhlIHJlYWQgdG8gYmUgZnVsbHkNCmNvcnJlY3QuIEkgdXN1YWxseSBoYXZlIHRvIGNvbnN1bHQg
dGhlIGRvY3Mgd2hlbiBJIGRlYWwgd2l0aCB0aGF0DQpzdHVmZi4uLg0K
