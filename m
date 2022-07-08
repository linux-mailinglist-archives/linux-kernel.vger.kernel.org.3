Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C356C43C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiGHWTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbiGHWTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:19:10 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910A7A2E57
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 15:19:09 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w2-20020a056830110200b00616ce0dfcb2so158543otq.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Kxx8TCaDSQdEmoq1MT4g1kMaGmbUTPSpUqv60KP7xA=;
        b=ZxVKN9dvP5JztVWedq/hOzhs8OoYK5hviyM4fp/H8A1WLKvd0UpPjU86A/tAR0eMnw
         VJkZQ9v9VX7uIf2KFHwFTMMep5m+YU6DiftDIKm+VdZXOuKk1XouA0Nt6otaREnuNkx4
         ALoq/pxYIr8TFAA98bz6FVqAoeGsAwp75xC+USCQVJKEoIo5wrHYrnkKdo6fJ88m8oGP
         cw21Ng588kwIvEewej1+CVmpzF7BPx6cQtYdvuNNGmaNGKYQappoYl/UIT3tdBKx+ejA
         wDW7zglOgm2bswdHDUD/nt4iQSs3usf8qMwudlJ9kjZ4WoCLEPoiR0bxraVr/JJkQyWr
         1Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Kxx8TCaDSQdEmoq1MT4g1kMaGmbUTPSpUqv60KP7xA=;
        b=tjMN9JM9lfB9cW06o2QS68IvIqOxwDkLTTKu5tCllo64Orb+v1+9l96gHjv5/YRgC5
         wqbrJG1fdf6tH3D2r31AEU8GxZDSzjnShalo+imL2/87/PDIJ5dYONRqIxjLYE30jurp
         yhpV1iQ4rOqIN24kSJGxwGdxSwzIFACPSgfwwXGx7s6X5bQ45luET93kacRMyvs8wvgV
         DJlQiL5oPEStYv8CM+68N4UDvNcn603ZznLGfpNHUAekI3PCQjPqXXCrjeVQdKfLsa8k
         6qNzI9zRToRfU0MFgxBD0/RcNW0K0sVjmUrQcL6ak3ufeeBDTIFmBoC1QBQ+T5gaeYJF
         gwag==
X-Gm-Message-State: AJIora+OiYTSXTs6QaLXzjzD3E9WnUsqB4QyWdBY/cHQMgJ1Z2ajiFZD
        jKymPnTNZScBqNTI3LeBHFqloA==
X-Google-Smtp-Source: AGRyM1svgmd7ZkykAPWXlD1EAAE54aWsp+kIe89t2k/ZBxGfYYriNpZdG/+HuTSFQTLSSZ3wWz8Tiw==
X-Received: by 2002:a9d:77c9:0:b0:616:ceb8:1776 with SMTP id w9-20020a9d77c9000000b00616ceb81776mr2478022otl.256.1657318748961;
        Fri, 08 Jul 2022 15:19:08 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y10-20020a9d518a000000b00616a2aa298asm48907otg.75.2022.07.08.15.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:19:08 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: (subset) [PATCH 11/12] docs: arm: index.rst: add google/chromebook-boot-flow
Date:   Fri,  8 Jul 2022 17:19:04 -0500
Message-Id: <165731872885.1018153.15545632847166031383.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <0ae8251f97c642cfd618f2e32eb1e66339e5dfde.1656759989.git.mchehab@kernel.org>
References: <cover.1656759988.git.mchehab@kernel.org> <0ae8251f97c642cfd618f2e32eb1e66339e5dfde.1656759989.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jul 2022 12:07:43 +0100, Mauro Carvalho Chehab wrote:
> This document was added without placing it at arm book.
> 
> 

Applied, thanks!

[11/12] docs: arm: index.rst: add google/chromebook-boot-flow
        commit: 1e061d985fee50cfcb91a1d2aedbfd43d2f11aaa

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
