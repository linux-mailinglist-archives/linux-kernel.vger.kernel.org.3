Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB7851DA92
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442207AbiEFOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442205AbiEFOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:34:43 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF3659BAD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:31:00 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so7350457fac.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Z3BhvNnZeKv1IcmAFTPQ8BjykroeJGCMjBhzdl/UNHM=;
        b=jO3oHxuDXU4qKNmreCjjYaiO4yOFVMLlHvrgsIknXQpO28ujlFHIX+YGJMNDAohf0S
         DZNeyUI7z2EDLgUqTLJxUWdlh1QK08j28ZN3csKfsdDpAqlRFloCzirijmDCbWZLcZyE
         C6gdUaugeCxwk+y28GBfLl9pvOmB54KmpIvUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Z3BhvNnZeKv1IcmAFTPQ8BjykroeJGCMjBhzdl/UNHM=;
        b=KtDlxUTvZGA9SnEcz3N8Y6a/thqkeZGmmFMkn5IxZis9h0gkXqZhFA7NKR6OOiZm4N
         q+7Bk0nDDklVP+D4y3pv1mWkai/JqPN/LrEvZPM3CQk6ivx4IzJw7lalp7Tfh+WZYMf1
         HECCYliT/cCGHmp8hPNcKepT/kVBRV719cc8wnJ8BQtxNrhKBjRGCL289XuMSod/uMza
         nU8si/Po+sU6LkBXKKOgvPI5IxWZ8BRkCRMsdqHt0f93ikL2quFVkRzuS7YrBqCzjmtb
         bfxsP5OFs2nHcovM3yvldCoo9mDlaVo/XZqAOtzYtqPFgLONGeFqMzkusBsw7ZvEbNx3
         6IAw==
X-Gm-Message-State: AOAM530S2aq+cMiEQnvyUwKyV0V5MCrgMAQdVghHP4J1DDV3b1FgiZJD
        wM9pFkppc+qxM3DT5nQvtPOr+OvtxAJ572M53aDJ09q0ISo=
X-Google-Smtp-Source: ABdhPJzE+vXk1hqtD9UBfXOO2I3rdrl0PyEIZMyce2ypHXN0n1NbIBLqFN65uSkfs/ck6n2qBT6ImYvZZMQRqp20FeQ=
X-Received: by 2002:a05:6870:40c1:b0:ed:9a12:3f95 with SMTP id
 l1-20020a05687040c100b000ed9a123f95mr1383802oal.193.1651847457937; Fri, 06
 May 2022 07:30:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 May 2022 10:30:57 -0400
MIME-Version: 1.0
In-Reply-To: <YnSYppSYwaoZRXb4@builder.lan>
References: <20220426225748.324759-1-swboyd@chromium.org> <YnSYppSYwaoZRXb4@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 6 May 2022 10:30:56 -0400
Message-ID: <CAE-0n50PaacK_zT1NPoj+9YA9GX4oqpADEHObFdK+Zyu67Guig@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Remove cros-ec keyboard
 from detachables
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-05-05 20:40:22)
> On Tue 26 Apr 17:57 CDT 2022, Stephen Boyd wrote:
>
> > Trogdor devices that have a detachable keyboard still have a
> > non-detachable keyboard input device present because we include the
> > cros-ec-keyboard.dtsi snippet in the top-level sc7180-trogdor.dtsi file
> > that every variant board includes. We do this because the
> > keyboard-controller node also provides some buttons like the power
> > button and volume buttons. Unfortunately, this means we register a
> > keyboard input device that doesn't do anything on boards with a
> > detachable keyboard. Let's delete the rows/columns properties of the
> > device node to indicate that there isn't a matrix keyboard on these
> > boards.
> >
>
> As this seems to directly relate to the final design of each device,
> would it make sense to push out the &keyboard_controller from
> trogdor.dtsi? Or do you think it would be too much duplication for it to
> be worth it?

I tried it out a few days ago but I'm waiting to see how the driver
patch goes before sending the dts bits. See the WIP patches up to the
end of the chain on chromium gerrit[1].

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3609017
