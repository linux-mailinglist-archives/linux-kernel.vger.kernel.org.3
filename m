Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CEE47212F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhLMGoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhLMGoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:44:14 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F7FC06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 22:44:14 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x131so14025234pfc.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 22:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=B3GY5pHxl40fgyTRDEfHUIewqx+99afdPdvQA2cgGa0=;
        b=HV1fwtvSc5NgT0fVab6eaFlTGDGdER5gSzWEIzh/LUrn+P7j5QnhBsAm3fvi7kCm4s
         Ez3PRkKCcTtDyII3WxkhgFgmUD6NHIrr+OjFLVV7t378bQ+vrKHFpBTscxseAJQClXfX
         ak3n+sLpDfCAN/KH2r2Ii6Vw+Te4BbxQwrfza+nGLDmcUI0gEQyFKA4yHEbIdyxiqoHK
         +n9vDWDRD6DTLo5E0QzTfkN4fztD1WNhq2VsWis87PFKnTf8GYewzmVdXCKruqhJy9rZ
         iWpGJgRo9KTqvYVw+Lv5aClszUBGLXdmWU6NqkzDtu2NbM/I3XKVwSgTrkzRBs0BT2EN
         LmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=B3GY5pHxl40fgyTRDEfHUIewqx+99afdPdvQA2cgGa0=;
        b=afbhCT5X7YsznBIEowP7n9T/Jmqqje0NyDt7VUc4Ruc6HEO8m0mWfMkt6D9xfryqWt
         TjR5CJwqZ1qfcPVVncnrnfhr3E3TVr0u6TCHIwQttzUYP0zYr1JOhrJ+mEk32xefkrvE
         UAMZVcI2lf5DTkr55iYeEw33wJQhekkk4W6AylW3dCPMNwjvArTdq9bFBepgl74tf93Z
         3wJXdmYIuzvwEVnYfNZIyZxAGLsbno3A7D4vZR9VNeUbCs60vidnoHf4wPXk+PP/zeko
         oGRqBVhxBTWuSE8BkTcFxAA47sogERx4Er8T3DqP4K6LWJRCKS9hAOrZLeMj0qCGTGz4
         g9hw==
X-Gm-Message-State: AOAM531ORtfHd9wvinTTn5LWBP3niCm2F0Rzu63n9sBdSmMQrG1Xw0T/
        w3Wm1EprRRqy199aOnhEKx++ypWwTpblJLtJbco=
X-Google-Smtp-Source: ABdhPJxXig8nzXkyZqX0NJXTzek0j0BQMnOC2Y9YM2uKPN9n9em7rIUfo+N8RqG8z2dEMPwQ3XJsW8rOaoBES1S09ks=
X-Received: by 2002:a05:6a00:888:b0:4a8:56c:d2c with SMTP id
 q8-20020a056a00088800b004a8056c0d2cmr31837093pfj.40.1639377853889; Sun, 12
 Dec 2021 22:44:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a20:4422:b0:5d:8fef:43a3 with HTTP; Sun, 12 Dec 2021
 22:44:13 -0800 (PST)
Reply-To: sgtkaylam28@gmail.com
From:   ken manthey <manken827@gmail.com>
Date:   Sun, 12 Dec 2021 22:44:13 -0800
Message-ID: <CAHbNM4EQKv=Zr=b0tNMYptkL-DVBoP42pEn2VxDdd8jfFpZnUQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
Please did you receive my previous message? Write me back
