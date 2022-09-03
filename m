Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6578F5ABC01
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 03:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiICBUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 21:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiICBUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 21:20:03 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746055E649
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 18:19:58 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id jy14so2675604qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 18:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=OEs3If/vA6n7iMnRWbVMdLOTk9I3frOpcTeJ9NsI/9kFNF+/IwBXHI21J4/33ysLyc
         JYUNuMoWqhLk+O0jAATHrm0Oia7T1ExnkFBe0uB7xmzxu3LpQw2wCoY1PuvwetcNNMBC
         lv+L4GPO2DozH5RjsN83gxMwH6mw9EmY77sCMAw01hAaVB90BmY4+v8Txp0PygVD441p
         dF8t39ddk4bsW9KNQjJ3mWo/1YCpUAkYtVrMR6TJ1H2/ezfnCic+vg8H7Gi/9VPKna5U
         xvCHYfu/ydikk1vGkx7xeIL46qS414XzuBPmOtdyrqLX1pPS+I7E0rOVGIWPDBDrVkBl
         Aueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=lay/gczT0MG0L0BX59oR+N0RdjDHyhgz01wNRCYJ7JNglji36/KgUIDe/xbD+227R1
         78sS2DVgvKop/oCInlreECO4R16flip2+GhtJo7w5uILWu35v8Rv7r/ATm19eOeSC5tl
         0dfflnCc1n6gyw/0eYNxuhmB8WpgB+6T5T8tqsAMwuQ/14MTNe3JbKbV0rbt4GrfSocm
         L2GgOt6Yk5j3U5699z9hRUel4t1SnsvI5p3Hu4QnaVIP0n0oHmqkMj95hE/7owZkALBv
         EOMyxPAPUb+TPEJUVTnfisf2Yu8LMMZ9/G3QsTP+bmkaV0yL/4CtW8R3y/Jm9/TEzOaq
         tW8g==
X-Gm-Message-State: ACgBeo0jBQfjASmsxuWo7OM3Hwrd/GDx9agINiB9wutMljA9ltzIx+z9
        OmEsIzT4J504P3lvYoKj0sTfe2x8/3VyZWHfKcte9uv0vINUmQ==
X-Google-Smtp-Source: AA6agR59DIqk5BVCPn+uqcrvrnf7q/fxw+WcXNkeh3FkaQ+iQPxa1psmNtwcK4dbUrxaDnnjQjlcy0Hi0TVYIP4625k=
X-Received: by 2002:ad4:5e89:0:b0:498:fdc3:9450 with SMTP id
 jl9-20020ad45e89000000b00498fdc39450mr25983802qvb.77.1662167997478; Fri, 02
 Sep 2022 18:19:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:f70d:0:0:0:0:0 with HTTP; Fri, 2 Sep 2022 18:19:57 -0700 (PDT)
Reply-To: maryalbert00045@gmail.com
From:   Mary Albert <albertmary164@gmail.com>
Date:   Sat, 3 Sep 2022 02:19:57 +0100
Message-ID: <CAFh2eHBDw=23fhow1XsMsM7vbjMPkqJgOZLUNDDCPSoZSU0scw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f43 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [albertmary164[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbert00045[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [albertmary164[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
