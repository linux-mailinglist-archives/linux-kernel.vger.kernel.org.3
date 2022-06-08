Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE709542C02
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiFHJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiFHJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:52:18 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAD14126EA;
        Wed,  8 Jun 2022 02:22:29 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id i186so19115536vsc.9;
        Wed, 08 Jun 2022 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8O+dWqJRmNXX42l+VfIBuyFVruFBhzZuKmMeYrDL58=;
        b=hkoxbNrBqAlZ0FGFOLDe5AB3Bry2Ykq7l9Dhemn4K6VHIHDrx5Y8QQJavYzlibjoG/
         FDSDZ4OckDv9TbGJQX5b6Wn8ZAyFJomZCLAzC2HiAo5V3q31MC2ZrB/bssFrnfHxNjsr
         CQeJt2wpvD8sUkf/f2AeBlNvKvct8HOrM/YZO6Ddn2+ibWm7YhTBm1+8/x4AOM2kNIWH
         xqNNQRB00l6nlEI9xVW/KgbiFigjkS4LbxsQO6VyVvEGwvBeDaTl7qHyD9A/xrQwT83L
         XhTMS61qcII60DeucnrRo8kYSYN96zeqL19rRSDeT8RYvZiJDPXnfvvg0YthpsPw007J
         19tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8O+dWqJRmNXX42l+VfIBuyFVruFBhzZuKmMeYrDL58=;
        b=VazuBR9THDRWGeKm4sQQ8h1bsq2shZNaTCCa6PlQHAvGtr/ol80GZh5cmmq+YhHvQI
         L6rIErxkGXBDygKhv9EfgCVFDAOxzaYDSicd282Vj6pDacc8AjTkWjBDUEI6ybW1H5Mr
         Rqj6zQkEyjMjOr7rFGHMFF/174bKm1BGAvWsDKZNlKQ8/N2J3WiO3AE5pRMIGv5RZb5t
         rDAM/S+9ENw8kspWAwjpgBtN8sTXrnD5bF3ub1CykTtb0t1TK8XdmWfgkMNrJO/w++SZ
         HqURMFwAfg8xYGwo8LoQ1ShxG6TGt/1Yzzf50OimpjNnYV7GBkrgD4ruKxZaHTj0ISqn
         Xx8A==
X-Gm-Message-State: AOAM530gvlEZB5kq2GOmhvR1fv8v4u8zJ1Wt96gbmZkGn0VPKSn2eO14
        y28Vh7ieFL8E9QMZMBXfj64=
X-Google-Smtp-Source: ABdhPJwwQ2eAzPtXPZklE6UqxsgzDYohhvbvRhkYC3OrryuPAij4OaKq7kMHYZGnNksdHmb+05buGA==
X-Received: by 2002:a05:6102:3f4b:b0:337:c02d:f5d7 with SMTP id l11-20020a0561023f4b00b00337c02df5d7mr14462774vsv.50.1654680135517;
        Wed, 08 Jun 2022 02:22:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c1-20020a9f3e41000000b0037559ff42a4sm2694770uaj.9.2022.06.08.02.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:22:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, florian.fainelli@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: update bcm47622 dts file
Date:   Wed,  8 Jun 2022 02:22:12 -0700
Message-Id: <20220608092212.1463998-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601233606.23281-1-william.zhang@broadcom.com>
References: <20220601233606.23281-1-william.zhang@broadcom.com>
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

On Wed,  1 Jun 2022 16:36:06 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Fix a few issue in bcm47622.dtsi file:
> - Remove unnecessary cpu_on and cpu_off properties from psci node
> - Add the missing gic registers and interrupts property to gic node
> - Cosmetic changes
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
