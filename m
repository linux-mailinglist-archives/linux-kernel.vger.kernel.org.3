Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FEB530604
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346232AbiEVU5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiEVU5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:57:52 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530B738BD8
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:57:51 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id d137so22244986ybc.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NDRtCt5IKvrD75rRnXcuTW8iRXjJ/s5YNzt05pMQFc=;
        b=DtY/tZ/S/a4gtZJC3fElPoyFJfvl2m3F3LvHtQGgfyG623p97p9BSoIipaI8oQES9D
         hcGg4yM2FV+bvl0iHVBGzpt0u+ozsRBcY9EOzcCeUTcX4pQfmiWvJLjmO+HtWTei8iYQ
         uGO7+wYy5VNBlRN7TFauG7DzUXnu+uiFE6unoU6C5n+MJlriQxiCJnxjXbzbpQwf3HK3
         JKl8kj7l2fO6CFbnxHlfhSbfJqbFzWf/bg8E6RAEJixnfu4cYCdZdq7yMe9SyCHw+p0d
         1W5xLB9J8f/7EAf9dEWCDVeKEQfeIB13Wi0KwB8gAmU2uDkk+5fHaB3INM7dMOCEpfBG
         BfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NDRtCt5IKvrD75rRnXcuTW8iRXjJ/s5YNzt05pMQFc=;
        b=6xIS29QSndexwJrUiFw5mYX3TlEG6uKCNzBq7sX2XFd3OC9Lhho6UZsT66LqZaB5Zq
         N4QREL5EW6rg2C6x5TR5aI00WvZvWru+wi9N9ldMsRG/KPen8sVIxVJxDTQaNQ/CLoMq
         WwRCFyet0NYO50WsUnTvIEa410MYrZWz6mimfm/Qvt3Y+bZfhN27CFsQb96BRbX5uT3T
         Z9saPEY+Mp8aiQ9jHuzL3aeWay02zC+vgM4i1I39qZWgkQvKau/iPYXUa5ZEWu0kgXyp
         schMR6ofJWOivE/v3gqALvK4AANpBXgDq/svek+qlg4uEoskCh8unTCZZgAcrwJBsptY
         xbVA==
X-Gm-Message-State: AOAM532qEZQoWYnHQHu+WQOvfi/6RxPoTjnx/p0V46NunXJ+lQP+TT0C
        ZJtrXo7+Z1nugWzTr6OITCS5tEFnLRCcegK/rvCRBw==
X-Google-Smtp-Source: ABdhPJx/ekEjROZtlx4zO2rTZDqWJXb55TJCuZIiQvSwU8m6RMcAhb++WSUaqowRDibkhPUXxwRZLb/YXDf6rORlip4=
X-Received: by 2002:a5b:691:0:b0:64d:ab44:f12e with SMTP id
 j17-20020a5b0691000000b0064dab44f12emr18769020ybq.533.1653253070562; Sun, 22
 May 2022 13:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220521111145.81697-17-Julia.Lawall@inria.fr>
In-Reply-To: <20220521111145.81697-17-Julia.Lawall@inria.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 22 May 2022 22:57:39 +0200
Message-ID: <CACRpkdZBvfyCBzPsD1S2RWKy1eUhiQDeaFb2xuF5VgFnY3rGOA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ste_dma40: fix typo in comment
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, May 21, 2022 at 1:11 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
