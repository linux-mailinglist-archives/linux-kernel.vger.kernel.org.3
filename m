Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5684EA0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbiC1T40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343948AbiC1T4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:56:24 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB4C33344
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:54:43 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q189so16768705oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=tJWmq9G1Gr+aa1y6az6AlHp+P9/CCOfAfKqWCIJvSkw=;
        b=HrE69A7lOoCgL8K0BUa9MJ+jka6CFPoH0mN5MkV5+LSpkpb8IiaxT6CbnVf2JmH7wg
         MUoruOKiNfiyLTlJBTDZgAk2GH8w3qdILQhsTYSkNYDd9S2/ECg8rZLvxKtQvfMevjrD
         6JZuozruKPIv3Ye2UiLae8ZUSiloW8LVigdhBE2J7H1kk114+Th7HJWOHUT6EpghrjaY
         XplUZFuPzvlG4aL6Sh0JD5EIJRxy2uHGi5oEIs3YQrabH4W9htl1/65GfmHSTGLmrrFt
         viwxc8inbnrzKG4bv+CmVytz1JwKD3b3myXGoRQs3rObNgZKYgjiiWD3xflaAaWhqm8P
         SkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=tJWmq9G1Gr+aa1y6az6AlHp+P9/CCOfAfKqWCIJvSkw=;
        b=buLxxoYnkSZiXPkG7NNm//ydUMPm+03QLzp9LF9/wDFhoVxbDWKEibgHoaTEXcpTM8
         Ci7GtN+dXCS758V2cwtVStqcM13oZxHdUuauCgssBNUW9U9l2r6CAEsqcQB30W9sSues
         mhS57W3yKvLoxQ1rlweukKNbKHqXzESBugl3Mf0zr2pjzMGKJ6aAgasqWgwznpR88FTc
         hQN0F5WwhQtLbidy6KYI4OxbTuN3kwuhLn/Vtretj7fwQ8YQFgBLPE5u1B7795bFQ3Yn
         jzWAJcIR8Qs94eCZmeGl12ZWoy6+gP1zDs3aQCc95rOPGN6FmC7Az75kvaa2hxrRRnp9
         Pd0Q==
X-Gm-Message-State: AOAM532IagxsiaavvdCBzIL3V8AswMpAGWlNPilcEPpXAPi4oIi/rbWL
        sqCnPDmkwF/VWpeccuC5XPS8SrxhFa5rSiB4/uM=
X-Google-Smtp-Source: ABdhPJzkm88t3TZIara3DtNb9KRoMMqPu9IYed0YGSgnkoIbUN1SCLOl1UirmBykSH7OPcEI2DQskh3Du+rPuSh8eOI=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr423913oic.200.1648497282196; Mon, 28
 Mar 2022 12:54:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:f1c5:0:0:0:0 with HTTP; Mon, 28 Mar 2022 12:54:41
 -0700 (PDT)
Reply-To: pm2956161@gmail.com
From:   philip moore <contact.donkalidon@gmail.com>
Date:   Mon, 28 Mar 2022 12:54:41 -0700
Message-ID: <CAGXj=C7VbHOWOyxBXBCRW1=+jxx5A+kX96Bb9JV9SyK3FzFUHg@mail.gmail.com>
Subject: Urgent
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,


Hope you are fine .


Please did you got my previous email to you ?


With Respect
Mr philip moore
