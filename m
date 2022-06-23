Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6E5577FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiFWKfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiFWKfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:35:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419064AE35
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:35:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n1so27053639wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=eJTmGKpMQou36yVdLMJa1BC1ACYpQHoAzJ3NEnmQZyg=;
        b=n0TryeyZ+I86xPmAlB09rCrYq9pR4bfsv68LvkDJgCrNqUjZlMEKHgJ4EDbchLH1QS
         c3MYidhbxrEY2RhArZuR8xDnwDkZ78jXunQNkIWGXhpDBYT/PcFd+zW6+lNuR3eKlbXw
         SgKd2cAG+ZUwFtS9A5YSZrHw8gfSKruehQTn/s6HTHuxDeEwdifDydJetrAWpGTJLSHA
         wJp07Sk0FfszXyA4w3BWYVcnDRbaY4PdyKLi9OT3wNsSUO7NYPJXw8UMS/5CAlTPVYhi
         kI2P9/IHVRe3p8MUbLvWq3NzyV7eBkrYu+0Vf8tjiusaXHO/26bJnXS4sxds4DVYXYT0
         Xu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=eJTmGKpMQou36yVdLMJa1BC1ACYpQHoAzJ3NEnmQZyg=;
        b=BRk5auKVKL1glO+D88rVcwEsa989yRKFuX7RjchUxdLWLaaWFeR3OKdQmwK84iyo7E
         GF3ilqr3AZUWj+hOA4490cMj/R6/Mn1dUk1/IPPGIluYzhFYPwWGzHmtV1vKjAV+2/Om
         OxbwW4iNpidX103ve2x3hYczyNJg1Bgsa84rZs1lCz429NuWR2fP0KnCVnpkUaEmWwTa
         HxPae27Bi04lbOlDu03rd6EgYPFOdwNhoRPPiBXCNZxgTQiYtaGo4C1xx05+f4tE/Tjn
         PNtWqyyZSwtl2WTJKRP10oiUjpv+JY0eJT9ZahFUNiSebjm17BqAnfUAKK+GnjLIX/nA
         rn9A==
X-Gm-Message-State: AJIora9jBG6U7O3Q6vmILBoHTLz8rC5xfed3MCIB9KrtSK/DaNSpxahr
        W/2yuK6Dsegfu8iIBqglfNw6XQ==
X-Google-Smtp-Source: AGRyM1tGXSW7MWm9TKc9l1yw9FiYf1PHq8jsE/ai/bUEqBeX4q0KDqllVcGgFTKV4orB7Nq1PhY83w==
X-Received: by 2002:a05:6000:1a8b:b0:219:ad61:f4e3 with SMTP id f11-20020a0560001a8b00b00219ad61f4e3mr8231903wry.190.1655980529860;
        Thu, 23 Jun 2022 03:35:29 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c2-20020a1c3502000000b0039c5328ad92sm2657222wma.41.2022.06.23.03.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:35:29 -0700 (PDT)
Date:   Thu, 23 Jun 2022 11:35:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     stable@vger.kernel.org
Cc:     James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [STABLE v4.9 & v4.14] l2tp: Prevent circular locking and
 use-afer-free issues
Message-ID: <YrRB771x/JrsGjXM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Dear Stable,

Please could you apply the following patches to the v4.9 and v4.14
trees:

  225eb26489d05 l2tp: don't use inet_shutdown on ppp session destroy          
  d02ba2a6110c5 l2tp: fix race in pppol2tp_release with session object destroy

They fix circular locking dependency and use-after-free issues.

Kind regards,
Lee

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
