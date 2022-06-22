Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB065549D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiFVMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiFVMQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:16:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51863700F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:16:14 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id p8so20899475oip.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=c1xRihTGnvd5U245Sv9uTLAoBKTZAFAS3qT4lMFr9HPZhb1Vx4d6OndrMp9kDGgdYZ
         rbVJpSZto6yquIjBmyTk4C6zW4EADBFH77zCsu76FwZes8O2qd25zvjtaFPShlMFHd9J
         2j849f421dKBg9OtV7SV/LL3BkWzQJlKEqJX7MiaZmMTgVcTny1iH6IpTSao7DwmMtPP
         6JbWdUvGqxYnWyRKFSl41Fdr+uC2Hz/3aOXKsCBxsRsLrXjBqk4Fd9hy9zRIFWjAVgY5
         M0eUWeeuFGq3+RKFJq3OEyxuxRJohWPzaVxGTwUBpUaL8VLcbFFQd3Qywx5ezsENWge1
         N8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=wqWh+ZrUenSQFxRs782/PbqZP0JBdj7sdSDX58jAh7RUxXs/wLMWMt68gFpbRZclmz
         3VzAoeZANSFZe8Wn5cJLuqIS8035aRlRvHjCnzts9MC2dxWEBk/1FenVRQweus3eDbf5
         rF/D9HnczlPzuVIsBU91NBRjsCPGV89OHrbRHvn1DyOixlTpggvnbbvxPXegJXBVqiQj
         voqKyOZf1G4+aUCNmS68J/URgKNn4/B4ftRsOwsN2GFZd4CzD4dpyTEaePyGptxAXBDr
         cOdLziYNgYuy5NejHwF6GdZn1m2VdNnFoGCEbcS8CaAxQkVOz9ZHq9aLyWKoDSqRS75j
         tgaw==
X-Gm-Message-State: AJIora9IeH5ACxlnDmApSk9wM11YDgv6yDabsVtrECOS84GvLuTPgRkQ
        sm0xO0s7OyT3niW2EzDERddB8CfEFSJT0mvZw/s=
X-Google-Smtp-Source: AGRyM1uDC9c7FDZ8he1DfEV9fAKpGJ1PE32QbZHduefZ6NVH8okhg3KuxCsRMz+N6/P2HP/++mOvufG6t+VT5daz0rQ=
X-Received: by 2002:a05:6808:138e:b0:333:54f2:1740 with SMTP id
 c14-20020a056808138e00b0033354f21740mr3685708oiw.21.1655900173744; Wed, 22
 Jun 2022 05:16:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:a99:0:0:0:0 with HTTP; Wed, 22 Jun 2022 05:16:13
 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <mebbe4596@gmail.com>
Date:   Wed, 22 Jun 2022 04:16:13 -0800
Message-ID: <CAGJBxNVxDnVHP1FGgTfpoeK_O1gBYN6QUxuP4UJ96h9-+fa8Jw@mail.gmail.com>
Subject: Hi Dear,
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

Hi Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
