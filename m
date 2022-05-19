Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CBE52C9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiESC3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiESC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:29:45 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2ED2C6E64
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:29:19 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(12590:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 19 May 2022 10:16:53 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Thu, 19 May 2022 10:16:50 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Thu, 19 May 2022 10:16:50 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v15 05/10] clk: Add Sunplus SP7021 clock driver
Thread-Topic: [PATCH v15 05/10] clk: Add Sunplus SP7021 clock driver
Thread-Index: AQHYZcsXCsTwSBsje0a2OPS1GfS78a0h1u8AgADuCPCAAdLagIAA6WiQ
Date:   Thu, 19 May 2022 02:16:50 +0000
Message-ID: <7fcb969a0d0740459a9ebc403aeb556f@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <9a71d17e9c70051db44c5545453ae8320ed8e0f8.1652329411.git.qinjian@cqplus1.com>
 <20220517021755.F1D05C385B8@smtp.kernel.org>
 <7febed72ae2747abb953a6f44a51102c@cqplus1.com>
 <20220518202049.6055BC385A9@smtp.kernel.org>
In-Reply-To: <20220518202049.6055BC385A9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGZfcXVv
dGllbnQgID0gZGYgLyBtOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRmX3JlbWFpbmRlciA9ICgoZGYgJSBtKSAqIDEwMDApIC8gbTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChmcmVxID4gZGZfcXVvdGllbnQp
IHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRmX3F1
b3RpZW50ICA9IGZyZXEgLSBkZl9xdW90aWVudCAtIDE7DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkZl9yZW1haW5kZXIgPSAxMDAwIC0gZGZfcmVtYWlu
ZGVyOw0KPiA+ID4NCj4gPiA+IFdoZXJlIGRvZXMgMTAwMCBjb21lIGZyb20/DQo+ID4NCj4gPiAx
MDAwIGlzIGNvbWUgZnJvbSAiYm9ycm93IDEiIGluIGxhc3Qgb3BlcmF0aW9uLg0KPiANCj4gSXQn
cyBzY2FsaW5nIHRoZSB2YWx1ZSByaWdodD8gV2hhdCBpcyBiZWluZyBzY2FsZWQ/IEFyZSB3ZSBj
b252ZXJ0aW5nDQo+IHVuaXRzIHRvIEh6IGZyb20ga0h6Pw0KDQpIZXJlIGp1c3QgdXNpbmcgaW50
ZWdlciByZXBsYWNlbWVudCBmbG9hdGluZyBwb2ludCBvcGVyYXRpb24sIGZvciBleGFtcGxlOg0K
ZGYgPSAxMywgbSA9IDMNCjEzIC8gMyA9IDQuMzMzMzMzMzMNCmRmX3F1b3RpZW50ID0gNA0KZGZf
cmVtYWluZGVyID0gMC4zMzMzMzMzICogMTAwMCAoYWNjdXJhdGUgdG8gMyBkZWNpbWFsIHBsYWNl
cykgPSAzMzMNCg0K
