Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA73F4EDADD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbiCaNuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiCaNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:50:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3CD10CF12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:48:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q19so20031131pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WIjS4hHkncWnADQSguPcZ9yDRhMIIgfXbDG/5koXL+M=;
        b=8JdtJA3KoB9+DGVHgZEvfjxJgMQB8AJ3+FSa/hLLh59tuXtTzMTYqls626HhE0Xx60
         M8oCxHsUeiyFnCM6zqv7RaiC1o3cURHKKd8TiUDajJIKwDH91uIAhjAWsRucpfdjRjaL
         MNyNzgTZVBriuzx0dA4ay60uAVu43DYTvPKr2G0XVXQ8KissoueE1rxxZFNyFbs4ES5/
         j4bv8lJfqwpnH0vwKGlzFRvcN1mAMxs4MPKKIb6qB3gRrEdaWRmCGB31IUaoOfyPhuIW
         RShLIX/p6TZP2ZhVRV6PkG5Qw+d9y/FGgpiUFEywgccI3/V+ah8sVNYNy6QbTu0k9Ed1
         DeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WIjS4hHkncWnADQSguPcZ9yDRhMIIgfXbDG/5koXL+M=;
        b=umCDcJqfEBqoi3tPZqoo2gkFoGq95tvO9yrLZoLuy5A6MJ4jTVHWbdk2jJsfXGqGzO
         xKqrgPoivomtUVHaMn1mllss67b+H3A3WDIVgGQv3ZG/re0nJpagZ1bh2FJsVxlsbx1x
         Oga3Z6gfl7hFclSgopyimdnxtG5nUkLMvDli11dxdT0pc9UErlwrIWvmJ8OY5bY4iKHO
         WJ0qzSINzab7B9rtI36BI7MJAI0y4xCMQZs3xSKipYOhI0T+6Mz6GljWZb1WoIshfF+Z
         SnTeD00ZlHlbL0YBwfVa4SsPvGAYAF9HQg0XCtzSFpAFI6zOTWxN27OhAg9hROfyFA++
         c8XQ==
X-Gm-Message-State: AOAM533rcpDe0pDneC6gPFWbvgSeKRL2UDSRzJTORHGxBWDuOsTFWMf5
        8J79/Km3MTqkQPm7xSeeLPI/fQ==
X-Google-Smtp-Source: ABdhPJx1JWwl3z3vLqKxPFPwBAUbmruyet8e5XAqvGozXt0cKP0NQz5DfjALnTIZvovc9OIbpJ01HQ==
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id bk3-20020a056a02028300b00342703e1434mr10853784pgb.74.1648734492091;
        Thu, 31 Mar 2022 06:48:12 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id lw4-20020a17090b180400b001c7327d09c3sm10037155pjb.53.2022.03.31.06.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 06:48:11 -0700 (PDT)
Message-ID: <8dbb5fc7-7170-d190-ba24-2ef13dc73623@kernel.dk>
Date:   Thu, 31 Mar 2022 07:48:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MAINTAINERS: add drbd co-maintainer
Content-Language: en-US
To:     =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org
References: <20220331134236.776524-1-christoph.boehmwalder@linbit.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220331134236.776524-1-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 7:42 AM, Christoph Böhmwalder wrote:
> In light of the recent controversy surrounding the (lack of)
> maintenance of the in-tree DRBD driver, we have decided to add myself
> as co-maintainer. This allows us to better distribute the workload and
> reduce the chance of patches getting lost.
> 
> I will be keeping an eye on the mailing list in order to ensure that all
> patches get the attention they need.

Can you go over the ones I already listed? That'd be a good start.

-- 
Jens Axboe

