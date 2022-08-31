Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C125A84C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiHaRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHaRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:51:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D167C1ED
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:51:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l65so4794407pfl.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=XFXEowDQcVYKezApj/384ov2KBax8K2fIP9yDwQpf9Q=;
        b=InN4QYFeXhi6K8Y7NaMJWfjcPixUKdsrMbVznMWaVd1BA9zOhRX8Wc45OE8uyf+jqI
         rL3UOwGqot6QfkagDK2R1YsC4SycKqS2TvLg5W0kieNaLsd1DYbwqpNyNJK/VhMBAv/I
         QE/seQeOZhDY7uTOjfghA2fjGV97IAFyG0RHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XFXEowDQcVYKezApj/384ov2KBax8K2fIP9yDwQpf9Q=;
        b=hncF8B9L354j+dD3WWOuz3ycWvxQbEnyXNVLfZd8kdh91uV/U01aaiy1avfAhuVRH8
         4MNAOiGogKGCE9QbI/CFIzoC5mPUoqzSmDtMiCUIO/bDY/WoY+ah30MMOkByHTb+sJev
         j0hw5Uond7t9xWkeduooMUaz4IlQ3kyXDGUCPTm4+zz9Jtu6bumcB1IYpb5FaJSf0MG+
         Ui/5sns0ezMSnU1+n8aA4JudUWlst0+Oql4/zOoU69uDbZyjJGk06f6mfrRFS9mDqSUt
         jpYYEXZ4ciyZk8EOcdfZRdJ3rBphOTHwh5KTgx1JvUY2vOBLYj+s80tlimxocpSlKn41
         z8Sw==
X-Gm-Message-State: ACgBeo0+yY4cuP2xVb2dYdDYQyXoAB8sEH/QQOuZsc5HOnY9UdLsTN8B
        5pBXDtRmOutNpMtwrq2SvrNr7cJMMw1L5g==
X-Google-Smtp-Source: AA6agR5qXFqXkTU2ik3j5m3InZp9lwNmw9IrdpIJekwLeSH8XNA60/frqdTvzd5HJLhsGXxbJoQpIA==
X-Received: by 2002:a63:8048:0:b0:42b:73ef:ac8f with SMTP id j69-20020a638048000000b0042b73efac8fmr22058673pgd.446.1661968270381;
        Wed, 31 Aug 2022 10:51:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r14-20020a17090a4dce00b001fde4a4c28csm1560720pjl.37.2022.08.31.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:51:09 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:51:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with the kspp tree
Message-ID: <202208311050.60A8E9C43@keescook>
References: <20220830170051.6c190838@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830170051.6c190838@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 05:00:51PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mm tree got a conflict in:
> 
>   lib/Makefile
> 
> between commit:
> 
>   5e3ad11bfc5a ("testing/selftests: Add tests for the is_signed_type() macro")
> 
> from the kspp tree and commit:
> 
>   7a2791666971 ("testing/selftests: add tests for the is_signed_type() macro")
> 
> from the mm tree.
> 
> I fixed it up (I dropped the latter commit by using the former version
> of this file and deleting lib/is_signed_type_test.c) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Thanks! Andrew, can you drop these patches from -mm please? I corrected
the filename convention in the above named patch.

-- 
Kees Cook
