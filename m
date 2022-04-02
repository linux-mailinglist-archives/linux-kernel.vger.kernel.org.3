Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00EA4F067F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 23:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbiDBVuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 17:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345098AbiDBVur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 17:50:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5445140AA;
        Sat,  2 Apr 2022 14:48:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d29so2933795wra.10;
        Sat, 02 Apr 2022 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=us6aSVa3J8Fz7ggtoxcbQ4SWfzc0yNq+6rwiUrC9dBk=;
        b=FRQmTwiC8OS41y5Pt5IJbdlzekXrE20q+difrm7MNa718iKxjy81n+c4Rg1RKgFq1V
         UNEYuLkNA7UlAzZ79SQMGfCRc6F3/9tbyFB0jR7xEd7JgF73CZMosSbAR9x7xyLVNDZY
         iYPuOVamVxtaHQOwqtNG3d/k//bS8S4QASczFZKwahefDJTMwVlaDN2e3AuOc9lJdTH+
         4fd6seJJguJnHNKsgn5Lw0F2cwKB4yFxZ4F2nLSm++ATArRAXHm65rWN0/7bTaOpjgzZ
         MU5oTfA+i3zN+E2cdZUEfIV/ybpV/4NHOfwghm52XqZVuT8uJr7EsbuiktDgjGVKCzOz
         Yesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=us6aSVa3J8Fz7ggtoxcbQ4SWfzc0yNq+6rwiUrC9dBk=;
        b=4OCCjzOlD0/PXFCUN4Lh65aFEQaJi4zW1N13H5ycnJKdxy8l13fcy0mmiG+H3uhgDg
         3HCImUZ/srLW6aZAN3hnqKQGhkizo3U/2RGvMGNht27WT+vqXAMH0uqIdqc+n+MGOVmL
         H824lG80rsixzGvSLwl1MFXBHsVybbZnYU0j7JNNooCAZe2a7gWBgVAYRkebv9s1Y4KQ
         i5SEMI7/IrBDx8WZG2hMxSJJcKUAnA424bNCTlregzSkaJ2RUqc4GD01nmB8MeCHoAdV
         syZbTpJza4gm6bwlC+ynERegQuDZjgRFz6+yjT8b+S0HBmCb31hpkmXuFhIdW4Gcco3Q
         OG2Q==
X-Gm-Message-State: AOAM531kNCVg0+lejRNwVoe4j2pmoFJ19tXbBWxHAhOx7qWu9A3nrPpT
        AdmzQ/+muhC+W3J7w0hNRWU=
X-Google-Smtp-Source: ABdhPJwtLky+OmeRw3EQtHVZFNNp8l429KkJLvaIuy7XhOkWnQObkFWvBDI21i1UMECswI5jk0iffg==
X-Received: by 2002:a5d:660e:0:b0:203:eda6:e983 with SMTP id n14-20020a5d660e000000b00203eda6e983mr12070443wru.544.1648936133424;
        Sat, 02 Apr 2022 14:48:53 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id k129-20020a1ca187000000b0038e6e789f08sm704877wme.39.2022.04.02.14.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 14:48:53 -0700 (PDT)
Message-ID: <cb85e759-d272-e165-beee-b0d1c8f87405@gmail.com>
Date:   Sat, 2 Apr 2022 23:48:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] ioctl_userfaultfd.2, userfaultfd.2: add minor fault
 mode
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-man@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
References: <20210604195622.1249588-1-axelrasmussen@google.com>
 <CAJHvVcjzi-7Wvrho1LqWiQC2WNbtg0XGf6-JBRcDZS1=banbVA@mail.gmail.com>
 <YQfVRuV2Ab2rlKVI@kernel.org>
 <1add2552-ea36-12a2-b3b1-6e97f6f84e00@gmail.com>
 <CAJHvVcggpJ7hE8VbhL09mT0=eJ5C+iH1poi_-V2v_dMLjSbVnQ@mail.gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <CAJHvVcggpJ7hE8VbhL09mT0=eJ5C+iH1poi_-V2v_dMLjSbVnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On 3/22/22 17:31, Axel Rasmussen wrote:
> On Mon, Aug 2, 2021 at 5:21 AM Alejandro Colomar (man-pages)
> <alx.manpages@gmail.com> wrote:
>>>>> +mode, user-space will receive a page-fault notification
>>
>> s/user-space/user space/
>>
>> See the following extract from man-pages(7):
>>
>>     Preferred terms
>>         The  following  table  lists some preferred terms to use in
>>         man pages, mainly to ensure consistency across pages.
>>
>>         Term                 Avoid using              Notes
>>         ─────────────────────────────────────────────────────────────
>>         [...]
>>         user space           userspace
>>
>> However, when user space is used as an adjective, per the usual English
>> rules, we write "user-space".  Example: "a user-space program".
> 
> 100% agreed that "user space" is more correct, but this man page
> already has many instances of "user-space" in it. I'd suggest we
> either fix all of them, or just follow the existing convention within
> this page.
> 
> How about, leaving this as-is for this patch, to keep the diff tidy,
> and I can send a follow-up patch to fix all the instances of this in
> this page?
> 

Sure.  Sorry for the delay.

Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
