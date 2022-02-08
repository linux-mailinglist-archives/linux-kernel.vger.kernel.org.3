Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2034AD9A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359514AbiBHNVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348082AbiBHMvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:51:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3ACC03FEC0;
        Tue,  8 Feb 2022 04:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644324664; x=1675860664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wy74L8tS15rSy2b04oi+zAzxwmvL4alzZjsARg+XJyg=;
  b=I9nZRQ5r9WW35nEV5Hy2OMki1C6H7Ktvd/uFvCXX1eYt+8sOkJCOEJhg
   fvXMCJADhI80HrUwpZ6dYzrvAqDDQ0SN0qnIYkyP91Ucuz9/vlbJISFVc
   xc/QKTjZLgtnoeb8xeGkB8x7KlCMl4SzD78JR7MS7LpAuLPY7WEnNPfMO
   AwzPtfFFcRMsCvERaAyFlGG0ov9V8KivuYbI5LuJI+5G7XhdnUwO6xX9R
   e4onMhw/HhMY7N6ntXmx9LJqle+CykH2KklewKvhMZsogTE3gRS1L8y8i
   AOUQvAMJA3kDwEutTG6FTz4f0/VQg0tmMGTkqjRgni66M+KlTQyLNz+QE
   A==;
IronPort-SDR: d0vnoyuKuN0TSFRZsdpwPAe26XnWNrqWXgLG4KJsiTKVRWEKZL6Li5kGBQZoxFXJqkBVcgb8HA
 DjwNJnWqndHdO54oFDX8iYXoPI+ccCDIJlmxkauVblERunD8VXTEwEiZijwgqqFL/SkJDDOom0
 yXT1IR4VKqOS90GJfeWe3wUwmFP8Q5S1l3XhgBQI47r/Wa+vxR0qi1QZZRSHrlEAFOnFqedIY2
 D6irrknqN3k2o0vimDHtn4eHJvXqiHTELYqobAmitJGwSMWKzxQfiaM6DlU+4V+7NavOOzGyym
 7kgK1c56gXeLtYawVE14hF6I
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="161469295"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 05:51:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 05:51:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Feb 2022 05:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHFCCxFFTsu1kCGGNyeHkicdZNLzq7GJ+CAN2l+635pveYQ8TAlXEXafAmLAUesT82LLmJguk4ntVnFntS5k0dWa/O6mkgIIUfWdioisrjG5Ym+q4HLFPXFcshuxho7muXfVhZ+pSqehHFNSssw4nGaKiO+evUcHXPicTwS7ZWC5fG9/lMTM7bGmm12vihk9Ah0dOJRDqGfuHwEZIDMPAvZQ+kQv8nRW2YoE7kzVcPcDXKh+/yRrl9yIj7B1nNw96+JEhvd+AdOC8/C0DRKQU1F2+tjmsw2bfErd5Kj3ZsXY/C8Nna4ro+xE+EHxuQry2DqEBdZPhNei+mVEZfpPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy74L8tS15rSy2b04oi+zAzxwmvL4alzZjsARg+XJyg=;
 b=KoDQKpJirCIPD62VxCJq3mIWUpa1zOo38+BhrPTg+QWKdYpGLo/2zvqij/cvK8ZCEAOIcNMhidECaQJ4uem7yKjt9TIPbq6Y2nBC5ryh+sJuLa+1HcSfgX5S5/P+q40g9vFedcq4RjPmPYh5wKU/YttgpYjGsEKGWOsCXkIcGgCUyw/Z+0n0mPuNnERfPMzagEOHnZSn9DkNHkDA0vktP7mgu5yYuDPgEtIpeS3XXBMxdqdjWJlFUVng6YDkWW0lYCVLYweOeynrFhkJ65OSzcN6U6UYWOyW+FvaZTDnQgDEg2k1khYIIZFe9pBM7lf34kelcLk55TEsAouZCoWWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy74L8tS15rSy2b04oi+zAzxwmvL4alzZjsARg+XJyg=;
 b=Hk9FiQBs78fDyXWCILvJzOthkxMrSJdlxW+Cil2UhxAhqyVHNoYGKKcFlv9V+u4bZy5deKnTFXmnfsZgQ++sb47xXqc4AqJa1joQe+SMRLpO2s73okdZT6QknJ50An33gCUVsC+MT8taoAKDEHRNHFGY3R5C/N04Py5eaEj0qrs=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by DM5PR1101MB2299.namprd11.prod.outlook.com (2603:10b6:4:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 12:50:57 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc%9]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 12:50:57 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jacopo@jmondi.org>, <hverkuil@xs4all.nl>
CC:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>,
        <Nicolas.Ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 01/11] media: atmel: atmel-isc: replace 'stop' variable
 with vb2 calls
Thread-Topic: [PATCH v4 01/11] media: atmel: atmel-isc: replace 'stop'
 variable with vb2 calls
Thread-Index: AQHYDsjpSyXNsyBpZkOtcLyOZsOMEKyIAnYAgAG0/gA=
Date:   Tue, 8 Feb 2022 12:50:57 +0000
Message-ID: <201fff30-59d0-c802-542e-93ddc70b0fd9@microchip.com>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
 <20220121131416.603972-2-eugen.hristev@microchip.com>
 <20220207104652.zovthrwpdi5cnvdm@uno.localdomain>
In-Reply-To: <20220207104652.zovthrwpdi5cnvdm@uno.localdomain>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a2728ab-2535-4db3-5e8c-08d9eb01a6c2
x-ms-traffictypediagnostic: DM5PR1101MB2299:EE_
x-microsoft-antispam-prvs: <DM5PR1101MB2299FBFC5067181F34671D45E82D9@DM5PR1101MB2299.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqaWwtD+NTYRpxxWAj91razpK2xc19mYeW/MfIii1h224cr1+pMAQFUgmrv7W03JohGomW5iTqBAJkV4KhAHsy4jkGY5ks/D4Suc+p6KwhZatAiRAcJsDvkZIcMg3KFkYZFqv/o3h2K7RBEs7QwXgQEF1RnrLzUszI4YJnYFRaAI0qRjPwMCsDKFSc+MaE3cDqrZdgiER/HjYkB2YApjjkf5N1YpEEA/BziM2QJ389g1NHv91taH8ZN+PzLf+EDdZJ+Ub6xwD/ArkIBwo0goo1Bx9w0g1vYk9GKq1nFAhEj+LocXioFN1IWHblClp3dh3n1vRm0YAUkGDMc8JdjnrfyweCEGxz8o1yOEscYI5Ks9dNtmkDM/JuM0DwyQI/ogMHrUz/uPjYHvammbX7IoZ3jcnWJ5oS6GZwdzKkQAcHhvoPmydcBRSQH6itg2HD03JS+LRm3OE89FlOwnnpQ8LQtmKB/Z1bfapfATKTdJioSiKAhmYNYRHeEPE9p3fSsrr3h4TtDcvA+Awm98IGJz9mmUwYf5+EpK5lNztNBj18AbJwQR28ilqfVr82Y2HGfqz2ckPyygrh0wOvtsUsBoULlPpS/kU8+4mvudb/uk2thJwE8z+vWAuGcxOiIY2gXADiq/5Kr2XxxZa3If/pXjisju5PhpcIgrVQClnWpv/SN8QJWydsUbHmjJTlTYhd7Z9bxJ+tIdYyb4PPccgxnfIR6LNULOoFlqbqg8WNhUyzR2LszbQ+uEdP20NE7ALWltobNogNXOqDa6VRb8NyWmHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(66446008)(86362001)(66556008)(6486002)(83380400001)(6512007)(8936002)(26005)(64756008)(186003)(31686004)(508600001)(2906002)(36756003)(2616005)(316002)(122000001)(7416002)(54906003)(66946007)(110136005)(5660300002)(38070700005)(91956017)(6506007)(38100700002)(71200400001)(66476007)(8676002)(4326008)(76116006)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3lhZ2VCMEZPU1dtZE16cTZObWlhOFNyS3hjNlFieTY5eTF6anVxdlpqSWtG?=
 =?utf-8?B?VHRpd2RzSFVncEo0eDJZdjdIWkZQWHdhVHIxVnV3TkNZSXdkZ0pMWTg2NFhO?=
 =?utf-8?B?Umw0THdOdFp1aFRwMDNZOXFFTUMrRW4vUEwwY0wvOFRpTFY1UGh0MXFvMVN4?=
 =?utf-8?B?NG9JTjVRcUJ4RWF1cW4wdXR2VElYV3BFQzV0UTFJMlVCem1HVTh0aDFzK0NK?=
 =?utf-8?B?aWYySmNKSG9kaE4zTk9TcW1wNzdlT0p6Tm5YVllENDIwcGRjemtIeG5YK3JP?=
 =?utf-8?B?aTRBWXQyK1pkMk5kbEtPNlpYcENhaUpJL25KYXpHQk9rUDFIUGQ4U3RpZVRH?=
 =?utf-8?B?TCtPWXU5Mzlyd0d1MXZNeGg0b0dZcTRQUkRoVzFoS2FuRmt3RFMrVEczdUZL?=
 =?utf-8?B?UzA1Z3d6aGxiQzBsWUJGYW8zdTRPWXFTNTZBdi9kcWhyM3hWNHRiWVFuY2Rl?=
 =?utf-8?B?R09ObFdYcWxTd1NJMWh5aEJXdGhwd2NiSjFBTzZrOTVLRXkxd2NkMVpBY3pn?=
 =?utf-8?B?Mk9RcU1VRFBRNTRyYzU0dmdEQVZmZXV3OURUYUFNdVhFWnhwQ1dpdXhOVTF5?=
 =?utf-8?B?aU5UdXh0ZHBiekRUNlRrbk5NejArcG5DaFB0NVg0VkE1MENmNDZQRmszU2FK?=
 =?utf-8?B?R1U4dnNOWSt6RUJiWm5FWVhMZ3Q5dWVUc1Qzc3YrSFVVTkhRdU5DM3h6c2Fx?=
 =?utf-8?B?UFdwUnUwVEhodUp1Wmo2cjdvRThWR1JhTDYyaUNidVo1amtLc3kzakZ1RzJn?=
 =?utf-8?B?eVBsenZWc2FqVDFmQStkaGVBOFJqTnN1VmdCR29ycHV4WG42MERjS2VtUlY0?=
 =?utf-8?B?MkpPRXhvNkxaaHhKL1cxRU5OT2VZNkFHc1grekZJQk1KK1FzWERuQzQvY3kv?=
 =?utf-8?B?V05mUS9uR1BEU09UbmpoNEtXVGlRM1o5WnlRRTNwQzU3VzJUN1pzeUJSbFN2?=
 =?utf-8?B?bU1HZ2NoQ1dKOTR2Rnpwb3lTTXB1T21EbFNqZnZBaTRNak5BQ3RnRFRPajJq?=
 =?utf-8?B?UGFPRDdLM29ESGRVZ2VHNWZDMjRzbjYxemN4blVWY0lVSUxvUHdRZ0lUcGRJ?=
 =?utf-8?B?dm05aGxWSC80WG9PSUZCZGxUY3dUcDdoTjBPc3BLZjhxbjhjTXUwZU5yQms4?=
 =?utf-8?B?VGJKTnEvc2NqV0g4TS9FUHQ0MG9BZld0czloeFl5TVhDZHROcER0NlJqT3E0?=
 =?utf-8?B?YVRNY2ZhVVFRNnU2Z25yTHBQdzI5KzRMK3A5Z3JHYVJFcmVZUDRVVFo1TzZn?=
 =?utf-8?B?M2ZpZlg1dFpmWVA1bGtNd3BGL0NRRTIxeGFnTHRDTkxHSUluTDFwd0RURndt?=
 =?utf-8?B?ajBScUF1c2N2YUN0ZVhyV3BxL1FVZzJvSEpHRFR4b0dlZFZoVmdkSWp1eW81?=
 =?utf-8?B?NjVoYmp3SjBqZ0VrNjZNaFhCQWNzTlBEVHU0dnBJckFlQUFWT2kwd3N0YlNH?=
 =?utf-8?B?Yit5dnEzZEJ5aDdqWTJhaGkwR0RITFgxdHVIaXJ5cHJzWGt3dFovQzFDdm4r?=
 =?utf-8?B?QzVScU5sK1Y1VE55Z0tNK2E2MjlUL1VUditMYXlWUzkvOGpwQ0dmQ1V5VE9Q?=
 =?utf-8?B?WDBZNUNxOXEzd0VCWGFsclJJcUdzYzNHYlpHN1FXeUZ6TFd4MlRVR01WZWVY?=
 =?utf-8?B?dlZhcjVWVXhlVTYzQmovL01nN3lYeC9HSnNmelBkYzBCY2E2MjlkYU1IZVBB?=
 =?utf-8?B?R2tSM2hlOG03SHhMcTN0OTIyYXhZNERweGNjZmJTRGN0aDAzWFQ5REwxbFhQ?=
 =?utf-8?B?aUViOVR3MlgzQWszV09sUnVVdVBuQXJ0RVNhb0YrZGR3Q3pTeWtBWncwd0N5?=
 =?utf-8?B?azU5OU1sdU5BdVllc29oVjVvck1DdFlKRnEwYW4zSi85b25Wd3luNm5FQkNT?=
 =?utf-8?B?NjBJMFhrQWYvQzQvZ2N6cVJHcGZvSlVZekI2U1JtSlNqY0ZpR2t6WkRmdjlq?=
 =?utf-8?B?TjhCdENMY052bmRDYm50dDUzS0FnSUVlMmFsMUR2MFFtaHhSTFNXdWI0OXAy?=
 =?utf-8?B?cGYyVUl1b0RvYyt5MitNUHpMTjRYZENHb0tnV05HZHJHMEZOeU51R0x1TlhC?=
 =?utf-8?B?ZFpnNEdUS1NzUDBMT0ovb09OaHM0SzFFVFJlYkV6YjZiMkFtNEs5eWRhNVJO?=
 =?utf-8?B?YXRKcWxLNWlFS2JZS2FDdWpSN2xkWkovSUFVOElXNGc3S0ZZRmRZMWlIQWtV?=
 =?utf-8?B?ZURONHpDRDRNYk5BSlJhU3BNWC9OaGRGU3o1VmdzODlkclBnZlFHdU1Jb1kr?=
 =?utf-8?B?dDdvOWpoWUFCTjh0TDBCazZNL3BBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <353083AD103E3A4AB4E32733ABAAB2D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2728ab-2535-4db3-5e8c-08d9eb01a6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 12:50:57.3620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvMZx6OSyklyshghmTwq2VRHpp/hRHk+ak5GEUY795lq3cad9GkppguuxPiKhM4IE9Z9bhSvn0Q+dHG11uL1rabUWOKD0eYIX4oE6lQOGPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2299
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi83LzIyIDEyOjQ2IFBNLCBKYWNvcG8gTW9uZGkgd3JvdGU6DQo+IEhpIEV1Z2VuLA0KPiAN
Cj4gT24gRnJpLCBKYW4gMjEsIDIwMjIgYXQgMDM6MTQ6MDZQTSArMDIwMCwgRXVnZW4gSHJpc3Rl
diB3cm90ZToNCj4+IFRoZSBzdG9wIHZhcmlhYmxlIGlzIHJlZHVuZGFudCBhcyB0aGUgc3RhdGUg
b2YgdGhlIHN0cmVhbWluZyBjYW4gYmUgb2J0YWluZWQNCj4+IGJ5IGNhbGxpbmcgdmIyX3N0YXJ0
X3N0cmVhbWluZ19jYWxsZWQoJmlzYy0+dmIyX3ZpZHEpIG9yIGJ5IGNhbGxpbmcNCj4+IHZiMl9p
c19idXN5KCZpc2MtPnZiMl92aWRxKS4NCj4+IFRodXMsIHJlbW92ZSB0aGUgc3RvcCB2YXJpYWJs
ZSBjb21wbGV0ZWx5Lg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogSGFucyBWZXJrdWlsIDxodmVya3Vp
bEB4czRhbGwubmw+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlz
dGV2QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBJIHRydXN0IHlvdXJzIGFuZCBIYW5zJyBqdWRnbWVu
dCBoZXJlLg0KPiBUaGUgcGF0Y2ggbG9va3Mgc2FuZQ0KPiBSZXZpZXdlZC1ieTogSmFjb3BvIE1v
bmRpIDxqYWNvcG8rcmVuZXNhc0BqbW9uZGkub3JnPg0KPiANCj4gVGhhbmtzDQo+PiAtLS0NCj4+
IENoYW5nZXMgaW4gdjQ6DQo+PiAtIG5ldyBwYXRjaA0KPj4NCj4+ICAgZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MtYmFzZS5jIHwgMTIgKysrKystLS0tLS0tDQo+PiAgIGRy
aXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmggICAgICB8ICAyIC0tDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1iYXNl
LmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1iYXNlLmMNCj4+IGlu
ZGV4IGRiMTU3NzBkNWI4OC4uOWM2MmQwYWU3ODg3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MtYmFzZS5jDQo+PiArKysgYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1iYXNlLmMNCj4+IEBAIC0zNjIsNyArMzYyLDYg
QEAgc3RhdGljIGludCBpc2Nfc3RhcnRfc3RyZWFtaW5nKHN0cnVjdCB2YjJfcXVldWUgKnZxLCB1
bnNpZ25lZCBpbnQgY291bnQpDQo+PiAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmlzYy0+ZG1h
X3F1ZXVlX2xvY2ssIGZsYWdzKTsNCj4+DQo+PiAgICAgICAgaXNjLT5zZXF1ZW5jZSA9IDA7DQo+
PiAtICAgICBpc2MtPnN0b3AgPSBmYWxzZTsNCj4+ICAgICAgICByZWluaXRfY29tcGxldGlvbigm
aXNjLT5jb21wKTsNCj4+DQo+PiAgICAgICAgaXNjLT5jdXJfZnJtID0gbGlzdF9maXJzdF9lbnRy
eSgmaXNjLT5kbWFfcXVldWUsDQo+PiBAQCAtNDAzLDggKzQwMiw2IEBAIHN0YXRpYyB2b2lkIGlz
Y19zdG9wX3N0cmVhbWluZyhzdHJ1Y3QgdmIyX3F1ZXVlICp2cSkNCj4+DQo+PiAgICAgICAgdjRs
Ml9jdHJsX2FjdGl2YXRlKGlzYy0+ZG9fd2JfY3RybCwgZmFsc2UpOw0KPj4NCj4+IC0gICAgIGlz
Yy0+c3RvcCA9IHRydWU7DQo+PiAtDQo+PiAgICAgICAgLyogV2FpdCB1bnRpbCB0aGUgZW5kIG9m
IHRoZSBjdXJyZW50IGZyYW1lICovDQo+PiAgICAgICAgaWYgKGlzYy0+Y3VyX2ZybSAmJiAhd2Fp
dF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZpc2MtPmNvbXAsIDUgKiBIWikpDQo+PiAgICAgICAg
ICAgICAgICB2NGwyX2VycigmaXNjLT52NGwyX2RldiwNCj4+IEBAIC0xMDI5LDcgKzEwMjYsNyBA
QCBzdGF0aWMgaW50IGlzY19zX2ZtdF92aWRfY2FwKHN0cnVjdCBmaWxlICpmaWxlLCB2b2lkICpw
cml2LA0KPj4gICB7DQo+PiAgICAgICAgc3RydWN0IGlzY19kZXZpY2UgKmlzYyA9IHZpZGVvX2Ry
dmRhdGEoZmlsZSk7DQo+Pg0KPj4gLSAgICAgaWYgKHZiMl9pc19zdHJlYW1pbmcoJmlzYy0+dmIy
X3ZpZHEpKQ0KPj4gKyAgICAgaWYgKHZiMl9pc19idXN5KCZpc2MtPnZiMl92aWRxKSkNCj4+ICAg
ICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+Pg0KPj4gICAgICAgIHJldHVybiBpc2Nfc2V0
X2ZtdChpc2MsIGYpOw0KPj4gQEAgLTEyMzYsNyArMTIzMyw4IEBAIGlycXJldHVybl90IGlzY19p
bnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICBpc2MtPmN1cl9mcm0gPSBOVUxMOw0KPj4gICAgICAgICAgICAgICAgfQ0KPj4NCj4+IC0gICAg
ICAgICAgICAgaWYgKCFsaXN0X2VtcHR5KCZpc2MtPmRtYV9xdWV1ZSkgJiYgIWlzYy0+c3RvcCkg
ew0KPj4gKyAgICAgICAgICAgICBpZiAoIWxpc3RfZW1wdHkoJmlzYy0+ZG1hX3F1ZXVlKSAmJg0K
Pj4gKyAgICAgICAgICAgICAgICAgdmIyX3N0YXJ0X3N0cmVhbWluZ19jYWxsZWQoJmlzYy0+dmIy
X3ZpZHEpKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIGlzYy0+Y3VyX2ZybSA9IGxpc3Rf
Zmlyc3RfZW50cnkoJmlzYy0+ZG1hX3F1ZXVlLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpc2NfYnVmZmVyLCBsaXN0KTsNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9kZWwoJmlzYy0+Y3VyX2ZybS0+bGlzdCk7DQo+
PiBAQCAtMTI0NCw3ICsxMjQyLDcgQEAgaXJxcmV0dXJuX3QgaXNjX2ludGVycnVwdChpbnQgaXJx
LCB2b2lkICpkZXZfaWQpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIGlzY19zdGFydF9kbWEo
aXNjKTsNCj4+ICAgICAgICAgICAgICAgIH0NCj4+DQo+PiAtICAgICAgICAgICAgIGlmIChpc2Mt
PnN0b3ApDQo+PiArICAgICAgICAgICAgIGlmICghdmIyX3N0YXJ0X3N0cmVhbWluZ19jYWxsZWQo
JmlzYy0+dmIyX3ZpZHEpKQ0KDQpIZWxsbyBIYW5zLCBKYWNvcG8sDQoNClRoaXMgcGF0Y2ggaGFz
IGEgcHJvYmxlbSBoZXJlLiBJbiB0aGUgSVJRIGNvbnRleHQsIEkgY2Fubm90IHRlbGwgd2hldGhl
ciANCnRoZSBzdG9wIHN0cmVhbWluZyBoYXMgYmVlbiBjYWxsZWQgb3Igbm90Lg0KV2hlbiBzdG9w
IHN0cmVhbWluZyBpcyBjYWxsZWQsIHZiMl9zdGFydF9zdHJlYW1pbmdfY2FsbGVkIHN0aWxsIHJl
dHVybnMgDQp0cnVlLg0KU28gaW4gdGhlIElSUSBjb250ZXh0IEkgY2Fubm90IGtub3cgaWYgSSBo
YXZlIHRvIHByb2dyYW0gdGhlIG5leHQgYnVmZmVyIA0KYW5kIHN0YXJ0IHRoZSBuZXh0IGNhcHR1
cmUgKG5leHQgRE1BKSwgb3IgSSBoYXZlIHRvIHN0b3AsIGFuZCBjYWxsIA0KY29tcGxldGUgb24g
dGhlIGlzYyBjb21wbGV0aW9uICwgc3VjaCB0aGF0IHN0b3Agc3RyZWFtaW5nIHdpbGwgcmVsZWFz
ZSANCmFsbCB0aGUgb3RoZXIgYnVmZmVycy4NClRvIGtub3cgdGhpcywgaXQgd2FzIHByZXZpb3Vz
bHkgZG9uZSB3aXRoIHRoZSAnc3RvcCcgdmFyaWFibGUgd2hpY2ggd2FzIA0Kc2V0IHdoZW4gc3Rv
cF9zdHJlYW1pbmcgd2FzIGNhbGxlZC4NCkFueSBpZGVhIGhvdyB0byBoYW5kbGUgdGhpcyB3aXRo
IHZiMl8gY2FsbHMgPw0KDQpPciBJIHdvdWxkIGhhdmUgdG8gcmV3b3JrIHRoaXMgcGF0Y2ggYW5k
IGtlZXAgdGhlICdzdG9wJyBpbnRlcm5hbCB2YXJpYWJsZSA/DQoNClRoYW5rcywNCkV1Z2VuDQoN
Cg0KPj4gICAgICAgICAgICAgICAgICAgICAgICBjb21wbGV0ZSgmaXNjLT5jb21wKTsNCj4+DQo+
PiAgICAgICAgICAgICAgICByZXQgPSBJUlFfSEFORExFRDsNCj4+IEBAIC0xMzk4LDcgKzEzOTYs
NyBAQCBzdGF0aWMgdm9pZCBpc2NfYXdiX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3KQ0KPj4g
ICAgICAgIGludCByZXQ7DQo+Pg0KPj4gICAgICAgIC8qIHN0cmVhbWluZyBpcyBub3QgYWN0aXZl
IGFueW1vcmUgKi8NCj4+IC0gICAgIGlmIChpc2MtPnN0b3ApDQo+PiArICAgICBpZiAoIXZiMl9z
dGFydF9zdHJlYW1pbmdfY2FsbGVkKCZpc2MtPnZiMl92aWRxKSkNCj4+ICAgICAgICAgICAgICAg
IHJldHVybjsNCj4+DQo+PiAgICAgICAgaWYgKGN0cmxzLT5oaXN0X3N0YXQgIT0gSElTVF9FTkFC
TEVEKQ0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwt
aXNjLmggYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5oDQo+PiBpbmRl
eCAwN2ZhNmRiZjg0NjAuLjVmYmY1MmE5MDgwYiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmgNCj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vYXRtZWwvYXRtZWwtaXNjLmgNCj4+IEBAIC0yMDEsNyArMjAxLDYgQEAgc3RydWN0IGlz
Y19yZWdfb2Zmc2V0cyB7DQo+PiAgICAqIEBkbWFfcXVldWU6ICAgICAgICAgICAgICAgdGhlIHF1
ZXVlIGZvciBkbWEgYnVmZmVycw0KPj4gICAgKiBAY3VyX2ZybTogICAgICAgICBjdXJyZW50IGlz
YyBmcmFtZS9idWZmZXINCj4+ICAgICogQHNlcXVlbmNlOiAgICAgICAgICAgICAgICBjdXJyZW50
IGZyYW1lIG51bWJlcg0KPj4gLSAqIEBzdG9wOiAgICAgICAgICAgIHRydWUgaWYgaXNjIGlzIG5v
dCBzdHJlYW1pbmcsIGZhbHNlIGlmIHN0cmVhbWluZw0KPj4gICAgKiBAY29tcDogICAgICAgICAg
ICBjb21wbGV0aW9uIHJlZmVyZW5jZSB0aGF0IHNpZ25hbHMgZnJhbWUgY29tcGxldGlvbg0KPj4g
ICAgKg0KPj4gICAgKiBAZm10OiAgICAgICAgICAgICBjdXJyZW50IHY0MmwgZm9ybWF0DQo+PiBA
QCAtMjc2LDcgKzI3NSw2IEBAIHN0cnVjdCBpc2NfZGV2aWNlIHsNCj4+ICAgICAgICBzdHJ1Y3Qg
bGlzdF9oZWFkICAgICAgICBkbWFfcXVldWU7DQo+PiAgICAgICAgc3RydWN0IGlzY19idWZmZXIg
ICAgICAgKmN1cl9mcm07DQo+PiAgICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAgc2VxdWVu
Y2U7DQo+PiAtICAgICBib29sICAgICAgICAgICAgICAgICAgICBzdG9wOw0KPj4gICAgICAgIHN0
cnVjdCBjb21wbGV0aW9uICAgICAgIGNvbXA7DQo+Pg0KPj4gICAgICAgIHN0cnVjdCB2NGwyX2Zv
cm1hdCAgICAgIGZtdDsNCj4+IC0tDQo+PiAyLjI1LjENCj4+DQoNCg==
