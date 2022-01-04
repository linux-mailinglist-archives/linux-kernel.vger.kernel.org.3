Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A388A484AA3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiADWXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:23:54 -0500
Received: from ip-16.mailobj.net ([213.182.54.16]:44980 "EHLO msg-6.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235396AbiADWXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:23:52 -0500
X-Greylist: delayed 1148 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 17:23:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1641335021; bh=D9+yesqlorbnAPS/+e8RpkomkpiH25w35KF85YKftws=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:MIME-Version:Content-Transfer-Encoding;
        b=deEhpTXGDzfZDyLq+M2IB6Gg63C8ZizhFRc6EhvmgCPG9VvhPPjnIPXizUTePHn9N
         /UmtQC9ZceL+5623ZBdJMtFs+02FfCqHfCtWqLSgJR8weg/GkhHemLtGrvKuiXp+yk
         Xmdc2mWkM7qhLHK5i54uum43Hz+/znn6iqtDqRAI=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Tue,  4 Jan 2022 23:23:41 +0100 (CET)
X-EA-Auth: dkBh22kJ20/hvolg0DJ9p+rXilUkNG/qYu7BqATLamBRCWe11wYuObjSvXCVh0j77U2DiA4iqmaYbpymvTVNxhbiOyBvrnJEg4zzQ4dIvQk=
Message-ID: <f15a477aa01e2e972f54d1c36fa24df9cce48506.camel@mailoo.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx
 and rx macros and external codecs
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Date:   Tue, 04 Jan 2022 23:23:40 +0100
In-Reply-To: <1641208380-15510-2-git-send-email-quic_srivasam@quicinc.com>
References: <1641208380-15510-1-git-send-email-quic_srivasam@quicinc.com>
         <1641208380-15510-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGUgbHVuZGkgMDMgamFudmllciAyMDIyIMOgIDE2OjQyICswNTMwLCBTcmluaXZhc2EgUmFvIE1h
bmRhZGFwdSBhIMOpY3JpdMKgOgo+IFNDNzI4MCBoYXMgVkEsIFRYIGFuZCBSWCBtYWNyb3Mgd2l0
aCBTb3VuZFdpcmUgQ29udHJvbGxlcnMgdG8gYXR0YWNoIHdpdGgKPiBjb2RlY3MgbGlrZSBXQ0Q5
Mzh4LCBtYXg5ODM2MGEgdXNpbmcgc291bmR3aXJlIG1hc3RlcnMgYW5kIGkycyBidXMuCj4gQWRk
IHRoZXNlIG5vZGVzIGZvciBzYzcyODAgYmFzZWQgcGxhdGZvcm1zIGF1ZGlvIHVzZSBjYXNlLgo+
IEFkZCB0bG1tIGdwaW8gcHJvcGVydHkgaW4gd2NkOTM4eCBub2RlIGZvciBzd2l0Y2hpbmcgQ1RJ
QS9PTVRQIEhlYWRzZXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhIFJhbyBNYW5kYWRh
cHUgPHF1aWNfc3JpdmFzYW1AcXVpY2luYy5jb20+Cj4gQ28tZGV2ZWxvcGVkLWJ5OiBWZW5rYXRh
IFByYXNhZCBQb3R0dXJ1IDxxdWljX3BvdHR1cnVAcXVpY2luYy5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogVmVua2F0YSBQcmFzYWQgUG90dHVydSA8cXVpY19wb3R0dXJ1QHF1aWNpbmMuY29tPgo+IC0t
LQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC1jcmQuZHRzwqAgfMKgwqAgNCAr
Kwo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC1pZHAuZHRzaSB8wqAgNTIgKysr
KysrKysrKysrKysKPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zYzcyODAuZHRzacKgwqDC
oMKgIHwgMTEzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiDCoDMgZmlsZXMgY2hh
bmdlZCwgMTY5IGluc2VydGlvbnMoKykKClsuLi5dCgoKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9xY29tL3NjNzI4MC1pZHAuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNv
bS9zYzcyODAtaWRwLmR0c2kKPiBpbmRleCBkZGViNTA4Li45NDYxNGM5IDEwMDY0NAo+IC0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zYzcyODAtaWRwLmR0c2kKPiArKysgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL3Fjb20vc2M3MjgwLWlkcC5kdHNpCj4gQEAgLTYzNiwzICs2MzYsNTUgQEAK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJpYXMtcHVsbC11cDsKPiDCoMKgwqDC
oMKgwqDCoMKgfTsKPiDCoH07Cj4gKwo+ICsmc3dyMCB7Cj4gK8KgwqDCoMKgwqDCoMKgd2NkX3J4
OiB3Y2Q5Mzh4LXJ4ewoKU3BhY2UgYmVmb3JlIGJyYWNlLi4uCgo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gInNkdzIwMjE3MDEwZDAwIjsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDAgND47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCNzb3VuZC1kYWktY2VsbHMgPSA8MT47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHFjb20scngtcG9ydC1tYXBwaW5nID0gPDEgMiAzIDQgNT47Cj4gK8KgwqDCoMKg
wqDCoMKgfTsKPiArfTsKPiArCj4gKyZzd3IxIHsKPiArwqDCoMKgwqDCoMKgwqB3Y2RfdHg6IHdj
ZDkzOHgtdHh7CgpEaXR0by4uLgoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29t
cGF0aWJsZSA9ICJzZHcyMDIxNzAxMGQwMCI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJlZyA9IDwwIDM+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjc291bmQt
ZGFpLWNlbGxzID0gPDE+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBxY29tLHR4
LXBvcnQtbWFwcGluZyA9IDwxIDIgMyA0PjsKPiArwqDCoMKgwqDCoMKgwqB9Owo+ICt9Owo+ICsK
PiArJnNvYyB7Cj4gK8KgwqDCoMKgwqDCoMKgbWF4OTgzNjBhOiBhdWRpby1jb2RlYy0wIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJtYXhpbSxtYXg5ODM2
MGEiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JmFt
cF9lbj47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNkbW9kZS1ncGlvcyA9IDwm
dGxtbSA2MyBHUElPX0FDVElWRV9ISUdIPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgI3NvdW5kLWRhaS1jZWxscyA9IDwwPjsKPiArwqDCoMKgwqDCoMKgwqB9Owo+ICsKPiArwqDC
oMKgwqDCoMKgwqB3Y2Q5Mzh4OiBjb2RlYyB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGNvbXBhdGlibGUgPSAicWNvbSx3Y2Q5MzgwLWNvZGVjIjsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgI3NvdW5kLWRhaS1jZWxscyA9IDwxPjsKPiArCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJlc2V0LWdwaW9zID0gPCZ0bG1tIDgzIDA+OwoKR1BJT19BQ1RJ
VkVfSElHSCA/Cgo=



