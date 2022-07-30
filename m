Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA758584D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbiG3Df6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240117AbiG3Dfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:35:40 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937BB1901A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:35:30 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31f41584236so67315457b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wQPQlV7apFmdAUsFT8uJyYaVCkVufIRKulfJqIm3SSw=;
        b=ZT2MMNv6qiCqlI600Ig6b2L8iRnFwfJquxCn1XYJzn0H8G46TfJLCNCKWvF0n2jPKE
         cL1xo4u/MpaZUgHgaUrvdLfSGN52FTRzbY32HyFlsPIN013qaIfEaGcgVz9/OOZ9frNE
         giYlc1jSqeXT1gmIiCPlerAuNKKTOxpFIUNJq6xNHdLSzBRHq/mcpFd10jN8j/SlQKT7
         Ic69vavUNAwl/q73AmgP5ql7tw964rTvC5zclj9oYv8C7MY6YcWfp6rbmXeQtB8WYFWu
         Oj+YL4y4t4c40uPwcl9vcZgXpDAH8CMdZr0UCO05HH0ghYJzgfFspgTTdlJ96/Brz+Cm
         UioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wQPQlV7apFmdAUsFT8uJyYaVCkVufIRKulfJqIm3SSw=;
        b=L45B+f0x05UAPNRxBJ/62noGFHILg7Cu+dlFbiGQj/4Q1hPtx97QcdQx6WjSBP9+lK
         +Y41dc1Bd18hItNJKPbu1zl+ZklDn/4E3Aw89q0m40K8psDVDTsh/WkXKe269ga7gRgf
         KByIU9WiqIYFCBZF+jobkVyJdU8iDM3Ds8iKNlea9k6GhbcGvc6WIr/VinNiKRqsICgC
         cYncv/PAgcFaPuBuhMUKKwkPiRdjq9gqzQ+j0FQh61D3RfZ99Ya9akP+RpEeMoxbm1vZ
         7itjel/wxDw/dTO7LUvgnKcg4JKJShI8WFKjaQfl7+/rlHmMzvqG3tN/uZG4wunl1xbH
         zQJQ==
X-Gm-Message-State: ACgBeo3/vurXS1S1b13jebl0XpqgjrG44LyxxizBw1VNNjwycc5B4U5E
        XimU4djJJw81Hrhzj6J+yRC5I8bQjYfa2XxZCXc=
X-Google-Smtp-Source: AA6agR4QY9761VtnH9U7F4uCzTjxcUz++vqV+cHnk6luBTe2FaF20W+gYT5CRUSs6UUGu7R0D8JPtHHQ5WAVxq0O5JU=
X-Received: by 2002:a81:4845:0:b0:322:ae4a:f3de with SMTP id
 v66-20020a814845000000b00322ae4af3demr5560045ywa.398.1659152129678; Fri, 29
 Jul 2022 20:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <YuDdHMaB6jWARQzA@kroah.com> <20220729035230.226172-1-ztong0001@gmail.com>
 <20220729035230.226172-2-ztong0001@gmail.com> <90a16ffd-5a08-0ed3-280e-bd5c4522525c@gmail.com>
In-Reply-To: <90a16ffd-5a08-0ed3-280e-bd5c4522525c@gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 29 Jul 2022 20:35:18 -0700
Message-ID: <CAA5qM4B_7wvnB8U1kgQpcn81sazp43wn9dYa+SQzh1iwGKp2eQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] staging: rtl8192u: move debug stuff to its own file
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:23 PM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 7/29/22 05:52, Tong Zhang wrote:
> > This is to prepare for moving them to debugfs and fix rmmod warn issue
> > when wlan0 is renamed to something else.
> >
> > Reviewed-by: Dan Carpenter<dan.carpenter@oracle.com>
> > Signed-off-by: Tong Zhang<ztong0001@gmail.com>
> > ---
>
> When I applied your first patch I got this hint:
>
> Applying: staging: rtl8192u: move debug stuff to its own file
> .git/rebase-apply/patch:399: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
>
> Not really an functional issue...but
>
> By Philipp

Hi Philipp,
Thanks for the review. I fixed it in v4.
Thanks and have a good one!
- Tong
