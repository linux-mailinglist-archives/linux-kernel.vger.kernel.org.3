Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E17530BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiEWIc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiEWIcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:32:22 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B1BEE07
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:32:20 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 190so5723818qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=WZ+H1qUyPNp2nmiWLS7sS86h9kl7Ug3kEyKLMvWcNxA=;
        b=bpoiUnULw3VjVRJiuHwveSWpGQOc1pxsu+apiCKpHiZKq/C7tXqy7FHP2QRlF2yiDT
         ZHkR5wwwCD8afQtRX/wpmbBOFtyZEH5wZxCTErhiLi51wUKafBxICQeInDVjz3vxYbSt
         zCFBulz3o7DtrHD5ClAk3/B7fBKv2V9L3DLt+6dkl9+vSAn2f8n+AmQPWnlBPxTZwhuF
         nVKGN1O2PQf4TqJ2YHQEme02jb6hepfvq4wfURN7xOZudLTbB7IQxIwJ6fRKoW30V5ik
         ihTWpkImSsV7lz2kRz3IJU0Zc7YZaHLtu417GPxC8IMdb+NUysp+U/ksrwS5eot1CEJ3
         TpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WZ+H1qUyPNp2nmiWLS7sS86h9kl7Ug3kEyKLMvWcNxA=;
        b=WCmpmdLAIWl6bQ3JFIHa3kX9hsoEoVJsYUIlkh92dPY/QHDy2uEQEOTXdKZ7U19LQA
         RaPCBvX2sL0ZiT607iPktXf8iZmaKkw2u/ih/HTY4vgUKasaL4M72r5daZlFsBwH3gDL
         JXKkKntD28/MZsM/IlUSzkLCd8hZ325epiUgGd5FjxRwB3oPAR6rU6LBElS+oYMWHELo
         jvFDxhArQq0AJBBInVlzw33dncr4oswe5bQQGZY8hn1GgdAyJTS3cUo+ZUVZb5zrNZbG
         Hp41Q7jabpV7AYvRIfpxVtJVLYt5sOejWhFYdUW/kcOPcpHaHegTaIWsPzs3DeEcv2OH
         3X3A==
X-Gm-Message-State: AOAM532a9T9QevwHT0+F3KORMOZO4EOsqW2DDDhmzIA5Uco4vi81cm8+
        pj67FouHg3aHDt3NXQwf5csBXkIVSpjiwWnvB6Y=
X-Google-Smtp-Source: ABdhPJxHzcF+LfQrzVhGJWngaGHQOhhEGsvowWWDlA8cj9+2b2jeLT4kgEMdln2TTq+kouNEiJ/7rSbLBzWPZbLNS8M=
X-Received: by 2002:a37:8946:0:b0:6a3:6f23:d6fd with SMTP id
 l67-20020a378946000000b006a36f23d6fdmr4783816qkd.766.1653294739212; Mon, 23
 May 2022 01:32:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:5be1:0:0:0:0:0 with HTTP; Mon, 23 May 2022 01:32:18
 -0700 (PDT)
From:   Kee Wang <keewang6@gmail.com>
Date:   Mon, 23 May 2022 05:32:18 -0300
Message-ID: <CA+LVnoz6+c1MZ8WtfJNJP4sK5cA1jGFtC55hzq=bE8bLpgX=DA@mail.gmail.com>
Subject: Good day my friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have sent several emails to you but no response from you. I hope
you're good? Please reply any time you got this message to enable us
proceed with further discussion
