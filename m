Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD18A5ABD29
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiICFKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiICFKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:10:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7ECDE86
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 22:10:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 73so3656768pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 22:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aOcDSKXlp0EJ6t3kZwqTuaD2pTzkFcj1dQ5Ha/6SqwE=;
        b=i3ztzSid1AsHGEQ246ZoUt18dJ2RfGY6Su/dIYUVyB3Zvl2oeioAtwvdwtZMszaMev
         Pwjx+rKu5ojbHnkpdEKrMW8T3Ukcf+6YOTriKmJsz1/nLHBSzSYOViUnsURhU2kmekB2
         zmhmYrgwLYhHDRIi3IQYfiZbEMW5Wbs/9pm7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aOcDSKXlp0EJ6t3kZwqTuaD2pTzkFcj1dQ5Ha/6SqwE=;
        b=cgZwrUxcp5L4K5ICjyZFHM2JrQ8ezlMRU6GOx/SD/ikDQDRIdKP5lTvXxUdg2OfejS
         PnB66ghpzsF5evNb4WtoXJ4wRoMMVKwUX2MADBdLYPVV6Zgv394Wpdu5LYHlUbWmi22c
         zzE+AatLbxJGT2MJacUprQ0uX6MjqldPSzYxBHRqmdtvx+7Jq5ZuGaAqfZ3TEKNAm+0x
         DqYi4JcU3db6lAY0ABLJNe78EKAZq7x0dZEZq9TuprzXmYIF2SWOLe70KGuFUz37x+h8
         YW1EPqZfbXFV4eRaAMDEhHng4mTerimRotNYMNIIzLuhZBBnj/Hqc3e7m7pyoDfFDK3K
         /RDQ==
X-Gm-Message-State: ACgBeo3HznB+lTR4SzLPNUVA9d0xCj6orFeq0wc4ptYNIjFXjfyM9xJB
        6LQVDpW+LEyI1kRddTdkEOlosthVScMAyw==
X-Google-Smtp-Source: AA6agR7hj5LdKaxooA4zyBk6NlsbsPsKSPfupmfzoKtd0brgGX3zgS/v9zqJPwxZxtXjN6+Xu5J67A==
X-Received: by 2002:a65:44c1:0:b0:428:ab8f:62dd with SMTP id g1-20020a6544c1000000b00428ab8f62ddmr33545276pgs.211.1662181803523;
        Fri, 02 Sep 2022 22:10:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090301c200b0017545ee859esm2610168plh.8.2022.09.02.22.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:10:02 -0700 (PDT)
Date:   Fri, 2 Sep 2022 22:10:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: Re: [PATCH][next] exportfs: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209022209.ABAD4C8899@keescook>
References: <YxKNA/3add4wxI3R@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxKNA/3add4wxI3R@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 12:08:51AM +0100, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members instead. So, replace zero-length array
> declaration in struct fid with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for a flexible-array member in a union.
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/197
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
