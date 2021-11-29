Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582D1460FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242382AbhK2IEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:04:31 -0500
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:19952 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231967AbhK2IC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638172752; x=1669708752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mB3Tht4HYVP1cnlaLiIWjI4bf5iKl1VPyotu8TYPXWk=;
  b=wj5hfmXDuP2KJ9k6QyElVMMsyFLw/+pWVJwxHRsa6nyi8fongJhB6KIV
   TrbPYkgUomLYkLjk1I1zqYVUO3ZMU8/XcSk7XoUhhPJDqcwKxRyYTCIPy
   tQUQt3CXt0o5e1e3us3WmD6fEdCGnSjQyUPX8UjgAmv36l75x386KENoh
   Rs8mBolsiK1ll7ZjoQljW4fIasdz9for02kycoRl7BGsOl2QQKstM2OTz
   j8i93UeuPZbAll5os1gZZj7hB+ZcnQfz/QJ+w7An5gXLyjuG0bZYD7Vgu
   z1rmubn09qUx14WZajR2EUArSwNovq9HB2F/mnELLcWKaDbPavmfORUqC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="44861499"
X-IronPort-AV: E=Sophos;i="5.87,272,1631545200"; 
   d="scan'208";a="44861499"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 16:59:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/MyoLRuuv7NtKbcwQej1sLpAq4Rph9hGTPc4p8g+/Yx5/dz3mIZ4VmeJyDvUkdxnO9UfdtP5c8yx+w+Vtg8eQTDnFsyksXwK0JdRVSUU0loo8SYrbMpx4mmoWsPbap3aRkDCFDPIO+TtaZBaYvtkppJXEcpowJRysUUW+AoYN6VhmSMcmJ7wCxZa7qc6Cxim/8zeCXEOPEEa5ArB8Dc82ifL18k8zYvh9JJRVuL+vTTUS3aF7hvQavQx2PkP3fQbmam+AI+Nb5BXNjqvL4UsCmqslovGRVItuY1Spe7MdhRjVF386EZsWy6x3bdum7jaSurj4oRf0x+6hwGwTOEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB3Tht4HYVP1cnlaLiIWjI4bf5iKl1VPyotu8TYPXWk=;
 b=jiBHown3dc25/NZPVHyG19HEk0pjPy+oWEP/+10Le2EyEznR7ALR+arG1lWCg5kRBs+ajAiZVDTObsxU2gtqy22bLouiXIEoBY7WumbBPvaU4hfhiWvMt3zQQMrUb3i/X7jNBcs1r0Vn4/zy/4WY172Iql88LYnJ2YMIaGllkbAgMZdNXt5gJRnTuZSDfufpzL5nSNFWeuotvxrqipaUgwuEU84xT99w5RIOQ5BMfX4ZMBdD+2O1q8wLXRO6OWN2+/RI2IuJbOovLawL0JNkozwBIi1OzsMTpY1s6l1eRfsqk/f5lQ6Resoi6M6NDsXMpFKmOx4NQCvOKLlv4pH+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB3Tht4HYVP1cnlaLiIWjI4bf5iKl1VPyotu8TYPXWk=;
 b=KJCxX8q6gccLv3zFhuXhJZg/MeyuiMgNvFhQqpvIS7pqBLtBndPXROTNWwxYxz2U4kSHJuJBOoeftwYXZDI85Xrq0E8X2ilzJnhKtn/fsGHmI+UG68L4Xy3bKFJYIxWIamFFkLWX0LwR3AUyrdqy02MnO0fusmAFb20lIHLswxI=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB5268.jpnprd01.prod.outlook.com (2603:1096:604:5a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 07:59:05 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::2c38:ad18:39de:3042]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::2c38:ad18:39de:3042%4]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 07:59:05 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] libperf: Move perf_counts_values__scale to
 tools/lib/perf
Thread-Topic: [PATCH v3 1/3] libperf: Move perf_counts_values__scale to
 tools/lib/perf
Thread-Index: AQHX2XOHFYmvEZZi3EerXKl2255IXKwH0/kAgBIHzE4=
Date:   Mon, 29 Nov 2021 07:59:05 +0000
Message-ID: <OSBPR01MB4600E123FC87D7A27517A2DFF7669@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20211109085831.3770594-1-nakamura.shun@fujitsu.com>
 <20211109085831.3770594-2-nakamura.shun@fujitsu.com> <YZE3Ia3UpHPx2/gh@krava>
 <YZUYWAiI6HIWPhYj@kernel.org>
In-Reply-To: <YZUYWAiI6HIWPhYj@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-11-29T07:59:04.652Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: a4e0a0cd-3f8a-505c-a2ed-74cb88417945
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34e10b73-f60d-4105-003e-08d9b30e1d5e
x-ms-traffictypediagnostic: OSAPR01MB5268:
x-microsoft-antispam-prvs: <OSAPR01MB5268587B9FF3A226EC1A4D76F7669@OSAPR01MB5268.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qmlzzjJ5qI08Yul0hk1kkmaC6h4evJbBP308EW0JaKyzzZUtjINQ4vLSgtb6erMIckobsW4MyaLGcTN9ZaD+bEFDa+7dMzaDB0Uql++PSHZ7AfYtpPN/hiyYHQIks9rehXzz7HuywXq63Jn/8NGA6Ckv1g3t73jed94NrH0aC0r1h6mCe6eUw9ur2Y8TeDDsxgs7Vs/Fsuh4FmFKOgM7HhmCEb8dChXqGANEIH4TB3XVzlCJvtZolxGJAnjg0oVq4bTBDvzghQjBik5VJBtB/5eug6STMt/pDyAQDaEwcJIA5pFV82KhBsKK1x90IYijSInqgFRqmYHxPQ7BPt1/RbauVRDuToCd1A8tkNHYXTBBPiLzxugqnp8/aEYL8igVnD/x4cYI86jNPq7lIHx47OSMQsP1Wqp2YLoX+GbH71+U3WR4frIe7kYufvcB0SYlgrBT2bPzTTO1/IODkOtGF3t+3YodrSdFb04ES3Vj1X9kgFKq/k/iz57kYEYdtKdp+Nv20s92Np890nMyU4LklIXVVSUaJz7cZd21dQ3FHtyWkkn5c0qdIZqzyK6C291YUnZBrrj27Y7SBUrpBzgrTaqJbYpcKhhosUzR0qBjenjdCeYAAu56NcFxdliWmkBIZzz738lO7OAfgJtoQ1wcnXk2YD9yXtCkp3k1DsF3CPbOiYVklAlWbhx0uJEj/T7O2p1OqIo0UssI5MBqxvw65uJArtvK7Mf7jPiitkklV9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82960400001)(122000001)(83380400001)(76116006)(66476007)(6506007)(91956017)(38100700002)(38070700005)(33656002)(85182001)(71200400001)(26005)(9686003)(186003)(7696005)(5660300002)(55016003)(110136005)(8936002)(508600001)(86362001)(7416002)(4326008)(52536014)(66946007)(66556008)(64756008)(66446008)(8676002)(54906003)(2906002)(316002)(101420200003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGpBUmJtMXlnNVg4eDhTUlhFUUFac1AxUjRab0kwNlQrRFpFamUwZ2U4N0w4?=
 =?utf-8?B?Z09GQ3U1bjU5VWJ5U3o4ZkVBZjE2aGZiVzMxYmw0ZGhKNjZyYWt0VFJxZHhi?=
 =?utf-8?B?ZDRIOTAwQkloUXQycmJkTGw5WkdSQy9vdFk4REp6WTg2UkJ0N0pkeDlMcThu?=
 =?utf-8?B?TjRRMVZVcm5EVU5scVVvZ1NVZU1IZGxTdEpMWHBoanozM2k2aEYyQU5jRFBz?=
 =?utf-8?B?RFpZZ2xFemlINmd5SGIyVjhETWxtWnVJb2czRmxLNG5JVlNXN21oeElhWGJp?=
 =?utf-8?B?djQvQ281dGVaazQ5cEhCWnpsUnVIcldQSzZHV0FWcHZEWU9ZS0VTMGtRTFBx?=
 =?utf-8?B?VWJDWjVUcUFXazJHbWpKQnNxckNBb2ZvT2NER1JjdVdGMkJwUmxjYnRLRmJ4?=
 =?utf-8?B?ZEJ2Ukk5ZWtqZmllK0pUSUVWM2F0V05ZWHZNTzZwdUxMcGs0WTZkQXVsT2JU?=
 =?utf-8?B?VUpZU3VKRFlTUEhSakpVNnFMNWRzWDU2eUFveEN0QlR6RWlDYnhMTFhrZ0Rh?=
 =?utf-8?B?ZzRXdDBlWWFBaEs3WXdIYitjd0tzU0ZLbG05NEp5aG03bzdUZGxFU2szUVI0?=
 =?utf-8?B?MnFOdGVVNEQwNWZEY1MwWkZkbjFndHd0M2VJUWtmOEdpdzZiTEc4QTNGWk9p?=
 =?utf-8?B?T3dGRG4xS3BuTTFpWTlJa3QxcHJPNDBqelZESjN5TmJjdEEybHJ6bStnb2xK?=
 =?utf-8?B?THd6d2VlR2JKUFc0U2JUaTNPWEdPT09oTDJiS0VkUjdZYS9GTXdUVmFFWTRl?=
 =?utf-8?B?NXh3NkZsZjJUV1JWdm5lNFQwa2xKOExSRHZJRXRIY1J4S3ZjVi9oZkI0dDNi?=
 =?utf-8?B?Z1dBbGJmYUR4VkEzZUppaXJOTGFURlRsajJpdVg2cm1OWS9lc1pLMUt1UTVz?=
 =?utf-8?B?MGF0UnBHa1p0Z095cmF0MFEraXh6WlNSSWJVZGZBRHBKMUx4MktzWUlUbjM1?=
 =?utf-8?B?VHgzd0dwelpsWis1OUpjbFduaS96SXpMVDB5VTZQRzMvc3VPaS85elYraWlh?=
 =?utf-8?B?NGtxZFR2MFdDUnlIQ25tdFhUc3ZST1hFSFppVGx3a1ZDVmVvMTRaQ3J6UEJB?=
 =?utf-8?B?azU4M0tkTHppTmtrMlQ0WUo4aExLMFJxQWlESDhhbWhYaThTdjZ1cXdFNzZy?=
 =?utf-8?B?bTRzQVJWdE5zVjF4Qm1lZ0xya29YVlpVTlluc1lSbWJFLzFERjl4cmd4REd5?=
 =?utf-8?B?Yk9kbHFOTWU3VkFiZWhHWmRyaFpGRTNlbDMrYUxFaFdjNC84TUZyVUs1d0hL?=
 =?utf-8?B?Vit6TTdNMzdackZWd29oMmMzOFE5RDZsYzBZZlRPWTJmM2ZEaXNYOXllNjlH?=
 =?utf-8?B?cTNLRmFCK2NxVkRLVHdkTFFkUDdPS3FOdTJmY0UxRkNDdGtBOGNmWDF5bS9w?=
 =?utf-8?B?MDB3eXlwTXFZdEsvN0dFWHJtUHZjZzRkeDJaemJwZEZpUlZ0TWhnOHduTnhu?=
 =?utf-8?B?ZWF0RndDQUorcC8xM3RHaGxyTEdSek55VEtMZ2Y5SEdiMzBFdFVBMDRzYTZq?=
 =?utf-8?B?QWZJNFJENmlkZ3JselQ1UXRZOGVEc0FUQXYyYm1VUDNxeFlEUElqYk5MNEN6?=
 =?utf-8?B?aUF0ZjFMOExTU0UyR2IrbWNxWndPY2tNeDVDRUxRckVNWlVwZnJDNFdhVXZu?=
 =?utf-8?B?WmZYMkg1WWpZSGJ1QTdSY2NDa1R3cXBPRVcxQzFsNnIxSHdFcmNML3kwRzA3?=
 =?utf-8?B?Wmpaa1FzbG10a2JIc0ZhS2E5WUVMdXAxbzExMFR4amtpcjczaktBOExsd3Zr?=
 =?utf-8?B?RDVUMER5RjNxRUpjUWxUTTk0WmkzVzNCTWNDKzBRNURtTGJ5TFh4dExGOTdC?=
 =?utf-8?B?TWNPVmdzVitPQXhxTGdLUEQ1TE5udGE5dElpL2dHUk1aZ1B0b0hhZ1dOdWUy?=
 =?utf-8?B?OUoyK1VwVUpMTzZDWFAxT25sNGsyTWxiV0J0M0tHcnBxSkppT09GUnEvQ1Zx?=
 =?utf-8?B?MGJ0SitWZEJzRnhjSXRqYXNMR3cyZDg1Rlc2b05lZWxpVkpEWFZ1cEtGOXJD?=
 =?utf-8?B?NTZFQWFnSDhEbWZUWTVDZStMMWhUNlkvT08zeitQTEtOcG8zbDhLSncrclY1?=
 =?utf-8?B?emV6czk4SWxtQ05kanJjVDNOT0pWR3NtN3NlZUlYVStwMDM5SFRaUkFRSk4x?=
 =?utf-8?B?dk15MC9nVFBKb2VCZWVnMUNiSC9JWHpTWVRlZUVJV2svc0hSSWdQNy9VWHN1?=
 =?utf-8?B?Sk11TW9nT25rZU9YV3FpN0dqTnNDeExHUkFKUVh2NjRReFNJNmhrTmdnVkxu?=
 =?utf-8?B?clRlNlBpcUFwVDVPd0VpL1FpaWNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e10b73-f60d-4105-003e-08d9b30e1d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 07:59:05.1990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Jh/m5OOc8EmVit+2CkncKFzNbJGm9wJLryaU00srziqNwfFUDlc2tI0SK0Nrsh8yB5/G/lV4CJdGrgS9XHhnYO13L6kYjk0OZ8s+SE5F88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuYWxkbywgamlya2EKU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LgoKRW0gU3VuLCBOb3Yg
MTQsIDIwMjEgYXQgMDU6MTk6NDVQTSArMDEwMCwgSmlyaSBPbHNhIGVzY3JldmV1Ogo+ID4gT24g
VHVlLCBOb3YgMDksIDIwMjEgYXQgMDU6NTg6MjlQTSArMDkwMCwgU2h1bnN1a2UgTmFrYW11cmEg
d3JvdGU6Cj4gPiA+IE1vdmUgcGVyZl9jb3VudHNfdmFsdWVzX19zY2FsZSBmcm9tIHRvb2xzL3Bl
cmYvdXRpbCB0byB0b29scy9saWIvcGVyZgo+ID4gPiBzbyB0aGF0IGl0IGNhbiBiZSB1c2VkIHdp
dGggbGlicGVyZi4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNodW5zdWtlIE5ha2FtdXJh
IDxuYWthbXVyYS5zaHVuQGZ1aml0c3UuY29tPgo+ID4gPiAtLS0KPiA+ID7CoCB0b29scy9saWIv
cGVyZi9ldnNlbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOSArKysrKysrKysrKysr
KysrKysrCj4gPiA+wqAgdG9vbHMvbGliL3BlcmYvaW5jbHVkZS9wZXJmL2V2c2VsLmggfMKgIDQg
KysrKwo+ID4gPsKgIHRvb2xzL2xpYi9wZXJmL2xpYnBlcmYubWFwwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxICsKPiA+ID7CoCB0b29scy9wZXJmL3V0aWwvZXZzZWwuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDE5IC0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID7CoCB0b29scy9wZXJmL3V0aWwv
ZXZzZWwuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyAtLS0KPiA+ID7CoCA1IGZpbGVz
IGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+ID4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9wZXJmL2V2c2VsLmMgYi90b29scy9saWIvcGVyZi9ldnNl
bC5jCj4gPiA+IGluZGV4IDg0NDFlM2UxYWFhYy4uNTA5N2FhZGVhMzdhIDEwMDY0NAo+ID4gPiAt
LS0gYS90b29scy9saWIvcGVyZi9ldnNlbC5jCj4gPiA+ICsrKyBiL3Rvb2xzL2xpYi9wZXJmL2V2
c2VsLmMKPiA+ID4gQEAgLTQzMSwzICs0MzEsMjIgQEAgdm9pZCBwZXJmX2V2c2VsX19mcmVlX2lk
KHN0cnVjdCBwZXJmX2V2c2VsICpldnNlbCkKPiA+ID7CoMKgwqDCoMKgIHpmcmVlKCZldnNlbC0+
aWQpOwo+ID4gPsKgwqDCoMKgwqAgZXZzZWwtPmlkcyA9IDA7Cj4gPiA+wqAgfQo+ID4gPiArCj4g
PiA+ICt2b2lkIHBlcmZfY291bnRzX3ZhbHVlc19fc2NhbGUoc3RydWN0IHBlcmZfY291bnRzX3Zh
bHVlcyAqY291bnQsCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBib29sIHNjYWxlLCBzOCAqcHNjYWxlZCkKPiA+ID4gK3sKPiA+ID4gK8Kg
wqAgczggc2NhbGVkID0gMDsKPiA+ID4gKwo+ID4gPiArwqDCoCBpZiAoc2NhbGUpIHsKPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChjb3VudC0+cnVuID09IDApIHsKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzY2FsZWQgPSAtMTsKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3VudC0+dmFsID0gMDsKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoY291bnQtPnJ1biA8IGNvdW50LT5lbmEpIHsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzY2FsZWQgPSAxOwo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvdW50LT52YWwgPSAo
dTY0KSgoZG91YmxlKWNvdW50LT52YWwgKiBjb3VudC0+ZW5hIC8gY291bnQtPnJ1bik7Cj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiA+ICvCoMKgIH0KPiA+ID4gKwo+ID4gPiArwqDC
oCBpZiAocHNjYWxlZCkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgICpwc2NhbGVkID0gc2Nh
bGVkOwo+ID4gPiArfQo+ID4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL3BlcmYvaW5jbHVkZS9w
ZXJmL2V2c2VsLmggYi90b29scy9saWIvcGVyZi9pbmNsdWRlL3BlcmYvZXZzZWwuaAo+ID4gPiBp
bmRleCA2MGVhZTI1MDc2ZDMuLjkwMTNkNzNhZjIyZCAxMDA2NDQKPiA+ID4gLS0tIGEvdG9vbHMv
bGliL3BlcmYvaW5jbHVkZS9wZXJmL2V2c2VsLmgKPiA+ID4gKysrIGIvdG9vbHMvbGliL3BlcmYv
aW5jbHVkZS9wZXJmL2V2c2VsLmgKPiA+ID4gQEAgLTQsNiArNCw4IEBACj4gPiA+wqAgCj4gPiA+
wqAgI2luY2x1ZGUgPHN0ZGludC5oPgo+ID4gPsKgICNpbmNsdWRlIDxwZXJmL2NvcmUuaD4KPiA+
ID4gKyNpbmNsdWRlIDxzdGRib29sLmg+Cj4gPiA+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4K
PiA+ID7CoCAKPiA+ID7CoCBzdHJ1Y3QgcGVyZl9ldnNlbDsKPiA+ID7CoCBzdHJ1Y3QgcGVyZl9l
dmVudF9hdHRyOwo+ID4gPiBAQCAtMzksNSArNDEsNyBAQCBMSUJQRVJGX0FQSSBpbnQgcGVyZl9l
dnNlbF9fZGlzYWJsZV9jcHUoc3RydWN0IHBlcmZfZXZzZWwgKmV2c2VsLCBpbnQgY3B1KTsKPiA+
ID7CoCBMSUJQRVJGX0FQSSBzdHJ1Y3QgcGVyZl9jcHVfbWFwICpwZXJmX2V2c2VsX19jcHVzKHN0
cnVjdCBwZXJmX2V2c2VsICpldnNlbCk7Cj4gPiA+wqAgTElCUEVSRl9BUEkgc3RydWN0IHBlcmZf
dGhyZWFkX21hcCAqcGVyZl9ldnNlbF9fdGhyZWFkcyhzdHJ1Y3QgcGVyZl9ldnNlbCAqZXZzZWwp
Owo+ID4gPsKgIExJQlBFUkZfQVBJIHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgKnBlcmZfZXZzZWxf
X2F0dHIoc3RydWN0IHBlcmZfZXZzZWwgKmV2c2VsKTsKPiA+ID4gK0xJQlBFUkZfQVBJIHZvaWQg
cGVyZl9jb3VudHNfdmFsdWVzX19zY2FsZShzdHJ1Y3QgcGVyZl9jb3VudHNfdmFsdWVzICpjb3Vu
dCwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgc2NhbGUsIHM4ICpwc2NhbGVkKTsKPiA+
IAo+ID4gbm90IHN1cmUgaWYgd2Ugc2hvdWxkIHVzZSBfX3M4IGZvciBwc2NhbGVkIG5vdyB3aGVu
IGl0J3MgZXhwb3J0ZWQ/Cj4gPiBpdCdzIGp1c3Qgd2UgdXNlIGl0IGV2ZXJ5d2hlcmUgZWxzZSB3
aXRoICdfXycgcHJlZml4LCBJIGZvcmdvdCB3aGF0J3MKPiA+IHRoZSBkaWZmZXJlbmNlIGFjdHVh
bGx5IDstKQo+IAo+IEknbSBtb3ZpbmcgdGhpcyB0byBiZSBfX3M4LCBmb2xsb3dpbmcgd2hhdCBp
cyBiZWluZyB1c2VkIGluCj4gdG9vbHMvbGliL2JwZi9icGYuaC4KSSB3aWxsIGZpeCBpdC4KwqAK
PiA+IGJ1dCBvdGhlciB0aGF0IGFsbCBsb29rcyBnb29kLCBmb3IgdGhlIHBhdGNoc2V0Ogo+ID4g
Cj4gPiBBY2tlZC1ieTogSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPgpUaGFua3MgZm9yIHJl
dmlldy4KCkJlc3QgUmVnYXJkcwpTaHVuc3VrZQ==
