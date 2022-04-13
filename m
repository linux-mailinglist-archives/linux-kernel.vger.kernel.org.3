Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BA04FFFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiDMUbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiDMUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:30:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14F83B0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:28:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o2so5539179lfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YogmsT3U/7IiGgtRupJ7l2JCvP07NCmlPwoFX7KDPtY=;
        b=BPo2dFn3g3Gh2JwBI11FdGs4x3mRiOExHJeQ0r5erW9MSIGbZjN8Th2c967Kx/7qf0
         5OXeYO3hDq6ZNvj20Gn+M66UP5whLZ7SNR3PT65RWwnPevdzMu8a4w12cMx99fkiyn86
         c86oP1HLwUiOvcm0css861ol8AmuTSxmsvPXd5tnG5VaFF720ge3kMgxvcvyXbVyLC2g
         AB9k2hJg6PAr5dKeHZybm1kcabwcp+wLYNh/hJzN6yTiUeLjNKrttW5A2KVS0E/7eiF+
         nH3hdggmgHb4XfAU0BEPLAwmvhXclpiHl+ex4n5v3iAjbJ5z6ZUmQfywc3dd7fCBEzaf
         lkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YogmsT3U/7IiGgtRupJ7l2JCvP07NCmlPwoFX7KDPtY=;
        b=NJH7IDUfQJWJQIP/raof3vb3vYJ9++Ij26eiPfyFFLKY7kNYj8jdvDC5yeKvluKuWv
         XKCFyOqN8jagqTl4glCnvI0kqdJWIDBr2dLkGa+ELGwc0BTkL+RBjXq1vbderwLQX7tl
         Mky0OzA6wUx9XWrsoBFLz8jmFBKtfFKJPwFm/v52IfPEueXHuzVrUTS+A4IRhOklMduy
         b0Xw8pz48GoPHWRkEoyuDSalZIAYIzQzOzzYlritqBCihrv3VaxIw0r34aiB/C1y4n/y
         y2Wh4/ffd0poHM7Osi5SyYHBr2sOnRJyr8kiXzTfXgLb1RzyRc+An4IvTPNAXpSNoKP1
         1u2g==
X-Gm-Message-State: AOAM532QdjrnqVY3lS3kuebMKWhjAEkeAqsEXZyG8iVHqjXrowaocwEU
        hpXiDQX7NlsJWBVCs4vpoGs=
X-Google-Smtp-Source: ABdhPJx0JXqvqpQqiCaSHmJ/9FmujTfxUUTysOB33UP0zQiaykp3WYA8RUFbyQijMt5X0AQ8Snm2IQ==
X-Received: by 2002:a05:6512:131d:b0:464:f4f7:1b2d with SMTP id x29-20020a056512131d00b00464f4f71b2dmr21530767lfu.143.1649881712569;
        Wed, 13 Apr 2022 13:28:32 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id 26-20020ac24d5a000000b0046ba2c20d79sm1405438lfp.206.2022.04.13.13.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 13:28:32 -0700 (PDT)
Message-ID: <2eab9c9e-7e56-9920-de4d-2e53b3d7e6a1@gmail.com>
Date:   Wed, 13 Apr 2022 23:28:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/6] staging: r8188eu: remove 'added by' author comments
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>
References: <cover.1649880454.git.jhpark1013@gmail.com>
 <c0c0a0e748ad85585b65e73841d431adefe86a59.1649880454.git.jhpark1013@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <c0c0a0e748ad85585b65e73841d431adefe86a59.1649880454.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaehee,

On 4/13/22 23:11, Jaehee Park wrote:
> Author comments "Added by Albert" and "Added by Annie" are sprinkled
> through the file. Git will keep history so these comments can be
> removed from the code.
> 

these people are not in the git log, since this driver was added in 
2021. I am afraid they are not even in Larry's GH repo log.

Anyway these comments are not so useful, so patch is OK.

With regards,
Pavel Skripkin
