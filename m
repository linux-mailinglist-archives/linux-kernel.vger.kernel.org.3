Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD29535944
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245200AbiE0GZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiE0GZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:25:13 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA63424BEB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:25:12 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d198so3708415iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=33H7bzlF73boyoKARvolMJlGymprQ+hHPrvlaQBxLsY=;
        b=gBB/cwiGfmHtke5+MVOg1U2wNWTEr120LVQWK908/OVHr82Ivoq7Un0O2mD3i6fHG6
         OThBqoy58hxFvilear3j/8YpPiFgIwr7tS/3KTeoverlG/LeQgwhL0Kn3HQRKWfaw1lA
         koqCWfHlLrIMDArNXeq7xC7YU67zXwUHiaeMwRRU9R0k72+LrMpRoasCvZL2CsC+qqfm
         jK3L+mfY9L0ohvfGZ1SV4+uxJ1Lr2ItAafFfZP98LBKdqEyVJ1KSvjDBqr3Pg8UK+75p
         vpdeVhnaRT3FfhQBH13FUh+ppuPA+VKMIMeMy4whpYxjLkLs/mshrzwW7oEzFoqJxV5h
         5dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=33H7bzlF73boyoKARvolMJlGymprQ+hHPrvlaQBxLsY=;
        b=GheQmsgc3R1GMZqZWTnMIA9/Foy+z51ycQpCeGvsodmJyStihks0mUAte+fDreuMSI
         KhujE7kU+yPm5UdFwCn70YLU0UxgzdNRXmzBbWfM0VsAHS+AUiGsG3c/lQzbUGPtvzod
         ZJJj/O8yaSTABpoLfkMBC3Pw3tYNTqJPPE4jZAVUhyAwVTvWz1NGruHMO31YjU/GFMTt
         MNY72Qi9GQxQbblVhZ9X6BFRpebCNkyNUhWkKwIaFG4SeqmBsLWlSldb9mD5YDLid/8T
         lYZmqupJ1gsweyZY/2AnDq15nKW6pFfkwim5INC2pvVjDXKglQ8h8AFrQgz6fFqQzjd5
         3WTA==
X-Gm-Message-State: AOAM532oxJbyd3UJvvHd3v1v2Y/C+VcQKHo7F4VTUz5BYIT2Ur7rLPs6
        aSUSh8PSRE/6BUnkzrjruB7XdHenU09yqgdZCEY=
X-Google-Smtp-Source: ABdhPJyuSHQEY2A3k4hHTnJvScNnCsm2HeGVpawtkPs2YKwiTHyvgOhOCllSaVK2jiAKtmi8tOuzQsZIg0156fnaTJ0=
X-Received: by 2002:a02:ba05:0:b0:330:f166:d90a with SMTP id
 z5-20020a02ba05000000b00330f166d90amr1303825jan.213.1653632712131; Thu, 26
 May 2022 23:25:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:388b:b0:32e:cca7:1993 with HTTP; Thu, 26 May 2022
 23:25:11 -0700 (PDT)
Reply-To: IREnnewilliams@gmail.com
From:   Irene Williams <lori.robinsonnj@gmail.com>
Date:   Fri, 27 May 2022 06:25:11 +0000
Message-ID: <CAD13ymaBeqKXgvfD_u2UWxZXj13uKaxNUKV4O4o+7kCc4JFEuw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I wrote to you this morning because I have something to tell you, please
let me know if you read my previous post today.
