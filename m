Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7810549B4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575602AbiAYNKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:10:12 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:9259 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1575290AbiAYNG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643116019; x=1674652019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LJ+Gqska3Pn8OU1O006tpxevr0TxQPIG4nObbGDwEtY=;
  b=fU2Jw5OG4P8QPhYFWCMNNH5hMuKngFNzEfMDdEKSro7v117UON5bROVb
   BhBiqKopvWjC97aATlPwf05Cjxc1Uj1vnjWo6RFCCZLqKdydXq4gWuz32
   4TLSsG5Fj/2lPT7oA1vtqUnNoIu0/VM4qKqiVKPl3OK7MpwPPKvYFeE3v
   BeOvC5dtr8CfxTv4oNNRY2lW2q1h9XhRgL/8p5xdSJ1cpFaHaj586Ohpi
   lsIu70KLv0pCGsNSrQ2D2YQ9O39iT0j1zs6CnDxKBpSJRZJMjS9GyB8c7
   7oSWsOi+tuacFyyxNp08o6CxxrS6T9ivzRrLl7qvx5OT3Bt0K9+RZmWwe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="49337454"
X-IronPort-AV: E=Sophos;i="5.88,315,1635174000"; 
   d="scan'208";a="49337454"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 22:06:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcOz9SdlPjVFvCfPx8cdoS9oPBS/WMpbfkTPrIYc+NUu53i4IGgafIyDqB9Q97RGXIrTluNmoHtzqEQYg/cl2vu5WUkovbw/hHRqUyREzLPwLvg6HsMlJGb6tPQb8nWddA6/vpTf63XLEMjig5fXP/c22Mughvjdd5W1sjwcM26xfZAAdk+4DYcZVQDVU4jmoohvzFS9NK7+v6XN1dvR+iFRtfqAxJSIVRIGYMR/4grSkOmBHMzOZQDD025UT3C60HRii3wdWQKU4aR+qKGhzjNyfwoTHrvaSDIVcsXav6aF53K2NeZuiRAqPb02887g8TCESU1uo9atJZmLKUIQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ+Gqska3Pn8OU1O006tpxevr0TxQPIG4nObbGDwEtY=;
 b=hebhjta3PmPNWqCWv3SD59sqONN/FRWEf0rx2LBE0SLt7HjdBwBdVO0MWoekzo/XiC16qt/0pHUnXGgUMH+o+hpLVw7k67hdSUg51kHtgTgD0RCjNMOktfqZu705lYNe1dr6RFAhiSZb65sJdlscC2WAo8l6so7KJk1i1BDmot4i85r8dgJrUpEbRPcdbIVEpq/WSVTFTk+V9hfm3rpdRLKaesgBczxcopPkU5dMSBD9MZaxSyi4dZF9Mq0slFE+JLoaqPD+t4UDdHj+bmRnbwVCyQuGK28IlTZgVb5dRImr1/X1NDAQwZfhf7DXFVIg6LBqyH7urJDtQ7O/TPtoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ+Gqska3Pn8OU1O006tpxevr0TxQPIG4nObbGDwEtY=;
 b=nYjJKc2zi4GHpK0uQgFqAXz4zmIwnURnsAFgy5UJUIYZuoG91+nvCoXXZCgBLq9EQthiYFfiEocdZMvt+ruZV0bUcfNPi8qQtBXq2lUSY4qvrYh8o33BZnhTm6qF8bH89LlnvxWbA2O9hIF7Qqhh/j7X3TKEJcWzLWXIJy5d9SQ=
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com (2603:1096:400:a2::7)
 by OSBPR01MB3109.jpnprd01.prod.outlook.com (2603:1096:604:1f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 13:06:47 +0000
Received: from TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::a969:a685:8804:20e1]) by TYAPR01MB6507.jpnprd01.prod.outlook.com
 ([fe80::a969:a685:8804:20e1%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 13:06:47 +0000
From:   "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Thread-Topic: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Thread-Index: AQHYBKVl3QVmCewphUe4SBvooFofu6xzugqqgAAMboCAAAhAVg==
Date:   Tue, 25 Jan 2022 13:06:47 +0000
Message-ID: <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
In-Reply-To: <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-01-25T13:06:46.209Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: d01d11c6-35bd-c0fc-e9ef-5191bc837731
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78fc78da-40cf-4621-fa12-08d9e0038b33
x-ms-traffictypediagnostic: OSBPR01MB3109:EE_
x-microsoft-antispam-prvs: <OSBPR01MB31098DA0109EE3274040DC10955F9@OSBPR01MB3109.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWevhFGWNx6VG77i/lW9JxEX5s1MuqcQoeItilgbDgxgAsHM9jfb5d9QX9Ogn35S493ZWpziFhHaIdGWJpdbNaTdt6mivx0isoMAe65h3sSiOC6EeAxOWHuiQeQDSWmQaILtRBVYxR8y8zT2Q7im6aZl1mIIXBT5k4iP6HTWQKgTEdh+NsZAiRyvWl1NVAI3tpXOp5pB2b6a3nDSCdgisNTVzQqbKfMA3Oq41BNCkXfWtPB70uXirvc12iuRB2nkeZeM0NvY2+IeHpu9dQBCybWH4Vx1AWmqmoxf9HqlAtyHIENfVuqZs0rUn4+Ckti86WAYA6QDkL9ZL98DB0ZfmpF86KHfwlX+qz1BvsE4lwZBIg61ezwQLnPXfqJj68HeDva1USrl1Q94UUs1TX24r7yIHukIAW2rcr2Pkt5CjEs1OboB9WUXV0mVgPXHuUtWChXUnHNFabUh06eBy0XuzHOMZK41Hw8AXPDoNCGdCvuU/8i2kC8uZM3hQKx718txkpUhghcOrSRhgzrxLYeQ0DLTOVEtfM+xb8X+M0/JtIiAyxB1R0yyCI9RQ51odounjEQo62BIhtiBqXlnROw2KR1U1dtioW6VSPxNZqqYY+EdfdiC2aoQriJeCzkl0tBWr1TXPd+D3VXgh2nG5E0o7BumCGYw2Ee7OfkzlUbOHC6Gn4qVMTpA+FcHvgSP1qQjqE/D2rlCJeH8W1pB7h8s4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6507.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82960400001)(122000001)(9686003)(66556008)(38100700002)(38070700005)(71200400001)(33656002)(508600001)(6506007)(186003)(52536014)(85182001)(54906003)(83380400001)(7416002)(4326008)(316002)(66446008)(64756008)(110136005)(5660300002)(66946007)(2906002)(86362001)(76116006)(107886003)(8936002)(55016003)(8676002)(26005)(66476007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?U3BkUVFTR1pRdlEyQjgybjFJdmJxWkZTUFYvTVZlcTlKcXJGS1YyRytq?=
 =?iso-2022-jp?B?ZzNVZ3ppajQ4L3RrRmRJTXgxVnNSQjRNY3k3TTJPTWgvbkdMbklxaHJ3?=
 =?iso-2022-jp?B?Z3N5SGRPSjRHU2FrbFhKTU1WVHpzVkdzYXgwYWFsMjNhSUlzcGR0MjN1?=
 =?iso-2022-jp?B?YUErRnNEK0w3REE0ZzB5ZXFvRDg5UDk5TUczeUpNV3k1WW9uTno3Nzlt?=
 =?iso-2022-jp?B?ZnZDQmg3V1l0cGFtRGcrRklVT2FoTThmeDJSTnI0anVRNGw4NkRwZWI5?=
 =?iso-2022-jp?B?dVcvS1FaaGZLM0IycFpwZHFNOHA3c2VDeVJIb284R2hhV29mNHVId2c3?=
 =?iso-2022-jp?B?c2ExMlZkemM0ZTN3Z3k2OFpOMnU5Rk11ZUx6RDk0RkNFbmFPUWVZeXFI?=
 =?iso-2022-jp?B?a25objZCZ3pRUVd3UlNvelVzZ2o0T3lSbTBrVzJUd3RXRkNPY2J5OHBC?=
 =?iso-2022-jp?B?YWhNbHN0TjJzKzdOci90TS9yQXZLR1JseVEydmxENUk0bmFvZ3RZdHVO?=
 =?iso-2022-jp?B?RVVuWEJZSzhQVTRZcml1UzR1cDhEWmttTlBaTXZBQ1dKbEdVUzIyL1Vq?=
 =?iso-2022-jp?B?Q1ZJSFR1NWRmZ3BabXoyVm45azd3cllTTS91WDU0NmhQVXlrWVM4LzNS?=
 =?iso-2022-jp?B?M21GdjVsOVJrM2RldjVVM2g5bmpGemxUcTYxU0w5SHRNOGhGY3JSMDRS?=
 =?iso-2022-jp?B?dEV5YzJoWHB5UnRSZm1ucGVqWDVJOTVRZFJXS09HSlR2U2hBdXUydFQ5?=
 =?iso-2022-jp?B?LzNUZERPUW1qbU4zeEZ5SlBaNi9hN3J1a0FBVlFNNFdJSWJFNnRSZGNJ?=
 =?iso-2022-jp?B?WUhzWElKWnFUYktyV0pLVDh5UkZrai9kMS9QRHdpKzUyaGVob1VVWnpR?=
 =?iso-2022-jp?B?czBiSUJZRFYxSUU0VUlZR2dPYVEyTFpYRkFiZGdENlhXWTc5L2IwYlM5?=
 =?iso-2022-jp?B?RE5FTDY1K2FybkY2NXJGN1ZYWFlxQjE2UXNCMEFMRStHcDdBajBBaTVQ?=
 =?iso-2022-jp?B?NFlJRGU3cUZBNzFhNXVVMnd5aU1hU3dCSkNrUWNQOUQ4UFVSTUVycGxk?=
 =?iso-2022-jp?B?OHZxZGp6c1VQNnVkNEZiT2M4d2ZWRVk0TDZ5eng0NmFuY0I1VW5nTXQ3?=
 =?iso-2022-jp?B?MmptcnhaODFzK2M1NCt4QkxWU0srSjBRcVM1aUNjZUMxcU1XNmgvakx3?=
 =?iso-2022-jp?B?citlN1FiRmVVVzNtSXNkbCtwSTR6N2grVE1ZakZnMFFtdlQ5SlMzMUVw?=
 =?iso-2022-jp?B?dFVWWjRWQ1BLdnVrRWl0aXFGRkdCNXBKT1AvQWZPaW1HVXp6RUIyWjFp?=
 =?iso-2022-jp?B?SWVUd25HV1NaTEtkU0JrK2lic0gvN0NYMTFoR0VVNW9ibXFzVmRNam5H?=
 =?iso-2022-jp?B?Ykh2S3hJaUVSbm5qMCtvWCtvNFh1WFRhR2VvS3ljNEVidVEwbTlGdjlw?=
 =?iso-2022-jp?B?QTRjcUdDZ2cxWVBlK2FqblhPM2tmNkNzNERkWUM5NDZPYUZzTEZFMHU4?=
 =?iso-2022-jp?B?ajQ2NHZjdGhFQjh4MnRlNTBHY0VJUzRjU3YxdXpuVkRYTGZsemFHdThW?=
 =?iso-2022-jp?B?WVNXdndVRHV3UWFyZWlIN1ROT0I3ekNzSjNFL09CQ2xsWUlGNmd1Um5p?=
 =?iso-2022-jp?B?a1AwTWF5OFFNRUFNUnlJT0cwTGdpK0pEQlV6bVltMWVqR2x4WHIraUpH?=
 =?iso-2022-jp?B?a1FrNStXYXRuRDVESld5ODB6Wm9oTkpKMzdsd2FQcGFUSzE5aWVGWHZE?=
 =?iso-2022-jp?B?N0hQelcyQUZRV0xTa3dEaHd2Y3paeDhIOGlNZmR4Q3lQZytMNGt6Y0l1?=
 =?iso-2022-jp?B?blJtbXlVR0F3N2RHdDJ2TFhQU3pJcS9QWG9CQW9RbmplOGNtWFhWVzcw?=
 =?iso-2022-jp?B?TXZ6enA2Vm12RFJuNWd3Vll1MnpHOWhUWmJROStoYlpmMSsxejVoallD?=
 =?iso-2022-jp?B?cmc3ZDJldVJwNC9zTlROU2lwUlpEYVNKQnMwSTFVWGlnWURNdkEvNU8r?=
 =?iso-2022-jp?B?YWx3SmNJRjZYTExsbUt4U3U4ZDhGQzdtZXlteEgveGt6aHllSjVxbTR1?=
 =?iso-2022-jp?B?RGpKVCtpWE9mdnFmZDk2OVA5d01GbkQ4ZWVWZGgrSmtYRHpyelM3Nzd3?=
 =?iso-2022-jp?B?TXZQZEEyeVcwcitMNkxTUmFvdXRYOVJhWEVUQUFUQVlQZSswcWxaRnN3?=
 =?iso-2022-jp?B?aGNTK2hkbmxJVTREWWlyYmFuc0loZTVpOVg3aCtTTEhWZ0JUR1Z0bEM1?=
 =?iso-2022-jp?B?SU1HNmlMNEJIcndSTVRWUU95WWFaRzFMdkIveVd4eWplSVk3b2VFMUZo?=
 =?iso-2022-jp?B?ZlRMRndoZWVKK2dXSXRjZmJSOWxBZUhNRWNUWHMxL2xkelpiaFBIc0Zv?=
 =?iso-2022-jp?B?N2szZVdONHJFc1lsWUl1VXVDbzZqaGlFQjBPd0lrVTJ1NG5IMW05UnpW?=
 =?iso-2022-jp?B?U3lsZ3dnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6507.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fc78da-40cf-4621-fa12-08d9e0038b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 13:06:47.3806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yih2ISJejtRRxDSgDSubZC6PjHDkmwIKsnLaBN0kqLpQQCMNAptZ2QETDMWjqyqqFshy2xe3zCyOwAuOEttyVCGVU7fyw+/ZjUcKaGwjR9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, thanks for the review. First of all, notice that it's very likely=0A=
> this patch isn't gonna get merged this way, we are considering a=0A=
> refactor that included 2 panic notifiers: one a bit earlier (pre_dump),=
=0A=
> that includes functions less risky, as watchdog unloaders, kernel offset=
=0A=
> dump, etc, and the second panic notifier (post_dump) will keep the=0A=
> majority of callbacks, and can be conditionally executed on kdump=0A=
> through the usage of "crash_kexec_post_notifiers".=0A=
=0A=
But the pre_dump cannot avoid calling multiple unnecessary handlers, right?=
=0A=
It's more risky than the previous idea...=0A=
=0A=
> Anyway, I'm curious with your code review - how can we use this filter=0A=
> with modules, if the filter setup is invoked as early_param(), before=0A=
> modules load? In that case, module functions won't have a valid address,=
=0A=
> correct? So, in that moment, this lookup fails, we cannot record an=0A=
> unloaded module address in such list. Please, correct me if I'm wrong.=0A=
=0A=
For example, how about simply maintaining function symbol names in the list=
=0A=
as string, not address.=0A=
=0A=
Thanks.=0A=
HATAYAMA, Daisuke=0A=
