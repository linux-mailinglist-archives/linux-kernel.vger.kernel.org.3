Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E14A56A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiBAFXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiBAFV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:21:29 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67DDC061392
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:55 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id m9so31144026oia.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLEXQVzRDD9hDzDA3QQaJl+H9Aj1xtzImTCkX8rQYr4=;
        b=F5tBTRyBpiZkZn6jnRnjgWcmgcX+XALUqsue4m+40+W+znnYjLXzuj/z9KKx80HWY7
         QPKDLG7aq5GWolNfCbAabApSl08TiQkj+TR1WEGvjoJNJ6dAlELFePfDAGZizsK6a/z2
         yvdpxzOz3kiaI/2ZblAfRsrLNhxj57GnDdU8n3XHBohG3AEJ56cUHihoVLn9cwxVnRf+
         9RiFv33E70U+2OAo3U+o2ZXNoCai1c3u2MTKcjOJTK/qCLgqOMI6+M31NDrTIY9WYcZe
         qfxW3UHTkRCPIS14uhWQVCuB3jMIAGAh5FTsrr43xZbMm+GbsD+CyRikZirmNGtQtjdk
         B2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLEXQVzRDD9hDzDA3QQaJl+H9Aj1xtzImTCkX8rQYr4=;
        b=IJMKu8YWBOZqjGprhK9dP5g4BkfiVcRWn+/KmI88dMlV/Gx9xBgaNBuWl8iQwQfXaC
         2O3qQRJSBZFv7kKXuamgavUmaddHb9ild414Rp4qhp4lkZCge75KpCTU/t+W91FhS8j6
         BX/5AypTGry9BqupCt3H7Ao7v/bf6HEE7SHvTtSixgC+tLk/SN3sTvNamRS9TqAoSRTm
         j+orKaXHBN4SCAVM+2KITijPqdGAkvqJhXLBwNQ7aDoZGX6wQnRqNeqR4lGgi4X6/mj7
         TioqS+P1oM/JUea0iHT5aT6TF7MXS5Km8mvFpSnjEkkqm6J4GijcOxksUYHQ2BCFV1wq
         ZCcg==
X-Gm-Message-State: AOAM532DNzLHqwhQKksBcmB2WVyGYR/60YOCttVzsDN+bErlZTkcqO3y
        u2KexRMVfhrSNUMY5Zza7JApTQ==
X-Google-Smtp-Source: ABdhPJyA2SqGmolBEGjQSSfhzwfp1+4bigXN6qmmLMj0IIm+HkHMAt1eboCIC+G9vUL/S4QV2fPLmw==
X-Received: by 2002:a05:6808:17a7:: with SMTP id bg39mr227540oib.184.1643692855233;
        Mon, 31 Jan 2022 21:20:55 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:54 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jean THOMAS <virgule@jeanthomas.me>
Cc:     devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        petr.vorel@gmail.com, konradybcio@gmail.com
Subject: Re: [PATCH v2 1/2] arm64: dts: msm8992-lg-bullhead: Place LG Bullhead generic code into a DTSI file
Date:   Mon, 31 Jan 2022 23:20:05 -0600
Message-Id: <164369277342.3095904.5357867603310330864.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201231832.188634-1-virgule@jeanthomas.me>
References: <20211201231832.188634-1-virgule@jeanthomas.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 00:18:31 +0100, Jean THOMAS wrote:
> This patch puts the generic code common across all hardware revisions
> into a DTSI file.
> 
> It also prefixes the DTS filename with the vendor name, to follow the
> naming convention used by other DTS files.
> 
> Changes since v1:
>  - Added "model" property to the DTS file
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: msm8992-lg-bullhead: Place LG Bullhead generic code into a DTSI file
      commit: 3f99518c6f6520ad0fd14d862d54ee12f16156b4
[2/2] arm64: dts: msm8992-lg-bullhead: Add support for LG Bullhead rev 1.0
      commit: cd4bd4704ec8cff3d045493e2130c7095bbabf78

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
