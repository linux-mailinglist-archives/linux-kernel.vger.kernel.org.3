Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15C5A715B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiH3XFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiH3XFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:05:21 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C403E5C352
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:05:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a15so9640117qko.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=03xHIim8cJwL2orZIsFEEaPEGZ5A0SO9Xy6iHS5VgRo=;
        b=CLAQbMcLQlcO5FDKowqIzEN/KN92ak2XZyugeDeBWg7w2NposY2Jj0vc3RKSyaipPC
         5n+rz5aN9vrZdZcWobBxzExvlxNeAKQ+/ORw9XCHzmowsMF8FfKOBcIgL7f+sBLdAcVE
         pzG6rVKv/POhYE0VTsQSMArU1JrCgmEL0sSco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=03xHIim8cJwL2orZIsFEEaPEGZ5A0SO9Xy6iHS5VgRo=;
        b=hWfR1R2vqiJ96XJnb6D/dVgVUUTQzn82V4FBYPvRH8eRXbqS4fAbvtS85/9+8nqWkL
         FfTeOshIncz2HvhjItuvWmZxyLDLSKUnP1B9GZtQF+r/AhjrZ2HQeJyESCjNjWpaCaC1
         rfUXW2D95wxN9dLo9Esa6F0/TnkDvD23J+K/HFThZFrlesJ7WGfL5ikG53GQUE1xo9Z8
         z6TZCiSR29dDFiPU/pMRDe4UySyoZCsAk3stigKJca0tdk8gcph3ohfcWa/+8wcAa+Au
         g0ddFaOwKa16imz2PevCro1Jo6NuPX6oaMwpjXg2whCTcnfrrpd6BO9GqAF67cM+dxk0
         Ayug==
X-Gm-Message-State: ACgBeo36D+wDq0NuC5uLSXDGPnLgqwCGyNokGepCJBPV2ahiII73C4c/
        jtdiBxuRqPcUfa0Cx0l/AOrxH0IA4mRhhMiorqHOguXypErR8g==
X-Google-Smtp-Source: AA6agR5RMu+MBNHzM+xUm2TPO1Kqe1FQ42HmfdhzT9rRFEuR+Os0L/+2NDY1lvV3K+ZVgoBLveHvEHFmFHN2ebLu6kc=
X-Received: by 2002:a05:620a:4088:b0:6bc:60a5:bba9 with SMTP id
 f8-20020a05620a408800b006bc60a5bba9mr13980652qko.170.1661900717259; Tue, 30
 Aug 2022 16:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220830225831.2362403-1-swboyd@chromium.org> <20220830225831.2362403-3-swboyd@chromium.org>
In-Reply-To: <20220830225831.2362403-3-swboyd@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 30 Aug 2022 16:05:05 -0700
Message-ID: <CACeCKae7ZCATSyHMupDynVye+CyKAqQMDU6GPKPXhf5Zibjihg@mail.gmail.com>
Subject: Re: [PATCH 2/4] platform/chrome: cros_typec_switch: Remove impossible condition
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, chrome-platform@lists.linux.dev,
        Tzung-Bi Shih <tzungbi@kernel.org>
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

On Tue, Aug 30, 2022 at 3:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The type of 'index' is unsigned long long, which can't possibly be less
> than zero. Remove the impossible check.
>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Prashant Malani <pmalani@chromium.org>
