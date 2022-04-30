Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925235160AC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 23:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbiD3VzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 17:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245553AbiD3VzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 17:55:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E58D3631B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 14:51:58 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 17so14402252lji.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=CtPJH3jqVVBjFVDIks2nPQF+6tDodj36jgdumuqDys8=;
        b=bL4tRJmpee4jlvVsg26RNfezLyh1KdjVBNyhZp/Y5xOP7+6FMnm1l8RLTCFOD64nzB
         vIGVKGiqmYGHJJNuMY6Aa7wyhwRz33KCNJEf8KmVkm1MzwIJ95drMXnwEz1DxUx5lMq4
         KkgKWT6XHrBPi+c78Pg1IUAu73SImYkO67hrAuX0qGDYkZpATfYeyEPdPZZPZK06jLnS
         gYh4jvzJ/W/zBKDoal+o0ZmJQiS7pCgGJUliQwqNq9zCswF7BhQgzcgrL0dIpbA2cjIM
         ux4vATTDVyXYi58ib2vBEc84UCRiI0SpV1ds5j+ihQWNEb9oJqF8tDezzo/3H/AnmzCb
         48zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=CtPJH3jqVVBjFVDIks2nPQF+6tDodj36jgdumuqDys8=;
        b=FUIhRwcQLks/E7KwfeBPn2jM+R1aI0he4+q7WSgAqjp9MdCfprUSOCb7oDOo6W9l8w
         EjVuUQGh+7BAT3yHVPZejarycAqdpKldlbh6M45AH5PMgSqLSotgQkjanlv3FYORFcfO
         zQkc9zj8Vy826yGGRrz4Y3xrvNi5sM7HS9846lnmdgNKJm4uFzPWZEHKkMKF0uchPh3E
         mFZIvZrzZy0c2hohcUpcZJ94NoR3D5c+E7led+P2Dx4uP0CfOJJyeosN5v3QqXcxbaoF
         eUPQYm2hQA+mW/1rs0Td5VmnJ0C9XHCZo3GTSsVczPn5y6pAepPVItJVm0/QqZruxKvT
         O21Q==
X-Gm-Message-State: AOAM5315ywfQS5dBou6Ma7rj7O6VVtUMzbMFrr5wrHR1CU3mm8bDgL8I
        Q+AgqEdCY6GQ7+09MmWQ1VY9JB4ZRUiwHmq5XQw=
X-Google-Smtp-Source: ABdhPJywdAVrO3+WXYnJZfhru8KpjliGgUQUXTWiZDSzzBI/9KSN6LVEjYbW5BmlITYGzl1YJzGgLfsmnxLa4bMiUXw=
X-Received: by 2002:a05:651c:1783:b0:249:43a8:b6f9 with SMTP id
 bn3-20020a05651c178300b0024943a8b6f9mr3576896ljb.273.1651355516775; Sat, 30
 Apr 2022 14:51:56 -0700 (PDT)
MIME-Version: 1.0
Sender: innocentyakububawa@gmail.com
Received: by 2002:ab3:1be9:0:0:0:0:0 with HTTP; Sat, 30 Apr 2022 14:51:56
 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Sat, 30 Apr 2022 14:51:56 -0700
X-Google-Sender-Auth: 36pv_A2tC6dppI7tULB1ulYrKbc
Message-ID: <CAO=JbK0gYYpYGvFzfn9+vQBN8G81yK+AwQ9uitfnW+chj+eDQg@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over  2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Mrs. Margaret Christopher
