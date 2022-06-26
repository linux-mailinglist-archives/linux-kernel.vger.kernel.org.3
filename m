Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53355AF3D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 07:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiFZFEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 01:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiFZFEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 01:04:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D82213D62
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 22:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EA63B8009F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 05:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99494C341CB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 05:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656219883;
        bh=7oOGRyu0tC98OV2VuDUV0usAqseVpiJUcrzGvwxzzbw=;
        h=From:Date:Subject:To:Cc:From;
        b=oRczlz0eRwpq6cE+rAmo3iH1dvDBWo6jW4eo34kfyFrLGQn3zODA9PflMu/x3jM+o
         XYkcabCtFtiWHSvJYC2m9O1s+3ke6K9f1URKr8dgsHDSrZ3OVTEtdXFgo21tV2mYWk
         Czt9HPbLPcq9zQtl8m0uLsOXryuosegw9l0qfJTnBKokK/zhsnJSZv+T+eSqQWbSB/
         HqPaJylzJI6qKgidBOg0AnHD+rYZrwbjRrvgDlR9XY0zuNwS7p5lhfW+r1Ov0rA3hu
         p5Q+vxbfb6qv7iH/KsPaswpQOjiGGzNqLRwoS15aijKjQY0Rr6dHDDjujvUe/bkNK2
         6FH+bibVd6VJw==
Received: by mail-wm1-f45.google.com with SMTP id n185so3444667wmn.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 22:04:43 -0700 (PDT)
X-Gm-Message-State: AJIora8AZTg3PcTbE7PKyUDRvY4INyEER8UWNGNydMd8FogyDre5n6SS
        wKeBJaZohoLtg1qBX9aU78i+GccuVnPU/ow3X7s=
X-Google-Smtp-Source: AGRyM1u5AujRwTBTJxJfLN/iMWs3d3m7/plnKqA/m3WOt3h0yFNccU2KLrlWEwkDfMClPLKO9PVanuWGZ0IHj6ud0s4=
X-Received: by 2002:a1c:ac83:0:b0:39c:87fc:5797 with SMTP id
 v125-20020a1cac83000000b0039c87fc5797mr12509763wme.13.1656219881842; Sat, 25
 Jun 2022 22:04:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f805:0:0:0:0:0 with HTTP; Sat, 25 Jun 2022 22:04:41
 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 26 Jun 2022 14:04:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9C+9RAF=M2h-gVXpnUDq-JQSF857agrE5c=eZQjEZaVg@mail.gmail.com>
Message-ID: <CAKYAXd9C+9RAF=M2h-gVXpnUDq-JQSF857agrE5c=eZQjEZaVg@mail.gmail.com>
Subject: [GIT PULL] exfat fixes for 5.19-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat fixes pull request for v5.19-rc4. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-5.19-rc4

for you to fetch changes up to 204e6ceaa1035cb7b92b156517e88842ebb4c7ff:

  exfat: use updated exfat_chain directly during renaming (2022-06-09
21:26:32 +0900)

----------------------------------------------------------------
Description for this pull request:
 - Use updated exfat_chain directly instead of snapshot values  in rename.

----------------------------------------------------------------
Sungjong Seo (1):
      exfat: use updated exfat_chain directly during renaming

 fs/exfat/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
