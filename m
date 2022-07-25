Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3667580580
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiGYUZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiGYUZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:25:43 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619B0637B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:25:41 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g1so9583545qki.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jQ7HI45z5wixFb+/1Im4pHzErViUmi/CF5+gTInj3AE=;
        b=oqOA072L/kD87nOMc3gKe/vkv/qvVP0z8KtLLpIDVI1nhUlt9u9vM/8Kza+NEHD8WV
         CId7cKZYxhcQywmKBqKVftF223zsI+KZQEcZ0FieRSM3rEih+WvReAub29AapTxNn5sF
         kzv+rzDScT0ARSmviIiEonye1f7pEosRNcEgKVr6yQPOB+YkNTL5DUIYNtM7hXtiz3TC
         UHpwY5pyj1pGB9YV7fD7AHA2Y16v8uIKmYp/NCSiC4VYZuOKbJLQWLz8Wywm66uCZhvw
         J+bXiJTHp5UaYiqs4ZCE1LtVegqkjCmmO/ROmd6WF3qotpciJby5fOS5elY0ik5pesBy
         ozlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQ7HI45z5wixFb+/1Im4pHzErViUmi/CF5+gTInj3AE=;
        b=RDRnRQMJJngCA+UyI/50wuT2zZoWCChWrJaL6KP3uVIwHot6q5dPMNPo11q4iBuJql
         CT2ZH3C4J4FEtwWGbqYrhCX2f6gxwYfNJ8OvpBhQXCHP+M7kntvFOP2GCcwsL+ezx2tj
         npIM0fEcpLTKN6iibcZQozhHzHiskkS9ThNdEotBJhnVWiMIOYF/W3AKbJ0kx/FTKiZJ
         J1WSO03QFV/tGmmHlXtvGAwAYfVYlnag11YT+CdReImTfvIPX2rNRNXuVJlHY4DQXSiY
         kyVg6EmXBc0gF9e0vPL3VLqv9XnmpEVc2tRAboCTMMRt/a1TaJ9eOtsyiogAmw2wnZBL
         QBNw==
X-Gm-Message-State: AJIora+C30ynSVhyMHLOQ2mx8C3S49E6xtg6MT7Sh9gojad/qj8aAxqP
        cdveG3xtNZDWQ8f8mdYqhbDZig==
X-Google-Smtp-Source: AGRyM1uTG4HZVwBBzArzy/8u/TGwyAfj5s8K5Dg5PUsYAJUdOT12doKcBg3ssTXnOYySh4d4KA3L5w==
X-Received: by 2002:a05:620a:13b9:b0:6b5:f7a0:ff7a with SMTP id m25-20020a05620a13b900b006b5f7a0ff7amr10539094qki.298.1658780740285;
        Mon, 25 Jul 2022 13:25:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i10-20020a05622a08ca00b0031e9fa40c2esm7822025qte.27.2022.07.25.13.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:25:39 -0700 (PDT)
Date:   Mon, 25 Jul 2022 16:25:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     joe@perches.com, axboe@kernel.dk, yukuai3@huawei.com,
        houtao1@huawei.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2] nbd: add missing definition of pr_fmt
Message-ID: <Yt78QrEvSap5YadH@localhost.localdomain>
References: <20220723082427.3890655-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723082427.3890655-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 04:24:27PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 1243172d5894 ("nbd: use pr_err to output error message") tries
> to define pr_fmt and use short pr_err() to output error message,
> however, the definition is missed.
> 
> This patch also remove existing "nbd:" inside pr_err().
> 
> Fixes: 1243172d5894 ("nbd: use pr_err to output error message")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
