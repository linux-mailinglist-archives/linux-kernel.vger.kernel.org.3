Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E5258CF20
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbiHHUaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiHHUaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:30:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3FB11E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:30:11 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u9so11602603oiv.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=KfAkGt8QGue719phHTzXNPa3CHT5k/PJCdLxXTi9oCl04Kv+uC0Cztnc4vVZ3FNUC1
         lhu7Gk1UO6mz4PRqF3TKHL2sHMIWaIAEo59ASBGGEjRHdcl1NEctxSSVBFD80rbx2D2g
         oTtR3I+1fM7RdNTLmxh+u/P64mw2IY86q2asWSgbAUparhQPWsCDiv875QNsWrNNdLxU
         WeUAbiW6Pf/0vZTOuCVcX6uOQGTdIsdX+IfBku1mGUom5jCB8Oi3w4CVGgkgCIYyLm+T
         2fSsNHJ9ME6ShMvgJd3aJ/OnS5SjQ35fZtnBGPT/MsigYdgRxBOWNYCInZ3G/TKMFMKO
         YKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Suu4k6bwai2RqxuSlqn+zfUErw+Rsuo/YMFnE31HmFzy4rBZiz09HcV8viXSVzEPJf
         ynAls0fwLzTodzBZOI9r6p7B3yNAleJCNd9QBZ5p4F9kE7HL6VVTQ6fAPuZvQy5YAMpT
         +obx3q3KsFQ9CqGP8irp1Ht8np/FxY7dpmCBqrS0YFvplovoLUn4nQJGAYOc4xhQrnEh
         e55PlNRJElsMFvFGjah9FNCyGCeJS1mHuxf74L57sa+M5a8CiriM/qrCBkhiK2Z7EBNO
         VfQ0I3EA4vcdhJlB8CphVFWxbE8uu4t2AmU7qRrQbl+cy+eOybp4RgrXmzAO7/KW14XO
         mSkg==
X-Gm-Message-State: ACgBeo28nUsLok+c2hrntGX5oL8PVWFZrPSq8n0opfdx15h5B6Jt0sqm
        MAbYIZaqSM/jgfs9nmE+N2XCHdM0l8jeaIPQmYY=
X-Google-Smtp-Source: AA6agR5N//ATQQRH5YPETg7k3MJ7tAEu+W9KWfbu90vD8nTslupN2rCISx7dmdgRdkl6BLzbYqOTjDyP7+B75G5eE7s=
X-Received: by 2002:a05:6808:20a5:b0:33a:806b:8a42 with SMTP id
 s37-20020a05680820a500b0033a806b8a42mr11956645oiw.271.1659990610866; Mon, 08
 Aug 2022 13:30:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6954:0:0:0:0:0 with HTTP; Mon, 8 Aug 2022 13:30:10 -0700 (PDT)
Reply-To: demirkol.m.sadik@gmail.com
From:   "Demirkol M. Sadik " <demirkol.n.co.chambers@gmail.com>
Date:   Mon, 8 Aug 2022 21:30:10 +0100
Message-ID: <CANvkXmHEoeKKgmTutxXEbF8asxBVEbX_fLXvOAmRhr+z+_mHJA@mail.gmail.com>
Subject: Hello. Please acknowledge receipt of my previous email to you and get
 back to me. Thank you.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


