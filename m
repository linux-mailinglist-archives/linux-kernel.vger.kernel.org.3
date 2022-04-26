Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C158A510C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355737AbiDZWo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiDZWo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:44:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C52E3E0D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:41:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bx5so10181262pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FbBWmvHmK3IQ/p4Z2WqxkrztSbZlWCp1DoYs6E39RsA=;
        b=ldES1I0qz9ByqPHhRHx7eCQ9ZkGKEBzw2T8tUCIFu7om2d4dlipMaoVyMIb5MUTW7w
         cZXRYqvSWU6i+TdOnxmOds+hBFesRmcRjIBOMWVXjOnFkhG8IBH5NcrnhzpEk0b4Qado
         a6ttqGdmb7NhEaYS3CShe6rXJfQ/LFrCQJTVp0Am9eeSYdUAChPWdFvDr/rFiRa40vli
         NqyoT5pt6PmNlqqnW+7GfkvfbVSk/7cSyT6Bp6FuwutIQub473pt5PsGQ+2hdACZUrDB
         C36H9WTqyhgGPlAEEPMIcEHx4hV/dEwYnvHW779nxyD1F36ihqXZ8FKkefg7nApimUkL
         Pdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FbBWmvHmK3IQ/p4Z2WqxkrztSbZlWCp1DoYs6E39RsA=;
        b=asZGlX3MaBXLIzbJYh1gwqRuVSITca4hcsMsp2V+lNBB7HiTz8rNwZVdc49geR44xD
         Fmo7q2VB5Hp4XTvecaPSHmbmDfmi41kCt3qbx/F1RsDc3OqUMYbBwwscpDRLGrOgTEY7
         w3MP3rUAelDLN4tnJWf5fcmHwEH614gKOS6iwAQuFXntQ1TAggAeZDo6q1dqCX6ZqHUi
         jKTj6Pr8zFp3RZhPn3gybuXPykQewsOwuTNRDEqH+tJwXrPvYR+EzbTpgvMXHEp51Z0k
         rVGVpJhMUu4BecNIJKBO8dw6PjvdiUdAAfiR2QjVfpO1uU2BKiWNy2wwmbmWjdgJx6qX
         ZXDQ==
X-Gm-Message-State: AOAM530KCU9LaoR69RQDKT+A9oYPfvSwlR3fGk7ZAtdwY0EE9OMkfjVm
        C7/a9H8gcvdCOzzYeuJY16awCUWCaS4=
X-Google-Smtp-Source: ABdhPJz3jG9OVaP0/gv/wHQABjs99n3lLKtgL9rMzQINE+y7Qjnz2IFJYpt1IeZOpTykC04gYm+j7w==
X-Received: by 2002:a17:902:8f94:b0:14f:d9b3:52c2 with SMTP id z20-20020a1709028f9400b0014fd9b352c2mr25183279plo.103.1651012907805;
        Tue, 26 Apr 2022 15:41:47 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d35:5028:5db5:38ea])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm16437172pfv.123.2022.04.26.15.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:41:46 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:41:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v2] Input: cros-ec-keyb: Only register keyboard if
 rows/columns exist
Message-ID: <Ymh1J9zQ+5EyQadE@google.com>
References: <20220425210726.3813477-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425210726.3813477-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 02:07:26PM -0700, Stephen Boyd wrote:
> If the device is a detachable, we may still probe this device because
> there are some button switches, e.g. volume buttons and power buttons,
> registered by this driver. Let's allow the device node to be missing row
> and column device properties to indicate that the keyboard matrix
> shouldn't be registered. This removes an input device on Trogdor devices
> such as Wormdingler that don't have a matrix keyboard, but still have
> power and volume buttons. That helps userspace understand there isn't
> a keyboard present when the detachable keyboard is disconnected.
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied, thank you.

-- 
Dmitry
