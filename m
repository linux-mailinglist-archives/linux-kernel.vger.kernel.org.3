Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44251CBAA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386111AbiEEV60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386054AbiEEV6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:58:24 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4055AA43
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 14:54:43 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f863469afbso63689457b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCoDgmddTtLI0GdQtfmKUixQsE6y5QSv0lEy17c3ipQ=;
        b=lu6mB205lEz4Wg1BqujKbELrVRbwubcWwzgfdPgmVjlSIGNeqVjtkWF+FObQNiaz98
         dycvzgpN8F2gnP7KVop+Gue3xaE0k8b8zPlaIeQaAm+Et5W0Uzd6cV+qCKIcW3PGzcPY
         WTsrJx6SKQUiKSpx07cO21m+c7p5f3S/9b8PTFJ5WYT+Sh1+zjemHtVlFG+Y6wGaiyLw
         fGBF4On5MHDwT/MaJgQSA8dIzSmED/cyUKtDx+kI+esrpNRt38LYF5v+Ov+W3WilJXmi
         HDuxTURVly1cdX4MqbcXnXM9soJds3OThmXzHcH1TsW0GUYA6dRco2rEQuiCUn6pIuLU
         9weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCoDgmddTtLI0GdQtfmKUixQsE6y5QSv0lEy17c3ipQ=;
        b=GFYpsJTCeXXeEZfBLkRd54TLyL2Yu1ugX6g6lQTrxCRQRdo+coubJ1xgBerda+kqRr
         q2KX+/fbgftqUG37PHvU2MQir2lHx8GaLxd+IT7F87Wrkam7hS9yYY9bVZreTGcx7M4V
         0m6QCicH92ER86Mc53t3KkXjqLCWsWg3U6+6Je6YGk55IQ8mzWCboawdMBdYXMjiorll
         BGSOVGSnJQjHZ7kPNV42smhF6irAlVdeNUEDdB4W/866eBeMhDFm5AkZcV+XSHJvosWg
         QHCIWc4xTURAGiGn1HHyRa6yDPPAw6NR1eSRpMjL3M0BU0brUlkNNA88+thCpcyPBmvU
         6Fog==
X-Gm-Message-State: AOAM532VUNAZkrzKurw4bBDzyI9fAy4jFPfaEoyHgiNI9byjtsc3Xvgu
        oQnsK09rlgOIJizDUwTa6dE9MsBqo5aMWzR1373dvQ==
X-Google-Smtp-Source: ABdhPJy7/124+1LI10Jlw8d6t97wM8daplTn9Eb7OgCD2ZOkd1qQO0Zvn53MloyRf2+Dr/cFkj/pJF6YdBjUseWWSFE=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr184278ywd.118.1651787682943; Thu, 05
 May 2022 14:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220318103729.157574-29-Julia.Lawall@inria.fr>
In-Reply-To: <20220318103729.157574-29-Julia.Lawall@inria.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 May 2022 23:54:31 +0200
Message-ID: <CACRpkdYyAhQ2MQQmBsGs9PfTEw8H8bcr4ii8WC1gMehQXr+DqQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: gemini: fix typos in comments
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        kernel-janitors@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Mar 18, 2022 at 11:37 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Patch applied!

Yours,
Linus Walleij
