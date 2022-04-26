Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4A510B79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbiDZVp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiDZVp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:45:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B105BE60
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:42:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h1so19115703pfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5gf3nYF9WdYbXs00QxenyePit2YiJMZrQ9wLgL5Q7jI=;
        b=P1z9e3nqHlFrb7EEv991K5FPplMY7ZI1McJEtBr+SDacbu1UC4zCOuxlTzzfu9JQnl
         YXMyyZXta2j13wlKX49/81iO4BvwKpOOLdaOQ0x1GkeKE4+64YeAjG4x8QrMzxhJ0RZG
         GbldKWaqPCre7DNy7Nh+edcZiQ52K3xj50atE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5gf3nYF9WdYbXs00QxenyePit2YiJMZrQ9wLgL5Q7jI=;
        b=piJj7QzvP2JVvqO4HpFw8N6pCYLvE4vjkjhwRy3LvMIn/OU6Pd7CR4OFn+nbeTnxvB
         jlH4bG3QA+3wGQ7SPnh7ZnIAEQZCNz4gjME4MtT1Bl7U2TQ5pOuIoNtQUagah/ASt8HG
         z8KFST7z0B2MlpnOUc5WbrE5nt1thBhS0rwhUzg4KJkqavEt+Ys4yb6b9nYVTmwqVSo4
         YV7xRl9VDaHeFDULPYL2HQKTg6hHj676khGXkLJJa+DxjFKwl/w6RPMqI3io2G/VdMBT
         7l1jyYrc6o2I9WDqpMjYjqGdzli/12x5Jwh6aiU3CQUTCkSxfXo8J21nx70JNB69rEzE
         9Iug==
X-Gm-Message-State: AOAM531O23RPVbI5PnZHegB4PiYJRpewiNm0ug69jJzJUpFY05/Xo9we
        2+PFl+3Hvk3N8Wi4sJds5jYyoA==
X-Google-Smtp-Source: ABdhPJwkQycKLw71SdNQNmcdN0UC64HuTVTyy5S9/DPWZMaF7QkDs0vFU+GmjzeWN51eQxo23te19A==
X-Received: by 2002:a63:8b4b:0:b0:3ab:25dd:3836 with SMTP id j72-20020a638b4b000000b003ab25dd3836mr11262472pge.112.1651009366617;
        Tue, 26 Apr 2022 14:42:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb63:4211:eb5d:f6b])
        by smtp.gmail.com with UTF8SMTPSA id x8-20020aa784c8000000b0050577c51d38sm15727853pfn.20.2022.04.26.14.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 14:42:46 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:42:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v11 3/4] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Message-ID: <YmhnVLAsKCDr+TEh@google.com>
References: <1650957666-6266-1-git-send-email-quic_srivasam@quicinc.com>
 <1650957666-6266-4-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650957666-6266-4-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:51:05PM +0530, Srinivasa Rao Mandadapu wrote:
> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
> based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
