Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389FD513F70
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353533AbiD2APW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353514AbiD2APT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:15:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316BC38BF2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 17:12:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p6so5694040pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 17:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iuNk9MwvCvbcUppmRdVoXyJvLMt+O/9GswTClaDk/QM=;
        b=nWfkeFVVLQdjCRdfHRtk0H3wnlkeTaDVtdQC75mQJ/tOw2zRRrQwrl/sJAIpipBuPh
         byJp4Evcvz6giHI0Cfq9iLl4hj6N/Dcvll8yOLY2ObcC1IqMgNOrHsr3NmVj1uyZ0SMV
         qyxCkuv6bajjM3ZxmMMvm4WlG1VuhqXLNbWOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iuNk9MwvCvbcUppmRdVoXyJvLMt+O/9GswTClaDk/QM=;
        b=etB8sVtdMLaZ+vmJf86F18paVVOfbVTFnCM/E0J6zkuzoCUEhscNwCX+z1KBc/N6mF
         fkd1Noip+0zjgUUB7dUTZeEO80qbw6wRvyZVE/xZ9lxt7twYmFOUwRI3bLI6k5Gwo4Vu
         ZPF3zjB8BYRMleQByiF3sOQj/VXo6GWltyb0T6mNTZ4crMt1qhSakqO5RaHCbm72eWR9
         5ar2v01tVfwQQaj+LL0a/ZsYEpARq2pOKSWkWUUCUb48LzLcHIWRuyb9Om/50WQGpKhL
         JwI+rzYGAiauYz7jyMP3Qcpj1L+pwiDWZdRJrrc61wd7YhctElU+keFkC/c2GRml0cuF
         9lKg==
X-Gm-Message-State: AOAM531TRSN/+0PhpmEMMyy/1aYWr46FUdIUl6Kzv/BKCHmvzZzYbpB8
        p8jOKKywsZ+HqpPgHFrPKOmYrQ==
X-Google-Smtp-Source: ABdhPJzcIuW/yBWAQUiE+LCgHZN1NHWgqzTsexx1tr6RbE8PgNgW0Cskvr5D7aO0nCb9SiDzr4B2gA==
X-Received: by 2002:a17:902:c408:b0:15d:1234:3434 with SMTP id k8-20020a170902c40800b0015d12343434mr23711839plk.67.1651191122732;
        Thu, 28 Apr 2022 17:12:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7d14:5f45:9377:9b6a])
        by smtp.gmail.com with UTF8SMTPSA id q10-20020a056a00088a00b004f7ceff389esm944209pfj.152.2022.04.28.17.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 17:12:02 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:12:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7180-trogdor: Simplify
 spi0/spi6 labeling
Message-ID: <YmstUBkqAdWvMnm7@google.com>
References: <20220427020339.360855-1-swboyd@chromium.org>
 <20220427020339.360855-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220427020339.360855-3-swboyd@chromium.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:03:38PM -0700, Stephen Boyd wrote:
> We had to do this spi0/spi6 flip-flop on trogdor-r0 because the spi
> buses got swizzled between r0 and r1. The swizzle stopped after r1, but
> we kept this around to support either hardware possibility and to keep
> trogdor-r0 working.
> 
> trogdor-r0 isn't supported upstream, so this swizzle is not doing
> anything besides making a pattern that others tryt  to copy for the EC and
> H1 nodes. Let's remove it and simplify the dts files.
> 
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
