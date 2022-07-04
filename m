Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01B5565935
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiGDPFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiGDPFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:05:52 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5961F5B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:05:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id e12so16249085lfr.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=yFjPBwfof55JxbmPqLU/8pTY0KXsIbs+GUr373EysuM=;
        b=dAOPq/iZ/feUV44Tq5OdcQNvWeJ7Nc+42HxTg+9SUe69I1n7/BtXL26o4G+Ymu9Myo
         pB4vs4bYiOdtbgY/tnEhCbOobeeESib37bIDfJ+WqcNQN0wYOktinOpnPna3aqwM4Zrz
         Zg92QENg3KosGUl4BalT+rS8ya0efQ+WvO3R13GtJZDMpUj7XSNYPrloWyGPqZnypX77
         GVM8wzDDuY+AKhjtdRy4Rs/xft4UldBVlu2ngnGq3sNX+H68fsMXWse9lUi8G85U9Wu7
         yuAdBBREJFW+/D+MDvAAfhIu7BAxAbisE6nJ6vZ2TGV6VY5pSs5kJ16bH59tm3PmekNV
         u7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=yFjPBwfof55JxbmPqLU/8pTY0KXsIbs+GUr373EysuM=;
        b=yuJAYWDfRpVUq6YdI5wA03CGs82D8+B79HsoMOn71WWiPg4JZhLSoBC+Tx1p1WbyZe
         Lng00WcQMVKnHYZ1Fo7WNJQICQomzfQH5kB3DOTB7H7JoA9UV4NoetdK+H9m+srntVGu
         BAVpzrVh8WtMx211Qq5o8sFuj50hfkGRYJU0XBErpaDrKipA+sdszsYkndWe0lpoSxF1
         jEB8Dr4kQUXVubOdujg55CO8DjRkBo1JWDCAJy9N6luZHeSBpsBXyD/Q5Qkt5ET4YBPq
         qKuwT9ReXBrZIBPAd4rtKOPecohbPGDvrr10FG9LRchRw6Shisy2ORho+ebkyp9SQzmy
         elhQ==
X-Gm-Message-State: AJIora97OTc2vAAHWBS51QmEx42zXukw7PblpIfckqfC6OQrI2kQbwPL
        CGFz9qqaBr8NapljN8s3pi45kNNKhC3Lw3dqjaA=
X-Google-Smtp-Source: AGRyM1s1s7oT5EBy779NkyiBFYXNXHLgWHK1TjiZvMXEmToNfpV3TlA7YOGOFHzLSxQmRweY58JlQzGijPvZJZD9Bbg=
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr19980657lfb.397.1656947149740; Mon, 04
 Jul 2022 08:05:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9a:5b1b:0:b0:1f5:297e:5050 with HTTP; Mon, 4 Jul 2022
 08:05:49 -0700 (PDT)
Reply-To: stanleydenford100@gmail.com
From:   Stanley Denford <sjt0781@gmail.com>
Date:   Mon, 4 Jul 2022 08:05:49 -0700
Message-ID: <CACCcWsCEZKuAvEO2y=xkSduftYfV=_Xsr5g5Cb7rJLfp0w=kjQ@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

-- 
Good day, How are you doing today

I am Stanley Denford, a Client Relations officer. I got your name and
contact information in my quest for her existing extended family, I am
writing to you on highly confidential grounds with mutual benefit in
respect to the estate of Frances...

The estate is worth millions of Dollars.I'd appreciate it if you get back
to me by confirming to me if this medium is safe and confidential enough to
enable me divulge to you details on why I contacted you.

Regards,
Stanley Denford
