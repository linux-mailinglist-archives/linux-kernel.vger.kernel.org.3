Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BD94736B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbhLMVsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhLMVsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:48:14 -0500
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4F31C061574;
        Mon, 13 Dec 2021 13:48:13 -0800 (PST)
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id C1B375DE21;
        Mon, 13 Dec 2021 22:47:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1639432047;
        bh=8MLStIcjR5HoWQ3NibZfosIq24yPRCNRoV7ELKJOOMI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZIawwt2bNFY9gqv6HsdZmKwGijlpiB4YG6UXTW0k8J/CiU3JaqOZNKvOqs/4CRMqw
         ypWmwibStNBnvcJdOiwFJUPZAVSl5+/jIyGnFiCDZrEzM7GPtpVCjQIHODr9XFhfth
         S15uwZrDTZo7bDpmd7G/7SLjHR/XHXpgS/4Ae0V2FONSt1pRjhdQcLe90EwANZkR3h
         DC9kjoxlyPewJJEgoA1ly/5CpuH6JH0kRMdHMeMCbJCGUdpacBWDvxkTU5LaAMDEii
         cZnA5WoKJRyDn6FAbhvScENWgYi3vwdo1Kk99W2U/xxQSZx7bm6q+tJ5PZC2TrRLNr
         Fxs031skqY2fg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 13 Dec 2021 22:47:14 +0100
Received: from DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579]) by
 DHPWEX01.DH-ELECTRONICS.ORG ([fe80::6ced:fa7f:9a9c:e579%6]) with mapi id
 15.02.0986.014; Mon, 13 Dec 2021 22:47:14 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Topic: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Index: AdfwANztWgHN3oJ0TZqwlPeCV8dlmAAJNrwAABE2QuA=
Date:   Mon, 13 Dec 2021 21:47:14 +0000
Message-ID: <97b298dcf6614cfca5ece40284779b47@dh-electronics.com>
References: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
 <1450af96-f279-c545-20a0-9361a070ca13@norik.com>
In-Reply-To: <1450af96-f279-c545-20a0-9361a070ca13@norik.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.51.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5kcmVqIFBpY2VqDQpTZW50OiBNb25kYXksIERlY2VtYmVyIDEzLCAyMDIxIDM6MzEg
UE0NClsuLi5dDQo+PiBAQW5kcmVqDQo+PiBJIGd1ZXNzLCB5b3UgYXJlIHVzaW5nIGFuIGV4dGVy
bmFsIG9zY2lsbGF0b3IsIGFyZW4ndCB5b3U/DQo+IA0KPiBZb3UgYXJlIGNvcnJlY3QsIHdlIGFy
ZSB1c2luZyBleHRlcm5hbCBvc2NpbGxhdG9yICgzMiw3NjhLSHopLg0KDQoNClRoYW5rcyBmb3Ig
dGhlIGluZm8uDQoNCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
