Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37CE4E67D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352215AbiCXRbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346687AbiCXRbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:31:32 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C1355759
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:30:00 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2e592e700acso58575317b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=H2YfWCG0balrUsjNebe6NPqLv9wl/pqUnfwIaMT7BYE=;
        b=chB+YvAKbmTF73mvwxl/MX9OAvRte6lKEtp6t2RaYQ0qnvcjJR3xDMmy86SL3huiSP
         hc9OpMmo5JJ6wwQt4FqRJpFtWkX5wYjeFcpITQpNK8ksyWfcCG7Y7lTLX7YdWkyOolgX
         cOCeakK6Zx6LePYvZ+H3Ys7JjzelDDTr9+mVO/TvVdxylu4/1tW3Zkz1gl4IHF8f1sfI
         fAhdS8QOtwoGXawkI1nBdCQ2MQ/eCNTd6ODeoSY8Zf0pzX7dFiMk7vpDFkoKeQFzO0wH
         kxPHUfDta7phuogWU6o31n4DpRwcdRpocX8yUPSp8YRYiWMhEwphommPdKw6TrtabpbY
         rdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=H2YfWCG0balrUsjNebe6NPqLv9wl/pqUnfwIaMT7BYE=;
        b=8MIfCgUiN13vVu91ZIPdRgXdAvcaH0cm+XC7kPFl/14sig2UXg5wrls2jP8fHg8Tv/
         z8AYZZVYdsp2qEm/jUAXThKaXSHrvokhjrrDoBOcNiOUWFmFr2hBwSNBd3ZEPQh328pB
         +f4Iu964M8MT3H6QX4/lx0wY8/JczZioF6Fu+8y6K6A3tlUlyZLC+uMelgQ0fegr/63E
         vE0VpQ1qMrzKXIwHQYE9RxwtpkRObAtVe/aKOFkULSfaSLFpzxcixUfgXWI6PuOIo98Z
         MVJ4aZQhCkFQSqOeUljGeb/+q3RrwNKNkJLWeRdAYCQtNCFltIo2/OjDGBibGl6qJdp2
         bREA==
X-Gm-Message-State: AOAM5328rDR0mNU03BB1LPdiFkzVjNyYXfJYrBc6M8dYK3OJN5gJmyGk
        w2lbWFEs986pxTKgS4Ks4qFKBhjAFuvuBrhN3KU=
X-Google-Smtp-Source: ABdhPJwYAOAOA61L6XLkuYZYb2QKCJnbZQsI4t9XMrGloapmOZ6cbSsmNS5iixRWnCttD7u9fanZjDd5s7D0ULREUkg=
X-Received: by 2002:a05:690c:9:b0:2dd:1de0:7b13 with SMTP id
 bc9-20020a05690c000900b002dd1de07b13mr6489541ywb.450.1648142998548; Thu, 24
 Mar 2022 10:29:58 -0700 (PDT)
MIME-Version: 1.0
Sender: mohammedibrahim7571@gmail.com
Received: by 2002:a05:7000:aa0d:0:0:0:0 with HTTP; Thu, 24 Mar 2022 10:29:58
 -0700 (PDT)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Thu, 24 Mar 2022 17:29:58 +0000
X-Google-Sender-Auth: wTmw6IaxZ6JwYDjrXV1u-mIFUqM
Message-ID: <CAKSk573stpac9ndu6JmMt34tsOTd=tas4pz9mrHHY8e4fMKe2w@mail.gmail.com>
Subject: My name is Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi Dear,

My name is Lisa  Williams, I am from the United States of America, Its
my pleasure to contact you for new and special friendship, I will be
glad to see your reply for us to know each other better.

Yours
Lisa
