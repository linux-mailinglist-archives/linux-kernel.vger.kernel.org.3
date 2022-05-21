Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C9652FC64
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 14:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbiEUMcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 08:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242064AbiEUMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 08:32:46 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8A59C2EA
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:32:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h9so1672481pgl.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=JgECGUYQPfzQccxjQJUi8fr2KJeySrPf4gVLNaVPy0U=;
        b=WXY1ugt3fKDzvhExzkLtPKfAnoaTleIm5nLQSD1VDR4y9vBVjrL0twjYEe0rHhtMV6
         1RyA3k/9mC8X7ckdY1XjXshHVglKqwrEMD2ZwIElo41MmucmJlUFkiMHR61XvU+Zf/6Z
         mylPQ6yvSzXb3yoRzuFcEw3dgwcJJ/uKKF355S7fw325qu/3dGuDPXD/sxL2KlkTWXcL
         spDpLa6rx2va0TFSjedicNGQH+fWRBMhIG0Zpx2uNTcJpO2y63MXlYsCKf0O5dCyLf/D
         8FLzBK1swN4AFRFmYptHnjLmAke3cowmC+hgzlRSKMV260ru/V6fjelTbufXtI8ZVVWU
         P/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=JgECGUYQPfzQccxjQJUi8fr2KJeySrPf4gVLNaVPy0U=;
        b=gRrUd/eXkY2uZ1oMYjjQij4MTCTgELy+5nEVLV+Q4vby2wsSogUpXunF59ZSaZmkph
         nKSjc0Gn2CNIt2hjFShvUzJTG4yfgvS+hHTDkN30CEjTStm8wyvGKOMmoiFKzsQDRCIt
         wwydj/arSZQDLQPivCDabxWIKc6gwSoBiyF2fS35Nx9kiVwTs5QW9AcnPwRTVwZLKJ2u
         nhl+13VHOrpW2Vd3F5ftUzoBozNz0v7MsbyX3iw2OV3BvHR/I+I0cJxEhLh2QIaErmhf
         7fdLBj9IAe6q9CXvYWAfcD6ODPh/unW7rFX9vXGLVDYwsjC09KLcO6c5hzNKZClz/Hvq
         jEOQ==
X-Gm-Message-State: AOAM531GgVRpWEwJajzJOursxUggBtp1rTKs+c+O2SDmpyU8S+99Bsw0
        +u8lROupKapisFO6+2Fn8ovs+h9ry5KAYA==
X-Google-Smtp-Source: ABdhPJyywiQeka0cL1QIQ52HrCa75B117/TtMloSmZELBFW0UPcqBV4nCigEW/gs58JskI9ne6BDZg==
X-Received: by 2002:a63:4765:0:b0:3ab:812a:ded2 with SMTP id w37-20020a634765000000b003ab812aded2mr12851246pgk.214.1653136365061;
        Sat, 21 May 2022 05:32:45 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e20-20020a170902ed9400b0015e8d4eb1f5sm1506394plj.63.2022.05.21.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 05:32:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Julia.Lawall@inria.fr
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20220521111145.81697-28-Julia.Lawall@inria.fr>
References: <20220521111145.81697-28-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] mtip32xx: fix typo in comment
Message-Id: <165313636386.19482.14816930857839555999.b4-ty@kernel.dk>
Date:   Sat, 21 May 2022 06:32:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 13:10:38 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied, thanks!

[1/1] mtip32xx: fix typo in comment
      commit: 537b9f2bf60f4bbd8ab89cea16aaab70f0c1560d

Best regards,
-- 
Jens Axboe


