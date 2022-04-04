Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0D24F12BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356187AbiDDKLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbiDDKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:11:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5174526106
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:09:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g22so10442421edz.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 03:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ORm7IEBhnE2whN6dFEeIM9GRceZWora10T4zNnlPwD0=;
        b=dq/Q0yNyookqIqWLL1mbsAP5y+ehqLOz4Xe2poFaTKCEmLA7+boLhXgWXyvaPz+DqW
         3fSwdLC7oEUlvl3oXPSA+jb65XPElLuE7pmBm6XxxjKy+N5RRD5oVnqzqoncxMHqHuI7
         ZZkBpt3MNOfoCJhvjmDXsje2NI9bgS0OcgZS76J3pxdgpITw8J+2j7Xt6DkpFoJWX1QB
         qVtR3k3m/GLi2E454fajVHtGdFC/WFk9SP1wqMpFcWc2USbYyAr49iA5FlBtDAgF+MlQ
         MHnewTR7gDKn1xpLpJS89eSunFslrIynkb/FvsEGCZv3b4xZMMA7ivYj9QzISp8T5Q3M
         suIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ORm7IEBhnE2whN6dFEeIM9GRceZWora10T4zNnlPwD0=;
        b=hlaM3Ba6FATuPO23G3c6ITNxmfHxtV6XVGGhRiSuW5ITY7v3kQEWE6iZqzYZXA9VMB
         u8lf5ekbgTZ1Zd/Z/KbDPnF/u93HUEXNcZDsnY+nxsrI7X8x/yirzqwOiqDMYYnMQRbr
         UtKhCXPYCHM2CDj1TxvW+x0iSXovc3fWECqTeuMA0RPY8vqsJgqOXog1q6LW0daS9N+t
         HlWPKoMHxAJQa/vpzdLaJ0vDbT5I9ImIWEoRe9EeJVg6VR5/3GXw/lAYwnSdtdLLXTPK
         fl+6HiV3g83z1N3xkdWv3TpwehxAO7G1VoqggKcmaSGZ1i9cDzY4N67Fz+RTLAJjIzg4
         FJFQ==
X-Gm-Message-State: AOAM533a7+G2Q5FR0eG8pWPZ1AgJD0/c4iyZ+pTx1Nb+Qoxe0X6OOpTw
        LA8H6wi46kxLL8VEQCGOsuvTAyfuUpX+3kta
X-Google-Smtp-Source: ABdhPJwX7lzYCamvN0+upaYm7/Lq6+W8sbYskyV64EstO8xeM/cNpVU9qYYWx98JUFHBVHf7wLyjjA==
X-Received: by 2002:a05:6402:2707:b0:419:5b7d:fd21 with SMTP id y7-20020a056402270700b004195b7dfd21mr32453301edd.51.1649066954876;
        Mon, 04 Apr 2022 03:09:14 -0700 (PDT)
Received: from [192.168.178.55] (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id og13-20020a1709071dcd00b006e7fdf0a687sm282708ejc.76.2022.04.04.03.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 03:09:14 -0700 (PDT)
Message-ID: <3fcfce19-ccb9-28ae-28de-2e62c12bcd23@linbit.com>
Date:   Mon, 4 Apr 2022 12:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MAINTAINERS: add drbd co-maintainer
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org
References: <20220331134236.776524-1-christoph.boehmwalder@linbit.com>
 <8dbb5fc7-7170-d190-ba24-2ef13dc73623@kernel.dk>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <8dbb5fc7-7170-d190-ba24-2ef13dc73623@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.03.22 um 15:48 schrieb Jens Axboe:
> On 3/31/22 7:42 AM, Christoph Böhmwalder wrote:
>> In light of the recent controversy surrounding the (lack of)
>> maintenance of the in-tree DRBD driver, we have decided to add myself
>> as co-maintainer. This allows us to better distribute the workload and
>> reduce the chance of patches getting lost.
>>
>> I will be keeping an eye on the mailing list in order to ensure that all
>> patches get the attention they need.
> 
> Can you go over the ones I already listed? That'd be a good start.
> 

We are going through that list (and others) internally now and reviewing 
them. I will prepare a pull request.

   Christoph
