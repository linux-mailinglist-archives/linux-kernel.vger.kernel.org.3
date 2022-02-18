Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA01E4BAF7B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiBRCNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:13:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiBRCNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:13:42 -0500
X-Greylist: delayed 865 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 18:13:24 PST
Received: from mg.sunplus.com (unknown [113.196.136.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10BC71FFCA6;
        Thu, 17 Feb 2022 18:13:23 -0800 (PST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(59923:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Fri, 18 Feb 2022 09:59:09 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 18 Feb 2022 09:59:09 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 18 Feb 2022 09:59:09 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Rob Herring <robh+dt@kernel.org>, Li-hao Kuo <lhjeff911@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH next] dt-bindings:spi: Fix test error for sp7021.
Thread-Topic: [PATCH next] dt-bindings:spi: Fix test error for sp7021.
Thread-Index: AQHYG8SUWkFwbvI1JkilCYvvnr8tzayXz90AgADOVTA=
Date:   Fri, 18 Feb 2022 01:59:09 +0000
Message-ID: <ad180b25cbe347f2bd1ae41da651efda@sphcmbx02.sunplus.com.tw>
References: <b8a94fbfcab68b1279b09b6297099310c209927b.1644198244.git.lhjeff911@gmail.com>
 <CAL_JsqJO=4A5f_26KNcoMWJj3YWxd=qnwE7V90MUCW9muYtH1g@mail.gmail.com>
In-Reply-To: <CAL_JsqJO=4A5f_26KNcoMWJj3YWxd=qnwE7V90MUCW9muYtH1g@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuIEkgaGF2ZSBzZW50IGEgcGF0Y2ggdG8gZml4IGl0Lg0K
DQo=
