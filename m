Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117144AA2FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348265AbiBDWQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348258AbiBDWQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:16:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4633AC0DD2A5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:16:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e8so13849528wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=UBwbtdy1Ghxr3ilsBl24fcTgN+pyyz7QeujJ9MeHPXg=;
        b=iWvn2MCzGuH2WASEP1yx9WcjPoveXjHxIvDJAGsIZHh+E1x4KG9DJSowRCPC3z104i
         +iungd9qsHTTsso7uA9qXF8HrzZhGt6/dYdYkRdVVSPAXbk1cJeAMS009DgkkifUSxur
         ysu/+1flsByu8yBAn+hMJl3PXrbzuVRtk03heyVnADl1+lUL5rumd5Hvx3b7M+CWIOQi
         HTIKJzAzXlTsly+gpQRtGffRW5fqJkoeQr22VhgztPiWB7PYZaaqzdOp904i7U+V+vDU
         2/AwYj4g9U6yf67lGEp63w7UusrYrsOatjGdHOj2khQRSAvlWsPxX6ZTQKD8muYjKiUX
         v2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=UBwbtdy1Ghxr3ilsBl24fcTgN+pyyz7QeujJ9MeHPXg=;
        b=J6SpJhtTcxzZ3iNnxq37TCYlADjt7PvG4jgmDHbLiW/YhqosWFvNA4SA3nm1syp39Z
         OfqSEPKEIvreAeXV7lkucuUeGYLGbeiz0QRr0V8boD0kinHPEWd6JPhzWKYNOZ6Ym4fG
         YG7tp7gppaBj7t9L8Ts+m8INotsaLa0woucovBr5nfJEl5Jl6rW+X3YVRdOJr7H6tcWT
         25kv80x3eBu74oeKKTvPPqCVLfZ7M6tLsk1xOHFvCbrsoENVzdZt4inUjUGlXOy1SEJV
         TJlmI1uDIUhYBaybpNr427ddVWZYRuu+C/x61FmZ6jOx0vV4YFaCLVdAQQzzGrDaksTq
         9MGw==
X-Gm-Message-State: AOAM533/mteX7YWv9BOfkf6RUEjwge3CoqzxdAKScwtsGsdnqMzrMVJa
        7GXfGUAPsmtNstmU96mX//lUdQ==
X-Google-Smtp-Source: ABdhPJzoXUEVt7sDIMjWFRfprJccgmQKw8vnTUEGWmFdPu8ybo/jGgTOXYyYp/11TWscwfrmQhLTNg==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr146656wrj.119.1644012983646;
        Fri, 04 Feb 2022 14:16:23 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:46b:d462:f12b:a36? ([2a01:e34:ed2f:f020:46b:d462:f12b:a36])
        by smtp.googlemail.com with ESMTPSA id r2sm3030945wmq.24.2022.02.04.14.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 14:16:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------sMLcLiLky7zeGc1ZqprPS6L3"
Message-ID: <c610f361-14b5-6c64-ff28-7ae0442aed71@linaro.org>
Date:   Fri, 4 Feb 2022 23:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tools/lib/thermal: Add a thermal library
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Sasha Levin <sashal@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
References: <20220204161518.163536-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gXJ8wF2ChGU1bydPiNHB4c+SVrmrTpUwxMh7ddODFV5g@mail.gmail.com>
 <d8e4c15757cd9b40fe5d47bec7e07fc997431b1a.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <d8e4c15757cd9b40fe5d47bec7e07fc997431b1a.camel@linux.intel.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------sMLcLiLky7zeGc1ZqprPS6L3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Srinivas,

On 04/02/2022 20:32, srinivas pandruvada wrote:
> On Fri, 2022-02-04 at 18:11 +0100, Rafael J. Wysocki wrote:
>> CC Rui and Srinivas
>>
>> On Fri, Feb 4, 2022 at 5:15 PM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>> The thermal framework implements a netlink notification mechanism
>>> to
>>> be used by the userspace to have a thermal configuration discovery,
>>> trip point changes or violation, cooling device changes
>>> notifications,
>>> etc...
>>>
>>> This library provides a level of abstraction for the thermal
>>> netlink
>>> notification allowing the userspace to connect to the notification
>>> mechanism more easily. The library is callback oriented.
>>>
>>> As it is the very first iteration, the API may be subject to
>>> changes. For this reason, the documentation will be provided after
>>> those are stabilized.
>>
>> So shouldn't this be an RFC?
>>
>> Also, I would prefer documentation to be provided or at least some
>> intended usage examples to be given.
>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>   tools/Makefile                           |  14 +-
>>>   tools/include/uapi/linux/thermal.h       |  91 ++++++
> This is duplicating the file at include/uapi/linux. I know this is done
> for other tools also. In my use I am copying and using symbolic link.

Why copy and symbolic link ? Should it be create a symbolic link only ?

> BTW I have potential usage of netlink targeted for next release in
> linux tools.
> 
> https://github.com/spandruvada/linux-kernel/blob/intel-sst/tools/power/x86/intel-speed-select/hfi-events.c
> 
> I can replace with libthermal calls once ready. I will check the code
> below next week.

Great, thanks!

In attachment a test file as an example of the library usage.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
--------------sMLcLiLky7zeGc1ZqprPS6L3
Content-Type: text/x-csrc; charset=UTF-8; name="test-thermal.c"
Content-Disposition: attachment; filename="test-thermal.c"
Content-Transfer-Encoding: base64

LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IExHUEwtMi4xKyAqLwojaW5jbHVkZSA8ZXJy
bm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxsaW1pdHMuaD4KI2luY2x1ZGUg
PHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5j
bHVkZSA8dW5pc3RkLmg+CgojaW5jbHVkZSA8c3lzL2Vwb2xsLmg+CiNpbmNsdWRlIDxzeXMv
c3RhdC5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CgojaW5jbHVkZSA8dGhlcm1hbC5oPgoK
I2RlZmluZSBNQVhfRVZFTlRTIDEwCgpzdGF0aWMgaW50IHNob3dfdHJpcChzdHJ1Y3QgdGhl
cm1hbF90cmlwICp0dCwgdm9pZCAqYXJnKQp7CglwcmludGYoInRyaXAgaWQ9JWQsIHR5cGU9
JWQsIHRlbXA9JWQsIGh5c3Q9JWRcbiIsCgkgICAgICAgdHQtPmlkLCB0dC0+dHlwZSwgdHQt
PnRlbXAsIHR0LT5oeXN0KTsKCglyZXR1cm4gMDsKfQkJCgpzdGF0aWMgaW50IHNob3dfdGVt
cChzdHJ1Y3QgdGhlcm1hbF96b25lICp0eiwgdm9pZCAqYXJnKQp7Cgl0aGVybWFsX2NtZF9n
ZXRfdGVtcChhcmcsIHR6KTsKCglwcmludGYoInRlbXBlcmF0dXJlOiAlZFxuIiwgdHotPnRl
bXApOwoKCXJldHVybiAwOwp9CgpzdGF0aWMgaW50IHNob3dfZ292ZXJub3Ioc3RydWN0IHRo
ZXJtYWxfem9uZSAqdHosIHZvaWQgKmFyZykKewoJdGhlcm1hbF9jbWRfZ2V0X2dvdmVybm9y
KGFyZywgdHopOwoKCXByaW50ZigiZ292ZXJub3I6ICclcydcbiIsIHR6LT5nb3Zlcm5vcik7
CgkKCXJldHVybiAwOwp9CgpzdGF0aWMgaW50IHNob3dfdHooc3RydWN0IHRoZXJtYWxfem9u
ZSAqdHosIHZvaWQgKmFyZykKewoJcHJpbnRmKCJ0aGVybWFsIHpvbmUgJyVzJywgaWQ9JWRc
biIsIHR6LT5uYW1lLCB0ei0+aWQpOwoKCWZvcl9lYWNoX3RoZXJtYWxfdHJpcCh0ei0+dHJp
cCwgc2hvd190cmlwLCBOVUxMKTsKCglzaG93X3RlbXAodHosIGFyZyk7CgkKCXNob3dfZ292
ZXJub3IodHosIGFyZyk7CgkKCXJldHVybiAwOwp9CgpzdGF0aWMgaW50IHR6X2NyZWF0ZShj
b25zdCBjaGFyICpuYW1lLCBpbnQgdHpfaWQsIHZvaWQgKmFyZykKewoJcHJpbnRmKCJUaGVy
bWFsIHpvbmUgJyVzJy8lZCBjcmVhdGVkXG4iLCBuYW1lLCB0el9pZCk7CgoJcmV0dXJuIDA7
Cn0KCnN0YXRpYyBpbnQgdHpfZGVsZXRlKGludCB0el9pZCwgdm9pZCAqYXJnKQp7Cglwcmlu
dGYoIlRoZXJtYWwgem9uZSAlZCBkZWxldGVkXG4iLCB0el9pZCk7CgoJcmV0dXJuIDA7Cn0K
CnN0YXRpYyBpbnQgdHpfZGlzYWJsZShpbnQgdHpfaWQsIHZvaWQgKmFyZykKewoJcHJpbnRm
KCJUaGVybWFsIHpvbmUgJWQgZGlzYWJsZWRcbiIsIHR6X2lkKTsKCglyZXR1cm4gMDsKfQoK
c3RhdGljIGludCB0el9lbmFibGUoaW50IHR6X2lkLCB2b2lkICphcmcpCnsKCXByaW50Zigi
VGhlcm1hbCB6b25lICVkIGVuYWJsZWRcbiIsIHR6X2lkKTsKCglyZXR1cm4gMDsKfQoKc3Rh
dGljIGludCB0el90ZW1wKGludCB0el9pZCwgaW50IHRlbXAsIHZvaWQgKmFyZykKewoJcHJp
bnRmKCJUaGVybWFsIHpvbmUgJWQgdGVtcGVyYXR1cmU6ICVkXG4iLCB0el9pZCwgdGVtcCk7
CgoJcmV0dXJuIDA7Cn0KCnN0YXRpYyBpbnQgdHJpcF9oaWdoKGludCB0el9pZCwgaW50IHRy
aXBfaWQsIGludCB0ZW1wLCB2b2lkICphcmcpCnsKCXByaW50ZigiVGhlcm1hbCB6b25lICVk
OiB0cmlwIHBvaW50ICVkIGNyb3NzZWQgd2F5IHVwIHdpdGggJWQgwrBDXG4iLAoJICAgICAg
IHR6X2lkLCB0cmlwX2lkLCB0ZW1wKTsKCglyZXR1cm4gMDsKfQoKc3RhdGljIGludCB0cmlw
X2xvdyhpbnQgdHpfaWQsIGludCB0cmlwX2lkLCBpbnQgdGVtcCwgdm9pZCAqYXJnKQp7Cglw
cmludGYoIlRoZXJtYWwgem9uZSAlZDogdHJpcCBwb2ludCAlZCBjcm9zc2VkIHdheSBkb3du
IHdpdGggJWQgwrBDXG4iLAoJICAgICAgIHR6X2lkLCB0cmlwX2lkLCB0ZW1wKTsKCglyZXR1
cm4gMDsKfQoKc3RhdGljIGludCB0cmlwX2FkZChpbnQgdHpfaWQsIGludCB0cmlwX2lkLCBp
bnQgdHlwZSwgaW50IHRlbXAsIGludCBoeXN0LCB2b2lkICphcmcpCnsKCXByaW50ZigiVHJp
cCBwb2ludCBhZGRlZCAlZDogaWQ9JWQsIHR5cGU9JWQsIHRlbXA9JWQsIGh5c3Q9JWRcbiIs
CgkgICAgICAgdHpfaWQsIHRyaXBfaWQsIHR5cGUsIHRlbXAsIGh5c3QpOwoKCXJldHVybiAw
Owp9CgpzdGF0aWMgaW50IHRyaXBfZGVsZXRlKGludCB0el9pZCwgaW50IHRyaXBfaWQsIHZv
aWQgKmFyZykKewoJcHJpbnRmKCJUcmlwIHBvaW50IGRlbGV0ZWQgJWQ6IGlkPSVkXG4iLCB0
el9pZCwgdHJpcF9pZCk7CgoJcmV0dXJuIDA7Cn0KCnN0YXRpYyBpbnQgdHJpcF9jaGFuZ2Uo
aW50IHR6X2lkLCBpbnQgdHJpcF9pZCwgaW50IHR5cGUsIGludCB0ZW1wLCBpbnQgaHlzdCwg
dm9pZCAqYXJnKQp7CglwcmludGYoIlRyaXAgcG9pbnQgY2hhbmdlZCAlZDogaWQ9JWQsIHR5
cGU9JWQsIHRlbXA9JWQsIGh5c3Q9JWRcbiIsCgkgICAgICAgdHpfaWQsIHRyaXBfaWQsIHR5
cGUsIHRlbXAsIGh5c3QpOwoKCXJldHVybiAwOwp9CgpzdGF0aWMgaW50IGNkZXZfYWRkKGNv
bnN0IGNoYXIgKm5hbWUsIGludCBjZGV2X2lkLCBpbnQgbWF4X3N0YXRlLCB2b2lkICphcmcp
CnsKCXByaW50ZigiQ29vbGluZyBkZXZpY2UgJyVzJy8lZCAobWF4IHN0YXRlPSVkKSBhZGRl
ZCIsCgkgICAgICAgbmFtZSwgY2Rldl9pZCwgbWF4X3N0YXRlKTsKCglyZXR1cm4gMDsKfQoK
c3RhdGljIGludCBjZGV2X2RlbGV0ZShpbnQgY2Rldl9pZCwgdm9pZCAqYXJnKQp7Cglwcmlu
dGYoIkNvb2xpbmcgZGV2aWNlICVkIGRlbGV0ZWQiLCBjZGV2X2lkKTsKCglyZXR1cm4gMDsK
fQoKc3RhdGljIGludCBjZGV2X3VwZGF0ZShpbnQgY2Rldl9pZCwgaW50IGN1cl9zdGF0ZSwg
dm9pZCAqYXJnKQp7CglwcmludGYoImNkZXY6JWQgc3RhdGU6JWRcbiIsIGNkZXZfaWQsIGN1
cl9zdGF0ZSk7CgoJcmV0dXJuIDA7Cn0KCnN0YXRpYyBpbnQgZ292X2NoYW5nZShpbnQgdHpf
aWQsIGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgKmFyZykKewoJcHJpbnRmKCJ0eiAlZCwgZ292
ZXJub3I9JXNcbiIsIHR6X2lkLCBuYW1lKTsKCglyZXR1cm4gMDsKfQoKc3RhdGljIHN0cnVj
dCB0aGVybWFsX29wcyBvcHMgPSB7Cgkuc2FtcGxpbmcudHpfdGVtcAk9IHR6X3RlbXAsCgku
ZXZlbnRzLnR6X2NyZWF0ZQk9IHR6X2NyZWF0ZSwKCS5ldmVudHMudHpfZGVsZXRlCT0gdHpf
ZGVsZXRlLAoJLmV2ZW50cy50el9kaXNhYmxlCT0gdHpfZGlzYWJsZSwKCS5ldmVudHMudHpf
ZW5hYmxlCT0gdHpfZW5hYmxlLAoJLmV2ZW50cy50cmlwX2hpZ2gJPSB0cmlwX2hpZ2gsCgku
ZXZlbnRzLnRyaXBfbG93CT0gdHJpcF9sb3csCgkuZXZlbnRzLnRyaXBfYWRkCT0gdHJpcF9h
ZGQsCgkuZXZlbnRzLnRyaXBfZGVsZXRlCT0gdHJpcF9kZWxldGUsCgkuZXZlbnRzLnRyaXBf
Y2hhbmdlCT0gdHJpcF9jaGFuZ2UsCgkuZXZlbnRzLmNkZXZfYWRkCT0gY2Rldl9hZGQsCgku
ZXZlbnRzLmNkZXZfZGVsZXRlCT0gY2Rldl9kZWxldGUsCgkuZXZlbnRzLmNkZXZfdXBkYXRl
CT0gY2Rldl91cGRhdGUsCgkuZXZlbnRzLmdvdl9jaGFuZ2UJPSBnb3ZfY2hhbmdlCn07Cgpz
dGF0aWMgaW50IHN0b3AgPSAwOwoKc3RhdGljIHZvaWQgc2lnaGFuZGxlcihpbnQgc2lnKQp7
CglzdG9wID0gMTsKfTsKCnN0YXRpYyBpbnQgdGhlcm1hbF9uZXRsaW5rX2dldF90ZW1wX2Jl
bmNoKHN0cnVjdCB0aGVybWFsX2hhbmRsZXIgKnRoLAoJCQkJCSAgc3RydWN0IHRoZXJtYWxf
em9uZSAqdHopCnsKCWludCBucl9tZXNzYWdlcyA9IDA7CglpbnQgbnJfc2VjcyA9IDU7Cgl1
bnNpZ25lZCBsb25nIGxvbmcgc3VtID0gMDsKCQoJcHJpbnRmKCJCZW5jaG1hcmtpbmcgbmV0
bGluay4uLiB3YWl0ICVkIHNlY3NcbiIsIG5yX3NlY3MpOwoJCQoJc2lnbmFsKFNJR0FMUk0s
IHNpZ2hhbmRsZXIpOwoJYWxhcm0obnJfc2Vjcyk7Cgl3aGlsZSAoIXN0b3ApIHsKCQl0aGVy
bWFsX2NtZF9nZXRfdGVtcCh0aCwgdHopOwoJCXN1bSArPSB0ei0+dGVtcDsKCQlucl9tZXNz
YWdlcysrOwoJfQoJCQoJcHJpbnRmKCJUZW1wZXJhdHVyZSByZWFkaW5nICVkIG1zZy9zZWMg
KCVsbHUgdXNlYy9tc2cpLCBhdmcgdGVtcD0lbGx1XG4iLAoJICAgICAgIG5yX21lc3NhZ2Vz
IC8gbnJfc2VjcywgMTAwMDAwMFVMTCAvIChucl9tZXNzYWdlcyAvIG5yX3NlY3MpLAoJICAg
ICAgIHN1bSAvIG5yX21lc3NhZ2VzKTsKCglyZXR1cm4gMDsKfQoKc3RhdGljIGludCB0aGVy
bWFsX3N5c2ZzX2dldF90ZW1wX2JlbmNoKHN0cnVjdCB0aGVybWFsX3pvbmUgKnR6KQp7Cglp
bnQgbnJfbWVzc2FnZXMgPSAwOwoJaW50IG5yX3NlY3MgPSA1OwoJdW5zaWduZWQgbG9uZyBs
b25nIHN1bSA9IDA7CgljaGFyIHBhdGhbUEFUSF9NQVhdOwoJaW50IGZkOwoKCXNucHJpbnRm
KHBhdGgsIFBBVEhfTUFYLAoJCSAiL3N5cy9jbGFzcy90aGVybWFsL3RoZXJtYWxfem9uZSVk
L3RlbXAiLCB0ei0+aWQpOwoKCWZkID0gb3BlbihwYXRoLCBPX1JET05MWSk7CglpZiAoZmQg
PCAwKQoJCXJldHVybiAtMTsKCglwcmludGYoIkJlbmNobWFya2luZyBzeXNmcy4uLiB3YWl0
ICVkIHNlY3NcbiIsIG5yX3NlY3MpOwoKCXNpZ25hbChTSUdBTFJNLCBzaWdoYW5kbGVyKTsK
CWFsYXJtKG5yX3NlY3MpOwoJc3RvcCA9IDA7Cgl3aGlsZSAoIXN0b3ApIHsKCQljaGFyIGJ1
ZmZlclsxMjhdID0geyAwIH07CgoJCXByZWFkKGZkLCBidWZmZXIsIDEyNywgMCk7CgkJc3Vt
ICs9IGF0b2koYnVmZmVyKTsKCQlucl9tZXNzYWdlcysrOwoJfQoKCWlmICghbnJfbWVzc2Fn
ZXMpIHsKCQlmcHJpbnRmKHN0ZGVyciwgIk5vIG1lc3NhZ2UgcmVhZFxuIik7CgkJcmV0dXJu
IC0xOwoJfQoJCglwcmludGYoIlRlbXBlcmF0dXJlIHJlYWRpbmcgJWQgbXNnL3NlYyAoJWxs
dSB1c2VjL21zZyksIGF2ZyB0ZW1wPSVsbHVcbiIsCgkgICAgICAgbnJfbWVzc2FnZXMgLyBu
cl9zZWNzLCAxMDAwMDAwVUxMIC8gKG5yX21lc3NhZ2VzIC8gbnJfc2VjcyksCgkgICAgICAg
c3VtIC8gbnJfbWVzc2FnZXMpOwoKCWNsb3NlKGZkKTsKCglyZXR1cm4gMDsKfQoKaW50IG1h
aW4odm9pZCkKewoJc3RydWN0IHRoZXJtYWxfem9uZSAqdHo7CglzdHJ1Y3QgdGhlcm1hbF9o
YW5kbGVyICp0aDsKCXN0cnVjdCBlcG9sbF9ldmVudCBldjsKCXN0cnVjdCBlcG9sbF9ldmVu
dCBldmVudHNbTUFYX0VWRU5UU107CQoJaW50IGVwb2xsZmQ7CglpbnQgbmZkczsKCWludCBp
OwoKCXRoID0gdGhlcm1hbF9pbml0KCZvcHMpOwoJaWYgKCF0aCkKCQlyZXR1cm4gLTE7CgoJ
dHogPSB0aGVybWFsX3pvbmVfZGlzY292ZXIodGgpOwoJaWYgKCF0eikKCQlyZXR1cm4gLTE7
CgoJdGhlcm1hbF9uZXRsaW5rX2dldF90ZW1wX2JlbmNoKHRoLCB0eik7CgoJdGhlcm1hbF9z
eXNmc19nZXRfdGVtcF9iZW5jaCh0eik7CgoJZm9yX2VhY2hfdGhlcm1hbF96b25lKHR6LCBz
aG93X3R6LCB0aCk7CgkKCWVwb2xsZmQgPSBlcG9sbF9jcmVhdGUxKDApOwoJaWYgKGVwb2xs
ZmQgPCAwKQoJCXJldHVybiAtMTsKCglldi5ldmVudHMgPSBFUE9MTElOOwoJZXYuZGF0YS5w
dHIgPSB0aGVybWFsX2V2ZW50c19oYW5kbGU7CgoJaWYgKGVwb2xsX2N0bChlcG9sbGZkLCBF
UE9MTF9DVExfQURELCB0aGVybWFsX2V2ZW50c19mZCh0aCksICZldikgPT0gLTEpCgkJcmV0
dXJuIC0xOwoKCWV2LmV2ZW50cyA9IEVQT0xMSU47Cglldi5kYXRhLnB0ciA9IHRoZXJtYWxf
c2FtcGxpbmdfaGFuZGxlOwoJCglpZiAoZXBvbGxfY3RsKGVwb2xsZmQsIEVQT0xMX0NUTF9B
REQsIHRoZXJtYWxfc2FtcGxpbmdfZmQodGgpLCAmZXYpID09IC0xKQoJCXJldHVybiAtMTsK
CQoJd2hpbGUgKDEpIHsKCgkJbmZkcyA9IGVwb2xsX3dhaXQoZXBvbGxmZCwgZXZlbnRzLCBN
QVhfRVZFTlRTLCAtMSk7CgkJZm9yIChpID0gMDsgaSA8IG5mZHM7IGkrKykgewoJCQlpZiAo
ZXZlbnRzW2ldLmRhdGEucHRyID09IHRoZXJtYWxfZXZlbnRzX2hhbmRsZSkgewoJCQkJdGhl
cm1hbF9ldmVudHNfaGFuZGxlKHRoLCBOVUxMKTsKCQkJfSBlbHNlIGlmIChldmVudHNbaV0u
ZGF0YS5wdHIgPT0gdGhlcm1hbF9zYW1wbGluZ19oYW5kbGUpIHsKCQkJCXRoZXJtYWxfc2Ft
cGxpbmdfaGFuZGxlKHRoLCBOVUxMKTsKCQkJfQoJCX0KCX0KCglyZXR1cm4gMDsKfQo=

--------------sMLcLiLky7zeGc1ZqprPS6L3--
