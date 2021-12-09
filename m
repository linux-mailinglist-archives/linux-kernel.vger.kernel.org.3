Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7F646F2A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243135AbhLISBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbhLISBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:01:40 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F039C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:58:06 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a37so9106309ljq.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Y+Zfz/dSJapqOhSDPMgeunKCVcoDmNJS6APZUcqwzyI=;
        b=OJtEdJcbJ3sGUH/+8gw7A7pcun6HvWkLERAb+eyiC55weN0tn9lQOIdfWVFFkAXSiK
         N9xXzQaJOyu0112VE5tNJdzUyDJ2iVpOmuJAW0t1hgbfU+4XWjNXMN/TrFbdVfUwwmrz
         OW7sqjTMSz0rrMSy7N7I8+2mGW0DwN/BXrhi9J4zUuB4qlU2qzyauhKZmEOEyoC8m/2t
         AbSNygbrLUbiq5hAmyXW27vI7KivKGLpocVBm4KILd9SB6be7ertJq9uEYkHhblWV0Bd
         NkQkPdMNJgh/u356XL9dBcj3I9EfNH9xDPq2uAYwCg1Sk3AVYsIeU+626k5EMsOJRLQ6
         QSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Y+Zfz/dSJapqOhSDPMgeunKCVcoDmNJS6APZUcqwzyI=;
        b=l9RzcSSMv1Cj/0e2b3/EB1w6HSe1ddFx6EmCT45rfjsfdbnZMqhlH6vIFJWCKqOK60
         lvHAcNt70eNjxqebAabgVpMeCqNEGVyrCijtw7MQQdxO2H6pA8LxWInZ68ruwjmj6hzX
         t+f8Ru3rrgomNI/t6PcvaGM44/9lugE7aXMKqTINDow5EZD4Ap8NIn1cV958hWCuJt3I
         iCdgwv5qMzotX7Zd1DFcmC+dfDSYHNQUnzn8bNjLh23NNKMe6oWUeBYO52JN/5ldcs2y
         toscnfsK5h/RcvUGVpDMcFlLfSF8u8F62em6JKkm1Jij8/6M1MtAdlcvO81+WuKiHXMo
         /diA==
X-Gm-Message-State: AOAM530Y/pApE79L/Q+FZHlrk9G0IfuLUEhLHvAgSbNGm9mZKpJKG+fe
        Kgy/7znMLJMRZsVksrisxqxdFAf4o0ptB8x7ZDo1wOhBMgf7NA==
X-Google-Smtp-Source: ABdhPJxZy82sK1a2YAm87oUyqtZKb59uSCGu9Kfcs21w4uWiZirs8hsMSRmwAAQzOHg36J48LHZrrpT9JbZsyNkc11M=
X-Received: by 2002:a05:651c:154a:: with SMTP id y10mr7661402ljp.314.1639072684447;
 Thu, 09 Dec 2021 09:58:04 -0800 (PST)
MIME-Version: 1.0
Sender: missionnelsonloretta@gmail.com
Received: by 2002:a2e:8e74:0:0:0:0:0 with HTTP; Thu, 9 Dec 2021 09:58:04 -0800 (PST)
From:   Yoon Kim <privatekyoom@gmail.com>
Date:   Fri, 10 Dec 2021 05:58:04 +1200
X-Google-Sender-Auth: mCfyrMmPSLPcm5dZZQI6CuWIlbY
Message-ID: <CADaCDksMRDxmHf=sWRhR46OVkWPXp9EeDToTThYHxEHeNmi1-Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conferma la ricezione di questa email!  ( You speak English? )
