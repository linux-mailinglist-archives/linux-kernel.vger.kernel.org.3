Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674D74D6F53
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiCLNyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCLNyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:54:03 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F7186DD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:52:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id c11so9827754pgu.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QFxRuFIIyUtKxPUjKxAoQZpclTWWztE3frWzZ93Pv0Y=;
        b=Jx2PMS5TOmNxCI9YKroZvJkzkSoZrhxKepW/vba0EAa06XrTjPa2B6j/wtBI7yxGfV
         RdDM0ORBhdec7qEhctALqVH9dr0z9jdRyFVLT5C7VCAGMY83kYbdfo7ElLBjKAPr73QX
         Xfs07tTVcE7HlGwU2cnZwefvp1V5M0phtEm+1rRIAg1WZjCvTO4+wZS+XEp+0Jk52dDe
         oJKQvp5YRP1VpoX7uJR88MUUjc1LTgg+lvbqqeE3Y3izmKqNRQ5pkD6a6shvVzIHYh1s
         yMW/arHPJW1L3nR81zifCIH1WCGbrteEAL/uQHrlnepkJ2bE5MadXIncQlHPJmtl43fW
         9xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QFxRuFIIyUtKxPUjKxAoQZpclTWWztE3frWzZ93Pv0Y=;
        b=LIZ+bAv6JIuh1prI4uVPGOTiAQDcbWoulR8sZxZmocbdirosId2RIrZr/uZSNrNKSM
         QtmHY0txVMJpmOYoVHAZvsn9zAL1TwN48M7EgAqwV8evZv61KwCx36HbUv7B4TXOz4XY
         r7BgXzKybXzyqK1ZwkvqRWxd+FhP8noIso1sCPn3PD/LLdP40Q9kUolQlfePrdmlfAXu
         /GMCsryiUiIwjDtGzfp7N7E8frlh75ux7ZLLtp8z1B/c9nkVMJSWXT7TRJt2WZXXMQDG
         7uBm5h0JxMuvS7SZE3qw4iJKAY3IH8rvVBzXu/Bz8cXT+kDN1kT7ww3NM/ilVAecdCZD
         HFjg==
X-Gm-Message-State: AOAM531Q8OiFnPPzg8+MZb5Y3uhVrVioUgJbk/fk4FApm/UjcBMcWJfZ
        xI+uKRajd6D349QKXzzVV7mmBw==
X-Google-Smtp-Source: ABdhPJw6MPM53nxToLlEoRzxC8BU/yZdvEhZUhPouYyRygf1NBJv4KNgszzy1AtEDgdRagPBt6RWWQ==
X-Received: by 2002:a05:6a00:140c:b0:4e1:530c:edc0 with SMTP id l12-20020a056a00140c00b004e1530cedc0mr15312968pfu.18.1647093176538;
        Sat, 12 Mar 2022 05:52:56 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p186-20020a62d0c3000000b004f6fa49c4b9sm13398228pfg.218.2022.03.12.05.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 05:52:56 -0800 (PST)
Message-ID: <e217e3fe-5e9d-fc6e-a547-2ebc6db5b850@kernel.dk>
Date:   Sat, 12 Mar 2022 06:52:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [axboe-block:for-5.18/io_uring 19/25] fs/io_uring.c:4338:42-56:
 duplicated argument to && or || (fwd)
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.22.394.2203121440550.18925@hadrien>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <alpine.DEB.2.22.394.2203121440550.18925@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/22 6:41 AM, Julia Lawall wrote:
> sqe->buf_index appears twice.

Thanks, fixed up.

-- 
Jens Axboe

