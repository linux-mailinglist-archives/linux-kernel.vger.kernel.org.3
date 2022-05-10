Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22602522023
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346810AbiEJPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347194AbiEJPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:04 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424C528B686
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:47:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z26so18934676iot.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nVSRi5wIDVHYpu1ojocgQkPMvGst2Aq+pvqCJIj4u9U=;
        b=nFOSEcSgCpgBBmL0TyKyaBVjPh73Ju0Q2KaPb7KCGh6PN1pcC8PB/DGUjucpqWozeR
         +NbJvR0+4rtIpirPaTw/xPISfWRVjDmxo4LY4zFzO4BN6rYwhbuzjCUVA8b5nZtlqpMs
         UWBGIYR978FvUWmx8cGw2nKJvy+DwAby2lp3ZPd2JDpoPnHAbIOmC/DgIpWD7Ht1uVwb
         FvaqA9sSjqBZFCwMcXeNr/sKgc7NE8sUkII2gFBGHpoqh1ytOfl4mpLYDrfi2r1uhVsK
         ZwCYb2dHYoH3p/Kib8Lj3MfG9k0DUFedUrYo1oTIf2LhQNvQc0CSaW5GQK1IFfL0xOgc
         mVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nVSRi5wIDVHYpu1ojocgQkPMvGst2Aq+pvqCJIj4u9U=;
        b=UD757SzGe1qOMk0J+V7xMFb1aZBhQJifdJ6kddGtZ1kEIzJhrrg8T+Zjn8NCEMB9cP
         befl/fuBoyBrlawcz+799ihLa8FyhjVE6owvs3NmBCbAIj52rAfQ72LT8LeozPgajUcf
         R0XDTXvYbj7/hD6MR9t7y2nT1sQ7LAKnirhA8+0THdJslpLnWTkyyl6FlNto0TtQLRB6
         v9IywgkOu0DU0WFYuiancjOiFtU0XnMt5cqhcJrcC3MKhbIOgJBXpxxyZ87wL/Dl0ihn
         n74TSAmDhntBHZmRv58ngGyB7hcyqMQ+fF/1P6glIvUH3UxT+tRNqcWD57DIsvSww/5I
         7JIQ==
X-Gm-Message-State: AOAM532G7LOqD72q0Q6Z4VoZNhzNSn0XpOGMEy9rYWgymIyLIEXVnyvD
        aNYOrJXn1Epz6s2i68Y2quafX4U2icUf1g==
X-Google-Smtp-Source: ABdhPJzJk2EhDRZC5gyjdHD0MJkfj4xYHJ2O8ogCT7cH9cIpmdxqbnx0pshNm6IQHgMhKlN5tXXIFA==
X-Received: by 2002:a05:6602:314c:b0:649:a265:72ee with SMTP id m12-20020a056602314c00b00649a26572eemr8750978ioy.100.1652197635312;
        Tue, 10 May 2022 08:47:15 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m9-20020a056638224900b0032b3a78173csm4452139jas.0.2022.05.10.08.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 08:47:14 -0700 (PDT)
Message-ID: <6e611c42-fea2-defe-80d1-e1b427d6ccc0@kernel.dk>
Date:   Tue, 10 May 2022 09:47:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH AUTOSEL 5.15 09/19] io_uring: assign non-fixed early for
 async work
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     io-uring@vger.kernel.org
References: <20220510154429.153677-1-sashal@kernel.org>
 <20220510154429.153677-9-sashal@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220510154429.153677-9-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 9:44 AM, Sasha Levin wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> [ Upstream commit a196c78b5443fc61af2c0490213b9d125482cbd1 ]
> 
> We defer file assignment to ensure that fixed files work with links
> between a direct accept/open and the links that follow it. But this has
> the side effect that normal file assignment is then not complete by the
> time that request submission has been done.
> 
> For deferred execution, if the file is a regular file, assign it when
> we do the async prep anyway.

This one should only go into 5.17-stable, not anything earlier.

-- 
Jens Axboe

