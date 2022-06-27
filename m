Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9527D55DCEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiF0W2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242599AbiF0W21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:28:27 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC61613E0E;
        Mon, 27 Jun 2022 15:28:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 99DBD2D3;
        Mon, 27 Jun 2022 22:28:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 99DBD2D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656368900; bh=sqIB6wvrcODWFpVRELCRk3qr6U5GjoJLZ6jWg7iZ8RM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tBdwa2gyqh0UWNpCqHtyxH00UrvUUHQCOygDftFAF48yMR+elnJmgrjHB4CIB36rc
         eJs15+rKB1Td8rbLIXE6NVfHABElEG0kY+P/UzVzJg0/W3DoWNlbl6iXkgSCvb7J0U
         Ivr0SH42v1FfRmhD3WuQPSXfQzYj1Q2XzNiFX+QwRQRO+WKPJ5Jll9Ip07JFmCv9bq
         JC8AXKkzdOs4pNLsVTSwo9ZsgoTT2o1N2Mr6HUe450vUOL1wdcg8NwUhgYX9M4Rz6d
         c63fjFL4BVgN37IAfVPt/gpAcbfJzT9eYPe+61wnUaCh2jhbyqoOZpmgQ0+Jbp9H4L
         6IYIOkLpk+w5Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/3] Documentation: kunit: remove duplicate kunit-tool.rst
In-Reply-To: <96154234-7842-3bc9-d89f-eb20be40e6de@linuxfoundation.org>
References: <20220603195626.121922-1-dlatypov@google.com>
 <87pmix3ktq.fsf@meer.lwn.net>
 <2c3399e9-4f4e-a71a-4030-e4e6d72b5d4e@linuxfoundation.org>
 <8735ft3co5.fsf@meer.lwn.net>
 <96154234-7842-3bc9-d89f-eb20be40e6de@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 16:28:20 -0600
Message-ID: <87lethyc57.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

> On 6/24/22 4:43 PM, Jonathan Corbet wrote:
>> Shuah Khan <skhan@linuxfoundation.org> writes:
>> 
>>>> So not that long ago these patches were going through Shuah...it seems
>>>> that's not happening anymore?  I can pick up kunit docs patches,
>>>> certainly.  I've taken the silence on these as assent and applied them.
>>>>
>>>
>>> I am still taking ksefltest and kunit doc patches through my tree. I wait
>>> for Brendan to ack at times. This one didn't show up in linux-kselftest
>>> list it appears.
>>>
>>> If you cc linux-kselftest and I get an ack from Brendan, I will take this
>>> through kselftest tree.
>> 
>> As I said up above, I went ahead and applied them.  I can drop them
>> again if you want to carry them, just let me know.
>> 
>
> Jon, yes please go ahead and drop this one. I will wait for Brendan
> to ack it. Reduces confusion in the future. Very often, there is code
> dependencies as well.

OK, I have dropped those three commits.  Note that I also had to drop
Randy's patch which had been waiting since April:

  https://lore.kernel.org/linux-doc/20220401024707.10550-1-rdunlap%40infradead.org/

since it conflicts with the above.  So you'll want to pick that one up
too.

Thanks,

jon
