Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A580546902B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 06:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhLFFXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 00:23:33 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41431 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhLFFXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 00:23:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UzVLSrG_1638768002;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UzVLSrG_1638768002)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Dec 2021 13:20:03 +0800
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xhao@linux.alibaba.com
References: <20211203091936.19804-1-sj@kernel.org>
Subject: Re: [PATCH RESEND MERGE REQUEST] mm/damon: move damon_rand()
 definition into damon.h
Reply-To: xhao@linux.alibaba.com
From:   Xin Hao <xhao@linux.alibaba.com>
Message-ID: <9a887fbb-ab0f-8297-9516-1e7bef508249@linux.alibaba.com>
Date:   Mon, 6 Dec 2021 13:20:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211203091936.19804-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi park:

     Are you fixing this potential bug? If not, I am willing to modify, 
i will send a fixed patch ？

-- 
Best Regards!
Xin Hao

