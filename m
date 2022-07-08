Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C60D56C21A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbiGHTpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiGHTpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:45:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716198736E;
        Fri,  8 Jul 2022 12:45:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q5so1510340plr.11;
        Fri, 08 Jul 2022 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UjgUg9m5Mx2p5AkJvp3yniZ4eG7XfhGCA+MBNolgs3g=;
        b=n7mv1+7pdZuwst35d02aBT+vpfhnIkdOESZgauYGuYaOmYBJVGcxba4x2K9q62WMJ+
         0Dt8yR4RLmBanqISHhQJv7q1jIMhK0M5S3S39h/9XEOkNV3qzf+e8F6Nt7VLuG4VO8Cx
         N60XBhUnpN+b4JJtrrK3r+Nmzt+6fmpN4PBSvz/9cqE7Utr4dllRTtL7bGtDFrZ5Geof
         HQ/808EbEPy4r0FERvmSqA85ibGyU/7/QYhCxMVDqswa9MciueQsJD4jM7/DODzFor7F
         xY+uf7gQ0Rm6s5iRPo1trb85w/rmgp56wNTLilLfW/mtnsOcx2zL+X4o0TC5tBLXBuoM
         PAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UjgUg9m5Mx2p5AkJvp3yniZ4eG7XfhGCA+MBNolgs3g=;
        b=B6tPPZ1+M4eqGsdu9Jn+SaODKrXAi0fMdaZJuQP3YkFtaWvJXvH0GzyNrUB+PyZo0Q
         mLV2j2WJMPfiq1VEaBCg9BBPnyQPGGFxx0fRkRgKzxYVlRPkgOAfy2SwinI7+Z8hgzK6
         a9egwCOFGQtOz9Nx8PvB8qylendupJST/GruwaC09D728lBdMwgS7irAtpyJSl277I4p
         dJ5VFmxuhTAgq8Pffo6w8sWkFAqLocnpH2M2fsKyr0UeweSy2Caes/z0S8uIVTWkqKQG
         lnrM7rTrwto8qEQ45GVHzD3twC89P86FHC5EZLEZ/fl5EuXkOvYTWHUyfcl/HD5nPafo
         Oc1A==
X-Gm-Message-State: AJIora/K8OsBX8o3jacMGgzKKp/UlYC/4bTPVduGIaLP8/qrGVahG+cX
        fTeCOuHgefsEijSNN0G+9Ek=
X-Google-Smtp-Source: AGRyM1vmy+p7PmKUu/aArbYwtrvA5gXRg9ql5tnhFEERwUEjhGcfHXXEUzQ7EbPLSb1flP98vnnYOw==
X-Received: by 2002:a17:90b:1805:b0:1ed:1391:c8b7 with SMTP id lw5-20020a17090b180500b001ed1391c8b7mr1660423pjb.193.1657309514866;
        Fri, 08 Jul 2022 12:45:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id fv2-20020a17090b0e8200b001e292e30129sm2023727pjb.22.2022.07.08.12.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:45:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: broadcom: bcm4908: Fix cpu node for smp boot
Date:   Fri,  8 Jul 2022 12:45:12 -0700
Message-Id: <20220708194512.1857741-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708182507.23542-2-william.zhang@broadcom.com>
References: <20220708182507.23542-1-william.zhang@broadcom.com> <20220708182507.23542-2-william.zhang@broadcom.com>
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

On Fri,  8 Jul 2022 11:25:07 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add spin-table enable-method and cpu-release-addr properties for
> cpu0 node. This is required by all ARMv8 SoC. Otherwise some
> bootloader like u-boot can not update cpu-release-addr and linux
> fails to start up secondary cpus.
> 
> Fixes: 2961f69f151c ("arm64: dts: broadcom: add BCM4908 and Asus
> GT-AC5300 early DTS files")
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/fixes, thanks!
--
Florian
