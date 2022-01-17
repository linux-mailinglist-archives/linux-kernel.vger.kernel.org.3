Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF89491181
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbiAQV55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:57:57 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52333 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiAQV54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:57:56 -0500
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20HLvr4B047534;
        Tue, 18 Jan 2022 06:57:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Tue, 18 Jan 2022 06:57:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20HLvrkp047531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Jan 2022 06:57:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c53285e4-cbd4-5fd0-cbc9-93e2e3d3d88d@I-love.SAKURA.ne.jp>
Date:   Tue, 18 Jan 2022 06:57:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: regression: LTP isofs testcase failure - bisection fingers "loop:
 make autoclear operation asynchronous"
Content-Language: en-US
To:     Mike Galbraith <efault@gmx.de>
References: <4eb771d2b48ee94ba2e3aa8706bce8117d398e80.camel@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <4eb771d2b48ee94ba2e3aa8706bce8117d398e80.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/18 0:34, Mike Galbraith wrote:
> Greetings,
> 
> LTP's isofs testcase began failing this cycle, and bisected as below,
> which a revert then confirmed.  Full testcase output attached.
> 

Thanks for reporting.
Discussion is continued at https://lkml.kernel.org/r/cdaf1346-2885-f0da-8878-12264bd48348@I-love.SAKURA.ne.jp .
