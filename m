Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39D657D200
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiGUQvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiGUQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:51:37 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FCA8BA99
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:51:36 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v185so1771344ioe.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kBrKJZxEJZScbYIdNWQ41kmJ2go5hgyJDa02gwDJF0E=;
        b=JGqQrlpABav9cLjPPE1rHTgN59BibGQ4hJ5TJSJYkj58k5n0aJ1eb75lj8ke5Y9Te+
         BQ9FFJTBMeZYpEqc3h+SOjJ+zI5WNdSaJneaImxRcXc8PRLzRUeiU5whjQ0F0DB62ugN
         ttV1bm2j3r+aGrJGyqlrgW6WO9qhu1Mep8Fg3DEqT1s66lMJ1RbmCBEp3Yn0CD0RzLHd
         TA3hf7GxdEgMUi/v5f3Wru1phU6LvHeC+kPdmBAIfjxuTtKGEgW00rtOi+UmdJfsehkF
         k7u9+SBqGfEFcS0av+EV2SRqRKmOnhlBDg/N0gVo5L5yof5t6KDKxttxSGpeDNYa+dPz
         OJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kBrKJZxEJZScbYIdNWQ41kmJ2go5hgyJDa02gwDJF0E=;
        b=FlLn1K7fSvXhYBMilxOk7L3T8LM9APNbikPRnBgNPQztezFSviE5FmazPmDWR9NuCw
         l1c73Q4zqj6XmeWvu+Sy7wrDmXiHE3vhtHsjWU1yaVc1jLwnDOzp2RHNmYVyd2swBTRD
         ogW3Wl1qH7j9+uydq8K2DHD2vaFxakkrOTtiiDXPqAlGZ4HtsvVmh48hkvSX442/57rg
         x4X9SM8My4ptq7VbVuNOEWPibHWOKkHS+q+m2G+f2tKXj2HnX+U26kkIEYw+u/kt4I2e
         sSBi6qxp7mqY3gWJSy569n3hA/+KJYHY6JwyjDapPdwAKIkhcENITxo8WaezJtxLQNJj
         0r5w==
X-Gm-Message-State: AJIora94sZrdLYgi/6NBHCJmW7YGVNj9T/0micrcuI4ds2g6E/4QGR6V
        aZJ3n8vbaYXs2T5LHqH8g6YEH2Lo6MZBjg==
X-Google-Smtp-Source: AGRyM1uRD8hgPo4nuRYApW45Md6Bu64OmRjSJ3pILNJHFypbmR46S+hC6Vj5iy3RRAs4vImkzF7qPg==
X-Received: by 2002:a05:6638:260a:b0:341:4bda:9c2c with SMTP id m10-20020a056638260a00b003414bda9c2cmr16638569jat.160.1658422296180;
        Thu, 21 Jul 2022 09:51:36 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n4-20020a056602340400b00674f9fb1531sm1019863ioz.30.2022.07.21.09.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:51:35 -0700 (PDT)
Message-ID: <7ceaa46e-ae1c-5bf6-bb60-f1a67ddd1fde@kernel.dk>
Date:   Thu, 21 Jul 2022 10:51:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220721131132.070be166@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220721131132.070be166@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 9:11 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/md/md.c:717:22: error: 'mddev_find' defined but not used [-Werror=unused-function]
>   717 | static struct mddev *mddev_find(dev_t unit)
>       |                      ^~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   4500d5c17910 ("md: simplify md_open")
> 
> I have applied the following patch for today.

Thanks, I turned that commit message into a real patch and added it.

-- 
Jens Axboe

