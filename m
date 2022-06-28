Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A5455E3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346040AbiF1NB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346029AbiF1NBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:01:24 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355382FFE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:01:23 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3176d94c236so116306157b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hd3XL93MmgNxl9VBaLiuBcv4b/i5SRbaDxLlwpB+u/c=;
        b=MyZ/4vLxNMcMrNX+yXCZtcjXPFhB/wSlJiNjElM7eOk84dJ29151nrYiL+hOeKO/y3
         h0o5lkMD+XQobd2vuhZ4XA8NHx3aqU+xdZO6A8oMtVllozIQL+CyteZJAp+S/mYyAwUK
         AEqvbiCeBmAjjyCfMwEr09YJCiTzzo4rx8Zr899ktOAOUtak6CxdS91BY4CJ/3zMef7Q
         c0OCPBsrKhruavhT1RemPcfqB866KPsk3AjkDyBFbq5FweTNxTCNxQLfTOsRNyaaTcE3
         1o/uZWb02e7QeaFKX13xgi8s7H/cE419zmEQOHOKXjRbE6XFaDRAG0AJZ8xunIJnEcLV
         Uy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hd3XL93MmgNxl9VBaLiuBcv4b/i5SRbaDxLlwpB+u/c=;
        b=PXULLN6wMeLaUkPZptbbJXvURJFWMMycpkZfXe3HsocSSiaOmv1877nNlMiRwfY5A3
         WOStODApbWHlt7j5d2ENQRlP27dqzBuEi86T9DxnfiZIj5QnMejqVGKEI7qpbs4OQEWm
         +IdDG+nRD26sNk4EbgjzSznbu9PVKnjpEogjsUrCvF6XnCwmWRGpcP0Tjts6c/q+N4HQ
         4uEUba6fx/T1kA4UCRvKYuZpKmYPe8xjgeBMVWqbmaw+wFCEbKnDiSWIdlG5onUGatCw
         bNs9/tfgITzJTxg5Xq6xILCTNu7uoDiPH6csf8jiIXaATuFRWd7BZ4qRqnxQvROYRR7G
         DAUg==
X-Gm-Message-State: AJIora/k7ZpOE+nax0h/DCSrpfgJ06XEWNZJBCw9uMFoSN2QyEs7RBiK
        f0JF11qD0AB4RHPYQPZMW7PKG6QFKxZ0vekL0siusw==
X-Google-Smtp-Source: AGRyM1tJOYiN++gGQe7eYZTvdGtI3GOuEZN7WBcRrjsQLknyG7NlgzAgkMZlyR1dNIzVB8TKvCJGJukoZrhgqMle/lk=
X-Received: by 2002:a0d:e20a:0:b0:317:ce36:a3a0 with SMTP id
 l10-20020a0de20a000000b00317ce36a3a0mr22036265ywe.448.1656421282218; Tue, 28
 Jun 2022 06:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220622155422.23945-1-menglongwoo@aliyun.com> <20220622155422.23945-3-menglongwoo@aliyun.com>
In-Reply-To: <20220622155422.23945-3-menglongwoo@aliyun.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 15:01:10 +0200
Message-ID: <CACRpkdZVY+o684nGpEVA0umkCkkN+E3WC3Uc-dey8MUHMAkqUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: gpio-sim device-tree example with gpio-base
To:     Menglong Wu <menglongwoo@aliyun.com>
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 5:54 PM Menglong Wu <menglongwoo@aliyun.com> wrote:

> Update gpio-sim module device-tree example with property
> 'gpio-base'
>
> Signed-off-by: Menglong Wu <menglongwoo@aliyun.com>

Linux-internal global GPIO numbers has no business in device tree
since other operating systems have no use for it.

Also Linux don't really want to use these bases either but want to
move away from it, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/TODO

Yours,
Linus Walleij
