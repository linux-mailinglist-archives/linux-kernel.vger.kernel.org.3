Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A444E31BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353324AbiCUU3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbiCUU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:29:08 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730861667DF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:27:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w127so17472137oig.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/5gH+Qk/caAbvq7TLc6uNTtoIHOsS/ggONeWolYhjMM=;
        b=mEcN0FZvNBnkfx7mE4kl+or2ZB2DdbADQOvjLZLMB/upcuDs29r4wkQBmVg8gaHYEQ
         dfZWuFIzHOja4/hU+Dz+KqtJWatcWb0brjy7gm5sD2ALSbWuw9sPCm4wpKl84kmWftXV
         sqILuV9AtC8LNg6mQFW2t3zFHWT/5JdNK6w8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/5gH+Qk/caAbvq7TLc6uNTtoIHOsS/ggONeWolYhjMM=;
        b=VHP0k/3Lf7D7jLgFSXQVtKT5iLaTE/r/WFSjlD7Fh59J6XN/qGaWfiLGrXoGxwzS/6
         805gs27ZKlfBPrg3JY14Og21/gJHd6ue2YXRevIfFfJnhvFxTZCy/vbrJ7pBlYviOLyh
         8rNC4N7oFJlJaY7vECBmOdqGG6jPl+vZUdsyZlc5udJ/cO68ia2ShLo33Td+IcqGvlFy
         m1mmh9jsQbnekT0o8HyTLvfqUCrnmX8+y53zTdxA5Bp4UMtt0AtJ9geCXcr2DGg0mA5m
         XdE1ayqNJytWSgNmJNmabrxpP6KvNxFF1AyKJt1mIBsdtzMb6ojLxByTsUwnGON8fsSv
         GKVQ==
X-Gm-Message-State: AOAM530peiZXbLM3KxPSy3hBYQTif9OP0cK7HPRmumfPSsbh9DGmfVg4
        E8LimsFQc2ao86JOLtB3dWdlVunSZFlCIwaAcB50fw==
X-Google-Smtp-Source: ABdhPJw+A5rqkEWBNBweCGwqww2vtbVI+22foZPQUlqvzbELO20xQTnLvWV0Mg8PC6ygwybxFAg1YwvsKQmOBZn3rpQ=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr424975oie.193.1647894460872; Mon, 21
 Mar 2022 13:27:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Mar 2022 21:27:40 +0100
MIME-Version: 1.0
In-Reply-To: <1647863959-3289-2-git-send-email-quic_srivasam@quicinc.com>
References: <1647863959-3289-1-git-send-email-quic_srivasam@quicinc.com> <1647863959-3289-2-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 21 Mar 2022 21:27:40 +0100
Message-ID: <CAE-0n50yxLZ6j32Cmx9gdACnKT3uJxc5wsOp3SAd4VHB7aNUvw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: sc7280: Add pinctrl for wcd938x
 codec reset and CTIA/OMTP headset selection
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-03-21 04:59:17)
> Add pinctrl nodes for wcd codec reset and CTIA/OMTP headset type selection.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Please combine this patch with the consumer that uses the pinctrl nodes.
Otherwise it is too hard to review the contents of this patch.
