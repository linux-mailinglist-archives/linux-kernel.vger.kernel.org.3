Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF1858A036
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiHDSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbiHDSGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:06:50 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708A76BD6B;
        Thu,  4 Aug 2022 11:06:49 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id r11so176722qkm.7;
        Thu, 04 Aug 2022 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=y3+JykshimcRvVUYlZhe+TenGi8byAV3WGSAtjZy0eA=;
        b=YSs45KNCZLfu4uJuUtGczuTH/TEv4YlnE6oTTVSDHua/Uql+ECewIwQH9+902neCcb
         rCjhq15b0NJS2b+rfv5kLrlKH+Dj+DXh8GbfUH/Rfa2+C/29JuO4Yzq4Kv1iCx8vU8gq
         +AngSNd4n56L1F6oSKR8o6UMIkO7zdOhigt2TanGCo5ZzO1BLwz0LlOHsohfJZDcPrcC
         PqXw0OGv67dYKoZOjv07MdwScHcRxJGUcDIiFZHRFYBowuOlhF9TwJZEaZOBtvyODgix
         OeYkGgNhA8LXJXVJ1ag3acbyUvWyhoM4h59zPvkA6FF0mof2zoFxM84Rkz/p8Hg//z3m
         ySCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=y3+JykshimcRvVUYlZhe+TenGi8byAV3WGSAtjZy0eA=;
        b=J95HNoyaUuoJ6cHTUJSRJosa9H4YG0uzMO1X8KhIg2XzRcxMk/MIgZpCDBnR/uPTVQ
         OYP4GibANtOYcjTf21Y4/aJNaKmQOwj3S3AAoTaVsRDhpPS+5MceegbOCj+5nxmydZtf
         3eQnC6UcPVltDQ/7fA3Hu1uJfCqPUmQDEuEWvMc+vRiUYP07y/WkqN1S7Gv4tseSo0Kp
         cw6q8zgdxJhs4bgTol4JPgGrUtdfqcLhpS1WrpPz7HqtKu/JoVsMGxDgTfDjSiZxK6o+
         zrfsY83it7zzaxoiFSrrJWKdClVFDeny8NyW92fYJ2C6JDscS0Cy/Ozw7+y8TO80Crc3
         TZFQ==
X-Gm-Message-State: ACgBeo25sA4LOc59A35duzUh1NfovApKRk0SwTO314GuT1D4c4GYNFiU
        /QlU4fcWaOaM8YlVNu53ZDs=
X-Google-Smtp-Source: AA6agR4Bnk+RQQz36m5puIvy9vdqcx4tDaJ7i51taW4+0gFJ0meiPCeayKXoHUijH/Q4K/6cb6OAtg==
X-Received: by 2002:a05:620a:bcc:b0:6b8:60f0:f419 with SMTP id s12-20020a05620a0bcc00b006b860f0f419mr2375002qki.157.1659636408364;
        Thu, 04 Aug 2022 11:06:48 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b5e45ff82csm1175635qko.93.2022.08.04.11.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:06:47 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, dan.beygelman@broadcom.com,
        anand.gore@broadcom.com, joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: bcmbca: bcm6846: fix timer node cpu mask flag
Date:   Thu,  4 Aug 2022 11:06:44 -0700
Message-Id: <20220804180644.1339317-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801194647.29437-1-william.zhang@broadcom.com>
References: <20220801194647.29437-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Aug 2022 12:46:45 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> The cpu mask flag value should match the number of cpu cores in the
> chip. Correct the value to two cpus for BCM6846 dual core SoC.
> 
> Fixes: de1a99ac0b64 ("ARM: dts: Add DTS files for bcmbca SoC BCM6846")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
