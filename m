Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C778158CC09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiHHQWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiHHQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:21:52 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89FBF47
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:21:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u9so10875305oiv.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=p2x78/WQCLJNFEWzdhn4/Al1RTNZOb4LssUAtfBZhvs=;
        b=AAAZZ1Iw8YeP0wqO2RfRde/TFeo905ofUrsQ98QWCjdVW7PvHgLceavQqaargorJi5
         V0f3e8nU89wcsg9UZQG3IyMdPtWxOM7j78xHFLqT2y1Vyxm/4nfXPJya3asUn6o2mrin
         Ea10T6hS4bhY7ulGiaIYPq4pW+uCYFHjHjBS7owcH/g3tbEAb/8jTiQ0Yq/Z625LW+V0
         DfDfeGUg/TWY7CsM5tMVz1JcZp1c5KbrANe4vFWS5pson0cK2N443PJKoCTcYOz52UUG
         OuV8HKqgOjwaB/XE+XI3Ck24vOW+Cg3s1Fx9sBmgChXqEIQqOHgh/7+ccDwRg772trKg
         dLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=p2x78/WQCLJNFEWzdhn4/Al1RTNZOb4LssUAtfBZhvs=;
        b=qmb2ym4l6Wx6R3/ntaFmNqsugdEAm1Gx0NGKCZWMf0xeiCUdXc4gx8oQj0YxhPtkur
         Xou5x0h+ZZptGDDex1OiFdOi8uPVACJEWCgFTELfOsGkBQJ0hOl4hNHlFGfQpsIgiqN5
         0H+YDB/eJcRzWOKLxkFRD2f0Rg2Fx0vZ4v3p+FRd1tz6+dSgsHP6fGV/18a9+mqEJz6G
         fK9h4NGpLq4Tu7wHbbtZ4uwRpeOGZ+zxBDhgoo59OwtIdijbUJV9630oDg9GfxZYa8vK
         Jzk+m70tm6XMF/EehSb9gG5ML+/yjRifC5UD6pbc+Ou1jf7deAX5Y3OB6a6rEygxSRE6
         Kwlw==
X-Gm-Message-State: ACgBeo0kVI2FKt9XpmG/xuTB+L+iwOQTwl6uIEmiStZlH+S4wc2q6Hra
        GTMFbSXmM+E1CCnxQZ/gU1vZF32vr7TWEQFTiWY=
X-Google-Smtp-Source: AA6agR4cuOf3RutstJ0+zVhqCYCGq0hFWo/ki77Y8HIRYADRnuwHDbHZPztdjOVdZDGIFRlsMW8wX+kFmv+F9V8LZkg=
X-Received: by 2002:a05:6808:1a11:b0:343:1ae:87d2 with SMTP id
 bk17-20020a0568081a1100b0034301ae87d2mr1184030oib.281.1659975711298; Mon, 08
 Aug 2022 09:21:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6840:2ea4:b0:c87:9c8d:50c5 with HTTP; Mon, 8 Aug 2022
 09:21:48 -0700 (PDT)
Reply-To: us.army.jameswalton1@gmail.com
From:   Major James Walton <davidomega705@gmail.com>
Date:   Mon, 8 Aug 2022 17:21:48 +0100
Message-ID: <CAFh2NJcBYF=fK9eo32bF6=Cm1BK_27rgS-DVMrkxk4ygQ3HNLw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:232 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [us.army.jameswalton1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidomega705[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidomega705[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
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
Hello

I am Major James Walton, currently serving with the 3rd Brigade
Support Battalion in Syria.
I have a proposal for you. Kindly reply for details. Reply to:
us.army.jameswalton1@gmail.com

Regards,
Major James Walton.
