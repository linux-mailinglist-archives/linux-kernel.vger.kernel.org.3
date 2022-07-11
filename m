Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF0E5701B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiGKMI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiGKMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:08:50 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6697E3341B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:08:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso4735531pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5cJHSClaSNSC6CADWeDtciJpzEgHDP3Cx3FDxh15jpg=;
        b=VEe19z//I3ovtx0AMZKYYF11Cl3bdbz3BrAqMDe4obqo5Sqp+KiXRuti89+qMNf19I
         qG8jlMvtlzuAC/76Yt0nDJgu4fsCuySMw81Ihv3NVgaX90vjMQ0ElWJMs5PkmN7XZ+9x
         mWfPsMTV0+egxdUYf0gJa83db0vYkjiDktXC8sl2OTZ6FSZEHXKLbYu6ixd8lrvg0i0l
         xA9Fse5Vvwh7MVeh55cGD0HG30AUheccBE4K1ofwwTTSCducuLgaw/owY7cNJW21S4Go
         IPIOY4kE2ENXeaxmet4QrpRnUZIWxuZ9F8VcHwobAHahgXG6BaiOHMWBvb1/yBfnOpjg
         D3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5cJHSClaSNSC6CADWeDtciJpzEgHDP3Cx3FDxh15jpg=;
        b=4m9THxKOhegNQAfCvtzDCcWnJrnY1dh+Xkb1cAQ9YXOtnTuKHQjInDNs/P5jUAbSrD
         bpkt0iz0PNNjRaVXCKKNthO6On/mq2PIrT7xD48WDE37LDc2cKjhgkadKKK7hjVID122
         dvpLZQAC9rYitGI83olYDuxcctiCXPGjkXJS5DfXNpiyFQ+u5YXgPFG7H4NS4Nr7ZBNT
         UzzpToId5IioyKJgtXbb4DLVmS5kQMFl5Soxkll1pIOITODfSOSr3RyFKI25pwfpp4As
         SJJvhnJa7W/gv2RrFOBGRLBpoHDoUTfcVXKC3zoyDSv+d7PfAasTQebyuQJkP0LjeoyM
         bAMg==
X-Gm-Message-State: AJIora+sBMXymhfRzzADq+E34kxT53RzIGiBANc/T+TaKLsk4hWhBO3f
        EAdazgkmINM0VFZQZ03D8ch/20H1QVaLi71EKYQ=
X-Google-Smtp-Source: AGRyM1vNV/DtKLd11MOVRaVFCVTJPYqeRQ/Cn6cy/+E0MFszeQ1xpDU3+AyFYqgIEkEh44C6ui946Ct0XMxdyDSsTYE=
X-Received: by 2002:a17:902:dac7:b0:16c:34a3:e4a2 with SMTP id
 q7-20020a170902dac700b0016c34a3e4a2mr11608775plx.11.1657541328876; Mon, 11
 Jul 2022 05:08:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:6f0e:b0:84:124:9846 with HTTP; Mon, 11 Jul 2022
 05:08:48 -0700 (PDT)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <david.kekeli1@gmail.com>
Date:   Mon, 11 Jul 2022 12:08:48 +0000
Message-ID: <CAD_8Fxvf6sb+qMnmfKvwXPomvN_Leq9B9gpaNj2tcb6LO0XxTQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1034 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4948]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [david.kekeli1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [david.kekeli1[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
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

My Greeting, Did you receive the letter i sent to you. Please answer me.
Best Regard,Mr.Abraham.
