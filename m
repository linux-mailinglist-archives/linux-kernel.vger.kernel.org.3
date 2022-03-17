Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639474DD04B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiCQVjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiCQVja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:39:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F7612C6E2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:38:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso8852904pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H5Zl2wvjuNiEzuSSqdGrzxbkB3GH5fcY+2dx8gf46go=;
        b=Is1dIn0DcwGOiCwH8KeruJ4YI8HqZqa38teQzdulxxt4LugHmlCXjB7hvJOeDZ09kE
         /cOOaNbarrWMiOvw65RGJw73j039FMwTRTE50uVJInitUlc9fLWtjd8OBaUiVNVyUEHl
         we13Bkx/54Xp58JLUSWRxm7o+M5ZerX7GS93g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H5Zl2wvjuNiEzuSSqdGrzxbkB3GH5fcY+2dx8gf46go=;
        b=2+/XafXeTVvTcyom7qiQ77+iVtWOIUwnNLr36MjHguiiOibIFU3PZphN6EinMjNgUt
         rUirTPO4d0JGIVq1oToKz6CkxXfsJN65uyprGi1AVAfgn7KaivmQ/6MZLF54cameO6DT
         V6XFEAK+9R/CUU3O0JkcqbZgPx4w6WlERJfQb2Sba89m20+zkkGYFCHEWIwxWFHHcVBX
         tq3+I/OcZNUTLCcpF/iM6vOgdzYUD29ZC3Yb/wkV3yuSDh4I8sDWwup/0TKlWYl8im1g
         wWJtj3NUS6n3HLZ4m8ld/pMvU7xcEogzF8UM8AJ2uh8x+dzcVGfhX6pSUi89vl5MDILD
         W9Wg==
X-Gm-Message-State: AOAM533BLntoGQoYYgRPUZXm4KcCoGe5NM7fCEracUBY+yDoshWCO/ke
        mLigA2eMwdIRA2+xkTVBDKyAPQ==
X-Google-Smtp-Source: ABdhPJzZ9qkiY0MC4Jy8sau2X2PMYa1pwEQeGCHH4/MpiQvCJbifVh0pZvC83C7QtH265TxOdijQJQ==
X-Received: by 2002:a17:902:e94f:b0:14f:1636:c8a8 with SMTP id b15-20020a170902e94f00b0014f1636c8a8mr6805693pll.130.1647553091691;
        Thu, 17 Mar 2022 14:38:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ae74:932d:af6a:6079])
        by smtp.gmail.com with UTF8SMTPSA id v23-20020a17090a521700b001bbfc181c93sm10193179pjh.19.2022.03.17.14.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 14:38:11 -0700 (PDT)
Date:   Thu, 17 Mar 2022 14:38:09 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v2 2/3] platform/chrome: cros_ec_spi: Match cros-ec-fp
 compatible
Message-ID: <YjOqQacDISz5eZgM@google.com>
References: <20220317005814.2496302-1-swboyd@chromium.org>
 <20220317005814.2496302-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220317005814.2496302-3-swboyd@chromium.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 05:58:13PM -0700, Stephen Boyd wrote:
> Add the fingerprint cros-ec compatible and spi_device_id so that we can probe
> fingerprint devices.
> 
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
