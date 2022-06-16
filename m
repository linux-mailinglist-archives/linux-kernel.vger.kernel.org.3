Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4BA54D70F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350374AbiFPBbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFPBbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:31:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B965620B;
        Wed, 15 Jun 2022 18:31:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o17so72152pla.6;
        Wed, 15 Jun 2022 18:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h7GmD2rjOvxf0rxdWlRdaeTk1yBAOFpd9CP+O6ifu+Y=;
        b=AqtTG00g03Z6rBPhiwyA9vmsQ4r2RFrJYVjOzWi/Iu/syVwJFs0NQBTUo9FPU69QgJ
         oSajHksmC/bFCZSBq3K46/OJraglSn0a9rqVVxpvcXfukpWy9J/IXoYN6PcgtTNE1dBn
         4q8UAD/fj/0DF8Bk+0K65Wofk42dqwVLz6yZifh/ujA7vkk+ENxuaYI0YDaAIWO1CVPk
         g3xJGq+3U7hoAgw143rWlWaea9zooisN77YCwU26eect5PAH2dSYrKOtekMHBJ05+YMt
         ZiURoIbr61ULk0jKL5REa8coRl+h3AgLRxZ27ds4z6uoSAn0fGtQkbFCHKaODzL0bnh5
         gSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h7GmD2rjOvxf0rxdWlRdaeTk1yBAOFpd9CP+O6ifu+Y=;
        b=GiE9kcDEjmOxFw76m1DoVmwf0Tw3tvdYfaRLmJZ+GC91/cNgbNvYseZdD+ENWt5M5O
         yjlC6AR100/8BeGR7+yv+FMY+56BXQ/GJKNqjPiN5zYDmP0jwD75x8kTR/0+aJpxNJ8Z
         DVByePCZ+8B9oIHSSMBsVJA9OYOumfoCcdOzgSrfHSKC03dcMDwIWVD5YnKY0kQjEziz
         dReZCyW16cTOEs3pSGIuYR813H5MhsHqxnf1PBLypBtO1XM/TLoJ5OHGhp1Pte5esLQw
         K/ENLNk3EzprZgg2fuHv3bCn4nWEZyaoljJXWZXJV0oDqoLaX0Jm5ecowSEfWPLwirsc
         sZfg==
X-Gm-Message-State: AJIora83boxZzQlEJqDuhPuJlelSSqsyz54E5y3od21nhrDKuZDdxdKu
        fiJ5FHxDmeuCtERWjxSaxnNshrx3skE=
X-Google-Smtp-Source: AGRyM1soCC8bklHl/3PVCNPZTnct2vin+wT2X/m0/+6frnJVaQnPP1jH6uH+eM1kUQJ+TO9P5pGuJQ==
X-Received: by 2002:a17:90b:4f81:b0:1e8:84b0:6aaf with SMTP id qe1-20020a17090b4f8100b001e884b06aafmr2459976pjb.66.1655343096770;
        Wed, 15 Jun 2022 18:31:36 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-50.three.co.id. [116.206.12.50])
        by smtp.gmail.com with ESMTPSA id i135-20020a62878d000000b0051baeb06c0bsm272301pfe.168.2022.06.15.18.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 18:31:35 -0700 (PDT)
Message-ID: <62074230-52d9-83b7-df64-c00aea016150@gmail.com>
Date:   Thu, 16 Jun 2022 08:31:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] Documentation: highmem: Use literal block for
 *kmap_local_folio() example
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220615101509.516520-1-bagasdotme@gmail.com>
 <YqnyJ/5/ZLiNI+5v@iweiny-server> <YqnyiuaeQz6aSNUL@iweiny-server>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YqnyiuaeQz6aSNUL@iweiny-server>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 21:54, Ira Weiny wrote:
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> My bad...
> 
>> Tested-by: Ira Weiny <ira.weiny@intel.com>
>>
>>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
>>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>> ---
>>>  Changes since v1 [1]:
>>>    - Point that the code example is for kmap_atomic() (suggested by
>>>      Matthew Wilcox)
> 
> As Willy pointed out you did not do this.  I was mistaken to believe this
> statement.

My bad too...

I forget editing patch subject. I guess the subject and description could
just say "code example in *kmap_local_folio() comment" somewhere.

Willy, what do you think? Any suggestion?

-- 
An old man doll... just what I always wanted! - Clara
