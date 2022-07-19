Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36957A9C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbiGSWWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiGSWWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:22:09 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A575D0E2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:22:08 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id bb16so8757876oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NHTqwoqQTjf+Ui5L12KEuoKx6Gb/D3zeFWHGlRbjT3A=;
        b=aozmhslMRV9nCw2CyRvJPFV0iNRukB16EYpTuc21e1O1MUw3YJ1HaQApNpeKpB0NTL
         mFQuD90/kaxgQ0SUThbtHX3+J8XapXTQn6BUERJ/qbMki/wum3xoGeWxEXTRceKfLuIl
         9SkO6plqRmHKgeuESeyUh6xUyeDDq36oKrn28UDhUzxu0mJi73r8TKB3px2wqeJaAZNz
         BN4WepT868n9UueFd3laR18YnkAktPkc+njrrWbTRwnAp4Fx1w3e1N/JywTJdAo7t681
         vGmmxY4N6tPRIWcqW0mtKmTie4h8pBio0ZryhvjTNk3cBHbRCSaBTLh02rp9Sr6vRvOA
         StIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=NHTqwoqQTjf+Ui5L12KEuoKx6Gb/D3zeFWHGlRbjT3A=;
        b=E0WHWZBZ29p1arb6dQzHqhOuzRBArPh6SWN9fubu2DJV5GI3SzRamTkLL/srpU0sjk
         05EzbzCe2R0vjLbaLavHv6Qk0L7rukp1yJIODsm9cxDETZ7k/C/xguh1kcXb72Txf2KK
         XFCXoce9Yvwk8Uah9ZxHlodJBUwSqcarQSDcdYZVN5qqJZXQ41QUZmm9xBFtT12x42C7
         MZw30QqIY8GKwrUQiBx2SDOk7Jsy2h+prfTRbQbuyHS11D/F8Qy91v8YKb/JhmX1X3jd
         2mODe5RthVh7E9KkbikIPMNkEUlaWhZxvIdS+wlC1W6KlHWPu7Z2KOoGLO72gugA3jFc
         +zdA==
X-Gm-Message-State: AJIora86JpbRHWcOJl+TwstkNAs7l5xh3Bwd+yTJoLUTIVRjqUoJ5MFb
        C05Xi4lkfTgOo/6nCaO5qk7ncdTiKOZ+JyZgfME=
X-Google-Smtp-Source: AGRyM1sgdzNbsroKx1WWC8b6LBVx4+UcNSSUF03KwYd8hmFa0gUMvqLhY2Obh0pus71WbjTdJCqK0j9EV3RefU5FjuM=
X-Received: by 2002:a05:6808:1b29:b0:33a:7bea:7b1c with SMTP id
 bx41-20020a0568081b2900b0033a7bea7b1cmr819402oib.275.1658269328092; Tue, 19
 Jul 2022 15:22:08 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: isabelleakpalo3@gmail.com
Received: by 2002:a05:6838:78b0:0:0:0:0 with HTTP; Tue, 19 Jul 2022 15:22:07
 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Tue, 19 Jul 2022 22:22:07 +0000
X-Google-Sender-Auth: WCTkVm6-drixE7G8hDrCnX7aISM
Message-ID: <CAFKeeizfA=FdHbGrtc5bL18+Sa1ngrxx2VcpC5zhAJX9=Ffxqg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5L2g5aW977yM5pS25Yiw5oiR5LmL5YmN55qE5Lik5p2h5raI5oGv5LqG5ZCX77yfDQo=
