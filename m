Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D23476C24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhLPIpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:45:43 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:42002 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229646AbhLPIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:45:42 -0500
X-UUID: 6ab9d8dc949f4d18b3b4579c80217e84-20211216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+IojS5yeYRx75FMM30KE+W/+YeDH20EiSGjnrXmbJa4=;
        b=s4gvNvjIopQ3LELm09NUh80VGh8Lh4g7QNvaWaVKBbvSuBjRd2ISLWWLLfpSgadsQux6iGipcQy70E026LQ2P6FgHQUhDF9ep91d//aEZUj4RtkMUwu+RPHEq4+3aDlsH0ndyvt5ylotH7xErFF0IFYDjjZHfxGkoUrfqR8DQzs=;
X-UUID: 6ab9d8dc949f4d18b3b4579c80217e84-20211216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1899851698; Thu, 16 Dec 2021 16:45:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Dec 2021 16:45:39 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Dec 2021 16:45:39 +0800
Message-ID: <e04620d000dfa009bceeaca0a18d17a6be81f706.camel@mediatek.com>
Subject: Re: [PATCH 1/3] usb: mtu3: fix interval value for intr and isoc
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Yuwen Ng" <yuwen.ng@mediatek.com>
Date:   Thu, 16 Dec 2021 16:45:40 +0800
In-Reply-To: <YbdWmQMck/WGYJ4/@kroah.com>
References: <20211209031424.17842-1-chunfeng.yun@mediatek.com>
         <YbdWmQMck/WGYJ4/@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTEyLTEzIGF0IDE1OjIwICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFRodSwgRGVjIDA5LCAyMDIxIGF0IDExOjE0OjIyQU0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBVc2UgdGhlIEludGVydmFsIHZhbHVlIGZyb20gaXNvYy9pbnRyIGVu
ZHBvaW50IGRlc2NyaXB0b3IsIG5vIG5lZWQNCj4gPiBtaW51cyBvbmUuIEJ1dCB0aGUgb3JpZ2lu
YWwgY29kZSBkb2Vzbid0IGNhdXNlIHRyYW5zZmVyIGVycm9yIGZvcg0KPiA+IG5vcm1hbCBjYXNl
cywgZHVlIHRvIHRoZSBpbnRlcnZhbCBpcyBsZXNzIHRoYW4gdGhlIGhvc3QgcmVxdWVzdC4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYyB8IDQg
KystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gV2hhdCBjb21taXQgZG9lcyB0aGlzIGZpeD8NClRoZSBpbnRlcnZhbCBiZXR3ZWVu
IHRyYW5zZmVycyBpcyBsZXNzIHRoYW4gdGhlIEludGVydmFsIHZhbHVlLCBJIGFkZA0KaXQgaW4g
Y29tbWl0IG1hc3NhZ2Ugd2hlbiBzZW5kIG91dCB2Mi4NCg0KVGhhbmtzDQo=

