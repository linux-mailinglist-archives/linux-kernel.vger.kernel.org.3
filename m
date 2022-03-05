Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD714CE430
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiCEK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 05:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiCEK32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 05:29:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C724EA29
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 02:28:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id w7so4601941lfd.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 02:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=B3GY5pHxl40fgyTRDEfHUIewqx+99afdPdvQA2cgGa0=;
        b=ImmE5WMlVq+YKZQ+V7DtrC8cjT3FeeZ53XNVKQl6B5JqBJI4CPjwieVN/zMErwWrOd
         NNw/Ey82kzlZ39SHRZP2OzMQcN5aemCIr2ACcHlBcxm27915JIUQywe9MM3lYzaRKAqM
         VZSRsFBJfW9e9VPPZNmmSio0xoLEhsXxysbR2xpUwmrEyBZGZrq/Mf5eXyQ1VvuSK/iE
         lk8bnIgNtTQ0ZZ8eG+fnafolzgcxxzD2dfkP4c5Mf4lkcpFEEHUFvrq0OrQxDiqdFzKC
         YH/bVE6WFQCrsGR9e6pE9ARH/oLpVw+/VqiblIguHIAr2ACKv9g4hGIgBraPGLX9h0NC
         E3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=B3GY5pHxl40fgyTRDEfHUIewqx+99afdPdvQA2cgGa0=;
        b=CxwI/546UyEZfuASYnUwLgt1CV73lME+x5+VfaBSApe4XfR1AnMfmAQKTQeZXIJe8m
         wCwIeo9NbvMWlm5vv3U0dOfMz0/DJDJ6qBUCOfSkRH9vN3nIJ6itzMTi5weWroqBXNSI
         t6Yrxa3qDDBr2oEHAGX4tLnfepMms0YEuzMRPp0M/lq++1OBxwqiiIsxWOewdaNNTjwe
         m7r16IP2xZyYAZ20bgw5tBf02I9kJqJ+C3CIdapFcasXswUgED7QjLy5iiycWjc4Opia
         zdx3R06KWtXBbh9yOfPuxAnS6d8ae8AQwQhEPB1kdsTQj6CKyJYWJKMSA9sLsdkPNr3o
         Cr9g==
X-Gm-Message-State: AOAM530HhQ7koIygOeFzZtKBqYVl44bNgKyJ5HAl/vZHA122G2FCbiyt
        vNZxombJhMWYSTBpa18hoAVLsES+yFsv+Yx5wiM=
X-Google-Smtp-Source: ABdhPJx1wPczKrARywIlL+889LXeODVcVFlmFIY4RimQzhPKlhgMYi4zYGPBG+uymXtjUD2gO8ix3BsOJZOV/jcCnXM=
X-Received: by 2002:a05:6512:3402:b0:448:c29:ce8a with SMTP id
 i2-20020a056512340200b004480c29ce8amr1948239lfr.633.1646476116683; Sat, 05
 Mar 2022 02:28:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6512:e8a:0:0:0:0 with HTTP; Sat, 5 Mar 2022 02:28:36
 -0800 (PST)
Reply-To: sgtkaylam28@gmail.com
From:   sgtkayla manthey <sgtkaylam20@gmail.com>
Date:   Sat, 5 Mar 2022 02:28:36 -0800
Message-ID: <CA+RGHE-2YB+pR+K4Z-Ozoexgp0DnQ1gozfOaCC-E0x2De53Lkw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
Please did you receive my previous message? Write me back
