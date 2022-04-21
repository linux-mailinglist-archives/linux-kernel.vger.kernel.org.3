Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357D450989A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385537AbiDUHHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385568AbiDUHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:07:36 -0400
Received: from m1390.mail.163.com (m1390.mail.163.com [220.181.13.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFE2815725
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=n3Was
        +XBnfltnqT6FH8uhMrs6oozRXXVMab7bJp4f8U=; b=Jkd1YJF/8hxgLlage/fpv
        7+kUoJFzfPmkczDT7scoZ5wbwOpVbwPy8KCIVSXfKENmp6otcO3o8PECCjEfbZpW
        Kljd5aUr9QDzERXmSfmv+z4toxMbosavskifBfaHYN7YfPt0xNDF1+rtC6n6+yuf
        AqXyldP2M29Cey16ngoWrc=
Received: from slark_xiao$163.com ( [112.97.55.38] ) by ajax-webmail-wmsvr90
 (Coremail) ; Thu, 21 Apr 2022 15:03:34 +0800 (CST)
X-Originating-IP: [112.97.55.38]
Date:   Thu, 21 Apr 2022 15:03:34 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Loic Poulain" <loic.poulain@linaro.org>
Cc:     mani@kernel.org, quic_hemantk@quicinc.com,
        gregkh@linuxfoundation.org, bbhatt@codeaurora.org,
        christophe.jaillet@wanadoo.fr, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] bus: mhi: host: Add support for Cinterion
 MV32-WA/MV32-WB
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <CAMZdPi9WJsz5nyzQB39q=Jhy8_q2=N8VAucYMUYKUf_faL5csQ@mail.gmail.com>
References: <20220420102811.3157-1-slark_xiao@163.com>
 <CAMZdPi9WJsz5nyzQB39q=Jhy8_q2=N8VAucYMUYKUf_faL5csQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <55f0b74e.25a7.1804aeeedb4.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: WsGowABnb7fGAWFiv9sRAA--.37675W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRvpZFyPb97uFAABsW
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA0LTIwIDIwOjAwOjIzLCAiTG9pYyBQb3VsYWluIiA8bG9pYy5wb3VsYWluQGxp
bmFyby5vcmc+IHdyb3RlOgo+SGkgU2xhcmssCj4KPk9uIFdlZCwgMjAgQXByIDIwMjIgYXQgMTI6
MjgsIFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+IE1WMzItV0Eg
aXMgZGVzaWduZWQgYmFzZWQgb24gUXVhbGNvbW0gU0RYNjIsIGFuZAo+PiBNVjMyLVdCIGlzIGRl
c2lnbmVkIGJhc2VkIG9uIFFVYWxjb21tIFNEWDY1LiBCb3RoCj4+IHByb2R1Y3RzJyBlbnVtZXJh
dGlvbiB3b3VsZCBhbGlnbiB3aXRoIHByZXZpb3VzCj4+IHByb2R1Y3QgTVYzMS1XLgo+PiBBZGQg
c29tZSBuZXcgaXRlbXMgZm9yIG12MzIgdG8gc2VwYXJhdGUgaXQgZnJvbQo+PiBtdjMxLXcsIGlu
IGNhc2Ugd2UgbmVlZCB0byBkbyBhbnkgY2hhbmdlcyBpbgo+PiBmdXR1cmUuCj4KPk9uIHRoZSBj
b250cmFyeSwgZG8gbm90IG92ZXJseSBjbG9uZSB0aGUgc3RydWN0dXJlcywgYW5kIHJlLXVzZSB0
aGUKPm12MzEgb25lcyBpZiB0aGV5IGFwcGx5LiBZb3UgY2FuIHJlbmFtZSB0aGVtIHRvIG12M3gg
aWYgeW91IHJlYWxseQo+d2FudCB0by4KPgo+UmVnYXJkcywKPkxvaWMKPgpIaSBMb2ljLAogIFRo
YW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLgogICBBY3R1YWxseSwgZm9yIGRpZmZlcmVudCBjaGlw
KGxpa2UgcHJldmlvdXMgU0RYMjQgYW5kIFNEWDU1KSwgdGhleSBtYXkgCmhhdmUgZGlmZmVyZW5j
ZSBiZWhhdmlvci4gRm9yIGV4YW1wbGUsIHRoZSBpdGVtIG9mICdzaWRlYmFuZF93YWtlJwpvZiBT
RFgyNCBpcyB0cnVlIGJ1dCB0aGUgcmVzdCBpcyBmYWxzZS4gSXQncyBoYXJkIHRvIHNheSBTRFg2
NSB3b3VsZCAKYWxpZ24gd2l0aCBTRFg1NSB1bnRpbCBub3cuCiAgIE1heWJlIEkgY2FuIHJlLXVz
ZSB0aGUgc2FtZSBpdGVtICcuY29uZmlnJyBmb3IgYWxsIE1WM1ggcHJvZHVjdHMgYW5kIHNlcGFy
YXRlIAp0aGVtIGZyb20gZGV2aWNlIGluZm8obWhpX3BjaV9kZXZfaW5mbykuIAogICBEbyB5b3Ug
YWdyZWUgdGhpcz8KCj4KPgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTbGFyayBYaWFvIDxzbGFya194
aWFvQDE2My5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMu
YyB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgMSBmaWxlIGNoYW5nZWQs
IDQxIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYnVzL21oaS9ob3N0
L3BjaV9nZW5lcmljLmMgYi9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jCj4+IGlu
ZGV4IDU0MWNlZDI3ZDk0MS4uYTJkYTQwMzQwZGY3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2J1
cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jCj4+ICsrKyBiL2RyaXZlcnMvYnVzL21oaS9ob3N0L3Bj
aV9nZW5lcmljLmMKPj4gQEAgLTQwNiw2ICs0MDYsNDEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
aGlfcGNpX2Rldl9pbmZvIG1oaV9tdjMxX2luZm8gPSB7Cj4+ICAgICAgICAgLm1ydV9kZWZhdWx0
ID0gMzI3NjgsCj4+ICB9Owo+Pgo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBtaGlfY2hhbm5lbF9j
b25maWcgbWhpX212MzJfY2hhbm5lbHNbXSA9IHsKPj4gKyAgICAgICBNSElfQ0hBTk5FTF9DT05G
SUdfVUwoMCwgIkxPT1BCQUNLIiwgNjQsIDApLAo+PiArICAgICAgIE1ISV9DSEFOTkVMX0NPTkZJ
R19ETCgxLCAiTE9PUEJBQ0siLCA2NCwgMCksCj4+ICsgICAgICAgLyogTUJJTSBDb250cm9sIENo
YW5uZWwgKi8KPj4gKyAgICAgICBNSElfQ0hBTk5FTF9DT05GSUdfVUwoMTIsICJNQklNIiwgNjQs
IDApLAo+PiArICAgICAgIE1ISV9DSEFOTkVMX0NPTkZJR19ETCgxMywgIk1CSU0iLCA2NCwgMCks
Cj4+ICsgICAgICAgLyogTUJJTSBEYXRhIENoYW5uZWwgKi8KPj4gKyAgICAgICBNSElfQ0hBTk5F
TF9DT05GSUdfSFdfVUwoMTAwLCAiSVBfSFcwX01CSU0iLCA1MTIsIDIpLAo+PiArICAgICAgIE1I
SV9DSEFOTkVMX0NPTkZJR19IV19ETCgxMDEsICJJUF9IVzBfTUJJTSIsIDUxMiwgMyksCj4+ICt9
Owo+PiArCj4+ICtzdGF0aWMgc3RydWN0IG1oaV9ldmVudF9jb25maWcgbWhpX212MzJfZXZlbnRz
W10gPSB7Cj4+ICsgICAgICAgTUhJX0VWRU5UX0NPTkZJR19DVFJMKDAsIDI1NiksCj4+ICsgICAg
ICAgTUhJX0VWRU5UX0NPTkZJR19EQVRBKDEsIDI1NiksCj4+ICsgICAgICAgTUhJX0VWRU5UX0NP
TkZJR19IV19EQVRBKDIsIDEwMjQsIDEwMCksCj4+ICsgICAgICAgTUhJX0VWRU5UX0NPTkZJR19I
V19EQVRBKDMsIDEwMjQsIDEwMSksCj4+ICt9Owo+PiArCj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IG1oaV9jb250cm9sbGVyX2NvbmZpZyBtb2RlbV9tdjMyX2NvbmZpZyA9IHsKPj4gKyAgICAgICAu
bWF4X2NoYW5uZWxzID0gMTI4LAo+PiArICAgICAgIC50aW1lb3V0X21zID0gMjAwMDAsCj4+ICsg
ICAgICAgLm51bV9jaGFubmVscyA9IEFSUkFZX1NJWkUobWhpX212MzJfY2hhbm5lbHMpLAo+PiAr
ICAgICAgIC5jaF9jZmcgPSBtaGlfbXYzMl9jaGFubmVscywKPj4gKyAgICAgICAubnVtX2V2ZW50
cyA9IEFSUkFZX1NJWkUobWhpX212MzJfZXZlbnRzKSwKPj4gKyAgICAgICAuZXZlbnRfY2ZnID0g
bWhpX212MzJfZXZlbnRzLAo+PiArfTsKPj4gKwo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBtaGlf
cGNpX2Rldl9pbmZvIG1oaV9tdjMyX2luZm8gPSB7Cj4+ICsgICAgICAgLm5hbWUgPSAiY2ludGVy
aW9uLW12MzIiLAo+PiArICAgICAgIC5jb25maWcgPSAmbW9kZW1fbXYzMl9jb25maWcsCj4+ICsg
ICAgICAgLmJhcl9udW0gPSBNSElfUENJX0RFRkFVTFRfQkFSX05VTSwKPj4gKyAgICAgICAuZG1h
X2RhdGFfd2lkdGggPSAzMiwKPj4gKyAgICAgICAubXJ1X2RlZmF1bHQgPSAzMjc2OCwKPj4gK307
Cj4+ICsKPj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWhpX2NoYW5uZWxfY29uZmlnIG1oaV9zaWVy
cmFfZW05MTl4X2NoYW5uZWxzW10gPSB7Cj4+ICAgICAgICAgTUhJX0NIQU5ORUxfQ09ORklHX1VM
X1NCTCgyLCAiU0FIQVJBIiwgMzIsIDApLAo+PiAgICAgICAgIE1ISV9DSEFOTkVMX0NPTkZJR19E
TF9TQkwoMywgIlNBSEFSQSIsIDI1NiwgMCksCj4+IEBAIC00NzUsNiArNTEwLDEyIEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBtaGlfcGNpX2lkX3RhYmxlW10gPSB7Cj4+ICAg
ICAgICAgLyogTVYzMS1XIChDaW50ZXJpb24pICovCj4+ICAgICAgICAgeyBQQ0lfREVWSUNFKDB4
MTI2OSwgMHgwMGIzKSwKPj4gICAgICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9IChrZXJuZWxf
dWxvbmdfdCkgJm1oaV9tdjMxX2luZm8gfSwKPj4gKyAgICAgICAvKiBNVjMyLVdBIChDaW50ZXJp
b24pICovCj4+ICsgICAgICAgeyBQQ0lfREVWSUNFKDB4MTI2OSwgMHgwMGJhKSwKPj4gKyAgICAg
ICAgICAgICAgIC5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJm1oaV9tdjMyX2luZm8g
fSwKPj4gKyAgICAgICAvKiBNVjMyLVdCIChDaW50ZXJpb24pICovCj4+ICsgICAgICAgeyBQQ0lf
REVWSUNFKDB4MTI2OSwgMHgwMGJiKSwKPj4gKyAgICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9
IChrZXJuZWxfdWxvbmdfdCkgJm1oaV9tdjMyX2luZm8gfSwKPj4gICAgICAgICB7ICB9Cj4+ICB9
Owo+PiAgTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIG1oaV9wY2lfaWRfdGFibGUpOwo+PiAtLQo+
PiAyLjI1LjEKPj4K
