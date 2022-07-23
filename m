Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC35957EEDB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiGWKki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiGWKkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:40:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC14205E4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 03:40:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 6so6304102pgb.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=RvixvEFXBR0adssMHxjD3AXVBSKKEh2HjeorcXyVOEz0xchEQYNdCv5WW/LBFEoFPI
         hz28OgVL2unL9sevPWvmyPc2+oVWd1CU4YhYr7wPIS3BtKX1tAQY0ruTEiH5H20f+wJI
         2FRwEan8nvjBqkwVLHAoDgd2xHsjYrkBVzSKwsw3KGFVZOML6vSvyTwMGg/2coxf3qQm
         M9tdabPsjrWL2YmoHS+nSxZiaFkjIjZSEV4MMqpe+fUiyVtdv/4ms9shtEqIWgLW6UlD
         USKOdpUfF2ivSbPym2Xphu0Ytuw3dqTnxKh2dUqRFZvziwdvZYYLZt/MdZepPWeczVnp
         QBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=UEc1pG3t0zprRjiXbAOQW15gSgOus5rO/sNpJme0pEOm+HVfU4u04IXwt0nVcznqr3
         JlznAckF9evhO239uoaIPYUMAb478dKCyCLVRacXb0CPpC7NaSTPSl4NBOhX2R7kCIlg
         uLvLSvm8VoiWmWL+uaTOMCmlLsz3TKQImxFibN0vDOUYy5ux8zPAZMrFW9BfhHZpb4JD
         Hde5YC//hBciIVC4Ga+Y/hD2sdpdD4u6N8z8ODQucXitB19dGwChMUoO1QaMB+WvZOBx
         61KVmOE7cTVZPM4DYJZu3AH8PKOaZ8l2sge8qHG2WSE2orw5PvIMV4uOF4eibnEgdOop
         VH0g==
X-Gm-Message-State: AJIora9CHxKBh/Ajs/fjbh9whv+JhKyJGTpYtgM0t36SMlo03RmXnuQE
        Q4CWhrYYWymGjh8T2gjHUo7rsI5SLSDu+8sLEjs=
X-Google-Smtp-Source: AGRyM1uVOc3JqMDM5P64subMt26axUQcg7yfvetcRQjZGoipdFSFITIbjGxFdh/OhXNSyqrqSkQxYx73U0/ywjsQyRQ=
X-Received: by 2002:aa7:9519:0:b0:528:c2e0:b7ae with SMTP id
 b25-20020aa79519000000b00528c2e0b7aemr4147417pfp.39.1658572835148; Sat, 23
 Jul 2022 03:40:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:639a:b0:42:da7a:c7c2 with HTTP; Sat, 23 Jul 2022
 03:40:34 -0700 (PDT)
Reply-To: drlisa985@gmail.com
From:   Lisa <hanksrugo@gmail.com>
Date:   Sat, 23 Jul 2022 12:40:34 +0200
Message-ID: <CAMamXdSzMoL-Q3bQTVmFDbsdzWd1=FivndX6XTrqB8X9z-fTJg@mail.gmail.com>
Subject: Hi.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lisa
