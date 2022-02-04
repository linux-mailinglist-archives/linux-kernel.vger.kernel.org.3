Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B971B4A9199
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356217AbiBDA1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353694AbiBDA1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:27:10 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0839C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:27:09 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z199so5445295iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 16:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZHLlp8umDVFs9Tye8ZudPORlyWBAZ0TceN0aLVUR5o0=;
        b=Ro0400dsEnmE9sFvCXr04FI1Suxxe+GviQVvHHvua9HenOqS29iCeTQK2BO/GvkJV0
         NYK0hioNaHxQozDh+vrUiMQnovxtyh8zG8zfNWOSNa2cmO1wF+2aGkFC7OBLlAZuFS7d
         QzLTY101Owp2M+rUMLjHgr3B7GQP1HdZD/b4DuawIiJaUZhmJhlPfFC3zcVo/rtaEr7J
         Kup/QqUiv7C0/FFyzYkBpMiRD8M4yRWm4jkA18aago6Veq3AYkzqsAUX8RzrWm8IB5Uq
         J5rxKu7NwIgAhVivDJm/xM8NuSWJzjXsHsx929HIZus7bzHpyYJ+515C+KRvvQh198S9
         ZVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZHLlp8umDVFs9Tye8ZudPORlyWBAZ0TceN0aLVUR5o0=;
        b=wXjv50AWvKILKhczm6jOXZy+I6D0ATltDyzsIvuIlO70QfZtBDzzdRSTwqx05WOdP+
         HWMWhzt3+X4LbiPlDZZ5V0MXlWPfi+sYV+TB4UXPKLYIaOO6o2ff0V85jW189hyH3ubE
         kUfUMNXcukoWILCsR/As/yk1dx60+aRyDASd9Aemq1BLVE0ROo8OsAcVhj/Bn428D/x/
         1tPPXgczuQvhEmuM1o5ojl+jA6R2p3DYFJpwq4bNDhhFIS0rOfkK1VFFZF+V7wSpymZI
         jhrmJzuxqBTTw4Goj0MqhQ6E95784OiqMYxl3/Bzagw4qMDivhXcxw1iPMjw0sGCT9ZG
         3oxA==
X-Gm-Message-State: AOAM531F1jyzhkTVv/W6i5EJuXBYnYr1f01bzvQuk8TAjQQtCSxvCgZT
        bZuy6iYFu7bJNMCfMWAcGUPuRbHE/71wxWUfXckb5XyyYYKnsP4oZ/E=
X-Google-Smtp-Source: ABdhPJzkeVpmnHh01+sMw4I7bRAwMdEmLxLXizA1qhnR5P1LQJu7e/QGIVCLOswhuk9zyyLWgWLSCVRdlnOv6PYHo4A=
X-Received: by 2002:a05:6638:371e:: with SMTP id k30mr227509jav.64.1643934429378;
 Thu, 03 Feb 2022 16:27:09 -0800 (PST)
MIME-Version: 1.0
From:   Slade Watkins <slade@sladewatkins.com>
Date:   Thu, 3 Feb 2022 19:26:58 -0500
Message-ID: <CA+pv=HNuxZXTxu2S5vcz=zF81wWxykQe2im6oKgKiaDPujVjiw@mail.gmail.com>
Subject: rtw89 driver
To:     Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Larry Finger <larry.finger@lwfinger.net>,
        Slade Watkins <slade@sladewatkins.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
Quick question for wireless folks: would backporting the rtw89
driver[1] (Realtek 8852AE) to kernels older than 5.16.y be possible at
some point down the road? I ask this as, when testing a stable build
of 5.15.y a bit ago, I had an issue where the driver wasn't present
and the system I was testing it on wasn't happy and started kicking
errors. (It's fairly new, so I did kind of expect that.) I was,
however, able to solve this by manually building and installing the
drivers so it wasn't that big of a deal.

[1] https://github.com/lwfinger/rtw89

Thanks,
Slade
