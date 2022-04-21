Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80845094ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 04:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383779AbiDUCGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 22:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356530AbiDUCGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:06:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC014DEC0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:03:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g3so2766014pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QPgrNi2w5mNvZRXFxA+lI+8y0pje+b6kH+uWfsD8SlI=;
        b=ZkJ6cAgaz54vaAbIE6Sv5WRZQrebTr0OSVJxxA2aSwml+2a8Kz5yWFys5mou0BGwXq
         0tjbEEDsfj8Bc0mkCrWhNuNwgv/eIN6/UMSiKcr+3kyoAQKLKPkiBOGui+Mm8itGqKac
         cSTkX0oOIzmKUDPx5D63QSsFGioVaMlve+MWifVNj/fcHH7RL01w1LscvqFmvqAN/DYz
         fNB0QmjmUVoD0AS40yKCrJ87EkRDzSffkT7qri13UB/V0LJ8SXAUuwrYanhMs+Gw19S9
         X03y2yNkm5nzVcCxoZ0w1Wo6WYMynJF5pHrW68zSiqs095Oprx8EwHu9cb+fOLPS1o7k
         p1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QPgrNi2w5mNvZRXFxA+lI+8y0pje+b6kH+uWfsD8SlI=;
        b=KZcDDSFIos9U3DeJ5Q4Z3lvwOUoC4vfY0dLK0XXDvJ1FpMWpG6VjOqbMPZjYm0GNJC
         VLtIXeKDdQ3cEyj/eZokNHWYPjcp2b1XiKq2zSu64HfoNie0yJnHBrTWwNzDKHwjvG7l
         5qX+jsOs7KucWwBxcWbCKN/zBEERpXxKBwlRty1xq+IfFqSjlB+0CaUS+cSeHDpjJ23S
         RrrzoS032J90Q5xCe1nqztV3dKDwrK/Qtkq2zsUj3Mh11gYtXWkRHmEAlZsS0rzoUlGH
         Z0RrQqWmn1BE2l3fO9RrzkFGysq0PWjYLENxVk+7XS5x6Fw+UXmN0TSa6GJxIUaNObcC
         6vEg==
X-Gm-Message-State: AOAM531lAkr8/4KNiILbCE/fa1ecvUr2SOwPTKFpVuhyKkIbuemb4C8z
        dAlglOJcX9rx7w6jvhj0KsH7lw==
X-Google-Smtp-Source: ABdhPJwESpBpWPVsneKqhd7UCFuoEADXomx8hTe5qi1FX0kTDHi8baurZYx31bIhhVe7/IDmXLG85w==
X-Received: by 2002:a05:6a00:14c4:b0:50a:9524:67bf with SMTP id w4-20020a056a0014c400b0050a952467bfmr11545695pfu.55.1650506628264;
        Wed, 20 Apr 2022 19:03:48 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p1-20020a62ab01000000b0050acad694a3sm3799550pff.206.2022.04.20.19.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 19:03:47 -0700 (PDT)
Message-ID: <a0ee9a3e-7112-f177-2f2c-6cc9dcc3932f@kernel.dk>
Date:   Wed, 20 Apr 2022 20:03:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: linux-next: build warning after merge of the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220421120203.2102b554@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220421120203.2102b554@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 8:02 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> fs/io_uring.c: In function '__io_sqe_files_unregister':
> fs/io_uring.c:8992:13: warning: unused variable 'i' [-Wunused-variable]
>  8992 |         int i;
>       |             ^
> 
> Introduced by commit
> 
>   16b217ed7bb3 ("io_uring: store SCM state in io_fixed_file->file_ptr")

Thanks, looks like I forgot to amend. Will fix it up.

-- 
Jens Axboe

