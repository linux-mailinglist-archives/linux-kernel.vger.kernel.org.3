Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3C856D2E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiGKCLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiGKCLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:11:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEDA18386;
        Sun, 10 Jul 2022 19:11:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j12so3271476plj.8;
        Sun, 10 Jul 2022 19:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKyXs2M5gEl9Yy+kDXx9obgwPlNnBsHIdeS7/5Z6+y0=;
        b=ANyA1+bavb+wPj3jrWTQhLx2uS77yjDqCXXXygZAC7O6KXmx9VWGZPt6F/NYKgS5Zz
         jNQe0akLrOAAVeryR7dK3yR5bszQdacrYNKUt2WAx2sVkaGpaJbbenm/FFz0BoGJvPyz
         TRg1i0lZapp5XPjVEmc/IDpnHOJbpCWMcs3W3C+Zo3YW3Wf7/MqGB9078p6yBG4yzq2e
         zMICnjK6kEs6Ud95y3mP8jPCE05c9o/DzX9ztrpyuKXDSv0Si/qLyQLZoMn346/FuBol
         3B6Cbf5k9pakEtnBj+hxFdW9wiGkiLa5TLRHaUhtzb4RvjQqyxuTen0A+v/feH1k1yT8
         U3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKyXs2M5gEl9Yy+kDXx9obgwPlNnBsHIdeS7/5Z6+y0=;
        b=qFkVwVwtDebuNKpxLemWBFykhyY+9kmG8jK466tJI1GyguLI74xkFO+vdkvHCv2qHY
         iLP7eD99zYLpBaxMjUjhQ73nvWOgsktsKZtelM7bcJjUzCClz8zYsZAc3furZyPCsEQD
         6hhelZTbVgjyPDzvxwzb7S8UtbCbCLo8ddFYLDTt0V/v2pZMu3JiasDhozx50rq4Ypcq
         o8ZUk32Iflm5/x66ZYY8ZQgiytx4l6K2p6BBu5h1c4/GryvfD6rjxpH4SNfAPGnPz2qY
         /RhWW2LtNi8gAl9lwXUGXLvhVMahMbVHzOOYSczlsc/uj0TjaRbUp7zXUj79qYId4vcv
         eTAw==
X-Gm-Message-State: AJIora+QfwPgquIaDo2DtADQA0crT26/ndBI9LU25ecDDEjaBclkxO5W
        RcWmnl2VkMnQmoMbRZWIdWI=
X-Google-Smtp-Source: AGRyM1s6aSzvsV90fMi4YcYdr0dkcU6oa4VXpm5EAUB/dRNgS9rN71bPwsWzqpMfGbENOhWJ3yethA==
X-Received: by 2002:a17:902:c40a:b0:16c:408:57d6 with SMTP id k10-20020a170902c40a00b0016c040857d6mr16098167plk.157.1657505494273;
        Sun, 10 Jul 2022 19:11:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b0016a4f3ca28bsm3357619plh.274.2022.07.10.19.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 19:11:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [RESEND PATCH 7/8] spi: bcm63xx-hsspi: bcmbca: Replace ARCH_BCM_63XX with ARCH_BCMBCA
Date:   Sun, 10 Jul 2022 19:11:31 -0700
Message-Id: <20220711021131.3289881-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707065800.261269-7-william.zhang@broadcom.com>
References: <20220707065800.261269-1-william.zhang@broadcom.com> <20220707065800.261269-7-william.zhang@broadcom.com>
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

On Wed,  6 Jul 2022 23:57:58 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> SPI_BCM63XX_HSSPI depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
