Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7052E0F0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343818AbiETAAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiETAAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:00:14 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C248B0BC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:00:09 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v10so6346521pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lLbMnvw+faTyxCMOwTjTghI4DP6Umnnr6YZkxv8pN48=;
        b=DHiPMHxkjxizpYca3CNj1ugi0Z/cSJZD+ubYtVyLqnGgFiXVhHBUIXRzon5pEt5d5g
         tmZ5uBdKlB00Ptz7Nwz4aKjxVy34E7+gG2mKxaaJDcnsckScBQTDmq+DaRtbtay3VgXZ
         SRBK+8rhLYGRGppT66Rjr9ZYl+K2HAW0ix/JxZi9oSN/FXwzDrfuGr2Ov7CmTyy8tFvq
         HaFJUclDI+t+GD6NONR+4tYDce/Tq+UXBr4iVpJubIXP7azF5WIqe7AnZQ7nWpKJIdcN
         G+woSh9FR3hjNsTx8qZQrAJbior/pnEAqX38BlpBp1sM3IF1puBYNz7tC0RMuX6W5dZ8
         7YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lLbMnvw+faTyxCMOwTjTghI4DP6Umnnr6YZkxv8pN48=;
        b=YG9SDqTuzD58w0+Cjn5Jf77E9btshmobPKbV42uR8BwE0caT9PEC73z5ygfkTYLXEy
         loYgIqiI2/250QvcLv7Hp+f5+NAPuzknuVdG0x+Osgb5C1A8E/IVckCIiBOn+4R2Rj60
         YsOd5p+nnCqyyXbZ/BjnmVGXtw+pWu7tL7R4l8b3jiSw8GClKt9r3Ut7jtzemlAeqTdT
         Ypus8aPP/8ruXkSvOhpYV2bmXoHvxXE43cFYeev5EexSmwE8VdYs1mLXaOBeSV77gmMP
         SUzqH/vHjNmXMMDL7LzxCWzPRRUuBGSG/iLymmkQJwBGuXQE8yYCBVzMbHZOTjxDLimy
         vO7w==
X-Gm-Message-State: AOAM5331Suga/GrI/t3a3R+v4YKbJJei8kPpIPpo93X4k5PPJRV5D7xT
        WXpVbYVnLrZo/V/dKHv0YIVLkA==
X-Google-Smtp-Source: ABdhPJwdzzyjGnmiUST+x2ws3gviPmuNu7n3vODs578ovWO2/HrPZbaRamrr3u35imdKVWgEBlySkA==
X-Received: by 2002:a05:6a00:1891:b0:50d:e6e7:acae with SMTP id x17-20020a056a00189100b0050de6e7acaemr7090542pfh.26.1653004809276;
        Thu, 19 May 2022 17:00:09 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id cp20-20020a056a00349400b0050dc7628140sm270500pfb.26.2022.05.19.17.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 17:00:08 -0700 (PDT)
Message-ID: <cb3d45f0-8cd1-3973-d1a4-ccc7e413cff4@kernel.dk>
Date:   Thu, 19 May 2022 18:00:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET v2 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220519233137.20415-1-axboe@kernel.dk>
 <CAHmME9p9jipQk96q_nY0YzFMUaAQ4jOAAN_cmVorddfKV8cn6g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHmME9p9jipQk96q_nY0YzFMUaAQ4jOAAN_cmVorddfKV8cn6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 5:56 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> This patchset seems to work. I'll queue it up with some cosmetic
> changes. Thanks a lot.

Great, thanks for the quick response!

-- 
Jens Axboe

