Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3F5546EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350096AbiFVJ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiFVJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:27:30 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5B937034
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:27:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 68so10157160pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=dfkbm31L3zKee0XVbWLBYvO0rOgBHmKKNVCBeYg5Cvk=;
        b=qcJuWk8Z9NSIeXr1gRlWpKfpYPNXI0lk2kQwXid3eCqYv3FgYcdA5gDmp9oT73nR+b
         jcKZu6LLuRl4DlQ0n1vukhrHarRkD6q6MqdgKpLuq4S66ONKfccgdvm44LEeUB96YiU+
         jQyyGHFk8AMiKhB5RaT4J4jkT8hRxnAdIcZ94ZTN37deUbtQrL1RQ3SXxg0FkcDqkXst
         mOWrd6D0+TiOnnxAKD8uPUq7x5V7A2aJ58g1v8UEwt1ARN2p0yH72MtUxLd8lRzgWfhK
         1i4PIo7iQwpcbd+SvoRmO8eWjq6D3Hit5+zQMHX0MYD1gYM2mssMYYB4+DxBAexf6hvp
         0OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=dfkbm31L3zKee0XVbWLBYvO0rOgBHmKKNVCBeYg5Cvk=;
        b=UnxSlXdPUuW7fmk9y98HVo1F4z5gUVhOP5Gzz0/jrSQ20tZm3KhMZ+H5IsTo/4khqF
         mf/BADAJjU/3POW25tbCTz1Ynm/D1GmIpKrZr/nGpuTkXTcJHNVSOL7FL+4ZvdENUgBv
         IU/PW/n7BmMHzR41FHQq32lxPJXCgj/cTbR0ps5DzAADVSYf8qhHwepBT/aHB6Jd5kmm
         uOy7CVdsTSzaf/a1DIZ9wQ+Q2f+k9hJkh50T39TCCE+954HaK5Hs3y+7rtvdFFow/Mii
         D3NJ+fF80dNddBu4kW8fwBHSx3E5jlJ5dnsSkwJQxTLU37pCPbP1foH9bog4iGWGiULB
         Dl/A==
X-Gm-Message-State: AJIora9bj6a1uAkkXXqVnz8XMwJdXOcl6Uh77wZSzCMf7qFE/HlS34aJ
        9Cp62QzG0wjWv11pAmQXzWgKp23gdPhHasYBso4=
X-Google-Smtp-Source: AGRyM1u7qtA2F62q3z4L8rdHx+c4A4n7CKOABpUeVX4nvuDL/5r/MPaZ8acFsc5wpoH28/GuLavNHF9hTCgLCY9MqYA=
X-Received: by 2002:a63:5248:0:b0:402:de14:ab74 with SMTP id
 s8-20020a635248000000b00402de14ab74mr2227251pgl.18.1655890048603; Wed, 22 Jun
 2022 02:27:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:bc88:b0:163:e975:9efb with HTTP; Wed, 22 Jun 2022
 02:27:28 -0700 (PDT)
Reply-To: susanbikram65@gmail.com
From:   Susan Bikram <essehsedo002@gmail.com>
Date:   Wed, 22 Jun 2022 09:27:28 +0000
Message-ID: <CAB7Jepfd1p6LRCsr9G2P5esG8K64XnmN5sbEMS+Se03=XKnmOw@mail.gmail.com>
Subject: please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,

  Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be mostgrateful
if you could help me deal with it please.

Susan
