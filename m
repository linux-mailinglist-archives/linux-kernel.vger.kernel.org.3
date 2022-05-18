Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918A752BF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbiERPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbiERPjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:39:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC83A5A81;
        Wed, 18 May 2022 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652888363; x=1684424363;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=8WND9E2GnGDv0ic+SbtV8f4+YwokzKLYteBSsNrOeuI=;
  b=GAaBJx643bMeEt1h9obiks2aBOONhQ848W47IpiJdBB0s5JtSlquxi0X
   huZnWthChw67hde9NRHbw60ayCM0OQCHowgJVoF1MZ4c5amDRxxFipcUq
   GiYxyZC41ahLxhuji/lDGX9zQNi/xld2U3rjFWwg2ICE8DdAv8/mFoWgN
   Zc4jTPSskuGEpi2XYH4XG8FO8ijP7nMmKQaTvQUvYY6SaBkkh2Z3qvL9U
   iviqr/2vclL44WbBW9PC4hRPHhEyPNQA1tzFQxyjFfmOuSi8Yq3vdPIWU
   fTtCXD70UuI+qaw603Cr+6l42y+W4S4i/5CIpZVZbiRYldSTXnQxOHpoT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="253779492"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="diff'?scan'208";a="253779492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 08:39:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="diff'?scan'208";a="673494949"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 08:39:22 -0700
Message-ID: <8fc40ebb2fbcecb1ab2f5ea156bf9ec10aff06bf.camel@linux.intel.com>
Subject: Re: hid-sensor-hub 001F:8087:0AC2.0002: timeout waiting for
 response from ISHTP device
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jiri Kosina <jikos@kernel.org>, Even Xu <even.xu@intel.com>,
        Zhang Lixu <lixu.zhang@intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com
Date:   Wed, 18 May 2022 08:39:21 -0700
In-Reply-To: <dff3d94c-93be-2b31-35c6-35a7886f3680@molgen.mpg.de>
References: <289be79b-8fbb-d171-a1e5-5d8218dff39d@molgen.mpg.de>
         <8833ba2600208a05940943636a3bd8b6af6a9fe4.camel@linux.intel.com>
         <dff3d94c-93be-2b31-35c6-35a7886f3680@molgen.mpg.de>
Content-Type: multipart/mixed; boundary="=-fSLorNTvZrztzG+RVRp9"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fSLorNTvZrztzG+RVRp9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Paul,

Attached a diff. Please use git apply and build kernel. And attach
dmesg. I want to see where did it fail.

Thanks,
Srinivas

On Wed, 2022-05-18 at 06:07 +0200, Paul Menzel wrote:
> Dear Srinivas,
> 
> 
> Thank you for your reply.
> 
> Am 13.05.22 um 01:07 schrieb srinivas pandruvada:
> 
> > On Thu, 2022-05-12 at 17:01 +0200, Paul Menzel wrote:
> 
> > > On the Dell XPS 13 9310, firmware 2.2.0 04/06/2021, with Debian
> > > sid/unstable, Linux 5.17.3 logs a lot of the messages below:
> > > 
> > >       timeout waiting for response from ISHTP device
> > > 
> > > Please find the output of `dmesg` attached.
> > > 
> > It seems that sensor FW is not responding after resume.
> > 
> > What is
> > # cat /sys/power/mem_sleep
> 
>      $ cat /sys/power/mem_sleep
>      [s2idle]
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> PS: I think, Intel should have a Dell XPS 13 9310 available in some
> test 
> labs. If not, Dell (Cc) should be able to provide access to one.


--=-fSLorNTvZrztzG+RVRp9
Content-Disposition: attachment; filename="ish_debug_1.diff"
Content-Type: text/x-patch; name="ish_debug_1.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL3BjaS1pc2guYyBiL2Ry
aXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL3BjaS1pc2guYwppbmRleCA4ZTlkOTQ1MGNiODMu
LjViODExZmE4ZjE1YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pcGMv
cGNpLWlzaC5jCisrKyBiL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL3BjaS1pc2guYwpA
QCAtMjYzLDYgKzI2Myw5IEBAIHN0YXRpYyB2b2lkIF9fbWF5YmVfdW51c2VkIGlzaF9yZXN1bWVf
aGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJc3RydWN0IHBjaV9kZXYgKnBkZXYg
PSB0b19wY2lfZGV2KGlzaF9yZXN1bWVfZGV2aWNlKTsKIAlzdHJ1Y3QgaXNodHBfZGV2aWNlICpk
ZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7CiAJdWludDMyX3QgZndzdHMgPSBkZXYtPm9wcy0+
Z2V0X2Z3X3N0YXR1cyhkZXYpOworCXN0cnVjdCBkZXZpY2UgKmRldmljZSA9ICZwZGV2LT5kZXY7
CisKKwlkZXZfaW5mbyhkZXZpY2UsICIlcyBzdXNwZW5kX2ZsYWc6JWQgZndfc3RhdHVzOiV4XG4i
LCBfX2Z1bmNfXywgZGV2LT5zdXNwZW5kX2ZsYWcsIElQQ19JU19JU0hfSUxVUChmd3N0cykpOwog
CiAJaWYgKGlzaF9zaG91bGRfbGVhdmVfZDBpMyhwZGV2KSAmJiAhZGV2LT5zdXNwZW5kX2ZsYWcK
IAkJCSYmIElQQ19JU19JU0hfSUxVUChmd3N0cykpIHsKQEAgLTI4Myw4ICsyODYsMTAgQEAgc3Rh
dGljIHZvaWQgX19tYXliZV91bnVzZWQgaXNoX3Jlc3VtZV9oYW5kbGVyKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykKIAkJICogSWYgdGhlIGZsYWcgaXMgbm90IGNsZWFyZWQsIHNvbWV0aGluZyBp
cyB3cm9uZyB3aXRoIElTSCBGVy4KIAkJICogU28gb24gcmVzdW1lLCBuZWVkIHRvIGdvIHRocm91
Z2ggaW5pdCBzZXF1ZW5jZSBhZ2Fpbi4KIAkJICovCi0JCWlmIChkZXYtPnJlc3VtZV9mbGFnKQor
CQlpZiAoZGV2LT5yZXN1bWVfZmxhZykgeworCQkJZGV2X2luZm8oZGV2aWNlLCAiJXMgcmVzdW1l
X2ZsYWc6JWQgd2lsbCBjYWxsIGlzaF9pbml0XG4iLCBfX2Z1bmNfXywgZGV2LT5yZXN1bWVfZmxh
Zyk7CiAJCQlpc2hfaW5pdChkZXYpOworCQl9CiAJfSBlbHNlIHsKIAkJLyoKIAkJICogUmVzdW1l
IGZyb20gdGhlIEQzLCBmdWxsIHJlYm9vdCBvZiBJU0ggcHJvY2Vzc29yIHdpbGwgaGFwcGVuLApA
QCAtMzA3LDcgKzMxMiw5IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgaXNoX3N1c3BlbmQo
c3RydWN0IGRldmljZSAqZGV2aWNlKQogCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2Rl
dihkZXZpY2UpOwogCXN0cnVjdCBpc2h0cF9kZXZpY2UgKmRldiA9IHBjaV9nZXRfZHJ2ZGF0YShw
ZGV2KTsKIAorCWRldl9pbmZvKGRldmljZSwgIiVzXG4iLCBfX2Z1bmNfXyk7CiAJaWYgKGlzaF9z
aG91bGRfZW50ZXJfZDBpMyhwZGV2KSkgeworCQlkZXZfaW5mbyhkZXZpY2UsICIlcyBzdXNwZW5k
X2ZsYWc6JWRcbiIsIF9fZnVuY19fLCBkZXYtPnN1c3BlbmRfZmxhZyk7CiAJCS8qCiAJCSAqIElm
IHByZXZpb3VzIHN1c3BlbmQgaGFzbid0IGJlZW4gYXNud2VyZWQgdGhlbiBJU0ggaXMgbGlrZWx5
CiAJCSAqIGRlYWQsIGRvbid0IGF0dGVtcHQgbmVzdGVkIG5vdGlmaWNhdGlvbgpAQCAtMzI2LDEy
ICszMzMsMTQgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBpc2hfc3VzcGVuZChzdHJ1Y3Qg
ZGV2aWNlICpkZXZpY2UpCiAJCQkJCW1zZWNzX3RvX2ppZmZpZXMoMjUpKTsKIAogCQlpZiAoZGV2
LT5zdXNwZW5kX2ZsYWcpIHsKKwkJCWRldl9pbmZvKGRldmljZSwgIiVzIHN1c3BlbmRfZmxhZzol
ZCBGVyBoYWx0ZWRcbiIsIF9fZnVuY19fLCBkZXYtPnN1c3BlbmRfZmxhZyk7CiAJCQkvKgogCQkJ
ICogSXQgbG9va3MgbGlrZSBGVyBoYWx0LCBjbGVhciB0aGUgRE1BIGJpdCwgYW5kIHB1dAogCQkJ
ICogSVNIIGludG8gRDMsIGFuZCBGVyB3b3VsZCByZXNldCBvbiByZXN1bWUuCiAJCQkgKi8KIAkJ
CWlzaF9kaXNhYmxlX2RtYShkZXYpOwogCQl9IGVsc2UgeworCQkJZGV2X2luZm8oZGV2aWNlLCAi
JXMgc3VzcGVuZF9mbGFnOiVkIFMwaXggc3VzcGVuZGVkXG4iLCBfX2Z1bmNfXywgZGV2LT5zdXNw
ZW5kX2ZsYWcpOwogCQkJLyoKIAkJCSAqIFNhdmUgc3RhdGUgc28gUENJIGNvcmUgd2lsbCBrZWVw
IHRoZSBkZXZpY2UgYXQgRDAsCiAJCQkgKiB0aGUgSVNIIHdvdWxkIGVudGVyIEQwaTMK


--=-fSLorNTvZrztzG+RVRp9--

