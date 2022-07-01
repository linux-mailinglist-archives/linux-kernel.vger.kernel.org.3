Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A91562B3D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiGAGJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiGAGJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:09:23 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ECA1A83D;
        Thu, 30 Jun 2022 23:09:22 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4LZ4Xb2TC7z9sRC;
        Fri,  1 Jul 2022 08:09:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1656655759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsyp9ivOxX37DAmmbqK5ol+805NdQpTLooU7ujGhSs8=;
        b=E5F+r6GuVreF8Q77JKB3QWhaPWkns7FXgZkzudO+ksui848ZmzeQHARDvw1dpargwOkLL7
        oYnAoGArIAa+UutQ/CP3VwOXP17kfxB7ZwGMHo4OGSaFwYh7Lxqn54yr2WnjIZtvTpiTEP
        yIlsdeX1Drao7mslBXhRg+kIukEP6a2mDIBNxxSkb7IcxegemEGCRosvqz0fMXXa4kIGhu
        R/s4ksGrOySOI/BxTqYe56hzQ/r8MND/r+Beeb+1M7IBJ08C4Dc6sz27MF9n+BweyI9Nct
        Wo5YNRlF6QA3Lz7lZZVFdvSZyRaryehccrugz+uLEOxU6wwgyOY4uTB0RJz3Zg==
Message-ID: <3b011dfa0aa2a880a113e005a49e2e126c1bef67.camel@dylanvanassche.be>
Subject: Re: [PATCH] arm64: dts: qcom/sdm845-shift-axolotl: Enable pmi9889
 LPG LED
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date:   Fri, 01 Jul 2022 08:09:17 +0200
In-Reply-To: <Yr4cGj7MujkXZ161@builder.lan>
References: <20220512054439.13971-1-me@dylanvanassche.be>
         <Yr4cGj7MujkXZ161@builder.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4LZ4Xb2TC7z9sRC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA2LTMwIGF0IDE2OjU2IC0wNTAwLCBCam9ybiBBbmRlcnNzb24gd3JvdGU6
Cj4gT24gVGh1IDEyIE1heSAwMDo0NCBDRFQgMjAyMiwgRHlsYW4gVmFuIEFzc2NoZSB3cm90ZToK
PiAKPiA+IEVuYWJsZXMgdGhlIFJHQiBub3RpZmljYXRpb24gTEVEIG9uIHRoZSBTSElGVCA2bXEg
KHNkbTg0NS1zaGlmdC0KPiA+IGF4b2xvdGwpCj4gPiB3aXRoIHRoZSBRdWFsY29tbSBMaWdodCBQ
dWxzZSBHZW5lcmF0b3IgYmluZGluZ3MgYnkgQmpvcm4gQW5kZXJzc29uCj4gPiBbMV0uCj4gPiBQ
YXRjaGVzIGFyZSBtZXJnZWQgaW4gZm9yLW5leHQgYnJhbmNoIG9mIGxpbnV4LWxlZHMuCj4gPiBU
ZXN0ZWQgdGhlc2UgY2hhbmdlcyBvbiB0aGUgU0hJRlQgNm1xLgo+ID4gCj4gPiBbMV0KPiA+IGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3BhdmVsL2xpbnV4
LWxlZHMuZ2l0L2NvbW1pdC8/aD1mb3ItbmV4dCZpZD1hOGU1M2RiNDZmMTlmNjdiZTZhMjY0ODhh
YWZiN2QxMGM3OGUzM2JkCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IER5bGFuIFZhbiBBc3NjaGUg
PG1lQGR5bGFudmFuYXNzY2hlLmJlPgo+ID4gLS0tCj4gPiDCoC4uLi9ib290L2R0cy9xY29tL3Nk
bTg0NS1zaGlmdC1heG9sb3RsLmR0c8KgwqDCoCB8IDI5Cj4gPiArKysrKysrKysrKysrKysrKysr
Cj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2RtODQ1LXNoaWZ0LWF4b2xvdGwuZHRzCj4g
PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04NDUtc2hpZnQtYXhvbG90bC5kdHMKPiA+
IGluZGV4IDg0N2Y2MjE3YTc3Yi4uYWY0MTJhYzJjOWQwIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy9xY29tL3NkbTg0NS1zaGlmdC1heG9sb3RsLmR0cwo+ID4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9xY29tL3NkbTg0NS1zaGlmdC1heG9sb3RsLmR0cwo+ID4gQEAgLTIs
MTEgKzIsMTMgQEAKPiA+IMKgLyoKPiA+IMKgICogQ29weXJpZ2h0IChjKSAyMDIyLCBBbGV4YW5k
ZXIgTWFydGluego+ID4gPGFtYXJ0aW56QHNoaWZ0cGhvbmVzLmNvbT4KPiA+IMKgICogQ29weXJp
Z2h0IChjKSAyMDIyLCBDYWxlYiBDb25ub2xseSA8Y2FsZWJAY29ubm9sbHkudGVjaD4KPiA+ICsg
KiBDb3B5cmlnaHQgKGMpIDIwMjIsIER5bGFuIFZhbiBBc3NjaGUgPG1lQGR5bGFudmFuYXNzY2hl
LmJlPgo+ID4gwqAgKi8KPiA+IMKgCj4gPiDCoC9kdHMtdjEvOwo+ID4gwqAKPiA+IMKgI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPgo+ID4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9s
ZWRzL2NvbW1vbi5oPgo+ID4gwqAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcmVndWxhdG9yL3Fjb20s
cnBtaC1yZWd1bGF0b3IuaD4KPiA+IMKgI2luY2x1ZGUgInNkbTg0NS5kdHNpIgo+ID4gwqAjaW5j
bHVkZSAicG04OTk4LmR0c2kiCj4gPiBAQCAtNTU0LDYgKzU1NiwzMyBAQCAmcG1pODk5OF9zbWIy
IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBtb25pdG9yZWQtYmF0dGVyeSA9IDwmYmF0dGVyeT47Cj4g
PiDCoH07Cj4gPiDCoAo+ID4gKyZwbWk4OTk4X2xwZyB7Cj4gCj4gV2UgZG9uJ3QgaGF2ZSB0aGlz
IG5vZGUsIGJlY2F1c2Ugbm8gb25lIGhhcyByZXZpZXdlZAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDIyMDUwNTAyMjcwNi4xNjkyNTU0LTEtYmpvcm4uYW5kZXJzc29uQGxpbmFyby5v
cmcvI3QKPiB5ZXQuCj4gCj4gSWYgYW55b25lIGNvdWxkIHRha2UgYSBsb29rIEknZCBiZSBoYXBw
eSB0byBtZXJnZSB0aGlzIGFzIHdlbGwuCj4gCj4gVGhhbmtzLAo+IEJqb3JuCj4gCgpJIGhhZCBh
IGxvb2ssIGxvb2tzIGZpbmUgdG8gbWUgc28gSSBzZW50IGEgUmV2aWV3ZWQtYnkgb3V0LgpUaGFu
a3MhCgpEeWxhbgoKPiA+ICvCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJva2F5IjsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoG11bHRpLWxlZCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY29sb3IgPSA8TEVEX0NPTE9SX0lEX1JHQj47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZnVuY3Rpb24gPSBMRURfRlVOQ1RJT05fU1RBVFVTOwo+ID4gKwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNhZGRyZXNzLWNlbGxzID0gPDE+Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNzaXplLWNlbGxzID0gPDA+Owo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxlZEAzIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDM+Owo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb2xvciA9IDxMRURfQ09MT1Jf
SURfQkxVRT47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsZWRANCB7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDw0PjsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29sb3IgPSA8TEVEX0NPTE9S
X0lEX0dSRUVOPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gKwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxlZEA1IHsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDU+Owo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb2xvciA9IDxMRURfQ09M
T1JfSURfUkVEPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgfTsKPiA+ICt9Owo+ID4gKwo+ID4gwqAmcXVwX3VhcnQ5X2RlZmF1bHQgewo+
ID4gwqDCoMKgwqDCoMKgwqDCoHBpbmNvbmYtcnggewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBwaW5zID0gImdwaW81IjsKPiA+IC0tIAo+ID4gMi4zNi4xCj4gPiAKCg==

