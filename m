Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DC9469264
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbhLFJdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:33:49 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:12131 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240727AbhLFJds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638783020; x=1670319020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5zQBB820hdfXrcUdZ6ULr+eg2FYE1Ge3BDO4ef+1noY=;
  b=SojcZw0mmmSE06uCTKY0Srr4r6N7zZQuCA0nrNZWFoPONuHTJZmJquaH
   9pj8x+zV1NgsZWbmWWSG12O1xrP0wmt3z4U/ZwIY6zm0KMsTxez9eUcTR
   inF9aplzBVUWLR1uxphYlAB8GlTec8J3/vqUlUVscea0qmwl8y522vl8E
   CXHhR0wYeNVkjjAXtJtjQ4IuqCs9WnSfhBuPZr8AJa/7K8n6ky8GmKYwu
   lmx8gtwFFbT/EbRFeSigo6ejD+8b7I7rsIGResuu2TdMd6dgOw9U1u5hM
   P7VHMOT4xZw8hnmSqVEcr929CnlSbgCxxLD7Ju+GWUwwlz2o+49WOZbXu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="45242340"
X-IronPort-AV: E=Sophos;i="5.87,291,1631545200"; 
   d="scan'208";a="45242340"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 18:30:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS2VWtr++wg0Y2Yx6K9OuBLveNvFFbvts7Lka2ZJYK3b8SB3BCSy7YjDvZVdzIJCId3t8hMh6wtOS7vk0oc7ywmOyS4yBgGAJ02p2iFbqzvqbktXFHUGoPUT6PX5JQVOppj80pjHqFGQFxwwDjm6SXqYQxw37Lh9YH4eeoLZVbQlaE4tB5Y4FJt5/LlZwAs6Sq+wK65copLu9m/ZV+JChdFByasF7o0d8r0ZAlc3Az+d/BU2IcSCONOCRLZkrs42NArsjVC+Y8krQrWGyIw12Lfr9+HsZKj6R87s8IxDPa9aTzjJU+OWW/JX1bEjVybL0eZCQvvtdOZ3xJVVv2Tgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zQBB820hdfXrcUdZ6ULr+eg2FYE1Ge3BDO4ef+1noY=;
 b=JA/Pi9fLTdNU59OyESsUHQeMfspMoW8OTuzJyz3Q6Kxpj/mIHZWQR4eTccWx0A2gpwuoNSHHbUfKBp9/VL5fQKeTaMyv6DcxcJs0whxKg7GQw65PNGGkfFjkZT4HSfeyc7mneV2q77Te21/v+tEEg0+YMAiccZVvgF6Scmwsl0+u1sWV5woVK4QdYn+piu+UjMMMxVoDqcW4lzLpXuZnrhDcRgFFUNkWWnrHmBuBcuY0c3BX7gLgG3WTiLGEXFWQ79Rs2mgYja3y+FLLoPza+9P+jDQR88DkyPURQYOuBoaDDdl5/ooE9lBB5n2hWvu/FGs3CKpnPhpPrATSgempqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zQBB820hdfXrcUdZ6ULr+eg2FYE1Ge3BDO4ef+1noY=;
 b=jk8+zjR9oCZk69y4M0VABTJo2lA++Y88vMPu04SnfbJ1w3NAyYBJsSYOecyYxUoE1K+0Xt9CkrjwZxAGU2sG9ET+xrFnLsbfZaj5smrMrzgH+LnBaQcZ/IBHCaYrrOXm9R2GMXkI/ikHzqesLHWE/LbFH6I77CWNR7VQv8vSsXc=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSAPR01MB4356.jpnprd01.prod.outlook.com (2603:1096:604:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 09:30:13 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::b596:877c:caf1:e443]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::b596:877c:caf1:e443%4]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 09:30:13 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Borislav Petkov' <bp@alien8.de>
CC:     "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
        "'will@kernel.org'" <will@kernel.org>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Thread-Topic: [RFC PATCH v2 0/5] Add hardware prefetch driver for A64FX and
 Intel processors
Thread-Index: AQHX0Tvqcmg6rBpliUSJLBUQh9tTC6vzenEAgAVvZFCAA48gAIAMZACAgAAVWkCAHG8kAA==
Date:   Mon, 6 Dec 2021 09:30:12 +0000
Message-ID: <OSBPR01MB203786A1B30C94950DFC50C2806D9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
 <YYP4fAgKSh4bVvgD@zn.tnic>
 <OSBPR01MB20370518F9296BA4302FF7DC80919@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YYuD+jRPUQrsmAkD@zn.tnic>
 <OSBPR01MB20375F9AC9E544FC7239A0C1809B9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <OSBPR01MB2037B293667A782CEC31C8D9809B9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2037B293667A782CEC31C8D9809B9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YTNmNGI1NzItYWRhNi00YTJlLWI1ZjItY2ZkNGRiMWJk?=
 =?utf-8?B?ODViO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0xOFQwNTo0NzowM1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf40f735-ea91-4549-d366-08d9b89b0140
x-ms-traffictypediagnostic: OSAPR01MB4356:EE_
x-microsoft-antispam-prvs: <OSAPR01MB43567427D46F030EA8517D96806D9@OSAPR01MB4356.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h+FCbGc8c5sJTT3jIVGZIwVYmVGG7RLK8AELE6e/VxAaOpmrN28RqlYQojxDok5xZ6SRU4sXrq51A9YVEx0MACkeiVZJPXL3HUubrZFBgQDMXD4+41afYhuBYYHm/xr27QXmAwowq89duGyLw0sJ0aVY+mlckztPY0wNKctc70Qbf55SNIVqua4DSNTGyZVw1gR37J/sO646P+yjEL+dPgVCf4d8H7rOALqEBE/DmscRiQcYFqEsb+olitSJtzQLdQkbQ5CyzTMyGzMHBTs9g38fpyeHJeeg93ZugWygyblgmjRLelGlup85FwtkYl3K4Xf9G9vy/9ZkCF6rJznOkL56cOsN4GmAXIItClzZwErfVuVOLbU8mz0gAG9JHiK2aUbPHZExGRAZQlLuAMQhujiCyZvDuKVMXPgDmzoRev6pgwWI9+jSATcf9BWGOeTidBjTIplBw+L9VccvtE28ru84VFuh6VdaIlSRqRES9RiBozcz8Vw+O+TbmUc9PIKrlzVHB47UJm89pubIsBMq1Mc/E+JgXkSVgTI61DauGhhyC93zKEF9TX1xBjK0QNsp4cAIYy7Ws423bA0nuFSLQmVy6aJtt8O4WxMeu4PJuXuR8+IQtpxFe7ioGkLyXjWg5nyrgEM0E5f6/nWWd83sp7wUaaqAliZfDlO7JMstm7GXsYNyoAR0C0K4UMLGfDEgsTmRVkA3K91CzUML1X4kCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(64756008)(66446008)(38100700002)(122000001)(26005)(6916009)(6506007)(8676002)(66476007)(76116006)(186003)(508600001)(4744005)(66556008)(66946007)(33656002)(5660300002)(4326008)(71200400001)(2906002)(316002)(9686003)(8936002)(54906003)(7696005)(85182001)(52536014)(7416002)(38070700005)(82960400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlVDQnZpZ3ZMRHhCM1lSMy84TmtoNmR2WVBtS2FRS3dWbDhqTWkwczd5a1ds?=
 =?utf-8?B?aXZhLzIzbVlJeVgydysrV1JtVnM3bWZyeTJJS1k3T08xSkpNTmZnUEY2MUVS?=
 =?utf-8?B?M1dyekc3Mzg3WGg3ZnA2Y05YaWJKMTVOSk1razFrY0ZURG9lUnBoWDdQU05q?=
 =?utf-8?B?MDBCR3Y2MkhaSkMxQ28yamlJeTdQL0dRc0R5Ti9mOGRJQnZDMXhyS0htNlJ4?=
 =?utf-8?B?VFdlejkwcjd1YWIzbHkzamJka2xvbUJCRFR4S0lJL2NTWVhnUnkzeURsWUxw?=
 =?utf-8?B?ZkIySHVqWDJMR2p5Nlc1MUxJWkhDdXN0WUZETXViNVdDbmIwWHFWckdIRytT?=
 =?utf-8?B?Y1RlcWN2M2xYaG9YZFBzd3FDZy9KeTBrVlB4ZjdTd1laTXk2d3ZzUDJCblBi?=
 =?utf-8?B?cnpsaU5hM1VqZGZFdDVaZ01qUTM4c3JYVWYwT3pMS05udlIvMFFwKy85MFJr?=
 =?utf-8?B?NDNkS1RGM05XaFZMSnpFNXlja2dNZXRPZ3FCKzFDOEppaFNxVWNlT3EwZUF5?=
 =?utf-8?B?cmtXN3VISWNGWCtlbkViWm1tSWQ5R09aMXRGSHRDN24xNEFPWGZVR01MWm9B?=
 =?utf-8?B?S0tZYi83OG1LRVpTZHF1V1JGVzNIaU1wYy9zeWJ5UEdNWlNaZWU1OSt2Unlp?=
 =?utf-8?B?YTdEY3I4UUc0K1c4VXp2bEpENGYwb1JsSlJPK0VxUVFDMDVFdHJKZkRQRVlI?=
 =?utf-8?B?VEJJWEIxcnVYUEZZck0xcDRVVkpvYWF6cEVwNmRTNlN5S3dCMXBkZisxbnhE?=
 =?utf-8?B?NldjTGcxbUl4UlV4UlcvVjFDMDgzTUplby9QR0RSVmpRdHB2eFduZ3FRbHFy?=
 =?utf-8?B?VndWYml4YTlLT25HOW9adHdMd29neFRaQnFDbSs1K2xFQXlWbjVzc3pyR2hT?=
 =?utf-8?B?ZVlLbHQrT0pXZmFtc2k0SVRSaDgxSmc2OGVYdlBxMS9SM20xMEZEbGljYkFY?=
 =?utf-8?B?SmsxQlM5L2l3THJvcnB5TDJQYU13L1RSVGZOb2tEWkFTQlhsSUFLVllWdVI1?=
 =?utf-8?B?TFo5SGxRR2ZwbnUrbnpFWXBQZGVKMDRIWFZlYXM0RW1aeG1YdkY2U1JBWGMx?=
 =?utf-8?B?aGxxcUNpY2tEbWVoLy9sY3Q0anQ1c3IySmN1Q1pNYlMrYTBtTVJNZVdncTF0?=
 =?utf-8?B?eHFidkpROEsrbENSUDJVREZ5ZW52VldlQTZKVElDVTZvTkxHamVOR1Frdk5r?=
 =?utf-8?B?Z1dubzYvU1hrbm02ZGplQ215TWo3UFNzOUxxT1k0RTgrUFdHa1c3YzZyc2Er?=
 =?utf-8?B?WmgzTEZOSTN1VStMRFlpTFIyeDkyQmttTTJpYy9rcGRMbWdwVlNVMjNWVlpX?=
 =?utf-8?B?ZWtSQWlZeFhXNXZkMGZZQXhqVzBXZjNRc090YWJTZkdCaXFVNzN0dG1teWw2?=
 =?utf-8?B?NXBrVEdReDZTaDVpRFR0YWtOdXlmSVVTWDlLbkh0MHhyZ1JtMWNhTVp1KzI3?=
 =?utf-8?B?TXhIZlp1QURxS1NHK3kxOTh4ekEzQXRtWFhVbXBDbTJxTTlPTVJPZ0ovY1J2?=
 =?utf-8?B?eFkvWDVlWnZPb0ZLMG5Bb3RGNThEUFhFTFlYSHI5MSs5M1lWYWJrd29LcVJN?=
 =?utf-8?B?NEZBdnU4Umg1MmhybCtmdTE3c0I4RWVGTE5EQ3lmZVFHSXlmbURZYUM5VnNY?=
 =?utf-8?B?U3QrTUhhbm5GaWsyNS9JQnVwbU4rendSTS9SNTY5OTJYSlFBVnQwa1p5YnlM?=
 =?utf-8?B?bmdIWFZwRFFkclR2M3EvSDVoaWhEZG9ISWJqTWlXc00rYmhGRS8wbytKZndP?=
 =?utf-8?B?N2lMdW9VZ1VMV1d0TUIyV2VkMExCaXlsRU94QnJnbnloZVVBN1JwY24ramQy?=
 =?utf-8?B?NW5JUzNZNGpLRTBzNEx3aWI2cjIvOXJ1VENYTnArSnlDU0djc3p1WkRtaC9l?=
 =?utf-8?B?Kzc5UFRYNEZabDhDMFBXeTRhck5UZ1ZNVUlKbndPZTRZUWh4NXptcUdqT2Zo?=
 =?utf-8?B?dG1jSElscE1ZK2c1Wm1SNEtra1c2eEx3RVZTY2Nva0pRKyttYjFESzVTNGNh?=
 =?utf-8?B?NVdjaGZNTVVZaldHQTZsbktkQkorOHNVaFNtTlhQOGU0THZuTFdCTmI0cmxB?=
 =?utf-8?B?RWJNMDJqK0Y2aDhCY1RCdHBqdFBtN1dtcDBIVjBIbUlOOVl6dW9uWGhHL0pF?=
 =?utf-8?B?NWFhSDJ6SWI4TTExcXBnczJYdlpTYVVlQlhHWmpETThYRElRM0d2djk1VmtN?=
 =?utf-8?B?TXBYREFrVko1dXZyaDB5L01hOHVxUXNocG0vZm5QNDZLTWZVOURhdGdtSTZ0?=
 =?utf-8?B?RUttSEwyVVdYdDljUkJtYTZaOEVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf40f735-ea91-4549-d366-08d9b89b0140
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 09:30:12.9634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5CDFP2HnxwFPLNFhW3bBDWa8wXxQmXCndtosfszx2ef+bK3I8FYcgy3FhAkytYnYcmR5st1lXB+EB+QvpZ9wvh/PZtbOPhu4RhlQoMYgmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4356
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gQWxzbywgYXMgZGhhbnNlbiBwb2ludHMgb3V0LCB3ZSBoYXZlIGFscmVhZHkNCj4+IA0KPj4g
ICAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUqL2NhY2hlDQo+PiANCj4+IHNvIGFsbCB0aG9z
ZSBrbm9icyBiZWxvbmcgdGhlcmUgb24geDg2Lg0KPiANCj4gSW50ZWwgTVNSIGFuZCBBNjRGWCBo
YXZlIGhhcmR3YXJlIHByZWZldGNoZXIgdGhhdCBhZmZlY3QgTDFkIGNhY2hlIGFuZA0KPiBMMiBj
YWNoZS4gRG9lcyBpdCBzdWl0IHlvdXIgaW50ZW50aW9uIHRvIGNyZWF0ZSBhIHByZWZldGNoZXIg
ZGlyZWN0b3J5DQo+IHVuZGVyIHRoZSBjYWNoZSBkaXJlY3RvcnkgYXMgYmVsb3c/DQo+IA0KPiAv
c3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUqL2NhY2hlLw0KPiAgICAgICAgICAgICAgICAgaW5k
ZXgwL3ByZWZldGNoZXIvZW5hYmxlDQo+ICAgICAgICAgICAgICAgICBpbmRleDIvcHJlZmV0Y2hl
ci9lbmFibGUNCj4gDQo+IFRoZSBhYm92ZSBleGFtcGxlIHByZXN1bWVzIHRoYXQgdGhlIEwxZCBj
YWNoZSBpcyBhdCBpbmRleDAgKGxldmVsOiAxLA0KPiB0eXBlOiBEYXRhKSBhbmQgdGhlIEwyIGNh
Y2hlIGlzIGF0IGluZGV4MiAobGV2ZWw6MiwgdHlwZTogVW5pZmllZCkuDQoNCkFueSBjb21tZW50
IG9yIHN1Z2dlc3Rpb24gd291bGQgYmUgbXVjaCBhcHByZWNpYXRlZC4gSW4gcGFydGljdWxhciwN
CmlzIG91ciB1c2luZyBjYWNoZS9pbmRleCBkaXJlY3RvcnkgYWJvdmUgbWF0Y2ggeW91ciBpbnRl
bnQ/DQo=
