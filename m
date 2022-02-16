Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9224B81DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiBPHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:38:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiBPHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:50 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03E1174D5E;
        Tue, 15 Feb 2022 23:37:16 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso3047147wme.5;
        Tue, 15 Feb 2022 23:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fcjsuPNQ/ElKKZzWhCUTEeBa9hiEJc7LibQjJR9rEeU=;
        b=5N719t1feMXZOgvg84T9FuHEPutLoMBmmUZsxUQD0kDpTkHHZ4Ty6oGtKxqmbIWGWR
         WDSNOwQsgHIdF08F+ZoALZEzyhvSVtLJyK+LtWzpRYJKdOXS0m1Wu3OWJ/+NQWlB8fVS
         bVyL1qvMEGzltoKFvfSCth7oyd0DkXYaRM2+03EL4h2tRz8tYZyZsGLF7SB/6SsCRpgA
         amV4IL2h51nMNZQjhUlLev+qXVEKs0mfKEgoSDRRI30KFNulkwMC7FyF5Hdb2vIkIrUI
         y0Aa8K2c0icBjYHu8UOtCWElD0w9/t93KBde8VE3AB7lDuJuYzar+xfPaHjeIz6NqLAB
         r9gw==
X-Gm-Message-State: AOAM530VmqNSl3/dxc4C8d7monoeo3o5Skl2LSwGefLZCzQbQh3i6dny
        8f2SS1zeRW6H1USeNyaSpx8=
X-Google-Smtp-Source: ABdhPJxbJNyEQzvIiDNrzD+g+pa+pXUcVq/akn8wbE/JG08QWrXf4nvoSo157dY8BbsGvojheUtgow==
X-Received: by 2002:a05:600c:414c:b0:37b:c80e:e3dc with SMTP id h12-20020a05600c414c00b0037bc80ee3dcmr314007wmm.116.1644997009856;
        Tue, 15 Feb 2022 23:36:49 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id z5sm21400842wmp.10.2022.02.15.23.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 23:36:48 -0800 (PST)
Message-ID: <99b0e568-ee2d-bbd0-dfd0-fb0953cd556c@kernel.org>
Date:   Wed, 16 Feb 2022 08:36:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v20 5/5] arm64: dts: qcom: sc7180-trogdor: Add nodes for
 onboard USB hub
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220119204345.3769662-1-mka@chromium.org>
 <20220119124327.v20.5.Ie0d2c1214b767bb5551dd4cad38398bd40e4466f@changeid>
 <YgJMkFAxjazkUDZd@kroah.com> <YgLCswtX/0THkzXT@google.com>
 <CAD=FV=WMP8M5HTRNv9_scvrytbpE0iBdUack=XaHoypGNLJeVA@mail.gmail.com>
 <Ygv3FSDS/fq1oePy@kroah.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <Ygv3FSDS/fq1oePy@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 19:55, Greg Kroah-Hartman wrote:
> On Tue, Feb 15, 2022 at 09:54:54AM -0800, Doug Anderson wrote:
>> Hi,
>>
>> On Tue, Feb 8, 2022 at 11:21 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>>>
>>> On Tue, Feb 08, 2022 at 11:57:20AM +0100, Greg Kroah-Hartman wrote:
>>>> On Wed, Jan 19, 2022 at 12:43:45PM -0800, Matthias Kaehlcke wrote:
>>>>> Add nodes for the onboard USB hub on trogdor devices. Remove the
>>>>> 'always-on' property from the hub regulator, since the regulator
>>>>> is now managed by the onboard_usb_hub driver.
>>>>>
>>>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>>>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>>>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>>>> ---
>>>>
>>>> No DT maintainer approval yet?  :(
>>>
>>> Bjorn usually just picks DT changes into the QCOM tree when they are
>>> ready, so I wouldn't interpret anything into the lack of an explicit
>>> Ack.
>>
>> Right, so the expectation is that this patch wouldn't land through the
>> USB tree but would instead land through the Qualcomm tree, probably a
>> revision after the code lands in the USB tree to avoid dependency
>> problems.
> 
> But our tools pick up the whole series.  I can't just do "i will pick
> patches 1-4 only" easily, and neither can any other maintainer.

I don't have problems picking individual patches - either b4 am on each
patch or on entire series and dropping later unneeded commits.

> 
> Why not just get their ack so that I know it can come through the USB
> tree?  That's what normally happens for other changes like this where a
> driver change is required first.

DTS is a description of the hardware and we take it via separate
branches of SoC-fami0ly repositories. These are always separated from
the driver changes. Always. For several reasons:
1. By convention,
2. To be sure there is no dependency on driver code thus an ABI break,
3. To have a nice and clean history of DTS changes, properly organized.

What is more, if this was coming via my Samsung SoC tree towards SoC
folks, I could not take it in one branch. I would need to physically
split it, otherwise Arnd/Olof would bounce back my pull request saying I
am mixing DTS with driver. Of course you do not have such requirement -
I am just saying that splitting DTS is quite common and proper way.


Best regards,
Krzysztof
