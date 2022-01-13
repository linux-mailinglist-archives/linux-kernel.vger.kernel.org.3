Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06648DE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiAMToc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiAMTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:44:29 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0B7C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:44:29 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id v6so9842134iom.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ea4P9vweLE2SQFqPi7PjYF9kIagB0cMOvz4tZQraiC4=;
        b=Nz7vkKdlw29rBglxW3mOaZDXAgpV25TK0O3qcJ0pruSaQgX8kZUAiG9gf4KaWKp2ul
         xVdxpfmUPvrTcxaw06NWcAQwceRjd+z7m/WUgX57zXsdQyQJw4rnHceBq72Gr+xumF9z
         M4cFwN/E+xeS+U5wUJ58ZdqyzDMAXvb5EG+ped+fRBYmxnfeSGCCMw7dZDEPH/3hB6qI
         MsMr1PT5PMa1Lqg2oy/RKKHN+L61DWbgLV10pDJGLVA3/X9KXa1jko5ulhyo0E++pLpm
         2YNW/5wwdHHpyR2mX5JSmp7Cpf0cbXjg3j9/k4FEW5WE2g5pw+1xujQvji+x2accBNbt
         Jk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ea4P9vweLE2SQFqPi7PjYF9kIagB0cMOvz4tZQraiC4=;
        b=WLrmTLwt2U9dSzAS/hK4oHjpc5VsyVe6zyykCBtO3rnnhXKXBzp0OjZP/0ZcwHHCJ4
         g8+Mp+LDomhRNyH/y1PIvBsHz9s/QK8nw/vminbykDJypoqgffyaNCCUo2dCyy1TE/DW
         T9J8dN8QzB6nk1zPCiiaFvj88MilOziRooWFm+WOOcLvEdTZdN3kUNfbuZBNQ69aixeE
         PC+jyZm6cLSIWsFujREoLwIBVtQbMHg51l0qw00SusZyryk2J9zMdmZrRUnBQv7OqCrj
         M0o+dJsxqGuJcKEjCTqqZsurym4v4qnH4rLoDJLaZlgqh5p7Z3Az3pW3wOjk4h9oJ6+o
         zjDA==
X-Gm-Message-State: AOAM532FbIcgj3VB/4UnvIx9ZizUD7P9XMfBFAUlZ56I4lE7qdLAmLQS
        IwOaKF+x0mRj18oGhf3ZTg50pg==
X-Google-Smtp-Source: ABdhPJwsNb3ZiH58suG+DB/4lvlmZ7kIYG2TRMdN1CpyrJlJk8DJUJZS5exigjqqUYyXWVvcgE2p6w==
X-Received: by 2002:a05:6602:1228:: with SMTP id z8mr2283548iot.82.1642103068589;
        Thu, 13 Jan 2022 11:44:28 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s9sm3626334ilu.3.2022.01.13.11.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 11:44:28 -0800 (PST)
Subject: Re: [PATCH] io_uring: Remove unused function req_ref_put
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220113162005.3011-1-jiapeng.chong@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <56e8a470-4141-c965-4967-dcecf480563a@kernel.dk>
Date:   Thu, 13 Jan 2022 12:44:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220113162005.3011-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/22 9:20 AM, Jiapeng Chong wrote:
> Fix the following clang warnings:
> 
> fs/io_uring.c:1195:20: warning: unused function 'req_ref_put'
> [-Wunused-function].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

This was introduced by:

aa43477b0402 ("io_uring: poll rework")

so I added a Fixes line for that. Applied, thanks.

-- 
Jens Axboe

