Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276A55ABEA9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiICLML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiICLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:12:09 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E2B6B8DD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 04:12:08 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l6so2444692ilk.13
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=upPQCftHoDomU/3682Givj5uYVRty3lpN8O9J87AHeU=;
        b=W2Cs5pOiDVytUfYn0uizp7RXDbljkNyI8Dhko8tlRlo6JVOF+8fz/ofEnrfCfBet9/
         jAbbj/Xt/+exyVQc5N8y/9JXizhTMmQmgOhTApFevOtz+nJ0Pef7ocFysG02PA7shToK
         NSgXjhtcZK0OXJOQ4KKLz9xd0I59zOgAT18MP5uzBTjP4rM+WEo9wcCmX/hoYhQ0o2SG
         3pWCweraeq3Br/JbNB2c5s1UA8HCX6aGicJ8A2mYtzaVxJNei/W8zhfCsjshUlMr+O35
         4WaQ83rG59DgKd43Kp+CSPKV669mcYyxgcd2MYuc/9I1T09/Twpmqcc5BKaI54iD1ia+
         OU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=upPQCftHoDomU/3682Givj5uYVRty3lpN8O9J87AHeU=;
        b=xe9Zb00Uy3p5XN+hDTTveqvuxiroOG/9XgDLWpxhLQQgen+UmvMFyFvWkID+Di1BC+
         KsEkZS1qPl5aiwzUvgh4t2BwCz1uLN783E9bvRP1iCLrIKfacrNVxQFpyJSSV/TSkEoo
         d6WtOzWXSAHX2EccXcAgYKcLMt8CB9oWv8zFz+okWeA4YYzMlX1mrBnvpasZz7BOtOat
         7TkaOHTykrB+nLzre1VDn595bb/Q5dxuAzwnBRXrpcrPXDNwnj5gOa5uVN3OfOynjHFD
         ATL0s75+ACErLkQwx9A40johW0VKLCKvmhJEiTjseeY4owAo8U/6lcCOU1FVSJzwQuAe
         9dcQ==
X-Gm-Message-State: ACgBeo1ciFp2FHFSkPIMpUd8oxIfR7cEDmg/Fc5lprIOglhu1tyuHl8y
        1LW3DDveX94MlzjScj8XF+8pUr1krACmL7qjeO0=
X-Google-Smtp-Source: AA6agR5u82IenTTZlNyFhN+CTCwId5d/4S87HXnQ084aLVMqdXXNPWG8SDlMrh+vJAaCKk63KRFDIo/ryHjxL8l7EY4=
X-Received: by 2002:a92:cbc4:0:b0:2e7:147b:6f7 with SMTP id
 s4-20020a92cbc4000000b002e7147b06f7mr21558078ilq.174.1662203527970; Sat, 03
 Sep 2022 04:12:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2b1d:0:0:0:0:0 with HTTP; Sat, 3 Sep 2022 04:12:07 -0700 (PDT)
Reply-To: Dr_natalia.johnson@proton.me
From:   "Dr .Natalia Johnson" <ttrvcdzwwqz01@gmail.com>
Date:   Sat, 3 Sep 2022 14:12:07 +0300
Message-ID: <CABq-8SQ2TYaFwdvBh6vJMu5L2eYDj+cDubi6s0neFLm7NV2O-w@mail.gmail.com>
Subject: Good Day Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the information

   My name is Dr .Natalia Johnson from United States of America living
in Italy am 33 years old medical doctor.
    I have important thing to discuss with you.. you can reach out to
me by my private email address (Dr_natalia.johnson@proton.me)

Thanks.

Dr .Natalia Johnson
