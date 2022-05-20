Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A740E52F596
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353871AbiETWSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245429AbiETWSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:18:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3571A166D4E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:18:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so12601382pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ppqA1V71Dip/w0SDRJr0n7SLy4Hy4OPoqjHQOx+tb1w=;
        b=RAU9fAtoYg44KWOfDd5AD8kQea342PUXf80S3LNyTJcnLvleWgVC8+ipOjZafWawXd
         HnotSYVty/ibTqhp+GKUwJ7nOwi22ObOyMdYnykGlnyHcC11RnY5TPJ5c2C8cM1ter2z
         mi2bSkOsYplAGvpUTkciI+BXFGYttZUEeZ1uRckqCWJ8gk9E6zzz8He0jph0vT50awPV
         DoGJft5PebpUz7wCdS40EHnqm7hRXd8xuDJFzLgzVmZD/TlQ5iCZVGAQO9Kj/3hUjtd7
         6Srv9u1r/8R0NcnZOgU4gIhJMnfzjTmek4P2Z2AVpiZg4j1rM4fFho07NQoQzcUIX7Fi
         bskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ppqA1V71Dip/w0SDRJr0n7SLy4Hy4OPoqjHQOx+tb1w=;
        b=sgL2nwSQA7ym7JNYEpiRQ9MTkfK4aLKJbTjNXkE914FEUaFMWBzWqjX/vfwj5i6dba
         eRqpkDkkGSUoZPfUppyRLdTkkMvRZk+aLnlhvoDSJmPmSXh0O2y+Rh/OfEkuqC4je5xQ
         Ia6hKul/ZJaBZIisRu0uUSGkw/1Phh22hC4BSj6z4tEp5Sogl59Z+4bCUbtOHspSj1Mg
         K21WXwDEKG1gQ4QQFuS47n7vDGP+Fa1K39LzI3n7T6LajVfgH9GB3AozmeZ3dF2+3CY2
         ZD1t+TNg7mY+ubGvCgMtZNxj0VIZKAjHQCDh5RZGwQTJVwQ3TKPPj5oJdQiR2OGPCUN5
         kJcQ==
X-Gm-Message-State: AOAM531thndfzaEXOfC9GY4VrJA/to7DS4vTf3fgTHUfpjGgFediyD1j
        IQAUtAQCIxWMIiZsIJweE+3kbw==
X-Google-Smtp-Source: ABdhPJwNh3Ko1yDLlYQF/0hdyJtZo7xphTsSajaIBO7hXN3XRFFS5rg0jQ6I/RsIU6d6JOX0mzuLPg==
X-Received: by 2002:a17:90a:eac5:b0:1df:7da8:4b19 with SMTP id ev5-20020a17090aeac500b001df7da84b19mr13839697pjb.2.1653085089685;
        Fri, 20 May 2022 15:18:09 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090a7c0a00b001d95c09f877sm2376612pjf.35.2022.05.20.15.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 15:18:08 -0700 (PDT)
Message-ID: <471e5654-49d7-9023-62b4-fc98483b1d89@kernel.dk>
Date:   Fri, 20 May 2022 16:18:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] fs: prefer read_iter over read and write_iter over write
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220520135103.166972-1-Jason@zx2c4.com>
 <39ed6917f2e64a07bad8dad63f8dceb4@AcuMS.aculab.com>
 <YogIg9FG7C/f98bf@zx2c4.com>
 <0da16e16caed4282ae97a86f1ba6f6db@AcuMS.aculab.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0da16e16caed4282ae97a86f1ba6f6db@AcuMS.aculab.com>
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

On 5/20/22 4:08 PM, David Laight wrote:
>>    https://lore.kernel.org/lkml/Yoey+FOYO69lS5qP@zx2c4.com/
>>
>> The hope is that it eventually becomes faster... :-\
> 
> I suspect all the xxx_iter functions need optimising for
> the common case of a single buffer in userspace.
> 
> That also includes the code to read the iov[] from usespace.
> At the moment I think the 32bit compat code is actually
> faster than the native amd64 version!
> I've written some patches to speed that up.
> But the bigger improvements all hit massive changes
> to the ioring code.

Do you have a link to those patches? I can certainly help with the
io_uring side of things, and I have a genuine interest in improving the
core and getting the iter side up to snuff.

-- 
Jens Axboe

