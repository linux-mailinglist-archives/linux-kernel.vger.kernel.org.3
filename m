Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8508158A047
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiHDSJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbiHDSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:09:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251DD6C100;
        Thu,  4 Aug 2022 11:09:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id w29so387328qtv.9;
        Thu, 04 Aug 2022 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7YtNDFh6ST2k4SsLWxBwY8nye0IX5sU3y1EdIwkl8Y0=;
        b=HJpiFr2FnpnyHX3e3nOjEhkmQm/yNnI9l+CFBLQwNOb03B0DEogNd7VszJ7oTvzbrk
         rg7cI1ao/sZqXQh3wdSV9/1lOdYp2MwwB9n4axsMK4YteGvXedRRoF8JNPUqeM7CODjE
         m3SY5D+Ef/pvyobfW1vSmOlPbxC4QLv990KT+F1rXRlxX73YgeqyTvP+6tfSZw/ajtBi
         tbYFFCW2rgS8yytQBWTE3MYrn8ggy6zZCCitVciiud5sjH8serplIN/q0I4xTKSH11Ro
         K7cXKek/ErYVt/X/f7oIhgDekfBmxyjZyXr1fZovuhAeOexGA8KqLIUbOD76i7AqB5Ke
         rADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7YtNDFh6ST2k4SsLWxBwY8nye0IX5sU3y1EdIwkl8Y0=;
        b=e24Aefcqw8Hcz8LTemlwiCFy811K1RedV34caq34hQlusX5AyzITLPbTT5Q66GEIC+
         LXDgDB/wT+PPwo8lZNstwPkGW4WyrGXs8VYO7p8YzwcFlBRMMHIfBzkzt8YXBCSXLRL9
         xgA4ZMRcHQQZ1rg9jwpo1CA4ghK/zBhxXK9Qa6CBtl4FYpA8YvbYjctY+elYXlDrYF9H
         LrB0lp/3oQZPNQ3Qm98jN3UeZJe+y22CXcVZYFnXeDUBLW/anSrOt/w3HGrKMP9FbEtu
         SLTsHv2jvxehmCpCTfekkp5tM9R8asWAjf8KLsMixitX+/y4rVfqgvNSOIGKNDQOQQmy
         /IKQ==
X-Gm-Message-State: ACgBeo1LX6nOKjVSVggf157dWcCzakFnc78taOmQwERdjL/ItTt2PHvN
        +NwbECQqladZeFzw4LfRn+5XzHjm9U8=
X-Google-Smtp-Source: AA6agR4Obr7D43Rgtf8qnfYZB5YyDWBlRKU3Ez9M/+NfyrSP4yG1KMb4xV8Va3K/IM3r/i9TkCl0xg==
X-Received: by 2002:ac8:7fcb:0:b0:31e:f635:c9a0 with SMTP id b11-20020ac87fcb000000b0031ef635c9a0mr2685442qtk.157.1659636546121;
        Thu, 04 Aug 2022 11:09:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bm32-20020a05620a19a000b006b8e63dfffbsm1195929qkb.58.2022.08.04.11.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:09:05 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: bcmbca: bcm6878: cosmetic change
Date:   Thu,  4 Aug 2022 11:09:02 -0700
Message-Id: <20220804180902.1339964-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801194754.29492-2-william.zhang@broadcom.com>
References: <20220801194754.29492-1-william.zhang@broadcom.com> <20220801194754.29492-2-william.zhang@broadcom.com>
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

On Mon,  1 Aug 2022 12:47:54 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add new line between dts node.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
