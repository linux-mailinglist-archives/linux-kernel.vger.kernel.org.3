Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA944EE138
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiCaTBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiCaTB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:01:28 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C41BD821
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:59:41 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id g21so555710iom.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=AJKpCjO3bIrdj5jwaRPJiTmBZzr0mwlOsxgUl6rGmbw=;
        b=TuTRI5CCImBv0SnoqzL8kyVBO4Gzi12A/T8N+73TESZvvg86KAR0bZDtj/rslsSUwc
         nqMTC6ATPx8ZCMJ41jr2+Xz4dm1XOZy3o1Pyd1fE0nOHO1Wyry3gLM4pDShxpzJUi75+
         vROsQYNcIaY4Ol/TAxJMB6YZk1+mPhzOzzjjheztkiF3oSPMXAFiqIVgAPH9aYDiKGZw
         jUZ7PIZusx0GmJesSR9z3cvFEgUoDtT69ZGVj7xvz3o1ub0v3L0hSDa/yV2WDZeoSD27
         CiFdce8xKR5UGVPV+9ibc6oBynqDuxTL5ERLHs20DufjdbPj5Xlr9q/iBG1glNrqI9mW
         mowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=AJKpCjO3bIrdj5jwaRPJiTmBZzr0mwlOsxgUl6rGmbw=;
        b=XLsjirrLO58lp4lJRk1Rpp0s1AskkIuMB6xPq+9MRJUv53u6OJHCA+MW/fecLCiK9W
         ysKLUa6oppXJqC5vwatrYkrw8J+qcnPYnIs5pRL1X7BFjOWgCBy58E/ZLXiWHAMLdDMg
         BQkdEQycn8t80OhXhGOa+bp0wwKQNt8zOLMDYSi15dih2GmQPqVsnYYRWAPZ55CmIig3
         cjpr+hJqYxYVSRU0SHKXskbixtMWdUVSRpp5hYI7NdYJlhNmF7vL+KsdmpGuQBjKQQ5H
         lheAD0vDO7as+QCEvZUWraIcETK3hspL/WFu6PMnzdj6VxjnhgrCII7rUPqjt15dQRSV
         sjrA==
X-Gm-Message-State: AOAM530SIO58k+GhhXb8zwZyvvqvgHlKjqfhUPPVK7mLw6SUt7NeGIS9
        BOqjgVomB/YGFRpedXqblLsduGYXAePYdelX
X-Google-Smtp-Source: ABdhPJzXTE03DOQiXIxoEpnpZrfQ7YBC2mFfy9hkCkipcDwqB9ra5bQO0RH2PTMXLrcdMWK3ELtPtg==
X-Received: by 2002:a05:6602:122a:b0:649:5df1:36f0 with SMTP id z10-20020a056602122a00b006495df136f0mr14629715iot.214.1648753180239;
        Thu, 31 Mar 2022 11:59:40 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f3-20020a056e0204c300b002c9fc68d9b8sm126537ils.51.2022.03.31.11.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:59:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     trix@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220331185458.3427454-1-trix@redhat.com>
References: <20220331185458.3427454-1-trix@redhat.com>
Subject: Re: [PATCH] blk-wbt: remove wbt_track stub
Message-Id: <164875317962.302830.17951664243355363241.b4-ty@kernel.dk>
Date:   Thu, 31 Mar 2022 12:59:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 11:54:58 -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> cppcheck returns this warning
> [block/blk-wbt.h:104] -> [block/blk-wbt.c:592]:
>   (warning) Function 'wbt_track' argument order different:
>   declaration 'rq, flags, ' definition 'rqos, rq, bio'
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: remove wbt_track stub
      commit: 8d7829ebc1e48208b3c02c2a10c5f8856246033c

Best regards,
-- 
Jens Axboe


