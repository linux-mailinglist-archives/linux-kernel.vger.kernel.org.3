Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318FF4859DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbiAEUNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:13:51 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45315 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiAEUNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:13:43 -0500
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 16F7780002;
        Thu,  6 Jan 2022 09:13:41 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1641413621;
        bh=n38eETiKPWYVzWE9QoAA6n095byGwua1NdzKiB13Uh8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=1bM/oFN4HnX4073RXMGtJUz5sqPbOA+sKB5GrUQ3yh/5Je75JrS3e7kgoehzYV9Ev
         Pf+ZDZ6Z1TS4rCHDH2iVfE5ZS+d7Vm/im1+s/chzq/nqsr3dglrGr6xLS1UzSlolZX
         zMgBnwne4uAZIdIgy2glHF33Wh1rb0SsrE0MjEIhHwAKOJoik4XJHmzItnoudWYB3F
         rZ+uqgUxJGZRqGfnQyd0jCTVOnjE+dUkRfOuxLlcaFKGljVZFVF40wH2p6h11ejLr1
         T4sIqrWz/jmRcvJpfnNnh036r64QystbGbGwy2PSl3sUfBjFd9rnAvJzEIm955jeXr
         AV9WiQ9ySTEPw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61d5fbf50000>; Thu, 06 Jan 2022 09:13:40 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 6 Jan 2022 09:13:40 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.026; Thu, 6 Jan 2022 09:13:40 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: spi-mux: Add reference to
 spi-peripheral-props.yaml schema
Thread-Topic: [PATCH] dt-bindings: spi-mux: Add reference to
 spi-peripheral-props.yaml schema
Thread-Index: AQHYAmKiYNZ7vSm4u0GdymU9r8gTqqxUAsGA
Date:   Wed, 5 Jan 2022 20:13:39 +0000
Message-ID: <51b2c802-2414-0f03-1472-18c0e2b50f4d@alliedtelesis.co.nz>
References: <20220105183234.3426649-1-robh@kernel.org>
In-Reply-To: <20220105183234.3426649-1-robh@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C48BFA4EB49E1C4D8238E15C091A9B6F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=HvoI5HbS c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=DghFqjY3_ZEA:10 a=VwQbUJbxAAAA:8 a=jb2shDTFc6WRtqQTgaUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA2LzAxLzIyIDc6MzIgYW0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBUaGUgc3BpLW11eCBz
ZXJ2ZXMgYXMgYm90aCBhIFNQSSBwZXJpcGhlcmFsIGFuZCBjb250cm9sbGVyLCBzbyBhZGQgYQ0K
PiByZWZlcmVuY2UgdG8gc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbCBpbiBhZGRpdGlvbiB0bw0K
PiBzcGktY29udHJvbGxlci55YW1sLiBUaGlzIGlzIG5lY2Vzc2FyeSB0byBhdm9pZCB1bmV2YWx1
YXRlZFByb3BlcnRpZXMNCj4gd2FybmluZ3Mgb25jZSB0aG9zZSBhcmUgZnVsbHkgZW5hYmxlZC4N
Cj4NCj4gQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gQ2M6IENocmlzIFBh
Y2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gQ2M6IGxpbnV4LXNw
aUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxs
aWVkdGVsZXNpcy5jby5uej4NCg0KPiAtLS0NCj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc3BpL3NwaS1tdXgueWFtbCB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9zcGktbXV4LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc3BpL3NwaS1tdXgueWFtbA0KPiBpbmRleCA1MWM3NjIyZGMyMGIuLjdlYTc5ZjZkMzNmMyAx
MDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGkt
bXV4LnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9z
cGktbXV4LnlhbWwNCj4gQEAgLTMxLDYgKzMxLDcgQEAgZGVzY3JpcHRpb246IHwNCj4gICANCj4g
ICBhbGxPZjoNCj4gICAgIC0gJHJlZjogIi9zY2hlbWFzL3NwaS9zcGktY29udHJvbGxlci55YW1s
IyINCj4gKyAgLSAkcmVmOiAiL3NjaGVtYXMvc3BpL3NwaS1wZXJpcGhlcmFsLXByb3BzLnlhbWwj
Ig0KPiAgIA0KPiAgIG1haW50YWluZXJzOg0KPiAgICAgLSBDaHJpcyBQYWNraGFtIDxjaHJpcy5w
YWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+
