Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938A1462CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhK3Gjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbhK3Gjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:39:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B58C061714;
        Mon, 29 Nov 2021 22:36:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so17518198pja.1;
        Mon, 29 Nov 2021 22:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WiGvLxXZbZ3RFR6KAqn4EtEkXaqlvKNUS7Wli73wFnE=;
        b=h/Sriw2jo7sE6PK6frGyuRwtFs6hSgndRp7y36hYG0Wam9Kjgf01TezSJhJgFuGfPZ
         UhxAIQoIu6SKtUKaGF33r3lPEQZBDAPhAUwjY96bR12OmV8L8OVPVM7ilQzJbKmxnLGO
         DiZZbBqDmH85wo7wLG8PSxQmKcXrNCCursf16Hso2LRMUeb3Yy1Vjz2IosQfAcYHMB5o
         p6R2H/IQL0ZM8jMizqE8iELsaU6uW9U7Gk7KjHDt0qemAlzqeb3zHGr9SPcJ2zGC/oeV
         24C4u/iEYZFaDhQx76NH2mtu2B5XgTkjr1AA6GJphYKSatLhIRluvNCiqDuRQkXHF5sV
         S2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WiGvLxXZbZ3RFR6KAqn4EtEkXaqlvKNUS7Wli73wFnE=;
        b=d8XubNsfQzYtXgqvnsx8E43K9YKDS7yIkt9zEJModB980KaARXGSkKJxyFfUDHqfew
         Dl7OEJlbw42cBmegsTaNG2/nC1v7UpkPUo7+Uue+5QUoqYLnoXkXEjN0AAuwhchDQRH6
         QfLxzvtjmQeoEvYb+4ND/3GyMpeXnFdEqdo56PvR8lwP0oHqS4cX+sL6SAWbrpxZf7KY
         XfGR4kfPvRpRhE0GZOP/bhxCvBpZzvqEoDX+D9gw0j+xCE+tCkFLhxgMjOI5hTFv1qpp
         CSAqcDs3WwAKYQ554ps3DT0rB9DLWdlU5vGNMz37ruMpRImbS+IJ2ybekXzWDbCHbhYw
         9l4g==
X-Gm-Message-State: AOAM531ykNwhu8RGzr43YFZqH+hNp6k1I4CrSt1+THYZOqjadCCo/UgY
        GMTsmUI7eeHHeK7Qi+Ix4l8=
X-Google-Smtp-Source: ABdhPJxyoNal/VABidBkJWDe9Jw9/2tJBZlZHZdPuvV+ahjEagU8VmD0v1Ll9X+KYTXsoa5lldAlaQ==
X-Received: by 2002:a17:90b:1e06:: with SMTP id pg6mr3834852pjb.137.1638254189609;
        Mon, 29 Nov 2021 22:36:29 -0800 (PST)
Received: from [192.168.50.83] (c-67-169-134-72.hsd1.ca.comcast.net. [67.169.134.72])
        by smtp.gmail.com with ESMTPSA id mz7sm1262128pjb.7.2021.11.29.22.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 22:36:29 -0800 (PST)
Subject: Re: [RFCv2 0/8] USI stylus support series
To:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
References: <20211126130141.1811848-1-tero.kristo@linux.intel.com>
From:   Hyungwoo Yang <hyungwoo.yang@gmail.com>
Message-ID: <1bcb6a07-c1c2-c8c6-a0a7-4eace372dd5e@gmail.com>
Date:   Mon, 29 Nov 2021 22:36:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211126130141.1811848-1-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,


I have a question. As you know, USI provides a room for vendors to 
differentiate their stylus. If a vendor wants to add reach features to 
differentiate their stylus. Do you think the vendor needs to come up 
with like HID-USI-<vendor>.c to configure the corresponding 
usages(vendor-defined data) ? or we should use other approach ? like 
register callbacks via HID-core ?

-Hyungwoo

On 11/26/21 5:01 AM, Tero Kristo wrote:
> Hi,
>
> This series is an update based on comments from Benjamin. What is done
> is this series is to ditch the separate hid-driver for USI, and add the
> generic support to core layers. This part basically brings the support
> for providing USI events, without programmability (patches 1-6).
>
> Additionally, a HID-BPF based sample is provided which can be used to
> program / query pen parameters in comparison to the old driver level
> implementation (patches 7-8, patch #8 is an incremental change on top of
> patch #7 which just converts the fifo to socket so that the client can
> also get results back from the server.)
>
> The whole series is based on top of Benjamin's hid-bpf support work, and
> I've pushed a branch at [1] with a series that works and brings in
> the dependency. There are also a few separate patches in this series to
> fix the problems I found from Benjamin's initial work for hid-bpf; I
> wasn't able to get things working without those. The branch is also
> based on top of 5.16-rc2 which required some extra changes to the
> patches from Benjamin.
>
> -Tero
>
> [1] https://github.com/t-kristo/linux/tree/usi-5.16-rfc-v2-bpf
>
>
>
>
