Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49057545E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiGNSEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiGNSEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:04:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B41613E27
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:04:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e16so2528298pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=74QXJDWqAz0LnYjov29LyjS5LD/BWMFkyZoslDFd9ro=;
        b=jXulcJn2qk2I+WR+IrKZcKqBz7BdkyQJFsHN08ms2tBie3OptA81d+AfKQZjjNxJxJ
         5ya2T0KEXVyPIF2OktpUiW2RKn21OX9COW+OYbGl4WqaDrilX1RthQVx/SvSCey6ARy4
         re+zUBKhHvEMP2sFiut4E3nqnZ1AbtO29jPjqHTYLzJzov0EB8/gIwo2YeWYmpalghDl
         Xf0WVgruZbv5h2HIm6KT3PaAMqznRzMxLcMvdGhdRNTbzjGeK1Z6Bc7YSOUZddzslTEg
         gGMyGGcTDtxuNhUOM/7w57AbxRWAYEmetNWfNfS0ehv6/prdWLw2q6krr5ejUIWkDP/0
         89wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=74QXJDWqAz0LnYjov29LyjS5LD/BWMFkyZoslDFd9ro=;
        b=795PH2WDNf8fOf9OXtGBkVhf9rZSf44F7Zqgs1ie9hA/O2xD0FEYJHzRLvELNIAl2N
         Exvew9TM8/vnir2qmj9koQ8OdZNh1UFFQl5+rCxM/E1X+s7Wja+Oh8AV57A7qkX+dWO/
         lClHKz67B47HoMI2WjKmQSPE76eZgc8F9DCXeC8yr/f4uBK7+sd2ejaBpbT2ul8u4BKx
         kDnqbMGje0J3BeaBGqjejSaRzNMTcnVcPvDhEa2kP7rwxmesV4KJXXB8P3UGWjmvxN9Q
         aHC2lUvlrlj7gg7R9zEwNcEgE+Z5YuNIlhhFGhaZcZcKAzXFiKddS266bQGlgbeXB34w
         tZkA==
X-Gm-Message-State: AJIora8CMnXLXug/2B/rX9aBeZT6EXnYJVlVrbLro1bnGVPVG39iNsf4
        iLc3qbQTNc/oIgqRe0vBsDE/rYSWhdTt9rGfpEbRBIZWlAvjuA==
X-Google-Smtp-Source: AGRyM1sUoVQm8N+YZYdzp7cpFoagdthkfsn6pDOUle8OmNsTPWiXR8CB5jhR7mJgRGTkxU/0KwjZ9L780eh+J+H5+VA=
X-Received: by 2002:a63:c006:0:b0:411:c33f:b4bb with SMTP id
 h6-20020a63c006000000b00411c33fb4bbmr8631858pgg.433.1657821849487; Thu, 14
 Jul 2022 11:04:09 -0700 (PDT)
MIME-Version: 1.0
Sender: mo933472@gmail.com
Received: by 2002:a05:7301:2519:b0:6a:d2b6:9d79 with HTTP; Thu, 14 Jul 2022
 11:04:09 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Thu, 14 Jul 2022 18:04:09 +0000
X-Google-Sender-Auth: B3BGFcFWfNEqyv-zWr5gN-Si1M0
Message-ID: <CAHbkfQzseSov1PbyHet-uCnGSDuAqD949MNJAN_xa+cOxQ1mjg@mail.gmail.com>
Subject: Hello
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

-- 
Hello. Dear,
how are you today
My name is Jessica Daniel
I will share pictures and more details about me as soon as i hear from you
Thanks???
