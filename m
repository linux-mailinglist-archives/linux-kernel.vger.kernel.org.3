Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A46748439D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiADOng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiADOnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:43:35 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A865C061761;
        Tue,  4 Jan 2022 06:43:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso1561550wmf.3;
        Tue, 04 Jan 2022 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=haW+R5LZt/7A48CppgWQ47GOZelWaEypF3zOPD1WT9s=;
        b=COThv360hLgWFyu/xbIh6xIziRgocf1fohix2c0yhImq6cYLu2vOkcTChdWOxRSabZ
         +7aIAXPe5kuvT9N7mdStZK5eGR2IYin0xo6HrZK2T4D0xHG/WXWGIoVEHrTHRjkahvq/
         8AoGb6+pQULo/92bf/ogfl3tkXm3H8UVgr75RX142ZgddPq71mtg8iXP+SiMMQphQfkD
         SzvNK+vRIY+9lS1q6Qbx5AK1Wuv0Ttjr7VurwE/qthCGuQpvrpfTf6hWiT6A+X8CgLg3
         6evvAV2k6AWmvzLd5R7sZEImQoSYSexn+b4eCQDuwnb4S0QfBbpw1Z72drcANeWk3naq
         wP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=haW+R5LZt/7A48CppgWQ47GOZelWaEypF3zOPD1WT9s=;
        b=eR8Mdkhq4QzKm/FfT1rKnOg7lNeCendrPnJvT15OQf2NfRPlJVwP7CXiLLxJZ0yr2S
         M/jfsPXX4RxJoEC9Fgd4TdWZwGPyQUdb8AGLJ+OqsZajpsLnJoqtR5css9h4x3uJlH+J
         P45XsTWjNsXrRC6P9GL4yCBunOCOSDkre9eg6a6siaVQwsrDsdDfLYXU+b2+ThCKVO12
         UpAnlklt6rqkTEHTt4C6G0naGP6h47GAjMTY8qXts+Xkn6BKL+guEN8u3AA77a6t2AVc
         ILYzX2jgxY72dlY88q6unxaVqH74q0pV2R5YKRkc7RrFEyoO5Q/EbQBwVCqy7aogBVvM
         4TfQ==
X-Gm-Message-State: AOAM531SF4AYO6Wc6x547BBz8rGE94VNkoeEsWr2mNnO601HbuuFim7w
        ++xlT/9FSGpcSUXnZZVUDIyFP6fbPtE=
X-Google-Smtp-Source: ABdhPJwmpOkl0r4hrLezxT3IfnTjZOpfndGOUO2UQIg13qpZwBegqLbWp2ducd7rgoNqKTY2xWOWGw==
X-Received: by 2002:a05:600c:1e8b:: with SMTP id be11mr43037806wmb.125.1641307414196;
        Tue, 04 Jan 2022 06:43:34 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2f:5b00:f9ee:e9e3:d08e:f6e9? (p200300ea8f2f5b00f9eee9e3d08ef6e9.dip0.t-ipconnect.de. [2003:ea:8f2f:5b00:f9ee:e9e3:d08e:f6e9])
        by smtp.googlemail.com with ESMTPSA id ba18sm1711544wrb.40.2022.01.04.06.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 06:43:33 -0800 (PST)
Message-ID: <c905fd23-19c1-218f-819b-b8ae3434f48c@gmail.com>
Date:   Tue, 4 Jan 2022 15:43:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: linux-next: build failure after merge of the pm tree
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220104111551.7f26e893@canb.auug.org.au>
 <d485fb62-b576-f9b6-13bc-709a2c409240@gmail.com>
 <20220104190220.45c8e0cf@canb.auug.org.au>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20220104190220.45c8e0cf@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.2022 09:02, Stephen Rothwell wrote:
> Hi Heiner,
> 
> On Tue, 4 Jan 2022 08:29:28 +0100 Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> The patch in the pm tree annotating pm_runtime_resume_and_get() as __must_check
>> follows some fixes of pm_runtime_resume_and_get() usage that went through other
>> trees. These fixes are in linux-next but don't seem to be in the pm tree.
>> We talk about:
>> f04b4fb47d83 ("ASoC: sh: rz-ssi: Check return value of pm_runtime_resume_and_get()")
> 
> In the sound-asoc tree.
> 
>> 3d6b661330a7 ("crypto: stm32 - Revert broken pm_runtime_resume_and_get changes")
> 
> In the crypto tree.
> 
> Both those are merged into linux-next after the pm tree.  If Linus did
> the same, the pm tree commit would break his build.  The only way you
> can have that pm tree commit in linux-next is to ask Andrew Morton to
> put it in the post linux-next part of his patch series.  Otherwise, it
> needs to be removed form the pm tree and wait until after the next
> merge window closes (or at least both the above trees have been merged
> by Linus).
> 
Rafael,
can you take care of this?
To avoid such issues I think next time I'd route all dependent patches
through one tree and just get the ACK from the other involved maintainers.

Thank you, Heiner
