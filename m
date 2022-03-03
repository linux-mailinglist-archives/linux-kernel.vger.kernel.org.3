Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B2C4CB418
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiCCAuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiCCAuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:50:06 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379533DDC3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:49:21 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so3197844otl.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 16:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Igbll9U9GWfPZyp0rAtKMmMZmYLrnV0QUhLztSvpRRk=;
        b=GjYYsIrh0KJE5xo+zEqZPMzwq/h3GNSVLP2CdDdHzS+GmbblGgulOkI5ZfBTRbQdtr
         TK66dFJ6lZqEsZ1VmKjxHAbIPjiWvoR4xfrXNBqiJ3fgZfK9X82mcJ0hrx82fpLHxlaF
         EmxCAChhZRfwphKcGIFifkGvxG4+8UocnrXo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Igbll9U9GWfPZyp0rAtKMmMZmYLrnV0QUhLztSvpRRk=;
        b=kxigBGEZEFMpWhUcNPypxAYohjgwppGSN2KjXiZTpiXIoU/kktjpEnQuGtpWLH7Xro
         Yl/sVuw1zbgSqkOnl8s/Ogpk+gk028paSrTqAgzxbEhTKGR5YvN6C30F8bpekU+Ch9aN
         fMNX8ya+nVir0Uw2r2GDTP9GAaZvw/aDue+dmdE9JkkJVoy3VWz7yKQpQyfmZXYKAF51
         mZEaFZLmhhUZZZRSn/zgsk2+UFAWgy1Xbfj2XZHepr6BxgqDk0Ep5ztSzlLNxfiYtZpB
         PMWlIAVGaqH/xEXH2Iwn87rva4ywAbBqtQMFTd/c6nkd7SBZLnf2shwJhCT8z7Bbxa2u
         A7+g==
X-Gm-Message-State: AOAM531STR8Hdk5S1VLcc4PtM7BjM1jD3LuYx6jdCQ+1PP9DhsDTW8PM
        05Z2YMl4w1WLxLX3mPcCpB/sr74r7XjCOn6JTBYePw==
X-Google-Smtp-Source: ABdhPJyUg/1XxpzO/77bE/2CGH5L5NlscQSdfof7aYOTzS48oVqPHSp9Wvb6oc3eXpY5MoJNqvFzXTK05l0Ih1LBqiE=
X-Received: by 2002:a9d:22e9:0:b0:5ac:1754:342c with SMTP id
 y96-20020a9d22e9000000b005ac1754342cmr17014519ota.159.1646268560456; Wed, 02
 Mar 2022 16:49:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Mar 2022 16:49:19 -0800
MIME-Version: 1.0
In-Reply-To: <1646204402-7608-1-git-send-email-quic_pmaliset@quicinc.com>
References: <1646204402-7608-1-git-send-email-quic_pmaliset@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 2 Mar 2022 16:49:19 -0800
Message-ID: <CAE-0n51imr33FJMdURG9VSRSBJT+xFNMpW0HaFGkd2=PK+Z3sA@mail.gmail.com>
Subject: Re: [PATCH v1] dt-bindings: pci: qcom: Document PCIe bindings for SC7280
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org, kw@linux.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2022-03-01 23:00:02)
> Document the PCIe DT bindings for SC7280 SoC.The PCIe IP is similar
> to the one used on SM8250. Add the compatible for SC7280.
>
> Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Can this be converted to yaml?
