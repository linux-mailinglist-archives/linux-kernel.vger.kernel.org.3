Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20351F5D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiEIHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiEIHs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:48:29 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66770187044
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:44:36 -0700 (PDT)
Received: from [192.168.88.87] (unknown [180.242.99.67])
        by gnuweeb.org (Postfix) with ESMTPSA id C62447E7F6;
        Mon,  9 May 2022 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1652081673;
        bh=27DTnJK3MypWLfzhHvPUFGb6x05+cT0J+g+6ZaU1ufU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OnzokGKowQtI8z4oKSGYLk9NjdqW2WHuJQ7mDk+Ojhcx/Oz3SHw8Anm9G0w8cHQRt
         X95t/K1kEqopR0dniBUB+97SeVdO94f++HmLlLK/c9biQHChCwIhXKPQGL+idChWg8
         5xhsvRoB17O6ceJCZ0/yiJItsDQNrGbWmJeFjoQ9zW4Y+eVWcrgvb3AGWGC8HK/7XQ
         rRHuKl/t1gUrjltGej+Nsk8f1ZhBxoyWs7uRFdmU1QG1g90fqhe2+zAeFXiimvH2bM
         ToPBilhYLWpWeAQ6Sa+7dXYAMedCAsZO/Pd7EJTELCuw3pHcFyCM9qNPGKrBfu+dEL
         c4nu/47vPlAqQ==
Message-ID: <6689f8e3-b61b-9bb1-0334-a3e5f52df450@gnuweeb.org>
Date:   Mon, 9 May 2022 14:34:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] tracing: Fix possible crash in ftrace_free_ftrace_ops()
Content-Language: en-US
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220508161827.1014186-1-xiehuan09@gmail.com>
 <CAEr6+EC+Kg4AJ=BFxrOSQV+KHj5WSm=1FtYCAPrn1gFnZUk-fg@mail.gmail.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <CAEr6+EC+Kg4AJ=BFxrOSQV+KHj5WSm=1FtYCAPrn1gFnZUk-fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 8:33 AM, Jeff Xie wrote:
> I am so sorry to bother you, this may be an invalid patch, kfree can
> return directly from null. ;-)

Yeah, kfree(NULL) is a valid call. There's no potential crash here.

-- 
Ammar Faizi
