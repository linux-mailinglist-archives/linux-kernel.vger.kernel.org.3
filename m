Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2606758541B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbiG2REF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiG2RED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:04:03 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234035C36F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:04:03 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id l68so5198996vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=6zatqDCQGQ7pcyKsn675gStM1jLZTDHMOU3KbwKZIXU=;
        b=DaZOfmfWox6JldZkjME27+h4OILP1kD1qdJCUQa09VMxSMAl63LAMZgvNIec3mpyz4
         0oIrQ2xifCgURzyApHI20US6VNfjoQC2jPXL9jxWjyr9lZA1hFnUQgEL9EXlDWPmJVDD
         Z+WaXjBxMzMXbjzO7Fmh+TshsmrLsh5OTH+3/csuny0o9pxwM1vU+/6dV5oqX80IkY1j
         cfIgg3FwFsNVIlLga1DI5nRIIR5Mof2Jcd05+oN/OcGyCQXDfzIs/guoNWi2ffPMYh6l
         PEhRXXemD+2t0Wzdb3Ric6OWG52M0KMeEBZkQuCn9Q7wgt2n1JTkP8T+AKBLRPmoGgE6
         sCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6zatqDCQGQ7pcyKsn675gStM1jLZTDHMOU3KbwKZIXU=;
        b=FhxKE8eZFLET07LZhcst3HNO97/fmzHEUd5nz5VuL2gZzIf1nfcx4opIhJ5xP2mmMP
         ek0gMgvY7OlgBuCfC7MGZLd547uqYf33Ci7tk+fvE6MARKnMJszQBiOTkMeZReg8Gt25
         NuWfLFo8U2ngk989QJ/X5xYkuuK5xn/ZNtEH1ck1gDwBg6AI+JfD+dlB2gnirVoyZ4om
         dn7rorSp/UHSyR6/W1iL2xKA8amWfHm+mAqLP0JS0NOi34ouPNOMe0MbpDZr+z3aE8b2
         yjxQ49WO7xLwpKDQEMQBxgtn/vnwD+9xDD6L3Aajw5RjFEO+xOH82gxnlG1i4+ztW63T
         OhaA==
X-Gm-Message-State: AJIora/+G4qtBrjHW3htlocZjQ4MrjO2nrhtkRCbF5H9rhVmhE2rGC2m
        JvhRzZxzGq6kzA5i7KmqvP6rpggtdk3Rbl3c6kc=
X-Google-Smtp-Source: AGRyM1u+T6tEG0sJ2rFDEdBNnmVeP6+Lj7IQkLbLJeTiQDdL7Eq+spPyQqqfUEhX6RdsANmLVstf4JcXH1d1POmeO8k=
X-Received: by 2002:a67:d381:0:b0:358:5b78:82e1 with SMTP id
 b1-20020a67d381000000b003585b7882e1mr1869266vsj.33.1659114241897; Fri, 29 Jul
 2022 10:04:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2e92:0:0:0:0:0 with HTTP; Fri, 29 Jul 2022 10:04:01
 -0700 (PDT)
From:   princss mecry <princssm12@gmail.com>
Date:   Fri, 29 Jul 2022 10:04:01 -0700
Message-ID: <CABQ_W2fEYuRxaf9hrC95kXApTvLJ+2Y=OY11O1SCNDi2YfU6bA@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please i need your kind Assistance. I will be very glad if you can assist
me to receive this sum of ( $8.5 Million US dollars.) into your bank
account, my name is  princess mercy i am 21years,i need who will help
me save  this fund,
i lost my father and only brother,
Please contact me through my private email:(princessmercy68@yahoo.com),
 for more information
