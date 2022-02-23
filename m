Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0844C14D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbiBWN5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiBWN5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:57:33 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9540636E14;
        Wed, 23 Feb 2022 05:57:01 -0800 (PST)
Received: by ajax-webmail-mail.loongson.cn (Coremail) ; Wed, 23 Feb 2022
 21:56:12 +0800 (GMT+08:00)
X-Originating-IP: [10.20.42.36]
Date:   Wed, 23 Feb 2022 21:56:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZqL5pmv5bOw?= <suijingfeng@loongson.cn>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Sui Jingfeng" <15330273260@189.cn>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Roland Scheidegger" <sroland@vmware.com>,
        "Zack Rusin" <zackr@vmware.com>,
        "Christian Gmeiner" <christian.gmeiner@gmail.com>,
        "David Airlie" <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Andrey Zhizhikin" <andrey.zhizhikin@leica-geosystems.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "Lucas Stach" <l.stach@pengutronix.de>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        "Qing Zhang" <zhangqing@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: Re: [PATCH v10 2/4] Documentation/dt: Add descriptions for
 loongson display controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10a build 20191018(4c4f6d15)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <YhVrigEnXTiNgk67@robh.at.kernel.org>
References: <20220220145554.117854-1-15330273260@189.cn>
 <20220220145554.117854-3-15330273260@189.cn>
 <YhVrigEnXTiNgk67@robh.at.kernel.org>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: jJgo1GZvb3Rlcl90eHQ9MjU4NTo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <720f940e.5ac.17f26de3a5b.Coremail.suijingfeng@loongson.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AQAAf9Dx_8v8PBZiZrgFAA--.3690W
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/1tbiAQAGC13QvO5TygABsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKJmd0OyAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KJmd0OyBGcm9tOiAiUm9iIEhlcnJp
bmciIDxyb2JoQGtlcm5lbC5vcmc+CiZndDsgU2VudCBUaW1lOiAyMDIyLTAyLTIzIDA3OjAyOjM0
IChXZWRuZXNkYXkpCiZndDsgVG86ICJTdWkgSmluZ2ZlbmciICZsdDsxNTMzMDI3MzI2MEAxODku
Y24mZ3Q7CiZndDsgQ2M6ICJNYXhpbWUgUmlwYXJkIiA8bXJpcGFyZEBrZXJuZWwub3JnPiwgIlRo
b21hcyBaaW1tZXJtYW5uIiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4sICJSb2xhbmQgU2NoZWlkZWdn
ZXIiIDxzcm9sYW5kQHZtd2FyZS5jb20+LCAiWmFjayBSdXNpbiIgPHphY2tyQHZtd2FyZS5jb20+
LCAiQ2hyaXN0aWFuIEdtZWluZXIiIDxjaHJpc3RpYW4uZ21laW5lckBnbWFpbC5jb20+LCAiRGF2
aWQgQWlybGllIiA8YWlybGllZEBsaW51eC5pZT4sICJEYW5pZWwgVmV0dGVyIiA8ZGFuaWVsQGZm
d2xsLmNoPiwgIlRob21hcyBCb2dlbmRvZXJmZXIiIDx0c2JvZ2VuZEBhbHBoYS5mcmFua2VuLmRl
PiwgIkRhbiBDYXJwZW50ZXIiIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+LCAiS3J6eXN6dG9m
IEtvemxvd3NraSIgPGtyemtAa2VybmVsLm9yZz4sICJBbmRyZXkgWmhpemhpa2luIiA8YW5kcmV5
LnpoaXpoaWtpbkBsZWljYS1nZW9zeXN0ZW1zLmNvbT4sICJTYW0gUmF2bmJvcmciIDxzYW1AcmF2
bmJvcmcub3JnPiwgIkRhdmlkIFMgLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0PiwgIkpp
YXh1biBZYW5nIiA8amlheHVuLnlhbmdAZmx5Z29hdC5jb20+LCAiTHVjYXMgU3RhY2giIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPiwgIk1hYXJ0ZW4gTGFua2hvcnN0IiA8bWFhcnRlbi5sYW5raG9y
c3RAbGludXguaW50ZWwuY29tPiwgIklsaWEgTWlya2luIiA8aW1pcmtpbkBhbHVtLm1pdC5lZHU+
LCAiUWluZyBaaGFuZyIgPHpoYW5ncWluZ0Bsb29uZ3Nvbi5jbj4sIHN1aWppbmdmZW5nIDxzdWlq
aW5nZmVuZ0Bsb29uZ3Nvbi5jbj4sIGxpbnV4LW1pcHNAdmdlci5rZXJuZWwub3JnLCBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnLCBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZywgZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwomZ3Q7IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEwIDIv
NF0gRG9jdW1lbnRhdGlvbi9kdDogQWRkIGRlc2NyaXB0aW9ucyBmb3IgbG9vbmdzb24gZGlzcGxh
eSBjb250cm9sbGVyCiZndDsgCiZndDsgT24gU3VuLCBGZWIgMjAsIDIwMjIgYXQgMTA6NTU6NTJQ
TSArMDgwMCwgU3VpIEppbmdmZW5nIHdyb3RlOgomZ3Q7ICZndDsgRnJvbTogc3VpamluZ2Zlbmcg
PHN1aWppbmdmZW5nQGxvb25nc29uLmNuPgomZ3Q7IAomZ3Q7IEZvbGxvdyB0aGUgY29udmVudGlv
bnMgb2YgdGhlIHN1YnN5c3RlbSBmb3IgcGF0Y2ggc3ViamVjdHMuIEl0IHNob3VsZCBiZSAKJmd0
OyBldmlkZW50IHdpdGggJ2dpdCBsb2cgLS1vbmVsaW5lIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5Jy4KJmd0OyAKJmd0OyBTb21ldGhpbmcgbGlrZSB0aGlzOgomZ3Q7
IAomZ3Q7IGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBBZGQgTG9vbmdzb24gZGlzcGxheSBjb250cm9s
bGVyCiZndDsgCgpIaSwgCgpXZSBhcmUgbm90IGEgcGxhdGZvcm0gZGV2aWNlIGRyaXZlciwgdGhl
cmUgaXMgbm8Kb2ZfZGV2aWNlX2lkIGRlZmluZWQgaW4gbXkgZHJpdmVyLiBJbiBvdGhlciB3b3Jk
LCAKbXkgZHJpdmVyIHdpbGwgbm90IGJpbmQgYWdhaW5zdCBkZXZpY2VzIHdob3NlIGNvbXBhdGli
bGUKaXMgImxvb25nc29uLGxzN2ExMDAwLWRjIi4gV2UganVzdCBwYXJzZSB0aGUgZGV2aWNlIHRy
ZWUKYWN0aXZlbHksIGZpbmQgbmVjZXNzYXJ5IGluZm9ybWF0aW9uIG9mIGludGVyZXN0LiAKSW4g
dGhpcyBjYXNlLCBjYW4gSSB1c2UgdGhlIHdvcmQgImR0LWJpbmRpbmdzIiBpbiB0aGUgY29tbWl0
IHRpdGxlPyAKCkkgd2FudCB0byBmb2xsb3cgdGhlIGNvbnZlbnRpb25zLCBidXQgZ2V0IHNvbWUg
cHVzaCBiYWNrLApLcnp5c3p0b2Ygc2F5IHRoYXQgaGUgY2FuIG5vdCBzZWUgYW55IGJpbmRpbmdz
LCB0aGVzZSBhcmUgbm90IGJpbmRpbmdzLjwvc3VpamluZ2ZlbmdAbG9vbmdzb24uY24+PC9zdWlq
aW5nZmVuZ0Bsb29uZ3Nvbi5jbj48L3poYW5ncWluZ0Bsb29uZ3Nvbi5jbj48L2ltaXJraW5AYWx1
bS5taXQuZWR1PjwvbWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPjwvbC5zdGFjaEBw
ZW5ndXRyb25peC5kZT48L2ppYXh1bi55YW5nQGZseWdvYXQuY29tPjwvZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldD48L3NhbUByYXZuYm9yZy5vcmc+PC9hbmRyZXkuemhpemhpa2luQGxlaWNhLWdlb3N5c3Rl
bXMuY29tPjwva3J6a0BrZXJuZWwub3JnPjwvZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPjwvdHNi
b2dlbmRAYWxwaGEuZnJhbmtlbi5kZT48L2RhbmllbEBmZndsbC5jaD48L2FpcmxpZWRAbGludXgu
aWU+PC9jaHJpc3RpYW4uZ21laW5lckBnbWFpbC5jb20+PC96YWNrckB2bXdhcmUuY29tPjwvc3Jv
bGFuZEB2bXdhcmUuY29tPjwvdHppbW1lcm1hbm5Ac3VzZS5kZT48L21yaXBhcmRAa2VybmVsLm9y
Zz48L3JvYmhAa2VybmVsLm9yZz4NCg0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ6b6Z6Iqv
5Lit56eR55qE5ZWG5Lia56eY5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw
5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul
5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw
5rOE6Zyy44CB5aSN5Yi25oiW5pWj5Y+R77yJ5pys6YKu5Lu25Y+K5YW26ZmE5Lu25Lit55qE5L+h
5oGv44CC5aaC5p6c5oKo6ZSZ5pS25pys6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKu
5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu244CCIA0KVGhpcyBlbWFpbCBhbmQg
aXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTG9v
bmdzb24gVGVjaG5vbG9neSAsIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24g
b3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBp
bmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5v
dCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiBv
ciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lw
aWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGVtYWlsIGluIGVycm9y
LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkg
YW5kIGRlbGV0ZSBpdC4g
