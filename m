Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3950C38F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiDVWN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiDVWMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:12:19 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6482E710C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:59:07 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f38so16643206ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xebxWNQuYNsiULkvsP8Xksi7ExUdkFx9hBwHBb7lxno=;
        b=fkxfcmkFOeL+3mJt+dM8xgC1BKfKmamAcSRTx467jTB3uqfbflUzssUVzH02MVcGYq
         A+OYzIgydCo/ZfHCesO5ybzjSIk+U9cDZ57szKpkov5OtuLSH3B2DvMfOQkmgMwFOUld
         8HUKJu0gt/C4yqGw4RgPcAhjg1Z+oHc8kFbnSfSVbEv++nCZk3vnnmQz8rkSYGiRp8RG
         I4LsW3JUK3CuvDRWEtNvkdNjhFNInwsd+u4xMcYTYXnEUmouZ7j126Azkyz6lGozfAd4
         VubeH+5EHzENhqjtgidGRv5AhFNNzZ6ZpcnKrjieD2EA+mH8i+1m+UflPQpmrbxCTPvx
         /QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xebxWNQuYNsiULkvsP8Xksi7ExUdkFx9hBwHBb7lxno=;
        b=A1ciH7gJy6q85YbRdOQHFgGthmYVtsQPZqkqnGWGPs2P3natMsN0cHG/Z9aGMqxiUn
         QiD6WaH2+FZ6Q3Aul72+PsFcKyONUgmKWBSGrn4cLcvqVSVTPvuydk/jNcakvqXAB7wr
         jI4Thz10ZAbmAAMFJZSJfxooPe1Oo+66+XTEM5OPF92nCVc21f27fFdxklCUDLnrfaLY
         aA43OIu4NQVOzKwTt1XPtcQxHOB1g4ih4qUSQSx/CUPOq5/NpKmRFf45Sh61SIWS/Rjb
         Luz2tRcJO8ylCbbl+8h3bIeb3Oqv0E7BpMCskeN3FTkNgNY8Sj0TQxqumus5Q0rB5lvl
         B2VQ==
X-Gm-Message-State: AOAM530zyxAXpBVc3uJ5k3AO+J3lnZqM3GTJKcZ9RD2uUFe6n2NbuzCN
        OJOYS0H4TjVwOZmHPnkWr6gYJAWOltdOqv2//0rd2Q==
X-Google-Smtp-Source: ABdhPJz6RHpkF4rIoCwoW3SD2TC5w8sxV/THHy1ewo+Nh1dqN167FqRmTsmEvmNqeKeg57QSnhU1jtx9DmxLtB8AxGM=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr6429543ybr.295.1650661146776; Fri, 22
 Apr 2022 13:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220422083216.304dd75c@canb.auug.org.au>
In-Reply-To: <20220422083216.304dd75c@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Apr 2022 22:58:55 +0200
Message-ID: <CACRpkdav4Lj9mbrk6cracB9+7V+4JUNqsX4ntcbuYTxaHru51w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:32 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Commit
>
>   c04c391aa743 ("dt-bindings: pinctrl: add rockchip,rk3036-pinctrl compatible string")
>
> is missing a Signed-off-by from its committer.

Thanks Stephen, fixed it up in-place.

Yours,
Linus Walleij
