Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948CD481C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbhL3M76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhL3M76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:59:58 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A7AC061574;
        Thu, 30 Dec 2021 04:59:57 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id d201so48118299ybc.7;
        Thu, 30 Dec 2021 04:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=KBYUy4F1EkXBdZcvrhlETrInDlhxQrDb/K+4x/wDGCY=;
        b=gqngpeMpoYQ4piP+SbH4Dv7nTr4f1JG+97AEcCC6UgrmpbD5M2uAru8zIOYEYF8qjI
         9akjvzoEZtHLnIBM/E5hiV/SsSNlZ5lrgx/XI6+cd7Erc2g75qR79hHb6KmoK6BxTRgu
         pgoICgylsPk4Mum8a8HeGGEUY6Q3+/uB7n1IUsM+KuSXZStnD32lCEMIveNtM+ncg0k8
         ooNFx24cUFaXXKGXhDCLKhx3qRfbXSrA3LVtiXJ1Q0O6cgrwjO4yX+/c/b4wNtEvvNSe
         XCdQyajvMpgGmqjAdM0vlFQ5Qqgy7/4xk+cpj1/b2b6wzTRpHUZcWwrmmr7VpffZewqP
         0pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KBYUy4F1EkXBdZcvrhlETrInDlhxQrDb/K+4x/wDGCY=;
        b=aCwfbzuO0Dsim0kTCQ2+npYFCjOc25VVH9QjOEYzIo04YIPTqzYs1JaG+kHQpTwt9J
         OzG8JSoWI/aOsrobB1IOT6OITH0XlvMDJJfT5PssU6psvvqEGnB2Vhg7QKi/4nxZkheP
         YBYD459N5uJc4lad9H83lqUfsnriBE6ikPN34Z2WJ1i/K9Lwzyn625iXQDgaT0so1Stt
         O9P+BwjcZzPDfGauKhk+pVGLhLd5XvgLtAFIcTKq7U0bqvGxVZQsskFmwv9PFIS+bCm8
         D71PMBPBaZou+gbeZ8yZC62tCdNqossteicbn2RQ/oztiFA1H39xntz+Jb2z1LtDoAbG
         2XDg==
X-Gm-Message-State: AOAM532a8Q+25yRUTnJJahXcFzlaygB4arEZG6Y4qT7g2mFCOTdxAv5M
        CliYuaws8RouB5kOGsZv6x7j9tuuicrM7t8zrgyt370Lxnw=
X-Google-Smtp-Source: ABdhPJyWoAqkaXk0xy2Ox1E9ANMjqSKicrWixn0gpxNODMZZ+J1K+9N7sjPgtbk4ryyIi4Dmen+bmHea7hE+VRxxpvw=
X-Received: by 2002:a25:d44:: with SMTP id 65mr27863779ybn.510.1640869196708;
 Thu, 30 Dec 2021 04:59:56 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 30 Dec 2021 13:59:46 +0100
Message-ID: <CAKXUXMxh=QK4C5OfLL1wSvoGFJZ8U+EhSr5dy9ddExtVhAdU-Q@mail.gmail.com>
Subject: References to non-existing configs in the NILFS2 FILESYSTEM
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ryusuke Konishi-san,


The script ./scripts/checkkconfigsymbols.py identifies references to
non-existing configs in the NILFS2 FILESYSTEM:

NILFS_POSIX_ACL
Referencing files: fs/nilfs2/nilfs.h

NILFS_XATTR
Referencing files: fs/nilfs2/nilfs.h, fs/nilfs2/super.c

I assume this filesystem support is simply not yet developed to
support those two configs fully, and these code blocks are just some
first steps in that direction, but are currently just intended to be
dead code in the repository. If you do not see this support to be
added in the future, you could also just delete these ifdef blocks and
these references to non-existing configs.

This is just to share this information with you; there is no need for
further action.


Best regards,

Lukas
