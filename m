Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A093504A00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 01:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiDQXNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 19:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiDQXNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 19:13:15 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367BCDE93
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:10:38 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id t67so23103288ybi.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Le4jl5XF0VLBlxt8HjmHELE2HKvDu0JU7mx1Xs8yGvg=;
        b=c0jdZ45L3REZF64lrO2C0QNLmZ4h/XmxmZ1szaQf2AJXBW6kXX39y7vvEfXAB6c01I
         uq4zgYIcGBUQPj3iAf7uv2H+UeOrhxpmSbedIkCjIOGsCP4jc1VCVWYGDUQ4uCrnd+NO
         04x/7CopQyhxNn9Q0HkQ+QrzJXe1hKdgLtlJVU8n9YOOY6++Igp5UPQDqlfPcuLXrGXc
         +HfAqgAAQNZ3Z46HwEBwECGGAq0wQ5MkH4ARRZp7aRDgxVgNmYbvVHwsJRFVyJR7kz27
         u5mdbZxNFIT4iXD7KMcjcokvX6yj8Kb5zearY2lf6O5faVBu61jHAU4C8xTr7jMgMBBa
         F0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Le4jl5XF0VLBlxt8HjmHELE2HKvDu0JU7mx1Xs8yGvg=;
        b=F71yWvDcjPQ5tTCJRlAvqSXYeLEu7rXZhJ+nqZySW3FktsGoFTpNWGzQdn7uzcaw5d
         iIVwf7cfDteXiHKyGwKLUJPsfc+Ok2+dgAcaVgW3GotITFTYqVXAaHWNNasCOL+p1FP9
         i12iw9EfIrMAd0eadvIkW7a9BblbX6VC4rC9zKlLVdmtCktpMGQfC/AhFiIBK0Z3P0E8
         2orLDPKVCdbS8diGW796g8akEYGsYK4gmvYT/18h3E/+H+ohVjGrqolc2XbvQu5GZ5Wb
         545zLsG6Bc4rIKJP5ZHMlXZ0qtuF7wZBsbqqhsd2+PSPlNfq2RSRqm/IhDG8iTPPXUSF
         sYAg==
X-Gm-Message-State: AOAM5316gdrycG4Nl5utP6XhSG8Lp3jzwXkx7j8CEbum3KmLmQ3bur9Z
        hQHnRC/uvQZV3eooZFeJBmTSh7OElt69/jYb1xPHhg==
X-Google-Smtp-Source: ABdhPJzKqeZN1SkN6+VZNQkz9459jTIakrP6+pv28l0cbdbwmcXV78MirwRmfGtmkDgp8il6CCdx4xYxepIf9b8JUVk=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr7860104ybr.295.1650237037490; Sun, 17
 Apr 2022 16:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220226184028.111566-1-bhupesh.sharma@linaro.org> <20220226184028.111566-2-bhupesh.sharma@linaro.org>
In-Reply-To: <20220226184028.111566-2-bhupesh.sharma@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Apr 2022 01:10:26 +0200
Message-ID: <CACRpkdZ97KkVqTfYVvSrBWZd=KK7x15Ppb3Pw0yJ_Sekg=i4OQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: qcom,pdc: Add compatible for SM8150
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        quic_mkshah@quicinc.com, linux-gpio@vger.kernel.org,
        robh+dt@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
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

On Sat, Feb 26, 2022 at 7:40 PM Bhupesh Sharma
<bhupesh.sharma@linaro.org> wrote:

> Add the compatible string for SM8150 SoC from Qualcomm.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Patch applied!

Yours,
Linus Walleij
