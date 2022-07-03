Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A385649A5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 21:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiGCTyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 15:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:54:24 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788DD194
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 12:54:23 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id d12-20020a4aeb8c000000b004214e709b72so1523720ooj.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 12:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=yaAH0g1iegHwxNu2nPfuEqNmqOnCr/4aJROLcY5axoM=;
        b=GhUxPG/dHNr2dEd+KOgIK67b7BfNRLO0rrurCp6KmfvH8kKhwBX2DrGveYX2WwcTAJ
         7ZhsdMC8DC0ho1fE5F9ceVjg9kyObejHuk16WfTigDZ6ymaBqHHShMpJ/1WQNlrT0Y7B
         j/LAHCascTyauQT471BMpm1wVWbLYU1XYjEDpeBC4M5AcgOv/Wp+QlSqXTdnDIXUf9u+
         32tAkGFobbr2Ipbn1fTx4rE/sVizI3J94oiTWR5//dPn8FKU15Rgp699RXdG7btABfzu
         +buK3wYFk9ELLLZEs9a4KeGOvC2/etP3lfS6MkLyTGKa2cIs/vGV18qbsq093AccuCzc
         XAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=yaAH0g1iegHwxNu2nPfuEqNmqOnCr/4aJROLcY5axoM=;
        b=XEDh1JLDCcgeSBYPpFSVZqvcf7UkqbdO3buVKNkNEm9ThjsGVJ8mjCOEMSTRkSLZAB
         spLx94ghG5XaywobA4v1pynbpM9tKDYHnjAi1eRyhUMyCl8BsGth4/PBYd/u8Z72yrh2
         wSglGQFF5P6syZ7+ib0754s/THTtcVcaKHJvcanBx3XwSZ00izHWle3ij6eMN3g/mkHu
         TwY4nYC7CpenjCl0U/YqQWQMUWxSzBzDQnNXyWlVC4CTsBiqUEt65k8TaUhr5yya3UuD
         vmBi7+rS0kgBu9Akk4HbUl0M77hwD4xkq1XOYErxHw11Vc0hSEeSDe2hGeGDEYomPKdI
         ekEA==
X-Gm-Message-State: AJIora+6UaNtRuiJ3yVGtlrC5EJmKjo2PyGYipsHsPJwjoXkEd5bnGAn
        4ORHwCZtkIKKOuFTDstFNzePz45Q/tMiBqzfh8Y=
X-Google-Smtp-Source: AGRyM1ukgV5xOg4vJZT5Ms86qQW3TOF5ZhUIW3dmSC5q2jwvxiEhj8wyvTvSaMMWJ8D8gOWf+UYEQNbQzEqznKScNlc=
X-Received: by 2002:a4a:81c1:0:b0:425:b01b:f757 with SMTP id
 s1-20020a4a81c1000000b00425b01bf757mr10527155oog.1.1656878062891; Sun, 03 Jul
 2022 12:54:22 -0700 (PDT)
MIME-Version: 1.0
Sender: ginnahassan1@gmail.com
Received: by 2002:a05:6358:291c:b0:ad:b8eb:23bf with HTTP; Sun, 3 Jul 2022
 12:54:22 -0700 (PDT)
From:   Maya Williamson <mayawillmson@gmail.com>
Date:   Sun, 3 Jul 2022 19:54:22 +0000
X-Google-Sender-Auth: c_ZBy1j2sa4pIizIo3XB880zscU
Message-ID: <CAAeL3JfNYbXozjaEgbOg6=NMhqfEWaXH7s2gENqWnhyAcn-x7Q@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
I'd like to talk to you

Maya
