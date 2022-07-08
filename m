Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEDE56C1D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbiGHVG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbiGHVGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:06:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208DA2BB2F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:06:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p9so101779pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZe5BMNx4cRlflSd59EdV/q4BTwE2ovrynFT6CtNL1s=;
        b=GReZq6IymToQ/dN6s1ulHlQPvao/0nKSKS8kk8ZYMO12XvWkLDPzmues+WwFov59A9
         0YD1gSY8uPmSflPoSBBzUa9FenubKzFSeZBhK70Tu/0t8IyJHy+XNjCkjgkjrJw26KZF
         q6ZIQp3GqnZLaMFt9jkUMKbz/Pwf+2dUH6SZ7gicP2CVb1Hhs3VBgr0kpeEd6p27vHn0
         DV1OwuMi+YKSGDaRPowUgJY4X38VZxOkTDDB/QNXZhFWOx9kblJ6Dil7EtS55DHi4uAS
         yJ7ENLYy0JYMild3rwUtxdvMUwn00qSkxNeOLuk0dQuwfQY4IExkZVaYG5jCoV0drar1
         2isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZe5BMNx4cRlflSd59EdV/q4BTwE2ovrynFT6CtNL1s=;
        b=yf7eeYIXV9pykI1NUo5u/W000uuD5pI4gTh9X545BOFbOHv16QiuHLne8zLaH+Zydn
         cq/4erarVNJba4S3IajyoZ7TdSgjS2BlZPRMcXJzZhaztqNj9a5CP0uTXJVBfM06WbBa
         bNelMRqvE0XlL5RZdk9JXSjdG4rRrUEiCzhKm+1pjNN6sDzrvnhlA09yy5BmImNbWpz/
         wpuul7UxfL36kMEgbLq6jx+3grQGQ4np4MnP5xaYbEAB0YD20s3ccGqIumFzf24B2nZx
         3zCYwx+1D0N1pypVwV8HyiTOaKWa6sT5Mp/H7stlMa7u+GImuHQ6G4QvixeJmVaNsXqm
         pw5g==
X-Gm-Message-State: AJIora/eUxj9oETloLzDOL5wbW7cw/VKTdbdxXJxbgE9AeZbuB769d62
        MJdkfEmUog+K1f0jcasW7m8=
X-Google-Smtp-Source: AGRyM1up9bBi68PXZcgPwVraAr6U0D0Epe/O07p32PfUlajGLsQfm+xDmERZouVZIzuBh72DeY9Akw==
X-Received: by 2002:a17:903:2287:b0:16c:b0d:2e99 with SMTP id b7-20020a170903228700b0016c0b0d2e99mr5644300plh.120.1657314414481;
        Fri, 08 Jul 2022 14:06:54 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g81-20020a625254000000b0051be16492basm2996pfb.195.2022.07.08.14.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:06:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] MAINTAINERS: Move BCM63138 to bcmbca arch entry
Date:   Fri,  8 Jul 2022 14:06:52 -0700
Message-Id: <20220708210652.2659104-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707070037.261532-8-william.zhang@broadcom.com>
References: <20220707070037.261532-1-william.zhang@broadcom.com> <20220707070037.261532-8-william.zhang@broadcom.com>
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

On Thu,  7 Jul 2022 00:00:37 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Move BCM63138 related files to BCMBCA ARCH maintainer list entry and delete
> the BCM63XX ARM ARCHITECTURE entry
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
