Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B80350F77D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347886AbiDZJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346254AbiDZJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:07:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962161759D4;
        Tue, 26 Apr 2022 01:48:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e2so18129214wrh.7;
        Tue, 26 Apr 2022 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iHo8yEw9vi6ApvW9lREs3BsO/SztyDLEl+71H8g0jpU=;
        b=VN1eJoSUpgw+fEiVLbAQqhxhv2kBlRYd8XppnJMJZihec2fPd9TDx1BawH28JfstJ4
         MZGiQzfZyiade6E40jIsx2nB2EHHy4ghLMSIVu3f/1AEIK1j8MmMOT0EdcQR0Fa/KYu/
         YenaRIDsLY0GZOFU7xhlRt915PShWqXv8pk8AJa3mNJD8h48/MVhKEUKjq87k9d+Q9dF
         67G8ODzTX8xqtN4Thyv+u2ISk4AcFdK63c2xoYkumqzsp01RXkqZE7MBmZxhV/DF4WI+
         4sZzFl59rGb59ctGzr33iTIilpZGoNcDyMxaaeq9el0k6lbQgPaRcayoqUPC1c0SmY7Z
         Wzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iHo8yEw9vi6ApvW9lREs3BsO/SztyDLEl+71H8g0jpU=;
        b=DZvc71mDU9/OnEdtDObdTwXfg4Vf73JVskdHAi/QSgPRpif+EgzFqRbirbnuFOlb3x
         pz3L5iiatMEJ6yT8NeimzsQ7J2LYTpt5lp9l+mxEy2E1fIX9vzG1ZgDptuOYzgCPQFe2
         EYcQO5bS5gxOD+tuz5qoYiFE/SuwnGxfDCuKTR2iGxTEVNbzs3XZZeXoSMeYtwrAcHkU
         Fg5v0GEm8SaQuuG1SfuEICRpHnX6R4KzU4LROTQDupY+rhBLN2lZTgAgZZgXHqaHTbNn
         C/gIe4AykST+T9ZX1vJgORGGDTn0oxmg1NtcFUfhs4qOaAWZyFS64rC4pU0N580drvfl
         Kztw==
X-Gm-Message-State: AOAM530NaWRQENU8A+4kZurSt+xBBQGllmHLc61aHBsMrj1QNRFkx6ne
        9J7FvrWHBLfj1dK9tDy/KQ3uaR+X+dL+Hw==
X-Google-Smtp-Source: ABdhPJwK/gdxNbR5wcwzCjZbJ0uPzi5O3qeN6FpU1jS1wRJBjccxbWHo8LB3JeEZkNOTKlhLjf7S3g==
X-Received: by 2002:a05:6000:18a8:b0:20a:8a52:5c7e with SMTP id b8-20020a05600018a800b0020a8a525c7emr17783246wri.355.1650962907085;
        Tue, 26 Apr 2022 01:48:27 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d64ed000000b0020a9e488976sm11890834wri.25.2022.04.26.01.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:48:26 -0700 (PDT)
Message-ID: <60b73431-ea41-bcca-8374-1836488b399c@gmail.com>
Date:   Tue, 26 Apr 2022 10:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: Signed-off-by missing for commit in the mediatek tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220426080706.26c6816b@canb.auug.org.au>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220426080706.26c6816b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 26/04/2022 00:07, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>    775ef8aaa66e ("arm64: dts: mediatek: align thermal zone node names with dtschema")
>    c8b8db1a173d ("arm64: dts: mediatek: align operating-points table name with dtschema")
>    c01d9aa630b8 ("arm64: dts: mediatek: mt8183: align Google CROS EC PWM node name with dtschema")
>    75a3c81bc634 ("arm64: dts: hisilicon: align 'freq-table-hz' with dtschema in UFS")
> 
> are missing a Signed-off-by from their committer.
> 

These patches are taken by Krysztof and merge into my tree via a tag [1] to 
avoid any conflicts. Please let me know if there is anything I need to do to fix 
this problem.

Regards,
Matthias

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=for-v5.19/arm-dts64-cleanups
