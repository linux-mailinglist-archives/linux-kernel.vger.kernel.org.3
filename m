Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDABD4D85AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbiCNNHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiCNNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:07:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A056C192AE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:06:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nTkOc-00053S-TA; Mon, 14 Mar 2022 14:05:58 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nTkOa-000eWs-KI; Mon, 14 Mar 2022 14:05:55 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nTkOY-0007WY-D1; Mon, 14 Mar 2022 14:05:54 +0100
Message-ID: <1e620fa18fa34ca1f65558e3a52f79f81ff20634.camel@pengutronix.de>
Subject: Re: [PATCH v2] mmc: mmci: manage MMC_PM_KEEP_POWER per variant
 config
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>
Date:   Mon, 14 Mar 2022 14:05:54 +0100
In-Reply-To: <20220314125554.190574-1-yann.gautier@foss.st.com>
References: <20220314095225.53563-1-yann.gautier@foss.st.com>
         <20220314125554.190574-1-yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWWFubiwKCk9uIE1vLCAyMDIyLTAzLTE0IGF0IDEzOjU1ICswMTAwLCBZYW5uIEdhdXRpZXIg
d3JvdGU6Cj4gQWRkIGEgZGlzYWJsZV9rZWVwX3Bvd2VyIGZpZWxkIGluIHZhcmlhbnRfZGF0YSBz
dHJ1Y3QuIFRoZQo+IE1NQ19QTV9LRUVQX1BPV0VSIGZsYWcgd2lsbCBiZSBlbmFibGVkIGlmIGRp
c2FibGVfa2VlcF9wb3dlciBpcyBub3QKPiBzZXQuCj4gSXQgaXMgb25seSBzZXQgdG8gdHJ1ZSBm
b3Igc3RtMzJfc2RtbWMgdmFyaWFudHMuCj4gCj4gVGhlIGlzc3VlIHdhcyBzZWVuIG9uIFNUTTMy
TVAxNTdDLURLMiBib2FyZCwgd2hpY2ggZW1iZWRzIGEgd2lmaQo+IGNoaXAuCj4gSXQgZG9lc24n
dCBjb3JyZWN0bHkgc3VwcG9ydCBsb3cgcG93ZXIgb24gdGhpcyBib2FyZC4gVGhlIFdpZmkgY2hp
cAo+IGF3YWl0cyBhbiBhbHdheXMtb24gcmVndWxhdG9yLCBidXQgaXQgd2FzIGNvbm5lY3RlZCB0
byB2M3YzIHdoaWNoIGlzCj4gb2ZmCj4gaW4gbG93LXBvd2VyIHNlcXVlbmNlLiBNTUNfUE1fS0VF
UF9QT1dFUiBzaG91bGQgdGhlbiBiZSBkaXNhYmxlZC4KPiAKPiBUaGUgZmxhZyBjYW4gc3RpbGwg
YmUgZW5hYmxlZCB0aHJvdWdoIERUIHByb3BlcnR5Ogo+IGtlZXAtcG93ZXItaW4tc3VzcGVuZC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBZYW5uIEdhdXRpZXIgPHlhbm4uZ2F1dGllckBmb3NzLnN0LmNv
bT4KPiAtLS0KPiBVcGRhdGUgaW4gdjI6Cj4gUmV3b3JkIGNvbW1pdCBtZXNzYWdlIHRvIGJldHRl
ciBleHBsYWluIHRoZSBpc3N1ZS4KPiAKPiBSZXNlbmQgdGhlIHBhdGNoIGFsb25lLiBJdCB3YXMg
cHJldmlvdWxzeSBpbiBhIHNlcmllcyBbMV0gZm9yIHdoaWNoCj4gdGhlCj4gb3RoZXIgcGF0Y2hl
cyB3aWxsIGJlIHJld29ya2VkLgo+IAo+IFsxXSAKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzIwMjIwMzA0MTM1MTM0LjQ3ODI3LTEteWFubi5nYXV0aWVyQGZvc3Muc3QuY29tLwo+IAo+
IMKgZHJpdmVycy9tbWMvaG9zdC9tbWNpLmMgfCA1ICsrKystCj4gwqBkcml2ZXJzL21tYy9ob3N0
L21tY2kuaCB8IDEgKwo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tbWNpLmMgYi9kcml2
ZXJzL21tYy9ob3N0L21tY2kuYwo+IGluZGV4IDQ1Yjg2MDhjOTM1Yy4uMGUyZjJmNWQ2YTUyIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5jCj4gKysrIGIvZHJpdmVycy9tbWMv
aG9zdC9tbWNpLmMKPiBAQCAtMjc0LDYgKzI3NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmFyaWFudF9k
YXRhIHZhcmlhbnRfc3RtMzJfc2RtbWMgPQo+IHsKPiDCoMKgwqDCoMKgwqDCoMKgLmJ1c3lfZGV0
ZWN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPSB0cnVlLAo+IMKgwqDCoMKgwqDCoMKgwqAuYnVz
eV9kZXRlY3RfZmxhZ8KgwqDCoMKgwqDCoMKgPSBNQ0lfU1RNMzJfQlVTWUQwLAo+IMKgwqDCoMKg
wqDCoMKgwqAuYnVzeV9kZXRlY3RfbWFza8KgwqDCoMKgwqDCoMKgPSBNQ0lfU1RNMzJfQlVTWUQw
RU5ETUFTSywKPiArwqDCoMKgwqDCoMKgwqAuZGlzYWJsZV9rZWVwX3Bvd2VywqDCoMKgwqDCoD0g
dHJ1ZSwKPiDCoMKgwqDCoMKgwqDCoMKgLmluaXTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoD0gc2RtbWNfdmFyaWFudF9pbml0LAo+IMKgfTsKPiDCoAo+IEBAIC0zMDEsNiAr
MzAyLDcgQEAgc3RhdGljIHN0cnVjdCB2YXJpYW50X2RhdGEgdmFyaWFudF9zdG0zMl9zZG1tY3Yy
Cj4gPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoC5idXN5X2RldGVjdMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoD0gdHJ1ZSwKPiDCoMKgwqDCoMKgwqDCoMKgLmJ1c3lfZGV0ZWN0X2ZsYWfCoMKgwqDCoMKg
wqDCoD0gTUNJX1NUTTMyX0JVU1lEMCwKPiDCoMKgwqDCoMKgwqDCoMKgLmJ1c3lfZGV0ZWN0X21h
c2vCoMKgwqDCoMKgwqDCoD0gTUNJX1NUTTMyX0JVU1lEMEVORE1BU0ssCj4gK8KgwqDCoMKgwqDC
oMKgLmRpc2FibGVfa2VlcF9wb3dlcsKgwqDCoMKgwqA9IHRydWUsCj4gwqDCoMKgwqDCoMKgwqDC
oC5pbml0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA9IHNkbW1jX3Zhcmlh
bnRfaW5pdCwKPiDCoH07Cj4gwqAKPiBAQCAtMjE3Miw3ICsyMTc0LDggQEAgc3RhdGljIGludCBt
bWNpX3Byb2JlKHN0cnVjdCBhbWJhX2RldmljZSAqZGV2LAo+IMKgwqDCoMKgwqDCoMKgwqBob3N0
LT5zdG9wX2Fib3J0LmZsYWdzID0gTU1DX1JTUF9SMUIgfCBNTUNfQ01EX0FDOwo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoC8qIFdlIHN1cHBvcnQgdGhlc2UgUE0gY2FwYWJpbGl0aWVzLiAqLwo+IC3C
oMKgwqDCoMKgwqDCoG1tYy0+cG1fY2FwcyB8PSBNTUNfUE1fS0VFUF9QT1dFUjsKPiArwqDCoMKg
wqDCoMKgwqBpZiAoIXZhcmlhbnQtPmRpc2FibGVfa2VlcF9wb3dlcikKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgbW1jLT5wbV9jYXBzIHw9IE1NQ19QTV9LRUVQX1BPV0VSOwo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoC8qCj4gwqDCoMKgwqDCoMKgwqDCoCAqIFdlIGNhbiBkbyBTR0lP
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5oIGIvZHJpdmVycy9tbWMvaG9z
dC9tbWNpLmgKPiBpbmRleCBlMWE5Yjk2YTMzOTYuLjJjYWQxZWY5NzY2YSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL21tYy9ob3N0L21tY2kuaAo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5o
Cj4gQEAgLTM2MSw2ICszNjEsNyBAQCBzdHJ1Y3QgdmFyaWFudF9kYXRhIHsKPiDCoMKgwqDCoMKg
wqDCoMKgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb3BlbmRy
YWluOwo+IMKgwqDCoMKgwqDCoMKgwqB1OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZG1hX2xsaToxOwo+IMKgwqDCoMKgwqDCoMKgwqB1MzLCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdG0zMl9pZG1hYnNpemVfbWFzazsKPiArwqDC
oMKgwqDCoMKgwqB1OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZGlzYWJsZV9rZWVwX3Bvd2VyOjE7CgpUaGVyZSBhcmUgYWxyZWFkeSBmb3VyIHNlcGFyYXRlIGJp
dGZpZWxkcyBpbiBzdHJ1Y3QgdmFyaWFudF9kYXRhLCB3aHkKbm90IG1vdmUgdGhpcyB1cCBpbnRv
IG9uZSBvZiB0aGVtPwoKcmVnYXJkcwpQaGlsaXBwCg==

