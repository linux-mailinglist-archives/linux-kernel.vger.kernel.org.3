Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9637554746
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356538AbiFVJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiFVJZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:25:27 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5C113CE5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:25:25 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0C1FEC3005;
        Wed, 22 Jun 2022 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1655889925; bh=tadOYNxwLu1eAEes2fKbtBZ2ma3hs9b8PX7XJEtOK8k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GMf71vIxjWAK2M0XqJUuG4yWAoHTl6VuzdS4iWLyKtOUIQhYHOh3SbRmX/NEjREeP
         uKOQBdL/21zKf0KUbP+014qcLhmP5J2xxHLt4cbq47xKcCEgDv+Ss9olUrsrAOmZZA
         GbStIeZxZOJF6Q5XEoMYMKnMhmdqQ6apcnvW2fli6QWYDqc0+N/p3LjEzZstGiOUuu
         nfvDH47z0AyfFHkcld4ulSh0AzxB2vr6RoCV8a1MUwIld+iQpti3V5uXhd3kqEkgM0
         OJWop5dplbvJfmNX7YpLLKzmam2O+oB1UBkN4lysmRKG+CGqKx9QCMANDJRqRoUGMe
         pxEppCOv23x0g==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BFF98A005E;
        Wed, 22 Jun 2022 09:25:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4CD4B40085;
        Wed, 22 Jun 2022 09:25:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=shahab@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Zm3HUx6g";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG7vFlNb+ed4aaTT+JRGfZL1FHPFv1jH+iNRAeruo8KJ1oiqyWtBolcyxQghEVUMTTebgJSbijLAJfRTbd+Uv2RHw0LlOKCw4qI7DcWeE9PoMZUImzxbmedylTbgkgAURnCqOGxZ4sFXAnyXiHmG41W8r3/aKjOVW1Br5ggZRVqp3KjREZ9vdsC4T2uBzVCKLhAfPBwu4IjbZDOWA5SspZm2ys/fOOLaTm9f7KOK44KlcCMIYSNbHTCXVaFADQV+bVJrcYE50bwP7Ts9UEuuz2l5N/WxHd583WMT5sjSAHzcibSqNuuShA6jK7/8fwK7TNgwuD+BSZ22ehb8rzl/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tadOYNxwLu1eAEes2fKbtBZ2ma3hs9b8PX7XJEtOK8k=;
 b=h+5impd7ed65ziexxsqc+C1FqZ57qEg2sT3ms+f3f1KR+9iooZp7zcC9fgfFSl9VVv0zE4g/JOgwmfzXOFC0Siul+0WJ5rtV+VAunICFG/nVILfZ2QelGSCjQN9i5vGPnfRsxHIq8zhx6P3q+46f9M/m7WTHA2OwhzsEGOQImDxkSos5xZ4UlhQGoE9EAbAKKr/SowYJhAuRcrFVkGTN0ciIEKOx0im9nfPwCVyK+sUrOU6h4qjqrMx885+TJ/c9S2BJdXnKlEApcs2O9D/V7emKBODUDgzZVvQTTLLECEkq1OPM6dRTUuvGzaVmkbMj/r+M/Rx6ZAz1BK3HIHIn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tadOYNxwLu1eAEes2fKbtBZ2ma3hs9b8PX7XJEtOK8k=;
 b=Zm3HUx6g/fjhknXFPmDX4jxcoOs33oCLOS+5m35PDV9d1vnUgHWtMWDreNwzlLWrGeuojVQ0ZMwe9dyjHwOgLDPlGNQmKHtVIbov3Il01hAiGasdMJCB7P+NasL9Vl/bK0EzpVQxD5TLTHPaevTeL3+vsqTXhs4QDUkEQ+Yt5M8=
Received: from SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19)
 by BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Wed, 22 Jun
 2022 09:25:17 +0000
Received: from SN6PR12MB2782.namprd12.prod.outlook.com
 ([fe80::8531:7f90:c11f:2fb4]) by SN6PR12MB2782.namprd12.prod.outlook.com
 ([fe80::8531:7f90:c11f:2fb4%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 09:25:17 +0000
X-SNPS-Relay: synopsys.com
From:   Shahab Vahedi <Shahab.Vahedi@synopsys.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>
CC:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        "vgupta@kernel.org" <vgupta@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
Thread-Topic: [PATCH] ARC:mm:Fix syntax errors in comments
Thread-Index: AQHYhg7kChJoJXHknkW9YJewO4LLpa1bGGmAgAADmgCAAAlYgIAAAoMA
Date:   Wed, 22 Jun 2022 09:25:16 +0000
Message-ID: <46e4b588-d35b-ec50-ad1a-8502c2903677@synopsys.com>
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com>
 <YrLTCXLrr3HB39lv@debian.me>
 <4cef89c9-3b27-11e8-2971-66b93b847ede@synopsys.com>
 <alpine.DEB.2.22.394.2206220513590.2646@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2206220513590.2646@hadrien>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f19a39f5-bcf8-4aa9-b733-08da54311e94
x-ms-traffictypediagnostic: BN8PR12MB2946:EE_
x-microsoft-antispam-prvs: <BN8PR12MB29465AC577D28FCE364CDF55A6B29@BN8PR12MB2946.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UasecWSAP55HkI3c9e5o8wqeqaL6lpsoaiOzc0tn1Jg7NriLt2QEErLUrFiGBn6x2MrOSKf8Uutv7733OfOilILihFdoDxrNDM3eruiYTQ4UpTX2DkR2Tcx0EIh8WEOga82nJV1iCaYSGopgAUzVaFCf6S+PtbOjlIIMmxpsF0RiDuJYAEtfaNu9CIH6XSadkq6+DA5WvwC41qGCsqhmLCtz2w2Zto72gccO+5WwpOFE8bS+xdPQ/pUpCl8BlpGxsbL6r/CK5gC24nuNlzBsdVrOypTkxAimexdVSYp2LPA7YzpwYnEBokxdA2jN9OicKJYRj+bpPhHrdMBc38SpxGWmME01LsJ0NJrC5xb9VAo9DDH8mKQeqV+CUU0mtwk2ru5UvbXelHYNq2+LA1nhXnxiJfAq8UvuQHRJ8BwQ4VMdRhJts6J1fCkAWcrCC6KnElAe7L5aQUp76qKJgWnuHTj1rjZUaTlmhzRRlrm4w7W6uXmpCjRKQzkCnucwt4R6e64tLKtzzZqD7K/CkF650tiDCs6/QdwgJYmQaK78In2dMZaOypHE58JnSFxKu/g2ZKjhWUbVqvV7UOCWhOYfxN6i9WdtfslwSs/SB9aP6mPlXYxSxCXTwJnBNdi89dEvYcMrnAoOLRLlTIVFZmS6wSqMwxNDG1oRALXF8cxC+uN6LtDKml2Os8rWvGedXSXftWoHl895Y/970SHqxBgGQRDItiFkYGgdmOyYRaB+RhrbYD8l1KdU6jliiczs+Ripl74+iPTuptNMpmAWRxfqVbaotzkACIBr9XvT7DcgfO0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2782.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(39860400002)(376002)(366004)(76116006)(4326008)(91956017)(8676002)(53546011)(66446008)(5660300002)(54906003)(122000001)(66476007)(66946007)(36756003)(64756008)(41300700001)(8936002)(71200400001)(66556008)(186003)(26005)(6512007)(2616005)(110136005)(6506007)(478600001)(31696002)(316002)(4744005)(2906002)(38070700005)(31686004)(38100700002)(86362001)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NENxVEdONmtHeitpWHhtMXByeGJpdWxsSUlMdkg3Nk9uTGxuVnErNWVVb2hz?=
 =?utf-8?B?bDdzNjRRcGdwa2VvZmVxOVUrRUlWQkRZcUZuQlo4bEYwdUpWYmJlQXFqcS81?=
 =?utf-8?B?anVKaThCSGsrSGtwU2N1WEJJZGhTMGtoblIza3lsNHFaUzZrNDdUcHZaekRQ?=
 =?utf-8?B?UmFwOW5TYmtsQVRMeDNsZEFTdmowRWswOGhkQ0tjQ0hhM0hTcUFWdzFoRStH?=
 =?utf-8?B?cVl0YW9memhLRituQWJFckVmOS9KR0ZXL2UvbkpkRkFKcGgzNWpaY1hxK0dh?=
 =?utf-8?B?czBKS3hCTmQxeE9XSUl2RklxcCtZbkMvVHVUVnZ1eXVlcHNZWmFDK1dZSXpP?=
 =?utf-8?B?c29KWmxXd3dmSjhxc1NyZjYwMFc5RysrSFlFSThQWkU2M0J4NWxCdGlpNUxO?=
 =?utf-8?B?VmNETU9NcGZFL1pmcGc2b1pnRnl1bjZLS1BaRmFBMVA5M1dTNUE2VWEvMnBG?=
 =?utf-8?B?MzVRU0JLRDdIeis1U2VGVmxyZlBMNkpiWEgwbHV6QXhueURBblNuemJ1YmFP?=
 =?utf-8?B?amFrc01TV3RudlFKYzZUdDhobEQ0U0t2VjJncDN1YXE5dVNkYytpSGFYWXNz?=
 =?utf-8?B?UjVnelUvM01aMVU5a2lNbzNEOEtWNE1HNitzNkdZUHVjRzF6VWIyYkhTU1ZW?=
 =?utf-8?B?c1JXTWtHQWthWWxSU2l5REg2Vm8vTXgwSlhHbXJIa1RHM2d5aHVGNzNsRGsw?=
 =?utf-8?B?L1RPSmY5RDRINUZDQ0JTeW5pb3lnUXg5VENYR2Z1SHBLOXhjZWxkb3NVOU4r?=
 =?utf-8?B?ODJNNUFMaEdiRGhObXBpRVA5Q3NxTkhneXB6Q1hrMlB4cUc4QU1rVFI4NlVO?=
 =?utf-8?B?b0ZkYnFVeGRUdVlGSzRnSGxGaU5FaDJjOEE0MWJwZXdZejRPYW0xbW1mYnBQ?=
 =?utf-8?B?Rm15MEZNS2YrSWFERGR2aVRtL1NCNU9JNWhFZmNxV2ZCMWZNTy9ZWVRlMFNy?=
 =?utf-8?B?NEZieGlHWThmY2w2VlcrZENoTmRjMHpNdlNrR29vVzVLYWV3Y2hwNTNWM2Zx?=
 =?utf-8?B?azA3aFAzbkYyT3E0UW9XRXZwcEhpYUtVOUxrYkViYVZBNG02SmJFQjlJQ2Fl?=
 =?utf-8?B?bVJ6OFJ5QXBDNlY0SXYvM0c2ODlhSTE2aTlhdUNoQ0tLSHZiVGRQTjBWMVM1?=
 =?utf-8?B?WjZKcmw2YjVNTEowb0twVGNLT1JyNUNxRnE2a01xN1JxTEFGM3dXUjMwQXhQ?=
 =?utf-8?B?cUNiMEl1OTd6NWFwcVpLVncwTzFCNjJaSTBMTndGZlFqNUdHQ2NRU2tpZzY5?=
 =?utf-8?B?Z20vSjR2UzRxRkhoMG8rSmN4NUhDSVhDMVFQalMrQ0xBbS9SU1FncUxKMm9m?=
 =?utf-8?B?akZpUWdxa1V1RVFDUjU0Q2pXbktPNVV4Y29IY1ZJRWVNRmt1NkFuZzNzQ0Rm?=
 =?utf-8?B?TCtWL3Rzb01KdGp5UmpIQTdRZDBJQm5BdE5KcEp6TFBRSHBCS0liYUtkdnVt?=
 =?utf-8?B?OEhjS085d3p4cHhhWFozN3dtQ1hvMmhYc3E2MW11UFZrNDhxZ1JBOUJxbG5T?=
 =?utf-8?B?YlBwQnVYNlhFTUs5d1dPZkI2eDJDaUE1OFl0VGVWUDBYWXozMGpyV2xEbjRN?=
 =?utf-8?B?VTZQN2taTk1ib2ZFRGlneE9uZW5nK1RFT2laOVFSWm5zVW5UWis5NDJmTzBM?=
 =?utf-8?B?ZVNYK1U4aXRQbFRwWEFXdWNYRlI4TThZZ1FXLzczVHZkWkJqRDk5UExIWGY5?=
 =?utf-8?B?MG8zek1la09pN3BFdG55L1puanpnNGtnU21hMUcyOU9xR2xHV1ZoL01UYTZO?=
 =?utf-8?B?K1hRTDNtcUdzK2VnN2JkdEtGeFRhZ0x6c0t0ak1xYzFHUGRiK2RadDB6UXJL?=
 =?utf-8?B?K3FqWXBwVitucmY1K3crT091NHVtaHFhRTlEYktQT1ZRdk0wV3BJd1NkaUh0?=
 =?utf-8?B?dmZQN0k4VjBrc0RTT0lPRHpBOHFjeG4xSktoeFhNYkVzeEIzNHdQQnZZVEQ0?=
 =?utf-8?B?dDI3Tk5YQ3B4MkRLcnVOdytPWWhiNkJuVUpodGRZeHlkajFaejhYNEMyRDYx?=
 =?utf-8?B?SXN6dnRSZEtIMGJzRld4R3daSW80R0ovcDY3SzF1UkNMcFArNzRHVHoyT3B6?=
 =?utf-8?B?eEZ1OTUxMWwxV2hleEdNczNtVmpDeG9WQTdqRml4Rit6dVZsN0RKY3YwQ2pp?=
 =?utf-8?B?c3hBdHJKSThmNVBqQW5jV0wzVHdTYUwwUlNNUTBEYzg0bjdHQXdFNGIwYnBC?=
 =?utf-8?B?UHhzdTZRTXhKdmE5NjExVjYySXlwYWR2Q3ZBdG9DNXVHT0NrZUNxVVdpTGh1?=
 =?utf-8?B?NzR0NkxUT2dSWlo1bXZVYXFkY0VZTUhRQWIwSzhBTC9zV3pVOTFLSGFwVnZt?=
 =?utf-8?B?c1hNWEJINWc2RnNmSFZXSzRYVTZuKzQrcDhaY3RuditjbTB1bDI3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5F149CB662CEE4AA1F1B480723D5F4E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19a39f5-bcf8-4aa9-b733-08da54311e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 09:25:16.9071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7lvGom/8k4f1wF535JRBHsco0P3WbzFbWpR5Y/R8H1HMRTWwinT63fwtsLOAsxuHjrLs5D89sd+g6GEhJAl1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMi8yMiAxMToxNiwgSnVsaWEgTGF3YWxsIHdyb3RlOg0KPiANCj4gDQo+IE9uIFdlZCwg
MjIgSnVuIDIwMjIsIFNoYWhhYiBWYWhlZGkgd3JvdGU6DQo+IA0KPj4gT24gNi8yMi8yMiAxMDoz
MCwgQmFnYXMgU2FuamF5YSB3cm90ZToNCj4+DQo+Pj4gSSB0aGluayB0aGF0IHRoaXMga2luZCBv
ZiBjbGVhbnVwIHBhdGNoZXMgKHR5cG9maXhlcykgYXJlIGJlc3QgZG9uZQ0KPj4+IGFzIHBhcnQg
b2YgKiphY3R1YWwqKiB3b3JrIG9uIHRoZSBjb2RlIGluIHF1ZXN0aW9uIChmb3IgZXhhbXBsZQ0K
Pj4+IHJlZmFjdG9yaW5nIG9yIGZpeGluZyBidWlsZCBlcnJvcnMpLg0KPj4NCj4+IEFtZW4hDQo+
IA0KPiBTbyBjb2RlIHRoYXQgaXMgZmluZSB3aWxsIGhhdmUgdHlwb3MgZm9yZXZlcj8gIEZpeGlu
ZyB0eXBvcyBpbiBjb21tZW50cw0KPiBkb2Vzbid0IGJyZWFrIGdpdCBibGFtZSBmb3IgdGhlIGZv
bGxvd2luZyBjb2RlLiAgQW5kIHR5cG9zIGluIGNvbW1lbnRzDQo+IGdpdmUgYSBiYWQgaW1wcmVz
c2lvbiBhYm91dCB0aGUgc3RhdGUgb2YgdGhlIGNvZGUgaW4gZ2VuZXJhbC4NCg0KT2YgY291cnNl
IG5vdCEgRG9jdW1lbnRhdGlvbiBpcyBhcyBpbXBvcnRhbnQgYXMgdGhlIGNvZGUsIGlmIG5vdCBl
dmVuIG1vcmUuDQpIb3dldmVyLCBmaXhpbmcgdHlwb3MgdG8gaW5jcmVhc2UgeW91ciBjb21taXQg
Y291bnRzIHRvIGEgcmVwdXRhYmxlIHByb2plY3QNCmlzIG5vdCBmaW5lIGVpdGhlci4gRm9yIGlu
c3RhbmNlLCBtYW55IG9mIHRoZXNlIHByb3Bvc2VkIGZpeGVzIGFyZSB0YXJnZXRpbmcNCm9uZSBz
aW5nbGUgdHlwbyBhdCBhIHRpbWUuIENvdWxkbid0IHRoZXkganVzdCBiZSBzZW50IGFsdG9nZXRo
ZXIhPyENCg0KLS0gDQpTaGFoYWINCg==
