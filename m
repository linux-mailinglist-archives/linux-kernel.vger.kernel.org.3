Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042AB50C76F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 06:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiDWEtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 00:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiDWEtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 00:49:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289DDF1A;
        Fri, 22 Apr 2022 21:46:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p8so9811364pfh.8;
        Fri, 22 Apr 2022 21:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ldlAohQJsTMQwSV2LOlG+2dFoY8odukiqsA1ICZfUFM=;
        b=Z/9U2blwARR4iizKeEddtuXxzU29ALXuD+p/GZFwGJOQNNhC1LIbk9uA0LTTcrxvb+
         uxAAD3lyo4Mr2oulONAZzKh2IqteQbiFObmYRj6l9ymgxf2nsxUqhBgOKF0z7SIGSRY6
         x2F1aJ+o6R9MHqb3FIAifmAoY1SJNd2oS2CQs/0AGIxIwvaL02VxskJ54ZwFCXTdLtg2
         tY0x/x3Dy2Dcwv1p3LKMHJyQI/6b2q9urJhpcl4ao351liVds2SoORgPIunZjC6IWxG7
         CqPiF2X3+WbcGf9k0jNLmYsAxAnBYPFaM5gI0LL5SN9Us4w1uYl9EMFDYQSCERwCQs5l
         bf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ldlAohQJsTMQwSV2LOlG+2dFoY8odukiqsA1ICZfUFM=;
        b=VMcWZF+fpvowlzhgZigYDj2Aq/MZA+VUsuVaeY4NxHx6SwUeulrJzPG4Q1DLxRyESW
         cWbCd7k9VcPhTXNp1e8Oofop4mbGs5OrLARkdak/D7j/BCBtjRh3FzbW+fjgOQc60HQo
         0HMwy2rKupvRar/tBgsyg2XO40y32gG1fZQDVDnhHoQjsyt7mDvPA+5ewTvCheO0hBXu
         uFUsHVBp2U8Vf8iXFx1L4c3OieGk43awa0S6ADoMEvMp+fpF6/7fBfRKbrnBeL+6p5Tb
         9QJJ8AuNfmUa/2QdqU+Gj4DIRzfilyPnEkses57KFDgHK5ZAzBQ55J0dgUu0xT4M3NjM
         CwRw==
X-Gm-Message-State: AOAM531CGYtVTcCQDEIghEsE00LOP3nJuBXSt+FctrREUzubAEMotc9Z
        xJO/JSkFMg6plount/XCdY4=
X-Google-Smtp-Source: ABdhPJwfcxF3l/u4Wac8SsFmfe+lPYy8eQhgQg3/b6cMRlYgirTIAmw4mh+umthf+kwQLaS1ntM8Ow==
X-Received: by 2002:a62:a50a:0:b0:506:cef:44f5 with SMTP id v10-20020a62a50a000000b005060cef44f5mr8379473pfm.22.1650689213291;
        Fri, 22 Apr 2022 21:46:53 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4a35:169a:7a52:fb54])
        by smtp.gmail.com with ESMTPSA id bw22-20020a056a00409600b0050a8e795672sm3972388pfb.29.2022.04.22.21.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 21:46:52 -0700 (PDT)
Date:   Fri, 22 Apr 2022 21:46:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.18-rc3
Message-ID: <YmOEuZ11On7T7Gbe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.18-rc3

to receive updates for the input subsystem. You will get:

- a new set of keycodes to be used by marine navigation systems
- minor fixes to omap4-keypad and cypress-sf drivers

This is the first time I am trying to use a signed tag for my pull
request so please let me know if something does not look right.

Changelog:
---------

Miaoqian Lin (1):
      Input: omap4-keypad - fix pm_runtime_get_sync() error checking

Shelby Heffron (1):
      Input: add Marine Navigation Keycodes

Zheyu Ma (1):
      Input: cypress-sf - register a callback to disable the regulators

Diffstat:
--------

 drivers/input/keyboard/cypress-sf.c    | 14 ++++++++++++++
 drivers/input/keyboard/omap4-keypad.c  |  2 +-
 include/uapi/linux/input-event-codes.h | 21 +++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

Thanks.


-- 
Dmitry
