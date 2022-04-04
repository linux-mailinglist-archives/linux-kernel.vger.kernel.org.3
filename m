Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164814F1633
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356318AbiDDNn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357765AbiDDNnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:43:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F7BC3D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:41:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h16so5989547wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=SRxD87AUiwmCT+RRQxA2h0waMYqz9GH33oHQGZB5jTI=;
        b=S8qwLlZvEbILDCpzG1jvTV79DrY9QEIypqTmU5u1m/hD875aK81BVlHQZoQ+1sElpk
         tQrZFigYBc6xfqDJZdrHFSaMI9DqIfEcntnC4n2IV5LRN5n5ED8KRl4Litc/zNPUUknn
         xh0xxQuaYBlrOehvb2jA4dsOepFt5Kn4iF0+1TphJBDOBN6gshZtH27MAlHHBBYWdwCf
         JqrDrgOi9HTDhXTTmG8whIoOCBm+OOaN8KF8H2GsZ4j/+7FBWf/ZJWxGLv1hIsg1uNX7
         5F+ksjYeTHrLbjybC0zZSpo8YxR9+YH6NLwC8oQ7VnxaC2/GfLC74MiM8k5TNDNMWN3L
         Vnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=SRxD87AUiwmCT+RRQxA2h0waMYqz9GH33oHQGZB5jTI=;
        b=aeKC08JqzxN66hiEz3DG99Inv6aVAM4PpmvXgX7pUvknDRwcnO6pMVhREwVErM+9Bv
         rsDhdx6Qr7L5Rbgfh/5feKYhDp/EVDpFFZU7tfEooC4rR/7uCa7QSCdBaeCAxXwkAlvM
         GW3XVrSJCKhsBs3/tWV6FtPY6mzbSDyspEVzbvueH9wehyvmHvMsnkNev1y/JY8fSxQM
         0VSvNoFduyncerlIuiG5YjbZBgxhNttung6etCXI1AD9Se8DIQXEJX6uT7Tn/1t/gt/i
         8yOBhENew7qcRICgxCcVvmeO+Yl3pj/LZyr2US28hh0XKIY16K1tOZrV67wiBwbLD9ce
         xhxg==
X-Gm-Message-State: AOAM531ZO1jrFrKBjKlH63Thdak7dzkrmhTvKvw2T6UamQ1e9z+ake9t
        JjO9IACHeUL7bx/3xezbJQ2vit21YcM3PvyaEtM=
X-Google-Smtp-Source: ABdhPJxyhGsPmyH90IEU0cl6VoHbeMpBJpmQEvygr5YBDBf6K8sqRtjRUaVE51sTZWX7ySLzBKxhDw==
X-Received: by 2002:a05:600c:2948:b0:38c:b3e5:eed3 with SMTP id n8-20020a05600c294800b0038cb3e5eed3mr19083730wmd.168.1649079676716;
        Mon, 04 Apr 2022 06:41:16 -0700 (PDT)
Received: from [192.168.8.113] ([154.120.88.21])
        by smtp.gmail.com with ESMTPSA id v15-20020a056000144f00b002057eac999fsm9794484wrx.76.2022.04.04.06.41.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 04 Apr 2022 06:41:15 -0700 (PDT)
Message-ID: <624af57b.1c69fb81.1d9bc.676f@mx.google.com>
From:   "Mr. Warren E. Buffett." <wseuno223@gmail.com>
X-Google-Original-From: "Mr. Warren E. Buffett." <info@usa,org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: God bless you.
To:     Recipients <info@usa>
Date:   Mon, 04 Apr 2022 14:40:04 +0100
Reply-To: unitednationparol23@citromail.hu
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My name is Warren E. Buffett an American business magnate, investor, and ph=
ilanthropist and one of the most successful investors in the world. I belie=
ve strongly in giving while living=E2=80=99 I had one idea that never chang=
ed in my mind that you should use your wealth to help people and I have dec=
ided to give {$750,000.00} Seven Hundred And Fifty Thousand United State Do=
llars to randomly selected individuals worldwide for my empowerment program.

On receipt of this email, you should count yourself as the lucky individual=
. Your were chosen from active email lists online.

Kindly get back to me at your earliest convenience before I go for my treat=
ment, so I know your email address is valid more details and subsequent dis=
bursement.

God bless you.
Best Regard
Mr. Warren E. Buffett
Billionaire Investor and Philanthropist
