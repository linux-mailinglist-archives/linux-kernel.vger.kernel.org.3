Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E291542945
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiFHITo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiFHIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:17:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6883855AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:46:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t2so16946913pld.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=xaoQPMzvfyBSVatXZHQ9ZPw/wASUdAlSu83Zsy+LzHo=;
        b=pBTGQKWpeC0cCspHFdSEUxykcQtGyCrj7O0WzCNVGGFoGjJuEf4mPksS7bJuJHTFf0
         s00Xjc4KiNwd0wxXzfV9uix9clCrpiemMLQxmUfFNGZ1K/hM9CYFxgwxULMwI3uXO08H
         HSikUHI4N7rns85OE4clhSAKmKIlmqO80X3eTWI3JZ5oYwpDmUFKezpzzQ+e0MHbZGJU
         RY77kksqcjt0O/o12XIqLk2fjJ2LPuOQW04f+PjO5fDcoMhoDCb+Sf1vsjHpGqXK0Tzk
         mwHiHAz0vMdO5Hsn5uMFJ3H39k9/plJnIgBR/wjf4bo7xtvhQVCf8GPcdKFgUTfl8HOR
         klHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=xaoQPMzvfyBSVatXZHQ9ZPw/wASUdAlSu83Zsy+LzHo=;
        b=Ibj0PkukI+046GtiAbKJEHsH1w4g2BcWOsomciyw5Xf6cI/9jEn7eytHpQUOqYtLJy
         4XYyNsJFfBGHPomAe+hSaP3Z16OlvIi0msTrcjJiP4J26VsqVMOc3a6HACO2vFiQlxxz
         oeulQ+cJbn9ATgEIRJnAlXkQDFG0yJLF7VGtm8M16YnvUWS6kpHpMTUtLNM3pjgAAxI9
         V2PQQRRArUkHsxvgWmQFio/SnZ4rIVDrO2Y+72zEs2mcFn9ERfffel7EH7oNk3MWxlba
         w/r4Rokr8Ye0cz+PGWYbwG+SxcHtEyj3WsDFAwpDoLl4x6ZUygeTHbdUmpydMtXYQVoX
         VFTw==
X-Gm-Message-State: AOAM530Jh1iUtnnDuXUS0fX6owhzMbYdQQ7MVvC7u+zjfcJcaP0jcFjs
        IqdDKu4THFAW97Yc9A7qf70+qTPsR+xFlnYM
X-Google-Smtp-Source: ABdhPJzJZWld+jb3QbXSLXClfhGUOhgJYA0yGXrJ71Y/3hwjSWqLrwOzpHI+HuAqpmLCYQh6lOKj2A==
X-Received: by 2002:a17:902:c951:b0:163:efad:406d with SMTP id i17-20020a170902c95100b00163efad406dmr32924408pla.55.1654674369972;
        Wed, 08 Jun 2022 00:46:09 -0700 (PDT)
Received: from smtpclient.apple ([43.245.222.183])
        by smtp.gmail.com with ESMTPSA id p187-20020a6229c4000000b0051c157f83e3sm6169280pfp.96.2022.06.08.00.46.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 00:46:09 -0700 (PDT)
From:   pay ye <pay606@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: unsub
Message-Id: <6BDB874F-85EE-4745-B7CF-F2091A949E58@gmail.com>
Date:   Wed, 8 Jun 2022 15:46:07 +0800
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unsubscribe linux-kernel
