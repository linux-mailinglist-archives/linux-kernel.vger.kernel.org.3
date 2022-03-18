Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0984F4DE0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiCRSZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiCRSZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:25:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A315FE3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647627850; x=1679163850;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to;
  bh=1VbnP1mRtzIbhksGgYufc6ivWNFeYoiZ/Vp5uhlkKVU=;
  b=LQGeUKSYgXGRGHgd+woGpmLABkAqbVpzGv4B9ShAwy5S4LexaloLVSKh
   Vk8uCKvzcvHTOOzygdBZeAUzKu9UH+xlVKUwUI1hYowl4u7Ld6MJORHfD
   Rqwuiab3nOJ/oBw8APuBt5OdZthYzPHxtl2UTB2sfyPTVtQsx1ePrSh2l
   2QmE1EQHKLdE8lXHacDWMT4wQ5/EVE2J6poAPOv0LfdJiAZRJV083ltc1
   aNbZdjSbvi4m+loNL+cqB/H1nY6z69inN3+YrcI4WrFIcjRZdOpeIrIPw
   8e6MYJFmISlPxo6gUY1MmZbeh/ZiHESlK4xM4uUduSwErMdqf56hA3ZfW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="282009602"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208,223";a="282009602"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:24:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208,223";a="558583534"
Received: from chittoor-mobl.amr.corp.intel.com (HELO [10.209.39.43]) ([10.209.39.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:24:09 -0700
Content-Type: multipart/mixed; boundary="------------8dCzQFjC8i0PZWmyOBLqIwoU"
Message-ID: <2847763c-6202-9e2a-54c5-44c761b59a63@intel.com>
Date:   Fri, 18 Mar 2022 11:23:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-22-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv7 21/30] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
In-Reply-To: <20220318153048.51177-22-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8dCzQFjC8i0PZWmyOBLqIwoU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/22 08:30, Kirill A. Shutemov wrote:
> +	/*
> +	 * After writing the wakeup command, wait for maximum timeout of 0xFF
> +	 * for firmware to reset the command address back zero to indicate
> +	 * the successful reception of command.
> +	 * NOTE: 0xFF as timeout value is decided based on our experiments.
> +	 *
> +	 * XXX: Change the timeout once ACPI specification comes up with
> +	 *      standard maximum timeout value.
> +	 */
> +	timeout = 0xFF;
> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
> +		cpu_relax();

I don't feel like this was ever actually resolved.  This timeout
basically boiled down to "this value seems to work for us".  There are
also *SURELY* timeouts that are going to happen here.

In the end, the host has to choose to run the guest.  If it decides for
some odd reason not to run the CPU that's being booted, we'll get timeouts.

The other thing that baffles me is the re-wakeup bits:

>         /*
>          * If the CPU wakeup process is successful, store the
>          * status in apic_id_wakemap to prevent re-wakeup
>          * requests.
>          */
>         physid_set(apicid, apic_id_wakemap);
> 
>         return 0;
> }

If this goes wrong, won't the new wakeup just timeout?  Do we really
need a dedicated mechanism to stop re-wakeups?  How much of a problem is
this going to be?

Anyway, see the totally untested hunk I've attached.  It fixes a bunch
of issues IMNHO.
--------------8dCzQFjC8i0PZWmyOBLqIwoU
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-acpi-x86-boot-Add-multiprocessor-wake-up-support.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-acpi-x86-boot-Add-multiprocessor-wake-up-support.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0ZWExMGQ3MDg0ZTU4YzM2NzcyNGQ3ZTMyNzhhNjJiZWVmMjU2MWQ0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiA8c2F0
aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPgpEYXRlOiBGcmksIDE4
IE1hciAyMDIyIDE4OjMwOjM5ICswMzAwClN1YmplY3Q6IFtQQVRDSF0geDg2L2FjcGksIHg4
Ni9ib290OiBBZGQgbXVsdGlwcm9jZXNzb3Igd2FrZS11cCBzdXBwb3J0CgogKiBSZXdyaXRl
IGNoYW5nZWxvZwogKiBGaXggdG9vLXdpZGUgLT5hcGljX2lkIHZlcnRpY2FsIGFsaWdubWVu
dAogKiBSZW1vdmUgZXJyYW50ICJWaXJ0dWFsIGFkZHJlc3Mgb2YgLi4uIiBjb21tZW50CiAq
IFJlbmFtZSB0aW1lb3V0PT53YWtlX3RyaWVzX2xlZnQKICogTWFrZSB3YWtlX3RyaWVzX2xl
ZnQgYW4gaW50LCBub3QgYSB1OAogKiBBY3R1YWxseSB0cnkgdG8gZXhwbGFpbiB0aGUgdGlt
ZW91dCBpbiBhIGNvbW1lbnQKICAgKiBJJ2Qgc3RpbGwgbG92ZSB0byBrbm93IHdoYXQgdGhl
IGV4cGVyaW1lbnQgYWN0dWFsbHkgZGlkIGFuZAogICAgIHdoYXQgdGhlIGxvd2VyIGJvdW5k
IG9uIHRoZSB0aW1lb3V0IGlzLiAgT2ggd2VsbC4KICogQ2hhbmdlIHNtcF93bWIoKS9XUklU
RV9PTkNFKCkgYmFjayB0byBQZXRlcnoncwogICBzbXBfc3RvcmVfcmVsZWFzZSgpIHN1Z2dl
c3Rpb24uCiAqIFVzZSBzbXBfc3RvcmVfcmVsZWFzZSgpIGZvciA9MCB0b28KICogYWRkIGEg
cHJfd2FybigpIGZvciBmYWlsdXJlcwogKiBBZGQgYW4gZW5kaWYgI2lmZGVmIGNvbW1lbnQs
IGFuZCBmaXggdXAgQ09ORklHX1g4Nl9MT0NBTF9BUElDCiAgIG9kZGl0eS4KCi0tCgpTZWNv
bmRhcnkgQ1BVIHN0YXJ0dXAgaXMgY3VycmVudGx5IHBlcmZvcm1lZCB3aXRoIHNvbWV0aGlu
ZyBjYWxsZWQKdGhlICJJTklUL1NJUEkgcHJvdG9jb2wiLiAgVGhpcyBwcm90b2NvbCByZXF1
aXJlcyBhc3Npc3RhbmNlIGZyb20KVk1NcyB0byBib290IGd1ZXN0cy4gIEFzIHNob3VsZCBi
ZSBhIGZhbWlsaWFyIHN0b3J5IGJ5IG5vdywgdGhhdApzdXBwb3J0IGNhbiBub3QgYmUgcHJv
dmRlZCB0byBURFggZ3Vlc3RzIGJlY2F1c2UgVERYIFZNTXMgYXJlCm5vdCB0cnVzdGVkIGJ5
IGd1ZXN0cy4KClRvIHJlbWVkeSB0aGlzIHNpdHVhdGlvbiBhIG5ld1sxXSAiTXVsdGlwcm9j
ZXNzb3IgV2FrZXVwIFN0cnVjdHVyZSIKaGFzIGJlZW4gYWRkZWQgdG8gdG8gYW4gZXhpc3Rp
bmcgQUNQSSB0YWJsZSAoTUFEVCkuICBUaGlzIHN0cnVjdHVyZQpwcm92aWRlcyB0aGUgcGh5
c2ljYWwgYWRkcmVzcyBvZiBhICJtYWlsYm94Ii4gIEEgd3JpdGUgdG8gdGhlIG1haWxib3gK
dGhlbiBzdGVlcnMgdGhlIHNlY29uZGFyeSBDUFUgdG8gdGhlIGJvb3QgY29kZS4KCkFkZCBB
Q1BJIE1BRFQgd2FrZSBzdHJ1Y3R1cmUgcGFyc2luZyBzdXBwb3J0IGFuZCB3YWtlIHN1cHBv
cnQuICBVc2UKdGhpcyBzdXBwb3J0IHRvIHdha2UgQ1BVcyB3aGVuZXZlciBpdCBpcyBwcmVz
ZW50IGluc3RlYWQgb2YgSU5JVC9TSVBJLgoKV2hpbGUgdGhpcyBzdHJ1Y3R1cmUgY2FuIHRo
ZW9yZXRpY2FsbHkgYmUgdXNlZCBvbiAzMi1iaXQga2VybmVscywKdGhlcmUgYXJlIG5vIDMy
LWJpdCBURFggZ3Vlc3Qga2VybmVscy4gIEl0IGhhcyBub3QgYmVlbiB0ZXN0ZWQgYW5kCmNh
biBub3QgcHJhY3RpY2FsbHkgKmJlKiB0ZXN0ZWQgb24gMzItYml0LiAgTWFrZSBpdCA2NC1i
aXQgb25seS4KCjEuIERldGFpbHMgYWJvdXQgdGhlIG5ldyBzdHJ1Y3R1cmUgY2FuIGJlIGZv
dW5kIGluIEFDUEkgdjYuNCwgaW4gdGhlCiAgICJNdWx0aXByb2Nlc3NvciBXYWtldXAgU3Ry
dWN0dXJlIiBzZWN0aW9uLgoKQ28tZGV2ZWxvcGVkLWJ5OiBTZWFuIENocmlzdG9waGVyc29u
IDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBTZWFu
IENocmlzdG9waGVyc29uIDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPgpSZXZp
ZXdlZC1ieTogQW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwuY29tPgpSZXZpZXdlZC1ieTog
UmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgpTaWduZWQt
b2ZmLWJ5OiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiA8c2F0aHlhbmFyYXlhbmFuLmt1
cHB1c3dhbXlAbGludXguaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1
dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+Ci0tLQogYXJjaC94ODYv
aW5jbHVkZS9hc20vYXBpYy5oIHwgICA1ICsrCiBhcmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290
LmMgfCAxMTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBhcmNoL3g4
Ni9rZXJuZWwvYXBpYy9hcGljLmMgfCAgMTAgKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxMzAg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FwaWMu
aCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FwaWMuaAppbmRleCA0ODA2N2FmOTQ2NzguLjNj
ZWY3ZjEyNjg3NiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYXBpYy5oCisr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FwaWMuaApAQCAtNDg4LDYgKzQ4OCwxMSBAQCBz
dGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCByZWFkX2FwaWNfaWQodm9pZCkKIAlyZXR1cm4g
YXBpYy0+Z2V0X2FwaWNfaWQocmVnKTsKIH0KIAorI2lmZGVmIENPTkZJR19YODZfNjQKK3R5
cGVkZWYgaW50ICgqd2FrZXVwX2NwdV9oYW5kbGVyKShpbnQgYXBpY2lkLCB1bnNpZ25lZCBs
b25nIHN0YXJ0X2VpcCk7CitleHRlcm4gdm9pZCBhY3BpX3dha2VfY3B1X2hhbmRsZXJfdXBk
YXRlKHdha2V1cF9jcHVfaGFuZGxlciBoYW5kbGVyKTsKKyNlbmRpZgorCiBleHRlcm4gaW50
IGRlZmF1bHRfYXBpY19pZF92YWxpZCh1MzIgYXBpY2lkKTsKIGV4dGVybiBpbnQgZGVmYXVs
dF9hY3BpX21hZHRfb2VtX2NoZWNrKGNoYXIgKiwgY2hhciAqKTsKIGV4dGVybiB2b2lkIGRl
ZmF1bHRfc2V0dXBfYXBpY19yb3V0aW5nKHZvaWQpOwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL2FjcGkvYm9vdC5jIGIvYXJjaC94ODYva2VybmVsL2FjcGkvYm9vdC5jCmluZGV4
IDViNmQxYTk1Nzc2Zi4uMGViZmFiMGY0ZjdhIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvYWNwaS9ib290LmMKKysrIGIvYXJjaC94ODYva2VybmVsL2FjcGkvYm9vdC5jCkBAIC02
NSw2ICs2NSwxMyBAQCBzdGF0aWMgdTY0IGFjcGlfbGFwaWNfYWRkciBfX2luaXRkYXRhID0g
QVBJQ19ERUZBVUxUX1BIWVNfQkFTRTsKIHN0YXRpYyBib29sIGFjcGlfc3VwcG9ydF9vbmxp
bmVfY2FwYWJsZTsKICNlbmRpZgogCisjaWZkZWYgQ09ORklHX1g4Nl82NAorLyogUGh5c2lj
YWwgYWRkcmVzcyBvZiB0aGUgTXVsdGlwcm9jZXNzb3IgV2FrZXVwIFN0cnVjdHVyZSBtYWls
Ym94ICovCitzdGF0aWMgdTY0IGFjcGlfbXBfd2FrZV9tYWlsYm94X3BhZGRyOworLyogVmly
dHVhbCBhZGRyZXNzIG9mIHRoZSBNdWx0aXByb2Nlc3NvciBXYWtldXAgU3RydWN0dXJlIG1h
aWxib3ggKi8KK3N0YXRpYyBzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193YWtldXBfbWFp
bGJveCAqYWNwaV9tcF93YWtlX21haWxib3g7CisjZW5kaWYKKwogI2lmZGVmIENPTkZJR19Y
ODZfSU9fQVBJQwogLyoKICAqIExvY2tzIHJlbGF0ZWQgdG8gSU9BUElDIGhvdHBsdWcKQEAg
LTMzNiw2ICszNDMsODMgQEAgYWNwaV9wYXJzZV9sYXBpY19ubWkodW5pb24gYWNwaV9zdWJ0
YWJsZV9oZWFkZXJzICogaGVhZGVyLCBjb25zdCB1bnNpZ25lZCBsb25nIGUKIAlyZXR1cm4g
MDsKIH0KIAorI2lmZGVmIENPTkZJR19YODZfNjQKKy8qIFZpcnR1YWwgYWRkcmVzcyBvZiB0
aGUgTXVsdGlwcm9jZXNzb3IgV2FrZXVwIFN0cnVjdHVyZSBtYWlsYm94ICovCitzdGF0aWMg
aW50IGFjcGlfd2FrZXVwX2NwdShpbnQgYXBpY2lkLCB1bnNpZ25lZCBsb25nIHN0YXJ0X2lw
KQoreworCXN0YXRpYyBwaHlzaWRfbWFza190IGFwaWNfaWRfd2FrZW1hcCA9IFBIWVNJRF9N
QVNLX05PTkU7CisJdTggdGltZW91dDsKKworCS8qCisJICogUmVtYXAgbWFpbGJveCBtZW1v
cnkgb25seSBmb3IgdGhlIGZpcnN0IGNhbGwgdG8gYWNwaV93YWtldXBfY3B1KCkuCisJICoK
KwkgKiBXYWtldXAgb2Ygc2Vjb25kYXJ5IENQVXMgaXMgZnVsbHkgc2VyaWFsaXplZCBpbiB0
aGUgY29yZSBjb2RlLgorCSAqIE5vIG5lZWQgdG8gcHJvdGVjdCBhY3BpX21wX3dha2VfbWFp
bGJveCBmcm9tIGNvbmN1cnJlbnQgYWNjZXNzZXMuCisJICovCisJaWYgKCFhY3BpX21wX3dh
a2VfbWFpbGJveCkgeworCQlhY3BpX21wX3dha2VfbWFpbGJveCA9IG1lbXJlbWFwKGFjcGlf
bXBfd2FrZV9tYWlsYm94X3BhZGRyLAorCQkJCQkJc2l6ZW9mKCphY3BpX21wX3dha2VfbWFp
bGJveCksCisJCQkJCQlNRU1SRU1BUF9XQik7CisJfQorCisJLyoKKwkgKiBBY2NvcmRpbmcg
dG8gdGhlIEFDUEkgc3BlY2lmaWNhdGlvbiByNi40LCBzZWN0aW9uIHRpdGxlZAorCSAqICJN
dWx0aXByb2Nlc3NvciBXYWtldXAgU3RydWN0dXJlIiB0aGUgbWFpbGJveC1iYXNlZCB3YWtl
dXAKKwkgKiBtZWNoYW5pc20gY2Fubm90IGJlIHVzZWQgbW9yZSB0aGFuIG9uY2UgZm9yIHRo
ZSBzYW1lIENQVS4KKwkgKiBTa2lwIHdha2V1cHMgaWYgdGhleSBhcmUgYXR0ZW1wdGVkIG1v
cmUgdGhhbiBvbmNlLgorCSAqLworCWlmIChwaHlzaWRfaXNzZXQoYXBpY2lkLCBhcGljX2lk
X3dha2VtYXApKSB7CisJCXByX2VycigiQ1BVIGFscmVhZHkgYXdha2UgKEFQSUMgSUQgJXgp
LCBza2lwcGluZyB3YWtldXBcbiIsCisJCSAgICAgICBhcGljaWQpOworCQlyZXR1cm4gLUVJ
TlZBTDsKKwl9CisKKwkvKgorCSAqIE1haWxib3ggbWVtb3J5IGlzIHNoYXJlZCBiZXR3ZWVu
IGZpcm13YXJlIGFuZCBPUy4gRmlybXdhcmUgd2lsbAorCSAqIGxpc3RlbiBvbiBtYWlsYm94
IGNvbW1hbmQgYWRkcmVzcywgYW5kIG9uY2UgaXQgcmVjZWl2ZXMgdGhlIHdha2V1cAorCSAq
IGNvbW1hbmQsIENQVSBhc3NvY2lhdGVkIHdpdGggdGhlIGdpdmVuIGFwaWNpZCB3aWxsIGJl
IGJvb3RlZC4KKwkgKgorCSAqIFRoZSB2YWx1ZSBvZiBhcGljX2lkIGFuZCB3YWtldXBfdmVj
dG9yIGhhcyB0byBiZSBzZXQgYmVmb3JlIHVwZGF0aW5nCisJICogdGhlIHdha2V1cCBjb21t
YW5kLiBVc2UgbWVtb3J5IGJhcnJpZXIgdG8gcHJlc2VydmUgd3JpdGUgb3JkZXIuCisJICov
CisJYWNwaV9tcF93YWtlX21haWxib3gtPmFwaWNfaWQJCT0gYXBpY2lkOworCWFjcGlfbXBf
d2FrZV9tYWlsYm94LT53YWtldXBfdmVjdG9yCT0gc3RhcnRfaXA7CisJc21wX3dtYigpOwor
CVdSSVRFX09OQ0UoYWNwaV9tcF93YWtlX21haWxib3gtPmNvbW1hbmQsIEFDUElfTVBfV0FL
RV9DT01NQU5EX1dBS0VVUCk7CisKKwkvKgorCSAqIEFmdGVyIHdyaXRpbmcgdGhlIHdha2V1
cCBjb21tYW5kLCB3YWl0IGZvciBtYXhpbXVtIHRpbWVvdXQgb2YgMHhGRgorCSAqIGZvciBm
aXJtd2FyZSB0byByZXNldCB0aGUgY29tbWFuZCBhZGRyZXNzIGJhY2sgemVybyB0byBpbmRp
Y2F0ZQorCSAqIHRoZSBzdWNjZXNzZnVsIHJlY2VwdGlvbiBvZiBjb21tYW5kLgorCSAqIE5P
VEU6IDB4RkYgYXMgdGltZW91dCB2YWx1ZSBpcyBkZWNpZGVkIGJhc2VkIG9uIG91ciBleHBl
cmltZW50cy4KKwkgKgorCSAqIFhYWDogQ2hhbmdlIHRoZSB0aW1lb3V0IG9uY2UgQUNQSSBz
cGVjaWZpY2F0aW9uIGNvbWVzIHVwIHdpdGgKKwkgKiAgICAgIHN0YW5kYXJkIG1heGltdW0g
dGltZW91dCB2YWx1ZS4KKwkgKi8KKwl0aW1lb3V0ID0gMHhGRjsKKwl3aGlsZSAoUkVBRF9P
TkNFKGFjcGlfbXBfd2FrZV9tYWlsYm94LT5jb21tYW5kKSAmJiAtLXRpbWVvdXQpCisJCWNw
dV9yZWxheCgpOworCisJLyogSWYgdGltZWQgb3V0ICh0aW1lb3V0ID09IDApLCByZXR1cm4g
ZXJyb3IgKi8KKwlpZiAoIXRpbWVvdXQpIHsKKwkJLyoKKwkJICogWFhYOiBJcyB0aGVyZSBh
IHJlY292ZXJ5IHBhdGggYWZ0ZXIgdGltZW91dCBpcyBoaXQ/CisJCSAqIFNwZWMgaXMgdW5j
bGVhci4gUmVzZXQgY29tbWFuZCB0byAwIGlmIHRpbWVvdXQgaXMgaGl0LgorCQkgKi8KKwkJ
YWNwaV9tcF93YWtlX21haWxib3gtPmNvbW1hbmQgPSAwOworCQlyZXR1cm4gLUVJTzsKKwl9
CisKKwkvKgorCSAqIElmIHRoZSBDUFUgd2FrZXVwIHByb2Nlc3MgaXMgc3VjY2Vzc2Z1bCwg
c3RvcmUgdGhlCisJICogc3RhdHVzIGluIGFwaWNfaWRfd2FrZW1hcCB0byBwcmV2ZW50IHJl
LXdha2V1cAorCSAqIHJlcXVlc3RzLgorCSAqLworCXBoeXNpZF9zZXQoYXBpY2lkLCBhcGlj
X2lkX3dha2VtYXApOworCisJcmV0dXJuIDA7Cit9CisjZW5kaWYKICNlbmRpZgkJCQkvKkNP
TkZJR19YODZfTE9DQUxfQVBJQyAqLwogCiAjaWZkZWYgQ09ORklHX1g4Nl9JT19BUElDCkBA
IC0xMDgzLDYgKzExNjcsMjkgQEAgc3RhdGljIGludCBfX2luaXQgYWNwaV9wYXJzZV9tYWR0
X2xhcGljX2VudHJpZXModm9pZCkKIAl9CiAJcmV0dXJuIDA7CiB9CisKKyNpZmRlZiBDT05G
SUdfWDg2XzY0CitzdGF0aWMgaW50IF9faW5pdCBhY3BpX3BhcnNlX21wX3dha2UodW5pb24g
YWNwaV9zdWJ0YWJsZV9oZWFkZXJzICpoZWFkZXIsCisJCQkJICAgICBjb25zdCB1bnNpZ25l
ZCBsb25nIGVuZCkKK3sKKwlzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193YWtldXAgKm1w
X3dha2U7CisKKwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1NNUCkpCisJCXJldHVybiAtRU5P
REVWOworCisJbXBfd2FrZSA9IChzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193YWtldXAg
KiloZWFkZXI7CisJaWYgKEJBRF9NQURUX0VOVFJZKG1wX3dha2UsIGVuZCkpCisJCXJldHVy
biAtRUlOVkFMOworCisJYWNwaV90YWJsZV9wcmludF9tYWR0X2VudHJ5KCZoZWFkZXItPmNv
bW1vbik7CisKKwlhY3BpX21wX3dha2VfbWFpbGJveF9wYWRkciA9IG1wX3dha2UtPmJhc2Vf
YWRkcmVzczsKKworCWFjcGlfd2FrZV9jcHVfaGFuZGxlcl91cGRhdGUoYWNwaV93YWtldXBf
Y3B1KTsKKworCXJldHVybiAwOworfQorI2VuZGlmCQkJCS8qIENPTkZJR19YODZfNjQgKi8K
ICNlbmRpZgkJCQkvKiBDT05GSUdfWDg2X0xPQ0FMX0FQSUMgKi8KIAogI2lmZGVmCUNPTkZJ
R19YODZfSU9fQVBJQwpAQCAtMTI3OCw2ICsxMzg1LDE0IEBAIHN0YXRpYyB2b2lkIF9faW5p
dCBhY3BpX3Byb2Nlc3NfbWFkdCh2b2lkKQogCiAJCQkJc21wX2ZvdW5kX2NvbmZpZyA9IDE7
CiAJCQl9CisKKyNpZmRlZiBDT05GSUdfWDg2XzY0CisJCQkvKgorCQkJICogUGFyc2UgTUFE
VCBNUCBXYWtlIGVudHJ5LgorCQkJICovCisJCQlhY3BpX3RhYmxlX3BhcnNlX21hZHQoQUNQ
SV9NQURUX1RZUEVfTVVMVElQUk9DX1dBS0VVUCwKKwkJCQkJICAgICAgYWNwaV9wYXJzZV9t
cF93YWtlLCAxKTsKKyNlbmRpZgogCQl9CiAJCWlmIChlcnJvciA9PSAtRUlOVkFMKSB7CiAJ
CQkvKgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2FwaWMvYXBpYy5jIGIvYXJjaC94
ODYva2VybmVsL2FwaWMvYXBpYy5jCmluZGV4IGI3MDM0NGJmNjYwMC4uM2M4ZjJjNzk3YTk4
IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9hcGljLmMKKysrIGIvYXJjaC94
ODYva2VybmVsL2FwaWMvYXBpYy5jCkBAIC0yNTUxLDYgKzI1NTEsMTYgQEAgdTMyIHg4Nl9t
c2lfbXNnX2dldF9kZXN0aWQoc3RydWN0IG1zaV9tc2cgKm1zZywgYm9vbCBleHRpZCkKIH0K
IEVYUE9SVF9TWU1CT0xfR1BMKHg4Nl9tc2lfbXNnX2dldF9kZXN0aWQpOwogCisjaWZkZWYg
Q09ORklHX1g4Nl82NAordm9pZCBfX2luaXQgYWNwaV93YWtlX2NwdV9oYW5kbGVyX3VwZGF0
ZSh3YWtldXBfY3B1X2hhbmRsZXIgaGFuZGxlcikKK3sKKwlzdHJ1Y3QgYXBpYyAqKmRydjsK
KworCWZvciAoZHJ2ID0gX19hcGljZHJpdmVyczsgZHJ2IDwgX19hcGljZHJpdmVyc19lbmQ7
IGRydisrKQorCQkoKmRydiktPndha2V1cF9zZWNvbmRhcnlfY3B1XzY0ID0gaGFuZGxlcjsK
K30KKyNlbmRpZgorCiAvKgogICogT3ZlcnJpZGUgdGhlIGdlbmVyaWMgRU9JIGltcGxlbWVu
dGF0aW9uIHdpdGggYW4gb3B0aW1pemVkIHZlcnNpb24uCiAgKiBPbmx5IGNhbGxlZCBkdXJp
bmcgZWFybHkgYm9vdCB3aGVuIG9ubHkgb25lIENQVSBpcyBhY3RpdmUgYW5kIHdpdGgKLS0g
CjIuMzQuMAoK

--------------8dCzQFjC8i0PZWmyOBLqIwoU--
