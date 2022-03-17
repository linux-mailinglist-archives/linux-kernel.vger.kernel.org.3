Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D14DCE00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiCQSxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiCQSwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:52:53 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C42221B9F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:51:37 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o106-20020a9d2273000000b005b21f46878cso4125360ota.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=c6pTj9KdqfKH8gYFJGRgPsV8D6Jtyz/2xq1oN8sgvN4=;
        b=FWohKLdZNgf8kbisorHcnMjgpt/aPXZc/rEOQ6MELgwFIDlE4b+AqPWmDeATQBwm6F
         GfDrEKcrCc5c/1vXtAF/NprKjQOkagM8hODfOAWgChdKBzsg01MSwca8p6dFLOYMAG4F
         /eZ0qpRCJ/KINsgAyJy9g+DCH/I9MLaLF8txU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=c6pTj9KdqfKH8gYFJGRgPsV8D6Jtyz/2xq1oN8sgvN4=;
        b=fpSJEULuh29Go03Z21+Sc0Gu/xo9cvRrNBgu/YrFiGtIwXIEJE6xZ1Oz08+sdpzXfZ
         R1Fe3wPzYYslw2e4mZfRnNrET4rxY804DaWdQntKhxZ0dMy6ZMIB2pdXbRpizv2w/d4q
         j0TZsJ4ok5U1sOvZJLfoodfxh9fsqDziAjXeuiFx+Uwq9/94KJhGX5YRMlG1dNu6YT+O
         mQy7eS3X+l5cNG6bvDNZp3CCtckN21s7SjBghZhU6w7siKk84soJjXa+aIetq4evFGBI
         XEWqpAEAmMN3nAhKzoMotv2lxQJomTvOzJ2vnm6KElMnVO8SjVOgT0ijIjQG3TxM9Rne
         +fqg==
X-Gm-Message-State: AOAM5304Dgrh7SfGxLNUk0RE7/VwXEBsd7OsB+4wgYdVi94igUVr8DzN
        nBdIyCw3PZDAzLmmcO94vFEtNS9f5yoBQJfZJSUPlA==
X-Google-Smtp-Source: ABdhPJwlc/YePSN6KuA53OPyCYHDKxjmeChzSSlIiOob596/ux9Ijh6S+8A8bUKsv7+dVBd2dmJfLKNhu4dhqWjq9QU=
X-Received: by 2002:a9d:5a01:0:b0:5b2:5b6c:232b with SMTP id
 v1-20020a9d5a01000000b005b25b6c232bmr2065256oth.159.1647543096410; Thu, 17
 Mar 2022 11:51:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 14:51:36 -0400
MIME-Version: 1.0
In-Reply-To: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Mar 2022 14:51:35 -0400
Message-ID: <CAE-0n53oY5ZDtmasq0C1-+TtzACE0zBAtt=SVcoVLGpCT5z2Yw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: qcom: sc7280: Rename crd to crd-r3
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-03-16 17:28:17)
> There are multiple revisions of CRD boards. The current sc7280-crd.dts
> describes revision 3 and 4 (aka CRD 1.0 and 2.0). Support for a newer
> version will be added by another patch. Add the revision number to
> distinguish it from the versionn. Also add the revision numbers to
> the compatible string.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
