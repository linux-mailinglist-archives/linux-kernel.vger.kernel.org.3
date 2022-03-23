Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF5D4E5834
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbiCWSPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiCWSPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:15:23 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB741FCD0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:13:54 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id o64so2461820oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Z0szFu8s6DGJqIhZ3dTeWXKtueRzB4LGmWYNg4eDNjk=;
        b=Pw96VHpBN9pckY8/ViT73bu6A9KdI9dwSgnZdCsVpxbhOtv7XLL4QbTvklvDKOxTjK
         7my/VdO0bTICcqavQ1+i+1VcmcqtzHPcZY+/4jQnW9/Z25XKuaumAwIdCIX6beFVNfyt
         M6qjON84RPkCePJiBkjTPWXn4nHQ3vgSilqrf00QE62hN9H4FMZtS4Lcyr7p0uK9BB0b
         e0kjVo5yWp0IE1BzTIGD8UQfg7gg0vdtV6h3ZFVHcZ5Wa8juuY9Dy2LCL44HQXLI0Ftm
         RhU1c+9kbPYJhXt+762FoVRb33PWMEq3XEWoVcM2pZdqOpKhSbv/K/2/OjqbS0igGqMi
         I43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Z0szFu8s6DGJqIhZ3dTeWXKtueRzB4LGmWYNg4eDNjk=;
        b=ajBZU1Iorw5/H6NgXNbFwYPFInh2JpkB1GEf1tTcPV8UewvYI+l+NZB3xftSdwmeTC
         /XCphCKpN8qkvC+3mETYprOqw6BhZubawWAr8a08Gxw7oh8ESR2/g3rq/mR2H3YoOKe9
         cyCXknsMtu5kzc6W8g/eFjQPEUGyUv0t2ml/Wrw92q5wcsbDZix2/X7Kn+nU3S+JVng1
         SqUkdHRuye9npcOjWP0tlk2pwyBrXO6QGeudnT//ivY6M2sulcg/F2hhXR47CTo1aT+o
         /rEAHdjF6J8JnteogE56Qwp2EqEalECD3slZA8KxMlU95pVxXyDYQkwh/lPDJpuhkXwz
         +aYQ==
X-Gm-Message-State: AOAM531/ovtF472JQf3KGo5qxvc2Pa8QSBPJefn7xeisA84CG4X4a1Yi
        u/7KBZxsVdNtloe7PnlUTG+94gd/QBP8fAwoifI=
X-Google-Smtp-Source: ABdhPJzho8H8RBEbi1B5vrFaBQPjWAWT/CXf8x24UbfulkQwgmk7CoHAJCEb9EmVdwWcZudNTHfmm847Lt7UAHK4m1o=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr5114060oic.200.1648059233441; Wed, 23
 Mar 2022 11:13:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:f1c5:0:0:0:0 with HTTP; Wed, 23 Mar 2022 11:13:53
 -0700 (PDT)
Reply-To: pm2956161@gmail.com
From:   philip moore <contact.donkalidon@gmail.com>
Date:   Wed, 23 Mar 2022 11:13:53 -0700
Message-ID: <CAGXj=C6XPnNvtdHCvwX15_M9++B_awmBTU9PBggOQUi_QN2pEg@mail.gmail.com>
Subject: Urgent
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


Hope you are safe?



Please did you got my previous message.


kindly let me know.


Thanks
