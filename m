Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094815B1EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIHNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiIHNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:21:29 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89299E55A2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:21:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so24352157edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yGzjUAVlbWD9K7WB5zdnXNvMsAG9MdKx18Dh/BG0fAc=;
        b=T+IPtcdLJg303fTaAq+ct5LWwvXOQ/rhVoGClZGMLoYPhMskJNU1QqUjBpaDX6bQB8
         aysHXs4c5+QV/fGHzpw6Lm9KAbX8P2lwqEZX62zLFZjvW8/0xTFB+5zF6AEa67/YiKBG
         oS/YRtgioKnhYbPZiAERB+c7qzh2bDvxLHeiNhcLDameybe8YdRmW2GRaUy94un4d/z5
         Am6C6RjA+Elb0Ua6loxzqY/pnzbTW0XbWcXVq0w53ZWmhdBtdM7k2Sq7jUOrRF9Z3iLo
         iiGJNf9dSTtQ2+bBF2K91nEj4KfaLqF2ZHeGg26GHAV1YTQ0Gd1J4qizLXne8F+NgrC1
         i83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yGzjUAVlbWD9K7WB5zdnXNvMsAG9MdKx18Dh/BG0fAc=;
        b=NXJKlqQejTHiLe18IodwdUMahdhqsoSLqMhWdaD5pzmZ9tLuXdpI/zsFfXGl2Ax9fW
         4nguQS3+X+f6j27HbIbTYY39KTN6Kro51GU+WnBDTcM3NhUkTCauq4Z783HaXPHTDs3w
         Cn0z/PMBIOP0OgQ0cX0rFxw0/qFbaR6/ctE8NE5UFUkPjADfpgExpBSwD7MWnjHolaep
         AdIAKGcjPueNMPWgAuE9xKOGI9vvjfvA0mkH8tm1X2MsZ01aNFIx+zSmzCjYNXExS1BZ
         47EMVUSdKh8npSgPXM2QWwWq3niBjdxqVruzJVsviA4zhOE5T+dlvFvlcaA7k0yiWgG9
         /sFA==
X-Gm-Message-State: ACgBeo2QBY/HLcTUF9fipiQDybMiZMCISaNLcuU8xzg+SE5uJ0/v72kx
        6m3G45SbfVM4jdjXROk4tydLOIrnZLidliWe+yisWQ==
X-Google-Smtp-Source: AA6agR5gu7ZZe9a+j6qGcOZMau8x3QW1vVI/bIdW6gIkpHsboKtJFXGRe4Kpf2DvG8FECjqzZPxoKKIEbjvKVFz3v08=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr7126269edb.133.1662643281146; Thu, 08
 Sep 2022 06:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <Yhe0pCpfeCpyfPWg@orome> <20220816102725.14708-1-pshete@nvidia.com>
In-Reply-To: <20220816102725.14708-1-pshete@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 15:21:10 +0200
Message-ID: <CACRpkdbMnRNTLcCtqNjKpxWxMbAXLssnuBEuNqAfgDfj3XVfXQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: tegra186: add Tegra234 PMC compatible in GPIO driver
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        smangipudi@nvidia.com, Manish Bhardwaj <mbhardwaj@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 12:27 PM Prathamesh Shete <pshete@nvidia.com> wrote:

> Using this patch we are adding PMC compatible string for
> Tegra234 in GPIO driver so the IRQ hierarchy can be set.
>
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It also has Thierry's ACK from v1.

Yours,
Linus Walleij
