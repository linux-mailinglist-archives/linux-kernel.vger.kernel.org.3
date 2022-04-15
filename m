Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E3D501F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbiDOAGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbiDOAGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:06:06 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6D568335
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:03:40 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id e4so7105976oif.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=++6zWDjlF8n3LQeDDeUqzEREnbWP/OwlrXrG0bJl48M=;
        b=Iha1t3xwyBxNB8suX4l8dG0IGCz7EQimmVo/O+G4+dUpKXdjn+b319Lm+m55eXShJr
         p3hxuECqIKk+pySQSKKI8e/9d84ZSiS+1YtVnAv8fwFf6V0yTSOynguuWbyS7WxF91bc
         mqm3EUfVSTc9myCr8jFZf0/C97xbXMC+DzC04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=++6zWDjlF8n3LQeDDeUqzEREnbWP/OwlrXrG0bJl48M=;
        b=Xgf0pxv0GnmNUuKwf2isQZ/UQmt7JjEDGSxkNPXkn0+cxjeFGCczIbwc1wr6o0Vntn
         TCoaWJosi6ZIvcKVhZlbv0b+isl+myNeQ+RPL0KnV+Mup2zCIEhpPtbE40/KpnPp0GVh
         fixTTpKRXNMbNlm7g+qCOIdtlH83M6EZSf91wqCGwMSVcREAMsgUGHcdmS3niElTtjQ9
         E0gJ2LLsO8r4Exu8pTenjaiN82wkg3OBTG00nAOpIMCY8bIcyOyawqeBflXgeCS105Tq
         nhRfNRp266JiJ0XO73KikmuwXGuzz93E267mzLRFHIOINsP9LYMOsnJgH8kOkCnU5/jq
         EGLw==
X-Gm-Message-State: AOAM532RMbXJ2Xk+HX/MnjfnvEHP6yPpm5z20TUAe6AjNV0qgLucygYq
        nTo+0P6xhtY54ce63U2Ooa4O+ycwbJ4V3KVXBZWHkQ==
X-Google-Smtp-Source: ABdhPJz298rmy2F1PAP6JljrlPiNntN82KA41s56sbWpY/ZjdQaM5Lt8Veg0Dtd2h9lGRyxSyUiiwCD9MUa/uAu3sXc=
X-Received: by 2002:a05:6808:10d4:b0:2fa:5fa6:e9c4 with SMTP id
 s20-20020a05680810d400b002fa5fa6e9c4mr468332ois.193.1649981020119; Thu, 14
 Apr 2022 17:03:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Apr 2022 17:03:39 -0700
MIME-Version: 1.0
In-Reply-To: <1649944827-6455-2-git-send-email-quic_srivasam@quicinc.com>
References: <1649944827-6455-1-git-send-email-quic_srivasam@quicinc.com> <1649944827-6455-2-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 14 Apr 2022 17:03:39 -0700
Message-ID: <CAE-0n53GoyLAJLEdcpzWPtWLpsZ1rdn9rdSVyprzQhb-XBHgdw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
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

Quoting Srinivasa Rao Mandadapu (2022-04-14 07:00:26)
> Add pinmux nodes for primary and secondary I2S for SC7280 based platforms.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
