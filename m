Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4B4AB412
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244615AbiBGFvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbiBGDsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:48:06 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD0FC061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 19:48:04 -0800 (PST)
X-UUID: 3f2e744b2750484ea08f7544dcb35fcc-20220207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=NgS5Z68GQOLnfRkUxlxi5corvWei8pAm2FGb8qrHoTk=;
        b=gVUcUlsJKcZwkO8V3RXBxVhB53youXBtsrB51W7EWN/se/oBZjU938JZkvbl0+ZEU4CsDwgMdPL9uCRE6QuR9bkOviKZxoKfnNpCTe/nuzqaw+evU+DuBubp9XgI/nT9rIJIEE3cHY5Re3gdQPGCCvl+q83y6QDrYMi8vKDYJBs=;
X-UUID: 3f2e744b2750484ea08f7544dcb35fcc-20220207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1101263638; Mon, 07 Feb 2022 11:48:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Feb 2022 11:48:00 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Feb 2022 11:48:00 +0800
Subject: Re: [PATCH 0/3] support USB offload feature
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <CGME20220203030000epcas2p2a924a55a5ae60e8685cd62b66a5482f3@epcas2p2.samsung.com>
 <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
 <27337aa9-2bfd-18d5-cded-7f8ae0f053d9@linux.intel.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <df83f981-8146-576a-c7a5-420aa2dd4b72@mediatek.com>
Date:   Mon, 7 Feb 2022 11:48:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <27337aa9-2bfd-18d5-cded-7f8ae0f053d9@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8zLzIyIDU6MzMgUE0sIE1hdGhpYXMgTnltYW4gd3JvdGU6DQo+IE9uIDMuMi4yMDIyIDQu
NTcsIERhZWh3YW4gSnVuZyB3cm90ZToNCj4+IFRoaXMgcGF0Y2hzZXQgaXMgZm9yIFVTQiBvZmZs
b2FkIGZlYXR1cmUsIHdoaWNoIG1ha2VzIENvLXByb2Nlc3NvciB0byB1c2UNCj4+IHNvbWUgbWVt
b3JpZXMgb2YgeGhjaS4gRXNwZWNpYWxseSBpdCdzIHVzZWZ1bCBmb3IgVVNCIEF1ZGlvIHNjZW5h
cmlvLg0KPj4gQXVkaW8gc3RyZWFtIHdvdWxkIGdldCBzaG9ydGN1dCBiZWNhdXNlIENvLXByb2Nl
c3NvciBkaXJlY3RseSB3cml0ZS9yZWFkDQo+PiBkYXRhIGluIHhoY2kgbWVtb3JpZXMuIEl0IGNv
dWxkIGdldCBzcGVlZC11cCB1c2luZyBmYXN0ZXIgbWVtb3J5IGxpa2UgU1JBTS4NCj4+IFRoYXQn
cyB3aHkgdGhpcyBhbHNvIGdpdmVzIHZlbmRvcnMgZmxleGliaWx0eSBvZiBtZW1vcnkgbWFuYWdl
bWVudC4NCj4+IEJlbG93IHBhdGhjaGVzIGhhdmUgYmVlbiBtZXJnZWQgaW4gQU9TUCBrZXJuZWwo
YW5kcm9pZDEyLTUuMTApIGFuZCBJIHB1dA0KPj4gdG9nZXRoZXIgYW5kIHNwbGl0IGludG8gMyBw
YXRjaGVzLg0KPiANCj4gQ2FuIHlvdSBzaGFyZSB0aGUgZnVsbCBVU0Igb2ZmbG9hZCBzdXBwb3J0
IHNlcmllcz8NCj4gDQo+IEknZCBsaWtlIHRvIHNlZSB0aGUgYmlnIHBpY3R1cmUgYmVmb3JlIHRh
a2luZyBhbnkgZXhwb3J0aW5nIGFuZCBvdmVycmlkZQ0KPiBwYXRjaGVzLg0KPiANCj4gVGhhbmtz
DQo+IC1NYXRoaWFzDQo+ICAgDQo+IA0KDQpEZWFyIERhZWh3YW4sDQoNCkknbSB2ZXJ5IGFwcHJl
Y2lhdGUgZm9yIHlvdXIgdXBzdHJlYW0gd29yay4NCg0KV2Uga25vdyB0aGF0LCBVU0Igb2ZmbG9h
ZCAoZXNwZWNpYWxseSBmb3IgaGVhZHNldCAtIFVTQiBBdWRpbykgaXMgYSB2ZXJ5IA0KaW1wb3J0
YW50IGZlYXR1cmUgaW4gY3VycmVudCBzbWFydCBwaG9uZSBkZXZpY2VzLiBJdCBpcyBhYmxlIHRv
IGltcHJvdmUgDQpib3RoIGF1ZGlvIGxhdGVuY3kgYW5kIHBvd2VyIGNvbnN1bXB0aW9uIHVuZGVy
IG11c2ljIHBsYXlpbmcgb3IgcGhvbmUgDQpjYWxsIHNjZW5hcmlvcy4gSG93ZXZlciwgdGhlIHNv
bHV0aW9uIHZhcmllcyBiZXR3ZWVuIGRpZmZlcmVudCBTT0MgDQp2ZW5kb3JzLCBiZWNhdXNlIHRo
ZSBpbXBsZW1lbnRhdGlvbnMgYXJlIGRpZmZlcmVudCBpbiBib3RoIHNvZnR3YXJlIGFuZCANCmhh
cmR3YXJlIGludGVyZmFjZXMuDQoNCkkgdGhpbmsgYSBkZXNpZ24gZGVzY3JpcHRpb24gKGRvY3Vt
ZW50KSB0byB5b3VyIGltcGxlbWVudGF0aW9uIGlzIA0KaW1wb3J0YW50IGZvciBpbnRyb2R1Y2lu
ZyB0aGlzIGZlYXR1cmUgdG8gTGludXggY29tbXVuaXR5LiBNYXliZSBhIA0KY29uZmlndXJhdGlv
biBob3ctdG8gaXMgcmVxdWlyZWQgZm9yIG5vdCBvbmx5IG1haW50YWluZXJzIGJ1dCBhbHNvIA0K
ZGV2ZWxvcGVycyB0byB1bmRlcnN0YW5kIHRoZXNlIG1vZGlmaWNhdGlvbnMuIEFuZCBJIHRoaW5r
IG90aGVyIHZlbmRvcnMgDQpzaG91bGQgZm9sbG93IHVwIGlmIHRoZXkgbGlrZXMgdG8gdXBzdHJl
YW0gdGhlaXIgc29sdXRpb25zLiA6KQ0KDQpUaGFua3MhDQpNQWNwYXVsIExpbg==

