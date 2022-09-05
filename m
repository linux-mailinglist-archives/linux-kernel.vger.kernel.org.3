Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A75AD76D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiIEQ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIEQ1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:27:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78614617B;
        Mon,  5 Sep 2022 09:27:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bz13so8598431wrb.2;
        Mon, 05 Sep 2022 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=T1hTUTEWq87p2cMRfpquYoG7rS+T/aAUPvt2ZKbM0yk=;
        b=nZWkmXAM6oB1XnP68ZaYrX6SvrpahhgVmAK6X9m2MRwTCf80hq1bV0NYBNjhZT1TuP
         ghb0UZT63EFcmoLnt6lGsYIm5e+08zkb38/wO2EQOuIo1cDUgzrMPMSRnDEsxUAAUt4K
         GZPxfMo/j/wlZzmPiigbC+r5u9abyDhcrNSLTsObxOJ2tyiZnkmstZ8WFJ0+wwMYioRJ
         i8vPieXjI8EyrnN8A1km4KGy9POjY4t1aWO287oqlRe0L5xb22crtvXfCKSM1mIJMdZe
         RMg/Kvy6tK33MQIl9z3PB2Y6avrHsC5jd3pI7F0N4de+S+AdXH/RXF8WOUM5JEd3JmqP
         PgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=T1hTUTEWq87p2cMRfpquYoG7rS+T/aAUPvt2ZKbM0yk=;
        b=QSv8o4kPKg4yBZGPOy80ihQLTmn5LjXTibTVHRf5PXGXCpCPkBiwErlVMkkpc47fCm
         vK9RPd4tzyR7ra+9Oqk1N9b0bJ5axROBDkJq07LYx3A32z0Uq1KvHSo7pIYGv20Bajjd
         +EzdpUdSMVN9kaUejqqHo4A65S/VZfzdYqD9jSV7w6RrnIl3c/qnYlyYjDHVZ3RuqmHY
         RxKQxiIGJ4Ab2HHBg/nEmVTP3P9z7baG3SyRanbphuFYcXFCG48Wxzqs/Ts1aYOF1YsR
         IrI0hzrWotXZMQqSog99yT56hKZ3TVJX2t4ZsWK5VcbipGBpCt1vUR7M895G7ZswuYLi
         IRAw==
X-Gm-Message-State: ACgBeo3hhxSi9NkkjNG7Flfqmjg8fxOfXvvB/dsv0CH5wIbgcemylGjz
        kfC3Hq2uavqZGRYfLRYZVLI=
X-Google-Smtp-Source: AA6agR7hQeOEdQm/U1C8FGztiC5rGCUZdS6rTNUxrOf0J+tP572H9oxgA2kNI6//tcSwZpzcgA4Z9A==
X-Received: by 2002:a5d:4448:0:b0:226:82ff:f3e6 with SMTP id x8-20020a5d4448000000b0022682fff3e6mr25809980wrr.115.1662395225977;
        Mon, 05 Sep 2022 09:27:05 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id e18-20020a5d5012000000b00226dedf1ab7sm4127026wrt.76.2022.09.05.09.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 09:27:05 -0700 (PDT)
Message-ID: <c3d2d8b307f7e11b7a2be751673220049b9a1a77.camel@gmail.com>
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
Date:   Mon, 05 Sep 2022 18:27:03 +0200
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

T24gRnJpLCAyMDIyLTA5LTAyIGF0IDE1OjQxIC0wNzAwLCBBc3V0b3NoIERhcyB3cm90ZToKPiAK
PiArCj4gK3N0YXRpYyB2b2lkIHVmc2hjZF9tY3FfY29uZmlnX25yX3F1ZXVlcyhzdHJ1Y3QgdWZz
X2hiYSAqaGJhKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGksIHJlbTsKPiArwqDCoMKgwqDC
oMKgwqB1MzIgaGJhcV9jYXAsIGNtcDsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgU2NzaV9Ib3N0
ICpob3N0ID0gaGJhLT5ob3N0Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBoYmFxX2NhcCA9IGhiYS0+
bWNxX2NhcGFiaWxpdGllcyAmIDB4ZmY7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJlbSA9IGhiYXFf
Y2FwIC0gZGV2X2NtZF9xdWV1ZTsKPiArwqDCoMKgwqDCoMKgwqAvKiBtaW4oKSBjb21wYXJlcyB2
YXJpYWJsZXMgb2Ygc2FtZSB0eXBlICovCj4gK8KgwqDCoMKgwqDCoMKgaGJhLT5ucl9xdWV1ZXNb
SENUWF9UWVBFX0RFRkFVTFRdID0gbWluKGhiYXFfY2FwIC0KPiBkZXZfY21kX3F1ZXVlLAoKIGhi
YS0+bnJfcXVldWVzW0hDVFhfVFlQRV9ERUZBVUxUXSA9IG1pbihyZW0sIG51bV9wb3NzaWJsZV9j
cHVzKCkpOwoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG51bV9wb3Nz
aWJsZV9jcHVzKCkpOwo+ICvCoMKgwqDCoMKgwqDCoHJlbSAtPSBoYmEtPm5yX3F1ZXVlc1tIQ1RY
X1RZUEVfREVGQVVMVF07Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJlbSA8PSAwKQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsKPiArwqDCoMKgwqDCoMKgwqBjbXAgPSBy
ZW07Cj4gK8KgwqDCoMKgwqDCoMKgaGJhLT5ucl9xdWV1ZXNbSENUWF9UWVBFX1BPTExdID0gbWlu
KGNtcCwgcG9sbF9xdWV1ZXMpOwo+ICvCoMKgwqDCoMKgwqDCoHJlbSAtPSBoYmEtPm5yX3F1ZXVl
c1tIQ1RYX1RZUEVfUE9MTF07Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJlbSA8PSAwKQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsKPiArwqDCoMKgwqDCoMKgwqBjbXAg
PSByZW07Cj4gK8KgwqDCoMKgwqDCoMKgaGJhLT5ucl9xdWV1ZXNbSENUWF9UWVBFX1JFQURdID0g
bWluKGNtcCwgcmVhZF9xdWV1ZXMpOwoKc3RhdGljIHJlYWRfcXVldWVzIGlzIG5vdCBpbml0aWFs
aXplZC4KCj4gCi4uLi4uCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB1ZnNoY2RfaW5jX3RwKHN0cnVj
dCB1ZnNfaHdfcXVldWUgKnEpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqB1MzIgbWFzayA9IHEtPm1h
eF9lbnRyaWVzIC0gMTsKPiArwqDCoMKgwqDCoMKgwqB1MzIgdmFsOwo+ICsKPiArwqDCoMKgwqDC
oMKgwqBxLT5zcV90cF9zbG90ID0gKHEtPnNxX3RwX3Nsb3QgKyAxKSAmIG1hc2s7Cj4gK8KgwqDC
oMKgwqDCoMKgdmFsID0gcS0+c3FfdHBfc2xvdCAqIHNpemVvZihzdHJ1Y3QgdXRwX3RyYW5zZmVy
X3JlcV9kZXNjKTsKPiArwqDCoMKgwqDCoMKgwqB3cml0ZWwodmFsLCBxLT5tY3Ffc3FfdHApOwo+
ICt9CgpUaGlzIGZ1bmN0aW9uIGp1c3QgYWNjZXNzZXMgdGhlIHN1Ym1pc3Npb24gcXVldWUgdGFp
bCBwb2ludGVyLiBUaGUKZnVuY3Rpb24gbmFtZSBzaG91bGQgY2xlYXJseSBleHBsYWluIHRoaXMu
CgoKCgo=

