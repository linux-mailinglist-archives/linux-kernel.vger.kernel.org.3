Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDD85835FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiG1A2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiG1A2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:28:14 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E89D51436
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:28:13 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 88D631E80D72;
        Thu, 28 Jul 2022 08:28:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VSybt8IYnz-4; Thu, 28 Jul 2022 08:28:14 +0800 (CST)
Received: from [172.30.38.102] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A6EED1E80CF5;
        Thu, 28 Jul 2022 08:28:13 +0800 (CST)
Subject: Re: [PATCH] tracing: Do PTR_ERR() after IS_ERR()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        yuzhe@nfschina.com, renyu@nfschina.com, jiaming@nfschina.com
References: <20220727153519.6697-1-liqiong@nfschina.com>
 <20220727122847.6b00e29d@rorschach.local.home>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <efce3a4c-4480-99f5-0229-a44009ebe9d8@nfschina.com>
Date:   Thu, 28 Jul 2022 08:28:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20220727122847.6b00e29d@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_20,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022年07月28日 00:28, Steven Rostedt 写道:
> On Wed, 27 Jul 2022 23:35:19 +0800
> Li Qiong <liqiong@nfschina.com> wrote:
>
>> Check IS_ERR() firstly, then do PTR_ERR().
> Why?
>
> The code is fine as is.
>
> -- Steve
>

Hi, 

It's all right, assign  PTR_ERR()  to 'ret'  anyway.
But this assignment is valid only at the "IS_ERR()" path.
Maybe it is better put "PTR_ERR()" at error path, keep the code clear.

-- 
李力琼 <13524287433>
上海市浦东新区海科路99号中科院上海高等研究院3号楼3楼

