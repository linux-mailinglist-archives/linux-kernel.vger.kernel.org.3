Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3392B55442E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352439AbiFVHPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352424AbiFVHP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:15:27 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6897B36E16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:15:27 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id d12-20020a4aeb8c000000b004214e709b72so2145819ooj.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=0imvHQCskduM2m6Jx13DhDeQy2lidkiegSkYCHGTbHA=;
        b=eIJwkxEhH4C/FubWibl4laKFclnMx8jo7kVWyWjWhINfRLEUmqQToG7tWEJDz4R9Qd
         yG70BewfOd5UaGph6RW5BpqIqHfebtuN0W0W30V9d9+CrrYRq80ySln4xgcBl/fjP82g
         7hNe3E+cbXiOJrs4YGE8Agt2qipqRzaa8jF1T1gAOs4oCp2JxBIqPEsE71XhcbFIketC
         AmulP/u/EyN/hjCYMHvlrRawKkygtROhHxmX4ZFS1BS8w453inf7nZfibUqTBS+7iprD
         VO0Iz/dkBnWIEhBAapDVxrtuU18QkT/Gc2fCmfS0I41a+UV5I5x7gp3wmvZZYOJts1Xa
         dNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=0imvHQCskduM2m6Jx13DhDeQy2lidkiegSkYCHGTbHA=;
        b=qBmdU89DCfnCfM+1PiTIK9H8M4CVsZMiRk/yNvP/Ad1sVFv4RQOiG/cFylTwwlP5B7
         4FZ2NBrYC86FnSuiIT/iemAupFFKzBs4DamckcPZiHHoRmfE2aAHfhnuwAQPVARyvc8D
         DoW+na3Kbh7cnbMiZ/tQA56xdj97FS56DFCTdO6A+l4EyWaJgiyq1gVGbUdUpskfeNHG
         M3AfPH8WvHmGoujrSB7WBrn8FLGyVCuEQb/mpg5xks8e+1x7QmgOJysGV3OHg2MGAIov
         Vj432tG+yT8veeTB3dkhWp+zhhXL5YGI6nhx1mCTZ/miLsLhjTtRuvxHGa6thRnJH4eQ
         Hd9w==
X-Gm-Message-State: AJIora+KhFUFYFPE6HrKS8D45BdmOC7s+i8CAQebGkJClGNGUQkgndOL
        w8mHFE8Ax0jn8nI+RvkDRwADVYLPwemF/zpd6TU=
X-Google-Smtp-Source: AGRyM1u/iivms+tthm8+xrWydwUJJX6BRm7pwFzeOqUiVRUsRNP1IidwSuDXB2MkIoPa4B4zOjjA86x94FzXnRArRN8=
X-Received: by 2002:a05:6820:169f:b0:41b:dba1:4f5f with SMTP id
 bc31-20020a056820169f00b0041bdba14f5fmr781504oob.69.1655882126047; Wed, 22
 Jun 2022 00:15:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:99a4:b0:a2:f157:f61d with HTTP; Wed, 22 Jun 2022
 00:15:25 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <tw44015@gmail.com>
Date:   Tue, 21 Jun 2022 23:15:25 -0800
Message-ID: <CABtpmn1QX9zHHiQROqnXSCnFbKG4aTmD37XorHKPAp-5EkssbQ@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Hello Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality
(dual) living in the U.S and sometimes in France for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
