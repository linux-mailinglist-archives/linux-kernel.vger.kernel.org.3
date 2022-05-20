Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0352EBC2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349073AbiETMRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348999AbiETMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:17:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819EC5EDCA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:16:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j6so7598230pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=BD7PI/jSYLDDXhR8nM6+izXH7+9ICId6CXZTsKRbqNE=;
        b=ckq9CxBSEWsFbquFDtkNT1eWtvYCYvCxcaFNjatqqV4RF+vx0272kuGbS+NsUjv2Qz
         HmS3156aoONf1ZkMGEFFNqE7bvFzPMjb2EhhrPMxpYlPkekDW8RjVNmkZC6vxHewcr4v
         2LaCYZUIEQ8fzBtlLezaRtpw4MBoRr/uTifNjxuWdh2ouA+z2BpGk/e2GFLqICYnEv+o
         SqLqMhy2RA3JwbBzF/3T+N7dhdl4D3bT1mKCiqrESB7U/fS0qX9oMqExEUS/9jcpTxtT
         FwCCc7r/2yvpl41dV8nl+zqfyOqTW7zPL6O3spJrB0dHuMt/0fASo0GCRjrrMfmX705y
         nVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BD7PI/jSYLDDXhR8nM6+izXH7+9ICId6CXZTsKRbqNE=;
        b=h5lHBjdfQrwcHvYSLv1hhCHBS9OF44S4v3KAL0JfqseiQR4tEKBrphOYvWPItZxLsb
         QKLw/9Ny7vkBkv4YnyywF3YhOIbxJSZOlHrqBcwNdR6VjDFnlFm5pQtMsZ1KnON2frEQ
         HBO3jANCDyfDMj7lyz0V1XPcmAOxFFZn5cL9R9MONDs+JJXp6WbCM+VvbwzU2kwA8rLM
         iHELJbZ2lSgPq7HmCO/ry4EaReMWuMVzKPTZxCTtzGHnWlZYrPXdySWbgSXn2yNaINUK
         JPc5J5ZFq6eYPaoqXihCPVy6aDPsas+8/PLeapxDFpFP4lenuqKohGYpleKFPzDM+I6h
         VsOA==
X-Gm-Message-State: AOAM531nR0bhPYFr1PQE8aE22PSO7Hm2TiTg04ExHm+xGHaJo5eE4eIT
        O34Z5g9TiPQou015TuW30fcN9g==
X-Google-Smtp-Source: ABdhPJxmTpQ+umrmkBJ4xaC92Tx6GlFsh8O4+/89KUZSN141r2svsJGTg67LZdrG0P40kcHqHOxH7g==
X-Received: by 2002:aa7:86cb:0:b0:518:3e92:f78b with SMTP id h11-20020aa786cb000000b005183e92f78bmr8607795pfo.61.1653049015893;
        Fri, 20 May 2022 05:16:55 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h188-20020a6283c5000000b005183fc7c6dasm1645851pfe.5.2022.05.20.05.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 05:16:55 -0700 (PDT)
Message-ID: <f3b9131c-6561-8b31-4581-fd8ca5184d4e@kernel.dk>
Date:   Fri, 20 May 2022 06:16:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220520094459.116240-1-Jason@zx2c4.com>
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

On 5/20/22 3:44 AM, Jason A. Donenfeld wrote:
> Hi Al,
> 
> I've incorporated your suggestions into Jens' patches and simplified a
> lot of the control flow. Could you take a look at these and let me know
> if it looks sane? In particular, I'm using the property you mentioned in
> which copy_{to,from}_iter() can take a maximum and do less if the
> remaining length is too small.

FWIW, ran my (small) tests and this series looks and tests fine to me.

-- 
Jens Axboe

