Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF256422C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 20:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiGBStk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiGBSti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 14:49:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E769DF20
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 11:49:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sb34so9544604ejc.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CdAV/6GUNOpdTz1C7hAmWiCc9fjEGHw3vQkBTwxBEOY=;
        b=FMn02QLmEMmkl/6gZP3RKuRZJVWU68THnsRAGKmQHz8Lrr00VWn01EGbtZhub1l4Ob
         i2WDfca2lqmi1irUTtYplzgqAMyoEL9tMGaMXYyloftE8yo7Ok/PikbVJ9i/6SqNMWsR
         ZeFjcT6CALaYjBnhwBrmmmj1++iwEx+fJe/9APaRMTKQ1zUfT19P8jgM7ZzTnPCPd5WF
         IlNHUyfy7xHp+UY7UjCEoZ11C7OvrvUvOf0FpAFe2nxVISTeekw46owJLp0kyNLQDRbn
         dqo1gGen8dZBgXXu+yCiugWtib4sJ6dzmzE2M3Th85POv3ZXQT7JMotp//zSTD8q3Tsu
         q79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdAV/6GUNOpdTz1C7hAmWiCc9fjEGHw3vQkBTwxBEOY=;
        b=fUNxtnEgErMxcW8ncTgFnlBlnJZ3xfpSjVxj8gUL1dDc8vaiYeCh7zjOUEt5WlsA23
         WPi8Gi2QQoD5rZHTvtnPo3jnyOHUMAowXnM/ABy8eKVG0V7XR2gLblc9S6blCdnGBXYm
         IHciH272SGqYIWDyefBdA6L3LWUxdZjTvuQeJOobEZioMZBuiwnyTWvgnmsLT27GC+YH
         0BKbW2+uItqGhUdJgGakVtFXP7Am4fQ4hqTLK499wtjmnc0aeUk0ufuOu5u4WEHYTUnn
         FPEdlsKBfz7WBadPftTB0UMnD+cM1UFPz2jWsM26K0O7oxH2WMhpxXhd6BW3EZwVHBpU
         42oA==
X-Gm-Message-State: AJIora/tex3oESl7EN6viViK7Y/ze+ScJaKrbky0XUSfCPc1y7BCukk5
        wEx4qSiq+0Yhx+t2EvHNQE0=
X-Google-Smtp-Source: AGRyM1tenYnX0HVtR56fkd/R+fWFRKkwPnmcJxGhx2/merGL3RJjmFBCmigs2vqU63stKLD9E04ysw==
X-Received: by 2002:a17:906:4fd4:b0:722:f223:8d86 with SMTP id i20-20020a1709064fd400b00722f2238d86mr20538747ejw.558.1656787776015;
        Sat, 02 Jul 2022 11:49:36 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id p19-20020aa7cc93000000b0042bdb6a3602sm16927232edt.69.2022.07.02.11.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 11:49:35 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sun6i-prcm: Update Kconfig description
Date:   Sat, 02 Jul 2022 20:49:34 +0200
Message-ID: <10103142.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20220702184044.51144-1-samuel@sholland.org>
References: <20220702184044.51144-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 02. julij 2022 ob 20:40:43 CEST je Samuel Holland napisal(a):
> This driver is used by a specific range of SoCs between when the PRCM
> hardware was introduced (A31) and when the PRCM CCU driver was added
> (A83T). It is unlikely to be extended to additional hardware. Update
> the description to include the full list of applicable SoCs.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


