Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA85431D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbiFHNqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240816AbiFHNqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:46:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA36B27FE1A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 06:46:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cx11so18651008pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5qhdiuPG2azU5M0qVLOQEvO3YubHAplKI2SWdC6ZWiw=;
        b=BO0u3hqfMTwVervrNwBa1bA96YBVioTs0E5Rj+M04itu2ndsV6XH23Lv6IIhNSVRjC
         Yxsxz1W2PnKw3A45sl3M9VX2BKj4gyI4sK+mnB/M7peTzuid5Ji7CRWoTlPCBWbDajY9
         QYGy3qmjM2gvgDIaKujCvLB3aPMrmYEHSOis5XFmwZSY3DGbaWp2eZvJMvKREnZZMEMA
         oy/4WrVEJwLnLN1A9JCYS0aD+SQti7lY3+xxGcf8ww60qZiH9tZ9AV8J1CVO0TY5bBWB
         RaW6qDleAztft4Q/whcqjmok9jTrHmvKrUDvN86rNKSNfRGXeR8vTvduJOQ7L7aRvNyc
         XU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5qhdiuPG2azU5M0qVLOQEvO3YubHAplKI2SWdC6ZWiw=;
        b=fgoinjvmP89WUIR3XIUy0Vb8DtmLQwalwfqBiITlPhqHnLzN4DxKl/PftX5y1GkWMV
         1Xh4xTIu3plYkP34DNIY6I2BbS09BkdnItg0dqAhbvhSWcAMmFr4RbOg7wqoheHURB0N
         +lA2xbcZOoT3n93Wah8PiG8hjfx+Oo/0bakzMBMeeKbMudcHzUbE9EHwfC+j8qaA5qMG
         vf8fwBT5ZKFlTnqsGP8uzzvQJnn7N7jLTglm+xfvi8APFNGeEXH38w/08lRgkd1skqSs
         /G/uo6MLEj2Sq1PTUoz8CG9cwO+ws6el4imqXC5gvnyWDmvEaMdkXbPhHQpVfjO2+1hr
         YdVA==
X-Gm-Message-State: AOAM530K/0XS8oMO4tpZ/WtPbdvsSMPcgu1ZAeaGou/QwEaG6mshYeq+
        n4yGuPTGD5dek/WEwPHcC9W7TX9GfD0N76O39tg=
X-Google-Smtp-Source: ABdhPJwd5duXOpnjJ0yZoOpYdyf8T+bS1k5x5Ta1hBoCZ3pGELN8JCoSACxYqlYeZsSVYoo+Ew23xsCZKbTeuY5p0pU=
X-Received: by 2002:a17:903:2488:b0:163:b2c0:7efe with SMTP id
 p8-20020a170903248800b00163b2c07efemr33550059plw.164.1654695999175; Wed, 08
 Jun 2022 06:46:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4f49:0:0:0:0 with HTTP; Wed, 8 Jun 2022 06:46:38
 -0700 (PDT)
Reply-To: jessthwaiteandjoe@gmail.com
From:   "Jess & Joe Thwaite" <giftbasseyibor@gmail.com>
Date:   Wed, 8 Jun 2022 06:46:38 -0700
Message-ID: <CA+SUxHCX5bfi01w366V=gUeq0F3-sgv3NnQfpHcWewd2gfm3OQ@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

I have an urgent matter to discuss with you that needs your immediate
attention and response. Reply now for MORE details

Best wishes
Jess & Joe Thwaite
