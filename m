Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05915550EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359605AbiFVQLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359421AbiFVQLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:11:07 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B14B39B8D;
        Wed, 22 Jun 2022 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1655914261;
        bh=nk8KgKas3epfldKU7z9t5qNljsGwrlSJR6Zhs5ksWy8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=R442PcJgjRtmfPMfST6Kcvdi3cLfWLqFefLyBb0duzfkUT1x8zoJZvWHv5b2gQXHj
         Is+2cc/HPrWGRcZTXw5eMUYiSZvzrWaaRsbOk/r8bYPy2Cacq8jEM+hqW12MFTtIkL
         IPtm2iuNf6UHakuVvWotNJptWKcx3dB3BJcUGqiA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 263AB1281161;
        Wed, 22 Jun 2022 12:11:01 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JpddjhKFjdPk; Wed, 22 Jun 2022 12:11:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1655914260;
        bh=nk8KgKas3epfldKU7z9t5qNljsGwrlSJR6Zhs5ksWy8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hV7mle7hQJe5qKTo/ItJN7oX2BC6bF3o6SJwgQ167QmnfnIVxQr1qzuxEXoO55iMj
         A6bKzdI38bHn/5+ICcj54L4UiQ/5EEyEI7BFSgfo2NSOB28tG1JUs2EnrQPuvEyOHU
         j/tywTRiO2ubZKgWjoNc1PyyEAyoB/VqAHtE+MzU=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 219121280DD8;
        Wed, 22 Jun 2022 12:11:00 -0400 (EDT)
Message-ID: <49a877f33a088edc232eb98029e46e53884c5cd6.camel@HansenPartnership.com>
Subject: Re: [PATCH] block: drbd: drbd_state: Fix typo in comments
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>, axboe@kernel.dk
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Jun 2022 12:10:59 -0400
In-Reply-To: <20220622155220.8704-1-jiangjian@cdjrlc.com>
References: <20220622155220.8704-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-22 at 23:52 +0800, Jiang Jian wrote:
> Replace 'is' with 'it'
> 
> file: drivers/block/drbd/drbd_state.c
> line: 1900
> 
> * But is is still not save to dreference ldev here, since
> 
> changed to:
> 
> * But it is still not save to dreference ldev here, since

I honestly don't think spelling and grammar updates to comments provide
much value.  However, there's no value at all if it's still two
spelling errors in that one line after the proposed patch ...

James


