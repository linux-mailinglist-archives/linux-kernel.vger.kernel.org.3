Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFED58FD45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiHKNT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiHKNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:19:56 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8908F80534;
        Thu, 11 Aug 2022 06:19:55 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 250D3FF805;
        Thu, 11 Aug 2022 13:19:50 +0000 (UTC)
Message-ID: <32f116c30f1f071d57e8e2d15425178cbccf9b70.camel@hadess.net>
Subject: Re: [PATCH v2] Input: joystick: xpad: Add X-Box Adaptive Controller
 support
From:   Bastien Nocera <hadess@hadess.net>
To:     Nate Yocom <nate@yocom.org>, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Aug 2022 15:19:50 +0200
In-Reply-To: <20220810141511.11827-1-nate@yocom.org>
References: <20220810141511.11827-1-nate@yocom.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5LAoKT24gV2VkLCAyMDIyLTA4LTEwIGF0IDA3OjE1IC0wNzAwLCBOYXRlIFlvY29tIHdyb3Rl
Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiBYLUJveCBBZGFwdGl2ZSBjb250cm9sbGVyIHNldHMgMHgwMiB3aGVu
IHgtYm94Cj4gYnV0dG9uIGlzIHByZXNzZWQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIHdlIGNvdWxkIHByb2JhYmx5IGNvbmRlbnNlIGludG8ganVzdCBkYXRhWzRdICE9IDAs
Cj4gYnV0IGV4cGxpY2l0bHkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogY2hl
Y2tpbmcgaGVyZSBlbnN1cmVzIG5vIHJlZ3Jlc3Npb24gaWYgb3RoZXIKPiBkZXZpY2VzIHNldCBv
dGhlciBiaXRzLgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGxlMTZfdG9fY3B1KHhwYWQtPmRldi0+aWQudmVu
ZG9yKSA9PSAweDA0NWUgJiYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGxlMTZfdG9fY3B1KHhwYWQtPmRldi0+aWQucHJvZHVjdCkgPT0gMHgwYjBhKQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW5wdXRfcmVw
b3J0X2tleShkZXYsIEJUTl9NT0RFLCBkYXRhWzRdICYKPiAweDAyKTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaW5wdXRfcmVwb3J0X2tleShkZXYsIEJUTl9NT0RFLCBkYXRhWzRdICYK
PiAweDAxKTsKCgpJIHdvbid0IGJlIGFibGUgdG8gdGVzdCB0aGUgcGF0Y2ggdW50aWwgbmV4dCB3
ZWVrLCBidXQgSSB3b3VsZCBhY3R1YWxseQppbXBsZW1lbnQgd2hhdCB5b3UgbWVudGlvbiBpbiB0
aGUgY29tbWVudCBhcyBhIHNlcGFyYXRlIHBhdGNoLiBUaGlzCndvdWxkIGF2b2lkIGhhdmluZyBh
IHNwZWNpYWwtY2FzZSBmb3IgYSBzcGVjaWZpYyBWSUQvUElEIHdpdGhvdXQgYQpxdWlyayBsaWtl
ICJNQVBfTEFZRVJfQlVUVE9OIiBkZWZpbmVkLCBhbmQgaWYgaXQgd2VyZSB0byBjYXVzZQpwcm9i
bGVtcywgaXQgd291bGQgYmUgc3RyYWlnaHQgZm9yd2FyZCB0byByZXZlcnQuCg==

