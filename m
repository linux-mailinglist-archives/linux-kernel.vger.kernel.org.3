Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188C5482277
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 07:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbhLaGVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 01:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhLaGVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 01:21:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C97CC061574;
        Thu, 30 Dec 2021 22:21:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d9so54520566wrb.0;
        Thu, 30 Dec 2021 22:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=8mjrwm3w0KoS600EYUD7h9ycLkJobzFPTBS2rfWrhAA=;
        b=J2GoPl1OarqetmbJu7EsAw/bqylp91mFU5T4Zs3EfQBXtlE+KgMNdPw5Jgij8bQUqC
         KTzlLF1S4/gzztFrlv65cGskMvBuW92ENegm+vCrETLYPCV3pvXJpuEzSlK+B3EGXigW
         r6uYXZzElgWOUnaQl1hMlEI8/mrkc2vrPp5fWVGg3yn1wwpCWExcYOO3ZkDi6VWXVgNq
         QGlH3YgLP5N9vrGGm2hWjN6h8IXFlF25/v26kTEyuHXGa2xdkqWIWE0S34HDN9XLaCCp
         NA+4pskNMhj0Yfg7vlOvGsR5QyhBuo4Rfnx07u2VPei8/OFMWeOoPi9KGvhyApZM0Rxk
         XS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=8mjrwm3w0KoS600EYUD7h9ycLkJobzFPTBS2rfWrhAA=;
        b=B22hdhJ2goQNWr3zewGuiCc9r7BFusCufGtByegubzqJmDArVMsiaufBcckFD15aBV
         vdIr9SiOkUwT0qZ5XnnzBkAk1EbFy3Tg6GExAi0qDRVNE9gW0jEdANcxpv+zNE6XtELg
         r63muBBziHkRm2+oFhh9ojJVHgdYpeDN4g5P/jDqFeXN+P9nrX+uTHltg7M/NRVy0wEe
         2pIJxVviAB3peFtPM3sjL0+PsBU3dL/6fYyltocRLJjCaC/BY86gKYJxcVXK4ADrau6v
         YhBHHZQ+4Eym6ZcfVugP04NZSewC8CUfG3SRy4pdrI7iNxkFGk9IiSWc+HgQp5uGl+XP
         90oQ==
X-Gm-Message-State: AOAM533bQwV6OtzqldyxRmxe6442Wlt/Iz/JMPUnQsahVBIKK0l+lN4Q
        1oHNpbMWPhkWrvLE/hltZaeMdlO1F4H/XQ==
X-Google-Smtp-Source: ABdhPJy7k+mr9VR7cFrcywTNDoc3AchTbasl4McsYnydjoKSRyrRETDhVuFiv07scbFcSINMD37ThA==
X-Received: by 2002:a5d:6d49:: with SMTP id k9mr19898185wri.530.1640931708956;
        Thu, 30 Dec 2021 22:21:48 -0800 (PST)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id m35sm54878477wms.1.2021.12.30.22.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 22:21:48 -0800 (PST)
Message-ID: <50ea1b0e-28d7-6d04-9c03-4becc4db143b@googlemail.com>
Date:   Fri, 31 Dec 2021 06:21:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: 5.16.0-rc7+ Bluetooth error
Content-Language: en-GB
From:   Chris Clayton <chris2553@googlemail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <02077a37-46d6-c94f-fa08-9da7ee99e42c@googlemail.com>
In-Reply-To: <02077a37-46d6-c94f-fa08-9da7ee99e42c@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2021 09:21, Chris Clayton wrote:
> Hi,
> 
> I pulled the latest changes into my clone of Linus' tree and built and installed the kernel. (git describe gives
> v5.16-rc7-9-ge7c124bd0463). I'm seeing errors reported by the bluetooth subsystem that i don't see in 5.15.12 or 5.10.89
> 
> The problem seems to occur twice during system startup and on each occasion I see a batch of identical error messages:
> 
> [    3.980822] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [    3.982812] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [    3.984812] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [    3.986608] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [    3.987621] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [    3.988606] Bluetooth: hci0: Failed to read codec capabilities (-56)
> [    3.989650] Bluetooth: hci0: Failed to read codec capabilities (-56)
> 

Sorry, I should have said that despite the above errors, my bluetooth devices still work fine.


> A full dmesg log is attached. I've also attached Two files containing the output from "lsusb -v" run on 5.10.89 and
> 5.16-rc7.
> 
> Please let me know if I can provide any other diagnostic information or test any patches. You'll need to cc me on
> replies because I'm not subscribed to LKML or linux-bluetooth.
> 
> Thanks
