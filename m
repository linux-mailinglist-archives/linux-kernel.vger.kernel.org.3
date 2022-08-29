Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFECF5A4B53
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiH2MP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiH2MPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:15:32 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF9EA0279
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 04:59:25 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so5720396oti.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 04:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=6VzaTuMkSaoKWgUM6Q1+SMdSDfZtUEniQTBorD4F7ME=;
        b=OUx87rS8b+0e8paS9czdLj3OAKtW0lgsoc62KDXNlc0VHR5WDIwrrDreEiwQmdsSI7
         Bv4bWf7psCwskYaxPZJ/E4FiJRqaiedfvZ6yngqsvrr6Gpt4yEStXIGdsLM4ZbC/1f9O
         g5pLOVTdWukGGZrH37EFZFU6kLZdr06CGv4eA30/idMkycXOjM3RSbtlq//kCCtThHr9
         VNyNtpIowCyrlk1mTgxgGeq27vnBA1OGMwX++VS0y/BdpRPYCk77dCXgGHKO5E3lbAWo
         mw1lg2gVD0FSxcI+p3HxPiTasHNmdrkRuccSR3hBAEKUuRq23bTmYYQ0eghl0NiNx48p
         XuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=6VzaTuMkSaoKWgUM6Q1+SMdSDfZtUEniQTBorD4F7ME=;
        b=izhTWgrAT+JZsnekSvEdAnfTlL59jtBZq/84u46+XNFHQbmckT2nFnLjS2s5okdxDe
         7fcpzfI94znaEeJz94lwuE16xizlrWLDpxHG/2EeHgLqzCrAsIlk07rpFHE1xe4TnYXQ
         ZcHUtE1APIO7HLyuOfITiw6Z8lt2dXL8r2TWS2Kdokb+cMl3c1dCedKTJVv5uXpxmeS7
         LTy9j5s+MQzbd8Xvu1DmcaCzlir74R00brjUs0Ru8MNNjT/SEC1Mzfdw+/obxdNXOlqh
         bFw0RJPUH83UBcPRW/3rY/bpk602rDjJkEogdlaohQtHvSbLHGsK9XJEFEbTWmURrerz
         asSA==
X-Gm-Message-State: ACgBeo3mFGKeE2D3n8/KFgH/0pBvybLBfGx4PDhEnY5nrQ1LTKrVyK7e
        uaDk6x3TRh0U0yj3LLvHRa07qo20T6ayGCzC8AAoxfPeN6cl+/vv
X-Google-Smtp-Source: AA6agR7Sn7KtMqCTMVFnRKzwoF2knQo6Qk39TsyceCVynFYu5HQA9y75APzJdS0A1Bn1Q5+BoO1CD3t9Y0MD/tGqJbI=
X-Received: by 2002:a25:23d4:0:b0:695:65fb:bf66 with SMTP id
 j203-20020a2523d4000000b0069565fbbf66mr8148849ybj.3.1661773779310; Mon, 29
 Aug 2022 04:49:39 -0700 (PDT)
MIME-Version: 1.0
Sender: aishanafiukaura@gmail.com
Received: by 2002:a05:7108:6893:0:0:0:0 with HTTP; Mon, 29 Aug 2022 04:49:39
 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Mon, 29 Aug 2022 04:49:39 -0700
X-Google-Sender-Auth: HW61Yr9zkN-MW0FpP64TgTutiL4
Message-ID: <CABET1+h0MuPTkEkmXR6Vg4ARCwozApMKLUkDyhn0__VDCChWSA@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Margaret
