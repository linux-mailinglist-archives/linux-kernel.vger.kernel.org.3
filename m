Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22AA5B28F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIHWCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIHWCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0404E18342
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1960961E3D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15275C433D6;
        Thu,  8 Sep 2022 22:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662674496;
        bh=nGZ4swDa3OFvOI7Xc2HZQiOx17JQyHGawucvj1sg054=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FIBQCxzhYuqa7ClmAaVqNVmugUKUPwZJth+7t3svZimMaKx65CZYWwkORB+gYg5GD
         o6i1R95XaC880lC+LaW3nPcC8eLXVc4pPVIOEKDwG2et95Yzgq5E7/fuSxETOAQ531
         P1p8PCUyY70JzuYXGrGRyNKQvq7TQJHk/rTPpK5+S9y5O4TfSauLk/xWg7jrjzL0QX
         ET5bgHsXX4SQApCPUOBTL9U0kVgPqoEx61+G9Kc9mEWxdPrqSqks39j/RwKvPEUQGx
         yvMWir1TnOSzTWjV7LqvWja/rVCC4BwJZZNFUj1hN5Jm4LpYjhrbwpIRulHJcL/xAO
         cGnn+omjPvSEg==
Message-ID: <03886bfdb74195c08f92ce7acc112ff387b1a2da.camel@kernel.org>
Subject: Re: [PATCH v5 0/6] tracing/hist: Add percentage histogram suffixes
From:   Tom Zanussi <zanussi@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Date:   Thu, 08 Sep 2022 17:01:34 -0500
In-Reply-To: <166226473132.223837.9011128463174539022.stgit@devnote2>
References: <166226473132.223837.9011128463174539022.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFzYW1pLAoKT24gU3VuLCAyMDIyLTA5LTA0IGF0IDEzOjEyICswOTAwLCBNYXNhbWkgSGly
YW1hdHN1IChHb29nbGUpIHdyb3RlOgo+IEhpLAo+IAo+IEhlcmUgaXMgdGhlIDV0aCB2ZXJzaW9u
IG9mIC5wZXJjZW50IGFuZCAuZ3JhcGggc3VmZml4ZXMgZm9yIGhpc3RvZ3JhbQo+IHRyaWdnZXIg
dG8gc2hvdyB0aGUgdmFsdWUgaW4gcGVyY2VudGFnZSBhbmQgaW4gYmFyLWdyYXBoCj4gcmVzcGVj
dGl2ZWx5Lgo+IFRoZSBwcmV2aW91cyB2ZXJzaW9uIGlzIGhlcmU7Cj4gCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzE2NjE1NzI5ODUzNy4zNDg5MjQuMjUzNzE2MjA5MDUwNTM5NzM3Ny5z
dGdpdEBkZXZub3RlMgo+IAo+IFRoaXMgdmVyc2lvbiB1cGRhdGVkIHRoZSBsYXN0IHBhdGNoIHRv
IGFkZCAibm9oaXRjb3VudCIgb3B0aW9uIGZvcgo+IHN1cHJlc3NpbmcgZGlzcGxheSBvZiBoaXRj
b3VudCBhY2NvcmRpbmcgdG8gVG9tJ3Mgc3VnZ2VzdGlvbls1LzZdLAo+IGZpeCBSRUFETUUgZmls
ZVs0LzZdLCBhbmQgdXBkYXRlIHRoZSBoaXN0b2dyYW0gZG9jdW1lbnRbNi82XS4KPiAKPiBUaGlz
IHdpbGwgaGVscCB1cyB0byBjaGVjayB0aGUgdHJlbmQgb2YgdGhlIGhpc3RvZ3JhbSBpbnN0YW50
bHkKPiB3aXRob3V0IGFueSBwb3N0IHByb2Nlc3NpbmcgdG9vbC4KPiAKPiBIZXJlIHNob3dzIGFu
IGV4YW1wbGUgb2YgdGhlIHBlcmNlbnRhZ2UgYW5kIHRoZSBiYXIgZ3JhcGggb2YKPiB0aGUgcnVu
dGltZSBvZiB0aGUgcnVubmluZyB0YXNrcyB3aXRob3V0IHJhdyBoaXRjb3VudCBmaWVsZC4KPiAK
PiDCoCAjIGNkIC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcvCj4gwqAgIyBlY2hvCj4gaGlzdDpr
ZXlzPXBpZDp2YWxzPWhpdGNvdW50LnBlcmNlbnQsaGl0Y291bnQuZ3JhcGg6c29ydD1waWQ6Tk9I
QyA+IFwKPiDCoMKgwqDCoMKgwqDCoCBldmVudHMvc2NoZWQvc2NoZWRfc3RhdF9ydW50aW1lL3Ry
aWdnZXIKPiDCoCAjIHNsZWVwIDEwCj4gwqAgIyBjYXQgZXZlbnRzL3NjaGVkL3NjaGVkX3N0YXRf
cnVudGltZS9oaXN0Cj4gwqAjIGV2ZW50IGhpc3RvZ3JhbQo+IMKgIwo+IMKgIyB0cmlnZ2VyIGlu
Zm86Cj4gaGlzdDprZXlzPXBpZDp2YWxzPWhpdGNvdW50LnBlcmNlbnQsaGl0Y291bnQuZ3JhcGg6
c29ydD1waWQ6c2l6ZT0yMDQ4Cj4gOm5vaGl0Y291bnQgW2FjdGl2ZV0KPiDCoCMKPiDCoAo+IMKg
eyBwaWQ6wqDCoMKgwqDCoMKgwqDCoCAxNCB9wqAgaGl0Y291bnQgKCUpOsKgwqAgNi45McKgIGhp
dGNvdW50Ogo+ICMjwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoHsgcGlk
OsKgwqDCoMKgwqDCoMKgwqAgMTYgfcKgIGhpdGNvdW50ICglKTrCoMKgIDEuMTPCoAo+IGhpdGNv
dW50OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqB7IHBpZDrC
oMKgwqDCoMKgwqDCoMKgIDU3IH3CoCBoaXRjb3VudCAoJSk6wqDCoCA2Ljk5wqAgaGl0Y291bnQ6
Cj4gIyPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgeyBwaWQ6wqDCoMKg
wqDCoMKgwqDCoCA2MSB9wqAgaGl0Y291bnQgKCUpOsKgIDU1LjI4wqAgaGl0Y291bnQ6Cj4gIyMj
IyMjIyMjIyMjIyMjIyMjIyMKPiDCoHsgcGlkOsKgwqDCoMKgwqDCoMKgwqAgNjcgfcKgIGhpdGNv
dW50ICglKTrCoMKgIDUuNTLCoCBoaXRjb3VudDoKPiAjI8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgCj4gwqB7IHBpZDrCoMKgwqDCoMKgwqDCoMKgIDY5IH3CoCBoaXRjb3VudCAo
JSk6wqAgMjAuMDjCoCBoaXRjb3VudDoKPiAjIyMjIyMjwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IAo+IMKgeyBwaWQ6wqDCoMKgwqDCoMKgwqDCoCA3MSB9wqAgaGl0Y291bnQgKCUpOsKgwqAgMC40
MMKgCj4gaGl0Y291bnQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAK
PiDCoHsgcGlkOsKgwqDCoMKgwqDCoMKgwqAgNzcgfcKgIGhpdGNvdW50ICglKTrCoMKgIDAuOTfC
oAo+IGhpdGNvdW50OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4g
wqB7IHBpZDrCoMKgwqDCoMKgwqDCoMKgIDc4IH3CoCBoaXRjb3VudCAoJSk6wqDCoCAwLjU2wqAK
PiBoaXRjb3VudDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKg
eyBwaWQ6wqDCoMKgwqDCoMKgwqAgMTQ1IH3CoCBoaXRjb3VudCAoJSk6wqDCoCAxLjEzwqAKPiBo
aXRjb3VudDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgeyBw
aWQ6wqDCoMKgwqDCoMKgwqAgMTUzIH3CoCBoaXRjb3VudCAoJSk6wqDCoCAwLjQ4wqAKPiBoaXRj
b3VudDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgeyBwaWQ6
wqDCoMKgwqDCoMKgwqAgMTU0IH3CoCBoaXRjb3VudCAoJSk6wqDCoCAwLjQ4wqAKPiBoaXRjb3Vu
dDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+IMKgCj4gwqBUb3Rh
bHM6Cj4gwqDCoMKgwqAgSGl0czogMTIzMAo+IMKgwqDCoMKgIEVudHJpZXM6IDEyCj4gwqDCoMKg
wqAgRHJvcHBlZDogMAo+IAo+IAo+IFdpdGggdGhlIE5PSEMgKG9yIG5vaGl0Y291bnQpIG9wdGlv
biwgdGhlIGhpc3RvZ3JhbSB3aWxsIHNraXAKPiBkaXNwbGF5IG9mIHJhdyBoaXRjb3VudCwgYnV0
IGl0IHdpbGwgYWxsb3cgdG8gZGlzcGxheSBwZXJjZW50Cj4gYW5kIGdyYXBoIG9mIGhpdGNvdW50
Lgo+IAo+IFRyaWdnZXLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
UmVzdWx0Cj4gdmFsPXJ1bnRpbWXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0+IFNob3cg
aGl0Y291bnQgYW5kIHJ1bnRpbWUKPiB2YWw9cnVudGltZTpOT0hDwqDCoMKgwqDCoMKgwqDCoMKg
IC0+IFNob3cgcnVudGltZQo+IHZhbD1oaXRjb3VudDpOT0hDwqDCoMKgwqDCoMKgwqDCoCAtPiBF
cnJvcgo+IChub3ZhbCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLT4gc2hv
dyBoaXRjb3VudAo+IChub3ZhbCk6Tk9IQ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0+IEVy
cm9yCj4gdmFsPWhpdGNvdW50LnBhcmNlbnTCoMKgwqDCoMKgIC0+IHNob3cgaGl0Y291bnQgYW5k
IGhpdGNvdW50JQo+IHZhbD1oaXRjb3VudC5wYXJjZW50Ok5PSEMgLT4gc2hvdyBoaXRjb3VudCUK
Ckl0IGFsbCBsb29rcyBnb29kIHRvIG1lLCB0aGFua3MhICBGb3IgdGhlIHdob2xlIHNldDoKClJl
dmlld2VkLWJ5OiBUb20gWmFudXNzaSA8emFudXNzaUBrZXJuZWwub3JnPgpUZXN0ZWQtYnk6IFRv
bSBaYW51c3NpIDx6YW51c3NpQGtlcm5lbC5vcmc+CgpUb20KCgoKPiAKPiBUaGFuayB5b3UsCj4g
Cj4gLS0tCj4gCj4gTWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKSAoNSk6Cj4gwqDCoMKgwqDCoCB0
cmFjaW5nOiBGaXggdG8gY2hlY2sgZXZlbnRfbXV0ZXggaXMgaGVsZCB3aGlsZSBhY2Nlc3NpbmcK
PiB0cmlnZ2VyIGxpc3QKPiDCoMKgwqDCoMKgIHRyYWNpbmc6IEFkZCAucGVyY2VudCBzdWZmaXgg
b3B0aW9uIHRvIGhpc3RvZ3JhbSB2YWx1ZXMKPiDCoMKgwqDCoMKgIHRyYWNpbmc6IEFkZCAuZ3Jh
cGggc3VmZml4IG9wdGlvbiB0byBoaXN0b2dyYW0gdmFsdWUKPiDCoMKgwqDCoMKgIHRyYWNpbmc6
IEFkZCBub2hpdGNvdW50IG9wdGlvbiBmb3Igc3VwcHJlc3NpbmcgZGlzcGxheSBvZiByYXcKPiBo
aXRjb3VudAo+IMKgwqDCoMKgwqAgdHJhY2luZzogZG9jczogVXBkYXRlIGhpc3RvZ3JhbSBkb2Mg
Zm9yIC5wZXJjZW50Ly5ncmFwaCBhbmQKPiAnbm9oaXRjb3VudCcKPiAKPiBUb20gWmFudXNzaSAo
MSk6Cj4gwqDCoMKgwqDCoCB0cmFjaW5nOiBBbGxvdyBtdWx0aXBsZSBoaXRjb3VudCB2YWx1ZXMg
aW4gaGlzdG9ncmFtcwo+IAo+IAo+IMKgRG9jdW1lbnRhdGlvbi90cmFjZS9oaXN0b2dyYW0ucnN0
wqDCoCB8wqDCoCAxMCArKwo+IMKga2VybmVsL3RyYWNlL3RyYWNlLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqDCoCA3ICsKPiDCoGtlcm5lbC90cmFjZS90cmFjZV9ldmVudHNf
aGlzdC5jwqDCoMKgIHzCoCAxNzcKPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LQo+IMKga2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50c190cmlnZ2VyLmMgfMKgwqDCoCAzIC0KPiDC
oDQgZmlsZXMgY2hhbmdlZCwgMTcxIGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQo+IAo+
IC0tCj4gTWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKSA8bWhpcmFtYXRAa2VybmVsLm9yZz4KCg==

