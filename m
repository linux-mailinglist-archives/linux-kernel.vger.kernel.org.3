Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385565977C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241819AbiHQUTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbiHQUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:19:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF18E446
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:19:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y4so1270219plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Z+/X/75bBL1X3xsZrV1lTZe7BZitkYfkSNopepMWJKw=;
        b=oKYN0loFeYxDm/+GmetyCtu1Ide2ixq91BmZy0oTuo45P4P+q3Abg106InTVGckOgg
         RCcY1a+ofoPtHc/7lKDqjCoeOrZvULlcVla/FR4bwd20lUWqz9ZxigaIhUlPVtwyrazL
         0PS3yq8YtCDvODS/mqEAnPbQgEXpOjP6z1F8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Z+/X/75bBL1X3xsZrV1lTZe7BZitkYfkSNopepMWJKw=;
        b=q6RdG47nDqgYhVMHyXmUml7/PLCspQLIz9MXVqctRznqomdoEzYgrSt597ogEAyPlR
         pUW6/8w7n93f7cXn7cxdyx9PlUWswxsyZH0hWF9pflx8eqqbDDP49YpV9XJPfEBY0+QV
         ATJFEmhhoNNOhiwGi23Ob9ruEtDHA6mqPbm0vUrejy+umC15i+E8vvFH/1ioerVUd9KQ
         djmGRlGwcsDfs1g5RDpsAqGInBQT/3qpJupHp6p9aLuNJ10P+itOccN1+WaDQA+UhxN5
         pXdRvAAYIWf+hwdl7+0kCQy3nVU1vYTOpLmk3do5MyU7PRu3DMw38N52BItc7AUgIj/A
         ujMQ==
X-Gm-Message-State: ACgBeo3gTy7aFogEnlM80XjtXzLnUGiTzcpFOFWUkmlMNH6s4VqY59HF
        GeKZmSrVgbb6xkP0FndNO2FLoQ==
X-Google-Smtp-Source: AA6agR7t6b2bE50K3de+5K4xMjXCNNOZWLiR9tXvxHlFRyvai7VeC3fBB/IeTXm527t46GMvyFgktg==
X-Received: by 2002:a17:903:24f:b0:172:7d68:cf1 with SMTP id j15-20020a170903024f00b001727d680cf1mr8575172plh.55.1660767585612;
        Wed, 17 Aug 2022 13:19:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r15-20020aa7988f000000b0052d51acf115sm10846638pfl.157.2022.08.17.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:19:44 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:19:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v9 22/27] rust: add `.rustfmt.toml`
Message-ID: <202208171319.24AA0B250@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-23-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-23-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:42:07PM +0200, Miguel Ojeda wrote:
> This is the configuration file for the `rustfmt` tool.
> 
> `rustfmt` is a tool for formatting Rust code according to style guidelines.
> It is very commonly used across Rust projects.
> 
> The default configuration options are used.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
