Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA507503846
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 23:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiDPVJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 17:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiDPVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 17:09:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4155736B64
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 14:06:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t4so12272627pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 14:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vqZKrItXzHP6DNEZ2GJ6sfcy+E/UGwHZqT6czMMhn08=;
        b=T308wQlh2W8cJ7q8iFYWtk9LA8bma9MRVwN5Gp0yl6uuCT3UKR7QHutyFtTIUfNAh0
         lskaH5k7junJDh+ynDgm8fgQTDpG/ul6vTng7ZkDbe/ovPhsyZw/os208N3bJDVf2F9h
         oxvr0D7pYHXHDOUxJJyIKPna+NhT8GPDFX/aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vqZKrItXzHP6DNEZ2GJ6sfcy+E/UGwHZqT6czMMhn08=;
        b=c2Ag8XTxHM1wv3z7o9pk9Cdvw75QTrlP8z3jRhb0yo821zEW4vSdwbmNNzJQMF+9au
         rJMlgZmID9peMSHgF9IMvoQ2DV+C0Skz656zEQFYUUoNWNxtjHzgQTvzRHl+/qEmcLx6
         gvsFU7c+XLYewV6OhUyHG1uSDuChjn+qGnu+poF5llvto18eMa2+jm0RTyA5CiIYmZK3
         zz7aTlJGBWewzFT+BFxdJOxBYoptgZ2sIe1H7iLmhvM8W5SpdEhVMjQOEqEcZ6t6l01C
         Mri0dSspPqpEkMKl/MJ2TwAi/KFS3hh/atOpCdQGsj+4W73TY3+Dq2HhhIOkYQGY5dYQ
         4cSw==
X-Gm-Message-State: AOAM530VsYwxhbKuAdJ52bBnchmpLeF4FvGKv3f2doYz1An0EMDdKUnt
        3gz4zXUplkEMRpV3QvCJUVpQHQ==
X-Google-Smtp-Source: ABdhPJzd27W8zOB3OUbyC2IR7CphZbre/Scp2n5l2fqsvh4dxA8IJuvn5XuYN9s/78mZq5XUTqhtfw==
X-Received: by 2002:a63:e146:0:b0:39d:1b00:e475 with SMTP id h6-20020a63e146000000b0039d1b00e475mr4131038pgk.537.1650143204707;
        Sat, 16 Apr 2022 14:06:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u206-20020a6279d7000000b00505fdc42bf9sm6937662pfc.101.2022.04.16.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 14:06:44 -0700 (PDT)
Date:   Sat, 16 Apr 2022 14:06:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        kernel@collabora.com, kernelci@groups.io,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/lkdtm: add config and turn off
 CFI_FORWARD_PROTO
Message-ID: <202204161400.B2267D6@keescook>
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
 <202203091122.A51B31230A@keescook>
 <62c11336-cac1-8501-19fe-980ebfa050e9@collabora.com>
 <8049e2a9-a478-4c6a-afcd-3aa4434a0590@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8049e2a9-a478-4c6a-afcd-3aa4434a0590@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 04:31:42PM +0500, Muhammad Usama Anjum wrote:
> Any thoughts?
> 
> On 3/10/22 10:21 PM, Muhammad Usama Anjum wrote:
> > On 3/10/22 12:22 AM, Kees Cook wrote:
> >> On Fri, Feb 18, 2022 at 01:56:19AM +0500, Muhammad Usama Anjum wrote:
> >>> Add config options which are needed for LKDTM sub-tests.
> >>> STACKLEAK_ERASING test needs GCC_PLUGIN_STACKLEAK config.
> >>> READ_AFTER_FREE and READ_BUDDY_AFTER_FREE tests need
> >>> INIT_ON_FREE_DEFAULT_ON config.
> >>>
> >>> CFI_FORWARD_PROTO always fails as there is no active CFI system of some
> >>> kind. Turn it off for now by default until proper support.
> >>
> >> Building under LTO Clang on arm64, this is available. What's the right
> >> way to add a CONFIG that isn't always available?
> >>
> >> -Kees
> > Yeah, as you had mentioned
> > (https://github.com/kernelci/kernelci-project/issues/84#issuecomment-1042015431):
> > 
> > CFI_FORWARD_PROTO is going to fail unless there is an active CFI system
> > in place of some kind. Right now this depends on arm64+Clang. In the
> > future, this will be arch-agnostic+Clang, but for the moment, it should
> > be safe to exclude this test.
> > 
> > In this patch, I'm turning off CFI_FORWARD_PROTO by default here. We can
> > re-enable it when it becomes arch agnostic. CFI_FORWARD_PROTO cannot be
> > turned off by using a config. Please let me know your thoughts otherwise.

I don't like the idea of disabling the test because this means it won't
have any output in CI systems to examine at all. I'd much rather have
tests that are expecting to fail to report XFAIL from the kernel
instead. (See things like lkdtm_UNSET_SMEP.)

-- 
Kees Cook
