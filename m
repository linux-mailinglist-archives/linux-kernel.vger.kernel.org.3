Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEBF4F5780
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245543AbiDFHLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574068AbiDFGpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:45:51 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B158B465FAD;
        Tue,  5 Apr 2022 21:56:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k14so1286572pga.0;
        Tue, 05 Apr 2022 21:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XBTdao9jI2D9lmUstuUU/m3zazcNfOzNZk+VV+cPROc=;
        b=o2agCgrxWu1S/e5lz0xVtEak+ZjQkhVy9NqMyYFzMyY9ik/F5+gNKctB0njKq7ces1
         aI/9JWwLMVlb+SvDL4nLGYceD8GUnBuB/ONF0LmL/uiVr3LrEJ/UZM7qBmuRV19R/Lqq
         eEg/JAcATqtsVoCvUWoIIqBN/6e5wq5qRQfvABEdDppWnVMgzARscEEzZjgQeVUdVG5M
         fxerWuCIAL3EyhOtgbvIVu58ec4jw1A/ts/oS3qgv6TNXThW00V0lAflUITHPoQp0bs6
         yWv0l3EIHNotko3JivWOqOdwgXH7rq89XnKq9MNou+P2mCs5gQDzXfocQIhR/IjQ0aaJ
         m8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XBTdao9jI2D9lmUstuUU/m3zazcNfOzNZk+VV+cPROc=;
        b=RaG2oI9zchAbQ8StOKgKJM4m8kFwVLmYaiWfH8BhPRFLnV4daiDR1WjVBIo5pCTq5G
         E9pNV4D7NXGvyzrJ4avTzpfKz7MUuvP0T6WbBDjXZ2Ur8Ct9scOessk0vAek7HL671Pc
         7ERFGhKVUbRSdBSpWFWHXLP5mUZ1hfsK3Jg6fkOpOGZmTgGoCMS/554lMk8NKjM9+sAF
         Ph6cq5L9eRzTj4CVwPj6acyKfUyaBCvmPEU4QF9sup+T2kaDK5PsVTVDAMx4OsPDMQnV
         e2y8HVguIXPJ6PbId8fbGawR91876ACW+DpeU6RAZspRARfVUQYs/OUSLlaMd5DPv+aB
         rpGw==
X-Gm-Message-State: AOAM531Xe8/J+CrCycYZXi6Ig1Wo7F4XT+tsPUkIB0WotegtkQcI2jCf
        q3tO6kQDP0EPhkZWtghf90U=
X-Google-Smtp-Source: ABdhPJytkJ6f/uulz3QgK3M86/NPKKlfRJs2XNZcJl7LiOP0j6bY87u1/erao2AY0FPEkWDZU/f7xw==
X-Received: by 2002:a63:cf12:0:b0:399:38a7:5063 with SMTP id j18-20020a63cf12000000b0039938a75063mr5592832pgg.311.1649220964192;
        Tue, 05 Apr 2022 21:56:04 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-9.three.co.id. [180.214.233.9])
        by smtp.gmail.com with ESMTPSA id s24-20020a17090a441800b001ca9b5724a6sm3858330pjg.36.2022.04.05.21.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 21:56:03 -0700 (PDT)
Message-ID: <bc258b22-71b9-c8af-4045-21d424d978b8@gmail.com>
Date:   Wed, 6 Apr 2022 11:55:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Documentation: arch_pgtable_helpers: demote pgtable list
 headings
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220326131313.691027-1-bagasdotme@gmail.com>
 <87k0c3ecc1.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87k0c3ecc1.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/22 23.15, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> Demote pgtable list headings from title heading to chapter heading.
> 
> This is a classic example of the sort of changelog that says *what* the
> patch does (which we can also see from the patch itself) but not *why*.
> Why do these headings need to be changed?
> 

In this case, before this patch, generated table of contents for
vm/ contains:

- Active MM
- Architecture Page Table Helpers
- PTE Page Table Helpers
- PMD Page Table Helpers
- PUD Page Table Helpers
- HugeTLB Page Table Helpers
- SWAP Page Table Helpers
- Memory Balancing
...

The headings for PTE, PMD, PUD, HugeTLB, and SWAP Page Table Helpers
should be subheading of Architecture Page Table Helpers, but these
were marked up with page title heading instead of chapter heading.

-- 
An old man doll... just what I always wanted! - Clara
