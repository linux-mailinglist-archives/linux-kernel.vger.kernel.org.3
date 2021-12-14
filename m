Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A884473E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhLNI11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhLNI10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:27:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C00DC061574;
        Tue, 14 Dec 2021 00:27:26 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o13so30961106wrs.12;
        Tue, 14 Dec 2021 00:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2jblH9KhQQpL8C0lkL6A2hbAXOSIO8xi+0vqpzu1QYE=;
        b=pib7NEIQ7lfdZpTZQAdzTOSrF7gTi4faxWOgQF+4g+rk13vJjeMlKR8N+ozENZb26z
         cYEL3cd4/zr12SKMu8FAN7oZ+JYECyTpylF4QloXlDIJwAf7zU0p1C8akbCOXYp+F+Wc
         GdATE+Eoon8Y+dQuyxMoJcff0shXQGytD2kclhNmqsr/QWuoCug2GsPPXiHDN+Xr6q8v
         vp7fmn8LwZaEn6q8tcZ2DnPAq8aQhamUtViiyyWDnAv+6Wi6ysc9dAs1tnYyJX2p++kR
         +gCtG4pfQ2jBh6GudiI59dqlO5VOs8tX5sGJBooKRJWWllorfONbde7lengI5mwB04Nc
         FvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2jblH9KhQQpL8C0lkL6A2hbAXOSIO8xi+0vqpzu1QYE=;
        b=7bby7RWQhsA/owqfVMKbkHm+b4fuejvicfZ2vm0mySj7PzyfgjyMGFW8QtFMkTQCaj
         Sk3Qx6TNPuWWs0+d8Vm/uuE3mkx0PdPzUhkKmttq3a2J6oB0QCmWtVHXj8f9S7MlfllK
         yjXV8l6YwNtQyA4uTMq6Y94BPgfjh85zk2d43EydgOAIjZEM/vp+NFER4s8xtN3S5XTN
         Q1M/Nc4c3Y4mIoewYb+NfDTKUUvPAexUxPzanRyilAoT5NphYGEZm1A/VZ6PhkWfWMEK
         HMEqZvVGUoHBAD7DVw62HO3hEL0M3keyWUXnIGDfYNZHeWjJuDCyHTp2QrTW0QPIFh5f
         lqeA==
X-Gm-Message-State: AOAM530Gdn+2QuMsUUXqo9Iph1zfTAYHZsZ62EmQmM5or1HYQCrhMoba
        qn+uGd3riS399/OgpKK6qlXIRv8TIgk=
X-Google-Smtp-Source: ABdhPJxnyR3aIwifGdczhPiWR20GIe87NoWdnzJ88N1rL4kkpvC6aY5U9VNqXBO9h8f6q+yOloWkTQ==
X-Received: by 2002:adf:edc1:: with SMTP id v1mr4329603wro.170.1639470444816;
        Tue, 14 Dec 2021 00:27:24 -0800 (PST)
Received: from ?IPv6:2a00:a040:197:458f:48e2:2cd9:961f:501? ([2a00:a040:197:458f:48e2:2cd9:961f:501])
        by smtp.gmail.com with ESMTPSA id az27sm16268wmb.2.2021.12.14.00.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 00:27:24 -0800 (PST)
Subject: Re: [PATCH 0/2] kconfig: Improve comment blocks in the .config file
To:     Boris Kolpackov <boris@codesynthesis.com>
Cc:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211213100043.45645-1-arielmarcovitch@gmail.com>
 <boris.20211213134416@codesynthesis.com>
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
Message-ID: <599d09db-f565-fe93-0c70-809c59461ff2@gmail.com>
Date:   Tue, 14 Dec 2021 10:27:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <boris.20211213134416@codesynthesis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2021 13:47, Boris Kolpackov wrote:
> Ariel Marcovitch <arielmarcovitch@gmail.com> writes:
>
>> The format for comment blocks in the second patch is a suggestion. I
>> realize some people will think the '###' prefix is distasteful. I'm open
>> to other options as well, I just couldn't think of a better option that
>> starts with '#', looks different from a menu and can't be confused with
>> a disabled config.
> Maybe instead of decorating the comment, it makes sense to decorate
> (and improve, while at it) the menu? Something along these lines:
>
> #-
> # Foo
> #
>
> CONFIG_FOO=y
>
> # Comment.
>
> # CONFIG_BAR is not defined
>
> #
> # Foo
> #-
>
> I also don't think a command is likely to confused with disabled option.

I mean that a comment like this - "CONFIG_FOO is not defined" will be 
considered by kconfig as a config, rather than a comment. Apart from 
this theoretical case which is not really likely to happen, making a 
comment only one line and similar to other lines that start with '#' 
really decreases the visibility of these comments.

As for the other suggestions, I think a bigger change will be even 
harder for people to accept, but I will leave it to the people to decide.

Thanks for the feedback!

- Ariel Marcovitch


