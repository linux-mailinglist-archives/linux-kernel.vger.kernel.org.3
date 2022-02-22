Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0044C055E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiBVXcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiBVXcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:32:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B423AA7C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:31:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c9so5116445pll.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ca7c7RCq1PCTE+7zQseB4HdUG5fedArDZEh19lcfcog=;
        b=MVtRlmIwR5u8CISwcCE0rKidkrgKnHqS/pNSLgPLIvoJI60SJ+F/jnwCxGJ3Lr7fyI
         mpzd+qHEGzAg3FS0luSHdL9G+481Ua4makGiTmLJvAygrNHCpxL2znzyvQm7qEwncFrN
         mET4ju0tmlcyKy1It6IWffGnVYhYzXvuCx+sXp1KEvrQgpw6YMM32vPz/dQWETPHHGBD
         fKv9W6v3nJdGJMGj2iHHgyamUIaAUyXgoPvbVcW6uAe0iwgOZqTIrhw6c8sS2mzpYpD8
         dfJE0/G6o+kzxZ5CIygPZ63ipbVOvKTnN7g1U8uJodnbMqt9sbJNG7Fic1h7/wIMg32U
         VUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ca7c7RCq1PCTE+7zQseB4HdUG5fedArDZEh19lcfcog=;
        b=cAIjDUdhLAZ8sSCS28jwSJddBkrKzZgel5e1PNi+m2r4JDrwRZ5WDzWmUYlLdw/cqk
         5/9IKcXGeogeHY7QR54FzoegysBKuYEZKsjZgFLRuwaI4wUDnuSprN3nKC4RahJyQwUm
         nBpV/asxJeJ3Ff8TF3Atk4rilzBKoTky/pmHUBobP1ZonnAsSnKIegPPAdqkr3kwn7hB
         lwti3odCGW2BG/U7cVOBJzjl0/iIHvElMMnROk8Ao9dSA2Eu+4aPNRYUbUpnHJNVg3qU
         xYAjMRPWhmPqt+NBULmXmbA/HskwxN2JayK3NYqM4rb/ScPZ/Mo8TzyV3OJYoNzaTsst
         tgHA==
X-Gm-Message-State: AOAM531KEA2otifKoFAvSvYz5jxk8BlD8P3SmA5/ulh+BJnO8VPcthe8
        OeogsPz5kyo93O9ad7Y6wOes0pprD1W76g==
X-Google-Smtp-Source: ABdhPJxdvgsJOgDs1EndqPiZxczzeIn9qk+T+nDhLNLwAxBC1DplmSgigf43dwESdov4Hmhi2wzsHw==
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id d22-20020a170902729600b0014b4bc60e81mr25242721pll.132.1645572694362;
        Tue, 22 Feb 2022 15:31:34 -0800 (PST)
Received: from [2620:15c:29:204:6b0f:423a:fd82:4e05] ([2620:15c:29:204:6b0f:423a:fd82:4e05])
        by smtp.gmail.com with ESMTPSA id h9sm18478326pfv.135.2022.02.22.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:31:33 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:31:33 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     tangmeng <tangmeng@uniontech.com>
cc:     sj@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: remove unnecessary CONFIG_DAMON option
In-Reply-To: <20220221065255.19991-1-tangmeng@uniontech.com>
Message-ID: <fa764420-7893-63ee-80b0-aaaca01f5290@google.com>
References: <20220221065255.19991-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022, tangmeng wrote:

> In mm/Makefile has:
> obj-$(CONFIG_DAMON) += damon/
> 
> So that we don't need 'obj-$(CONFIG_DAMON) :=' in mm/damon/Makefile,
> delete it from mm/demon/Makefile.
> 

s/demon/damon/
