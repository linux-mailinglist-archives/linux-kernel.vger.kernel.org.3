Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D361C505F80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiDRVzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiDRVzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:55:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1727A101E3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:52:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so493590pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5EloPRaMAEvo1BFocPUg4BfBZ1iEVJmMWJsQxi5bcMM=;
        b=YVmlcx5sXVXgzhOvtNXNtNAkcmWX3wxfxu84QX8EIpr8heLKB5rxNy/PHU4gQiNksP
         Nl05EfDdHLQO6X+ieo8hsfYFPduWzcKaHEXh44GBVkDSCnxZhkapPOLpfjvmZMUZIvZh
         /Jx0z/vO6S4i685sTPpbOfzj63SA8nGReAIY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5EloPRaMAEvo1BFocPUg4BfBZ1iEVJmMWJsQxi5bcMM=;
        b=K/7illghHipJU+3ZKbh7hx28dtd9YvGqqLL2G6U8F9USD1zQkdYYLlOAknOJtTKIkG
         b0Wv17/W6VoMXnJntfBLIh+ZBfCOwRwgJQsya/nXly/mn6RABp524Bla1Tlj1oDzwwOj
         PVt7NgLWlDpbiKVfSgXgEZRF7W+qkr4u3ghTwd0KfTWca9lkeQsD/c8gYJ+01Lyw2r9J
         /6cDxJwcynZgiFkVw8y9P8rGV5ECbwcy0OohacumQfUqcZE9IlBn3fQIJmWbRO9Tnv3J
         pJjad1hBT6bM2+MvxSTv+1ymTqK63sf6t/LB1aNrEl3wZdF0k1xFu+NCGSCYeqJCY5dX
         uEbg==
X-Gm-Message-State: AOAM531OPlfb6wUZDKYfIkn5hHVBb45rT6WvMsB4GXzhTysCio1LBWG6
        kTGD0m5+eDdbogayH9ByejLksA==
X-Google-Smtp-Source: ABdhPJyIIy7Mu/4/cYuLkLDArRZG98DXBS95aUkzsSxNZ1kkHNh/R2HFtJ2oWipnr/f65XUDX5MU2A==
X-Received: by 2002:a17:902:e743:b0:159:40a:a156 with SMTP id p3-20020a170902e74300b00159040aa156mr5598299plf.89.1650318746580;
        Mon, 18 Apr 2022 14:52:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r8-20020a17090a0ac800b001c9e35d3a3asm13984922pje.24.2022.04.18.14.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:52:26 -0700 (PDT)
Date:   Mon, 18 Apr 2022 14:52:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kees:for-next/randstruct 5/5] include/linux/cred.h:254:17:
 error: no member named 'non_rcu' in 'struct cred'
Message-ID: <202204181451.006918DB0F@keescook>
References: <202204180214.X2Y1kbZ6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204180214.X2Y1kbZ6-lkp@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 02:31:31AM +0800, kernel test robot wrote:
> >> include/linux/cred.h:254:17: error: no member named 'non_rcu' in 'struct cred'
>            nonconst_cred->non_rcu = 0;
>            ~~~~~~~~~~~~~  ^

Thanks! This is being worked on:
https://github.com/KSPP/linux/issues/185

-- 
Kees Cook
