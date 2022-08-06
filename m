Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D505358B642
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiHFO60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiHFO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 10:58:22 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73B821276A;
        Sat,  6 Aug 2022 07:58:20 -0700 (PDT)
Received: from [192.168.1.12] (unknown [81.178.197.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id ACF94140200;
        Sat,  6 Aug 2022 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1659797898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBZVMbltsIkBFwLkxDGMWLniH6iU/Y6FiotIXQVhv88=;
        b=qQES6BnccUYz1+rLG4Jicvck/nD41hk2Rr3ChLx+HhqRP0j6mP5zTz2QuSOzIu99suIcUH
        qqaJVFS16kDTb959tGrs/CAbsN4Qz3A6JgxZsCKsRTuc0YN3K+ejeBOuFYCYfS5U1aQZeo
        BURzjBRl7KqYt40esDRhDMqlnl716nI=
Message-ID: <eb4327d0-b31b-b6ea-e0d3-d5cff3508f39@postmarketos.org>
Date:   Sat, 6 Aug 2022 15:58:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     megi@xff.cz, martijn@brixit.nl, ayufan@ayufan.eu,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
 <f9cbc047-f30f-e711-3213-56fcbb7bbc8a@postmarketos.org>
 <9a168a20-1fd1-5d73-1d33-bd2f054d60d7@tom-fitzhenry.me.uk>
From:   Caleb Connolly <kc@postmarketos.org>
In-Reply-To: <9a168a20-1fd1-5d73-1d33-bd2f054d60d7@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/2022 03:37, Tom Fitzhenry wrote:
> On 6/8/22 12:10, Caleb Connolly wrote:
>> I was surprised to see this series, and this patch especially.
>> An almost ready to submit version of this patch with considerably more 
>> functionality has been sat around for a while but unfortunately never sent [1].
> 
> Firstly, thank you for your review!
> 
> I'm not sure why that other patch series has never been submitted. It was 
> prepared 3 months ago (unbeknownst to me, at the time of v1), but since then has 
> not been submitted.
> 
> I would feel uncomfortable submitting that patch series, since I am not familiar 
> with parts of the full DT. In time I intend to be, but for now I think we'd 
> benefit from having a base DT mainlined, on top of which we can iterate and 
> parallelise.
> 
>> According to the link below (and my own knowledge of PPP development) Kamil is 
>> the original author of this patch, both Kamil and Martijn created the initial 
>> version of the devicetree. Given that you're using their work as a base, 
>> Kamil's authorship should be respected in the patch you submit.
> 
> I agree authorship is important, and thus Kamil, Martijn and Megi are listed as 
> Co-developed-by in this patch.
To be clear, by authorship I mean literally the author of the patch, the 
previous patch in this series was created by Samuel and you left his authorship 
intact - it has "From: Samuel Dionne-Riel <samuel@dionne-riel.com>" at the top, 
so when a maintainer picks it up and it ends up in Linux, anyone looking at it 
will see that he was the author of the patch.

This patch is from you, there is no From: tag overriding it, and the diffstat in 
your cover letter shows you as the author. Whilst you have obviously made some 
heavy changes to this patch, it isn't your original work as you state yourself 
in the commit message. Authorship should be attributed to Kamil as they are the 
author of the earliest version of this patch we have.
> 
>> Their original patch [2] contained SoBs from them and Martijn, those are both 
>> missing below. Both of their signed-off-by tags should be added before this 
>> patch hits the mailing list, and the same for Ondrej. The order also seems 
>> wrong (Ondrej should be last before you).
> 
> Yes, this patch's acceptance is blocked until all Co-developed-by authors 
> (Kamil, Martjin, Megi) provide their Signed-off-by to this patch.
You should obtain SoBs from Co-developers /before/ sending this patch upstream, 
this indicates that everyone is on board and that the patch has some sensible 
history. The mailing list isn't the place to ask your co-developers to sign off 
a patch after you've made extensive changes to it.

I missed the following points in my original email:

Please read the documentation on modifying patches [1] as it applies here, and 
add a comment before your SoB explaining your changes, something like

[tom: strip down to minimal booting DT for initial support]

This way the history of the patch is preserved properly for anyone looking back 
at it in the future. In a similar vein, replace the external git links with 
links to exact commits so they don't degrade over time.
> 
>> Support for the volume keys, accelerometer, magnetometer, GPIO LEDs, 
>> touchscreen, modem codec and audio support are all missing here, but they're 
>> included in the patches you referenced. In their current state (see Martijn's 
>> commit [1] or my 5.19 rebase [3]) the DT for these components has been worked 
>> on by several people, tested by the larger user community, and are already 
>> supported in mainline. It seems strange not to include them and just leads to 
>> a bunch of extra busywork to add them back later. It's easy enough to drop any 
>> of these nodes during review if they become an issue.
> 
> To keep this patch series light and easy-to-review, I'd be keen to keep it as
fwiw, a few extra nodes now is a lot easier to review than a bunch of individual 
small patches later. But yes, better to get this done in some form than not at all.
> small as possible for now. This DT is >18 months old out-of-tree (across 
> multiple repos), so I think this minimal DT being mainlined is an improvement 
> over the status quo.
definitely, it'll be nice to start to see some upstream story for the famed 
"linux phone" ;)

[1]: https://www.kernel.org/doc/html/latest/maintainer/modifying-patches.html
> 
> The existing work that the community has done will still be useful, albeit in 
> future patch series. This DT just allows that future work to be done 
> iteratively, and in parallel.
> 
>> With that being said, I've left some feedback below, with it addressed and the 
>> authorship/SoB situation sorted out:
>>
>> Reviewed-by: Caleb Connolly <kc@postmarketos.org>
> 
> Thank you for your comments, I appreciate your review! I will ensure v3 
> addresses those.
