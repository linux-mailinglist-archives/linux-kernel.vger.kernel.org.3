Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8496D507BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355611AbiDSVRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242666AbiDSVRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:17:23 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E1E3A181
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:14:39 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p65so33361371ybp.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B5FkgS7CpCMD1fBHRk4Pg2TvAwwG8HWvfvSYT8z+CM0=;
        b=cWM1mQNRxVVmkRqvpJoS6HQ7n4uVQ8ZXRkav1OIuUXOelKwkJGOE/I5lh4mFQSdjQs
         9CywP7VVEHQcY0IMFPwuidd5CTnqBt53/BReu3XS6fO1tL8Dsd4kjIXv5l2hgfHpAE9w
         dOkGgbjywxdy2/bwAxkLlXpuAqoL1N7Aa3o/nhBed31tzQe5TG07pQxl08GFRBMAAiKS
         LiN/5rbJScXQbBkUNQKS3Ol0BSMkpZC23iHgRos10Z1Pp4sQq9svt/A0KUukNX9Bmx5Z
         9cE7gtXwERipmqD/bCVXKTx0bYgY2z55WTHhHsBZVY5j07YliDRhWaHLeDn0v+nhYZGW
         NRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B5FkgS7CpCMD1fBHRk4Pg2TvAwwG8HWvfvSYT8z+CM0=;
        b=SA3iBXNRs5PKU2hqCWggr2YsZrnIHDbAmD0+29UY7+VNtGQ+fevSaupUmcct6ROaZx
         7WCqQ5CliZEyEmYo1GATpi7t7nEXW5gswEdTVjJbC+YH2PprkxW0pQ90JAd5c4pT23Zf
         OSw+NEOM7qZby3qZJN74nzjm9TKXvfePxdwgIhJHuug0VH1xVOyOEztd2Yl4kQ4Y87Ow
         Z58vApteXA9UF+SifVfHiM8ShDla0Z2deumhLS5PMBXgMSg+k9eWsXh79zlsGBAbTXlv
         hc9Jbe6pZ60Z2X3P04KrZrIQ3USX927vmIbZEkyI6ciBuXUl/6RwGwgp005jUs3tGjoy
         ienQ==
X-Gm-Message-State: AOAM530/LZm8SWpUfDNRU+cymlK2zRFA0G19zaYdc5mQw5pRoNzAQZij
        Co1GZJBxmX89jNpT0rkHT8ixy/5WcNMVzZyl+d38pA==
X-Google-Smtp-Source: ABdhPJyUm04KA3osPPotEEqNmtRkf6e+697t9fH2aHJ9OuoYnB5ZhpMPCHKyoLBadeQJAgM1x+lwH2LZA0t7o/A48cA=
X-Received: by 2002:a25:a12a:0:b0:644:e94e:5844 with SMTP id
 z39-20020a25a12a000000b00644e94e5844mr12357883ybh.492.1650402878390; Tue, 19
 Apr 2022 14:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220315211936.442708-1-nfraprado@collabora.com> <20220315211936.442708-4-nfraprado@collabora.com>
In-Reply-To: <20220315211936.442708-4-nfraprado@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:14:27 +0200
Message-ID: <CACRpkdYbRXrqNwo-h2jn91xU20pQ-aiNxeJHxyK2uMgbKm7OsA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] dt-bindings: pinctrl: mt8192: Add
 mediatek,pull-up-adv property
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:20 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:

> Add the mediatek,pull-up-adv property to the pinctrl-mt8192 dt-binding
> to allow configuring pull-up resistors on the pins of MT8192. It is the
> same as in mt8183-pinctrl.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Patch applied!

Yours,
Linus Walleij
