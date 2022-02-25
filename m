Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2594C3A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiBYAsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:48:04 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D68184B75;
        Thu, 24 Feb 2022 16:47:29 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o26so2537653pgb.8;
        Thu, 24 Feb 2022 16:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r049N3OXReoTi1PN3pmujCqBPamtnbVP08zrxtd4YRU=;
        b=lYEf6uCzPLcn7lSAGnRuEhK/d3/33Jdm/N4uG9Sii4JX7fY0jqjlEJIx7klm/+a4O9
         QtUy8CNhRQ3WUvKgz6/SfL7ZMCfu3Hi8NqRNPn3/GbRmgLY1ztpJfFaDS+nmCXIfW8c2
         5LYEkIlG9IN+Wing+nPGuXJY011WD2bS5t2bWuVHwpV9iu34bBGVDSUVH/wYtSBcMXs+
         6DXNq/Fix4fBBJsOSeSFU9IecKUAtorD4k9M1ymykvDtK5EZnEqtFhRLTtN33eG4iy/f
         3vNgchqet0A66Zb3Tv7i2TcRKbZ4pC77I2J9LUpAltBeuajfbIYYF4AiUww9omqEkEVi
         AgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r049N3OXReoTi1PN3pmujCqBPamtnbVP08zrxtd4YRU=;
        b=0iA8IhVYPKNWVnu5A2R6dhxebinlLP5lUAZOI+f7gjQf8KF19YjwL9El50KdWeUcwE
         jwrlsgP2PIFAHw+YhJGf6XUI7OdALtfdRk6PtOg5Z4d6IVaSDlnmYx8p+7B1UcEG1ndE
         wu8nwuNX8R4R73de3ITN/KXnwNc5WJo6AAdXTrZNVPO9h98bEsGhKyQvkfLU5mmIfXnD
         UZgt3TB3lLL+alP/bDAUjJO+K61K4tb37u+3Pqhm8XWxVTdbiIZ7TGKcMXjCp6g3VnT8
         bCJRDVoL0ztmKDMXoPiK+r2tNFDBTemIX7k/siijzzBuUQMHyEjXdyUKkz+AmwtsF7cS
         aGSw==
X-Gm-Message-State: AOAM530IBXeZosOGRfdmZZgKmxpRrK/bhZseqliJ17TjEWHUwC+6VczS
        6PteafmnOB/XGoXekvx8Zcw=
X-Google-Smtp-Source: ABdhPJzeq1bq6OfkXN4sJx+s//+0osI0JJunO5rtJFaOzukQtFKdftmXdPhY5Hl4kdnSgbyDN/p6nQ==
X-Received: by 2002:a63:1405:0:b0:344:3b39:fd27 with SMTP id u5-20020a631405000000b003443b39fd27mr4196271pgl.488.1645750048836;
        Thu, 24 Feb 2022 16:47:28 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a001acd00b004f0f9a967basm683706pfv.100.2022.02.24.16.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:47:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: NSP: MX6X: correct LED function types
Date:   Thu, 24 Feb 2022 16:47:26 -0800
Message-Id: <20220225004726.1106616-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223235041.2542331-2-mnhagan88@gmail.com>
References: <20220223235041.2542331-1-mnhagan88@gmail.com> <20220223235041.2542331-2-mnhagan88@gmail.com>
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

On Wed, 23 Feb 2022 23:50:40 +0000, Matthew Hagan <mnhagan88@gmail.com> wrote:
> Currently, the amber LED will remain always on. This is due to a
> misinterpretation of the LED sub-node properties, where-by "default-state"
> was used to indicate the initial state when powering on the device. When in
> use, however, this resulted in the amber LED always being on. Instead change
> this to only indicate a fault state.
> 
> Assign LED_FUNCTION_POWER to the green PWM LED.
> 
> These changes bring the MX64/65 in line with the MR32's devicetree.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
