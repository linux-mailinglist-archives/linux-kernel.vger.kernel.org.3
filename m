Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20E4D57C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345506AbiCKB6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345520AbiCKB5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:57:53 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847A219D776;
        Thu, 10 Mar 2022 17:56:44 -0800 (PST)
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 01F9D404DC;
        Fri, 11 Mar 2022 01:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646963804; bh=0aEB/Wl0Uu6m9Ae6gyVuUQegnqM4LO7uP63GqTeSTi8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SzI0qi2qd9AwSYH1iMcZ1mw3/nk4Sfcu/2PO9eU5FcYO8A68Dy3UYzgytL8SBmBoO
         qc8JAFQPtUzIv4E11G+wuFJlHoViR4cHiXeud/GZkHXoWuVZ6sbhRV8Vt7IySY8dGr
         cM3k88ILZKYCZ9UCwRVHc++Pdl9LWS5adg0iv3dCRyaRol7Vg+eDSIdjm72Isp3TK7
         bSZDv7y+maCddG4+6LshB9cCCiDQ8+XUCFyd/NLf4+WRl+/6LE9VXxkFWD9ycJmxA/
         eeo5KVIFXRDwemnGtXQlMksCYVWUUQzMzb36ggcV1LQvfYVOCTGOXcYs8MmyiSOUD6
         ++k47s+1l9DAA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1E7C5A006C;
        Fri, 11 Mar 2022 01:56:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0298940030;
        Fri, 11 Mar 2022 01:56:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="peuv0/AW";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDYBsfpe+uiCVIFliWJ07fQCfhmrBe9T29R2Zp/StCZ5POnqw5uGnBlQEcBhtyUf+V+OEliGpU4lWPCgwkWcO0upywJXat8FMJhbO+bfLVdcayJK7TI01Ws02oQ36HMEOXwPAB5PLZrQLVwCH3Y6UwhTQ3HUFr8ZMHnrMYipXtaZScl03D1CL1aV6NYhmJBUmsPKDZ24P54aGOydfJ2ZofEnRRGyYuc7ov8guOG29kD3XnT2WHMbtEHKG1Lkw+YCL4DPCIeKh+/0pGE1s6TYcfqrku97azvGjyd/jsmd5p3muz3OIft+MjxgaN3tcI2q9CYjz30M+UjtTptNlPL4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aEB/Wl0Uu6m9Ae6gyVuUQegnqM4LO7uP63GqTeSTi8=;
 b=O7WKB7QvARyl3NWbZ/NaixTZ1Hv1Nm140KxzyMy774ecIW1moG8Rcm8QmE2hPecQxNHoco8TCFjMD7oJvjberToNyrYH6DDW5n0cIKhoW++eKtwwurz1Py4QIeymXEZUKOIa7bnp4goZhGAdlUppLtNpXNRWm7CFmxoieLWdq76M0KYo7OlqomxYvdR4QgUw00wSn62GvWWE3pnxp84S/j5lIE9bhhBsHM53P1Cy2R4FRtAQjbu21p+PlRMWtyKJId0F/OkhKkRewkJ6QOnLe+vIfnanN0QR6u5jG/j8sI4YCokgFv+6ijlT8ESSq+TCbe+fTba7C63CEvQVQAeHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aEB/Wl0Uu6m9Ae6gyVuUQegnqM4LO7uP63GqTeSTi8=;
 b=peuv0/AWFt0dDEXQsx1nDYDAXiUbfQV3ruzET214x6kv1eAf9XFntV7IaiSPNxNHfJ7D9vhMlilWNVvczNlLlDbJsMD/zhgEwpIP6F736S4RnixwB1OdXcHQrTp4FefArRgiXN3V2Oq75nw2Gh/1KezoGVnieGfOaaMF+xDYu3w=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN6PR1201MB0164.namprd12.prod.outlook.com (2603:10b6:405:4e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 01:56:38 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5038.026; Fri, 11 Mar 2022
 01:56:38 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC:     "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "cpgsproxy5@samsung.com" <cpgsproxy5@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Thread-Topic: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Thread-Index: AQHYMePmBfflf4nAkkGdLNAaNOlrkay35TEAgAGF7ICAAAeXgA==
Date:   Fri, 11 Mar 2022 01:56:38 +0000
Message-ID: <559b00b6-8b3d-9422-6a25-674f719ad237@synopsys.com>
References: <CGME20220307052605epcas2p2b84f6db2642863ed61373070f508e200@epcas2p2.samsung.com>
 <1646630679-121585-1-git-send-email-jh0801.jung@samsung.com>
 <99eabe6c-8782-1bc6-e1d7-09b019cee65b@synopsys.com>
 <016a01d834e7$72b11fd0$58135f70$@samsung.com>
In-Reply-To: <016a01d834e7$72b11fd0$58135f70$@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdc660cd-8b28-4db9-e8a3-08da03026168
x-ms-traffictypediagnostic: BN6PR1201MB0164:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB016441CAE2740B2344950DDDAA0C9@BN6PR1201MB0164.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FhGx21PSOcsRsarsxs0mCFnkt4czNv6JHb/wuhnH6d5LvnUtp7W/6FvFrLjAKMgX6XZKBY7gmHcVtLntQ2Cekh+i2gvtYPyOYciu2RSQFQdm3FYy4Q7wcaEsGsM5dHSDW4PbdWSRG1Xy3KPxd8BMGzcebdyMxdsk4g6PeEl1FoIcWhtUdBBxbO0oLAyjky4ZwDi7+DBhVgHkNZGnIcoMM0cPluwnjyRTsROzravSYbybNHIEw0PvaA3iwHt3LtlILWQsXtNBLbWqKOxzVA0itXe3r0c3G2bOYC9hmbTp4gJ3MYQTlC7gj18TALtpeS2+u1SUtFp38HY8yy4WR2Ytr1jkzjufJ2tqIIL0Z/76QCOUI5hQHHWN2njc1BMp/AykyO2r0JVkItn+c8Uku8kxNnydLL4RNvJBq2YIbipXc7e/yNS3r4UzYf2Ffk9XH1fCxOTpVY2gSaY69dSPUXSxdkXV6PgLDYHMVcHZ9V4qD/vFCtyYngrUDOcwmmX5eKSHRoTCojy5iM9gUf+M4L/jsVkHi88AXmPRwlZBJK3hhImJ7mMX5qFilxA2KkKm7bJQCWt1UpCCRcEmmRD3Tyjj5c5qv+8m2xKeGdCNLe06t1xcbwHTc9OMBV6dhldQJYuWxwUNNAN99UNWR2jt/CprK/mTT2oZPLKJvyD4icGDDcuclOq3Zf6n+kRRHtE3RTutNd/SkoeqfPUW6Ex2/FLlZeg1sp9fhzcjksBNsOrTuO+ZknB1uTSru3S6qrMeqCzizem7RyohsCFa8bru5tJrSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6486002)(186003)(2616005)(71200400001)(31696002)(53546011)(36756003)(64756008)(4326008)(8936002)(6512007)(38100700002)(86362001)(8676002)(66476007)(66556008)(66946007)(316002)(31686004)(26005)(66446008)(76116006)(110136005)(5660300002)(54906003)(83380400001)(508600001)(38070700005)(2906002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWJ3TTkxMzJxMXRlbVhUMmIwSWk4RWJuS0Vsd0RFY2hiQ0Znc3BubjJGelIv?=
 =?utf-8?B?WS9rNUVsL241SEVia2FaUVZvQ29Jc3FBeDBzVXlaWWs0QzFkdnhkdTJxUjQ4?=
 =?utf-8?B?T0k2d09xZXRVRXFLdHd2K1FrWEVBMUZjZUFDS2hSL3RWcmZ4NDdabXVlVjVp?=
 =?utf-8?B?TzY4R2w3UWh3c015dUcvNVZXdjBiZTFRcDNOQXVOSWJ6aGp3MVY1UlJJT0dX?=
 =?utf-8?B?UjNYRDJORElaaDJKZ0lWMFdmNCswSTEweU82M05rY2tiYXFISzBlakFQT0hD?=
 =?utf-8?B?bGZOUUNickFCVHFpTWZmaTVmUkpmUGRiQkp3ZUZYVUhzdmNQa1p5b2FNTFJI?=
 =?utf-8?B?SUpRMEtBOGhoeThVaWp4WmsvbUFEMU5Ob0FsdG52U2hENkZNSmdmTms2OExx?=
 =?utf-8?B?Skd3dXByQndvR0libVF3VWR5dU82SXRiREQxL3BmZm9hWWN3N2YxTEdXOGxq?=
 =?utf-8?B?K0o4bTBVR2JaalpBYm9OTzgrR1RWVzZXZ3Mwa1RjdlBVNE1GREVETERKS2Fr?=
 =?utf-8?B?dHhSRmdiSmFoaHBQdGZGYlFUaHZnSTBNMjk5WUFHZ2pFUWF6QjdUMFg0ZDJl?=
 =?utf-8?B?QkRDUmJrUjdYK0s0NjgycXhEN3paUTJOdHpVdEltb2xmZzBZOW1EN085L3hV?=
 =?utf-8?B?TVphV3llMFBWbVdpdi9CbjZTQTJxeVFvNE5kaFB4Mm05M2tINWhoZk9pL0FI?=
 =?utf-8?B?c0xoWW8rWTZnYkZpd3BaaittMjdHQ2txaGkyOEFXQlBjRzg0ZDc0eGxGa0RP?=
 =?utf-8?B?UEl1dXZnbUFJVE9MSTMxV0ZFb0RhSktjYzNwNDJ2aGhlWmhiUmg1VHJYL2tZ?=
 =?utf-8?B?ZCtySC96bjJ2dDVBSWpMNzRDYXI1M1ExUmx2bmJBV0xVeUNKVVRobm40SUZO?=
 =?utf-8?B?Zjk4MWhrdmJiQ2pORmxFTnh0K3AzaHAyN0pKbk83MnVQWmNqUHl4aWNGTFVE?=
 =?utf-8?B?Sk44R0k0ZitmNnRjb2dNb0czZ3FxUWY0ZjcwNkRaVnh6Skpackc5Y1FoNFlD?=
 =?utf-8?B?a1I3N2Zya1BpTGUvcHVQTXhqY09PTHpJSE9OanlLcmlocmt6aTF4N0F2ZEVn?=
 =?utf-8?B?MjVEN3VTTVlaU1lCeEVNMTI2aWxzdG9qMVFDRGJZa2gyVkJuaHRoWnFKWnll?=
 =?utf-8?B?aUg4WE5ka0dUWm1LV21CcDcyQ1dEbVJvVWtSUTFqakpuUnBGemhxMHZmZ3pw?=
 =?utf-8?B?ZGZOaDZGeWJtUmsvNHF1eXovbEdVRWRQYkE2VWVhaWR3ZG85bUVLRzlkWncv?=
 =?utf-8?B?cmkvNVJDWEZkNXAvZzhFY3FJTlR4Rnk5WnoxRWdSWGJ5eDg1T3ZuTTRuWng3?=
 =?utf-8?B?QlB6bVBRTWNzbVp6M3ZINEZ1UWViRXh3eFFGODBNVElzRU9MamFWamhjMy9I?=
 =?utf-8?B?MktjeFVIKzNmTHBuUDdwMjVtZzVvL0lRZ0FDOVdzaTFoRVBnZHpFaWFjbTZl?=
 =?utf-8?B?MGxUbHczaTB2dCtjV2RmTElsSmZQWk11bFh3a2ZZalppcnNUTDRPRjRCQkVR?=
 =?utf-8?B?YzAxRVZINEZkYW91aDdqcWVudTRzMVcxWDBkeVVkMEV0N1lTbUdWY0dXV3pY?=
 =?utf-8?B?WXNsT3puZCs2YjFmWENoQkVpVngya2M1QXJvMzdHWmMxS25ONnNhelVtMkt5?=
 =?utf-8?B?aFVJT1hjU1pOTFk1WitSbU5DenVNcWZsS3RDQ3BkajJ3Qk1FQVhCejBEdk9P?=
 =?utf-8?B?SUdBYVpmSmFnSGducjE0cFZOUCtEcDhLK2RLb2RPRUF2b3NhUzZkWWtuZmkr?=
 =?utf-8?B?bUNaS08wWE42a2NleFh2RmxMbmFCSHNYWm5oVHVYbUIrNTZPNThWM0JKZEwv?=
 =?utf-8?B?QS9pRzExYlp5MDlEUEtUYXlYRmFTMUZFYjN6SWpFdlJTcVB0ejlpQ0NUclh5?=
 =?utf-8?B?UnpkNHhDcUFNazRsTStpcUJLby9lZG9FU21zYllPQ2xxWHFRVmZxM3NFb3Rp?=
 =?utf-8?Q?/mgwpb2vqqZS/VmcYCWTmM8wvKtwNP57?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2603A507FC1D34B9E6D3B6A252F4EBF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc660cd-8b28-4db9-e8a3-08da03026168
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 01:56:38.2461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCbHtI344LuFGTcpGffI+ClBftFpQTby8pfoEgyJXL7XxNxOISJe//o1Y6pL8WF7O3ORms528iM+HgDd/MKM1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7KCV7J6s7ZuIIHdyb3RlOg0KPiBIaS4NCj4gDQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPj4gRnJvbTogVGhpbmggTmd1eWVuIFttYWlsdG86VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNv
bV0NCj4+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxMCwgMjAyMiAxMToxNCBBTQ0KPj4gVG86IEph
ZUh1biBKdW5nOyBGZWxpcGUgQmFsYmk7IEdyZWcgS3JvYWgtSGFydG1hbg0KPj4gQ2M6IG9wZW4g
bGlzdDpVU0IgWEhDSSBEUklWRVI7IG9wZW4gbGlzdDsgU2V1bmdjaHVsbCBTdWg7IERhZWh3YW4g
SnVuZw0KPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MzOiBBZGQgZHdjMyBsb2NrIGZv
ciBibG9ja2luZyBpbnRlcnJ1cHQNCj4+IHN0b3JtaW5nDQo+Pg0KPj4gSGksDQo+Pg0KPj4gSmFl
SHVuIEp1bmcgd3JvdGU6DQo+Pj4gSW50ZXJydXB0IFN0b3JtaW5nIG9jY3VycmVkIHdpdGggYSB2
ZXJ5IGxvdyBwcm9iYWJpbGl0eSBvZiBvY2N1cnJlbmNlLg0KPj4+IFRoZSBvY2N1cnJlbmNlIG9m
IHRoZSBwcm9ibGVtIGlzIGVzdGltYXRlZCB0byBiZSBjYXVzZWQgYnkgYSByYWNlDQo+Pj4gY29u
ZGl0aW9uIGJldHdlZW4gdGhlIHRvcCBoYWxmIGFuZCBib3R0b20gaGFsZiBvZiB0aGUgaW50ZXJy
dXB0IHNlcnZpY2UNCj4+IHJvdXRpbmUuDQo+Pj4gSXQgd2FzIGNvbmZpcm1lZCB0aGF0IHZhcmlh
YmxlcyBoYXZlIHZhbHVlcyB0aGF0IGNhbm5vdCBiZSBoZWxkIHdoZW4NCj4+PiBJU1Igb2NjdXJz
IHRocm91Z2ggbm9ybWFsIEggLyBXIGlycS4NCj4+PiA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+PiAoc3RydWN0
IGR3YzNfZXZlbnRfYnVmZmVyICopIGV2X2J1ZiA9IDB4RkZGRkZGODhERTZBMDM4MCAoDQo+Pj4g
CSh2b2lkICopIGJ1ZiA9IDB4RkZGRkZGQzAxNTk0RTAwMCwNCj4+PiAJKHZvaWQgKikgY2FjaGUg
PSAweEZGRkZGRjg4RERDMTQwODAsDQo+Pj4gCSh1bnNpZ25lZCBpbnQpIGxlbmd0aCA9IDQwOTYs
DQo+Pj4gCSh1bnNpZ25lZCBpbnQpIGxwb3MgPSAwLA0KPj4+IAkodW5zaWduZWQgaW50KSBjb3Vu
dCA9IDAsIDw8DQo+Pj4gCSh1bnNpZ25lZCBpbnQpIGZsYWdzID0gMSwgPDwNCj4+PiA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4+PiAiZXZ0LT5jb3VudD0wIiBhbmQgImV2dC0+ZmxhZ3M9RFdDM19FVkVOVF9QRU5E
SU5HIiBjYW5ub3QgYmUgc2V0IGF0DQo+Pj4gdGhlIHNhbWUgdGltZS4NCj4+Pg0KPj4+IFdlIGVz
dGltYXRlIHRoYXQgYSByYWNlIGNvbmRpdGlvbiBvY2N1cnJlZCBiZXR3ZWVuIGR3YzNfaW50ZXJy
dXB0KCkNCj4+PiBhbmQgZHdjM19wcm9jZXNzX2V2ZW50X2J1ZigpIGNhbGxlZCBieQ0KPj4+IGR3
YzNfZ2FkZ2V0X3Byb2Nlc3NfcGVuZGluZ19ldmVudHMoKS4NCj4+PiBTbyBJIHRyeSB0byBibG9j
ayB0aGUgcmFjZSBjb25kaXRpb24gdGhyb3VnaCBzcGluX2xvY2suDQo+Pg0KPj4gVGhpcyBsb29r
cyBsaWtlIGl0IG5lZWRzIGEgbWVtb3J5IGJhcnJpZXIuIFdvdWxkIHRoaXMgd29yayBmb3IgeW91
Pw0KPiBNYXliZSBpdCBjb3VsZCBiZS4gQnV0ICJldnQtPmNvdW50ID0gMDsiIGlzIHVwZGF0ZWQg
b24gZHdjM19wcm9jZXNzX2V2ZW50X2J1ZigpLg0KPiBTbywgSSB0aGluayBzcGluX2xvY2sgaXMg
bW9yZSBjbGVhciByb3V0aW5lIGZvciB0aGlzIGlzc3VlLg0KPiANCg0KTm90IHJlYWxseS4gSWYg
cHJvYmxlbSBpcyBkdWUgdG8gdGhlIGV2dC0+ZmxhZ3Mgbm90IHVwZGF0ZWQgaW4gdGltZSwNCnRo
ZW4gdGhlIHNvbHV0aW9uIHNob3VsZCBiZSB1c2luZyB0aGUgbWVtb3J5IGJhcnJpZXIuIFRoZSBz
cGluX2xvY2sNCndvdWxkIG9iZnVzY2F0ZSB0aGUgaXNzdWUuIEFuZCB3ZSBzaG91bGQgYXZvaWQg
dXNpbmcgc3Bpbl9sb2NrIGluIHRoZQ0KdG9wLWhhbGYuDQoNCkJSLA0KVGhpbmgNCg0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYyBpbmRleA0KPj4gYzAyZTIzOTk3OGUwLi5hOTZjMzQ0YjlmMTcgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+PiBAQCAtNTM0MCw2ICs1MzQwLDkgQEAgc3RhdGljIGlycXJldHVybl90
IGR3YzNfY2hlY2tfZXZlbnRfYnVmKHN0cnVjdA0KPj4gZHdjM19ldmVudF9idWZmZXIgKmV2dCkN
Cj4+ICAgICAgICAgICAgICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+PiAgICAgICAgIH0NCj4+
DQo+PiArICAgICAgIC8qIE1ha2Ugc3VyZSB0aGUgZXZlbnQgZmxhZ3MgaXMgdXBkYXRlZCAqLw0K
Pj4gKyAgICAgICB3bWIoKTsNCj4+ICsNCj4+ICAgICAgICAgLyoNCj4+ICAgICAgICAgICogV2l0
aCBQQ0llIGxlZ2FjeSBpbnRlcnJ1cHQsIHRlc3Qgc2hvd3MgdGhhdCB0b3AtaGFsZiBpcnEgaGFu
ZGxlcg0KPj4gY2FuDQo+PiAgICAgICAgICAqIGJlIGNhbGxlZCBhZ2FpbiBhZnRlciBIVyBpbnRl
cnJ1cHQgZGVhc3NlcnRpb24uIENoZWNrIGlmIGJvdHRvbS0NCj4+IGhhbGYNCj4+DQo+Pg0KPj4g
VGhhbmtzLA0KPj4gVGhpbmgNCj4gDQoNCg==
