Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3A4572F78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiGMHpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiGMHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:45:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664CE587B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:45:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y8so13026134eda.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8X4Vu2ZWa6I2Um12C1RT93BfuiOm6mADzjzffETS0E=;
        b=KsEYsT+mc+QR6aljberUmrYNjYdRnlNPdInbbYEHyF0SUBEYYJZiiFBo38+/qD7e+A
         mUIoacQruGvCNM6scS9Awws4l0XCcIWlS4vbFGxbMRWUSel5AtB+UqHa1rBlZXbSKsTa
         /wy0+4/VrxgHxQ004IEEBYs4NNlVBhnc/v9QF7hFmDCZrGEdV9whwd8BTAiMu+BGy3AR
         8sDGmY18C87/toTAMqtZubTaOKwJlWV1i9I1qpY21FH3vvui3Wg+AFfTf96OWLNKqkYF
         Ylcv83c1gIYjMoQGmVzIbkdL7ekQTbfrPxOmsXWPN3bSuomauma/S+G26KuNFFKblUfr
         xaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8X4Vu2ZWa6I2Um12C1RT93BfuiOm6mADzjzffETS0E=;
        b=8M+z2avIjSSCKtFaPur2pAFn+pACubpakjwk8GSbxj5+Q2NFuiM1rBevRaP8QYiWkZ
         1G1uFyA3RCGnXKGQIV9iKWnX4Oc+D9TYLOOSTaaj5CndN+9bnlmd+tTQiT+siHjRq7DR
         mph5F79omoEaG+vD1iYVs2zbGipY7/bZZDvktDDOTGS72+4EcuFZeJj8vt99KLA3zT3m
         qqA0ZyfMRNTlIEjdER0/6HomRAi1R2I8uJe2FHLs2Knd/5ukbPYN9Urn3j+Wv6gZaFHO
         w02JNPLVSTPmrIvEEL6z6AazyjSx/4uTKhd0TzUnwidm4llhJKQ6Jm+awc7BrdQJoo+8
         6jSA==
X-Gm-Message-State: AJIora9ccjdxIPztFbk62O3Hu+93hwTbzJrkJSUVJv5V4Jc6EhHw7InF
        xTyp/tYNVskQlR3cTIacwCDTh7efD/F3qV6HtzqwFZrwwqw=
X-Google-Smtp-Source: AGRyM1uK+GJnmRQSEDTIyrpUeGU/Je76t9/u0s4eyZnuvDVk5Z9WnGH2ApQW6J0G9aY+2+WekuhSQFSXVyw4AwzafRQ=
X-Received: by 2002:a05:6402:4c3:b0:43a:f612:179d with SMTP id
 n3-20020a05640204c300b0043af612179dmr3066980edw.422.1657698345414; Wed, 13
 Jul 2022 00:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220711141753.32523-1-aakashsensharma@gmail.com>
In-Reply-To: <20220711141753.32523-1-aakashsensharma@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Jul 2022 09:45:34 +0200
Message-ID: <CAMRc=Md2pUk0FuVfYDxP602vfUR+BWLLiNtpwzOP1uHz5SYxYA@mail.gmail.com>
Subject: Re: [PATCH] gpio: 104-idi-48: unsigned to unsigned int cleanup
To:     Aakash Sen Sharma <aakashsensharma@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 4:18 PM Aakash Sen Sharma
<aakashsensharma@gmail.com> wrote:
>
> * Removing checkpatch warnings.
> * No functional changes.
>
> Signed-off-by: Aakash Sen Sharma <aakashsensharma@gmail.com>
> ---

Applied, thanks!

Bart
