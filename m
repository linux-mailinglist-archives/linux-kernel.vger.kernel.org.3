Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFF59ABF5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245534AbiHTHPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343768AbiHTHP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:15:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119A4C6978
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 00:15:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bq11so840442wrb.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=MUPE+WCKiaoxRAdnteR3TsIHrvUD8FAr/F1eBQt4pX0=;
        b=KdCJNWL2dR3N/ki0djnH1LZ3DEUE9n7v97f8kUj+j8kkKCp0bSS+9oKbmEHJxoM9Vp
         QGw8rff2sdBxCz5RPsiif7+pTWd+ZiDH+l4SrNLaYb4zNo4XE6yejvcpjq+UsBlILEt2
         rb8gxJMC0yP4bLfUNquuvA3LP7d/jNXAeXCnITM/pOMW/IlV09hz5xS/F4v94iF7nLKn
         FN5+ufOPUAe2CKvQieqUeUsgVlvjf9NwJJ30avMQsq9ipIusKcqLWZ0ixeoH/0wxhxC+
         PyKm4E767FcuRVp7Z3Vl05o1xbaaAD1Q0CTASgsC/tM3RR1WBi5/u72jJpHx2AyqBZDg
         73lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=MUPE+WCKiaoxRAdnteR3TsIHrvUD8FAr/F1eBQt4pX0=;
        b=LMhRzwxktWDHviF1rygFLuGUY9bdMIQOuswsjeBFM8AkptiL+UJgtdekdWOVUuZdTC
         LLBs5AhJs3KOF791km3aZg9v+GFd2NrGf4hwto9mEcqNYfguDou7FhnNUem0+YB0W2fJ
         /HQlBw7hGyRDl0WTQGjF6t6Y51y+uupuTFxPSpUG/yNqEPCBc8zzz+cnIxZTuPC5ssAl
         SxF4+ruDDYidqWomQeU9stf2ORHrZN3+oZMruQeRJqJwsQdGOc2GQhdILpFeI1wjob4X
         CtxGl6xwFuHpXYNi5KGX1sFFFa0Sw11NXDMl8f5TnETXNJ4xTnpoGEnbMXJO7Rw47kId
         7GWw==
X-Gm-Message-State: ACgBeo1kI4fBEqTkK0j/8KzjLI6Ps5gjZQ1Ycrv5wKn6FaJ9HUNxd4oQ
        ltMP3aVZhvAAoRGLXWPL3gHwu/d2D4sK1uo+tA0=
X-Google-Smtp-Source: AA6agR66pRfE0qrWirj4m0fL4TX9iCkT1Fan7BxZqnxjZBoBCp4zilySUj4Hgdtnk4ngzfFJdoROSc7I4TBQ/MGXkEE=
X-Received: by 2002:adf:ec4c:0:b0:225:2f42:39df with SMTP id
 w12-20020adfec4c000000b002252f4239dfmr5894756wrn.135.1660979725423; Sat, 20
 Aug 2022 00:15:25 -0700 (PDT)
MIME-Version: 1.0
Reply-To: jerrydosso1@hotmail.com
Sender: udoeze160@gmail.com
Received: by 2002:a5d:5887:0:0:0:0:0 with HTTP; Sat, 20 Aug 2022 00:15:24
 -0700 (PDT)
From:   Jerry Dosso <jerrydosso55@gmail.com>
Date:   Sat, 20 Aug 2022 09:15:24 +0200
X-Google-Sender-Auth: QWSCMBbUKtezJzLKwWqfEjQuCYo
Message-ID: <CAG0PvUCQwKDJCdM=Y4-fUUaDV1x0UkRB2pvcwFWMZ88BPaisKA@mail.gmail.com>
Subject: Mr Jerry Dosso
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:432 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [udoeze160[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jerrydosso55[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jerrydosso1[at]hotmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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
My Dear Friend,

Did you receive the message i sent to you?

Regards,

Mr Jerry Dosso
