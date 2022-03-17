Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686274DC4DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiCQLeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiCQLeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:34:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA046B43;
        Thu, 17 Mar 2022 04:32:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so1426535pjm.0;
        Thu, 17 Mar 2022 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=D1r2+ujwtgn46Z8IW9rsnE8ina0uSN8BH1oaJ82ex2s=;
        b=C090cHSsTT/XY1HvyyGEEbnYVln+2jSkSncoauLw4cuTHsmDy8LhH3sb3db0JoG/TO
         7B9zFaWm7eB6tFQ7nNsGKtC0rwM0MkAtSMh7jJOjvtIUgocKM73fqvXTT+m2GQZVDjGR
         kKbhNW20spLTZrW+1pGk/nRHZVmpuRUfIRlU4Bik5YU8yiINh4h4b4mv5Mq4okPhAwYM
         EgZ+y20MndMxzw655ovZpE+3Vu/1nT4KGhUzPEtt0pUgBW3LWa2UpyTH/QoEUG4+hg31
         MgFarz5drfd8lEXoRUJV0rytmJYQ6N4vm5KLdVdVnLqcWUEYv8JwMjp1BdHB4UbghOy8
         kP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=D1r2+ujwtgn46Z8IW9rsnE8ina0uSN8BH1oaJ82ex2s=;
        b=t2M8UHEDxYxuW7C80g1jBCgAsAJ1TCNfjhdO+LZAkQzPFH0LnGD0sQIs40H99s3g2Y
         xo+JOzroElw8XkQWSofsNagTsmtKzLaBrIlsUhK1chW/lBgntLgSK6Rzkr4lR4hATiT0
         zQZE0MOWti4fTaYvarT7N6u4LhlO3AWezR0RoXTjST66D7Ds4tepoKcnqapr1jUgc8TX
         MAFi6yGxK44YeSYbCi4jtdfXFJErGJcrD6SRjwBrZ4umxZgPwcaXlry7DMWA7WtyagmI
         VJ8QUdbNY344EoQ9lBlU0WivJzHCfRxVt3iUgrkvwARFkAcH4oHezHZZ8M/POZO0ZNJ3
         ytKQ==
X-Gm-Message-State: AOAM5325vJpCZU67g9HrhMLsocZwuDJxZFsiQXlkz8XIymXEg52leBP3
        xdxMym807N9giEpvd3K/0SOTyxRVrzCazw==
X-Google-Smtp-Source: ABdhPJxgb0qWeAujzMIl9E8TyRyXqgQbnoynbbARMY0OiKTJJ/cfUeu5waSoEQ8hAiDsuZL2r2I0pw==
X-Received: by 2002:a17:903:41c1:b0:151:f026:8048 with SMTP id u1-20020a17090341c100b00151f0268048mr4086675ple.41.1647516777848;
        Thu, 17 Mar 2022 04:32:57 -0700 (PDT)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm10097718pjb.16.2022.03.17.04.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:32:57 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:32:53 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: RCU: undefined reference to irq_work_queue
Message-ID: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RCU folks,

I like to use minimal configuration for kernel development.
when building with tinyconfig + CONFIG_PREEMPT=y on arm64:

ld: kernel/rcu/update.o: in function `call_rcu_tasks':
update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
make: *** [Makefile:1155: vmlinux] Error 1

It seems RCU calls irq_work_queue() without checking if CONFIG_IRQ_WORK is enabled.

-- 
Thank you, You are awesome!
Hyeonggon :-)
