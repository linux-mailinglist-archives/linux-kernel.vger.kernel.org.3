Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A524F5C02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiDFLPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiDFLOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:14:22 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD99E53D7F9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:37:48 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id cs16so1641854qvb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=d8V7VO+kcQ0mbmyy8ZkB/M+w0ELWDpQbJ0MubcHelRk=;
        b=jOs4/FH9L11zBGxLuILPhWUWMjiRrToNmG96XfuXI7ivphTv2rrs42hglZ/8jdDE+Y
         3qV02WGwqJ1cR+/DsdkDZtCq+F+1FZGK3NahncU7Y8gDXE3ePQBNgSpws5crAynqqDyj
         Sj4OD7lSPJ1ELJ/Sea9K0uC+367K+Vh5e5JBJ2PSYwfwIbaG/fruHRM/kB6Kw8Le60iO
         yFTg8f24DypMSc8QRecDAJHYaLf1/8syeQ8IMrgDHjmycskMwLCtYA0fXqdOld6BGcCD
         ADLErlyGyPmqNxPT3izkjv7dT1oMHsTlDxIr5eS9XXvkS435TfloxtitO3iy/LnbDe5i
         8sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=d8V7VO+kcQ0mbmyy8ZkB/M+w0ELWDpQbJ0MubcHelRk=;
        b=UB6s035bQwAsXxFo2zpNVwRh8/A8EMxTXefgEEHlwHofAll7MZQYm/+AiTVyfdJyMw
         KLEIHpWDz7I6gMm1NdFUDXz6Kojd6VwmemVQVXZXzbD+qPrbBkKC/BAi+TxewuBPnS2k
         qhzuTO2t427nru3YnHerS39tYJeX1GlO7oosy659fXZOrwfVWWgxJZEsF90f+w1iHvEu
         FUPvWut02UyLeroXB02rs/AhqKzZwjwYSL1bDDoe5PRywNtRHPod61Y8O9GafLKoGwnz
         FvfBLEnpiZp4inwOuxk0SSD8uOmijRjQ9wmrLzsFVn5uHS2TiOzn2ZFxK5H4Kxy4ck1m
         lGKA==
X-Gm-Message-State: AOAM530vCNWqk4EoL3KMkUlVrfncQ8buolM8X9X4dl4dAk7xjLDWDsri
        xTnLrFbcOtSOptiV+nSmC/0=
X-Google-Smtp-Source: ABdhPJwwnFIt4rCcIgVwjIbuX+wMIjrYrcDUM+9auTHH9TsznJEiml3Zvha9G5B1PLH7bPq7N8aumw==
X-Received: by 2002:a0c:ffab:0:b0:443:d915:59cc with SMTP id d11-20020a0cffab000000b00443d91559ccmr6384101qvv.44.1649230667752;
        Wed, 06 Apr 2022 00:37:47 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c1-20020a05620a0ce100b0067e0cd1746fsm8806915qkj.51.2022.04.06.00.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 00:37:46 -0700 (PDT)
Message-ID: <624d434a.1c69fb81.11e99.b2b8@mx.google.com>
X-Google-Original-Message-ID: <20220406073743.GA2487892@cgel.zte@gmail.com>
Date:   Wed, 6 Apr 2022 07:37:43 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, bsingharora@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] delayacct: track delays from COW
References: <20220322110444.2340748-1-yang.yang29@zte.com.cn>
 <9f9ddbf7-797a-58d8-2903-beacb2698329@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9ddbf7-797a-58d8-2903-beacb2698329@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:49:46AM +0100, David Hildenbrand wrote:
> On 22.03.22 12:04, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > Delay accounting does not track the delay of COW. When tasks trigger
> > much COW, it may spend a amount of time waiting for it. To get the
> > impact of tasks in COW, measure the delay when it happens. This
> > could help users to do tunnings, such as decide whether to use
> > ksm or not.
> > 
> > Also update tools/accounting/getdelays.c:
> > 
> >     / # ./getdelays -dl -p 231
> >     print delayacct stats ON
> >     listen forever
> >     PID     231
> > 
> >     CPU             count     real total  virtual total    delay total  delay average
> >                      6247     1859000000     2154070021     1674255063          0.268ms
> >     IO              count    delay total  delay average
> >                         0              0              0ms
> >     SWAP            count    delay total  delay average
> >                         0              0              0ms
> >     RECLAIM         count    delay total  delay average
> >                         0              0              0ms
> >     THRASHING       count    delay total  delay average
> >                         0              0              0ms
> >     COMPACT         count    delay total  delay average
> >                         3          72758              0ms
> >     COW             count    delay total  delay average
> >                      3635      271567604              0ms
> 
> You should also update Documentation/accounting/delay-accounting.rst
> most probably.
> 
> Overall LGTM and this might be of value not only for KSM but for anybody
> using fork(). There will be collisions with [1], especially [2], which I
> want to get in -next early after we have v5.18-rc1 (after rebasing [1]
> on top of this).
> 
> We'll have to decide if we want to also account hugetlb wp code
> (hugetlb_cow), and if we want to account "unsharing" here as well under
> cow (I tend to say that we want to for simplicity). For THP, we only
> split and don't copy, so there isn't anything to account.
>
As for simplicity, what about account "PAGECOPY" instead of "COW"?
"PAGECOPY" include COW and unsharing. And we may also account hugetlb
wp in follow-up patches, based on this patch is sufficient reviewed.

> [1] https://lore.kernel.org/r/20220315104741.63071-1-david@redhat.com
> [2] https://lore.kernel.org/r/20220315104741.63071-14-david@redhat.com
> 
> -- 
> Thanks,
> 
> David / dhildenb
