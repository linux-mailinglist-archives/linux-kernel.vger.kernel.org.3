Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792A64E5352
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244382AbiCWNlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiCWNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:41:21 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378E77D020
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:39:52 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d39f741b2bso1690746fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=HjeihxJTxzkbTZ2MqJZoma1iPJVLD30cD4qsp7lAs6w=;
        b=oEImOIhT5C3E28uXYK9NnqSlOFJxjnVSRc6tZFmXPk2XNUHwU1vgiYdWWY8FkHgYCE
         sZrVFUWXHXlVPty1egPFmsAyF+c0UQo3YYLikhOgtVKosj8IGhlWTU6PeLq0daZCxXTE
         BeZB7uWPxLNtnySthS/2c4KVxzKSOKOrHuB4pXnwtOdaVd1Lfi8mHSzkG1HepFjQsQkp
         bQeshgMOxc98OuAX7rRBRHf+JHguKLaTmaKfddms2rb7/biX+JSqGuUgNxlg6663When
         xXbIymeF0r/GlS1zK0FuEz3Ib4VDtKWM0xt82XHihChzTTlRDv3wnxy3ugNKFT2z/KBJ
         XJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=HjeihxJTxzkbTZ2MqJZoma1iPJVLD30cD4qsp7lAs6w=;
        b=TD3vKUerZmWvREqkYcKHdAA8Gwwf768vFeEqt8xusbVJ3xCT9HO+ve8VlUa+1SoHzU
         n2UGTalHQkJOUeoM3uPW+WXOyizAS0LSiQ7OA9NgQHJJsXGh4JQbUY4N0EmM2zbfJdz3
         mapqYQa81MpbLW+oko0FaxNp6RehU5qxFu5H0pM6p8mWoz/0OBQ7YxvMXi2gHO1O2FoM
         pkxx+oFEttRNpzK/Q8nehoZgCiTT1lTlHfjDDAmVduodNV6e1as0r72AfspZmYVwGxHn
         cCdZ3FkG6EhC1fwxRAtLRcqKgwRevoLAAnmsHYQqxWBZH4rJDU0Uvke1YUDo63Plbmcs
         drTg==
X-Gm-Message-State: AOAM531fOM4qkRZZ4SgFbCp888sClUak2tHlcIYLFMRDTbIsiJFvVTIS
        6/4DYgW/1eps+cZO/ytcqrU0fGsTKnm7LCwFSG8=
X-Google-Smtp-Source: ABdhPJxUG4TrxEiZQS8OFRNPKhUesFncxq6PC2GQPBlp8BXWId+K+uSHGJFQ1j4u9UPloo2JXzuIn2ikZXDcYN7gPdg=
X-Received: by 2002:a05:6870:5627:b0:dd:d3ad:c573 with SMTP id
 m39-20020a056870562700b000ddd3adc573mr4082009oao.46.1648042791405; Wed, 23
 Mar 2022 06:39:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6839:2196:0:0:0:0 with HTTP; Wed, 23 Mar 2022 06:39:51
 -0700 (PDT)
Reply-To: michellegoodman035@gmail.com
From:   Shayma <shaymamarwan07@gmail.com>
Date:   Wed, 23 Mar 2022 13:39:51 +0000
Message-ID: <CAAgEbk=cMyCDkK8o429A532e7dL29DrhH8GKtdLQMO4+xjQx_Q@mail.gmail.com>
Subject: Danke
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [shaymamarwan07[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [shaymamarwan07[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Schatz, bitte hoffe du hast meine Nachricht bekommen
Ich brauche dringend eine Antwort
Danke
Michelle
