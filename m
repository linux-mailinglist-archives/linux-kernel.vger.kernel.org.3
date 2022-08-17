Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE54596CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbiHQKhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiHQKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:37:38 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01152FC4;
        Wed, 17 Aug 2022 03:37:36 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id EA13740006;
        Wed, 17 Aug 2022 10:37:34 +0000 (UTC)
Message-ID: <2a521e4f327778e390f344da16c9df0b6dea82fb.camel@hadess.net>
Subject: Re: [PATCH v3 3/3] Input: joystick: xpad: Add X-Box Adaptive
 Controller XBox button
From:   Bastien Nocera <hadess@hadess.net>
To:     Nate Yocom <nate@yocom.org>, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 Aug 2022 12:37:34 +0200
In-Reply-To: <20220813185343.2306-4-nate@yocom.org>
References: <20220813185343.2306-1-nate@yocom.org>
         <20220813185343.2306-4-nate@yocom.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIyLTA4LTEzIGF0IDExOjUzIC0wNzAwLCBOYXRlIFlvY29tIHdyb3RlOgo+IEFk
YXB0aXZlIGNvbnRyb2xsZXIgc2V0cyAweDAyIGJpdCBmb3IgdGhpcyBidXR0b24sIGFsbCBvdGhl
cnMgc2V0Cj4gMHgwMQo+IHNvIHByZXNlbmNlIG9mIGVpdGhlciBpcyB1c2VkIGZvciBCVE5fTU9E
RS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBOYXRlIFlvY29tIDxuYXRlQHlvY29tLm9yZz4KClRlc3Rl
ZC1ieTogQmFzdGllbiBOb2NlcmEgPGhhZGVzc0BoYWRlc3MubmV0PgoKPiAtLS0KPiDCoGRyaXZl
cnMvaW5wdXQvam95c3RpY2sveHBhZC5jIHwgMiArLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQv
am95c3RpY2sveHBhZC5jCj4gYi9kcml2ZXJzL2lucHV0L2pveXN0aWNrL3hwYWQuYwo+IGluZGV4
IDgzYTRmNGQwN2FmNS4uYmVhNzE3MjFiNmNkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW5wdXQv
am95c3RpY2sveHBhZC5jCj4gKysrIGIvZHJpdmVycy9pbnB1dC9qb3lzdGljay94cGFkLmMKPiBA
QCAtODU5LDcgKzg1OSw3IEBAIHN0YXRpYyB2b2lkIHhwYWRvbmVfcHJvY2Vzc19wYWNrZXQoc3Ry
dWN0Cj4gdXNiX3hwYWQgKnhwYWQsIHUxNiBjbWQsIHVuc2lnbmVkIGNoYXIKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChkYXRhWzFdID09IDB4MzApCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeHBhZG9uZV9hY2tfbW9kZV9yZXBv
cnQoeHBhZCwgZGF0YVsyXSk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aW5wdXRfcmVwb3J0X2tleShkZXYsIEJUTl9NT0RFLCBkYXRhWzRdICYgMHgwMSk7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlucHV0X3JlcG9ydF9rZXkoZGV2LCBCVE5fTU9ERSwg
ZGF0YVs0XSAmIDB4MDMpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW5wdXRf
c3luYyhkZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+IMKg
wqDCoMKgwqDCoMKgwqB9Cgo=

