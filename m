Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05646739D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379269AbhLCJEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:04:20 -0500
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:34393 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234861AbhLCJER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638522054; x=1670058054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OR+CYH00Vdawiqk4bo8yKynT6HSXV2kShoPUvXkeM40=;
  b=XfxmdUmym+p/ZMoeDUanJHcjZU8767gTqNYRoTDqIxfHUoAc1EP+qdlU
   6dsUsZArJyfdRqx7A+5rKMq6eB1s2WZ+1RJ4w5mOOoxRqVXtyTUBVKzOu
   l2gc8uRCGe283aNDYSSOBpjdRZhlWz73dtk9cTY7gNSJig890ZVQ+xXn9
   ipRrOfH7R91fWuyB+T1OWgc1dtz8EPlV8CSFpB99YJHYXCImA+9OpdopK
   X9K/a6MELhMQh+9ERgMucO7bUVtjGGF/sBrEaiscv4yAv+XZKhjc3D0xL
   TOA62KG8qHLE6ZJtBPvCBxAuU6oGq6iF7uX8Vf2GOoj7HV/+2bbCIUpQR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="45148762"
X-IronPort-AV: E=Sophos;i="5.87,283,1631545200"; 
   d="scan'208";a="45148762"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 18:00:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9YYQM2m1qxoZrdwPyUOjimRDof9B5pXD05ow7Vyl5nCdoFJqj/JoNh7+yItmUxVrGK1N8wwqSlBS4zJHmxiGDvlCMNKL7su6siCRrOzR7t0xU534lDBcVt6a/fYJF1E1jeZmVbjQqQ9tgSSbyuu3jjA7uZXmvn2ai3bI4NAAeYcJ3sd9l93rGKF96LsZGYh7D4A97ml4R8CLGCmTySYlRaDt+MbGUt1dA2eMX6SsadcIsfRF7idagiVYPcrvh1s8cw2lvu3e0WrMgkUyVBl1SNpHnvgxql1xo7ctso/iGwRTEnCkG5PTS/FkQGGALzYrPA8blEILmSriSMr2+g27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OR+CYH00Vdawiqk4bo8yKynT6HSXV2kShoPUvXkeM40=;
 b=egOlB8n35miLwwZ+CtZ/+TWSOcIUzLwO0W+rha6IyIZVx6ujdMIy1r/V4oGg/YVX+4r38kEz2B1bpXfw6TeYImSb0obSKPsTxj+8vw91WSyQgVDFuEb97nYUfqYKfv2B89oS/4IMBqSWtWuD04XU1A1Wzwu/WiDaY9XVH0SnQg1aHgWIAx8hw4/qhDgCOvBPL6dXMCRve07hIidybPrs6Tcc/uhIsdmUGH3MX7kjbucedas+O+Lo6hTWihqSW77KBE1B57xLWT4dnG8WiQSAO8XGkrO4XvwhHtqqfRJF4IfCTY+xYmhbxGhK3azWn4meVukid0RC1jny4A23C+JdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OR+CYH00Vdawiqk4bo8yKynT6HSXV2kShoPUvXkeM40=;
 b=K5HvEH/GE1s3HFC/W8a7YDnRkqJanO/6UjXuvGypkEqigTrLDLH9d0JBiommdfDVo+O211De0VLAzDzIF5HnfCS9Jr9wQDp66j4nqijvv8ckJ33dQT8K1eJekNpqNABq4flYEb8VHRBgGvUbcOFmpCR53xImInZZUYCAeMtha4E=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS3PR01MB6135.jpnprd01.prod.outlook.com (2603:1096:604:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 3 Dec
 2021 09:00:46 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::2c38:ad18:39de:3042]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::2c38:ad18:39de:3042%4]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 09:00:46 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: libperf: lack of interface
Thread-Topic: libperf: lack of interface
Thread-Index: AQHXnxU1v7C7yDhEy0Gzl7rxTcNZhquPLp8AgAE//ACAHexCH4AqXPW2gANjt4CAArnVuoBCHup+
Date:   Fri, 3 Dec 2021 09:00:46 +0000
Message-ID: <OSBPR01MB46002D1F64E2349CA9E742A4F76A9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YS+B6PVHtiTmqZS+@kernel.org> <YTCOVGyffe+VwL6G@krava>
 <OSBPR01MB4600E7C8C79D64125270D034F7A19@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB4600A616AD3341EAF6AA3DE8F7BC9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YXAJhTC9aqOS/GWy@krava>
 <OSBPR01MB460067F4CE80D8EF6B707D4CF7809@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB460067F4CE80D8EF6B707D4CF7809@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-12-03T09:00:45.453Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 3d7557ce-924d-2af7-d211-b5f1f945440e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4207dab-47e5-42f3-ff17-08d9b63b6502
x-ms-traffictypediagnostic: OS3PR01MB6135:
x-microsoft-antispam-prvs: <OS3PR01MB613520E0E4F41568A5177763F76A9@OS3PR01MB6135.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00mTCDiTe+pkfQs6NJcdB5HyEarb+AxqppqhId9FFPNKEMHtJhJ+dNFKg+RQ4TMaHyRWzJYzrt7ECSiQwccHZu3NTvxJkId/TOKCnwurmbIiiUcmkdafqgvhdWxmNRs+AaG4anh4X4j05fcs3BIRnJ1VPt4unWtRCeBDDY9ZMUrrXrKTnOFsr1bNyFVdvxOjOCC7RFtxm9j/dJJEsrEezrNo+0H673/ycOiAPE0ecmq9om5Q3+ClM8yFaqrV/ojP8LjG5LbhC/X4MBTy1ZnrGmvHLy4Nhud4p5w56hXAsFoTpP3AegLYSTA1gI+/NzX/8VO6C2yNhGwTAt4mRlh13FAqygdqq/hHKwfKiPbH3bWQ2np6TSMvG7c/81bYiKRZzwTL6QJaktJvF6EyvYqcGo9DjEqhIWtIwTBZ2QsFiTjIxs4oukTcwb4gLnHzU8MiVYADx9ETQgNUhoXrR5mrdf79nWdH03KRhsC78+FnPdktpKrjjHkJZo1pT1kBFODq4rsaAA4hCOUiZaQUIWCZBQew4U0TgzFOdPCEloCkgq/GErRkOP3D3s8iZiOCNG2bnVPOmuphmJ0zkNvK2x+h3jqxRGFG7pskVQ1+HbKhHPofJ3lXrHF13bJpx+mN5K+W32YHkioJ1lFVgNIa55b2peyCTPBxPo3TqB6PRHoZCbBB5wilrl1XaMrHzkngF7s5ipUXI0cTzpueJs6FFf7Jkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(26005)(4326008)(186003)(86362001)(122000001)(2906002)(85182001)(83380400001)(38100700002)(55016003)(38070700005)(6916009)(66556008)(54906003)(66946007)(8676002)(316002)(7696005)(64756008)(8936002)(91956017)(66476007)(52536014)(508600001)(66446008)(76116006)(82960400001)(6506007)(5660300002)(71200400001)(7416002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlkzVFk1d1NCejFsQWxPUjVJWHdndWZkdCtJQ2RhWkZtcGdWaGE0azIyVktt?=
 =?utf-8?B?aG5NWDdwZ2h6d056WmNwZHJsbjgwWklCR2hYNDlVdElwOHhEM2JhZ3B3aENt?=
 =?utf-8?B?OXlaL3hOSkFIblE3R2IyQTlNMVBNcTdWNXVneWZDUEpQSFE3bE9LWGloeVZT?=
 =?utf-8?B?emR2RlBSMTZlVi9BVjVIYUxtR2NTUVRmMzNQNncxMkNqNzU4K0RPZ1BJVk0v?=
 =?utf-8?B?UE83L3IwYitRdXRHS1I2UUVueStHbnRCZlNsRU1ldW1CREFUa1FpL25ORERU?=
 =?utf-8?B?TU5WV1MvTWEvWGMvcmNseGJwdWN4eStlSUVNQ2NIc3lsUS9ERnh3WU5aOFYy?=
 =?utf-8?B?ejVlZGltbjROT3ZreXJUT0N4ZGxvVzllSjlCY2xPZkU3SkNCQVFIRkhJQXdy?=
 =?utf-8?B?L3p0YVdiNnFNL0hnemRTYStZSHJ6WEdoWmMzS24zR1c4Yks2MjZ4Z1orc3FO?=
 =?utf-8?B?M0hCZ0RJYUQ3QkxpUTJhTUFoQ0s1cER4OGoxY25sbXUyOXhjYVRSV3YxWXBV?=
 =?utf-8?B?UExzQ0FtRzQ0djV5ekVhR2ZiR2FPNmM3N1pvSXVvUW5VNEI1KzRtbkJyRXRK?=
 =?utf-8?B?MnFiblRuR1JtRkhrcXdyN0lUS1pxQnNNSGQ0TmUvTzB3ZGxlcFk3UFZXYkt5?=
 =?utf-8?B?T0lnZ0hQaTdOdmxTQmlCbHVsd3YzWGQxeW9TeUYrUkpXckRzMVlZNVRvbXhT?=
 =?utf-8?B?Zng1T09MY3F1dURCekVUT0Q3djB3RGIrYTUrSXI1ZytiYTY5anUrOVE1b3h5?=
 =?utf-8?B?QXF0RzdsQjVCZHh6UlpNS1F1eXhUblc4dE9jZWhDYlEzbW9qV1MwK1BnL1pt?=
 =?utf-8?B?OHV6bXBpT3VxbFl0aDR1S3h2ZjhUbngzbDVIZThEcDRYbmNBSmZ1R3lyRmJ1?=
 =?utf-8?B?VmtLb0FvZytKSC9tVG1Sdy9UQllPODNYODR3OFpKNDBRUU1OUXhwVmdrYWth?=
 =?utf-8?B?YUI0aDR6UkluRmlPMjNaV1JSa3hVWmJLTTdxV1B1d2o0Szl5MUJaS1V1R0RO?=
 =?utf-8?B?dDZBbUQyOFB6NjFNWVdkdU1wZk10alhyNTh5ZVFkWTd1dVpmcmFpVGhMS0Ry?=
 =?utf-8?B?YWxDSkVGOWRwZE0xT1NFVlZXYTZZSmdqNDRzQWV2b0Y3RlNTRDM5VnJKMjdw?=
 =?utf-8?B?VTdkS1BLUnZBK1M2UVBVcHVIUE52MkxkTGd5Z3VLM0pGZXZIMHpObmdiQk13?=
 =?utf-8?B?emlyeEJFTEluYUlFYjBUenptVVVuNXQwSlo0WE0yZktJYms5MEJUMTQwbmhn?=
 =?utf-8?B?U2poYWtWSGs1eFQ5RDdtN2liQ3AzNnlpTFZvMkI0c2pGTXlzZlpzTTFrQ3Fx?=
 =?utf-8?B?VmcyL2lPS0p4cDQ5Z21aZ2h3V1BlOVE0VjlGVTk1ZjUzVG51T3Rmc2xSSkVm?=
 =?utf-8?B?bVpxdkY0cGxZcExFY2dDcU1OTFBnUlRLM0VxN0p0RjBtelNIeWVDcUJ0TURH?=
 =?utf-8?B?UkdiZEFPYzVNcUs5MWNYTDBMYW9ZNWFNWWtGVXlVczIzTGI0WDlUL2pYc3V4?=
 =?utf-8?B?clByWkZSUzRPcklYaHdNUVZXUjUyWHZlZSs2QUJBSHhhN2wvazV2U2xTR09P?=
 =?utf-8?B?clRPaTdWSWtudFlMNyttSk8zYjdxbW82S3NTSFRudXR5TmRDc1haRVR5ZzlU?=
 =?utf-8?B?eUVNR3p1eGhBb1lMM29WZ0NOcHJQYTFvZEMyMlE5Ry9jSEYrQUJzVGdBMHpI?=
 =?utf-8?B?Wkx5OWdjMFVQSEZIbVVYejNwYXI4OEVpcm1yNUlORmFtNk5vOE8zN0o5MkV1?=
 =?utf-8?B?WEpTSGg0SGJjNndIZ2pEVCthODB4N2h3cDlYRDVvZ0FRMUtJWk12RHozWjhH?=
 =?utf-8?B?aUcxdGtVSzdBYzRRMGJSUFpkMlN5ekZBUC9WV1plSEtFenUzUDFKZWs3RjFa?=
 =?utf-8?B?TXdQeGNMc1RydXZ5dUMvU0VGbEdUZlNNeHpzOVd1TVlkT0dZT2RwbEJDcDUy?=
 =?utf-8?B?NmdFUFhHdzFqeS85bDNITmRHQ240YzJUdSt4SDZpMGxDeUpIS3gyaW1ac3lR?=
 =?utf-8?B?S1RrODNtMmoyY1h4dFlJaEdwQlFGa3ZQcEJidjFtSWQ3M2hzVmY4NnpEcTBM?=
 =?utf-8?B?T2RFVDVZZzhrb01LV1B1ZkMyOTZlQ1JlYTRGME5hWlo3S1BNcFg3MzBaNVRa?=
 =?utf-8?B?NnZ0TmZqTVQ5ZkxITHl3NkJ1cDgxb1lZZ3ZkMUNqTEhZRWxtdnE4T2hDb2x1?=
 =?utf-8?B?R3lOcVdRU3dZYU53am42LzM0YWU2Y3dzMld1R21xWTBqZ0EzaFVBNC9iNy9h?=
 =?utf-8?B?d1lwVEgycGQwQ2EzUmxrTHhQTXV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4207dab-47e5-42f3-ff17-08d9b63b6502
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 09:00:46.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MV2vT/oPXLfiINVK6Q38IHKzf38RAUCSVJBIEbC56xuSYiwSsrA2hCbqgmuLeOWFOyebMOCgvA2Yd/Tn+JOTjNCEx1t5+WwesvFBcEEBKfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgamlya2EKCj4gPiBPbiBNb24sIE9jdCAxOCwgMjAyMSBhdCAwODo1NzoyMEFNICswMDAwLCBu
YWthbXVyYS5zaHVuQGZ1aml0c3UuY29tIHdyb3RlOgo+ID4gPiBIaQo+ID4gPiAKPiA+ID4gPsKg
PiBPbiBXZWQsIFNlcCAwMSwgMjAyMSBhdCAxMDozNjo0MEFNIC0wMzAwLCBBcm5hbGRvIENhcnZh
bGhvIGRlIE1lbG8gd3JvdGU6Cj4gPiA+ID7CoD4gPiBFbSBXZWQsIFNlcCAwMSwgMjAyMSBhdCAw
OTo0NToxMEFNICswMDAwLCBuYWthbXVyYS5zaHVuQGZ1aml0c3UuY29tIGVzY3JldmV1Ogo+ID4g
PiA+wqA+ID4gPiBIZWxsby4KPiA+ID4gPsKgPiA+ID4KPiA+ID4gPsKgPiA+ID4gSSdtIHRyeWlu
ZyB0byBjaGFuZ2UgcmRwbWMgdGVzdCBpbiBwZXJmX2V2ZW50X3Rlc3RzWzFdIHRvIHVzZSBsaWJw
ZXJmLCBidXQgbGlicGVyZiBkb2Vzbid0IGhhdmUgZW5vdWdoIGludGVyZmFjZXMuCj4gPiA+ID7C
oD4gPiA+IERvZXMgYW55b25lIHBsYW4gdG8gaW1wbGVtZW50IGFueSBvZiB0aGVzZSBsaWJwZXJm
IGZlYXR1cmVzPwo+ID4gPiA+wqA+ID4gPgo+ID4gPiA+wqA+ID4gPiAtIEludGVyZmFjZXMgdGhh
dCBjYW4gcnVuIGlvY3RsIChQRVJGX0VWRU5UX0lPQ19SRVNFVCkgZnJvbSB1c2VybGFuZAo+ID4g
PiA+wqA+ID4gPiAtIEludGVyZmFjZXMgdGhhdCBjYW4gcnVuIGZjbnRsIChTSUdJTykgZnJvbSB1
c2VybGFuZAo+ID4gPiA+wqA+Cj4gPiA+ID7CoD4gaGksCj4gPiA+ID7CoD4gd2UgY291bGQgYWRk
IHBlcmZfZXZzZWxfX2ZkIGxpa2UgYmVsb3csIHdvdWxkIGl0IGhlbHAgeW91ciB1c2VjYXNlPwo+
ID4gPiA+wqA+Cj4gPiA+ID7CoD4gaWYgeW91IGRlc2NyaWJlZCB5b3VyIHVzZWNhc2VzIGluIG1v
cmUgZGV0YWlscyB3ZSBjb3VsZAo+ID4gPiA+wqA+IHNlZSBpZiB3ZSBjb3VsZCBhZGQvbW92ZSBz
b21ldGhpbmcgdG8gbGlicGVyZiBmb3IgdGhhdAo+ID4gPiA+wqA+Cj4gPiA+ID7CoD4gYXMgQXJu
YWxkbyBzYWlkIGJlbG93IGl0IGNvdWxkIGJlIGFscmVhZHkgaW4gdG9vbHMvcGVyZi91dGlsLyou
Ywo+ID4gPiA+wqA+IHNvbWV3aGVyZSA7LSkKPiA+ID4gPsKgCj4gPiA+ID7CoEFzIFBldGVyIHNh
eXMsIEkgdW5kZXJzdG9vZCB0aGF0IGZvciByZHBtYywgbm8gcmVzZXQgaXMgbmVlZGVkLgo+ID4g
PiA+wqAKPiA+ID4gPsKgSG93ZXZlciwgUEFQSSByZXNldHMgaXQgZXhwbGljaXRseSwgZm9yIGV4
YW1wbGUsIGF0IFBBUElfcmVzZXQuCj4gPiA+ID7CoEluIG90aGVyLCBQQVBJIGFsc28gaGFzIHRo
ZSBhYmlsaXR5IHRvIGNhbGwgUEVSRl9FVkVOVF9JT0NfUkVGTEVTSCBvbiBvdmVyZmxvdyB0byBj
YWxsIGEgdXNlci1yZWdpc3RlcmVkIGhhbmRsZXIsIHVzaW5nIFNJR0lPLgo+ID4gPiA+wqAKPiA+
ID4gPsKgSSB0aGluayBpdCBpcyBkZXNpcmFibGUgdG8gYmUgYWJsZSB0byBhY2hpZXZlIHNpbWls
YXIgZnVuY3Rpb25hbGl0eS4KPiA+ID4gCj4gPiA+IERvZXMgYW55b25lIGhhdmUgYW55IGNvbW1l
bnRzPwo+ID4gCj4gPiBJJ2xsIHRyeSB0byBhZGQgdGhhdCBmdW5jdGlvbmFsaXR5IHNvb24sCj4g
PiBJJ2xsIGNjIHlvdSBvbiBwYXRjaAo+IAo+IFRoYW5rIHlvdS4KPiBJIGxvb2sgZm9yd2FyZCB0
byB5b3VyIHBhdGNoLgoKRG8geW91IGhhdmUgYSBzcGVjaWZpYyBwbGFuPyAKSSB3b3VsZCBsaWtl
IHRvIGtub3cgdGhlIHJvdWdoIHBlcmlvZCB1bnRpbCB5b3VyIHBhdGNoIGlzIG1hZGUuCgpCZXN0
IFJlZ2FyZHMKU2h1bnN1a2U=
