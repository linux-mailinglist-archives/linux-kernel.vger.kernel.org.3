Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA7508BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380137AbiDTPYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379944AbiDTPYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:24:12 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699045536
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:21:26 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p21so2185708ioj.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=XGUcPAyFYtUWMYO5tKtj4ZzzebuC3OQHKF+J/C0blWA=;
        b=hDA9+9WDhq3oTrBMc7XC5/79dUHLKCYnS6ngQ6mgcL98tfITd1M527u2YPl2DoUH3j
         rUeSYB/J1O2RXlWAONOWGzaWcRbTVdgnxvQX3ShBRTa2IO1jsx8OejhrkJg/XtfJgz1X
         /hCnDHDKxkoOQZRJ/vRTYlyuVph1Wb6INtF9xSuFo1zUUxqppgCHZToJyOm8+IA/rMtf
         /Y2AW7S8OgnxdPQ5IE4V8umfUgSjGCC1WBCttZhrrXLbPd1iYfWYc9Aqt1ePXD8UC1SD
         8iogedA8KOiW49vhdETltNJJhJqzIAlrSinx4pWU8S6rDzMCaYLbGHEYl4FB87VV9/0O
         s6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=XGUcPAyFYtUWMYO5tKtj4ZzzebuC3OQHKF+J/C0blWA=;
        b=Vbdf/wGawhNflCSqzNS6j1H4x1+O8wYvAOHNINb1Ulc/ZPV4T8wo/IvxCFOUNNtXo/
         6XMx+g8g66sqYcjRWWivwl30Yu+u1O4SJiENCSAClpBwJbYa1TvdEmu2LZN5zVNKBq+e
         gPoHx7Ar/QabWqSBqd6LsRsV/RFBfXsmGHh+IfPjEuxxfwVexmuSLYBqMpi8wECGQeqO
         Z9s4pik74JliRtdsDhC9xPuK+YzlQ86cyis7iZC9BbFtMha1ylCJ2wn0gUgBFE3GDoOc
         HfUOCVuCf0Cqx/RknSo1pnQAQQw2TM/c00Ks9XLA2a8YLUKw0VlDK73/cpQS9Dv0/fkL
         RWEg==
X-Gm-Message-State: AOAM533He0PIaOfCwIdI+0NrszeJHALZ8rNXA0MdUtPKsDINI8oufMOV
        wUbUgcIh5M59cdqlFZ3RvsFiQT/bx+ApAXA0bWo=
X-Google-Smtp-Source: ABdhPJx8pcKSRDZ2vFIDPCQ6r1mB5g5K+SrZHoZ4xK8oJr4DhednMjzjKkYoKWEKJkD2U71L3Z+RTUERLXGlhu0XcdY=
X-Received: by 2002:a05:6602:1683:b0:64f:ba36:d3cf with SMTP id
 s3-20020a056602168300b0064fba36d3cfmr9054810iow.144.1650468085899; Wed, 20
 Apr 2022 08:21:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3490:0:0:0:0 with HTTP; Wed, 20 Apr 2022 08:21:25
 -0700 (PDT)
Reply-To: isabeljffrsn@gmail.com
From:   Isabel Jefferson <dembadioh@gmail.com>
Date:   Wed, 20 Apr 2022 17:21:25 +0200
Message-ID: <CALvF5q4+=HZYyrt-3CST8mo_i5Uncok-jnNrXZXifT0CGOq_vw@mail.gmail.com>
Subject: HELLO.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        HK_RANDOM_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4426]
        *  1.0 HK_RANDOM_REPLYTO Reply-To username looks random
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dembadioh[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
How are you today? I hope everything is alright?
