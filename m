Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624EA543E23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiFHVD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiFHVD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:03:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804BA226574
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:03:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x17so29877752wrg.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=G1SeVyk2Nyojrc2cD4/xuDKokGyeVSNBkJ8po2K9wXQ=;
        b=jboDtxG/rDWCthC7YhJ5mpIUwagt3P9I3+CzYHX/pnxZnVkPD+4/PyEE60+tVwHFsl
         e6dgfSn7HPw2A1QrDDvAHlrBgoUez2GpL1oDro1u6Dyavo340wKHPnTE/qtfjajw4WBv
         nCpDr3z42QSe9JaOvD32dnXiz3dsTeYqD+dBYtbtyqm3zE/hBjSItVeDuKizbp1rcy8E
         xythZD9URL3QAvSmmJLggyAosKJ5j/OPFl0uUkV55yexeP49lhxq8Dm5GhRw/mPssSiF
         dqco1PMfVqWFpPL3d1+hhzGeDvaB5FI+KwmYmBZ0Jt9QFzIagM7lOhQkBmzMuzJo3B8M
         vPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=G1SeVyk2Nyojrc2cD4/xuDKokGyeVSNBkJ8po2K9wXQ=;
        b=ERYUUbGYU/7eUlQrWVdr09t88U++DK1o7SgcE2vA66aSVAXGlfBP34brYns4NdU+Rg
         qhKBAB76KYUzJHSmYxHrHprwJLZ6mwaqNEqwmMB3ifONgzO3Ij7tqdillCy8S5BHBG59
         5Ml1dj/7xLfboCTZrEVE/c1aBSd2ICbpirVwFPSEqnBjnrmVE3ebUmLKpFR/1ynPxaGW
         gqVFvxQ+cmmAv8l19dPwNU8kV9M/PlHTVIMkYIXWSqLpbvv2tVOAlPFAQ4REC+Nlm/Z7
         UgMSD7zDM4QbhuIwiSlzWKHq+vhr7/4cPbcFxQ2/JRYGYE6z0uMz+tGXy+vYIFDN0IHf
         KMnQ==
X-Gm-Message-State: AOAM533S77QOGvQBczEQ6I43w39DrTLEkVctqVv2Zqseb4soRR5l0H6z
        NSYUUItEpFG4x0CpmqBPbLG+aI2GzjZ4W+AkrlU=
X-Google-Smtp-Source: ABdhPJzWVe0traqotLRMu5nJIhnlgDatbHtOJcBgB9cb9nIFthX9HP+27bdVzkJaHJDDoE5C9KKvy4by9648wotZnvc=
X-Received: by 2002:a5d:4fc8:0:b0:210:3520:7479 with SMTP id
 h8-20020a5d4fc8000000b0021035207479mr35203185wrw.610.1654722235106; Wed, 08
 Jun 2022 14:03:55 -0700 (PDT)
MIME-Version: 1.0
Sender: armtonney@gmail.com
Received: by 2002:a7b:cc12:0:0:0:0:0 with HTTP; Wed, 8 Jun 2022 14:03:54 -0700 (PDT)
From:   George Johnson <georjohns57@gmail.com>
Date:   Wed, 8 Jun 2022 22:03:54 +0100
X-Google-Sender-Auth: WxXvTY-EaSmBC2Z_UBThx6NFmtE
Message-ID: <CAJM5FotprJO+D+joVW=PrersPPHgn=G_2+ZA-Vgnj4HAOh9XNQ@mail.gmail.com>
Subject: Informartion for 08/06/2022
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a very important transaction i would like to carry out with
you. do write me back on: georjohns57(at)gmail.com for more details.
Regards,
George Johnson
