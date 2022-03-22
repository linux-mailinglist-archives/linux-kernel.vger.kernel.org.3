Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5494E3FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiCVN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiCVN6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:58:22 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1B3B00E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:56:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id x9so12501047ilc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=OzLduqLdlph/C3MBg4rY8qTwRp/ibnBbeg0V9G2gDQo=;
        b=AT4D/4nnVZsVLGbCS8njiF+0QtFbeyX5AXhhqYgeQfVvSh3CeL+eDjrN7FxhjU6Add
         2kreLvFu3/jqgw3I5ytOBQhDXyJQMCeQN8hG7dGzYUxqfQN6AYiLGxhjJR7BwKPRQrla
         qrlPY12nezhPuS3wg4n445Ey9pNleXXtiM+QTk8pg7QrQfWBC/+Lk6UeddSfCwKHMy0q
         YbFyOxFJ1a8MgCqpXdiRbn0XBTEffd6jcfegeQRhluJez+L9Emd7VEPpyzf1D6CA+ezx
         oc7egZJNfszbVnUtHCZtbA3wDXoWFtgAJXT8SqzldvPuFPywTCYu7pPeBGpor/iPgmnf
         RV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OzLduqLdlph/C3MBg4rY8qTwRp/ibnBbeg0V9G2gDQo=;
        b=2JosHefiLucL7eRpLHB9ixOZFwfVGPrSqJkCMU2y7ZvHl1+R5DDEaQFH+RUx31H2HK
         iU53T8004zFjgs207Cjyn1KlOyeIHZKVJegblPsQnwVCBPu/5Y2lATj9NCw9UDlm09D6
         CZa9FdbnfR7Wszn/JNp3bWATkH7kW813eesCDiPp9/R1OPSX/AeEv4Y93UQBlZdAxLAt
         NB4FHjsFQKuDKIlWrKNY9RDVhimqo5Dt0ESC6utHu7hc5/x6uz/9se8FZ5FvWHeAvzmT
         CKjKQwdwu2/eTOrP8LT7c/Y6ryp+uhW82Oi4Rwqll4a5TZCdad2uhSzJ0yV19RCQym6J
         LSAQ==
X-Gm-Message-State: AOAM530FuECmPUTun/z6XwffXEt0DCV6te8F79UFLxjTIglMY6relmnc
        wUSFQBMpwdXxgIoYmMwc8RITkhMVVAP+xNLFXjU=
X-Google-Smtp-Source: ABdhPJy+l2AFwPqfbZeCRRsyK3gC4SVQlhwkKa0bOM9EjdKUzQxDycP4cWtZyuSCDuIR6RENnu5TljNvysoYCR7xGmQ=
X-Received: by 2002:a05:6e02:1a66:b0:2c8:1f88:249a with SMTP id
 w6-20020a056e021a6600b002c81f88249amr5697753ilv.223.1647957412717; Tue, 22
 Mar 2022 06:56:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:2c8a:0:0:0:0 with HTTP; Tue, 22 Mar 2022 06:56:52
 -0700 (PDT)
From:   serge amidal <amidalserge1@gmail.com>
Date:   Tue, 22 Mar 2022 06:56:52 -0700
Message-ID: <CA+1711hedgG0gdsWY1rmErvrym9d0NJeyAVAw_Awe7yFnaP_HQ@mail.gmail.com>
Subject: message
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
 I need your urgent help to transfer an abandoned fund
to your account within 10-14 days if you are interested, reply to me
with your information for more details. your first and last name: -. Your
the country:-. your phone number. : -.
 Please reply to this email address (sergeamidal@gmail.com)
 Best regards
Amidal Serge
