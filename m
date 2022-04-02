Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13374F0045
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347958AbiDBKB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiDBKBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:01:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25A2165A3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:00:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o10so10583110ejd.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8aF9bw+PFvYITEhCdBeu0fNkCE7OJPb/Ug0o8DPKitU=;
        b=Lo0sEYk00UI3wB1E6emvHo1TY/DB5moTqNkGjsLn0lR8vyxU1G9wT5tP9Gcsob/PPf
         Nmbo/WNGn/ScrNot9gV/SSnta9wHSFEEExXkTdJveb4jy9czxT74ciywSEalX98k4CvU
         MVvYw5ZGmqPbFIRzeNX86Qb9GjT38bOy69MPw+wIWoinnl2J4HAIDzfpDrX9pdGHk4vp
         EC4bz/pjqMqhQx/hEr2yXAAj02gAAKexcS31lT3B9I4kqscWm+hCFjKdL6C79xN3wTT1
         2vSJTmo9wDariHeBbafitqgLLfw0gBG43/nIiZfQQ+PrwfYgf2vIDzqrMk5hqlHc0wsH
         oenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8aF9bw+PFvYITEhCdBeu0fNkCE7OJPb/Ug0o8DPKitU=;
        b=E44gMaMmFzGyvJXQdXzruDO3GyBaGj9xXxljtIOBuFtuaKsVEcwmxaoVsQwuM3kFZm
         MF3sGie+BLFi7AkiZCdCVUv9J5n0qxzEGOtWr2gpPkZ5h41USkaeLsXYE5+IQTsj9SH7
         JxL0zcM3PfyiKh+gKQad36f9BRwPiqZhteVir/zVvfUs+zCW4gWfVFt9qvUeGpSCmqbE
         C9wmqZrI/qWj45IwnQXPfHXwXStpSnOYdTDrUH5wYKq16WfzxxhSPcXFmeyCJfwQN0rf
         SrejSiBR/oSrQEzPF1U4yzGwbYO/rz0oWYjc2NLFWBwGuxtcgmMSi5I4tHakWvgko6TC
         14gg==
X-Gm-Message-State: AOAM531ZbGjua2O6Zw/huIHJ7yI02iyS/TwlftyOid0YEIahpAVidK4v
        V1oiDmxDbkyhAWZKbW7pCY3sKG+3zo1s5d+0o1Y=
X-Google-Smtp-Source: ABdhPJw9XJjVwNJvz3i0vUozdnLKqn8N2oQdaxHnZD5I8pZc7J0YodTfpAoWAnArit040nlvIEkjA5MO91tMtp4H/34=
X-Received: by 2002:a17:907:3e1a:b0:6e0:5ba8:8e0f with SMTP id
 hp26-20020a1709073e1a00b006e05ba88e0fmr3096601ejc.581.1648893600054; Sat, 02
 Apr 2022 03:00:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:26d2:0:0:0:0:0 with HTTP; Sat, 2 Apr 2022 02:59:59 -0700 (PDT)
From:   Amadeo Giannini <solutionloansinc327@gmail.com>
Date:   Sat, 2 Apr 2022 10:59:59 +0100
Message-ID: <CA+NgZ-E8NC-ZdytkhdgZw=A2iyvneT8MUMFoa7Xbm0Yt+vj3ug@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Needing a loan? How much & the time you can pay back?
