Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4154E4151
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbiCVOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiCVOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:31:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699868FA1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:30:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so2314102pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=aff3LzXcc/QXC3lSVBfHE050TlrC4LgP94Zk3yX+5nw=;
        b=O8hvHEoVr6axQhyyES2jeMuIpi7HHZRWLZa43Dej9j9jfaw7MsyvGMY7hv2Uyk07wy
         QgFkJ3nI/CGjzxpSlb0tjQD4tw/QYCzqwOg8yKq0o8eCYG0z05Qx06HHIE6sbaIywglG
         q0ppDhYaR2lJajGU5umwAEJqfY4RWj0XoFhjB1eRInJ6xzohUPbnJrKhoBkwC4ICog+a
         s7xJYM9Ep0eKkdMWEXkk+FQuc+uaZV7QQWqB+znenuhcAlxpGgFTPJdQ0GPp95cVma0o
         4G+jMbUKdpU5t31v9ApOI43E1Y+1js/GRLlSRjrf10QWvBuJ9dzsdzANS2sPVD1Deqp5
         jKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aff3LzXcc/QXC3lSVBfHE050TlrC4LgP94Zk3yX+5nw=;
        b=ZUvkDY+RxMcfCcUacqFAsDvdlenYvjdLEcKDgo1XdR4h6Jz0uHQJxzBY9JQgleGpM7
         5KQX/dR/gMiuNabg3vvDYpVwPtUi+jG+M3aREdTfaqrGc/dVz3qK6ZZHbG0bsUJxujXM
         7fTfbRi/vuMPX9dadNiarpWk0n94qiuWkvib5PhoktNt+6XfhiEH+Z7ZKoFcdwEAkSZ2
         xXqT2cyBzH94rCy1TzsTEVvzmZmxTn+7HJu4xx98poOT8/FaT39PFS3sWgQLYGSm0hfW
         1iKNP9hJ6c4VLlR9EzeCQps0yjIjfCtwjeTpoWelH9mJArRXDGNXGsSKZvlsPIKcA22c
         yA2Q==
X-Gm-Message-State: AOAM531wq/GFbMsMkYv5vBIIHwFsTOgKP+uGy/JNblaj7O3v4xU3uF3K
        PqgNi0s9LOfr8kjHYtLHirHN9KZH8OWMCfi+uBA=
X-Google-Smtp-Source: ABdhPJzSbZTcWET/TPxaSk6dQb65NIP7sM7Mf14LgwrJQM+RuPPYWGAKinVdO0UMwzGzgBB2q5JOMe4difBaqEPO50E=
X-Received: by 2002:a17:90b:1c83:b0:1b9:caa:8230 with SMTP id
 oo3-20020a17090b1c8300b001b90caa8230mr5432906pjb.26.1647959400744; Tue, 22
 Mar 2022 07:30:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4d04:0:0:0:0 with HTTP; Tue, 22 Mar 2022 07:30:00
 -0700 (PDT)
From:   raymond <tomsteveoo661@gmail.com>
Date:   Tue, 22 Mar 2022 07:30:00 -0700
Message-ID: <CAGiZt92FW2iti1s39=0hyX9xoBVT7=Se4mC6J_fTc7V7QnYs=A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Business Deal worth $47.1M USD for you.
