Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35F3485232
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbiAEMDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiAEMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:03:22 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8158C061761;
        Wed,  5 Jan 2022 04:03:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id iy13so33727100pjb.5;
        Wed, 05 Jan 2022 04:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cPQoGloZhYJVk/xiShb0qTWLNiy1SKPPjtIRgItHWxw=;
        b=pjhbK9eruOxcH9XOk6z2rcGYPViKZVirpYhR1CaP50cYQNMpW1TqaAz3yE8u3nVptQ
         w23Hsy8/Od4kxu0kLLgLmSqJIjpGxg1VHoctk7NJsg4y608A6dgRQHr9nd0APFMsGbmU
         JPggVkbGTKYUzr4l9QR13pn5jpq5Wve/DoWAWN8dp9ZRZMo3+K5it8kc1M48Iwl65dDR
         gNDgrKvtLSdkmxUghMwRaiktRYwNDuU1wEr/nQRX1KJma8B4NDl0gwi75JdYvVqm+x0L
         AdrnLPy2iA3KPD8vIAgOaXc+k6U7ECcsU8TPL8r9GenA46IE1pI8gFMbr/Wq3tr0X8Rg
         q0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cPQoGloZhYJVk/xiShb0qTWLNiy1SKPPjtIRgItHWxw=;
        b=3olchAeATKYAm7aqj7/Tv5ra5BJp+6HhkSuTWzp3c5gMzkF3T250hQk7n/D00WIhb6
         cAcg1UXljjsPsIpardb9ek1czQ/bqzl9Tx9aM4sNllASS9DmjHun0V0VzxPlTB+cvGQ7
         gPeNBC/SAy1/4Zw5O1B6EWq8Dk3H9JXizVg1gG9yzsQLygCWBtzOfAkiBRP8SjHzIaGb
         6OPPkVr1EalT8xgW9pyL8jlT2andHqcTDXIIGjzfgxvboHGgFBdLJ5Ps8gaOUUhs16Am
         5JtGvmi0vlbl4Vp0sdDRJcOOwwHCNAv1DKAsMG6wiN+0JbXgbCo4IaHgj6oUcy+joEHs
         KIRQ==
X-Gm-Message-State: AOAM533VDchgKn3DvPFU1F6Bwlr81ZHk+NDQeBzzJhr68xSk/m9qVRYv
        Qpkg+AbM8f7dicLyPQyv2EE=
X-Google-Smtp-Source: ABdhPJzV5rfZCZzCvJR8Ywe5FhNbffxNcVOLkO4YAKC04PWSJ9CH+t6rQuuVbCucnGgg6aqwnk7Jjg==
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr3691486pjb.109.1641384202287;
        Wed, 05 Jan 2022 04:03:22 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id z3sm37580986pgc.45.2022.01.05.04.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 04:03:21 -0800 (PST)
Subject: Re: make pdfdocs fails on Debian stable
To:     Christoph Hellwig <hch@lst.de>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
References: <20220104064708.GA15446@lst.de>
 <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com>
 <20220104073625.GA16910@lst.de>
 <02f6aa77-17b7-ed23-8f39-34239ec6e724@gmail.com>
 <20220104131952.GA21933@lst.de>
 <2fb003aa-545c-31a4-1466-8c3c3fc708fb@gmail.com>
 <0ee407a1-ff5a-4c04-a99e-045cfe90d850@gmail.com>
 <20220105073504.GA3524@lst.de>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <48dfca1b-3436-d2b0-0dd1-de6104539c50@gmail.com>
Date:   Wed, 5 Jan 2022 21:03:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105073504.GA3524@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 08:35:04 +0100, Christoph Hellwig wrote:
> On Wed, Jan 05, 2022 at 10:47:40AM +0900, Akira Yokosawa wrote:
>>> See my pending patch set at:
>>>
>>>     https://lore.kernel.org/linux-doc/e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com
>>>     [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF
>>>
>>> This uses Inkscape if it is available instead of ImageMagick.
>>> No imagemagick nor librsvg2-bin is required.
>>> As long as if you can trust Inkscape...
> 
> I haven't gotten to try that yet..
> 
>> Alternatively, you can avoid ImageMagick by installing
>> graphicsmagick-imagemagick-compat instead of imagemagick.
>>
>> I'm not sure what you think of GraphicsMagick, though.
>>
>> If you'd like to try, do:
>>
>>     $ sudo apt install graphicsmagick-imagemagick-compat ghostscript gsfonts-x11
>>
>> This will remove ImageMagick.
>> (You have ghostscript and gsfonts-x11 already installed, I guess.)
> 
> This works just fine, thanks.

Nice!

Glad to know I could help you.

        Thanks, Akira

> 
