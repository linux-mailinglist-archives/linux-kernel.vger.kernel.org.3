Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1846B3DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhLGHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:32:07 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:10804 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhLGHcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638862113; x=1670398113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pA4LwX0+eVwPvMGSTOFcbnNMjWAZsQj31Xs/8RQem0I=;
  b=Ueu5QY84s6VM+y0JBSiO5FQnM/CVORFmHezoolEU6zgl7OY+dyZROahk
   q1ucLKOqlVlyxhsPI2NkLEU/rhOVZmLIoCu3CMn9L4yeaXBI1Zez+k1Md
   HlI9oSve5MDM+0+/aXu76V1QobGxbwEy2XoMmuGHS3G7QH1GP51MkSLwH
   TuI+BYa+5TJYpjKJJWCzW8bwOvOES0ViRE3quh5Ec68U1CuM1qF35un5m
   AfSwDqvC3hSQvDF0wUcaaFcSquwx6RqBLDaa974g38btqMjZqcF0zTdpd
   /xKBarFZsDI8m20UM3qSyeWK2B/SjrHrJuCm6rdZxmTNWgNKiXrq1mSU5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="45311141"
X-IronPort-AV: E=Sophos;i="5.87,293,1631545200"; 
   d="scan'208";a="45311141"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:28:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjrvoHrvC6VYGcs15Xd98NkrIplVcX7ImL3i0nuULW+wSM/gq30BrJdrsc0rGrfLSNcZ5DQPwBgjK6Lzm/UoRUwz8lvU41Sw6CZi4jbA3JJPEMAgsl9Fvj6m5K8YFKsX8dyeABXIeVC6HrATLdnUweY3CRXTfMxSJK7rAsMRD6t3nAmfEVxRFeTyVEtpU9xjJvzWkREknSvkAJx9I04QOrAAzEXrp742sY+A81DTd/DVjvq08Z16Vs6M4HLGkXbhYNwlaa5T8EpHBWdlFFpnh0UqEqZ3gJnm94WXM0JIe0OV9Cirs9cDIgq4Io9OeRRZNwQy6xNsK72tZNQnCpqkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA4LwX0+eVwPvMGSTOFcbnNMjWAZsQj31Xs/8RQem0I=;
 b=WNoU33KevrKCcZ/rEwxHBASORtgGL0zAMfEIbZGYF1uVOoDEztpKqSabydHcHlL70IAf12BWbZKG5+3zwXwBoAcB5nNUV1ksT0G6O0pxPGc/mEjvtq4NPbRGvK3Vb1owsEX7rkD8Djgnph+xZvXWBXVu+EFjTesw675DhTooFP5YrBGEaD2yjOBGtXhVd+5I3WlXmOiC+sdKBFcgjvsdBafreHBAmoPvIsF7ULgLz6Qfdg7wWci8HdTMnWCf1t3XMOu017VwvP+OfGy9KXYoXrn18yCeS+U4YhLRncBhVTIVzfZZ443LSp2mfGFWdVXblBOljK77xfR5xoWJx+DtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA4LwX0+eVwPvMGSTOFcbnNMjWAZsQj31Xs/8RQem0I=;
 b=BdNvYSp44WiFsnqjrF39uKwwwxY8BW958gZKM/CB++szkldL/QlHIF2zEI07sX7dYWfapoxY1YRyQQOTyhwp5GzrJmWAT5qjRmuOjHCPXqh5YKIa40KCuODpO7ePkipeYM/o2jpfNPJJUns3kxr9TuYgN7APNrnrwvP7pmafvBc=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB3765.jpnprd01.prod.outlook.com (2603:1096:604:4e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 07:28:26 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::2c38:ad18:39de:3042]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::2c38:ad18:39de:3042%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 07:28:26 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] libperf: Move perf_counts_values__scale to
 tools/lib/perf
Thread-Topic: [PATCH v4 1/3] libperf: Move perf_counts_values__scale to
 tools/lib/perf
Thread-Index: AQHX5QCacux2v3OupEqNq+85TtPQsawmlqzm
Date:   Tue, 7 Dec 2021 07:28:26 +0000
Message-ID: <OSBPR01MB4600580E0F24918719D8AE2FF76E9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20211129090627.592149-1-nakamura.shun@fujitsu.com>
 <20211129090627.592149-2-nakamura.shun@fujitsu.com>
In-Reply-To: <20211129090627.592149-2-nakamura.shun@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 6dad7b2c-12f2-cbaa-722e-eb1e07424c03
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ef786ad-a2ad-42b7-6c3e-08d9b95328bf
x-ms-traffictypediagnostic: OSBPR01MB3765:EE_
x-microsoft-antispam-prvs: <OSBPR01MB37655B482F0AE49C75308D5CF76E9@OSBPR01MB3765.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JexQXYENTUqCs/4aEhfng7ktLSLE8yqcnBXceHZiOO/QGthhV8PkZ0SDFJ5UqxNJ63INLZ7IxgiMzDWHRB4dofO9061O/be+3SKLot8QrZoGCXsLwep1TPrtsmG31MUkD/NvtL10j2Frp0wksLRiKhJo5TmlB1lc+dndwv4K1KbKunZC5p/yBvCQhSYvJ3mKDdyc4Mv1rH/zpsfL2JpW2LY5m7P4e1lbpsA/A3QijOXG/dH/lRT41WIjtGT63B1Lnupc4qNyG2qDzHTLzof+zHmHlub6ZIKR2h2+9ycFexLm+Qh5khj0xq+0ZReCrPNLD3Fr+j5a6D82xHrtHlITHkn+5Cn7WzWJ4MiypesCnw7eDjQixHmhs/fkXnEylKtYxNpWGRMIx1lTS9n6ooyucQIEeGbLD9y8QcvVXX4e1yVVxoBXjN9HMo9ZEZ9Nj8h943CSyvaH0PkFMh5A5FiGjmXAee9cTP6mrdul75L3b+zvYCEygPnY95AkeML5ahEdsOQukHCDGMyCO21wVikrQ05TwYIuHUDV4wjz0Cxg+YssXq0U3OGdcpczbPhLhlFDKaZF7JMxYOQgO1zFni0IoDGMOzgVEHVsrQZwpdj5TelxC4cHDe7Or/Up1xJiUEX6pdj0ucc4U2CjRnZC8gyipj271KpIbVFhgRLu+G1Eev3lw38h1fr05OD4cVysSOb1PXYNbUqZtnqeN5UhhdKbQ7RotleMrIEA6WI9WlCgRM00QcQGk0eklzJ+DHAcp6nU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(2906002)(71200400001)(508600001)(122000001)(38100700002)(85182001)(110136005)(316002)(7696005)(52536014)(83380400001)(6506007)(8936002)(26005)(186003)(4744005)(64756008)(66556008)(8676002)(66446008)(55016003)(76116006)(91956017)(4326008)(9686003)(66946007)(7416002)(66476007)(33656002)(5660300002)(82960400001)(86362001)(38070700005)(101420200003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWJLQmR2Y21FUTFsdmxoWEJydC9kTWpXSytTZ2ljeUt4WmFXbUlyZFoxL29N?=
 =?utf-8?B?Q3NxQmxHYU9XcDZidExrUVJCTnFSTEVwQ2FFTWVlN0tHQit0OWlRSnNpUllH?=
 =?utf-8?B?b1R6WUdCcXZER3l2YjhuakxLbWdHeDZ5amxtQWtTcEhocDUwOEF4cFhzazZu?=
 =?utf-8?B?dzJFSk52eCttQ1hHdzM4TUdhazNFYklORjc4L1NneDdJdTBxV21PR3VwOCtz?=
 =?utf-8?B?OEdhVmxJaGh4M2t2dldrOVgwLzVvM0xkTnkxUVMzbFpFVmR3Skl1eERFQTFl?=
 =?utf-8?B?UmdCMHVjM296dHBCM21BK1JYTFlhNXhiWG9XZHlIUyttYTJ3ekt2RXkwVy8w?=
 =?utf-8?B?VzlvSUE4b0g0N29vWDViR1Vtb0toVG0yaXhlWmFJaHpZTEplU09RNzBMc2ZY?=
 =?utf-8?B?eVNzQUlCelVvM2RkR2tJSG5yNWZBM08yd3ZtSXFicWFnY0d1Yi9zSFdPNWo0?=
 =?utf-8?B?M0Zld3dOVWVpaDJaYVhpMURPNnNoczc0ZFpVclNzNVlhdy93d3RwYWozQnQr?=
 =?utf-8?B?V3I5ZnFZSjRabFJldmpXWDlndW93VlBCSkloSXJTbDlVb1RuMjB4YThqdXZ6?=
 =?utf-8?B?aWpaTjE5aUVTazExWW5aZm42WmdDTTRPaVRULzg1M0VMMmNtQVUxT0o4MVNk?=
 =?utf-8?B?a29LWm4zTXlyUlBQUE9TNkp6TklldDFQMXBxOUtkUkZvSXFyNzk0RjYyTkJE?=
 =?utf-8?B?dHM4Ym1Zb0ZVY2JhaGxUSjd0aDg4WkVsa1BTdWF4VEozazVraUdOMDlYbGkw?=
 =?utf-8?B?OTVLcVpNRjNoaGtrQ21HZUFkTXdnQmxrRFRjd2VJeWpsQk9pcG51aDU2T1hF?=
 =?utf-8?B?MUFCai96Z1FYR1pQWk1DM2lqenFSVXZVcm9xNlhkWE82VEtBUHdQZW5PQTJP?=
 =?utf-8?B?LzMrLzdMUDIrZG1PSVJnUzFITWJQZVp4UUFQa0lRMHN3UlJzRHV6REc3TWhL?=
 =?utf-8?B?TWEveWVwOE9TcVpROGxVaUpaWWJxck5Kci90MVlwWG5QbEtFR29xRU83SElW?=
 =?utf-8?B?a0F5UURCQWh0N2hrZWhTSU05MnBNbU9paXFvdDZRZW9hbDRPV3BxZjNNUUJp?=
 =?utf-8?B?a01ERmxVdVhUbE94c1cyZ0pBRHlKcTFlRTBEamVPOVRlQkg1d0J5VkVqUjhk?=
 =?utf-8?B?SU9qamdLcGg5QlFrY3p6djJGWGRQd1oveWNMYm9SUXRUK09mQXhXRVN2M0JX?=
 =?utf-8?B?cWRMVE9qcGM1VW5MWmpOYmJuc01XY0RIUTQwUkpVWG9Zczk3cHk1UHVpVHZi?=
 =?utf-8?B?bWRTVlVhODRvUVp0TjZHazdLVWE0aTRTUUMvaG5GVEpBWVlFQ1hmRlFIRU01?=
 =?utf-8?B?OVgwQjlMQU15NFdVZ3NwS1loVzVUSW56V25rbDNVT0p5TW5iT1JQcVplL252?=
 =?utf-8?B?c1VubVdwaEt5SksrcVRxSmhBVzUzRVFKeW55MmRqeURVYno1by9hbjc2UzNK?=
 =?utf-8?B?SEM2eU1TR1d0VUJwd3Q2Qys4SnFhYy90NkhUMmdTUFM0ei8zTmdxMldhMHFu?=
 =?utf-8?B?T0ZaUlZJYzM2U2lYUDZySjdySTUrSFk0RHNSS1RiOWhaclUxeElxUFVBR0E0?=
 =?utf-8?B?SUtzUEJOU1FIaldWQ1ZURm1rZVQ2Ym96YWNPdkVaNFkvWmRpcW9kNmdsYksy?=
 =?utf-8?B?R3RkaEhIWnVZZVNKRHJBSEl3Z3BYVEFBWmZ1OTgxZEN1MXlLSklsY2tGTEth?=
 =?utf-8?B?TllBRnh4Vm5EYUNaZE91WCtySDFvR2FOWFlDWFk2ME0wK25mZ2hFaDFwOGoy?=
 =?utf-8?B?N1cwQ3FRNFRHMTdRMUVWZTZDclB0b2xBbHkvbjduNWpkRzJCQVMwOUxYNytv?=
 =?utf-8?B?cDVtdkpWaEZTWEhCUWtEbzlSYmI5U2c1VTRCT3h4U0p4L2NROWIyVHlsR2dU?=
 =?utf-8?B?VkE1cUd2dEMyZCtHd2RPc2pzQk1QZ1BTbDBST0JXWGNPdG5rNytISFdrajg3?=
 =?utf-8?B?ai85dDFqUFlYMFBoYVBZS2FLZHErWHNRTDBHV3dpSHhkTXRWTE1xbDMwRjdh?=
 =?utf-8?B?YnJuaE8yNFNGemhESUh0UW9zNEJZeFhlU21maFB4b1JSRTRFUXUweXEwcEZv?=
 =?utf-8?B?ZWMxbmdRU2VKbFFzcDJ6RFVZcTE3SzIwdlJyR3ZuOUF6NU00VkhVNWtGakdG?=
 =?utf-8?B?VTdMU0FlRGNacWp6MFhkYTR3KzllbjBzQm5aVElIdFpOcWRSTDFsTmhNWlln?=
 =?utf-8?B?VHVyM1pJSlY0US9ha1J2OXhKbWdxbzVzUFlhTVRoYUZNWlJtSDd4WS9IWjZU?=
 =?utf-8?B?a1pmcjBVZWlNb3dqdERuMm5yc1F3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef786ad-a2ad-42b7-6c3e-08d9b95328bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 07:28:26.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMCoFQhAJJ1Kb/sNmr7yBqSMPAQ9MlE87ZvvDnwtM6zg8hHXRJ1X8rZmtfuBqpX+D/DFoY9Sipre+PS3uBvP+7gMKTV9ZGV/RKnKTacOesM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3765
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBNb3ZlIHBlcmZfY291bnRzX3ZhbHVlc19fc2NhbGUgZnJvbSB0b29scy9wZXJmL3V0aWwgdG8g
dG9vbHMvbGliL3BlcmYKPiBzbyB0aGF0IGl0IGNhbiBiZSB1c2VkIHdpdGggbGlicGVyZi4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBTaHVuc3VrZSBOYWthbXVyYSA8bmFrYW11cmEuc2h1bkBmdWppdHN1
LmNvbT4KPiAtLS0KPiDCoHRvb2xzL2xpYi9wZXJmL2V2c2VsLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDE5ICsrKysrKysrKysrKysrKysrKysKPiDCoHRvb2xzL2xpYi9wZXJmL2luY2x1
ZGUvcGVyZi9ldnNlbC5oIHzCoCA0ICsrKysKPiDCoHRvb2xzL2xpYi9wZXJmL2xpYnBlcmYubWFw
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiDCoHRvb2xzL3BlcmYvdXRpbC9ldnNlbC5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTkgLS0tLS0tLS0tLS0tLS0tLS0tLQo+IMKgdG9vbHMv
cGVyZi91dGlsL2V2c2VsLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgLS0tCj4gwqA1
IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQoKSSBtaXNz
ZWQgdG8gdXBkYXRlIHRvb2xzL2xpYi9wZXJmL0RvY3VtZW50YXRpb24vbGlicGVyZi50eHQsIHNv
IEkgd2lsbCBmaXggaXQuCgoK
