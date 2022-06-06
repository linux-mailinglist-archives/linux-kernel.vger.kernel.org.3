Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A884753E935
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiFFJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiFFJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:22:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0648A9FCB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:22:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id fd25so17959261edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ybrv+bzctpeug341ukOx3SGsCHJGmZEVgY9V7q++jyo=;
        b=uUBoVtfVYuTWIISUPiOMxroxWDHAWiTymHUdRzYt1nMox5h5ganPiB2UwX2/kBNSWh
         iBXErrEisUqYzITF5/TgL72YPU14HAPQ8hOZSK7dt+/74jcRo3viVvg79RvwwzsT2q1a
         02oT0TEi0M+ex93ejIlh7NNbJxbnR07Ve8mMbE/GutoGR8ZbthUEP58M9wRbIhlcXYKY
         emsDeAxooTz/WiuAQbrqoxz7CU57gQO+It0ld84bnkDmZaBPbN6cODSnhVpzqV+s5EKw
         NP2G1ynYy2uJEZcGZ8m/UxhCm8T+Gs3v5NQzbPy8HIuntcjPWdv4KiZLzHWqjugztUjp
         zrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ybrv+bzctpeug341ukOx3SGsCHJGmZEVgY9V7q++jyo=;
        b=1h5BOudEVwdNUL4bXnXE5siHYw6YsaJ8VHHOLhnL/WtAMSHn1i3aYJL8+ZTBaX0MvT
         7vhjyjRh0zjCLRcX18HKwjVzCPQCYM9d+LaqdGcsNc7iLDbabYgasEdddaUXi5zQcGxa
         VbBi7YtAe8bPuD7MAEQIlAy3hGO+crdiahRCtwrE2g07z098GgPWokgst08Rgw/7Py+B
         5/SpzSW8BEr96JqUJJFM9jOs7B6bbI8VtDykA5imQZFb0xsIiIsOgxoUc1EOkEegc+GM
         krLYcKxGbErUx5JYCa7h3CiiZXNEC9A1+SfTs+EhX1hM3q2wCLRUlYNeuAxlxYnjZCnb
         RTZA==
X-Gm-Message-State: AOAM533LOE6+wFuc3vjrsdS/VBOyVdUwltEPn5DQ49ObiHZP5LcaPPPY
        c+R0eu2wBQSs+YXtfVL5PpJYSw==
X-Google-Smtp-Source: ABdhPJzk8nEw9/Otbmr/3ovJRhvdphjxQi21wayueg0Ak4Msn0yiNavxRHM3CquimXqnlv0paUMJPg==
X-Received: by 2002:a05:6402:274a:b0:42d:dcd1:c847 with SMTP id z10-20020a056402274a00b0042ddcd1c847mr25680307edd.169.1654507369945;
        Mon, 06 Jun 2022 02:22:49 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u15-20020a05640207cf00b0042dd60352d1sm8271687edy.35.2022.06.06.02.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 02:22:49 -0700 (PDT)
Message-ID: <f3bf2e35-a613-0f2b-daa7-3cbd6fd5b68b@linaro.org>
Date:   Mon, 6 Jun 2022 11:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3 v2] ARM: s3c: Kconfig.s3c24xx: Fix indentation and
 replace some tabs
Content-Language: en-US
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        alim.akhtar@samsung.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
References: <000c01d86e721c025105406f30samsung.com>
 <20220523080409.14949-1-juergh@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220523080409.14949-1-juergh@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 10:04, Juerg Haefliger wrote:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> While add it, replace tabs before comments with whitespaces (which seems to
> be more common), add a missing trailing endif comment and squeeze multiple
> empty lines.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
> v2:
>   Mention additional changes in the commit message.

This one does not apply. Please rebase on my current tree or tomorrow's
linux-next (easier) and resend.


Best regards,
Krzysztof
