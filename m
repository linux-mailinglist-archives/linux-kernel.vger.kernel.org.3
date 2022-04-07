Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491C24F877E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347045AbiDGS5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiDGS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:57:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6E21B755B;
        Thu,  7 Apr 2022 11:55:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w7so6271085pfu.11;
        Thu, 07 Apr 2022 11:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xIJxGEc1QXZ1RcKZlcjhf5oZ3vhjq/vBcSj9ntl/GUc=;
        b=n0B4c8vF3uXc0U2QRZCP2Puug54wEENNNU2K2Z7lLOKs5Ak6K8PZr3M7Wk/8F0d9NF
         zryGV1LYrPASoDI9neNcWNXoaGLu2i0MriMczwQ/cUxADlRCcw4kmrbh+204tMtV+Qrb
         eMHy7vGBOjmShFQkwiNdmviJKJJvxhH1k8udRGK0Uo2wC+OntG4I+xuPgzOKblq/x2tH
         7bW+iMwCFqq5efuW+Mb/gIqq4MibdBBwvpzwAkWBEOGhTp0mx2AcRIGYeOu5Wte/bGgW
         RymB4+Zr6ZnhZr4EsgvpuoXvBprYZAD/nqQwR5cckJC/DZtzxLapXEEHNoQMJGoCAFQZ
         oY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xIJxGEc1QXZ1RcKZlcjhf5oZ3vhjq/vBcSj9ntl/GUc=;
        b=FIHmsX3X0Rg+1yGenc94h+8gCCtYfAhj/9Q2zvDVMIwqmw6EybOJegRpkthgRUYo6u
         Pqq+bsIQjQf8FvElHibofs8ofUvL05c0g6WZterZIOHf3ETaV2XtDhiGRUf3cMolI23N
         /ymNtKuQBzjAojqDBcBg5xSx17Jtjwhv43fMXyfZniwTv23XIYUUha6WMw7tJ0uOg0Kn
         nRr9fEBu7/QG8p9uhPyoLiCK+PQrsuQHf5PR5xto+5nSHA2Q6lbxFnfWVqd9HfT7ogyq
         cwdVONKHBwjmgNk8GNupqMeg3Ys7QvaU5nW7F/YF+PsHcIQY0lwsLRL1jjMEzGI/khZK
         DhIg==
X-Gm-Message-State: AOAM531GsteKyBIUBTmmBPjKzTqAO4SPJaD6mMJt+KMK6TfvBVw4TLzk
        YIzrsKK6UZmgQrRRjTOLEXI=
X-Google-Smtp-Source: ABdhPJz0hVUZVOmEVSFMVj10ITGCRQp26kdI6fMbWtW02DkmKeXXyETlrz1l3lPRvDJlGmIDxwpyKA==
X-Received: by 2002:a63:24d:0:b0:380:ada1:cd4b with SMTP id 74-20020a63024d000000b00380ada1cd4bmr12455357pgc.127.1649357709221;
        Thu, 07 Apr 2022 11:55:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d21-20020a634f15000000b0039ce7158664sm893218pgb.68.2022.04.07.11.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:55:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: broadcom: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 11:55:06 -0700
Message-Id: <20220407185506.2575806-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407143211.295271-1-krzysztof.kozlowski@linaro.org>
References: <20220407143211.295271-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Apr 2022 16:32:10 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
