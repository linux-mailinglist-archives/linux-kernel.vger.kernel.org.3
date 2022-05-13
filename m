Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3483B525FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379318AbiEMKPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344771AbiEMKPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:15:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5B8284938
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:15:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f2so3761979wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=BCIQd+Nvv3xVMFfMfNqHYk5j+GFIS94051tgo6glueg=;
        b=DcvXCC1IruS/thP2YGVTyuVrn+bUpineAT+SjckrpAwsT3WpmcSO2qRAySZa2Vh3Sa
         4caxkK8uBuYhufDIiVbCg1F0CS9PoI2IttAGMS7clK/EI/2td7Qe5alpKuoVEZn6RKh7
         MiQ837vE47Dt8plyD8K/2QFRFamM7VpzYBmLe0lMSaeCqEaaFx8vlL8IwRvDvBSbT2KF
         nta+vZDJF90YgKBaNpHZPkWqkRAms8+VtC5Z10514PN+RlTZPnFU0GQXKO9aMRrBVYg8
         qUrBe/4TqjMByV6IWUnNtefvJo4aG1Dx1uF/UeLONS6+3fhLQkQGgCJ3AqYYpolT2AKo
         k+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=BCIQd+Nvv3xVMFfMfNqHYk5j+GFIS94051tgo6glueg=;
        b=gLn5OM6DgBnG7M+xs6Xbq3d11GFnaQVT2RwxEX0Colv6fs2dtlRt0OiGVJoi0P9ypv
         tYBGRdJhIvbrv/M9el0UGZtWAJMgU2zmQnq2fNlj/lYjFpq3GGVQx9u4osR9AvyDLZ+o
         +tp4mAb6r4G8rKRh41l9uoU7VnwvylyrMJ8DoY03EzUe0utNpqGv0TX/NFwg11Hxt9sJ
         cDyj4QEseeT63o+OZwsgXvDAqXaCOcoUVTKvSGAc318AFCNhARDlwLjPe0BZPrXt0O6E
         W9PxQe6VROuAfkH3wToKwa4Gl47ppXtMN6tXRFlcId3uoUW0UuZFElkC7V1iT6q53zuZ
         UjYA==
X-Gm-Message-State: AOAM532dptM8m08y+VyvjPFcYier4p2vZfcrbRCURAhErqbeRMsJ07oG
        5eMc4eSQHDteFOHOYs5mDY14EaYdwZOd0I5ykFw=
X-Google-Smtp-Source: ABdhPJwOj52rKR+SnGSCk5zrakaTEuCph0Vlh9mCPeniuBCEg8LbPAc6/T407ZIJXx81DrLAPZXxwGPcEYKoqBpnfuU=
X-Received: by 2002:adf:fb05:0:b0:20a:e113:8f3f with SMTP id
 c5-20020adffb05000000b0020ae1138f3fmr3342797wrr.534.1652436917502; Fri, 13
 May 2022 03:15:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:d1cf:0:0:0:0:0 with HTTP; Fri, 13 May 2022 03:15:16
 -0700 (PDT)
Reply-To: kellnersamuel5111@gmail.com
From:   Kellner Samuel <maruscapitalmoney679@gmail.com>
Date:   Fri, 13 May 2022 11:15:16 +0100
Message-ID: <CAAyiObXY2Ob5NiLFZYuLTq+MA777aT2VvxxfSksAwvx9GT0c1g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5878]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [maruscapitalmoney679[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [maruscapitalmoney679[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kellnersamuel5111[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Good day! I am aware that the Internet has become very unsafe, but
considering the situation I have no option than to seek for foreign
partnership through this medium. I will not disclose my Identity until
I am fully convinced you are the right person for this business deal.
I have access to very vital information that can be used to move a
huge amount of money to a secured account outside United Kingdom. Full
details/modalities will be disclosed on your expression of Interest to
partner with me. I am open for negotiation importantly the funds to be
transferred have nothing to do with drugs, terrorism or Money
laundering. Thanks for your anticipated corporation.
Regards,
