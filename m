Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6784C5F30
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 22:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiB0VxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 16:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiB0VxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:53:19 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F073DA79
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 13:52:41 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l9so8669476pls.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=KELxwpE6zsT2Sd3VaKEod57TJwPwVugZyJqtCDvL28E=;
        b=xTG8nK5H6qwycXEKjmelhk9G1F46HO/f0zI426KHXciCpZEghM6+Lw38sThzSOhqic
         9UJxPh/V/cgNsVH6BrEuu658Mj62JZmCgdZUQd3XFt9sn1RWdyvijVMFF7A4uVFyc9el
         V03MNJNvP12XZcOP1Y/KK2+qimtrsrw1pnwQA4nfO5AltiOB+CjsZFqMQKHlSiEW5DPS
         FPTtmNB8x/yEK3uzDN/wg7zTFZ5dlZo738hSOyr74Jk5OTxdoIqP0ZC2gFZi0sTyh2rg
         VAHI6JlE8wD9XujjzMK8jX8QhjFT+a+quJEdwnAaG//iQ2/DpfOk2ktk6FajcfjyMA9z
         mdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=KELxwpE6zsT2Sd3VaKEod57TJwPwVugZyJqtCDvL28E=;
        b=vuRDcxNkVh0iSTDH2Dn9ZtzqbH0D4Np6Rscj4SFB70Jfjtw520iEXQwWnbiccAD2cm
         Xl4vpFxLrIsp6AVzmeP9jRLiiRJRjBs86O4ZdLDZt5JPXsxcP56jW5+dpPVSfiKL/Apw
         gkBEmlB2J7K5LCiNehvpxyBPRaqZR7CqzePHkUMi0eyI4X8qjb4CHoveR1717UWYvsTw
         XDAkIlY13orMK7NUzaMa0GmhiDImwdfEXf64VUuOZ6swyTfPVhLuxyhgSAYel761rPJL
         HeEBIKtNaxBodMH8cUYct+93JQsX5QZdj/7EAlTeXmOTcbYSHfDwlFjsGd+cgagnf2ox
         y3Vw==
X-Gm-Message-State: AOAM532YS681Hj6HDDwJxk4wNA/7GfZr0b0+YJgJUM5Gv5bNQ75An58B
        IHiY9LHJAbEXtYwRVPzAT4Pc6Q==
X-Google-Smtp-Source: ABdhPJyINlHZicR+tKM59zWkHp5XFpvt6CfTxWUnjh8T8J9AnNvQMNiAURBFRwYfW6tVlPU6dV8QLg==
X-Received: by 2002:a17:90a:8e85:b0:1bc:429b:513d with SMTP id f5-20020a17090a8e8500b001bc429b513dmr13616893pjo.11.1645998760999;
        Sun, 27 Feb 2022 13:52:40 -0800 (PST)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a16-20020a056a000c9000b004f0f8babedfsm10597368pfv.29.2022.02.27.13.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 13:52:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Nian Yanchuan <yanchuan@nfschina.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220227170124.GA14658@localhost.localdomain>
References: <20220227170124.GA14658@localhost.localdomain>
Subject: Re: [PATCH] block: remove redundant semicolon
Message-Id: <164599876007.130939.6014751551631014564.b4-ty@kernel.dk>
Date:   Sun, 27 Feb 2022 14:52:40 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 01:01:24 +0800, Nian Yanchuan wrote:
> Remove redundant semicolon from block/bdev.c
> 
> 

Applied, thanks!

[1/1] block: remove redundant semicolon
      commit: 483546c11d702fd6f74c8c3f8123b7672def10b2

Best regards,
-- 
Jens Axboe


