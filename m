Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C202C4ED320
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiCaE74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiCaE7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:59:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EA0192A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:58:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so2485516pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PiZCacnPf98OojdKuzINeLxopb1yUnx6kMNzrFZ8Z0Q=;
        b=QdzIGs75a0rR3hVHkIuN7hxiZ4aIPzuc4M/KeYmxbrkFiL2oGnnYcUls5gqOUADsU2
         /InY719mlbvIERZhcMJAgrG8BBz2ZeMeB3Ji3RIEPHvOtKDuV+gYWU+24hqigzBclFxM
         a+QyB2x5+PDV0Czos3Hs9krBMqsVR9J5hbf10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PiZCacnPf98OojdKuzINeLxopb1yUnx6kMNzrFZ8Z0Q=;
        b=IcMwevoInymv0QwtR+NpyW0nEA/RlU1wanadNEeRLSkBVdjqwpO5BvmV+7YGbk0IJq
         hLth/h+LJlQBPW2I1xLM2T8AuYzFxdOua0Yv8ULlegDgdwFV69hXlrbBz6+lBigVPuVU
         28hGnAIObCArDo0djuA94TstGb4bhYftuNxvwvy+Hvqj9JhbMSf4LiTXksNuT3j/h6Lx
         IdIx/YtalxpeatOE4X4Unf0Lw1pbdEwcG7AARDd2Dm7/fXZc6NKPsTkZAISySAI9bts5
         bbkFfo7ViW2XSF13wuIaWkOqf2hXvk55/ybv+hJzbrLScU3WPrlxhs6EICQtwHfUm+q6
         Vd3Q==
X-Gm-Message-State: AOAM531bGpTK2WfX1Jho0yhXpse07ww5lxsc1wdiBjZKNNQGoRtjZaF/
        TPWZyNDpPtkCmJrGpvBoECWKsQ==
X-Google-Smtp-Source: ABdhPJx04e6lBaZRpW1n1dYJytcwlo3x5EktBQVulB7uPke2GcjNB3IWVFbK2YSFUSHzNkltQKTqwg==
X-Received: by 2002:a17:903:3051:b0:154:6fa8:2fa3 with SMTP id u17-20020a170903305100b001546fa82fa3mr3515456pla.129.1648702683965;
        Wed, 30 Mar 2022 21:58:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a2ec800b001ca0ce2e2c8sm1912587pjs.47.2022.03.30.21.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 21:58:03 -0700 (PDT)
Date:   Wed, 30 Mar 2022 21:58:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH 2/2] Revert "um: clang: Strip out -mno-global-merge from
 USER_CFLAGS"
Message-ID: <202203302158.BEAB17240@keescook>
References: <20220330234528.1426991-1-nathan@kernel.org>
 <20220330234528.1426991-3-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330234528.1426991-3-nathan@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 04:45:28PM -0700, Nathan Chancellor wrote:
> This reverts commit 6580c5c18fb3df2b11c5e0452372f815deeff895.
> 
> This patch is buggy, as noted in the patch linked below. The root cause
> has been solved by removing '-mno-global-merge' for the entire kernel.
> 
> Link: https://lore.kernel.org/r/20220322173547.677760-1-nathan@kernel.org/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
