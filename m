Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F324C05EA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiBWA1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiBWA1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:27:03 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2653926F1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:26:32 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id e8so14284359ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Niu8BsR9isXU2Kkmnz56yc6lMiREQRBSltPoKUcabxc=;
        b=jhnDwTDW0FR/ROUhsuc0Yuc3i7tDnAcCCgW/rgGkmSYsWSxlgrurjzZhBRDR6HpLqT
         dXKvIc79ldPBsDfqhWM+K0/avNd/ibh5vzIBMUHNbwnRrUcakobk3+0RJCgWwTTPFMIg
         WATVDNOIe+ENbQXxBe1m+RSBZdMB4VwThXn96bRawGRDXB2BGs/4pBVHrvKDtkTuVQcY
         h4t0bk325DmvejhK8thqRs0ZOQIiTVqmd4V+bXwyeZMmdHjtsSPAgaz6VVXwQIxo4Hon
         KFm/UZqGsPXNUA1TNkXOc5IW6+fI2BwQsitRWwfFrILkbSZg62KybUf5ZOhHKVzHVjrF
         cjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Niu8BsR9isXU2Kkmnz56yc6lMiREQRBSltPoKUcabxc=;
        b=rqsOwx8YaqbKMuMaMVLIU98IJqnqGRJQp3gs/sYAEQzb4n83cE0X7DyLJPbZ7nxXi5
         rMBkTkdhYGagEYwZUMeRpwwFUf2r8SVTgP5D0Yh6kEd5iymzEYI+LHnAClsuQWoDmUpi
         n0BSajsNLG7q36t4+IgzuCCNYBZ6umEJXI/LKB32vg4EQYjet2aRJmHXGjLpfI/lyHUP
         MwHqqYi+AT/WBV2drEW5sgWzdSvmkTvXfVcfnzLWQ1pQsau5VIeFP8UOexdj4ICtrjNy
         tFYDg6wfypJKqZ4u2UuJVEwbPmHIcvcWfuT8yasvvreDZwJ9t5Nq4vmfq8LpR8nINWA0
         d94Q==
X-Gm-Message-State: AOAM533MyzetM9ZoVSa7L4dcrnLKKjSXUb8bNC6nHRetkEtzTqin2iNk
        qDZgQF6pQ6HaOjUR/JgIA7kBOTP+lJs3SKv5ldo=
X-Google-Smtp-Source: ABdhPJyKF6zoDUuH3v62lwmk0PGWYANLrjvMu0p+zQ4FD/H+JZlqGS6fF114MUIiBCq98wcngqkkLbJ9ULGhsfF0d2g=
X-Received: by 2002:a2e:9ecd:0:b0:246:4907:d837 with SMTP id
 h13-20020a2e9ecd000000b002464907d837mr4588633ljk.174.1645575990302; Tue, 22
 Feb 2022 16:26:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa6:c08f:0:b0:19a:cecf:350 with HTTP; Tue, 22 Feb 2022
 16:26:29 -0800 (PST)
Reply-To: emmaludwigk14@gmail.com
From:   Emma Ludwig <feouziyaplisono@gmail.com>
Date:   Wed, 23 Feb 2022 00:26:29 +0000
Message-ID: <CANiBEGUEhuXFG5jVnP_KCMPz0zdSPVdareZzC+gHhCx=RTe-7Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello .
My name is Emma Ludwig .  Can you find time to respond to me now?
Please something came up and i really want to discuss with you urgent
and important.
kind Regard
Emma
