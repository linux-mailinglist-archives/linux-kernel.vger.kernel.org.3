Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738F353E966
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbiFFOQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239607AbiFFOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:16:12 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B912CDED
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:16:11 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p130so7972569iod.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=AxxqEHs4lysBpxL8/oesB4vW3/a+Zr057P6NazPrbgQP5HsmJgEs8GvtVFN9zQjLsZ
         lJUfJIJUug9ekGnWe3iwTySEHVrmddBtyZFMXlEAuVQJsB+QKsOq1f+LA7HbArv/cvyO
         WrE8sEmpunUpvnMSGQLxjqkO0KA7cgVXyDd5lbtB1uK5kNBYE6vslSAGGMH2PDcPVA/w
         XNRqiZ6KLeDrv667Fnw22BARQuIRe2Vgb45ZDwoe6/Cowanj7pqeum+bRiqFvYf1Ka9+
         uk7CKz8N9PDoPbjgMpMvJzZqE9TVkv0oZsOMwKy7KCgPx8GaqmFAszpUZEBIVRd7Imjt
         jGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=ofN2zjizcs2ei+iEA+wB97ybK32U1Q6WsGL5PV9iGi7F7Ug7v2sa3ccWB0N93h0nOl
         XIhEf89SuDoZsyXUzl2e5RCkWJKb3G5vJgKjmFIpXyj2BmjpIqxmBsrsyogn/vEEgQg8
         jqmP/3aWDfQ3NGGpuBCUtw4HsguZZg4v3MoIeFOtkccetbQNW8h0yU9wdNdL94+nQ3SD
         lKnx9mNxXibF11tbOlvyKseSpa4EScwdaHTEdCPLNiZFkzPj5+NBgZsknwA3laDkaXX1
         h6sFSmO22kEz72EkQE/7XeBXRzbyhZXo8+URal1XjXsixbURgo/YAcYLtZEuU7xjqJCc
         +2LQ==
X-Gm-Message-State: AOAM533sASdOpZMKKpzhxHtW2vrokqINNwmqQtXv+vADeiTXiVs2Q0qk
        ATvSwnaO7XCdO51wAnLWKfUEFSeitM8zgKzQocA=
X-Google-Smtp-Source: ABdhPJyBnj2t6bHhIPWxvY1ZdzgtR9h6Ju8aNdCwgnD3w4MhMv8YRHnrQx/FJp4Pj9K/Fh1wmNr3fWZmWUfy+c+cHqE=
X-Received: by 2002:a5d:94c2:0:b0:60b:bd34:bb6f with SMTP id
 y2-20020a5d94c2000000b0060bbd34bb6fmr11177294ior.32.1654524970602; Mon, 06
 Jun 2022 07:16:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:c41b:0:0:0:0:0 with HTTP; Mon, 6 Jun 2022 07:16:10 -0700 (PDT)
From:   Ulrica Mica <ulricamica323@gmail.com>
Date:   Mon, 6 Jun 2022 07:16:10 -0700
Message-ID: <CAOL=-jZJ79M7GPNF7H1s0ECxNvaZduOSuS-iksPrfaPoyh_=Yw@mail.gmail.com>
Subject: good morning
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
Hello dear
Can i talk to you please?
Ulrica
