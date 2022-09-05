Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008A45AD492
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiIEOP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiIEOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:15:47 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDA427B37
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:15:44 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-345528ceb87so14246407b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=f8+wkscY0Mz9WNFd9ZPJmFW4bAcsP+7zRqQ/fyjtbFrj9O0NHuDG+8Xo6YRqoedIqv
         0vVnvFx3DmOSvCT3n0b8La5scXT4lG7JrkuAs1euKuVYBLFvUCqCUSzAN8MGSSh7zLiz
         7xeuVLzzWymd9vX9L1QInNsEMkrEEMB/9cWWibMrThxBeKZuELSK9iBPbWDv9LzNRBYY
         OaeqPflnVnpf4WCnIO0UEG/5u/legpk7bx8Fc3J43t7xdFwpdWGo/cCSJlPBYBxSnEN0
         oH8ge2+J20ELaYe1YwJngTfgXIEidu3s17Tbaa1EoYTCIJyXSIfXWnJlqqu4MroXKtnF
         U7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=4xp+LGfpjQZ08IqL7/blzW03GuJQk+2P32nh0BzZtR0hV40EwNSN/lV6hPAbQtSdbh
         uZrxKB7xioaGIR4C0HSjragsehpPAgux8OFhhB+aYhqUZ19hsdtlk4oiULAt5d/guoo8
         J82y3POkVfDH7gSgV1fzUqPCD4ts3W6BoqyDGdyD6TKDjYmUoTEDiyXaJLMb96bIAu17
         OihE0xxKwV0hfoPM8fRYucH2MaD+BboVgDaQK9IRGk+Ure/fmTncNDdQZmMV2vRRRFwo
         69QcTPM9MZk+OxCQXq6xSa8SWliwk8EIZTFrpb1x7ieMHbEjt9dmNSZ5IEZxtoadBOtS
         pY6Q==
X-Gm-Message-State: ACgBeo2VDnqK5SGnkrAp17u20RJ58yG7i3OiBpPIizPMlMD3JoybKVyx
        kvIg1JgjiQ2tcy5a8cuXhpzO1gdAIdEwF0OoXTowEvGfmag=
X-Google-Smtp-Source: AA6agR5QY2I/2to+GpJC+yxgLLCYsS7mbQv3EEJ5EwtnDQqpnV8MVQYgqVfc44Ne/IApaAhXzmOnzgcdrMEAbTm9/Us=
X-Received: by 2002:a81:c0a:0:b0:341:44bb:d640 with SMTP id
 10-20020a810c0a000000b0034144bbd640mr31149360ywm.372.1662387343771; Mon, 05
 Sep 2022 07:15:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:fb0c:0:0:0:0:0 with HTTP; Mon, 5 Sep 2022 07:15:43 -0700 (PDT)
Reply-To: maryalbert00045@gmail.com
From:   Mary Albert <ourogounimouhamed@gmail.com>
Date:   Mon, 5 Sep 2022 15:15:43 +0100
Message-ID: <CAHwLVq6UdCwjD8Xojx1wAOMKrrCBPyof5CtyU5KhzUOA-Ma65g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1141 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6852]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbert00045[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ourogounimouhamed[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
