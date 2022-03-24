Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5124E5C51
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344480AbiCXAbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiCXAbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:31:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8500844A01
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:29:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id v35so5700699ybi.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IoqbeTUYBXl4uFbe11Nv7ujLCyRHTKu8zwCbTPd+B4g=;
        b=B6bbJPx5LvPTGsPiEaAoYSshdK4ZXXs/KxQYowT6uJiSpQY3jRJYJdYJtOTCeCj1Jp
         VLIHW2QvQrH2nhf9HuXlIaXzaFCKXaGbl3gVSRvuYAXoNn9NoCelrUaJY1vbzgeL3okg
         CuSVSlx1SSAKb3a+F9nOis7ZgmL4KcjDLfYJbLB4SDnD5G+qiQ1ttGbtoQEdsRyMCZ4u
         SyTmy3/p+oQFA9OA26bSpVwZHDvmLQuL8ip69jDcKzL88HBJKENPzz9JXJFUKVKCsHi4
         94QwyaRx+QA8jCiUVovAtrhRMIqvWaRMCoFCfAqn1Jt2+rK4FlbTU6AVAf9RUBotxqrg
         joDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IoqbeTUYBXl4uFbe11Nv7ujLCyRHTKu8zwCbTPd+B4g=;
        b=BUsPNH0gh40v1EBYamanrMZTw6QKzCRYooqmarPmHfg/ytxSzxTuzO34OAXiFw0jmt
         fH/eyFwJP5mITCRnpQnae4cUkOnBthlCuI08xMx71uPHx12VY7q03JCKaDPkmW0b+B5V
         IGoS1Oww0O/jYSMcxCCQU5d/j/9iFopR9whFpQIInP5vLSRnWj5Ti4f0a/dRKGXsqY/7
         nr18/TkHiCVcG/v3Z7wn/FhJdc5y6auQH3RTkbMd7k3m3zmJpB0f41Cjj+fJWIlrnATT
         uArFoWuBSPBP/+ivWzh4SXnWgvMKgzwaFMg9ULOs4ezYaSdsLdat+fjFiZnou4We9bmi
         Nsrw==
X-Gm-Message-State: AOAM5310Kdv1XBxZi47cEe4npjXRzAPQNnQ8g8z/exjS6H6M9ZY1xixg
        byBKo7BK6GVQyQTpfDF0aLqXazCqZLvq6YWcVJORyA==
X-Google-Smtp-Source: ABdhPJy/ox6rylfO4sLmWMhWY4C8zE3bHDFkkZfn9py0yyNh32/Bwu06zQpTJJoZzwB7RCcy1EYaTwgU9oe6bDw0iME=
X-Received: by 2002:a25:4e82:0:b0:633:68d7:b864 with SMTP id
 c124-20020a254e82000000b0063368d7b864mr2588238ybb.514.1648081777824; Wed, 23
 Mar 2022 17:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220317114413.1418484-1-j.neuschaefer@gmx.net>
In-Reply-To: <20220317114413.1418484-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Mar 2022 01:29:26 +0100
Message-ID: <CACRpkdb1zg0yUfjHEc45-G2+qf=T2=R-vzuTaec0p=OfQ5QTZA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nuvoton: wpcm450: select GENERIC_PINCTRL_GROUPS
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:44 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> CONFIG_GENERIC_PINCTRL_GROUPS must be selected in order for
> struct group_desc to be defined in pinctrl/core.h.
>
> Add the missing select line to CONFIG_PINCTRL_WPCM450.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Patch applied with the Fixes: tag!

Thanks!
Linus Walleij
