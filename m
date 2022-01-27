Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5549E8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiA0RUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiA0RUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:20:52 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D913C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:20:52 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id o10so3136393ilh.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iaHewaMXEmzHJ38WOmH2YhxpB8gHzlEG+ateVK/sjGY=;
        b=c770KxyDssfxz3edUgRShQUMxMkrUGm68vfXZFUdg/T4enqHy0AM2dVsxWdY3KVYJ0
         pqxDwO1fXkyRFaBIZmDbXiXcVVxGdI8npF58BnDI7LUfutnlH7Mm+KCUGGIxH2cMc931
         uspt7+Dw5y1/AzWbiRwr0oiidvt4y0UUnD+btZNo9TgUJAwPo6daj0h+gyB4XTvpYlDJ
         /sv3iQlEsjsC/iCzMPKQm+ZfRthekLmkOYO34JJc97xtwgnWHvZ75BBM75sgBM461cO7
         KU7H7Rl/4PeuO7pn45de1PN+KL2/MRORdd2bdSeHzJto2Hw0eoSvK5JGnfQkJJ8oG88R
         P3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iaHewaMXEmzHJ38WOmH2YhxpB8gHzlEG+ateVK/sjGY=;
        b=hedAf22nWhZDVKzNi9U40Y0XOcnJRoTeQwOlA9QZMCFTvOl82yHe4/j5FAcQ+Ht68U
         qOaYB7W/sU4Jr62dxk41Zwr9uIPsrtuIn1Z8qvlHPa3YPg1mYCvtVBQO+ixiWseH4RrZ
         6dDpMcbn01ZV9PzHxOXUELh/wbQD5FvYoNnysSPpN2imeJdXO26S2d3f+gaArRYcmUFD
         AdLVdxnZ53Rf4l7JuZWfa5zfIDl5a/77cHOv18C1OHEVGEIBKV59/dzlXFaVXXP4g7Jg
         tLLIzuUIu2+OAbwHUxcZgKIpvfNhJ7cW4SpjrvD9yyJm/n0sBz5StOIlwiL2QlytCQ5W
         InpA==
X-Gm-Message-State: AOAM532xqlReqSjHB8PxRM3xfzYy0wo5Ze25HfGoHiLSbWFhaB7ufwO+
        5MGB9cxE4pq/LM9n6g4TZMzPD4cjBqzB8g==
X-Google-Smtp-Source: ABdhPJz2DVVUGFXnX7N8YFu+DkilEwlVbM4nJn7TFP8KoLVRbdj2ubTE6mXZIyHfGa9jpDoxzlSZ+w==
X-Received: by 2002:a05:6e02:1a87:: with SMTP id k7mr3256323ilv.217.1643304051612;
        Thu, 27 Jan 2022 09:20:51 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s13sm11917896iln.15.2022.01.27.09.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 09:20:51 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: add bio.h to the block section
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
References: <20220127064221.1314477-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <990369e1-0868-5cd1-2f97-286c50be2cba@kernel.dk>
Date:   Thu, 27 Jan 2022 10:20:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220127064221.1314477-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 11:42 PM, Christoph Hellwig wrote:
> bio.h is pater of the block layer, so list it in the MAINTAINERS file
           ^^^^^

part?


-- 
Jens Axboe

