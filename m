Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC04D5AD43F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiIENsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiIENsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:48:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0225808D;
        Mon,  5 Sep 2022 06:48:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so7006752wms.0;
        Mon, 05 Sep 2022 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=43AvYQ84NFT79c+Ju8v9NNSFk2SIfrXKvCx9jT0QbhA=;
        b=WKNu9B//fqfkM1kDyDqJCJWfKEwh0jyI0j0NPX7UQMJkcx70R8+X5BtZMTae9LcvM5
         X8s4VWNlQVy810TG2MQlVbPq5AuBLRDwnOt0/ngywqR0rTulz2tlt7FI8i3LEYIwtfln
         xEOIVn5LBU1eGeQN+qcKryU/9jzXO0U7S2mjVUxw0J+1MyPfmfnDCl8uGwi68+f4Zztl
         2bFYaIEenyQ6+vcd0ocygmtUWxlioZF9lflgVFRmVvQr5wxJOctM3NlQEY5D0rKKbPer
         h47OI6hWoJQjn1ctG8k6DJi9AEzCUTTqaUwBDgsZ+LVWHvLLfYVISZDH+tr8xGIXxGVm
         P7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=43AvYQ84NFT79c+Ju8v9NNSFk2SIfrXKvCx9jT0QbhA=;
        b=KAjKE6YfxeIP4Ks5+Ki4SwR49LYt2n2D4mCzdW52sVCBJGfFI0bnPJdCtX6AOniq6m
         rjbscxrVkQJe4P9wt1XKAmpjhgA060ijZhz8fZH10g8qNqm4us1BDjnqxRzjsCyQstji
         76JF+r2pOqtsnFkCzj7nGsSIu9UHjLxMaaCeQgwBDeYqXlQO5IQQWG0V/nl/laEaumwp
         Mn1FvKCpT4HvxtS/vOjcFodd1xR0hMxbgYSUsfE0tWG2HF2XpqyU5taKztbbUo4sjCuu
         /thecsEZ8zRmPJ03Kik04gNixN4rN3VxlgIkKqpfFgoN4CnRW7WurRtEQ7nN5gd5yxhK
         dNzA==
X-Gm-Message-State: ACgBeo0FSVDLI51etEnnTjGxogbanDF6IOwfNeiteYr2TIJ+IrrEkyqp
        u1RSIVhcgV1UloySzQLoWZ4=
X-Google-Smtp-Source: AA6agR4M7AySTt4LkNjPWBw4DZOxQSHw37OYVM4zSSHqUTvhndukRk6Xrh1mAbdcwXAvMD93hJDvSw==
X-Received: by 2002:a05:600c:410d:b0:3a6:1db8:b419 with SMTP id j13-20020a05600c410d00b003a61db8b419mr10853587wmi.119.1662385697499;
        Mon, 05 Sep 2022 06:48:17 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id l6-20020a05600c4f0600b003a3170a7af9sm11795424wmq.4.2022.09.05.06.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 06:48:17 -0700 (PDT)
Message-ID: <748f9c294e304cc5b5ccd9804fa647afc39c8bc3.camel@gmail.com>
Subject: Re: [RFC PATCH v3 2/4] ufs: core: mcq: Adds Multi-Circular Queue
 support
From:   Bean Huo <huobean@gmail.com>
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, bvanassche@acm.org, avri.altman@wdc.com,
        mani@kernel.org, quic_cang@quicinc.com, beanhuo@micron.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 05 Sep 2022 15:48:15 +0200
In-Reply-To: <04f4949e4dea991a93bdf6727bf12948ecc586be.1662157846.git.quic_asutoshd@quicinc.com>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
         <04f4949e4dea991a93bdf6727bf12948ecc586be.1662157846.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTAyIGF0IDE1OjQxIC0wNzAwLCBBc3V0b3NoIERhcyB3cm90ZToKPiAr
LyoqCj4gKyAqIHVmc2hjZF9tY3FfZGVjaWRlX3F1ZXVlX2RlcHRoIC0gZGVjaWRlIHRoZSBxdWV1
ZSBkZXB0aAo+ICsgKiBAaGJhIC0gcGVyIGFkYXB0ZXIgaW5zdGFuY2UKPiArICoKPiArICogTUFD
IC0gTWF4LiBBY3RpdmUgQ29tbWFuZCBvZiB0aGUgSG9zdCBDb250cm9sbGVyIChIQykKPiArICog
SEMgd291bGRuJ3Qgc2VuZCBtb3JlIHRoYW4gdGhpcyBjb21tYW5kcyB0byB0aGUgZGV2aWNlLgo+
ICsgKiBUaGUgZGVmYXVsdCBNQUMgaXMgMzIsIGJ1dCB0aGUgbWF4LiB2YWx1ZSBtYXkgdmFyeSB3
aXRoCj4gKyAqIHZlbmRvciBpbXBsZW1lbnRhdGlvbi4KPiArICogQ2FsY3VsYXRlcyBhbmQgYWRq
dXN0cyB0aGUgcXVldWUgZGVwdGggYmFzZWQgb24gdGhlIGRlcHRoCj4gKyAqIHN1cHBvcnRlZCBi
eSB0aGUgSEMsIHVmcyBkZXZpY2UgYW5kIGlmIGV4dF9paWQgaXMgc3VwcG9ydGVkLgo+ICsgKi8K
PiArdTMyIHVmc2hjZF9tY3FfZGVjaWRlX3F1ZXVlX2RlcHRoKHN0cnVjdCB1ZnNfaGJhICpoYmEp
Cj4gK3sKPiArwqDCoMKgwqDCoMKgwqB1MzIgcWQsIHZhbDsKPiArwqDCoMKgwqDCoMKgwqBpbnQg
bWFjOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBtYWMgPSB1ZnNoY2RfbWNxX3ZvcHNfZ2V0X2hiYV9t
YWMoaGJhKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAobWFjIDwgMCkgewo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB2YWwgPSB1ZnNoY2RfcmVhZGwoaGJhLCBSRUdfVUZTX01DUV9DRkcp
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtYWMgPSAodmFsICYgTUNRX0NGR19N
QUNfTUFTSykgPj4gTUNRX0NGR19NQUNfT0ZGU0VUOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4g
K8KgwqDCoMKgwqDCoMKgLyrCoCBNQUMgaXMgYSAwIGJhc2VkIHZhbHVlLiAqLwo+ICvCoMKgwqDC
oMKgwqDCoG1hYyArPSAxOwo+ICvCoMKgwqDCoMKgwqDCoHFkID0gbWluX3QodTMyLCBtYWMsIGhi
YS0+ZGV2X2luZm8uYnF1ZXVlZGVwdGgpOwo+ICvCoMKgwqDCoMKgwqDCoGlmICghcWQpCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHFkID0gbWFjOwo+ICsKPiArwqDCoMKgwqDCoMKg
wqAvKiBBZGp1c3QgcXVldWUgZGVwdGggYmFzZWQgb24gZXh0X2lpZCBzdXBwb3J0LiAqLwo+ICvC
oMKgwqDCoMKgwqDCoGlmIChxZCA+IDI1NiAmJiAoIWhiYS0+ZXh0X2lpZF9zdXAgfHwgIWhiYS0K
PiA+ZGV2X2luZm8uYl9leHRfaWlkX2VuKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcWQgPSAyNTY7Cj4gK8KgwqDCoMKgwqDCoMKgZWxzZSBpZiAocWQgPiA0MDk2ICYmIGhiYS0+
ZXh0X2lpZF9zdXAgJiYgaGJhLQo+ID5kZXZfaW5mby5iX2V4dF9paWRfZW4pCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHFkID0gNDA5NjsKPiArCgpBc3Rvc2gsCgpJIGRvbid0IHVu
ZGVyc3RhbmQgaGVyZS4gIEhvdyBjYW4gcWQgYmUgNDA5Nj8gIE1BQyBpbiBVRlNIQ0kgIGlzIDkg
Yml0cwp3aWR0aCwgdGhlIG1heGltdW0gZGVwdGggd2lsbCBiZSA1MTIsIGFuZCBoYmEtPmRldl9p
bmZvLmJxdWV1ZWRlcHRoIGlzCm9uZSBieXRlIHdpZHRoLCBtYXhpbXVtIHdpbGwgYmUgMjU2LgoK
S2luZCByZWdhcmRzLApCZWFuCgo=

