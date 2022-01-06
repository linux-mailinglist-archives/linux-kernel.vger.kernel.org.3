Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9CA48622B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiAFJgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiAFJfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:35:55 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56C6C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 01:35:54 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id b1so1656231ilj.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 01:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhsA1aKlglGjpRdMu2peVecDmERAuTyLLhI53Hw2hvM=;
        b=HmnD/eTJxWFq2MfGhRQi9TqjWtRvXIchlvLmA/5av1Q9UeS12PVSIpwebAYtXtQq4Y
         LEZLJCgSYoTfMR2ITdEEJQMeIi/hY/F5Wgp1eh4wyeqgYlwmFBW1toGsDPUI7zekAKcr
         RBe+DFrIeZapnbQokrwdiQYNKenpeLLWINPrrQUKlI3e+rVPSvWZugkQpesTkBgeyghr
         EKjeArMlDZPkboa3Pkm8kLN/XXS92Bm85VJTsR+gLBy+C+ptIFAsB4TOkM4W7d8eXbDn
         OLGqRSlkWVQKAadIZNWsrgU3r+8Vs0l3RWLGLrEUX+dq4AaU4U5wNTYFAY+Rb4o/CM01
         1G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhsA1aKlglGjpRdMu2peVecDmERAuTyLLhI53Hw2hvM=;
        b=Aw/ydiZ/RBlYkvFk/vug/QY73/TcOkPQRVidOAMjvx7Ig0EtTCVqsqeaog/Z9Ed6O/
         9JBYrbSgp3FmAdxcor+xiCwNNx1lvYDJiCVkeZsFH5fcpmwCWixoVU5GizXRo2XMow6+
         5w0d8ePQHRBiSRUCqYtkyMpKhqCUuLMT4i2V8ECHKWAONvfo47E/tYVK9WhRCbKqD8xJ
         TCucBQ2A9Xxhftn726UeTbIfG7l8HlrPsbk9wdiKwKXX/DY/CUfyCzhQi4iTIjgzdD/M
         +LaWyyntgwW90sD9RZ3YTdR8AJThVwzCCseDyHwDzen8OcT6mg0/J9IW5jXpoARttMbg
         w1xA==
X-Gm-Message-State: AOAM531somAtwGR8KNZxJ0Bn0n++0txlJcA1niZXap4po/xJLrbmwysu
        f+hbkxPD2udU1s/DppRqu4rONd127vjXTPC2I38t6all
X-Google-Smtp-Source: ABdhPJzosVQyw6opq0Es0hP19cS1jagqLMljmdRjhRi0j+1K1Fx2hdhkUXs0vUVDjLUA+jWtu6XEKAUAx2XezLw3Quw=
X-Received: by 2002:a05:6e02:2167:: with SMTP id s7mr27243781ilv.230.1641461753949;
 Thu, 06 Jan 2022 01:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20211223123140.3789-1-jiangshanlai@gmail.com>
In-Reply-To: <20211223123140.3789-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 6 Jan 2022 17:35:43 +0800
Message-ID: <CAJhGHyBexhbq9-706YnRKATiGv8SnpQabYaqTpW-EvzQ4T-eDA@mail.gmail.com>
Subject: Re: [PATCH 0/4] workqueue: cleanups for schedule callbacks part2
To:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping
