Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1977458E4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiHJCk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiHJCks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:40:48 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9239E79
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 19:40:47 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o184so6307472oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=DQnlcLeV/I2Mov1xVZc++U6BNkJlThTblKyckdlHE/o=;
        b=hqQ21qGwbZ4ZYHQGFNl1FEWZJ9IUYOpzv51kQprn7JiGKrd/QlGK26FyqDZBopMV9L
         TFKsws6BTBQlRZgtzIHyqDEP2er1OZ56KQSeqPXjUVmX1TTpKeFkW7vtRb6Q3eQDeIOG
         1Wx1V4Pa5z7cri6Wy4za22xZhnvwdTEHdsy/C4lxNrU5+1QcExqIHPdNxRpOzKs8bcZC
         4KWF+n4ibNYjdNp0H/XFtierlOFvTmg0XEscw+Qb6ddgMp8ZtvSMzPnE2LRheLc1oelD
         tznQZ/Sw12q3aJxaemZHklJAF37un8k+Y5fuYG+1LJxqxqPx+KUliH68grLtid/2nPJv
         zBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=DQnlcLeV/I2Mov1xVZc++U6BNkJlThTblKyckdlHE/o=;
        b=hkT9bZVt43jKlMV+A3pQYAn22Uzp6fCN93uzBHEQ/hJ9ZiT3W3FW/BG63U0TN6siBF
         5BGrTm6Zr3cWBgz0+MldprtbNoS414Out5CqSotFA2Vxip0W6mhuhvWNISshqFPaLbv7
         rw/7lDoMQzR13WIjpyggVWd/zICP50FekXBcGNDb14nu6MmwRc9KMz3noju4NshXVKWo
         E9KK2SoyqOvT6ErM0DW0UAE5r3Y8nf6ZAntnWi1Y+GmNEHHKVvaGAZ45b2BFUC4rC+DK
         gI1c4NqWFWZp47p5/WRM5+mAr4RyXe0UvVo4CBLY+GE7xJJIkuZz/Sr+6QRq5tpO0Rg6
         BBmA==
X-Gm-Message-State: ACgBeo0AlBcJ15aMrN5/EhEaKAX7Jgc5qgw+zA6WOibx4zeQ1U33BkYE
        yPlu6hkgKEYre0RQjd3FufemFcoXCptLoWjvRq4=
X-Google-Smtp-Source: AA6agR7JDtBlL76RGlbKwaQNHXLihx5rt05VlM60HgI2PtePw26s5lNNGoOMUuwUnlLC85nAvWAWdFyCDFs6l1yIueY=
X-Received: by 2002:a05:6808:1202:b0:322:dc37:2c3b with SMTP id
 a2-20020a056808120200b00322dc372c3bmr551717oil.298.1660099247093; Tue, 09 Aug
 2022 19:40:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:89a:b0:b2:d9a1:7057 with HTTP; Tue, 9 Aug 2022
 19:40:46 -0700 (PDT)
Reply-To: johannspoerk30@gmail.com
From:   johann spoerk <luuasika@gmail.com>
Date:   Wed, 10 Aug 2022 03:40:46 +0100
Message-ID: <CANpQBizN7RuY5uUpYN4G4vtBN+BxsJUo+Uo4j71ouPv8pHag-Q@mail.gmail.com>
Subject: Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:233 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [luuasika[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [johannspoerk30[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
  Dear friend

i sent you a proposal,and i have not hear from you i hope all is well?
