Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34934D8703
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiCNOgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiCNOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:36:39 -0400
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806AD3CFC7;
        Mon, 14 Mar 2022 07:35:27 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id bk1so8442684vkb.5;
        Mon, 14 Mar 2022 07:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZysgtXfsvATJN+SzsQw8W599UCzEtICCfKvj8cL/+Gg=;
        b=aGF8rnoZYeM65FIThcGMDozm5aW2n5v24bj7a8VULlgxdK490IiSAmZw+4SWKABpWa
         jz1/j7mLWVBH3bd3RqU/r+05PGDbF6uditrl2C6xHcZ2WC6zy5XlQO1UQjj50o/oRzyc
         bELq/xGw2fiPo+/7CHfDcuX3jA2wBhkqpEzyORm22Fb1+5LAtmeBC6c2sz5ryczyhnYr
         7FkqT9qIORrWeCWwvT8aGogU9h9OlyIali9CI0h3X5fQdYDEDajSoowvB9OjMSEyB9zq
         ooYwg6Iptfk3Lt4aFOQ+hvQvFBu2bIkYIo7vFpSwjzvyyT08qrCsL9OuXZew66vqCHla
         WM8g==
X-Gm-Message-State: AOAM533EjsZrWOelB5qsqCkvGBG3DYn7kC9bL0QmGcogotcX4KgLduvo
        c0JIVrsJM+K2rDrVE0paSjiHp7KxdldEIA==
X-Google-Smtp-Source: ABdhPJwsawgClGzDb5RYaSW7oDljl3abuBQaB5et3JoDtgbPLz2wV4K6ahh7jB6w9dHWrtuG0+eMcA==
X-Received: by 2002:ac5:ca0e:0:b0:336:d060:f33f with SMTP id c14-20020ac5ca0e000000b00336d060f33fmr10149957vkm.39.1647268526280;
        Mon, 14 Mar 2022 07:35:26 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id u6-20020ac5c926000000b00330e8c9b1d6sm2289641vkl.39.2022.03.14.07.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 07:35:25 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id z85so17311046vsz.5;
        Mon, 14 Mar 2022 07:35:25 -0700 (PDT)
X-Received: by 2002:a05:6102:364a:b0:322:b4b4:6407 with SMTP id
 s10-20020a056102364a00b00322b4b46407mr7372287vsu.39.1647268525337; Mon, 14
 Mar 2022 07:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220314115354.144023-1-Julia.Lawall@inria.fr> <20220314115354.144023-22-Julia.Lawall@inria.fr>
In-Reply-To: <20220314115354.144023-22-Julia.Lawall@inria.fr>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 14 Mar 2022 22:35:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v65eFvx+by=t3DEqV1w3ciQ4ruWtDXW=6teSFDqKMWzXxg@mail.gmail.com>
Message-ID: <CAGb2v65eFvx+by=t3DEqV1w3ciQ4ruWtDXW=6teSFDqKMWzXxg@mail.gmail.com>
Subject: Re: [PATCH 21/30] spi: sun4i: fix typos in comments
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-spi@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 7:55 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Chen-Yu Tsai <wens@csie.org>
