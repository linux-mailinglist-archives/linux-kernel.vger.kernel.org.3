Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E10F552AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbiFUGGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiFUGGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:06:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5AA2018C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:06:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z11so11715948edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=8L3u9yLimYhqEYiPckuKAsVAuSvOnpygme4DEwcN/0I=;
        b=bK83hoj2i7b6z88tns8D/gcTKyp3cynytnB4eQUJ3Ztwy3o+HSa4JMPAo4cHSL0rg6
         pFjPgT7wKTaGx9OdrlrYoP1Gro9Cn6XXNASkLlZUMpY0D9mwSzsb+5T5Wkggwyfd8gXM
         bO31Ky6+CZI+a3GHChh61/2ILVDrzSqJRKA4wlUoj1/CxRUig72/aTQE6xKAiBEe2pEt
         04whtJKVx8TBKSzTRO1Utdi083P76WXDFazkWpMgwMgaebs/Ewe+tRym5gu0G8YhUhHd
         gI8g9IQAemDmA+esf5SCIeC9nKBMBX7TggkJzc6s2OVSxZQ6wswNjCfySRECYom+UPLm
         ULlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=8L3u9yLimYhqEYiPckuKAsVAuSvOnpygme4DEwcN/0I=;
        b=bkqhJZ4YC4tNFpJuQYU+V1SlYpwhrQe0AuuUGuJhWgcEqGNTdj7Vjkm3dOPetV7wMM
         W6ASnBJYOxlVyQHqnzjN52KTe0CJI9+ZWJXUGwtcqm034sRuVW2LfQ7DfYnvVzVlet10
         dIez1hwI4+TqoFlQkOjpF3FkJf8CpG7xZL84Jqd42mTAaZ5zxNDsEZB/C0SOlO5vAuFq
         vtTt3NiAa+FPOXSiQSkd761/d/Lx483bBff8R0c28WXKOTt6vx/uqPn96nS/O/69bXuU
         CHixy9mE7QgA6sdM0leVUJvh+fYTjSw7NGHLcLV8FYvH+/ASVtMC1tI+WB9hgDOE66fo
         F/SQ==
X-Gm-Message-State: AJIora92LYafrsOmFOhJEvfhn6Swdr4vmMi1Ecv4QZgABt7IR0OIGExv
        UUyjD08G5FnVQJeAAHAD8J7cTVh2+C+pGodsVf4=
X-Google-Smtp-Source: AGRyM1v8J962cliLseZ9SL3FdsdIqkc0Rz3FNN8MuyD+uZpDGhq66Uo1bYzmcwrrAKlOSBpe49z7QWx2kvtSVOFyJuU=
X-Received: by 2002:a05:6402:43c5:b0:435:89ee:578f with SMTP id
 p5-20020a05640243c500b0043589ee578fmr7217039edc.225.1655791576871; Mon, 20
 Jun 2022 23:06:16 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mayumisakimoto7@gmail.com
Sender: christyfilon2016@gmail.com
Received: by 2002:a17:907:3e0d:0:0:0:0 with HTTP; Mon, 20 Jun 2022 23:06:16
 -0700 (PDT)
From:   mayumi sakimoto <mayumisakimoto07@gmail.com>
Date:   Tue, 21 Jun 2022 09:06:16 +0300
X-Google-Sender-Auth: ymo2Kz8jJesXE4gyxoR0ovIUjLs
Message-ID: <CAL97wxgc2J9j-bsxc_xxnsfXsV7jywPDutcCYbe7a0iGtX=tNg@mail.gmail.com>
Subject: Mrs.Mayumi sakimoto
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

Greetings,

 I hope this email finds you well, Please accept my sincere apologies if
my email does not meet your business or personal ethics. Please I have something
very important to discuss with you.I need to entrust you with a
humanitarian project, Please reply to me as soon as possible.


Kind Regards,
mayumi sakimoto
