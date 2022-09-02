Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE25AB3D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiIBOkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiIBOit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:38:49 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6DA1583D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:59:18 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id s3-20020a17090a5d0300b001fb3ac54a03so1084638pji.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=oN5uSrVstmrmpjZNjpC0MkyDD5rjW/MPwKNf9i5pnNc=;
        b=o+Lsa+2foF5sCCgfrc7ezOOg1N50QrhT6WR0lKZS9r+zxfU/D9FKMVuxEAEXxEHUkX
         4023LM4orS+Xa6f0wcOXSpNRjc9RF5Z1aA99E5sLPYAlDlL4ZWTENpnQLxLJYD96Sgii
         GMakGniU5YUfOGTTc9o2Alam/Ni9ZdjP330b7KPOL/vX5FFjxu3kopt0hAgo3o6QNjzA
         yqpx1XnMXGvJotFbkxsZljt4moyhknjjCPcLjs8P3pwvvlrA2xJ9Y/yAMxYH2vtUFk4Q
         r1DwI+/lqaZjN5nRXgdegS+0uqD+/iJG8FBSvLybqDyWYUfPrSd7NBDMvmpUQEf420KA
         km1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=oN5uSrVstmrmpjZNjpC0MkyDD5rjW/MPwKNf9i5pnNc=;
        b=HimLXc9Alpx+R8yP38DuqQBcAEkY/yYomWSjKu59rYUO5HweJ1J6r1yUa6zDtUssjK
         KvflPJrnmsmjzgQdQ7yW3gVzNJGjHQdmVlfI9HHWQv8fC8eIot09TWd1TWAwoscOlivG
         vFz39vY4UaaUWF320DyAluIgx2hYCzKdcNmslPFcw81bsY9uoXCpW27J0tRIaJwwTh0q
         dCQdzGxPiwsErDC+hrOxJHtzdRV7YZFqfptUhvY6GNAKSX8tTgvsV7V09pTQKM0j/reD
         HnMbrFfr1kROTFGrqSVl+K0TLhxgBtFRI7p6ZF9i75BoxF6dVww/kKz3Jx7PMUCUo3U7
         tLWw==
X-Gm-Message-State: ACgBeo0BOxg6fC8H6CVJmnZ+b+dCJy45gMlZuJ6RBxq6fKsts9TtJNNv
        uTluh6NhF+zCFHwXBfxh3TKuxCMSnWAfIFHaLw==
X-Google-Smtp-Source: AA6agR54EWg2sgqmKFoaPLZA7WYfFsWIYBZkRNebscj7qllbI0jp4jyOkQdEH2hM+LuA89xIf+dP/XSfCqclvkGGPA==
X-Received: from varshat.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:a35])
 (user=teratipally job=sendgmr) by 2002:a05:6a00:2db:b0:537:f78b:222e with
 SMTP id b27-20020a056a0002db00b00537f78b222emr30233530pft.35.1662127158481;
 Fri, 02 Sep 2022 06:59:18 -0700 (PDT)
Date:   Fri,  2 Sep 2022 13:59:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220902135912.816188-1-teratipally@google.com>
Subject: Request to cherry-pick 20401d1058f3f841f35a594ac2fc1293710e55b9 to
 v5.10 and v5.4
From:   Varsha Teratipally <teratipally@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Rafael Aquini <aquini@redhat.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Commit 20401d1058f3f841f35a594ac2fc1293710e55b9("ipc: replace costly
bailout check in sysvipc_find_ipc()" fixes a high cve and optimizes the
costly loop by adding a checkpoint, which I think might be a good
candidate for the stable branches

Let me know what you think


