Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAC8544DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbiFIN2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiFIN2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:28:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EBBC01;
        Thu,  9 Jun 2022 06:28:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d13so4586426plh.13;
        Thu, 09 Jun 2022 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Mz7V2xD1G6h5TvOs7Ag8m6DrvQ9A1f2IYetUk1d+PhQ=;
        b=B4zn5ZGeBYoVIcQ/k+mcJqq14IHOQj3uKEcxP5ZCiIyILNtXmeX1a3/pZULGcGoyKG
         9I0bdB9k4gCBE4shh70XOv3E86s8fLu3sfb0mIptRvcxAGmCsf28bCMBmAtzTLL1XylV
         CiMw/Vfz9t5DifHHm7LcwvGnHpoG3lnnxjvhBnH25Y2d5NagIuvrgYj8b/h2GFphW0qU
         8q/kFu29nmz7X9a/m0PIVxiZFgkXpKc7cqQ31wQcsdZarUDEdq/4DCXdjTAOjUktct9J
         xmIlPQKtrKzknalUYLDTowIkXiVRyECcpN7gX7ZAwWUbjygMkeLhrVE/rv/XZFYEcXVX
         SUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Mz7V2xD1G6h5TvOs7Ag8m6DrvQ9A1f2IYetUk1d+PhQ=;
        b=U5sBmBfKsMAN/BIjOsDGlGCHXIIloc0GMM4z2oKbXHjBiZKnV4GldADtn4uU/bpO7f
         GvTzyugwo89X5o+XJKIC0JFwnCQDcK+urkRwVoBzFMCUy9ZlquBzXdAGd4ilJoiGbW82
         XFvV+5vVedSpo/3zvbHS7Vkxf070yAGbAmNEyPKKZivY9LJRZTvPhidcPS8VTu7merHm
         m19DS55K7by5QhR9CLvWETkZL1uLR7dhPCaoRWlGAh3fl42URY6Td66u5c7m2YcqWJcv
         fv2HTtbInMpRuP7EUCINmPalFrGBzpAyUGucEhFerozmMzVwERNURbXJ80WnJtJ87wtw
         hVhA==
X-Gm-Message-State: AOAM5318vNVecHHdT17vl7ora9ZB7W2p2JWs9cIXiuWVtZPZIsSBZUyR
        zXpjuarRgIrhmLdTK90Dgxg=
X-Google-Smtp-Source: ABdhPJxsVethl6NbMzTT/j6FDOIG6XvSlq+VQNCFhGOK00BjXa8MIVhSqSAUY6ozNNcfG32Nj6MKjA==
X-Received: by 2002:a17:903:1211:b0:15e:8208:8cc0 with SMTP id l17-20020a170903121100b0015e82088cc0mr40322693plh.52.1654781324091;
        Thu, 09 Jun 2022 06:28:44 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090b079500b001e0d4169365sm18521658pjz.17.2022.06.09.06.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 06:28:42 -0700 (PDT)
Message-ID: <15636c13-7fa2-f973-6d3d-361222b839ef@gmail.com>
Date:   Thu, 9 Jun 2022 22:28:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 5/5] docs/doc-guide: Put meta title for kernel-doc HTML page
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-doc.rst has two 1st level section titles of "Writing
kernel-doc comments" and "Including kernel-doc comments".

Therefore, rather than using the first one, put a meta title
of "Kernel-doc comments" for the title of the resulting HTML
page by using the "title" directive.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/doc-guide/kernel-doc.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index a7cb2afd7990..9c779bd7a751 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -1,3 +1,5 @@
+.. title:: Kernel-doc comments
+
 ===========================
 Writing kernel-doc comments
 ===========================
-- 
2.25.1


