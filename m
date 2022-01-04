Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE853483BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiADGW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiADGWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:22:21 -0500
Received: from mail-oo1-xc67.google.com (mail-oo1-xc67.google.com [IPv6:2607:f8b0:4864:20::c67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C807EC061792
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 22:22:20 -0800 (PST)
Received: by mail-oo1-xc67.google.com with SMTP id v7-20020a4a2447000000b002daf9b0cb1eso9657945oov.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 22:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tesca-id.20210112.gappssmtp.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=dZ9ZcTJ5j73nz7d+81ixbBYmVxHiHSM/dTKoNtPdL+4=;
        b=BMtN95J+x0H57dEpI+awS7sAGVOwnNyGk+A3D2Fv152tmwD5YSMB9WuXAxdznWSZwR
         eNUB7tPxv07IDgFzlfCoB9D21rrByE/DIX4rkdcuka1JDLzDKgHZClhT8EoqgvFLUAiL
         lh/s4wGrzKeZnsl0JDo1tfA4rD5k8k72DUA1ummMTOR4yq/zfMH+334LKenY3JClHwip
         0k037hHfAsH9zVeSWqJcs2McuprcKnm/wwJZ1w9pwn5Yiq02qvA72yaALR/4cqzy0SLs
         2OyRXiWu8UsqVT750lB/FnuXGAYS8N6diqrhKtqwFQQ02skuOVaMnCAAGrA6zYgFOOfQ
         M8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=dZ9ZcTJ5j73nz7d+81ixbBYmVxHiHSM/dTKoNtPdL+4=;
        b=FOAyGKqpvgB8Xph2OjJoCUX+Ef+kxYIBJmbJuaGUn34fJxNm5pjX36z7+gLljKWtzT
         Rol6GdXFx7Qo5nxzwzXkaGIGNkeCletSbMZ0wgDIJyJFCPy/5pq3UM0rJxwZ+jXj+VJK
         mb26naRne4aNPSe/G83v8d64kNrDWcWPMCMhsgJay5P9zuenzcgY4t4XYeX/dh4tEbNa
         yvf3S2cYxgpEovpj6YbZW2ken2BkQV02OOXlNFgNqcHKN5EYCc+El/5sDQFmf5G4aPlB
         x2Y66TGONlW3LWb1idUt7Cp0fMwJrTYu/XDsdVUrh8sAqmoep2I2eogshwEyb9dO8tVy
         C6fA==
X-Gm-Message-State: AOAM531hJojYWnQeoVBKjukV8j+vgile51icbH1sAjsdznrjrOhG0HD/
        U/DtJfhxTlohlM9OViT82HrlafFpS1i+AzY/1wlMUpzw1x9Csg==
X-Google-Smtp-Source: ABdhPJx87FGmIz1n7n3Q08O1ZITUqV3Qyr4RlPxd7VRIt6NnuHjzmXmR4uyFfwunQHxDshy46ypjTf8NNrXB
X-Received: by 2002:a4a:9747:: with SMTP id v7mr30535562ooi.31.1641277340265;
        Mon, 03 Jan 2022 22:22:20 -0800 (PST)
Received: from [192.168.1.4] ([36.37.185.103])
        by smtp-relay.gmail.com with ESMTPS id h12sm9738420ooe.24.2022.01.03.22.22.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jan 2022 22:22:20 -0800 (PST)
X-Relaying-Domain: tesca.id
Message-ID: <61d3e79c.1c69fb81.99426.bd3cSMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Joint Investment Proposal
To:     Recipients <no-reply@tesca.id>
From:   "Mr. David Cheung" <no-reply@tesca.id>
Date:   Tue, 04 Jan 2022 13:22:08 +0700
Reply-To: davdcheung@aol.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm David Cheung, A senior staff with public Bank in Cambodia. I have a bus=
iness proposal that gain the benefit for both of us to share with you.

Kindly get back to me as soon as possible.

Many thanks,
David Cheung =A9
