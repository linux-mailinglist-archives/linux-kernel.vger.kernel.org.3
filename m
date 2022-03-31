Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF8C4EE29D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbiCaU2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbiCaU1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:27:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2013231AF9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:26:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so538730pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Fg5ZxIipH5PYa+giih/rYg46mfwxn+q1qs4/fWsb4Q=;
        b=OxonsWzIo7ExfnfAPBaTV3n3cDc0Yw/Ey66WRX5e4RkPkCopxCKlqRKouuScTp7Pax
         vJeixqAYT0J2DDo1hYEFYZut7Y0895ZGzoq8ZZOu1tESV72hD0eGq/O4Ir3x/sPhFvCj
         +Szzqwt78UQ6RDQ2ZQNgJGDVm2yjrsF8QBptE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Fg5ZxIipH5PYa+giih/rYg46mfwxn+q1qs4/fWsb4Q=;
        b=1pAaSrvEt5UC5w6FzlyYOZacnehmJeC3lw8X1yJs/DAqAvFiEibeG+RcgRq2dQVeVo
         fUrd4ADxlLVQ/qQbwLUJzmhphanJeXqqW03HucCJDPGwIH1YYCeXml5AHFPKJ/9YPu5C
         8GznYGqXcTSSA3cMnmE7xYVdVW0/prR6Zpdn7+eodgdE22E4RLBHnU4PI6rUKUdtHgXX
         56BF3tBavkgGLSkkp/OheJ+vriAyqMQyyZtCBLpx1ju3POZW17VrsysZTMBrg4LkJ++4
         dzV2Zs7i0vZTBipY24H0ECgGV1UzR/yMzXjv5qqh43FLgpumTwNYMgaMLCT1XZbscUqm
         wUTg==
X-Gm-Message-State: AOAM530SiVmzsb42q6e+LoBy9spsg4sKhiDXpN7u7mY6/QIW3Wz/KlEB
        RooEcq3Wk/7ltw5UXinuWh6BeWuWk6yiNg==
X-Google-Smtp-Source: ABdhPJwrvzAbjDawgzxeZohnaBoU+xXfcUVHsMqf21UNWDhm1cojLu31z1us0nZFL4dWzclDTYDuvA==
X-Received: by 2002:a17:902:dad0:b0:154:740a:9094 with SMTP id q16-20020a170902dad000b00154740a9094mr6707894plx.107.1648758360450;
        Thu, 31 Mar 2022 13:26:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a005000b001c7511dc31esm196186pjb.41.2022.03.31.13.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:26:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Keith Packard <keithp@keithp.com>,
        Gustavo Silva <gustavoars@kernel.org>
Subject: Re: [PATCH] uapi/linux/stddef.h: add include guards
Date:   Thu, 31 Mar 2022 13:25:35 -0700
Message-Id: <164875833218.953539.603296054554390981.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329171252.57279-1-tadeusz.struk@linaro.org>
References: <20220329171252.57279-1-tadeusz.struk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 10:12:52 -0700, Tadeusz Struk wrote:
> Add iclude guarde to uapi/linux/stddef.h to prevent
> redefining macros.

I cleaned up the commit log and applied this for-v5.18/hardening, thanks!

[1/1] uapi/linux/stddef.h: add include guards
      https://git.kernel.org/kees/c/55037ed7bdc6

-- 
Kees Cook

