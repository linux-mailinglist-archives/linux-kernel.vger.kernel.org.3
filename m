Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FDC517664
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbiEBSVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiEBSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:21:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1912E1F;
        Mon,  2 May 2022 11:17:34 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 125so16773230iov.10;
        Mon, 02 May 2022 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2NFyu4Gt61+QYs1mLP0LruiAJugECyDISNKQilmDba4=;
        b=kSwDa5ATRspbpqxHdejmcou1BCv9BTqxI29t4PDFokn9lYVCJNdQ4i0vfv2NwDlsDr
         p163IZJodaar2zJgitXQRPYoT9RxblutabPvjcFl28VpnuQqSWWeGcKfTLFbrL3XM6rM
         tVs6uBtxKb4gvWU3yOxlCK8/UVeUATHVmtSTboDf/iRogkNYUEmOHJBJ81mL8s/GycUX
         na9dWmK8pCJRWNokNKMPmilEOF6oCS7BqmstC6VrO2xfnVqvo71T5R4yzagVRCFU9A9s
         f0knjZ4Ao8KLYt8PfjuArXzatwgHZ7oPJvWtxS629BSzjyph/g5vRFWV/P+TEALS3nqV
         GA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2NFyu4Gt61+QYs1mLP0LruiAJugECyDISNKQilmDba4=;
        b=60CFWaXQzi759g3UVc5t2Wsw1vY6Tm5iFbBUnlHRfhvSiXIkiSx9crqT+GJ0yzUmQw
         HmUw1K3eCbztmDCyHcnkSfcCDakG/7o/FrHjOFVuMXx123PVyLz0rVI+YVvT59+QkinU
         +ET+zURSBbeJwqgblL9DwpBfsKEjIswCeHhy937dYHUUjHBZmRfJJhKRCUj1o+DwrhWv
         /ElVU5xZIEkXtziInXtXYRfONvm/A5F7fk+WrA+Dch217sM2XhopOMipykJF3t/9efBt
         L0MwHDEJ7TXU4/xJjwtwYv6Pr50lVc92rLGD9kvQXlBHs2E/Ep6akbYivKu9zhZ2/CLL
         5Kmg==
X-Gm-Message-State: AOAM531EkSKNvU0q/XmE49eGzbyY2l0H8s8pRRlX0ErV3YT/DPsmqSpS
        uDqLHWl9mOBqzl1v5gKydBM=
X-Google-Smtp-Source: ABdhPJwgQ7bs8X5tx00BikwdgEBcvWdDQWUQbG+CklbdT2U0A436nlqlGQDi3y0U9DhcITGIJ9qEfw==
X-Received: by 2002:a6b:8fd2:0:b0:657:c987:457a with SMTP id r201-20020a6b8fd2000000b00657c987457amr4573921iod.165.1651515453834;
        Mon, 02 May 2022 11:17:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:bd98:70d3:4542:6c6a? ([2600:1700:2442:6db0:bd98:70d3:4542:6c6a])
        by smtp.gmail.com with ESMTPSA id y14-20020a92d20e000000b002cde6e352fcsm2831040ily.70.2022.05.02.11.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 11:17:33 -0700 (PDT)
Message-ID: <367805de-3ef5-1e1d-3711-7d21b500a886@gmail.com>
Date:   Mon, 2 May 2022 13:17:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] of: overlay: add entry to of_overlay_action_name[]
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20220501000543.1368005-1-frowand.list@gmail.com>
 <20220501000543.1368005-2-frowand.list@gmail.com>
 <YnAOEqO23BQk53vz@robh.at.kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <YnAOEqO23BQk53vz@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 12:00, Rob Herring wrote:
> On Sat, Apr 30, 2022 at 07:05:41PM -0500, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> The values of enum of_overlay_notify_action are used to index into
>> array of_overlay_action_name.  Add an entry to of_overlay_action_name
>> for the value recently added to of_overlay_notify_action.
>>
>> Array of_overlay_action_name[] is moved into include/linux/of.h
>> adjacent to enum of_overlay_notify_action to make the connection
>> between the two more obvious if either is modified in the future.
>>
>> The only use of of_overlay_action_name is for error reporting in
>> overlay_notify().  All callers of overlay_notify() report the same
>> error, but with fewer details.  Remove the redundant error reports
>> in the callers.
>>
>> Fixes: 067c098766c6 ("of: overlay: rework overlay apply and remove kfree()s")
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/overlay.c | 27 +++++----------------------
>>  include/linux/of.h   | 13 +++++++++++++
>>  2 files changed, 18 insertions(+), 22 deletions(-)
> 
> This isn't applying for me.

Weird, patch can apply it, but 'git am' does not work.  I see that when
I try that on your dt/next branch.

The problem seems to be that I did not create the series on top of
dt/next: 5f756a2eaa44 of: overlay: do not break notify on NOTIFY_{OK|STOP}.

I have rebased the series on top of that patch and am sending v2.

-Frank


> 
> Rob

