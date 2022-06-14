Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0EB54AFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356693AbiFNMKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356483AbiFNMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:10:26 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93F748E7B;
        Tue, 14 Jun 2022 05:10:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s37so5708824pfg.11;
        Tue, 14 Jun 2022 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Mw0EQvrU7rnu0xsHd/85d5zmXokM1828mn5qv/9/7pY=;
        b=IdHqyEQ5ZxrIpPpcXsfUe9kU0utW++E7PzruvcWj2bH+qq5j1rOoA/Zs4KRgJVDPJB
         FwZEQH8gRuSUbEkeKH2O+CdzNYuYbC+yWsBpHAF3CuF5mTw231bjPkiuSq8dPiGJ8cRw
         9C9qIkH6p3LbKyEVfCuH1mg6kttUOxvHFG1IBoCip6r/l6GK0U4YY65FjfOsnfvWY2qt
         cVdRNmNhAH6OAxTV4+xu4PWGbKHX/qMoVIwVf3CC79ULH5BhY14zUz3Ory00Dc8wGq+v
         v+OBeshLEcU0L5wQeEXDBuLURFZEhz4LFh4jkntnUVKau4UJaYHuzJJT2I67n4eL3qYm
         yXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mw0EQvrU7rnu0xsHd/85d5zmXokM1828mn5qv/9/7pY=;
        b=6Qyp9tJ9D22Np8w1GIGhJbfZ9tnTskJwEDUqnhVCMXA9/VMcztepSyAYtY4jMP97Go
         O4vpA59MKwpmN+/oq16+jHT8BBazRNykT/YGC558iTGyDFwqrn02QN5A8ovdqQjPlyAq
         5nHJaha9O+jwdXikfbtT8tyia4AO377ZKO4ovGuqVhh0b0WdBjiD/XgLEctNjcQaienA
         9AdAnJNajIj34OPLi9RyB2Y26++sEL9W2LUYlJHhzesFHGhPyWPJ8bFGqjTIdPNn/1RM
         nq2/H2pOHHLBImW/NMVhKH1mUHPogT02yhwq3NvqkXOCRojatQLg4QODTk11Vpd+4NBQ
         WDSQ==
X-Gm-Message-State: AOAM533Ubjkg6VqXN+dNOJG2Efyzwfr5y/PBceac9ESwVEL3w6CtjDbp
        JQ/pN8CewUZuRCsMY1EY6Kw=
X-Google-Smtp-Source: ABdhPJw4eED7I9ElEerUgaqmPKpAQIi60hKd1blZwLF8Y8+rUFNbj0QxxKpNqFpkHgkfj5dWcsQQZA==
X-Received: by 2002:a05:6a00:9a7:b0:51c:3e28:1501 with SMTP id u39-20020a056a0009a700b0051c3e281501mr4414402pfg.86.1655208624312;
        Tue, 14 Jun 2022 05:10:24 -0700 (PDT)
Received: from localhost (subs02-180-214-232-21.three.co.id. [180.214.232.21])
        by smtp.gmail.com with ESMTPSA id f125-20020a62db83000000b0051be7a8c008sm7435411pfg.30.2022.06.14.05.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 05:10:23 -0700 (PDT)
Date:   Tue, 14 Jun 2022 19:10:20 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: Add closing marker into comment in tty_ldisc.h
Message-ID: <Yqh6rL7nNvR3B5Ix@debian.me>
References: <9bc6d45d-48c8-519-1646-78ba22505b1f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bc6d45d-48c8-519-1646-78ba22505b1f@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:50:54AM +0300, Ilpo Järvinen wrote:
> The closing `` is missing. Add it.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 

Hi Ilpo,

I have already posted the same fix at [1]. Thanks anyway.

[1]: https://lore.kernel.org/linux-doc/20220614091214.511791-1-bagasdotme@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara
