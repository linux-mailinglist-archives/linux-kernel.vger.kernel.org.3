Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4290756270C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiF3X17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiF3X16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:27:58 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1667F44A2C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:27:52 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id b23-20020a9d7557000000b00616c7999865so557135otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=SH4c10UHd2jm5iXZMsMlumPvXgKDKSukPGr/j2MwBes=;
        b=DOYeB54ERnxkc8KCdfg/9ohDBPJKXF4Zj3owMi8p+AOUa5ARLSnQ6//fWAcXaUSeYo
         pIbJo7hLhKev5eib3IyLpSXkMUnnDGAeqPNe8oSsRGAG/ReIqkW/mKCkXzKhz0k0zx7P
         XiC1PDBqdFcx69rKuM+WWlCRM4kpBxZ2tDOdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=SH4c10UHd2jm5iXZMsMlumPvXgKDKSukPGr/j2MwBes=;
        b=qA9KV4A6qCm+7DfX1iCSvkdhaL0QnfSresmEnFPTnxo0Q1BB5AMr6kf3jOLPnSyBwe
         nwE3f+7R02qTsgFO/+e+cjIoStMDxuBCYRQbFOKy+6MGQOJuhEDKxEi7UgYwhVNdQx9B
         jX1lnGArhM2MauhUltztA99TEOPhS+ed2BQ0aGkEeinAvwtGd9I/Spkm4nGu3VA3GhHU
         aY4cXXqOzHnSLH/QPA2/dLvS+58pXnIOjBgPnvQWscs2TC2rNg5RoUKx75g05M6TQ7d5
         7lhSZXxWYaLsGThxga22NB5AM+dNRlyQ2e06WxCm0RpukYgl59whM8vf7wThcPP6kwrb
         jWRQ==
X-Gm-Message-State: AJIora9IW3QHWHFOkGkbmQJuUehRaypjPMuxj7AK9UidpqHTVIZ4NOEN
        aYc38FD7rD2k7YSjaLoQkLTHU/uRsCGaMm6OO6EF0w==
X-Google-Smtp-Source: AGRyM1uVXOUlD37mLQ7pLmkL8BIEdZdsnlXTlVxy7cY0Oa3nZ1gzq/kLiCUOdFyoe5MDzqiDJ+32/N24XhJQNeSiK8s=
X-Received: by 2002:a05:6830:d81:b0:616:c424:6f22 with SMTP id
 bv1-20020a0568300d8100b00616c4246f22mr5252300otb.77.1656631671458; Thu, 30
 Jun 2022 16:27:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jun 2022 16:27:50 -0700
MIME-Version: 1.0
In-Reply-To: <20220630173328.1369576-1-hsinyi@chromium.org>
References: <20220630173328.1369576-1-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 30 Jun 2022 16:27:50 -0700
Message-ID: <CAE-0n50Pe2=tYeuuhBVHsTV9BqU1huU-w-xMMn-1scj2OxBWbg@mail.gmail.com>
Subject: Re: [PATCH] video: of_display_timing.h: include errno.h
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2022-06-30 10:33:29)
> If CONFIG_OF is not enabled, default of_get_display_timing() returns an
> errno, so include the header.
>
> Fixes: 422b67e0b31a ("videomode: provide dummy inline functions for !CONFIG_OF")
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
