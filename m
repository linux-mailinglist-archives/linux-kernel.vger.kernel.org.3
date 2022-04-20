Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F20350886F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353774AbiDTMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348748AbiDTMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:49:22 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6B3BFBE;
        Wed, 20 Apr 2022 05:46:37 -0700 (PDT)
Received: from localhost (unknown [151.68.223.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E7117378;
        Wed, 20 Apr 2022 12:46:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E7117378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650458797; bh=BgIHcvaj/KfUgAyHJOsk+OU5MNNVxfxAo3KS8RmYeZQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PSbP6DALguwm5EHOwD+FPf46VnpXKWokAPBHEZT6JTiGrfZ/cvzHvNFFqfSjfCGzv
         0LDWiacpkpBLdqZc20gNp0vpv/6QGs03hsWcQapmDdAxXfHtRRRUB68ZljI5u/lnPY
         j390tH0EOa0Uo0drO5TXJW6gA2VzotevbS4EjNPYj+2NCDHZ35/2SWlXa5mGBw5ggN
         AvmUj1rQ9XJffMJdoeNJeoaRQQ09wMpWQzEfU3KovjqkbzfHpckNZnfPPdQAz5A7D2
         E7YQ/Z/ohWp2YcnBi8Sgl5MQNjAFPSUTyaKJjBObHEjK2x2r6ZHDLyZZ4Uk7bOSX7P
         SfkG4L7ePMRpQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Haowen Bai <baihaowen@meizu.com>, siyanteng01@gmail.com
Cc:     alexs@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, seakeel@gmail.com,
        siyanteng@loongson.cn
Subject: Re: [PATCH 2/2] doc/vm/page_owner.rst: Fix table display confusion
In-Reply-To: <cbb540d1-151d-f5a0-0a24-ce2d2fba4825@gmail.com>
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com>
 <1650424016-7225-3-git-send-email-baihaowen@meizu.com>
 <cbb540d1-151d-f5a0-0a24-ce2d2fba4825@gmail.com>
Date:   Wed, 20 Apr 2022 06:46:32 -0600
Message-ID: <87tuan3ot3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 4/20/22 10:06, Haowen Bai wrote:
>> After make htmldocs, the table which is made of tab will
>> display all by one line. so we make a standard table for STANDARD
>> FORMAT SPECIFIERS description.
>> 
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>> ---
>>  Documentation/vm/page_owner.rst | 34 ++++++++++++++++++++--------------
>>  1 file changed, 20 insertions(+), 14 deletions(-)
>> 
>
> I guess this patch can be factored into its own single-patch series,
> so the zh_CN patch at [1/2] can depend on it, right?

I'm not quite sure what that would buy for anybody ... ?  Arguably the
two patches could have appeared in the opposite order, but nothing will
break with it done this way.

jon
