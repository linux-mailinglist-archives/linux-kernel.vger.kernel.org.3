Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED7E46BBA5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhLGMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhLGMvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:51:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6EBC061756
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:48:01 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c4so29194613wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 04:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q2jM7lhHj4MSusyqeI/Jl3r21eXJjVqAqeBJnoEgA4o=;
        b=D4wwnYV+3tWXq7Dj/JCbdGfsMsH4Fi2ZSGz89eVtC7U7DONy0Xh+Sqllxk2HEYYAAQ
         1uGQscqKVLvZkGrDzFIu9cnScV2TIm0msnBfgE3A5bZqlxBoGEQ7Ser4YxiFcEITIbTl
         TJAZj9Vxt1yJm1NyjmN+s1BbYYJlPnD4GoXi09lqeeVOk7cNTA5bxO1gSID/DhRM2Al3
         ZNRrA+lZfW5qJf7BShYK7Vs30OFkPdcc0oxZSOZMF8em96IhEKQa2o/yMW14Wrm9J8XH
         7RKd5csdFCWW+V9HwPxZIMYku+mECLJC550v2bwQqFzGKgKC17atI/eB6WbVdwN4R/Yf
         ervQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q2jM7lhHj4MSusyqeI/Jl3r21eXJjVqAqeBJnoEgA4o=;
        b=5FM7VOzugpqXSmfFT6Nj5r0lLLP+LCAEuXj9KWxuq9LZ3Irdr4Juo3J4imTLuxPC6Q
         vL25pzBwXQQwPjh+gS5OzsNq61MwN1R/81oE9g80T3Nm0H2hNk50OcU4Bsw3TEwjxQoZ
         V84FMMNWROOve7pIxOikfd0ljSzNy1BF5DLdQa2rD/pE6+XZWSq6phGqVj9XZda7o+u8
         TnIF2c4BWSZJsx1vsECRC0RH3QH+yBCB6uztGBkn+6dfxzKIYy9hOvj7elJSCkopYTyN
         6yP5KQjyv9xXUSYqioYEkBAA+HtMX2k7QPYUxak4g8wJk/CxLGknVcZz42MEbgtH5FQS
         +INQ==
X-Gm-Message-State: AOAM530G0jQvi7mUlu4kWGYSdHvjNE2LWoti7+bcuOIDBlXZ18YaZlhq
        7Hwrg6joN3nVq3YkgakI62Hstk1c1f8=
X-Google-Smtp-Source: ABdhPJwjjHsXT0ABkbgCWUYTM4yLZA8swLPC2BhxWUxLAzJ1YsnugbPpYiAPJCTH5tlJ/7I4VRGhkg==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr50598794wrj.338.1638881280385;
        Tue, 07 Dec 2021 04:48:00 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::834c? ([2a02:8108:96c0:3b88::834c])
        by smtp.gmail.com with ESMTPSA id w17sm15012672wrp.79.2021.12.07.04.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 04:47:59 -0800 (PST)
Message-ID: <8365eb19-2a03-d053-cfad-22bd54fc1554@gmail.com>
Date:   Tue, 7 Dec 2021 13:47:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] staging: r8188eu: convert type of HalData in struct
 adapter
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211206092258.3765-1-straube.linux@gmail.com>
 <Ya8z7q+ufy30MaOw@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <Ya8z7q+ufy30MaOw@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 11:14, Greg KH wrote:
> On Mon, Dec 06, 2021 at 10:22:58AM +0100, Michael Straube wrote:
>> adapter->HalData is used in the GET_HAL_DATA macro all across the
>> driver code but nobody checks if its allocation in
>> rtl188eu_alloc_haldata() was successful or not.
>>
>> To avoid errors when the allocation fails convert the type of field
>> HalData from void pointer to struct hal_data_8188eu. Remove
>> GET_HAL_DATA, rtl8188eu_alloc_haldata(), rtl8188e_free_hal_data().
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>> Tested on x86_64 with InterTech DMG-02.
> 
> This doesn't apply to my tree anymore, due to the other changes that
> were submitted for this driver.  Can you rebase and resend please?
> 

Sure, I'll do.

Thanks,
Michael
