Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB07F50D7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbiDYEFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbiDYEFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:05:03 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5B65FB6;
        Sun, 24 Apr 2022 21:02:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q12so12338687pgj.13;
        Sun, 24 Apr 2022 21:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XpqXUKQnBMu16RDI3lug4RWsduF9+QynmSZQ3BCqjAg=;
        b=dRi+fDayDSsY4PNuZojPnc78erUng+iTE61/if5JtS9deSN5Kue2wbhrHWwIRwJsw0
         uRKEZZq2d0oQzKHVnCMa+BOIAhpyczU4b1XENcA2or9LBLCAtYiCZYYq11m9+wW1Xih0
         verUXesH6xwXZ5u2pAD6egcZgQusy+7jzrSrE7OoiMcDDzSwFe8aMcoRWHp4fjNmTRmA
         IKNo5CcXN7Ns1IIHoBFMPFPtkda9PFAsAnyKWLvDR6Sf2qaRswCR4XdyNaJFEehVfSPE
         TKsXlCXUT4IcnDYXQGMWIITz1O+Mz2yFdi7ymEn16nHtPjZf9g17a2rf4RX2LI777YXb
         JXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XpqXUKQnBMu16RDI3lug4RWsduF9+QynmSZQ3BCqjAg=;
        b=jSLjktOInhWA8BIUUV+5c6yJTdXqk3ijeaBNqjcpYElMbTKYOQSDgHlVoEYoR+HA9J
         VpFcKgpoJ7RuBNvmU83/aowj0BvlxTIsrpmDexWCDSZeBhMq+m4LHqu+9dZeeEfihcSm
         B0rtj2l1U5by1ZT9oKsnQBH1XUWBlpilvMGxdtBPjpYEq7kFJUz11KfuxXbuNkGoc7mq
         TSgJV0xAP0yp1kSplJyvoLkeaqzu8lPdAfiKov4lghn+gMIQUFcbvCcrNBt5OgFVhDMT
         jcEDaRKIqBc1wrXWhDDX8AIVNjadx+UOrz1HqNf54wck8vGynfieDedeuVit+qicKmWj
         iy2w==
X-Gm-Message-State: AOAM531Aw72xHpMK5C/s3A9UwkgDXq5jshGstG+9pNyB7+hkuD0dEua1
        n6tDrxKkEC1szHHSZlgk574=
X-Google-Smtp-Source: ABdhPJx3mcsUbCjgVIlR76wYqJ8xMmU4F0udievDmHkC2+5Ct4NkT4XlJe7M5Vsc+lyReFF2m1CQvA==
X-Received: by 2002:a63:fc18:0:b0:39c:f431:8310 with SMTP id j24-20020a63fc18000000b0039cf4318310mr13368460pgi.433.1650859319693;
        Sun, 24 Apr 2022 21:01:59 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id g14-20020a63200e000000b0039d9816238fsm8004385pgg.81.2022.04.24.21.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 21:01:58 -0700 (PDT)
Date:   Sun, 24 Apr 2022 21:01:56 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] Input: aiptek - remove redundant assignment to variable
 ret
Message-ID: <YmYdNLCRKZtuZG6D@google.com>
References: <20220418142457.84708-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418142457.84708-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 03:24:57PM +0100, Colin Ian King wrote:
> Variable ret is being assigned a value that is never read, it is
> being re-assigned again in either path of the if statement. The
> assignment is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> Although the value stored to 'ret' is used in the enclosing expression,
> the value is never actually read from 'ret' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thank you.

-- 
Dmitry
