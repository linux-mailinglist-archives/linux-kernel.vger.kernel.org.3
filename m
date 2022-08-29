Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB4E5A4BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiH2Mb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiH2Mba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:31:30 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7283F1F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:15:30 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by gnuweeb.org (Postfix) with ESMTPSA id B1058809CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:14:35 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1661775275;
        bh=dq9i892mvDKO0rwREbf6FenovT7hGbfX3rv5JIV+Mc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hb98i53R0IWBkJe8jDFqM7WVowG6yLL6b9RSJXMw9u2HfGlpRZuacbViLMoanZrGf
         uBCqASRVcWqfvxUp1O5iC0eZo3Ko3w3GK8FUAt2hMe0pYw8igs0lTCOYPuIBoD2MID
         ScBuQqYZxygIK3mmroiKofaYFKusGdmkIb3X7ml05LdZYW5ZJkJ8+R6fakkxWdAMcQ
         iKQ8wgs5JbtVwNCf3N+uhtjug5dYFyf0F9u+0KX/1rTguNCSLlZsxwfNUs8+FMbflR
         xHKH+v+n1280RSfZs4JAC0dhgixPVKcjZTQz3Xdg4fzX1BZaHO70WNT8KVDzWqY9dt
         rafIr6oprN7wA==
Received: by mail-lf1-f47.google.com with SMTP id br21so5093340lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:14:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo2fG8aZAEoz4t5SCTc9KklorvKeZmB9F3LAxRZa0RBBUi92VakU
        Fmmjbq51I59a7xEl858LbAC5cNE8/QquoXEjJ7XWag==
X-Google-Smtp-Source: AA6agR7PccLuelx3iLdiC/EP4JwkX0TBM1sDVbNjzbUjuX9RrKIr21p2EUxQfcp1Dy/zeEOSLIdmaBQ56wd+eFhm2T8=
X-Received: by 2002:a05:6512:3501:b0:48a:ef16:2b5d with SMTP id
 h1-20020a056512350100b0048aef162b5dmr5848742lfs.186.1661775273773; Mon, 29
 Aug 2022 05:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220829105454.266509-1-cui.jinpeng2@zte.com.cn>
In-Reply-To: <20220829105454.266509-1-cui.jinpeng2@zte.com.cn>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Date:   Mon, 29 Aug 2022 19:14:22 +0700
X-Gmail-Original-Message-ID: <CAGzmLMX4vB=t_7ncjA4BmAEkd+OhKkEP9JLDCO9SxnEgUTn2fg@mail.gmail.com>
Message-ID: <CAGzmLMX4vB=t_7ncjA4BmAEkd+OhKkEP9JLDCO9SxnEgUTn2fg@mail.gmail.com>
Subject: Re: [PATCH linux-next] mlxsw: remove redundant err variable
To:     cgel.zte@gmail.com
Cc:     idosch@nvidia.com, petrm@nvidia.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 5:56 PM wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
>
> Return value from mlxsw_core_bus_device_register() directly
> instead of taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
