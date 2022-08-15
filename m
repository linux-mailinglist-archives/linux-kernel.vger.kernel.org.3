Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AD359271D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 02:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiHOAnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 20:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiHOAno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 20:43:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396236398
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:43:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso5505289pjl.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=lb7mKHsaIcUxW+3Jy2BJQ41sCMA+sLqu9myEjLcTq6E=;
        b=anOO2IPFLaUuSvUf9E7Qpg5p6/NmGeyjbW7G+RX4Cpx5BlVWkPf8GgBvJ24LzQxOB1
         ctAsE98DrtxgaaUdSiHcQSlJiRKmWMe+0h0aNLG8tGd+coHE0iZHcv42Iv8I9FSeQ4ig
         8EtCPqpwoL24/hmvTrM7aDJdvRstLsW3fOOIoDWKCMtHTjWmi3hAlBOkK4fqy4wHp/ZF
         WicwU5ysc/pHKg++a83qB5FMH36bRulq/+Wl++FYUvFFW5Y3xfEQG6LthDt+cvc0Ejzv
         RYRyzks1pwAqe+ZS0bdZxkc4pUxoYl0i9wEpndYSIE7d3MZHW57BOTY9X5T92HtE7hG9
         MvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=lb7mKHsaIcUxW+3Jy2BJQ41sCMA+sLqu9myEjLcTq6E=;
        b=Lxyr27mSgdYaHTEBTfP8omxgfvJlEOyUXzhr9aNv2tu9lLcXIxN/A8/UZ2oR6pmzyv
         x9F5nSRuXLKIpwkXe9n4IXlOU22+b/cJlP7XGUJav2AcA5/LRNSlpYxttCmuPfrILCbn
         xrswGJusB8Vvb8lSpj2mnEQkKtEP0LoqbI5K1zQ570B5qWwdRwceCg1u6M4oj8/E0b3E
         AXcBbvNGOEn9qBugnNzf1fQwrazHtpDa4AzJXGRzBYzdZwn9Q2MlSrg/ERAx1eRtP8cV
         xU6KDmvUEcL2UIpsszEYXdwX9GlDzJf60BKDNby+pnDxX35TZggTu4B4ZZyhIRwtJEu1
         rkaA==
X-Gm-Message-State: ACgBeo02azfpgWDfaobU/YbhkWcArx0K1g8Axr1/e0MjDek2AqKxKAUr
        UCEBc12+TdBrl2IQNKn7jYM00rKL/30oCMwaT90=
X-Google-Smtp-Source: AA6agR7uRPBdUCQJsn+HWXMWaemHpGc/nxXzJtR/ldFbFAE04XllZoATKRW9ziZ6ZE4bDjIpaxMvqBd87/TCVg7fGP0=
X-Received: by 2002:a17:903:2611:b0:170:953d:e03e with SMTP id
 jd17-20020a170903261100b00170953de03emr14890239plb.49.1660524223456; Sun, 14
 Aug 2022 17:43:43 -0700 (PDT)
MIME-Version: 1.0
Sender: ndubuisio992@gmail.com
Received: by 2002:a05:7300:c09:b0:6f:e3f6:8ca4 with HTTP; Sun, 14 Aug 2022
 17:43:42 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Mon, 15 Aug 2022 00:43:42 +0000
X-Google-Sender-Auth: kU1uFIzsDddQeG0Oes5Fw05x-9g
Message-ID: <CAO7YTNn=POK=wdFN1Ho9c_TA3CHRvgGLBwrs1L0fX76TEHdSXA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
Did you receive my mail
thanks??
