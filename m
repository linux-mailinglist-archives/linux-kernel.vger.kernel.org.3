Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A48486F90
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbiAGBSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344072AbiAGBSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:18:11 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650CC061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 17:18:10 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id v12so7586217uar.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 17:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=WeviqVEWYIeQD8m9pJ6XEdhs7jh18MnXCnfDTMO3bqM=;
        b=iPB2kprhJhgwBm1vWEOL4rw+NmZLbEA8Ir4WZYoWsg8jIa8GligSshFsQigIXsaxb7
         sHjocG7jXWdEg3u7hKsUz6+1pxpc5Jyl0MxK06N9QHYvhIh3AO6mZx//I2UclQQjci/O
         l9fGrLhE5jpUIQV5HY1eNI/qR62Wo1jlhYPXq+Q/2X1y/G2DerwDEjRJvztVrq3+PKeX
         VUhFVWA8adF8lBNpMP1FPdGxAQUX6pCZ7L3J/QlFu7zMv24R8qRi+3ECgfVCyLlH/lsC
         TQ631WMl6IzXw463Id8nscplgYsW5ey4iSyZEY+wuyzzNZn/H2cOtz4ne1ndQKxn+J3w
         DvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=WeviqVEWYIeQD8m9pJ6XEdhs7jh18MnXCnfDTMO3bqM=;
        b=c5i7f/IVhgX6OM81A1s8QGRwTX3dOJO5HUAso0LgWgStqHAXEY9kLE8Lbp+bJE30/K
         PKmVN5v9UmMpuf8tJ5isAko4QiSnahifBkauDGxm1BPSi853jg4u/r2oggDcuB53Cbqf
         FcT7POla9VMBLAH27XODlQi/ToS0n9MV1L7+zT1mjdZ940bi7iIp/OKXD8JOGZQAYkjP
         qIZfCdPlBpNIJN/l35cpto4tiAl6ohGms2omQ31H0k6a2PnBmfd3kiyNnfm5XG2BUUz6
         RF+wrzlOj08UiU5i/kjC00ax9dvzeOh1+RUv5PAnXV4+3pEBPGKwZPGq+YFPjqI7p+DG
         ajdw==
X-Gm-Message-State: AOAM533ShHAdEDLcZ1wEe4pbf1WV8CYWmqq8mu+UvNUlOEMs32cxBw6h
        OeIa3UOuCJt5LdFmE+BNsZ/ktlXcwTLTeds3P3ywJLkTQqH97C4CNg==
X-Google-Smtp-Source: ABdhPJwz/D1MMXZcDFmT4hskUQwGJoYL5zHa0oX0bx+g7DGsm67Y7JqvAeQHGCn6s4wKnj06EReQxxYGc1W+cB9hHhs=
X-Received: by 2002:a05:6102:c46:: with SMTP id y6mr19829685vss.53.1641518278986;
 Thu, 06 Jan 2022 17:17:58 -0800 (PST)
MIME-Version: 1.0
Reply-To: ouedibepaul@yandex.com
Sender: magadam1009@gmail.com
Received: by 2002:ab0:69d6:0:0:0:0:0 with HTTP; Thu, 6 Jan 2022 17:17:57 -0800 (PST)
From:   Ouedibe Paul <ouedibepaul@gmail.com>
Date:   Fri, 7 Jan 2022 01:17:57 +0000
X-Google-Sender-Auth: 3SRPRWNu6kaEb2mD3UDrd-2v0QY
Message-ID: <CAOdfs1eoFUtqZHvrOiX6oYKp6L2pU27Ltv7SbrKcAjgD8nCMOg@mail.gmail.com>
Subject: Greetings to you....!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to you!

I am Mr.Ouedibe Paul, the Audit and Account Manager (A.D.B)Bank in
Ouagadougou Burkina Faso, West Africa

I have a business transaction for you, In my department i discovered
an abandoned Sum of US$10,2 Million Dollars,
In an account that belongs to one of our late foreign customer who
died in plane crash with his family member years ago.
ever Since he died, Nobody to claim the left over balance in the account.
It is therefore upon this discovery that I decided to seek your
assistance to transfer the funds to your bank account.

if you accept i would give you the guide lines of how we can achieve
this transfer of the balance $10,2 Million Dollars to your account.
the fund will be share 50-50%. by both of us

Send the information required below for more details,

1. Full Names:
2. Address:
3. Your Age:
4. Your Country:
5. Your Private Phone Number:

Best Regards,
Mr.Ouedibe Paul.
