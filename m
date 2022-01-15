Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18A48F738
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 14:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiAON6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 08:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiAON6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 08:58:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C9C061574;
        Sat, 15 Jan 2022 05:58:50 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b13so45331572edn.0;
        Sat, 15 Jan 2022 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MNIIAwZPN2WK/bRTkHTV9IygDz14rAm8Sea6YKv4518=;
        b=NuBujBfcv1KJFzIZZ68NLu3JYoGDW5MAKMgBmxEZYEzGtqdae90cZ/CYsgzxHDm/VQ
         HBnM3eQIhkT/lkuX2X5W2cw6Ai+S1LqH5D2dzx32tEJbOre/qGnKmKLhPQ5f392KW+nN
         rZ80+hRnwGpYC4S6fG47AdAvHd9fg9KQMtHL+BooOjNnwwzw9Dxk0usxAzUkVmjH7YWO
         bUK/RU8l390HX1ly7e2h9tNCUREOX23qHmL0hsG3iFGMZNrsQ6+danuvslmoarMmEUCp
         wT6bB3i4h9WY/DcsX4+ccjAq1+Ycwy0gT9tKTooEuus0llVv5+C5GksEkiI8yQ45weme
         prUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MNIIAwZPN2WK/bRTkHTV9IygDz14rAm8Sea6YKv4518=;
        b=BgrCIcXNdHC/pGuMTGiY9Br26tw0nO58kEe3axEa3+Exsh81qnyX/cFO/rbYuw5xNa
         eSpr7XgiBTvMNF6pNUMcbctyb6/vFQIxsXNls5Jn6z74Q5GiR4g7k/OjfErvR9PcfbaD
         YIbBzFPqQzCD8XXtpv4u1nnl/7lyRLRFOxD2Yo6Pe2gQ8GuodcQ27bYesKIsWWkD1MYQ
         o1Lco+wSOkARl9oi0/47XBHk3F9sEDK0PAjWDBoDpVQ358VYMqlugSaxlkOSjy6ZPTQt
         yI/mAIhxNIsS4zEfL10a57XMOXZd8LqA8El21Wok9NNiQ9RcsjHV1AdVep4ZuE3LKTX9
         dWkw==
X-Gm-Message-State: AOAM5339htQHLbY/cj1vTjTqAgXyH36c/PsBwSelgf8sMhdXA7BRvNCa
        BQ4IPmbFP64gDBrKUqUz+3aO/83pyeU=
X-Google-Smtp-Source: ABdhPJxoHKhgNSogvFF3KBWdCDZxLJbgDfDInFO2FBmO5cm08+L1VxSquUGOdmsKoABAGkXZ7wvBjw==
X-Received: by 2002:a17:907:7e9e:: with SMTP id qb30mr10377494ejc.279.1642255129071;
        Sat, 15 Jan 2022 05:58:49 -0800 (PST)
Received: from ?IPv6:2a00:a040:197:458f:2395:a31f:2f8b:a545? ([2a00:a040:197:458f:2395:a31f:2f8b:a545])
        by smtp.gmail.com with ESMTPSA id g21sm3338556edt.12.2022.01.15.05.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 05:58:48 -0800 (PST)
Subject: Re: [PATCH 0/2] kconfig: Improve comment blocks in the .config file
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211213100043.45645-1-arielmarcovitch@gmail.com>
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
Message-ID: <343788ac-41bc-4308-6aae-03a00535e9f3@gmail.com>
Date:   Sat, 15 Jan 2022 15:58:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213100043.45645-1-arielmarcovitch@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping (would really like some feedback :) )

On 13/12/2021 12:00, Ariel Marcovitch wrote:
> Hi there!
>
> This series attempts to make the .config file format make more sense.
> Currently menuconfig blocks look exactly like regular configs while
> comment blocks look almost exactly like menu blocks.
>
> The first patch makes menuconfig blocks look the same as menu blocks.
>
> The second makes comment blocks look different than menu blocks.
>
> The format for comment blocks in the second patch is a suggestion. I
> realize some people will think the '###' prefix is distasteful. I'm open
> to other options as well, I just couldn't think of a better option that
> starts with '#', looks different from a menu and can't be confused with
> a disabled config.
>
> Ariel Marcovitch (2):
>    kconfig: Show menuconfigs as menus in the .config file
>    kconfig: Make comments look different than menus in .config
>
>   scripts/kconfig/confdata.c | 34 +++++++++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 11 deletions(-)
>
>
> base-commit: e06a61a89ccd3edda046c78f9d08aa045b8c4d32
