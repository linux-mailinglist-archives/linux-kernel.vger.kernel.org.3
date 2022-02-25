Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABED14C3AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiBYBYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiBYBYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:24:10 -0500
Received: from mg.sunplus.com (unknown [113.196.136.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7FD7223124;
        Thu, 24 Feb 2022 17:23:36 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(59919:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Fri, 25 Feb 2022 09:23:48 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 25 Feb 2022 09:23:44 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 25 Feb 2022 09:23:44 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Rob Herring <robh+dt@kernel.org>, Li-hao Kuo <lhjeff911@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH] dt-bindings: spi: delete unused required and adjust the
 item.
Thread-Topic: [PATCH] dt-bindings: spi: delete unused required and adjust the
 item.
Thread-Index: AQHYJGrUQu7iwIveQUyuGpfFvai606yiOAuAgAFJ77A=
Date:   Fri, 25 Feb 2022 01:23:44 +0000
Message-ID: <9d6bb702f9ea480f9d77cf1d44bd8f8d@sphcmbx02.sunplus.com.tw>
References: <6a86f8c481be417972ef1b1e3b902ccf95706547.1645149279.git.lhjeff911@gmail.com>
 <CAL_Jsq+tMG_8nYaZDaU2pPgy7+bXfPxATSeoJKKyR=kv=x=70g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+tMG_8nYaZDaU2pPgy7+bXfPxATSeoJKKyR=kv=x=70g@mail.gmail.com>
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

SGkgTXIuUm9iIEhlcnJpbmcgOg0KDQpJIGFtIHNvcnJ5IGZvciB0aGF0Lg0KVGhpcyBwYXRjaCB3
aWxsIGZpeCB0ZXN0aW5nIGlzc3VlcyBhcyBjbG9jayBuYW1lcyBhcmUgbm90IHVzZWQNCkNoZWNr
aW5nIGZvciBhIHBhdGNoIHdpbGwgc2hvdyBhIHdhcm5pbmcNCg0K
