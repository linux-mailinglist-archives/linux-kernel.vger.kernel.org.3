Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D655A8BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 05:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiIADQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 23:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIADQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:16:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A2DC3F51
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:16:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u6so20782680eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=G7ttsCuJ+J4/i3YBhKPz49AMBmOxDd9nfW8xTxQ4h0M=;
        b=YK/HTOaFeidBrISWkJxAv0RRcjxbKPsrvYdSRlC5iYmTFRM94m8seXKolYNCyWAfry
         PlRsUbcA6etASqDUHjas214kmY09uDBASTQYG9XmYDEvk6DVFlOUd1Yxa3/Hkii2xeyr
         TT7zDAdOUTUBmgFXR+oZqizpPkotwljSby1qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=G7ttsCuJ+J4/i3YBhKPz49AMBmOxDd9nfW8xTxQ4h0M=;
        b=hBH6Z8yAdk1po2ujvzNJe0glUmpM3NLgJ+tdxcDf7u2fufuQdePi0WLmoLn1v9t7vE
         Q0u8JnuHxhkBO8d9HV9qaL9fH30kWHudFRCPVa1EpGSMcXkOtZjRw00UuXlr1DJE5Uix
         tI/ERDrug7kx9WBl4cGGZmYnLswD2cnST1Yd4R3kuvmGeXZVr19ufxD9UBSS8DsBLJeU
         pesN+lEt9UQYC8IMENq+MreI0ifr9CLSRzy80hC1Z88sdxl6tuD1Ps1/1b8qCejF4ywt
         1FzcninOXnr59lHhygfry4+2VXeBkzb/ed8vdeKZs/BLgWc/sh4fJeFaILeMcxUZ39Vk
         f5LQ==
X-Gm-Message-State: ACgBeo06l162EzooKW3IDGnTdPNKSU4VgtaIRTiStRAEcuGt4CHKVX9X
        Tm53MmINU66tyAl6WHQVZirK0lGxMUpnqE7+VSi9MA==
X-Google-Smtp-Source: AA6agR7vJeE5BNhhen2MLdU5JdOhlrGzZODJxL0PCi4/ZVfXO6wKdzyhUgjU0FnX+CRblsDSypW2pprW7PvKD2IsvwA=
X-Received: by 2002:a05:6402:292f:b0:448:6241:25de with SMTP id
 ee47-20020a056402292f00b00448624125demr15550195edb.248.1662002194496; Wed, 31
 Aug 2022 20:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220831175326.2523912-1-sboyd@kernel.org>
In-Reply-To: <20220831175326.2523912-1-sboyd@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Sep 2022 11:16:23 +0800
Message-ID: <CAGXv+5G1cAdT8S7Ksr=SiHn8-ugMvRXEZkVXd9vru_nuQvVW0Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "clk: core: Honor CLK_OPS_PARENT_ENABLE for clk
 gate ops"
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 1:53 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> This reverts commit 35b0fac808b95eea1212f8860baf6ad25b88b087. Alexander
> reports that it causes boot failures on i.MX8M Plus based boards
> (specifically imx8mp-tqma8mpql-mba8mpxl.dts).
>
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Chen-Yu Tsai <wenst@chromium.org>
> Fixes: 35b0fac808b9 ("clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops")
> Link: https://lore.kernel.org/r/12115951.O9o76ZdvQC@steina-w
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Acked-by: Chen-Yu Tsai <wenst@chromium.org>
