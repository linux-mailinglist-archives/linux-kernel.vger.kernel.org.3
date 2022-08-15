Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA42592929
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiHOFp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiHOFpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:45:23 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D55FCE;
        Sun, 14 Aug 2022 22:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660542323; x=1692078323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MN6DZzBy9X27OEYsKBr2tzzbyxhyziDucda9ItSouK4=;
  b=ZRmm7FzeriUOpGDeBI1QopzXyEZx2E0Jxb2n9awAhxSjhmMUo9Yw3u7l
   ejSyT8kqUpPMB/ieWUH+v1KsQfW7rRh3C5lSV7hbCJ8rQ+Yvwc355IOfx
   BlbgYZ54J7fDpuPHk/TAP/BJIwtgcyHd6w/qr+2j7wV12eG0HIPB4kiI9
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,237,1654560000"; 
   d="scan'208";a="119102256"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 05:45:03 +0000
Received: from EX13D16EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com (Postfix) with ESMTPS id F32032011F5;
        Mon, 15 Aug 2022 05:44:58 +0000 (UTC)
Received: from [192.168.12.137] (10.43.162.134) by
 EX13D16EUB003.ant.amazon.com (10.43.166.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 15 Aug 2022 05:44:52 +0000
Message-ID: <05dbdf57-e990-465d-e4cc-e83e7f2b697a@amazon.com>
Date:   Mon, 15 Aug 2022 08:44:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH] kunit: fix Kconfig for build-in tests USB4 and Nitro
 Enclaves
To:     Nico Pache <npache@redhat.com>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <davidgow@google.com>
CC:     <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <brendan.higgins@linux.dev>, <alcioa@amazon.com>,
        <lexnv@amazon.com>, <YehezkelShB@gmail.com>,
        <mika.westerberg@linux.intel.com>, <michael.jamet@intel.com>,
        <andreas.noever@gmail.com>
References: <20220810234056.2494993-1-npache@redhat.com>
Content-Language: en-US
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
In-Reply-To: <20220810234056.2494993-1-npache@redhat.com>
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D18UWC002.ant.amazon.com (10.43.162.88) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiAxMS4wOC4yMDIyIDAyOjQwLCBOaWNvIFBhY2hlIHdyb3RlOgo+IAo+IEJvdGggdGhlIFVT
QjQgYW5kIE5pdHJvIEVuY2xhdmVzIEtVTklUIHRlc3RzIGFyZSBub3cgYWJsZSB0byBiZSBjb21w
aWxlZAo+IGlmIEtVTklUIGlzIGNvbXBpbGVkIGFzIGEgbW9kdWxlLiBUaGlzIGxlYWRzIHRvIGlz
c3VlcyBpZiBLVU5JVCBpcyBiZWluZwo+IHBhY2thZ2VkIHNlcGFyYXRlbHkgZnJvbSB0aGUgY29y
ZSBrZXJuZWwgYW5kIHdoZW4gS1VOSVQgaXMgcnVuIGJhcmVtZXRhbAo+IHdpdGhvdXQgdGhlIHJl
cXVpcmVkIGRyaXZlciBjb21waWxlZCBpbnRvIHRoZSBrZXJuZWwuCj4gCj4gRml4ZXM6IDYzNWRj
ZDE2ODQ0YiAoInRodW5kZXJib2x0OiB0ZXN0OiBVc2Uga3VuaXRfdGVzdF9zdWl0ZSgpIG1hY3Jv
IikKPiBGaXhlczogZmU1YmU4MDhmYTZjICgibml0cm9fZW5jbGF2ZXM6IHRlc3Q6IFVzZSBrdW5p
dF90ZXN0X3N1aXRlKCkgbWFjcm8iKQo+IFNpZ25lZC1vZmYtYnk6IE5pY28gUGFjaGUgPG5wYWNo
ZUByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy90aHVuZGVyYm9sdC9LY29uZmlnICAgICAg
ICAgfCAzICstLQo+ICAgZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL0tjb25maWcgfCAyICst
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aHVuZGVyYm9sdC9LY29uZmlnIGIvZHJpdmVycy90aHVu
ZGVyYm9sdC9LY29uZmlnCj4gaW5kZXggZTc2YTZjMTczNjM3Li5mMTJkMGEzZWUzZTIgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy90aHVuZGVyYm9sdC9LY29uZmlnCj4gKysrIGIvZHJpdmVycy90aHVu
ZGVyYm9sdC9LY29uZmlnCj4gQEAgLTI5LDggKzI5LDcgQEAgY29uZmlnIFVTQjRfREVCVUdGU19X
UklURQo+IAo+ICAgY29uZmlnIFVTQjRfS1VOSVRfVEVTVAo+ICAgICAgICAgIGJvb2wgIktVbml0
IHRlc3RzIiBpZiAhS1VOSVRfQUxMX1RFU1RTCj4gLSAgICAgICBkZXBlbmRzIG9uIChVU0I0PW0g
fHwgS1VOSVQ9eSkKPiAtICAgICAgIGRlcGVuZHMgb24gS1VOSVQKPiArICAgICAgIGRlcGVuZHMg
b24gVVNCNCAmJiBLVU5JVD15Cj4gICAgICAgICAgZGVmYXVsdCBLVU5JVF9BTExfVEVTVFMKPiAK
PiAgIGNvbmZpZyBVU0I0X0RNQV9URVNUCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydC9uaXRy
b19lbmNsYXZlcy9LY29uZmlnIGIvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL0tjb25maWcK
PiBpbmRleCBjZTkxYWRkODE0MDEuLmRjNGQyNWMyNjI1NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZpcnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvdmlydC9uaXRyb19l
bmNsYXZlcy9LY29uZmlnCj4gQEAgLTE3LDcgKzE3LDcgQEAgY29uZmlnIE5JVFJPX0VOQ0xBVkVT
Cj4gCj4gICBjb25maWcgTklUUk9fRU5DTEFWRVNfTUlTQ19ERVZfVEVTVAo+ICAgICAgICAgIGJv
b2wgIlRlc3RzIGZvciB0aGUgbWlzYyBkZXZpY2UgZnVuY3Rpb25hbGl0eSBvZiB0aGUgTml0cm8g
RW5jbGF2ZXMiIGlmICFLVU5JVF9BTExfVEVTVFMKPiAtICAgICAgIGRlcGVuZHMgb24gTklUUk9f
RU5DTEFWRVMgJiYgS1VOSVQKPiArICAgICAgIGRlcGVuZHMgb24gTklUUk9fRU5DTEFWRVMgJiYg
S1VOSVQ9eQo+ICAgICAgICAgIGRlZmF1bHQgS1VOSVRfQUxMX1RFU1RTCj4gICAgICAgICAgaGVs
cAo+ICAgICAgICAgICAgRW5hYmxlIEtVbml0IHRlc3RzIGZvciB0aGUgbWlzYyBkZXZpY2UgZnVu
Y3Rpb25hbGl0eSBvZiB0aGUgTml0cm8KCgpGb3IgdGhlIE5pdHJvIEVuY2xhdmVzIHBhcnQ6CgpS
ZXZpZXdlZC1ieTogQW5kcmEgUGFyYXNjaGl2IDxhbmRyYXByc0BhbWF6b24uY29tPgoKVGhhbmsg
eW91LgoKQW5kcmEKCj4gLS0KPiAyLjM2LjEKPiAKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRl
ciAoUm9tYW5pYSkgUy5SLkwuIHJlZ2lzdGVyZWQgb2ZmaWNlOiAyN0EgU2YuIExhemFyIFN0cmVl
dCwgVUJDNSwgZmxvb3IgMiwgSWFzaSwgSWFzaSBDb3VudHksIDcwMDA0NSwgUm9tYW5pYS4gUmVn
aXN0ZXJlZCBpbiBSb21hbmlhLiBSZWdpc3RyYXRpb24gbnVtYmVyIEoyMi8yNjIxLzIwMDUuCg==

