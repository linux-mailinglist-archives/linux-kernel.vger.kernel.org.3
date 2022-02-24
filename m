Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159974C317A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiBXQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiBXQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:32:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D491113ACB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:31:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nNH1V-0007S9-Nb; Thu, 24 Feb 2022 17:31:21 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nNH1V-00136X-AD; Thu, 24 Feb 2022 17:31:20 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nNH1T-000Bf8-RW; Thu, 24 Feb 2022 17:31:19 +0100
Message-ID: <234b9fd5d3125e071717b06635ff28afe87b3686.camel@pengutronix.de>
Subject: Re: [PATCH v4 14/16] dt-bindings: reset: add ipq8064 ce5 resets
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Feb 2022 17:31:19 +0100
In-Reply-To: <20220217235703.26641-15-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
         <20220217235703.26641-15-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnIsIDIwMjItMDItMTggYXQgMDA6NTcgKzAxMDAsIEFuc3VlbCBTbWl0aCB3cm90ZToKPiBB
ZGQgaXBxODA2NCBjZTUgcmVzZXRzIG5lZWRlZCBmb3IgQ3J5cHRvRW5naW5lIGdjYyBkcml2ZXIu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogQW5zdWVsIFNtaXRoIDxhbnN1ZWxzbXRoQGdtYWlsLmNvbT4K
PiAtLS0KPiDCoGluY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvcWNvbSxnY2MtaXBxODA2eC5oIHwg
NSArKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL3Jlc2V0L3Fjb20sZ2NjLWlwcTgwNnguaAo+IGIvaW5j
bHVkZS9kdC1iaW5kaW5ncy9yZXNldC9xY29tLGdjYy1pcHE4MDZ4LmgKPiBpbmRleCAyNmI2Zjky
MDA2MjAuLjAyMGM5Y2YxODc1MSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL3Jl
c2V0L3Fjb20sZ2NjLWlwcTgwNnguaAo+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQv
cWNvbSxnY2MtaXBxODA2eC5oCj4gQEAgLTE2Myw1ICsxNjMsMTAgQEAKPiDCoCNkZWZpbmUgTlNT
X0NBTF9QUkJTX1JTVF9OX1JFU0VUwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoDE1NAo+IMKgI2RlZmluZSBOU1NfTENLRFRfUlNUX05fUkVTRVTCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTU1Cj4gwqAjZGVmaW5l
IE5TU19TUkRTX05fUkVTRVTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoDE1Ngo+ICsjZGVmaW5lIENSWVBUT19FTkcxX1JFU0VUwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
MTU3Cj4gKyNkZWZpbmUgQ1JZUFRPX0VORzJfUkVTRVTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAxNTgKPiArI2RlZmluZSBDUllQVE9f
RU5HM19SRVNFVMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoDE1OQo+ICsjZGVmaW5lIENSWVBUT19FTkc0X1JFU0VUwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTYwCj4gKyNk
ZWZpbmUgQ1JZUFRPX0FIQl9SRVNFVMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTYxCj4gwqAKPiDCoCNlbmRpZgoKQWNrZWQtYnk6
IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+CgpyZWdhcmRzClBoaWxpcHAK


