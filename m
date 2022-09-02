Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38B65AA4D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiIBBEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiIBBET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:04:19 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360736053B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:04:09 -0700 (PDT)
Received: from [192.168.230.80] (unknown [182.2.38.99])
        by gnuweeb.org (Postfix) with ESMTPSA id 0521180C16;
        Fri,  2 Sep 2022 01:04:05 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662080648;
        bh=iD6BOF9mCksjgGavlfU52CVCPmnjoHlzrcHJ9w8PUEA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XX42bpND97BPUf6CetCHdX9GpIRThkjhhyB1X/8xBmHSrOV9aSDKVbjl4iUZxrrih
         Timm5u/JFBQJUeDUVvRvAPqSl8G3AdkXqe5AvcvGZh8lvkqvoYp2GwYJOWIJR5LBvb
         +t7MftN/uEHiv6aT1+/uovOu5XxqYPPRl9uxqG8ERTR0v98wuWL/ZHZRxOdCvNrj4X
         SH9eBkU15CCeE9a7iLNIp/yoQCDKVuBpm12Lc7XrjfiiD9O1QLL1VBFgBhhGoctNpu
         ngdbD5OQS5WTNRIpGGsXXlbrDQmY9ClxHp8lhl+rJkczIVIpWaDRhPUjP34NheZSrU
         9pnZnAJuR8JZQ==
Message-ID: <1235e88e-c6f3-5d47-93a8-bdf275a4fc7d@gnuweeb.org>
Date:   Fri, 2 Sep 2022 08:04:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH liburing v1 00/12] Introducing t_bind_ephemeral_port()
 function
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dylan Yudaken <dylany@fb.com>,
        Facebook Kernel Team <kernel-team@fb.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220902005825.2484023-1-ammar.faizi@intel.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220902005825.2484023-1-ammar.faizi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 7:59 AM, Ammar Faizi wrote:
> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> Hi,
> 
> After discussing an intermittent bind() issue with Dylan, I decided to
> introduce a new helper function, t_bind_ephemeral_port().

Oops. Wrong address. Will resend.

-- 
Ammar Faizi
