Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3DD4E8684
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiC0Hbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 03:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbiC0Hbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 03:31:41 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6150033E3A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 00:30:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t13so8617801pgn.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9lKd8D5vs1bIv3we5bTdIwiI5r0+Ib+NYvoPSo6tiVQ=;
        b=DVwBa9WSKfeJAtPIYpGVU1glDFmKVSYr3UvGi3icEEfIpn5/ThzQu+jQMooM2pl9/7
         QFz5hOlCq/sIw7aGgeXNsMKDUlkor7PRRtjtrO9dq8q9QAKTyEC+JBV3vnPKuSpJ7dQx
         +s6glZZPDGszA9fbmaEPdLoDplve2ZPLR6UW1XMMxPdfIh5KA5H3E1yqnu3RU5VThEi0
         OMk4U/1wQdt5IrXaYA7VL5kr5sNpxBSEBSuEPmjJa+C+47APTSrllVFW9w88RNlP9QF0
         449hrZ4q5Cy4hqucwiXwUmB0y7EnBgsoFnC4P9yK2/D0ZJaOAqPHZ+l33/7lcCCvQwVr
         33iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9lKd8D5vs1bIv3we5bTdIwiI5r0+Ib+NYvoPSo6tiVQ=;
        b=L3NB8d9v0GLx2UrGjXFmix+O7H7mgXCmXI6EjheDcOhnsD4s2W2h9/kBNRO/zVoyR+
         w55bxr+1AGKeTnuCO/RTRa5dcZasH8Pfyw6hRmBWiZZGwJMAvoIMpwv90vg3FWWgBcJD
         t7Eg2U0nIYPowoTX+mZTVrpmWGNNsYoyxavF8jgT5KXXMb+WpYeLRQANqrW5UQ4tzdqz
         hyoyM8endrsq6tGWrsmIpUTECQwxC1Hmylv44zHtoKlCJVYV0NYFlAn2Xi9gMkQZEKsl
         E+CBKnxZG12Gd7BGQQWp7CF/9fIFfSqw62pB0CvjKbS9LeMl4hQP+ogxYhYz+yXuYDUf
         WsPg==
X-Gm-Message-State: AOAM53168N+ufVGZWJKIGTKT38Ou5DmnWZm+v+Dol0MnrqLWNxiSsCYt
        s4pMAydQjWTMz8xAJWkDpVt/XEwEX/M=
X-Google-Smtp-Source: ABdhPJw8M8u1+/Tw6FlpRuq+xn0lYjq4U9MertxQH22ZMRcQye6U9WUbTvPCFLQQo463sNVLz6co2g==
X-Received: by 2002:a63:6fc4:0:b0:393:9567:16dc with SMTP id k187-20020a636fc4000000b00393956716dcmr5750446pgc.593.1648366202763;
        Sun, 27 Mar 2022 00:30:02 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id x25-20020a056a000bd900b004faae43da95sm11362544pfu.138.2022.03.27.00.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 00:30:02 -0700 (PDT)
Date:   Sun, 27 Mar 2022 16:30:00 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: [GIT PULL] OpenRISC updates for 5.18
Message-ID: <YkASeMlP+k/OJm3+@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Not much for OpenRISC this merge window, I do have some things on the back
burner like sparse warning cleanups and new defconfigs.  But I didn't get time
to polish the patches off for this round.  There are OpenRISC updates coming in
via other queues like removal of set_fs() and possibly new generic ticket locks.

With that said please consider for pull:

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git@github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to 862cf8d5fd98ed8ea8989726ed5da53761a9ed76:

  openrisc/boot: Remove unnecessary initialisation in memcpy(). (2022-01-30 17:44:34 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.18

Fixups and enhancements for OpenRISC:
 - Small fixup to remove duplicate initializer in memcpy from Kuniyuki
   Iwashima

----------------------------------------------------------------
Kuniyuki Iwashima (1):
      openrisc/boot: Remove unnecessary initialisation in memcpy().

 arch/openrisc/lib/memcpy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
