Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F86557E80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiFWPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiFWPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:15:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDC3A5C7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:15:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 128so12392242pfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Itay7Y2xxargq/J6Y/NurU6/Z+HFhZkczjPHvFJ5w4k=;
        b=QRTrJBy4cdY9/GL2IfCMWoERkieO1ztaHrelylTalu+w6fND9Ru7WTU/7L5ili5jVQ
         VmZQTyzxUR6mg3t0KwRzEpjkIDMLQU1j/CS4+v0VA8aK6Q0fkXK7bw6b6ve8hAPyj0XW
         AyGiMzRxvi8U8zP/b9b8nXZN4EehwGiJlp5Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Itay7Y2xxargq/J6Y/NurU6/Z+HFhZkczjPHvFJ5w4k=;
        b=egCs677oHU2LbGf4gpYpG0YynlourdPvz8IzXbMgqx4RfxzE2U4WVoq0vVNAGjNPBQ
         Yr6cJXCrQhWPp4RUNn+qlxD8KVFHQVrGRshvOh9nSMnQRxIzlDJhhbHghov0+mX6o/1U
         JRBWJU3nyel1h/1GwkYN1pfocWLGYaztR4lxaQ1jEncr5PzkeexgUKlQnWo82yVeZT+e
         DHLQCQxVsnk5PfCqSaxfDM3t3vW6/M2MIdhojO4oJoNyOg93PUOkGTSJAoVNOulxNFAT
         g5blWNy+36JF84on7vh6t1lix16m30Chn2BGuVL3WyxeqvIzvdooSwU4Sm/MnfsqfYnT
         jyaw==
X-Gm-Message-State: AJIora/di9+QIT+wa0jqbMsRWJQ0wUChEKn/LRZCGIvRBYyMk6lea+PH
        E8FLzHk2VnF/yLnXTyFBGrdEPw==
X-Google-Smtp-Source: AGRyM1twFv4L8nR2YdNrvbFQ2Ymi/KFdsUtfmdfENtOYdNtCP5sVA1YaYvN6GkAKRUHQTy0exGde+w==
X-Received: by 2002:a63:698a:0:b0:40c:4714:2425 with SMTP id e132-20020a63698a000000b0040c47142425mr7858173pgc.548.1655997348116;
        Thu, 23 Jun 2022 08:15:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090331d400b001641047544bsm14938197ple.103.2022.06.23.08.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:15:47 -0700 (PDT)
Date:   Thu, 23 Jun 2022 08:15:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        oberpar@linux.ibm.com, bjorn.andersson@linaro.org,
        liaoyu15@huawei.com, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: Fix typo in comments
Message-ID: <202206230815.08ED0F225@keescook>
References: <20220622142713.14187-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622142713.14187-1-jiangjian@cdjrlc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:27:13PM +0800, Jiang Jian wrote:
> Remove the repeated word 'and' from comments
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
