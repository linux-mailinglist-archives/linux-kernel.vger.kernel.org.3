Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087264DAFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355837AbiCPMne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355824AbiCPMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:43:32 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054F666623
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:42:14 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v35so4119172ybi.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=8ZUl50izl5XTdOzAJcdDsecVVhU46smQU8A68ZRWLG4=;
        b=lFzwR/Jub1Yg/lKMmW0U/1yHjyPFf/NbxtGfEEWBka6CeEOX/OG61lVmQfkv6KOuK/
         H99HlyKx9Cb5StArZJGjU5ZnmGpuwpAnD/+og1HE6kwZQrmZkpCY4/IvcOa84kJV0bMF
         Cssd0jZ/4kwFJq6El7csZUvwTqi/DtKGH6XkCJiCuIKY7Hj7eJGkDxec1FH5xZcm34KV
         45IVjPw3Zixdaleh6fzL/yL1FxF2L5FLvf7HQdb61InYYkHhsyLGHmcaKRN0MzsRFKkO
         TO0+axbfIHLHFVIpyig8KVZurRFMsj960thlPtgUmL58NUWxw1kgoSmbEkEPK25r+/LB
         HAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8ZUl50izl5XTdOzAJcdDsecVVhU46smQU8A68ZRWLG4=;
        b=jRpm/o8jg0wOwlzmUmAnRud6+viMeHd9o+kPDVu64L4h2kDGSsVDy8a+dcdadREU19
         aOGIUbAN4bXp/OsvVAcrx0Ybwbogx77Id8JBVy485kfnbpmlR3UEfV7Gzg4J3Vmx9KXQ
         mG1IbEr11x8tLk+idrVqLFor8USIxdo4VHmSkUhFhercS85aWbtS74ALe89Syzt3gOib
         NqlXgkDby08gzU8d6roP8VM23PMZyskmz2f8dTo+2LdpZ4X8yjrwbqCD8PsZ5od8Lzw5
         p0UgCGH9NkzV8O8596O1lvsaNk2UYUi2mq10VGZxJd+X5xn1gOcvUKesmLne7z4Atj7w
         i0jg==
X-Gm-Message-State: AOAM530bHo55AsRcGE7an2tK0Hr/cF2xSxwX59JR5YoTad3ttsPYOqhX
        ZwE2GNablhRHoB8LeifOvwJPncJG9UTnOa4VratD5g==
X-Google-Smtp-Source: ABdhPJxB80wG+ojKETJv7yBdRo6Azrs2Hkadc5V+b2cDQonRXQdBy6DQdPwetodn7KtaURM4mic8pcZjwQZ0Qk5aCXE=
X-Received: by 2002:a25:3c41:0:b0:62c:2929:84b1 with SMTP id
 j62-20020a253c41000000b0062c292984b1mr27842661yba.338.1647434533874; Wed, 16
 Mar 2022 05:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220314145920.247358804@linuxfoundation.org> <CAG=yYwktdQ1Ep0r=VKitta=1gWrNN1Wi0Ft9t0+sXdy1bsX81Q@mail.gmail.com>
In-Reply-To: <CAG=yYwktdQ1Ep0r=VKitta=1gWrNN1Wi0Ft9t0+sXdy1bsX81Q@mail.gmail.com>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Wed, 16 Mar 2022 18:11:37 +0530
Message-ID: <CAG=yYw=SrONeQb3mn6C+9RievV-8zbW7h7j+CGZP2gK1JesoOw@mail.gmail.com>
Subject: previous mail relted
To:     Greg KH <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000002f557005da553e19"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002f557005da553e19
Content-Type: text/plain; charset="UTF-8"

hello,
did you get my previous email?

i am forwarding it .



---------- Forwarded message ---------
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Tue, Mar 15, 2022 at 11:04 PM
Subject: Re: [PATCH 4.19 00/29] 4.19.235-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
<gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
<torvalds@linux-foundation.org>, Andrew Morton
<akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, Shuah
Khan <shuah@kernel.org>, <patches@kernelci.org>,
<lkft-triage@lists.linaro.org>, Pavel Machek <pavel@denx.de>,
<jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
<sudipm.mukherjee@gmail.com>, <slade@sladewatkins.com>


On Mon, Mar 14, 2022 at 11:00 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.235 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Mar 2022 14:59:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.235-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
hello,

Compiled and  booted 4.19.235-rc2+ on ...

Processor Information
    Socket Designation: FM2
    Type: Central Processor
    Family: A-Series
    Manufacturer: AuthenticAMD
    ID: 31 0F 61 00 FF FB 8B 17
    Signature: Family 21, Model 19, Stepping 1


I think No major new  regression or regressions  from dmesg.
Some error related stuff has happened.
Please see the  attachment for build issues related.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology  -  autonomous


-- 
software engineer
rajagiri school of engineering and technology

--0000000000002f557005da553e19
Content-Type: text/plain; charset="US-ASCII"; name="error-4.19.235-rc2.txt"
Content-Disposition: attachment; filename="error-4.19.235-rc2.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_l0seymyd0>
X-Attachment-Id: f_l0seymyd0

Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxlcnJvciByZWxhdGVkIGNsaXBwaW5nIDE+LS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KSW4gZnVuY3Rpb24gJ21lbWNweScsCiAgaW5saW5lZCBmcm9t
IG1lbWNweV9mcm9taW8gYXQgLi9pbmNsdWRlL2FzbS1nZW5lcmljL2lvLmg6MTExNzoyLAogICAg
aW5saW5lZCBmcm9tIGdoZXNfY29weV90b2Zyb21fcGh5cyBhdCBkcml2ZXJzL2FjcGkvYXBlaS9n
aGVzLmM6MzExOjQ6Ci4vaW5jbHVkZS9saW51eC9zdHJpbmcuaDoyNjE6MzM6IHdhcm5pbmc6IF9f
YnVpbHRpbl9tZW1jcHkgcmVhZGluZyBiZXR3ZWVuIDEgYW5kIDQwOTYgYnl0ZXMgZnJvbSBhIHJl
Z2lvbiBvZiBzaXplIDAgWy1Xc3RyaW5nb3Atb3ZlcnJlYWRdCiAgMjYxIHwgI2RlZmluZSBfX3Vu
ZGVybHlpbmdfbWVtY3B5ICAgICBfX2J1aWx0aW5fbWVtY3B5CiAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeCi4vaW5jbHVkZS9saW51eC9zdHJpbmcuaDozNzc6MTY6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyBfX3VuZGVybHlpbmdfbWVtY3B5CiAgMzc3IHwgICAg
ICAgICByZXR1cm4gX191bmRlcmx5aW5nX21lbWNweShwLCBxLCBzaXplKTsKCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLTxlcnJvciByZWxhdGVkIGNsaXBwaW5nID4tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQoKCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxlcnJvciByZWxhdGVkIGNsaXBw
aW5nIDI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCmRyaXZlcnMvY3J5cHRvL2NjcC9zcC1w
bGF0Zm9ybS5jOjM3OjM0OiB3YXJuaW5nOiBhcnJheSBzcF9vZl9tYXRjaCBhc3N1bWVkIHRvIGhh
dmUgb25lIGVsZW1lbnQKICAgMzcgfCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBz
cF9vZl9tYXRjaFtdOwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08ZXJyb3IgcmVsYXRlZCBjbGlw
cGluZz4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKCgoKCgotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS08ZXJyb3IgcmVsYXRlZCBjbGlwcGluZyAzPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CmxkOiBhcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvaGVhZF82NC5vOiB3YXJuaW5nOiByZWxvY2F0
aW9uIGluIHJlYWQtb25seSBzZWN0aW9uIGAuaGVhZC50ZXh0JwpsZDogd2FybmluZzogY3JlYXRp
bmcgRFRfVEVYVFJFTCBpbiBhIFBJRQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08ZXJyb3IgcmVs
YXRlZCBjbGlwcGluZz4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ==
--0000000000002f557005da553e19--
