Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F01598395
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbiHRND3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244927AbiHRNDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:03:04 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439B275FF3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:03:03 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id d126so1363170vsd.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=VhbT+I+m/j1zIBMdGQ5YCdD5f5II+ZRqGX/fHpao/tc=;
        b=GdStEbTW5X0c4MG1UpyabRABqrGRhMc1lWDnouejHCzvWCwdHwH5Xn5rsYt7X3BNzt
         +UfLukYZ4cfkXzzf5qeb9uRV6SqUsFF2cgysp6W1y/gzNDjv5rhfCLwtzhxqaSGEdO92
         KezhFK6GFSw5ZeH0qC4WsHk/jXR3aJE/QgsSP59dULo94fMmgMWlHNtiJnLf44CahjDG
         2C9SC9r7nfAS3gW7V4XMLf+byQ8H/P99ob9Y93COc3W94KDmPFXi1jk1wTy43vQ0F5wJ
         JVVHspB9C1ohHyebI0OrlFOQ0HthcyI44FDPEAwmFBEU5NXBlJGWPnhDziQUwy4aurdy
         FwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=VhbT+I+m/j1zIBMdGQ5YCdD5f5II+ZRqGX/fHpao/tc=;
        b=v2Q6SK4nkMUGs1nKM0sCtDzm/i/jIPB8CnAVZ4p0+07XiEEkQ9k9LANbxC5b3rGruM
         1P5bJ605htyHRjYvwobOyg8K9OsEDpMtrcJlOl6hWCSswVvqg+VL/bMSdQy5FyJ6suhg
         I3GGUJkhunrvt4IUp7PnKlkhr1I2XXhth+yFO6QLIXmY5IwxKWyyoQZM1v9Lks8VYccG
         H9ReBG/0WT4OUD9mSPkQDwnsgPkvGp7L6EtkfvwNEnAlmjY3pHXjez7KdQg/fYTyEJVT
         GTz52PlOmbtBJBzfQZZJgKkbBrLbX4noUs6bymPkJSHpJMHn5bdZU27bKPhvhj5AI9N8
         NccA==
X-Gm-Message-State: ACgBeo1Fm/jgeAoAhHYSGYBc/Cps9ZELI3Y41x8OT3T4vD6r8reGBUJo
        lPY5L5GYwHICHN05CLoihmtCa6vh1PNlbo6AF/k=
X-Google-Smtp-Source: AA6agR4b35hTQqXDYzvzyNvZ+UpUQgu5SWIsGsObqzuiC8ehTFuB9a3UvOoPfrsTYSbmvAZ+1mSdc2Fmzh8K9EeSLp4=
X-Received: by 2002:a67:e1c8:0:b0:385:e7f8:35dd with SMTP id
 p8-20020a67e1c8000000b00385e7f835ddmr1094717vsl.19.1660827781638; Thu, 18 Aug
 2022 06:03:01 -0700 (PDT)
MIME-Version: 1.0
Sender: 2fatimaahmed@gmail.com
Received: by 2002:a59:cb2c:0:b0:2de:9c38:6de8 with HTTP; Thu, 18 Aug 2022
 06:03:00 -0700 (PDT)
From:   Elena Tudorie <elenatudorie987@gmail.com>
Date:   Thu, 18 Aug 2022 06:03:00 -0700
X-Google-Sender-Auth: WKN4KLL0gD45wPcs2mZqXe2f8S0
Message-ID: <CAH=VxSM96NdQNvkkm975jWp3nRs75n0riJ+doKs1oahFxP7raw@mail.gmail.com>
Subject: Hello.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I Wish to seek your conscience about something urgently, Please reply
this message, once you get it.
Yours sister,
Mrs.Elena Tudorie
Email: tudorie_elena@outlook.com
