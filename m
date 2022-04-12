Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA454FCC09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiDLB5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiDLB5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:57:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B9A186E8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:55:16 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z6so20890479iot.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oBVB6OMaVmW4VIDZAaEbON7kMyciD94DEsz9UZvj85o=;
        b=QjwzsS6usi7V1XeKXWF4Vglaq7eM5rnAiKiLughIP0ghQ//qBSt6pXF8Wy65karFKN
         f5jGgz69NhX4t81wiicmvfqWge29IsgGZrbnJjrHvbdZ2WShrE8PlKzG0n6jd0SJM/Yl
         7/Ls7B7PW47llnfhBXZ/+IzbGcfA7wRwyCQ4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oBVB6OMaVmW4VIDZAaEbON7kMyciD94DEsz9UZvj85o=;
        b=l1Swg9NDBqvA48o6UH4nMVVqb6gM5u7DM7u7xaQbhxoqOfjPZ9brnipZApMy/mkPKm
         nFmUz34UJuXpcyMw6DhuJ/bRnDT3Ih83EZqFw0mLfshU9qMj+JwN3bS3kL+FVkdeAxwn
         34BDIU0ps2VY0orEt8Q6w60lWK1nNuDUvSH+HJHpJdVqN70NSlCGousAA9YzX4zJN35c
         ETTTcwZs2gCRG6VfQfhqTNHibq1hMMTWMwjbyjKXYpwB3JGhWNtaNk2TvkAscbGQLdaS
         S1aUOM4EtmPBPknf8oFqbo7zbk1QQaZHtg+5SNHcVzLHeCoibnnE16NcfXH2ryOrnulZ
         IteA==
X-Gm-Message-State: AOAM531S4gXWeb34nGQYUVf7VE8F8+REF8WMR+mXMfQb6V3mYj0vySA6
        IQJugXEn6GM2tbKqXNqexf0X+g==
X-Google-Smtp-Source: ABdhPJyr6vt6puQIS2gbji09gkrJPhnfDSc5vipjeTwUTA07rThe82vQKJkBr4KzhKq/ChbxNSs8wQ==
X-Received: by 2002:a05:6602:2a45:b0:648:b21c:6f49 with SMTP id k5-20020a0566022a4500b00648b21c6f49mr14820942iov.206.1649728516198;
        Mon, 11 Apr 2022 18:55:16 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id a2-20020a5d9ec2000000b00645ab33390dsm21121751ioe.9.2022.04.11.18.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 18:55:15 -0700 (PDT)
Message-ID: <9c3bdbce-e898-696b-b645-6e566faffa85@ieee.org>
Date:   Mon, 11 Apr 2022 20:55:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/2] staging: greybus: fix warnings reported by checkpatch
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <cover.1649712572.git.jhpark1013@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <cover.1649712572.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 8:50 PM, Jaehee Park wrote:
> The first patch corrects a typo in a comment. The second patch fixes
> 'void function return statements are not generally useful' warning.
> 
> Jaehee Park (2):
>    staging: greybus: correct typo in comment 'Atleast' to 'At least'
>    staging: greybus: remove return in an empty void function
> 
>   drivers/staging/greybus/arche-apb-ctrl.c | 2 +-
>   drivers/staging/greybus/audio_codec.c    | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 

These are really trivial patches.  Whether the second
one is even worth changing is questionable (it represents
"code churn" without really adding value).

That said, you've properly submitted the patches and I
have no problem with either one.  So someone else can
object, but if they do not:

Reviewed-by: Alex Elder <elder@linaro.org>
