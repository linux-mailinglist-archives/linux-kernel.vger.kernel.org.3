Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9B04ED821
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiCaLGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiCaLGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:06:11 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6F433BE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:04:23 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y38so39000829ybi.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ok9uu0V531CazTOyjGJ2yJllUtTNzw42Zb2Eqtk4Uak=;
        b=S8+b8HMCy+ITEeRTqYwete2JXKKb3BsD7ync2GEWZmwVGWDUKdpzUg8kcC+7J44gFp
         odrnDZJz3mDki5/4yKOY2HMmMYvGDO6iO0Bh6QisbU/buz8PFTad5mfqcA61jVTfp98o
         RQIJ+Y0wHm8ScnFXIVd4TJKd7AEkbdytL4coWdzS0HcAQ1tsijgt+HTdVl1qbe8TpbSq
         xv6g5EgZIs8PpPMsrpYBiCcy3jIAbcNfd4vlbkCAzpV80gqHFLLa/g1UxGAr+FOZtwbs
         5siKvKfGfD5kjBXjzH3fyYe11Uxhmn+oX/mfN/PXqtdl7PhA/vxOQQMV/fa6CwzmIIy3
         qTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ok9uu0V531CazTOyjGJ2yJllUtTNzw42Zb2Eqtk4Uak=;
        b=F7lMYCn+Dy2H4y3Ohfhenue/UOVfYm/W6BcM92aJ5fyJz29u7F2jv2XVyDx3bw2ZBA
         y7NgroSG6gJIQ+0iCwRSqJQ+gjF0tRWPq767nc0PvxPspKr7omKfPTaQWdfcTmXFcH4l
         i8PXflq/5nbN1Wk9PzABfvoh/rJLjqAQt8u/sCVVmhIbF+kiRpFXIxvSjCXKnDYibp05
         krQO2NlcOvD7Rdk4V6w4kPGjtkmew1OZ2trqmgmH1t555zu5H+91Sy6AtXPYnx1ViWLp
         16FSYkf7pt7j7Mumyz6oBuJx+Oi/xUDO1dsjVGVZYLybhEsdw1Fp8rsbdMiWVMZQe5cV
         v8ww==
X-Gm-Message-State: AOAM532R9NjUKmFHNEgEK1lmbKrn4CYYTXKDBMLVdF+0mhcj22lcM+xN
        qY6QuO9GMsPgHXPJmb0Go2+LPK31jactW01XmYY=
X-Google-Smtp-Source: ABdhPJzGdeZz49ZSoPx5S1QgW558hMXi9s9WXiRx9f5MTZHON1mcB6V3oELZcnBJ/ZUKpCGv17joNAmvEER8h6yl7aY=
X-Received: by 2002:a5b:4ce:0:b0:633:d3e3:1f5c with SMTP id
 u14-20020a5b04ce000000b00633d3e31f5cmr3816811ybp.256.1648724662840; Thu, 31
 Mar 2022 04:04:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:3746:0:0:0:0 with HTTP; Thu, 31 Mar 2022 04:04:22
 -0700 (PDT)
From:   Amadeo Giannini <138287270o8@gmail.com>
Date:   Thu, 31 Mar 2022 12:04:22 +0100
Message-ID: <CAHNBraQKr7xiogDV4bZgaAa6GE_hjR6pOb4yUOP-=P8E9Gc38A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Needing a loan help, how much & time you can pay it back??? Amadeo Giannini.
