Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CC44F1E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379758AbiDDVra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379992AbiDDSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:35:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A70DE6;
        Mon,  4 Apr 2022 11:33:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y6so8875657plg.2;
        Mon, 04 Apr 2022 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTlJgdeE3lDAqjCO4JsmP8RkA59LG12ag3IJtKwIY0w=;
        b=P+dfA3xvQXkqkDVlraLxZTQnIMWTwarqXlYTJ99lRVk7T2xkorG4bZnidEdbaLbGES
         RyNomIVom+PWAe4r4wm2td8PnRxJ9fAslAsGGwkaSzZvwUETX8b6s7pETYTcMoWWdkRH
         aHxvAIhs/IbxLyErjub8jgWIo187ee97PNZ2Ucy9yi18MGSTIY2Ona5H4w53u9CExOgg
         0NG53Fk4vnKnuZlUnihv7Vj5hPA/pqAxYAir8fpcby0uEDowXno2DUlEQOMk0HpKq6Fl
         yRWuvEAWnpGK623LtUxevSPLH5yZhlzfBdYTJ53WysTo6T0Gfy7XshDsS60LFpHGAiS5
         /EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTlJgdeE3lDAqjCO4JsmP8RkA59LG12ag3IJtKwIY0w=;
        b=349U9bjqolacvAF4TKlIz+2Gd7qTGBuC3N/ZYwht3ZvGxHP1RBsMYLidX/ELmo7HeA
         asSRettZfdQigejH6qFFh+XfHF/UwPachcyXD/X2DmMaqkDMo4FzJ/e2lfJWwGzv/RrK
         G3x10TKowmTm6PfHormpchrmzjv+guPiwdWwzysOfLm/WHswv4mdcn5fqRuJTRJUD+Ik
         hhpoZmT/MFzSju7MlekRmeGD2Zf5LlK9N6kz3W6P66WemdIlT73y2dGRbkfUrUw66sbj
         wfzVqetKKqgigp9MDMf0EuyL4no8M/QKBOrTABNG3JS/bxyL916sITK4sMkzkAFftKBL
         UxaQ==
X-Gm-Message-State: AOAM533CDjOP9IM+YcMDT8JD7NyhhlW+nrCdnx18ZUvHa2dPDeGwHDCP
        4EfdttWvYUaVnkIc6NY3j6g=
X-Google-Smtp-Source: ABdhPJwNXvwaTH65EoOOHPTEfB5Y2JfrzarbaacpVXtcBxzrJWqO/r0jswwpURqlCoHbrfBnh+mFIw==
X-Received: by 2002:a17:90b:224f:b0:1c9:949e:2202 with SMTP id hk15-20020a17090b224f00b001c9949e2202mr567659pjb.56.1649097212048;
        Mon, 04 Apr 2022 11:33:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b13-20020a056a000ccd00b004fadb6f0299sm13163917pfv.191.2022.04.04.11.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:33:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: brcmstb: fix typos in comments
Date:   Mon,  4 Apr 2022 11:33:29 -0700
Message-Id: <20220404183329.2316211-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318103729.157574-34-Julia.Lawall@inria.fr>
References: <20220318103729.157574-34-Julia.Lawall@inria.fr>
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

On Fri, 18 Mar 2022 11:37:29 +0100, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/soc/next, thanks!
--
Florian
