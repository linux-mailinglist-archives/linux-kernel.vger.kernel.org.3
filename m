Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4C4A4E29
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350671AbiAaSZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350524AbiAaSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:24:43 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C55C06174E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:43 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so13851373otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLlgtlyWylrYHGOuGuSUZGjcKE10y8u1ZgzMN2Uiw08=;
        b=Ab0MEecTf+6tR7ZmrfH/eZ30eU+i5RMnaBso2jS7lIA7e/uvgxX90t8DqPkEO/Vwdy
         RYeSaiLFbgBzMtpcP24vtPua5denNgI+xHJeulMa2dGZh9wQermNsHb2S1I5j9h334zu
         HXaWcze0izav92JADR2YaYY7LXHLgltt+wdjfWmyVbD+TN3EaabTu6HlU7QzgLiYMoTU
         SSCnjBhfFOl7r2iMXV4KCsiR1b00lt6NuV0/mkpG7oj7Sb+JODTSL1P6oVg/FtxZOqge
         9h/zfWqS8pXvo0Ot20nsKG2xtNHLq2bsQcgrR71VlSfU/EgcKgyPp709r5WAlmk00dcd
         /S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLlgtlyWylrYHGOuGuSUZGjcKE10y8u1ZgzMN2Uiw08=;
        b=tuXSujw+5TXAO+NO0ooL5NN2UM/V9T9R/Zrso2MAFkUkltp2Gzd0D0Z26EachqNFCR
         e6hG3pA6sqwsoXAAucs6wQcGReoSZPa4lB/b2JjrtpdgqJfsjuMh226cngHgOPe6r+aA
         MbMDYWYNkEXsstKPVJZ2jpynf97QZn7goEYkba7UlYP/k9KRXKPmcMZPvER0AtB5Wwyb
         Zwdpbv/K60cZdajgzWm2Z8t4tsjJIVJSPf8P67UfxL5zkTzaxGVisy4hWmXnOqxyLTp9
         5XBYKI+Jw1Flv6h8VjkqvBTx7G8HBT+rPTNyk3uZmVp812hWTYYuSwthq5ugsfB44q+o
         oTVg==
X-Gm-Message-State: AOAM531Phvl1uNF3AFk53GE7SaXZ3VwiHgm6QT6FAYjb1YoZoAQM7OL7
        6ThHumdijkbRNm8AhaQ17jsxIicmHpwagQ==
X-Google-Smtp-Source: ABdhPJyjerxtWltj+izVuyHYgPPh+eQIQinri3NN+NtDEc+wm1tsTf/urM6SoOb3xBh1VpFRXOXNzw==
X-Received: by 2002:a05:6830:4409:: with SMTP id q9mr12686683otv.316.1643653482698;
        Mon, 31 Jan 2022 10:24:42 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y19sm3273722oti.49.2022.01.31.10.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:24:42 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Taniya Das <tdas@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1] arm64: dts: qcom: sc7280: Add camcc clock node
Date:   Mon, 31 Jan 2022 12:24:30 -0600
Message-Id: <164365345129.3009281.953613098927084329.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124184437.9278-1-tdas@codeaurora.org>
References: <20220124184437.9278-1-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 00:14:37 +0530, Taniya Das wrote:
> Add the camera clock controller node for SC7280 SoC.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add camcc clock node
      commit: 7b1e0a87730e32aac0089182c8cfe3b5fa6434fb

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
