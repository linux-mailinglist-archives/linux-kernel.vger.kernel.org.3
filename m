Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99986493F19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356435AbiASRdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:33:14 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:43561 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346866AbiASRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:33:13 -0500
Received: by mail-io1-f72.google.com with SMTP id a185-20020a6bcac2000000b00604c268546dso2012184iog.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=krtATGllhtAyALqcC63oUyGRYkOjOXl+s46Pa7ysR9c=;
        b=T6cGb76aqOuEjS4mZvbFrtEABrAnuL5U7rpbFN9zuI9Q7px1nibJjJsqVin6/yN+KI
         XgCJcNqkMi1/aC6k6AuUcvhM1m8h6c3bMHdsDarJLKrKIVIIeE11ijtNz/ASMsXqsbpL
         HibqzpwkweW7z73tVlnbUvsjMj0VJoUO57qkNI2iN1PkGtj2rI03RIOnXLR0qwscBP4d
         u2JjbBrzMM2ivW+wrZd4ErLqIIzV1t5jjuSWUM/sJwYe7wE1A8RZStWedaVFe+7GOW3K
         vGjcr9O+Vh7AUjOc78vB1t7jmvPdYAg0v5w5kpwJyS2fpjaTzWpJtynxSAPBlj0IHz2B
         1X/A==
X-Gm-Message-State: AOAM533a31xkmOgxMoUldwNxErz6yYIadmjCRMXAdSf0h/xC1tr2GtiI
        AOs18NL6rzNPaNpLI2z/yTu34x1X1y8MYf5sEX7n0u5fyPPX
X-Google-Smtp-Source: ABdhPJzaKzowQfVT+GHWXZ4UgeNZs4G8yUeWQIjhrpoxjIgMxBU+Sk0gF05xHP68cBU8Nk4qdQmB+F86UGe2oxxBm63RydRPrvJF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:: with SMTP id y11mr18240493ill.256.1642613592883;
 Wed, 19 Jan 2022 09:33:12 -0800 (PST)
Date:   Wed, 19 Jan 2022 09:33:12 -0800
In-Reply-To: <000000000000c5c09805d313d03e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5085105d5f2c7ab@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in tipc_crypto_start
From:   syzbot <syzbot+73a4f2b28371d5526901@syzkaller.appspotmail.com>
To:     davem@davemloft.net, fw@strlen.de, hoang.h.le@dektech.com.au,
        jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        mathew.j.martineau@linux.intel.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tipc-discussion@lists.sourceforge.net, yajun.deng@linux.dev,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f845fe5819efc4111c456c102f15db6d9ed3406e
Author: Hoang Le <hoang.h.le@dektech.com.au>
Date:   Fri Dec 17 03:00:59 2021 +0000

    Revert "tipc: use consistent GFP flags"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b09d88700000
start commit:   28a2686c185e selftests: Fix IPv6 address bind tests
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
dashboard link: https://syzkaller.appspot.com/bug?extid=73a4f2b28371d5526901
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1066ce9db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1398fc6db00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Revert "tipc: use consistent GFP flags"

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
