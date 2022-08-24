Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E889A59FD86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbiHXOrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiHXOq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:46:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62D97CB7E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:46:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id g8so11969959plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=C+NeCHssE1/lqQqRReLcbuAg25+o7NPeoZ0z7Y3QDZTni3Ryrbw5kNNXpHZy2DZuFG
         a6mjIGaZaVND9Y9z0sSEyOvQKp7PiMsqOWYJkV+8WziN8kXbykIg+Yppbc96Jqi0RO8h
         zwBiQynAx6ygoaY1uVa9X4ZwXuoxwimfIuUPyS/JI/zw03V0NfGxr5t7CTlE7DudwCbU
         AhX6aF+gmrwGa/ybrykH3928Q0jzpjmHbIdXPdShGxU1NbYWi4Jvdvl9nqCV19mCZ4x8
         baDFkS/J8qvt5oj5HT2c3wFdkhMX8aLdJPAMr4qOzgJRhqnKY9v4vbb9ungw5QGFSequ
         a5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=bY7zbu2CtljCePRR7Lfogld9AyuYnFolOps5YQJ13qWR677FiQsDdoKh4KsS+uvm6b
         Ly3+0eWibtKLxmBFuzNBNL+9Mdnm6kGYm8NzB/7ZbMhgXlIA2Eo+yAQYCvIWF4RyfpbI
         KIGJFSIaIaYYFvXWEjjbnezFSQD7QSqGhf/1bm5ErqgsLNuoyssArMA6v3v9i94+8SBc
         T+7NUUfYXYHqIyN8TIQODHncULo9BzC+DOiIvmUqwsAxteX4ObFUZ8eeHv9dFhqxh1Mp
         tX2L5/iKgu8fevBWfPdxg4h6EG59Uo0RbxyMyy4HuZNlL/anD58klWq3nL9KklAFu4Ij
         cHWg==
X-Gm-Message-State: ACgBeo2SoDNe3EhNCz1ofA78ZaFDzqStm6ELUFIyv7kHVGrxAyq3GAyu
        yX+oomah9kxcE7hvF9y5Wdlhd4FahubsQv1XVi4=
X-Google-Smtp-Source: AA6agR5+wKWrbUOwntZ53vTW/uKA4lIAiRjfvdPRRGKxMIQlZmX4AYGD8WtFJ3ZMtOriobgkTHzp7zxvm436j03CRuM=
X-Received: by 2002:a17:902:710e:b0:170:8d34:9447 with SMTP id
 a14-20020a170902710e00b001708d349447mr28920752pll.126.1661352416311; Wed, 24
 Aug 2022 07:46:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:321c:b0:8f:3072:37e6 with HTTP; Wed, 24 Aug 2022
 07:46:55 -0700 (PDT)
From:   Ulrica mica <ulricamica64@gmail.com>
Date:   Wed, 24 Aug 2022 07:46:55 -0700
Message-ID: <CAL+hFN3ph4T+N3dDa==WG7GnG8yoNW-BrfGM4eBKN51+fuWMAQ@mail.gmail.com>
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
