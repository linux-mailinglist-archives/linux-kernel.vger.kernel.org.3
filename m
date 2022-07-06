Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0D569175
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiGFSMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiGFSM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:12:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998AC2980A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:12:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso11213779pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=mN3P8hPLWEZdYq/Iq2iVxFahPajjklJmxF0PKn78//uClSCt4VG2U88hiC+11v16xh
         y1SqfQca+JNBVAZI3ePM63ZbF/Ll2WyFBxkuWhi0DbjFZD7bQcGvjfRIWz9nOeUbfrNN
         Hn12zBv/BHEjrzhK9FyYZgJ+0yDe9gXNRwyhqCay9zO0NttAB/+uaRHDNofm5fJJ4uyL
         UE2EskqpdPqCBWA33nmN+zOjdnlOoGQz4kYyfy27QOsJGqWsEfVgJUCLFJ7tUYFz1it3
         polGmHqOxVGn/C/jOAMwwxKSSJA7dpPm8rxHhFZfT3QwVHikUfVhjEQAyBYj6En6JhiK
         ztug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=i0GIbfAjjZweAVNIyKpHSx1ouqngAlzQpc5yvTqNtxF3eOkEHEhMNY1bj0tEubc0QI
         F5gBJoRWy51Uocl+PGZxAPzKB8QGCyZZ2/2JxSpQnI4um/dSZlXiuy3JA892dXf8iZex
         i06urbCICPYCpsLfa0vMAxZ5GsMKGlsKaz9b2WkLgBMj13O58Xrl+VN6px4bSVMatSa4
         ewNFZqHhlbQQJLuO+4UZg3N8Fd8l1/Gd/TATTS6knNlTg2590XSShwoEHE5KrzeFJctR
         FS3ZEXLwOJFS5RbQPQgticFQ0Ao104/oI6EVroanT55uRua0k+EjtGr0Moz1XU54pfTS
         aaoA==
X-Gm-Message-State: AJIora9wPHX/zFxOlpEw0+kYJdlTtlI7PCmPSp3LycfX7w6ZYvocZrie
        705M0ru42pHpmKfWHnMU7/vqTGu2A9fKWV//kkk=
X-Google-Smtp-Source: AGRyM1tSYQD1ua0CTRUtypz3YJM8n3hdcH3c6IIFHPkFLrrLRVN/+BPxkQjsmeSTaVke5NPWeFiSOZZnJAKztGQjykw=
X-Received: by 2002:a17:903:22c7:b0:16b:fa15:63d4 with SMTP id
 y7-20020a17090322c700b0016bfa1563d4mr7832109plg.2.1657131143717; Wed, 06 Jul
 2022 11:12:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:688:b0:2b8:44d7:af7d with HTTP; Wed, 6 Jul 2022
 11:12:23 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <sidimadi424@gmail.com>
Date:   Wed, 6 Jul 2022 10:12:23 -0800
Message-ID: <CAMKkZLv4y_z0FHKzrstmY9iWS6F=dqe-=gTuDKKGrJQyOX5=9w@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
