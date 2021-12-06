Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631F2469064
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbhLFGcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbhLFGcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:32:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BAEC0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 22:28:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 332B661160
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 06:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFC2C341C2;
        Mon,  6 Dec 2021 06:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638772120;
        bh=qnDbwA/2TIM12cv9RoIY2yw8Nptbxe+VufGW5sVZO4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=Z9I5WPrK7kSd9WXO+Bte5q6zD5oa8wxT9Tl+vI+yNJBqQ07zLQygnKqWWCEJxsgIS
         w5ipHogYHTT5LsbUu+qyJSEu1cNhHKz2yT7rMUqCtSqPHOk4AcBapK9igMFQnA70Sr
         QSsCb062FwrPXhv9ZkoTM6NArQWNjT85njFiL3GbANe7kxWkGrrgrEkobJVn0797aQ
         vkhnhkxLeFAZ19YnckLVDtHU6MQImhGXxLeHsKbTBtcbdLRXOgP0aSaVlt154jBxqj
         vdIum74tlcLAAi8FtlSTqgzaiGfepXdtu3CiMIoHpHwxCp9dKRLYZwEpDap9jmxWpm
         msEmNkat9d/5Q==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RESEND MERGE REQUEST] mm/damon: move damon_rand() definition into damon.h
Date:   Mon,  6 Dec 2021 06:28:36 +0000
Message-Id: <20211206062836.4497-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <9a887fbb-ab0f-8297-9516-1e7bef508249@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Mon, 6 Dec 2021 13:20:02 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Hi park:
> 
>      Are you fixing this potential bug? If not, I am willing to modify, 
> i will send a fixed patch ？

I couldn't find a time slot for this yet.  It would be great if you could send
a patch.


Thanks,
SJ

> 
> -- 
> Best Regards!
> Xin Hao
> 
