Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725A94781C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhLQAra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhLQAr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:47:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B357CC061574;
        Thu, 16 Dec 2021 16:47:28 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d10so1299012lfg.6;
        Thu, 16 Dec 2021 16:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AAR+6gokDhVIrnm7EiJygBmXr48WtYzlLYW9kUrZk1I=;
        b=Qka8zTqjm+QroCBjjfHEMnmj8WmNq3H2uQ1IBvFtxQ11GghpAW1o0uk8IX/TbF+RWb
         mJkNqP0NwlZW1KHZjLnP+VrX7wSnwe+c8/0K/HotoiBvwiHeqkXahdNNnKIL0Zrggpg1
         Ysezta2LMpajRr/gzWm/xvzVr00vqjjLz8gbrePUtoPSA0x/4cZxwChelODhjiQYK7va
         PwS3KyJRwhf1P67jOy8cMoeb7dYVUcHvIULSj9lrvLeepc8ErwHj/yEDEJChjPYVS5FY
         IobM4twqG0RBriMG+CKfyth4HUbNMOg3hnVKL6wH2h9Rh4tTY66hZfIVTkaFyX11nxMb
         SWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AAR+6gokDhVIrnm7EiJygBmXr48WtYzlLYW9kUrZk1I=;
        b=TLZ9fChpmDo5+kJJkmxjNWJbl6NsQNFXh1yx/PoUUVMuv8aA76bcmzQ59C7IkVcZzq
         EePeLxGlzFyt2e0nXTo8nl42iJopUQTjGBqEpdmO7vID+bGZKqYh+TxXaiQcPmtOu2Yb
         XeO5vJhTvourpbpGipLGtH+sx0ohY1l344UYKAjlKhX58G+pqxxoQzTqimxzc3KUknFl
         axwfeg7Qvm0eEZMeFe6BQtQQjRYqG6A5ZSWbKmgPnVZqlTxDBuyRKFA4mYcQeBLYeKXF
         8IzIm6KTdmuFFhyYhOJHcsPAl4JnwZWFCx/Ls6/RB542VbwxUvY5yWuGhSWQfwKD3e9b
         3ybg==
X-Gm-Message-State: AOAM533mLOgd6E42mLnphHUClGSo5naEa/ntGP8u2W+zfgB9HiKEO2mA
        cNcI08YoKM/6oGSHA5n0YVaDe0jgYyU=
X-Google-Smtp-Source: ABdhPJxmEjB5n5f5oNzo1e6e3pmj4zBm9PN4yweFZPbD0q0qCiRmk0H/reVmoYCFx2qlpB6falgcZQ==
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr667843lfg.184.1639702046863;
        Thu, 16 Dec 2021 16:47:26 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id z8sm1413490ljj.86.2021.12.16.16.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 16:47:26 -0800 (PST)
Subject: Re: [PATCH v17 7/7] usb: Specify dependencies on USB_XHCI_PLATFORM
 with 'depends on'
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211116200739.924401-1-mka@chromium.org>
 <20211116120642.v17.7.If248f05613bbb06a44eb0b0909be5d97218f417b@changeid>
 <YbvSNta4jCxizaTa@google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b0b69294-e7fb-5e7a-80f3-466dd4bdc88a@gmail.com>
Date:   Fri, 17 Dec 2021 03:47:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbvSNta4jCxizaTa@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2021 02:56, Matthias Kaehlcke пишет:
> On Tue, Nov 16, 2021 at 12:07:39PM -0800, Matthias Kaehlcke wrote:
>> Some USB controller drivers that depend on the xhci-plat driver
>> specify this dependency using 'select' in Kconfig. This is not
>> recommended for symbols that have other dependencies as it may
>> lead to invalid configurations. Use 'depends on' to specify the
>> dependency instead of 'select'.
>>
>> For dwc3 specify the dependency on USB_XHCI_PLATFORM in
>> USB_DWC3_HOST and USB_DWC3_DUAL_ROLE. Also adjust the
>> dependencies of USB_DWC3_CORE to make sure that at least one
>> of USB_DWC3_HOST, USB_DWC3_GADGET or USB_DWC3_DUAL_ROLE can be
>> selected.
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Note: This patch has been removed from the onboard_usb_hub series,
> together with "ARM: configs: Explicitly enable USB_XHCI_PLATFORM
> where needed" and "arm64: defconfig: Explicitly enable
> USB_XHCI_PLATFORM". These patches aren't any longer needed for the
> series. If maintainers think they are useful independently from
> the series please pick them or let me know what needs to be
> changed to get them landed.
> 

Hi,

I don't know what this all is about, perhaps I'm CC'ed semi-randomly
because touched that Kconfig once.

All I can say here is that the commit message tells us "This is not
recommended" and doesn't explain what's the actual problem is being
solved. If there is no real problem, why bother?
