Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A3537977
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiE3KyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiE3KyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:54:16 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B853E14
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:54:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id w23so407947ljd.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=c/g2MpcTZ4CRm2xH+v4fJ8dsUTvfUxlOuuKB1Pn62DDb4J2SQarmMMdAucbruT9YGV
         /yfQXNaS3FoJndsU+UVGvUvFGH21LYljWyZh+b+iE/HBrz2VGvcqGvgx0Thu0EqokTPO
         ubfiHwJeRii4Xoo4rHvRYayROJbmT4FVkS6+bSRmHTfZkxDxSt03JUJmvhV554RsadQo
         EhahvfP6vxJCAuyhw29MnXoalfdSjo9gBOuI5di9eem5R3uZEiAgO2xzGB2vZseQYLoa
         C37DLKyk/CN1OCiQkj/hsiFN5XhCo0ip1zsE8wU1Zjqm4Njsn2T2KsdzmRaINVJs/yYS
         Hvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=OY0dEIeW5xOl+5EPrFx2/FHsNGnD+E5Au1HiZ11c+c3pniCW2YZGX4B7+EnA6qsnFR
         tvzdMSNhaZu+7zZoYN6Nsr82addiBmiRUsz+am0VmKzdEicy/yszGPiqYyDeFbHbtiWp
         NAwxuvrC0ilNt7w9aA4SPggYX+kJsZMCFTOZZXp1Eibu7GJ6w34J7R1qSOuc9w51Jv6H
         a5ZVYXrOBYB6NV63hghYZww7vrlg7hvuFeoUFMPAA8JvHoOKxnRsDkvzENPePyfhvgwx
         G7hzs1/FRND+6kr2Hfyo9MsAYiENWPzNOsmCBEriz1Zr64Uynhw84EHZoukE6hldBseh
         csMQ==
X-Gm-Message-State: AOAM533/Q8uSjHD8KOjLvWSakSpJiWSGJInY/DyfTxs+lFtuhNg0khAm
        s+I4CCP4CCrSut/5vqY4Odzoj3Jsco1QK5+wxX8=
X-Google-Smtp-Source: ABdhPJybPuE/EzNh5VVGsS5on143U9snpcZzjeCNXO78Lq4EZARJmmowD0eamttgC8dB0NUjg/HvBey8UNb3Kbe01hM=
X-Received: by 2002:a05:651c:4cb:b0:254:f9d:4e69 with SMTP id
 e11-20020a05651c04cb00b002540f9d4e69mr14727341lji.194.1653908054371; Mon, 30
 May 2022 03:54:14 -0700 (PDT)
MIME-Version: 1.0
Sender: bellahakou0@gmail.com
Received: by 2002:a05:6520:28cd:b0:1d0:8b1f:5dc0 with HTTP; Mon, 30 May 2022
 03:54:13 -0700 (PDT)
From:   Kayla Manthey <sgtkaylam28@gmail.com>
Date:   Mon, 30 May 2022 04:54:13 -0600
X-Google-Sender-Auth: PEA_8DqIEQy4ueXR8aWxy6uZPnA
Message-ID: <CAGbYsZs7xs2B8fp8W3bHdWMhGOYyN_Q_BEpa1GOsSbn1_=oFeQ@mail.gmail.com>
Subject: 
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
Greetings,
Please did you receive my previous message? Write me back
