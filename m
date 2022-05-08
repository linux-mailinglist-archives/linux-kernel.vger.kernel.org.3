Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F1751F212
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 01:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiEHXnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 19:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiEHXnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 19:43:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3FF9FEE
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 16:39:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i24so10824983pfa.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Fk9q2wfMTU5E0RXXO2TYgguLljwQ6xqMwEk6TDsdlU=;
        b=wY3J39TPH39dOxnwLSzrS/92AyWzYfqZpW2VUeWFYChy6h2i1JZT9Imd9TNmAn75cJ
         bwXaMix/3uigiF1YkTMA5Q419t2mS4f/5PsSVD8u3VftrI++rOLNvmIp61sqZnMC5ESX
         KGmYS0T7/Q0q3EeOCSmkBE1cMrPM2hE91glin3Vzo8B5kSIm1PjDGD2WoeoPqwh93E6c
         x4mV8p8e0wIuBavS20Tniv1H7KL1/0os+kBTkq4iWVbZ41QMS2wWBhdh4Dfmp8Avk8zW
         y/Cj74FzBJYZC96wKCJc/wBStmUwcVIy5UBfxRxZIsorwwTvgkwwskrcEmPtN6B/LB+H
         yhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Fk9q2wfMTU5E0RXXO2TYgguLljwQ6xqMwEk6TDsdlU=;
        b=MG8Io08SYY7aq+BZLkuWunde7+VQfykCA7iDl+CjnZ/Uaihib32d88DkkdszbnUX5S
         8hny3HxnTERNxBra6juacsAXhsOBl7Fiv3tYd67P3czz5wQJyRkfSO7MigK26uzxGZ7N
         oIBLiLVcaUsj3VMwPFZsiAh0Vtobz8AemnA2IMR7btMJ8klYZI0mdefN/tMS+oFBBPyf
         K6gF83rigJyEzSJCENKfhq+tCnG8E0iuAWppp8Kx09fm6/5SYRcBCYtmRDgXlT1oYJ3n
         IbvR5XUTfQO+UnPoAaChxmUPlS1tGj7vik3jExFqka+h91aWq08icm9Jfu4lVHp/+Z1P
         y45g==
X-Gm-Message-State: AOAM530LkPRekQdOopgo1fBqo03oP9bol/Lxi7x38BF9NJ993hP2VKfu
        wUmTQukWNCnu9WoH3dRVJJMVdg==
X-Google-Smtp-Source: ABdhPJyptYpvZmOl7i/ADERhsb3D3uvcKnTFigv/RxTHQ8pSCp7y+lltJmAHuLhY8s0FDPMd2Og6+Q==
X-Received: by 2002:a65:6e0d:0:b0:3c6:12af:15b4 with SMTP id bd13-20020a656e0d000000b003c612af15b4mr11094141pgb.338.1652053183261;
        Sun, 08 May 2022 16:39:43 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b0015e8d4eb1f0sm5639687plt.58.2022.05.08.16.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 16:39:42 -0700 (PDT)
Message-ID: <1e4264e6-55ed-7681-0aff-ce1dd9d6fd9a@kernel.dk>
Date:   Sun, 8 May 2022 17:39:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] relay: remove redundant assignment to pointer buf
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-kernel@vger.kernel.org
References: <20220508212152.58753-1-colin.i.king@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220508212152.58753-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/22 3:21 PM, Colin Ian King wrote:
> Pointer buf is being assigned a value that is not being read, buf
> is being re-assigned in the next starement. The assignment is
> redundant and can be removed.
> 
> Cleans up clang scan build warning:
> kernel/relay.c:443:8: warning: Although the value stored to 'buf' is
> used in the enclosing expression, the value is never actually read
> from 'buf' [deadcode.DeadStores]

Andrew, I'm assuming you'll pick this up?

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

