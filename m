Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8045B51FD5B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiEIMtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiEIMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:49:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E52284938
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:45:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n10so1972237pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ar2Vj24oKrFskuk8K65yXVdl6lIbOLvc0eVWOcD6t+c=;
        b=nnWuCyCgeU00gREk1DyCY05rHLgGLZ/rT9oZPgiZAo7Q+lB+LRyfUfW3eOYoImFpnY
         5HDPar0WbvEBHKvkHcZ0JGwuSrCRY1XkNLunyMFXBal2ElodsHTcSYkc8hsOZE6CBz/p
         KnXlRxU2KL5Lw/Sg+bXWAqqrGHBT2l8pq1x7g5pHKBK9TiHMcC10yt8N3Jm7WeaFGvEV
         0A/ptu7xszFMVk8w3PmZxtdUVwRKvEmfIUjmc8PuUg05uQ3Pa+W8eKWepaZMz0k+IJM5
         +Yo28iIe5NMhW5SFxZ+JE4hWWTT39sa89nUB+SjTmYSW0S5VNlpMbGkIgiNvgTNpQh3q
         KNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ar2Vj24oKrFskuk8K65yXVdl6lIbOLvc0eVWOcD6t+c=;
        b=jTSiJ4hPfcLOkUJZdPgWi04UosTenHB0jUMTcNcnXpdNhcyv8FUukq3mG2j995iI27
         OvocSqTNo5JTK+R1xfu1svDuonA0DQ6VrXdn/S4+JD5AEyRh5ZtsN5hp23NfE5RSOhiY
         Qsi2GUErfZut/RbXALlNOFldOl5RSswNzhwZKbieWbCHacS7i383/VlKBXhPb4Id+zvZ
         yyOUjxeA4ZS96Dh8+R0OvIClmK7Iyotuz+O5NiCwDpkQnZZ3duOIPZBEL7ZGGKAZYztg
         36/BuNlguHoflboZ7KcS2YjePLBQN93b5XBZDnV5zHZsxWszQVBYpN24Pv8vJsOwPzRv
         mzuA==
X-Gm-Message-State: AOAM533UflQfZsM0Fn3zufqL1gFwzj+4q0nuYRwKes+snEPqQECwo2BU
        eSz+rS1BsUHxxV/gOeqnzUzlfw==
X-Google-Smtp-Source: ABdhPJzC+TQUxUOojLESFYPuEi0T3KKewg2ciEREu5Jl/wvbgjtQHHIfnvoI9tdvGUfpFXsF1oS6sQ==
X-Received: by 2002:a17:902:ec8a:b0:15e:967b:f928 with SMTP id x10-20020a170902ec8a00b0015e967bf928mr16511860plg.133.1652100334928;
        Mon, 09 May 2022 05:45:34 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id q3-20020a656243000000b003c14af5062asm8398023pgv.66.2022.05.09.05.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 05:45:34 -0700 (PDT)
Message-ID: <9d51e5fc-6ab1-84e0-9956-8a084e0d2110@bytedance.com>
Date:   Mon, 9 May 2022 20:41:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] nvme: enable smart AEN
Content-Language: en-US
To:     kbusch@kernel.org, hch@lst.de
Cc:     sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220507065026.260306-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I misunderstand OAES[7:0], only the first patch "nvme: introduce 
bit 5 of smart critical warning" is available.

On 5/7/22 14:50, zhenwei pi wrote:
> Hi,
> 
> There are several changes in this series:
> - Add missing NVME_SMART_CRIT_PMR_UNRELIABLE enum type.
> - Add missing NVME_AEN_CFG_SMART_CRIT_* enum types.
> - Enable smart AEN.
> 
> zhenwei pi (3):
>    nvme: introduce bit 5 of smart critical warning
>    nvme: introduce smart bits of aen cfg
>    nvme: enable smart AEN
> 
>   drivers/nvme/host/core.c |  6 +++++-
>   include/linux/nvme.h     | 20 ++++++++++++++++----
>   2 files changed, 21 insertions(+), 5 deletions(-)
> 

-- 
zhenwei pi
