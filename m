Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70701510009
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350461AbiDZOMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbiDZOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:12:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C23D1C121
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:08:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v12so18838039wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SD3R0UcHqDybFui9mVFQWHIx4CHUAd50hCJoSvs5tsI=;
        b=KNVLAuhmDvETnQaSzkamhZRo4b0+kyvGD1casuzpjRSQ1bzBQQSBsiTRFddJJeyQqd
         8LcOkXNrmCbH404bjE8j9FqzMnG/qXwoplSGPa2jRHiaF/PzpSToqJpxMkJ1Cvt0VVpG
         q0IR+93Ev2ytnCdAMyMunocZJPNjZZjLL8ONJTFcBmPwq0foH3q4OkSXBDokpH9SEw7Q
         M4oehDmU44QGOG4T4FOwUdZ9RrhAvgLv/hfaUeIidxPQhVoz6RIvViyK+eoFK+h9LWRo
         Di/bqWSsGZa0MLTNZvqG3rjisizb8kmE3QH2BISzB1i+ttozRigFmbnya8fnGkAN5BCg
         hvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SD3R0UcHqDybFui9mVFQWHIx4CHUAd50hCJoSvs5tsI=;
        b=Spp4KDvbEFuLkWXMSKvxaFURySHOBXcHrthP8T7wx7AN7xpl52wXTlS7cI2FGWnwzV
         XKYa4OOAwgOghoJh9wNZDcwTdXv7O42p8EF5n7wPleMs3UZa8Tw91zceOW1RemINNHSR
         h5bFj+6T9fPAxnblijoIQWc6HHPIiRl0zx7c7g+YIbES7D+GXZ3/snmu1BTeJWKYzYwI
         3r1CNaWIiv5YDzLtFMkdaH9ArgbxJEA+HGsKD3AKqj2ZxgXlbE4Ekz9njMyUvSxmdPSJ
         j8FTlnpKGoR0LpR7tlrQygaJ2UG8GoYXmP9UOmpNofGoN7btaxeihjT89UOQrirWEGsQ
         VHew==
X-Gm-Message-State: AOAM532ijJ1JeDk5QteE9P8kGcM60+NPhJL4WQk2BJNNovDk1FjNA3ev
        xEQrjFE5iE+PGZORgpaSaRVGKQ==
X-Google-Smtp-Source: ABdhPJyiWCubk4OcikncGWfsfQqWuZHj0Ij83FLVOPTTVu2iQex3WnII618HG+9yV55dPtF6h7YJsw==
X-Received: by 2002:a5d:630d:0:b0:20a:e1a3:8018 with SMTP id i13-20020a5d630d000000b0020ae1a38018mr4579886wru.489.1650982135790;
        Tue, 26 Apr 2022 07:08:55 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c502600b00393d946aef4sm10316660wmr.10.2022.04.26.07.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:08:55 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:08:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Ammann <daniel.ammann@bytesatwork.ch>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: tps65218: Fix trivial typo in comment
Message-ID: <Ymf89TwZNDxULmdY@google.com>
References: <20220405125426.28016-1-daniel.ammann@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405125426.28016-1-daniel.ammann@bytesatwork.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Apr 2022, Daniel Ammann wrote:

> The driver is for TPS65218, not TPS65219.
> 
> Signed-off-by: Daniel Ammann <daniel.ammann@bytesatwork.ch>
> ---
>  include/linux/mfd/tps65218.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
