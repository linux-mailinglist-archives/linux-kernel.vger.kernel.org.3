Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64A48BE50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349288AbiALF0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:26:13 -0500
Received: from box.aukejan.com ([173.82.79.94]:34141 "EHLO box.aukejan.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236995AbiALF0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:26:12 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 00:26:12 EST
Received: from authenticated-user (box.aukejan.com [173.82.79.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.aukejan.com (Postfix) with ESMTPSA id EA8565D023;
        Tue, 11 Jan 2022 21:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=boldcoder.com;
        s=mail; t=1641964808;
        bh=zQ1PVvuIFNC14+I+rfwXtUA2El8AVu5Xww1hekw4iLU=;
        h=Subject:References:To:Cc:From:Date:In-Reply-To:From;
        b=OwsGKXYrlQI7gXVZKiD93Ji4yTJNTq16331b/L2nXK/T9fLhf1CXRdSgM+12d1GWE
         jRb6FLZJT4dG2T8jqyeequbAPLX+JW/GSZWLMPSinBCkihrPvlQ1K53O62mxeEV2UJ
         6WrEYiIio5MhQNqYsqtyeAteveV3K5qrwP5+1yeJOFzNm37bd/KUAn+jAaQPlbni0V
         NY3IUy06oblJFj60dYdJ0LdDUG/w3p3vHtOhkY1zukyeL0I0m5KBikCAA5rXvorIVT
         kHkSczOKTpdxr0ES6AsLE86/dXR+41NZZ1ZSgrmN6mKiDyx384CDddrgXK4PHaZ2Di
         jio1J92qwwcBQ==
Subject: One-line patch: Make ACPI provide CEDT table
References: <9d2182c6-9c63-f3dd-91a6-efdf3671ed61@boldcoder.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
From:   Robert Kiraly <me@boldcoder.com>
X-Forwarded-Message-Id: <9d2182c6-9c63-f3dd-91a6-efdf3671ed61@boldcoder.com>
Message-ID: <1f2236ac-0517-8de6-a7a0-a9d04f65bdc8@boldcoder.com>
Date:   Tue, 11 Jan 2022 21:20:09 -0800
MIME-Version: 1.0
In-Reply-To: <9d2182c6-9c63-f3dd-91a6-efdf3671ed61@boldcoder.com>
Content-Type: multipart/mixed;
 boundary="------------5EEE7986C7511B382BBB6404"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5EEE7986C7511B382BBB6404
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch is a one-line change to linux-pm 5.16-rc8.

The patch simply adds ACPI_SIG_CEDT to table_sigs[] in 
"drivers/acpi/tables.c".

Presently, CXL code isn't able to make use of the CEDT table. Subsequent 
to the change, the CEDT table can be used.

If a developer plans to use the CEDT table to program the CXL ports, 
this change is needed. Otherwise, it isn't expected to make a difference.

If this should go to linux-acpi as opposed to linux-pm, please excuse 
the error.

Regards, Robert (the Old Coder)


--------------5EEE7986C7511B382BBB6404
Content-Type: text/plain; charset=UTF-8;
 name="220111-cedt-patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="220111-cedt-patch.txt"

U3ViamVjdDogTWFrZSBBQ1BJIHN1YnN5c3RlbSBwcm92aWRlIENFRFQgdGFibGUKQXV0aG9y
OiBSb2JlcnQgS2lyYWx5IDxtZUBib2xkY29kZXIuY29tPgoKVGhpcyAgaXMgYSAgb25lLWxp
bmUgcGF0Y2ggdG8gdGhlICJsaW51eC1wbSIgQUNQSSBzdWJzeXN0ZW0gNS4xNi0KcmM4LgoK
VGhlIHBhdGNoIHNpbXBseSBhZGRzIEFDUElfU0lHX0NFRFQgdG8gdGFibGVfc2lnc1tdIGlu
ICAiZHJpdmVycy8KYWNwaS90YWJsZXMuYyIuCgpQcmVzZW50bHksIENYTCAgY29kZSAgaXNu
J3QgYWJsZSB0byBtYWtlIHVzZSBvZiB0aGUgIENFRFQgIHRhYmxlLgpTdWJzZXF1ZW50IHRv
IHRoZSBjaGFuZ2UsIHRoZSBDRURUIHRhYmxlIGNhbiBiZSB1c2VkLgoKSWYgIGEgZGV2ZWxv
cGVyICBwbGFucyB0byB1c2UgdGhlIENFRFQgdGFibGUgdG8gIHByb2dyYW0gIHRoZSBDWEwK
cG9ydHMsICB0aGlzIGNoYW5nZSBpcyBuZWVkZWQuICBPdGhlcndpc2UsICBpdCBpc24ndCAg
ZXhwZWN0ZWQgdG8KbWFrZSBhIGRpZmZlcmVuY2UuCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9h
Y3BpL3RhYmxlcy5jIGIvZHJpdmVycy9hY3BpL3RhYmxlcy5jCmluZGV4IDcxNDE5ZWIxNmUw
OS4uM2NjY2Q3YTEyZjIyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvdGFibGVzLmMKKysr
IGIvZHJpdmVycy9hY3BpL3RhYmxlcy5jCkBAIC01MDAsNyArNTAwLDcgQEAgc3RhdGljIGNv
bnN0IGNoYXIgdGFibGVfc2lnc1tdW0FDUElfTkFNRVNFR19TSVpFXSBfX2luaXRjb25zdCA9
IHsKIAlBQ1BJX1NJR19XRERULCBBQ1BJX1NJR19XRFJULCBBQ1BJX1NJR19EU0RULCBBQ1BJ
X1NJR19GQURULAogCUFDUElfU0lHX1BTRFQsIEFDUElfU0lHX1JTRFQsIEFDUElfU0lHX1hT
RFQsIEFDUElfU0lHX1NTRFQsCiAJQUNQSV9TSUdfSU9SVCwgQUNQSV9TSUdfTkZJVCwgQUNQ
SV9TSUdfSE1BVCwgQUNQSV9TSUdfUFBUVCwKLQlBQ1BJX1NJR19OSExUIH07CisJQUNQSV9T
SUdfTkhMVCwgQUNQSV9TSUdfQ0VEVCB9OwogCiAjZGVmaW5lIEFDUElfSEVBREVSX1NJWkUg
c2l6ZW9mKHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlcikKIAo9PT0gZW5kIG9mIHBhdGNoID09
PT0K
--------------5EEE7986C7511B382BBB6404--
