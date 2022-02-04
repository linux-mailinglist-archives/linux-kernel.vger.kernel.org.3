Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165C14A91CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356334AbiBDA5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiBDA5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:57:09 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7930C061714;
        Thu,  3 Feb 2022 16:57:08 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q186so6732905oih.8;
        Thu, 03 Feb 2022 16:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B9+H4Yh8cn5Am5LQnb0jHKaLC66ejKyC+IO0VaITZ80=;
        b=mHTuZcIOmlI27Zt2owzoaagQAMyz/U1XBl7eMRwyeL0RERvYh8EX+z67srwWbFZCvD
         DVCciYmUYuvFh3Lb1UEmlT2lOvRP+4Czpmjk7z7wvvblSCTcutpBfICQjhl1fCfibKU8
         ehQBbi1sEgD5mN0UbdVBMOv3cIEqJOx5bumPP+hxuwaNXAESu4eOjXe4+jSdSI+tWSzH
         CXBVg2EJpNB4M6HUcmoc3i6QTWJTWCNVfRChJw13wU5HKt4LyXR+31SaYj6OL+gTzlAp
         NFY1O8D9y3c/TxPOVc/PC+A/vzCKQT2lQZ9rGDoM0qV39ccmqFKUkx+839OF7jEbWPpa
         nLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B9+H4Yh8cn5Am5LQnb0jHKaLC66ejKyC+IO0VaITZ80=;
        b=Ru/FyO1dYwl9JDtdqn+YU0PD4Rtsioiij1t1gb3NuPvFvtYUYba1QZlDeaBCk/j+ua
         NLFfV2NFQ9Daqq5S/Qo8mJtS9bdRKNmJeQqmkKtaoMLEeWIF4c+VEzM3D3DwfVAhhNfA
         2slC4Jog8ObPtcD48MyfGCjmUbbhdPCregiG2trCOEZda3heX/6zQo/wMrjQfsSxcrld
         /pJJtAHoNjqOSfDzByIBiRC5SoZw81w7gRF3yK/dFSmO9LQlH5Y3bDslAj3A/YwsOnQv
         XKwBoBIpe9uBfi6ywL0aymLsLELVEyk2j5aZ0qJOcwQuvn6wl+rqnv3cyH00Qognjt9r
         U+MQ==
X-Gm-Message-State: AOAM532BRbDo/EpnakR8Bs77yr7HrNa9P17T042K3UIym829D/RybVU5
        9rSu33Ef5s1L28nckFVx0/9BBDGdF1Q=
X-Google-Smtp-Source: ABdhPJwVNtfOnhHY9CbwBMcModSWHu1eGHsllhRufF+tauvoEZwMjtHzSMocRusroCbhQP1w5Bu2FA==
X-Received: by 2002:a05:6808:7cc:: with SMTP id f12mr161366oij.143.1643936228184;
        Thu, 03 Feb 2022 16:57:08 -0800 (PST)
Received: from [192.168.1.103] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id c6sm171014ooo.19.2022.02.03.16.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 16:57:07 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <3721475a-a154-7a1a-ad23-b8a77873f951@lwfinger.net>
Date:   Thu, 3 Feb 2022 18:57:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: rtw89 driver
Content-Language: en-US
To:     Slade Watkins <slade@sladewatkins.com>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+pv=HNuxZXTxu2S5vcz=zF81wWxykQe2im6oKgKiaDPujVjiw@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CA+pv=HNuxZXTxu2S5vcz=zF81wWxykQe2im6oKgKiaDPujVjiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 18:26, Slade Watkins wrote:
> Hi there,
> Quick question for wireless folks: would backporting the rtw89
> driver[1] (Realtek 8852AE) to kernels older than 5.16.y be possible at
> some point down the road? I ask this as, when testing a stable build
> of 5.15.y a bit ago, I had an issue where the driver wasn't present
> and the system I was testing it on wasn't happy and started kicking
> errors. (It's fairly new, so I did kind of expect that.) I was,
> however, able to solve this by manually building and installing the
> drivers so it wasn't that big of a deal.
> 
> [1] https://github.com/lwfinger/rtw89

If for some reason, you do not like my version of the kernel code in the GitHub 
repo that you reference, then you could use the Backports Project.

Backporting a driver into one of the stable trees is not a sanctioned activity. 
Stable kernels only get fixes for bugs, not new features such as a complete driver.

At least one distro packages rtw89 as kernel modules the same as my GitHub repo. 
That distro is openSUSE, which gets its source from that very repo. There may be 
others that provide similar packages.

Larry

