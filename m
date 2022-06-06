Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950C453E3A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiFFIgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiFFIgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:36:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FBE44760
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:36:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h5so18901288wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e5pY7Zs2OeyJ/6j9wL70dA8FyT9sORckQyN+RpWUnRE=;
        b=BRR4m1BEWcRUiBLIqOz4FIWTu2zFCwLDbBxYE3zeOOH29FBHF/1Oo4KdfLmgmcPJqG
         CLnNc6v9+HgCohOv9rmgrN1MQwHy+UFFIi+8bfR91Im6MlZggPJCg3iXPMehZynHyK4n
         TXCV+/6vkoMGhSgNMK3ijECsuYnUeTRkXWwTyjLtYJUCvXh0EQ2f7a2bCwvweDmi1JY9
         gMhhYnoPUUN9tc86RSy90pXQ/DQZUi3Z4ftoDVvjXSq7C41DkWKt3s2ghcEIEM+iV9Jr
         enWYp7XJ+3jU7oHpAl+kxOuCwhE/ouRF9OFDJrTsW/Qfd89SZZxhQEddEqWOF8pIkRWu
         ki2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e5pY7Zs2OeyJ/6j9wL70dA8FyT9sORckQyN+RpWUnRE=;
        b=Mg4SVTg3+BYFX/WTF/He2ikbHfReKVsNBiLftwicm5dHQ8YCAuWJez+z6gu2g4IMJD
         WgsDRbbfSc1am4tfVMdxYPYyk/ZrzKKtiTnjTDYpwkeiQeBNa6yU9XbVV+Hpx5gmVOun
         8ovVyO/zVCTAvaaMSwcnsOp9/N7JwmC8oKqN7pIU0+6BhoYrwFugdb/FeJZgQNeAKgxs
         yrVgn1ahRR8UcU+lgO2XmcqO6887fOVh1E/HhPzTZYmJlxaxWJCAaapPGZiQ08qNPlbp
         C25Fosnw7xt+n1lbO5c4PSaJMLbHSqJbHxHimEyP6VvHXWHY01N88/AWopKHJNZ2L4LB
         6asA==
X-Gm-Message-State: AOAM532rt2RvBqv7e5Vd6bOeSGfm7G0N41P2tU7XyC/eUB87494Mz8cQ
        ngGb1eZufQ/l0XM+4xO+obwPw7Gca1Q=
X-Google-Smtp-Source: ABdhPJynWKJ2McUoRgVRUzekhmf0dx80C6IX53FZQHpFiInhu0fYWi9uD84onZOjZG23egsSNEcUsQ==
X-Received: by 2002:a05:6000:2a8:b0:213:ba0c:fef8 with SMTP id l8-20020a05600002a800b00213ba0cfef8mr15956377wry.485.1654504571829;
        Mon, 06 Jun 2022 01:36:11 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h4-20020adffd44000000b002102d4ed579sm14471478wrs.39.2022.06.06.01.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 01:36:11 -0700 (PDT)
Date:   Mon, 6 Jun 2022 09:36:09 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc1
Message-ID: <Yp28eYfDnX8Mepn0@debian>
References: <CAHk-=wgZt-YDSKfdyES2p6A_KJoG8DwQ0mb9CeS8jZYp+0Y2Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZt-YDSKfdyES2p6A_KJoG8DwQ0mb9CeS8jZYp+0Y2Rw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jun 05, 2022 at 05:42:33PM -0700, Linus Torvalds wrote:
> So the last two weeks were _fairly_ normal, although I will gripe and
> moan a bit about how many late pull requests I got. The second week
> started out very calm, but that was sadly only because a _lot_ of
> people left their final pull request pretty late. Not very pleasant at
> all.
> 

<snip>

> 
> So hey, let's start calming things down and testing this all.

Build fails with:
arm allmodconfig
mips loongson2k_defconfig

Both have been reported earlier:
https://lore.kernel.org/lkml/Yps1Jw6PJdLBya1W@debian/
https://lore.kernel.org/lkml/YpncSXSTTyKGprLi@debian/


--
Regards
Sudip
