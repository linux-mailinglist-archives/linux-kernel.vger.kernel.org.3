Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FBA4D483B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiCJNis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242632AbiCJNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:38:36 -0500
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 9AE32E40
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:37:30 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1646919450; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: References: Cc: To: To: From: From: Subject: Subject:
 MIME-Version: Date: Message-ID: Sender: Sender;
 bh=quoOdBqHe+MiRynnU2oJbvE2sJ9ayk5MN4kKgho3uZs=; b=UJhMs8eqeZJmmf6hbWKHDs6FVyhW9kA1bvrMjQt0kye8H3GrT7FIazT1z6dnv3cSiIb5o1s7
 CvGtYomaZi9iOYdcc8tlAJIcPjELPTYkkpd9YDZzzeQ8XnIvUZLleeOVIiHmXxY2GvbB9xF/
 fA0Lj7AfLjLv2sKShbMpW6TZXkM=
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6229ff19ea5f8dddb596cf71 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 10 Mar 2022 13:37:29 GMT
Sender: Michael@michaelkloos.com
Received: from [192.168.0.103] (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id ACDAF40176;
        Thu, 10 Mar 2022 13:37:27 +0000 (UTC)
Message-ID: <b10e777c-1511-519b-20bb-a682a6119132@MichaelKloos.com>
Date:   Thu, 10 Mar 2022 08:37:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] riscv: Work to remove kernel dependence on the
 M-extension
Content-Language: en-US
From:   "Michael T. Kloos" <Michael@MichaelKloos.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-08a28047-b563-41f4-b705-f27b88554f2c@palmer-mbp2014>
 <8f06a08e-c1b3-066f-bd9e-1f2d686492fa@MichaelKloos.com>
 <3db8c258-cc62-29d1-c64f-31f3c4e2aa07@MichaelKloos.com>
In-Reply-To: <3db8c258-cc62-29d1-c64f-31f3c4e2aa07@MichaelKloos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there something I can do that would help alleviate your concerns or
apprehension?

On 3/10/2022 8:22 AM, Michael T. Kloos wrote:

> Some other thoughts:
> It sounds like I am not the first person to want this feature and I
> probably won't be the last.  I created the change for my own reasons, the
> same as any other contributor.  I think we all know that I can not pull
> out some chart and say, "This many people want this and here is why."  I
> live in central Ohio and have been doing this as a hobby.  I don't even
> know anyone else who knows about systems and operating system development.
> If the justification that you are looking for is that I as some
> hypothetical developer at a major tech company is about to release a new
> RISC-V chip without M support but we want it to run Linux, I can not
> provide that answer.  It sounds a bit like some software or hardware,
> chicken or the egg anyway.  Trying to maintain my own fork if people
> start contributing patches with incompatible assembly scares me.
>      Michael
