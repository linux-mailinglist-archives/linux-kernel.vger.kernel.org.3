Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D214E4E20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiCWI1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiCWI1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:27:00 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B94C6E7BA;
        Wed, 23 Mar 2022 01:25:31 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id o10so1316702ejd.1;
        Wed, 23 Mar 2022 01:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=UDzmM2F5qsBTjZeESFYmdK8jpXHM9dNYq1XkfGnSqpY=;
        b=kJ4ciQX15fWC3dE257y7kXlqZ8UVpkkZRJr56eSAp3CyBiRY3Q2Iiw4KcRwPT2u7xj
         2SM8aX8sbEmlLhaY5I/4oRgVlwyTythfkgjc1Fjb9w5Dp5mPAzbBvlI2Yx6Bc70a7eD1
         wstxeSjY7hXgQJ2KdHmVhYPB//Nh9UHMbPkUcMG6xsjJ20zDoyvTCg8VPpRkyI5aHx7x
         9hnV4YhFTwIcZqmD5RZaayg5UHYTXPToKZLR3pnRv7B04ELtjrshjEK/302oBYG3tEOf
         soFC5PcB8nFsbJAkH6XzDPc0RcwB0LIX776xMSdCgGBYrI+Nx8L1It+GOxtDNCiB6Eqx
         MXmA==
X-Gm-Message-State: AOAM531/QfYHT5DY3F9npisoJxfyEk3Q7wJ57oONIa4DAH2QJ8uBDaIj
        joXwbVjIEYb4eMu0HJqqop8=
X-Google-Smtp-Source: ABdhPJyQziiQYcUgVJbS3gtxrr+bZDijjrDjWjpvQFg2UbAUXHyP2kyUm5aC9LxVP8CgHkxRaqkflw==
X-Received: by 2002:a17:906:9b8f:b0:6e0:6bcb:fc59 with SMTP id dd15-20020a1709069b8f00b006e06bcbfc59mr372218ejc.624.1648023929560;
        Wed, 23 Mar 2022 01:25:29 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id d7-20020a50cd47000000b004187eacb4d6sm11165318edj.37.2022.03.23.01.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 01:25:28 -0700 (PDT)
Message-ID: <81bbd50c-1c81-f0fd-2edb-3780b0c7a799@kernel.org>
Date:   Wed, 23 Mar 2022 09:25:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 0/4] support USB offload feature
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
References: <CGME20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c@epcas2p1.samsung.com>
 <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
 <YjhB7+AaEXvuUmdi@kroah.com> <20220321092409.GA62265@ubuntu>
 <YjhGKVKuPsKG80wZ@kroah.com> <20220321100631.GB62265@ubuntu>
 <YjhQg4I7eYWXIfgr@kroah.com>
 <CAJKOXPdmSUqs+d3CuJ9px=vWPPdgP0scAZvKJkKDrs5O+sw6yA@mail.gmail.com>
 <20220323013130.GB19041@ubuntu>
In-Reply-To: <20220323013130.GB19041@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 02:31, Jung Daehwan wrote:
> On Tue, Mar 22, 2022 at 06:05:49PM +0100, Krzysztof Kozlowski wrote:
>> On Mon, 21 Mar 2022 at 11:16, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> [v3, 0/4] add xhci-exynos driver
>>>>
>>>> This patchset is for support xhci-exynos driver....
>>>> ....
>>>>
>>>>   usb: host: export symbols for xhci-exynos to use xhci hooks
>>>>   usb: host: add xhci hooks for xhci-exynos
>>>>   usb: host: add some to xhci overrides for xhci-exynos
>>>>   usb: host: add xhci-exynos driver
>>>
>>> Yes, that makes much more sense.  What would you want to see if you had
>>> to review such a series?
>>
>> Unfortunately it might not make more sense, because last time
>> xhci-exynos driver was a fake driver, not for submission. It did not
>> compile, it did not work in mainline.
>>
> xhci-exynos driver wasn't compiled on v1,v2 but can be compiled on v3 series.
> 
>> That driver was not even sent to proper mailing lists, as pointed out
>> by get_maintainers.pl, maybe because it was not developed on the
>> mainline kernel, so there is no MAINTAINERS file?
> 
> There's no MAINTAINERS file yet as you guess.
> 

Which is a proof you develop on some custom tree, not on Linux kernel.

Don't. We cannot accept code which was not based on Linux kernel, but
some out of tree local flavor.

All submissions must be based on upstream trees (mainline, maintainer's
for-next or linux-next).


Best regards,
Krzysztof
