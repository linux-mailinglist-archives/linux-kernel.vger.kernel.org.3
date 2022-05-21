Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E1652FC61
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 14:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiEUMcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240930AbiEUMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 08:32:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686969C2EA
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:32:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r71so9896639pgr.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=lIe2BuS+hmdG8AC61X4W4lVxIRLtVNB5bIbXaAUes2E=;
        b=xZn9e0CtL2ijpN1+ZzPITsYQVlCKSIw0zYEYMs9ibNQYitl3G4yzlB4qAfrtuBjd48
         /fq0XGp1DtLEMxe+SyW4PMENlvb0VDj0TthBZUFT62Yy4cg94EcfhRToAlP0T1v3A3gQ
         OS+8wvpaf3bwj+IMsGplvjg1RIaSmsZ5vWoTolouyPwGJuW/0pHzx519NSJKJZWXV58f
         LDvMDP7pO1dYPKdALkVtEsKyB8UCL9zqr5wxLrwYisc00/4VDDMmJBNylGz8Psp1ZrQ/
         lxPQUJneD4nB2J0kfdSCkvWHIzsKxQlOzFWq27Sj19TAt/6PF3wL5QOxV1LfZaA1c5oU
         gpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=lIe2BuS+hmdG8AC61X4W4lVxIRLtVNB5bIbXaAUes2E=;
        b=OChNHXBirNIgZ3x2SuVk9+hAg3Lz6qRXfvgmJd6eBLoP3XuZwXiFDx7j0EM/F92Y/h
         jGRZj7JKUDgh5iSDWJEcOD6xlSjNkn6i0issjZZRfkfuIQZ4lghjmfHpgVKSheZDSo5O
         5uHPtr2i06rY4d0pqK4eWTXk8C7ycDBUd3wgTNh0MQzHk7hS1DVWzrU05ngfreQasxXy
         8yuxj7+dIszDbLMzT+wvfb7npVtekA7whEKisB5sDFvH+MZNmURohcJMkTPdVfQZ5f+C
         +eRxZ9CQuQb5TpASjOraoFZIGzX11GRTMn31AMZK6+ELbI0OUu13FDM/jhWnvDH0Hl3L
         I3GA==
X-Gm-Message-State: AOAM533DCDOQ899kq0ONcJP/WZA4mcpq5OWVWbwkM7VNaFW8E028LIy/
        fZOAP2kb/pg4LsgrMFb+mxlkRQ==
X-Google-Smtp-Source: ABdhPJzRWPrUcTvufMhYzwWmLFMMgDj0nDGFmOBoKj6xLvfnguKOugOol+/wchoN4E3ubIosscAlRg==
X-Received: by 2002:a63:e50b:0:b0:3f5:e132:4526 with SMTP id r11-20020a63e50b000000b003f5e1324526mr12449716pgh.506.1653136361824;
        Sat, 21 May 2022 05:32:41 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902f55000b0016194c1df58sm1497724plf.105.2022.05.21.05.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 05:32:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Julia.Lawall@inria.fr
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220521111145.81697-29-Julia.Lawall@inria.fr>
References: <20220521111145.81697-29-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] blk-mq: fix typo in comment
Message-Id: <165313636064.19338.15073887794756259717.b4-ty@kernel.dk>
Date:   Sat, 21 May 2022 06:32:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 13:10:39 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied, thanks!

[1/1] blk-mq: fix typo in comment
      commit: 2aaf516084184e4e6f80da01b2b3ed882fd20a79

Best regards,
-- 
Jens Axboe


