Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B514CF2E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiCGHt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiCGHtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:49:25 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6E9220DD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:48:30 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id r11so11413446ioh.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 23:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=8J38Rv9T88O8LznVLYDAMzgkYD+RbVqzgKVGb2a4ys8=;
        b=C8tUdaN4Ho1KtRgmpMqNKpIK0uns1KlJbuWW/a5RactIDPbEp7MKSuKX36WVTq76Zu
         /LWz6u36HbO2tISPIlbwSpWMqWIaKuJbLIsRzV/9POU6ReLgzmLSm55MGUXceGygRrw3
         5NR8qgFZhzryYwEoEb/XgCVbmJ71YjwUlULuBQgvr0RIGrnct/Pjy48ROR5lOSFQjshh
         AOy9el8iVbV2COXBKimY7d32GMJqvdFsiLESuhXNd4MGMxTNpYmnucRuMOkgS1Ts0HPR
         SqP6Lo3mv9fQzGAD5u/6nS/MvK3HCJfLze26E65gqIdgJrWyK36sVNHPr6d3SJFCTAoA
         HUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=8J38Rv9T88O8LznVLYDAMzgkYD+RbVqzgKVGb2a4ys8=;
        b=RmXeWD2yy1Z1lyEyyGuF2fUA84qC2ZnbvigCMAjSAq6QQ1uidsLVp+lvBT4YnxWhJR
         UuEfiQoMIsM6FCqy87L+1xckOXpF7S4Y9zYLBLMVZOZKxktyv8iY9aZPUp2CmvBOHeD/
         hPKIYIl0z8179geHfrQRKidND4i0sO1/vc2CwSPYV15FrDygZyNM1z/b5PaVyylccKvp
         qq1MI+WXENoqmKJrVLRT8rnT7kpY1d67FKVOv0ZQUiCVhxYQpoL6+6F/rQlS/Ad/CZLR
         oNLtRiCmmcySPXSeFt8bM7XpWUq24ZPyTOr2SYwT5fkhulnOktCxK6NUxGtbcwMcuOZU
         U7bg==
X-Gm-Message-State: AOAM5336+XugDgmM5AtWkPf8oLwB8EGMcjaN+cOsO9zJAnR6Vbs1z3YN
        iYDWkC3rFa5JZK0U+XW/m1wGcl5r+lsTzO/FWAY=
X-Google-Smtp-Source: ABdhPJy0m8WFCbnEHh7+SXhPsiMuUf+Y9a0VoChZDv9Nv97O1qdlwAQdWjFZ2AuknrEtA/QiDLSSGKYkEtSXPX0aRvU=
X-Received: by 2002:a5d:944a:0:b0:645:dc2c:46c6 with SMTP id
 x10-20020a5d944a000000b00645dc2c46c6mr523779ior.190.1646639309845; Sun, 06
 Mar 2022 23:48:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1e0b:0:0:0:0 with HTTP; Sun, 6 Mar 2022 23:48:29
 -0800 (PST)
Reply-To: fb5485370@gmail.com
From:   fred benson <fb5088646@gmail.com>
Date:   Mon, 7 Mar 2022 08:48:29 +0100
Message-ID: <CAGY2EXNO1MLbF5FVBNWiQhsXwfMkGouHTuQktcO6QitqV3avUw@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
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

please get back to me for more information on the transfer.

THANKS
