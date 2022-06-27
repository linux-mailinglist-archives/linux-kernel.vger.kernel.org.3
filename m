Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1355E361
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiF0MLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiF0MLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:11:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6ACD129
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:11:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id h23so18651990ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C3KL/sYPaJbDkn8gHvUu80xf6BHf0wMPSq7pgt2dfq4=;
        b=pKEwEnLEh8eqTkxHzxxMwYACs1ZSGTH5+wEp9YlifpBiyk69QxOsm0mfCb0/1Ya20f
         M6WIuZaXX1CT47L2Vf+JZGLNmbP2UKH+lfLAAZI7/pfli1Jzf/Kpk093ITmcNLIwwwHg
         3K/coyY0CPCy45hA5P04xwlclE1EW0HaPQfHboyYOyVl0O18seEg3KcqiaJAMPw8341u
         cdawriRVsEB71eokqznyk4+g4n60khejwOpfca1/nvrv1Xky5yzoeJAqX0eU29kw5gPD
         lDZl6n0pdnkSWSrEdjHuMnoAAcZ7z9yrZ7pfWf5FUGv8TfwDKvGGanfFEXAvPhaQezo9
         efQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C3KL/sYPaJbDkn8gHvUu80xf6BHf0wMPSq7pgt2dfq4=;
        b=IFKE+LEwUU1yQVzBCkDB6SIZfofi1Z7BBG3RV9VZP3s4oeIiXO1KG2ehfriSiHjuuz
         6hhLDXyawk2GyXM5uFiFF5aMnVM4ly51BHTZAiWS9eywcY/M4USXqOBx1VpIYZ5LfpMk
         YQNIWT8ZeTphNn77ZogS6ICSEBnsluU9P8L4PZhuJFw3dJ0ypmjbwXsbefBPqgR2Zjvn
         OwtYS9LBGhHzg6XEna94+dxt3nAYBkg925n9mhRPNO1FNpeI+MzY7Rodd6duOXdWY6bC
         J6MYa3LtDWPKUE+bZTqEbUkrM/4GV28D2+8NRrNJNtyNrxvOh7p8DqyslLJ4oHpgbQgt
         IpFQ==
X-Gm-Message-State: AJIora+RAD+EqNtQsFyCfw5zutc66IQuQPQ0cci4KYWNsWrn3iTPnPN1
        jOxGmK6fgox3w5mo/BrJKpRvcQ==
X-Google-Smtp-Source: AGRyM1uXHMGZ2GyrPysszA/LYuf0pD6D/mj5ICrd5hPH/m735Qkr/ACQEbCz1XcuXuY5CbJ9dSfnzg==
X-Received: by 2002:a17:907:9620:b0:722:fc5e:3259 with SMTP id gb32-20020a170907962000b00722fc5e3259mr11884062ejc.579.1656331875094;
        Mon, 27 Jun 2022 05:11:15 -0700 (PDT)
Received: from [192.168.0.249] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b12-20020a05640202cc00b004335e08d6c9sm7473365edx.33.2022.06.27.05.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 05:11:14 -0700 (PDT)
Message-ID: <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
Date:   Mon, 27 Jun 2022 14:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        s.nawrocki@samsung.com, jrdr.linux@gmail.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
 <803785ef-42b7-647c-9653-702067439ae9@linaro.org>
 <YrmYbZV4mj9d9++t@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YrmYbZV4mj9d9++t@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 13:45, Mark Brown wrote:
> On Mon, Jun 27, 2022 at 11:49:46AM +0200, Krzysztof Kozlowski wrote:
>> On 27/06/2022 11:43, Charles Keepax wrote:
>>> The conversion of the set_fmt callback to direct clock specification
>>> included a small typo, correct the affected code.
> 
>>> Fixes: 91c49199e6d6 ("ASoC: samsung: Update to use set_fmt_new callback")
> 
>> Where is this commit from? It's not in next.
> 
> 0b491c7c1b2555ef08285fd49a8567f2f9f34ff8 - if you can't find something
> search for the subject, people often get things wrong.

Finding it by subject does not solve problem with Fixes tag, that it
might be pointing to incorrect commit (e.g. rebased).

> 
>> You should put such big patchsets in your own repo (e.g. on
>> Github/Gitlab) and feed it to linux-next or at least to LKP.
> 
> The size of the patch set isn't really relevant here, the same issue can
> apply to anything that can be built in more than one configuration.
> People should of course try to do things that work but equally we
> shouldn't be putting procedural blockers in place, we have integration
> trees for a reason.

I would say that size of the patchset is a proof someone is doing bigger
work and we want the bigger work to be tested even before hitting
maintainer's tree.

My comment was not a requirement (procedural blocker) but a suggestion,
because maybe Charles was not aware that developer trees can be tested
for free.

> 
>> This way you would get build coverage... because it seems the build was
>> missing in your case.
> 
> That coverage has apparently also been missing in -next for several
> weeks.

Eh, it seems defconfigs for this old platform do not select sound, so we
rely on randconfig. :(

Best regards,
Krzysztof
