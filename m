Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55163488B61
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiAIRhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAIRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:37:18 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB89C061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 09:37:18 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id 2so5236036ilj.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=bODOj2iY3281uNiwPt+MJVU4a89V+UJ+UJjJJrO9Fss=;
        b=2jUIhvux0YeD6RwsfY9TYfiTTCrZC/XkWBXPY6d4SSwtcWoudBsnmtW77Zo8j81Byv
         M8XhUvHBQ7mEe4C1J8+ZKq2ow/tSXRsPgmfb0WHkksx8+YMZv4kbgmE/WreyNqdwf9W3
         EzYpWN+PCl1usIO0RX5fwDQvohttuTUKY+9yq0t/D5s2zpzPtuW5sjnxiVS7SGkJR+5x
         RqPS7AjuNrbPc+U0kMY6YmLxfNRoiFD/0CSFoU6wE9JBOFgemm9JAUwJa0m5bUgocD98
         Nr6iwQs1GxG2+Bc0U3Yb0iycZ7stWNSSNHcTZfZ7XF4wal6YY29N2gQkIVKGyMCMiqhV
         q8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=bODOj2iY3281uNiwPt+MJVU4a89V+UJ+UJjJJrO9Fss=;
        b=7euSoQvByJMiS6LKj8AFm7g7jeJh+euLmbnGSOeZFdPZG6tkf1deANcU/pDbShJlfu
         8/p7MkEpo9G41oxrZp38gPXf8cr7PCVoBqg9P8MNzqpDT4uQS/Avrqm+MEwnsp8dxoJt
         hkDQiTla4hlwRbLsJg7DCpwLlk3xZ/OW42EC7N9DIY2DYv5tLlYi9IEriCQtjSk3HHrD
         Oo7ezMkt1gtT4ww4BuYc20WY0hgVmxmlze6Ul4VBwq24nd0sy0sV/jdJX4V+EDgqgvFT
         Fd4gaaRbLsXsMD9e294qFLxl1ZNkJwFWjUGaNyHTl0BlMrjIDkbhajCWCKTBVkaCe4z3
         G6GQ==
X-Gm-Message-State: AOAM532D3ng86TLPNLSOOzuEGWdhpzdkQB3m8pBgKYIUztOE4/Rr82nF
        GDbVmUPrbMIyZCIlKLOPF6QABBd6ZYEm8g==
X-Google-Smtp-Source: ABdhPJzhgT9GoDuxD82LpzWq8JlymoPqHojM6SncquisHWWAsIZsqGdPvlwlCE6um9UeCQbTaZ44VA==
X-Received: by 2002:a92:de0a:: with SMTP id x10mr3078309ilm.309.1641749837966;
        Sun, 09 Jan 2022 09:37:17 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g5sm2991212iok.52.2022.01.09.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 09:37:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220107005228.103927-1-yang.lee@linux.alibaba.com>
References: <20220107005228.103927-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] block: fix old-style declaration
Message-Id: <164174983619.77550.9171818584702975669.b4-ty@kernel.dk>
Date:   Sun, 09 Jan 2022 10:37:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 08:52:28 +0800, Yang Li wrote:
> Move the 'inline' keyword to the front of 'void'.
> 
> Remove a warning found by clang(make W=1 LLVM=1)
> ./include/linux/blk-mq.h:259:1: warning: ‘inline’ is not at beginning of
> declaration
> 
> 
> [...]

Applied, thanks!

[1/1] block: fix old-style declaration
      commit: 292c33c95defd0b814fec1fc8cd60d16556cf7b8

Best regards,
-- 
Jens Axboe


