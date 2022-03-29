Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765BF4EB21D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbiC2Qso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbiC2Qsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:48:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3AA6211F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:46:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p8so16389393pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=mjUJmj4POHLc72j+uESMrPipTUvziFqTLssOqNZTKng=;
        b=16bvm3mK5BVPEq0QsKQh8+GZ+eE3roFJbDhcdsWwz8Ho+JKpMBeJgHQBc5vEXGZTl5
         MyoYHuyex5gP78CXssjDemtj7S6fPfK7X8eP3FYhNjPAf3AI5lE0tnJANGvwoZzqP/Pw
         WxmltKzSxZV1WZB8zTh3uOTnae0eIbiGn+1aSmAZsDV/311oVeTG/Bgc1ltg8bJ+0fAN
         vp4pJaVXVGunFXuZZzGlPrAs7OxLKBy17is1ZCMJTGsvR8LfDSyu54kgns9+5vH0Z8eQ
         luAFgyJnoyCxTYL+/zKEBfV/IF3hV/kSxOHalp6TjtfIIehSJ5o099fb+cko7bEnMX7+
         9LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=mjUJmj4POHLc72j+uESMrPipTUvziFqTLssOqNZTKng=;
        b=CBmdGKZiZB/CwjO/GoVGwUWnCW9oyfWWFwsOAMkjjnxCp7y7WEfv4RBqXDfPXiQUH9
         Aks/w0AOebjWm3j2f/gbO1gxKu4VYhqc5M/DZrwyHi2WPFZRrkPaUhAcDs8WLBTRdB2B
         6OYKB6qHEdL5IsTk0cRYW0IAHLydJ7FVkKFCHKf05GlIBvEWA2Cz4OUNO0827Gzfv18Y
         4NPj+IS8zL0CZG3Yj4Ps+st5Zg5yhWrt5Fq05Q2Ls31t0JEfGEPdBGkDnXRTar/nPlBK
         fVoEgWyPa73ScXQ0ltIO6lpdltf7AuD3LLHyWqtD2W0rj5yG2bU8iRnN2+h38HWXskN4
         7Vcg==
X-Gm-Message-State: AOAM533ESW6WUM/DBTmYRj8jh9nlHFYfNP163ZF0Etazj56AhYx5qZ/8
        8d+21tJ1BEL0lINBY7pOyPZIGg==
X-Google-Smtp-Source: ABdhPJxTUNdlC9idt9aofzdeF/SqBgQafoUThLB6TuhkEmYTEqzNhlqRyTH3BuFi+mQCqEe8rTs57Q==
X-Received: by 2002:a62:4e4e:0:b0:4fa:b1d4:3405 with SMTP id c75-20020a624e4e000000b004fab1d43405mr28627061pfb.71.1648572415934;
        Tue, 29 Mar 2022 09:46:55 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e12-20020a056a001a8c00b004fab88d7de8sm20243658pfv.132.2022.03.29.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:46:52 -0700 (PDT)
Subject: [PATCH] doc: RISC-V: Remove pmu/ from the toctree
Date:   Tue, 29 Mar 2022 09:45:44 -0700
Message-Id: <20220329164544.29367-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        alex@ghiti.fr, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org,
            Stephen Rothwell <sfr@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This subdir no longer exists: it was there to document some of the
quirks and paths forward for handling them, but those have been dealt
with as of Atish's recent patch set.

Fixes: 23b1f18326ec ("Documentation: riscv: Remove the old documentation")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 Documentation/riscv/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index ea915c196048..e23b876ad6eb 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -7,7 +7,6 @@ RISC-V architecture
 
     boot-image-header
     vm-layout
-    pmu
     patch-acceptance
 
     features
-- 
2.34.1

